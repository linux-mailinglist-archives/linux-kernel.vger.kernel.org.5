Return-Path: <linux-kernel+bounces-152339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 760528ABC9C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 19:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FC71C20BD1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 17:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E4B3B1AA;
	Sat, 20 Apr 2024 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="r3Y3TEG9"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F4B2AEEC
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713635654; cv=none; b=Gx3zheAkTkHw6OXnaYaGtcSfY5PobehPJ4koUhXCBpNlmmZt80cr0VCL7yjdGS89guzX/tZkoWpBMP5VwoKLE/icaT0SQkKs378xw51iXfkkQ4JrMysRFHV+1XYyFi5MFEmEs95PxNF1ZGwgNAmLO/AKIsvuF6iRTyVdd10d7wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713635654; c=relaxed/simple;
	bh=rmzeX3otQzl7qQ8byaD3r2pVWLINXK/hYrDzx/7fOS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NiC4b1CB5LzVoO48ZKEeqY3bfuQ5P3/TsXWDJfJd3iwkm7PVmAK23HY3kmiaqSAmzf49++8HS1Y0cqfcthDzaxREF0yEfKzC+V2g71yri8EAQDaiKSx4qe0IhjrrCFMQ2pW208sUHnTsWKWl5DShFLmLs//F8wG+zxKUSkiXrQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=r3Y3TEG9; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1713635650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gx2Uh2+mS9jVrYQNKT1y5m3Fmt99nDwzwE4O30Is9Gg=;
	b=r3Y3TEG94336SUOJ2uer6SBieQ+Kp4JYl9HpcLNqIyHZodtUPS7dimhdv1JdI5GGS0sYq7
	RC/NnOJ5a2JduO5/sLiYslkC6FV//cGLjGEGJW7S/t3kbHlHm1EfpzadZBwJ8Z6twEtSCX
	wFq8ffi7xn9KB13glsOVZ49Si4N4zWqML2oAKpk2ZgSj+wtdmvpltUsKqoT9CeDsEpHfoM
	fPKIZtiYOjCoBZGh/gC6LrdrcAMYzrHtSp60Q3NXvYfplBTrJ06kvf9WQxe/OscGLbQFOt
	xHDrF+QR9ELKNSyZFo8BK8qkjXCK4IIzC1lM1Dn0OpSOsLh/my/d/byyYGf9aw==
From: Diederik de Haas <didi.debian@cknow.org>
To: Dragan Simic <dsimic@manjaro.org>, Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 linux-rockchip@lists.infradead.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] RK3588 and Rock 5B dts additions: thermal,
 OPP and fan
Date: Sat, 20 Apr 2024 19:53:58 +0200
Message-ID: <3068718.7t0mGDVaCv@bagend>
Organization: Connecting Knowledge
In-Reply-To: <9f4c7615a6685ac42dccdbe35e57c357@manjaro.org>
References:
 <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <66689051.MzlzmSNrL9@bagend> <9f4c7615a6685ac42dccdbe35e57c357@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2278925.Y8TTUSuLqC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart2278925.Y8TTUSuLqC
Content-Type: multipart/mixed; boundary="nextPart1975143.ijBsUvVnos";
 protected-headers="v1"
Content-Transfer-Encoding: 7Bit
From: Diederik de Haas <didi.debian@cknow.org>
Date: Sat, 20 Apr 2024 19:53:58 +0200
Message-ID: <3068718.7t0mGDVaCv@bagend>
Organization: Connecting Knowledge
In-Reply-To: <9f4c7615a6685ac42dccdbe35e57c357@manjaro.org>
MIME-Version: 1.0

This is a multi-part message in MIME format.

--nextPart1975143.ijBsUvVnos
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Dragan and Alexey,

On Wednesday, 10 April 2024 11:28:09 CEST Dragan Simic wrote:
> > Can you rebase this patch set on Heiko's for-next branch [1]?
> > And then also fix the ordering of the nodes and the elements within
> > those nodes so that they match the current conventions?
> 
> Ah, thanks, this is a good reminder about the proposal for the plan
> for moving forward, which I promised to send a while ago. :)
> 
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/l
> > og/?h=for-next

I build a (Debian) kernel based off 6.9-rc4 + a whole bunch of patches, 
including this patch series. I got someone on #debian-arm to try it out on a 
Rock 5B and the dmesg output showed a number of items wrt thermal and OPP.

