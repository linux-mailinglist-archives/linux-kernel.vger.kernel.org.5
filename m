Return-Path: <linux-kernel+bounces-92870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38637872742
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3C11C22A95
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC6124B29;
	Tue,  5 Mar 2024 19:04:36 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDB51BF3C;
	Tue,  5 Mar 2024 19:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665476; cv=none; b=DyQiuxARMnPh02TUa4h4EitPmXcKLX4/c/MZZWNgldfv3cSxfesl2fHZGTfr1stMLM7vVdJB1M6kXo6exKKqFsO1Flxq0Bn6gVOL1ip553QlG5Lr89A9bAuCaHFsoyyuqolqee74pqU1wQdziaF4KbBi4Q7DAJXzfJEZIt8/Uoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665476; c=relaxed/simple;
	bh=rLNadQH124qkvis5G8T5Ibj9jxNp33uFHpoXpJVOMkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ESv4P0/SYRiVPp0sTi0IKoJw8gJdb3lxeJCt/hJM7x5SipCc2+RIUJa1aPXPGgXO1SVjF+vrvr20idO/duK7L98WJnLYi+4OjFKzVyqEl514Tm12No0ldzf/Z9kCtC7l2JiXjEnt6vGMl2ICkkgNxfhBzBu8aUyeqx2AiUovrDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29a74c88f74so4022311a91.3;
        Tue, 05 Mar 2024 11:04:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709665474; x=1710270274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22MPWwbM3zhSE10kK+4F0IeX95NXlBV1KV/bo2U8AfY=;
        b=vt6/zQsfhbUdqT+1IKfAFfT0bkVTytsg2P2bir4aM1Xe9Mqzf0m8vTzBdvZbHPR3Vs
         NqfVK7PLTl4dzp6BPARD+DRU++gnAlxQrhUQxIXECYqMiJjpVi9x/FdrBoxSuR3b00f9
         yIgyYmd33RDzTRwqbiAA+HsGmB5gPOBHcw5xHGkx4Swbx7zxylvvUniai31crjjzahj0
         VorGGDBR7QYpcT8UKEkDhcdbRttoGy2D16/6J/AZGyzfwtlzGXt4dGSjuvN+0e3w2NBg
         k96NI91MGWLT5fnu/edhCf+zQ3Oj13AHiD915XIDhKWKRS67o75ZuDkMI1YljiUdrPqi
         q7TA==
X-Forwarded-Encrypted: i=1; AJvYcCVMeQtwlcKmJOQFzRUMbSiJOLRHmj3a5wgQWAx+JaNLTSnxNoaTOBZJWepUPk8jFpfM1RY/c854f23nLX5leCHk6Dcg8Y90U4UU7GqA1TH6zq8C8gK5L/HxYUMjEdB+8vdIi+hpJ47GIQ==
X-Gm-Message-State: AOJu0YxzU3unzZpjno+IrMvQjFfwsijzfWT6bIUORcS7UFw3gS1mRkbg
	nagwn7kpAPKvbTspO8QGZF3HNdeoyGNZ3zSyaTm9+/IvLu8CEFaL
X-Google-Smtp-Source: AGHT+IGT1YCGV1vjwrx6h0SEn3DJvK2qWVOsrijPQkE7dEHsjCiUdp8ItY0MTp+lElJS3fVrH8FvZw==
X-Received: by 2002:a17:90a:17cb:b0:299:3511:1554 with SMTP id q69-20020a17090a17cb00b0029935111554mr10236225pja.40.1709665473853;
        Tue, 05 Mar 2024 11:04:33 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:3e11:2c1a:c1ee:7fe1? ([2620:0:1000:8411:3e11:2c1a:c1ee:7fe1])
        by smtp.gmail.com with ESMTPSA id q40-20020a17090a17ab00b00298cc4c56cdsm13167208pja.22.2024.03.05.11.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 11:04:33 -0800 (PST)
Message-ID: <f6045888-bb53-4ba2-90a9-98fc6a5254ad@acm.org>
Date: Tue, 5 Mar 2024 11:04:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] scsi: ufs: Re-use device management locking code
Content-Language: en-US
To: Avri Altman <avri.altman@wdc.com>,
 "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bean Huo <beanhuo@micron.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240304092346.654-1-avri.altman@wdc.com>
 <20240304092346.654-2-avri.altman@wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240304092346.654-2-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 01:23, Avri Altman wrote:
>   /**
>    * ufshcd_exec_dev_cmd - API for sending device management requests
>    * @hba: UFS hba
> @@ -3291,11 +3305,6 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
>   	struct ufshcd_lrb *lrbp;
>   	int err;
>   
> -	/* Protects use of hba->reserved_slot. */
> -	lockdep_assert_held(&hba->dev_cmd.lock);
> -
> -	down_read(&hba->clk_scaling_lock);
> -
>   	lrbp = &hba->lrb[tag];
>   	lrbp->cmd = NULL;
>   	err = ufshcd_compose_dev_cmd(hba, lrbp, cmd_type, tag);

Please restore the lockdep_assert_held() call.

> -	/* Protects use of hba->reserved_slot. */
> -	lockdep_assert_held(&hba->dev_cmd.lock);
> -
> -	down_read(&hba->clk_scaling_lock);
> -
>   	lrbp = &hba->lrb[tag];
>   	lrbp->cmd = NULL;
>   	lrbp->task_tag = tag;

Same comment here - please restore the lockdep_assert_held() call.

Otherwise this patch looks good to me.

Thanks,

Bart.

