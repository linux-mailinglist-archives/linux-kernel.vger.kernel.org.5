Return-Path: <linux-kernel+bounces-80221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B94862C34
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81E6CB210ED
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355E618637;
	Sun, 25 Feb 2024 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wu05TE0Y"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1E917756;
	Sun, 25 Feb 2024 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708880983; cv=none; b=APW012DDKAaJ1ejGCf5eXYKMXNiYVqsY60s0KnyCbRUdADnNeBO7LYD7w/AU9PIHT8C5S1yXjl/j6b9PvqilaBGXqarPWw3n97C6m3Z4SfB6wZTul2TI+2hGBYvw9FOMt6OgeU69/GDEuBJWq5+ydIPiFXeWwDdkQnV7520TiUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708880983; c=relaxed/simple;
	bh=AuzeUpAuvt0i584TLDXKXK/SGBp3CXpbKtMT3HhI5CU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0f9yap/3pCBKaXJW7E20j/r9/fL2wMGerxetRTVPdCZVdikfUjoZejKXGJIqpvmuF3m3SQ6VQ1jN1nIUsG7FqFaHd/t3O1WCilHhjBUE9BqTVsx0LUPh4eYTnzKKnU/+462MIF5rxbuVg675k42D1z99XtIBGxd/GO6JktO1Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wu05TE0Y; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so376619566b.2;
        Sun, 25 Feb 2024 09:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708880978; x=1709485778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kkn6pd7i45J0ICc+RJDxPZ9ytlkUDwXcvF4anYGRf8c=;
        b=Wu05TE0Y79et+4vYhxEucbG5Gbdbqn6++DlKcDrhNISrLp3imRVkSSv5yunySHyaP2
         mBes0RuNpsE72uxiTTKjBccQi0DJWmCXSX3VRxuYZ350eJiTAbRin6GeSCUv1SQdmAhs
         utjPbYvTLdZ30yS1A1diFoZoVs47NIOSMz2Shf+ZgdS9QbPilj9nwNp2ASal1xFiwBV9
         0aparemQxMLmFnaoTn6kK6mvyqhTjOHLvO6zxqtTWSYwi7q+s8lfJY3XzSeh1JYS/qhN
         22EGwY3mgvpYFIuZCvFc9Kup39ChIVUnJ/vGxy3JYMlY7f4eqTrqpzQNtBG5NzDlkcNg
         lUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708880978; x=1709485778;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kkn6pd7i45J0ICc+RJDxPZ9ytlkUDwXcvF4anYGRf8c=;
        b=vTt1XbgBhowT+z1hZzoLuREFm3w9Gu+HYp25JyKXJ800FYOwVL3/7OEGG2hWpRzd9C
         88ovl08ISpdwPYchgzmw8zKQvB6n6M8ahfzMNPgX4dgHdqWWSX6VGBX5KjGfCB2++Gd0
         4ePv6eI55fPciaoq3licHHp12kpxnErfiAOCYI32gmxi3XyHqDJj/3lsycL+J1SLoCGl
         GCK0GxUj1tX6aLN047gF1d85e0WP+8XFFYSLjwe84rtJj5Gsp7VwjicpDbADWeVKlfh3
         9nN/IqPY+EX5KDTiEfO5bJ1AYrHEtaYq7Xt107+pFhBnDsCv8FRy4qg/IpYA0cE8Q+FJ
         JOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoJnjB7oQMShigiTDm+s6z2WlXY6QttZRHwqaptGaTk8V3rvJHi9SDJ/kKePWUG+FXcghFauNLFFG4aRoKFYpIcT5Mk0vOn65KHw8Q6pSnOm7FDMXQLM/lG6++vw9c5G3G8rKB7xzfPA==
X-Gm-Message-State: AOJu0Yx+MI2wG7MgJ1xNVF5jxJtXpfdKBBrVwmxQtdBoKQfzBv7a2/Rx
	lbEeQbELGuRGYzUoukyu4Dwe/UDoAdI+o3mRXGTLE4QOK09b23GN
X-Google-Smtp-Source: AGHT+IGszEAq6BHv80snpKx/oNaWod/Norc7ugu9RaQQjfW1h7yVcb61ikCupAMtWez9i6TQpfioDQ==
X-Received: by 2002:a17:906:3653:b0:a3e:9df6:7f0a with SMTP id r19-20020a170906365300b00a3e9df67f0amr3589352ejb.68.1708880978429;
        Sun, 25 Feb 2024 09:09:38 -0800 (PST)
Received: from [192.168.20.170] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.gmail.com with ESMTPSA id jw4-20020a17090776a400b00a434cae86ebsm187939ejc.219.2024.02.25.09.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 09:09:37 -0800 (PST)
Message-ID: <c5556062-1761-48ae-a028-6180637f9cc7@gmail.com>
Date: Sun, 25 Feb 2024 18:09:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: add TP-Link Archer AX55 v1
Content-Language: hu
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240223-archer-ax55-v1-v1-0-99f8fa2c3858@gmail.com>
 <20240223-archer-ax55-v1-v1-2-99f8fa2c3858@gmail.com>
 <fb14acfa-5b43-4ce7-93f4-9f6681152ca7@linaro.org>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <fb14acfa-5b43-4ce7-93f4-9f6681152ca7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

> On 23/02/2024 09:17, Gabor Juhos wrote:

<snip>

>> ---
>> Note: running 'make CHECK_DTBS=y qcom/ipq5018-tplink-archer-ax55-v1.dtb'
>> shows the following:
>>
>>     DTC_CHK arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb
>>   <...>/arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupts: [[0, 62, 4]] is too short
>>   	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
>>   <...>/arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupt-names: ['hs_phy_irq'] is too short
>>   	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
>>   <...>/arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupts: [[0, 62, 4]] is too short
>>   	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
>>   <...>/arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupt-names:0: 'pwr_event' was expected
>>   	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
>>   <...>/arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupt-names: ['hs_phy_irq'] is too short
>>   	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
>>
>> This is not caused by the new device tree per se but comes from
>> the usb@8af8800 node defined in ipq5018.dtsi. Running the check
>> on 'qcom/ipq5018-rdp432-c2.dtb' shows the same.
> 
> Thanks for noticing and describing. Appreciated!

FWIW, I have checked that in the meantime. The warning happens since commit
53c6d854be4e ("dt-bindings: usb: dwc3: Clean up hs_phy_irq in binding").
Reverting that eliminates the warning.

> 
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile                  |   1 +
>>  .../dts/qcom/ipq5018-tplink-archer-ax55-v1.dts     | 133 +++++++++++++++++++++
>>  2 files changed, 134 insertions(+)
> 
> ...

<snip>

>> +
>> +&tlmm {
>> +	button_pins: button-pins-state {
>> +		pins = "gpio25", "gpio31";
>> +		bias-pull-up;
>> +		drive-strength = <8>;
>> +		function = "gpio";
> 
> Usually we keep 'function' as second property, after 'pins', but there
> is no need to send new version just for that.

Sorry, it is my fault. I should have noticed that pattern based on the other dts
files. Nevertheless, I can send a v2 or a follow-up patch to fix the ordering so
we can avoid having a bad example in the tree.

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thank you for the review!

Regards,
Gabor

