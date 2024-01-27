Return-Path: <linux-kernel+bounces-41189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 555FC83ED2D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00661F22F52
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 13:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B1B2560B;
	Sat, 27 Jan 2024 13:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="wAcJWRdL"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A48C25576;
	Sat, 27 Jan 2024 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706360991; cv=none; b=ZqfQQ8SQCXMtBMXug2pVYExBrzRLcwY5OvE8u60CxFV07Jk6lqcT7Uu0YgDApaq0PufdGLF2ssck2ZkCnRkjg0uDbqooUAJAGrWtTZkndPzpJgGYYkkrba2NQ2163cqnIGFfSH9na6rdQJSS3MSbU5doAxhpbnKrha/yHTDIhk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706360991; c=relaxed/simple;
	bh=VFVfwxL5If4aGv728WKPlLe407XHd9wmAkDP5L/+P4g=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Krqt9q+gnzHhJt21dLkJITx0ZLmeYQYqVt5E7dDKDTIkqe5+cDBN1LKgZvnczaJDhoH1hXjyw2CPmD2boXmj7CxJLksi1vJH7XPKjARj2hwxuyAss7FGUdXIUGLjaydcaAGICtKWZbRVhAHUvLLMQozhKIzb70Iqc8Fqdw7/CEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=wAcJWRdL; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706360987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cufdQqnYjHFq8zPvbdj8xB6WnLzWkarMVmEXqUgJEsk=;
	b=wAcJWRdLS11R2tadF3UO4hLBBCd39YvSBm6DEIpEcuOR/3Vxada9/LOeX1Lgf1VD0vNZSG
	cmYOn+wfNi7YhyVF6O0mJ4DYPb2wixfyH4lGvHqGZ8epGpszahlWZuIMQD6U9Dd5PHE9LA
	JK0IhnWMwhtjGBDcJrBN/uzTnM/iV38MrcGljkxKVwCUtNMo9u2spphCo+y134OQLZhiYq
	0Fo+SoMSypi+FZqv6xA/Y7yga3zZqe9vH3/u+KBK8yhseTrQGfDVzstGZ2YObDQE1xPM2t
	jW/MIjHmUFo4F+rjgdS5uPSOwqxeWNezC+K+RilUauIIsMsrPY7iujUCEkBsFA==
Date: Sat, 27 Jan 2024 14:09:46 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Andy Yan <andyshrk@163.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: rename vcc5v0_usb30_host
 regulator for Cool Pi CM5 EVB
In-Reply-To: <23650d42.ecb.18d4ad89c0c.Coremail.andyshrk@163.com>
References: <20240127092034.887085-1-andyshrk@163.com>
 <20240127092034.887085-3-andyshrk@163.com> <2798389.3c9HiEOlIg@diego>
 <23650d42.ecb.18d4ad89c0c.Coremail.andyshrk@163.com>
Message-ID: <00ed78ea06aecde202a11a23c80f80af@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-27 13:15, Andy Yan wrote:
> At 2024-01-27 18:36:40, "Heiko Stübner" <heiko@sntech.de> wrote:
>> Am Samstag, 27. Januar 2024, 10:20:33 CET schrieb Andy Yan:
>>> According to the schematic, this regulator is used both for USB30 and
>>> USB20, so give it a more appropriate name.
>> 
>> I don't have the schematics, so I'll need you to answer this, but what
>> is the regulator called _in_ the schematics?
> 
> There are two regulators called VCC50_USB_HOST1 and VCC50_USB_HOST2,
> and they are both controlled by GPIO1_D5
> They both for two usb 2.0 hosts,  not usb 30, the schematics make
> me a bit confused.

In that case, I'd say that renaming the regulator to vcc5v0_usb_host is
fine, but there should also be a comment in the board dts file that it's
actually two separate regulators.

>> I.e. we want regulators to really be named the same as in the 
>> schematic
>> so people can look up thing from the dts in the schematics and the 
>> other
>> way around too.

Ah, that's very helpful.

>>> Fixes: 791c154c3982 ("arm64: dts: rockchip: Add support for rk3588 
>>> based board Cool Pi CM5 EVB")
>>> Signed-off-by: Andy Yan <andyshrk@163.com>
>>> ---
>>> 
>>>  arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>> 
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts 
>>> b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
>>> index 1b5681fe0471..5f42f1065d73 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
>>> @@ -84,7 +84,7 @@ vcc3v3_lcd: vcc3v3-lcd-regulator {
>>>  		vin-supply = <&vcc3v3_sys>;
>>>  	};
>>> 
>>> -	vcc5v0_usb30_host: vcc5v0-usb30-host-regulator {
>>> +	vcc5v0_usb_host: vcc5v0-usb-host-regulator {
>>>  		compatible = "regulator-fixed";
>>>  		regulator-name = "vcc5v0_host";
>>>  		regulator-boot-on;
>>> @@ -200,12 +200,12 @@ &u2phy3 {
>>>  };
>>> 
>>>  &u2phy2_host {
>>> -	phy-supply = <&vcc5v0_usb30_host>;
>>> +	phy-supply = <&vcc5v0_usb_host>;
>>>  	status = "okay";
>>>  };
>>> 
>>>  &u2phy3_host {
>>> -	phy-supply = <&vcc5v0_usb30_host>;
>>> +	phy-supply = <&vcc5v0_usb_host>;
>>>  	status = "okay";
>>>  };

