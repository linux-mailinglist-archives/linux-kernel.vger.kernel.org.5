Return-Path: <linux-kernel+bounces-89495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0908486F123
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2EFC1F20FA9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D395B18C08;
	Sat,  2 Mar 2024 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WTLuGIrN"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828E7EADF
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709396116; cv=none; b=DC9ISbz/Usi4sg1TvqjK45OOscMc7PKCxUY1gPz8ybE2JX6plDU4JTVFIeGHSXbtjuZ7V+ucuepp6AqPa1aw/9die9hON7yREuh7pzzI4bDzOeFSpsKX0c5aWMrGma2JLlWwoddsMVAaaRNFHSR0K806+vCmehzzwUmaYSdjmVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709396116; c=relaxed/simple;
	bh=J2s77OaC9Z8zPjNGbMBDpIzvitDgSkTLiaqP4+fGBWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nxA2GpJfEwdu7NDaI1wuG0/BqiZfIBTt1Eu1jGo6jsIWMsDgEGNFlF3wHMUyAlx7Pe87Q2KkbkzG1yPrJi7kMlalFQ7c0IlrsreR5OijXZKD5KMdNLf/mymHKWWVBUVpH3Cg2+ALqr3KMA7kjiFGArr5kFbCrWWa5hpeHRcrVec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WTLuGIrN; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412d6906338so2587355e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 08:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709396113; x=1710000913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kMf1B1zas93DyOm/aNpiI/+76qRYaG2o/9vaaLBXpc8=;
        b=WTLuGIrNRB4T54O2b5+CH6RyyTUbUKV6Wf+3XOlMR8uqGdI5gpS7FI+waUJLUXPUN8
         miCxXFLFy67UJ2tENgSDsrcYvAGrj7C6CRXaKwi12f0e8EfVIxQkwqqtBeT4LwxOLbMb
         6V9vMwXjbvhCqoK+mSZz3AlCSsnfxzzsbdVTKoWC8RRQELIWRKjVEagSC2pSq7fCVvH+
         7TP8tgH6u2PDRFSnGG+U3a3N+dmNwCaP74n0BeDwFOVUXBzI1ogja3T/8J+Lrzt7zATN
         lJFv1wdJ1Y8+fsuy4X0A2KlpkIJhrgszm2hbLIioRcuBG7wMc7cbWiKnAjiiShhMpTTs
         9f/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709396113; x=1710000913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kMf1B1zas93DyOm/aNpiI/+76qRYaG2o/9vaaLBXpc8=;
        b=McddSNUy8n7SpyE5PHT5O/2bxKZeXmoBncvn/OBuaSsLKwN8YpLhYxZxWBgAAbKP/p
         cVoIQAIblRZKeJ4peLjBdMpueIsRIsmd509VJZgUhejlg9j1JKUaGBcOHMNSrQqy04ZN
         H7v5rDaVa/pR5IfOouEUpmLCSeeWLpNZMGOF6C+JI3nBJGfyG3bcgIxqXkZyn/zk1gYJ
         Lhoj8qNZv3cSdnLsjCPvf6Atz7uD7Y51K1cY4J0gXZBGqNk5hy1T9TuPdqiSoxYLcp+g
         EXnXtIx911amZXvU6ZC2fSZAy629+4DtXL+SkDRnGA/VEnGxCaQRkhB/48HPwMSB3ggi
         LneA==
X-Forwarded-Encrypted: i=1; AJvYcCXL4wvwUK9l5hstGqTtgHqM8Cz/gKcMRE4CkhPD86VUua1JT/MW8oGw42Z0MpUeRAOgG0iJKxWiMcOUxxnIn5zko9Yu4angC2zRPCxo
X-Gm-Message-State: AOJu0YxDmdONzh+sv2fMvJWowL3dw4I1RKuX6upyyqrq83d139ilpMaD
	CJZxvt6Vl7/9zx+p9Vbm6rYDRtZUXlvevGA7hSryKDYzBJSWVpTCEGFRJriIwak=
X-Google-Smtp-Source: AGHT+IG2muUu4cZZ/O4fZEEXEw4Tnyrzpb0VDuXs0U3T8AfkOuVLRgDQNm/8wITqOG1ijAgL+WW8VA==
X-Received: by 2002:a05:600c:a386:b0:412:c7b5:1085 with SMTP id hn6-20020a05600ca38600b00412c7b51085mr4107817wmb.29.1709396112958;
        Sat, 02 Mar 2024 08:15:12 -0800 (PST)
Received: from [192.168.0.58] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id ay18-20020a05600c1e1200b00412dc44e5d8sm275537wmb.26.2024.03.02.08.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 08:15:12 -0800 (PST)
Message-ID: <6620b011-933e-40cd-98e1-a4d39cc96346@linaro.org>
Date: Sat, 2 Mar 2024 16:15:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: Add camera clock controller for
 sm8150
Content-Language: en-US
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Abhishek Sahu <absahu@codeaurora.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>,
 Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20240229-camcc-support-sm8150-v1-0-8c28c6c87990@quicinc.com>
 <20240229-camcc-support-sm8150-v1-5-8c28c6c87990@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240229-camcc-support-sm8150-v1-5-8c28c6c87990@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/02/2024 5:38 a.m., Satya Priya Kakitapalli wrote:
> +			clocks = <&gcc GCC_CAMERA_AHB_CLK>, <&rpmhcc RPMH_CXO_CLK>;

<&rpmhcc ..> should go on a separate line

---
bod

