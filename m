Return-Path: <linux-kernel+bounces-167736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C128BAE43
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981E62811E8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930C315216B;
	Fri,  3 May 2024 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3K1qWFv"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA3C15442B;
	Fri,  3 May 2024 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744616; cv=none; b=SwOhlWR/Hc4wQVt3kPXDdKrT+H4c2i8BsxPdQolT+cAqeYlTWEFSrIv74VlXYZ7ltXWENiUEXSCkz2svo2EOptEG3lAiScgaVvw+JtqbZJ8+DbnxjxbiCNP82hSoGltPZqTlhpF0y1x3x4l6s/u/tL+fLtrEwmjCECQ11skcauU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744616; c=relaxed/simple;
	bh=PeOh5WvB2jO9kjAZGpv/X7I0fdOPfdMIas+bIf/VctY=;
	h=Message-ID:Date:From:To:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkI+jSqNAvoZd94AizThmg60Aq0z4Wk7sXHq7SSfuH7s4i0VUsaSm9B95bBhjLgHKiNPFqB6UvRPRm2rL39FP1BhJfZssb0qCU7hu+biTpC9VJimT/zt/XtJv5onKU1EXGKQT3b5ZxcmT3W6p6eVnccWubIhf0sVMzQAkt7kOFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3K1qWFv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41bab13ca80so53676735e9.0;
        Fri, 03 May 2024 06:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714744614; x=1715349414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sWfvVAWRwF//8V6unQeHUEl+DB8qNLdcguWHwFINGgE=;
        b=h3K1qWFvNL2BIY1Osj9p821Cfct270e2aDtz9YPDn3NdujWc7NseMZYNqInmKqMMa5
         c61tnPSv3rQEOi2/vBkmeNQ3FBONtUHVNCM/LdIWXDbxbGRIq5C1EwincT8qDvNb3MKv
         c6XRy654ZpO+kdg5oKdTr09cHMSEIgkWsNHkjMhkU8pNeOLfaVHORJvO1A9Bv2Dq9VPs
         j3lAIicsDBY7faLmOvKTibnIdyKW//rfkOEA+KbXYOL8CSS9jeryUJwqZ1b03ULetiCk
         6SNnku96QTxRtz+LChG3n+zKMu8BbBKkw1OsJIMZ8qKl+7U+v9kv96hjbBJt+l6BacF6
         DQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714744614; x=1715349414;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWfvVAWRwF//8V6unQeHUEl+DB8qNLdcguWHwFINGgE=;
        b=DR9cO3rBV4z1bL6jTyZkqQCWcehgR1ZsKDfqh0PJM7+XA6+3bTbEQIIi3/Z4f+5UHS
         vme6rjiB2YCnbH2Hb5o23xLFV9b6vX0qAJ74tzesKVgEhlWknDt08Pr1c0DYRmdUDNKG
         J6I8zEfbRcdg/mUAT4V2YMhYajg63deUvD1UqkkovK0qWL/OmMPbD03MISgcAMaNk/rR
         FuioiUL2gIEH90UETk4nsxjr9jsNSLBzDLaJt4Ri61e/61caf+1YYaesG7NzVLGBqP/T
         SUKi4a+/hdY1zDyTor+b++nhgn8rHUn+L1SpAwdfL0r7kjInVO+GVoiMZQgBPZpecDaK
         pFFw==
X-Forwarded-Encrypted: i=1; AJvYcCVExO2iWVffZ6Nd6oYXe62IVagc0x1M44xHLcZozDVrDuoa8DSA455u8zAr07iFd8oBQPLyZnGUiI6ttK14GZ6em5RpehZNKnXBSrDg1W1XbIhMptM3r2VywIc46wSi/ggj0J9LLLRBOiarrMrWEilxCy/Ib2GEVvBC3smwCSnqA67Tp1Y=
X-Gm-Message-State: AOJu0YzLL00fd/PvGHDGOxasEVAG4IifPmHZtbe6Sl8/mkb0kHguQN3o
	b2i38J7wrPJLf2Rp1GsHBX9L+ok2/h6h50LYpZxDtwJU3qWWApQs
X-Google-Smtp-Source: AGHT+IF7OXDclHAg3YQItYYm5lvN9FDxTlwXfqhpmpnPcI1rjIbX+znZ/XR9A0S7QqWBuuOi9rBDWg==
X-Received: by 2002:a05:600c:1c84:b0:41a:b310:8959 with SMTP id k4-20020a05600c1c8400b0041ab3108959mr2210636wms.32.1714744613625;
        Fri, 03 May 2024 06:56:53 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id w6-20020a05600c474600b004182b87aaacsm5738160wmo.14.2024.05.03.06.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 06:56:53 -0700 (PDT)
Message-ID: <6634ed25.050a0220.78e65.3123@mx.google.com>
X-Google-Original-Message-ID: <ZjTtIw3tgJVYuEDa@Ansuel-XPS.>
Date: Fri, 3 May 2024 15:56:51 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>,
	linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel =?iso-8859-1?Q?Gonz=E1lez?= Cabanelas <dgcbueu@gmail.com>
Subject: Re: [PATCH 6/6] bmips: dma: drop redundant boot_cpu_type in
 arch_dma_sync
References: <20240503135455.966-1-ansuelsmth@gmail.com>
 <20240503135455.966-7-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503135455.966-7-ansuelsmth@gmail.com>

On Fri, May 03, 2024 at 03:54:06PM +0200, Christian Marangi wrote:
> Drop redundant boot_cpu_type in arch_sync_dma_for_cpu_all. These needs
> to be parsed only once and we can make use of bmips_rac_flush_disable to
> disable RAC flush on unsupported CPU.
> 
> Set this value in bmips_cpu_setup for unsupported CPU to skip this
> redundant check every time DMA needs to be synced.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Sent by mistake please ignore and use the other PATCH 6/6 patch. (wrong commit title)

-- 
	Ansuel

