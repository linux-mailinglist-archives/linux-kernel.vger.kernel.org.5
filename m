Return-Path: <linux-kernel+bounces-156941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A37A78B0AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32BD21F22161
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A5115B550;
	Wed, 24 Apr 2024 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="c4Kfk2PD"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3CF15A49B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964564; cv=none; b=khWcQJtKwmarynSYSjYWd26/WT3OC3ei+TsCfyTLSooRWS7Keqts9cr650IYHYpabOszkpywprNQXP5DUA6xGfmIhIvXR1bIimXGXSb1K27hEC30EsTDeoBmdDuBDoFLV6N4CW44Aew+zW7EOojbnR6y+rGG925XDyaiB6yo4o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964564; c=relaxed/simple;
	bh=dHuz5newU0/QKNz5ikSXq9/zcX9MSEVDI0HnDyHzSy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sk66ZxrtWVyBzn0tbdVbJA3zzycUHnsqbHA1M2GIm5lwaaPkJlUdEfjFrn/kTEwrr7agxx+nMG2fxkfcvf82WB1Epo+gLtO/hhdwuZArdU+nzMd38qwX9wSCK+oZ9/F2jlYAMLo9CllcaWNUHawssBiTXu+3eF7x8Y8FZ00IjqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=c4Kfk2PD; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a2d0ca3c92so700485a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713964562; x=1714569362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xx8lMzPD+ezD4WFckZUVYGiHQFKa0kwuRk0nIxWq0b4=;
        b=c4Kfk2PDxCYn3cS4Mm3u6L6eYvnlyWkjjNuF8GGP9K3oLt11isyE0pD0VN0ik2i+gk
         uqZAppn5jnYxPyNnZDwwhrFpsfQf8Nt3NyGxO3fcTrc/3pWFa/YO8V5i2e6WV9L6Dseu
         p97ZD377S2CVjHgie8/QoTFsWnmUHcp+klr9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713964562; x=1714569362;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xx8lMzPD+ezD4WFckZUVYGiHQFKa0kwuRk0nIxWq0b4=;
        b=t7qTeb4GCKqU/xEdZV1rbUxQdH4xup4ihq5bLFfjg1IO4MS1RVRyaQPfpsX+Xn+k7g
         e3prxYU37W+rvgJghdqxtQC+Os+b6vR3m42C3Mf2XATS5Qbd1MQ/DIoS6i3C1IuvvZj7
         XU85oalraKxVFL2MtDtbgWmygqqahprZG+dT2zfsO4JEzAuhLwDQIYOQob2xCK0NkZpH
         rMkypMC0ofQpyDoUXeGUrXR37ufC4DEGaTINZmQtL92j9velhVKVzhwfFhe8OTLmRBKa
         VOYdmfK/S1D6w2rGPkmOiruqTvi3YFKM7ZVl99f/aXNQOwmbxC/iJy5vqrI3iG2pZGry
         UBlw==
X-Forwarded-Encrypted: i=1; AJvYcCUSoHfYmMDLuVpa3vKVR1zasViLG6qg4v5Je/LBMKTQM/SQ3zqncIxbgZUkoB0UsHHjx9g1RNxZW2Mby/Z3jiZi6op0gCvsw5X03yf5
X-Gm-Message-State: AOJu0Yxh64GVx6SvAJBTcmTpOSX70icEiUBJ18VS1QIIVkksHwrwxXd1
	Eayw8XKxxGicSRjqgWPwi0+VOIz2Qoac/vyAbXOCJ4weSQnIJe8TPUIlVQ4IEO3gZo1hwaJUsMB
	7dZir
X-Google-Smtp-Source: AGHT+IFvzEu80M3sDrVOmnHmXcdn0Kg8OjgB1H7ed8BR+tNHHseuHMOtVLXvFra8skdJeVWfcFww3A==
X-Received: by 2002:a17:90a:f086:b0:2a4:79ef:4973 with SMTP id cn6-20020a17090af08600b002a479ef4973mr7470114pjb.14.1713964562225;
        Wed, 24 Apr 2024 06:16:02 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id c6-20020a633506000000b005f034b4d123sm9158113pga.24.2024.04.24.06.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 06:16:00 -0700 (PDT)
