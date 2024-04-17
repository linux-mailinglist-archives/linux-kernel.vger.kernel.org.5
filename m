Return-Path: <linux-kernel+bounces-148786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529228A8764
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843A11C21B31
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B1A147C6D;
	Wed, 17 Apr 2024 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="0sRwnceK"
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC1C1422B6;
	Wed, 17 Apr 2024 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367273; cv=none; b=MUPPgt7oKSrX3xk86/8NFQKc2d3Ng8n+T715/vjz2mKamkvY3VhMF+xwvy4nbHSuw5zo1NSPTBc++JoiHV5KqKWBlaesBxPSbxilwBAnKb535hiPo0Ini/WG7QbRVn1ouQ+iT24aOPHt5WZ4Po775r7Ysnk+S83alOgzou7ZjOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367273; c=relaxed/simple;
	bh=VCfAs8USJF3wx0id2O+sBCqLXABLgSB8mGlPhzfNoag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JUWCHnYbRmX0QtUwbNtNewE70RQ3msciqMkP9avvdcdZGPy6bjoomXs9RR0A5jTmdYuwLzKDt4VgnBmgCxCJiyD9h+AvEWaWFuAI8pgyzHoGmwenrj85EAY23W81ZGlNWT4th/svVSUoa6+Q3jzZqwCzdBVQURCyux84SCu2HPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=0sRwnceK; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 355AADB246;
	Wed, 17 Apr 2024 17:12:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1713366780; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=sSKVR8UhHpKjQMIoqq9gE19puW+/Cp9laurxH1WDzNA=;
	b=0sRwnceKOWShPBtkB3H8QB0Czs+FLrr1iYqX4yT3SHAUK1unv2zX2HC2HstB71QxQWmdEK
	6VvNvyVufwPT1JH/f0BvuRlSwLE2NA2442KWZmNmk4tQfGfnA6CcO3fCYWjYWnNL1wyaKT
	IaxdgCc4zK3eI38Bs/m0dZNuJJjq6+OdEKzro23Bd0nfUc59McC9vxX+jMGhk6n/66ekq7
	fN3qDgC0Ilai/qu+34aMgFj+cgEc7qSTuizy9E1gBcfnFMZp1koNOQv7oP8wVbI179prSP
	re7zg5gfCwgI1ZnWMcR+6uGF/hydm5EvximZnIZFCIgdX9+okY5eyzU6Mjgmpg==
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
Subject: [PATCH RT 0/1] Linux v4.19.312-rt134-rc1
Date: Wed, 17 Apr 2024 17:12:52 +0200
Message-ID: <20240417151253.16881-1-wagi@monom.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Dear RT Folks,

This is the RT stable review cycle of patch 4.19.312-rt134-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release is also available on kernel.org

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

on the v4.19-rt-next branch.

If all goes well, this patch will be converted to the next main
release on 2024-04-24.

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.307-rt133:


Daniel Wagner (1):
  Linux 4.19.312-rt134

 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.44.0


