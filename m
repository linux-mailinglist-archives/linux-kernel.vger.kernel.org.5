Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1977755EA0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjGQIie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjGQIib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:38:31 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4D2F4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:38:29 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso41611075e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689583108; x=1692175108;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z4o4TF/LxZly0vmrx76BwSM2BKqw0I4+/QaBjz9uTXs=;
        b=JaV92xVDUvovCm+5AOf7VXTT70biF1yo1d8ZNHDTZ7c8s8DJ7s8HFrJ51Pe9GuXZHs
         2+7R9LUaxFYqKXfjRy9R8w5Zzll+hJLQWKthxlNKNLLHExtWxu/kdoibRd4eNf/Dz9+m
         86KU/z0VcVrBZfGG8oKSLJ5gTp2hr6Q6fyHGxbQ9WYTzZZimI6hZsdKWkZ5A0T9RjqWb
         WBi0II2wYy1IYlg2w+X8qvt5GBKIASiTQVWK3KrrzU5d3KKyKDqBJAUomig/PhPUMH8R
         TZ8AJ6fE6eOxd/kPHP85EbY/JbZ/Zn7/RNOdMcEEdvAKFq3TwfVpdREMsxfzZEUIfLXF
         42dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689583108; x=1692175108;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z4o4TF/LxZly0vmrx76BwSM2BKqw0I4+/QaBjz9uTXs=;
        b=PXAmKZilrZAJ9Tp6RsT5i0HRFGA+zafyf7FRMFCrl2O9CQj29Rk4ZH9agWw2PSnjB8
         mhw7Zv3jhnz7YlVjgW7i572HTeLFXEHcrtkbsSVo1K/DiCux7W2PZT5umLXPI1Y6Nj5L
         G6oAAx/o604QN99SL5dQbQ8QxrmNxAXqoqLbFGJOgpSawHZGIZn+z0bgn7+zYJQpYXSp
         UeJHRrkDqppzWGm7jjd0d3zZMKrUi35BtsZnrQ0DLS1GteEah0gMchhpN5zunXx8Jc51
         oy15KcS25qILrB87Y2/ACf/i+qoYpfI0+Q+mIOjY7Mlv6FPYwQX+ihT6cKO9dM1o0oRH
         JrcA==
X-Gm-Message-State: ABy/qLagc0O3weVYV/jb1e9SRW1EmJ9uvULEy9omN+r3nzp09wrHSQxo
        5egCuDOZTwQj7pRoGzu65QrPFw==
X-Google-Smtp-Source: APBJJlGx68JBlekO0xvjwT7iigvCwI/s1FOxF/ffNTRgvDyXHyJIZnu+G2GKCpabCXWQUYGMJS6rNA==
X-Received: by 2002:a05:600c:21c8:b0:3fb:fef3:53f8 with SMTP id x8-20020a05600c21c800b003fbfef353f8mr9724649wmj.25.1689583108129;
        Mon, 17 Jul 2023 01:38:28 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id y20-20020a05600c20d400b003f91e32b1ebsm7485189wmm.17.2023.07.17.01.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 01:38:27 -0700 (PDT)
Date:   Mon, 17 Jul 2023 09:38:25 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/2] backlight: lp855x: Initialize PWM state on first
 brightness change
Message-ID: <20230717083825.GA3448956@aspen.lan>
References: <20230714121440.7717-1-aweber.kernel@gmail.com>
 <20230714121440.7717-2-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230714121440.7717-2-aweber.kernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 02:14:39PM +0200, Artur Weber wrote:
> As pointed out by Uwe Kleine-König[1], the changes introduced in
> commit c1ff7da03e16 ("video: backlight: lp855x: Get PWM for PWM mode
> during probe") caused the PWM state set up by the bootloader to be
> re-set when the driver is probed. This differs from the behavior from
> before that patch, where the PWM state would be initialized on the
> first brightness change.
>
> Fix this by moving the PWM state initialization into the PWM control
> function. Add a new variable, needs_pwm_init, to the device info struct
> to allow us to check whether we need the initialization, or whether it
> has already been done.
>
> [1] https://lore.kernel.org/lkml/20230614083953.e4kkweddjz7wztby@pengutronix.de/
>
> Fixes: c1ff7da03e16 ("video: backlight: lp855x: Get PWM for PWM mode during probe")
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
