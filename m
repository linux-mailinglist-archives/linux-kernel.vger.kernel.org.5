Return-Path: <linux-kernel+bounces-110922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C22F8865BD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 05:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A90D1C225B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 04:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A68BAD5D;
	Fri, 22 Mar 2024 04:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oC2SLE63"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79B26FCC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 04:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711081015; cv=none; b=PPIahxPQRXAUDN4NbIhtv6slDoEMDpNJhy1xL9Jad4T4hvyRNB40LJO2vShztLKqh5Ps1puxU4ddR0i1HNjIK16mt8W7vNraUgZnc+c+5UabmFrMb3vhMRqxfjq04NjbaQMX0iYB5QeXu1nwllJScp7Gs8/OCkKgGNMhfW3zzYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711081015; c=relaxed/simple;
	bh=VUwqvk2FdXQpXJAHRVmr/OcDsmt98HWmWBozNopBJ1o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=tL7nDynVu7L7eOzC45a+4X8zSpa3C9rbWVKgWbpStMi9KDzi0UJHuS1ekAAmBEDHplU1lqgPx+rmPyfS/g4aclQnGI4D+PLcEGvbpywRRchFhHxfvAHg9kkgvQrxZj4ZayINpLX9y7N/Ohjnm44EMWTH1yHpoWCZgEpvNV82J5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oC2SLE63; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240322041644epoutp0193a06766ded21b4eb6cc36b0170a809e~__xuKC0GA0515905159epoutp01m
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 04:16:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240322041644epoutp0193a06766ded21b4eb6cc36b0170a809e~__xuKC0GA0515905159epoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711081004;
	bh=9kKW01SYW8n00To8GRW9yLV87wsWhL7l6j407SYCACs=;
	h=From:To:Cc:Subject:Date:References:From;
	b=oC2SLE63rc3+JVAjHaRmS/k6RiKMSwlSe4UWLaQcK/hQAx6CMG4GIfMocRgaOcBfT
	 DEQSmmZ4XpsgYzuVeDZBubFYbX7C6GhmcoC0yguRQsjhfheqLcHjCAbwWgtG+8ijRi
	 juv+1yKRImQdNtciU6TPKwNzV7wVPn7zsBouDHQM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240322041643epcas1p1464767200570836c3b1620309fdaed41~__xtk2OWr2700527005epcas1p1V;
	Fri, 22 Mar 2024 04:16:43 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.223]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4V18Cv35KXz4x9QB; Fri, 22 Mar
	2024 04:16:43 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
	D4.7A.10076.B260DF56; Fri, 22 Mar 2024 13:16:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240322041642epcas1p45a26c5b2bde5f8b006c900c235b14e01~__xsNOTHM0085600856epcas1p4L;
	Fri, 22 Mar 2024 04:16:42 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240322041642epsmtrp17ad1515bafec0a84df466f4bb5b2ecdb~__xsMlr-e0540705407epsmtrp1i;
	Fri, 22 Mar 2024 04:16:42 +0000 (GMT)
X-AuditID: b6c32a39-7edf87000000275c-34-65fd062b5566
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	36.76.19234.9260DF56; Fri, 22 Mar 2024 13:16:41 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.41]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240322041641epsmtip10228577e205e65746e88a1b6b76dc651~__xsAUbUW2836928369epsmtip1S;
	Fri, 22 Mar 2024 04:16:41 +0000 (GMT)
From: Yeongjin Gil <youngjin.gil@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Yeongjin Gil <youngjin.gil@samsung.com>, Sungjong Seo
	<sj1557.seo@samsung.com>, Sunmin Jeong <s_min.jeong@samsung.com>
Subject: [PATCH] f2fs: Prevent s_writer rw_sem count mismatch in
 f2fs_evict_inode
