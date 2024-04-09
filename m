Return-Path: <linux-kernel+bounces-137580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B5E89E43B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83DF2B220E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9257158205;
	Tue,  9 Apr 2024 20:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lor+Vqi7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9228562A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712693686; cv=none; b=sAgxO9INkMG87qq2Xo1ptWbAgerGKRRNQvs8qKv/B1EGHWFhyN2G4HTLGdTxDEATKcVZZdQ4JcmkZvPD/5WC2FGw6XkK6gPlyQKPlaRJ1jzT7z9XxdcqE0efJXNZrfY5ZAZsuxNXZjnDRU5VwZAzl9MNicFrTAf3/Ctd/N967ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712693686; c=relaxed/simple;
	bh=ibAqeCoQkmuMa06beBnZLbNBG1bw+Wt8jm5FJ7Cf0JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYT50Hm9CY5jvF8PRZOvz6IeVPWprPllCuaOOHPdhb0z0QaWP8ylYCsyIFnv2JzUVyGGs3qxBUqwvA5FV1X8MxrnEfKpw+yrmMLDyAwqGm1stGpWkUp/TgQCnwf2F8zUXQrk8odSiiC4ir/NRDUXKf/xCSbjRtVvxg59b+bjamM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lor+Vqi7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E73C433C7;
	Tue,  9 Apr 2024 20:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712693685;
	bh=ibAqeCoQkmuMa06beBnZLbNBG1bw+Wt8jm5FJ7Cf0JI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lor+Vqi7BhXthadgCQTo8fDbY3H7ttnAo1JOTzdQV7Yzo2VxCiaEnDcTsS3jEhUeX
	 iWdO6Vz3YsY2pBfrwG4nfhDOZe8BTK+LBmo0ZkAD0QPewbDjxMm5F8F+Gw6RV+DPx9
	 aJJ5F9cMHr2T1y/91kjUyG4d3ABOOyRd1FAe4dL/5WJxb6xBlx7UXiyGe0yh78kaaJ
	 EUPb800+VeBeKMfS+nhM/dYTHfGIaawUMQHwvfaSMAotSD7FW6RyTUsYUVtgnxqLbV
	 MMZL8XplMbLAEV69NkBWJr0zQ5IcMtp2+3nVfIjQ8I3TubHHiPDDQEvcXOMstri7bM
	 gMyo41lA395CQ==
Date: Tue, 9 Apr 2024 14:14:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: Holger Huo <holgerhuo@outlook.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Holger Huo <i@holger.one>
Subject: Re: [PATCH] drivers/nvme: Add quirks for device 1cc4:6a14
Message-ID: <ZhWhshq7hpPd9XrI@kbusch-mbp.dhcp.thefacebook.com>
References: <ME3P282MB24818FA28E7C73BC01302882B5072@ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ME3P282MB24818FA28E7C73BC01302882B5072@ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM>

On Wed, Apr 10, 2024 at 03:28:50AM +0800, Holger Huo wrote:
> This commit adds NVME_QUIRK_BOGUS_NID for device [1cc4:6a14], the
> Shenzhen Unionmemory Information System Ltd. RPEYJ1T24MKN2QWY PCIe
> 4.0 NVMe SSD 1024GB (DRAM-less), which can be found on many Lenovo
> notebooks. This SSD produces all-zero nguid.
> 
> Other SSDs manufatured by Shenzhen Unionmemory Information System
> Ltd are likely to face similar issues, but I currently have no
> device to test.

Are you using the most recent stable kernel and still need this patch?
These quirks shouldn't be necessary anymore unless it's advertising
multipath capabilities, and it doesn't sound like this one should be
doing that.

