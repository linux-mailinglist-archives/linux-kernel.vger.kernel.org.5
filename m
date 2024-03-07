Return-Path: <linux-kernel+bounces-95899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489A28754B8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28AE1F236AB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545E312FF8B;
	Thu,  7 Mar 2024 16:59:46 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377AA12E1FA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.204.156.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830785; cv=none; b=es/oL8AsqGUtmIVjlgwkH0jGCJJ64htJz/F0ifzeYql3Cl5dD/6tw3kqMt4qT+3I4ZcwYMsNDzbNPhd1aT3A4JzN8ZwnP3likxqjWk7abl8Aavrs+6QZCcXw8dlYBmfshe0DJ4fjyO+iTJh/UWQSqOvpEoYIxJ7XzGXxHh/HEyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830785; c=relaxed/simple;
	bh=Xx16k1lQpykWDVOb1+WLwXQSR6pXhS2//bXbGt1Wnp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FdYpnRtBEN3nSiBWDuDyz2uIs0uUu6ZbQndYwHLraX5YuwyYpdZFQH51OK+ExgNx3iPZdiPe+pBdEeEBNmTfuBqPhQI4gp00u+qqbtscSey2iQqPH1AuFd3B7Wg6lkvFs+tjlxmG/z7Z9GQA2lY3ZjEVn9hA1YGmcztjpieuRVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com; arc=none smtp.client-ip=165.204.156.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 427GxZGN3856988;
	Thu, 7 Mar 2024 22:29:35 +0530
Received: (from sunil@localhost)
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 427GxZDB3856981;
	Thu, 7 Mar 2024 22:29:35 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Mukul Joshi <mukul.joshi@amd.com>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 0/2] Add pagefault support for devcoredump
Date: Thu,  7 Mar 2024 22:29:30 +0530
Message-Id: <20240307165932.3856952-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support of devcoredump from global object of amdgpu_device

Sunil Khatri (2):
  drm/amdgpu: add recent pagefault info in vm_manager
  drm/amdgpu: add vm fault information to devcoredump

 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 14 +++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  2 ++
 3 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.34.1


