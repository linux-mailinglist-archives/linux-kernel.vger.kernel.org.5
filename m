Return-Path: <linux-kernel+bounces-152263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D568ABB97
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 14:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24EA0281493
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 12:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B2318C05;
	Sat, 20 Apr 2024 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="wetB2Hmr";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="wetB2Hmr"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8D91640B;
	Sat, 20 Apr 2024 12:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713617535; cv=none; b=iwfQHrZi5nAiy8lcS0JXmLZmrJEDHB7oFdwbD/gE1nIYy62oSW8ge21YnXKjqtI3t+HfnDkYLGIZ7N1zVG3X/DM0Wz+gbs735EEGqDrzDJnxkLZUBXD9ET79p3hBuvNCoARlcuphQMoE7pMCVTmQrUzePXI9vb/4nwTRC56fsRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713617535; c=relaxed/simple;
	bh=6xED21WfVGjRF5mk9/LtGNdr0ZPGmxdCXMO/NYMDBI4=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Z1oVCT2lYuO7y6GQNxfFrDoI8mWv8AUdACWioCYXeEMjfB6I2eTFCYYDy9Qgeh/uCmw2UWXLOgzBJl0iIS2Va83lKCr3SDLITf9CDHVr2AdHGIcQpSRX1ZUnIR/yKvWK6cNZyGZwRR3VxIcMLONQW0JvEQ0WpoZHSw36f5iHK6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=wetB2Hmr; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=wetB2Hmr; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1713617532;
	bh=6xED21WfVGjRF5mk9/LtGNdr0ZPGmxdCXMO/NYMDBI4=;
	h=Message-ID:Subject:From:To:Date:From;
	b=wetB2Hmr94jyrx3lVjbJfElSvvDsFFJY9pEWcY0diT1FaQWG1iQBHeBf+FklGiFA6
	 oGRduCRYg25pa4C67+GBIESvvrLZoBARZJEFDS7A+PtiJpALuDIf1/N1VcsSjDR19z
	 wnsd4+DEMZn1Jm9EPlK81WBApD0PXyHRLJZliGS8=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id D0389128649A;
	Sat, 20 Apr 2024 08:52:12 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id wXJldp-1vML9; Sat, 20 Apr 2024 08:52:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1713617532;
	bh=6xED21WfVGjRF5mk9/LtGNdr0ZPGmxdCXMO/NYMDBI4=;
	h=Message-ID:Subject:From:To:Date:From;
	b=wetB2Hmr94jyrx3lVjbJfElSvvDsFFJY9pEWcY0diT1FaQWG1iQBHeBf+FklGiFA6
	 oGRduCRYg25pa4C67+GBIESvvrLZoBARZJEFDS7A+PtiJpALuDIf1/N1VcsSjDR19z
	 wnsd4+DEMZn1Jm9EPlK81WBApD0PXyHRLJZliGS8=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 238EF1286027;
	Sat, 20 Apr 2024 08:52:12 -0400 (EDT)
Message-ID: <cfb963420b1848bc2259ae3006b49106b9ae02d6.camel@HansenPartnership.com>
Subject: [GIT PULL] MAINTAINERS update for 6.9-rc4
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel
	 <linux-kernel@vger.kernel.org>, keyrings@vger.kernel.org
Date: Sat, 20 Apr 2024 08:52:10 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

My IBM email has stopped working, so update to a working email address.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git email

The short changelog is:

James Bottomley (1):
      MAINTAINERS: update to working email address

And the diffstat:

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

With full diff below

---

diff --git a/MAINTAINERS b/MAINTAINERS
index c23fda1aa1f0..e5121ff5e60e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11995,7 +11995,7 @@ F:	include/keys/encrypted-type.h
 F:	security/keys/encrypted-keys/
 
 KEYS-TRUSTED
-M:	James Bottomley <jejb@linux.ibm.com>
+M:	James Bottomley <James.Bottomley@HansenPartnership.com>
 M:	Jarkko Sakkinen <jarkko@kernel.org>
 M:	Mimi Zohar <zohar@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
@@ -19669,7 +19669,7 @@ F:	drivers/scsi/sg.c
 F:	include/scsi/sg.h
 
 SCSI SUBSYSTEM
-M:	"James E.J. Bottomley" <jejb@linux.ibm.com>
+M:	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
 M:	"Martin K. Petersen" <martin.petersen@oracle.com>
 L:	linux-scsi@vger.kernel.org
 S:	Maintained
-- 
2.35.3



