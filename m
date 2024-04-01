Return-Path: <linux-kernel+bounces-126893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A6D894411
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F202EB2140A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A1F482EF;
	Mon,  1 Apr 2024 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="m0lMe8sE"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD41121105;
	Mon,  1 Apr 2024 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991571; cv=none; b=OP0oE4VKEWAJcO1O8B2F/g+tXU6grXmR4NAUJQ8low3cKfZe07/D1PeLwKd3RUA4ESsxiF3G5L2g6JXo5b6YQR1I+PmteGUnbTgLYrTYao4o68u4ViuBLMA7K3oqTaMrhIpCGXaQEvYEAj4ZsJE12kNkTMwlieqElqg85XM6zkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991571; c=relaxed/simple;
	bh=hRW7LaUViC/2yeXmYcIOSziW/mhb4rNib+dfmKV1v0E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbYAQPd2yUPEFiJtLuHvh3PIFvZNHtKEn3CX8wAnN7Vn04YVl7Ol2+frBFaW0HApDdW2P1N4+wwH/Fe6uuPE48VeMxG4RoBUsmH7MYvxy01o7+YYz0O59g7BUjIReHkekQsXN1uqV3FAeqT3+BxHSfK253tGG0qxZuF4KlHkOWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=m0lMe8sE; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 0FDA2120003;
	Mon,  1 Apr 2024 20:12:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 0FDA2120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711991558;
	bh=tnV8DGhNxoxzX801UIgTUfBlu7sQv3A5VcnesxjPL9Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=m0lMe8sEnZlEGvDay+PxIIf/+Fp5YlR6YcY6FU18RLaDLcT4t9bpZukzKSIN0I9gX
	 EC1at4j0jfb5muT9AZbmhNFeiep++Efy9T67jgAlASn3gPHWwjK+G7Ds561EiNLXIu
	 kQv1yDB8I68uX4j5Z+zJFH+k2m5omOd2tPn62c5cGARyE1VG874sEZhDfyXAs1JtMq
	 Ebbbq9dOx26d+Tiii208BfDl3C9sTK50W3UJHRTghYKRbPKCH6cl9C4meLSRfnaOgT
	 EipK+d1wAnQpREsd+r683GN9byPNe4PyHN65WMYegm8xeJBzxoZmRnif+crgvF7ic0
	 JueEdsEU77NKg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon,  1 Apr 2024 20:12:37 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 1 Apr
 2024 20:12:37 +0300
Date: Mon, 1 Apr 2024 20:12:37 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 6/6] clk: meson: a1: add Amlogic A1 CPU clock
 controller driver
