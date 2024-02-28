Return-Path: <linux-kernel+bounces-85090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0926D86B04C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1C21F271A2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816EB14AD2D;
	Wed, 28 Feb 2024 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ryI2yKQc"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513CD145FE8
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709126886; cv=none; b=O0Hzy8EVgUgLwbNGj2yuCxEeiGq88csJIGuZZHBPXAACxTHv1DnxpoS3AqPNOt42zZkqpOBuowFxcGFuiuRFHY8cN8n+Su1BPGin7kURb2mtp3k1bOKccVoeBC1H+qfcxDtKJtmarLb9G07QZ5eg3xmSQ5Wl3PMm0aRsvQ3VHfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709126886; c=relaxed/simple;
	bh=5tu4oA59KhY06nxQt1gQkS0mgx9HIzfNvh62p6xnllQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6LxheCmykHk0nbnxFd8a4I0IvVIpzkF6iIA0INrF8+lpSSsfEvtQypBj+8psm+0QKFkr+cF2+G4fZvFZLD1Qrxbs6EEYYe1FYV4hDkLfivPd27odcDNEy2q72SVwxUnCmoSiABBQyZKUifMacD4s2hes8RfX8a/fqd61GKYmV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ryI2yKQc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412ae087378so13277495e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709126882; x=1709731682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e9wUp62staKveDTu96LB6OyYEe4qCAP2aId49Azr470=;
        b=ryI2yKQcTsrM8jS/xT0zgx+VUPnyVBj1FzTtcdEaoVKOoE3/lGEyIKYwGqUP8Q4GPY
         yJCARAsYvHUe9N0XBZIVkT0LSihQm5t/YSbX/Aux3Vcq4KibesKAGRuX8IuKsKMqEfkC
         VKCNPgOSvrJGjP9F1DIOTTvdn2Xa5UfuQfIxhnefAvd24J4NFS0Yz3mGQoENpycCQHco
         rM/UMM5s/zb8DchlbZgRZ3sP5TQRPz8TAaYg6cYwJgeb9zWguAU6bq0YVQM9jFYYHwrx
         p4L491f+FhWjdHYIaJ7GO1xtY0Xyw1cgyIMaltwZZ8o1s2ASEnbAsJa5hJPkO2hVmjsA
         4PlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709126882; x=1709731682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9wUp62staKveDTu96LB6OyYEe4qCAP2aId49Azr470=;
        b=JBACfqdtXX0Hm4FHVEj736ZLyvoJzxLtTYwtn1XMvZrhMEaIBQZE/wMxMuq3hc4wp2
         H0mrOQ8puVest36txNgufICoHKFJ9UKuQ9WdTGbfZx4Qh/A2rz4FjlqISaV8LJkicZdQ
         4NDJ56tMHl1LXVv1cuI/MrQ6sgH/BMO1KBPJurXHL+rR9u9IC4PEfKPCghkzvazCOimV
         zqXXfkxKq/MDemTbYgTDQZJ2PI5j0h7ro1uS6tu4rJ1cf8/HPggWo5zmwFnKruuHC6Ct
         fCZjCE/d7vhpHncFSNB+93nqmMARjsnUqAMjFeErZcFeeUVUSDA+x3WMgU7A6P2i88J2
         cuLg==
X-Forwarded-Encrypted: i=1; AJvYcCUBYlg/ErJcZ6q6lB4Ca2HfoiZBwNWybm21Sh9ZLK1MuD9Xr65FUjwwxYpOlbnQTqi24MSjpzJEBgig8hJ9IeiUgK2moTBfU2AotKxe
X-Gm-Message-State: AOJu0YzI7dQ4VkE6WnvF0fGjEKDPmXmxSqY0CcvPMweXIpi++JxZ1sTW
	yA4OaYO/0i3TBDbqu/nK2A3/0uKPd6GkvOtVpaolBmEc17fyhAN+PX1pB/pp1dI=
