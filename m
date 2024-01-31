Return-Path: <linux-kernel+bounces-46896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 275E98445EF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89601F2C916
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA4812CD9D;
	Wed, 31 Jan 2024 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="SDAF+ON7"
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB0112BE8F;
	Wed, 31 Jan 2024 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721590; cv=pass; b=ZtdnzSoPZdFvLzDG02LHhpIHEx4TnAi0mJXZlmv/GhfH+mlH9RQR1zX3DXOJfy65ANbrcP17eumlS7GXvz0qBWPTGXzDbda7ARAWiucppSJXA/+90IqQj7fJ7UMnv1X1Rg8GfHv40UzcBdWU0VJ+NbxgA32sctXCp3ytcV9rLOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721590; c=relaxed/simple;
	bh=KKuyKxfSvJuo9R16tFGRbmgmlPSNp5swHpNOjW6jdtE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u8cCxjhdCXKtE2FXYrxkQW8rPvMbdD+tYU5qF8aqXF6UMLBsrAY7EwvE+jnZqSaldjkVSVW/hEmoZkqpgJZZvKzG/lTLF7vdzKdWFN6Ecou1nn0JlaPc0ZpwPPZJQxyYk/yVteHCANY1w3JjQ/zraO96VDqyqwysZyZRLGRD0AY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=SDAF+ON7; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
Delivered-To: dpsmith@apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1706721579; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XeJNbt80dq/YnqE9s2qrA474J1xloCS1wK0nRo2KoFA1h3Od7FDHPptN2jWbytsG81f/ZRJQoWp6Lwp7TzzTViSKNE//ikmUczA+BhvCJq49Ed7c8rhrm9+t5jekYNnKwCz32WFW6bR3JQTCrpr095Psogjr4xW1aqLNwopeTHk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1706721579; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=H+s0lZ1A3z3Ml9q/qDrJ1Lvaz2sQ/evnbzNLrzH5QYE=; 
	b=dkYHYxk84cc/iLGcMw+lDHsKcG/lFAlkTuZpvHipdTi/0UczlQ8U6cPibdG2zRiftcG/BYOu5HFAKm27hlF9LCI3UERTRwsp4iH3weoScTCENT0ldUE2eqTDzg+EK6TJ+WkLv6tbYDVZEvc0IRyLrzGuJnu7PCypsGY48DTH4oI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1706721579;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=H+s0lZ1A3z3Ml9q/qDrJ1Lvaz2sQ/evnbzNLrzH5QYE=;
	b=SDAF+ON7AUn4x8ZWG2G1Ns62Uw6JHUBvLqWR5mmP5+dZX0AkX1/RSAIyYyYrtLle
	IS3FuSEC11RyP0aPWItjqGPU9g/OJSm2QT5vfHpHEqvxnhhHxmHBkTPV/rb9P+pLV8W
	OrCxDBK1T81on6iLBBX1KmRe7XrkLsRLRuHOFDoE=
Received: from sisyou.hme. (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1706721578272198.53972224163658; Wed, 31 Jan 2024 09:19:38 -0800 (PST)
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
Subject: [PATCH v2 0/3] tpm: make locality handling resilient
Date: Wed, 31 Jan 2024 12:19:29 -0500
Message-Id: <20240131171929.18799-1-dpsmith@apertussolutions.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

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


