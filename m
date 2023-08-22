Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88109784A68
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjHVT1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjHVT1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:27:47 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768B6CD2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:27:45 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-48d0db157efso975083e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692732464; x=1693337264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9q0xN3X00iLqb1H5SZd62TXDvTVYDSQIDRCSUAWcvw=;
        b=M/xV0JkKPKlzPZyIR/4qrqcdHmwhxUpuw7JxDcSv2Vt8rY7bFdAriR8OkGldMSe6k4
         k4zivhISLr0VOC4HKLuW9xLKt1Xae07nZRqtIFq1YsAaLm1cJkmgSdoIfAWLAxL2nQ/p
         xv6BEI89pMPag96gWjjLXVm0nxDo2zwaaUEszcqFrsTEYd4Qppn5pXPQ+goKdJ5Vs7YG
         BZwGSQPzLcpGkARUZNODUgJ/qa1QP8q8p3gUlYRCGX8hHi5ZOO1Yda2VFEUIZl+UO+8Y
         6cQNAr7oQpx2DFnKuwxsjY/w8HRiDzDEBipT273gvI9YnlqG4lDb2Inm5sRmCvuQg8Wc
         73ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692732464; x=1693337264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9q0xN3X00iLqb1H5SZd62TXDvTVYDSQIDRCSUAWcvw=;
        b=QL6JjSLIr8TR7v1c3RpQG3M3nbqvFneVy2wtYR1PSxsX+8/Jy1fug9kb7zV3trSmjo
         W122jkFaE9KePwfHM6fqY//oqmXykVMFvTR5nyzzaMIddzCCFthwdeJqoMITZ+11ZU1D
         2qJPZ6qB4Sq9CwaGDlqOwbLeqlg1m8bTHDvbzrR/KtqjdOB7W7CoGGOn+P32cRZse5cO
         UCjZpTel25D7zmRF6RWXOPywwjabiXHPV8X2e1S1Ewb/ZW3ExIJf8bo5cFCePFuI2gza
         MMBVZeYT931tXxEJh/xicpimIp68dThG6t6N5jIIINN5t2Umw3bytqIEeLibIsNOss36
         c7zg==
X-Gm-Message-State: AOJu0YxObbPYpxpn9vWX/mNw4JVXkrkRECeoj60BkqPP8l+IyiFwoj4e
        WO2eU9DhYWOAE6J1v+6AfEPaAA9ogJhGxkYZZYaT7g==
X-Google-Smtp-Source: AGHT+IGwEk2HY+QVQQCc5miZkTWPqZ7hDkvFLLbiwtTyS+Mz06H0p+lNmLVMO35EZ2Kl8RDxbsEdPn/Ssd+19ofYXd0=
X-Received: by 2002:a1f:4c81:0:b0:487:e8f1:a2bf with SMTP id
 z123-20020a1f4c81000000b00487e8f1a2bfmr8338893vka.15.1692732464560; Tue, 22
 Aug 2023 12:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230822152244.214394-1-brgl@bgdev.pl> <ZOTUHzKKBNcjQLRi@smile.fi.intel.com>
 <CAMRc=MdWbQPuNh=ziyqD_xVaXDD3nE5yNeq1+d4F_P4_3H=xxQ@mail.gmail.com> <ZOTZHn1BzO6oZYOH@smile.fi.intel.com>
In-Reply-To: <ZOTZHn1BzO6oZYOH@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 22 Aug 2023 21:27:33 +0200
Message-ID: <CAMRc=Mcknnzc5wPRZfZMm1W5v=x5juL4dNEooYZgTJmv2=bsqA@mail.gmail.com>
Subject: Re: [PATCH] HID: cp2112: make the irqchip immutable
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 5:50=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Aug 22, 2023 at 05:38:45PM +0200, Bartosz Golaszewski wrote:
> > On Tue, Aug 22, 2023 at 5:28=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Aug 22, 2023 at 05:22:44PM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > This make the GPIO irqchip exposed by the CP2112 driver use an immu=
table
> > > > irq_chip struct thus addressing the following warning on probe:
> > > >
> > > >   (cp2112_gpio): not an immutable chip, please consider fixing it!
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=
=3Dfor-next&id=3D3e2977c425ad2789ca18084fff913cceacae75a2
> > >
> > > Can you test HID for-next for this hardware?
> >
> > Ah you beat me to it. I didn't see this one.
>
> Now looking at it, I don't understand why I added a call to IRQ shutdown
> callback... (Looks like it slipped from experimental patch.) If you can
> test this, would be nice.
>

Yeah it works alright.

It's already in next but FWIW:

Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
