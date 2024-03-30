Return-Path: <linux-kernel+bounces-125805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DF8892C59
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 19:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8919B1F22579
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 18:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F73A3D984;
	Sat, 30 Mar 2024 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O6P/rB54"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FDD3C068
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711822684; cv=none; b=U3JqI/lOkru7hIuqMeqqNgk0NV/RgSjse9Lypq1+cdftvcdtft63vkusMa57dlprgL3viIQ43JO63BvquSvxVRr3vFV9dBo14x2bEBI73AXKSerPtCRMlvFGnnUFLREOMoLWx84z/BDRRBcFXOcOqJPcjhdE/QVw/PFZHguzjPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711822684; c=relaxed/simple;
	bh=jyBy+ghAmi7wVOjwqKwpCMBM6ZLkcus1csATf41+nC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rtxwHjkVHr44r2HVWaFTzj4uP5nffNd5xwcpLeUTmIMVlyptEbOuHDWXeCFrBOEmbFjlOWvYUOC35VitVk4uR319DOwhexQPdSEoet5x4+KpAbp8+rtWIKP7VXKYhmX2GwgX8sRTDrCMdjDyZa3ZCT0aeJdWWM+c294HE62dcZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O6P/rB54; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41551639550so8860095e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711822681; x=1712427481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9J+SmGm43SmAZ1IPKslxmdpdwaDd06Mo7C6gr6kK5kk=;
        b=O6P/rB54ZnGPZFZ0hreoiez5hgAN9KdTKEgb96J15u1HqI5NBgktLxv9ldQwYmcgFS
         fibFO4yjoSl8e6Zdm8ewEv3CnK5wgfYX2XfbxoS72MsMy8TBw4O7Hn1CBhR3IIBfZvaw
         ba5R41IfIu8dSSd+oMeYDNRVAUMvKBT9J+ZSpEyx+4xnD9B3wtP2h7SX+qmgjFxILuX4
         O0jPDHuE7jQqL4Yi2jHdU3d92tf4j4AAZy6RGWJtQ1SQc3MW9X5a9igbGUeHs1GYiE1R
         mv0Syi/AjWb4wXSNjsChsIxU5eht1LNdsajtlpZZbemx1CAPoGSp++MegsTAwkvYqP73
         F3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711822681; x=1712427481;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9J+SmGm43SmAZ1IPKslxmdpdwaDd06Mo7C6gr6kK5kk=;
        b=onebm3s+4cvBCv1kXlVS9TexQIxZvwiDPp8q8IXixluOzJZKN816m26H1+5Gt3ZeuN
         HiCcca56UxS7RZcZYT1vtuO1GhzOBcCDV6BXvZenKUpF/ak0QMtKRM4AYHGGg+FmOeXr
         jazuzZQczhtjuBPGIH8EqgD4mUc4R0OMRNXHAao5l6b0OtzYtw3fXWJTzQH5nEZ1Lt3w
         GVvTNp2e4aRr2+O652F6EyHdnAriyCTz3/17YvggZlsWj8tCv/vbr4GKMXROAl+p9P9Y
         LQH9399qcU0E2XyrTag7NHyC8oBTb+VY3lfuf+Nx1Gh4L3lf4iwHCXf6nicnRdVl/hFR
         MguA==
X-Forwarded-Encrypted: i=1; AJvYcCXyadzPH//ert8GG/4Bc0MfGUC51yQd8ZOvzfLm55a+kiTHbdJb7p0Dr1gzFOJCmtGbBSE2KtA2hwWm6NKpDvl/iR6k0S46V8JV6iIA
X-Gm-Message-State: AOJu0YzimVdJ5Zz6wPkecQCR3bAkgL5Z0HRPICxHVpjDQJw3jE3CgAh0
	016A16rXcCM7QeaKzkkuiaOwuk2Fw+ji3NthIbnzSfcLlYxGYo3XdzVLlpaXLrA=
X-Google-Smtp-Source: AGHT+IGNmLzpEN9w8zDii8pb9jmCT+9tTum0cvh7rfEZIiEwNGrRzdfhYpAHimToutuliFwcV6H9AQ==
X-Received: by 2002:a05:600c:6a87:b0:415:544b:3128 with SMTP id jl7-20020a05600c6a8700b00415544b3128mr3194236wmb.27.1711822681448;
        Sat, 30 Mar 2024 11:18:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id bd18-20020a05600c1f1200b004155c2b8ce7sm1688414wmb.29.2024.03.30.11.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 11:18:00 -0700 (PDT)
Message-ID: <1534f781-f7dc-487f-a28a-cd635c58f9d5@linaro.org>
Date: Sat, 30 Mar 2024 19:17:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] dt-bindings: dmaengine: Add dma multiplexer for
 CV18XX/SG200X series SoC
To: Inochi Amaoto <inochiama@outlook.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>,
 Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <IA1PR20MB4953F0FAED4373660C7873A2BB3A2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953DDD8E89675650E0E2529BB3A2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <IA1PR20MB4953DDD8E89675650E0E2529BB3A2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/03/2024 03:04, Inochi Amaoto wrote:
> The DMA IP of Sophgo CV18XX/SG200X is based on a DW AXI CORE, with
> an additional channel remap register located in the top system control
> area. The DMA channel is exclusive to each core.
> 
> In addition, the DMA multiplexer is a subdevice of system controller,
> so this binding only contains necessary properties for the multiplexer
> itself.
> 
> Add the dmamux binding for CV18XX/SG200X series SoC.
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


