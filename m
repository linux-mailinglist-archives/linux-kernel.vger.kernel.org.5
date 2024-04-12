Return-Path: <linux-kernel+bounces-141942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8AD8A2562
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E571C21C05
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDDC171A7;
	Fri, 12 Apr 2024 04:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="aj0K+kgu"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA5E5C82
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897754; cv=none; b=gv7crTtBLnFhOEMqOUns29Sl53Lkmu0B410U0j56E2YKx2yJUsar2/y/qW3ZhxiHB+s8BadjT9gGsaWf5MrmYXzay3ltfIhOLc/bKDOZSRon4nu4KrdLm+WD8mhXp/gc1EK9I/Y/FMMuIoYukxjOsQ1De8sh126gAdRWN8nH0HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897754; c=relaxed/simple;
	bh=qBdZ/WmVwjsPR06eUv8IkFU8wQYCotYNeYIYkwRnvSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZSTTzDg2aJ82a5DlehcI5EsFIquRFKiZ2VDJX+0+VYiPPeqVAhL9++OREHCVlg5c9JBPRmAkWXRWR7AOnZw9m2cdP1CxGb/8LJrwfx3kfnh0EbejjprU8P7kNplz7CdXR/s747LlV6xuXRHS3VZNHgd5E8JMrdnOT5+jP8j6DLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=aj0K+kgu; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 8221D2C030A;
	Fri, 12 Apr 2024 16:55:44 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1712897744;
	bh=GBDLcPVV4KNFzSdf2OqJdH9r+AA4nnB2zZM8z6kDykg=;
	h=From:To:Cc:Subject:Date:From;
	b=aj0K+kgu1iwSxBn0LuRXP62Gqtsei+mXDgT2NNoghg20z5LVU0PlUcXKsDYGvUdOO
	 j+QorWrbxlTGojVWEqI0tJfkcxmoaEERJPvK5dj7dRfQqGpNuxUz8W2xZIN0eIDESw
	 2Nt7200EfP04KdtjbJFzTUysCIVAr5OzfO1YI4QXapPvrtoIYaLWIhrQtRDoh3HqGx
	 FFs1hAqX2P2FHf0azNHLB1R6pw333+c/pSxbmKwEjMCN3nfXogk0CpSb4k+dHApn+e
	 9+RIcaI5G280QbWv4oPOPOPYoXBGDWkT8TyGissILt4h7hwbiHZ31uEXFDzeu7hsbn
	 EoLUdQVhexYjg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6618bed00000>; Fri, 12 Apr 2024 16:55:44 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 397FB13ED7B;
	Fri, 12 Apr 2024 16:55:44 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 34C6A280824; Fri, 12 Apr 2024 16:55:44 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: gregkh@linuxfoundation.org,
	guanghuifeng@linux.alibaba.com,
	cleech@redhat.com,
	njavali@marvell.com
Cc: linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 0/2] uio: pdrv_gen_irq and threaded intrerrupts
Date: Fri, 12 Apr 2024 16:55:34 +1200
Message-ID: <20240412045536.1909897-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dY4j3mXe c=1 sm=1 tr=0 ts=6618bed0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=raytVjVEu-sA:10 a=VwQbUJbxAAAA:8 a=IP9_hPQSgtk6KLpm9RAA:9 a=3ZKOabzyN94A:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

I've combined these two commits submitted separatedly [1][2] into a small
series. They can be applied separately as they are not dependent on each =
other.

[1] - https://lore.kernel.org/lkml/20240325015045.778718-1-chris.packham@=
alliedtelesis.co.nz/
[2] - https://lore.kernel.org/lkml/20240325015045.778718-1-chris.packham@=
alliedtelesis.co.nz/

Chris Packham (2):
  uio_pdrv_genirq: convert to use device_property APIs
  uio: use threaded interrupts

 drivers/uio/uio.c             | 24 +++++++++++++++++++-----
 drivers/uio/uio_pdrv_genirq.c | 10 +++++-----
 2 files changed, 24 insertions(+), 10 deletions(-)

--=20
2.43.2