X-Google-Smtp-Source: AGHT+IEPcxRfVeevLifaXmgO5QobEy2Cf5VY3JV3xCE4YTrpJZ6rYoXF80CZFflldoLPhoHRiWr5EA==
X-Received: by 2002:a5d:528d:0:b0:33d:7c8:2230 with SMTP id c13-20020a5d528d000000b0033d07c82230mr9850374wrv.24.1709126882544;
        Wed, 28 Feb 2024 05:28:02 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id d14-20020a5d538e000000b0033d4deb2356sm14476145wrv.56.2024.02.28.05.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:28:02 -0800 (PST)
Date: Wed, 28 Feb 2024 14:27:59 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, rogerq@kernel.org, andrew@lunn.ch,
	vladimir.oltean@nxp.com, hkallweit1@gmail.com,
	dan.carpenter@linaro.org, horms@kernel.org, yuehaibing@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH net-next] net: ethernet: ti: am65-cpsw: Add priv-flag for
 Switch VLAN Aware mode
Message-ID: <Zd8034JJFHTjyhfc@nanopsycho>
References: <20240227082815.2073826-1-s-vadapalli@ti.com>
 <Zd3YHQRMnv-ZvSWs@nanopsycho>
 <7d1496da-100a-4336-b744-33e843eba930@ti.com>
 <Zd7taFB2nEvtZh8E@nanopsycho>
 <49e531f7-9465-40ea-b604-22a3a7f13d62@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49e531f7-9465-40ea-b604-22a3a7f13d62@ti.com>

