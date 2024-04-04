Return-Path: <linux-kernel+bounces-130956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C2989811A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21AF328CE3B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 05:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8ED45945;
	Thu,  4 Apr 2024 05:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="sy+/1H0n"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C1222EE4;
	Thu,  4 Apr 2024 05:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712209883; cv=none; b=DRv1H71WAh+fi2uC7L+mKI7H7EO08Q+6F8gmi/fUN0y2fv4TPOKiD/doW/9LRJBrvzbat8t5Edt4xiEs1aL2jQ1cmFaUQgv8eFvPwTaR70SROX9KloSnlWMmpv8f87A8IlCkHrzGWVPHH0PPGBKQiFxFBXn18ChqlPzeMhUFG3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712209883; c=relaxed/simple;
	bh=Sif9OYlf7o5rH6HJtXnuHMHBMudAuoAS3AZeNXTSQtw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=NaQ1vxoa7ofSgVbSuSOJrXY+ytIrbjFYGr+HK8rOWAgC8XX+/gHv7PxpmkIzan0T8IPg32D9/hYjjSzVS5xnAmClrieiTwtF2gcIE2fJ/PK3YaILfdS7K7DsKIQVGhpwDSNoyw+EZy5mzjWnvFZZ3DAQbAFROQtZo6dRm01fjU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=sy+/1H0n; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 85509401B5;
	Thu,  4 Apr 2024 10:51:11 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1712209872; bh=Sif9OYlf7o5rH6HJtXnuHMHBMudAuoAS3AZeNXTSQtw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sy+/1H0n879DQFwK5S1aRcnxXOy2DLSnh/tFK9jJBtWM24ThNfJ6PCWtPW1mkNfrX
	 QXbDwL5A8nEbYD3zcH9daJozYZDxXHRuBWk5JTP32U5604DEQuIT/jzO60dYsSwNbl
	 pzMu6zV1kaQxhV//UGl7+NbaZJ+URfAlFk8Ta+kxrdEOQMshI7qu7+qC/yqOCW0i1V
	 s1MnD4gLsoCqROamEan3VLRXQiOAOMaexaQnqhqS+YFlToU9eiYzqqSpO7fD2uXtYU
	 8PAFV7maE3tP/vCswjxE3NTQtLmCtgdDXANhCQsQydVPqfWD1qw68hQSs2bmub8s8D
	 bBgnGS8Mk+LFw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 04 Apr 2024 10:51:10 +0500
From: Nikita Travkin <nikita@trvn.ru>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Raymond Hackley <raymondhackley@protonmail.com>,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Stephan Gerhold <stephan@gerhold.net>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, Joe Mason
 <buddyjojo06@outlook.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: msm8916-samsung-fortuna: Add
 touchscreen
In-Reply-To: <dyeqnhgvlzw44baihb257lhacei723iqoskthh2bjsfsgvxfrq@6hnk4f3ncsfl>
References: <20240312074536.62964-1-raymondhackley@protonmail.com>
 <dyeqnhgvlzw44baihb257lhacei723iqoskthh2bjsfsgvxfrq@6hnk4f3ncsfl>
Message-ID: <13170c97e7b84001da966ec06b62b002@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Bjorn Andersson писал(а) 03.04.2024 23:49:
> On Tue, Mar 12, 2024 at 07:45:42AM +0000, Raymond Hackley wrote:
>> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
> [..]
>> +&blsp_i2c5 {
>> +	status = "okay";
>> +
>> +	touchscreen: touchscreen@20 {
>> +		compatible = "zinitix,bt541";
>> +		reg = <0x20>;
>> +
>> +		interrupts-extended = <&tlmm 13 IRQ_TYPE_EDGE_FALLING>;
>> +
>> +		touchscreen-size-x = <540>;
>> +		touchscreen-size-y = <960>;
>> +
>> +		vcca-supply = <&reg_vdd_tsp_a>;
>> +		vdd-supply = <&pm8916_l6>;
>> +
>> +		pinctrl-0 = <&tsp_int_default>;
>> +		pinctrl-names = "default";
>> +
>> +		linux,keycodes = <KEY_APPSELECT KEY_BACK>;
> 
> linux,keycodes is not a valid property of zinitix,bt541 according to the
> DeviceTree binding. Is there a binding update for this somewhere?
> 

There is a series for this [1] that Dmitry seems to have no time to pick
up for a long while now, which we carry downstream. Without correct
touchkey definition the touch controller reassigns the tkey lanes to the
screen surface and display calibration breaks a bit, but since we don't
have the changes upstream for now, probably want to drop this line from
the submission so we don't introduce more dtbs_check warnings.

Nikita

[1] https://lore.kernel.org/r/20230801-zinitix-tkey-v4-0-b85526c5a474@trvn.ru/

> Regards,
> Bjorn

