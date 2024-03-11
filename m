Return-Path: <linux-kernel+bounces-98695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AE7877E0F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E5D1F217E9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12262C69A;
	Mon, 11 Mar 2024 10:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="aZcFwatq"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B45129409;
	Mon, 11 Mar 2024 10:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710152690; cv=none; b=gKzvYvfLGOt0tD+BBWwGj28+fn1eMiXI3xY8gLWBmA6f/zDgrB7KqQvDB5Y3Yx9E5wbNfHV+TgdE8m+BMVxLWKeK3ZPq1I8VF+7445/PRb8EkY+zOy3oZKu595e+Q8hR9DY4Ej+62YImr1QoQ/z/Di3MmwERRvCcjXZ0Qy65JM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710152690; c=relaxed/simple;
	bh=JMhvWvgqFrYYTDdwxA2PIAMDKzBl/VjVBe2wTMQ6Odc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LsEna0CzVbOo49g15Ob8n4+am4HH6pF/b/TFzOu0vPm5pBEs8u62zn4hxuWJsp4J0nP5v4Htx1ZRG/A2eAcvPoQnPT9JU5Pk2fQ/eO8fQkLU1XM7VGZbC+ET4Mj+nCzXBoMVpauBfn+pqw7wto3D/XPE9ask+PKdLpBMOY14yoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=aZcFwatq; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710152684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ea2sTiT8afFcKIn8ydC5cAZuUU4HxS2+XT6hhynUCM4=;
	b=aZcFwatqGccBCoJ9Z6XrEHqnF05ETFlmmhxHizHc5IjaUU++yTBM+Cq2CkQER/44sCsbfF
	fCaGno+etdltB5vbIF8HH6XohXi/gpJPkbRgHOQI9/9otUX4JsAzjGlqv3vwK56ndiXLVE
	gXpPp8P2eJB4+AP/eOlByEPurMbGx9kDk3l9ZNqdQ4AIoBtBwImSXa05ez8wvF5zIlQmBa
	iFiM1+UoVGrYiw/0oL50+wN/tEaobWtdeEXgtvkFH5jhwuDHGaaTTUl1lkHWwKcKE5Dnvo
	Zqc3iVXSKXomK/2fQr534j02B7cJfOaddyj0yOkWj7eSrJWUzS3qpizu6+Thkw==
Date: Mon, 11 Mar 2024 11:24:41 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>, Kever Yang
 <kever.yang@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu
 Tsai <wens@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] arm64: dts: rockchip: Add CPU/memory regulator
 coupling for RK3588
In-Reply-To: <7e4379931dc6e35ca79a0ec7d27cf590@manjaro.org>
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <20240229-rk-dts-additions-v3-3-6afe8473a631@gmail.com>
 <7e4379931dc6e35ca79a0ec7d27cf590@manjaro.org>
Message-ID: <6908d38e68a77fd3a5633484a97e2821@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Kever,

Any chances, please, to have a look at my explanation below, and to
possibly provide some further insights?  I'd really love to understand
that better.


