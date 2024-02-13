Return-Path: <linux-kernel+bounces-63153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EC4852BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B731F24ACF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD321B598;
	Tue, 13 Feb 2024 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J4PRARsI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6AA21100;
	Tue, 13 Feb 2024 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814192; cv=none; b=mK+7/rwWbdC8RM/HsHVot2SFdXVhq5u2+C0g80FPjfitSJM1YD1uODMQbJrxikfz8E7cNimb4dyl56RiBrYYb+7ySbHHwu3XMYOoGU+eWFksXsAqp8zubtuovCV2oE9OgP0dIdvHwhkv7cVbpJg4F3nvWjDy3h8Lczw5GBQ/sN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814192; c=relaxed/simple;
	bh=tTbz1v8fkqJ0/mdCR+W3RMbnx2wr06DJUcVEFdBv1ps=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a+AYEI/7dtP5YPt+j6UdPv/4bERy2+oTPcObsIgVCxWpTTQdsENwd1UuClk0qJxsrmrJpf96r/LKgAvZ9UIuXxzR2atIOncMJjcyQAHWakX6FFzLlFWV0fhYCZ+iCIHX0zdovGNMtx+fSZIFlnHB2tBSyuzKYFZS9k9tYBalc5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J4PRARsI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D8cnAc008573;
	Tue, 13 Feb 2024 08:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=kCqPcNo+Xt7o8GNLYwi+lrAM4HO++yNt6oCLnibGDyU=; b=J4
	PRARsIiBU0uSwPXNo9MzzZTLdpMFUc80Quj0xAZWuHpmA2xWf8PQ611M6s5y1AET
	8vtI2NmwbVSmmyPVcmaizRIt7JB3Qn7b7D4GEcGsn3PyxghmD7BGXYSzCzKKJb0Q
	GxG4FSdIUyGBcq+lqKzLb03y0FqWFFDf8AXkwS20qcvQqS2XvAol9dvVa7DnFyVI
	awHrfnT5EVbhA+iQiWmVU0fEUXy9p0eS6uR9xugX2op34+KzpqUjwq3luh6VS18W
	hbeuFaJGVVD3e/WhsuhpMkQKHgQ8olofO01OcRU2z3OwXXJAON3Bi0vVgxEZ3gDm
	ARyciOG6jigP0TDjOFxw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7s3919c2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 08:49:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D8nY1Z026901
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 08:49:34 GMT
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 13 Feb 2024 00:49:30 -0800
From: Charan Teja Kalla <quic_charante@quicinc.com>
To: <gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <david@redhat.com>, <surenb@google.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla
	<quic_charante@quicinc.com>,
        # see patch description <stable@vger.kernel.org>
Subject: [PATCH] mm/huge_memory: fix swap entry values of tail pages of THP
Date: Tue, 13 Feb 2024 14:18:10 +0530
Message-ID: <1707814102-22682-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ExtM5oF4G8N0zHAvaPk-MHkzrH5KQYU0
X-Proofpoint-GUID: ExtM5oF4G8N0zHAvaPk-MHkzrH5KQYU0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402130068

An anon THP page is first added to swap cache before reclaiming it.
Initially, each tail page contains the proper swap entry value(stored in
->private field) which is filled from add_to_swap_cache(). After
migrating the THP page sitting on the swap cache, only the swap entry of
the head page is filled(see folio_migrate_mapping()).

Now when this page is tried to split(one case is when this page is again
migrated, see migrate_pages()->try_split_thp()), the tail pages
->private is not stored with proper swap entry values.  When this tail
page is now try to be freed, as part of it delete_from_swap_cache() is
called which operates on the wrong swap cache index and eventually
replaces the wrong swap cache index with shadow/NULL value, frees the
page.

This leads to the state with a swap cache containing the freed page.
This issue can manifest in many forms and the most common thing observed
is the rcu stall during the swapin (see mapping_get_entry()).

On the recent kernels, this issues is indirectly getting fixed with the
series[1], to be specific[2].

When tried to back port this series, it is observed many merge
conflicts and also seems dependent on many other changes. As backporting
to LTS branches is not a trivial one, the similar change from [2] is
picked as a fix.

[1] https://lore.kernel.org/all/20230821160849.531668-1-david@redhat.com/
[2] https://lore.kernel.org/all/20230821160849.531668-5-david@redhat.com/

Closes: https://lore.kernel.org/linux-mm/69cb784f-578d-ded1-cd9f-c6db04696336@quicinc.com/
Fixes: 3417013e0d18 ("mm/migrate: Add folio_migrate_mapping()")
Cc: <stable@vger.kernel.org> # see patch description, applicable to <=6.1
Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
 mm/huge_memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5957794..cc5273f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2477,6 +2477,8 @@ static void __split_huge_page_tail(struct page *head, int tail,
 	if (!folio_test_swapcache(page_folio(head))) {
 		VM_WARN_ON_ONCE_PAGE(page_tail->private != 0, page_tail);
 		page_tail->private = 0;
+	} else {
+		set_page_private(page_tail, (unsigned long)head->private + tail);
 	}
 
 	/* Page flags must be visible before we make the page non-compound. */
-- 
2.7.4


