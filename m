Return-Path: <linux-kernel+bounces-143484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DBD8A39FF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD65CB2224E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 01:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECA763C8;
	Sat, 13 Apr 2024 00:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b/DAJ9iO"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BAB4C83
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 00:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712969845; cv=none; b=WcbcAa7um4jJZIb9jRghxlfbnLXZTRvr4hlIj3gcySlvkK/ngnUK/vaezlbdaB3/qYIBPzoHFcjDhWIwj0j4gIHKCb7/nwvYnEsCvQOZTjvy5cdEJqCWainSdZVMmEdWScO788SYaJeaK+iLAdevveZxZGgvJpbsa5gb7Iql1qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712969845; c=relaxed/simple;
	bh=bmzo1ooKzqufK+juDvo25PZMBaSl3V6Gz4q4MzinNGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTL5N4jAOEGXBhCYanaNi6YNkOTsKnRn/zv/7qV5nFhpYy4twiYfFm8sodjUKFghh7WXvROyEZSx8IFgF8c1lKvvUvL6TZLL6zGXE36E6tro0cRZ1lJdYNu7Xi4Db1KlgDBtHAXQU/GvPfyaV2qXXP8HA3T8YxO5eJI7MgQV2zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b/DAJ9iO; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3442f4e098bso1398004f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 17:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712969840; x=1713574640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wc6szgZjNNFyh/LwTAWMUZNCmALq+FNR/Ebns3AOlpc=;
        b=b/DAJ9iOSoS2kY4rEO8CA6EkYIjguKRyM8bp7s2L3qy4wA2vmVHRGWQRXEb/pKOT0R
         zr90UeovvZ85AW//d4dVYXSEh9v2aabWhThaEt7wOmeDkr3JkJRKtx4NuT7OmEu5N3MG
         +1A6+lDVRVwsvdBiHHcLsTkJfSSH9gIFMHyuHGF7zG+85rXu/z6dae9m2WLVmKnkBwtY
         5OEn0Zp1KMsrAfAABOvmSv2AyP5M/F+pWOoG70VsTRXt6onjgfHwyxZc/PPBmPoi73LX
         +zSOUpZA2AMtdssZrmTooes6WTw+ycKw/5suBo8QqVzW54yP29LN1zucxmy61b5lzb0X
         osgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712969840; x=1713574640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wc6szgZjNNFyh/LwTAWMUZNCmALq+FNR/Ebns3AOlpc=;
        b=JqAVwQ/y9YLKRBFKQ/mXV3wbH8lPyfyI7qqTxLREC0gBsHGv41aqlV3TJcVue48+gx
         JknIMjRq2Qluvj0Kfr+IWMEhbvdMiZvturH+FPuM0gdQx6j43g1yoWcU8orNgVlC+/MC
         8JzXx6cfDy55eUm3+sbWpPKTooStDDJJmAFMoyQ7/QdxfIJCvqPS3AQ0epaMnHFJ18Js
         qMGVV+lwNGwWiSWqZg8jAd5UTnO3XyWMWcYA8gBpIW7SFD6im+rkz0AZqwNFA8Mp/TOz
         wwmsEf/m1eM8QPu6yXJoIUtCdYpcL7VAXyauB4qlKyhOsTxJlS65hrB2umrERKEn4PUY
         RB+w==
X-Gm-Message-State: AOJu0Yw3XapgDTXQP1y9fB514nVBwoRVCVe2V//tPpvWNQJt6GFtn4P4
	+DpYtsokhE25IDQGz/Pq2OEg1sD41qHV0nNyb+xsS9nz9vdknmMBhweEqIn15E8=
X-Google-Smtp-Source: AGHT+IG5KyNZ5UA78drYL10vGyqyFOO3ZKeVjROMtVCq0nW7TCGzkkBZy2nnAMrb7RUrG6yqAasTfA==
X-Received: by 2002:adf:fc49:0:b0:345:6cec:4e02 with SMTP id e9-20020adffc49000000b003456cec4e02mr5032792wrs.12.1712969840341;
        Fri, 12 Apr 2024 17:57:20 -0700 (PDT)
Received: from ?IPV6:2001:559:57b:111::ffff:d600? ([2001:559:57b:111::ffff:d600])
        by smtp.gmail.com with ESMTPSA id z5-20020ae9c105000000b0078ed33d55f2sm837987qki.121.2024.04.12.17.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 17:57:19 -0700 (PDT)
Message-ID: <c55d8329-6d59-4821-89f2-6b50fa9dc6a7@suse.com>
Date: Fri, 12 Apr 2024 20:57:18 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mst: Fix NULL pointer dereference in
 drm_dp_add_payload_part2 (again)
To: Wayne Lin <Wayne.Lin@amd.com>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, stable@vger.kernel.org
References: <20240413002252.30780-1-jeffm@suse.com>
Content-Language: en-US
From: Jeff Mahoney <jeffm@suse.com>
In-Reply-To: <20240413002252.30780-1-jeffm@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

As a follow up, I read through the original thread before sending this 
and my understanding is that this message probably shouldn't be getting 
printed in the first place.  I've turned on KMS, ATOMIC, STATE, and DP 
debugging to see what shakes out.  I have a KVM on my desk that I use to 
switch between systems fairly frequently.  I'm speculating that the 
connecting and disconnecting is related, so I'm hopeful I can trigger it 
quickly.

-Jeff

On 4/12/24 20:22, Jeff Mahoney wrote:
> Commit 54d217406afe (drm: use mgr->dev in drm_dbg_kms in
> drm_dp_add_payload_part2) appears to have been accidentially reverted as
> part of commit 5aa1dfcdf0a42 (drm/mst: Refactor the flow for payload
> allocation/removement).
> 
> I've been seeing NULL pointer dereferences in drm_dp_add_payload_part2
> due to state->dev being NULL in the debug message printed if the payload
> allocation has failed.
> 
> This commit restores mgr->dev to avoid the Oops.
> 
> Fixes: 5aa1dfcdf0a42 ("drm/mst: Refactor the flow for payload allocation/removement")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> ---
>   drivers/gpu/drm/display/drm_dp_mst_topology.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 03d528209426..3dc966f25c0c 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -3437,7 +3437,7 @@ int drm_dp_add_payload_part2(struct drm_dp_mst_topology_mgr *mgr,
>   
>   	/* Skip failed payloads */
>   	if (payload->payload_allocation_status != DRM_DP_MST_PAYLOAD_ALLOCATION_DFP) {
> -		drm_dbg_kms(state->dev, "Part 1 of payload creation for %s failed, skipping part 2\n",
> +		drm_dbg_kms(mgr->dev, "Part 1 of payload creation for %s failed, skipping part 2\n",
>   			    payload->port->connector->name);
>   		return -EIO;
>   	}

-- 
Jeff Mahoney
VP Engineering, Linux Systems

