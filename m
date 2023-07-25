Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CE97606DC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 05:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjGYDvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 23:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjGYDu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 23:50:59 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2127.outbound.protection.outlook.com [40.107.255.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC3C171E;
        Mon, 24 Jul 2023 20:50:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5CpZepo8wPiQ/mzRMU9q8tRrpfQxWzWE+gmOAPQkX/PaZkTIuuAleZzE6D8OcinEQbJR839fbg0Ipbxjf18vzk+zwr3fA0/5IgYv1iQrnGMqBMBL2AukR58j2udhncyuS4Ovt4CWCSNC2U5d42bS/x+CDRTjbtw/m5G6NBJayqLG99GPWGmS5Kyhij4QYKoOU7mhR2FenrpzrNZNgTC5KBTqonTCETOd0/GIKkO2K0U7wfg9gIA2DQejQPhZUjDquB0oCFbHQvKexu9rX43OSFTJ0duTa8ie1Xhqe3xT7YAfXm3isw+P+nocVFTVaQiEyolQsFngkqVdwIcbB2M9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6bkqRAC1TdRNN4jhacPvxhu+fLHVeq486KzpLJPkfk=;
 b=awY0YP+4pcoO5ZIc0mzycL3czw4gdY38bQpvrrFxaESPKDcudTQVdVB82I3ZXXVmZyxr/qpy8drk7VXUv9N9F3eT5GC+VgdWlAF7Z7DOd0uIVLjH4WJCCiMWxS4c9ekyU8Dw18w7ohBV2cVPrJCnf0Ffp9iSDocWtpQIrGxSi+82foRafDDlyWP7gUHqw6g99f2dv5USwIGc0SzEvXWMXr7ij+4tF5cvSsyhH92ZEcvomTwXA8K+lnmSVJW9tDE3NjPk/zJIlQ7uqxW30M8LLxMAs/h1rvqYA6oB59PUP0C/8sf4nG2eemup0hROhRqPVAtZWiQf91QZqDX3ynFSiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6bkqRAC1TdRNN4jhacPvxhu+fLHVeq486KzpLJPkfk=;
 b=Xxae/ur3Yab84TkXiYfpbGilYP3bO+mTlFZUSM5+in/MmdmQW4oAbwM6NOqc9i3CHGOfOI4a+YIluy4Bm3RijAX9RdvZZ8LchrVlxL7LCsYzKltJYStDE4chhhF8fWkPz9ZFD5zk87UMJKg+uKyZzmg9ZlxI9Q8iBlTJAx0IPfuXChwE52l7aTpEAjHhE2THCC+0rLoVaOcn+5pt+08oLzOdt1p4JN2N3JuB4O7xb0YiJ5Oo0yYKrGetohJTh9/rNrO/jGo3tv7OBFAb2KJ0JSW03OAE2T28cxiIqPHZSsQMooCWPcT42ddo39/nc3BHQusA9F2UQCd4m/436+TDTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 PUZPR06MB6223.apcprd06.prod.outlook.com (2603:1096:301:107::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Tue, 25 Jul
 2023 03:50:52 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::75ed:803d:aa0a:703f]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::75ed:803d:aa0a:703f%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 03:50:52 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-spi@vger.kernel.org (open list:FREESCALE DSPI DRIVER),
        linux-kernel@vger.kernel.org (open list),
        netdev@vger.kernel.org (open list:PTP HARDWARE CLOCK SUPPORT)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v2] spi: fsl-dspi: Use dev_err_probe() in dspi_request_dma()
