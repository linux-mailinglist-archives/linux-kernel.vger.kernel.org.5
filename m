Return-Path: <linux-kernel+bounces-123106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 054D5890237
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF10C29513B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A0C12D745;
	Thu, 28 Mar 2024 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JTq25Hrs"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111F47D071
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637232; cv=none; b=cF4W8D4/tWTGFEm1OLKgZMXsXlK2XY+LMiw3QdakPjsAiIsBryqJBKxPRLVkAkikaTSgvk001xeor3lXEnQYQXj1lIm9TMzs3CS/cJeLqpxIZqhDeTu/8m5czjkQ4ugPktGnQpoVh34QoT8E3ykFPV9pfKCK8CR0cZ1y0E0HJls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637232; c=relaxed/simple;
	bh=n1HQmUHKBroyBMQujO5c42Joq0+GVgze8L6DxO1rOxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BoJz5zokHP7HL+bsScjviFR+QCbPM+GB2HGMdJxXTnaBsZbu44rVu3JbYwENfPGKqfCNqqPWDDAnVdDtOKeWOGBpC+/sqPUpS8YuF6ONHIu8zFflC3zYmpleOVS+eQwpH3qMilIhkoBzq/YiTPtgNPUi9PsxsZyZgONlcrltIMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JTq25Hrs; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a472f8c6a55so138143066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711637229; x=1712242029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NNfnpvUaxIjqgept1H9JPNTektamoKYhe963ZSnN0sA=;
        b=JTq25HrsN10vPk37dRcd0gbm0gnXNWCraKme9BVBd/h9uUer/TSWwk7DIovGnY0xSb
         4eaGG0eOZkZheGwI/iFL6rVDHCdnzu9gLxO7PE9Ns5poZ6vJZfCIhFGGWv++1HPmSjv+
         WAjuvsgmQACNZbAnSMnRvDw8NB2NYFAcWu57v7gz+V2kSYL3isT0uWxqTc/YLsoNkv/f
         pvF4bzQXVPBbg2dceoQqhNgybGTa25nyAwSQx9tqDuOmRrdIQH+PhLSG4JfG8cK8O+Y0
         zBT1eBQXPDxuP9mPxo+BAWs2h0bxQ8BPHsyB5uOXA0RasUSLmyNfnbEpaGMgaTLM9CDI
         T42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711637229; x=1712242029;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNfnpvUaxIjqgept1H9JPNTektamoKYhe963ZSnN0sA=;
        b=qmWsEc41XM6g8ufWZpn/QHYrsj4lP+fcVr5lRpbhsaehjLz5ohnh8sIngIop7cvsqD
         mksLENpR1iZ5kGcoG0jcFMiNhS5w31W1vM73elwseHIm3Ciq56qnhEcDocis43gQX84a
         h1AN/JgbZO66tvaWjHBCywGeKoSL1hgbYZveZIvtR6Sg8wIIHXAIkKbhueLVTwAWqLo0
         hZFal3goT4NVOWQrlgeQd9BOZ0+X2RgbhS/ob4JOmT11LDnNFdAybpmQTzeWlR1RthVO
         Ank90Y+q6hBVJXe+Yak1+J+uTHq1HWUqQU5YAoFuBRGi7HjgqOc9gpToViRaXhMopwOI
         Ps3w==
X-Forwarded-Encrypted: i=1; AJvYcCWD9dlLSLP4LvHjYSEfU9aMWke/8Y3sBx7jExp+oU+Ve+LmZKeg6syITPofjp4cI+B0gNwxZoDHEQuQxj4zr+2dhBF8JDd5XPHTkf8V
X-Gm-Message-State: AOJu0Yx/8UxeESjzq0T1dUL3AjOLxS8VYodFZhfEu2IyBqGsTS+/og9C
	mXI4DVyQyEOta3fGik5EQwnG0fqIsTLQwvNq8nJvY97+30HmPEfrx795YMbNJM9EW++HA14NO4u
	j
X-Google-Smtp-Source: AGHT+IFg5oo8KN4OdRQm06Vbk0P3S3xRqgJbhzWurMvglwATXbwqfiNl5OCap2pbOV3Zy/uJY0t09A==
X-Received: by 2002:a17:906:f888:b0:a47:535e:1dc2 with SMTP id lg8-20020a170906f88800b00a47535e1dc2mr1999654ejb.40.1711637229373;
        Thu, 28 Mar 2024 07:47:09 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id f6-20020a170906ef0600b00a46af0fbf5dsm821413ejs.103.2024.03.28.07.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 07:47:08 -0700 (PDT)
Message-ID: <8e09b779-a18f-46b4-926c-40e2a5782d85@linaro.org>
Date: Thu, 28 Mar 2024 15:47:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: arm: qcom: Add Samsung Galaxy Z Fold5
To: Alexandru Serdeliuc <serdeliuk@yahoo.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240328-dt-bindings-arm-qcom-add-support-for-samsung-galaxy-zfold5-v1-1-cb612e3ade18@yahoo.com>
 <ca4ed5e3-32ea-451a-82ca-25fba07877dc@linaro.org>
 <33e23d1c-5b6f-4111-9631-0f8db1100d0c@yahoo.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <33e23d1c-5b6f-4111-9631-0f8db1100d0c@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28.03.2024 3:42 PM, Alexandru Serdeliuc wrote:
> Hi Konrad,
> 
> 
> Thanks, yes, I am new to b4 and sending patches, in a few minutes I will add the second patch.
> 
> That actually add the device tree, but  without the previous patch it showed me a warning, and with both patches provided another  warning that i need to split them in two.

Oh no, you should send them together! Could you please paste the warning so that
we can work out the issue?

Konrad

