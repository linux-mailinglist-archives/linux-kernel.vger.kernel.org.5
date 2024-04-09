Return-Path: <linux-kernel+bounces-137506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 411B189E306
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63931F229EA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6211586D5;
	Tue,  9 Apr 2024 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/XMayYD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24551586C7;
	Tue,  9 Apr 2024 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689734; cv=none; b=W6j3x8nI8rk1I5FR6Zs6KrYvUx+32hIkhZyUbSLXoB2kpnNer3V62Fs2WL1EQgpIBnvYuDGVH57Emwd6mnZjaYp5h32EsSQDysw07WyF+nTMsN/lNv95FgUx093sSFBu+JqjiS0xFa/J2b6zCBVmpASIXOKm6poOueqmlD/3W8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689734; c=relaxed/simple;
	bh=NI4IOOBGPBNQ7za0OvSJUdNySKt0sPGUWBq2CGWF4Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bJcUXgTRF1qCu/1NqlaGXzkksTwb+ELshUKQSGWx3ZJ9QzOE+JkKZIzUz51ASKj6SKw+s3B1C7D08XiQjbSmdJ5NKId36ijfkTHmmE1bqCw/q9m1uBWQ8paYJXwtxzbVdCBTZicbXxtg9aKjlDGYC7KB6K6szxyHw4D3WCzllEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/XMayYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BD1C433B2;
	Tue,  9 Apr 2024 19:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712689734;
	bh=NI4IOOBGPBNQ7za0OvSJUdNySKt0sPGUWBq2CGWF4Mo=;
	h=From:To:Cc:Subject:Date:From;
	b=F/XMayYDtMY7KGUK1e881yn+qkds+5l8C/kPN/eokZvuBc8Eygn5VSHmpgjzJHMrs
	 ltjQVqRBm1EKjCTaQ3XjCNw5LbZyJ2tSBWbE0jV7q90zjSKtMgdx7GGQXdejh0eBoW
	 CI2ZxwMqTYHwmJN7MENVUA9QkxfPmTGsEmpKbUvaqgpHdiOmReRdSNZrb/QYSUtgXx
	 4qufJbamaTgdSU5o9mjIMidm+7dHqlKEIERTohZNM/2KT94XHo3MfqI4WOuT2u9opX
	 NjgK9Ch+6e5Fh3ti8ar2/DwCeqTDL04j9NA1Hwv2yHlArlc7ufGNUujy3O2eT771n8
	 yCIpsTiGCsbRQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Alexander Steffen <Alexander.Steffen@infineon.com>,
	"Daniel P . Smith" <dpsmith@apertussolutions.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] TPM documentation updates
Date: Tue,  9 Apr 2024 22:08:45 +0300
Message-ID: <20240409190847.10869-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Re-send of TPM documentation updates. Note that in this patch set the
patch versions do not have relation to the patch set version, as they
were before managed as independent patches.

Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
CC: Daniel P. Smith <dpsmith@apertussolutions.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org

v1:
- Collect the latest versions of patches sent earlier.

Jarkko Sakkinen (2):
  MAINTAINERS: Update URL's for KEYS/KEYRINGS_INTEGRITY and TPM DEVICE
    DRIVER
  Documentation: tpm_tis

 Documentation/security/tpm/index.rst   |  1 +
 Documentation/security/tpm/tpm_tis.rst | 46 ++++++++++++++++++++++++++
 MAINTAINERS                            |  3 +-
 3 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/security/tpm/tpm_tis.rst

-- 
2.44.0


