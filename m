Return-Path: <linux-kernel+bounces-167903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F6C8BB0DE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC2C28101D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F74215538A;
	Fri,  3 May 2024 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSxJmFl+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652FC4D9FD
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714753656; cv=none; b=BSXeTiwoht0Tb3cNeQrqFDMTvLm2XyWKHswUit0PcDGpdo01fjk4rz/N+nJacFOTf/2uoTkUidJYfKWXkPOL6a9hD2qrJ+lCW/Eg92i4Vs8vdVStGHBfcji916q2iFL6wSJh28wQyfkEc4cijE5TjYntSv4zL6KAM1DyhTcfQwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714753656; c=relaxed/simple;
	bh=/5WkH6/GqRaDUYQJDb4/SAmQ283pmiDQISzKI223Yw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuIPxz4CCGVRV/V5D9MXudIA6i5cOVJNUeMUy8S5TBoG+dktnP60ZDnJrpnoLjQ6k5qEJCAQF0h7mzDHwcZ5tMXcoP8e/FUcLld1SLCfGm6h7s9ZkIEntEXQNu/5pPFlL05AjwjxsRkkq2JWPFO/8Trh/4vypmWMkHPjZQH9aFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSxJmFl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAD1C116B1;
	Fri,  3 May 2024 16:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714753656;
	bh=/5WkH6/GqRaDUYQJDb4/SAmQ283pmiDQISzKI223Yw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eSxJmFl+hmo1cor0GBSFAqY1kGiStzeAy3HsDnF5j0GE7l0LjBMZpiC4Aj/iIn9Zv
	 CJmoWaicIEUDAaRbjwbC6W48BLVWULOpcV7HhDDe9qjJXE+5+De5WBuN3PPpWD/r6e
	 66Vn+2Uw388BQq9G2tQVcJAWYJGT70Yk0I7Ntheg9oKjbY2HgMTwi63+fTCrgz7RXe
	 7T3Z3Cnn7A327vlZfyK7Hn5JdcTuvojBGDsuNwLb+reA6t7RBiEYuR4B/hUL4QgEtE
	 RKkOUlBvQD/vAnH8HJNYu1y88jFdss1Ahr1QtUQfw6ThZUesVyKVV+eEg+JmTH4tKs
	 3xAA6+iGPDsSg==
Date: Fri, 3 May 2024 09:27:33 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v3 0/2] Fix Kernel CI issues
Message-ID: <20240503162733.GA4136865@thelio-3990X>
References: <20240426-dp-live-fmt-fix-v3-0-e904b5ae51d7@amd.com>
 <2a14d8ff-a8f5-4ebe-9f0e-a5554b417f0c@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a14d8ff-a8f5-4ebe-9f0e-a5554b417f0c@ideasonboard.com>

Hi Tomi,

On Sat, Apr 27, 2024 at 10:48:16AM +0300, Tomi Valkeinen wrote:
> On 26/04/2024 22:27, Anatoliy Klymenko wrote:
> > Fix number of CI reported W=1 build issues.
> > 
> > Patch 1/2: Fix function arguments description.
> > Closes: https://lore.kernel.org/oe-kbuild-all/202404260616.KFGDpCDN-lkp@intel.com/
> > 
> > Patch 2/2: Fix clang compilation error.
> > Closes: https://lore.kernel.org/oe-kbuild-all/202404260946.4oZXvHD2-lkp@intel.com/
> > 
> > Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
> > ---
> > Changes in v3:
> > - Add Signed-off-by tag.
> > 
> > - Link to v2: https://lore.kernel.org/r/20240425-dp-live-fmt-fix-v2-0-6048e81211de@amd.com
> > 
> > Changes in v2:
> > - Compilation error fix added.
> > 
> > - Link to v1: https://lore.kernel.org/r/20240425-dp-live-fmt-fix-v1-1-405f352d3485@amd.com
> > 
> > ---
> > Anatoliy Klymenko (2):
> >        drm: xlnx: zynqmp_dpsub: Fix few function comments
> >        drm: xlnx: zynqmp_dpsub: Fix compilation error
> > 
> >   drivers/gpu/drm/xlnx/zynqmp_disp.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > ---
> > base-commit: 2bdb481bf7a93c22b9fea8daefa2834aab23a70f
> > change-id: 20240425-dp-live-fmt-fix-a10bf7973596
> > 
> > Best regards,
> 
> Thanks, pushed to drm-misc-next.

I think the second patch also needs to go to drm-misc-next-fixes? The
clang warning fixed by it has returned in next-20240503 because it
appears that for-linux-next was switch from drm-misc-next to
drm-misc-next-fixes, as I see for-linux-next was pointing to commit
235e60653f8d ("drm/debugfs: Drop conditionals around of_node pointers")
on drm-misc-next in next-20240502 but it is now pointing to commit
be3f3042391d ("drm: zynqmp_dpsub: Always register bridge") on
drm-misc-next-fixes in next-20240503.

Cheers,
Nathan

