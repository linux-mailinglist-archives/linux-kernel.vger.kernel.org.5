Return-Path: <linux-kernel+bounces-158988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD58D8B27D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3111C212FB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B01414EC6D;
	Thu, 25 Apr 2024 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U2kpW9J9"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D3B14EC42
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068357; cv=none; b=iEs9ySbwqwWripTpheHWAqnks6OzRAE9N7dRwENH8q+SPndw9XBSvlxtkBgDBQ32Z94A24H9Y0o0oXXEqIO3UvpbQp1eB7KYySaALQvqCJ0WRySGv8Baj9C0r8r2ybS/QXDHkjvN6qMb2A59J64F3uo1WwDU5LG2WXLHMCxSr6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068357; c=relaxed/simple;
	bh=iWcjY0lnb4SitmVfU6xtAMMUxAI0vdUbDl7KMavrTX0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KoGRL74L/lo/zNKY+vlYDuhk3jFc8/OMjshI5ZhBjPWzfnSPBwucj/oOKuIovbslybD/tQQDOuZOk7QtfYxCdueD7tj+TD7KsYky9l2jJM4tEVoIchLWKcDZD8QfoH0bvGbw86vIoDcA1FglT3dhfXkjqz8tQlqkeIrKW+aQgss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U2kpW9J9; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43PHOYh1032479;
	Thu, 25 Apr 2024 18:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=fdE/vGy1/CsZxknVvsTTf1OdJq1AfvcRLlNzDSnRC0o=;
 b=U2kpW9J9knsSYUig3Z2YFrPye7JU6rOvi0tzh+IT/fpQoQ3cSiu8H1B9+NeJkuEYcFDR
 S8DZ3C5cdXwznYwPc3b+Kf8DGbnmoSBzrwvUrHCfCpHMr6k4NizXfkh37Ire+95ARFXt
 TGBqoUkLfTshY5d0CKMe03E91Q4A97sFNJJ21ItwjIQYYuEhucrgr30Ycjqyf7wJQxyC
 uuL9p39D2Z7vS4GOqotmC1Awn71OJu0j/FN15/l4HSYbybCbqWA3AfLEAO91YOqJmCS3
 FWneg4lrJUHfCsuC8DaZwooZyilztXRtSgHVkriTRMXB1Y3Qo/gZlhqrg99XzQcxWbFb jg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5kbvcn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 18:05:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43PH0pQj001851;
	Thu, 25 Apr 2024 18:05:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45be3ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 18:05:45 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43PI20Kd032785;
	Thu, 25 Apr 2024 18:05:44 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xm45be3wd-1;
	Thu, 25 Apr 2024 18:05:44 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, keith.lucas@oracle.com, aruna.ramakrishna@oracle.com
Subject: [PATCH v3 0/4] x86/pkeys: update PKRU to enable pkey 0 before
Date: Thu, 25 Apr 2024 18:05:38 +0000
Message-Id: <20240425180542.1042933-1-aruna.ramakrishna@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_17,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=857 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404250131
X-Proofpoint-GUID: 9qa-0M74dyWNeinQ8OLstS1wPke5gxb7
X-Proofpoint-ORIG-GUID: 9qa-0M74dyWNeinQ8OLstS1wPke5gxb7

This version incorporates feedback from Ingo Molnar and Dave Hansen,
and adds a few test cases that exercise this flow.

v3 updates:
- Split the original patch into 3:
	- function interface changes
	- helper functions
	- functional change to write pkru on sigframe
- Enable all pkeys before XSAVE - i.e. wrpkru(0), rather than assuming
that the alt sig stack is always protected by pkey 0.
- Add a few test cases in pkey_sighandler_tests.c.

I had some trouble adding these tests to
tools/testing/selftests/mm/protection_keys.c, so they're in a separate
file.

Aruna Ramakrishna (4):
  x86/pkeys: Signal handling function interface changes to accept PKRU
    as a parameter
  x86/pkeys: Add helper functions to update PKRU on sigframe
  x86/pkeys: Update PKRU to enable all pkeys before XSAVE
  selftests/mm: Add new testcases for pkeys

 arch/x86/include/asm/fpu/signal.h             |   3 +-
 arch/x86/include/asm/sighandling.h            |  10 +-
 arch/x86/kernel/fpu/signal.c                  |  45 ++-
 arch/x86/kernel/fpu/xstate.c                  |  13 +
 arch/x86/kernel/fpu/xstate.h                  |   1 +
 arch/x86/kernel/signal.c                      |  33 +-
 arch/x86/kernel/signal_32.c                   |   8 +-
 arch/x86/kernel/signal_64.c                   |   9 +-
 tools/testing/selftests/mm/Makefile           |   2 +
 tools/testing/selftests/mm/pkey-helpers.h     |  11 +-
 .../selftests/mm/pkey_sighandler_tests.c      | 315 ++++++++++++++++++
 tools/testing/selftests/mm/protection_keys.c  |  10 -
 12 files changed, 422 insertions(+), 38 deletions(-)
 create mode 100644 tools/testing/selftests/mm/pkey_sighandler_tests.c

-- 
2.39.3