Date:   Tue, 25 Jul 2023 11:50:37 +0800
Message-Id: <20230725035038.1702-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|PUZPR06MB6223:EE_
X-MS-Office365-Filtering-Correlation-Id: a17237e0-3f09-4f4a-4916-08db8cc25770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l6LvqY2nUAmVZCqwYQlqJa+SkIaFDQ969tH1ieRPiDfMYY9xkv7xI4EYkCiNMC32q4+tRnq7yTxOJ320Qz+C8t2wKb+jMncQk0G2UfjtWOzY0AwMw55luThMed2Oyey2GXG2rpFbpk2G1uhuL2D4VqrQIk9TvlBjkve9b7bvPowa0RR9BaxirPf7HtqWU9U+KblqWr1g1QvrZ4fJDK4zbSCVr8YV0+v+oqr9lICRnNYK+dsSFNZNEz+HpXMQbUHKDw07/9JxbOvv6EbseCyPd/eSgqEIOTU8ai35nqQLjbKVQ1CHQSJ7rrAbC0vg4bB/xefj786KMPpNH8VXLLg1C62CvmJ566+VHuLQ1DWbUblZvFXpV3Hrlag0lssVT/rTT0p/oRVoA69NChv+48hNcmJyYjLSg7d8U95KxAGPcS7Hlc9ho0iZpeG2suJvJzozHyL836pGupewx2jcgZrLGE5LaHfeGAdYYFMa6Mi6uSBBE0QPlQdwxxkr21IQgqDq3MeDJUyu9quP8tL1cM3iSI0OCkwsLJIxANqjXJ11esCGM+gXqNsqxmfWnDAjfiBmIsJBgQO86HkLSMo63vRcwMmCnSwoToHriykkicTLI5KzpLDl9h4Sue/EAGxqkNHJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199021)(52116002)(6486002)(6512007)(6666004)(478600001)(110136005)(186003)(2616005)(26005)(1076003)(6506007)(107886003)(2906002)(41300700001)(8676002)(5660300002)(8936002)(4326008)(316002)(66476007)(66556008)(38350700002)(66946007)(36756003)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ISMchyrGBNBoGknPlS6KrwmrjSNecwrVmEidDWjwFvZ4p+zN2C++e2qRpgy+?=
 =?us-ascii?Q?IamZji12EwdWlseJ40et/03er+E8F1+jPJQinUljtsXXO0+kaPUSZv7iPQqj?=
 =?us-ascii?Q?HXZPU3Ly8IUQzhUTgC05mAMgDkFjnqxwWNMKa7ejCvm2yURiRiOX4P9cumEJ?=
 =?us-ascii?Q?HxtVlGzkzvBCstqyzMrEeIVjv4njgfJaW8l8DSfAiRWXiLAfxh+juRy+RBnZ?=
 =?us-ascii?Q?VcYsUTu3LDWDLiVg8psJz5vQQYtdkwvnx6j0jETy7o2aSk5dKAQkv1Pjokuz?=
 =?us-ascii?Q?qOa2xMlY2JSejo2A6hLSCTJNnXRS47glAJlK/EpU2YELSYGUoQW65Xl++yE5?=
 =?us-ascii?Q?YtRKpMN31MCDlTV1UHvXE990EqUzbx8BHVqk468eM5+sqd3jO8+cpUp1Obeq?=
 =?us-ascii?Q?Ipk5i54fVajIycZVj/ly0/WQpiABqFDYuB8/JTy7ozPVmS8mgfDHGrRloxsg?=
 =?us-ascii?Q?ir3AZnTUtgd2r2w8Ww4Zy/qmkDiVVkKrsbX+KhqxWU8iJ8zZAkU7/8lJIBx/?=
 =?us-ascii?Q?TLvvl1I5c49PftO6i9JDdI9pztbLUS1U2mk3BvDkNIa5UrIeKzPhAL6ZX0ea?=
 =?us-ascii?Q?E4wexN1QU1tAixrn9F+vEkGDfScjdCtv0pJN7bvqZLGlbpsbu7cp37mPAyE6?=
 =?us-ascii?Q?NrFuyE4wCxlo3CuTRKs6dABfUmtIS9aIk7szOHXdL6xMTwAU8RtwKQDpfWT7?=
 =?us-ascii?Q?aip4IBfA+vf8aY7cJ3ujTViL9AHdiSLrMAGW30y3Qty6ZYQ73knHoXpONbKR?=
 =?us-ascii?Q?kMirpMPjq5Za6pEuGZycjsSjuzOefK/rAkgoZdy7iUDdf6hVG9FlFXoeGlRO?=
 =?us-ascii?Q?LOx7SysYfuBykrVvAD+P/dLfFshLhEIrubRdiFnHQpWXhQgLTvXtrNWO0Dp6?=
 =?us-ascii?Q?y9HrWgVtBQPsIZAUcUrTo28yxfkfAt/hVjrzGqkS7vKVLRG+NeH4DGYTJokS?=
 =?us-ascii?Q?a9iXw3nvLTc/ysCwVzHklIkJZuUf+H+eJoYwil/5v8WH5yZEJqVzf40v6SbD?=
 =?us-ascii?Q?VzDb08EyZWIztD/ut26rT7FiZBzjkDabNs3NPqpJclSSFaGoF0sFQl63QlQF?=
 =?us-ascii?Q?5TREtmQa0KVPyfrZNb7fA+EWhAzqa7gzJwfDyK0hgMSym5OADXxWLccsIUWX?=
 =?us-ascii?Q?dbQy3cDuwPVSmgYAx+rCXlD/iT/Mycz0ZWVpL6yIgvvc+K6yXqwOwdBcBe2H?=
 =?us-ascii?Q?pWLmme1ndd3U4qH+a2GDJucHLsY6WDT+Ng4QXWVVHbL6d28X+QfiG/tg8/Ll?=
 =?us-ascii?Q?kVlGnQ1O9pcQMvT/jr4Or8VfeXuWv6+G/al7dCrG2uCdnBnoIqZrmtkoWl71?=
 =?us-ascii?Q?Kz2Y5PIflFmSsaQK8gkKojkLQnb+JcQ9JQHhSSZ9f79ZySDvKVW9XBtkSjPR?=
 =?us-ascii?Q?JKVgqvUcsT2LqBYIeo7nl1ooVAUVPBvYbtwfL6TBLVLAfu/QuUzKuThl/lzC?=
 =?us-ascii?Q?V+G/cf50Qi3vS5rXRU2vHExG7R9PV8HTd0fPqtxnzzl/pdo6g5EkAymyzhQf?=
 =?us-ascii?Q?JLsAcsHm8go4mk5DWtvSGVFyo71NAwV6AwNjU3mRPDrMQc915fERyXq2T4N7?=
 =?us-ascii?Q?F+XhQ179pSlZqirWZCtFSfHQuQ+KY67+JnDflixA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17237e0-3f09-4f4a-4916-08db8cc25770
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 03:50:52.4251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hb0I6Zqs5YPnajTigQ4IQxMdee45yOW1G9rZhAWpzzkYQz9WVZ/Dgpg0BO+pj84DiF8R7oSpUrcj7DCnHYescA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6223
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible for dma_request_chan() to return EPROBE_DEFER, which means
dev is not ready yet.
At this point dev_err() will have no output.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/spi/spi-fsl-dspi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index ca41c8a8b..6aaa529b7 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -503,15 +503,14 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 
 	dma->chan_rx = dma_request_chan(dev, "rx");
 	if (IS_ERR(dma->chan_rx)) {
-		dev_err(dev, "rx dma channel not available\n");
-		ret = PTR_ERR(dma->chan_rx);
-		return ret;
+		return dev_err_probe(dev, PTR_ERR(dma->chan_rx),
+			"rx dma channel not available\n");
 	}
 
 	dma->chan_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(dma->chan_tx)) {
-		dev_err(dev, "tx dma channel not available\n");
 		ret = PTR_ERR(dma->chan_tx);
+		dev_err_probe(dev, ret, "tx dma channel not available\n");
 		goto err_tx_channel;
 	}
 
-- 
2.39.0

