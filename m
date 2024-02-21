Return-Path: <linux-kernel+bounces-74435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3377B85D42E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64DF51C21DA8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2630B3D967;
	Wed, 21 Feb 2024 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="OrfpZQ/8"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106C53D96E;
	Wed, 21 Feb 2024 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508638; cv=none; b=p8badGmFoycqpS/Oke4gvmB+T8IPMuoueJMdEAryELGDP+JA97Yga2qYe+69Nlwu5u4Q0T2TAV5B6ANyraBQXDzemB/f0AfYb0MwKRDSs1m7X+kPge0ZThaBbONNYzNpf7jDT+hPV3+XGIsx+OxYcLKwMgvcHIJdFJd4fAuf9SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508638; c=relaxed/simple;
	bh=zck0md9e9hczZPzGSi9ZNXoWFP+RBH0B66cxeKdD5gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZdwLKXj5pU6XIBbP4O5OhY7vsz6uuKFmuQkcycP+tBh8WU0Vd/jzD+WBdFqlDtVON1cQLm5/Qdgx1+jpMbiC3ZS5CgZiwhh3YRccir5kVglyKy8cgYaoUe3IBALCeR+1sR5kvrrNOPybiX1tJwiwWa01rOjuQpMBp2OKRIDrjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=OrfpZQ/8; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dc09556599so2912375ad.1;
        Wed, 21 Feb 2024 01:43:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708508636; x=1709113436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=htQw3emsO49rg9PiLwzeebHa4gNjc926EdZyaO29woA=;
        b=D/io4jCpvIDcBYW2c5GgYSqab3vx0wItqe5J4j8Xq2VgCbmHVS1dWVRjwqNNGOWAiC
         IupwAqoWUxsIh7aHQhIl+hUWvG6QyQRMDv6L0tFV8xdqESjBXOSljgtGV7N5SfRNprEv
         XzwLR2BkAoenJp1rU7jhyfaARb6WlOsbJazBpeRj+SSZB0qsVZAhtKYFVtJTRAGoAHNi
         8X+ysQCLxdzbWBa2PwaT5WDNNHiUliAERZRTZPwkH4ewKHUQpH/YwkpZ/k5DpRO+P70V
         UmThpPsIK1fiL65iZYPeSmgZk/an6rE5OeWC6rPl8uvgRVz5B4B29xXOuI2o0Zn0r70o
         3QLA==
X-Forwarded-Encrypted: i=1; AJvYcCWVBqhuHzhfLUltSFRL9VqYCi7x5lkYTEigITizBxQhGPROQLczVKKx9bYeSTCCdshwqcGImA3XCSK8oRt+X97/o2CxWlcoYM5/Ish0
X-Gm-Message-State: AOJu0Yy9FISIA2icLEnPAcHEzK/gTb6bbgSm9pn9ZyFj4u+STqaFM3HQ
	v1TgarDD51b7rBxTCiCqfKP3hdJhwcLR0FRmpIoB9PvnlEVE4dZ6
X-Google-Smtp-Source: AGHT+IHKZLIJgAfYu7qXtfxH9GFan+pSJQez4znLuNBb38mjr3W3o1S/FNYjrRLJAQxJhbQLG8vjig==
X-Received: by 2002:a17:902:aa84:b0:1d9:c17b:43f3 with SMTP id d4-20020a170902aa8400b001d9c17b43f3mr16209931plr.15.1708508636058;
        Wed, 21 Feb 2024 01:43:56 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902c38c00b001dbb6fef41fsm7633899plg.257.2024.02.21.01.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 01:43:55 -0800 (PST)
Date: Wed, 21 Feb 2024 06:44:40 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708508633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=htQw3emsO49rg9PiLwzeebHa4gNjc926EdZyaO29woA=;
	b=OrfpZQ/8EjafxtEV7e59t78piOeUhuANuHYD6yMEGQjmkyuzC8tUlK7t2lhgiXhXBlTHRv
	nPnCqRAEFpZiIktMFk63k69nr7MHamseuJU81PVdIgWf+7HQqxN2UYflVH1vLFgf24WxmG
	Pp765Kqa+7jKj6oROkkxfyZS+Zhm1R+S34NJT+C8APyHpLLfdyk0JG5fh5vsxBq3z+/07v
	LPZoBBSkw77DIQRGm/Hvp+54NIMnGi9hXYbWEMhVqj7lg3gYHAjtVrZDvU174FOg8ZE9CR
	NfDlNERAtVDChqBMU1ASsBRL/L2x9nnECCTqt+0QVeo1M+qyvhRwpPA45WlTQg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 000/309] 6.7.6-rc1 review
Message-ID: <3gd2extw6kvhuqwufxhtg6o6goa6hlzahaiwu3dgclnpac4n25@5oru7y5p4ia5>
References: <20240220205633.096363225@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220205633.096363225@linuxfoundation.org>

On 20 Feb 21:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.6 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 22 Feb 2024 20:55:42 +0000.
> Anything received after that time might be too late.

Hi Greg,

no noticeable regressions in my system.

Tested-by: Ricardo B. Marliere <ricardo@marliere.net>

Thanks,
-	Ricardo.



