Return-Path: <linux-kernel+bounces-14169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1F28218B0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8831C21738
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF7563A9;
	Tue,  2 Jan 2024 09:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="P94UWCDe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17B4568C;
	Tue,  2 Jan 2024 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704186572;
	bh=0IJc2UOGZ6oMEAmRyC8mL1X+nZIu6VgIRz8xHSvM2KI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P94UWCDeEk5DKNB6KMkv3dEvRD8cI6BmKuy/6krHuaJB+1o+zwQoDoGEVvPdZdaaD
	 8VcqkRQfLaqEvHgRFs7agU3FTdKAfkJlamVTamOQVIwdt3uSITjLpAetWlPu80wFZf
	 uehhpHxvakYiX8ZVTA1yaTuC+CnAk83nY9E6433BXB/8Dj76LWc+nBQLEpnvdL5FFT
	 3jCWAxT7A9JLv4GDNjxCiZ6usIkmyBpWZEdnPCvRwBIpdEYsPeyeyrZd+Wafw3eb3T
	 Fjk8QOqTY53UaB+3ahZDRfpHG77yfGQfiQNVSI+HHhO2EY4wYIXPvZ5runNQEXVMxp
	 B0uah6DH1q7vg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4C3C237804B2;
	Tue,  2 Jan 2024 09:09:31 +0000 (UTC)
Message-ID: <a288d5c8-6eb9-49f8-bcbc-f2b41e51c797@collabora.com>
Date: Tue, 2 Jan 2024 10:09:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: cherry: Add CPU supply
 dependency to cpufreq-hw
To: Viresh Kumar <viresh.kumar@linaro.org>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, kernel@collabora.com,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20231229212853.277334-1-nfraprado@collabora.com>
 <20231229212853.277334-2-nfraprado@collabora.com>
 <20240102061123.frvwltggqqh6m7pm@vireshk-i7>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240102061123.frvwltggqqh6m7pm@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/01/24 07:11, Viresh Kumar ha scritto:
> On 29-12-23, 18:28, Nícolas F. R. A. Prado wrote:
>> When the mediatek-cpufreq-hw driver enables the hardware (by
>> writing to REG_FREQ_ENABLE), if the regulator supplying the voltage to
>> the big CPUs hasn't probed yet, the platform hangs shortly after and
>> "rcu: INFO: rcu_preempt detected stalls on CPUs/tasks" are printed in
>> the log.
>>
>> To prevent this from happening, describe the big CPUs regulator in the
>> performance-controller DT node, so that devlink ensures the regulator
>> has been probed and configured before the frequency scaling hardware is
>> probed and enabled.
>>
>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>
>> ---
>>
>>   arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>> index dd5b89b73190..505da60eee90 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>> @@ -502,6 +502,10 @@ &pcie1 {
>>   	pinctrl-0 = <&pcie1_pins_default>;
>>   };
>>   
>> +&performance {
>> +	big-cpus-supply = <&mt6315_6_vbuck1>;
>> +};
>> +
>>   &pio {
>>   	mediatek,rsel-resistance-in-si-unit;
>>   	pinctrl-names = "default";
> 
> I think the regulator needs to be mentioned in the CPU's node and not
> here ?
> 

Even if the regulator voltage is being changed by firmware with cpufreq-hw, the
actual regulators should go to each CPU node and not in the cpufreq driver node,
I agree with Viresh.

Besides, that's the same thing that we're doing with mediatek-cpufreq as well...
and since we're talking about that, we should also do something about this such
that we stop declaring `regulator-always-on` for CPU cores in devicetree, but
this is probably slightly out of context for what you're trying to do here, so,
read that as an "extra consideration" :-)

Cheers,
Angelo

