Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB429751721
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjGMEFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbjGMEFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:05:33 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2113.outbound.protection.outlook.com [40.107.215.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340DB1FDD;
        Wed, 12 Jul 2023 21:05:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdfFbek/OpuYGHmF81LEbeXav9axeXn/ZPApoCSvRFf8SmR7X7FRIq9mKv5Kd0oPGjh5O0ABG7TyaGwLLwASfNKyJcTFuOPMbrpfR2JyNWRYt0CsskGcdvtbCi7qAzMYyOWFA9/4zVeGJ1o6r0zr9qxpLVGcqC7nPQRMSqu5FQJ91UPRcAPzsG+KVtqqQadbuLlZJazokEAvxDp4d4kNT2G5LA6CzdBL2SLBOUnuA2+5qLz62gka0V3kM+zDK28P8fdbfASSNQL3vwER9dbZdhVaRaoHmDF+c0cHhzhGDSiubGnwFe3nI3upp1EfzOthHDKH8iIQ8c9gL6klFj25NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GSkjARFw17A6NM3rLgqAcHTfqDDVxoKbLHpuPFc3Ow=;
 b=hLdG7yefMYFBNXxG6I1mF1fIOCbMDSncU/sDjAQ6DMMBj1K4Jdv+/K3L4aP9G628z0caUINUK2G6WIR/olVsaM68rCouw9RxrfDc1RTzRqbwjF/ZVb3dpr1JKeHmXtdfoguzWS3pwsVtJqgyDZb538e1sj+onOM5f+nj/o4zWHD1Ta1YcVgftn9ZrIwy4WO9r6C9IJ3j8WuEJ5brRxrdgqJeZ9VICLbglXwLJtDtPwggBZ1JLWDsXVQxLTsNPdzgOEqtAZrZSI5OT3yTuF1Xjjtpwi6z7QHpJsVAyasZiKWtj0V6KipkW2/ctfZcztLi+W9M8cfvm0lI868RYPN1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GSkjARFw17A6NM3rLgqAcHTfqDDVxoKbLHpuPFc3Ow=;
 b=EKP3gBFy5OQBnPk/d+sWKmdhdVy7rqIQDUlEZQvA31MlAfsvKXC4dtKdgE+CUF8P67CIUMH2/lIjaqZ5nxwQE1NsavvO3/mz6ht2VEKWvbZZ86MyYHGNK78pVzatVDDq+ofPeU+L5WnS64I8qhIVKzp+5ZYs4AcW0h/x+lC3kZgmsv6nZtq0W277KUeJ7HZosLCCYR7IMIRh9AaYJh3qQ/GxpMvLFtvI9a66CX0eqY/wfuVl2vpwEF+P9/5r82gHQW84o1dYD6ed4w43ktcxB0NboX8PfcoCyWexhQcrgUm3D9ALO+tWxsl9/MSFHF8jRdr4YPHh1tgrreUnLKdmHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 SEZPR06MB6421.apcprd06.prod.outlook.com (2603:1096:101:184::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 04:05:26 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 04:05:26 +0000
From:   Wang Ming <machel@vivo.com>
To:     Kalle Valo <kvalo@kernel.org>, Wang Ming <machel@vivo.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH net v1] ath6kl:Fix error checking for debugfs_create_dir()
Date:   Thu, 13 Jul 2023 12:05:02 +0800
Message-Id: <20230713040518.13734-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|SEZPR06MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: bab07618-c226-4665-60df-08db83566320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wqHFTj6mLmqAS19WyjSBDLUaUUA5mXA+8zKWZJeKcU729BN0nvPjevS4Tuv7YcqzVA4ED7akrPMd2c0VdGKQAyfY3Vjl0idXsvLJwicCq2wUKJz9sT1U3t21WggbwLQTQ5so1Ru27hk09X+FTYtbkR0eR2HZM/srASLmmKnzuKjK00MuMxFjnhOSCm617fBHVvpQ1468WJstKKQoPLeqXxWbXW2BdhfBnEEtXw98GjNK789JbNl0PypK9JuAp9FuBJPtr00zC617J1m4QsATbc33NgIpzTIt/5d3J+Iz7nyd9VNi6CyzbTJAoeQAEMLjC1H7Hmd1U4oPK5GyiWeVgzjOGepAIn0skOpmQWvWSAQf1RO/eCAx5UyEx9Qole27eXYftiRpeP65f5Al+1jF00E3p2fbtr4HprdNDlhKRpgEzlA19JDFmHXt2YooDm6HEwpSGRgSSI4PbLBvb1YYiev41bJ6qM63td9ju+k95h+D45T+Emc5+MD/m6CsT/GmZhpha9WhTbsPiKwq71bvrfDQT4UmCOMUoyL0oW4+aH9X0hrjkA7wWoaY6nhf0WakaVuoY/S88Yh+4lFEePO1/3podNGw6w6vMJVKo5dx0+p57iRG4yJNkH2jz+Bh8JKEnwhwY82VP+B8Tw61OqwZSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199021)(4326008)(41300700001)(66556008)(2906002)(66946007)(66476007)(4744005)(38100700002)(5660300002)(38350700002)(8936002)(8676002)(86362001)(316002)(478600001)(52116002)(6666004)(6486002)(6512007)(107886003)(36756003)(26005)(83380400001)(6506007)(1076003)(186003)(110136005)(2616005)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dM+wTcMva/T2t880e0JVyZ/qCshRm4eTCmC6nY8qOIqnsR/SsQmh57OkkrKe?=
 =?us-ascii?Q?HvuX3XgDVs3PheK3dp35M2yWbLVwZHHgsxi2/wta6MyhFtlOZOjUWQf9gdnd?=
 =?us-ascii?Q?2DJe+qo3LPjE10nTf1ahkYX7Mx7W4mf5AmG89RzxX14hjIQD32WaqRvjEJoV?=
 =?us-ascii?Q?NmeRc4bdJCJIHzsucrKFRdzpNX4uEMuSf0EC4W8PXLpBddB2nDUtzBLuDamF?=
 =?us-ascii?Q?tx3pnke85igx4UWN01+FScSHxJdJjr8qxyGLJuyBf1LYMhPrNWAkRmfsuHC3?=
 =?us-ascii?Q?Ofn7JAtWmHXO3kWWCw6mFQq70WuDpGpSbDEjbiEVUFEugYY0z5VuIWyNXZrI?=
 =?us-ascii?Q?Tr0tFzll0fZSJEeWoNvii1lI37LHTU6MdbOva2zq77w0XTdg8gxOGoF56+Uz?=
 =?us-ascii?Q?H0YqZ2TnFm6ncJlLB4UXUogUb6Ol41/rkZ7vA2a3kR/ONY6TxA4gsWPPX1ak?=
 =?us-ascii?Q?j3PHaz9BfY53Fz1qbnWfN2cVRJlyoGubvAduMaojRRA6MOE0iFgCxJSH0CdA?=
 =?us-ascii?Q?QoHwQ5mWs0isDaDCjbR7fvSbYrKcimdgRUUsghgnruF1YbwweyyeCQEw1E+N?=
 =?us-ascii?Q?nxC5nlYQN8RfMF3EfDjAcVHbhAbVxnc/lagQqM5b9sJXTOcx3me/nFj8+/h+?=
 =?us-ascii?Q?0mEcfBIx+0DGPSeOONqefjDl+ibKOpw5PzQ8KHPgcEjEJutP25azFkewUpzB?=
 =?us-ascii?Q?h5tm7cS/cKx761DFfF4dXhks5X2Vz8/+BkLuN6cTF6T+Xu4Nhz0HIBjHYARJ?=
 =?us-ascii?Q?rDCP0QJiEdfAaCSGpERK0zOWcwoEMuRvhdf+qkcy4IoJ7Nr//iGhmdiP/stp?=
 =?us-ascii?Q?hj8LChlEY9iULHi5RmMHJCvEw4lEUpuoHKL0eQ7o0Pdnfh+9XTMDjc/T7rLf?=
 =?us-ascii?Q?O6sPG+quonl8ZbGSin27ouMGwbZrKLRf+Wz014ycrqp1OQLRXRFDFgOEk15/?=
 =?us-ascii?Q?bc9xV/Rw3FByCU1G7SxxORO41sPsYZRloAcXfJ4V1oeJJ7eaRnGEtGN7eKNW?=
 =?us-ascii?Q?kJm8VHpi9fSOOAlXSHavr2K/RHvASbYunXSFAOf90OxG4c4Ii7iyIvApJUSp?=
 =?us-ascii?Q?VyYhFC7ZveIt1U/GdSQ3W9S1tZNdWU4t6wA1+RQh9M/PLZe4cWZCv0L6npq6?=
 =?us-ascii?Q?K+fYVPbCujkManjm+tcZn5JaDJDXkTp71d5g+k+9uLzRLpuRr+LXdjw9qwVJ?=
 =?us-ascii?Q?2geXXce2u2IPQo3AYIHYXhGtWeQMuOkWfsyvDu75C9JORnxOAcNF7jDMynbc?=
 =?us-ascii?Q?a+jxRa6/n0z6aIya0LX4gSvoIC5K/kCjpAhHkHAEeRtekORJPxx7zn94wD3V?=
 =?us-ascii?Q?oN8cDqZ9DSqxHjrdR5wGD4VXpz416WCbdcUnQwd3MDsx5F6nnq0+Fyi89BlW?=
 =?us-ascii?Q?x3sQhZ6AWj9VRiJ01ZkBPhApoTmWwTS8yMFmooAJKkaSN9sWicd90iPQx4Q8?=
 =?us-ascii?Q?o1tn9SNNMsOo/7MiDnaWrV0++0q1oJ8eLXpzbJ2A3RwZZq2H2GCgmNGVRaZZ?=
 =?us-ascii?Q?fEuBeQjCxLGKL8SmVkojwM+S7fvolmZmaMvhqKFYYC0JZEDNx3BMlkB6iMfY?=
 =?us-ascii?Q?wW6phpVRa7wuHTAI8ESPrvnfzJyFzievcjvapcnx?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab07618-c226-4665-60df-08db83566320
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 04:05:25.8259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KaS6I2uyf7lge5Liy4WWHgDMH4zLzPxsY6hhYBQfRa3PxUo+CAddFQFGCWFh+a9pJMCYIA/Sb5AsvGqZj7+jIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6421
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs_create_dir() function returns error pointers,
it never returns NULL. Most incorrect error checks were fixed,
but the one in ath6kl_debug_init_fs() was forgotten.

Fix the remaining error check.

Signed-off-by: Wang Ming <machel@vivo.com>

Fixes: 9b9a4f2acac2 ("ath6kl: store firmware logs in skbuffs")
---
 drivers/net/wireless/ath/ath6kl/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath6kl/debug.c b/drivers/net/wireless/ath/ath6kl/debug.c
index 433a047f3747..505af195e299 100644
--- a/drivers/net/wireless/ath/ath6kl/debug.c
+++ b/drivers/net/wireless/ath/ath6kl/debug.c
@@ -1793,7 +1793,7 @@ int ath6kl_debug_init_fs(struct ath6kl *ar)
 {
 	ar->debugfs_phy = debugfs_create_dir("ath6kl",
 					     ar->wiphy->debugfsdir);
-	if (!ar->debugfs_phy)
+	if (IS_ERR(ar->debugfs_phy))
 		return -ENOMEM;
 
 	debugfs_create_file("tgt_stats", 0400, ar->debugfs_phy, ar,
-- 
2.25.1