Message-ID: <98a6bed6-98d5-4db4-ba74-44a47b90d381@penguintechs.org>
Date: Wed, 24 Apr 2024 06:15:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL
 returned by gpiod_get_optional()
Content-Language: en-US
To: quic_zijuhu <quic_zijuhu@quicinc.com>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240424122932.79120-1-brgl@bgdev.pl>
 <2d3823bd-bc30-4e3f-a350-eb9a718261aa@quicinc.com>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <2d3823bd-bc30-4e3f-a350-eb9a718261aa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/24 5:59 AM, quic_zijuhu wrote:
> On 4/24/2024 8:29 PM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> Any return value from gpiod_get_optional() other than a pointer to a
>> GPIO descriptor or a NULL-pointer is an error and the driver should
>> abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_qca:
>> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
>> power_ctrl_enabled on NULL-pointer returned by
>> devm_gpiod_get_optional(). Restore this behavior but bail-out on errors.
>> While at it: also bail-out on error returned when trying to get the
>> "swctrl" GPIO.
>>
>> Reported-by: Wren Turkal <wt@penguintechs.org>
>> Reported-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> Closes: https://lore.kernel.org/linux-bluetooth/1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com/
>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> is it really reviewed-by Krzysztof?
> suggest reviewer give explicit review-by tag by public way, then you add
> this tag.
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> ---
>> v1 -> v2:
>> - also restore the previous behavior for QCA6390 and other models that
>>    fall under the default: label in the affected switch case
>> - bail-out on errors when getting the swctrl GPIO too
>>
>>   drivers/bluetooth/hci_qca.c | 18 +++++++++++++-----
>>   1 file changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 92fa20f5ac7d..0e98ad2c0c9d 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -2327,16 +2327,21 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>   		    (data->soc_type == QCA_WCN6750 ||
>>   		     data->soc_type == QCA_WCN6855)) {
>>   			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
>> -			power_ctrl_enabled = false;
>> +
> think about what will happen for present lunched products if this type
> error really happens.
> BT don't work at all with your change. BT can be used mostly without
> your change.
> 			return PTR_ERR(qcadev->bt_en);
>>   		}
>>   
>> +		if (!qcadev->bt_en)
>> +			power_ctrl_enabled = false;
>> +
> you don't answer me how to treat a required enable is not configured by user
>>   		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
>>   					       GPIOD_IN);
>>   		if (IS_ERR(qcadev->sw_ctrl) &&
>>   		    (data->soc_type == QCA_WCN6750 ||
>>   		     data->soc_type == QCA_WCN6855 ||
>> -		     data->soc_type == QCA_WCN7850))
>> -			dev_warn(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
>> +		     data->soc_type == QCA_WCN7850)) {
>> +			dev_err(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
>> +			return PTR_ERR(qcadev->sw_ctrl);have the same question as above.
>> +		}
>>   
>>   		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
>>   		if (IS_ERR(qcadev->susclk)) {
>> @@ -2355,10 +2360,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>   		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>   					       GPIOD_OUT_LOW);
>>   		if (IS_ERR(qcadev->bt_en)) {
>> -			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>> -			power_ctrl_enabled = false;
>> +			dev_err(&serdev->dev, "failed to acquire enable gpio\n");
>> +			return PTR_ERR(qcadev->bt_en);
>>   		}
>>
> have the same question as above.
> is it right for such prompt ?
>> +		if (!qcadev->bt_en)
>> +			power_ctrl_enabled = false;
>> +
>>   		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
>>   		if (IS_ERR(qcadev->susclk)) {
>>   			dev_warn(&serdev->dev, "failed to acquire clk\n");
> have the same question as above.
> 
> how do you known the root cause of the issue reported without my earlier
> debugging and fix?

Without your debugging, this fix would not have been possible.

> 
> do my fix regarding the issue i concerned have any  fault?
> 
> NAK by me.
> 
> 
> 
> 

-- 
You're more amazing than you think!

