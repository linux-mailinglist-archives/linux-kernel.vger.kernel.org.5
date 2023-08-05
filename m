Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0A07712E6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 00:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjHEWoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 18:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHEWow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 18:44:52 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F542128;
        Sat,  5 Aug 2023 15:44:51 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40fee14093dso17033601cf.1;
        Sat, 05 Aug 2023 15:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691275490; x=1691880290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UkhP9GBkLs5jbzdYUWU0vcmVISF8c2SiX6lEIeJeNw=;
        b=LnXCpXklo+jHY1vnaFgU/J8XRYU8U/0SXhiyAUguawbPw4OHXgnlvzmp4b/0nbByxq
         KuQg7CEwMBqLxnD9C/TpDhdLV/RRBpZpxvF08XV4wUyEKtjKD7OcTMCONRlOPG5/Tt79
         /F5J88zijJlhrXSgsnSFjZfK94Gbh64i6OzkK1piDAfFe515QxngyfMn44FtdydSWp82
         SeaBVleTFY/6J04b0/L3R/xR84LJRIKr1OO4ghdRRvmga5CjJqE5or+a/7BJgF5+6DBy
         /+8Gb6560KRcyx8Cgvn6bU078rWvOZGJo2PSW4N+jDZmLpBWewW79ZJPq9CgEdYTcqpr
         x2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691275490; x=1691880290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UkhP9GBkLs5jbzdYUWU0vcmVISF8c2SiX6lEIeJeNw=;
        b=D4gdsKylD79Wdy5ce+g7koOq4WAOozfbP01f3fEawmx85llrlV6UOJcCUZR7eJ2I50
         awDB9SOIZkSfSbRSc6QUPEC0I9E+jBKSVrWxoYQ4AAI3/zax3ATInt+enqthjznLfwth
         x7XCjhPlXmfiIWbaFudmaxhpVeYQLVrDE/ycVSeBqMNsC3u9PXphwHUn9qgBpbR8GBby
         58V4t6mf+PR1QDvwly2OVyROG9ReXfJaexX2vEj1ytpNeb6aRgUqktfKOhdImJ3IIJeP
         d+7RAgsvBTRTloHqua3hb9oEnQirbx3JdqSNIE6K0tfGjKMSYquSjYr52aSDwd4w5aPJ
         BAXA==
X-Gm-Message-State: AOJu0YxPBGRUiX+vbPntx3vdPqtTzK/OnY2m0iFMkJ8Wvxub1sRblUki
        vIFEdUZplA6Ml8fXMriWK0FGxolBdpji4POupTg=
X-Google-Smtp-Source: AGHT+IFY9fJMWGrI3cCstWnoq1yFck1hRFTZVTg/gL48UzBii5wiFSCuHiI2DYmEh/4belLJLfjMO7dLp7a0Y7hRTQk=
X-Received: by 2002:a05:622a:1b86:b0:403:c51e:f038 with SMTP id
 bp6-20020a05622a1b8600b00403c51ef038mr5546007qtb.17.1691275490448; Sat, 05
 Aug 2023 15:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230804171448.54976-1-yakoyoku@gmail.com> <CANiq72mkmTRzuYSGveP2xxPbDJELHXoVWVbKF2eyK0DhJ+y7bw@mail.gmail.com>
 <32944cb3-5c0c-4ca0-97a9-841114c9adc9@gmail.com>
In-Reply-To: <32944cb3-5c0c-4ca0-97a9-841114c9adc9@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 6 Aug 2023 00:44:39 +0200
Message-ID: <CANiq72kYTLUMPa8_A03A8G6GzF7mXb4pL0sncadv+hcb9_BYWA@mail.gmail.com>
Subject: Re: [PATCH v3] scripts: generate_rust_analyzer: provide `cfg`s for
 `core` and `alloc`
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 5, 2023 at 3:00=E2=80=AFPM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> Ah, it was because you suggested the commit's text, should have been
> more clear about it, I thought that the "Suggested-by" was for any
> suggestions in reviews, and in reality it was for suggestions for
> the kernel itself. In this case I've got confused. So, because I saw

If it was for the commit message suggestion from v2, then it should
not be there. In most cases you would credit those in the changelog
(in the cover letter or after the `---` line).

I will remove it when I apply it then, thanks!

Cheers,
Miguel
