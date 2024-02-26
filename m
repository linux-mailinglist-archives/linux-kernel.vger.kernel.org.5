Return-Path: <linux-kernel+bounces-81999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CCC867D8B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C31C1C27DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38677131747;
	Mon, 26 Feb 2024 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6SCH6W/"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B625113173E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966649; cv=none; b=ryp8AYJqB+Pqat/5zV6kz8U0Yxuv9WaCzo+zqLnVsI3DfABzMXyMz2jhff2jlAkpnRmixWXAIr1MmgL/K82zvOTYA2myYDcSxDeJTlciqVkPD3BcjO+ecjdepwweEYnlUngHvDkwYJQgWGpdt54ZoSPLrz2f0X7RorAMFNlAD60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966649; c=relaxed/simple;
	bh=aJ68smvdUhAemksJrXi/fVDE0y74bVnXu1fKZwDgaUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pp04KJJXUMIEY1f2ss0vEsHZj/xq5XmdtCXPgVzvB34+v6sihsddwJnBcf5HVkIjV6U11Q8EpBkmKaHXuPOBJj5IDU1RTC3MldWkuxH1hAFtnMQYeUK7Ulv+gSejwlQdb9oE/GefELKi2g9RTHEpKZMUjajHYQvs3CIGhBmkUiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6SCH6W/; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33d855caf7dso682538f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708966646; x=1709571446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7FUUzYRpWlE/uC7gYsXYypoQ8pTl8AZIEHC0lk+2G0w=;
        b=V6SCH6W/T2K4Mufv9N0wSFhmiVYiNGmTfuUTn24dVHGpabu/7viiYkIfmIJ4S49VNs
         SOLPoWpjn8K4ZizZRHzGuSY3OrwyDspexOdl5+fUui+66C40fZcrEtL1VYs0CGvEiXNC
         rhhY8AYHt2lI3Vht3l21XXUmswZKhrGihCzvVmlkp9G81DI85oWwwuFbxmPf6OPO+9BE
         T4+cDN2psq+/JHE8cArib9yP1FQ11LNZdIkZoKZK09ks+6Omw60c171TeRvQ4ORUeWxx
         38Z7tZXIZxConYB6RMmuLxBttnMM2ZYb9SmV6I2y48CC7gru21tXY+ZxypzvBaOlCGT7
         ikTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708966646; x=1709571446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7FUUzYRpWlE/uC7gYsXYypoQ8pTl8AZIEHC0lk+2G0w=;
        b=hxlLmcgQAPgyx0EpoLXwMwMRRRir/BksPzq9SqOk2Hm/31XrIt9R3cagE8pb4v8gOo
         C8UmqqJsY115cTfjNoBd9ZBlSqjD4GhPOApcny/mjjSXuNNOOJF2GPXbp5rkhjmalHUV
         lpZnYhexD3x/vgPnN7kYC2A+3S39UHPbd91Ss3G9m9hNNx0MOjVJkRdoCv86FTU0fr3k
         ZDLJYviHMJbJJwNqDHrsb0vxSSRaamNikslcAunlwQlm5zhZYsf2GL/K2LgxmeZ9OfjU
         UsYSAU/lokmQFbABsk+IepLN3/2BK9uddl/tpvFWtbUywxTs38ivy46px4t4qCHt/zM3
         hBUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/roW5P6FP+bQWYHM/POlPfGVq8fyYDATKv/ydzv/HsHJk9ZdH3rqFYashPhkR0wUHkCBr7y79W4Vsyc/+K8f9cQ1oXRRszYrJw9SJ
X-Gm-Message-State: AOJu0YzzI3N0aDtpOicWZy2OhTRjOT2jtHab3mIlaXgxNeLOUmjIoFDI
	3VGvyPj++qBOrx2zBqRC11z0ue3VRE4xfjGAN4ggScjv0hknd4RTMrxGpg0BWak=
