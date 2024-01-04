Return-Path: <linux-kernel+bounces-16343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BDD823D0F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC963282D98
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE17200B7;
	Thu,  4 Jan 2024 07:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NGMNvfuY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E466200A0;
	Thu,  4 Jan 2024 07:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AA4C433C8;
	Thu,  4 Jan 2024 07:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704355047;
	bh=UsiFvvQ67rQ9gDRtKFLmtG1DEc7t0Pul+q2ag+yzqhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NGMNvfuYQhJu7t7oDcttALEDFIpXUcUpJ+lKTHQakas1K2/1RfRoYB20s95EGer0v
	 1WzFrrPYBce1kugCRgLNWYQ/SJQZvoVE/pxwrNaiG72+sW9gpbrljbBN5tf5b2rQ3b
	 za5QsBxLjvBUm2bJjfh7BWVwitorzmlvuAknUo1A=
Date: Thu, 4 Jan 2024 08:57:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Luna Jernberg <droidbittin@gmail.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 00/49] 6.6.10-rc1 review
Message-ID: <2024010411-everyday-wrist-4e91@gregkh>
References: <20240103164834.970234661@linuxfoundation.org>
 <CADo9pHiP8rXxLrGdsH5o+0KbR0f8XO+G1a=OgNW6UfD0s_hwAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADo9pHiP8rXxLrGdsH5o+0KbR0f8XO+G1a=OgNW6UfD0s_hwAQ@mail.gmail.com>

On Thu, Jan 04, 2024 at 07:55:02AM +0000, Luna Jernberg wrote:
> Tried to follow this guide:
> https://wiki.archlinux.org/title/Kernel/Traditional_compilation to
> compile it on Crystal Linux based on Arch Linux on a Dell Latitude
> 7390 laptop with a Intel i5-8350U and did not get it to boot
> but the same process worked for the stable 6.6.9 kernel, so guess i
> will just wait for the stable 6.6.10 and try when thats out

Can you use 'git bisect' to find the offending commit?

thanks,

greg k-h

