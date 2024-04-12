Return-Path: <linux-kernel+bounces-142021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 277588A264A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED362874C8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698EF1CAA1;
	Fri, 12 Apr 2024 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J6hvoMNg"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B011B974
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712902502; cv=none; b=cNgxybctpOxtmQdOji5pLxoW0MeUzOL2q2Fn83kY/+eXJ/8cb+ghRtLmjZQf+wA5Ei1hQeoDwqsc66fru1LiKIjPsSFWJCU/hmYoDYVqUMvElbshJNuxsUSzzv/aNkNjpVhE8OtCG34/Yl6oX9DasLJaQgsPircBfzMcm6W55s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712902502; c=relaxed/simple;
	bh=C2/Qifp2Owgqs6DtAzOflUaj93zlu3fCA+TJTCNZpz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmiQPD/BUHpNRmtapFOmY36dSDC+AIIFn5XTG7kg41n7j9Kd5cFclFhq0w6un86hi3FF1WUNHrCwzIwZV80JSU/Y4X1z3JiPN9/VN2JmnpKou3ysZ7Zbla4ly3hEaToSMTGqvrvr7x0/3gZPBzFXkXqCILMaEUMKm3uV0/motWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J6hvoMNg; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4715991c32so55282866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 23:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712902499; x=1713507299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gCI29F9l9L/J/kvbB2pgzrjxGLikqEacFr/Q/WRo0Ls=;
        b=J6hvoMNgpxmQUH9LPS0I0gGBHNWR2n6rW8oj2s+exFVv2upCm7K2RnU1RefyNVhddH
         gCcadaRMO0JIkA1JePaih772z/kUDWDvXnoxP7SNIpkiRyoxO40leh2UrfVRY7vDeYnK
         p29f7V/2d5KD9OqAys+yFTADIm/RlO9d7rYIJ/AujoUx3if/v0PkHUKD0Zv/cw1cmyok
         md3CcgCvEBnRwhfCf/Sk6JMhq0x+7yKoSPUh7V/yJibcZ+EV+OHReGwBHvejNpoNSyZg
         Q/U6PWMC5Y9G+lpnABCvsnZvm5RVrrE+kSeVkZHnUZYIv8qG/aDLQ4mKa3Kxy8c2o/Wx
         vMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712902499; x=1713507299;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCI29F9l9L/J/kvbB2pgzrjxGLikqEacFr/Q/WRo0Ls=;
        b=BKINzuNmqK4jOtEQSaf33UZnR5Dhv3I8XZ4fKlg14UkAv3pi5bXwnq0PWhZ4cTD0yu
         KjWymQSdcTzMsLxpPuborcEWqYyFZQBQWD2ep9ZjhWC96vE0Ba/hiqDOevzRGTcX8l/f
         3qiaQcjCulLB1OWTTTx9kBCJU9CZQiaf0NbfM5/59RAOqyI4BSTcEbzEt/TqOXxc78kn
         eGi9h9JPrNF/Br8j+R+Ftx4vRXcJq7YOlBOiviSW680dB5ur5Kq9jnTm6MBC+/JAC+OR
         OoznCGI9AU9jlBaH2KjWhnUtur/pJHal1hzF2YOvLXHq7JMgCAXGuQEOwx4Qyut9+9OG
         p78Q==
X-Forwarded-Encrypted: i=1; AJvYcCWf5YJzYESClfMn6Mj1n+W4q8j4rX+QW2EkVbwWwrWj75jKHR3UHsftpBHQ83JGhIzC2cV2ZT5R+yWxo0zFgCS7IaZiYk/aV+PZ2eab
X-Gm-Message-State: AOJu0Ywnsu6TeafSSS7I6iPgEvQWsM1UV2DTWfPc/D2QRBdFDyongrHn
	QkC94kkEEk9VWssliKtQ+WJ5D3tGlFGR79z/8gvH635KOSf1jdgJyqUwy0b/cIA=
X-Google-Smtp-Source: AGHT+IH97vMPW1J5aDomYm9r8ce7blRXlavje7fO6005bjr9oXC8oW/tdVp3ZX8RFok8YmF09aQJpw==
X-Received: by 2002:a17:906:4086:b0:a51:df52:5a65 with SMTP id u6-20020a170906408600b00a51df525a65mr1117508ejj.2.1712902499387;
        Thu, 11 Apr 2024 23:14:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id g5-20020a170906c18500b00a522f6fea95sm612736ejz.223.2024.04.11.23.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 23:14:58 -0700 (PDT)
Message-ID: <38b7d40d-bdd0-4263-9996-2c9f7715aca2@linaro.org>
Date: Fri, 12 Apr 2024 08:14:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: PCI: altera: Convert to YAML
To: matthew.gerlach@linux.intel.com, Rob Herring <robh@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240405145322.3805828-1-matthew.gerlach@linux.intel.com>
 <20240410173159.GA733161-robh@kernel.org>
 <alpine.DEB.2.22.394.2404111700280.410528@sj-4150-psse-sw-opae-dev2>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <alpine.DEB.2.22.394.2404111700280.410528@sj-4150-psse-sw-opae-dev2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/04/2024 02:04, matthew.gerlach@linux.intel.com wrote:
>>> +  interrupt-map:
>>> +    maxItems: 4
>>> +
>>> +  "#interrupt-cells":
>>> +    const: 1
>>
>> Already defined in the common schema, drop.
> 
> When I remove the lines above, "make dt_binding_check" gives me the 
> warning, properties: '#interrupt-cells' is a dependency of 'interrupt-map'.

Could be, reminds me why we must have "reg:" in cdns,cdns-pcie-ep.yaml
(and host), not in shared cdns-pcie.yaml schema.

Best regards,
Krzysztof


