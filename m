Return-Path: <linux-kernel+bounces-119848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C01F88CDA7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F46322D11
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5877E13D2A6;
	Tue, 26 Mar 2024 19:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="aJw4UsDY"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777D113D26E;
	Tue, 26 Mar 2024 19:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483041; cv=none; b=gowFFxEdGxduIPQU/rLS/rgYzdQQIy01Dg2MBUBQ168asF+igcq6TLfOgFBIMUb5t9XfwwFFxKgO+I0mrw7GjeHICslHtTcY7fufRdC/fDTHoalwQ5XvsYa6jnZfBnwFC2iv++TKy/037+Ucz5cpo3/VPn6u2Fbx3RGFVqmWIrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483041; c=relaxed/simple;
	bh=QGwS65KJjo0Qod2Xdlr+Q8+UcRquRTar4gyjPDRrK3A=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ZOJUEn6M+8uE1d9u68IK+7dwSgc7Xd5uUch8gZYOhFwTHoqUpedmiQpFNhFES/bzKmSdZVAhfo89i76ar95NaIaYEdvzcnOkCiQqSWL3MTRocfUVPsycYu44YnpJhtiWktIHhL7sG5A+GgfVweJcqI9RdgkMAHv1zglrYs7u2g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=aJw4UsDY; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711483036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xdxbt16Q0f6CqU6yeOFhWB+1nByjcjx4pNUNCjrto2I=;
	b=aJw4UsDYDzSEQygSUSOl+p5ZjX2WL0g3w7qrdlsdnjGGmLl5td1BeQILUAgqHoT4SYOHnb
	P2qKgWLD/ZtCAEgsyRlh/3fUxi9Wv3fBXOcQgUvWNXEv8RdFE0rbGOL2iOZmjl2DVqFvye
	+IyvoDdB3JzxESeirCP6yFu4jiikr8olKy/z5v9T/hrlspxzVw6Gofk2f6+I5f121xHbhd
	+AWmf2XQN3CCjYY977zAKlgdLVOi6r8t21XG3DUC9erQKwFEMiBBWj4zOdix3ubI4tsK0I
	O4cpwLlYjbX0Bel7vir7n9dvBM23ZqmDlX5wItxFhMk6Bd9BIlyRclyffVklSA==
Date: Tue, 26 Mar 2024 20:57:16 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 boris.brezillon@collabora.com, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH] arm64: dts: rockchip: quartzpro64: Enable the GPU
In-Reply-To: <jbyqey5y5ngr7mkrrmdxrwyw5ogd7rq56af6mrmhsckboanvyp@tcaav2tridos>
References: <0f3759ee390f245dac447bbee038445ddfecbec0.1711383286.git.dsimic@manjaro.org>
 <jbyqey5y5ngr7mkrrmdxrwyw5ogd7rq56af6mrmhsckboanvyp@tcaav2tridos>
Message-ID: <78f5ee0cc543aa4406c15fcafa50f2e8@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Sebastian,

On 2024-03-26 20:54, Sebastian Reichel wrote:
> On Mon, Mar 25, 2024 at 05:19:04PM +0100, Dragan Simic wrote:
>> Following the approach used to enable the Mali GPU on the rk3588-evb1, 
>> [1]
>> do the same for the Pine64 QuartzPro64, which uses nearly identical 
>> hardware
>> design as the RK3588 EVB1.
>> 
>> The slight disadvantage is that the regulator coupling logic requires 
>> the
>> regulators to be always on, which is also noted in the comments.  This 
>> is
>> obviously something to be improved at some point in the future, but 
>> should
>> be fine for now, especially because the QuartzPro64 isn't a 
>> battery-powered
>> board, so low power consumption isn't paramount.
>> 
>> [1] 
>> https://lore.kernel.org/linux-rockchip/20240325153850.189128-5-sebastian.reichel@collabora.com/
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
> 
> FWIW
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Great, thanks for your review!

>>  .../arm64/boot/dts/rockchip/rk3588-quartzpro64.dts | 14 
>> ++++++++++++++
>>  1 file changed, 14 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts 
>> b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
>> index 67414d72e2b6..68d432c61ea5 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
>> @@ -285,6 +285,12 @@ &gmac0_rgmii_clk
>>  	status = "okay";
>>  };
>> 
>> +&gpu {
>> +	mali-supply = <&vdd_gpu_s0>;
>> +	sram-supply = <&vdd_gpu_mem_s0>;
>> +	status = "okay";
>> +};
>> +
>>  &i2c2 {
>>  	status = "okay";
>> 
>> @@ -491,11 +497,15 @@ rk806_dvs3_null: dvs3-null-pins {
>>  		regulators {
>>  			vdd_gpu_s0: dcdc-reg1 {
>>  				regulator-name = "vdd_gpu_s0";
>> +				/* regulator coupling requires always-on */
>> +				regulator-always-on;
>>  				regulator-boot-on;
>>  				regulator-enable-ramp-delay = <400>;
>>  				regulator-min-microvolt = <550000>;
>>  				regulator-max-microvolt = <950000>;
>>  				regulator-ramp-delay = <12500>;
>> +				regulator-coupled-with = <&vdd_gpu_mem_s0>;
>> +				regulator-coupled-max-spread = <10000>;
>> 
>>  				regulator-state-mem {
>>  					regulator-off-in-suspend;
>> @@ -545,11 +555,15 @@ regulator-state-mem {
>> 
>>  			vdd_gpu_mem_s0: dcdc-reg5 {
>>  				regulator-name = "vdd_gpu_mem_s0";
>> +				/* regulator coupling requires always-on */
>> +				regulator-always-on;
>>  				regulator-boot-on;
>>  				regulator-enable-ramp-delay = <400>;
>>  				regulator-min-microvolt = <675000>;
>>  				regulator-max-microvolt = <950000>;
>>  				regulator-ramp-delay = <12500>;
>> +				regulator-coupled-with = <&vdd_gpu_s0>;
>> +				regulator-coupled-max-spread = <10000>;
>> 
>>  				regulator-state-mem {
>>  					regulator-off-in-suspend;
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

