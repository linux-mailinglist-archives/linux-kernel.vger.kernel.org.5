Return-Path: <linux-kernel+bounces-89369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0910786EF7C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 09:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF911F234AC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 08:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFA1134CD;
	Sat,  2 Mar 2024 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="i8nUdSzo";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="i8nUdSzo"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980117469;
	Sat,  2 Mar 2024 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709367903; cv=none; b=SaGMDx124vuTndv4wN7rbZvJ6vxDhVjXEsLE1G2oAu/64Vq8QDthSYdRAio+Y1vFuMqLZ0y3vf+AIBgDsrutc3Z0/dqU8R8NRLblN8ARnBHyCQTbmL/hCdlZdYSxRiYLW7ayeY31w+yeToLXfL3+jMGA6AYRKHdrPVvqDmN8lt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709367903; c=relaxed/simple;
	bh=yxRHpAE7Su6Yi++mYKCyTKa75U5UXl1rl+cNRpQDmog=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Wa/pfMlMUvu5vACxKh6oY6HmkpD6tQYDYNPWlflo7MNotsfKCxk3oxQhpe9zAIc/G/C0oz06b/u2Rn/rLzBjRv/vkmmd2mbiE+vDjN0XJwAJMsdcucDhwAtXwy91jat4YnZ8KHamZ6VVzXpalwzYQiGFDlqnqZXjZjCI+jNk6OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=i8nUdSzo; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=i8nUdSzo; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1709367900;
	bh=yxRHpAE7Su6Yi++mYKCyTKa75U5UXl1rl+cNRpQDmog=;
	h=Message-ID:Subject:From:To:Date:From;
	b=i8nUdSzoplFMdAusSEFd2X39x1qtDcUZ8L9gbgoli77AShQlzUYW/WbM3P6POycHj
	 joG/QNkks87A6QsxZiUaL/KRgUnFTpeDgD+2zZgmHSjsprvO8U7KYmq0RAY5V1OjyI
	 7LIAbnP+Ewdp6yo1eZBlKE88XY8aqVMShYS/Akok=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id B52241286E23;
	Sat,  2 Mar 2024 03:25:00 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id FHF77ltlOsGh; Sat,  2 Mar 2024 03:25:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1709367900;
	bh=yxRHpAE7Su6Yi++mYKCyTKa75U5UXl1rl+cNRpQDmog=;
	h=Message-ID:Subject:From:To:Date:From;
	b=i8nUdSzoplFMdAusSEFd2X39x1qtDcUZ8L9gbgoli77AShQlzUYW/WbM3P6POycHj
	 joG/QNkks87A6QsxZiUaL/KRgUnFTpeDgD+2zZgmHSjsprvO8U7KYmq0RAY5V1OjyI
	 7LIAbnP+Ewdp6yo1eZBlKE88XY8aqVMShYS/Akok=
Received: from [10.0.15.72] (unknown [49.231.15.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 376981286E22;
	Sat,  2 Mar 2024 03:24:59 -0500 (EST)
Message-ID: <1f7995571142ef7e7ed2739bc6f8574d40159de7.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.8-rc6
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel
	 <linux-kernel@vger.kernel.org>
Date: Sat, 02 Mar 2024 15:24:53 +0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Two small fixes, all in drivers (the more obsolete mpt3sas and the
newer mpi3mr).

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Arnd Bergmann (1):
      scsi: mpi3mr: Reduce stack usage in mpi3mr_refresh_sas_ports()

Ranjan Kumar (1):
      scsi: mpt3sas: Prevent sending diag_reset when the controller is ready

And the diffstat:

 drivers/scsi/mpi3mr/mpi3mr_transport.c | 7 ++++++-
 drivers/scsi/mpt3sas/mpt3sas_base.c    | 4 +++-
 2 files changed, 9 insertions(+), 2 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/mpi3mr/mpi3mr_transport.c b/drivers/scsi/mpi3mr/mpi3mr_transport.c
index c0c8ab586957..d32ad46318cb 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_transport.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_transport.c
@@ -1671,7 +1671,7 @@ mpi3mr_update_mr_sas_port(struct mpi3mr_ioc *mrioc, struct host_port *h_port,
 void
 mpi3mr_refresh_sas_ports(struct mpi3mr_ioc *mrioc)
 {
-	struct host_port h_port[64];
+	struct host_port *h_port = NULL;
 	int i, j, found, host_port_count = 0, port_idx;
 	u16 sz, attached_handle, ioc_status;
 	struct mpi3_sas_io_unit_page0 *sas_io_unit_pg0 = NULL;
@@ -1685,6 +1685,10 @@ mpi3mr_refresh_sas_ports(struct mpi3mr_ioc *mrioc)
 	sas_io_unit_pg0 = kzalloc(sz, GFP_KERNEL);
 	if (!sas_io_unit_pg0)
 		return;
+	h_port = kcalloc(64, sizeof(struct host_port), GFP_KERNEL);
+	if (!h_port)
+		goto out;
+
 	if (mpi3mr_cfg_get_sas_io_unit_pg0(mrioc, sas_io_unit_pg0, sz)) {
 		ioc_err(mrioc, "failure at %s:%d/%s()!\n",
 		    __FILE__, __LINE__, __func__);
@@ -1814,6 +1818,7 @@ mpi3mr_refresh_sas_ports(struct mpi3mr_ioc *mrioc)
 		}
 	}
 out:
+	kfree(h_port);
 	kfree(sas_io_unit_pg0);
 }
 
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 8761bc58d965..b8120ca93c79 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -7378,7 +7378,9 @@ _base_wait_for_iocstate(struct MPT3SAS_ADAPTER *ioc, int timeout)
 		return -EFAULT;
 	}
 
- issue_diag_reset:
+	return 0;
+
+issue_diag_reset:
 	rc = _base_diag_reset(ioc);
 	return rc;
 }


