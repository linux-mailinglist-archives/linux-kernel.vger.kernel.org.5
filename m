Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299F07A8757
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbjITOmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236617AbjITOmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:42:16 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8571BC1;
        Wed, 20 Sep 2023 07:41:27 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38KAqTGL026857;
        Wed, 20 Sep 2023 14:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=St6gkpLx2qLPhgGEmZ
        k3fHWlmrsej8jBnpHNPeFDWLQ=; b=Lzd7jhoORwLBhQmM8H6aLBH0+f36vDUz+W
        mbBEHDtizLLpHvq2huJTJt9om6B+rSjxVK7N9Go6Ai6EZ4HTGRhXdl6qm1wyg5nh
        DyKkpkQzuSQMkm5iYNpAamsnj4dEYuvpHpecPfBDrn8OUr2OcMVu9LqTf5s2WiHB
        EtJEFZThefG4XAJgaLCN8KImUrp4jQ8l9EY5jYlWwj2Mqvd+FdYUlY4IcuVgDpSu
        yskXyeDsDQU92p++kYqAvB0KDt3yUJM0qg6prAkEsXf0jalMIYXENGAHpnTIQVWn
        2gpIzqICmer+9Zr4IjiJchytCawhr1VUZSgeHMsVrCcx0P8jx5EQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3t53b5ukm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 14:41:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1biCTO0kL/XglhzeijLtxYf5e8Ln4XhF9fRFzfIzjqrjty80iSeGDK6nHcxdXdTKYgSWftm6sZ2cORo1zcsWv61pLxqidc6CZsuYVK6KLYYPZd4+9PW2wfZhpFguiKn+yOh6EiYnSAx0omFS0+qvyjnYiq89eFo4hyelwoTvOhRLe46BSvcZW1SINbzVkD5jeJbeDGzs4JKMK8laYqezslOq3kL9Z8VmZOLudRkK6k2l2g0VXy8aweQTjEQ/hIlPiJK+6CjMKPEIYkJ0xIzE82llB6Vud7o8ZIo5AHLboTFY4tGd4gtQmA6JT6LlmgiO+wSwx0xgvJlaV9clOIMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=St6gkpLx2qLPhgGEmZk3fHWlmrsej8jBnpHNPeFDWLQ=;
 b=OKEwdpWUEb9Ao6JliFNkJHE0OjnhclzWpbPdhKJNdhTpd26y1Q/2WDPkmGNUgsOl0499IffJJgK7jRh8B7Qfvp2Egi1oIRTRhMo9EvO2I2lVdaRZ3LlBd5nqR1hWqwbxhGbIpen2tWWYOQCLnr46v+8Yvn2fSigUzmoSAzm56ymi/+x3a/NpP7jWyoj938PIrsuVJR1ECKq8zWvj/eRbQjYURDRgaHV5eB8+4+q0GfnIQY8No2gPrmK7527Rrx5RaJhy5xQxcNLKEWpnUlSwY/LacNz6wrtlKQaY2TzdfdsUWZNtibSkXF5fXTGyymON9OJoq9dMwDvXNaexBzVgMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by DS0PR11MB6445.namprd11.prod.outlook.com (2603:10b6:8:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 14:41:14 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 14:41:13 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     peter.chen@kernel.org, pawell@cadence.com, pavel@denx.de,
        rogerq@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] usb: cdns3: Modify the return value of cdns_set_active () to void when CONFIG_PM_SLEEP is disabled
