Return-Path: <linux-kernel+bounces-136642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBAD89D68B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B2E1F225B6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE4D12D74E;
	Tue,  9 Apr 2024 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="DutVURL+"
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B8912B14A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657634; cv=none; b=S94rmkfeV5q83IQdQN65/e0ymwhj5MGDUeeoIyvfuR5INjOvDamDC0OAogNNrN+MP/MeczFTUPP3jxWbVaGzIFC1kIf6n2Sug0TsNjswtGRzgZ7ict24zYJESI+0VfpFut0Ah7FCfgv8pJcQDab7uB13QonJDAo9UP3DeL8tfS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657634; c=relaxed/simple;
	bh=z/e9FoRiyI9hqDwCkx3v++nqOrdtfNLDoRSEf8XPdlg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=h8k6+sIgx/Rdgl8U/RxOTDkZiqfASuiG1IzQNsvg7QAMeQiZQ+ibhPCGLFIYxGdIS+AS65BbFhCyIm8oPUMZozLoYXLhvOiXNRywDGzg4l/G6mqMocSw6/VbGhXltUi4wczo9QObPVbq1iq1InAjZoD0m24aK66fB09U96B4oaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=DutVURL+; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712657623; bh=hOnQ/UH3aNl5tM4fI62DW07XwsLBMYR+se+Q99zyz28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DutVURL+k/sctzsdZSj6KKEJ/Cds4CoMp2Ak3RRt0/5QESDpdJHszEizXQ1jMsvLF
	 XFKz+p77IrosE8XW/FYGM0sMOefKZVC1X4LLDXvpFssSmu+cMuHMtvvN22SAqmV60p
	 EOvL4C6Bo5QlBTF6WPARmzOE91z9aq0UgypZeQRA=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 15D020F0; Tue, 09 Apr 2024 18:05:29 +0800
X-QQ-mid: xmsmtpt1712657129tkr7p4lcq
Message-ID: <tencent_971B5DBEDDD41947CFF98DA0A5FB8D9B9207@qq.com>
X-QQ-XMAILINFO: OQhZ3T0tjf0ae1WvG5xAKJFK3udAX0qRmFuZBPcBQ2uaCAiTj0/SN7r1Lnri+h
	 /dGB9QAtFmv/Y+snDsZctD4y2YfREatVrBML78E55QqNvtPozjiUj2/K9DTLGQ+dOi1N0LaE/IUg
	 BgMYa4+ebCzHNkZJdVCz35R2nPutL30DwUD8JW0FDRZhXfyUx6Xd5FJyo308xvg5ZY91S54XBJMc
	 4c5q+bMWJ1yjcVEn8RcIyA96J2U0X4kSeeGhBBLV/4JXrw4NZm2kBMR3fVthA2p2tb60biDL3S9U
	 U04tYNnXRld53UfG+n0T1Ag9p7thLk7qBlr5WhrmUqycVKnI98SDx7Ix/+aAhriEd5oICH6TYMoa
	 xuYMDEVaGgz1iHAn6ealaVKFJTsN4RAnjgS0H8s9VyPdx6SrqrtZlMKQBzGVZs2mlj+W/s+br4Co
	 2586M6knuUpB7mbD4tLfT5b+RF7+JEnaBL6Gxw1PRlc9kKg/hLqObn3n5S2byL1lRQ8Mxog3+rOe
	 h336ZE3MBrOygKxZyZPPpi6bxv7YvJJ90Znqq0tL8NhqmJd1jcmp3O5AkX/QJWFG/P+XJ68OE8Bv
	 Shi8T08neZgoH7bDx92yoLwLxr0nMNoueCZ1eHHXS3BRRrZXmJvNBeBh50B8fw0P40mICpu3Jctc
	 YSSqELNJmUB+UdbxaA+1A+PnOtqN9XhYuS9cGWTT41LzTI1VwXJ8lRPbXqGTJXSLxmE8gu69ugEA
	 a/WqPX4uSNN73SWyJ/xx1rKH19Kt5LvmqeZkMYI1sCOB5mKW/9CHuF1QyGmrAOWt1NB9K+ylduoD
	 bsfdtidreHSNJR4NxEagnZjc9rGGlPVdde9q1fT9qycdcX5kxF+dlzWVRcjovRJ6Y/Vcf4AhyW/B
	 bE7s3oKQcIEA5WcDtIRlRDvNIqq7dqiu4ON09DNNUoCEk85SR+66hbW4NoR2NR+ApZSMw2I+t+
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+01ade747b16e9c8030e0@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_listxattr (2)
Date: Tue,  9 Apr 2024 18:05:30 +0800
X-OQ-MSGID: <20240409100529.3962578-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000fefd040615a5bef6@google.com>
References: <000000000000fefd040615a5bef6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uini in hfsplus_listxattr

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fec50db7033e

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 9c9ff6b8c6f7..858029b1c173 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -698,7 +698,7 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 		return err;
 	}
 
-	strbuf = kmalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN +
+	strbuf = kzalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN +
 			XATTR_MAC_OSX_PREFIX_LEN + 1, GFP_KERNEL);
 	if (!strbuf) {
 		res = -ENOMEM;


