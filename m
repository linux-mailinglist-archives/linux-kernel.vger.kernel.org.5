Return-Path: <linux-kernel+bounces-136668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB02489D6E0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDA128A2B8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FBF12BEBE;
	Tue,  9 Apr 2024 10:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ajvumatU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506D781AA5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657891; cv=none; b=j8116e76hSHEY4VjZDALQfpSLV2HbBJN3ID5JoHJcS8DlH7jVtbbv5m5rQFu03K4VA70SIQNIQHr3y/U4KFgTVGUbIR1sndOctWsyR/dppN0VFSZiAaaZxnwXCWA0mf+th9OgawhcZO0bpwNHTm+4WmkE9cZ02DkDbxE+524WdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657891; c=relaxed/simple;
	bh=u2U8gJTN1Y6/tkA6R0gZXY/7BUyF0iITDQkVEsbOAnA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I2xnTaEE6rQSFRe8O9Tdq5GKcZJNJXpmT49a4bOK/LYhYMFria97PtI8pN9EzqTx5XjOoPHZKxATvy7GjwdKMFApC+II2FQsVCPWXoJ+4Ks5/RBuRNQd7Fgu4hq9h8tpGUrUq8c+GgGuDeH7IjiRVVAorPWy2v8kNf65y4hlheU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ajvumatU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712657889; x=1744193889;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=u2U8gJTN1Y6/tkA6R0gZXY/7BUyF0iITDQkVEsbOAnA=;
  b=ajvumatU/MGHXpxFzrswG24et95j7b6keOdZ/fZQR5C7aXYiYxQ4Sl2P
   nOvISVvROVcRluOdmhT/mMFp9AsviEte7zp4b/gH8/KKvHyzGdBzB5xqy
   genozE5v4FiCkJYzBmVdNIKmvjoqGdR3yO23nczLM7JRgsIkUKG0CP84H
   jt4XfkJ4Lvr1xihRI3pY0XMQIezcj0P3mIYgeiyDDv898L1DiEl+Un795
   XQhmi6vLwITcA+Eq0byKpcchm7ANCUGkdiwUI0/MOlkEaOhD+ZMpBfVqn
   GU6eApbpe0dHFPO0kPD4cadspiJyP5u8dS81ab/5OQn5jjnbEQIlgN3Hy
   A==;
X-CSE-ConnectionGUID: nVn0v+WaSjOKBNv0OCQCsQ==
X-CSE-MsgGUID: nAv517X1Tyygaf1M646PWA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7809999"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="7809999"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 03:18:08 -0700
X-CSE-ConnectionGUID: LTf4sdfZTz6UbXVmVZS56A==
X-CSE-MsgGUID: qxFEr1dPQ6GxCjqgjB5/HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="20754976"
Received: from mserban-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.59.228])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 03:18:03 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
 pekka.paalanen@collabora.com, thomas.petazzoni@bootlin.com, Louis Chauvet
 <louis.chauvet@bootlin.com>
Subject: Re: [PATCH 0/3] drm: Multiple documentation update
In-Reply-To: <20240409-google-drm-doc-v1-0-033d55cc8250@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240409-google-drm-doc-v1-0-033d55cc8250@bootlin.com>
Date: Tue, 09 Apr 2024 13:18:00 +0300
Message-ID: <87msq296w7.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 09 Apr 2024, Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> PATCH 1 and PATCH 2 focus on the rotation property. The rotation property 
> can be challenging to understand, especially when it is combined with 
> reflections. These patches aim to provide clearer explanations and 
> examples to aid in comprehension.
>
> Patch 3 relates to the fourcc property. It includes additional details 
> about block and char_per_block to provide a more comprehensive 
> understanding of this feature.
>
> Regarding PATCH 1, I would appreciate some feedback on the expected 
> behavior. During a recent VKMS refactor, I used drm_rect_rotate as a 
> reference for the rotation. However, during my testing phase, I noticed 
> that the original VKMS implementation interpreted the rotation 
> differently. Therefore, I kindly request that someone validate or 
> invalidate my interpretation before proceeding with the merge.

Did you run 'make htmldocs' and check the results after your changes?
I'm almost certain this botches up the layout.

BR,
Jani.

>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
> Louis Chauvet (3):
>       drm: drm_blend.c: Add precision in drm_rotation_simplify kernel doc
>       drm: drm_blend.c: Improve drm_plane_create_rotation_property kernel doc
>       drm/fourcc: Add documentation around drm_format_info
>
>  drivers/gpu/drm/drm_blend.c | 57 ++++++++++++++++++++++++++++++++++-----------
>  include/drm/drm_fourcc.h    | 45 +++++++++++++++++++++++++++++------
>  2 files changed, 81 insertions(+), 21 deletions(-)
> ---
> base-commit: e495e523b888a6155f82c767d34c8d712a41ee54
> change-id: 20240327-google-drm-doc-cd275291792f
>
> Best regards,

-- 
Jani Nikula, Intel

