Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5046B7FE202
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjK2VdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbjK2VdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:33:07 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F09795
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:33:13 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-db527023652so168612276.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701293592; x=1701898392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aK2DmvA9NMVkTXP2kh85VxvDVeGmy7YS6BB1IBzmvwM=;
        b=Ey0wuWbtfnecr0DMc6iE68MSP6ISmBMfzWOMgDHNvy4+qLbuqDkijuBtDwHHpIbcHz
         GwSDvxfdCJd+LQ81l4CqtjaVytc4fnsfmuL21M/O3wFW3lDgOtjHxroLZyzgTFfNkAJj
         XT9A05aLJWSZqlzsZ/cSBCAZ0hKP9MfBG/BwYASGRl0ma32Jtq5iFK985lpsHMP6ZpNJ
         TqGoQjdd2ov4Zjad0FkfbqtlA9jz1gaGja06InIudHDyMHyi4nOa8GoIbmReuQ0rVgOK
         kKL1mFq9WO96Bo3vgfLiZXB6RFwCg7uwEwLlBNvJTtRB4Zsnj0Seq4Fh9PPfmylRwTqX
         YqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701293592; x=1701898392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aK2DmvA9NMVkTXP2kh85VxvDVeGmy7YS6BB1IBzmvwM=;
        b=WHjwIZMuDzfBlQr2JxLT09gB+uMSy6PEsIQBZiR4m80CykDFWDcVb14R7rkgdTMPoR
         G++5Tp84J06g/cTB8teEWtTs6xp7Cqjd1GzQI5fTQu3SXU+ekEyVVl884hhIjuVyd8ZT
         4av/7sknGaG0+t4bLtX9WMB0Py3K1F2HnSJjRoECQV/J+QArbGxMfTXQaY2VUYiSw29y
         Eel590Fpq0tiUYwL/lftRdMClQCJKLHwGRoSW+9CL+ohjjkf303VHAsAS8Juy+drLSmK
         Y6bOqZ2DJNMBoGiZY3LzN/qIW7qLembz1qTvDprvHWe06Mffytc6i57KxM2eB1mJNORA
         VKRg==
X-Gm-Message-State: AOJu0YyVCV5E1m32TSqpXPrWGw7HTd/vnMrIMN8iauHNWccsvA2IiPPJ
        u2xWK+m1MWvbb/qLDoJ/lJeNqzzbCCVoxEmtu9QD7g==
X-Google-Smtp-Source: AGHT+IHzZgXIjLn7ou1rCTJlZgnnvre2KumvBXnqdcF+AjoOkHS0lLVqyN/49Y80EhMpvKrojWib+edhg0wtHE1OaYI=
X-Received: by 2002:a25:4b42:0:b0:da0:3bfc:b915 with SMTP id
 y63-20020a254b42000000b00da03bfcb915mr19790887yba.11.1701293592433; Wed, 29
 Nov 2023 13:33:12 -0800 (PST)
MIME-Version: 1.0
References: <a03a6e1d-e99c-40a3-bdac-0075b5339beb@gmail.com>
 <CACRpkdahWm9aP+UasDx=s3th+vyjAfuWrKB5HS9BKEbz90ZmKw@mail.gmail.com> <ec17c6c8-e697-4a5a-a705-bff24daae7b2@gmail.com>
In-Reply-To: <ec17c6c8-e697-4a5a-a705-bff24daae7b2@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Nov 2023 22:33:00 +0100
Message-ID: <CACRpkdZp=4sP_1a=u6c7DGbPWA8WRee4J8Wpsw7Y57S2FT5GFw@mail.gmail.com>
Subject: Re: ARM BCM53573 SoC hangs/lockups caused by locks/clock/random changes
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        openwrt-devel@lists.openwrt.org,
        bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 10:20=E2=80=AFPM Rafa=C5=82 Mi=C5=82ecki <zajec5@gm=
ail.com> wrote:

> Here comes more interesting experiment though. Putting there:
>
> if (!(foo++ % 10000)) {
>         pr_info("[%s] arm_pm_idle:%ps\n", __func__, arm_pm_idle);
> }
>
> doesn't seem to help.
>
>
> Putting following however seems to make kernel/device stable:
>
> if (!(foo++ % 100)) {
>         pr_info("[%s] arm_pm_idle:%ps\n", __func__, arm_pm_idle);
> }

That's just too weird.

> I think I'm just going to assume those chipsets are simply hw broken.

If disabling CPU idle on these altogether stabilize them, then maybe that
is what we need to do?

Yours,
Linus Walleij
