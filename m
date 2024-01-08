Return-Path: <linux-kernel+bounces-19868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8778275E5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB3A1C21FDA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C9053E25;
	Mon,  8 Jan 2024 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Obw90bOC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66693537EE;
	Mon,  8 Jan 2024 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704733114; x=1736269114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A8ikZedLxsY2xkH4LOd0AXUF915DXBEZW85jWrbwwQw=;
  b=Obw90bOCSqHcl7zaz9YNe+y8XZM9LV4s2EhKRK1f5ConP4ir7Z2sxFxr
   HZ1xb2TYZSIhtJrWo0dGUoT7QDb6P7bSsksCJgolMsleJWnZs8Hq7dlvx
   FeCrblOkMGXemnnyGHkMlYq/qfj9C5IRoCpK2RIyR/qxb40hdFmUBbEzh
   xqPOoqzgnbatpEp/iIyDi5rfqjzZIE28KkFcY0QMAyAcKwkjxVar+dp82
   onAGjEA5+Cvz062UqaSU8ZW3J9LERPqr7CN3f3/DjIhSpAl0bJy0riems
   46929TYaJeVcP4b8IWwnUoNKP317ad1/NU3h0ByGkNp8nOSksUNGwaZsh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="11428566"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="11428566"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 08:58:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="784918170"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="784918170"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 08:58:32 -0800
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
Subject: Re: [PATCH][next] drm/xe: Fix spelling mistake "gueue" -> "queue"
Date: Mon,  8 Jan 2024 08:57:58 -0800
Message-Id: <170473304994.868225.37284185827378036.b4-ty@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240102092014.3347566-1-colin.i.king@gmail.com>
References: <20240102092014.3347566-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 02 Jan 2024 09:20:14 +0000, Colin Ian King wrote:
> There is a spelling mistake in a drm_info message. Fix it.
> 
> 

Applied to drm-xe-next branch, thanks!

[1/1] drm/xe: Fix spelling mistake "gueue" -> "queue"
      commit: a3e6b7b90ce1ff725d7585cbd2c9279e6e39b914

Best regards,
-- 
Lucas De Marchi <lucas.demarchi@intel.com>

