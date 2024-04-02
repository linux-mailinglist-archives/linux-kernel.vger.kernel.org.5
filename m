Return-Path: <linux-kernel+bounces-127876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E80895222
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 132D3287287
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E546D762E5;
	Tue,  2 Apr 2024 11:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="f7xcPOcG"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AB169945;
	Tue,  2 Apr 2024 11:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712058231; cv=none; b=DyT0flR+ubRuUKxo5D4ffNRD/TfdNq2tFWFTnEwESTX0ciJ0I/UdRa0HUoEoL3sgP77pYtYT7WBuQoN1z3qKpqwuR6/MCw+3ntjEqrS0qEGmPJti4M0lT4W/EyGYLL9szsX8ti7QhlRlOw5oaTHieQODLev50gXynvHZTn6gCeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712058231; c=relaxed/simple;
	bh=njjMEzLsHMSlDTiQE1B36+f5crvXTv8rcO7u5f6kj5Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wf/UvovqdudIAsucVhIlcnjPsZjOyuhEvtH+IZsQryYImNI8w3mMJkvmJ20HK3jne82wykym0Hue0x2k3CjyjljPVDxZBjg83235C5KyDjzblbeCvo63IxYiwmNfplC0MH4ZKrP7DxCusfKR2ZjfGhKm+p/h2oWi5SMyu6iRmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=f7xcPOcG; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 295BF120006;
	Tue,  2 Apr 2024 14:43:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 295BF120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712058224;
	bh=wuiJSm2gwfdh+2/YJ8DiGWwXRM4OI+Enlg3GWjkAqQY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=f7xcPOcGvkHqQhAbYErDCAhZS1dOFzzq6zcW9Di/esudoJnthSr8ZStQJzjv0Q8q6
	 V5W6NTQDDQ0XN4OVlhxnzTsMkdRWJ+1ZRMhZE/RelEVGDt7zqdEH694ZddSryvhbw3
	 lilBxleaWY/2/TNgXMAeWQvMEEvnod1i9SjrtmBUqJYWoKT6cK7j8T1B3Fu57mmcMq
	 KG5oyBu5Yl4uQ2j/l4PufudeEj9ZV9XFfsGXjmSYGuS4uhAow+kWWFXZ5nw8FglU7I
	 zHc3K4JinLRlfnwGC5I92Xtpi5Bq/25ngOfYAmzK3g6zj24+XwiywwYPXCVJAyhhfe
	 FiCAel5zT+w6w==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  2 Apr 2024 14:43:43 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 2 Apr
 2024 14:43:43 +0300
Date: Tue, 2 Apr 2024 14:43:43 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Jerome Brunet <jbrunet@baylibre.com>
CC: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	<neil.armstrong@linaro.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<khilman@baylibre.com>, <kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 6/6] clk: meson: a1: add Amlogic A1 CPU clock
 controller driver
