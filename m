Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC147D9702
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345763AbjJ0Lyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345637AbjJ0Lyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:54:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D56BC0;
        Fri, 27 Oct 2023 04:54:32 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39R5iFkg022018;
        Fri, 27 Oct 2023 11:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=QyEYbupriJ0rTzNbJLpDUuAoPidOl8BkFZUAEVbQn6o=;
 b=WVgr0X3kNQuWtxhxW1LbXnfelrWCb27kF0ncnzz+LI5co8rGMEANzZRX98hvhGsxtGF6
 TM8NmipKwLV7/WH0LhzOJJsiHTn6PqtbL8beCTeZdWaqo10wYBAfw9YnUMt8UhplbCiA
 YZWSehpIIHHcT2TN/FRh55bcoLTWPmE36uwvIj3ImoHCivK1aDKGlnNdcIdeuqEqRMMw
 Nax9yLsnkGFfB32l3dXEbEiyZuCxb6jJ6aSUxiasLLbtFK3kIX7SVKUEqFv42c4b2xZZ
 09+v6Va1deBZMx7jcsXb+JMaKP1OFwDMc7ffTYMTV9e61Fit/gw8O6AE1fV+9vOehA/C IA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyx3nh969-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 11:54:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39RAvWim025894;
        Fri, 27 Oct 2023 11:54:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqm53sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 11:54:30 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39RBpxoG040386;
        Fri, 27 Oct 2023 11:54:29 GMT
Received: from t460-2.nl.oracle.com (dhcp-10-175-58-39.vpn.oracle.com [10.175.58.39])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tywqm53r6-1;
        Fri, 27 Oct 2023 11:54:29 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH RFC] docs: automarkup: linkify git revs
Date:   Fri, 27 Oct 2023 13:54:20 +0200
Message-Id: <20231027115420.205279-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_09,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310270103
X-Proofpoint-ORIG-GUID: laQ4hBS6JZJxmfEKg0PHk1id2K5tdLbc
X-Proofpoint-GUID: laQ4hBS6JZJxmfEKg0PHk1id2K5tdLbc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There aren't a ton of references to commits in the documentation, but
they do exist, and we can use automarkup to linkify them to make them
easier to follow.

Use something like this to find references to commits:

  git grep -P 'commit.*[0-9a-f]{8,}' Documentation/

Also fix a few of these to standardize on the exact format that is
already used in changelogs.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/arch/x86/boot.rst           |  2 +-
 Documentation/bpf/btf.rst                 |  6 ++----
 Documentation/doc-guide/sphinx.rst        |  9 +++++++++
 Documentation/livepatch/callbacks.rst     |  4 ++--
 Documentation/networking/snmp_counter.rst | 16 ++++++----------
 Documentation/sphinx/automarkup.py        | 20 +++++++++++++++++++-
 6 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
index f5d2f2414de8..04376280e58f 100644
--- a/Documentation/arch/x86/boot.rst
+++ b/Documentation/arch/x86/boot.rst
@@ -71,7 +71,7 @@ Protocol 2.13	(Kernel 3.14) Support 32- and 64-bit flags being set in
 
 Protocol 2.14	BURNT BY INCORRECT COMMIT
                 ae7e1238e68f2a472a125673ab506d49158c1889
-		(x86/boot: Add ACPI RSDP address to setup_header)
+		("x86/boot: Add ACPI RSDP address to setup_header")
 		DO NOT USE!!! ASSUME SAME AS 2.13.
 
 Protocol 2.15	(Kernel 5.5) Added the kernel_info and kernel_info.setup_type_max.
diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index e43c2fdafcd7..257a7e1cdf5d 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -272,10 +272,8 @@ In this case, if the base type is an int type, it must be a regular int type:
   * ``BTF_INT_OFFSET()`` must be 0.
   * ``BTF_INT_BITS()`` must be equal to ``{1,2,4,8,16} * 8``.
 
-The following kernel patch introduced ``kind_flag`` and explained why both
-modes exist:
-
-  https://github.com/torvalds/linux/commit/9d5f9f701b1891466fb3dbb1806ad97716f95cc3#diff-fa650a64fdd3968396883d2fe8215ff3
+Commit 9d5f9f701b18 introduced ``kind_flag`` and explains why both modes
+exist.
 
 2.2.6 BTF_KIND_ENUM
 ~~~~~~~~~~~~~~~~~~~
diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index cd8ad7904491..bb7971643fcf 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -435,6 +435,15 @@ path.
 For information on cross-referencing to kernel-doc functions or types, see
 Documentation/doc-guide/kernel-doc.rst.
 
+Referencing commits
+~~~~~~~~~~~~~~~~~~~
+
+References to git commits are automatically hyperlinked given that they are
+written in one of these formats::
+
+    commit 72bf4f1767f0
+    commit 72bf4f1767f0 ("net: do not leave an empty skb in write queue")
+
 .. _sphinx_kfigure:
 
 Figures & Images
diff --git a/Documentation/livepatch/callbacks.rst b/Documentation/livepatch/callbacks.rst
index 470944aa8658..914445784ce4 100644
--- a/Documentation/livepatch/callbacks.rst
+++ b/Documentation/livepatch/callbacks.rst
@@ -110,7 +110,7 @@ Global data update
 ------------------
 
 A pre-patch callback can be useful to update a global variable.  For
