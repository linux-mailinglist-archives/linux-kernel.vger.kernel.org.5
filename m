Return-Path: <linux-kernel+bounces-163370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B28498B6A00
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449041F220E2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F721772D;
	Tue, 30 Apr 2024 05:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="SChbnixO"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB17BC14F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714455626; cv=none; b=fa2rjtaiEbPLrqvl/jfERf/24xlMImH3RGpCdA3rmazeyuDaaVvtEVlg5f/xtd8wWRIvKn/eo1jFoHsKdJt+mEE56TVX+0/EB2y0uPuf3DSi+OYgk+n51HkQeLQlDPckyBbLvnit25dc0XZqzRVmCRd59EzWW27jsME3ivHEGzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714455626; c=relaxed/simple;
	bh=o2mkoohmWSqXxEQKCsPzfVpPezIXDWDYgvj5CKYjwaM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Dwz6vmDuxdy6FSfScibBBhNthhypnahoYCzPHfJ19wDzlA3iLJFSm7kmHDyz8B1BTQu83l8wJoXqOJ43hQpfhNrMZ6gNVzNkjxjLH4pOFw4eMTK3FftBJZXHrnRLtfuP0Bqtd1BRLF6/DZUCBgmjhPg2eKOg+ZDMEYuGfSDg6lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=SChbnixO; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1714455612; bh=cE2Z8F+T6CzTKmHgax54sOHcrGaYMhSaBGLMxBBiY+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SChbnixObmb8XynVH9453ILUYgKvqEpeja+KfIQxkFTHeT187xoXHK6TRm8MH3IrM
	 Rwsg2VZekgAEY7F+Y5ACo3In/7I/NunWibOupldDprZMN3pVdUUGj7mLHL2QbFNFx6
	 q+WiEeTzs+yv8U8kBiIVY4jSjYzjF+wqJR1EO3BU=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 8820A65A; Tue, 30 Apr 2024 13:34:02 +0800
X-QQ-mid: xmsmtpt1714455242tc59767xk
Message-ID: <tencent_7437344BBA742F76EB67C63D0F362897D209@qq.com>
X-QQ-XMAILINFO: OQhZ3T0tjf0ae1WvG5xAKJHC8YjbpJpaMz3BzFnLFo/y+C2ulx/8PKYcoYL+hv
	 UBOO6f+HAp0Jwc8pJzI4OnzZhytTmYapkVaIz1n+gJTGj1/OkdCiTeSEy18InFotE1Rl9+yk4w/G
	 53kM6CFmtsNZSFVf3O08X5jyg+eePeDTdtglQpnrz9JGOWsJbNWlOyZuUC58i4ifu+r3r3Azfxwk
	 wpfHOE12f1rxJ6u7q2e7uzfbqqay8z2r/l63B9acJW+Q+5H86VtbTCyIQi0JpYCfIN1EAyAASVD5
	 sTj9Vbp6qLfKyRVefT86qPZw26d9wHzvZYwDpkl7SIeATpIbYZcpmbDJlrq2jLdTPz9VeeV0ccsF
	 ZdyeIcpUnRbdw4w1F0t4cVUW0nrMdEQr2V8PUsqGRKOG12f6zopbdhezqLKDiWeZt7k+QF+InNCQ
	 4v0ytbgPvf62FlN6CT/TNpo1gu7lLNKzAndCG+Kl21L9TpMvC9RkCR1fC4K1uOLXI6q22TH0uawN
	 hLbJwNkhKLoqoCSdnVNr35tOXi0zmEv9ogbb6U3JpXjKXxQRszpQTHT3ZrFBPw5Yq90ggFtA+tf+
	 qZMlfS57R2eB2ISF0hyVLz/5OgP5u1mbFvDulJcSOZG3IezMCdSKADalKjBW2ZB3lNPOTVMv57LD
	 ApVOWIw/QGmTNddTbbEfEdRj7beK066n1a3vnqZhpfhVAXQiUnlfkpJZYVPrC+AB7BGqtSnL8Kef
	 A/KieRNOxOcbZ6HHHYOKS456C4s2rBKG9p4NR2/m9tM/PRkUuTTPf7RH43pfyGcgEAkWcbKGzOSO
	 f8VwsaEIeJ8PaBJi40YezQkz4rJg0Pp77vJrvSaYWJ11wpISM8Is5KMY9UnNpzQ2i/9jsZGWA4PD
	 q3ScgEpWF38SQOk3X+vILUn81EiEFwAFmXJ5q6rW+IyBWyXeM7UnHcbAcIex7fuj0s4PLq91Bn
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+eaba5abe296837a640c0@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] KMSAN: uninit-value in ext4_inlinedir_to_tree
Date: Tue, 30 Apr 2024 13:34:02 +0800
X-OQ-MSGID: <20240430053401.562396-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000440b0a06173e6ca8@google.com>
References: <000000000000440b0a06173e6ca8@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uv in ext4_inlinedir_to_tree

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 5e4f65c14dfb..3611952570a7 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1182,7 +1182,7 @@ static int htree_dirblock_to_tree(struct file *dir_file,
 int ext4_htree_fill_tree(struct file *dir_file, __u32 start_hash,
 			 __u32 start_minor_hash, __u32 *next_hash)
 {
-	struct dx_hash_info hinfo;
+	struct dx_hash_info hinfo = {};
 	struct ext4_dir_entry_2 *de;
 	struct dx_frame frames[EXT4_HTREE_LEVEL], *frame;
 	struct inode *dir;


