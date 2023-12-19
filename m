Return-Path: <linux-kernel+bounces-4906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D36E8183AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1208283028
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D41D11C9C;
	Tue, 19 Dec 2023 08:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glMEdn8Z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F2911C96;
	Tue, 19 Dec 2023 08:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28b4d7bf8bdso1082425a91.3;
        Tue, 19 Dec 2023 00:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702975513; x=1703580313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OX75w/xyd5E4hq9OpOdbbEfwOMXrJ9s2JNpMiA5zZgk=;
        b=glMEdn8ZduYHS7BX/2ip7xZfRWgOv4mZSUSXcNxQEC9suNEvv016YvXvjNGfKPzUbc
         Xcxo4dl8To1nM/6tNNNG2DbtJjvgSU2KaYDeyp46Jpx0v6d+aJVdtGXt0p+Ee0xYFHw5
         THFG9YxVXQrsRo3Voky6xIsouUSxHu/8U/3NZ0uZzSUqem7glkRJfXTWQ9/SRcllUxd8
         vKYvurBn2ZTlLr7uI8ajZsahtgJs0pMDzpU3WOtykGGFvS8OLBHGF2m1g7mScofAJaaH
         XYDQGsT/Dslev6pmmXhuy6ZEASSqnkZLpBQk3GvAIKfUD7ngxKPOUAWQAGSnVSyAN/Vo
         4smA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702975513; x=1703580313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OX75w/xyd5E4hq9OpOdbbEfwOMXrJ9s2JNpMiA5zZgk=;
        b=a9XzJSaSdMToeBrNj+BsUU0w98beEmF9agn0rt2qeAaJv4oy4G7F+lJ/mpmOIGiu+a
         amQWmP1qOC+Gi+u7OJwyHBozKmGfFQ7Jr8yb2TwVH2+970etsaktpDeyPyJ+zMkqwhmr
         xsrCEhh81cL2JxUU/czrS8QoR6UNzmKbMMnACqO8miiot7hzCaqOIv+sBNezsF1Q2iQG
         Wcm5IOSSUCRYzUd5UHgpcR9a6mEe6nbYpH/j7rfES1l+YFnuSoWRAWKCZFiqg5xwqSuG
         DTD89J/qSWN5VyfmEe4F9IMMCMuBiZoV7fRZqPWtRLi/JSrpa6do0mEQ+t7Oa7MrKWrQ
         eqIA==
X-Gm-Message-State: AOJu0YzHVw772hYgtvDbno7TEkOBAXWPEHDlQUzozJVm69+TNSL4XRm5
	J6RXNVIPNSENEhNWniqBbAtw4VkEbxXzu0EU
X-Google-Smtp-Source: AGHT+IFK/thGv+qIApRNL9M8QxfHBu53kxqrBPtkirj1+0RUsdv/qlvD/RCdQERCJtVFdrSe1i3yHw==
X-Received: by 2002:a17:90a:f2d6:b0:28b:313b:7cba with SMTP id gt22-20020a17090af2d600b0028b313b7cbamr2379844pjb.20.1702975513360;
        Tue, 19 Dec 2023 00:45:13 -0800 (PST)
Received: from ?IPV6:2401:4900:581e:798e:871c:98db:5638:a4? ([2401:4900:581e:798e:871c:98db:5638:a4])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a000300b00285cc7a867esm1057300pja.0.2023.12.19.00.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 00:45:13 -0800 (PST)
Message-ID: <6c1e13b3-28d2-42fc-b9c2-dcfc4793fc39@gmail.com>
Date: Tue, 19 Dec 2023 14:12:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: add MCP4821
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-kernel-mentees@lists.linuxfoundation.org,
 Shuah Khan <skhan@linuxfoundation.org>,
 Conor Dooley <conor.dooley@microchip.com>
References: <20231218164735.787199-1-anshulusr@gmail.com>
 <f8aaf7b3-fa17-495f-9c1c-9ddf6fb41d8a@linaro.org>
Content-Language: en-US
From: Anshul Dalal <anshulusr@gmail.com>
In-Reply-To: <f8aaf7b3-fa17-495f-9c1c-9ddf6fb41d8a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/23 13:29, Krzysztof Kozlowski wrote:
> On 18/12/2023 17:47, Anshul Dalal wrote:
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  vdd-supply: true
>> +
>> +  ldac-gpios:
>> +    description: |
>> +      Active Low LDAC (Latch DAC Input) pin used to update the DAC output.
>> +    maxItems: 1
>> +
>> +  shdn-gpios:
> 
> Open gpio-consumer-common.yaml and look at entries there.
> 

Should I name the property `powerdown-gpios` instead of `shdn-gpios` as
specified in gpio-consumer-common.yaml?
Furthermore, do I need to add gpio-consumer-common.yaml as a ref?

Thanks for your time,
Anshul

