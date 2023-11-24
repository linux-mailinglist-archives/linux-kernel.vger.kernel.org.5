Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D657F70B2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjKXKBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjKXKBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:01:32 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A56D4E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:01:39 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5cd0af4a7d3so17395117b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700820098; x=1701424898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPKtCopZtjo9sHDnS+A4ZAdadrH7hVpFlfcBUcushSo=;
        b=a38AHAE97Fwtnv0Fqx41LZtSKbLI9zuCQzz9ykxgwlPrNEm4gU58X3WSBlrvrhyEn6
         wSYwBadjYJ0ZSnDKufVBBBDW5AFLyfgaS0Gyjlm219H9QuBXHVY9euQLMYvose9B4lTp
         632gLYvvF5bgC6kuQQDH9h7pOT6rcBIkjv/1sLErrys0bpCxsNihMIRb+PFAfeWZbCTb
         B4XLi7FqXOf0YcWOyL5N842l70pJnBC/914kQplBSjBTmJpjR2biWtLJKek18eWmE4mT
         RLF85vm/HvU2m/H88WyQAi4fHVHQW3K0A8LREk9q1k4Iqw8QN1kRcjXvBQ1EfKVg995W
         58Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700820098; x=1701424898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPKtCopZtjo9sHDnS+A4ZAdadrH7hVpFlfcBUcushSo=;
        b=oak8AOBIK/9gXJSX2D52jnQvEVroX/sMbgg0GDs7b4nASXkwFp7u5IxCeRfg92AsBb
         xKFZXHn6CyICQJ/DV+IW1q68o80sRRqgqREZ8aaB6uaZxDZ3N8HD0IWov3LnZIWSEwde
         A+sQWZHe8zemSQFqgJFDZc2K+hi8ajBlFIQ6pudH1pmhrs8W3e9mjB0rVsudNUaZTkWa
         ZhSFUWb43G8zNRh51tJuveHn5E1L7+48qgAcjbaArjhJ59AuL4JECqaqArT1dFnlL0Kq
         nHWdMoQPMh+erlIZ+WX5YGKekbFf8U+zHOZefW7tuXV7lgZnOV6uHqjIdmbdv/uqTuMm
         Yluw==
X-Gm-Message-State: AOJu0YzjyOclzZohlhF4T6/o0FuNwB/zhun7/BKPkSc0RZylSyxdZRnU
        w85ooOcunrr10CpUHg7WIXr+r+88sp8FRmHRD6ZJng==
X-Google-Smtp-Source: AGHT+IEQyC4nSPcfo0BaJZ+VCOLswCLlYEsACBXAJN4r77FPCG2ucCTKzF44LOPdRFVatrdcBlDU5Fd67usGJvhsVvk=
X-Received: by 2002:a0d:e653:0:b0:5ca:67e8:4fab with SMTP id
 p80-20020a0de653000000b005ca67e84fabmr2008948ywe.8.1700820098221; Fri, 24 Nov
 2023 02:01:38 -0800 (PST)
MIME-Version: 1.0
References: <20231115165001.2932350-1-brgl@bgdev.pl> <CACRpkdbDny8X3WB_qJ4h_vbwrjno5ytAtNMgTeXg4jpegdUH2w@mail.gmail.com>
 <CAMRc=McZJzdj04Ckf_ygDhWNN2JcbTfY+yefOZSYx_nTE_Jpjg@mail.gmail.com>
In-Reply-To: <CAMRc=McZJzdj04Ckf_ygDhWNN2JcbTfY+yefOZSYx_nTE_Jpjg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 Nov 2023 11:01:27 +0100
Message-ID: <CACRpkdb7QwWcq=mDa4y8bh_QLAFU+X9LCr0chrGVL-_9YE5P9A@mail.gmail.com>
Subject: Re: [PATCH 0/3] pinctrl: don't use gpiod_to_chip()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 4:06=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
> On Thu, Nov 16, 2023 at 2:43=E2=80=AFPM Linus Walleij <linus.walleij@lina=
ro.org> wrote:
> > On Wed, Nov 15, 2023 at 5:50=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
> >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Let's start working towards removing gpiod_to_chip() from the kernel.
> > > Start with pinctrl. The first patch should go through the GPIO tree
> > > and become available through an immutable tag so that we can get more
> > > conversions in this cycle elsewhere.
> >
> > Fair enough, maybe an immutable branch with all three patches?
> > Probably best to merga all three into both subsystems I think.
> >
>
> Nah, I don't think I need to pollute the GPIO tree with every pinctrl
> patch. It's enough to just merge the first one into GPIO and you do
> the same in pinctrl.

Fair enough, but I need that immutable branch for patch 1 so I
can merge the rest on top.

Yours,
Linus Walleij
