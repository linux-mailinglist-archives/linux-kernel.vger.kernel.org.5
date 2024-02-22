Return-Path: <linux-kernel+bounces-77137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C0C860194
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831311C2499C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5817F73F2B;
	Thu, 22 Feb 2024 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8DLwu7/"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82F973F08
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626430; cv=none; b=KMwW0tS56RMmWY1AiM9anCoOBdwKbyukk7GbZbkjiCwLcD3Aqtgj/pMrwxKFtfUyoVY7+eTivJm69ZDHYTSVjwrCD5wG6j2fZtRvJ00iZ89uVYjkiY0cPkUnj4MMgkLS7nZ7pgUPP8Qyk9wwmdnFDPtOdGenw/IibTagkoQXdPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626430; c=relaxed/simple;
	bh=LV8HtBqn41W71/wptU13iMdkCr07Gl0rd2NcdD58NUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hq9WxYA1k4b3i3TYw8LCa393b8NnvcI17qDt/Sas87BWfcSYnk1ZRlz7hi1KzWvQZnYwNyN06zAly+rpYq78WnH8DnYUYVHbM5y969Dj3vND6Pr2OsJfuI3zsM2SPl02k7HlTyy8Sxm/kMK9tVuvp2haCtKIcDa039+eG1EjY60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8DLwu7/; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-563fefa2718so1565373a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708626427; x=1709231227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eyx7F65SZjO1tm+DpSvBE8Mi6jfraaN35m+DJYJ1cBI=;
        b=h8DLwu7/GxagNOHsVl3KVplRhw6oOj3Zcmxbw+i8YmjofBQahEnLCxmYe9UDAsAIaC
         rbUMNpLWy44+5ENN2lu6VwY1YMp6Xixj997faBwDNm/WNRox1Rq08uCpwD9voF8ZGc6+
         OgT0KOSPq/sFIeYoEo2qIT/shl+fBNZCBxo4Bx3RoPcwfCSlRwXImYN3bqss88pAQLa7
         iRjWzLLDeQJU6j8veZeA/FlJLdJ0fTUf16SJcp3KpdDhGJ8E7FOkxWDh4h0ITAuxSDgo
         30zBkzA66WDaEGJ08q3EpuNrjbvIP7wSg3h3d+ZIxR558UmoTk8RrxMKsQMrDyQgleAJ
         xckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708626427; x=1709231227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eyx7F65SZjO1tm+DpSvBE8Mi6jfraaN35m+DJYJ1cBI=;
        b=kcSA4e8MKixQoAzdFOxMzL8IHi9MEm2iX/Tmle6ocuVGcyxAEY8XdWQEU+VPvqzcfR
         zrxsKUQiyBVLOmqz/y6WRNKaDnBE4toE6gWsRMj6tdXLAqH6NVZAC+HwyKdbe+PYI4Ij
         7WcPi+nGMMIMdrYH9ywPaajijSk+bedr+2Ogw65ho6oPGQM0y/uLIPb80pVgSaUJAlsW
         GwXt3gNrasBYPm8vcPFo7PjwqNkl+3BuoWAD4ePVBMFZS2PLMLcH62//RvuPEIF9Uviq
         B+9Hj5t0ff3xE7Blwa41PDmN1qG6Y4xvglvUzaMahozmrZPImstMlNj7GTuuC/dRvjV3
         ywDw==
X-Forwarded-Encrypted: i=1; AJvYcCX1vqQAzCvfhk1NlWxwT6wz+DKCqaLs99a4EWapQdPraAEGbiyX8sPG7/v01i79CSXo+/wAs3bHYHnry9GgJ9DWU7/ZX9rMyyvWMmjX
X-Gm-Message-State: AOJu0YxzY4BxVXwfqkvQAnsElKqx+rgJ3FbtzcV0wMi78Mkv1D2WPaw2
	5zHdMxH8+R04zJViQB/7ZJIxkgyrrSc3HlM3n0JTCwuCMmYvQJ9C
X-Google-Smtp-Source: AGHT+IGHHFpoDc4CySdIhMn/8uybwBQBnI2V5nsV/IbUg/ZZTb2r31N7tftTS97jKI0BFqK8KTyEAg==
X-Received: by 2002:a50:d7c3:0:b0:563:fc40:6268 with SMTP id m3-20020a50d7c3000000b00563fc406268mr1928928edj.1.1708626427262;
        Thu, 22 Feb 2024 10:27:07 -0800 (PST)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id cf28-20020a0564020b9c00b00564761ca19fsm4048192edb.29.2024.02.22.10.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 10:27:07 -0800 (PST)
Message-ID: <a1924b54-d878-485b-a842-68c6837bfc20@gmail.com>
Date: Thu, 22 Feb 2024 19:27:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] staging: rtl8192e: coding style cleanups
To: Michael Straube <straube.linux@gmail.com>, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240222112723.18428-1-straube.linux@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240222112723.18428-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/22/24 12:27, Michael Straube wrote:
> Another small series with coding style cleanups.
> Compile-tested only.
> 
> Michael Straube (3):
>    staging: rtl8192e: rename rateIndex to rate_index
>    staging: rtl8192e: remove empty cases from switch statements
>    staging: rtl8192e: rename enum members to upper case
> 
>   .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 64 +++++++++----------
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 29 ++++-----
>   drivers/staging/rtl8192e/rtllib.h             |  6 +-
>   3 files changed, 48 insertions(+), 51 deletions(-)
> 


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