-example, 75ff39ccc1bd ("tcp: make challenge acks less predictable")
+example, commit 75ff39ccc1bd ("tcp: make challenge acks less predictable")
 changes a global sysctl, as well as patches the tcp_send_challenge_ack()
 function.
 
@@ -126,7 +126,7 @@ Although __init and probe functions are not directly livepatch-able, it
 may be possible to implement similar updates via pre/post-patch
 callbacks.
 
-The commit ``48900cb6af42 ("virtio-net: drop NETIF_F_FRAGLIST")`` change the way that
+The commit 48900cb6af42 ("virtio-net: drop NETIF_F_FRAGLIST") change the way that
 virtnet_probe() initialized its driver's net_device features.  A
 pre/post-patch callback could iterate over all such devices, making a
 similar change to their hw_features value.  (Client functions of the
diff --git a/Documentation/networking/snmp_counter.rst b/Documentation/networking/snmp_counter.rst
index 213637474478..ff1e6a8ffe21 100644
--- a/Documentation/networking/snmp_counter.rst
+++ b/Documentation/networking/snmp_counter.rst
@@ -313,7 +313,7 @@ https://lwn.net/Articles/576263/
 
 * TcpExtTCPOrigDataSent
 
-This counter is explained by `kernel commit f19c29e3e391`_, I pasted the
+This counter is explained by kernel commit f19c29e3e391, I pasted the
 explanation below::
 
   TCPOrigDataSent: number of outgoing packets with original data (excluding
@@ -323,7 +323,7 @@ explanation below::
 
 * TCPSynRetrans
 
-This counter is explained by `kernel commit f19c29e3e391`_, I pasted the
+This counter is explained by kernel commit f19c29e3e391, I pasted the
 explanation below::
 
   TCPSynRetrans: number of SYN and SYN/ACK retransmits to break down
@@ -331,14 +331,12 @@ explanation below::
 
 * TCPFastOpenActiveFail
 
-This counter is explained by `kernel commit f19c29e3e391`_, I pasted the
+This counter is explained by kernel commit f19c29e3e391, I pasted the
 explanation below::
 
   TCPFastOpenActiveFail: Fast Open attempts (SYN/data) failed because
   the remote does not accept it or the attempts timed out.
 
-.. _kernel commit f19c29e3e391: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f19c29e3e391a66a273e9afebaf01917245148cd
-
 * TcpExtListenOverflows and TcpExtListenDrops
 
 When kernel receives a SYN from a client, and if the TCP accept queue
@@ -698,11 +696,9 @@ number of the SACK block. For more details, please refer the comment
 of the function tcp_is_sackblock_valid in the kernel source code. A
 SACK option could have up to 4 blocks, they are checked
 individually. E.g., if 3 blocks of a SACk is invalid, the
-corresponding counter would be updated 3 times. The comment of the
-`Add counters for discarded SACK blocks`_ patch has additional
-explanation:
-
-.. _Add counters for discarded SACK blocks: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=18f02545a9a16c9a89778b91a162ad16d510bb32
+corresponding counter would be updated 3 times. The comment of commit
+18f02545a9a1 ("[TCP] MIB: Add counters for discarded SACK blocks")
+has additional explanation:
 
 * TcpExtTCPSACKDiscard
 
diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/automarkup.py
index 06b34740bf90..acc6d55718bd 100644
--- a/Documentation/sphinx/automarkup.py
+++ b/Documentation/sphinx/automarkup.py
@@ -74,6 +74,12 @@ Skipfuncs = [ 'open', 'close', 'read', 'write', 'fcntl', 'mmap',
 
 c_namespace = ''
 
+#
+# Detect references to commits.
+#
+RE_git = re.compile(r'commit\s+(?P<rev>[0-9a-f]{12,40})(?:\s+\(".*?"\))?',
+    flags=re.IGNORECASE | re.DOTALL)
+
 def markup_refs(docname, app, node):
     t = node.astext()
     done = 0
@@ -90,7 +96,8 @@ def markup_refs(docname, app, node):
                            RE_struct: markup_c_ref,
                            RE_union: markup_c_ref,
                            RE_enum: markup_c_ref,
-                           RE_typedef: markup_c_ref}
+                           RE_typedef: markup_c_ref,
+                           RE_git: markup_git}
 
     if sphinx.version_info[0] >= 3:
         markup_func = markup_func_sphinx3
@@ -276,6 +283,17 @@ def get_c_namespace(app, docname):
                 return match.group(1)
     return ''
 
+def markup_git(docname, app, match):
+    # While we could probably assume that we are running in a git
+    # repository, we can't know for sure, so let's just mechanically
+    # turn them into git.kernel.org links without checking their
+    # validity. (Maybe we can do something in the future to warn about
+    # these references if this is explicitly requested.)
+    text = match.group(0)
+    rev = match.group('rev')
+    return nodes.reference('', nodes.Text(text),
+        refuri=f'https://git.kernel.org/torvalds/c/{rev}')
+
 def auto_markup(app, doctree, name):
     global c_namespace
     c_namespace = get_c_namespace(app, name)
-- 
2.34.1

