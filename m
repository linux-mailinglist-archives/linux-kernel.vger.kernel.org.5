Return-Path: <linux-kernel+bounces-414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE0C8140BF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A335F1C2230A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE6CD275;
	Fri, 15 Dec 2023 03:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="NQeTnqoL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pv50p00im-ztdg10021901.me.com (pv50p00im-ztdg10021901.me.com [17.58.6.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF39CA7A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1702611775; bh=f6UsQfJqru2wxeQHRYIGzIFx+QojRrWdAumuRT1bErQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=NQeTnqoLw0Gci5WZbfohKqJJQ/vq8zsZvyEd9kC9OLStA5wk21Ct6wwYwuiin5/D2
	 d+MoCE1/pV/vGJ4n6xj1caykQaZ+NAie4AKhSkZQkQYUInQDyzrlY8JFHlb7e0Ict6
	 YbaMSC6WJ/baGEMp1gXY+PuOhCcUh+kTKgpyTov8pJ9yle/A0q5RgnDjBuToVHQTTW
	 zV8d0+sxz7AAxqTHSWBlY06XOfuCSKze50gBa3/FP9WHn7l2irQIKexo/cq5tMt0Af
	 FbnAayyW5EBZMgsFjA8T4hF/isd1TWD5lhM/ZTql7nhBKGWRhC0a99PuqzCB9mlUJ/
	 UzosSUtnVGszw==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021901.me.com (Postfix) with ESMTPSA id 6862281320;
	Fri, 15 Dec 2023 03:42:49 +0000 (UTC)
From: sxwjean@me.com
To: vbabka@suse.cz,
	42.hyeyoo@gmail.com,
	cl@linux.com,
	linux-mm@kvack.org
Cc: penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	roman.gushchin@linux.dev,
	corbet@lwn.net,
	keescook@chromium.org,
	arnd@arndb.de,
	akpm@linux-foundation.org,
	gregkh@linuxfoundation.org,
	quic_jjohnson@quicinc.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiongwei Song <xiongwei.song@windriver.com>
Subject: [PATCH v4 1/4] Documentation: kernel-parameters: remove noaliencache
Date: Fri, 15 Dec 2023 11:41:47 +0800
Message-Id: <20231215034150.108783-2-sxwjean@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215034150.108783-1-sxwjean@me.com>
References: <20231215034150.108783-1-sxwjean@me.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lzIsUutIukHkftBK76aMj4vFZYidGvSF
X-Proofpoint-ORIG-GUID: lzIsUutIukHkftBK76aMj4vFZYidGvSF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_17,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxlogscore=816 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2312150025

From: Xiongwei Song <xiongwei.song@windriver.com>

Since slab allocator has already been removed. There is no users of
the noaliencache parameter, so let's remove it.

Suggested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
v6: Clean up typos.
v5: Collect Reviewed-by tag.
v4: Collect Reviewed-by tag.
v3: Remove the changes for slab_max_order.
v2: Add changes for removing "noaliencache".
    https://lore.kernel.org/linux-mm/20231122143603.85297-1-sxwjean@me.com/
v1: Remove slab_max_order.
    https://lore.kernel.org/linux-mm/20231120091214.150502-2-sxwjean@me.com/
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65731b060e3f..9f94baeb2f82 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3740,10 +3740,6 @@
 	no5lvl		[X86-64,RISCV] Disable 5-level paging mode. Forces
 			kernel to use 4-level paging instead.
 
-	noaliencache	[MM, NUMA, SLAB] Disables the allocation of alien
-			caches in the slab allocator.  Saves per-node memory,
-			but will impact performance.
-
 	noalign		[KNL,ARM]
 
 	noaltinstr	[S390] Disables alternative instructions patching
-- 
2.34.1


