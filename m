Return-Path: <linux-kernel+bounces-48860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A8D846273
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84BA71F27179
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F673FB38;
	Thu,  1 Feb 2024 21:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEi55vND"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43C73FB3B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821633; cv=none; b=l2OBlDctNK6uVwjEDRaQatsD99Q/62KiGH7kWw6esTuIik2wlONanYahHiCO/qJNqe/9Ux5XVGo+9b3slFpnok3rC6xexTQvUemxWi/PKdiR7I2LVAjgCO88wkGVa6EwdTckM5LykDQnhFxOkZzaCcN7oIzUGiWbCDZaCrctBhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821633; c=relaxed/simple;
	bh=7EmwMioNxZXrojX8nMWHbwqJFpxP0JNO+hJYa0MADuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ngLtXyGPrFkwwPfAS8jbUNp9k2INHyxYDOdOt1gjtotMpzmwLxloLMTJtlQfH6P2O0J8IxtRhDXUxp4FZLtxSzEqWJpofYf64Ua+vqFsie+QP7qgTsX72bgYsTf60s6vU0WJ7WvljD2eiDC64xg6V+pWJL4xjzzaVkv7xjtujQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEi55vND; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-783cdbecfe2so40684985a.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 13:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706821631; x=1707426431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fNUsRQWJRD/SdtoJ06hRNIrvyVsnBVIIyaRokLoeu84=;
        b=BEi55vND3LUrV2s1JbOIuWw+n5ILiMRVwHA0GYo+mghMr/XLpBUyTDCurmOOeN24ug
         tUOUrZ2d7E4vVjmeIQDdZp4EGUHEtuDAW49ruzqFMp0dyzMwp00DrvjyxWjGdxfTgtdm
         4tWRw2AlK+CNJjJ7gOsbnkcncZa/Pn6MX64zYijhWX78kZDuoenxh2NhmHtxV+p83pKl
         F1pUu8nAaSVW4IvMgsvEQ7SIeI0CmaXoQ8P2m0xjUp+IRzzP/5pzP8a2zFyTamIRo1r+
         11eyAJ1epAWC3f4VXE7nGO0nFgWxYi/f0UWg7AYTooyQge/LLGEU/HHhrPDObZEN2XgK
         +jMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706821631; x=1707426431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNUsRQWJRD/SdtoJ06hRNIrvyVsnBVIIyaRokLoeu84=;
        b=U+6UBuCHpl4ajXsVprLCKFMSMB4/wqQlcu/JqEINgiNgF5Y+PVbikM1vaWJm5ffmoo
         1Uun3mN3IMm2mmvBuAe1MGMB0NpGaslsyqffGi+TMOc/g7JXawfYwvmM9ZEhS/A0NliK
         xSNhmnJ+Ta1qJynXQfvBrVeO+flZoqaiLSoZFYDYahkDTMa+7QndbA+xaW5ROeKmnTm8
         yZwPSbqVwGsnDJbVPoy0/BgVJj55c3ss7jvzRjdHYD+BnbXNKMStbcH4x3cPBDjGkElR
         cOznvHMB+7w6whRU89vKajbczTYncIULTI4ZU9ZTr7mZhWJAwgDdcTa0h78WI9HsLOch
         3oaQ==
X-Gm-Message-State: AOJu0YzqZQz5YFIkTCD+dckdiBH9Ahv7Kf4nBkdOiTrJL2rDWuHBNcrb
	4plqCqIE+5jzFYC04W+n6cpw1/AYusKCjG1GoLccZA3zQqGWGiEM
X-Google-Smtp-Source: AGHT+IF8oF0nC6tGdbCX6Sy80api5qcXhhwLPM6Yg3kdlboF3pSOM6Aqoeg2JcClHarMiturlUn3fw==
X-Received: by 2002:a05:6214:aa8:b0:68c:6eb5:c727 with SMTP id ew8-20020a0562140aa800b0068c6eb5c727mr3869586qvb.6.1706821630646;
        Thu, 01 Feb 2024 13:07:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUNybhWeQ64BmWfJoCjsJARxp+lYkniBeFdWKYSls90Bv2w36QA1aWymKsIFGufrTcCs9KreBmPrngOdQLathlLszNnMCoKbHwc4FtitkQ96Su2ZJ3sQmmnLk6xWBIUiUNbkxiYo3Igfw==
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id mk17-20020a056214581100b0068c7c91b04bsm126741qvb.104.2024.02.01.13.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 13:07:10 -0800 (PST)
Message-ID: <d2033061-2f85-4215-9d39-0c56da17cd37@gmail.com>
Date: Thu, 1 Feb 2024 22:07:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] staging: rtl8192e: some coding style cleanups
To: Michael Straube <straube.linux@gmail.com>, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240201081824.6998-1-straube.linux@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240201081824.6998-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/1/24 09:18, Michael Straube wrote:
> This series contains some simple coding style cleanups to clear some
> checkpatch warnings. Compile-tested only.
> 
> Michael Straube (3):
>    staging: rtl8192e: remove braces from single statement blocks
>    staging: rtl8192e: remove return from void function rtl92e_set_channel
>    staging: rtl8192e: initialize variables at declaration
> 
>   drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 5 ++---
>   drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 1 -
>   drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 3 +--
>   drivers/staging/rtl8192e/rtl819x_HTProc.c      | 4 ++--
>   drivers/staging/rtl8192e/rtllib_rx.c           | 5 ++---
>   5 files changed, 7 insertions(+), 11 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>


