Return-Path: <linux-kernel+bounces-13662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FCD820AAC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 10:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2616D1C20E1C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 09:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568D31C2F;
	Sun, 31 Dec 2023 09:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZRInQyo7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7194133CA;
	Sun, 31 Dec 2023 09:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E3BC433C7;
	Sun, 31 Dec 2023 09:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704014293;
	bh=lP2RWGTM8NB4X6cFreDs/o9S0hUMZbE0Z2crb6Lsq0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZRInQyo7QXejYfvQzWHMXPbE929GriARFJlQsQXUHrZLWUNMHOn+T+kyET0HgRMzc
	 WmMoXF1d8bJ1zJtKoaU6cqI/gX/hwJEAsCibanr80uAnQC9RxGwlWAkfsvDufz6oxD
	 gsbjU0bDPJvgmW/sJ8E8kKk1MpfRLUZxtBfxJCoM=
Date: Sun, 31 Dec 2023 09:18:10 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Luna Jernberg <droidbittin@gmail.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/156] 6.6.9-rc1 review
Message-ID: <2023123147-canopy-winking-8071@gregkh>
References: <20231230115812.333117904@linuxfoundation.org>
 <CADo9pHhnv8xv1yAPyAzowhU5Z8qw09gUMqj=VMjbku2XbA060w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADo9pHhnv8xv1yAPyAzowhU5Z8qw09gUMqj=VMjbku2XbA060w@mail.gmail.com>

On Sun, Dec 31, 2023 at 04:18:29AM +0100, Luna Jernberg wrote:
> Did not work for me on Debian testing on a Thinkpad Edge i3 laptop
> just booted me to busybox

Did not work in what way?  Is this a regression from the last release?
If so, can you do 'git bisect' to find the offending commit?

thanks,

greg k-h

