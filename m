Return-Path: <linux-kernel+bounces-1520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA030814FA3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593141F24204
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FDB30139;
	Fri, 15 Dec 2023 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="K4D21S36"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4AB3FB28;
	Fri, 15 Dec 2023 18:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1702664451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdamCqjRtgR4H2j8cWSZZKks1yiKAdE2PPQajEtV960=;
	b=K4D21S36po9STPxTJatpUcsaVOOhhFAeaDCcHOXV2QkyxFUv/02KPsHyvImWXz6DuZMQW+
	YGiN8M+jUjFoBcWhThuScNK3j/QV+11ijxq5K/3RYSkbbBMyemuD2/g0gLmfxUP+Fv0Ap4
	eD63ztjYxKsGncRkgAXqPAbSdCBWS2wgz39EkN22ImQMDFg1ExnpoSKSms3xBPW9gXc5SM
	UbLUAOEG/v5muxM198w920kUkuxswpIrEjdPeNwf1wQSwwWxBlrH4kFggX+oJPi9aSKf8X
	k1ixsAwmCx7KyfHD4eFIeZmz3MEaSRB4PDHMgGm00t1DlYjO6+2vny3u0ncE/w==
Date: Fri, 15 Dec 2023 19:20:51 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Stefan Nagy <stefan.nagy@ixypsilon.net>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Increase maximum frequency of SPI
 flash for ROCK Pi 4A/B/C
In-Reply-To: <33e632c38fa57053585c0016652ed8c8@manjaro.org>
References: <20231215122848.59534-1-stefan.nagy@ixypsilon.net>
 <33e632c38fa57053585c0016652ed8c8@manjaro.org>
Message-ID: <4fce0de996d6cc3056d972cd3fc3fb93@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-12-15 19:15, Dragan Simic wrote:
> On 2023-12-15 13:28, Stefan Nagy wrote:
>> The ROCK Pi 4A/B/C boards come with a 32 Mbit SPI NOR flash chip (XTX
>> Technology Limited XT25F32) which has a maximum clock frequency of 108
>> MHz. However, the Rockchip SPI controller driver limits the maximum
>> SPI clock frequency to 50 MHz. Use this limit for spi-max-freq.
>> 
>> This patch has been tested on ROCK Pi 4A.
>> 
>> Signed-off-by: Stefan Nagy <stefan.nagy@ixypsilon.net>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts | 2 +-
>>  arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts | 2 +-
>>  arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
>> b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
>> index d5df8939a..30e63e62a 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
>> @@ -19,6 +19,6 @@ &spi1 {
>>  	flash@0 {
>>  		compatible = "jedec,spi-nor";
>>  		reg = <0>;
>> -		spi-max-frequency = <10000000>;
>> +		spi-max-frequency = <50000000>;
>>  	};
>>  };
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
>> b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
>> index bee6d7588..7122bf6c0 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
>> @@ -37,7 +37,7 @@ &spi1 {
>>  	flash@0 {
>>  		compatible = "jedec,spi-nor";
>>  		reg = <0>;
>> -		spi-max-frequency = <10000000>;
>> +		spi-max-frequency = <50000000>;
>>  	};
>>  };
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
>> b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
>> index de2ebe4cb..8af75bc7c 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
>> @@ -49,7 +49,7 @@ &spi1 {
>>  	flash@0 {
>>  		compatible = "jedec,spi-nor";
>>  		reg = <0>;
>> -		spi-max-frequency = <10000000>;
>> +		spi-max-frequency = <50000000>;
>>  	};
>>  };
> 
> It would be better to upstream these changes to the Linux kernel
> first, and then sync them back to U-Boot.

Oops, my bad, sorry, I got confused with your other patch on the U-Boot 
mailing list.

Regarding the new spi-max-frequency value, it should be better to have 
it set to what the SPI chip actually supports, and let the SPI driver do 
its thing.

