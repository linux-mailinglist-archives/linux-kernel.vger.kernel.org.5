Return-Path: <linux-kernel+bounces-107706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9F5880080
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E44CFB20DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE55657AF;
	Tue, 19 Mar 2024 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r1L4cwO5"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254B6651B1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710861891; cv=none; b=MMTpa3QOjjbD1LohIAjECLDx4Gzaev/b2uwqt7LMFwluMWxndIxN63Z0Wx4CN6a1Qsu5PQzJaszKqSZPeI43YXEU7ghN5OSbRSQH0RrYYgxYGeP0s9OB/CygQLWe0Yx5+YGtS2RI7Hlu+accgxx6nt9H1JjpeM+JMIhgdMD6yk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710861891; c=relaxed/simple;
	bh=lIytFHbbynF0ymPcC7goQip8SDsqtONTI2YWA6WZ5Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tB+cZo8Kb598ANwlGRqQU6p90s3Xt83tK0tODaSPRFQHGbGTgaQgNkXzM6b+dsfXKOGgGqFbeCkpKyIha1dXtOt/PeIon3H7UluRQRbad7oWFDglRYLBqlOFbrBz6DD9wsAVhbgO3mHMqFWlpuFP36elByYjcLMeDDVAz3g8+Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r1L4cwO5; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a46aaf6081fso414352266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 08:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710861888; x=1711466688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kOmnXFbjjE4szNevNMFXZKUt1lQSXyLP1LD1PrVAQ2E=;
        b=r1L4cwO5/yDUu/LQnkqLrTxC9nOybOjZEc0eXPzxFSuRSFCA9najUxc5cIlDKdiH0g
         N5STwFDzhp58D88edjb1ymfmu6kLO2yQgrE7mZWoApgCQOXbgkMJiIJM/S8+IEoDMM33
         mIXHns6Lik3A7iL8bCcsL8pX5Dnn5eLxSvRlv8SClRTQ0gkgJ3LIy9zrMbaLzVgkpW9/
         TMSnG8MikJnGMAE8p3poZc1IqoWnxmJtmERHMka1QH39YUpegj7Ypp8eq/DVY3VbX16w
         auCkyxzumdCrh842LwuYK/5MH6jLdlqoRFX9V9HMjQhrzT3hUIDAUu4dosrS748fbfgC
         uT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710861888; x=1711466688;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOmnXFbjjE4szNevNMFXZKUt1lQSXyLP1LD1PrVAQ2E=;
        b=XbkhcMsCZyJUZHpE1dOvLGGhQjsyyHf1fGgIHhS13ZKzy2XRktFOn4x5yYNcycqgKZ
         9f/r1fai5nqgDIJAM+9u4fyquY+HFW3aECU8GKYBqPJt6EBm3XWVZ35mW1P9TDtyw6zu
         7DYll9IhwBP3+RX2+39lVRA8SxZFjRKvj3AHwedFDVPFqI/zhRf17Zmy5VVzj8RKQtVX
         mx3jkawEqmfB/WTbkCBmpEw95+XtG0t5rit3oZnh/NeqzPvvx5OQhyhcX5+Wvh0tHMLI
         q3jomTY1Zboukc/i+PC+G1zdemp/HdSmOkLvtkQE7vXnHpLKT/KgnMRWMXOJ+i8q/jCM
         tKTw==
X-Forwarded-Encrypted: i=1; AJvYcCWoTLNNr563K1zbJBOSt4tGByVeTkzrzzt63JhCbxlkQziiaPpQHuSkSIjQInndZxX7L5TRr0gMnB3eH/JG8izZ7qEvbY6+kA15ZQ+I
X-Gm-Message-State: AOJu0YwtquUsWLn2HW9+RDCmpJr/DxKhIYc2uDkDjEto9Il7062XdrP2
	qJWPxp913n9S0netqEcJGcCw8c2/5zy4XUa+9Aw3D8zH4L/UTpmrEmfw9f0hFVE=
X-Google-Smtp-Source: AGHT+IHTYuFBC+LcDF+FXQ6e2/Worpo6eNOG9VEW5amG72ngZAdrH+oLoVookfNEjJvS4++i5dQt+Q==
X-Received: by 2002:a17:906:b7d3:b0:a46:c8e6:b825 with SMTP id fy19-20020a170906b7d300b00a46c8e6b825mr1790305ejb.26.1710861888426;
        Tue, 19 Mar 2024 08:24:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id dt22-20020a170906b79600b00a4669f6c2e2sm6149478ejb.44.2024.03.19.08.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 08:24:47 -0700 (PDT)
Message-ID: <23692c07-98bd-477d-b244-bba14c50352c@linaro.org>
Date: Tue, 19 Mar 2024 16:24:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] virt: vmgenid: Add devicetree bindings support
To: Sudan Landge <sudanl@amazon.com>, tytso@mit.edu, Jason@zx2c4.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, thomas.lendacky@amd.com,
 dan.j.williams@intel.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: graf@amazon.de, dwmw@amazon.co.uk, bchalios@amazon.es,
 xmarcalx@amazon.co.uk
References: <20240319143253.22317-1-sudanl@amazon.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240319143253.22317-1-sudanl@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 15:32, Sudan Landge wrote:
> This small series of patches aims to add devicetree bindings support for
> the Virtual Machine Generation ID (vmgenid) driver.
> 
> Virtual Machine Generation ID driver was introduced in commit af6b54e2b5ba
> ("virt: vmgenid: notify RNG of VM fork and supply generation ID") as an
> ACPI only device.
> We would like to extend vmgenid to support devicetree bindings because:
> 1. A device should not be defined as an ACPI or DT only device.

Virtual stuff is not a device, so your first assumption or rationale is
not correct.

Virtual stuff can be ACPI only, because DT is not for Virtual stuff.


Best regards,
Krzysztof


