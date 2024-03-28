Return-Path: <linux-kernel+bounces-122615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E107488FA6B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46C92B2681B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36C4657AF;
	Thu, 28 Mar 2024 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rj/mWA8p"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9390964CD0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615945; cv=none; b=U2oVP5QjFrWTxu6jiclGEykO6Vnj1iGK+Jux95GwZvcEC6k1ULeHDpTQWyr+YfLE6xfYug6JMd+hGv0PKJGKna4kCGBSY706ZxLJut48w3pf7vJUMVfCY5LE+Ijlq16Y/NOUzPuVbLy7RzRHjYkR379H3MSZnBv2bZkn98TLLvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615945; c=relaxed/simple;
	bh=ChxjiAPwIJAoMLWvSyvtBLUuuJR3I+RKCIHsWyF8tDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thiuK19sFWVZAOilyU2Exn1zCr+mJKC+wZDiIbVBkdRfNmOqhKVAZFV6hN694ellCEO1XEt3XexLbxHB/34tLdWvZRJtiVGd6NwrQ78UmuxcD9EUZMB6KZ2y6hdqRaIynhiz7rNOx15A6Or6uE7NO5heUYuvPxcpXzM3kMSPE+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rj/mWA8p; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33edbc5932bso461617f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711615942; x=1712220742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zPYjukiTakqXaBTdtaepVTDOm2SsVNFnM6RyH2/1aQ0=;
        b=rj/mWA8piQ9hR8B1HhwNb7jshD5tWjcER8vUkrz08dUW2JmdOD4Hg1rMTeRcyBIYjY
         Q8Q1zwsn9AALbaDPYqXCleuq8iGxj5EhyaEXRNrvMgtdv+QfACf7onTq9qo+/3FRBqc6
         66q897PQqiFm0nq7ICtqH+z/MWNOf5kdctLfqS05ZkmKhwK4KHsMc2MgK/ASP3Z91TpE
         smrysuHZsavq3yVpjcMVW1yLq+KMl+RT5aE8bQZE3zpzsmdtFKg18H8/pbe439o9qG53
         1L7wqVLlzGnVzGN1Ba3KBa2Q5PzL+Zu8il1XJ60Hx293vZcMTY9R1DoWFEP9MDNXHi5d
         cL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711615942; x=1712220742;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPYjukiTakqXaBTdtaepVTDOm2SsVNFnM6RyH2/1aQ0=;
        b=fh67lU8bsa/H2i5fglmwzB5DyI4wx5+woH5le7NVuePDFcveRtVlm3omupuDydeM15
         og/jQNR3W6IOditPcRn5n1pbmBqsr0FllN6qh+vHia1TFW4rGKk5nfGLGixzHCuAjhsi
         BqQiv38VNGz+wmKUsAa7aSTeYfLyflozaPKpkU9lK/O3hxB/SSf5nxZRRrsmb46j+1AS
         pQZLmFdHg7W0rAcwedAgghGPP2L/3gAXZ+scmpSO5Mjk1ghmSpH8JtJ+rey25UPcXW+2
         NMesOFaFcN5zbYa3fIkCMOjTqkrgU1eQoDB3cjE7JgaOTf079b9mXlTkFNeLRSIxj9kX
         oK8w==
X-Forwarded-Encrypted: i=1; AJvYcCXok5Z5WmR/aHmIsFY6r+BNdCBbkrmCLiD8yZVKpYIMDggF3a3xzorR7AFydzc6aNnGfn50DQIsTrvYMPxKOXh/EEY+jg4cCj9UkzBl
X-Gm-Message-State: AOJu0YzQ3wnocet8DpO3OSz8W7F3TOmc1MvRJ6l2/sct8qz/nOVFvcn0
	ePiLCu83AL/K6KchSP6tTfi5c8yJPFsnFO81ePAiL4d7mjwIAjJbeO+J68tiKGU=
X-Google-Smtp-Source: AGHT+IHzq/DkX1mQgyKwyLbrkwPXY9N1nuYOMcKmFgvdM0fybQQIm4ZFa6cnU75qQRsOsahfuax9Vw==
X-Received: by 2002:a5d:5043:0:b0:341:bf1e:45a5 with SMTP id h3-20020a5d5043000000b00341bf1e45a5mr1247456wrt.46.1711615941979;
        Thu, 28 Mar 2024 01:52:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.148])
        by smtp.gmail.com with ESMTPSA id dz16-20020a0560000e9000b0033dedd63382sm1148785wrb.101.2024.03.28.01.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 01:52:21 -0700 (PDT)
Message-ID: <4937df72-9efb-45c5-9c46-2a9d3ec8887f@linaro.org>
Date: Thu, 28 Mar 2024 09:52:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: ufs: qcom: document SC7180 UFS
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240326174632.209745-1-krzysztof.kozlowski@linaro.org>
 <20240326174632.209745-2-krzysztof.kozlowski@linaro.org>
 <20240328035909.GB3212@thinkpad>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240328035909.GB3212@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/03/2024 04:59, Manivannan Sadhasivam wrote:
>>    - if:
>>        properties:
>>          compatible:
>> @@ -250,7 +276,7 @@ allOf:
>>          reg:
>>            maxItems: 1
>>          clocks:
>> -          minItems: 8
>> +          minItems: 7
>>            maxItems: 8
>>      else:
>>        properties:
>> @@ -258,7 +284,7 @@ allOf:
>>            minItems: 1
>>            maxItems: 2
>>          clocks:
>> -          minItems: 8
>> +          minItems: 7
> 
> I'm getting confused by the clock requirements for qcom,ice. Why does specifying
> the qcom,ice phandle require these clocks? These are the UFSHC clocks and
> already defined above.

I am also confused, but I did not change that logic. I don't think that
it is anyway useful, but that separate topic from this patch.

Best regards,
Krzysztof


