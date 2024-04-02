Return-Path: <linux-kernel+bounces-127363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C43894A55
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B651F22C6A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54879F9DF;
	Tue,  2 Apr 2024 04:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="gRT3Fs+v"
Received: from out203-205-251-84.mail.qq.com (unknown [203.205.251.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C614175BD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 04:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712031371; cv=none; b=hQL9I6gxO//xqgtnFXAOWyA8ZGwG+At8wmrD1HtyMSo72Hgchz1hjDGrkbdEg5wl7xI5uaTm0BhIeZyp0tf04R9arjgiySwavm47R7ArhBgn6RbNtvp81G4pctWQLCaMrNyfv3xvrU3r1eCJD0siWhNB8kIMbHqPKEDjJrPONZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712031371; c=relaxed/simple;
	bh=s/HHnwD+SmkKVBqoUGGKKDAzr0kT/JyFkYQoA4a1XBU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=jCbH2gHcZ3FfTi36C1f3uzfNXRvlZrDE3C0NILDn5UxlqmXXWpLcq4Mbt+Tx4YXvJKN6buWM/yZLSP0nv5yOXqmqAw2kgEj9k3kMwjQaAnaKbmXS4fskoGpVyBNcwfN87OaifhV+vF3cqVUhf2MnGOkXnCCeeixc6snKemlm1NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=gRT3Fs+v; arc=none smtp.client-ip=203.205.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712031059; bh=MXUyitxU3QQUntbz7v+tHoLVPwTiSCKPD9XlMVmmt+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gRT3Fs+vnfscAUkZSPnnZ9O9mvH8C8MueYFaOrjg9M3jRAv+G4SOS7L06UYSCr1ri
	 MeAlxkcB0VgU29LPFRxGD4jJoSpgXlWUj6VrwV4gy4nrzZbTpIvdMtx2Iha8QTPzP4
	 S3n5C8lxWwMJdHuGWwzpNcwB9ppRdTa0m9yOgsbc=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 2B9AE89D; Tue, 02 Apr 2024 12:10:57 +0800
X-QQ-mid: xmsmtpt1712031057trjz466f6
Message-ID: <tencent_1F326FF82C456F509544E992ECBECE087A0A@qq.com>
X-QQ-XMAILINFO: NvxNySBpH0QlOg07ENiPGFyGyemJSpSmZEAM3Hy7bSDkiyrqiePYBB69d+DAJj
	 sttNSzSM6PDb5FPqIzAyQheZQ1FeQLP7BJcF5t2Dq1hgQXc+HxPbDYJkFI7m0qvrqvCqPRsiPUiN
	 NUEK/PYl/YTJ9xxekA0FuEDVEdV2V9hAKTtrNroPRFbAQxNAvw1VGe824WjELlNxbFPEwQThIWcx
	 MJkZLQMybwt/iXm6NbYy2ywuuxsyO0EH9tEMmzqEZV6He05RkoTusP8Y7NgNlZB8jnAXaQAqE2aF
	 98BykFREaP0wJp0Kd0y7KmwMxWHiz4Zx/gEhPt2sR8ntAWdiy3nxqPSSCmPxBNbWxjOyYe8g9zim
	 omyhT076YY8K6BzwZB/T/o5Ajgcv4u1mxrwpgEhFAw/zGmZdUXScU3J0kr5NDQSdYyepqeMz49At
	 T4k8e7OiVO2FiSPlFjY0XEcVwH4kbIDfS+MJ6t6mzfdrnHVzzovF8RQFNv5vP4QpN4vsKQY/tbTH
	 vggGs+D29fd9t3f5B44UypY+LKH/yK+BxkNtr4EVkpJMPCN/K4taW4sOogtbkOg63v9/ss2GVFcH
	 u0935tzhHb/gzPQD8O9ErIzXaYMYT5xW3tct0GDSUXQhbjiIPGxbn8QToqWElcdOxr0DqwX/z7io
	 qHzTsvekD9sl4uzku3roiP2vpPETdSaGgZ53m/te/H0PzeYUJMqJ1OHbdFoqgCV6J9n1Fj63FrKN
	 7uXM+wxnrtg6T/IcUmaugUpJDfszkaZDFJONtQpXCQmeyn+GMZp5JZm7hhFVuVsyRB922BZGRXjp
	 EeyED+CImwJdz6ZuCO6NWOm97XFzwXMXMGTJthIIclVpesUAoaS9O60Z8Cyma7F7u7S7AIMFsTRI
	 XyZojY5UfxaxA3CVUnO7eoCvdvnkZbi4GBdaEvQVgRYZWS38Jyp5NndQbEpdL7cS8SN9/NZo8p2u
	 2vzT6kbb0=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f516089d7815b10197c9@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mtd?] WARNING: zero-size vmalloc in ubi_read_volume_table
Date: Tue,  2 Apr 2024 12:10:58 +0800
X-OQ-MSGID: <20240402041057.1873314-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000a7f84306150bc9d5@google.com>
References: <000000000000a7f84306150bc9d5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test zs in ubi_read_volume_table

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/drivers/mtd/ubi/vtbl.c b/drivers/mtd/ubi/vtbl.c
index f700f0e4f2ec..e3b337afdb4f 100644
--- a/drivers/mtd/ubi/vtbl.c
+++ b/drivers/mtd/ubi/vtbl.c
@@ -791,7 +791,8 @@ int ubi_read_volume_table(struct ubi_device *ubi, struct ubi_attach_info *ai)
 	 * The number of supported volumes is limited by the eraseblock size
 	 * and by the UBI_MAX_VOLUMES constant.
 	 */
-	ubi->vtbl_slots = ubi->leb_size / UBI_VTBL_RECORD_SIZE;
+	ubi->vtbl_slots = ubi->leb_size > UBI_VTBL_RECORD_SIZE ? 
+			  ubi->leb_size / UBI_VTBL_RECORD_SIZE : 1;
 	if (ubi->vtbl_slots > UBI_MAX_VOLUMES)
 		ubi->vtbl_slots = UBI_MAX_VOLUMES;
 


