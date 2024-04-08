Return-Path: <linux-kernel+bounces-134847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B3089B7CA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0E91F21A96
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C72124B2F;
	Mon,  8 Apr 2024 06:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ESUw3Lpq"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A85F22EEB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 06:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558596; cv=none; b=qWiJgxsYIhIIk+RDmFW/5JI85s4eBPBrtklx8rNvN1XuGaDZQAyjaGGBhA9Ig/dHyuutFsVzsqOz34TrGVPvTvtygLZuuHKTcJtcV4Ck1nEjTZPIAmEgZGtoIQcS7gyJKzI6xKzF3N1Wqq2XPBqjdvMITJ9WkxyrIKMup2SSd5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558596; c=relaxed/simple;
	bh=OjdribcLA53Fwz+JeLKxDPhNrfDqxuIAbAzbCzubzsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBRPip5qUMLQNixo4KZa6DtCwvP6dcz8BULT9H+UvwighSdfjDSLWAhyB4lOFfe3qJBJ0csdxJLBXYp/n4JfF7fdE3xr/+4H+k6EBV6whneMe3E8ZDilgxXtza6oRhW2SkV6EJY7P9O31ucyDxYrRNQlDT80h61+bFL88H5Osos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ESUw3Lpq; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516d756eb74so2759153e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 23:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712558593; x=1713163393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Fs4Rab7i3Fc1NzrGJb0B7jUp6L1AV2eL+J1xyNAG8c=;
        b=ESUw3LpqcTHEMwA8AKDb4uapw3/HglbqiPZkdYuqq7H+ehHOp4lmu/C1CpMZOOBP7U
         CF5lDOmjSuaPSK7ISwBNYUpCN/aBvxXG1V0b3ZRzhIJNHmMIGa4EXI3Paj1yYkFfM+Rc
         d26R+TDKJXD5pCt4qwk93PKvlxunicGQxB3+ZMQwRVFfHiOc/vh4q0EgYR10AvNo8cLC
         /EeiOIO4hyCZeYNbcLTlkBQAHBEsfnM3+q8M9Q412JaVPSlU2CYeAYoPc3nL7eUxdfpI
         38nPfVZZpniH675Vh2KX/c2lDlWpNEpCm26fCRW0Ve+5TeooA4uYsqi21CzdEWxVR9bR
         fFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712558593; x=1713163393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Fs4Rab7i3Fc1NzrGJb0B7jUp6L1AV2eL+J1xyNAG8c=;
        b=QvRekSK4UMo7e4LX7omkydlaUIcqiZYNTQnsT7lWcK1LZSjqRsJEv0O26tz6QHR4M7
         iqd9kC8QQ8I9kh8TcTx4rty44UgAGSjcj1gSKH3hEVxLbVBdS8L7gaEMfzP3ng3NaAqp
         0ZeX8awn+E/9+vBY1GNOac1wOCiJwIzQZ6GqwAEhQ0mor5kXFSygngPcvAzmomK9qc7X
         zdKo/fNLT/KOk8V1lW1WxtGh9vOc7hyhgdnF5DZRqtJJ1NDKetJBn3nx7LiZ42ZVXj19
         zSP7rfHqhasvKfMPcb6OIkGPdQMhkzKJ/jvQXG3W2hIEb4CJTNIvinZ8uNdPSZUVoNQM
         YoMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKBFSG45TTq/sRbQhua27+X1TzwOY4ARV4RxZu1tGA/8fTAGapuYLSqLB/i8N0Pyl6+wrHszbpPdysUBNrxxfb4Z/ckIbaXnvdbsze
X-Gm-Message-State: AOJu0YxnmA8Q9LfBhH247jlWUwy/P6kEh3mcAUK2Ru/SyESqy2nKnslG
	+eePrTVG77NuGx6PWm9jgHNeVF8mKEY+/NmlpTOcVVRlSwGy32JfmK87bM0Ko9z5zkM6SUSY2+h
	D
X-Google-Smtp-Source: AGHT+IFVxgw3525GrzEaS9/BcvCjU2asTXaT3p4GSsxVHGdjvPPzgt4D2pOpgLM8/eHDX3kZl/3d2A==
X-Received: by 2002:ac2:5508:0:b0:516:ea55:324d with SMTP id j8-20020ac25508000000b00516ea55324dmr2056505lfk.31.1712558593140;
        Sun, 07 Apr 2024 23:43:13 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
        by smtp.gmail.com with ESMTPSA id dh7-20020a0564021d2700b0056e53920717sm1707418edb.8.2024.04.07.23.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 23:43:12 -0700 (PDT)
Message-ID: <d0ab6420-bab8-4584-ab9f-b801845ad0ff@linaro.org>
Date: Mon, 8 Apr 2024 08:43:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] MIPS: CPS: Convert to use debug_ll facilities
To: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240326-mips_debug_ll-v2-0-b64abc76f2a1@flygoat.com>
 <20240326-mips_debug_ll-v2-9-b64abc76f2a1@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240326-mips_debug_ll-v2-9-b64abc76f2a1@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/3/24 21:35, Jiaxun Yang wrote:
> debug_ll replaced CPS's custom NS16550 printing functions
> for dump early SMP bring-up exceptions.
> 
> This will enable CPS debugging on more platforms and also
> reduce code duplication.
> 
> All exception name strings are prefixed with CPS to help
> identification with regular low-level interrupts.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   arch/mips/Kconfig.debug    | 52 +++++++++-------------------------------------
>   arch/mips/kernel/Makefile  |  1 -
>   arch/mips/kernel/cps-vec.S | 16 +++++++-------
>   3 files changed, 18 insertions(+), 51 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


