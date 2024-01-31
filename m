Return-Path: <linux-kernel+bounces-46399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CBE843F22
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84931B225BA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44715768FA;
	Wed, 31 Jan 2024 12:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TeRxvga9"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75D77762C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706702838; cv=none; b=QOwCLMVdJ1yAgdMLrPdcXr7PS3jNTG2vZaEMeJgPmjUgWYWp8WhAThisw8sHh3x/jeOPHkQkn2QeXWnOhncdHk78LjMEEwj8FYC6FutJ74+NK0SGkx4Ip9fnr5LaiAXTL4jdS7JGArcyq7hUWWBViwKzL4m+RNAKDvvh9bXt2as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706702838; c=relaxed/simple;
	bh=qU4E162loZwfTp3HYkyxdRM3XI8TqDAEicNfRq17EP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCK/uCKq8vJ8B6R5hwPsNbDrAJ7Rw3j8S31bQpSzMicXYgxLlYtqjJgotigWLM1ogd0HfQkPjkysGAAvWGN5wz24ztp1bDniwJ14il+pDnN5ApGdnERDHygFAnYhoLzZ1UJeLoIbVGi6rvb3WOIa+r6aYoTtSvGUcO5QFhQacSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TeRxvga9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33ae51f8111so2639606f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 04:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706702835; x=1707307635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qU4E162loZwfTp3HYkyxdRM3XI8TqDAEicNfRq17EP8=;
        b=TeRxvga9JP+VY1AJ3tZ20wr5/MLzTokxLNfMCFU3a4a8XpLrx4tey6NtViNneO/WW4
         wyg41Q5q/v+DeK3kdl0ZscV48Srrc1kMze/07ruNYKoEHaP7MayxO/gVcl26ISrVUE5g
         mjesh18yncZSFplSN2ioRJOgoVISZ+cXCpK3kOE0iwRwW6P4FPWqH9pypXlCprSozuQo
         /JbExTn/k9ZvCExP7mTpUqycgHT4XZfqrVZ9eM8x0hTKFLIJYnAH6hBt+b9WyE8p4fkU
         7q5YkncZZ6aEvWBA2L6OyhsC9AZzoiA2vO4Ua6aNhNjFiV0ttCYkbrreFc0Ku+kwxQdy
         trAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706702835; x=1707307635;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qU4E162loZwfTp3HYkyxdRM3XI8TqDAEicNfRq17EP8=;
        b=GUP+7nYkJQHkOBn0l6XZTh2JvnpWekhkX50zLIk5e2zL3M2TZy1IaGZyhTR3vgkKd6
         5kAlj9V1a1BLr2T2lHFPAy8JY9PDr2Mpznf1pfxDh7gXAIiPBUadGde/H8BP5eJxVhnX
         AcrGCuuvF/ffoNnBZs4PQJ/ZL6z7nVARSR7Z67jO4mfLXVg834/5JILjPqF4w/3W3Bg1
         7MfpYM6/fAJrIkMdm3eKKaWmIvlxtrCgPva1XsIHMI3w41eBda9mJDzLdMD7z4ZEff3j
         0RYfMuJC5dxNcMqdN4DT0XIivxIJlVqK8F3ZQZxwof4NFO7ko34LdjOTihDh3BadQJPJ
         uPfw==
X-Gm-Message-State: AOJu0Yym4/GfR8IJ8qA0pRgjJ5xePoQ99xi8tZLpErYMvPiC0xRCqFBd
	nKswRG1o9B27aTxPFia/w1cEbok0leli7iEVm1Tuz9fAe2Ab/c8iHSS2F5C1Yc8=
X-Google-Smtp-Source: AGHT+IHEiOaXbWBjL1ilTiEtD7iPaCuj/GwMk7gd6hWU92Q2b0hXuGgSG3wky1CyZEiG3uPJAJ4kSg==
X-Received: by 2002:a5d:68ca:0:b0:33b:e1:e2b7 with SMTP id p10-20020a5d68ca000000b0033b00e1e2b7mr857231wrw.67.1706702835109;
        Wed, 31 Jan 2024 04:07:15 -0800 (PST)
Received: from [192.168.100.86] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id bv16-20020a0560001f1000b0033b049ba4d4sm1391994wrb.57.2024.01.31.04.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 04:07:14 -0800 (PST)
Message-ID: <d56d11f7-e796-4de5-ad1b-2e7fdef5f085@linaro.org>
Date: Wed, 31 Jan 2024 12:07:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: ipq6018: add ipq6000 CPU OPP tables
Content-Language: en-US
To: Chukun Pan <amadeus@jmu.edu.cn>, Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240131102003.2061203-1-amadeus@jmu.edu.cn>
 <20240131102003.2061203-2-amadeus@jmu.edu.cn>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240131102003.2061203-2-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/01/2024 10:20, Chukun Pan wrote:
> Some IPQ6000 SoCs don't have pmic chips, and fused 1.2GHz.

"ipq60xx SoCs" ? "and are fused"

---
bod

