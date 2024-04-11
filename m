Return-Path: <linux-kernel+bounces-140249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E578A1025
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8E9BB2610C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26538146582;
	Thu, 11 Apr 2024 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="u1S11NYq"
Received: from forward102c.mail.yandex.net (forward102c.mail.yandex.net [178.154.239.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B317C14884E;
	Thu, 11 Apr 2024 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831442; cv=none; b=XSv7r0i4b2LGOd7rjH+gQk7bgnBWkPq9TZnWOGM8s+ZvtCxI5ZIWTQRKj9u5LwuHnpUvh0yDtu039CGMQMIBqMDdXQ/eCtz+/75So1tkp5fQs5vWwx7QHUGyG/w63zfUEN5FuNpzUQIvxI/0Qpnm4WCBdUQT1+UVy2GC3yQ3LZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831442; c=relaxed/simple;
	bh=Tyd5sjSQq0uCOIAQla9jv62vIEKZInGcvL7SV3Eq3Zo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g5VJmF2qwjXehNWIgwwfiocrdJZF1Jv2hjQIKBqZNA2bCyqATFz+BznAt7WhRD5T9ms3PnUWsIFmTAlUJvKA9kPkL27dPuM7qgljQlVMSkJ8SIL0bAeHU05w8Of1XZEx77ZTI/KzgwWJ3ZYJpL2C3gfNh/Kv5b6Pk/d7kT8FtXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=u1S11NYq; arc=none smtp.client-ip=178.154.239.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:40a8:0:640:e4a0:0])
	by forward102c.mail.yandex.net (Yandex) with ESMTPS id CD7C8608C4;
	Thu, 11 Apr 2024 13:30:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GUYvfB6Aa0U0-eq8haQBw;
	Thu, 11 Apr 2024 13:30:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1712831429; bh=0U309rUe4lYr52AcQxtvvnxUZcPXlp+u/Y/o6hkGyZI=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=u1S11NYqae0MtTOiEqXrQt/PitXzQLm6BeWlLEi7t1094HbIapfPIH3QrrqzTdxmI
	 YxZR9ZiEJtNBuJ1J49yFZru0joH/S5On00oyjUzwVTDR8biNGFfitIf/opSpFqDKjL
	 bu2Gu0ZLWnoIOmfXuTLTm9hi2jFEeiQ/K7cxQoOs=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Mikhail Ukhin <mish.uxin2012@yandex.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Mikhail Ukhin <mish.uxin2012@yandex.ru>,
	stable@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavel Koshutin <koshutin.pavel@yandex.ru>,
	lvc-project@linuxtesting.org,
	Artem Sadovnikov <ancowi69@gmail.com>,
	Mikhail Ivanov <iwanov-23@bk.ru>
Subject: [PATCH v2 5.10/5.15] ata: libata-scsi: check cdb length for VARIABLE_LENGTH_CMD commands
Date: Thu, 11 Apr 2024 13:30:13 +0300
Message-Id: <20240411103013.5547-1-mish.uxin2012@yandex.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No upstream commit exists for this patch.

Fuzzing of 5.10 stable branch reports a slab-out-of-bounds error in
ata_scsi_pass_thru.

The error is fixed in 5.18 by commit ce70fd9a551a ("scsi: core: Remove the
cmd field from struct scsi_request") upstream.
Backporting this commit would require significant changes to the code so
it is bettter to use a simple fix for that particular error.

The problem is that the length of the received SCSI command is not
validated if scsi_op == VARIABLE_LENGTH_CMD. It can lead to out-of-bounds
reading if the user sends a request with SCSI command of length less than
32.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Signed-off-by: Artem Sadovnikov <ancowi69@gmail.com>
Signed-off-by: Mikhail Ivanov <iwanov-23@bk.ru>
Signed-off-by: Mikhail Ukhin <mish.uxin2012@yandex.ru>
---
 v2: The new addresses were added and the text was updated. 
 drivers/ata/libata-scsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index dfa090ccd21c..77589e911d3d 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4065,6 +4065,9 @@ int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
 
 	if (unlikely(!scmd->cmd_len))
 		goto bad_cdb_len;
+
+	if (scsi_op == VARIABLE_LENGTH_CMD && scmd->cmd_len < 32)
+		goto bad_cdb_len;
 
 	if (dev->class == ATA_DEV_ATA || dev->class == ATA_DEV_ZAC) {
 		if (unlikely(scmd->cmd_len > dev->cdb_len))
-- 
2.25.1