Date: Fri, 22 Mar 2024 13:16:39 +0900
Message-Id: <20240322041639.23144-1-youngjin.gil@samsung.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmrq42299Ug7MzhCxOTz3LZPFk/Sxm
	i0uL3C0u75rDZrGg9TeLxZZ/R1gtZux/yu7A7rFpVSebx+4Fn5k8+rasYvT4vEkugCWqgdEm
	sSg5I7MsVSE1Lzk/JTMv3VYpNMRN10JJISO/uMRWKdrQ0EjP0MBcz8jISM/UKNbKyFRJIS8x
	N9VWqUIXqldJoSi5AKg2t7IYaEBOqh5UXK84NS/FISu/FORqveLE3OLSvHS95PxcJYWyxJxS
	oBFK+gnfGDNOdggVfOGrePFhBnMD40fuLkZODgkBE4kNn/YxgdhCAjsYJTZ1BHUxcgHZnxgl
	Fi78xgiRAHLmrU2Eabj25CwbRNFORomb91+ywBXd3eAAYrMJ6EpMffmUFcQWEVCXODVpKQtI
	A7PAEUaJ37u2g00VFgiWuNs9mx3EZhFQlbjeeY4ZxOYVsJV4v3USI8Q2eYmbXfuh4oISJ2c+
	AVvGDBRv3jqbGWSohMAhdonWL0tZIBpcJGasOcMOYQtLvDq+BcqWknjZ38YO0dDOKLHi4RxG
	CGcGo8Tf9/dZIarsJZpbm4Ge4wBaoSmxfpc+xDY+iXdfe6BKBCVOX+tmBimREOCV6GgTggir
	SVyZ9AuqREai78EsqL0eEp032xlByoUEYiXa1jBNYJSfheSdWUjemYWwdwEj8ypGsdSC4tz0
	1GLDAlPkaN3ECE6ZWpY7GKe//aB3iJGJg/EQowQHs5II747/f1KFeFMSK6tSi/Lji0pzUosP
	MSYDA3gis5Rocj4waeeVxBuamVlaWBqZGBqbGRoSFjaxNDAxMzKxMLY0NlMS5z1zpSxVSCA9
	sSQ1OzW1ILUIZgsTB6dUA9Pq43c8ev9ohDH5iv9/dSZGS+50u8O8e7J7l3jN8XPMTPlX/UVE
	wElgwsQJE7qWvw/zCVdRD+E+M2dr+8XDt5N7QzgXvvz5+Epq2XUfE+fzhSa9uyVX7T3u+kNg
	x9ISIe8vPdrcHUqnmSV4oh6+2L2Ee4kJ+0qzB0pqjT6z1yftnlojd/TsiiLujClaMw8Ifz7z
	7fqb9vhtNS8Etm20aTvZVBN/tk3VuvK5RrBRnJ5orKmh2LH7wZ5vPaQ9N7oUslZHyBhdOHxL
	Kf9DY1uI7QGt+6nRZ15obGe8xW9kmbtpz7+jnnt2Sr2aOo93Mn+/WCK7d2G98pbaS2G7jJh3
	LH3o0jNZzEFhsdvH+glhe5VYijMSDbWYi4oTAWCuBFtQBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSnK4m299Ug3/XLC1OTz3LZPFk/Sxm
	i0uL3C0u75rDZrGg9TeLxZZ/R1gtZux/yu7A7rFpVSebx+4Fn5k8+rasYvT4vEkugCWKyyYl
	NSezLLVI3y6BK+Nkh1DBF76KFx9mMDcwfuTuYuTkkBAwkbj25CxbFyMXh5DAdkaJh/c+s0Mk
	ZCT+THwPlOAAsoUlDh8uhqj5wCgx+dUlFpAaNgFdiakvn7KC2CICmhJHOmeygxQxC5xglPi6
	+CsTSEJYIFCid+pMZhCbRUBV4nrnOTCbV8BW4v3WSYwQy+Qlbnbth4oLSpyc+QRsATNQvHnr
	bOYJjHyzkKRmIUktYGRaxSiaWlCcm56bXGCoV5yYW1yal66XnJ+7iREckFpBOxiXrf+rd4iR
	iYPxEKMEB7OSCO+O/39ShXhTEiurUovy44tKc1KLDzFKc7AoifMq53SmCAmkJ5akZqemFqQW
	wWSZODilGpjM/V9sfGR/4Jlbhf9hpqvKYS6Xa889m/okg6utT0A5tHrpgklRu2dOlc/Psdjn
	3ri8+vg02cTitwfktLdP8+Gy11tqOunFZA2d1SK7JL++3+lR9mBVo8pfl8iNBdPuGQp0ys5/
	sH3Jf+YnvL9v7f7+67Sd5JbYz61mG2ck7PDMiOdYdrvq9ecuh+8vzYzvOE8T4pzHva9obnIS
	w9aT8g1dL3eZ/P7GLW85+/xTFTvuUxJWHvlnztwzuPVAcJ5yudlt+0tZHs+sP968J6d6sfLA
	PRvx2bPrXjiF+nlsyPyX0lB+3vKTR9mKmoRVKrt0P5xIe28cvXT5/LYjWsfbTRvPzrxsc3Op
	2uWJipb/zke5K7EUZyQaajEXFScCAPmc9Ke3AgAA
X-CMS-MailID: 20240322041642epcas1p45a26c5b2bde5f8b006c900c235b14e01
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240322041642epcas1p45a26c5b2bde5f8b006c900c235b14e01
References: <CGME20240322041642epcas1p45a26c5b2bde5f8b006c900c235b14e01@epcas1p4.samsung.com>

If f2fs_evict_inode is called between freeze_super and thaw_super, the
s_writer rwsem count may become negative, resulting in hang.

CPU1                       CPU2

f2fs_resize_fs()           f2fs_evict_inode()
  f2fs_freeze
    set SBI_IS_FREEZING
                             skip sb_start_intwrite
  f2fs_unfreeze
    clear SBI_IS_FREEZING
                             sb_end_intwrite

To solve this problem, the call to sb_end_write is determined by whether
sb_start_intwrite is called, rather than the current freezing status.

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Sunmin Jeong <s_min.jeong@samsung.com>
Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>
---
 fs/f2fs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index c26effdce9aa..12b1fef31f43 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -804,6 +804,7 @@ void f2fs_evict_inode(struct inode *inode)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	nid_t xnid = fi->i_xattr_nid;
 	int err = 0;
+	bool freeze_protected = false;
 
 	f2fs_abort_atomic_write(inode, true);
 
@@ -843,8 +844,10 @@ void f2fs_evict_inode(struct inode *inode)
 	f2fs_remove_ino_entry(sbi, inode->i_ino, UPDATE_INO);
 	f2fs_remove_ino_entry(sbi, inode->i_ino, FLUSH_INO);
 
-	if (!is_sbi_flag_set(sbi, SBI_IS_FREEZING))
+	if (!is_sbi_flag_set(sbi, SBI_IS_FREEZING)) {
 		sb_start_intwrite(inode->i_sb);
+		freeze_protected = true;
+	}
 	set_inode_flag(inode, FI_NO_ALLOC);
 	i_size_write(inode, 0);
 retry:
@@ -887,7 +890,7 @@ void f2fs_evict_inode(struct inode *inode)
 		if (dquot_initialize_needed(inode))
 			set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
 	}
-	if (!is_sbi_flag_set(sbi, SBI_IS_FREEZING))
+	if (freeze_protected)
 		sb_end_intwrite(inode->i_sb);
 no_delete:
 	dquot_drop(inode);
-- 
2.40.1