Message-ID: <20240402114343.npyh7whgrpuv7jme@CAB-WSD-L081021>
References: <20240329205904.25002-1-ddrokosov@salutedevices.com>
 <20240329205904.25002-7-ddrokosov@salutedevices.com>
 <CAFBinCCC5KK-4_w41B-+ZJ3zdZckq_EDuAW+Kak2C0Ow8uuD6Q@mail.gmail.com>
 <20240401171237.qoewp2pgcdrqvc3e@CAB-WSD-L081021>
 <1jzfuchztl.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1jzfuchztl.fsf@starbuckisacylon.baylibre.com>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184532 [Apr 02 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/02 07:07:00 #24571916
X-KSMG-AntiVirus-Status: Clean, skipped

On Tue, Apr 02, 2024 at 11:27:24AM +0200, Jerome Brunet wrote:
> 
> On Mon 01 Apr 2024 at 20:12, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
> 
> > Hello Martin,
> >
> > Thank you for quick response. Please find my thoughts below.
> >
> > On Sun, Mar 31, 2024 at 11:40:13PM +0200, Martin Blumenstingl wrote:
> >> Hi Dmitry,
> >> 
> >> On Fri, Mar 29, 2024 at 9:59 PM Dmitry Rokosov
> >> <ddrokosov@salutedevices.com> wrote:
> >> [...]
> >> > +static struct clk_regmap cpu_fclk = {
> >> > +       .data = &(struct clk_regmap_mux_data) {
> >> > +               .offset = CPUCTRL_CLK_CTRL0,
> >> > +               .mask = 0x1,
> >> > +               .shift = 10,
> >> > +       },
> >> > +       .hw.init = &(struct clk_init_data) {
> >> > +               .name = "cpu_fclk",
> >> > +               .ops = &clk_regmap_mux_ops,
> >> > +               .parent_hws = (const struct clk_hw *[]) {
> >> > +                       &cpu_fsel0.hw,
> >> > +                       &cpu_fsel1.hw,
> >> Have you considered the CLK_SET_RATE_GATE flag for &cpu_fsel0.hw and
> >> &cpu_fsel1.hw and then dropping the clock notifier below?
> >> We use that approach with the Mali GPU clock on other SoCs, see for
> >> example commit 8daeaea99caa ("clk: meson: meson8b: make the CCF use
> >> the glitch-free mali mux").
> >> It may differ from what Amlogic does in their BSP,
> >
> > Amlogic in their BSP takes a different approach, which is slightly
> > different from mine. They cleverly change the parent of cpu_clk directly
> > by forking the cpufreq driver to a custom version. I must admit, it's
> > quite an "interesting and amazing" idea :) but it's not architecturally
> > correct totally.
> 
> I disagree. Martin's suggestion is correct for the fsel part which is
> symetric.
> 

It seems that I didn't fully understand Martin's suggestion. I was
confused by the advice to remove the notifier block and tried to explain
why it's not possible. However, I believe it is reasonable to protect
the cpu_fselX from rate propagation, because it is symmetric, as you
mentioned.

> >
> >> but I don't think
> >> that there's any harm (if it works in general) because CCF (common
> >> clock framework) will set all clocks in the "inactive" tree and then
> >> as a last step just change the mux (&cpu_fclk.hw). So at no point in
> >> time will we get any other rate than a) the original CPU clock rate
> >> before the rate change b) the new desired CPU clock rate. This is
> >> because we have two symmetric clock trees.
> >
> > Now, let's dive into the specifics of the issue we're facing. I've
> > examined the CLK_SET_RATE_GATE flag, which, to my understanding, blocks
> > rate changes for the entire clock chain. However, in this particular
> > situation, it doesn't provide the solution we need.
> >
> > Here's the problem we're dealing with:
> >
> > 1) The CPU clock can have the following frequency points:
> >
> >   available frequency steps:  128 MHz, 256 MHz, 512 MHz, 768 MHz, 1.01 GHz, 1.20 GHz
> >
> > When we run the cpupower, we get the following information:
> > # cpupower -c 0,1 frequency-info
> > analyzing CPU 0:
> >   driver: cpufreq-dt
> >   CPUs which run at the same hardware frequency: 0 1
> >   CPUs which need to have their frequency coordinated by software: 0 1
> >   maximum transition latency: 50.0 us
> >   hardware limits: 128 MHz - 1.20 GHz
> >   available frequency steps:  128 MHz, 256 MHz, 512 MHz, 768 MHz, 1.01 GHz, 1.20 GHz
> >   available cpufreq governors: conservative ondemand userspace performance schedutil
> >   current policy: frequency should be within 128 MHz and 128 MHz.
> >                   The governor "schedutil" may decide which speed to use
> >                   within this range.
> >   current CPU frequency: 128 MHz (asserted by call to hardware)
> > analyzing CPU 1:
> >   driver: cpufreq-dt
> >   CPUs which run at the same hardware frequency: 0 1
> >   CPUs which need to have their frequency coordinated by software: 0 1
> >   maximum transition latency: 50.0 us
> >   hardware limits: 128 MHz - 1.20 GHz
> >   available frequency steps:  128 MHz, 256 MHz, 512 MHz, 768 MHz, 1.01 GHz, 1.20 GHz
> >   available cpufreq governors: conservative ondemand userspace performance schedutil
> >   current policy: frequency should be within 128 MHz and 128 MHz.
> >                   The governor "schedutil" may decide which speed to use
> >                   within this range.
> >   current CPU frequency: 128 MHz (asserted by call to hardware)
> >
> > 2) For the frequency points 128 MHz, 256 MHz, and 512 MHz, the CPU fixed
> > clock should be used.
> 
> Apparently, you are relying on the SYS PLL lowest possible rate to
> enfore this contraint, which I suppose is 24 * 32 = 768MHz. It would be
> nice to clearly say so.
> 

Based on my understanding, the minimum frequency that sys_pll can
provide is not relevant. The CPU fixed clock is considered a "safety"
clock, and I can confidently connect the cpu_clk parent to that stable
clock without any issues. CCF will decide which parent will be used in
the end of rate changing process.

> > Fortunately, we don't encounter any freeze
> > problems when we attempt to change its rate at these frequencies.
> 
> That does not sound very solid ...
> 

Why? Per my understanding, CPU fixed clock guarantees this behaviour.

> >
> > 3) However, for the frequency points 768 MHz, 1.01 GHz, and 1.20 GHz,
> > the sys_pll is used as the clock source because it's a faster option.
> > Now, let's imagine that we want to change the CPU clock from 768 MHz to
> > 1.01 GHz. Unfortunately, it's not possible due to the broken sys_pll,
> > and any execution attempts will result in a hang.
> 
> ... Because PLL needs to relock, it is going to be off for a while. That
> is not "broken", unless there is something else ?
> 

Sorry for wrong terminology. I meant that sys_pll cannot be used as a
clock source (clock parent) while we are changing its rate.

> >
> > 4) As you can observe, in this case, we actually don't need to lock the
> > rate for the sys_pll chain.
> 
> In which case ? I'm lost.
> 

In the case for which notifier block was applied - cpu_clk and sys_pll
rate propagation.

> > We want to change the rate instead.
> 
> ... How are you going to do that without relocking the PLL ?
> 

I'm afraid, this is terminology miss from my side again. By 'sys_pll
lock' I mean rate lock using CLK_SET_RATE_GATE. I want to say that we
can't prohibit rate propagation of sys_pll chain, because we want to
change the rate, this is our main goal.

> > Hence,
> > I'm not aware of any other method to achieve this except by switching
> > the cpu_clk parent to a stable clock using clock notifier block.
> > Interestingly, I've noticed a similar approach in the CPU clock drivers
> > of Rockchip, Qualcomm, and Mediatek.
> 
> There is an example of syspll notifier in the g12 clock controller.
> You should have a look at it

Okay. As I mentioned in another email reply, in order to make it happen,
it is required to move the sys_pll clock to the a1-cpu driver. However,
I thought that this approach may not be correct from a logical
perspective. I will try.

-- 
Thank you,
Dmitry

