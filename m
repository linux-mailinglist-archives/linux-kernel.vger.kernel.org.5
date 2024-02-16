Return-Path: <linux-kernel+bounces-68186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDFF8576F5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3971C21C05
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80D21759F;
	Fri, 16 Feb 2024 07:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="KWSqTlGm"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06652DDC4;
	Fri, 16 Feb 2024 07:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708069652; cv=none; b=ny0upML1gsrfVfXqfZnaazuQLxXTlpl3LU6gYX8c/MTeeU0XEA0D8DQYk0nVhk1EI/rsPeL6d/OTX0zSID9e+6DBgkpICG+FsQKl6kBKziQ7dLQ6wjhp7rTk1Vcr7mHzGrAojYglVBUSFWhTuXs/dHtpEBcuw7n6evRTypGu9Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708069652; c=relaxed/simple;
	bh=UkQNSsCosNH9uXR41zqk38q6dvmrPTadrT4OC5Os+7Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fgm0+bVf8g36PTgRtymaJlxWK0XJLIY/f6ZSZTmXD5f8z5WdhF7y8jH7HwuGfn68dUx5ZnqnHXyM3pGsVIF9dWLtiImGBYvbvCcwSj53dRRAv7wM7cjGb0APKxcXKaxO2zTY0TBwSwKEaomVHYsqhPxHQN5IQvs3Ykg7mN4st0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=KWSqTlGm; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id A89C412000C;
	Fri, 16 Feb 2024 10:47:22 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A89C412000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1708069642;
	bh=JBIQUmjhGqPH9CX2watwkGz5Gl4QEsmX9X4DCeR6veI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=KWSqTlGmCZbZaVN413ix6tubW0zlKnEts0ric9KI0eH7kJJePjFTvu7bcJnL+ahty
	 +2uDTqajV2lOb3OSckxNBL/KHb4uDUDBsmMsMExUM5K7+glolNWcGmBd5+oKO8kbJ1
	 K/awcGxdJG+Y8H86k5T6iZ9TqTog5qUwM53cAUgpioSYhnmRRfGavHtflpdnuUHDUr
	 3jw3LSKEuKRLvP/sqwHXCaw7u86+ejG3RCp5NWsYGMNzA7PfJRct0Nj0cnBGtiVg0R
	 lMLXD/ty9kYKzokg/lOHLqXqq0/p5BEgXOa1pckZ6Cnqpeus4ieUFcC1NAOaGDNqsB
	 kePv4zKdeuhCA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 16 Feb 2024 10:47:22 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 16 Feb
 2024 10:47:22 +0300
Date: Fri, 16 Feb 2024 10:47:16 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
CC: Viacheslav Bocharov <adeep@lexina.in>, Jerome Brunet
	<jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [DMARC error][DKIM error] [PATCH 0/5] soc: amlogic: add new
 meson-gx-socinfo-sm driver
