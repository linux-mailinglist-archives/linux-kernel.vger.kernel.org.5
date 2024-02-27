Return-Path: <linux-kernel+bounces-83214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3306F869057
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A79F4B2A416
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4966813B7AE;
	Tue, 27 Feb 2024 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="erbBIast"
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB4013A24E;
	Tue, 27 Feb 2024 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036503; cv=none; b=JhfTH2G/6umkRSqucT0LLMa8u/5yWcRUYmWSpWyFg+h5aNKk6FoC1j674x7liQcOBq+N951+fu/nx5N/xR3T6R/cBOOvDkkut8H7MURFY5T1KZr4/7b3DY4CkDuMZI6aaSTzAnEN87lGIMEAoIozANc1LKmrBgtgXakt/0qNKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036503; c=relaxed/simple;
	bh=KU0K0rydl2H/3SSwP99NYgbhBLWIG+lu0ATYZqrMQAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rcaCIG9bIlmB6iFjPEOd6SIopiwE3EKczWiwZ8rDe2UQl6Gko93RusowIkOJFPlbbyaIpN4k9PT43nCsxH5kvQCIJfzSPyeiBjQ8JpyZGA+5Rqnnhrd5LZRmuRA0yoPZsVR0zLs7pxsgSKu9v+lN9fQaiEHhzrhznmrc8K3/IBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=erbBIast; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A4FBFDAFB5;
	Tue, 27 Feb 2024 13:12:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1709035933; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=+HZtExjCgBbxZdb+SjkFunHgCU6z86Pw68XOPo88bK0=;
	b=erbBIastQXxCgjdqAeG8BOGoy9wxOV7cRw1VZq60hCnjIp6NCfObD2YdUqYdTlgSI4jRDS
	cUfga+8p4wVSAs9bmQpIpWhvJds+7Fsf9jVo5+wVMkXSy/KC7hkeETIUCZifcZkDnpGW/H
	qiHokf1l0HwnMJaENy003838tHgmCX86kh4Yocgut6VIl1PXd/YvfPpQLGv2wu93w/vpLZ
	pciNQ85DPjf5oNmcYl3dQmBfePKKoa9sl94AY74lnWca60mWYKoA44fa9e51hpyJejIiGY
	VQpsf1Au4GXrFaE5QmhuUH9X2vJN6duWDWThudd5fH+KXW7Xw6tR0SlSCUO7kw==
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>,
	 <linux-rt-users@vger.kernel.org>,
	 <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 0/1] Linux v4.19.307-rt133-rc1
Date: Tue, 27 Feb 2024 13:12:03 +0100
Message-ID: <20240227121204.30720-1-wagi@monom.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Dear RT Folks,

This is the RT stable review cycle of patch 4.19.307-rt133-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release is also available on kernel.org

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

on the v4.19-rt-next branch.

If all goes well, this patch will be converted to the next main
release on 2024-03-05.

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.306-rt132:


Daniel Wagner (1):
  Linux 4.19.307-rt133

 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.2


