Return-Path: <linux-kernel+bounces-164715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E2B8B819A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53AA31C22F76
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690811A0AF5;
	Tue, 30 Apr 2024 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="D5iJH4+4"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD0C199E99
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 20:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714509607; cv=none; b=h3Ut/+jpPceOIVhrg6V0lSkVGeBM0HdWmoCfxpSRKr8c/08cV15h39x8qYmpYItMhtALvbKPxRDjGpqP4SZCbz5ToU32DO7F2hD2K5heIlSdQkzAcQa+3BLQR3Gd8e2P6SAdTEUJ5xQEi2KfdnAeW9FzOKuPmxlxOhMQJGuiOC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714509607; c=relaxed/simple;
	bh=oQSngsPwHpqjPWpk2CQtdzD5TSEeud66qrlHa2cPFsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQr/pWblMAIWuTK8k97E+JD267rE1MWhmYlHRkBVC1e0UzBEysW6gzQ55WgCraR5s+GkKj/2T2dFxGiJlMkXBYkGP5LO4NMQwVnJ+XecApQGzezHmmgiag0AyO6ScR3iUwBpzh2uErBs1Dm3bOPDqxxPymGVQxX4Jv9T0AWalrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=D5iJH4+4; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ee3231d95eso115457a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1714509604; x=1715114404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YYgSWxhf4zOPIcEbuWf3i+tS5g0up/+LJ/wCKYsmNQ=;
        b=D5iJH4+4eWojvAlJFfFNbOK0NrVhneQ8iK0IT+BHCN9g9vbAyvAOJr21EZvUSLXIm2
         gE68/bZfE9OiHviN+W7NsfkMoVLJ3Yysz+wceU1SngsmPQGBXUaMoCrW9KDZO9AZWqZr
         TbMcS+PAEZgViIp0CER1c4Y6sgERL62oFaZGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714509604; x=1715114404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YYgSWxhf4zOPIcEbuWf3i+tS5g0up/+LJ/wCKYsmNQ=;
        b=M5rXTcXn0kOKi0IwSFGFtN9ZlbIwxWa63Ra1xR9rLUU6S03dWTUqlLXKWJq+dRKtQ7
         zv0cjapA1vUASLNBnk7eM88sBZdQ+73gUItaTHdtkSlg5l7hujbvIEYHUUdkHpLBMVhM
         p4iydcT2pH75MyxO8AZzeo1sGbijy8BY5Msig1BagYiVjJZgtsaGxx8V+OM7BfSnE4j2
         2AYsG+ddc5roe9yhafVMobfy2/vRvl53dcTCz/PnRpHHdNV2gP7BZW6/jKhfe8v85MY1
         IkTejYIfadWjtxO52nrbTLrewJBz7/dtXDFx5NBAtr6yVlqvow35mdkC23MJQpzzCBbR
         rkCw==
X-Forwarded-Encrypted: i=1; AJvYcCVJPqeZdWbA0aedA245jGm+4AJmOwrwN9+9ysmM18DjB8LyRQQxhxdJIQ7y16kPkNrADuoJxWBnqOKwt32f+hbF50wymgxyb1mqGSM7
X-Gm-Message-State: AOJu0YxGcKpkzlAjCoY2havEygSNEjtMlEYLb9QcVNGVCUghF19eSGL2
	l7pRdYrQpExdNOzVumvk0d3+PCNcrekPnuN8xKBuLTXx9lMn2Fhr5Eoj6GzpoA==
X-Google-Smtp-Source: AGHT+IFRIwaOZIJKk9q6FINe4lpZDhEXBbf7mbgHPgC2qdcV1d/X97KO1ZiGdcpPPLnYfRdPuBcpvw==
X-Received: by 2002:a9d:6d90:0:b0:6ee:3f5f:c4ef with SMTP id x16-20020a9d6d90000000b006ee3f5fc4efmr1871923otp.0.1714509603829;
        Tue, 30 Apr 2024 13:40:03 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id l4-20020a056830268400b006ee64b1c8dfsm395000otu.23.2024.04.30.13.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 13:40:03 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 30 Apr 2024 15:40:01 -0500
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.8 000/228] 6.8.9-rc1 review
Message-ID: <ZjFXIftVw8F1VT6T@fedora64.linuxtx.org>
References: <20240430103103.806426847@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>

On Tue, Apr 30, 2024 at 12:36:18PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.9 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

