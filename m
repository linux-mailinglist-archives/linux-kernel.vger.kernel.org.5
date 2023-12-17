Return-Path: <linux-kernel+bounces-2451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2061815D55
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 04:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A741F224DD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 03:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F947110A;
	Sun, 17 Dec 2023 03:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="uHypg7YJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF43ED0
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 03:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1702784376; bh=WQbUQm6qO8In/5RqnmlJGX6EUe/PtdIM3FORG9wb+NI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uHypg7YJ/LZow+aP+vn1Z8Kx3jFaeW2DvV4uTSR0WfmH2O42tjrjZUFvVNgwMBKtf
	 N/B+sKvRiviy2X3zoTEOfO5FoAPSzjgeC8y9xg6ucD9/1L1fjDtiqtWTAAHjMyhRL4
	 6Gg37w8zyh33wFRQ5A1ZMobyHTnTqGqe04lsx20k=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 9E237A82; Sun, 17 Dec 2023 11:39:34 +0800
X-QQ-mid: xmsmtpt1702784374tnp41sele
Message-ID: <tencent_BC66DF537D0372896683AD445B5767376D05@qq.com>
X-QQ-XMAILINFO: MIXpHopat2IaZk3GntdovwnmryiIzE/j9qSjqNkzb2z1jPLHW2Ti1HTRtY31Rh
	 r+U5doDksGdh5oy4YVM9GB6Q4fVIi4A1I3NYlo0jm9n7W6pJNYzoL99qh4U+BX5jJhFeeOnuqhX8
	 W15+cIPGpDi8iJaYCJVPFKMvWMIaDoFFkqj7JExWvU1cfbtLBdi7oVLNRhETvA5h4WJbp6qktc6c
	 aZW/pWDR86EiGVCf4rpatt8GHd5LnscgtKYxeTrOKUZhEWvFeQhcL3kvVvO0LHYVQ4A1L08kJ+7g
	 JiQrjHjEjefRfOB62ObbvIdz3xCMAmznCfWrQozKUp6wHNi7S+GzwKR6mIewuFwVjIF3EBdEPAMx
	 6VQcf75r+DtUv2E+PIuEO/cORQK5mZ5T7IcCZoeF4SWFK+lCwfbM8YJzpg0ewUoV6n/jW5kohjIC
	 Zk31Du/5jQ+9p179KOHRo3lKUBIaqG2R5PKBdeuNo5UGUP5GBUPow0GtRAUvMGwHh0gQhIg/YmP2
	 Gfv3qHrPUSRwSgB+otI7cufRux2MRLrH7cU/zOepVTEYMoZ+6JjcRy4i0tCtJnRe4p7+gReuqwuE
	 06WKGeSb4lksu+eqfNxaNy9lJLG0nOaot8hWipvViHobR7YB3zdHJkDI2wppUUP57pVuq84ql/Gt
	 zZT/lKep+2nYjRjN11A9cHfwk1JC6SvC1U7uZNwRdY1TNCNl2CZkvOv0Fx2jdyI+6rf7TH60i82u
	 uiNQMVPxodCh7lTyO4DYPZtj9kTme37U9ukHqwd5ZpIoFE6f2NCB5KutnwciNdUEizw0YPanbdn1
	 czrpQLFZpBV4tIavtLkhCATgcfZ025brnSkibcN2c/9toYu3QHisxkhALvdzZZWy/hhcNJf+y4FY
	 sl1czWSiWe6u751T/qfaiLH2pUgo+dQ5U8PuguEYuoyxZ/WA1xdzTaHh9WVDnSfosIHx4SHbYo
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8608bb4553edb8c78f41@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [reiserfs?] [squashfs?] BUG: Dentry still in use in unmount
Date: Sun, 17 Dec 2023 11:39:35 +0800
X-OQ-MSGID: <20231217033934.3915845-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <0000000000003362ba060ca8beac@google.com>
References: <0000000000003362ba060ca8beac@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test BUG: Dentry still in use in unmount

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3bd7d7488169
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 4382881b0709..c366b0c6fad2 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -808,6 +808,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	return err;
 
 cleanup:
+	ovl_end_write(c->dentry);
 	ovl_cleanup(ofs, wdir, temp);
 	dput(temp);
 	goto unlock;


