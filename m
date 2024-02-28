Return-Path: <linux-kernel+bounces-84665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1310A86A9C6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C531C232B3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AAD2C84C;
	Wed, 28 Feb 2024 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QRZ/anWH"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144DF2D022
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709108592; cv=none; b=JAOm31S3jEZmOFKRtGj4rYLgQVS5Hf1LKF9SijU/Sg7YGwwW6JoCw0rTsA4Slkn5M5vxednyVq8p83kgv563T+zkwdH9pKvhUaLb3Y5BRb6Zh+o/ifu2bgCrWAOJU3utn+AMUVmX896pZolNtxTh0DaekEMRvHKBSxuGpx8UiAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709108592; c=relaxed/simple;
	bh=zcAL1tz6ACOVjNFHPJlq0qKUpVxS0PmWRTLBkHyo94o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gyq9l9EI0Gea7YtnKOB5iomIMBHtd9ekeZcD5JTJvh9UhkPfAW1oqOEFdJy4DvFCHAY5p/WF/mjTsspIuC7y8U1Jo3SryUh2LuoN4Ln3rP9yKYJ538abaIejRO0FzbzncOLFNUgyR2JpK2L0PepUVm3A21vRQCqsWNGzood4ZrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=QRZ/anWH; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d27fef509eso49946001fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 00:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709108588; x=1709713388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cqgLOaVURL67ftXp6v7O92fn39oSUkQDPBYPEe3/YNQ=;
        b=QRZ/anWHgICcWsOlPXe8eHsMxTRnm3eOm2Ln0j+nFQOVkhr0bodPnc47svm7Kr+/JA
         XDj6N0Z/kMaJ9mehUXHYIqSLYAsiOcASPTytJklg4WopzkVg+lIZxMHvVHdt4iOMk3lY
         n5JuCnAczRw8VYOQx30k26vwS6fAsd62J1p3zXXWx6P0fZQd/qiF3RTqp6Q5OibcdCWw
         1MKcYpQavHE9/xAigj3bVhOoQQygjA2D6X93X0+PwSbeZriYuB+57i6o4B95lNj4Dtee
         +qwNaUSvyTmxNWCNt3hfw4TxZKSbtOP/LLg6so98WPL8zGJ7OBZMXeuyLE6+rXQ5/gOp
         oF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709108588; x=1709713388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqgLOaVURL67ftXp6v7O92fn39oSUkQDPBYPEe3/YNQ=;
        b=h0Dwz9Y08Fq9OpdEkVBsBM3MRxmkIQN53k0wAfOC1U1ETmauALp3uzrT7/J04eGOSX
         w8UWAIGhE+AE61/opGHSJhafjVsTyGPiHwEb4hx9wV1PchDgSEJE6fdHgm3p7QyUCwEY
         dV7oLQ6HZR8vQrua1V5jQ/jytwI/GrvFnyolR+ogZPsQcGACLZ2OiyZCJBUWY5hD6npR
         kbU1hZns+a/EjLMyrMwGMZLfTpdIEVXqFsHUDDMubVCtA7o4ln48mzmC9XDq7+XvyeNu
         hUjz9Vq1ylp30eiRY6PwvKcrhoTdzQ4zGsNKitGyEClnBL9Imyp/m5BnbwWwMaP57FEk
         0Vpw==
X-Forwarded-Encrypted: i=1; AJvYcCWpTH3RNW1/OcBD/9GF60X7z9D76wiF8jH0lWu0njQ4n2Kh70amHhNZKDd0n3KDa7xjIJL7SenNd9TuzbgBTLPjiWU3kPleXmWA+q29
X-Gm-Message-State: AOJu0Yx8dhyhLn5FOyrIO7tiEIv6t61un/RwtDbzlIgitmgKwMvsan47
	fxRx1jJxmVtVpV31+OvVUmI03XOCeAGg7jH/fJlYtbt1NcCXMk88SE+CsaW4Jb8=
X-Google-Smtp-Source: AGHT+IEdjlYQBynczVxYHirKmQjo0oLu2GibxkoDPhBH6ojuuWCevUu//kVmNR7RzwvBkiXfRmUZVg==
X-Received: by 2002:ac2:5ed0:0:b0:512:dfa1:6a1c with SMTP id d16-20020ac25ed0000000b00512dfa16a1cmr7280828lfq.10.1709108588092;
        Wed, 28 Feb 2024 00:23:08 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id c3-20020adfe703000000b0033d6fe3f6absm13734962wrm.62.2024.02.28.00.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 00:23:07 -0800 (PST)
