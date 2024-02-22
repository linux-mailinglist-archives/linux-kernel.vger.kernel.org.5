Return-Path: <linux-kernel+bounces-75955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D94485F11C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E70EB23843
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835DF14A96;
	Thu, 22 Feb 2024 05:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ul/ppe0Y"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40932107B4
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708580868; cv=none; b=dl8xX0du5yyYXHj1RuTVloU4qdvfS4eA7TH8J9yJbrRpZXPYrmtzyOG8RTkWhL/rJIlaYkjPinROP0tRvVjXA/RxL/ib/tN7rMesEV/XPTOMegonOjL3WUCi5OJqonRPFbNOTuhZsq0ilRkkIOX9WyWIkJoaQPXNqcit93WA8pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708580868; c=relaxed/simple;
	bh=qdDEQ/odklpLTC89u2grpARtU2NkpDJ3xSWe0VUu6UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onLqLip6m0nNNN2Yeraq2N7FJblFzxvBKHks/8i4EwcEROmxWkEyH0+x6V4u0mbU4zOomCLv0X6AmfTxa38rtVp35NHCUafseo3+UVst+HSyZ7RLE9xY438KL4uTfBCc9Ttiw6reeRUQcl/8vDJlImwEb3ob/+FMQr8gofpAxtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ul/ppe0Y; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso468480b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708580866; x=1709185666; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wSWmeGU/PHEWXrJBkyrdMCv0vQ2HmKobzP0FHV/IZQY=;
        b=ul/ppe0Ys0tdOppd+Dygcuxs5uzpbBUWoI88prMGpADwiSWfswYtfsgjVQaDbceI3r
         v6klax3A0mE8EKBNWo/mJ02spHqw21oGB+EqfQmRFlUVKrz5Sb6F+qfXDOG/DBSc8kLK
         bQk4we4YgxgRXidVT1riMmugMXUNmLoVnvWFhOBd8dJq/ikyb6zoHU4lNNHapD3i9ZUn
         SknFuzC9Ee5u/Jt1o3SAzJDW3JIw/AaBHKqAeyVB11j186z5jm2ZO4l6ZTaAcQE2edzi
         mIV4jDEJFa7pGxsGDrz0rQkJNVhZRY73faXzmkyiOuN1Ji4nIYGwWjfpEfuCyXTKWeYs
         SXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708580866; x=1709185666;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wSWmeGU/PHEWXrJBkyrdMCv0vQ2HmKobzP0FHV/IZQY=;
        b=D70LK5BNfccJQFaHFcW19qxO3jtUn3vR0/9qcFjDltqUyfF+gjcMn6DBLUrif8e6ms
         rg+52yYQmKGGo4ZOtnZPgrSCFicdstwFfz2JQpwhLrcE9D6fRkQ8pQpwzG0trzKYqvMz
         yCRwV2KDyeCjuA/ySrx/qNOUxw2N1JfQdxLMyHrqmADyZodWJmgYzdqOv2lEU2zgRSCN
         /gkZz9/vAmfWsbI6O6u86jXPi0R+4N061/m6tjJPeeuytZDj+Ub6C8kwZ4Vt1x6TQV0f
         TxCU5UYza+H9pjq+pUfF77IhmvuTiCTooYXKM8kTkgNRopwrlDVfTgd/UCbeypBHScSt
         1azA==
X-Forwarded-Encrypted: i=1; AJvYcCUhY5eqoOUgzIygvFoo72qZUgSJ0R9yN/LGWdS9SmYETK5+wfb7IPu43IIa0N3PDJZv9UGrOVqfWvamIS9724VVbUllXQMSoJUnEqAg
X-Gm-Message-State: AOJu0Yyx3t1ctsbYrDpfwJE1mbJsZPoXZTyfIw5ORSMhlmNyA1agUJbt
	11gBd7D7l1Bfyvzfy4PC+bdCYgXuK6A33VP7fmIpK3mAQeuham0EyJSdV/0Z2vMXT/vHgUUsrpE
	=
X-Google-Smtp-Source: AGHT+IHcAZ7rWFCCCCrNCo/vjZ7VNYn7nL2POZRFMS+2IBVvi+pUx8xK0KHdEmv6esp16oSwmLVbuA==
X-Received: by 2002:a05:6a00:2d0f:b0:6e0:4a19:8da6 with SMTP id fa15-20020a056a002d0f00b006e04a198da6mr2882834pfb.3.1708580866081;
        Wed, 21 Feb 2024 21:47:46 -0800 (PST)
Received: from thinkpad ([117.193.212.166])
        by smtp.gmail.com with ESMTPSA id fn16-20020a056a002fd000b006e3dfb2ef4esm8623980pfb.95.2024.02.21.21.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 21:47:45 -0800 (PST)
Date: Thu, 22 Feb 2024 11:17:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Kalle Valo <kvalo@kernel.org>,
	Linux Wireless <linux-wireless@vger.kernel.org>,
	ath11k@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org
Subject: Re: ath11k allocation failure on resume breaking wifi until power
 cycle
Message-ID: <20240222054739.GG3374@thinkpad>
References: <96481a45-3547-4d23-ad34-3a8f1d90c1cd@suse.cz>
 <0994ae16-8174-4a04-b454-1974b16bc106@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0994ae16-8174-4a04-b454-1974b16bc106@quicinc.com>

On Wed, Feb 21, 2024 at 08:34:23AM -0800, Jeff Johnson wrote:
> On 2/21/2024 6:39 AM, Vlastimil Babka wrote:
> > Hi,
> > 
> > starting with 6.8 rc series, I'm experiencing problems on resume from s2idle
> > on my laptop, which is Lenovo T14s Gen3:
> > 
> > LENOVO 21CRS0K63K/21CRS0K63K, BIOS R22ET65W (1.35 )
> > ath11k_pci 0000:01:00.0: wcn6855 hw2.1
> > ath11k_pci 0000:01:00.0: chip_id 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
> > ath11k_pci 0000:01:00.0: fw_version 0x1106196e fw_build_timestamp 2024-01-12 11:30 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
> > 
> > The problem is an allocation failure happening on resume from s2idle. After
> > that the wifi stops working and even a reboot won't fix it, only a
> > poweroff/poweron cycle of the laptop.
> > 

Looks like WLAN is powered down during s2idle, which doesn't make sense. I hope
Jeff will figure out what's going on.

But if you can share the dmesg after enabling the debug prints of both ath11k
and MHI, it will help a lot.

- Mani

> > This is order 4 (costly order), GFP_NOIO (maybe it's originally GFP_KERNEL
> > but we restrict to GFP_NOIO during resume) allocation, thus it's impossible
> > to do memory compaction and the page allocator gives up. Such high-order
> > allocations should have a fallback using smaller pages, or maybe it could at
> > least retry once the restricted GFP_NOIO context is gone.
> > 
> > I don't know why it never happened before 6.8, didn't spot anything obvious
> > and it happens too unreliably to go bisect. Any idea?
> 
> I've asked the development team to look at this, but in the interim can
> you apply the two hibernation patchsets to see if those cleanups also
> fix your problem:
> 
> [PATCH 0/5] wifi: ath11k: prepare for hibernation support
> https://lore.kernel.org/linux-wireless/20240221024725.10057-1-quic_bqiang@quicinc.com
> 
> [PATCH 0/3] wifi: ath11k: hibernation support
> https://lore.kernel.org/linux-wireless/20240221030026.10553-1-quic_bqiang@quicinc.com

-- 
மணிவண்ணன் சதாசிவம்

