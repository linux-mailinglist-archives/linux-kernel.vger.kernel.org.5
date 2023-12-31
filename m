Return-Path: <linux-kernel+bounces-13749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914B8820BF7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 17:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 525A0B21374
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 16:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48048801;
	Sun, 31 Dec 2023 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diNbtxNe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C138F42;
	Sun, 31 Dec 2023 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3aa0321b5so65861145ad.2;
        Sun, 31 Dec 2023 08:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704040383; x=1704645183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMrjXLFyZ7sydj2+FYft9slf8SlVSgmYXTiwv8QTWok=;
        b=diNbtxNeXxi+wt+QC5Xp+VKO4h5QlAhGniyDEu9atmJ+lBarbFQB4v1Fpd1lIoDgWW
         r5z7CxQXrpmtVPloHxFqmgZpk6rJTHVoqDiFhz03kz/KzHck2pXV2YVgNtQVXn6yOW7r
         tFB0gYtm3j62gp+WJ0Ey6hqGjaem1ZZGxFfcYdnWuC/aDDOnRlNFOkGf/qE26uo6XFsU
         W9Ht1EuFvEvDMW+IVmuz/S2EXYTEHFMQ1wDltPrsYhvZf/FnE12vvz1brEcBYxd2vxlE
         sJ+SjX1P4FwyQwcxA6NFKfOqNJYnRbs9fZ8M6Da6H+cucRZqNEqAbdT6qomBqvyiSN2V
         2EzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704040383; x=1704645183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMrjXLFyZ7sydj2+FYft9slf8SlVSgmYXTiwv8QTWok=;
        b=k9bbKbtbSmSkckgd0fZmVFHTwGw/YHh3M6gyYzHNjs5VOtCsu3q87431AkfYEG50qk
         N7PskDdWPhQe8PLEhHjyrhJvUEIJnxxuQHL4EKzezP5rnvhRdhYA6XiAe/OOFZnAhj9s
         srSxagC3UKsFdLLrmj3WR9yafsSWNgy5AHFH72WPthNfYe7IFnk7JBXrVOnsFdUotpys
         U6KAUanJIh7BFlnPO0XCr3/OqP5C8pQK4lZ8XhF/dlr2x3htV0SB1w9+miJYKqiCgpUR
         xzAZhsZE2nRGed3BMPyC4uuh16mRqHgT3QEMfFcfXhoJQMwvRSBeuJ665ZGlJgsbVXU9
         matQ==
X-Gm-Message-State: AOJu0Yyz/sHPmtwH2PzDArk8AOp+w6v7AC7npVcsV7oPKjjmuzUPfv8A
	brn5Gn6gs+AoMcWqAlwUBsU=
X-Google-Smtp-Source: AGHT+IHfurOYCOL7l5tsZ46Xzsi1qIHnQxh8Vlgqm97Wr86HJCTMy+dEkHLpy1g4RXFqDeH2HcgQoQ==
X-Received: by 2002:a17:903:41c4:b0:1d4:575c:45b0 with SMTP id u4-20020a17090341c400b001d4575c45b0mr15276162ple.91.1704040382878;
        Sun, 31 Dec 2023 08:33:02 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902ea0500b001d45f92c436sm12005130plg.5.2023.12.31.08.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 08:33:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 31 Dec 2023 08:33:01 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/112] 6.1.70-rc1 review
Message-ID: <92966cc2-7726-4a31-ae4c-5d1b0a5dd0e8@roeck-us.net>
References: <20231230115806.714618407@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231230115806.714618407@linuxfoundation.org>

On Sat, Dec 30, 2023 at 11:58:33AM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.70 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 01 Jan 2024 11:57:43 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 544 pass: 544 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

