Return-Path: <linux-kernel+bounces-96220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA298758D4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5556A1F229CC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8710013A898;
	Thu,  7 Mar 2024 20:51:15 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0A8139593
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.204.156.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709844675; cv=none; b=p0e7ZI6uiTO00RgPz8meZy219JgpH+/mScW0CEpoyst79j32RkdsOx3kBg36RtaESD5qTH99B8rUY8kby1gvOtMKmRf8GUNzL9492QK4Y5bLBAKRyap6ePfIW5jQd5Tqydn2TWGVqU4sPCklZKv3W6V3UqAV5JvB8ybPzbQk01E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709844675; c=relaxed/simple;
	bh=ziNQRGuY0EAeRCOx3KF1nFOCSLoMd5/YFn1l3RiUJPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NbEWuDDAP0N5n2Z0snGAXr5cVBgG74QCovrJv8AT8aZdRzk75W1R06UraCdrlalWKisXjqaRoCxbHyuYDKuCK2uepNPn9sbu4vM+svOuz1oIQEu+mr7bjGdzHwWzm3z7tRIup2WeRjVMrBJ9JFKlBqu1eGn/cjh3dGMTnnsgeqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com; arc=none smtp.client-ip=165.204.156.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 427Koucs3904687;
	Fri, 8 Mar 2024 02:20:56 +0530
Received: (from sunil@localhost)
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 427Kouqo3904680;
	Fri, 8 Mar 2024 02:20:56 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Mukul Joshi <mukul.joshi@amd.com>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v2 0/2] Add pagefault support for devcoredump
Date: Fri,  8 Mar 2024 02:20:52 +0530
Message-Id: <20240307205054.3904657-1-sunil.khatri@amd.com>
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


