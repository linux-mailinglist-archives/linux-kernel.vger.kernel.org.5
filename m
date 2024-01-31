Return-Path: <linux-kernel+bounces-45987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD86A8438CD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520181F24260
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C645A0E3;
	Wed, 31 Jan 2024 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XE/sxfpW"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC2E58135
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689404; cv=none; b=jjxo1Fu7I9lFlgnzDXk//1WpbSpeWxPlMSEmcGNN+XRNP+RnwYvDjcNtObWZA0cmzMNY4XV4RXEgVTPGTi5gNI4sD7amskrXC8o541Uzq6/olzaINQbRJGsD3F19bBsIBcGZhfCT/T9r73Uiop7hfBvl4or39sTjOt6J6eHUtQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689404; c=relaxed/simple;
	bh=QgpDZve7ss1zcRxUslxn5XlDMDLXMO00RYq1sF7s++o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bi+/+s1wn+5KiNKfyT+ZTe9nulM2P82DJCZzJCGujVAo5Msmde15fb+FOODSONov8ID95xdmFlQRaZNWOnZMKmV3EGgBKn1PhDuUOfGYi4ABn/4aRoC6X2SO9VUHqUsiiSZq/cQAk+Pg6eBXzikSnPdsAzLmeMPAnEbx7PI6eTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XE/sxfpW; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55eed368b0bso1283059a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706689400; x=1707294200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6oWkXNQFc42njWrBrqxTcJGmHbVFrq7Z5uukN1LsJvo=;
        b=XE/sxfpWsQ12AT0mH8w2C2XdswqbmzJjdfIMsPqStUoTnFkcBsYqFuKJM729AY8KdI
         6REnoEqJha8LockcC0VQ9hIVL/Rz990rue1BrSGdnQM647txQxtbl+VSERoSZHQGRxyY
         DNSOS9Bm9Q48lkYcLBu6YSINF9D06D7hfEfN8IylFUeVJeq3yLaZ26NlQzGrcNMWjaUd
         RMXl8JCjqA5agFFtro1BMXTvtB0Aq743P2y5XWbkenpKRsZqzU+Z0VYeDlOmsREQGiGG
         06QqT8BZveUih3BDhCLdS+L8REz4wbXLu2qsg90xkxOeD5UcXlZ6JjLdpTtPcSIjGAEL
         2RcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706689400; x=1707294200;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6oWkXNQFc42njWrBrqxTcJGmHbVFrq7Z5uukN1LsJvo=;
        b=f8qYgzRm2uI7eYQw8LQ6NF5WucmPz+BbJvXqhgYm8kWmrNh4sRBK0B5Nf6y5szmYqD
         02XCN/LTbIp1xyFxvOmpJGCTDeUPq0/NKsabZQ1iw7nKQcR0UF2cOtziVSb1Hvt9YVtZ
         3G8c+l9psFY8vAVswAnHp50T1m+FPSbjT3WSSpTioil8MEQEDktldsr2U2LxzXLO4oAV
         +b592v5WG3UPngMG1llWo44dFbDp8XRfAsSo9bHNnECar4BiluHobfTOjonrDwcOe8L0
         Ezwd9pL0t+peqKI4EEj/+WcvuRm+2/PK8GA2666BvJJFlYQKuoG5HIOlGl1wKN35KOUu
         7g0A==
X-Gm-Message-State: AOJu0Yw3IGUOmtkVSEwho/CyyqeANkyIXgbDEAPgTk9wQzxhNQkYgprW
	JDXHygjWIvLgea5oyj8XRNb5CAbDe7jJ4OxVwDMCH1qPO1C175ZncpwPZFiXlpo=
X-Google-Smtp-Source: AGHT+IFxEn8Dm6TyE4moFxcJmW05ztFJmbBnpV/niDQ4vi/BEjobr+abb1wIm8azHmC0V+A9QHVTpA==
X-Received: by 2002:a05:6402:28a7:b0:55f:16d2:46a8 with SMTP id eg39-20020a05640228a700b0055f16d246a8mr908029edb.3.1706689400632;
        Wed, 31 Jan 2024 00:23:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVu2nf+laZjhpaHa+O8ru184W3wpyDEnU4Va2z/o1HE1L/WXlRM0zYUtFl7SyaRpyWcZNo4tT4Jf0gHtol4LBWQYND23+fD02nVFk+PV3rgCl7B8uupIOfwWIpn2cyOYSANaqBjWenBTY5yLAoWEf72TGunJx4klneb5BioPDl4OoD9Ox9i6MeH6/vOquQ/wvSbIUkb3GWJs56Y8k20S0A3asM1PNUdGmd9vLo6aII+SoXQEKvLOG28R3olr6ujST3ttXwTjAc4quOfrWwJ0D/in42SzdwpvvyOFICfZnLC2diQIw==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id en26-20020a056402529a00b0055823c2ae17sm5530662edb.64.2024.01.31.00.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 00:23:20 -0800 (PST)
Message-ID: <faba2666-88f3-491c-8edb-c844fcec1f48@linaro.org>
Date: Wed, 31 Jan 2024 09:23:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: mfd: syscon: Add ti,am654-serdes-ctrl
 compatible
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240130195128.58748-1-afd@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240130195128.58748-1-afd@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2024 20:51, Andrew Davis wrote:
> Add TI SERDES control registers compatible. This is a region found in the
> TI AM65 CTRL_MMR0 register space[0]. Each instance is used to control a
> SERDES clock and lane select mux.
> 
> [0] https://www.ti.com/lit/pdf/spruid7
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


