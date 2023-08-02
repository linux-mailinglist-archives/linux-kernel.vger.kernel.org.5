Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B9476D5C9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjHBRoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjHBRoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:44:09 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1241995;
        Wed,  2 Aug 2023 10:43:56 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-38c35975545so10733b6e.1;
        Wed, 02 Aug 2023 10:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690998235; x=1691603035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXB2C54kcCfzkMo5JP5j3YSpszMKwDqJaaMSO/QcrL8=;
        b=IkMh5HwpFEzlJEPMxlafehZs3yQEl4qygzUdFDpARfNXq7W2uJpLqTZGAvpZDLXXb0
         h70rP4EFo28Is+KGxsqtfoRW4PA1JGf+twyzC/mSh+30gFZcLestCUgYhX8Gz1j09ZJL
         /DOKZa2nN5Ux6CUAr5nWk7eXWcr2VhfbLyyB7sdQwIFybPQuV+qNfYPysYVzD08YVlrT
         zJ2X93P28OupyHllVvfO6CcI0qjJMGQFUXI/j1dydDR8IECeUB31dqaSLFbyZPTf02B/
         niMKsN6q/HfkLw3FFUFTNRDHzLQZGpimVDxg7ecgbGkF/6h+M0iF0fsVpjlxfyiVfJI3
         U8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690998235; x=1691603035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXB2C54kcCfzkMo5JP5j3YSpszMKwDqJaaMSO/QcrL8=;
        b=bUfZdtPFRWmXv2764CpGQMRzdSw26Be1BezTYu6/z++DEIHtm11OjWiz2Zj6dwgdRr
         /I/onZz6yFR6+uI67Mm0VOf32qkR3WkHNs5TQAKu7u0HNuGzbFz0O/kQfLwkt2CpZ6HK
         Gop5qkRTmuRSKsyC0xPAKYNGUBwIqb3l50Hm1bClD4uZgYpuDZmWkVTS5Jurcb+vE/RM
         gEwBvOujtB1i+PBqYAQ523Vxz6FitOstHWKhIABoIm6hBGvKrcbmTzqp0J3LycOUU8dy
         jU5mf6S1E+7DZ/ODJard11ztZiwslNW+Xf44hFhcJ9SRXFLU5IJRqQQxC1XGJoIoDcL5
         FflA==
X-Gm-Message-State: ABy/qLYiLf/Cu/lLlFg/g0nea8O+CkgOm2rRoyLbwGXCE8UFuSXh7jeS
        4gC1OGaxQM2B7+tcyq1V3LeDGs5TSusZ5g38jsY=
X-Google-Smtp-Source: APBJJlG/C6AtNY1RUhf5suE8NtlQHVkiEjRIDlQw45ffwIqZ3Hq3h65lna0Oj6h8bDiJ7xBnViOQiBzh45N46rHEIFM=
X-Received: by 2002:a05:6808:55:b0:3a7:5d6e:dcf8 with SMTP id
 v21-20020a056808005500b003a75d6edcf8mr1851806oic.39.1690998235506; Wed, 02
 Aug 2023 10:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230626074242.3945398-1-changxian.cqs@antgroup.com>
 <20230626074242.3945398-2-changxian.cqs@antgroup.com> <CANiq72muJwPHuJF++BYptO4_WVA=mU68nn=GWgqYo7pMdxC=pA@mail.gmail.com>
In-Reply-To: <CANiq72muJwPHuJF++BYptO4_WVA=mU68nn=GWgqYo7pMdxC=pA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 2 Aug 2023 19:43:44 +0200
Message-ID: <CANiq72mdHzmqT2zisEEJCxFWJ5F4DOkKWD6zJMXJMFC=C6u7zw@mail.gmail.com>
Subject: Re: [PATCH 1/1] rust: macros: fix redefine const_name in `vtable`
To:     Qingsong Chen <changxian.cqs@antgroup.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?B?55Sw5rSq5Lqu?= <tate.thl@antgroup.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
        rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 7:39=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Applied to `rust-fixes`, thanks! I have reworded it with content from
> the cover letter to make it more clear. Please double-check if it is
> OK.

I also added a `Fixes` tag, by the way.

Cheers,
Miguel