Date:   Wed, 20 Sep 2023 22:40:45 +0800
Message-Id: <20230920144045.2165758-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0181.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::13) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|DS0PR11MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: ad71d8ab-2926-4a73-1711-08dbb9e7a392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46W6cxSzd8k1D77rUW3mi0jSyybb5ZlbV000XShs1Hrlc1x5dntsk9cOXN+7QH/c6JYmQh7hzec0YDXp8oLQC6fPkMVaSsXwSLXQQEZDpobP3u5GubtQm7C4a5a4ykCZ/Y7hN+GvMLnJacX0EIdlCzsTz0sThXANXxxs4OI7HWKh8cQT2FR2OdSap5NUJBQgoJPH2PoX3b3hsXW3MsgHwIFtjZC2IeP06xDMTfRDYbGMV5qeRiDFTYtFIh6Bo+X9wjAjjlRKuWNVEbObe74hAN39lFPeUB47m+Ky9HI2jD5ZAnkPYJOYyPCJ+B0/FzReZGkv27bFaGUqy4iAxIn2SaaHt29yDGV/gAS44pV+xwc33v4xOzo91zA0f4ldPP47+JtcXy/IoKC5viD8Cuq4qIIZaV9X1adpIPtEmfzessR7dVmc/UuJYJm0XQz83igtRmp5sqHkerLYOtGL3W6zsLraedh8iI+nPrb6EcQ+DAHRYU5cqgQKpYAKm2GXYDUtAUhLp3um7GS+wNriLcEQGbsmFQeAo4qSiPQzHM1s92MMSa97fL+IoRK3rYK68cVqLaEZHk5kPcQ+W1g6UYsZmAlCeOj6I5k84+aOC+tFEWs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(39850400004)(346002)(186009)(1800799009)(451199024)(8676002)(6486002)(44832011)(66556008)(66476007)(316002)(38350700002)(478600001)(2906002)(38100700002)(966005)(66946007)(8936002)(41300700001)(52116002)(86362001)(6506007)(5660300002)(83380400001)(2616005)(6512007)(6666004)(4326008)(1076003)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rhOPij7ZucAMQvHpiZJ5pXJCrMQ5ZR1jLrIF/c77V1lxW9MmxRtsYwHh2yGi?=
 =?us-ascii?Q?Ha9+9NWmZgQ865YgrOOHjw7g8EsPTA+4b2WpTjRc1FpTQWFhF+BSfeQPYTlF?=
 =?us-ascii?Q?anKXKdHBasz25rTo7haQ8LXsA04e2Dyb1JIhb4mkJIw3bAMLnSDHuqNGLRTL?=
 =?us-ascii?Q?8QBWO2gzQsoa/xmKWwelzZfwkmJPL5RAS5DKrjc4J5+ErZ35DYOIW/huH82O?=
 =?us-ascii?Q?D4uuUjLx78Mp4qXJ1hXE/iKZbynu2QJ+mLSUEWsmFQiImlgCrWNlqysUrfsd?=
 =?us-ascii?Q?0Ad/EbcKoa9GgzFrQvIOU8DMqccCUJUztdCXDAIZoKeShbqxNvry4Xb6so+M?=
 =?us-ascii?Q?4BnUWfPuO1HfdgUINiIZJ0XpJHoTv4FD2SObmSiqtpOT7RVYZYZMSTINfRYR?=
 =?us-ascii?Q?cVbznGls6VtWtYdBCAyonNWkoM63YPqbbmSkFjFNMs13+A++BjwfB9hsrzWG?=
 =?us-ascii?Q?ID5Ygzyf6hJmniSrsf9rN6UhDrwvrWqaUMtCfUVwhV2O4wdELk1TTHupUDhl?=
 =?us-ascii?Q?fTSdLheJpTFW9n0SbIPuoDN9m2Vk0iEW8pWE4nNwlf+DfmULsJe4dmNlRC7o?=
 =?us-ascii?Q?guHXWogQ4BWI4VWnFBEegob8Y0Xr20IuWfqvQyCzWt2/ICT8yzaC8eaFwEZO?=
 =?us-ascii?Q?3AoQyaXeRmnboy9936fy1XUfEFVBdz0zJuB7tPnlgjdOg0tPtgJbg+IaFgWU?=
 =?us-ascii?Q?5eH6ROl2HY40E6uD3OuSXygxgX1McHSFR1y+sCz+hcYfEDdQGRKvd5hVPa1M?=
 =?us-ascii?Q?RcxqcqoQxKN4xCJjQaYkvl/evOV+/guGTGunhiyz1mWVyUf382efYQs3BLrr?=
 =?us-ascii?Q?27xG9uhh/OBuihmPPtQk324nSNmdifX1GUPsz/Y7eQebl1sj5CYMSiDO0vLg?=
 =?us-ascii?Q?m70uJIIY2/0rF7mMAthJqTGX+t2QdKFeAkTywdMd4/9dOKufQYP4BGxBrijt?=
 =?us-ascii?Q?LKEyCf0Yw8/zIt/m1/mEKaP/P2ARngaFmlFUZjnK9Sn+vOOXhriV0xtp5b+a?=
 =?us-ascii?Q?tSSWMFHsId+cu6Qbct1vyAa6cubn8C+CGYZETZ0vCQAeSOCf++N7RHQ4qzJf?=
 =?us-ascii?Q?Z4nflEDsUf78LKsHAC7ftMbW9y7SfA+U0pj4iZLaN+Qmh/3Hb9CZO1rxl1q8?=
 =?us-ascii?Q?d+alQHIzG/XuDTQfH+bkGnqBl8pBdcyX3FyqKuQCiWVtzifZXFrswPB+q82X?=
 =?us-ascii?Q?KqSXv3RCb4clqRE4oXvyD/yXd6bOtCn3V49oXukIvaLJBy1WZJVM80l4hOmN?=
 =?us-ascii?Q?B6mgHOj3twbHQXlwdtrOGHx0GhxA+Eh9KJM8rtg8EMbA7XCRNqXatrihdIUn?=
 =?us-ascii?Q?ps3f1ZZWcoKkdDY72DLD23oPmfoX/R79rZJO0l4CK9ujR13q3zvmuFfULrLN?=
 =?us-ascii?Q?jjpgd66lZlcXas8xh94ViUr2rDqKIEKftkQMg15YYy3Z5Rq0g1xoeNcRjWN8?=
 =?us-ascii?Q?CW7bV8IOcAMQdCe53lGFFuUVZhtxV4eliCAC6Z/Hlhboy7dXD+Huj/c5H6gw?=
 =?us-ascii?Q?pGa1Ff2itOoh05mQI+u6eZKlGoPb10xnV6fbcAXKxac5vbBcjNT9BEONsUEI?=
 =?us-ascii?Q?KHDYADGri5DmBv9GyXGAi4bnoBV8/TagD8ir99RwGemTR3cjl9LnbgfBAhZd?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad71d8ab-2926-4a73-1711-08dbb9e7a392
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 14:41:13.8990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UbR43QQcsLPGbsNwOpe4Nde6JS95qs+RYYU6itF3OxIc3WzzMo4eheos9uij6Or2IK8p+q05DUaT7nXk3oTBRvojhyvuKLpqrSvagOSspFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6445
X-Proofpoint-GUID: 8N2KYWSfZbpgsNGN9-zLxniDc_zUEWNm
X-Proofpoint-ORIG-GUID: 8N2KYWSfZbpgsNGN9-zLxniDc_zUEWNm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_05,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=666
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309200119
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return type of cdns_set_active () is inconsistent
depending on whether CONFIG_PM_SLEEP is enabled, so the
return value is modified to void type.

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://lore.kernel.org/all/ZP7lIKUzD68XA91j@duo.ucw.cz/
Fixes: 2319b9c87fe2 ("usb: cdns3: Put the cdns set active part outside the spin lock")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---

Changes in v3:
- Add Cc: stable@vger.kernel.org

---
 drivers/usb/cdns3/core.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 4a4dbc2c1561..81a9c9d6be08 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -131,8 +131,7 @@ void cdns_set_active(struct cdns *cdns, u8 set_active);
 #else /* CONFIG_PM_SLEEP */
 static inline int cdns_resume(struct cdns *cdns)
 { return 0; }
-static inline int cdns_set_active(struct cdns *cdns, u8 set_active)
-{ return 0; }
+static inline void cdns_set_active(struct cdns *cdns, u8 set_active) { }
 static inline int cdns_suspend(struct cdns *cdns)
 { return 0; }
 #endif /* CONFIG_PM_SLEEP */
-- 
2.25.1

