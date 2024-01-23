Return-Path: <linux-kernel+bounces-35824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5407B8396FF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8309AB26C03
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCA181203;
	Tue, 23 Jan 2024 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rHAuPwn5"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1368005F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032433; cv=none; b=daZgnRZFtN16bugutmc8bfti89ltr70kMK2RFaCPX6kR72EkANLE2rilBJqTDVIEO1N48/FK0c+s6VXXS6K1iVsjyBMgSFp6ySKO2prEv1Zo/Py3AnnBM9jhIaLjX74tNZ4DQslktXQs47UZ3hgoslwi2exGHmsInmaUJCn55Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032433; c=relaxed/simple;
	bh=wVl9haQVCPWB5lzRPA2n7zxH/Rd+6wdBvfdx8WKhjak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eIY6kBM5VH1RudlCc+VmGjTv8vdjb8Nz9Gn5OLD4CRu3mex7OwEckJywEp5k+YV5oM3TRyQkV/rP34zySHXR8xcrH+7+1iyvbsAl4R5n7hTjgl9VtBx5MCyVNJFN8uDH00R1j/zri1iZL9eCFrIC/rETKhaiNFQs4E110m8emdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rHAuPwn5; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5100c3f7df1so692850e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706032430; x=1706637230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Imf394kL4Iql2UnZew/bvNix8nVGsR4OQhBljRFX9lY=;
        b=rHAuPwn5keRFL8donQq8pdtoArJ8fORsMAgqzxDMHzPIb3JratuJRj+bXCX6aJ0yMp
         1sSCjwnN/SNUa1OarpOsiVnYy2i4b5nbgt1yq9yiwpWUxjYvgM659VXwNO/wM9nKr6N5
         qtLN/6SDUKzDkLRJiuIPvNIa92kgj0QcXDucX2RQdagdxlt35kd9tQxFXnt0zIkbIoTn
         gy5ntwSMXRlpVQIzWgDbt1Mw3ljvEnbqbxR+s0HwX5XV8PZQxc04WuT2LFiUR9VJMc3l
         FmXQ/juP6fPUzpLq0KVjJf0vsR4BsAMoilS7HrQKsg9aZO2hzYFhcD4xi1BAes+KOlU1
         PYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706032430; x=1706637230;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Imf394kL4Iql2UnZew/bvNix8nVGsR4OQhBljRFX9lY=;
        b=TY3N4mQ7+rabQepAc1z5xtIIchUtiRV14Nw30B5c4w0YM8KEY3/nKiSXQoF5NRSL3r
         pQy3r4Ju7eO4a+cb/KiJDPGmUWnb07f1rkdcq4wgvrkH2IUQpzVzB8ygm40ZWz8urI/e
         iaNvclKwBkj2ifdAa766pims2cmljX7GRJE97jphchAvzELE9tV9Uvyfwjc14Q3ZsTUh
         L+oQdbbsuYdNC8QpexMCEFpbUzMhv/6HGaud8pQuACW4hJJ8KoBBMrq06WATHoKh1ml7
         3UPWMsbo8Ta7UByVLJbT/S/ZqmjCsofuE4qf6DQAOzbiMZNBSb2eomsguOBJnTl+q3ZH
         OOfg==
X-Gm-Message-State: AOJu0YwYbADH3BmYf/5xHBA1eNZUG1XtmmN0T4azdlsY32XMHf6/GfwC
	TSWf5AtfDP7CAGUTbk/Ux6EQkfy2cC9NhmwkCVyZY/ExNr8Cw5ATz7iRsZksNSSlm4WtOUo2+Gd
	m
X-Google-Smtp-Source: AGHT+IGlQzLHPjyad4jSTiFUwQ+wUYXFN3+pN1AE8D9XlERsL+T/vi018ZC8BpzsZPiA/qSmqxjbBQ==
X-Received: by 2002:a05:6512:1082:b0:50e:c845:5be6 with SMTP id j2-20020a056512108200b0050ec8455be6mr3479727lfg.107.1706032429896;
        Tue, 23 Jan 2024 09:53:49 -0800 (PST)
Received: from [172.30.205.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id j6-20020ac253a6000000b005100c529020sm100704lfh.6.2024.01.23.09.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 09:53:49 -0800 (PST)
Message-ID: <b7e91951-e554-4baf-9b8d-fca4a2f0d412@linaro.org>
Date: Tue, 23 Jan 2024 18:53:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] power: supply: qcom_battmgr: Ignore notifications
 before initialization
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel
 <sre@kernel.org>, Marijn Suijten <marijn.suijten@somainline.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xilin Wu <wuxilin123@gmail.com>
References: <20240103-topic-battmgr2-v2-1-c07b9206a2a5@linaro.org>
 <Za_iR0ctkgYO0W5L@hovoldconsulting.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <Za_iR0ctkgYO0W5L@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/23/24 16:59, Johan Hovold wrote:
> On Wed, Jan 03, 2024 at 01:36:08PM +0100, Konrad Dybcio wrote:
>> Commit b43f7ddc2b7a ("power: supply: qcom_battmgr: Register the power
>> supplies after PDR is up") moved the devm_power_supply_register() calls
>> so that the power supply devices are not registered before we go through
>> the entire initialization sequence (power up the ADSP remote processor,
>> wait for it to come online, coordinate with userspace..).
>>
>> Some firmware versions (e.g. on SM8550) seem to leave battmgr at least
>> partly initialized when exiting the bootloader and loading Linux. Check
>> if the power supply devices are registered before consuming the battmgr
>> notifications.
> 
> So this clearly was not tested properly as the offending commit breaks
> both the Lenovo ThinkPad X13s and the SC8280XP CRD.
> 
> I spent some time this afternoon tracking down and considering the best
> way to address this before I checked lore and found this proposed fix
> (why was I not CCed?).

I didn't give the offending commit a spin on the laptops, as I simply
assumed the interface is generic enough to behave similarly across the
platforms. With this, I didn't imagine the DSP firmwares aren't unloaded
on these..

[...]

> 
>> +	if (!battmgr->bat_psy)
>> +		return;
> 
> This is not a proper fix. You register 3-4 class devices and only check
> one. Even if your checked the last one, there's no locking or barriers
> in place to prevent this from breaking.
> 
> Deferred registration of the class devices also risks missing
> notifications as you'll be spending time on registration after the
> service has gone live.
> 
> I'm sure all of this can be handled but as it is non-trivial and the
> motivation for the offending commit is questionable to begin with, I
> suggest reverting for now.
> 
> I'll send a revert for Sebastian to consider.

What you're saying is valid, but a "battery" device is always expected
to be present. If devm_power_supply_register fails, things would go very
south very fast anyway. I personally don't see this being a terribly bad
fix, but I'm open to different propositions.

Konrad

