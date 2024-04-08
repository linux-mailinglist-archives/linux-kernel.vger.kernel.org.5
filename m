Return-Path: <linux-kernel+bounces-134856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B4A89B7E4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F5C1C213E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26CC25761;
	Mon,  8 Apr 2024 06:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q/xJHQc1"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3796D2555B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 06:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558911; cv=none; b=E/ShzAQdRgwFi61QH6Pcf7gpSHki7ok+kba6uMrv5vYjp9LiLlNEETfqEFr9izNE9NWLiKAenjW2V/w5BWgNjt7aS7KuF2BSrzzj+r/hJXQ3fYiGVDrYX8l5rBu5NWNoHVxOi2KmZRNCg+3neVS0ImICFVHY8S5tTTZChrRM02k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558911; c=relaxed/simple;
	bh=OU1pRHykJNQWPgpCgYdU2lGmCV6FTUuwq9rQvP2sYhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjtVoGs1qs9JVpNduUrWgNl8Ne7IYmxvNLzTmaIWyFHZww8FQNxdQ+sCvjxZ9Cxe+2fjOUD3pRg15hiexHsEAz2NJaWSI04wm3WRzh28LPbh9XW1mUK6Tk+4SwKQ914roXIPLIfEi3wCTlHA2po53vzAOo2QYE+pPz/0wyq19V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q/xJHQc1; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-344047ac7e4so898511f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 23:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712558907; x=1713163707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tuU5HrPX6/Kq0AAOmjh7ZjsMPB5kwQSkhaeRztpCm5k=;
        b=q/xJHQc1QuF0fTHECrNqbFcNdD/Rlu3XJU4h9/3kGer1JsIayYhnZx6KA7kAKi3g91
         HFnkV5NpaFYn2IQLs5F5qZd+jK1kRvcdwdKnOUvRpm56sHnbZLwtMTr5MTrr8TDBi4m5
         v7JNh3NEDBHrkcB9Hr93cML8a3yqY2lwGxbTNGGJDlQQoQKSDU3rWdLTyP6X6UHQc1Pu
         8k9FgTXcVHlV68nM177vHNaYrlpK5Q1QnyASZFIg65dp3/rp5DhldFvYrXyQOr6ju3Wq
         cTiIP/gPKAcqP0mTZGViYR9SRNP2mLYKUyrx3MFSaZPTH0VEbhmxL5JB/54I0NiJselF
         gGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712558907; x=1713163707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tuU5HrPX6/Kq0AAOmjh7ZjsMPB5kwQSkhaeRztpCm5k=;
        b=GyR6WbI4mPB+deTo0hSMlluEPmL91Wgbr4IqxlYRggYhpx5ZoDWX2a65KKSEJT/ZPs
         TueB1oac3gdM8xk1Mg9Q4WjCXV8mb9XX+ryyUqPPJU0uVlCw4nCVNUYWj94FFS5gZ2gO
         rbph63vHgcLfR98b8v88bxvq3JylWuyQqFvZQ/E3zRrPQlZDsnzN+BKHxy9saWA/P53D
         KTgr+JXx/8zxtm8ziDGsycGRXiRV4AwHejoB3XhcJlJiubVED78uHW9Ur+83QSp1/azZ
         wj69jZTCFGx3s/CRZ1VZX4xXXfnGMQpo+dlemJWmxk1l5y12+U4v4O8XJGmLVk2ugE4P
         mkgw==
X-Forwarded-Encrypted: i=1; AJvYcCVRNTDoCYmoij9BVLz7PGQVVrje2j8Xs7w0eEo/3kVdP/PBlPzcp/JGHugcnc1zP32kqGQ9A3MZIDpqXRDfWZiSN6DQErRYfRCgJwkh
X-Gm-Message-State: AOJu0YybTceOBdqTnzz+XWxO/g75ayY8EOFCeAQbM55Ml07ZR2T24PKc
	VcIrZHIej0RTw44CSUJWZJtK3NID/VRL3FFu3u/p70NqVHXBOSkz2g5ODjdEHes=
X-Google-Smtp-Source: AGHT+IFuDq+ccGHmbG7fv3EvroLMgrV6kfESSmdPeTxgVIpyPWXvrl+BI/YV5UJyMZ/ex2qQ/EZhNw==
X-Received: by 2002:a5d:64ea:0:b0:345:6010:6343 with SMTP id g10-20020a5d64ea000000b0034560106343mr4165761wri.6.1712558907695;
        Sun, 07 Apr 2024 23:48:27 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
        by smtp.gmail.com with ESMTPSA id d6-20020a056000114600b003456c693fa4sm3915426wrx.93.2024.04.07.23.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 23:48:27 -0700 (PDT)
Message-ID: <2654580f-aeac-45d9-b838-8d6cf8605bdc@linaro.org>
Date: Mon, 8 Apr 2024 08:48:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] MIPS: asm: Move strings to .rodata.str section
To: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240326-mips_debug_ll-v2-0-b64abc76f2a1@flygoat.com>
 <20240326-mips_debug_ll-v2-1-b64abc76f2a1@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240326-mips_debug_ll-v2-1-b64abc76f2a1@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/3/24 21:35, Jiaxun Yang wrote:
> Well, they are read only.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   arch/mips/include/asm/asm.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/asm.h b/arch/mips/include/asm/asm.h
> index 2e99450f4228..05a158a8920c 100644
> --- a/arch/mips/include/asm/asm.h
> +++ b/arch/mips/include/asm/asm.h
> @@ -94,7 +94,7 @@ symbol:		.insn
>   symbol		=	value
>   
>   #define TEXT(msg)					\
> -		.pushsection .data;			\
> +		.pushsection .rodata.str;			\

Nitpicking, \ is now misaligned.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   8:		.asciiz msg;				\
>   		.popsection;
>   
> 


