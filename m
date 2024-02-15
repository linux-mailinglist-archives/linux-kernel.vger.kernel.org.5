Return-Path: <linux-kernel+bounces-67615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C84A0856E11
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6842FB21D6B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475E213A885;
	Thu, 15 Feb 2024 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7c0rTvE"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F3913A26F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026803; cv=none; b=MwK9JbzVP4/dv/Lj+9bbbgPIZ1GqaBLS0HCLJ94oxO1EjMiSo/ufpf2OZJaD4AjRBHd+4P0kJKWjFg7+UhTyDQGisEQiXeuNx+VruEGHw4rmyQF4G2ZXCe0v2gigVw2c9IihwhqkOZFH9ESqVC2rqrPJfpzHYrPGA3gT3ppv+iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026803; c=relaxed/simple;
	bh=bcaDsLqllFV09FolTRkyNclQnzrPYm9pxiVwZqFXlxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7VNkld7C2bArrp/8xOVBjG/iOQgQK/mXlDf9+GMqfmQtna/kE2N/pDLPbn8bj2K++rG9XZMMXSuI3oLOT8jseEMeku+E8jwYLt2rPxPaOhRQsxI8kzSUkALL7NmK8jV3AXKNVegUtq+FD92VilV5kbw8GcrLYdSrSkTCpWtex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7c0rTvE; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a28cfca3c45so50013666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708026800; x=1708631600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HRrM47UslnlmuRTWOp2JJ1DzYUX+lqfl80GleBMNoms=;
        b=h7c0rTvEZ66D0bDMRgIU3MpmNl9qYnyYUmyns8KTGghREb8qXgBPjd8oNfJeLOP3C2
         zohP1WoO8CsYpZDacrkXcOYyUyPiPDr36jucCOmnUCIQL2tZMqrVKI8nIReMKuzqVaQn
         24vVu3gqAiV2u9NMf2amFKVwSIWk6uxxNSWv5J1W7+d/XA03tfNfl9PmdrX2etf6WZUx
         YkvF2HOgwpTe3f2Xs5EQnqJJcDcCw/cgti+wdCQ2WXRu1pTFcAguLN8D4ujlncRskmu8
         sdiTv5lyrz0b1m/8a/walT1fkql8ncsd2pXZWeNHT5myw2qZTajQenjd8kKSL1vYYPl8
         biKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708026800; x=1708631600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HRrM47UslnlmuRTWOp2JJ1DzYUX+lqfl80GleBMNoms=;
        b=VqecL84ouNsbyTvzg1zY7zbFAX7l0XeI71iKE7Ua8Cvbr/jS+vL3+apz1W4ZVGOFdS
         YdNskD+ckuWdADqa4o/lrWaZ3qPku6++Akr5KhJvz56nNXW6aNkZfccD8FQyG5fu8Ic3
         HtrVbJpgcXHkFEuE0dY1SQCoFYCfphuoIJKsIR5w1jtZOmmRC19gJKMQpUx9astYZeDk
         ze15LswW2yMltVbi7kEA1MbhSy12yT9cstfooImkAxbZjkhGlkWkX4eAgbbVtceJ6Uiy
         zhQAhzk0hfbwsmLOzjqIgBGUaE/2WfMUCeXAHkLZaehRDztHlTzpEug8dfLxhY1XpMV7
         KXQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIyV4ueSZ4FCGB73xs+n5/AHZOiafxKp9jVQ1XlgPPuDNtszlbIKI+eRw0ADaRU1tmjK6QyoRPr/4c5dXNwImYK1AlZDqWl269qFuK
X-Gm-Message-State: AOJu0YzCSY7MIVSKgaIrsrZcaYH2PB6aUEcSyFUQbeSyWgRzod+w7pd+
	y6NynYEDf2fku1ir05jfDFIZdj4DeyhFWNT9Bsxk2AliyRGbudc6JLK3l//2
X-Google-Smtp-Source: AGHT+IFrbXXnFMFs4ZsfYJIQAS0fwvKvf4po1C9yMYTHgnBhTWAAiq2QJgYhY6SqNJwbC6uB6bsh8Q==
X-Received: by 2002:a17:907:a709:b0:a3b:b56a:e711 with SMTP id vw9-20020a170907a70900b00a3bb56ae711mr2513531ejc.4.1708026799964;
        Thu, 15 Feb 2024 11:53:19 -0800 (PST)
Received: from [192.168.44.127] ([185.238.219.72])
        by smtp.gmail.com with ESMTPSA id f23-20020a170906085700b00a3d70dc4337sm854509ejd.102.2024.02.15.11.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 11:53:19 -0800 (PST)
Message-ID: <f8f19cf1-6b83-4fee-92a0-b9934a0a6c64@gmail.com>
Date: Thu, 15 Feb 2024 20:53:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Staging: rtl8192e: rtl819x_HTProc: Removed braces from
 single statement block in ht_on_assoc_rsp
To: Aaron Parfitt <aaronparfitt123@gmail.com>, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240215194045.37205-3-aaronparfitt123@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240215194045.37205-3-aaronparfitt123@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Aaron,

the changelog needs to be below the three minus "---".

Look for examples: https://lore.kernel.org/linux-staging/

Please omit the changelog line with my name... that is not relevant...

Is the length of the subject line within the expected range?

Thanks for your support.

Bye Philipp


On 15.02.24 20:40, Aaron Parfitt wrote:
> Remove braces from single statement blocks in the rtl8192e staging
> driver to clear checkpatch.pl warnings, improving code readability
> and adhering to coding style guidelines.
>
> Changelog since v1:
> - Updated the subject line to make it more unique and descriptive.
> - Refined the patch description for clarity and conciseness.
> - Incorporated feedback from Philipp to improve code style compliance.
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

