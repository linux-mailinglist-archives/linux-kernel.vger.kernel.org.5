Return-Path: <linux-kernel+bounces-94000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE36787381E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC581F24B0E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6861F13174E;
	Wed,  6 Mar 2024 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="D1VN1cyu"
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B12130E57;
	Wed,  6 Mar 2024 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733031; cv=none; b=E3DclQ4nirgP41j8A2HUNXV8it/IWWqBcx0o2fI9AtYHhLVMVmvo8VaSfpEfHEGHe5uL21QwniILYRQVYNG8bpq8MquU6oo/YHYO9hKthXGsz7v/FPzSIIsnLlH5YElQPI47XvblUd7e3VU3ta2rTVnFwkfCbgjh5uD8PgoejGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733031; c=relaxed/simple;
	bh=Rz/7QeGwGWVQ23cVl//CoUspDWwVdJjOPTplV8dC39E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ifBVpXLoOTGuMzeINMXbhVl2gnb1s7+JlIvxkoQRP6UYIwk+QZsEqzeJOySLUquOYnJBbDqjx9WfgMfdLWskXRGA6FyQ4NIjDuhgxH9n+/5ogBhmcmWqByURAftrQqk8GVtyyEBN9JmUU1UOMIAq1AVplRdW0P9KRRa5BvG9bB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=D1VN1cyu; arc=none smtp.client-ip=178.154.239.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:601e:0:640:ac7:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id E70F16090D;
	Wed,  6 Mar 2024 16:50:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Bogo8U46U0U0-5x8x78mU;
	Wed, 06 Mar 2024 16:50:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1709733025; bh=si9CmxfbTTi+fzS7ZgV1gg2/IENW5eLorkGc5P/t0aU=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=D1VN1cyuNsIj1u2ombhbQGZLwl6NLZWBoBjvpgF+oBQ0bDbD0i8wrI8SljgXvkQyj
	 2Vba3U5tDUZqR7YBvxEzfLgA3EL9TI32Roii1o59KBOcyR+ZHoPEuG4d7vhHNF5CDf
	 aDXNkMROmIdi0tuSn0/SyooTY7XBsmqJ6li6omLw=
Authentication-Results: mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Mikhail Ukhin <mish.uxin2012@yandex.ru>
To: Dave Kleikamp <shaggy@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Ukhin <mish.uxin2012@yandex.ru>,
	jfs-discussion@lists.sourceforge.net,
	stable@vger.kernel.org,
	lvc-project@linuxtesting.org,
	linux-kernel@vger.kernel.org,
	Pavel Koshutin <koshutin.pavel@yandex.ru>,
	Artem Sadovnikov <ancowi69@gmail.com>,
	Mikhail Ivanov <iwanov-23@bk.ru>
Subject: [PATCH 5.10/5.15] scsi: add a length check for VARIABLE_LENGTH_CMD commands
Date: Wed,  6 Mar 2024 16:50:10 +0300
Message-Id: <20240306135010.9250-1-mish.uxin2012@yandex.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fuzzing of 5.10 stable branch reports a slab-out-of-bounds error in
ata_scsi_pass_thru.

The error is fixed in 5.18 by commit
ce70fd9a551af7424a7dace2a1ba05a7de8eae27.
Backporting this commit would require significant changes to the code so
it is bettter to use a simple fix for that particular error.

The problem is that the length of the received SCSI command is not
validated if scsi_op == VARIABLE_LENGTH_CMD. It can lead to out-of-bounds
reading if the user sends a request with SCSI command of length less than
32.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Signed-off-by: Artem Sadovnikov <ancowi69@gmail.com>
Signed-off-by: Mikhail Ivanov <iwanov-23@bk.ru>
---
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


