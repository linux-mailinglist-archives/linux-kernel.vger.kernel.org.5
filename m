Return-Path: <linux-kernel+bounces-57882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB0584DE95
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D941F2144B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4E06DCEA;
	Thu,  8 Feb 2024 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWPEmkiN"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD066A8C6;
	Thu,  8 Feb 2024 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389211; cv=none; b=H7QSUroEzDclR4MJyyFthv/aEm6nwVv02DltJDgJSXPRLyq/fGRGL+7qF61AORzvJEYcgJPVO35vDGDuXiLeuIsHltP2iPwQFjhCdYincrvuj7BiT3sZpzZCZHs9GqvZKyxRUFzC5U13N0q6m4c2MbpbyA5uBGXekCUYhIxe3vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389211; c=relaxed/simple;
	bh=+6JGq4Q4i/2rxQ/hd551UDrluUPrXlEMEsqWEVqLbok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWvPasSujcM7FppWmKqwNFQ2v4Xaey4el5C5DUN8DDw12hCsLUXUUDsHy9IMtOOkyUFBal2kgkMNQ3TLmivM/os5gaiuaIplxklcapjhJBRVijw6sEUw9/5YwvQ+Wq3nV9ddWoxmhcGtnuFxbvAjdyXBRd3GzMLjrUPXxAddq2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWPEmkiN; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3832ef7726so200726766b.0;
        Thu, 08 Feb 2024 02:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707389207; x=1707994007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hVfj0mGKenh7sh/LQJJnzIaJzg4BySJc+5osuuIf1hI=;
        b=lWPEmkiN/GaiLgojAxIaKGyjsQf2dt7KsmC39jWju/2oWkHEYb6pXrMSDDgYvIu7FX
         l9/l95yA4rTPsmg/wZeAsVPctcm37VXafGYIwK4LWhpvN4n0zvOqCvtTwWJ1T3G7y2Kt
         4+NQkyXRkACIRLfmmUvomz4zOc5GRqtw1BzfWgII/GOxPw3j/sv4SOnSgw075L8JFVQ+
         cuXtPwDAINO2AqYDuHG27q9Dy5bzlmnlinTVufZdkWAlm2cR9NhrQU1PYcwdPrQpz/FY
         UryH98yupio8o5PPAn7f33sbdiX3q9ptnxaun8ODDbjqFT66cC2iwXmTUYJmUP8pu8Ka
         +EgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707389207; x=1707994007;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVfj0mGKenh7sh/LQJJnzIaJzg4BySJc+5osuuIf1hI=;
        b=sK7Fku29C5L+9fQzLisboNyVKPWxZ5QKUdDS9bKmVGS6jZqicCJrMSNOMF6peD2pdm
         LqJb8u26/05R6awW1IClIGuTMZYcLkUa6CSJvs2H167DH342+217xL7+Ob7fnxDAz828
         SWfZY1fVBwxMXReUluXqfuf0LxkBIreGJqJSEV5NlFCyWVWAcWw3artTMi1D2ZmMgi+J
         jBgG/gsiyDa0XfOKMaSTdBbczIH8T32rcrJBZyeNuaaX+RZyEZUdpWVWMpOU/kRpeHIP
         9VLg0A3gfde2zLpnCeHaNDNRigzCcna3M519nOF9P95hFwD3AOSU8CFHheuDF/jklY4q
         yOKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKoyKERT6C7DPvTj5TMZ3KgcW2fpvaeyoGPb1KhRfzMpMm0DascHbdqkG13QVcvcpOiI7gLi+tjPYatxK1UDPK79Lqy+OLOuTxv7LX
X-Gm-Message-State: AOJu0YyZr+nzKczbILB+9I2l9gAZ5NhoQYVnnQ/0tevAKBtoR2ofrux8
	Ds+4MeKqNTykgims9CWQuNjUmv+Jg8QNBRxhofNxiO2CPs/WgDoA
X-Google-Smtp-Source: AGHT+IGIaj6CrTWwyEFBKJxFfesEa71doCCs1CJxOO0hSVEwedhVAatadiRlx3PIGWeyIOVhMUfPyA==
X-Received: by 2002:a17:906:168e:b0:a38:41bf:f6f6 with SMTP id s14-20020a170906168e00b00a3841bff6f6mr4592476ejd.77.1707389207260;
        Thu, 08 Feb 2024 02:46:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXhicQLMa9wX39q+zgzpiEMQIY7KjFh9x7rfu2Spd06biFbR/CRKYX6FSWZ8mpCymQlCcjPzuYNKKIQ9AeFpn+Ei5//pC2x7GZAI2PgjLpEC2cj+3jnTTVqAhXYyaMU8iKtbAw26jpM2nWHmMveq9tbzHKcC9Pp5Lj08VpHvR0n+vlbtf4eiLndUFaJ/ZvHErPMfvfG6aiWwGkTIhWv1tHZ
Received: from ?IPV6:2a01:c23:c599:8500:b9b1:3254:a1ac:4417? (dynamic-2a01-0c23-c599-8500-b9b1-3254-a1ac-4417.c23.pool.telefonica.de. [2a01:c23:c599:8500:b9b1:3254:a1ac:4417])
        by smtp.googlemail.com with ESMTPSA id vg11-20020a170907d30b00b00a37210f1e92sm1788038ejc.205.2024.02.08.02.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 02:46:46 -0800 (PST)
Message-ID: <fd72544a-f3ed-44bb-86e3-bdfa4fca720e@gmail.com>
Date: Thu, 8 Feb 2024 11:46:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next20240208: tg3 driver nw interfaces not getting
 configured
Content-Language: en-US
To: "Aithal, Srikanth" <sraithal@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, andrew@lunn.ch,
 Jakub Kicinski <kuba@kernel.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20240208155740.24c6ada7@canb.auug.org.au>
 <ce7150b7-b6f1-4635-ba5f-fdfda84a6e2f@amd.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <ce7150b7-b6f1-4635-ba5f-fdfda84a6e2f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08.02.2024 09:30, Aithal, Srikanth wrote:
> Hi,
> 
> On 6.8.0-rc3-next-20240208, the network interfaces are not getting configured.
> 
Thanks for the report. Could you please elaborate on what "not getting
configured" means in detail?
- Any error in any log?
- Any other error message?
- Interface doesn't come up or which specific configuration are you missing?

> I have 'NetXtreme BCM5720 Gigabit Ethernet PCIe'
>        configuration: autonegotiation=on broadcast=yes driver=tg3
> 
> If I revert below commit I am able to get back the interfaces mentioned.
> 
> commit 9bc791341bc9a5c22b94889aa37993bb69faa317
> Author: Heiner Kallweit <hkallweit1@gmail.com>
> Date:   Sat Feb 3 22:12:50 2024 +0100
> 
>     tg3: convert EEE handling to use linkmode bitmaps
> 
>     Convert EEE handling to use linkmode bitmaps. This prepares for
>     removing the legacy bitmaps from struct ethtool_keee.
>     No functional change intended.
> 
>     Note: The change to mii_eee_cap1_mod_linkmode_t(tp->eee.advertised, val)
>     in tg3_phy_autoneg_cfg() isn't completely obvious, but it doesn't change
>     the current functionality.
> 
>     Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>     Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>     Link: https://lore.kernel.org/r/0652b910-6bcc-421f-8769-38f7dae5037e@gmail.com
>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> 
> The same works fine on 6.8.0-rc3-next-20240207.
> 
> Thanks,
> Srikanth Aithal
> sraithal@amd.com
Heiner

