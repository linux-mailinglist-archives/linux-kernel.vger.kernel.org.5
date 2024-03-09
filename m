Return-Path: <linux-kernel+bounces-97800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF1B876FA8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C8D1F2190A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 08:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675633717B;
	Sat,  9 Mar 2024 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ePZulBAo"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890FD2C6A9
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709971333; cv=none; b=EsLVL28LLt6Cd0c8Dn2zXDqayndLA+awniq+e3OwHzmNr70L3xIIftfuuudwbBa2Vb1KxqJxRMtpcuXaSu4KbkYjQazBpiw/Dghhi7eutLI6M+pBCIenF3hgPfoKVUus/JaUBDcgIv2HRBJkD1svAZH3rNUrLXSRTbBPXb/2hbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709971333; c=relaxed/simple;
	bh=ONR25plKwc8F4QQjteikUYxTn8xZ48iS+AvAl7Lze7g=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=ftzA79kE+cHunbmt6MwQIJDuUgshHhx4+d/YOH8vvHzgYsKXyY08BeU+Eiz3Wq6PFlkV8SJoTGNe/Yo3O0ORdtcrocAIRaP2xFs5cdNLVQUHfqMTcYuh33dJjMo/yLpORz0rHY7M0/eIYaluIA1uwlwaeeckupGigWxYz1Ro274=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ePZulBAo; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709971020; bh=MgdYsqpogfEC4dYs/sinBQ9e0RstZ+X/AARjVyBi1JM=;
	h=From:To:Cc:Subject:Date;
	b=ePZulBAoAyWrXiNB7b+6u6WgnLF6h58HdHEeV5+ntoAb4Vax3aw9bMCvEUxSdQ+/V
	 oN85RkMnralfZBe/kZFQsGYnEn2E3xQOV1LzB6194wUFEWK90IxqvnTHy8do3IPiNf
	 0UEYxESilPKaBKpv13tztRCh2rfal0Z9XXksrnMQ=
Received: from localhost.localdomain ([58.213.8.163])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id E3907482; Sat, 09 Mar 2024 15:56:57 +0800
X-QQ-mid: xmsmtpt1709971017tf0kf6ubj
Message-ID: <tencent_60DA4643DAB0341D8320190AC0A403636807@qq.com>
X-QQ-XMAILINFO: MIAHdi1iQo+zZ0BjCihli4BE3n5peZ8ehZdgt+CX+t6VAX7Vg4DYl3oLjf9ily
	 cxzVXzLazy0ntdTUjO3IosXsJPIv8Lp8GHaaXRi8Wv5sa12GdzfOF16WV75+bASzw0mCA0XH3MfI
	 whHosZOMB/RNG6n7bEk/SjQzq4NyoQ1ub0wuEW4hm0RECzeSv3RcDmI6vcapP1zJvo3qBsdZb7DG
	 lOFakRUUn8bSxepyq7BKDYDTY2cQKE2eWoeW67QlMtc93Vdt6GdY257/kGeFj6lOuPFK/tbYaRk3
	 /dF3DUXG2aj3vDoRnpwW0RfRZ2XqeTgZa25L1g40nvZNRZOEoTEyeoGY0WM/hOzjGeP/M4LMZ8oG
	 3dTa7Q4i5ElDBsNo3JVKcomIX/3GSZ+PsDIoQ7dR6xOr78IMPoQ5ZdwnSMIZ9qG34W05uBEihnBl
	 okU0zy8PMrVuXUUY/yULRmJdN9UPu+C399H1rR7/bYDmM9CdXdVqDpn7Zs1aPvIeTWC6ldTGoo7A
	 jdbYjW80j79dfT/XiBUiNjPXWznOE241ihSj9Mgxu/f8yiVAYj3v5fLzsMIr6cuPE45gG9ESf+UL
	 QDkqY5ntkHc2Ab1vhlNePtfgoJtCmHDOcrA+VlM2szfR1uUzakfJ0V5l4GJYybtZRa8eHDPz1E9G
	 nAkine/urV8nIBjNAg/95ItzcBi9ImZpCcF+0jnYYrDeC0MVXLiJm9ZnJds3kIb4XQrJlewGEwt7
	 SiWMEldGn3LsT+zuipKk0ZLeE99c//WiAWQpborqHpm0X43E1TQSWXrtTA2f232YY5FR2P2S4Rtf
	 V6Nmlo9usZJkZBOEKFHFMTyl1E4euuIj2Rc6r1GClJvaGSaFxVVOWcJ4kwLcKKKwlNwak6eiWKbF
	 995H7SDjf5aUnoXcd2Dg1Gra3IRNJ0flZK3C4PQftf5bMJdAi2Mp7vRzHSnE1Ba89Ujlnqk2uNN5
	 UEMgzhTIx3Ae9xLkl62rI4M12AcgLKnianHdYulybaA9ydK9yq4m0QitR69fZoIhkST04cGX0/WN
	 9cNUdtjPWBnQiHRD2dizb8qUUTUA4=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: linke li <lilinke99@qq.com>
To: 
Cc: lilinke99@qq.com,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/slub: mark racy accesses on slab->slabs
Date: Sat,  9 Mar 2024 15:48:56 +0800
X-OQ-MSGID: <20240309074856.49648-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reads of slab->slabs are racy because it may be changed by 
put_cpu_partial concurrently. And in slabs_cpu_partial_show ->slabs is
only used for output. Data-racy reads from shared variables that are used
only for diagnostic purposes should typically use data_race(), since it 
is normally not a problem if the values are off by a little.

This patch is aimed at reducing the number of benign races reported by 
KCSAN in order to focus future debugging effort on harmful races.

Signed-off-by: linke li <lilinke99@qq.com>
---
 mm/slub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 2ef88bbf56a3..7b20591e7f8a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6257,7 +6257,7 @@ static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
 		slab = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
 
 		if (slab)
-			slabs += slab->slabs;
+			slabs += data_race(slab->slabs);
 	}
 #endif
 
@@ -6271,7 +6271,7 @@ static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
 
 		slab = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
 		if (slab) {
-			slabs = READ_ONCE(slab->slabs);
+			slabs = data_race(slab->slabs);
 			objects = (slabs * oo_objects(s->oo)) / 2;
 			len += sysfs_emit_at(buf, len, " C%d=%d(%d)",
 					     cpu, objects, slabs);
-- 
2.39.3 (Apple Git-146)