X-Google-Smtp-Source: AGHT+IHLw90iyN14oEJc7WiZp425r/pRSyRV7jZAGjdsZqUITNpewOwpnkk20eDcibcyiSXPu5kXBw==
X-Received: by 2002:a5d:5a1b:0:b0:33d:297c:911c with SMTP id bq27-20020a5d5a1b000000b0033d297c911cmr6296712wrb.0.1708966645888;
        Mon, 26 Feb 2024 08:57:25 -0800 (PST)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id m26-20020a05600c3b1a00b00412a5cb5a76sm3097244wms.23.2024.02.26.08.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 08:57:25 -0800 (PST)
Message-ID: <535eb04e-19bb-4d64-9818-7fc28195b9b1@gmail.com>
Date: Mon, 26 Feb 2024 17:57:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] Staging: rtl8192e: Rename function
 rtllib_FlushRxTsPendingPkts()
To: Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
 anjan@momi.ca
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240226035915.370478-1-tdavies@darkphysics.net>
 <20240226035915.370478-8-tdavies@darkphysics.net>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240226035915.370478-8-tdavies@darkphysics.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/24 04:59, Tree Davies wrote:
> Rename function rtllib_FlushRxTsPendingPkts -> rtllib_flush_rx_ts_pending_pkts
This line is too long.
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit 
description?)
#
> to fix checkpatch warning Avoid CamelCase.
> 
> Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> ---
>   drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
>   drivers/staging/rtl8192e/rtllib.h         | 2 +-
>   drivers/staging/rtl8192e/rtllib_rx.c      | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> index 0581ed1e9ed1..04f3fb54d1b7 100644
> --- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> @@ -268,7 +268,7 @@ int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb)
>   		goto on_add_ba_req_fail;
>   	}
>   
> -	rtllib_FlushRxTsPendingPkts(ieee, ts);
> +	rtllib_flush_rx_ts_pending_pkts(ieee, ts);
>   
>   	deactivate_ba_entry(ieee, ba);
>   	ba->dialog_token = *dialog_token;
> diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
> index 05abc001507c..fe850dbeaa02 100644
> --- a/drivers/staging/rtl8192e/rtllib.h
> +++ b/drivers/staging/rtl8192e/rtllib.h
> @@ -1810,7 +1810,7 @@ bool rtllib_mgnt_disconnect(struct rtllib_device *rtllib, u8 rsn);
>   /* For the function is more related to hardware setting, it's better to use the
>    * ieee handler to refer to it.
>    */
> -void rtllib_FlushRxTsPendingPkts(struct rtllib_device *ieee,
> +void rtllib_flush_rx_ts_pending_pkts(struct rtllib_device *ieee,
>   				 struct rx_ts_record *ts);
CHECK: Alignment should match open parenthesis
#40: FILE: drivers/staging/rtl8192e/rtllib.h:1814:
+void rtllib_flush_rx_ts_pending_pkts(struct rtllib_device *ieee,
  				 struct rx_ts_record *ts);


>   int rtllib_parse_info_param(struct rtllib_device *ieee,
>   			    struct rtllib_info_element *info_element,
> diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
> index 051371e0138c..be0f92e97d12 100644
> --- a/drivers/staging/rtl8192e/rtllib_rx.c
> +++ b/drivers/staging/rtl8192e/rtllib_rx.c
> @@ -487,7 +487,7 @@ void rtllib_indicate_packets(struct rtllib_device *ieee,
>   	}
>   }
>   
> -void rtllib_FlushRxTsPendingPkts(struct rtllib_device *ieee,
> +void rtllib_flush_rx_ts_pending_pkts(struct rtllib_device *ieee,
>   				 struct rx_ts_record *ts)
CHECK: Alignment should match open parenthesis
#40: FILE: drivers/staging/rtl8192e/rtllib.h:1814:
+void rtllib_flush_rx_ts_pending_pkts(struct rtllib_device *ieee,
  				 struct rx_ts_record *ts);


>   {
>   	struct rx_reorder_entry *pRxReorderEntry;


