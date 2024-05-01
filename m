Return-Path: <linux-kernel+bounces-165389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8828B8C25
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A606A1C2117E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C21712F586;
	Wed,  1 May 2024 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g56enQL0"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6148153379;
	Wed,  1 May 2024 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714574849; cv=none; b=Zn90dMAXmYXHYHohDO00eMUbDXzCb6OlRkn9TVkveJspx5kOUsPARX8UlapGT6GNPKbNd+helNT9lHia3wkHBL8Ci7lLgNLjli6XOnSlt5czcElq7BdkAXboSd22pHMS1Z5wDTzKdYQFqJ64Cmyr4YsEA1aRqClqvEMa4wwuIK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714574849; c=relaxed/simple;
	bh=pjboBw7lbIXB1VFaVWC0GZOCQcohZM/vA6aD8MfesL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VljqhCkYMrs281Z6w48UzRG1TLSQVHcBsH8O9mxLlUUm4kDVbj097NQiE11iG0fCsX8PSR1F1gOj1HxQI1GxKQniEyLgYvalCw6HgWqFvQ770kHUbHBgkkRSIp9BV7CmjU1LsyaZWLFjZWDMIU7PKit7jWcHwLVnONU6DVGIDw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g56enQL0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso12489595ad.0;
        Wed, 01 May 2024 07:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714574848; x=1715179648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Fl+fLmRZyiDNW/6JyUoRJz4DQMZ9LCyXCbw+ImdrLo=;
        b=g56enQL0sKt4/xiXD74rfeQyrracArurMFCV/FF3D9LcfMpyPqyP87L4km0kuDUsDE
         CZlQBj8IGP6cfjv/okOJDT4fqzBR7D1HJMh8K4+aOyqm6YG0I5lP3yq4ER1bsc3VYo1q
         lc5jUglErEQFDkr9jsYrDs13aYhcXNvX3ZWhBL+ZJ/gUpoyl7ca1v+WWsp5SF1ETPSQd
         RCCD9YbMfODYYAq2QwQ4eikG1VtZRQ/Z4DgsHiWd2s3KCEvRJUCjjEM63ohLBJYRVrmo
         5mpv3phYXD8pnApEAMJ1x2TkVtmlygKtJRtYYhaHJs1HISW6PcK4BNe0ytAYSarbCWUj
         AN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714574848; x=1715179648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Fl+fLmRZyiDNW/6JyUoRJz4DQMZ9LCyXCbw+ImdrLo=;
        b=wddduA/kq6VlCVtVvZM5BOiC4tNKJ3A1hLWaKLlw5OGju2jDwz1FEMXk2j43Hi6N/F
         u4V8slA3cZ+r29U5OyegE09aUgP2eNPaRURlzeThmE5yUTG6v2X6zKhlvk7ZBIjAaB1W
         U3U7ZDjO0JRyaS/lNVddH6zU8YyU+jrDzZBKSORuZtuJPHFYXCkfRscZkzCZgUnKsZR3
         RaCAOo/K1dhxWGVX6/xZq6XeY3b9YPJP+ZDEWU6TsqgtzntqBy4nUyLzdfab5olEzxIQ
         jVBv+hkF3gjsZAz0dvhir8ClsRMkk3U1KKhImhnLul0zwGg6LBioJ60RzPn8d8KscuNj
         75VA==
X-Forwarded-Encrypted: i=1; AJvYcCWVPHewHcXwpt2ULbrr10hxPrufdqz4PH6vSP6FSrWbbiA4gwk7jxflMdKESmQio3y+6XdbWnYZ3tCWkE+73aNEzQzfBFJYEUun5MBvc+Fm7m8TJjtajjLyAXZahXKlsrHJgsv0v5y+sQ/gPcf4/T6f2C7n/AKWZ6+YzsT0+XTCZHDSM1UtlEQ2CIc=
X-Gm-Message-State: AOJu0Yxhno2m+T78Mn0YaHv34Z8QZ6Ad6hgQYyN8MkrrnKs7jUEIxAml
	6m3aboWX2ntMj7KIzaC4oS8R+8mjgsywJyjimKQnH9T/hYAL+DxR
X-Google-Smtp-Source: AGHT+IGgpIAXcFz1mMO9Yvnre1zeYuS5SHuvMtJ2mjS8Nwz+CACsWDEtmKwlEEfZxFUJp/H/q+7CNQ==
X-Received: by 2002:a17:902:ea86:b0:1ea:a87f:bd2c with SMTP id x6-20020a170902ea8600b001eaa87fbd2cmr2593775plb.68.1714574847597;
        Wed, 01 May 2024 07:47:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q17-20020a17090311d100b001e904b1d164sm21162840plh.177.2024.05.01.07.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:47:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 1 May 2024 07:47:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, openbmc@lists.ozlabs.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (npcm750-pwm-fan) Remove another unused field
 in struct npcm7xx_cooling_device
Message-ID: <68a66010-97ca-4278-8dcf-95f01fec9d45@roeck-us.net>
References: <74eee8aa739f94b8c6425ce3e37a427ca92243ea.1714505655.git.christophe.jaillet@wanadoo.fr>
 <2ff738663d40ac5ae3d0b4d2e688ff7e36032be8.1714505655.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ff738663d40ac5ae3d0b4d2e688ff7e36032be8.1714505655.git.christophe.jaillet@wanadoo.fr>

On Tue, Apr 30, 2024 at 09:35:38PM +0200, Christophe JAILLET wrote:
> In "struct npcm7xx_cooling_device", the 'pwm_clk_freq' field is only
> written and never used.
> 
> Remove it and update npcm7xx_pwm_init() accordingly.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied.

Thanks,
Guenter

