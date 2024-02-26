Return-Path: <linux-kernel+bounces-80525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19064866920
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FCDA1F22E94
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9F11BC39;
	Mon, 26 Feb 2024 04:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ayN+x7Q2"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEED1BC27
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708920169; cv=none; b=VIKbqWwR8dpkk7I6IJ1Cr297czpkg484j9lBUdf8gwtor7Hi8cOhDN7Kc4iEVSm53QH2TQf226SoMk5Y+XWGWF9ypFBnUmNCiKK6z5L+N2xdgOIm3DQOwM079RW3/Sv6mXd6VCmPXLmWrvqRnjFGXfvp7PPhx5xpzEL+VD9Kn78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708920169; c=relaxed/simple;
	bh=r8nCZ7cekaeBu5AKNHYr4YHc1J/SCWuXi8RGoSZaeXc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=qGKzY98bQneTzmQGcB+iQOslZGWwUndne/yqsCr5J3MLQAnKqJvgfoUz/83tkV8dFsGohcKESZAWll1fAI4PWlCJa4ymB0EKyc5f9iAKlV50+EKAHVKkDCW0TCNIu/P7shU5XK5WukfYT3/NkqlyK4etjCxrw8zl6MRQgjfI0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ayN+x7Q2; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240226040239epoutp0435d34c03f61ee01a11ac240d16594bc2~3TdSkKVHf1232912329epoutp04e
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:02:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240226040239epoutp0435d34c03f61ee01a11ac240d16594bc2~3TdSkKVHf1232912329epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708920159;
	bh=KZgZqrja1XDlseSrM4SCjCyjIjqBbCiuVy6jA3qnLbk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ayN+x7Q2I+AxGLY61JUyUff/HtONRmJ3YPjb3OhC8KHQYmevVBgF1L1+RP4d85SM3
	 XNtJt1Vsny+IIw3hKLjlteTtJji8o8wqDiN7qZx9WmVPBzCxRfg4JSmFGCrN1IeOg3
	 I16BUSypSfpuN+L8/285kn85YTpaKPY+LiZZSfg0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240226040238epcas1p261a2c1fcab01e092fb67a506f3379b00~3TdSGj1FX1967419674epcas1p2I;
	Mon, 26 Feb 2024 04:02:38 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.247]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Tjn5B4s2Dz4x9Q2; Mon, 26 Feb
	2024 04:02:38 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	18.62.11177.E5D0CD56; Mon, 26 Feb 2024 13:02:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240226040238epcas1p189fc1471befb73603d75aab855ae37ac~3TdRnx7Se1420514205epcas1p1Y;
	Mon, 26 Feb 2024 04:02:38 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240226040238epsmtrp1bfb022a3027f20b789c9a62e9eece55f~3TdRm386x1469614696epsmtrp1U;
	Mon, 26 Feb 2024 04:02:38 +0000 (GMT)
