Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD287E16E7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 22:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjKEVus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 16:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKEVur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 16:50:47 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9701BF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 13:50:43 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a81ab75f21so46232487b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 13:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699221043; x=1699825843; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hr90dwu2WPmXaV4AOaADTw6spiSJ6baUUUEIFJOSjZY=;
        b=a7PP9pAuklVXMrs/bRGWxE4gXaokmyt2253HQZVSn//yuYepZ4H6f+ietUitc/767A
         0iJopoPV104WAHp9Wf1utyP9kgmAo9+R+DR5h5zspzW2iXG8DePvTDf8t169KZKoiXZQ
         JHq1aP81+9hUAJWT29Oq+nBrjMXdzM5hFQ7iHBGlupv1fUv8gtrmikDC/tzYy+2Jb4cW
         QqWAjVG1Dc0YpwEkrPUAzj5fHvoF2HuUiMdtvDNMAsSKQMI7n7/5x8AL9Ef+0wXFsBQu
         LYR4PlUqyQ0HrdRl3NHMXi4CZC9nSN6lEdCSrDMdgtVo1tSmDNhT0HS/jQy2o8VMeCOl
         jCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699221043; x=1699825843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hr90dwu2WPmXaV4AOaADTw6spiSJ6baUUUEIFJOSjZY=;
        b=KkAURanLIhZaOJSjoon9b6Ydg5LvziX4wGPzJov8rLPA9lNR5z6awsyKKpxsUTMe/3
         EFjJCMKyfLDNSrcf1hT/g4SQ4zsWhFqI1/k9H3c8+ouMhbbjTs82pp6tYNm03of8wmv3
         NOOsc+780as0/Lt5uf3o9JmyDpbNeihZ1K+xI/sF7KDQiuOUQpIQeC09SNBFPF2jDggF
         8T1mNSnvJ+RJBYRSHhuobMhkFbT9+wnhcBPVWn9dKZlFexfr01DDT2gNHLEI3sZ/LNYl
         9p8aM+4EHaxSH8l452XT3khfraGDcpa2ZsWOMueN/56PYPse8zWgzLjMNp2rDbKnQQkB
         AIuw==
X-Gm-Message-State: AOJu0YxWgvakfYD1ovcY7diATQsqG6Qik9O4MWh30QSh0LTgcqP1D+Qd
        pZCGkL+E17ADddqQbOHHxwKLSU4iRwPOwRyYHdMy9Q==
X-Google-Smtp-Source: AGHT+IH3pT1GWz389sFqirKn5caQD4B9kLeKnqxw6mJ3o9PSnnJ5ODaLO9iXH2fcFh44UlzTYX6nLVYHv1RqiDHHBUo=
X-Received: by 2002:a0d:cc4e:0:b0:5a8:5079:422 with SMTP id
 o75-20020a0dcc4e000000b005a850790422mr8924478ywd.26.1699221043009; Sun, 05
 Nov 2023 13:50:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1698353854.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1698353854.git.oleksii_moisieiev@epam.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 5 Nov 2023 22:50:31 +0100
Message-ID: <CACRpkdZ4GborirSpa3GK_PwMgCvY0ePEmZO+CwnLcP6nAdieow@mail.gmail.com>
Subject: Re: [RFC v5 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Takahiro Akashi <takahiro.akashi@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksii,

thanks for this patch, which still looks very good to me.

A question that was raised in discussion with Takahiro Akashi was how we
identify pins that can be used for GPIO and if the spec or implementation
has given any thought to that.

I can think of a few, such that:

1. Pins that can be used for GPIO all belong to some group - possibly even
  one group per pin such as "gpioA1", "gpioA2", "gpioA3" etc - that can be
  assigned a function named "gpio" or similar.

2. GPIO is seen as something external or "third usecase" that is handled
  by pin config, not by pin mux.

If it is 1 - which I find likely - it would be good to standardize the name of
the function to be "gpio" and somehow make it clear that all pins that are
desired to be used for GPIO need to have a (group, function) tuple pair
such as ("gpio001", "gpio") that will put the pin into GPIO mode.

If the assumption is anything goes, i.e. a vendor could say something
like ("io-group-99", "generic-io") to put a certain pin into GPIO mode,
that is maybe not so optimal, because it's nice for the GPIO driver
(which will come up) to be able to figure out by e.g. string name
conventions that a pin is in GPIO mode, and which group and function
that will put it into GPIO mode.

If this generality is not desired, having standard names for GPIO
functions and groups is still going to be an upside, if it can be achieved.
But maybe this isn't attainable at this point?

Yours,
Linus Walleij
