Return-Path: <linux-kernel+bounces-123929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4E4890FE2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E52C1F23BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91A6182AF;
	Fri, 29 Mar 2024 00:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BfOd+3b1"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F66BA920
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 00:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711673657; cv=none; b=qCZbKrykx1Q5jo8RMdGd7hDAfHrVSDaMtTrBEsrcdeYqV/r96etv4fxCvkot0rTRl3VrHVPSzJaz5rItcItOrw/3ksMM4/40g+Rx2ckUIraqOt6hw8i7CvCoa+6ccCeyl/a3htFkJjkndyuko8Im/kxvpzksaEoqKH5Cw5UAFSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711673657; c=relaxed/simple;
	bh=j/1rgdbmuMmpxGy1Qp+LCPqELie2gUYPNcbR8OOy5yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EplJ1+qMCGgKWWzkTYyo/cpa/0/eh9IxoqmkptIkZLpxZeS3UkLnV02wUl9hJPtDTBw/ccfQzaiHs6rZgCsmNHdMQVVT22p8ZvRGzEL7I6933v6n5/GT82jgHDFUeMS7g/JKaC8EGuOHVJP2yFatQ3Rzjuqv0hMTdn4o3clpy5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BfOd+3b1; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56c404da0ebso2370797a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 17:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711673654; x=1712278454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mYUSjIVZMnLfL2FeoKjHJweuFEhZehPAV531EqV0QWs=;
        b=BfOd+3b1rDH29nBi7IzGPC+24301nlTWlCkZxfyr2zkBhEy5i14uUNva+/9C6RvuSF
         R7kWJd1hgpcaEwozY4+wxH4TRujMn5xYu9gsPCrc39to6zBWCX2umkS5aTpMHfZIA3SP
         tx+rCks911SKFY16HLuPvMNWFw9fGLa+wqM767RjT3+oAnxika4Ygo6AuxMXna23Kup+
         RK8V/MEwZjO3WXiS1PBMTSdYIUp+Gcka1UDV84lKf85ejk3aMbu5LzB+Mq4ADD0UFS00
         oT6Gu7pbycm8qUDWfrmbuoloZbYmWTpvNZYlQvfDZIWYAXfG5hucWMQV/HuQaLk2HDdX
         31tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711673654; x=1712278454;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYUSjIVZMnLfL2FeoKjHJweuFEhZehPAV531EqV0QWs=;
        b=De53jPcVIAEBgjFOqsMFmbbx3lP5ZlRSGHGF3RScgs2WsCJnw8l5ECVYrcLSO2yy2p
         OvOzgz3NqBIZjsCGAcGdhziSdOSu8bYTuMCOrkwyjXocCCR9xXrdxNPjEEzjYdm5ZyP+
         ersB4haptxcZ6/TFEk7kLUStlQlqRdYhTWxy5tWnVBYfmXAzdJCTMIjFISe6hMhKtq5+
         yVjhO0iHQXYsJVXXRIEHQmgEkuXH+ba2dbUs6SljU+PGIRMFjsbMpr7QAAfwS+m0rLVQ
         YjXYGMhe/L+obxZEwHMS6wKrGV++Yi2ioe+peg9vUIPn5HDfczp3cpeUNtJrEDIUWWVM
         9oAg==
X-Forwarded-Encrypted: i=1; AJvYcCU9nMbXqYhW46zxzQGB9dZSEECJCBZJf+HjFTaDtzp5xmleUdY2GOAluldRehL2RMFQO0v1C+iTvwAQr5slbjUsqE1U8YF3N2vrStYU
X-Gm-Message-State: AOJu0YwSK7Aj2s6e1WLe+rApi+5DjV54gHhUpS6ujVHChZ76+yD+Gl0B
	kD/wW7Dfg4+2rUePLDHDzfqgGi1t47ZsgfA2P+8reupXFjr2HfgOUQ8qtqG6nDss3Tt6nMrLqCI
	g
X-Google-Smtp-Source: AGHT+IFp6G2F1CpG2TFo1DwIArWeXB/T4Oo3zIvlThoJku6qoamJAHyRxK8G8ABpsb7KxmUSaoZlPw==
X-Received: by 2002:a17:906:3993:b0:a4e:2d69:e379 with SMTP id h19-20020a170906399300b00a4e2d69e379mr524194eje.4.1711673653662;
        Thu, 28 Mar 2024 17:54:13 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id dp14-20020a170906c14e00b00a4734125fd2sm1308229ejc.31.2024.03.28.17.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 17:54:13 -0700 (PDT)
Message-ID: <4e1c225f-9b9a-4300-b4d3-2fc38c9b573c@linaro.org>
Date: Fri, 29 Mar 2024 01:54:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] v2 arm64: dts: qcom: Add support for Samsung Galaxy Z
 Fold5
To: serdeliuk@yahoo.com, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240329-v2-dts-add-support-for-samsung-galaxy-zfold5-v1-0-9a91e635cacc@yahoo.com>
 <20240329-v2-dts-add-support-for-samsung-galaxy-zfold5-v1-2-9a91e635cacc@yahoo.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240329-v2-dts-add-support-for-samsung-galaxy-zfold5-v1-2-9a91e635cacc@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29.03.2024 12:08 AM, Alexandru Marc Serdeliuc via B4 Relay wrote:
> From: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
> 
> Add support for Samsung Galaxy Z Fold5 (q5q) foldable phone
> 
> Currently working features:
> - Framebuffer
> - UFS
> - i2c
> - Buttons
> 
> Signed-off-by: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
> ---

Looks like the commit message and contents got mixed up!

Konrad