Some items that I filtered out from that dmesg output:

[    3.211716] hwmon hwmon0: temp1_input not attached to any thermal zone
[    3.908339] panthor fb000000.gpu: EM: OPP:900000 is inefficient
[   10.473061] cpu cpu0: EM: OPP:600000 is inefficient
[   10.473233] energy_model: Accessing cpu4 policy failed
[   10.585236] rockchip-thermal fec00000.tsadc: Missing rockchip,grf property

Attached is the full list of items I collected from that dmesg output which 
seem worth investigating. 

Maybe useful to investigate when moving forward?

Cheers,
  Diederik
--nextPart1975143.ijBsUvVnos
Content-Disposition: attachment; filename="rock-5b-dmesg-issues.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="x-UTF_8J"; name="rock-5b-dmesg-issues.txt"

Radxa 5B issues (dmesg on https://termbin.com/e170):

[    2.863508] rockchip-spi feb20000.spi: Runtime PM usage count underflow!

[    2.915650] rtc-hym8563 6-0051: no valid clock/calendar values available
[    2.915949] rtc-hym8563 6-0051: registered as rtc0
[    2.916945] rtc-hym8563 6-0051: no valid clock/calendar values available
[    2.916950] rtc-hym8563 6-0051: hctosys: unable to read the hardware clock

[    2.994580] rockchip-drm display-subsystem: [drm:rockchip_drm_platform_probe [rockchipdrm]] *ERROR* No available vop found for display-subsystem.
[    3.101020] rockchip-dw-pcie a40000000.pcie: PCIe Gen.3 x4 link up
[    3.101308] rockchip-dw-pcie a40000000.pcie: PCI host bridge to bus 0000:00
[    3.101316] pci_bus 0000:00: root bus resource [bus 00-0f]
[    3.101324] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus address [0xf0100000-0xf01fffff])
[    3.101329] pci_bus 0000:00: root bus resource [mem 0xf0200000-0xf0ffffff]
[    3.101335] pci_bus 0000:00: root bus resource [mem 0x900000000-0x93fffffff] (bus address [0x40000000-0x7fffffff])
[    3.101357] pci 0000:00:00.0: [1d87:3588] type 01 class 0x060400 PCIe Root Port
[    3.101369] pci 0000:00:00.0: BAR 0 [mem 0x00000000-0x3fffffff]
[    3.101377] pci 0000:00:00.0: BAR 1 [mem 0x00000000-0x3fffffff]
[    3.101384] pci 0000:00:00.0: ROM [mem 0x00000000-0x0000ffff pref]
[    3.101389] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    3.101396] pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
[    3.101402] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    3.101410] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    3.101452] pci 0000:00:00.0: supports D1 D2
[    3.101457] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
[    3.103848] pci_bus 0000:01: busn_res: can not insert [bus 01-ff] under [bus 00-0f] (conflicts with (null) [bus 00-0f])
[    3.103921] pci 0000:01:00.0: [144d:a809] type 00 class 0x010802 PCIe Endpoint
[    3.103987] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
[    3.116969] pci 0000:00:00.0: BAR 0 [mem 0x900000000-0x93fffffff]: assigned
[    3.116983] pci 0000:00:00.0: BAR 1 [mem size 0x40000000]: can't assign; no space
[    3.116990] pci 0000:00:00.0: BAR 1 [mem size 0x40000000]: failed to assign
[    3.116995] pci 0000:00:00.0: bridge window [mem 0xf0200000-0xf02fffff]: assigned
[    3.117001] pci 0000:00:00.0: ROM [mem 0xf0300000-0xf030ffff pref]: assigned
[    3.117009] pci 0000:01:00.0: BAR 0 [mem 0xf0200000-0xf0203fff 64bit]: assigned
[    3.117042] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    3.117048] pci 0000:00:00.0:   bridge window [mem 0xf0200000-0xf02fffff]

[    3.211716] hwmon hwmon0: temp1_input not attached to any thermal zone
[    3.211775] hwmon hwmon0: temp2_input not attached to any thermal zone
[    3.211823] hwmon hwmon0: temp3_input not attached to any thermal zone

[    3.327532] pci 0002:20:00.0: bridge configuration invalid ([bus 01-ff]), reconfiguring

