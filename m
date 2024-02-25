Return-Path: <linux-kernel+bounces-80180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2074862B67
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BCC5B20EFB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B475175AD;
	Sun, 25 Feb 2024 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tx5t9d9r"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD71816427
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708876889; cv=none; b=uOgudeylNEsGBubY70tyRj6pfkVAXe4Ey8LM511mEX4HsNfp/orNZwiuy7/5yPa+C5C6P+Tl6O8dLTbwG81lglVbPVIpIr/5/dZA7MvsXyWX1KktQGCxCD/IucpGHqa3IzkwyX4VroitWRhlwbHa2RCtNExlsEArORluyglFBmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708876889; c=relaxed/simple;
	bh=tzc3inzMBBnJRCFSdQFsBFDwAmTQGVCalWIpAZqpb4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbRWbx2tL2ZFU6ZWJce6fg9vCu7zkHTajGS48WXjiMJmjnj+yzOwatDwgY6as3JWiFkpaXlZ9zaqFjvSnrrIh/BXYKZEbDD05DCA6LWMwUzieQa7HVZqy6tvhHXELAmY0Gmwf+tMhLJpIvBk4Q724nFBmNZjdmXL+DK2FEeTZt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tx5t9d9r; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so3287004a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 08:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708876886; x=1709481686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Lh8/THgwGw55D3SYvQ4tVT4wl9yHcsf48kaa/ReQKE=;
        b=tx5t9d9rbdhHSDJ22dZfseqTBCMaxf2u6HrgLaVr1Qxe35moWKt/EDvbmvu3mrk+G0
         RJnnsh5zMV8VytjhAjfvJdvuxNFlNi4mcF4iJUckRGYvOoiS4wXn50qgQIQ4cHKGJqR8
         i6soDJIwl7x9smznps22M4cHCyRa+nr9HjeN7z/bem/C4dvRXPBTGkB3MI9MLVLrfAdQ
         1KKkyxhVKwAzrzB0OFMXJ9HTDJ54GhcFmhQglF8gvlhIFedCQybTgyUP9fVX0NOSoGe5
         V2b54l7UmHsXfUQbj3lEOkun4zcytFdUcaooHJgBh9GfQHatcG5Iwk2oW9VqZrNo5UTm
         Lsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708876886; x=1709481686;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Lh8/THgwGw55D3SYvQ4tVT4wl9yHcsf48kaa/ReQKE=;
        b=XEPWSqUn69Wqbvp/PFxesVqxG308SLqBfmxHuQnWtHYgpIvHCAYK/2NYPqer68KsKk
         fRaoH7WM4UIEeqKNarmONXPlxRkj8SSlt/iLJVuWE5an7lFfNatgyGOoYPAk3SjjgG/N
         TV/QaKlEwzjm5pXKqSLyWz0x2UJ8d5O8rIascKdt20yXQqZG11vzZYgRv2ueesG+M/o3
         eeF0mfqZMUxYKk5y31rjlHQVrTj5vWNaxYfsPhsqvrPh3F/gthnezKVmL6LJSfAtoWa6
         0oAy2EytZxdyixYzaVoK+gst2f/4tI5f6GdwIqDfWyQxQYtRHU0Sk8WbHGWSx6wW+n8Q
         eDAA==
X-Forwarded-Encrypted: i=1; AJvYcCXlhc6b7VWImIvYF9czPmPkZpSRmcow0zCMUy6pJD5Ui2LP2QP+FwDseCHS9yllhh6WPKtQvkyCtxe7GibmRjclkp66P7S+C2smagcz
X-Gm-Message-State: AOJu0Yz5H9gZW3ABdMJzTUaO/a3ChgzWrhYm3JIW4qmoHAXGcTrGjZhK
	dkZTGh/IiUYsOYfXY74kD7ecT7+utWZjvwXxohkWUFvt/KP06G0r4YFdSvNsux0=
X-Google-Smtp-Source: AGHT+IF+ubTsC8/SfgWb/dm7Gvisz+DHZDC6KCVOARscF3A2ASrzSWnLFyBviuiY0FAyujHvpfnv+w==
X-Received: by 2002:a05:6402:5201:b0:565:a5f5:84d0 with SMTP id s1-20020a056402520100b00565a5f584d0mr2761007edd.22.1708876886028;
        Sun, 25 Feb 2024 08:01:26 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id a8-20020a50ff08000000b0056524c91e18sm1531847edu.2.2024.02.25.08.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 08:01:25 -0800 (PST)
Message-ID: <f6d99b65-7679-4a14-bb4c-ab62aa45dd6f@linaro.org>
Date: Sun, 25 Feb 2024 17:01:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] clk: samsung: Keep register offsets in chip
 specific structure
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240224202053.25313-1-semen.protsenko@linaro.org>
 <20240224202053.25313-11-semen.protsenko@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240224202053.25313-11-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/02/2024 21:20, Sam Protsenko wrote:
> Abstract CPU clock registers by keeping their offsets in a dedicated
> chip specific structure to accommodate for oncoming Exynos850 support,
> which has different offsets for cluster 0 and cluster 1. This rework
> also makes it possible to use exynos_set_safe_div() for all chips, so
> exynos5433_set_safe_div() is removed here to reduce the code
> duplication. The ".regs" field has to be (void *) as different Exynos
> chips can have very different register layout, so this way it's possible
> for ".regs" to point to different structures, each representing its own
> chip's layout.
> 
> No functional change.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---

Missing checkpatch --strict:
ERROR: "foo * const	bar" should be "foo * const bar"

Corrected and applied.

Best regards,
Krzysztof


