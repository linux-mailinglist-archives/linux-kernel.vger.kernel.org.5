Return-Path: <linux-kernel+bounces-17428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C415824D17
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46FA1C219F8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD48440E;
	Fri,  5 Jan 2024 02:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8UlcejX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E529A2107;
	Fri,  5 Jan 2024 02:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EE2C4339A;
	Fri,  5 Jan 2024 02:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704422577;
	bh=barjzUtSMCfNPt2kYjSmX/9hfaoE0y6ATBZOltLmcTc=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=d8UlcejXlqi/LWNLY1ZJ9GoxLD5X6t49JzmHkfdvsTXdGKkS3GaAXJzR0BreIY9xt
	 Daifnl3uPlQgcqDnlUaWh2Zq4rnJfHCJgif/GWeUzKCv07xrSUT4qGUkNAY4lRu/EH
	 NWMtjHU1tt2aNAWUAJDzt1y1WfGWZUM6RtP/OqARPxCRKG1g1/e1UUDjT28hoA4Gs3
	 ifHHVO28NvUQ5AXB/U7ofbMkZDEDCbF8ieqKacDUixiZqyGG+N6fpT+xml24NTOF1X
	 0SFLSI3lV8XWxBDXBxchNMzVshRBEGk4nTURkklS2o1b4ophKpzTqGBzsPbGJgVveY
	 sSkVMddTRz8Qg==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5955a4a9b23so511179eaf.1;
        Thu, 04 Jan 2024 18:42:57 -0800 (PST)
X-Gm-Message-State: AOJu0Yx1DIS74cvaPUQcl0QPJ1CtGrAWFF49uRHp4ghuT8F3WPt3qd5S
	FlrM5YOaE3QhjXZUgjHKiEiw6Nn47hdXsxeQumI=
X-Google-Smtp-Source: AGHT+IGshPQgVZKaG/gwBIhPlKm/P+H79qim1ajJuEF13kbsFUad9tYzPi3gyx191lwUaE4vHmU35YLIuXZjLRyQ1ts=
X-Received: by 2002:a05:6820:1c97:b0:596:248b:a73 with SMTP id
 ct23-20020a0568201c9700b00596248b0a73mr2197471oob.10.1704422576536; Thu, 04
 Jan 2024 18:42:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a8a:c13:0:b0:511:f2c1:11ee with HTTP; Thu, 4 Jan 2024
 18:42:55 -0800 (PST)
In-Reply-To: <20240103164856.169912722@linuxfoundation.org>
References: <20240103164856.169912722@linuxfoundation.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 5 Jan 2024 11:42:55 +0900
X-Gmail-Original-Message-ID: <CAKYAXd91bJV98qW4BKtrnXkE7qobegFKFTK7J5T+6VUgFGZnPw@mail.gmail.com>
Message-ID: <CAKYAXd91bJV98qW4BKtrnXkE7qobegFKFTK7J5T+6VUgFGZnPw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/100] 6.1.71-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"

2024-01-04 1:53 GMT+09:00, Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> This is the start of the stable review cycle for the 6.1.71 release.
> There are 100 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.71-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
I have tested smbtorture and tests through windows client against ksmbd.

Tested-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!

