Return-Path: <linux-kernel+bounces-48772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3DB8460FF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E6328587E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF01D85285;
	Thu,  1 Feb 2024 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="SKjI1kF4"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E7085278;
	Thu,  1 Feb 2024 19:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706815909; cv=none; b=Y/G5kEEVS8KdgCCt7qWPssIl2H+FEtwfGf3kmW+qML5DkKv9LkIZAnWmikEMEwj+NTro7SMMY8H9Bn9lT0zzxBPGgceTF0Az/s5hCdPpDQM82tV1h45HDecZWjoyfWpYeRiwNTDRa8neSdBOEUcP6RFdsDG4Zz8aHy8TYCHa7L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706815909; c=relaxed/simple;
	bh=30CrakodQoj7bnMNjvntO6yWV9ILkjgkGXFZuyqQ044=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=c9tnWhszpmvgKXTBuvISzO+1PxnEqgCsZP+qvs/dOvEqVAOW9MY+FOnLRmmPhqoV4Epouo/pNVP6jiWtE4ah3BxEVB6oMC62unYM3ShmEWPAAGDEy0plTwoim5oynFQAuCtMtjwDTze2fhPSIkEhbE+pNojzqkKqu1vvHvWTXy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=SKjI1kF4; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706815904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7kLN+F37wlT4potTE1hxcRfMjPjrCtSNMuo+YwMDxvM=;
	b=SKjI1kF4cfxpbkHEOLzLGDRB+LXTqrbLitQsEeHkR/7RxPOUGJVJ2P2VgqbhveMtNdmZRm
	24XYitFv27nxw1ajFlSGJZuXYbjuWMWAygSOiEA/F+wP8G5MCgtrBqyhP9VzsL9IlK8D7X
	P8zXcvfNKuQ/tB2Lpblx56WcVM/wbfSp9SHN+tU/87sdtjRkfZDZ7Ha2joCdegtx4yEkb7
	iu1CLpI5lZj/PJfPWfK9Y20ILQsHQI56KqIRUEEO11NOhn8vifcymHB8jaw0GION9pjkhb
	w68TWDLx/Ktp04QDIeyldb20ljLUsr/4thalc+AducLysS6upbxlMZ+MAXhRFg==
Date: Thu, 01 Feb 2024 20:31:43 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: wens@kernel.org, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64: dts: rockchip: enable temperature driven
 fan control on Rock 5B
In-Reply-To: <CABjd4Yx0kQ67fScrFVavjObMLaNt_PJ3TVOhLpCmj00Dx9dOqA@mail.gmail.com>
References: <20240130-rk-dts-additions-v2-0-c6222c4c78df@gmail.com>
 <20240130-rk-dts-additions-v2-2-c6222c4c78df@gmail.com>
 <CAGb2v65--rgb2FqmG_0-w1-jUL0odqKXxiZJ-XPYA4uomfYmaQ@mail.gmail.com>
 <5e3e12d65e4919372e7fb02d56202393@manjaro.org>
 <CABjd4Yx0kQ67fScrFVavjObMLaNt_PJ3TVOhLpCmj00Dx9dOqA@mail.gmail.com>
