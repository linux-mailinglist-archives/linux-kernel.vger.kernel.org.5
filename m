Return-Path: <linux-kernel+bounces-81002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3318B866F0B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B78E0B23E73
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FAA7993C;
	Mon, 26 Feb 2024 09:04:27 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AFD79935
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938266; cv=none; b=XtQ+POxRD04SL7UewkuI6aU9oWeVOO5Cd0tXCMjC4h0Z7eOPKz9Q4+SV3JenJpAlcPHz7fly9Sqykx8zmEZJFLeb1lcHvrUFmmGPvwchNve5I+Bhp5TH26dcQRBmj1a3K9x4nMjx9M/PYUYN6MWiEpjUCB0FRMoujbDnNlBZDR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938266; c=relaxed/simple;
	bh=kjoOBO5dV83WE6D/m1dPB4O07n3XvBLpXsn6foUCW+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hbelt3NrFaq/p06W1dYAm9KoxSIYQzbZryrNnxTBKP37yKPUzNYudLxTK6ea1uKdYCNpsuDnu/zm2r8dT32KRX2zwYEzpVFQMN0VBVjIOuMWIRhBpY/c8W7ECec9zsFfPLTnXTD+frswpDXH042Sbc3yW8kjBgrodkI8eAQiac4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d61e572074a642ad8fb0589f8f636a01-20240226
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:ce398543-a259-4799-9710-7a6001f2deec,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.37,REQID:ce398543-a259-4799-9710-7a6001f2deec,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:9790d280-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240226170419I9TKTXCE,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: d61e572074a642ad8fb0589f8f636a01-20240226
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2107915134; Mon, 26 Feb 2024 17:04:16 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 4ACDBE000EBC;
	Mon, 26 Feb 2024 17:04:16 +0800 (CST)
X-ns-mid: postfix-65DC540F-955139647
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id B891DE000EBC;
	Mon, 26 Feb 2024 17:04:12 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com
Cc: linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] x86/mm/pat: fix kernel-doc warning
Date: Mon, 26 Feb 2024 17:04:11 +0800
Message-Id: <20240226090411.1925770-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix kernel-doc warning in memtype.c:
arch/x86/mm/pat/memtype.c:710: warning: Function parameter or struct memb=
er 'pfn' not described in 'pat_pfn_immune_to_uc_mtrr'

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 arch/x86/mm/pat/memtype.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 0904d7e8e126..77c86a575268 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -700,6 +700,7 @@ static enum page_cache_mode lookup_memtype(u64 paddr)
 /**
  * pat_pfn_immune_to_uc_mtrr - Check whether the PAT memory type
  * of @pfn cannot be overridden by UC MTRR memory type.
+ * @pfn:  the page frame number to check
  *
  * Only to be called when PAT is enabled.
  *
--=20
2.39.2


