Return-Path: <linux-kernel+bounces-160028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE808B3808
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56FE9284714
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A5A1474B7;
	Fri, 26 Apr 2024 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AS4TV73U"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB98485624;
	Fri, 26 Apr 2024 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137094; cv=none; b=kDfB7GCheYWKLJL7S6tJuLwJveTl4OlTI6A3GBvaMgidb/2N1x20vNcPbYpDBvt2vLqy6+9tLZ7rfh5OFP9xUuo9gJZvtUaQBLTYUkAXJ8gd6TEGGcKzBMbbyD2NYuFHfsN3kCZ2NG5ft98uRA9qhnb3NCxF//8BKeoH2RE6ZSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137094; c=relaxed/simple;
	bh=/UFE2tDaNmf2j4moyUP8Rwbzpwd1yZuB0QRkfQ1nl7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EI1lCai/F1XWVQydLp3ysVMdFtVfte1jDl4pB7Xne41Vwgz7jEzIaRI4WdGXrgEipXvMQQfvGt9sZ6pu4wxJCex3yCDZ6TbPbqzZlrzbXzPoDOc7xxG4AbCJV6XmSF8+AghWgRLfDUqek6FJrDTqYpgvJIOw6pv/EipxzIzuMsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AS4TV73U; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714137093; x=1745673093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/UFE2tDaNmf2j4moyUP8Rwbzpwd1yZuB0QRkfQ1nl7Y=;
  b=AS4TV73UzgTYfUNU0XT10VBy0qXeOk+VJY8LjG/5thqbu+1zxZXzBuWO
   ML/AoP9A8Li37v8Y0fvdrTkobKbSmidL5ZTdMRJ0++GBbA9WGd9z6Xi8h
   up9jdzCB9rAl48tFxYeUM6lEc2YVfGRrr1gO64dlhLDSiWfvgPfYfQXZw
   4X1yxdJ4+38f7Ng/iXxJpVHGeJgzHJfdvNcbUuykhouMGgkEE24m5KIqM
   MyyLvIacYDkikyk7lPX19vesZQFUXt013G63nQ2/awO3a+jnMUM1wo6XH
   LGMh3Guq1BNw88Db6TSPhNmW4ftJUJnBIZw/a9+q4nJg45X//8wXRmap6
   w==;
X-CSE-ConnectionGUID: HV1rz/ARTM+N7eOs3t14pQ==
X-CSE-MsgGUID: 89gCp6T6QEayN01u/qLZ7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="9796898"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="9796898"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 06:11:32 -0700
X-CSE-ConnectionGUID: 7DirwTB3QyG176RdgkR2Sw==
X-CSE-MsgGUID: P+xVloUzRFyKGYA33/EkLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="25416985"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 06:11:30 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Oded Gabbay <ogabbay@kernel.org>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Colin Ian King <colin.i.king@gmail.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/xe: Fix spelling mistake "forcebly" -> "forcibly"
Date: Fri, 26 Apr 2024 06:11:51 -0700
Message-ID: <171413710466.3189116.492328462949220625.b4-ty@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240426094904.816033-1-colin.i.king@gmail.com>
References: <20240426094904.816033-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 26 Apr 2024 10:49:04 +0100, Colin Ian King wrote:
> There is a spelling mistake in a drm_dbg message. Fix it.
> 
> 

Applied, thanks!

[1/1] drm/xe: Fix spelling mistake "forcebly" -> "forcibly"
      (no commit info)

Best regards,
-- 
Lucas De Marchi <lucas.demarchi@intel.com>

