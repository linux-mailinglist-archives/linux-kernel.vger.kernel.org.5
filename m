Return-Path: <linux-kernel+bounces-74147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124AA85D070
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4335C1C2267A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25793A1B8;
	Wed, 21 Feb 2024 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="49izGoR4"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE934A1D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708496520; cv=none; b=urxgZRDNR0R8/rHXFnsL+I/8OSRlAvGE1gjOUzLwfrQFl8rPxS5OPMCoINP6VskeAiwS8CryjmGoOjV7Wo5zvvlR4dZ+8dA2UEJitKkw4oJeDX8NYPrJXjXJHSyCofrdVdEPq/xzhvPYP/FpxXpSRO9496ATFY//yKogAz9wAS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708496520; c=relaxed/simple;
	bh=vAVbgIHkYAJyh5yqrJMHBFVJN83YshqRAh3wdY4viiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mIp4FJccV8l3AQ8AmoZIX0EIJwsC2Z6VY8xYpUsY1F8FjZOTQp0on/elHGQHLOVAn2C7EobVUnfLEiE3mMVaaG8RC3orlOx9a9bU1lsn7qY7/+NwLP+rf4RrfjuBrX+X7C0f1/dShW8NdWJvJgpAj/JPmaIDQSiIPbLNHRm133E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=49izGoR4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=rqPhx6jr1tPSwcKB6bnF+kRoDxCAr/BNcrz1uhr4xAw=; b=49izGoR4zV59g+0+Qb+7EzeROo
	y1Rd/5CNW5OiFIfKgXpzT79K6uxgW3OzVpYZZuDyp3t9gyAGbWTDDgrvQYMHshIFyhfe33b3HfvdF
	WLz7CdovH0baZwIyFsI6csRMOD2jdlsr0TE6sPp6Ttq8BfinpYowG9HYZDL1d7Ej+43gLqxiI/rLi
	7tUojxY4w7xaVw5NwurPF+3tRWAWyiWrp3SBW9PoncAh3lMfnfHD4QcR34DMqbXltFnWVg+dGKe8D
	kdfPmk0aT4IoH2/THk1xDUuwOL60n+W16AsAA8KmmL4D80s3+fWq9ZJeH1/kNiRshEpxPl8CHx0Mz
	68t9LFUA==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcfzS-0000000HJed-0pKJ;
	Wed, 21 Feb 2024 06:21:58 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] firmware: arm_scmi: optee: fix struct kernel-doc warnings
Date: Tue, 20 Feb 2024 22:21:57 -0800
Message-ID: <20240221062157.8694-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the kernel-doc notation for the nested union in struct
scmi_optee_channel to eliminate kerenl-doc warnings:

optee.c:130: warning: Excess struct member 'shmem' description in 'scmi_optee_channel'
optee.c:131: warning: Function parameter or struct member 'req' not described in 'scmi_optee_channel'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/firmware/arm_scmi/optee.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff -- a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -109,8 +109,10 @@ enum scmi_optee_pta_cmd {
  * @rx_len: Response size
  * @mu: Mutex protection on channel access
  * @cinfo: SCMI channel information
- * @shmem: Virtual base address of the shared memory
- * @req: Shared memory protocol handle for SCMI request and synchronous response
+ * @req: union for SCMI interface
+ * @req.shmem: Virtual base address of the shared memory
+ * @req.msg: Shared memory protocol handle for SCMI request and
+ *   synchronous response
  * @tee_shm: TEE shared memory handle @req or NULL if using IOMEM shmem
  * @link: Reference in agent's channel list
  */

