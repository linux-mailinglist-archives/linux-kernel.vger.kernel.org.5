Return-Path: <linux-kernel+bounces-60027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BAC84FED0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29D01F29EE6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC6C63A7;
	Fri,  9 Feb 2024 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cQFBuWjs"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E44538A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707514022; cv=none; b=bISkJO7R6YQmbjGlvAzXc56t9DpVOMdrgoZmcztTBudAbUspp8h+yH1Mj3SljNTcW820XGpmWpXlhCjd41cQH3yK296Si+6zx0EI5Ik8YqVJY5P8qIhgpSthIfHNoYRbV6JMLg2znhqCop7326RfhuMMRCYG8+gBJocvAQs7IsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707514022; c=relaxed/simple;
	bh=tvnRQibtJ33EQTxC+un6JsNwbYSdPuRIhj/wOJPELjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mKZ0+WWd1odOz8rbJ4wlxKFidm4D60+PFWrABdofU/LeWxqs3Y6pvBbJhhbQy1Rc0FIpamQ3TkvIREF7xTv5XhyguvWzLAAoUmUYbuPLwRPgBBd4ExYex0Wk9b3oHcJor2QbMd39J8wgEk0WzqPA/SY/xqipXnsXbBah4meS8RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cQFBuWjs; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3864258438so250705566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707514019; x=1708118819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/bpbhM83P5fAqUwj/xfMpAx8K/08V97Zc82x4Fmrvg=;
        b=cQFBuWjse27E8vE4oEAuw9L1g9CE2z+5Rmb24q6kUYkOApNty5r8r1lKBcP2r+TAlh
         SddWQU8+QAjmTE0+LqLx+mNzDsOHwA3Ljk4mt7tRxjJZqZ5sDFvRpGEDBo2qcPCSYNgB
         H5tAqdAo/c8M3qDF2MnbD5i2ZzNnZlucmakxl3DZG4ygPfDZtLwo8kH/Ga6DE0cXo4w8
         Ygfp9K0GLzFJ1aM3JFNywYeUoXIAvFi4w6o4DjbPQE6/7g56Lfn75NSba+dM3fbkNKzR
         wYIP0xTjJaUnLH60jsvgDGqJZKr2VoF9YBgsr1yr8K2HeqJw6mgznlWZgHA253Ze67X1
         ztGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707514019; x=1708118819;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/bpbhM83P5fAqUwj/xfMpAx8K/08V97Zc82x4Fmrvg=;
        b=LVw4+yKUvhSmU0gxrLS22+Gyp+yE1kmw28craFWn0+J30SYzalwx6f5prsOIIZ8jbv
         1yxWGQ+iLrh7jEF6vhO0xad2Hu4lOHlnIwFKwEvx6Yd7d4rFyMwdjYtNbasE4fWHA1PS
         WHEgDFzf8m6rTSpGWrRpApOja/px7cL5IDAI+zYxfyoQYUMySJRAWuq/8yhrhrRQJJx+
         sMwls+e3F37uUG6fekBiEXsU+N4hCzu2ZDS8FP9WJKTvLP4EXvdvY31kAP4Wh9AozAxs
         iESDGe0lxcGyqPm74Y3VWd1+AB7Z/YS2chRwXboq3Hn5pCksovSRSkpqCDi1hXUhlVgt
         w3ug==
X-Gm-Message-State: AOJu0YyYukcUmOQx4buWxO1GQR/T2skJ7F+G05D98MB7Ky3k3zedaN7R
	ntLKD8NsopjmZAmUOl3x4iy4WIWZb2EpLrlv6DLGSi/UMeYt7xRAhHeV1nB6ncg=
X-Google-Smtp-Source: AGHT+IH3dtji9Eta6bMf1SWuK2QTTxqY6Ft4kR79Dva0ZqJrAsLhccAeJ65+q9H6qsIimACIxqNk+w==
X-Received: by 2002:a17:906:6b86:b0:a3c:11c3:ce9a with SMTP id l6-20020a1709066b8600b00a3c11c3ce9amr283908ejr.20.1707514019093;
        Fri, 09 Feb 2024 13:26:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV38jaEC9FBC3mOiZ8FltZEs7elyE7Ij4mAUabO/wzOd9a2wnIDrU1z5FwshJkDyHmUuyAxOLmEeZDBJUqcSMvpMbg28eTzLDDSIDzs8NXM+9PYn83Te56xbnVOlWqk+gw/In1c7yBo0S6ZJ44H9rc5D1LD61Vc3lNYCztdDPZC6lRjiRn5bYMWZd0zXjYA5+hO/o2nxvg9qFcp9544By8lWQe4XPtTGP0YwZiajMiLmz/78Q8byK+3QobutwoTMblnIns=
Received: from [192.168.192.207] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id n25-20020a1709061d1900b00a3c1e8ecc09sm132677ejh.152.2024.02.09.13.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 13:26:58 -0800 (PST)
Message-ID: <46785ff5-2cac-4d77-be8a-c005d85b5947@linaro.org>
Date: Fri, 9 Feb 2024 22:26:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100-crd: add sound card
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240207085615.27187-1-krzysztof.kozlowski@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240207085615.27187-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7.02.2024 09:56, Krzysztof Kozlowski wrote:
> Add sound card to X1E80100-CRD board and update DMIC supply.
> Full schematics are not available and the limited available parts
> suggest that DMIC0-1 use BIAS3 and DMIC2-3 use BIAS1.  The DMIC supply
> is unknown except one remark for VREG_L1B that it is "used for DMIC if
> no WCD".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

I have little idea how these things are connected, but brain compiler
says it looks sane..

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