Wed, Feb 28, 2024 at 11:04:55AM CET, s-vadapalli@ti.com wrote:
>
>
>On 28/02/24 13:53, Jiri Pirko wrote:
>> Wed, Feb 28, 2024 at 08:06:39AM CET, s-vadapalli@ti.com wrote:
>>>
>>>
>>> On 27/02/24 18:09, Jiri Pirko wrote:
>>>> Tue, Feb 27, 2024 at 09:28:15AM CET, s-vadapalli@ti.com wrote:
>>>>> The CPSW Ethernet Switch on TI's K3 SoCs can be configured to operate in
>>>>> VLAN Aware or VLAN Unaware modes of operation. This is different from
>>>>> the ALE being VLAN Aware and Unaware. The Ethernet Switch being VLAN Aware
>>>>> results in the addition/removal/replacement of VLAN tag of packets during
>>>>> egress as described in section "12.2.1.4.6.4.1 Transmit VLAN Processing" of
>>>>> the AM65x Technical Reference Manual available at:
>>>>> https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
>>>>> In VLAN Unaware mode, packets remain unmodified on egress.
>>>>>
>>>>> The driver currently configures the Ethernet Switch in VLAN Aware mode by
>>>>> default and there is no support to toggle this capability of the Ethernet
>>>>> Switch at runtime. Thus, add support to toggle the capability by exporting
>>>>> it via the ethtool "priv-flags" interface.
>>>>
>>>> I don't follow. You have all the means to offload all bridge/vlan
>>>> configurations properly and setup your hw according to that. See mlxsw
>>>> for a reference. I don't see the need for any custom driver knobs.
>>>>
>>>
>>> Thank you for reviewing the patch. Please note that the "VLAN Aware mode" being
>>> referred to here is different from ALE being VLAN aware. The hw offload of
>>> bridge/vlan configurations is already supported in the context of the ALE. The
>>> Ethernet Switch being VLAN Aware is a layer on top of that, which enables
>>> further processing on top of the untagged/VLAN packets. This patch aims to
>>> provide a method to enable the following use-cases:
>>> 1. ALE VLAN Aware + CPSW VLAN Aware
>>> 2. ALE VLAN Aware + CPSW VLAN Unaware
>>>
>>> All hw offloads of bridge/vlan configurations are w.r.t. ALE VLAN Aware alone.
>>> Currently, only use-case 1 is enabled by the driver by default and there is no
>>> knob to toggle to use-case 2.
>>>
>>> I am quoting sections of the Technical Reference Manual mentioned in my commit
>>> message, in order to clarify the CPSW VLAN Unaware and CPSW VLAN Aware terminology.
>>>
>>> CPSW VLAN Unaware:
>>> Transmit packets are NOT modified during switch egress.
>>>
>>> CPSW VLAN Aware:
>>> 1. Untagged Packet Operations
>>> Untagged packets are all packets that are not a VLAN packet or a priority tagged
>>> packet. According to the CPWS0_FORCE_UNTAGGED_EGRESS_REG[1-0] MASK bit in the
>>> packet header the packet may exit the switch with a VLAN tag inserted or the
>>> packet may leave the switch unchanged....
>>> 2. Priority Tagged Packet Operations (VLAN VID == 0 && EN_VID0_MODE ==0h)
>>> Priority tagged packets are packets that contain a VLAN header with VID = 0.
>>> According to the CPSW_ALE_FORCE_UNTAGGED_EGRESS_REG[1-0] MASK bit in the packet
>>> header, priority tagged packets may exit the switch with their VLAN ID and
>>> priority replaced or they may have their priority tag completely removed....
>>> 3. VLAN Tagged Packet Operations (VLAN VID != 0 || (EN_VID0_MODE ==1h && VLAN
>>> VID ==0))
>>> VLAN tagged packets are packets that contain a VLAN header specifying the VLAN
>>> the packet belongs to
>>> (VID), the packet priority (PRI), and the drop eligibility indicator (CFI).
>>> According to the CPSW_ALE_FORCE_UNTAGGED_EGRESS_REG[1-0] MASK bit in the packet
>>> header, VLAN tagged packets may exit the switch with their VLAN priority
>>> replaced or they may have their VLAN header completely removed...
>>>
>>> I hope that this clarifies that CPSW VLAN Unaware/Aware is a layer on top of the
>>> hw offload-able bridge/vlan configuration.  Please let me know if there is
>>> anything specific that could enable this without requiring the "priv-flag" based
>>> implementation of this patch.
>> 
>> I have no clue what "ALE" is. But in general. User provided
>
>ALE is Address Lookup Engine.
>
>> configuration, using ip/bridge/etc tools/uapi. According to this
>> configuration, kernel is bahaving. When you do offload, you should just
>> make sure to mimic/mirror the kernel behaviour. With this in mind, why
>
>What if there is no kernel behavior associated with it? How can it be mimicked
>then? This patch isn't offloading any feature that is supported in software. It
>might not be possible to offload features which act on the forwarding path of
>packets entirely in Hardware within the Ethernet Switch.
>
>Please consider the following:
>Untagged packets sent from Software via the corresponding VLAN interfaces will
>be tagged which is the expected behavior. However, if this is offloaded, it will
>imply that even untagged packets that are simply forwarded in the Ethernet
>Switch and never get to software will also have to be tagged by the Ethernet
>Switch. This is not allowing the choice of leaving untagged packets as-is on the
>Ethernet Switch's forwarding path. This patch attempts to allow configuring
>something quite similar to this, where it is possible to *choose* whether or not
>to tag packets being forwarded.

What would kernel datapath do? That is the question you need to ask and
configure the hw accordingly. If 2 interfaces are in the bridge, vlans
involved, etc, the forward behavior is well defined, isn't it. What am I
missing?


>
>> can't you do it without adding additional knob? And if you really need
>> it because the know does some internal hw/fw tuning, priv flag of netdev
>
>The feature can be turned on or off depending on the use-case. Is it acceptable
>to have build configs scattered in the driver code? I don't suppose that is
>acceptable, due to which it will be preferable to have a runtime configuration
>option, which is what this patch provides.
>
>> is most probably not the correct place to put it. If it is, make sure
>
>Please suggest an alternative if this isn't the right place. Otherwise, I can
>only assume that there isn't one.
>
>> you advocate for it properly in the patch description.
>> 
>> pw-bot: cr
>>
>
>-- 
>Regards,
>Siddharth.

