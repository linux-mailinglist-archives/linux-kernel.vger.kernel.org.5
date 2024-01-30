Return-Path: <linux-kernel+bounces-44754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB638426FE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC7F5B28AA0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD676A34B;
	Tue, 30 Jan 2024 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="hOx88CkY"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272B474E17;
	Tue, 30 Jan 2024 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706625164; cv=none; b=bFNgB7tU3BXJzNvLnPPJ9Yt3swioCHI/Be28Nck7feRYsml99Uj8HRRvNNDZxe3b2MU0YrMyegd0mv2R4It+cWqCuCF/PLndM06pB1XrP/uQ0zZWY1Gg8xzifX89JjCaDGjn4DoiRXWTn+XLe39x/q7aXArpz+RMtfw/+VUrd8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706625164; c=relaxed/simple;
	bh=nuQGv1Jds4FtXlqqQLPGMEKmNz6TXTY7xb77Rn4Uis0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kK3sv2na5MkndJ/NgostJXD3Ih6xmg7HzaKWLGNkzg3fK3BlPBaKMwMqCWsxxPJdpJbYCC0MNaxfj1okwJX1to6X7knUDLLgW5MeNJDS8h4wv8TENxwzcNSvL2+v0uSJd4OkM93LwUeYx9b59NAhKAyW2Wy2aNGq21p/oylhcSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=hOx88CkY reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so2137961a12.0;
        Tue, 30 Jan 2024 06:32:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706625161; x=1707229961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n1bRZI/oUopCNXOjXdeojE7GQGN2Uu9IDwrj3sROkxw=;
        b=uDvRruN2hmj14UiOj9wn2SENQBCunpUvvuAPkPtj+QR7tUHB7MuEd63cWIQ92a9RtI
         wXVsM4xJSNwdmOhS7cKSOuHgbUQ/3H0AxDu9j3SYrjtCObVk8tdCNEfA69KZUGHkbHVF
         FZ2usNnPssIyZGP+llP6C0CwbD97VeTTzIGxsQ2pGs/no94TNiB0Gj/g8X5/ZIUVGwRg
         xBnFsRLZHz61zXXScZ1Rzo5uJQcpUzcIpT1bCh5VLUR4KvegYBDkq0Ija8qDJ46lLJWW
         FSgKuySRJLSOA7bsQ4afqcFZUC5xwahS3VvSFwv70WGBF/Mtzec7VEUlXlhgFfbz7ZDi
         GkJA==
X-Gm-Message-State: AOJu0Yx5ALVgnWHMY+CR0eHVN2wkmnaqhMBaYzoyH4kJSHmlkxnxKaGJ
	+gs6h2G+4TXLqkJwO6+eCT5LiVf2yFRCiOkSwDmaG2jBhoEsHSJ2
X-Google-Smtp-Source: AGHT+IFiv7dYpDESmpNj9u3X8FlcxqrpBMcMuVqkQU4azqWhgsppFKd2Eu2fF4hLHtoNgEOAQcofDQ==
X-Received: by 2002:a05:6a20:6d91:b0:19c:7e49:495a with SMTP id gl17-20020a056a206d9100b0019c7e49495amr4123145pzb.57.1706625161337;
        Tue, 30 Jan 2024 06:32:41 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id a8-20020a62d408000000b006dbdac1595esm8469877pfh.141.2024.01.30.06.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 06:32:40 -0800 (PST)
Date: Tue, 30 Jan 2024 11:33:01 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706625158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n1bRZI/oUopCNXOjXdeojE7GQGN2Uu9IDwrj3sROkxw=;
	b=hOx88CkYwmXA3RcMYHBDx+Zk6hEYtjKrKCCssw5Xw2NpUTGcVyGUl4Zm0c9U+9o9m+Xzf2
	c5gLOskrGzneBORNFPToP+UcrXO4GYW5htTamgBgThdQdxYmY3QNX2GB5VGVcGPdVyNboB
	hFp9tCXH9Clkx/swjh/olFBhA3wB7luaqeUxkyjdg0C/rwyJl2cPp2+plVTvQ77ob6mAcc
	DPR9aqkkFsr71u0p1FYrrA8kdCmWtIMVWVEgzdZ1QK7hoAoboo90j2vHAnAOfBgb1O3mnk
	SvT8bsdZH7j+ZOz+W9IL94QzWAeOh/BgB8vwaMjLUBFyGejuGmY2YwwDifbcJg==
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
Subject: Re: [PATCH 6.7 000/346] 6.7.3-rc1 review
Message-ID: <pivme2beq4h7wrbmjt7s6s4jgihyh5y2tt5rjt3c2flvtto4ao@y5iflivhyz6u>
References: <20240129170016.356158639@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>

On 29 Jan 09:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.3 release.
> There are 346 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> thanks,

Hi Greg,

No noticeable regressions on my system.
[    0.000000] Linux version 6.7.3-rc1-ktest-g7c05c677b6ca (rbmarliere@debian) (gcc (Debian 13.2.0-12) 13.2.0, GNU ld (GNU Binutils for Debian) 2.42) #2 SMP PREEMPT_DYNAMIC Mon Jan 29 22:13:17 -03 2024

Tested-by: Ricardo B. Marliere <ricardo@marliere.net>


Thank you,
-	Ricardo.


