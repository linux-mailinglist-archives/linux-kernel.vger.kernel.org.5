Return-Path: <linux-kernel+bounces-96125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D866187576D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DE61C20B44
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5B81369B8;
	Thu,  7 Mar 2024 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="iZoH6ZWP"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37DA12F399;
	Thu,  7 Mar 2024 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709840691; cv=none; b=GR08J1Yq5KW9KPvEZpPtY6It6fSbIkw/dRif/fe/tyuAWinLcXeMdzb3ezFrjxBWoan5CQ6xdXdZlmjsIrwi8nOHVNo9cD9rJOq8smouQpsiW8gRJV/zkvEnoij7CPp72AMG1rx7I7az8NFL1j9BvzsVb6aEUT813Cq/4lmkmgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709840691; c=relaxed/simple;
	bh=XgJUa5/zRGoc2L+nYuRH1XvQNBJF4iikjoUJX52nFxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V5zd0zZpyv2zA/Zfb/Ye6R132PXYjd6Bdsr4bcUVD4bHabIAxUYLvi7Ltg5aFsua/p7JhfeHZKAjQ9yxVz8vsHWj4YKmQCGcakwza/l+Cyn419EzdjuEUK+Wjq9M7zLlRn9LnppF4tVsxQYxdrRZl34vV5OP6AJovUTsGa0IDk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=iZoH6ZWP; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709840663; x=1710445463; i=spasswolf@web.de;
	bh=XgJUa5/zRGoc2L+nYuRH1XvQNBJF4iikjoUJX52nFxM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=iZoH6ZWPYP9trw8qlx6M/hKnFPpiFXHfYiyG7xrzl+LP1RfcODO+1EGxAb/kqD7o
	 X6SfD69GME+hyrKJMw5vWep+Td2Ogg910u5G2JDv/sHNXR50nGnDvIcJgtWCwlbik
	 mMDc+VqQvOrKjlsBb6niSkCgdTDt7aYjHyk0KH3tPntpAyAfIxK9o6Pk/Wi9D+naN
	 JWGMMIHaTcj7PsshsWYhQejwDwKiVBx6taxCSQzNCRfElmh2Qu/ZlmpJY6xdq6yfQ
	 eGNa/jVtySGIkwR4JTpSr8wvXT6V+owfUyhtmn6Nm2NgnK5xXE6ocioEJz0BhUf6p
	 BJ7o+v5JLfpDWaZDng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from lisa.home ([84.119.92.193]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3m9J-1ri2gH3fpT-0012rJ; Thu, 07
 Mar 2024 20:44:22 +0100
From: Bert Karwatzki <spasswolf@web.de>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	haifeng.zhao@linux.intel.com,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	jiaqing.huang@intel.com,
	joro@8bytes.org,
	kevin.tian@intel.com,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	will@kernel.org
Subject: [PATCH] iommu: fix compilation without CONFIG_IOMMU_INTEL
Date: Thu,  7 Mar 2024 20:44:19 +0100
Message-Id: <20240307194419.15801-1-spasswolf@web.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: 20240220065939.121116-3-baolu.lu@linux.intel.com
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hJ/EqF2bUYCrsXvrrUvZwiUXkkyj27FOXhqt8cTC7Kq90kSlYPj
 4b7bPD5r9edVonMvi+A5KJBuxmsVx+JEJ6Am6ipWb6paEQSdNz/sWCVr3s8oWoyvdOkqCTO
 ZsJ3MCVFwMiMnRVlK+Ohpw5BD2k9or/lbbJpu8fJy+vM5Ov3SqBTaRVYS9Tqj35ELsHGMDi
 8H+0cVAJQDX0g5vIm9Xfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uYplgaJgDq4=;lgloB+JWZWvvLi7QdmHQOxfxNN3
 aS5Sla3GXqZfGR3FlPg6y2xlqCq6/8r+GJ0k/JKRy5GXsOBWXMcnw6rp4D3jcVjo3WAqy5Kjr
 zrV5le4MKHxYWjeoAyCHMsHCg8EfrpZlwZ25Mpj8GBqNpWbGVYaL1a0brYYMyHosh+3EAUN89
 x4cBxevhepngAE4317fPRzu2c+weMhaGwJNhxDczoSTJ5PVemrrIax8rxBLQIQPfCykCtikTm
 ZbK/eWEMXugl1fCzURsDX0neVkUS5MGRa4VLG7zvRSu+eax/68VOtp669qPuzq9ZlSY5T2oYF
 HTC+MN/M+HnoKi4mjH0dW+nJD9tOSclLvBULEVCed8m5s3yg/k/glavVOCtMPsGStwU0QTks7
 EFtwa68wSvsB79l2K/DhcM6XZm7shTHoRN240LUC3Alkz4HlTk8ITcS+K199CjV18uB6ysJ9Z
 jPy1K/7iEnxpCU8o72/Kcm850x3jNpw77vAxYSJDD2Fzf5mYT+sOwPeC03Whj4GfoIQkFpucS
 MhM0RxYqC/SSfMtxEBDge/Veubgwo7lVhKrKD6RPPVrtDcCKiO23OV2KXO+M/HaGt7TVBzqqP
 SF6hcYSGEFMWKJ47LdnI1SiNbCOb7ahjGlz8YmkULTujXV/Rd5lhuBrq/4fwSsCxcxTNKXnH4
 Hl3K9GSbD8/EgDz5oYqUmTGnft9E90pbibiWAVjgLkwlqNuXkTXf+akzsxJwJ60E/YRiLkBXZ
 QGnmJSvPWvQUFUB38QxAPmFlx5xPtWysFpyhktZ16DNp4KhsG29qd2mRcRXS2fRXHL9J6PLFh
 Yl/gDm4uLKMyHeWZ2yw0sMgpGGt/ed1g3r5G48D4iUzHs=

When the kernel is comiled with CONFIG_IRQ_REMAP=3Dy but without
CONFIG_IOMMU_INTEL compilation fails since commit def054b01a8678 with an
undefined reference to device_rbtree_find(). This patch makes sure that
intel specific code is only compiled with CONFIG_IOMMU_INTEL=3Dy.

Fixes: def054b01a8678 ("iommu/vt-d: Use device rbtree in iopf reporting pa=
th")

Signed-off-by: Bert Karwatzki <spasswolf@web.de>
=2D--
 drivers/iommu/Kconfig         | 2 +-
 drivers/iommu/intel/Makefile  | 2 ++
 drivers/iommu/irq_remapping.c | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e0796fa84227..0af39bbbe3a3 100644
=2D-- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -199,7 +199,7 @@ source "drivers/iommu/iommufd/Kconfig"
 config IRQ_REMAP
 	bool "Support for Interrupt Remapping"
 	depends on X86_64 && X86_IO_APIC && PCI_MSI && ACPI
-	select DMAR_TABLE
+	select DMAR_TABLE if INTEL_IOMMU
 	help
 	  Supports Interrupt remapping for IO-APIC and MSI devices.
 	  To use x2apic mode in the CPU's which support x2APIC enhancements or
diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index 5dabf081a779..5402b699a122 100644
=2D-- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -5,5 +5,7 @@ obj-$(CONFIG_DMAR_TABLE) +=3D trace.o cap_audit.o
 obj-$(CONFIG_DMAR_PERF) +=3D perf.o
 obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) +=3D debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) +=3D svm.o
