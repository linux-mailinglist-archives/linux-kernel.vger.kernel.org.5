Return-Path: <linux-kernel+bounces-59087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CFC84F10B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 597DEB2873B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B8465BB5;
	Fri,  9 Feb 2024 07:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mRi7WvEw"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C6B65BB4
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 07:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707465027; cv=none; b=VNjtSRkkUx3KdtYM2mJfquq+u7RYS7QICLjOBvXVMHNo01HvV9LzJtr0+/sSIVjkqJ/FcqY3Fddnshe2oQmd3i+jMdVvOyyUUp5+XEYLRDF1d5H5v2um5HBFDB0A77ZfYIsC93pDqZyZ7B5x2hdZljeDuFRyENaRaOEduOWQq3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707465027; c=relaxed/simple;
	bh=RRPYwrR6fwrQ2GsoY9DxBuCZFaHlWVUInsoL/A4eXi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBcImhQPlcCDryRDMaRPq0gmqnU2wC9BAQDnKtdwuz+3M8GjYESTEKJae1yy1++ECZXNmndZ0c9SJkRd72z1eZnnq6aTJu9m/CmVLuo9O1tdVygmHjKv9LIxFrA1OruR3Zx/WMVeqUNPS3CowThIoQcBP3h9iBk0JZtm4vyt4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mRi7WvEw; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so5447405e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 23:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707465024; x=1708069824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/tmPr4S1GA3wVBKp3I44e+CzH/GZVO7fOynDcglz+g4=;
        b=mRi7WvEw2EN0GU2zET5D/mUcMTVow9UfNdC5Hkuk/k9HSJtJfWaOb3GY8eZVbhTwW+
         DEdt8cqh/2H4Vrade4Wmcx6MqIeUX6HOYyF6RcPHo5YUld7/WUMBt/O45iAemMMTy4Nx
         A1OcD4idMEp6Nv3XreqzLfCyxpyD8WSv8H1Tq7gWB6mKeySCoY/KIAJZrT2YyxCk1R0s
         it7P7gr0j5XO1zVQ9wP6k/eIQ2qe8FFc1xojK2D/UTMVKPAQZWYzLeZYiMywx4gXpG9Z
         lIO79MvyPAKf0G5yGfemkoXH2nYbl2BgT0WhZnsEuJtRkK4smBrahZtGCryiLGknr0Dk
         RQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707465024; x=1708069824;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/tmPr4S1GA3wVBKp3I44e+CzH/GZVO7fOynDcglz+g4=;
        b=wSknl9ARwenAaD6udHTr11QBJpE8SJTpb+4a9Eh7jstERNYjJTmgRwddQuGLNUodsr
         3nVcbih6nlXfLTa9mdQ0UsjL7Tr6vN4oIIuJDID7blWtdG+TC7b33BMU/hAOSRfHwAao
         2u3NGEENFRBcPSEeeedA0WFcEIAfF/DZuwwPaqsxuJDMaSht5uCwE4P2UbSVfffrWw3E
         KAI3NIhEmWA3bK/cVh0NdFIJ73LQx+xLWBADMECa8LXCdolkh6MS+UK2+XuzysDEgJ9h
         5foyeFvBsNfqMq33y08dOJx6r5oM2WrwlcjpEg8ps7zpAeNGb0yrhll8TCZRgXhbZ6z3
         rTyw==
X-Forwarded-Encrypted: i=1; AJvYcCWDKwzQw+XNTubyQzUtK8Hm9EkCTk2+YLl4aZanQT886OtdezR8D0cHLsPSheRVPevvEfJvyYswQzopGN1Pkosmjc/IMxKQTf8pbI4x
X-Gm-Message-State: AOJu0YxdloJNQub4d6kSOXa5X3SZAVyO31NidwbrP3/lb6MVO36G3fhG
	KccVNvrbpZSBwGZ+oNZkjAHLZEv8QpzouXqd3FFjWMquVDAAZ2vPbFQIEPYY5gs=
X-Google-Smtp-Source: AGHT+IHOTH5Q+xcX+xqUBWMcMjecND2EEmLkiiGclhrl41KMDNiKkrE+N+QlZFJWWZ/sd3FJXpQekg==
X-Received: by 2002:a05:600c:1c89:b0:410:709e:f242 with SMTP id k9-20020a05600c1c8900b00410709ef242mr393812wms.2.1707465024069;
        Thu, 08 Feb 2024 23:50:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVnmmTYcSdPpmnWReAXzwGMvW8W+nmAgxrVmjBNQ+qnPUOMpauv19Kp5xb/zqawoZyJ3vgzAeU5wkjgUVZa/Rr9rZItlZAT7X4xMb/we6BdvTZCqmyJG+cOkw6Xsn6nj4yPrdg45gAZx0WFtzQ/r1egylwagP/bA7YU+s2ry2Ydsf/HfEkB3qj7rd5ilCH2Q+0IOE7JaV2F+LmjQLdU3F3Iojy26QK8HwluMd3aKnK+3euQeH4ajG5axPsiqqjCGqFi7jqLZMDafekVQ92H+zZHiR/l15xHfjUwUMe+Rq2Ez+eQ6DvIRYHm6GJJ/fZtKufjkvyLo0lzNSwTWbkFDPvtLhiDW1hIP2LLAqakVutM+nMYHMj1UVIPQRynDVt7RD+1x7vQy+ujGRcOVOq0uRJ6DIMp+RtbuMRpbg0FraMNphPBrK1xRz10ZIIvWNfInrfIsKNkx//OhFLMr/fUb2wDD9bQieW3kvY6PVUF3SnssJQO5HeFRSG1ndZl+5I1Zu3+rT8jfzpV+XhgFqGNKJcV1L0SF0AzET0fBw==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id ay2-20020a05600c1e0200b0040fdc7f4fcdsm1791764wmb.4.2024.02.08.23.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 23:50:23 -0800 (PST)
Message-ID: <3746a7ff-0b27-47f1-b4e8-cb33f6cac12f@linaro.org>
Date: Fri, 9 Feb 2024 08:50:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] dt-bindings: arm: mediatek: convert SSUSBSYS to
 the json-schema clock
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
References: <20240208215926.10085-1-zajec5@gmail.com>
 <20240208215926.10085-4-zajec5@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240208215926.10085-4-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/02/2024 22:59, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files. Introduced changes:
> 1. Documented "reg" property
> 2. Dropped "syscon" as it was incorrectly used
> 3. Adjusted nodename, "compatible" and "reg" in example
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


