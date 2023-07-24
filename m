Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E8575EA7C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 06:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjGXEZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 00:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjGXEZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 00:25:08 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAC512E
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 21:25:06 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-66c729f5618so3765964b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 21:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690172706; x=1690777506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UPd/ArX54wqm/tpIEiEhXcXx1X1EWiF2KSiUxQCQJ7k=;
        b=RvsdkRDPYfr6N/6c8aZGUc/31/ZJGWi5u6uyeM4gRwE6Uozbh5mcN6VfAItdfyjeK8
         lECf7dOHIeA1juGAeWddfBG56wZ1O2BX6TAkwg/4yXUs+OdBGAfqKUpCmR5igdBYHFLy
         i1Dt5V+/H9EaZzEAzzTCA/0ywgyJWmSnyMoBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690172706; x=1690777506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPd/ArX54wqm/tpIEiEhXcXx1X1EWiF2KSiUxQCQJ7k=;
        b=kZ7C+0w9dFPzALfHpbSiJhf2UZJMBGMmJrprI5+90K/kJv3Eg2DazbKrGUMcobpZ+Q
         5WLdTknnu5Yyo/girjHhqEcOb2UKSZS1FjD6TKF5rN+5NRDCZzaKWBs2PZypMGl7I3lb
         yBGsULQjb82YBsLzx32/n2C0h8MvnYHVTtzYA5FUU9blzlXjhqRSerh3YmKbw2BFbv9x
         s5TkYwGKpMoI9dLI0RWe91xc4JXwh74tQoFxsa/H+P5apuKCNwCI5kV9no0vqi7WWX8M
         npiAekLgAr0efky5qtaTiO9GPEvDZ7wu8M/BK1UB2sVely8JJaSuO+uwSkaOMZgp4tBX
         Y0vA==
X-Gm-Message-State: ABy/qLY/BL4rOha9xznCirS/a7AJpdy/b6fKE7lI1lXb9JfRL22Z2kId
        flLTLb2jTVcXIH7/1r2KIQOoxA==
X-Google-Smtp-Source: APBJJlH2TXjXyCI+Wm3NdTdlzQ/Md1RTpmdFKaqCFO/is9/DjNxtCBDRl3BbDb8IaKxYTeFcBvfJkw==
X-Received: by 2002:a05:6a00:2196:b0:668:82fe:16f1 with SMTP id h22-20020a056a00219600b0066882fe16f1mr9170529pfi.1.1690172706143;
        Sun, 23 Jul 2023 21:25:06 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:a3b4:a34b:d387:dea5])
        by smtp.gmail.com with ESMTPSA id x48-20020a056a000bf000b00666b012baedsm6636251pfu.158.2023.07.23.21.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 21:25:05 -0700 (PDT)
Date:   Mon, 24 Jul 2023 12:25:02 +0800
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Icenowy Zheng <zhengxingda@iscas.ac.cn>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [PATCH RESEND RESEND] thermal/of: support thermal zones w/o
 trips subnode
Message-ID: <20230724042502.GA2403526@google.com>
References: <20230722122534.2279689-1-zhengxingda@iscas.ac.cn>
 <ZLw4CnzLI/QHPGWx@finisterre.sirena.org.uk>
 <6d1c0915-1485-d9d6-9fff-0413fb16bd3f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d1c0915-1485-d9d6-9fff-0413fb16bd3f@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 12:12:49PM +0200, Daniel Lezcano wrote:
> 
> Hi Mark,
> 
> On 22/07/2023 22:11, Mark Brown wrote:
> > On Sat, Jul 22, 2023 at 08:25:34PM +0800, Icenowy Zheng wrote:
> > > From: Icenowy Zheng <uwu@icenowy.me>
> > > 
> > > Although the current device tree binding of thermal zones require the
> > > trips subnode, the binding in kernel v5.15 does not require it, and many
> > > device trees shipped with the kernel, for example,
> > > allwinner/sun50i-a64.dtsi and mediatek/mt8183-kukui.dtsi in ARM64, still
> > > comply to the old binding and contain no trips subnode.
> > > 
> > > Allow the code to successfully register thermal zones w/o trips subnode
> > > for DT binding compatibility now.
> > > 
> > > Furtherly, the inconsistency between DTs and bindings should be resolved
> > > by either adding empty trips subnode or dropping the trips subnode
> > > requirement.
> > 
> > This makes sense to me - it allows people to see the reported
> > temperature even if there's no trips defined which seems more
> > helpful than refusing to register.
> 
> The binding describes the trip points as required and that since the
> beginning.

Not really. It was made optional in the v5.15 kernel release by commit

    22fc857538c3 dt-bindings: thermal: Make trips node optional

> What changed is now the code reflects the required property while before it
> was permissive, that was an oversight.
> 
> Just a reminder about the thermal framework goals:
> 
>   1. It protects the silicon (thus critical and hot trip points)
> 
>   2. It mitigates the temperature (thus cooling device bound to trip points)
> 
>   3. It notifies the userspace when a trip point is crossed
> 
> So if the thermal zone is described but without any of this goal above, it
> is pointless.
> 
> If the goal is to report the temperature only, then hwmon should be used
> instead.

What about thermal sensors with multiple channels? Some of the channels
are indeed tied to important hardware blocks like the CPU cores and
should be tied into the thermal tripping. However other channels might
only be used for temperature read-out and have no such requirement.

Should we be mixing thermal and hwmon APIs in the driver?

> If the goal is to mitigate by userspace, then the trip point *must* be used
> to prevent the userspace polling the temperature. With the trip point the
> sensor will be set to fire an interrupt at the given trip temperature.
> 
> IOW, trip points are not optional

for measurement points that are used for thermal throttling /
mitigation.

ChenYu
