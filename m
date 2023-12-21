Return-Path: <linux-kernel+bounces-8601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C707681BA04
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 247FFB25134
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC894AF8F;
	Thu, 21 Dec 2023 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMdi7jfv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1045E37168;
	Thu, 21 Dec 2023 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d3dee5f534so14457555ad.1;
        Thu, 21 Dec 2023 06:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703170662; x=1703775462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3USUl9WO2gcOQwDnVCeaBX3q/QuTE9UFOGfxgimai4=;
        b=UMdi7jfvHUDGhSCeuYvG2KETN9NFclrIBzSKrD3MEhny89Zmjm1MNEj4wOFQtLRzNH
         RmeLpmxrO/rMv0usruXt9DWqrgu026crXC628T34xCRR9iWPnbBmuZ3MalQuUcFePQLk
         J1DRXKZeUAiIdtKk8tcyX+t/jQwgm0B/0kIXa7QD6uJ7ItLFh5NGd0IYENq6SoE0iYyX
         9+PrhAaQiZE2QNGjLt9hLCoOwPEcCLbeWLssc0hL/72U9umq0ZDJdA1rsOh5Vt8w5xxb
         g0SciyQ26Epux4gby/XwUWvzVvdhHi/spoz7KRa84dVQnCWn33PAIs1u5Wzohn3JnMcA
         9MEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703170662; x=1703775462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3USUl9WO2gcOQwDnVCeaBX3q/QuTE9UFOGfxgimai4=;
        b=KXhjBK5FS0gq1grFnfOYpfF2k3FCZ3NBwsfFpIqADDd3nRuNYi9bIWZpQIgy2v+epp
         EuGyc2c9aLe3GujsA/llCc44izClO8ZySVGg3j8RKOW1Etpw+5GDZ7dwAy5Q8wEkG45s
         yiCnwu6cGBFRmN3UVtO7Dplf8Rk7y4ZHwLZRwAIVbh7T+y2qcwXi9hPlYMIdCVG0ba3T
         QWW6BDPuHQxi9h/754G0+YShCl7aGOO1xd4isiHJylSf/TOnPUv42v6k1NiK93qrna1/
         slEaMC/tYQyLlq6mxRTNMQ7UPDF0x/NUQ4y6IeW7icjTIfTU/x+2ceQvPqJNRrLH9TWf
         7zrw==
X-Gm-Message-State: AOJu0Yzjww0Iuk3nC6JaoFAN2VBWeg36Po5j0v4REHWCEDpd7WLyJWoc
	IjIgzMbSd09avoRf/jQz7vY=
X-Google-Smtp-Source: AGHT+IE5wFdUULiCY8ELFxZqWGyGPK5/+XMGldnySVulFribOOOrmtJkIkISv8i7aleKcpl8MtnXpw==
X-Received: by 2002:a17:903:22cf:b0:1d3:cc75:63a4 with SMTP id y15-20020a17090322cf00b001d3cc7563a4mr973865plg.21.1703170662197;
        Thu, 21 Dec 2023 06:57:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902cec500b001d07ebef623sm1750024plg.69.2023.12.21.06.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 06:57:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 21 Dec 2023 06:57:40 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 5.15 000/159] 5.15.145-rc1 review
Message-ID: <9307d019-b0ea-41ed-a559-2fb14022295d@roeck-us.net>
References: <20231220160931.251686445@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220160931.251686445@linuxfoundation.org>

On Wed, Dec 20, 2023 at 05:07:45PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.145 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Dec 2023 16:08:59 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 158 pass: 158 fail: 0
Qemu test results:
	total: 525 pass: 525 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

As you may have noticed, the two day response time isn't enough
for my testbed, especially if all releases have to be built and
if there are multiple release candidates.

Guenter

