Return-Path: <linux-kernel+bounces-84979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 131CA86AE70
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4296F1C245C6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87B61493BB;
	Wed, 28 Feb 2024 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rMzOs0Ng"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CF27351C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 11:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709121143; cv=none; b=WWGuWvhYkxwc194xrxRG6h3MDEVQsMCAGbgYjL5fpvJDlYUPNItg0mT2c9Rxr8Hep+3SuDOPFruP59JLEdMHwAwE+s4nr+N+lBmr6oVg5rQADlMh087HmdbwQZLD0slQa4nioKJIkL6RL9oUXIrY1UI5xPPDfibnRvhOyLeS7Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709121143; c=relaxed/simple;
	bh=3n/Qsn9eEC88y1T6J/WAzonTmx6UamA/Qs6tg6Zzozs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kndBBwsRFiy3PxLoZSiV2tIXPxNzNeEu+3OG+ykl4SuPl7wCLOiUDj2/Ekpk8bO1/4rUw/COkokLDvvXC1T+dC5pFwiMzZOHKsrwlFSIxQlXWN6oQt7cSeajOwEMIz5ifonsgYhMYoIBfss00ZS7ScQLvVAPXSdWl6RMOcAyEUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rMzOs0Ng; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412b20dc555so6935345e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 03:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709121140; x=1709725940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0bkVtbcoc/EdAlN+I6+oL1+CCziM/Me6KnKW3KLACdQ=;
        b=rMzOs0NgbYU6OzQizbGpZvbE3jkLlc/cjxxWKs3WEMahM1r92b8V5IBoB4cb/UQweb
         UD+lnDPmzbP1yE9CyhCx21RJqcqGFsvnieDZgkmuhldTQAZxSJQO2pWFl2o/pWflLDS/
         2Jtq3JOiq1c6vROIz8HnhhbP02cY2k6fXbVlfjiivuAxWZAGi0F2aUzzCWqcCzKXFuH0
         7Y/f/wnPSWu9kdWx5uDAkETQGoTV+e6Eg8MnHaFeDIwJ7sRPCaRe8nXhv3xT6vTzXL/0
         tkX/fcUNVd/hR2etrOlrS1MQC5Js12RbBizjQc0lgur//3qybMgB8K60+o3X77LQQqma
         UNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709121140; x=1709725940;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0bkVtbcoc/EdAlN+I6+oL1+CCziM/Me6KnKW3KLACdQ=;
        b=Lik7ugox0FhtvUON9Ent0zY4B+CxhDfBWlHQsEsu+pUAj27lj6psX2IV3bJv9BGqzg
         LoFR8ZK013JGTOgoIborz5rg1HfXnyMhOR1ryZ1qP12Qmji3UHhnz1no/44VjJ4wnKos
         irRM2CsVow/4S26OhKOEUbSKoovmdyOjey/gzp5H1p7QiKmuJRGtmgyxOAS44Q5Ssfgb
         YjWfF7ytFufVC6V6Yh/pzpUpdXRUWrYK/zbt7V552iSF5v3q2+LFfrl6l7J2GEMZRCc2
         Bjn2GnIuQpY1G5grePIAQ0KBzaV8n48/CKk1BB8YjED2ClLiEDzOlg2b0GIXRIE26hwq
         Z2QQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7J7Jt1/h8i6Ng8XbzT7LJxOR/aLl69TwQ7VWs/N5PcsVFfimq/ULX91Fx4y7j7WNZJEcAh1OUWtwUzL+JX3TGh4cgiZ7MvJJ4xekM
X-Gm-Message-State: AOJu0YyuCwGTaj/zoFIa3jGBK3bX2Ln0gyFGbDA6yvX999ho9dlJV3Vr
	EOgB5UjTINBdj0HIoXYj/hvOXLevHbbS9lh9CBZdhVp0bpxqtwLN2s9qJyOYuMY=
X-Google-Smtp-Source: AGHT+IHh3XwNm56x8VVnZGWgAiXBjtGnlYCa910zzqHzwF2XAr5dKhzjRTtYlEXsuysr2PU3mQ3FJA==
X-Received: by 2002:a05:600c:34d2:b0:412:afa6:cf28 with SMTP id d18-20020a05600c34d200b00412afa6cf28mr2732380wmq.30.1709121139750;
        Wed, 28 Feb 2024 03:52:19 -0800 (PST)
Received: from [192.168.169.175] (58.171.88.92.rev.sfr.net. [92.88.171.58])
        by smtp.gmail.com with ESMTPSA id jn5-20020a05600c6b0500b0041228b2e179sm1853771wmb.39.2024.02.28.03.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 03:52:19 -0800 (PST)
Message-ID: <d44026e7-5ffa-4906-9b59-10fa207ecd51@linaro.org>
Date: Wed, 28 Feb 2024 12:52:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: sibyte: pointless if tests
Content-Language: en-US
To: Joe Perches <joe@perches.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <2cf0b77f51b907969ae83993854773961b4e159c.camel@perches.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2cf0b77f51b907969ae83993854773961b4e159c.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/2/24 23:28, Joe Perches wrote:
> A checkpatch modification was suggested privately about
> braces around an if test like
> 
> 	if (foo)
> 		;
> 
> so I thought I'd see how many of these possibly pointless
> if tests exist.  There aren't many.
> 
> Here are a couple in sibyte:
> 
> Maybe this should be documented as:
> 
> 	"well, don't know what to do here"

Or pr_devel() / pr_warn() if you want someone to notice it :)

> 
> $ cat if_semi.cocci
> @@
> expression e;
> @@
> 
> *	if (e) ;
> 
> $ spatch --very-quiet -sp-file if_semi.cocci .
> diff -u -p ./arch/mips/sibyte/common/cfe_console.c /tmp/nothing/arch/mips/sibyte/common/cfe_console.c
> --- ./arch/mips/sibyte/common/cfe_console.c
> +++ /tmp/nothing/arch/mips/sibyte/common/cfe_console.c
> @@ -22,8 +22,6 @@ static void cfe_console_write(struct con
>   		if (str[i] == '\n') {
>   			do {
>   				written = cfe_write(cfe_cons_handle, &str[last], i-last);
> -				if (written < 0)
> -					;
>   				last += written;
>   			} while (last < i);
>   			while (cfe_write(cfe_cons_handle, "\r", 1) <= 0)
> @@ -33,8 +31,6 @@ static void cfe_console_write(struct con
>   	if (last != count) {
>   		do {
>   			written = cfe_write(cfe_cons_handle, &str[last], count-last);
> -			if (written < 0)
> -				;
>   			last += written;
>   		} while (last < count);
>   	}
> 


