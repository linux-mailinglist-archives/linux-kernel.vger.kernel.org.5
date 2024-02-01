Return-Path: <linux-kernel+bounces-48770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C188460FB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693A91C269D4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBD085632;
	Thu,  1 Feb 2024 19:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjLxYP15"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DC98562C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 19:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706815810; cv=none; b=INAtvQA3oXCkg41bpF+mPjvjzhzXtXsQZzkOUBTX4xD7FjCRZM6XqcJotPTs+OOA8doC1OCPbvd6vj9VA4axp5mE0jpe7Bon0unIItY5xkiCwvhD6mSp7fVlhSeO710zbLnOJGOezJt78Qq4NLMeCocTpQIj4etolEDPAYUkBDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706815810; c=relaxed/simple;
	bh=qEdOIhplANC0gorwcTR2WxNxvxwlx3uplcYTcQ9qBKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mt3alaZYAs6rgo50Usut/x0RACZpSAkYJTgh4PrsevpltF6wvqH4f1doZ4AsFs7x3DHFEh9SkYALXbtyPwcSqMramFZbUq574nb7De5SvHkLmanaNZUEpF5qZVTLDh4Gk3po9cmweVlZaApj6+GFwFTXvjkt+DcPeUSkR4FNNg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EjLxYP15; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55f15762840so1588187a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 11:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706815806; x=1707420606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p8AF+nF7f6GKyHNgDkKIyrm92UYx2InesUiKuHDgxjA=;
        b=EjLxYP154gSgNB+thsRnMUshj1rlGe6xzFjcBC3IRcQ+kf9ygr0DL3ReS8n014oQix
         4/8RW6k2A+uaWKXuMx5XyX5liJwe4VV94DP31z75X2bIlJd15u6/U4vYvWNoCDAgtGGx
         90ztDHzCAS+psSeNJv9sOrSFHD0iWvpuLP1KwC6CSB1cfOC+A8iY2HWLase8QVPqmr4U
         j/G1CmMp6gqnT5hSrG8ydL9vIPtyc3m6jGhWCuaJHP4ApcAN7C3mtyRa3PxEmOfix82E
         mqH3GHGJ2vifGzB8dXZ81YORLKf1aNNNFlHZwKnAtaytWg6AghbEoSsWqHN0by5Qxi4R
         a0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706815806; x=1707420606;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p8AF+nF7f6GKyHNgDkKIyrm92UYx2InesUiKuHDgxjA=;
        b=HYjTUIDAMb/ZeCP3iZTsEudnJdsO/zlD9hGCCc/+Sz9AKkEJ0aaxpULXjNEakyXiHK
         GP+yg/vOQEVkGZF4cY8GOpOJFjwumP2UaAvewVAm20+E+n2OcJP02jwFZgsTcHjM88BS
         KDUL8CJyGULLmRA0bUf9dvXfDZKYNqfOcf4C29rHqr9Hf/Is45SzeB/TAAtalFFW7CqS
         m2DSav0xfuRUF0Ad5+bldrlMZFBe5LXfHp68rZIQYvFh0seiqXH+dQlM5o1MYKs2npbC
         lj3PK8Jh3MBq1HepHv43Xlgakd47Rk2Sf8W0XRAsRtfVDefvqUwMsLkij3DYYAf+e71Q
         9SWQ==
X-Gm-Message-State: AOJu0Yyv5UiNK4wDRkWGIGq4sAyjHbD3d88n1YHsemj4XnUz7zHF4LnB
	/MxT7Fuk33uv0IA34G7n9Jy9zHon2PAwrUeiYSuE0a+6L2eYjmhDeh7S+lLhA60=
X-Google-Smtp-Source: AGHT+IEkKtSLNo+Ps5dlB9BfkBVWWZSEfjFQelsor9HO5y8oGLVBKmRLPigMyO4ZMQPPKKtg4A1XQw==
X-Received: by 2002:a05:6402:1aca:b0:55f:e35e:1450 with SMTP id ba10-20020a0564021aca00b0055fe35e1450mr363191edb.0.1706815806611;
        Thu, 01 Feb 2024 11:30:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVLFV2meBnZyL2aQToPalM5dRVdfEbeV5Rqhbw7IHafWJYZKhQg6t7RZ8bVZm+x4uAH4YThlx0QGCmwNRk1Nxkj56PXICjd0fI2BGoQBHpn6B8pHoO7RDtxsDeCT9FKh0Bf+DvmcjxQEajOjPTpDM7MoEzBuKJBfVHJeFZ7KVJzVX/hB8tw6kDAiubxvtEO0b2WEACkl0dChcGGl1GIezVl4BGv7UtceKSJWvPJxgSBgtnibCenWUCENT7vobB5efcSrz043CPoIAUy
Received: from [192.168.159.104] (178235179129.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.129])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e0200b0055eed9cac54sm110982edh.12.2024.02.01.11.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 11:30:06 -0800 (PST)
Message-ID: <d16729a0-ce5e-4587-aeaf-b9fceffd2696@linaro.org>
Date: Thu, 1 Feb 2024 20:30:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] arm64: dts: qcom: sc8180x-lenovo-flex-5g: fix GPU
 firmware path
Content-Language: en-US
To: Anton Bambura <jenneron@postmarketos.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240130202755.2289952-1-jenneron@postmarketos.org>
 <20240130202755.2289952-2-jenneron@postmarketos.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240130202755.2289952-2-jenneron@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30.01.2024 21:27, Anton Bambura wrote:
> Fix GPU firmware path so it uses model-specific directory.
> 
> Signed-off-by: Anton Bambura <jenneron@postmarketos.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

