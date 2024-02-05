Return-Path: <linux-kernel+bounces-52508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D5084991F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB9CBB28111
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EA6199A2;
	Mon,  5 Feb 2024 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMvHV16Q"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F267C18EAF
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707133415; cv=none; b=JYBpcaWzTT5zWBAyE7+VNzjBFCCqZRZfU8EuHEqcD30v8Q9S9vQCilHgCP6tLT8RZbscViNFxUehEgVI6uqznNBWegCcar24hbBstDBSe0liSLGYp0+UDDFuf8RhONTLYZYwRstTc3mgvji5JS8GR71/h254Br1l7pNF6WuwRuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707133415; c=relaxed/simple;
	bh=wWwZ9GWNRNWCcWG+8ePvvPv3KgWAFNUpak3I8orXiWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwzOXdjzz/uI95i7Ct5ZssQ/1HecZINEm/D7uot1ltmQFdCbO3oRV2uCZcCa9/XKNW7QECk90mxtaCin3ubK+cY7mR6bVDR4qjMaO+P5VW2txj5iUt0OYYlHOjIDyKhmNdNtPAjZewRZj0nOdFzInLUIc6EwKAZjwVlArdl/6TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aMvHV16Q; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55790581457so5965366a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 03:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707133412; x=1707738212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=27f3hv4hAG6ctBS++dx8DY5TqMQ3yEvRD1YTSrdrwXw=;
        b=aMvHV16QijJZ9ddxjQuaN5ZXvV7SIkQtCNRvxFNtkzDBeyEdn4eUx1MvzW2C0w0/Lq
         2j9CrvFZe4fizLIxkK1gqC8L0HTU5w+ZyhkHsy9UiXy6dfqVoMjGcmszc2nKXpVGKD+F
         rnLofrkGNePVAwvtY7OI2kNShPlagrUwaGnyerJQUnKrmb4g/ctrKbqQexHN61OKAHlZ
         PqevAUxQbSczX51PirxJfzby499gQXWv4oeNN/FRgPhLQUYEVbsSf+DH6spSkwDDVhc5
         BCj/+HBuTgnYz0K8/VvFR0S1mzfwszbIKgnO/NFjHGEBnjXVjX+M7g+YwtKQ5Qj/+/iZ
         2ibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707133412; x=1707738212;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=27f3hv4hAG6ctBS++dx8DY5TqMQ3yEvRD1YTSrdrwXw=;
        b=reMExPB5SmZXCaKe8I+dtP2njDEcsCLyNUOil8u9q7QAdDJ+Mg8pzV2baC6lk0Po/z
         y+t/0rVqZDE9a/Ah3x8E7Z8Joft9wDchFSHnKGWcTMglGskd+mjzwLP3/mAEROZDRqRn
         loutjcpn3db6NW3pTyQ3ICcWcDmL78iNcl2zhFv65tIwOXsKqntnVUYvwTjF94nLgAKo
         jIfc/SaYHWXxydefSI1vRIPmd6RhiYfuWNaj1bazFA2FTlOK3C0PRP6m+HjjdQOCSuoc
         bUqebYWlrS1FzrenH7IIC8rpSQstguTpwTygAk2pWrez8g8OqzNqQc4pLyPIFtmUohE9
         Y8JQ==
X-Gm-Message-State: AOJu0YyC8O9SUnTIs7ZkglegcYO7jMSX0UUNtZnirzQI18jYahNzDSJL
	AfMAimprOy7TGIH7Wu+vgIhQIbRSfggpu+Qni1MWBL7YDWfwiAJFRgZV5eq5noM=
X-Google-Smtp-Source: AGHT+IGnOn8us0S3/oMUfGTCyqEJpdJfvpahCqTdv4Pa0LRAXClIo1BA5OlBFM+//uIUy1uE8wTmgw==
X-Received: by 2002:aa7:d854:0:b0:55f:c253:a76d with SMTP id f20-20020aa7d854000000b0055fc253a76dmr4720222eds.3.1707133412048;
        Mon, 05 Feb 2024 03:43:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXJVS+Hyo99cSaa6Lh91etOpslemfUuisT4OaZpJmGJUl4h86CaQHzMbYzN9C2E5Q42DVzMgy2muI9BxF/NA8lHsrob+LFLvoOXyFjbgjLMgdf7kHpN5oS/62D7lusI079hMzgeqOylLNlxeOyYEI6htn3Wjol723kwQzm32RcdDNp6ScW6ohu132Tot112
Received: from [192.168.159.104] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id d17-20020aa7d5d1000000b0055eed463c4fsm3710310eds.84.2024.02.05.03.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 03:43:31 -0800 (PST)
Message-ID: <0e56c6f1-67d1-40d8-b0d3-9a45b1a3e124@linaro.org>
Date: Mon, 5 Feb 2024 12:43:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Workqueue regression
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
 Naohiro.Aota@wdc.com, kernel-team@meta.com,
 Bjorn Andersson <andersson@kernel.org>
References: <b3d08cd8-d77f-45dd-a2c3-4a4db5a98dfa@kernel.org>
 <ZbxK01xuA_FFWaE6@slm.duckdns.org>
 <17cae1aa-98a8-48f4-adf3-2ddfc451bef6@linaro.org>
 <Zb03LDPmMcBU0-Gj@slm.duckdns.org> <Zb__cFpyP3B2N1hH@slm.duckdns.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <Zb__cFpyP3B2N1hH@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4.02.2024 22:19, Tejun Heo wrote:
> Hello,
> 
> There was a bug which could easily stall flush_workqueue() which just got
> fixed (http://lkml.kernel.org/r/Zb_-LQLY7eRuakfe@slm.duckdns.org). Can you
> please see whether the patch fixes the suspend problem? 

Thanks for the pointer!

Unfortunately, it doesn't seem to fix my issue :/
I'll try to look into it more in the coming days, though my calendar is
somewhat wavy..

Konrad

