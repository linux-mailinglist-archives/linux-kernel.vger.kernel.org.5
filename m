Return-Path: <linux-kernel+bounces-136232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B353A89D18A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54181C21FBF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7198D3A1C7;
	Tue,  9 Apr 2024 04:37:52 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51055EAE5;
	Tue,  9 Apr 2024 04:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712637472; cv=none; b=bkVO9bmBH+LoYByBWJfEjhY/n+PUdZ7v2chuJ1lqtnJ0Bhn7o3vY/CK/6GuPOM4+g/xkIF0IHlAd978wMWxCSuwS4Rw+a742FuzuXU5z0fIkBtB0h0R2rNboZBH/sM0m4yjKlAvjr6yANHwiUurzZxpSPFXoLruSmyBkrsm6+HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712637472; c=relaxed/simple;
	bh=WczXyv1Jb4NWZHeS5sQ67kPawURHR9s9m2dCqU0Bf7E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XE0rmVAhFThG3bCvt6+ZxyMxo9a6H1klIIkQLUjyzQQdq+vTBqxjo6h9OrQqBRi7wxdO71Ex/CexZhDHAwK2+wkLkQNIXBqzWQHDz4LiNZXS9KChLhJVZCaj61f6b89QvtNpMme8v3wI18C1UNXg4gBOb1tfgHTI5cY4HDmmr3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com; spf=pass smtp.mailfrom=ozlabs.org; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	by gandalf.ozlabs.org (Postfix) with ESMTP id 4VDCqt32GMz4x1R;
	Tue,  9 Apr 2024 14:37:46 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VDCqt2DB9z4wbr;
	Tue,  9 Apr 2024 14:37:46 +1000 (AEST)
From: Michael Ellerman <michaele@au1.ibm.com>
To: Andrew Donnellan <ajd@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: manoj@linux.ibm.com, ukrishn@linux.ibm.com, fbarrat@linux.ibm.com
Subject: Re: [PATCH 2/2] MAINTAINERS: Make cxl obsolete
In-Reply-To: <20240409031027.41587-2-ajd@linux.ibm.com>
References: <20240409031027.41587-1-ajd@linux.ibm.com>
 <20240409031027.41587-2-ajd@linux.ibm.com>
Date: Tue, 09 Apr 2024 14:37:43 +1000
Message-ID: <87bk6jb17s.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Donnellan <ajd@linux.ibm.com> writes:
> The cxl driver is no longer actively maintained and we intend to remove it
> in a future kernel release. Change its status to obsolete, and update the
> sysfs ABI documentation accordingly.
>
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> ---
>  Documentation/ABI/{testing => obsolete}/sysfs-class-cxl | 3 +++
>  MAINTAINERS                                             | 4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
>  rename Documentation/ABI/{testing => obsolete}/sysfs-class-cxl (99%)

This is a good start, but I suspect if there are any actual users they
are not going to be monitoring the status of cxl in the MAINTAINERS file :)

I think we should probably modify Kconfig so that anyone who's using cxl
on purpose has some chance to notice before we remove it.

Something like the patch below. Anyone who has an existing config and
runs oldconfig will get a prompt, eg:

  Deprecated support for IBM Coherent Accelerators (CXL) (DEPRECATED_CXL) [N/m/y/?] (NEW)

Folks who just use defconfig etc. won't notice any change which is a
pity. We could also change the default to n, but that risks breaking
someone's machine. Maybe we do that in a another releases time.

cheers

diff --git a/drivers/misc/cxl/Kconfig b/drivers/misc/cxl/Kconfig
index 5efc4151bf58..e3fd3fcaf62a 100644
--- a/drivers/misc/cxl/Kconfig
+++ b/drivers/misc/cxl/Kconfig
@@ -9,11 +9,18 @@ config CXL_BASE
 	select PPC_64S_HASH_MMU
 
 config CXL
-	tristate "Support for IBM Coherent Accelerators (CXL)"
+	def_bool y
+	depends on DEPRECATED_CXL
+
+config DEPRECATED_CXL
+	tristate "Deprecated support for IBM Coherent Accelerators (CXL)"
 	depends on PPC_POWERNV && PCI_MSI && EEH
 	select CXL_BASE
 	default m
 	help
+	  The cxl driver is no longer actively maintained and we intend to
+	  remove it in a future kernel release.
+
 	  Select this option to enable driver support for IBM Coherent
 	  Accelerators (CXL).  CXL is otherwise known as Coherent Accelerator
 	  Processor Interface (CAPI).  CAPI allows accelerators in FPGAs to be