+ifdef CONFIG_INTEL_IOMMU
 obj-$(CONFIG_IRQ_REMAP) +=3D irq_remapping.o
+endif
 obj-$(CONFIG_INTEL_IOMMU_PERF_EVENTS) +=3D perfmon.o
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 83314b9d8f38..ee59647c2050 100644
=2D-- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -99,7 +99,8 @@ int __init irq_remapping_prepare(void)
 	if (disable_irq_remap)
 		return -ENOSYS;

-	if (intel_irq_remap_ops.prepare() =3D=3D 0)
+	if (IS_ENABLED(CONFIG_INTEL_IOMMU) &&
+	    intel_irq_remap_ops.prepare() =3D=3D 0)
 		remap_ops =3D &intel_irq_remap_ops;
 	else if (IS_ENABLED(CONFIG_AMD_IOMMU) &&
 		 amd_iommu_irq_ops.prepare() =3D=3D 0)
=2D-
2.39.2

Since commit def054b01a8678 compilation fails on x86_64 without
CONFIG_IOMMU_INTEL=3Dy with an undefined reference to device_rbtree_find()
when linking drivers/iommu/intel/dmar.o. Even though this file is intel
specific it is compile because CONFIG_IRQ_REMAP unconditionally selects
CONFIG_DMAR_TABLE. This patch fixes this by only compiling intel
specific files when CONFIG_IOMMU_INTEL=3Dy.

Bert Karwatzki


