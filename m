Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B85A800527
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377790AbjLAIEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377784AbjLAIEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:04:36 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CADE10F8;
        Fri,  1 Dec 2023 00:04:42 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c9b88cf626so24355261fa.3;
        Fri, 01 Dec 2023 00:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701417880; x=1702022680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qTjlCC+GslsWJzNLyZ4ti8FIX5Ayf6BUta7nxCdgfSg=;
        b=DwzPIypo/sFgCsngfWwO/Vd8QifwTn6cGoj2XZodMqmLgwhprTNpEeIjnpJP8dTf5E
         cQIzLpq9NKZNnMvpvLiQRFE5V3m2r0b8SbCI752uWWXBQ5oQtbv1LofvJzRywdb73Qlx
         /hdTbStMtaCRZynT44Lhe4vspNwrY4QEtW4ai5avhWkUlX28jWLGHLfAKGi4bEf4WReI
         dHSb8tZtn4WOsBVR/Ka2OOHxwBw8CAm31eoPQW5KuXAJoAUsbECIThC98jUv9XjUp8d8
         khQ8mrkKzTK+ixxhVkrcdWKLQx/fGIajUZEQ+1y0YbOi4uBBerFCBD/xz4YIYJuGWVUl
         mHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701417880; x=1702022680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qTjlCC+GslsWJzNLyZ4ti8FIX5Ayf6BUta7nxCdgfSg=;
        b=jKCaW1P02LEnZ8l0iLA8/PHIxegVKmoClpa0Diq6onj5xm63HcxTFZcfHKTun9ZjU1
         IJEW7mhuXa7ZgZ6oNy3fYI2wQxl0v8P6cYlBpSWI/UWLRxW1sOixj94vCz/ScIgPBe2j
         YnLiLzVAhsTc8IdUCZUSGyqlGUfTJdVz9KPASk1j9WtuUb0aVM3Iyuv3oseunTPm8nMW
         efCDudNptaHa6McgsIJAF5CiBXxoy+dKAamYjCTUiRuUnnIBq0nE+mLxA0C5ROCSihxQ
         90cgmWFLa6WwUZ+zBpc70DXIaODkQFCItkbzKFJeZbO3Y2PafVOD1zOEryOBTwrmn5T1
         UrWg==
X-Gm-Message-State: AOJu0YyVVOXI9h00Vm33mVtG49w+75bT2n/mpuOQ7Dzlynej5eRgzrzj
        pJHKG8+2DjCA5bwLphIO8j+BH1ONBz3Tc9pcFlg=
X-Google-Smtp-Source: AGHT+IFEuuxko1Q2PpI2q5cy8/izJael5ks2bFo9rN1ePwh31sc7O83FYc/61iNEILFM6s+xu0ERR56KQAymMM0pPL4=
X-Received: by 2002:a2e:80da:0:b0:2c9:d872:e795 with SMTP id
 r26-20020a2e80da000000b002c9d872e795mr434172ljg.76.1701417879899; Fri, 01 Dec
 2023 00:04:39 -0800 (PST)
MIME-Version: 1.0
References: <20231117-maintainers-v1-1-85f2a7422ed9@google.com> <170113164796.1670732.18133777682518787773.b4-ty@chromium.org>
In-Reply-To: <170113164796.1670732.18133777682518787773.b4-ty@chromium.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 1 Dec 2023 09:04:03 +0100
Message-ID: <CA+icZUUOFVOe7Z4q4F6nasQ--8v9wvZs9vZtLpR-p3o4UZ0HPQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: refresh LLVM support
To:     Kees Cook <keescook@chromium.org>
Cc:     ndesaulniers@google.com, Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Nov 28, 2023 at 1:34=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Fri, 17 Nov 2023 11:24:02 -0800, ndesaulniers@google.com wrote:
> > As discussed at the ClangBuiltLinux '23 meetup (co-located with Linux P=
lumbers
> > Conf '23), I'll be taking a step back from kernel work to focus on my g=
rowing
> > family and helping Google figure out its libc story. So I think it's ti=
me to
> > formally hand over the reigns to my co-maintainer Nathan.
> >
> > As such, remove myself from reviewer for:
> > - CLANG CONTROL FLOW INTEGRITY SUPPORT
> > - COMPILER ATTRIBUTES
> > - KERNEL BUILD
> >
> > [...]
>
> Applied to for-linus/hardening, thanks!
>
> [1/1] MAINTAINERS: refresh LLVM support
>       https://git.kernel.org/kees/c/9099184dec26
>
> Take care,
>

Jetzt amtlich (Now official):

https://git.kernel.org/linus/994d5c58e50e91bb02c7be4a91d5186292a895c8

-sed@-