On 2024-03-01 09:13, Dragan Simic wrote:
> On 2024-02-29 20:26, Alexey Charkov wrote:
>> RK3588 chips allow for their CPU cores to be powered by a different
>> supply vs. their corresponding memory interfaces, and two of the
>> boards currently upstream do that (EVB1 and QuartzPro64).
> 
> The only reasonable explanation, based on the Cortex-A55 and Cortex-A76
> technical reference manuals (TRMs), and some other documents, including
> the RK3588 hardware design guide (HDG), is that the 
> VDD_CPU_BIG0_MEM_S0,
> VDD_CPU_BIG1_MEM_S0 and VDD_CPU_LIT_MEM_S0 voltages are internally
> used as the supplies for the SRAM used for the A76's and A55's L1 and
> L2 caches, which are both per-core and private in the DynamIQ SoC 
> layout
> that the RK3588 is based on.
> 
> Sure, using "MEM" there is confusing, but actually, the Cortex-A55 and
> Cortex-A76 refer to the L1 and L2 caches as "memory" in multiple 
> places.
> I'd say that's the reason for "MEM" (and "memory", in the RK3588 HDG) 
> to
> be used in the board schematics (and in the RK3588 HDG).
> 
> The RK3588 HDG specifically allows what the Rock 5B does there, i.e. to
> basically short the RK3588's individual *_MEM_S0 power inputs to the
> respective CPU core power supplies, which avoids the need to use 
> separate
> voltage regulators for the RK3588's *_MEM_S0 power inputs.
> 
> However, I'd really, _really_ love to know why did Rockchip opt to make
> the power supply voltages separate for the RK3588's L1 and L2 caches,
> which are, BTW, rated for up to 100 mA for each *_MEM_S0 input, meaning
> that they present no large loads?  All that under the assumption that
> my analysis is correct, of course.
> 
>> The voltage of the memory interface though has to match that of the
>> CPU cores that use it, which downstream kernels achieve by the means
>> of a custom cpufreq driver which adjusts both at the same time.
>> 
>> It seems that regulator coupling is a more appropriate generic
>> interface for it, so this patch introduces coupling to affected
>> device trees to ensure that memory interface voltage is also updated
>> whenever cpufreq switches between CPU OPPs.
> 
> I'll verify this a bit later and provide a separate response.
> 
>> Note that other boards, such as Radxa Rock 5B, define both the CPU
>> and memory interface regulators as aliases to the same DT node, so
>> this doesn't apply there.
> 
> Yup, they're actually shorted on the Rock 5B, as I described above.
> 
>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts    | 12 ++++++++++++
>>  arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts | 12 ++++++++++++
>>  2 files changed, 24 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
>> b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
>> index de30c2632b8e..dfae67f1e9c7 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
>> @@ -788,6 +788,8 @@ regulators {
>>  			vdd_cpu_big1_s0: dcdc-reg1 {
>>  				regulator-always-on;
>>  				regulator-boot-on;
>> +				regulator-coupled-with = <&vdd_cpu_big1_mem_s0>;
>> +				regulator-coupled-max-spread = <10000>;
>>  				regulator-min-microvolt = <550000>;
>>  				regulator-max-microvolt = <1050000>;
>>  				regulator-ramp-delay = <12500>;
>> @@ -800,6 +802,8 @@ regulator-state-mem {
>>  			vdd_cpu_big0_s0: dcdc-reg2 {
>>  				regulator-always-on;
>>  				regulator-boot-on;
>> +				regulator-coupled-with = <&vdd_cpu_big0_mem_s0>;
>> +				regulator-coupled-max-spread = <10000>;
>>  				regulator-min-microvolt = <550000>;
>>  				regulator-max-microvolt = <1050000>;
>>  				regulator-ramp-delay = <12500>;
>> @@ -812,6 +816,8 @@ regulator-state-mem {
>>  			vdd_cpu_lit_s0: dcdc-reg3 {
>>  				regulator-always-on;
>>  				regulator-boot-on;
>> +				regulator-coupled-with = <&vdd_cpu_lit_mem_s0>;
>> +				regulator-coupled-max-spread = <10000>;
>>  				regulator-min-microvolt = <550000>;
>>  				regulator-max-microvolt = <950000>;
>>  				regulator-ramp-delay = <12500>;
>> @@ -836,6 +842,8 @@ regulator-state-mem {
>>  			vdd_cpu_big1_mem_s0: dcdc-reg5 {
>>  				regulator-always-on;
>>  				regulator-boot-on;
>> +				regulator-coupled-with = <&vdd_cpu_big1_s0>;
>> +				regulator-coupled-max-spread = <10000>;
>>  				regulator-min-microvolt = <675000>;
>>  				regulator-max-microvolt = <1050000>;
>>  				regulator-ramp-delay = <12500>;
>> @@ -849,6 +857,8 @@ regulator-state-mem {
>>  			vdd_cpu_big0_mem_s0: dcdc-reg6 {
>>  				regulator-always-on;
>>  				regulator-boot-on;
>> +				regulator-coupled-with = <&vdd_cpu_big0_s0>;
>> +				regulator-coupled-max-spread = <10000>;
>>  				regulator-min-microvolt = <675000>;
>>  				regulator-max-microvolt = <1050000>;
>>  				regulator-ramp-delay = <12500>;
>> @@ -873,6 +883,8 @@ regulator-state-mem {
>>  			vdd_cpu_lit_mem_s0: dcdc-reg8 {
>>  				regulator-always-on;
>>  				regulator-boot-on;
>> +				regulator-coupled-with = <&vdd_cpu_lit_s0>;
>> +				regulator-coupled-max-spread = <10000>;
>>  				regulator-min-microvolt = <675000>;
>>  				regulator-max-microvolt = <950000>;
>>  				regulator-ramp-delay = <12500>;
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
>> b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
>> index 87a0abf95f7d..9c038450cd7c 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
>> @@ -818,6 +818,8 @@ vdd_cpu_big1_s0: dcdc-reg1 {
>>  				regulator-name = "vdd_cpu_big1_s0";
>>  				regulator-always-on;
>>  				regulator-boot-on;
>> +				regulator-coupled-with = <&vdd_cpu_big1_mem_s0>;
>> +				regulator-coupled-max-spread = <10000>;
>>  				regulator-min-microvolt = <550000>;
>>  				regulator-max-microvolt = <1050000>;
>>  				regulator-ramp-delay = <12500>;
>> @@ -831,6 +833,8 @@ vdd_cpu_big0_s0: dcdc-reg2 {
>>  				regulator-name = "vdd_cpu_big0_s0";
>>  				regulator-always-on;
>>  				regulator-boot-on;
>> +				regulator-coupled-with = <&vdd_cpu_big0_mem_s0>;
>> +				regulator-coupled-max-spread = <10000>;
>>  				regulator-min-microvolt = <550000>;
>>  				regulator-max-microvolt = <1050000>;
>>  				regulator-ramp-delay = <12500>;
>> @@ -844,6 +848,8 @@ vdd_cpu_lit_s0: dcdc-reg3 {
>>  				regulator-name = "vdd_cpu_lit_s0";
>>  				regulator-always-on;
>>  				regulator-boot-on;
>> +				regulator-coupled-with = <&vdd_cpu_lit_mem_s0>;
>> +				regulator-coupled-max-spread = <10000>;
>>  				regulator-min-microvolt = <550000>;
>>  				regulator-max-microvolt = <950000>;
>>  				regulator-ramp-delay = <12500>;
>> @@ -870,6 +876,8 @@ vdd_cpu_big1_mem_s0: dcdc-reg5 {
>>  				regulator-name = "vdd_cpu_big1_mem_s0";
>>  				regulator-always-on;
>>  				regulator-boot-on;
>> +				regulator-coupled-with = <&vdd_cpu_big1_s0>;
>> +				regulator-coupled-max-spread = <10000>;
>>  				regulator-min-microvolt = <675000>;
>>  				regulator-max-microvolt = <1050000>;
>>  				regulator-ramp-delay = <12500>;
>> @@ -884,6 +892,8 @@ vdd_cpu_big0_mem_s0: dcdc-reg6 {
>>  				regulator-name = "vdd_cpu_big0_mem_s0";
>>  				regulator-always-on;
>>  				regulator-boot-on;
>> +				regulator-coupled-with = <&vdd_cpu_big0_s0>;
>> +				regulator-coupled-max-spread = <10000>;
>>  				regulator-min-microvolt = <675000>;
>>  				regulator-max-microvolt = <1050000>;
>>  				regulator-ramp-delay = <12500>;
>> @@ -910,6 +920,8 @@ vdd_cpu_lit_mem_s0: dcdc-reg8 {
>>  				regulator-name = "vdd_cpu_lit_mem_s0";
>>  				regulator-always-on;
>>  				regulator-boot-on;
>> +				regulator-coupled-with = <&vdd_cpu_lit_s0>;
>> +				regulator-coupled-max-spread = <10000>;
>>  				regulator-min-microvolt = <675000>;
>>  				regulator-max-microvolt = <950000>;
>>  				regulator-ramp-delay = <12500>;