Message-ID: <a8aa04ca0061cd09c7b3eb5336e534a4@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-01 20:15, Alexey Charkov wrote:
> On Thu, Feb 1, 2024 at 9:34 PM Dragan Simic <dsimic@manjaro.org> wrote:
>> On 2024-02-01 15:26, Chen-Yu Tsai wrote:
>> > On Wed, Jan 31, 2024 at 2:22 AM Alexey Charkov <alchark@gmail.com>
>> > wrote:
>> >>
>> >> This enables thermal monitoring on Radxa Rock 5B and links the PWM
>> >> fan as an active cooling device managed automatically by the thermal
>> >> subsystem, with a target SoC temperature of 65C and a minimum-spin
>> >> interval from 55C to 65C to ensure airflow when the system gets warm
>> >>
>> >> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> >> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> >> ---
>> >>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 34
>> >> ++++++++++++++++++++++++-
>> >>  1 file changed, 33 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> >> b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> >> index a0e303c3a1dc..b485edeef876 100644
>> >> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> >> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> >> @@ -52,7 +52,7 @@ led_rgb_b {
>> >>
>> >>         fan: pwm-fan {
>> >>                 compatible = "pwm-fan";
>> >> -               cooling-levels = <0 95 145 195 255>;
>> >> +               cooling-levels = <0 120 150 180 210 240 255>;
>> >>                 fan-supply = <&vcc5v0_sys>;
>> >>                 pwms = <&pwm1 0 50000 0>;
>> >>                 #cooling-cells = <2>;
>> >> @@ -173,6 +173,34 @@ &cpu_l3 {
>> >>         cpu-supply = <&vdd_cpu_lit_s0>;
>> >>  };
>> >>
>> >> +&package_thermal {
>> >> +       polling-delay = <1000>;
>> >> +
>> >> +       trips {
>> >> +               package_fan0: package-fan0 {
>> >> +                       temperature = <55000>;
>> >> +                       hysteresis = <2000>;
>> >> +                       type = "active";
>> >> +               };
>> >> +               package_fan1: package-fan1 {
>> >> +                       temperature = <65000>;
>> >> +                       hysteresis = <2000>;
>> >> +                       type = "active";
>> >> +               };
>> >> +       };
>> >> +
>> >> +       cooling-maps {
>> >> +               map0 {
>> >> +                       trip = <&package_fan0>;
>> >> +                       cooling-device = <&fan THERMAL_NO_LIMIT 1>;
>> >> +               };
>> >> +               map1 {
>> >> +                       trip = <&package_fan1>;
>> >> +                       cooling-device = <&fan 1 THERMAL_NO_LIMIT>;
>> >> +               };
>> >> +       };
>> >> +};
>> >> +
>> >>  &i2c0 {
>> >>         pinctrl-names = "default";
>> >>         pinctrl-0 = <&i2c0m2_xfer>;
>> >> @@ -731,6 +759,10 @@ regulator-state-mem {
>> >>         };
>> >>  };
>> >>
>> >> +&tsadc {
>> >> +       status = "okay";
>> >> +};
>> >> +
>> >
>> > Is there any reason this can't be enabled by default in the .dtsi file?
>> > The thermal sensor doesn't depend on anything external, so there should
>> > be no reason to push this down to the board level.
>> 
>> Actually, there is a reason.  Different boards can handle the critical
>> overheating differently, by letting the CRU or the PMIC handle it.  
>> This
>> was also the case for the RK3399.
>> 
>> Please, have a look at the following DT properties, which are consumed
>> by drivers/thermal/rockchip_thermal.c:
>>    - "rockchip,hw-tshut-mode"
>>    - "rockchip,hw-tshut-polarity"
>> 
>> See also page 1,372 of the RK3588 TRM v1.0.
>> 
>> This has also reminded me to check how is the Rock 5B actually wired,
>> just to make sure.  We actually need to provide the two DT properties
>> listed above, at least to avoid emitting the warnings.
> 
> Well the defaults are already provided in rk3588s.dtsi, so there won't
> be any warnings (see lines 2222-2223 in Linus' master version), and
> according to the vendor kernel those are also what Rock 5B uses.

Yes, I noticed the same a couple of minutes after sending my last
message, but didn't want to make more noise about it. :)  I would've
mentioned it in my next message, of course.

> This made me think however: what if a board doesn't enable TSADC, but
> has OPPs in place for higher voltage and frequency states? There won't
> be any throttling (as there won't be any thermal monitoring) and there
> might not be a critical shutdown at all if it heats up - possibly even
> causing hardware damage. In this case it seems that having TSADC
> enabled by default would at least trigger passive cooling, hopefully
> avoiding the critical shutdown altogether and making those properties
> irrelevant in 99% cases.

Those are very good questions.  Thumbs up!

The trouble is that the boards can use different wiring to handle the
thermal runaways, by expecting the PMIC to handle it or not.  Thus,
it's IMHO better to simply leave that to be tested and enabled on a
board-by-board basis, whenever a new RK3588(s)-based board is added.

Thus, the only right way at this point would be to merge the addition
of the OPPs and the enabling of the TSADC for all currently supported
RK3588(s)-based boards at once, instead of just for the Rock 5B.

I can handle the required changes for the QuartzPro64 dts file.  For
other supported RK3588(s)-based boards, if there are no people having
access to them and willing to perform the dts changes and the testing,
I'd be willing to go through the board schematics, to enable the
TSADC for them as well.

