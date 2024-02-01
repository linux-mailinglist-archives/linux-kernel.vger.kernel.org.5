Return-Path: <linux-kernel+bounces-48763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2938460E9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CA0AB23C13
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFADB85286;
	Thu,  1 Feb 2024 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LoZVl6qU"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DEC85627
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706815659; cv=none; b=Hx0ViKGSE0+1CoUsVoejSYVywPBITndQmLErgtQWpwhcpk4BHNH0vJdYYmCBlXiSowop82IqGxYrvHqjDaZ2RJsanInKtX8enXp+fqmywxjShqSCgxH00XzyHD7FV1/c13aAgkaKJ+lA5tlY+Y2DitgVWBMCZiB3jxUl8/BNSyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706815659; c=relaxed/simple;
	bh=SxPEt5jkAuHy2kh86Q02d3yBZAFCCfqdncNN4TGVXKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FYP4nretguD6x/1fFNc18ohsmAaSLNUT0mMQERMtyopnSW7Lmix6dG1a6Hr8apxEQiKGBfa/g3UE8A4qzPHNMwiFqbnR1mjvecqZ7XL9XjqsvTnCVJYnVIrzeUykewCsfbrDYLMnNthDCCOe8CZHqqv/0duG4pbjuSOFp2cz69Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LoZVl6qU; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55eed368b0bso95490a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 11:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706815655; x=1707420455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aTBsYLPg8jSJKydU+cnrnR6Ok1gcYKUiE/kEKEwSKII=;
        b=LoZVl6qU/Ad/u2FKzA78rMG5dxU3rvqNpCIuvH2nnwdBAGa05rAgUDt8pITjmODKnc
         ktPVXXUGz5g9ceX7joIt9jHF362TDbXQmZC2TD9qnhlQdcpiDZHeg7xdDHy1fUNC7L89
         AkJdIKdm6aNmwnSeq4uF6Z+B84I18XunCoqKwJdZi4HStoZP5/j7y1YOESj9ETQ2LG9v
         TAsm4fqdiPMktATvjL8M1cNgj0jPVdfQ5sef3ZlIPhML9UmODO49Ea7aanKdodFpu4pb
         BisYc3P+Fd6vvGdbeilj/uUylPiAELBCqsRReV7vXhsbAtT7BVpuwmqhnT4yvwnblhd7
         DZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706815655; x=1707420455;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTBsYLPg8jSJKydU+cnrnR6Ok1gcYKUiE/kEKEwSKII=;
        b=lJjCDn05UBcqtH+G7uRnO3Dkwo99et2Po9T03JIphkMuwNCfIW2QRzisVSWRftYIOE
         Kif+O9K3IWvNDJrAU27NHmZqkloQ8hCwN/jeLTIYQ1VqZoLUBIJ4foTL18ZmsWi4agK7
         i1kZNj6jusUQzon8GZHCmMW6qIqi6u82D66+mIEQwWhKrHs2/OjeqDcvFN1ZYczyQ8dt
         Y9rHbP4nufljHA7gZY64MqQYkB6sFS/Hg5qPNJ8TMNPVjSYL8+Hxdi/GbQSAHfpj5zdE
         Axw0lNhfwjNGcu48hpv7HabJrTOnPAzndeTXUmE8wkQzzweQ/D6C/XAWvh/7HRzCmSjj
         zoeA==
X-Gm-Message-State: AOJu0YxM0u42lZsNGgdk3sDtNYXuxZL97xF9kfoUVBtYWvWkFqo3c5TL
	LybbdJDT2O+VUdz98Xo8p0MQMlixpCQ0uORbCf9cih7BRTqLFryWnhwdv7yNh9lhx2G2M1Rc8k3
	i
X-Google-Smtp-Source: AGHT+IHIhQr9ch3SAM6lYViVmHHivPkw0VGL8eXA96xiEeWb8Tv1eYUoxZGf0ciA+Ih821Vht31zJg==
X-Received: by 2002:a50:aa92:0:b0:55f:cc6d:29b5 with SMTP id q18-20020a50aa92000000b0055fcc6d29b5mr1463051edc.21.1706815654979;
        Thu, 01 Feb 2024 11:27:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXekdfdGebEvqKWpKE1aHymENq5hUW63aujeE8icXDHn7jLqN3o5IpL5G8l6ro2JSdxdnnIIg5lEU0qfC+jin9SgxnuFfeAOj8z9zJYNEsaKQjT8MO8MFD6mrh9JHr4uJ1imN/hkA8VgkdIWZ0htLSYSVI6df+wcb2fJKaIVH4545eIrg5oLtns+MQ9bFKZOoMcBqQOHb45ravCSBytKnUUJbH9+tePIEFeigO9ZUwkBkDdjSANpT0pZqo7JYa0fQoOvv8o5cj4jH9vhAX2Kju96ZdqoeEs8/5EpPD14jMDaUB3bilk0etVy91LE9B47d3iz5tIp0gK2EftwoI=
Received: from [192.168.159.104] (178235179129.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.129])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e0200b0055eed9cac54sm110982edh.12.2024.02.01.11.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 11:27:34 -0800 (PST)
Message-ID: <b1fa4ab1-18b6-4609-b27d-71b89db2c716@linaro.org>
Date: Thu, 1 Feb 2024 20:27:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: ipq8074: add clock-frequency to MDIO
 node
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240131022731.2118-1-ansuelsmth@gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240131022731.2118-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31.01.2024 03:27, Christian Marangi wrote:
> Add clock-frequency to MDIO node to set the MDC rate to 6.25Mhz instead
> of using the default value of 390KHz from MDIO default divider.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

