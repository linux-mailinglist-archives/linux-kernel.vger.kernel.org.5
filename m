Return-Path: <linux-kernel+bounces-66552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D915A855E47
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9987AB2FAF6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05201BC56;
	Thu, 15 Feb 2024 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8xrrJvJ"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EB5182BF
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989567; cv=none; b=nDEMneysxkEu2W5UwC66OoOX3/ha7A6FAJ5/54f3BP1xxgZsSdRBzlFZbPlkaImGTPCWZM4eC0koPuIGnUrhZsZ0s0rKax5DtjF9h/KrUWUGsWnopEJFDyUSgD9wWe1YwdrxjaKr9X+wwnea3DDmVwBUdCfGWdESgXLAcxTqcYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989567; c=relaxed/simple;
	bh=Omg4acYujtdeRawCGb0RTHxJLjrGqaPKUU7KovSJhpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/JYCjjzjpp+XRrxaDZ4CX4JCz9JZHctAe3wa48+dVuKdUSz++zZd0Ah8k0n//2hZkSluYgEOk+9/B1CwNZtJ6iDPUFg+1aQTIH3OZkbnc6gLQy7HL0WMDXuyGrfBQ3PY0fLawYMz+R0HxjhH4D5pIRLolZ+DLoZLMBOFr0wnWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8xrrJvJ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-563bdf132f8so32580a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707989564; x=1708594364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kg/5u3u8BHpzXrjgfyC49Sj4UVynox8lvULasQKi+Xs=;
        b=a8xrrJvJB21dWg3bY5NJCS7AhIQ9kdFHwvnYAyU9XT5RdL5lmIO+TQnDH74MZ7lGVR
         ZgBs0llyY6UtdgMT2GsdKZG4xpccFNmAlzkeGiES2ojqNHQVSLLYIaT85xw9KGpEqgnW
         DM2x15YRP+d0RFjEzvvPCjwH1FSQ8KK06SqKaJkeGKVbZa2vmpTbew35IU+cOlEL7bQH
         5Ucib2T5IO8YVLOlnwM5/Nfsgfz7gS9CikhsHCsqua8oNiL291YOKkEZTeAwIRYkAH/6
         sT8cw8h7U2LV0VF/AQ+qwhI/FGZoB+/XKcDql7O2p+yyYizxPKYI9bzimQZGe53UrCmc
         SS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989564; x=1708594364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kg/5u3u8BHpzXrjgfyC49Sj4UVynox8lvULasQKi+Xs=;
        b=h+KQVNR/QiJ4LNziUMhchi4yAZLLi4sgFaUvlU5pzaiWsY6idhOrDvF3AD/frCQwjb
         lsy/ZVDSsqm2DwND1Lhn8MDFhS2cYB3KCTAy+M04rTGTIbW73OTvcV+QTLSQzSXfs8Du
         +WLo+wVMoiYvqHg5iyhkfqoMQVKrhlH9VcPj1M59PAxrhJ/o5G3rorUSRbpE3nmm/uZn
         yF0beWZ9S74XjnRotQAur23oa8ZOjHGcMd+evlINwTAJrVN6UHdPSxkBmPAU5ntKYvz4
         gtQCXGAJ8RJa0s+LxS7HJTnaAfNK6NdmjKnmtHYSmNbO8fPcwyJD4ubscC/A/ioc3UXO
         0PMA==
X-Gm-Message-State: AOJu0YyXjTM3iZqJJ4y6Ley+qQadki1wrsatGCa4lAgqOp0XgV95W3Qv
	ryqyCEZCm2q987wekWxjVCK5r/alYFDzluqL0nGrWdOeCrtn2teb
X-Google-Smtp-Source: AGHT+IEcIgt2Iqxx2tsbVKbYneFYaBxEmNZ14WV6xTenuRe50DQjP6SUkT4XxX/DOObJtd/XCGhboA==
X-Received: by 2002:a50:8d11:0:b0:560:1f51:80f6 with SMTP id s17-20020a508d11000000b005601f5180f6mr808912eds.4.1707989563363;
        Thu, 15 Feb 2024 01:32:43 -0800 (PST)
Received: from [192.168.8.103] (dynamic-176-005-144-062.176.5.pool.telefonica.de. [176.5.144.62])
        by smtp.gmail.com with ESMTPSA id z10-20020aa7cf8a000000b0056399fa69absm364316edx.26.2024.02.15.01.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 01:32:42 -0800 (PST)
Message-ID: <817953da-12ee-4720-aef1-725d07c2704e@gmail.com>
Date: Thu, 15 Feb 2024 10:32:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Staging: rtl8192e: rtl819x_HTProc: Removed braces from
 single statement block
To: Aaron Parfitt <aaronparfitt123@gmail.com>, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <20240213074649.18158-1-aaronparfitt123@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240213074649.18158-1-aaronparfitt123@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Aaron,

looks OK but can we make the subject more unique. Maybe like this:

[PATCH] Staging: rtl8192e: Removed braces from single statement block in 
ht_on_assoc_rsp

Or is this getting to long?

I propose the description to be like:

Remove braces from single statement blocks to clear checkpatch warning.

If you change this you need to make a v2 with changelog.

Bye Philipp

On 13.02.24 08:46, Aaron Parfitt wrote:
> Fixed code style issue
>
> Signed-off-by: Aaron Parfitt <aaronparfitt123@gmail.com>
> ---
>   drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> index 6d0912f90198..49b882c363bf 100644
> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> @@ -480,9 +480,9 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee)
>   	}
>   
>   	ht_info->current_mpdu_density = pPeerHTCap->MPDUDensity;
> -	if (ht_info->iot_action & HT_IOT_ACT_TX_USE_AMSDU_8K) {
> +	if (ht_info->iot_action & HT_IOT_ACT_TX_USE_AMSDU_8K)
>   		ht_info->current_ampdu_enable = false;
> -	}
> +
>   	ht_info->cur_rx_reorder_enable = 1;
>   
>   	if (pPeerHTCap->MCS[0] == 0)

