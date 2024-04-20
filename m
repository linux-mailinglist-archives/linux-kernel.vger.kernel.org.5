Return-Path: <linux-kernel+bounces-152261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CA88ABB92
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 14:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360EA281606
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 12:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB8317C72;
	Sat, 20 Apr 2024 12:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="YdlNkD4n";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="YdlNkD4n"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116627EB;
	Sat, 20 Apr 2024 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713616972; cv=none; b=jVedj7DRJz8iB72cqD/lk2tV49WhoZ4aQrLT528KJv9HmQn91FAgRCbd+sDLHzMxQdU6cULiVmascmfVr4yYuEjXMCtMuDKf/6SHwvo8KDHrMetaRT7LhemPh3pcLJJRMvPCDHRHYyQ09hnGPIyuDQkGB6vNlzDtqGetwcqYUCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713616972; c=relaxed/simple;
	bh=5/hr0Mzp7QzNVogN6AM38E/79ROQzQNR4VUsuZMoYKc=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=eo6iTzqImhp23HcRxK8emBXXvbms844taTGh/wvmkedyLT3YMm4uUNAhYbTp2+0J70RF0KC8bvLsiQHyKlJISNtR5FfNAF4LPJKabOH9udcds51VDD3efFsjne6i/6WwJXPMOBaQCEX2QdeCiYf1C2kgJvwxnQebKCGR3oN/vHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=YdlNkD4n; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=YdlNkD4n; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1713616969;
	bh=5/hr0Mzp7QzNVogN6AM38E/79ROQzQNR4VUsuZMoYKc=;
	h=Message-ID:Subject:From:To:Date:From;
	b=YdlNkD4nKNSuk/K2S6AOlt1Si8rUR+Hck+daJRSVy18YGxS+VQMJ3+HN40vOumyq/
	 BvPUk0kIvI5AZ6p0S7Dx4b/Kgo02bWLEhtJwH2BOZsg1nkZ+j5ASVIPfYyr36PhYYT
	 8Z6WeXagIYqIfdm7f8d5cs0z5ZdlL712yQbJru3s=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 511A91281C77;
	Sat, 20 Apr 2024 08:42:49 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id E69Gx8GAeK9c; Sat, 20 Apr 2024 08:42:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1713616969;
	bh=5/hr0Mzp7QzNVogN6AM38E/79ROQzQNR4VUsuZMoYKc=;
	h=Message-ID:Subject:From:To:Date:From;
	b=YdlNkD4nKNSuk/K2S6AOlt1Si8rUR+Hck+daJRSVy18YGxS+VQMJ3+HN40vOumyq/
	 BvPUk0kIvI5AZ6p0S7Dx4b/Kgo02bWLEhtJwH2BOZsg1nkZ+j5ASVIPfYyr36PhYYT
	 8Z6WeXagIYqIfdm7f8d5cs0z5ZdlL712yQbJru3s=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B5E3C1281C31;
	Sat, 20 Apr 2024 08:42:48 -0400 (EDT)
Message-ID: <31678fc9077af80a2a5648c2bb6c116053e07be7.camel@HansenPartnership.com>
Subject: [PATCH] MAINTAINERS: update to working email address
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: keyrings@vger.kernel.org, linux-scsi <linux-scsi@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Date: Sat, 20 Apr 2024 08:42:46 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

jejb@linux.ibm.com no longer works.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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



