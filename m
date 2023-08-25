Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B42378851E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbjHYKkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236919AbjHYKkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:40:49 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF78E67;
        Fri, 25 Aug 2023 03:40:46 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37P3YDUR025426;
        Fri, 25 Aug 2023 03:40:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=ULGo5y56IIkJmUKVD4/PVXleacDfOWY6lBq/dDiq/kM=;
 b=X0OE+EeRVzHCYWlpWifR1etrebnj54mTyCQmZY0sz0m0tdrpRgXY5FdjnXZphCiKY0WW
 TyJyg5JYcX/IBfNJW3KTbQpBJJiDAkKYIPXNnKovi8mli+FK3fDzGuAYxLfgF2+lYV+J
 wfEGTq8W6TGyB+D+aQQkQyNm7mjNQj0pZHBl3AgF7A3u9Aix3H54HX7wc5lIU/mZMeFg
 QtOSQkt9j2Ucef13bIKbes9Uhh2QSg9CRi3KnqfjgglyfVRnJ6NMiaBzhxdWhH1FldOy
 tFhWkh6Sn0KCH6tI5r6T52K/1cG2z8AyYKFU+8pW2esJBGClim4vWrsQ+BnYZ7ynGBdU hQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3spmgvs3nq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 03:40:29 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 25 Aug
 2023 03:40:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 25 Aug 2023 03:40:27 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id DFFEB3F70B7;
        Fri, 25 Aug 2023 03:40:23 -0700 (PDT)
From:   Hariprasad Kelam <hkelam@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: [net-next PatchV2 0/4] octeontx2-af: misc MAC block changes
Date:   Fri, 25 Aug 2023 16:10:18 +0530
Message-ID: <20230825104022.16288-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: w82loodIsWPj5_R9WZree4Sm2v-68rBE
X-Proofpoint-ORIG-GUID: w82loodIsWPj5_R9WZree4Sm2v-68rBE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_08,2023-08-25_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches adds recent changes added in MAC (CGX/RPM) block.

Patch1: Adds new LMAC mode supported by CN10KB silicon

Patch2: In a scenario where system boots with no cgx devices, currently
        AF driver treats this as error as a result no interfaces will work.
        This patch relaxes this check, such that non cgx mapped netdev
        devices will work.

Patch3: This patch adds required lmac validation in MAC block APIs.

Patch4: Prints error message incase, no netdev is mapped with given
        cgx,lmac pair.

Hariprasad Kelam (3):
  octeontx2-af: CN10KB: Add USGMII LMAC mode
  octeontx2-af: Add validation of lmac
  octeontx2-af: print error message incase of invalid pf mapping

Sunil Goutham (1):
  octeontx2-af: Don't treat lack of CGX interfaces as error
---
v2 * Removed patch #4 which is replacing generic error codes with driver
     specific error codes.


 drivers/net/ethernet/marvell/octeontx2/af/cgx.c     | 11 ++++++++---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h     |  1 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c |  7 ++++++-
 3 files changed, 15 insertions(+), 4 deletions(-)

--
2.17.1
