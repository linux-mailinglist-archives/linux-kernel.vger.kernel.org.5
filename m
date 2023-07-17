Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E14755F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjGQJeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjGQJeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:34:17 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C47E1725;
        Mon, 17 Jul 2023 02:34:04 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H5TrO8020470;
        Mon, 17 Jul 2023 02:33:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=A6vb4AfiZvBPM3VMzeFbHqzbdNwya3XR1SiGD5k6Gnk=;
 b=UCxuh6ood5GryilNTUmftnSpyu2p3oR8PtnPRkXxw63/y5j/QxkxbxbD7fV07FSMJBcn
 QNP1xtj886of9YNAEw0RtfAWHa2n4lP2Eiw8cKTXcVkFLcZKOqdj9Bj9RrnOZoe0NrP+
 OLViurmeYKDwYCDJz4lNmdO5KNF+m1wJ9w0wWQfc9+exZykA1diyngxtjBCuUujecMNp
 mvUPUbWzKfjT9QnQ9Gx5k5qFQ82N6LsxakE5m92LMm2c2xmA688jZW2eIRb+DkT6w7Xa
 BAJD6Un9isVu7+c0F8g4YNzm+J95bsIW2OZiZHiGeT4eFeVAU8sjvqwN+9c9D2TktgVB mw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rvyhx0p41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 02:33:53 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 17 Jul
 2023 02:33:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 17 Jul 2023 02:33:51 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.134])
        by maili.marvell.com (Postfix) with ESMTP id 87F5F3F70A4;
        Mon, 17 Jul 2023 02:33:45 -0700 (PDT)
From:   Hariprasad Kelam <hkelam@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>,
        <willemdebruijn.kernel@gmail.com>, <andrew@lunn.ch>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <naveenm@marvell.com>, <edumazet@google.com>,
        <pabeni@redhat.com>, <jhs@mojatatu.com>,
        <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <maxtram95@gmail.com>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
Subject: [net-next Patch v3 4/4] docs: octeontx2: extend documentation for Round Robin scheduling
Date:   Mon, 17 Jul 2023 15:03:19 +0530
Message-ID: <20230717093319.26618-5-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230717093319.26618-1-hkelam@marvell.com>
References: <20230717093319.26618-1-hkelam@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: zmcuVvw3xrV44UQ9PWInUeQ82PT9qnUP
X-Proofpoint-ORIG-GUID: zmcuVvw3xrV44UQ9PWInUeQ82PT9qnUP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_07,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add example tc-htb commands for Round robin scheduling

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 .../device_drivers/ethernet/marvell/octeontx2.rst         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst b/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
index bfd233cfac35..3523e101cb53 100644
--- a/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
+++ b/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
@@ -332,3 +332,11 @@ Setup HTB offload
         # tc class add dev <interface> parent 1: classid 1:1 htb rate 10Gbit prio 1
 
         # tc class add dev <interface> parent 1: classid 1:2 htb rate 10Gbit prio 7
+
+4. Create tc classes with same priorities and different quantum::
+
+        # tc class add dev <interface> parent 1: classid 1:1 htb rate 10Gbit prio 2 quantum 409600
+
+        # tc class add dev <interface> parent 1: classid 1:2 htb rate 10Gbit prio 2 quantum 188416
+
+        # tc class add dev <interface> parent 1: classid 1:2 htb rate 10Gbit prio 2 quantum 32768
-- 
2.17.1

