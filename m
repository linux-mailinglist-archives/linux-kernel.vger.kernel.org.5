Return-Path: <linux-kernel+bounces-18391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81568825C76
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 23:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171B6285AF7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B061A36096;
	Fri,  5 Jan 2024 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIWWNajS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E21635890;
	Fri,  5 Jan 2024 22:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6daa89a6452so66195b3a.2;
        Fri, 05 Jan 2024 14:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704493150; x=1705097950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEzsopUw3KlXSSQNrQJ1Qhdx8uIJ/YgpReJRgYkVS+Y=;
        b=SIWWNajS8EobwcQtCHpwnkPWF/e4zUgZTpI2uYt3S+pOWEIG97ly2KwCLnePm0O1cw
         nX2Hf/0P++U1bIWEIe509QHRVwI2qudjlfjbnUg+WVR9iES9xATKSNK8w1VMWprm0wFp
         NzcKH+o3/JoK9Ii4byaVJ78E9NBVz7XbvMqKzgYz2b/ICgfMXqUQdIcC72t9TE4oWpgs
         6qwmc0pWR0YJbl+wfI05/rv2+35q33tlCS2P6zVcWXB1c8CcOLhPigKC2ezxriMyiQbN
         J+kig22aVsqHWznkgUdhW/0XbFA/aX/uBBd0VVMPhobf87MPfM9NxQAOY51VczXiiHxR
         fNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704493150; x=1705097950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEzsopUw3KlXSSQNrQJ1Qhdx8uIJ/YgpReJRgYkVS+Y=;
        b=HxRw3skemK6ntiy+mCG2gpt2kdpWqWFCkXucAcmmtRa+edOeimC0IrSqjCIY88nnkD
         faVOfPtetdPsDGjiZ68VvfAwXJQwOzjgXHbTeQcjvmJxqHWyhlnOmp7OJFjWTVBVPtwb
         X1nhPE0RWOM1UH9Op9/TKgcrPvP63wn/gIPHN0io/v/o0Np1bFuIrQHUnlVMy/CE1prB
         aSiMnvP8wC55fNZsG4mevO5LmE3qSS9Bzs8Q4IE5uH9egAB3GDx9p6PRgHo63GlLqi9m
         y3mZ5ii9esPWc1B5NZpC4Mi+Hnu1eN4aWdp1EBswKsLwjtUooOgwC4iRxwm07/dXVxXX
         iRhw==
X-Gm-Message-State: AOJu0Yz9H1KvVIpRRxpchkcmW3Fj/v24YOwFIK5b/N0jZOjySqQmgRab
	f7vdBdMDVzTBHwLU17uDPJmA8gFjZKM=
X-Google-Smtp-Source: AGHT+IHYaVUvDYTytHoUAgoh6ibf8bs4vasMNCYNnWAsi42vIgp5xLNGQPbQlS6nTSo1LgxdHfcYRg==
X-Received: by 2002:a05:6a00:3d44:b0:6d9:bb6b:f418 with SMTP id lp4-20020a056a003d4400b006d9bb6bf418mr30109pfb.2.1704493149774;
        Fri, 05 Jan 2024 14:19:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u6-20020aa78386000000b006da6b404e7dsm1856783pfm.63.2024.01.05.14.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 14:19:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 5 Jan 2024 14:19:07 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Pavel Machek <pavel@denx.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 4.19 00/41] 4.19.304-rc1 review
Message-ID: <72a5ad9b-4e10-4e8a-995d-a7450ab47a5c@roeck-us.net>
References: <20240105143813.957669139@linuxfoundation.org>
 <ZZh1MloSmA7F4Z2Z@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZh1MloSmA7F4Z2Z@duo.ucw.cz>

On Fri, Jan 05, 2024 at 10:31:30PM +0100, Pavel Machek wrote:
> Hi!
> 
> > This is the start of the stable review cycle for the 4.19.304 release.
> > There are 41 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
> CIP testing did not find any problems here:
> 
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-4.19.y
> 
> Tested-by: Pavel Machek (CIP) <pavel@denx.de>
> 
> Best regards,
>                                                                 Pavel

Odd, I didn't get the rc announcement. The same happened with the e-mail
announcing 5.15.146-rc1. That makes me woner if my spam filters are too
strict. Do others have similar problems ?

Thanks,
Guenter

