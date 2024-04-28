Return-Path: <linux-kernel+bounces-161484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C283A8B4CA4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE50B21241
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106C871756;
	Sun, 28 Apr 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgztAZrJ"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47C06F506;
	Sun, 28 Apr 2024 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714321159; cv=none; b=o/YcZEFNldCV7dWU0iYwoW5MIvU6VCe3IhY4lxZwQmBogIpnFNCrVAfpbs+DKmgTitDq6bTWzIbnFQgdTTSOFAwx5fsVxYiMRzvPxSoBVjzDZf9AtUgCx2LZxfuulfp+THT2xyCwFcG52IMsaJQbXJHebnK6zgNOVXbGEeSTZD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714321159; c=relaxed/simple;
	bh=ulUn2Roe+pzNA/CtKdogTu9szg+ulnwZVNNaty/EbLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kaKCW/A53QkdPHIxvXPbgNdL7EnpF7T88MAj8SyexXu0HBjd8rZFKmuf+OySjjpArT1p7JVTRtcsFEVGLDdhsCb5iVY/uYOqfmExju0uoWf6qyCgjKAvY4orgTkXZoCH4GUtq05wfpYP/cfgixTUywAFIlId9OkkHHARvL36xOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgztAZrJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41bab13ca80so13617745e9.0;
        Sun, 28 Apr 2024 09:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714321156; x=1714925956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8wa13zwfdNflwwU+lO/hDpPql8ov9l9JWWF4zFv8PI=;
        b=fgztAZrJGVmDpQieqU4ArI9DMpafJLcO0GQY9TnZY3/v2hWORXWe+sQp8PMpm2szjK
         zR+vPsObwZD3LEkg2n3qs8SZIKe859HCnDJu4/fv3P9FLk7LPsR9BMqyjUP3Vk+xzZoW
         2QKl/MIMb9H3G8hZ2DN7W+3G+lfpDpqyE4UamOyNYWYI59QM+3uF+9YWdd9rVNetG623
         ITIgIzQBfYNPqeN8Eutuh7Pswn/vhmMyqV9oaelsn6CkWu4XxzHgGf9VVlbEwXpejbAH
         xAITLESlbZKd7fiH2OzuEEdMeuDDBiZGvFBOBLuQuRMaAEv8CL6/3Jq95IMyxuhocOLa
         yl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714321156; x=1714925956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8wa13zwfdNflwwU+lO/hDpPql8ov9l9JWWF4zFv8PI=;
        b=q1PcuGgyrwWz1cYGmFLmi7s2lnY7G2jKTTOgniH6vNSyiKhUsYWjkAzO+OFPzHoKV8
         p79FYD/yWNRsKE03Fn+7wyKEHOEdY57xbrR/nNSBfdAA9mufPTE7RRoFAXwwyGJKPQsE
         A8zKPFI7P/3oIWPgOly/yQ45M0Vk4csFNXbA/+nT1nBz3y5GFKIf0Tl4iXTQkMW7PCkb
         qyUw0pvx3RSdZpWQNYO6Nzue9/LKHSz9nYKwYjAfIcW5YKCeWCax1mTeb2uwoerh9YuO
         ob32V5r9PLCAP2jnhWQH+uN0SO3BKC8P8GR/BajQjjLrRs+7JZxYTAeiIwVHwe7PpvzN
         UzRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJADKjE5ZVLZ0zYqQXBgTMgMC5Jjwy994bAm5eclk38zLoxg1paSJdVVPxMDlST8BUBW5ekJdljrIxR7X0FshfrTeZAMRYOADYNA6J9wtW5+kyt22x2avQJxtKO2Wrmoa5xSX2H5aZ9g==
X-Gm-Message-State: AOJu0YwYgd74SeXdgNuFfEViHT6TcFAlyP43p3kDWgDGSAkaFH6l1/Xc
	c4eKuigPqhoTCi21rWVz+dHTKMUwW/3QsjSWKIHzpIT7752eI6mH
X-Google-Smtp-Source: AGHT+IGptgXSf37/lCXJb/77nPWdb36TF7NEcazq4nRcEnOE+ZBrhWAs9b9n7VfqYJuZo01OUoWiUg==
X-Received: by 2002:a05:600c:3111:b0:41a:9fc2:a6b1 with SMTP id g17-20020a05600c311100b0041a9fc2a6b1mr7155221wmo.22.1714321155771;
        Sun, 28 Apr 2024 09:19:15 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c358800b00418f72d9027sm36319513wmq.18.2024.04.28.09.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 09:19:15 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>
Cc: wens@csie.org, samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] arm64: dts: allwinner: Add cache information to the SoC dtsi for
 A64
Date: Sun, 28 Apr 2024 18:19:13 +0200
Message-ID: <2726728.mvXUDI8C0e@jernej-laptop>
In-Reply-To:
 <6a772756c2c677dbdaaab4a2c71a358d8e4b27e9.1714304058.git.dsimic@manjaro.org>
References:
 <6a772756c2c677dbdaaab4a2c71a358d8e4b27e9.1714304058.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne nedelja, 28. april 2024 ob 13:40:35 GMT +2 je Dragan Simic napisal(a):
> Add missing cache information to the Allwinner A64 SoC dtsi, to allow
> the userspace, which includes lscpu(1) that uses the virtual files provided
> by the kernel under the /sys/devices/system/cpu directory, to display the
> proper A64 cache information.
> 
> While there, use a more self-descriptive label for the L2 cache node, which
> also makes it more consistent with other SoC dtsi files.
> 
> The cache parameters for the A64 dtsi were obtained and partially derived
> by hand from the cache size and layout specifications found in the following
> datasheets and technical reference manuals:
> 
>   - Allwinner A64 datasheet, version 1.1
>   - ARM Cortex-A53 revision r0p3 TRM, version E
> 
> For future reference, here's a brief summary of the documentation:
> 
>   - All caches employ the 64-byte cache line length
>   - Each Cortex-A53 core has 32 KB of L1 2-way, set-associative instruction
>     cache and 32 KB of L1 4-way, set-associative data cache
>   - The entire SoC has 512 KB of unified L2 16-way, set-associative cache
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