Message-ID: <20240401171237.qoewp2pgcdrqvc3e@CAB-WSD-L081021>
References: <20240329205904.25002-1-ddrokosov@salutedevices.com>
 <20240329205904.25002-7-ddrokosov@salutedevices.com>
 <CAFBinCCC5KK-4_w41B-+ZJ3zdZckq_EDuAW+Kak2C0Ow8uuD6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCCC5KK-4_w41B-+ZJ3zdZckq_EDuAW+Kak2C0Ow8uuD6Q@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184515 [Apr 01 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;salutedevices.com:7.1.1;100.64.160.123:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/01 15:13:00 #24563578
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Martin,

Thank you for quick response. Please find my thoughts below.

On Sun, Mar 31, 2024 at 11:40:13PM +0200, Martin Blumenstingl wrote:
> Hi Dmitry,
> 
> On Fri, Mar 29, 2024 at 9:59 PM Dmitry Rokosov
> <ddrokosov@salutedevices.com> wrote:
> [...]
> > +static struct clk_regmap cpu_fclk = {
> > +       .data = &(struct clk_regmap_mux_data) {
> > +               .offset = CPUCTRL_CLK_CTRL0,
> > +               .mask = 0x1,
> > +               .shift = 10,
> > +       },
> > +       .hw.init = &(struct clk_init_data) {
> > +               .name = "cpu_fclk",
> > +               .ops = &clk_regmap_mux_ops,
> > +               .parent_hws = (const struct clk_hw *[]) {
> > +                       &cpu_fsel0.hw,
> > +                       &cpu_fsel1.hw,
> Have you considered the CLK_SET_RATE_GATE flag for &cpu_fsel0.hw and
> &cpu_fsel1.hw and then dropping the clock notifier below?
> We use that approach with the Mali GPU clock on other SoCs, see for
> example commit 8daeaea99caa ("clk: meson: meson8b: make the CCF use
> the glitch-free mali mux").
> It may differ from what Amlogic does in their BSP,

Amlogic in their BSP takes a different approach, which is slightly
different from mine. They cleverly change the parent of cpu_clk directly
by forking the cpufreq driver to a custom version. I must admit, it's
quite an "interesting and amazing" idea :) but it's not architecturally
correct totally.

> but I don't think
> that there's any harm (if it works in general) because CCF (common
> clock framework) will set all clocks in the "inactive" tree and then
> as a last step just change the mux (&cpu_fclk.hw). So at no point in
> time will we get any other rate than a) the original CPU clock rate
> before the rate change b) the new desired CPU clock rate. This is
> because we have two symmetric clock trees.

Now, let's dive into the specifics of the issue we're facing. I've
examined the CLK_SET_RATE_GATE flag, which, to my understanding, blocks
rate changes for the entire clock chain. However, in this particular
situation, it doesn't provide the solution we need.

Here's the problem we're dealing with:

1) The CPU clock can have the following frequency points:

  available frequency steps:  128 MHz, 256 MHz, 512 MHz, 768 MHz, 1.01 GHz, 1.20 GHz

When we run the cpupower, we get the following information:
# cpupower -c 0,1 frequency-info
analyzing CPU 0:
  driver: cpufreq-dt
  CPUs which run at the same hardware frequency: 0 1
  CPUs which need to have their frequency coordinated by software: 0 1
  maximum transition latency: 50.0 us
  hardware limits: 128 MHz - 1.20 GHz
  available frequency steps:  128 MHz, 256 MHz, 512 MHz, 768 MHz, 1.01 GHz, 1.20 GHz
  available cpufreq governors: conservative ondemand userspace performance schedutil
  current policy: frequency should be within 128 MHz and 128 MHz.
                  The governor "schedutil" may decide which speed to use
                  within this range.
  current CPU frequency: 128 MHz (asserted by call to hardware)
analyzing CPU 1:
  driver: cpufreq-dt
  CPUs which run at the same hardware frequency: 0 1
  CPUs which need to have their frequency coordinated by software: 0 1
  maximum transition latency: 50.0 us
  hardware limits: 128 MHz - 1.20 GHz
  available frequency steps:  128 MHz, 256 MHz, 512 MHz, 768 MHz, 1.01 GHz, 1.20 GHz
  available cpufreq governors: conservative ondemand userspace performance schedutil
  current policy: frequency should be within 128 MHz and 128 MHz.
                  The governor "schedutil" may decide which speed to use
                  within this range.
  current CPU frequency: 128 MHz (asserted by call to hardware)

2) For the frequency points 128 MHz, 256 MHz, and 512 MHz, the CPU fixed
clock should be used. Fortunately, we don't encounter any freeze
problems when we attempt to change its rate at these frequencies.

3) However, for the frequency points 768 MHz, 1.01 GHz, and 1.20 GHz,
the sys_pll is used as the clock source because it's a faster option.
Now, let's imagine that we want to change the CPU clock from 768 MHz to
1.01 GHz. Unfortunately, it's not possible due to the broken sys_pll,
and any execution attempts will result in a hang.

4) As you can observe, in this case, we actually don't need to lock the
rate for the sys_pll chain. We want to change the rate instead. Hence,
I'm not aware of any other method to achieve this except by switching
the cpu_clk parent to a stable clock using clock notifier block.
Interestingly, I've noticed a similar approach in the CPU clock drivers
of Rockchip, Qualcomm, and Mediatek.

-- 
Thank you,
Dmitry

