Return-Path: <linux-kernel+bounces-48600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B0D845E9C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E26284E4A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C183365E31;
	Thu,  1 Feb 2024 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="WkY/V6+2"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9813D65E15;
	Thu,  1 Feb 2024 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808864; cv=none; b=Fs6DuFiMqjJP4b+4Mq7PyGKlIOOFuQqRPuRh/oLNH/vxWXuXHD+rlZ8zjIlucrYyp0n0rRM1Xh3nbk4zTjoNqW0e2SQbVgMg0k0MihlWiv91gTTgS488R+ajOVmz85WjhgvBHFRz2w4pySC7uUI53DKXNG/OlMrPN0csxuCZ7xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808864; c=relaxed/simple;
	bh=kWgUmjrV4QCujWjJbuyKqlSNr3R3M/nzMNx/c81aUu4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qcnJKfYreLRSnMolW6q/ucXPkwwMtKI5Jd1L2DiK/Z/O5lt5BdXm93yd/aNgd2rS0r0tg2JxPsADAOFoJjQn+RCLvCIzAzJ7u9cF1W0l13Wf/CMZWcpVGhoCIq+83Le7pSH94IuGfCSHbwf18vJTXXdiLbmYrTbDsz6WWWhYCwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=WkY/V6+2; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706808859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I62Ngu6mHUbbEd5/PKgWiEzJpbocaOMuoLyyq/u6R8M=;
	b=WkY/V6+2VLAsUER854fHTV0ijhfmJSzor5H6LK4YNxI2Z9+7CpORaMMz4uetnzSEQDFxJh
	ICEh9Du6iegkMwDanyR4V2Ro7ptplD8sOZ5Q2QRz5+hm56aeH/RRiiw1T9oz92eQgEk6V2
	6yf38wMVwANtCJWVwN9gKD5++gVglcvUuM/ruqcLnd4EdV9QxvBQ0wJRNa9gsOBn4uZBYx
	w7Th5wyqr+dIbLpSXTkeN+LClphsGIXgt0ZHfsuKPUg9IiIYJDLBuruSSXwBX5K6QjphIk
	aSFprWQ9gT96w8UldfAYuWcueWJHdHrOfqBAEXd35XKhm0x/5WnV55Er7R+aMA==
Date: Thu, 01 Feb 2024 18:34:18 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: wens@kernel.org
Cc: Alexey Charkov <alchark@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64: dts: rockchip: enable temperature driven
 fan control on Rock 5B
In-Reply-To: <CAGb2v65--rgb2FqmG_0-w1-jUL0odqKXxiZJ-XPYA4uomfYmaQ@mail.gmail.com>
References: <20240130-rk-dts-additions-v2-0-c6222c4c78df@gmail.com>
 <20240130-rk-dts-additions-v2-2-c6222c4c78df@gmail.com>
 <CAGb2v65--rgb2FqmG_0-w1-jUL0odqKXxiZJ-XPYA4uomfYmaQ@mail.gmail.com>
Message-ID: <5e3e12d65e4919372e7fb02d56202393@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Chen-Yu,

On 2024-02-01 15:26, Chen-Yu Tsai wrote:
> On Wed, Jan 31, 2024 at 2:22 AM Alexey Charkov <alchark@gmail.com> 
> wrote:
>> 
>> This enables thermal monitoring on Radxa Rock 5B and links the PWM
>> fan as an active cooling device managed automatically by the thermal
>> subsystem, with a target SoC temperature of 65C and a minimum-spin
>> interval from 55C to 65C to ensure airflow when the system gets warm
>> 
>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 34 
>> ++++++++++++++++++++++++-
>>  1 file changed, 33 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts 
>> b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> index a0e303c3a1dc..b485edeef876 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> @@ -52,7 +52,7 @@ led_rgb_b {
>> 
>>         fan: pwm-fan {
>>                 compatible = "pwm-fan";
>> -               cooling-levels = <0 95 145 195 255>;
>> +               cooling-levels = <0 120 150 180 210 240 255>;
>>                 fan-supply = <&vcc5v0_sys>;
>>                 pwms = <&pwm1 0 50000 0>;
>>                 #cooling-cells = <2>;
>> @@ -173,6 +173,34 @@ &cpu_l3 {
>>         cpu-supply = <&vdd_cpu_lit_s0>;
>>  };
>> 
>> +&package_thermal {
>> +       polling-delay = <1000>;
>> +
>> +       trips {
>> +               package_fan0: package-fan0 {
>> +                       temperature = <55000>;
>> +                       hysteresis = <2000>;
>> +                       type = "active";
>> +               };
>> +               package_fan1: package-fan1 {
>> +                       temperature = <65000>;
>> +                       hysteresis = <2000>;
>> +                       type = "active";
>> +               };
>> +       };
>> +
>> +       cooling-maps {
>> +               map0 {
>> +                       trip = <&package_fan0>;
>> +                       cooling-device = <&fan THERMAL_NO_LIMIT 1>;
>> +               };
>> +               map1 {
>> +                       trip = <&package_fan1>;
>> +                       cooling-device = <&fan 1 THERMAL_NO_LIMIT>;
>> +               };
>> +       };
>> +};
>> +
>>  &i2c0 {
>>         pinctrl-names = "default";
>>         pinctrl-0 = <&i2c0m2_xfer>;
>> @@ -731,6 +759,10 @@ regulator-state-mem {
>>         };
>>  };
>> 
>> +&tsadc {
>> +       status = "okay";
>> +};
>> +
> 
> Is there any reason this can't be enabled by default in the .dtsi file?
> The thermal sensor doesn't depend on anything external, so there should
> be no reason to push this down to the board level.

Actually, there is a reason.  Different boards can handle the critical
overheating differently, by letting the CRU or the PMIC handle it.  This
was also the case for the RK3399.

Please, have a look at the following DT properties, which are consumed
by drivers/thermal/rockchip_thermal.c:
   - "rockchip,hw-tshut-mode"
   - "rockchip,hw-tshut-polarity"

See also page 1,372 of the RK3588 TRM v1.0.

This has also reminded me to check how is the Rock 5B actually wired,
just to make sure.  We actually need to provide the two DT properties
listed above, at least to avoid emitting the warnings.

>>  &uart2 {
>>         pinctrl-0 = <&uart2m0_xfer>;
>>         status = "okay";
>> 
>> --
>> 2.43.0

