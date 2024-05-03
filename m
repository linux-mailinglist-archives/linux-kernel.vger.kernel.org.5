Return-Path: <linux-kernel+bounces-167711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59328BADD4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA926B22AD2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AE0153BD2;
	Fri,  3 May 2024 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+Ag5lh8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8783E15098B
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714743457; cv=none; b=rsd4XJ7qBuXkQMWLeFn4O/R/O7U2q1DcDuE7PicyxaG86ywZt2k2gJAPSD0i6/Yqjj/AyePHw5QMPvQzts2Vlqxtuqu6McLIJu3UW0qknjM1p8lhhewa3GlFft8J+PzSKiNB1wzaGBI18LAvRDkuZ5h5r43UqNF19C3uI91YxHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714743457; c=relaxed/simple;
	bh=6ku6DEcidRMeAjG5D2Qr6+Ec3pRITgEXOvWTrjl4BJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lGi/4U8nrJFivlhgf7i9gjDdyK9c9gU8mJUp9+3qXurFTE0oNf0T907ZasD5Ds3VIn82jigTmSdHcQO7uiccUmh/v9+TQ2kID17S8SsmYwDXRqsIEHEoGzlxpFLy0cXDGxK4cVogc30szDDtEodMWBHcMN6+nqjqeZ2Z9ik6LUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+Ag5lh8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714743457; x=1746279457;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6ku6DEcidRMeAjG5D2Qr6+Ec3pRITgEXOvWTrjl4BJ8=;
  b=O+Ag5lh8apUkyZhSnA8qYYBe83yoa/zDWeOQMtmkhXfHleHT2JAucuG4
   lxphk6zysJg5EniAqMkh9hQ2DNhK3fHDPJTEsbtYxfk2DaP4ycuZa/ghT
   eI+zf/gTS5XBuQ3rckMuYOjogzUg+CpxizQRWMvbxVhGLzAaNhETCVYvb
   nQ0iV0mkB3my0f7mH731VUvJr9vcahzdSVQR1ENu3euB2MbJv9lOC5Ryp
   6UOpvQffjA8N34vcaxv9IVFtJHH4rHU1xO1R3zjD5JlbuPBlf8sjFCL6F
   txzVhQfrrtstiHUT/nkF0HN8n4RZry2ygg984FyfautGERc0WHmuw3AQX
   g==;
X-CSE-ConnectionGUID: nMaJrkZ+RSGi7yDDcF2Z4g==
X-CSE-MsgGUID: GnQ/tN3WR7KevmbYe9BBaw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="13499473"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="13499473"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 06:37:36 -0700
X-CSE-ConnectionGUID: qiDBTzaOSnuK5wCrr3qnAQ==
X-CSE-MsgGUID: SbEsP4ikRZ+04UxW2P9d/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27502234"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa009.jf.intel.com with ESMTP; 03 May 2024 06:37:34 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1][PULL REQUEST] iommu/vt-d: Fixes for intel iommu
Date: Fri,  3 May 2024 21:36:01 +0800
Message-Id: <20240503133602.78992-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following fix has been queued for the intel driver:

 - Decouple igfx_off from graphic identity mapping

This change is not critical for v6.9.  I'm fine for it to be included in
either the fix or the next branch, whichever works best for you. With
this in mind, please pull it.

Best regards,
baolu

Lu Baolu (1):
  iommu/vt-d: Decouple igfx_off from graphic identity mapping

 drivers/iommu/intel/iommu.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

-- 
2.34.1


