Return-Path: <linux-kernel+bounces-79182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5695861E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56031C2243D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B202149391;
	Fri, 23 Feb 2024 21:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bi+ot12s"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00FD1482F8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 21:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722657; cv=none; b=iOFvVltEFLesfQSqxsy7+gr1n7z8ulmos6Te+I9V5k+qJLphzH5QHInra2vFyo1jmJ6WcitIh+m2gXlTYQR0szmW+exO2QCvboaAUXiIf/flqBfUCYqFS7NfX4PUNBe82Sjgh4U6s9nA4Njf2Jl80AB7OxBlmL0voW8W4DhS3kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722657; c=relaxed/simple;
	bh=zLfaBPQQ/PChVmxN6vpfoSLBNRdvKq4jQqRP2+O0sUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omRLwpU+SFR7f7jATPukQ0m2MQlYUUBfLMNpqqfKa9JOpHpsq4Jgk0Pl663Ue6JWvRnO2EBA5DLEfvWYg/mAHBgU7DB1dfWU8ViPLbwSgxvd5t7togxz/xsLl9v+BGAOLsy9ACZEYGIrKKYsKM3vvsisE3cE3tEtDYHEL73+7PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bi+ot12s; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3e75e30d36so240386666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708722654; x=1709327454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=brDT2YXF8x8KzS2bAH7c1UHxnZms6mIqOBc2rPT/eec=;
        b=Bi+ot12sSPPWiJd4UxeO3J/+6vvUyvvisiqqoYcDUeQAzCQLAxY092awLenxUlOBg3
         HdiKbrwdvHpuV+LAxIFWd5XS7H8pWVp28WYUGsNGM2kDZZc7+Ki/XuqbOf+E4x9MzcUE
         dihyW1LbOApegVhIo95SSdSYeMIBUhqZbhqzCR2F/gyhszSJLQ7MGFQrBKmSR1oUyHmC
         ibDdrto7Wc2fyByMNf3fyZ+deelZ9jAQ3D2SIz0Pzw9BtkgOKEDGmwSlDlp69uYCV6zo
         /Wn8KON55XRwd6IFFIVgNIxndOQgMJi9JFUEx5cRMDBjfoATE1iAWx8sOKbvJq4BAl4y
         pwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708722654; x=1709327454;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brDT2YXF8x8KzS2bAH7c1UHxnZms6mIqOBc2rPT/eec=;
        b=siW8oCS7iPP7Vv17kRWyDPTW7LXUr3iAQwBnCJZ8ogbJ8o05gMIRPW/XBorUwgLwpN
         dY3xqwUBBwF6Tc/MJX1Q1lmxaaI3qSZXrfH5XcSaF3HSUDzE+6/YLy+bGya1Q0UfBSmP
         YbIw1OAPQUwovElLUczl4uudSnxsfQyTudzEkhFnDfsxqouVTxkh5eZWuODnuTMpN5BC
         yT/gtYHsU3SC7YX4B3Pgy9KQeunVkSsAngZsFHgiZcaHe7yRhSBT75B5TSbSylVW9FVz
         hgNjzDMXouynnvcYCPvcy9o05PXKvgjID8WsyZTHYZXHNIZ+UBidDYshMxz2+Io4Uhkw
         BWeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzaVIzxqJCFwHMKWJ6AGbZtjw/LsAF05Np+pWA69YBn0lL96FbTiK0soxc/vQIY9mgXx2m0woKGTH9Pt8g+VEl3N3nvGqqSz2192tl
X-Gm-Message-State: AOJu0Yzuk8miJmwJMEq8PeeDudnsTT5wK8ahIDqlyxhOcdGxIaegFEeJ
	yb8FEhl5+gLFFsqXKaFVgmeCEV0iXdFVvrbiayz7BEdae9YWjVGoDsQigTB3mtU=
X-Google-Smtp-Source: AGHT+IENyNqGiyGuCGeSB03nxXbt7g7grkwi1tJiTGl4k5p72DlF2FORlui6OfziRrMuxknRyi5GsQ==
X-Received: by 2002:a17:907:b9d0:b0:a3e:cd8d:39c3 with SMTP id xa16-20020a170907b9d000b00a3ecd8d39c3mr781477ejc.38.1708722654037;
        Fri, 23 Feb 2024 13:10:54 -0800 (PST)
Received: from [192.168.179.2] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id rs6-20020a170907890600b00a3e48deecd4sm6313016ejc.222.2024.02.23.13.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 13:10:53 -0800 (PST)
Message-ID: <a3356079-bd55-4852-9bb3-b5362a1c953e@linaro.org>
Date: Fri, 23 Feb 2024 22:10:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 05/35] virt: gunyah: Add hypervisor driver
To: Elliot Berman <quic_eberman@quicinc.com>, Alex Elder <elder@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Murali Nalajal <quic_mnalajal@quicinc.com>,
 Trilok Soni <quic_tsoni@quicinc.com>,
 Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
 Carl van Schaik <quic_cvanscha@quicinc.com>,
 Philip Derrin <quic_pderrin@quicinc.com>,
 Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
 Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Fuad Tabba
 <tabba@google.com>, Sean Christopherson <seanjc@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-5-1e9da6763d38@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240222-gunyah-v17-5-1e9da6763d38@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.02.2024 00:16, Elliot Berman wrote:
> Add driver to detect when running under Gunyah. It performs basic
> identification hypercall and populates the platform bus for resource
> manager to probe.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---

[...]

> +
> +	/* Might move this out to individual drivers if there's ever an API version bump */
> +	if (gunyah_api_version(&gunyah_api) != GUNYAH_API_V1) {
> +		pr_info("Unsupported Gunyah version: %u\n",
> +			gunyah_api_version(&gunyah_api));

Weird for this not to be an error, but it's probably not worth resending
over if it's the only thing

Konrad

