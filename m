Return-Path: <linux-kernel+bounces-52095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FF6849406
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2702847B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75528C147;
	Mon,  5 Feb 2024 06:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="epNqWGkQ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3453010A09;
	Mon,  5 Feb 2024 06:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707116042; cv=none; b=fd/Yol+rsfPhhE5VmffQ0VWg5sth6XvaWPqzyEP2Y2CbboOyJZkR4qA5gtbZbClgNGwDhHIlnLsqL2eEKCsl4wdWZPLX/UI8qhQV4bbKmNzGggatnrZd8JfQ9e5xSl/wbEnWyar2qDeHyDyLhPTRzhhPYiYuKpCED9rEKUf3woA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707116042; c=relaxed/simple;
	bh=ojRJBvyE1YzDmUrEru2rDr5tb+rS3GNKhG6Ej3QuQEE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GdRBKPcSDJ1HVNrG9lbL+K1ckoc9N37MZdbVGMqM8azPC8tc8oOqSxzLUAnms3Zi/1RdXF9NrdrBNyl3n3nS2AFRc3OGWAuM29OHCRmZv1urITwriJSIRX/vdJY6uoH7yjS7eADw1l4SXMeZF+BydziMjuBpj8f1ISuGC3LcDAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=epNqWGkQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4156W7Wo013592;
	Mon, 5 Feb 2024 06:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=dXlQaVF2Q56S/IZ+aTvQ4JSRtoaUwWTdK3pOfNh1CcA=;
 b=epNqWGkQPGB8Il+0/kMWRpe8rw3TUlgLv+VxVLE8YV7L5Y/FkVdkfEw/uriQyu8VA5Re
 MlbCN6T0GYRqA7CXC4co1qUQ4ZtXh+9PSnjXxqOL2NRpCsvc2eoNTL3lYgYmh+6VpPdD
 EnmZzxKTKfeM+hTbKQxcNUz5IURGrLmo3dGxvtlpZS4XeJyq9S1t7DLVxQnGX6lrOY7k
 XOkjBwDe7EYEqILe3RWJ5KoH2CawFjmCN31rEeEhto2LXJ7/KqohHFLW5++AYg/Esgx/
 Fp97XDUo4ZiKTKSTgar70eY6k+d6jdaWNnzUyZY2cnysiF4AEq5mpmVcnYWit1gIg47p /g== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w2tg6ref5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 06:53:54 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4154WRJX005458;
	Mon, 5 Feb 2024 06:53:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w21ak6qp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 06:53:53 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4156rpjL38339154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 06:53:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54DD420043;
	Mon,  5 Feb 2024 06:53:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44A2720040;
	Mon,  5 Feb 2024 06:53:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  5 Feb 2024 06:53:51 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 0D686E050E; Mon,  5 Feb 2024 07:53:51 +0100 (CET)
From: Sven Schnelle <svens@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mete Durlu <meted@linux.ibm.com>
Subject: [PATCH] tracing: use ring_buffer_record_is_set_on() in tracer_tracing_is_on()
Date: Mon,  5 Feb 2024 07:53:40 +0100
Message-Id: <20240205065340.2848065-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zZuRWJ8066-h3O52CdFArny3BaMnQhx-
X-Proofpoint-ORIG-GUID: zZuRWJ8066-h3O52CdFArny3BaMnQhx-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=921
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050051

tracer_tracing_is_on() checks whether record_disabled is not zero. This
checks both the record_disabled counter and the RB_BUFFER_OFF flag.
Reading the source it looks like this function should only check for
the RB_BUFFER_OFF flag. Therefore use ring_buffer_record_is_set_on().
This fixes spurious fails in the 'test for function traceon/off triggers'
test from the ftrace testsuite when the system is under load.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2a7c6fd934e9..47e221e1e720 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1532,7 +1532,7 @@ void disable_trace_on_warning(void)
 bool tracer_tracing_is_on(struct trace_array *tr)
 {
 	if (tr->array_buffer.buffer)
-		return ring_buffer_record_is_on(tr->array_buffer.buffer);
+		return ring_buffer_record_is_set_on(tr->array_buffer.buffer);
 	return !tr->buffer_disabled;
 }
 
-- 
2.40.1


