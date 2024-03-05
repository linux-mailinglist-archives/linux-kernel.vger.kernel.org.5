Return-Path: <linux-kernel+bounces-91700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB3C87155C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5281728101E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C6262143;
	Tue,  5 Mar 2024 05:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NVqAOJDY"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152D8AD5E;
	Tue,  5 Mar 2024 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709617696; cv=none; b=PzFhQUFUakZnQDsLSoV0J871O/V6EtS7r4d4Qkd6PgTkw5e1avGN88SdTW4OAXSx2QE5lSXhhS30aiDeyC0JwdMYmr78cEzH/Ok4YoeGo31ILGqsFSxf7VEVeHVkD0tZdY0wlOTGbpO4V0Y7lp8suSyj7lsL4/a0Ute43/2osHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709617696; c=relaxed/simple;
	bh=fAkvfoJdCmBA/dOW+GxOkuZlb2R5x+NWMQ8XkkvwPBE=;
	h=Content-Type:Subject:From:In-Reply-To:Date:Cc:Message-Id:
	 References:To:MIME-Version; b=eaTZxxptBBD015SRHFVSEdFq5uc6f43rXP71Q2WPapEGsDrAsk5sfjLOOkxVadIuvsVTxoZEKmZiiH+ckUdFiLXpiwbHvTVOpvbUlhHomKCeJ+GoCrF09O4/xnt+EG7RPQqaFkKv5BIy6KBZJZtwqcjWaJmosBzBymc7dt9rz5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NVqAOJDY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4255ZVLG019594;
	Tue, 5 Mar 2024 05:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type : subject :
 from : in-reply-to : date : cc : message-id : references : to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=KklhlwyuVBeNesq5FVkCo2afhv7RjYPRwek10Wa6HP4=;
 b=NVqAOJDYTAQiL/Og+Dq5jGEbNRINP+FB5OdtM4oiAb/gcG+ZRAaNiPbDBsI7vCPsIrfW
 RzjG3zYm/xxXRaqj5rXcHOUMBLKq7s3nhqS3QnG06ZNf/4NvHQNyibp9bcgow0b8IMgN
 Kw71r5Q+3+sicnxCP9e6yXYG23pKstmRnKlXI72+SNXAsO+pYohmhzTikmkXoEhPRkm5
 vzAWB4Wv/raexenYGx6W0754CSbPD5UNkIW0DMnaREPT3Qz1hI8El5oxBnQlJaKAkC9A
 srJbsC7lFW4SQjgar8A1Efq1dwt2rRUsjH9lDDL03zxZGOP0Hp/0O82AVWJUtyaW2reZ 6w== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wnvyb8vds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 05:48:07 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4254S2Tb026251;
	Tue, 5 Mar 2024 05:48:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfennh0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 05:48:06 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4255m2wT9700006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Mar 2024 05:48:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89F9720040;
	Tue,  5 Mar 2024 05:48:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1DD72005A;
	Tue,  5 Mar 2024 05:48:00 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.110.47])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Mar 2024 05:48:00 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Subject: Re: [PATCH] tracing: Remove precision vsnprintf() check from print
 event
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <20240304174341.2a561d9f@gandalf.local.home>
Date: Tue, 5 Mar 2024 11:17:49 +0530
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Message-Id: <C6A44F79-8A0A-496C-82D2-2214BCC34C62@linux.ibm.com>
References: <20240304174341.2a561d9f@gandalf.local.home>
To: Steven Rostedt <rostedt@goodmis.org>
X-Mailer: Apple Mail (2.3774.400.31)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6v3BOyvB_pPa_8F5sr7aqSjU2BITv7tW
X-Proofpoint-GUID: 6v3BOyvB_pPa_8F5sr7aqSjU2BITv7tW
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_03,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050043



> On 05-Mar-2024, at 4:13=E2=80=AFAM, Steven Rostedt <rostedt@goodmis.org> =
wrote:
>=20
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>=20
> This reverts 60be76eeabb3d ("tracing: Add size check when printing
> trace_marker output"). The only reason the precision check was added
> was because of a bug that miscalculated the write size of the string into
> the ring buffer and it truncated it removing the terminating nul byte. On
> reading the trace it crashed the kernel. But this was due to the bug in
> the code that happened during development and should never happen in
> practice. If anything, the precision can hide bugs where the string in the
> ring buffer isn't nul terminated and it will not be checked.
>=20
> Link: https://lore.kernel.org/all/C7E7AF1A-D30F-4D18-B8E5-AF1EF58004F5@li=
nux.ibm.com/
> Link: https://lore.kernel.org/linux-trace-kernel/20240227125706.04279ac2@=
gandalf.local.home
> Link: https://lore.kernel.org/all/20240302111244.3a1674be@gandalf.local.h=
ome/
>=20
> Reported-by: Sachin Sant <sachinp@linux.ibm.com>
> Fixes: 60be76eeabb3d ("tracing: Add size check when printing trace_marker=
 output")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---

This fixes the reported problem for me.

All the ftrace selftests complete without any fails.
# of passed:  121
# of failed:  0
# of unresolved:  6
# of untested:  0
# of unsupported:  7
# of xfailed:  1
# of undefined(test bug):  0

Tested-by: Sachin Sant <sachinp@linux.ibm.com>


=E2=80=94 Sachin

