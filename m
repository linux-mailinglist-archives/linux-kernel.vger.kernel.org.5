Return-Path: <linux-kernel+bounces-60493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E728505AC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 18:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE0E283B6B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ACE5D463;
	Sat, 10 Feb 2024 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FHV/hj3K"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE975CDD8
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707585555; cv=none; b=SvgpBGHqpPdUza7fblHBxfv+V+G755rU9KenY0cUzdRTAxV//Zzvz/s5m8NCe6DjV0ShD+ncNlzmHa33UMp8lWIAHOwL8Bww3Km0QFjXaPWPe2abe7vfUExC6zLiCG8gH9omv74k4QRmQ0u74cyZ9X/MZp691Zt0x5DMudo4euw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707585555; c=relaxed/simple;
	bh=NYudsIGjRm27pkmw6NfIzTDAlY58kWaMj/QkAiYov4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnAmR9FikTLfH8DsQg5ipLFblcUNCpBNxnLjBZJIA9ZK+mlGpZnpEthPZ7Evx1L+7QB8Z0IDPqCe1shyS0llAT14QcKZcLGdJEL+zii2WLVynHJPVQ116RWAGilVeaEk5hDY4SJAwa1uEFCSgxsUALQtknJkbV7pdZ8n9CPBb44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FHV/hj3K; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3122b70439so237931766b.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 09:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707585551; x=1708190351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UPPfoSPtlGq/Vz0zCl0yTdi8JSgrSbydPmzP0jiNjJM=;
        b=FHV/hj3KVFn2TW+vxL0Cb08qRLakb9PQaR5QvIMHACKWybvRnsGtagyk8ShF6Ub0NU
         Pu6wEbWKgYYFJktaUoHe/cVWZubDoCfE4mSEDYMunUWDPuQpvv7f4orxIcgokHNevLAR
         ZOXvXJuyBTdzaALSyEzjANPj+6rLk52dYyoJtLT6e2q0u7KZ1cvsZLMipoCwWv+Qf6T0
         gp/VIYRatSJIizSG54747J9SgMjtNJpKitwMYNUvgPQwYXhazGXA8pGHUPLSi1XzacAp
         fVUTVfkA3SnIcajD2UHzTeGwRqhh0DVHRjKAltlPJW3cTSZPpmef/Hh66l4ZHEHy51lP
         mZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707585551; x=1708190351;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UPPfoSPtlGq/Vz0zCl0yTdi8JSgrSbydPmzP0jiNjJM=;
        b=VE6dT7cOTMofViBHCLBFGI/QKtvoQ20ZZw/NF8TwE5WHaEHh/4z4Dhoaryf7x6LoEP
         8P5vvbXdC+I59CsUMG8UpaEffaLG1ir/6hXAAUm39r+RqTP/tBBX9c08xF5gwUkDOLa9
         67ES1MPKNCdWLDViNxXdljgHFYPCZPuDDk0fpYAC0EQS9L7hsOLTFiEoeSnZQQ18V45S
         VO3ExNLEEOUpa5f8Eb4CfJfbSeEAs4F6E7cAFyNkOsS9KzpU+bEGLFSDjsP5W8zRpQVy
         qLFkiy+bFOMK0AWJv70JUW//MghEwAs+p3giRvshf2dDijkS/f0e1uylpdT1t0By75Vw
         TSDg==
X-Forwarded-Encrypted: i=1; AJvYcCU31dRscDagUlEMWAywL33jdAUcw419AlD6IvzLJTdgWmtoiXoNWShc8n9i2xbAS8+Vquk3Hzn0qbBklH3qkzhLsr6d6u1IByWNXlFI
X-Gm-Message-State: AOJu0YyiyRSj4iPrvDS7zjJm4/5a8DkqMr8ZcKbPnTeWiSYA1IkeyOEY
	Nk4QDgc/I4kAJmrw4zuYd1zKWmr/GdYwb6H1619+ImtN4Vn05/5EwlAs1K929A0=
X-Google-Smtp-Source: AGHT+IGf3lJjgMzTBNliFCNzGITS+DH/YyZWIGQY8pBo91UsuBBfHuCnnxy3Ge1cjbhereUEyz6q3w==
X-Received: by 2002:a17:907:9858:b0:a3c:2146:a0be with SMTP id jj24-20020a170907985800b00a3c2146a0bemr1531701ejc.70.1707585550785;
        Sat, 10 Feb 2024 09:19:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8EHLrQDnCbtgF7aPp4Tys6b9xyplZflPIlITe2JUzkER/f+TZ3YW+1QuqWab1ZqVx1hWI7gDCToCTtN5IveWnTIYJkgjK/tuD7DbIrM+PlbCrnLZb2ZnxXi5br7FA6Ax/fYDYrlQZu9bEpqxG5O0sulZvU/lnBUdb7W1Tn8rqSGvmcLgAj6jYcMvpWcHks1GSDS7Zt83ulZ0qayIbguRXhhwynGXVjfbWcnsGKf40pKXfpjcpUdknyP3YW63EiKCIA5a9HC2soubhCIC4Vt/vWmbkvCl+26UoxHIKYS3bLhfLjNRui/59vNhfCmE4LNF+bPnNy7tuuQstPRFaf1FNnMB+C8muvUhYzK0ZUIQm4PsqHgAb9OTAyEOgDrE5+xBvVCJmRAodWRemSO3U4RYgkSaJv8xpR9XndMFRZf9Hh4CssNMlKU6mEAFaXkX8DY9JvH6oBfVHS8bh5ocXoNJVlRR7LYv6epgKPfXcPQuW2A==
Received: from [192.168.1.116] (abyl12.neoplus.adsl.tpnet.pl. [83.9.31.12])
        by smtp.gmail.com with ESMTPSA id ps7-20020a170906bf4700b00a3c5fa1052csm64186ejb.138.2024.02.10.09.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Feb 2024 09:19:10 -0800 (PST)
Message-ID: <7b1a0b84-4a4a-43a4-8698-d22f883e6318@linaro.org>
Date: Sat, 10 Feb 2024 18:19:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] pmdomain: qcom: rpmpd: Add MSM8974PRO+PMA8084
 power domains
Content-Language: en-US
To: Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Stephan Gerhold <stephan@gerhold.net>,
 =?UTF-8?Q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20240210-msm8974-rpmpd-v2-0-595e2ff80ea1@z3ntu.xyz>
 <20240210-msm8974-rpmpd-v2-3-595e2ff80ea1@z3ntu.xyz>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240210-msm8974-rpmpd-v2-3-595e2ff80ea1@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/10/24 17:38, Luca Weiss wrote:
> Add the power domains CX & GFX found on MSM8974 devices that use PMA8084
> instead of the standard PM8841+PM8941 combo.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

