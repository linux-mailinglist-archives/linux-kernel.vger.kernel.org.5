Return-Path: <linux-kernel+bounces-38904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADB083C82F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C775CB22D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDE212FF97;
	Thu, 25 Jan 2024 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M+kSoDQ2"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90036129A73
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200573; cv=none; b=Ee0xdo2efyfC9SFcuXlh7KWqG3FayHH4byPspR/FmtJkiN0L4Z3ZXna8Mp4lG2ejFWzWiNfKtTLlIj7Nfv4npbB3jazGYZUP76YbFviC7y5QtT+gINcCmC86OxVIQh8le3VXORmxdcb+7HSp6VA9uEgvDBYzAa2qWF+NfnksX6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200573; c=relaxed/simple;
	bh=lt40wahOJSZn/bRu/spTVg3+z5XWb676wGctXtgvtfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kiCXntxBv0N98y39PO7vj1dAvhZpY/vS0QY2jpaRMMft2TlZtHCnjMZ5pg/524LiJ55+TjUkLue9TR29XQX1proJfFJxabyba8a3MT3uOKpAwBdOXeojhMqUGyBORMN/xrntO9GjZefIgVxVTVqLAtdOq5nuLUDidUCq3lxMKjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M+kSoDQ2; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-510221ab3ebso345742e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706200569; x=1706805369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mOhc9njMffkxNYdD1egZdDRcjEt1wn9p6obVt9P775E=;
        b=M+kSoDQ282YgxrHH4Vz1Qd+BmfDqAAf05avIFKL8CF+oE7vLHFKSde+NEuV7Cz126U
         HsWqWTd7aj0H/mfQKbMaGyglxzv2a7qSsjxYkvflNZR9NHsS64Zgz7sIOF8wRvOty0vR
         d84i056q3+ieFZDTcf4wFdqwlIPLgOQ9Y2B0xdns85bd4vTsHLaMf5GznNjhHbmg9D/p
         gZXCJKUh6CzAXPWVQlomHv/9E2q3k6gSIuQDGesvCZihX3GvXfXf/+SxeV0VeJQv4jWV
         dDNoIH5Or2sEcAbqUpAk8yrIHRZ6H+IZWj4tRU0PIqOn5zrlrRj4brJJ4OshvYr1m8JW
         AMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706200569; x=1706805369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOhc9njMffkxNYdD1egZdDRcjEt1wn9p6obVt9P775E=;
        b=jepe2ybGRfJlPiikn+IGtpXB74ZQx6yFINTd/Yrf0xG/kpxQNzogqjlK0SgdzJIc11
         4p+UylPVqgaFsjA+1YveqgnoUpW9dg2hWBQRchMaQAEt9A3me/rxn5erZFDKiN+fsXCA
         g8kmCnptjXiw5NnbntwjRsg/VCEIysybVtzvnKMOqPcTa1VLAdk7UoV6g8+cQMtgLeJU
         f3erwRfY0l8HfOM43dPP5zm6V84jWaIQQ3p3s5ZLmDqPNpgKQWU4HWpcF0I2lbHp+KAR
         fOwbr/ZwPuk85w5NIbP1zV2f6XgrzsMRTOcVGd0AHnQPjR2757hoWKiMk8Rv8KJJUVg1
         BXnQ==
X-Gm-Message-State: AOJu0YxwEdXirrDAfzOFXiX6LR42nl+hYJGgi6TZNrG0cIgNiGICxRdu
	ApQqzsODitsAv1r4w+qVaBqP90DRsOXP6bX7bqVipqN+r513Cn4y77oZPUVg1fw=
X-Google-Smtp-Source: AGHT+IFMO+xoeC65I4slZOzO2IxFMLHMXEpO8c2Ds1GdTTlBycdyA02BYh1cW1xcPHtk0iX3z7de2g==
X-Received: by 2002:a05:6512:ba5:b0:510:135c:c060 with SMTP id b37-20020a0565120ba500b00510135cc060mr38059lfv.76.1706200569551;
        Thu, 25 Jan 2024 08:36:09 -0800 (PST)
Received: from [172.30.205.155] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id b30-20020a056512025e00b0050e7f5cffa6sm2904066lfo.273.2024.01.25.08.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 08:36:09 -0800 (PST)
Message-ID: <0ba94f0f-3df5-4eaf-a88c-c63aebff4232@linaro.org>
Date: Thu, 25 Jan 2024 17:36:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] phy: qcom: edp: Add support for DT phy mode
 configuration
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan@kernel.org>,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20231219-x1e80100-phy-edp-compatible-refactor-v1-0-f9e77752953d@linaro.org>
 <CAA8EJpr8rKMBzcm-=HGu7-C5hPkNMrnG1cA78O00UjgJVT7p6Q@mail.gmail.com>
 <6179e3c7-f399-4b0f-abb0-aaf5e549d8d9@linaro.org>
 <ZaUASV+0gc/Bufmw@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZaUASV+0gc/Bufmw@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/15/24 10:52, Abel Vesa wrote:
> On 24-01-03 14:42:49, Konrad Dybcio wrote:
>> On 21.12.2023 17:27, Dmitry Baryshkov wrote:
>>> On Tue, 19 Dec 2023 at 22:55, Abel Vesa <abel.vesa@linaro.org> wrote:
>>>>
>>>> Until now, all platform that supported both eDP and DP had different
>>>> compatibles for each mode. Using different compatibles for basically
>>>> the same IP block but for a different configuration is bad way all
>>>> around. There is a new compute platform from Qualcomm that supports
>>>> both eDP and DP with the same PHY. So instead of following the old
>>>> method, we should allow the mode to be configured from devicetree.
>>>>
>>>> There has been an off-list discussion on what would be the right way
>>>> to pass on the PHY mode information to the driver and it has been
>>>> concluded that phy-cells is the way to go. This means that basically
>>>> the controller will pass another value (that is, the PHY type) to
>>>> its 'phys' DT property.
>>>>
>>>> For this, we need both the bindings value and the PHY mode value to be
>>>> added as well.
>>>>
>>>> The controller part will follow shortly. But for now, lets see where
>>>> this is going.
>>>>
>>>> There has been another attempt at this here:
>>>> https://lore.kernel.org/all/20231122-phy-qualcomm-edp-x1e80100-v3-3-576fc4e9559d@linaro.org/
>>>>
>>>> Compared to that version, this one uses the phy-cells method and drops
>>>> the X1E80100 support. The X1E80100 support will be a separate patchset.
>>>
>>> After several back and forth discussions, I think that this approach
>>> is not correct and not that easy to extend. Instead I'd like to
>>> suggest adding a property to the DP controller, which enables eDP
>>> behaviour (and thus makes DP driver call phy_set_mode()). Something
>>> like this:
>>> dp: displayport-controller@ae0000 {
>>>      compatible = "qcom,sm8000-dp";
>>>      /* reg, interrupts, etc */
>>>     edp-interface;
>>>     /* or simpler */
>>>     is-edp;
>>> };
>>>
>>> What do you think?
>>
>> Please excuse my alzheimer, but why did we not go with phy-type after
>> the last discussion?
> 
> phy-type would be a property of the phy. That way we would need pass
> the mode to the controller. So it was concluded that passing that
> information from the controller via phy_set_mode is more straightforward.

Eeh, reluctantly, I'm gonna say yes. It's not the prettiest solution,
but none of the ones I can think of seem much better.

Konrad

