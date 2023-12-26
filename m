Return-Path: <linux-kernel+bounces-11302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C594E81E44D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F5D280A70
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A086B1854;
	Tue, 26 Dec 2023 00:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pucWZtBW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B461845
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 00:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703551939; bh=zNVTMPR8z/kFky9pU8OOkjegKgtMlhMqrYKj8Xmm2oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pucWZtBWbSVsOLpJkUAzpxNgNNx2hUx02sXmMU6C0DK1T+ydQ+w90hxajgHpYSh9R
	 KeHgIL4sY7SzKWxOzb3PrEoIg4pnMhOvvNPJ5giUjtdI09xCx4mJ7ofgTathsdU95c
	 CcoBTe4KGqfr1o/EptlcKXgPFyTi6ykPFdQb4/bI=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id D1129228; Tue, 26 Dec 2023 08:52:17 +0800
X-QQ-mid: xmsmtpt1703551937turrwo329
Message-ID: <tencent_70A097B037B44AAA748F77BB66843CD73609@qq.com>
X-QQ-XMAILINFO: MPAlP4yRn0xgkaX/3HemM8n7lA7IrXKZBPBaaGtiue46N57o5UMCIskcPYN/nD
	 3nuoFpA4ArPuCfKQXkxvSMMgG0I4KdLJCA2qDndr/pokjLW18lSi0QA/O+VgljgyEzBJGO862Vp3
	 15hC8SEYAE6yY9/MzHD3GcgyUeOTCJ+5HfHGzYAGQifuVMxGwWH7K/7hEv3KbhlZXnakkPSySWfU
	 H1afueMUd85SgwNtdkeIEU+4ujed3Y/f3XdXqRH36yDvORUdRmtLlN+AVCcorirgu//V+m72jv3C
	 vTeIxHcgz4HYKNLy8O7ZypWpOk1NuWaABn9sQWoG44V8KjZpbKCYL9zSL9Zwi2gxCkn3IksEr3bB
	 8WJ3h7CT6g1hbucRdSi83sHEPYcrrJucVPydSbjHZetEhIA2Hy+Y5z04W8XKNEX7nmPYtSukr4xt
	 qKSrMGgQ+u76qmRVFzFUjR9rS4+Ox17wz5IV5So4z/NRX44eFnfaz9bCCqFCf4OR1AS/niRDc3ws
	 U1CEfA6+lNorT11ZThoEPeV2rhwaNjQzc52WEAc/gmRpmXYLNgGeljzYet5NhvJp2L82nqn+dUCC
	 C91ZfNrtXhhWDcNnUFmmdlOXSfZCpREVbESFWSG2WIRpHUbbxzKUdYGo6nLNkyqqsHsS14YEZ3qV
	 CYNNzTTAPXNDrlfx+tw8H3pMdnSoOaDjgprybk/E/cMyfrYNKTXAL1M0wEKuYrsVU3Eg0P1ScOI1
	 oHUT9qj2+HU4Gy2UPzmamcjMVVo9hUlNo7fuGxJNA7S6NlfHoAYbxak4jb9Eq8gZ6gR2T07+F4lg
	 UYAlmTF43IIZ8qP9r9yg0YxJLg9RzlEjuR/JZl+VIeh5XwaI2tEJO5i2Wdss4yBVMvpffpGIIsL7
	 KtxNDrIUx75EDfmlJzBhGN6SUyPe2sR6f+EeJF13cz2b0XI+4/zZU76tP8T1DSTQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+07144c543a5c002c7305@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [perf?] WARNING in perf_event_open
Date: Tue, 26 Dec 2023 08:52:18 +0800
X-OQ-MSGID: <20231226005217.900978-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <00000000000048b478060d541670@google.com>
References: <00000000000048b478060d541670@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test WARNING in perf_event_open

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git 441c725ed592

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9efd0d7775e7..e71e61b46416 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1924,6 +1924,10 @@ static void perf_event__id_header_size(struct perf_event *event)
 	event->id_header_size = size;
 }
 
+#define read_for_each_sibling_event(sibling, event)		\
+	if ((event)->group_leader == (event))			\
+		list_for_each_entry((sibling), &(event)->sibling_list, sibling_list)
+
 /*
  * Check that adding an event to the group does not result in anybody
  * overflowing the 64k event limit imposed by the output buffer.
@@ -1957,7 +1961,7 @@ static bool perf_event_validate_size(struct perf_event *event)
 	if (event == group_leader)
 		return true;
 
-	for_each_sibling_event(sibling, group_leader) {
+	read_for_each_sibling_event(sibling, group_leader) {
 		if (__perf_event_read_size(sibling->attr.read_format,
 					   group_leader->nr_siblings + 1) > 16*1024)
 			return false;


