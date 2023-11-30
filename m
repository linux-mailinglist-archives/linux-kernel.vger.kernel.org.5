Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B49E7FF876
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346351AbjK3RjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjK3RjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:39:11 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9A710D9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:39:16 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7c44b09f9f9so673090241.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701365956; x=1701970756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNguKtwIvnyO2Gj9lJbmb0T+V4gmh2R9drIGOrDbnbI=;
        b=L5/BopSsLhX7lwIzm1g8i14mn3tSN6qeGnNVAVX8VV6dzxAwJ6M0gqWDDBZIj0w+l9
         cLWUaAYUqF/Yi33yahVsLvvvRPpdERVSOrMotkPOWb6znmoUEMWHbY+IzdfekDiH4MJh
         TXdpGdwDXyJoBkw2ytexZcqHbsKCC4DCxhyPdL84lZ4GaKB5ZR12GfgFTGK2WKZCfemv
         s+aOPor5BZpxlYHbbnwtWqLsO5seARIAXpZ94axgqch2bOzdQ36RVfOk7Kz2pwdVUJpt
         PJfKdOtlGE1XZcsRbrGcNzV5EhgWOf905mNMiqyocuDwgqylv0LaODY2Qz1qr6AkoL/8
         Tohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701365956; x=1701970756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNguKtwIvnyO2Gj9lJbmb0T+V4gmh2R9drIGOrDbnbI=;
        b=r8amZCk1HXO15CuTqfVYyAf8eKcQPNAJDGxVWLanmzNkuTavUsDPpMLOWceH+VANki
         x/MXi7gN1TWp4axDEm9jWDyCGYXAPSMHKcPtjil9xw250KGfPQ7DZGo91RYl5iXCozr7
         k5Qkq2tYnDVI6z1yW+wLU/gzNMq/DErjwcYTjIjI6SPxSiTZJAhaNA4yKvgRAd19zZbP
         wCnBPHD5QCA7RAQgmNmfHotfpfvxcaI3KVVi/aOQyt7iX1BTkKFKkkboipy030slD1Oi
         bCybzie68iFEO8VrkTHJD8/s0b8qLMJEfCJEOiE1KIGxqLE50/2YVryew8nPUG9YU4ie
         c0cw==
X-Gm-Message-State: AOJu0Yw/Zzq871d/R76JRkor7d62exoqRJZfQZAPT+a9DQP/i68LxXFh
        nqAsly+dvJDUIrl/13J8e+kLsq67kmUWPROEIRkrCg==
X-Google-Smtp-Source: AGHT+IHlEzVbLFXtUVKvNXK5OPlaLnHH9WMmD+cMOElsPuiPjPJbokxrcbzXeAaCqBx4JFdaaGRtna1fzpG7H//KYvA=
X-Received: by 2002:a05:6102:1627:b0:462:7e73:c11f with SMTP id
 cu39-20020a056102162700b004627e73c11fmr27567494vsb.6.1701365955833; Thu, 30
 Nov 2023 09:39:15 -0800 (PST)
MIME-Version: 1.0
References: <20231130134630.18198-1-brgl@bgdev.pl> <20231130134630.18198-8-brgl@bgdev.pl>
 <ZWi5_VHlUSmgpLiB@smile.fi.intel.com>
In-Reply-To: <ZWi5_VHlUSmgpLiB@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 30 Nov 2023 18:39:04 +0100
Message-ID: <CAMRc=Mfuuri-67KBNWXeHApd-qHYQ0wJeU-6A5eb=B9NeQT8hg@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] pinctrl: baytrail: use gpiochip_dup_line_label()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 5:36=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Nov 30, 2023 at 02:46:27PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Use the new gpiochip_dup_line_label() helper to safely retrieve the
> > descriptor label.
>
> ...
>
> >               seq_printf(s,
> >                          " gpio-%-3d (%-20.20s) %s %s %s pad-%-3d offse=
t:0x%03x mux:%d %s%s%s",
> >                          pin,
> > -                        label,
> > +                        label ?: "Unrequested",
>
> This already fourth (?) duplication among drivers.
> Perhaps you want a helper:
> gpiochip_dup_line_label_fallback() // naming is up to you
> which will return the same for everybody and we don't need to hunt for
> the different meaning of "Unrequested".
>

IMO the overhead here is very small in return for better readability
(IOW: `label ?: "Unrequested"` is more readable than some function
named `gpiochip_dup_line_label_fallback()`). Given the string is in
.rodata anyway, I wouldn't be surprised if adding a helper resulted in
bigger code.

> Also the word "Unrequested" is a bit doubtful as it can be a label, right=
?
> Something with special characters / spaces / etc would suit better?
> In any case it might require to add a warning (?) to the GPIO lib core
> when label gets assigned if it clashes with the "reserved" word.
>

Agreed but this is a functional change in debugfs output. I know
debugfs is not considered stable but I didn't write it, I don't know
who's using it and I prefer to leave it be.

Bart

> >                          val & BYT_INPUT_EN ? "  " : "in",
> >                          val & BYT_OUTPUT_EN ? "   " : "out",
> >                          str_hi_lo(val & BYT_LEVEL),
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
