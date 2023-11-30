Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A047FEA0F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344783AbjK3H7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344822AbjK3H6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:58:51 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C2010E3;
        Wed, 29 Nov 2023 23:58:51 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AU7iiqV027731;
        Wed, 29 Nov 2023 23:58:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=BnBnwUIi1lFAm060BvEP3AMsH0MfpESXX1EZeTkIRYo=;
 b=P5QGpF70wlONSZ/Ed+VY+BoYyJExHZVcZj9sGKcgl4/dgDmwoyfef5JMxAUjlLCi1+3S
 oBlYjkg6rtDWMixqWdIgxaHUWpQ6m+QSFFPlnX1f2dV6bhh78it+4/CWBT84ROc6Txmp
 /RGkZwRbQLNw0K7pkYj7dNoR91W2GVM1rXjYZxMAY38NLkjwp9tKXTSJryxzrY2zhl/Q
 XujlB0oIhk23Ru2JOXn9qC10I6+lw4mJS7Q6hiEWUhGjySAbcSqOshrtnTcgPPu2hkAN
 1K21MoVMvwFjInSjyqVrAmhuizwMN4JjHh1RuCttiypJb9kaOjjUcKUuFPj/m7SFD82P Ew== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3upc1v2j0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 23:58:45 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 29 Nov
 2023 23:58:44 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 29 Nov 2023 23:58:44 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 8A1455B6937;
        Wed, 29 Nov 2023 23:58:40 -0800 (PST)
From:   Geetha sowjanya <gakula@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <jerinj@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net v3 PATCH 5/5] octeontx2-af: Update Tx link register range
Date:   Thu, 30 Nov 2023 13:28:18 +0530
Message-ID: <20231130075818.18401-6-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231130075818.18401-1-gakula@marvell.com>
References: <20231130075818.18401-1-gakula@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: JBI1NGPbBEzD5yBTMd8Ez-jyJkUoJSPH
X-Proofpoint-ORIG-GUID: JBI1NGPbBEzD5yBTMd8Ez-jyJkUoJSPH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_05,2023-11-29_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rahul Bhansali <rbhansali@marvell.com>

On new silicons the TX channels for transmit level has increased.
This patch fixes the respective register offset range to
configure the newly added channels.

Fixes: b279bbb3314e ("octeontx2-af: NIX Tx scheduler queue config support")
Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c
index b3150f053291..d46ac29adb96 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c
@@ -31,8 +31,8 @@ static struct hw_reg_map txsch_reg_map[NIX_TXSCH_LVL_CNT] = {
 	{NIX_TXSCH_LVL_TL4, 3, 0xFFFF, {{0x0B00, 0x0B08}, {0x0B10, 0x0B18},
 			      {0x1200, 0x12E0} } },
 	{NIX_TXSCH_LVL_TL3, 4, 0xFFFF, {{0x1000, 0x10E0}, {0x1600, 0x1608},
-			      {0x1610, 0x1618}, {0x1700, 0x17B0} } },
-	{NIX_TXSCH_LVL_TL2, 2, 0xFFFF, {{0x0E00, 0x0EE0}, {0x1700, 0x17B0} } },
+			      {0x1610, 0x1618}, {0x1700, 0x17C8} } },
+	{NIX_TXSCH_LVL_TL2, 2, 0xFFFF, {{0x0E00, 0x0EE0}, {0x1700, 0x17C8} } },
 	{NIX_TXSCH_LVL_TL1, 1, 0xFFFF, {{0x0C00, 0x0D98} } },
 };
 
-- 
2.25.1

