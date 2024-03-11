Return-Path: <linux-kernel+bounces-99038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FA78782A7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2391F24F9A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696EA40C09;
	Mon, 11 Mar 2024 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="azBS6ah4"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20DA3FB9D;
	Mon, 11 Mar 2024 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169353; cv=none; b=uTfjUjZ/vt4HiOY8pkjRHN9ZBkdK6t3cWCG42UVpCYKQWldf00zvHHc/++9q63SuHKzWGLdZocdTOQ3EkevZThEjSFf5IdtVpWvvPdyWzPShTrabHKWHuxLvOMO9PJN+ti+yM0E6CczL3IiX99rX3iakPh4+muLesHM2xegOHZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169353; c=relaxed/simple;
	bh=0d1h+66LiZBG4l7r4vzhI6g9+f3v9VLhHMPpwzwCB1o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s66FxJnryOv9m+W2fQhe7hLlPi6o+ffIp6gbOtjdzR2fwFwwHWadjffdJK8WcZAJ6bMJXYgsGvXDG/DmV2jhSLPbf0pU7s5dlQTAqFjM0FCCowFtDFrvWWFPJWP22bO/vma6muYOB4kz8BhnxG5IYJL/ENJlDhfbh0T+vIWq1aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=azBS6ah4; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BExtWO007122;
	Mon, 11 Mar 2024 15:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=w/vL4sracDDYC8rXycaL7lPs9isu/fY8uteFKSY6cBI=;
 b=azBS6ah4c2A62JuJ1hLEBxoWbAUvV/KdNh/9xEDGXurYC5Myvgb42D21hAsVaFRMbKhH
 7ZURIGEdigpD6y/s529MqmEY8wk62MbI/vrhcZG1ZjbGpbQg+XNDveneQS8hlWoPmdQG
 karOwytWQJuTM2rLU7jqxmfL6rhCq875eKOZhKE7VieWtmVxF8CX9God1l3lsdfixq8w
 vUGbasHbSCZtbW5Sr9Fj08ZUtFcU5YvS9qEtPuaFU3bFkeziK17SLODk8Rq/PzL8J1RB
 kIX/vXQtEU50c/DrDEAPkMFk56oPUFU08eeHHiVJiJbyviET2EghgWFS6JVHJOt6UziR iQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wre6ebhh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 15:02:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42BENe4T005252;
	Mon, 11 Mar 2024 15:02:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre75ykya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 15:02:19 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42BF2I3L000311;
	Mon, 11 Mar 2024 15:02:18 GMT
Received: from t460-2.nl.oracle.com (dhcp-10-175-49-173.vpn.oracle.com [10.175.49.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3wre75ykvn-1;
	Mon, 11 Mar 2024 15:02:18 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Jonathan Corbet <corbet@lwn.net>, cve@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        security@kernel.org, Vegard Nossum <vegard.nossum@oracle.com>
Subject: [RFC PATCH 1/2] docs: automarkup: linkify CVSS: strings
Date: Mon, 11 Mar 2024 16:00:53 +0100
Message-Id: <20240311150054.2945210-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110113
X-Proofpoint-GUID: J-vTCBCe52pbfRHix-D-QdTHimg_w6ft
X-Proofpoint-ORIG-GUID: J-vTCBCe52pbfRHix-D-QdTHimg_w6ft

CVSS vectors encode the results of a vulnerability analysis.

When encountered in the documentation, create links to first.org which
can be used to explain and explore the various vector components and
their values.

Example:

- https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:L/AC:H/PR:N/UI:N/S:U/C:N/I:L/A:L/E:U/MPR:L

FIRST is the Forum of Incident Response and Security Teams, founded
in 1990, and is partnered and supported by many well-known organizations.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/sphinx/automarkup.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/automarkup.py
index a413f8dd5115..8cf95a404bc8 100644
--- a/Documentation/sphinx/automarkup.py
+++ b/Documentation/sphinx/automarkup.py
@@ -76,6 +76,11 @@ c_namespace = ''
 RE_git = re.compile(r'commit\s+(?P<rev>[0-9a-f]{12,40})(?:\s+\(".*?"\))?',
     flags=re.IGNORECASE | re.DOTALL)
 
+#
+# CVSS score vectors
+#
+RE_cvss = re.compile(r'CVSS:(?P<ver>[0-9\.]+)(/[A-Z-]{1,3}:[A-Z])+')
+
 def markup_refs(docname, app, node):
     t = node.astext()
     done = 0
@@ -93,7 +98,8 @@ def markup_refs(docname, app, node):
                            RE_union: markup_c_ref,
                            RE_enum: markup_c_ref,
                            RE_typedef: markup_c_ref,
-                           RE_git: markup_git}
+                           RE_git: markup_git,
+                           RE_cvss: markup_cvss}
 
     if sphinx.version_info[0] >= 3:
         markup_func = markup_func_sphinx3
@@ -290,6 +296,12 @@ def markup_git(docname, app, match):
     return nodes.reference('', nodes.Text(text),
         refuri=f'https://git.kernel.org/torvalds/c/{rev}')
 
+def markup_cvss(docname, app, match):
+    text = match.group(0)
+    ver = match.group('ver')
+    return nodes.reference('', nodes.Text(text),
+        refuri=f'https://www.first.org/cvss/calculator/{ver}#{text}')
+
 def auto_markup(app, doctree, name):
     global c_namespace
     c_namespace = get_c_namespace(app, name)
-- 
2.34.1


