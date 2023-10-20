Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793F17D086E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 08:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345092AbjJTGYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 02:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346657AbjJTGYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 02:24:43 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55576D46;
        Thu, 19 Oct 2023 23:24:42 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39K4qx3J011300;
        Fri, 20 Oct 2023 02:24:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3tuc08jr71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 02:24:30 -0400 (EDT)
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.22/8.17.1.22) with ESMTP id 39K6Ijcb016122;
        Fri, 20 Oct 2023 02:24:29 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3tuc08jr6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 02:24:29 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 39K6OSTt034550
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Oct 2023 02:24:28 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 20 Oct 2023 02:24:27 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 20 Oct 2023 02:24:26 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 20 Oct 2023 02:24:26 -0400
Received: from debian.ad.analog.com ([10.48.65.126])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 39K6Nx9Q030648;
        Fri, 20 Oct 2023 02:24:01 -0400
From:   Ciprian Regus <ciprian.regus@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Ciprian Regus <ciprian.regus@analog.com>,
        Dell Jin <dell.jin.code@outlook.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        "Andrew Lunn" <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        <netdev@vger.kernel.org>
Subject: [net] net: ethernet: adi: adin1110: Fix uninitialized variable
Date:   Fri, 20 Oct 2023 09:20:53 +0300
Message-ID: <20231020062055.449185-1-ciprian.regus@analog.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Rpz_IqZxEPt2g0CkplaSGHuB8eXhvwAD
X-Proofpoint-ORIG-GUID: d2V22XTgghNcfe8VsbGA19C_TfI3FeOg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_04,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 malwarescore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 mlxlogscore=965 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310170000 definitions=main-2310200054
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dell Jin <dell.jin.code@outlook.com>

The spi_transfer struct has to have all it's fields initialized to 0 in
this case, since not all of them are set before starting the transfer.
Otherwise, spi_sync_transfer() will sometimes return an error.

Fixes: a526a3cc9c8d ("net: ethernet: adi: adin1110: Fix SPI transfers")
Signed-off-by: Dell Jin <dell.jin.code@outlook.com>
Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
 drivers/net/ethernet/adi/adin1110.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
index ca66b747b7c5..d7c274af6d4d 100644
--- a/drivers/net/ethernet/adi/adin1110.c
+++ b/drivers/net/ethernet/adi/adin1110.c
@@ -296,3 +296,3 @@ static int adin1110_read_fifo(struct adin1110_port_priv *port_priv)
 	u32 header_len = ADIN1110_RD_HEADER_LEN;
-	struct spi_transfer t;
+	struct spi_transfer t = {0};
 	u32 frame_size_no_fcs;
-- 
2.39.2

