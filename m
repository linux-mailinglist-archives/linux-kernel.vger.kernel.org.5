Return-Path: <linux-kernel+bounces-46887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B268445D3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5B7289645
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C9B12CDA7;
	Wed, 31 Jan 2024 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="EuBXF3xn"
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD60812C554;
	Wed, 31 Jan 2024 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721435; cv=fail; b=GlPs/VGJfMKaNZK/4sLY+FSVXt0vO2L/fc0U8XgOjLuv67oTouNXiW/HYcaZw4j9rb6sIjVJJKdvkwNNqf4WsrwMww8Y3+b9Z9Tpzz/AA+NJ81sSH7AF2C3SgPa1NhM7HWj0WpIpK0mSxIpRFzsmZHO+J/jRsiSe//hJB915SmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721435; c=relaxed/simple;
	bh=XXcpNZ2rcDI3vVQ8/Eszkap951MkG/aGpB/S+UJ2e7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CwS4RrcRggTlvrAYPhQHJusnTvR3rYPkdyKEwAss056BmQJed9jPo+evUDhXWDexfYO8zWeNY0nZr+8Y8PxywNejbwB4lmG6YNJwE9iGBeD/n2sNUs+ENPmf2cSX3xJlYY+jnu29dMZtdNWmNk9s2NY/MTUPdNAltIRrhzPIciU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=EuBXF3xn; arc=fail smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
Delivered-To: dpsmith@apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1706721425; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BrzFsShetAr//Au0/VgUiqgtdGUiEYUh6tSSxK6EQ+wwPblT419KlvABnM+gn9hEC9tAs/r8EZlT0gBujaDU6WtfUcAJRNT+1dbAgdJ8yT5IaGkZZ90lioAeq2dn/A3/lg5Xjl/ERnjNnhleWpMWgolD2l/bZ3flB2QPJCGHwhQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1706721425; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:To:To:Message-Id:Reply-To:Subject; 
	bh=d8FvsybUVvAeqHKTrmR5FtLlH3g40qorWd0hTMXdq/Y=; 
	b=SHkfsgAt5iF2lQ8ZBn2r4BOJotInCRCOHndatwQmRUBJpW2HgB2wIRowM90ZSfjJQFN746d6MmSyERboNU+rTN/iyIO416zqF7hyUTlKk0wk/Sz8MM3gqybNE8dtTVcFHZyUXBUFrVRKOhRvVG6jvyqPaKZU3XOLxVFP5rmGg+A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1706721425;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=d8FvsybUVvAeqHKTrmR5FtLlH3g40qorWd0hTMXdq/Y=;
	b=EuBXF3xnV0wo6LNqC3nSYFgVtFWAnE2iKsAtGyJLC8dHVWO1LFhSSZmQTXECrlj8
	agm28wXqMmRN3VG4kWX3G4Dm2KLS1iBRUwZYshbtJGdAgs5EeZaQiDVGiLOXTfqmgnJ
	V33fyPInCWBy9qTHM/0iSuJleBvnKfIiiZxNw82A=
Received: from sisyou.hme. (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1706721424032954.853713826795; Wed, 31 Jan 2024 09:17:04 -0800 (PST)
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Daniel P. Smith" <dpsmith@apertussolutions.com>,
	Ross Philipson <ross.philipson@oracle.com>,
	Kanth Ghatraju <kanth.ghatraju@oracle.com>,
	Peter Huewe <peterhuewe@gmx.de>
Subject: 
Date: Wed, 31 Jan 2024 12:16:50 -0500
Message-Id: <20240131171651.15796-1-dpsmith@apertussolutions.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Date: Wed, 31 Jan 2024 11:43:16 -0500
Subject: [PATCH v2 0/3] tpm: make locality handling resilient

When the kernel is started by a loader that leaves a locality other than
Locality0 open, for example Intel TXT SINIT ACM leaves Locality2 open, this
triggers a failure condition in the initialization of the TPM driver. The
result being that despite calls to request/relinquish locality, the locality
that was open at startup is never open/closed. The impact for an Intel TXT
platform is that after SMX mode is exited, access to the Locality2 register
space is blocked, and the TPM is locked in Locality 2 rendering the TPM
unusable.

The ability to trigger this failure condition was introduced in commit
933bfc5ad213, which introduced a locality counter to control when locality
requests were actually sent to the TPM. The commit introduces a series of
missing or incorrect protections in place for incrementing and decrementing the
counter. The protection around incrementing the counter was protected with an
incorrect check. The check was incorrect in two ways, 1.) it assumed that zero
was the only successful value that would be returned by
__tpm_tis_request_locality() and 2.) was evaluated outside the if block under
which __tpm_tis_request_locality() is called. The effect of (1) is that
__tpm_tis_request_locality() in fact returns the locality number that was
requested, e.g. 1-4, and therefore the protection check would fail and the
counter does not get incremented. The effect of (2) is a combination with the
ret variable being initialized to 0 and the counter not being 0. The result is
that __tpm_tis_request_locality() does not get called, but the counter is still
incremented.

Another effect seen is an indirect result of commit 933bfc5ad213 and is due to
locality being tracked in two different locations. The first is at the TIS
layer in struct tpm_tis_data and at the chip layer in struct tpm_chip. The
failures experienced by commit 933bfc5ad213 causes the locality value in these
two locations to fall out of sync with the value in tpm_tis_data reflecting
Locality0 and struct tpm_chip having a value of -1, no locality open.

This series seeks to address these conditions by introducing a protection
against underflowing the locality counter. The closing of all localities at the
beginning of initialization to begin with the TPM in the state expected by the
sequencing codified in the initialization. Lastly to adjust the return error
codes from __tpm_tis_request_locality() and tpm_tis_request_locality() to
ensure they are consistent and that the locality counter is only incremented
for a successful call to __tpm_tis_request_locality().

Changes in v2:
- split into three patches
- adjust code comments per review
- dropped incorrect return value change for tpm_request_locality in tpm-chip.c
- additional -1 replacement in __tpm_tis_relinquish_locality
- changed -EIO to -EBUSY, which is more appropriate, in tpm_tis_relinquish_locality

Daniel P. Smith (3):
  tpm: protect against locality counter underflow
  tpm: ensure tpm is in known state at startup
  tpm: make locality request return value consistent

 drivers/char/tpm/tpm_tis_core.c | 25 +++++++++++++++++++------
 include/linux/tpm.h             |  6 ++++++
 2 files changed, 25 insertions(+), 6 deletions(-)

-- 
2.30.2