X-AuditID: b6c32a35-29ec5a8000002ba9-20-65dc0d5ea753
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	8E.85.18939.E5D0CD56; Mon, 26 Feb 2024 13:02:38 +0900 (KST)
Received: from parkseongsu-desktop.. (unknown [10.252.69.73]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240226040237epsmtip1f13f6f51ff360b97ba7103daa25cfeff~3TdRU8mNM0330403304epsmtip1t;
	Mon, 26 Feb 2024 04:02:37 +0000 (GMT)
From: Seongsu Park <sgsu.park@samsung.com>
To: catalin.marinas@arm.com, will@kernel.org, anshuman.khandual@arm.com,
	ardb@kernel.org, maz@kernel.org, joey.gouly@arm.com,
	quic_neeraju@quicinc.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	sgsu.park@samsung.com, Leem ChaeHoon <infinite.run@gmail.com>, Hyongwu Kim
	<browoo777@gmail.com>, Gyeonggeon Choi <gychoi@student.42seoul.kr>, Soomin
	Cho <to.soomin@gmail.com>, Daero Lee <skseofh@gmail.com>, kmasta
	<kmasta.study@gmail.com>
Subject: [PATCH] arm64: head: Remove the instructions that get the virtual
 offset in __relocate_kernel
Date: Mon, 26 Feb 2024 13:02:24 +0900
Message-Id: <20240226040224.611039-1-sgsu.park@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmgW4c751Ug1MNqhb7TiRb/PzyntHi
	8vsuVov3y3oYLTa13We0+LNxN5PFl+Y2IPF3KbPFpsfXWC0u75rDZrFzzklWizdXfrFZvG8A
	6pj0YwujRfvnF6wWLXdMHQQ81sxbw+ixc9Zddo9NqzrZPDYvqfeYuKfOo2/LKkaPQ2cXsHp8
	3iQXwBGVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkD
	dL6SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CsQK84Mbe4NC9dLy+1xMrQwMDI
	FKgwITtj3tZ+poJW7oq3S48yNzDu4uxi5OSQEDCR6Jt0iLmLkYtDSGAHo8SCtW1sEM4nRolP
	c34xwjmz7yxkhGmZeeMTVGIno8T5i21McFUN+56ygVSxCWhJrP7Xyw6SEBGYxShxdtp2VhCH
	WWA/k0Tnv5csIFXCAhkSc39/AbNZBFQlbt+eA2bzClhL7Li2gw1in7zE/oNnmSHighInZz4B
	q2EGijdvnQ12uoTAXA6Jf0+3skI0uEgcvPeTHcIWlnh1fAuULSXxsr8Nyi6W2PdlDTOEXSPx
	YN4eKNteouNZG9ACDqAFmhLrd+lD7OKTePe1hxUkLCHAK9HRJgRhKkuc2+oIYUpK/FmgBzHD
	Q+L/9tdgRwoJxEr0XT3KOoFRbhaS+2chuX8WwqoFjMyrGMVSC4pz01OLDQsM4TGZnJ+7iRGc
	bLVMdzBOfPtB7xAjEwfjIUYJDmYlEd5wmZupQrwpiZVVqUX58UWlOanFhxhNgSE6kVlKNDkf
	mO7zSuINTSwNTMyMTCyMLY3NlMR5z1wpSxUSSE8sSc1OTS1ILYLpY+LglGpgOjrB9uVCsWct
	O9beFXkQtGvxsveHZr65eCDM9EC0ZXeg/y/j2SovDf6xsG0+u//ftXn1radad0n/aSuyX3rS
	xd/5s3lV/MKfd2YGrKu8v+VZYUvD747ApQ1/p9wV2T098+uyGuHv7XM95b6E6TWUKKQ0n+Db
	LGO/Qf8p6ze2V9+8lVyMl75qV/D50na2TW2fk8fDs9sZXmxwb7rmFGzJu7x54Xvn66dkRP0P
	d/2qumaTL7TlU7/K0mp/p3jvA/l9nx7X9GQJH2eJPqgUNu1o63WFhsyDzm3JTNyrHWJ1Tb95
	LdTWjlkua/zh2/z1BQIf/sTNURP++eUGu8S2/UGTzRy/vt6js3tOa5XSruvLZJVYijMSDbWY
	i4oTAQR2fyY/BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSnG4c751Ug1trOC32nUi2+PnlPaPF
	5fddrBbvl/UwWmxqu89o8WfjbiaLL81tQOLvUmaLTY+vsVpc3jWHzWLnnJOsFm+u/GKzeN8A
	1DHpxxZGi/bPL1gtWu6YOgh4rJm3htFj56y77B6bVnWyeWxeUu8xcU+dR9+WVYweh84uYPX4
	vEkugCOKyyYlNSezLLVI3y6BK2Pe1n6mglbuirdLjzI3MO7i7GLk5JAQMJGYeeMTYxcjF4eQ
	wHZGid9PJ7NDJCQl2t9dZuli5ACyhSUOHy6GqPnAKPFh3gJmkBo2AS2J1f962UESIgKLGCU6
	f59jBnGYBY4zSazbt4YZpFtYIE1iebsBSAOLgKrE7dtzWEBsXgFriR3XdrBBLJOX2H/wLDNE
	XFDi5MwnYDXMQPHmrbOZJzDyzUKSmoUktYCRaRWjaGpBcW56bnKBoV5xYm5xaV66XnJ+7iZG
	cDxoBe1gXLb+r94hRiYOxkOMEhzMSiK84TI3U4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzKud0
	pggJpCeWpGanphakFsFkmTg4pRqYeE9uzHNmOtiarqywqzLmUOaVaYzvXuhPzF3VUlMfbVaY
	eDTEsLPvjVSYjOfU61euZRzxUDGOPunUsyFTx2/rbNvq2X0z7gWoTI7cPPvxq0LJNssDS4yj
	8np7U+v+L91a5sB/tvB+4J/JEze/XWnw0oL5+I3rLC97mB87rpn+UfuyxqHGG17/Bd9fKnmf
	kz138rMXYWWrn5XXvIz9KiT385LWqWch3fkCG2Tfz9b6dSh9QkLCUh5l9mp3s4h/jUtmdOy9
	ZjHr5YvzBs5bknPs9H5+3fm8je+i5l7Tt7vnPus8wdvebOok/3v7/A+PZjNNf+lwksfp1uTP
	Fxs3HpTPkK6vV51w2vygoz13dadZnRJLcUaioRZzUXEiAPxFyUT2AgAA
X-CMS-MailID: 20240226040238epcas1p189fc1471befb73603d75aab855ae37ac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240226040238epcas1p189fc1471befb73603d75aab855ae37ac
References: <CGME20240226040238epcas1p189fc1471befb73603d75aab855ae37ac@epcas1p1.samsung.com>

Since relative references have been used in RELA and RELR tables,
there has been no need to know their start va and end va.
Therefore, the instructions to get virtual offset in __relocate_kernel
should be removed.

Co-developed-by: Leem ChaeHoon <infinite.run@gmail.com>
Signed-off-by: Leem ChaeHoon <infinite.run@gmail.com>
Co-developed-by: Hyongwu Kim <browoo777@gmail.com>
Signed-off-by: Hyongwu Kim <browoo777@gmail.com>
Co-developed-by: Gyeonggeon Choi <gychoi@student.42seoul.kr>
Signed-off-by: Gyeonggeon Choi <gychoi@student.42seoul.kr>
Co-developed-by: Soomin Cho <to.soomin@gmail.com>
Signed-off-by: Soomin Cho <to.soomin@gmail.com>
Co-developed-by: Daero Lee <skseofh@gmail.com>
Signed-off-by: Daero Lee <skseofh@gmail.com>
Co-developed-by: kmasta <kmasta.study@gmail.com>
Signed-off-by: kmasta <kmasta.study@gmail.com>
Signed-off-by: Seongsu Park <sgsu.park@samsung.com>
---
 arch/arm64/kernel/head.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index cab7f91949d8..90db196f7c19 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -787,8 +787,6 @@ SYM_FUNC_START_LOCAL(__relocate_kernel)
 	 */
 	adr_l	x9, __rela_start
 	adr_l	x10, __rela_end
-	mov_q	x11, KIMAGE_VADDR		// default virtual offset
-	add	x11, x11, x23			// actual virtual offset
 
 0:	cmp	x9, x10
 	b.hs	1f
-- 
2.34.1