Message-ID: <20240216074716.a33hrvl5xnpm7aep@CAB-WSD-L081021>
References: <20231122125643.1717160-1-adeep@lexina.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231122125643.1717160-1-adeep@lexina.in>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183487 [Feb 16 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, github.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;elixir.bootlin.com:7.1.1;salutedevices.com:7.1.1;lists.infradead.org:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/02/16 06:18:00
X-KSMG-LinksScanning: Clean, bases: 2024/02/16 07:22:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/16 06:42:00 #23632408
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Neil,

May I put in my two cents on this patch series?

There appears to be a misunderstanding regarding the terminology used.
Allow me to clarify my perspective.

The original Amlogic chipid has the following format:

    4 bytes      12 bytes
    +-------+-------------------+
    |       |                   |
    | CPUID | SOC SERIAL NUMBER |
    |       |                   |
    +-------+-------------------+
    0                          15


In the current uboot [1] and kernel [2] upstream, only the SOC SERIAL
NUMBER bytes are read from efuse OTP storage (and it isn't swapped, as
Amlogic reference code does [3]). We refer to these bytes as "serial".

The original chipid value is utilized in several algorithms (for
example, in the Amlogic boot protocols), making it crucial to have the
ability to read the original chipid value as intended by the vendor.

In my opinion, we should align our naming terminology as follows:
    - "chipid" - Represents the complete Amlogic SoC ID, includes
                 "cpuid" and "serial"
    - "serial" - 12 byte unique SoC number, identifying particular die

We strongly believe that this patch series is essential and are highly interested in seeing it applied to the upstream linux-amlogic, for the following reasons:
    - We use chipid for device identification in our boards
    - The Amlogic boot protocols utilize the full version of chipid
      (ADNL, Optimus). As I mentioned in the IRC, we are preparing a
      patch series for uboot incorporating them.
    - in OPTEE: for generation of SSK (Secure Storage Key) [4]
    - RPMB: for generation of RPMB key, further provisioned into RPMB
      controller (thus particular SoC is bound to particular eMMC

Therefore, I propose that we rename "soc_id" in the Viacheslav patch
series to "chipid" and subsequently port this patch series to uboot.

What are your thoughts on this matter?

Links:
[1] - https://elixir.bootlin.com/u-boot/v2024.01/source/arch/arm/mach-meson/sm.c#L84
[2] - https://elixir.bootlin.com/linux/v6.7.4/source/drivers/firmware/meson/meson_sm.c#L268
[3] - https://github.com/CoreELEC/u-boot/blob/3efc85a8370796bcec3bcadcdecec9aed973f4a9/arch/arm/mach-meson/g12a/bl31_apis.c#L398-L417
[4] - https://github.com/OP-TEE/optee_os/blob/5df2a985b2ffd0b6f1107f12ca2a88203bf31328/core/tee/tee_fs_key_manager.c#L152

On Wed, Nov 22, 2023 at 03:56:38PM +0300, Viacheslav Bocharov wrote:
> The Amlogic Meson SoC Secure Monitor implements a call to retrieve an
> unique SoC ID starting from the GX Family and all new families.
> But GX-family chips (e.g. GXB, GXL and newer) supports also 128-bit
> chip ID. 128-bit chip ID consists 32-bit SoC version and 96-bit OTP data.
> 
> This is the second attempt to publish data from the Amlogic secure monitor
> chipid call. After discussions with Neil Armstrong, it was decided to
> publish the chipid call results through the soc driver. Since
> soc_device_match cannot wait for the soc driver to load, and the secure
> monitor calls in turn depend on the sm driver, it was necessary to create
> a new driver rather than expand an existing one.
> 
> In the patches, in addition to writing the driver:
> - convert commonly used structures and functions of the meson-gx-socinfo
> driver to a header file.
> - transfer the chipid sm call constants to a header file (perhaps they
> need renaming?).
> - add secure-monitor references for amlogic,meson-gx-ao-secure sections
> in dts files of the a1, axg, g12, gx families.
> 
> Viacheslav Bocharov (5):
>   soc: amlogic: meson-gx-socinfo: move common code to header file
>   soc: amlogic: meson-gx-socinfo: move common code to exported function
>   firmware: meson_sm: move common definitions to header file
>   soc: amlogic: Add Amlogic secure-monitor SoC Information driver
>   arm64: dts: meson: add dts links to secure-monitor for soc driver in
>     a1, axg, gx, g12
> 
>  arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |   1 +
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |   1 +
>  .../boot/dts/amlogic/meson-g12-common.dtsi    |   1 +
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |   1 +
>  drivers/firmware/meson/meson_sm.c             |   4 -
>  drivers/soc/amlogic/Kconfig                   |  10 +
>  drivers/soc/amlogic/Makefile                  |   1 +
>  .../soc/amlogic/meson-gx-socinfo-internal.h   | 102 ++++++++++
>  drivers/soc/amlogic/meson-gx-socinfo-sm.c     | 178 ++++++++++++++++++
>  drivers/soc/amlogic/meson-gx-socinfo.c        | 106 ++---------
>  include/linux/firmware/meson/meson_sm.h       |   4 +
>  11 files changed, 317 insertions(+), 92 deletions(-)
>  create mode 100644 drivers/soc/amlogic/meson-gx-socinfo-internal.h
>  create mode 100644 drivers/soc/amlogic/meson-gx-socinfo-sm.c
> 
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Thank you,
Dmitry

