Return-Path: <linux-kernel+bounces-9852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8C481CC5E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9252850F1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E807241E4;
	Fri, 22 Dec 2023 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qizy9SzF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDB6241E0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 15:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3DFC433C9;
	Fri, 22 Dec 2023 15:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703259964;
	bh=WhROq6fxnNV/9LI7/csVWNcx/nYTzRP6g5WWhYCUuNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qizy9SzFWYEh7GuqWHk5sN61dU1zluBDr2eiyV5ul86BnAWICg7vCzRhmMvfpfqRF
	 bRd3p+nmLBqpeJ8wDX5ok5OTYWdQjBWXuHoulKeRZHvQHJWJHmOepJO3r6Gcz+dfkc
	 5iya6ox8Wn1qI6TAZaMKmR5phr2kNyP0OxniPLG9qyV+BTLU1GrVD5eDVgHF7LkGIi
	 O203Ey4xbjKTSq6EymOWWhQSRWEfkgnUbZsbFKIRU04uv75HHnzsfQx8qmwW4C+c7n
	 tTjePTVEzWNj0YZSdSaSGBCUS2uHnl3wRSb5ZRak+7hN1xF/ZI2SZ4ast7O8S9oZkj
	 3cu7s8j++sGpw==
Date: Fri, 22 Dec 2023 21:15:59 +0530
From: Vinod Koul <vkoul@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
	Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
	pierre-louis.bossart@linux.intel.com, vinod.koul@intel.com,
	venkataprasad.potturu@amd.com,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/12] drivers: soundwire: refactor soundwire pads enable
Message-ID: <ZYWvNxpLPUGCGElA@matsya>
References: <20231221073558.3181911-1-Vijendar.Mukunda@amd.com>
 <20231221073558.3181911-5-Vijendar.Mukunda@amd.com>
 <ZYRqEbVADgU4fNtB@matsya>
 <6d98c43d-fb90-4cfa-a22e-8fd6d5a6eb50@amd.com>
 <ZYVVD2mL5kAePXDE@matsya>
 <0ab000c3-be7f-41f3-8017-28738cf0a698@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ab000c3-be7f-41f3-8017-28738cf0a698@amd.com>

On 22-12-23, 16:04, Mukunda,Vijendar wrote:
> On 22/12/23 14:51, Vinod Koul wrote:
> > On 22-12-23, 12:45, Mukunda,Vijendar wrote:
> >> On 21/12/23 22:08, Vinod Koul wrote:
> >>> so the code is copied from a GPL declared file to now and GPL + BSD one!
> >>> Have you had lawyers look into this... why change one file license ?
> >> As per recommendations from our legal team, we have updated the license as dual
> >> one for amd_init.c file.
> >> We have also observed that license terms should be updated for other files as
> >> well (amd_manager.c, amd_manager.h & sdw_amd.h) as dual one, which we have
> >> planned to submit as a supplement patch.
> > Lets change that first before we move code from one license file to
> > another
> Will push the license update patch first.
> >
> > Btw why would you want to do the change of license form GPL to dual?
> As this code being used by AMD SOF stack which uses dual license,
> So we want to maintain the same license terms.

SOF is firmware, do you share this kernel code with sofproject, that
doesnt make sense to me, maybe I am missing something

-- 
~Vinod