Date: Wed, 28 Feb 2024 09:23:04 +0100
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
Message-ID: <Zd7taFB2nEvtZh8E@nanopsycho>
References: <20240227082815.2073826-1-s-vadapalli@ti.com>
 <Zd3YHQRMnv-ZvSWs@nanopsycho>
 <7d1496da-100a-4336-b744-33e843eba930@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d1496da-100a-4336-b744-33e843eba930@ti.com>

Wed, Feb 28, 2024 at 08:06:39AM CET, s-vadapalli@ti.com wrote:
>
>
>On 27/02/24 18:09, Jiri Pirko wrote:
>> Tue, Feb 27, 2024 at 09:28:15AM CET, s-vadapalli@ti.com wrote:
>>> The CPSW Ethernet Switch on TI's K3 SoCs can be configured to operate in
>>> VLAN Aware or VLAN Unaware modes of operation. This is different from
>>> the ALE being VLAN Aware and Unaware. The Ethernet Switch being VLAN Aware
>>> results in the addition/removal/replacement of VLAN tag of packets during
>>> egress as described in section "12.2.1.4.6.4.1 Transmit VLAN Processing" of
>>> the AM65x Technical Reference Manual available at:
>>> https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
>>> In VLAN Unaware mode, packets remain unmodified on egress.
>>>
>>> The driver currently configures the Ethernet Switch in VLAN Aware mode by
>>> default and there is no support to toggle this capability of the Ethernet
>>> Switch at runtime. Thus, add support to toggle the capability by exporting
>>> it via the ethtool "priv-flags" interface.
>> 
>> I don't follow. You have all the means to offload all bridge/vlan
>> configurations properly and setup your hw according to that. See mlxsw
>> for a reference. I don't see the need for any custom driver knobs.
>> 
>
>Thank you for reviewing the patch. Please note that the "VLAN Aware mode" being
>referred to here is different from ALE being VLAN aware. The hw offload of
>bridge/vlan configurations is already supported in the context of the ALE. The
>Ethernet Switch being VLAN Aware is a layer on top of that, which enables
>further processing on top of the untagged/VLAN packets. This patch aims to
>provide a method to enable the following use-cases:
>1. ALE VLAN Aware + CPSW VLAN Aware
>2. ALE VLAN Aware + CPSW VLAN Unaware
>
>All hw offloads of bridge/vlan configurations are w.r.t. ALE VLAN Aware alone.
>Currently, only use-case 1 is enabled by the driver by default and there is no
>knob to toggle to use-case 2.
>
>I am quoting sections of the Technical Reference Manual mentioned in my commit
>message, in order to clarify the CPSW VLAN Unaware and CPSW VLAN Aware terminology.
>
>CPSW VLAN Unaware:
>Transmit packets are NOT modified during switch egress.
>
>CPSW VLAN Aware:
>1. Untagged Packet Operations
>Untagged packets are all packets that are not a VLAN packet or a priority tagged
>packet. According to the CPWS0_FORCE_UNTAGGED_EGRESS_REG[1-0] MASK bit in the
>packet header the packet may exit the switch with a VLAN tag inserted or the
>packet may leave the switch unchanged....
>2. Priority Tagged Packet Operations (VLAN VID == 0 && EN_VID0_MODE ==0h)
>Priority tagged packets are packets that contain a VLAN header with VID = 0.
>According to the CPSW_ALE_FORCE_UNTAGGED_EGRESS_REG[1-0] MASK bit in the packet
>header, priority tagged packets may exit the switch with their VLAN ID and
>priority replaced or they may have their priority tag completely removed....
>3. VLAN Tagged Packet Operations (VLAN VID != 0 || (EN_VID0_MODE ==1h && VLAN
>VID ==0))
>VLAN tagged packets are packets that contain a VLAN header specifying the VLAN
>the packet belongs to
>(VID), the packet priority (PRI), and the drop eligibility indicator (CFI).
>According to the CPSW_ALE_FORCE_UNTAGGED_EGRESS_REG[1-0] MASK bit in the packet
>header, VLAN tagged packets may exit the switch with their VLAN priority
>replaced or they may have their VLAN header completely removed...
>
>I hope that this clarifies that CPSW VLAN Unaware/Aware is a layer on top of the
>hw offload-able bridge/vlan configuration.  Please let me know if there is
>anything specific that could enable this without requiring the "priv-flag" based
>implementation of this patch.

I have no clue what "ALE" is. But in general. User provided
configuration, using ip/bridge/etc tools/uapi. According to this
configuration, kernel is bahaving. When you do offload, you should just
make sure to mimic/mirror the kernel behaviour. With this in mind, why
can't you do it without adding additional knob? And if you really need
it because the know does some internal hw/fw tuning, priv flag of netdev
is most probably not the correct place to put it. If it is, make sure
you advocate for it properly in the patch description.

pw-bot: cr


>
>-- 
>Regards,
>Siddharth.

