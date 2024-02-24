Return-Path: <linux-kernel+bounces-79879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BFA8627DD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8152D1F217EF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B27C4D59C;
	Sat, 24 Feb 2024 21:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaX6G8k2"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30C6C2D0;
	Sat, 24 Feb 2024 21:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708810764; cv=none; b=s+1MhwIIdNVB9VzrM6REWBriUlJPaPqATUmI2P5J1BZ6brNvw+3JT9A8q15iDZ2XWkOdJ7jP0x5tUNFkjafNSowCHrLJ2YaOhEE9iZWumKI3xf1CuQhO3LbBwegsBG56cy60rpY5In7UJks72sxElH+J/f3Lcu2apdhaWk87EGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708810764; c=relaxed/simple;
	bh=Tu9OK29VGpH/7RoDqIIppvvxvciKCRwxT2ehQJXmT5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HtF1mc4xtC4IeWXwAxDDtuXCV4MSwL+byvFiiSh8jmES/2d/3tyNdRxu9sMpISDQLyz/O3W95EjxCzGmkougjn9sOpm7Si6B3J7txl+QoTa+a/hkahWi919IZ48rtpybpX1whHusHGXaBF5H/gSRW6Uxp/mvG0OGCfG35htZWhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaX6G8k2; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33da51fd636so1202016f8f.3;
        Sat, 24 Feb 2024 13:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708810761; x=1709415561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DkdGdhFoc0akFM5OFRz9BIUNFYP570NY+QU/9XQ+PN4=;
        b=MaX6G8k2PaZ9wKEn1jDcQEeQYWRKqQtSGVQH8ugWWi1A4Qq/trSEx5rjW6/TFiwuHz
         VPwBgaf1wOetj7qbvj3KFcTjS3oaoa/0ZU7nRx3zeCdL40kKpwOSFrT2aBCgYG58ZKBY
         dAbthhLMBsNux4cBF+0R49gqRgchQ/ESn0HtsZp+5w34b3+UBEI4gbLB9el5U4MIeYgp
         NKWrtDwlqBDaYVtbRjtIBFh4i9+SjXkIM3+dMRassVnkA62ds4Y87zXCba2r2oQU+9LY
         1MDI9KURF5rdqFtpuNsRx/j2bpG2dqPggCR/b3zDlf3TzcQA0ZNNo+i3KUykTgMlaWQo
         vpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708810761; x=1709415561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DkdGdhFoc0akFM5OFRz9BIUNFYP570NY+QU/9XQ+PN4=;
        b=heZ1PpqWKz6dZpARjRrmxPVXe7DN0otYlPEOsVzV80wLRNE3GX8Ju7DZke4HcIoMn+
         iGXKiLe191IPnsRPJ4wQ1NLgs6YfBnPuPIYVKeg1XtkySuN1it3T/Evou8YATlfKmyis
         rrjegLHRFRCRWR3gPiTIUVRHZUd4eRVXy/CtAz1S0adEEsiOh/bQeOCS1yjY8d0YiUi+
         nueg7En9SzFttX01KJ7lD994cWZQLaVVV1WCniHkh1quM3AndPVOM2v//gdhIDA6DqQz
         5lnbE3T6KfowyzEW+nfNiDbOlEl2kEeGr5WaxLt1Pyk1H5Ec0mGU7qmG9AoSo2UK0oz6
         QDmw==
X-Forwarded-Encrypted: i=1; AJvYcCXIpB+bWXDFYY0QZl2iRRZ2yeo+fUft2KqjwfR0woXR428IDrwSCYzS4ZDdSOoh9GarQ7rjT4MRZ96bhvc0gMuhQVCZkEs1tw3b7QHGiocYGLYuzt9Fsc1egu2TNiALJX+pA3rSCuFgampJh6Wq
X-Gm-Message-State: AOJu0YxxdEBC6h2PlqPkm02Y/jiMCoeqtKlm/i+EH7nMDeQ8D9XB1OFJ
	mau/8JUrPp7FiUESuiZh6CQSjOA5tA/bNFsFsQxTm24yZAazeO5k
X-Google-Smtp-Source: AGHT+IGKhvrP5vmS7jSBHkidmWWgYtbYT6cKOJlGMZk3qh7TyfIvHiiBl6iNO1h7JSeMCU2HYMI4OQ==
X-Received: by 2002:adf:e284:0:b0:33a:eb25:31a2 with SMTP id v4-20020adfe284000000b0033aeb2531a2mr2396019wri.67.1708810760877;
        Sat, 24 Feb 2024 13:39:20 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d6d42000000b0033b79d385f6sm3190973wri.47.2024.02.24.13.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 13:39:20 -0800 (PST)
Message-ID: <81dc43d9-1a65-4cf3-967c-9ee3458de26a@gmail.com>
Date: Sat, 24 Feb 2024 23:39:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: wwan: t7xx: Prefer struct_size over open coded
 arithmetic
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>,
 Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
 Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
 Liu Haijun <haijun.liu@mediatek.com>,
 M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
 Ricardo Martinez <ricardo.martinez@linux.intel.com>,
 Loic Poulain <loic.poulain@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kees Cook <keescook@chromium.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240224181932.2720-1-erick.archer@gmx.com>
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20240224181932.2720-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.02.2024 20:19, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> As the "port_prox" variable is a pointer to "struct port_proxy" and
> this structure ends in a flexible array:
> 
> struct port_proxy {
> 	[...]
> 	struct t7xx_port ports[];
> };
> 
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the argument "size + size * count" in the
> devm_kzalloc() function.
> 
> This way, the code is more readable and safer.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> 
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

