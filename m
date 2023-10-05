Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A057BA6CB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjJEQlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjJEQkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:40:10 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E010649CD;
        Thu,  5 Oct 2023 09:34:39 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59e77e4f707so14484877b3.0;
        Thu, 05 Oct 2023 09:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696523679; x=1697128479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4tg2+xr3KT0aenM1QifjTQYunwzMhJdxnzpDyHvDvY=;
        b=VwgZclZePaBjFLx17eHAJFP9DrNZSIjO9bhoWfGVk3pf+MZxqa7vkkGTKPxSyvLf99
         K3P1XydTEcQSo6VJgTlhE0tPt09G0f9kDPzb+DGPn4B4ZbIw5a3WLAq+DzihrM3hTHUd
         bw+NABq5uqKWwCVdMAFGyvDrVCyago2I/zbewUWtMoGqzIM70CmtdsfXrhFJVS0bSoqL
         pAuYB+1vJ4Nqha5iNmVBa8S4yURnvOGmG8ZvyWAif6edxJrau55lxafGILc46QU2c4/i
         0/TI0QYx90nY7eKh1lTdeY5o4IKI3Uz5+q3HLf9Q6xby4H37LxxvoRo+wv0Ii4MgjdRG
         CP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696523679; x=1697128479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4tg2+xr3KT0aenM1QifjTQYunwzMhJdxnzpDyHvDvY=;
        b=rK+1bNiUsAEF3a+AvIcxd2VN+170xAjJTzzmZ4u5FvBfauU8rRK/zC61i+4m+gtv4F
         q5smwD1V20asxydvRiEmlElW97Iui0cdRyfRHah/hY5hk1RO9aJpVOWAFDxZwxa8feqI
         6iHyap6OutWDB45mUhPM0jMPfdzmqOxEZ0JFsK+BymZ+tlofdXtzh1qahVKdm1Kl1g6z
         fyS+fVzPonersYvGeYvF8IITD58WxAwxOfLfbGV0fIdJdaADpfP+z4Mi43KHBU0Ov+X9
         9Whp74zSeSQI3wxjeLOEzgUr38Xu8M0uSpT2fy3Om2OVIOe7PFOa7zHEEKD9tt0wOP6j
         EtqQ==
X-Gm-Message-State: AOJu0YzxO9XiiWoU9Q6DR8ndNcjlh+9uXDa0PCgt0K/kB+pHgfAjONL6
        T6zjIuRMN35ok9WEcnA09Xmn8R9ANiIYCyiPdBKzoGCeojtTaw==
X-Google-Smtp-Source: AGHT+IG6sIDN8XjXV0ktEGS3SwOUGAHbPaZGfd2h32fXN/0ytiWPzajC0yZ3LzJH6hHWVUzM1wVe/KyNqzRHSkZdev8=
X-Received: by 2002:a81:6289:0:b0:59b:eb8:c38a with SMTP id
 w131-20020a816289000000b0059b0eb8c38amr6679782ywb.30.1696523678763; Thu, 05
 Oct 2023 09:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230923024707.47610-1-gary@garyguo.net>
In-Reply-To: <20230923024707.47610-1-gary@garyguo.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 5 Oct 2023 18:34:27 +0200
Message-ID: <CANiq72=NQ3-cnc7cnUiF4u_dX7q2kWKe5edeZdFBtRTwmUNP-w@mail.gmail.com>
Subject: Re: [PATCH] rust: remove ignores for `clippy::new_ret_no_self`
To:     Gary Guo <gary@garyguo.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Ben Gooding <ben.gooding.dev@gmail.com>,
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

On Sat, Sep 23, 2023 at 4:47=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> The clippy false positive triggering `new_ret_no_self` lint when using
> `pin_init!` macro is fixed in 1.67, so remove all `#[allow]`s ignoring
> the lint.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Applied to `rust-next` with a bit of rewording to add those two links
I mentioned -- thanks everyone!

Cheers,
Miguel