[    3.908339] panthor fb000000.gpu: EM: OPP:900000 is inefficient
[    3.908349] panthor fb000000.gpu: EM: OPP:800000 is inefficient
[    3.908354] panthor fb000000.gpu: EM: OPP:700000 is inefficient
[    3.908358] panthor fb000000.gpu: EM: OPP:600000 is inefficient
[    3.908361] panthor fb000000.gpu: EM: OPP:500000 is inefficient
[    3.908365] panthor fb000000.gpu: EM: OPP:400000 is inefficient
[    3.908369] panthor fb000000.gpu: EM: OPP:300000 is inefficient

[    3.920149] [drm] Initialized panthor 1.0.0 20230801 for fb000000.gpu on minor 0

[    4.483910] dwmmc_rockchip fe2d0000.mmc: Busy; trying anyway
[    5.213383] mmc_host mmc2: Timeout sending command (cmd 0x202000 arg 0x0 status 0x80202000)
[    5.228057] mmc_host mmc2: Bus speed (slot 0) = 300000Hz (slot req 300000Hz, actual 300000HZ div = 0)

[    7.072323] dwmmc_rockchip fe2d0000.mmc: Busy; trying anyway
[    7.801690] mmc_host mmc2: Timeout sending command (cmd 0x202000 arg 0x0 status 0x80202000)
[    7.816350] mmc_host mmc2: Bus speed (slot 0) = 187500Hz (slot req 187500Hz, actual 187500HZ div = 0)
[    8.369904] dwmmc_rockchip fe2d0000.mmc: Busy; trying anyway
[    9.099376] mmc_host mmc2: Timeout sending command (cmd 0x202000 arg 0x0 status 0x80202000)
[    9.101395] mmc2: Failed to initialize a non-removable card

[   10.473061] cpu cpu0: EM: OPP:600000 is inefficient
[   10.473075] cpu cpu0: EM: OPP:408000 is inefficient
[   10.473227] cpu cpu0: EM: created perf domain
[   10.473233] energy_model: Accessing cpu4 policy failed
[   10.483901] cpu cpu4: EM: OPP:2352000 is inefficient
[   10.483914] cpu cpu4: EM: OPP:2304000 is inefficient
[   10.483918] cpu cpu4: EM: OPP:2256000 is inefficient
[   10.483923] cpu cpu4: EM: OPP:1008000 is inefficient
[   10.483926] cpu cpu4: EM: OPP:816000 is inefficient
[   10.483930] cpu cpu4: EM: OPP:600000 is inefficient
[   10.483934] cpu cpu4: EM: OPP:408000 is inefficient
[   10.484193] cpu cpu4: EM: created perf domain
[   10.484199] energy_model: Accessing cpu6 policy failed
[   10.488907] cpu cpu6: EM: OPP:2352000 is inefficient
[   10.488917] cpu cpu6: EM: OPP:2304000 is inefficient
[   10.488921] cpu cpu6: EM: OPP:2256000 is inefficient
[   10.488925] cpu cpu6: EM: OPP:1008000 is inefficient
[   10.488928] cpu cpu6: EM: OPP:816000 is inefficient
[   10.488932] cpu cpu6: EM: OPP:600000 is inefficient
[   10.488936] cpu cpu6: EM: OPP:408000 is inefficient
[   10.489175] cpu cpu6: EM: created perf domain
[   10.489179] energy_model: updating cpu0 cpu_cap=397 old capacity=530
[   10.489186] cpu cpu0: EM: OPP:816000 is inefficient
[   10.489190] cpu cpu0: EM: OPP:600000 is inefficient
[   10.489194] cpu cpu0: EM: OPP:408000 is inefficient
[   10.585236] rockchip-thermal fec00000.tsadc: Missing rockchip,grf property
--nextPart1975143.ijBsUvVnos--

--nextPart2278925.Y8TTUSuLqC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZiQBNgAKCRDXblvOeH7b
bm9nAP9oyg2gMlYJQz+CTtHWFhf1KPqWPuu9eQjci3eJVHMLAQD+KB738LRB0U0Z
gN0e8/UkAudwoqAC8Gp6ME0SBzLXPw0=
=Pc21
-----END PGP SIGNATURE-----

--nextPart2278925.Y8TTUSuLqC--




