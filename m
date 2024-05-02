Return-Path: <linux-kernel+bounces-166870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8245A8BA125
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5B36B21D3C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8371802BE;
	Thu,  2 May 2024 19:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWjwivL5"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB3D17B507;
	Thu,  2 May 2024 19:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714679469; cv=none; b=B0O6J8fPqrrHz7RjaKoJMb8OS0qW637fqXaymee4Eik44nXxWRlR3n1v57IUH7/OhjJD8g04yQB/EYkD4jfdKXmlFuvhYMFV3C3L8kgKQNJ5BgdVwz8BTNGtNXo7U+nC6TBhQTn9dnMPETIifGYFDixKHcKKU7EIJyrWPl+/520=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714679469; c=relaxed/simple;
	bh=FWiK0dGbKFr03CLSGRaUZUePCfPRUdEj6iROZy7l32E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IXmL6LvLwTzGTdV+YmvU0GUtdYjZcuLo+QZMIOzRDV+RDHPZonZ5bLLX1Hg1q6srUGPxLeK1h/ccLtF8bWVr02ORhJ8rFLWQmOza/6jj4KFfUGl/Cz2lyYsTw8ojS5ZTjkk1mr/0eH2S2WP9pWL09otZc6oMsOvE0p6OwbJXIXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWjwivL5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41c7ac73fddso41845245e9.3;
        Thu, 02 May 2024 12:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714679466; x=1715284266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0aGztHs3AzXvbd06Of34MGwgGFfC850xs6oX7gVaHTg=;
        b=YWjwivL5H1SX9H8e3nkO3NCBALrYPwV7BwSlbSYt0fKC7HG3XFHn2AB7q/0Md8N/0R
         Kfn7H9MhcVnq5gAp+Dlb73quSvEXnim9G5aYEpoPY578sb30Fno8CYHJmjEbtHB/zvZX
         Jqfpgr59xKsLQNICpohhml1YrSIsNa0xsVhiHPXqEa2Ayt72ynMl6QMApOf5LiBb+I3A
         JaMTEyonkFJ74+B8c2CrdLt0qKRF20OUHuXdtAbB1gxaYfXY6QLx5Cjtw365YKicGKtr
         Y+rEJY/eb83LFRMn5b/Hoa1DUv/2SKdynj4MWyHg4tkNkXAgBMHrGdnVw60CyLTXAGan
         AwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714679466; x=1715284266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0aGztHs3AzXvbd06Of34MGwgGFfC850xs6oX7gVaHTg=;
        b=rXgGjncR65SXem2DH8CQKOrULM+UU9Ct931itS0ktf9E28o2Yw2A0t6vfZ759h9RTg
         qjta6Q06u7TfZPr0E1RznAr7mkz6V5m9EtjFy+P9sbD9NRY33k+L3nzIjEHo2EnaD+Xs
         hlelxkbpvx5qsQcFmAeJrBTzJH+LOhgmyrLgM1fuAH59RshhwfZAbUKYt+irrjJlDR+/
         6Ev87mwBL4giYlyhgbs3azrlU+Ezhg+nSQ/jZw+vGuxFiKol5o+ZStCWQGJ4FaaVyKVU
         dcYWWmtIV3u8ydusoGoTKx5PAxoNJfGrayryuv4wGSRbVZ1K1DJvM5dYVfeVquFpMjMl
         NDVw==
X-Forwarded-Encrypted: i=1; AJvYcCUNyisy27myDTJRbuSneCcHzPNOZA7mXWAmbhlW8tiQcWVoRq4JPTYDPRzQcC/nmMoh3GdKse3WoUn5XlkQvDiI8WQuIetMGZoUwT0NCY7fodeMniJVXimrHQkpxyyBpCvy/F6turWBDQ==
X-Gm-Message-State: AOJu0YwBRFToi565/AZWpM+86EFT836SjKpb8qju8domQH0veBCIz+2p
	jNyX8Z54jHmFGNSJbsRneT+sML5GZpb6iSsZNfkGUFJvcdpHTCOC
X-Google-Smtp-Source: AGHT+IHHp6tBlSEk3uj3fBaBTxA7VzebiPhluCE+6GDZCwVg3xoENfDcGWY/jyX/qJ2MCenu21Qp3Q==
X-Received: by 2002:a05:600c:4454:b0:41b:d08e:8ce with SMTP id v20-20020a05600c445400b0041bd08e08cemr717600wmn.33.1714679465525;
        Thu, 02 May 2024 12:51:05 -0700 (PDT)
Received: from ?IPV6:2003:c5:8705:13dc:c5cd:ee6f:81e6:6614? (p200300c5870513dcc5cdee6f81e66614.dip0.t-ipconnect.de. [2003:c5:8705:13dc:c5cd:ee6f:81e6:6614])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090681c600b00a4e657a5f1asm872948ejx.112.2024.05.02.12.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 12:51:05 -0700 (PDT)
Message-ID: <4fe336f1-0441-4697-9da5-45a5f7a4007a@gmail.com>
Date: Thu, 2 May 2024 21:51:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: Allow RTT negotiation
To: Avri Altman <avri.altman@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240502131943.7292-1-avri.altman@wdc.com>
Content-Language: en-US
From: Bean Huo <huobean@gmail.com>
In-Reply-To: <20240502131943.7292-1-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Avri,

On 02.05.24 3:19 PM, Avri Altman wrote:
> +	/* RTT override makes sense only for UFS-4.0 and above */
> +	if (dev_info->wspecversion < 0x400)
> +		return;
> +
> +	rtt = min_t(int, desc_buf[DEVICE_DESC_PARAM_RTT_CAP], hba->nortt);
> +	/* rtt is 2 after manufacturing */
> +	if (rtt < 3)
> +		return;
> +
> +	if (ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
> +				    QUERY_ATTR_IDN_MAX_NUM_OF_RTT, 0, 0, &rtt))
> +		dev_err(hba->dev, "failed writing bMaxNumOfRTT\n");
> +}

bMaxNumOfRTT is Persistent Property,  do we need to re-write every time 
power cycle?

Kind regards,

Bean



