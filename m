Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7542D75FF19
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjGXScj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGXScf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:32:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F39E10D9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:32:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OFOh1r022600;
        Mon, 24 Jul 2023 18:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=8zb46HmNu+Kr156lOYkl9NY9ZHNJ1ATbVnkVV/ckLRo=;
 b=M4POthLuPlvnqAqDliPkY13tme79K7noNJwYQX3E1tpWgmBZcTokXCu+0rUpZef/U07N
 3zU7VieAlOFs01Il06bb7mHvW/2kXG/EhN4sayFp78fCMX4BnMYAJy3aSF1IPuSsaKg7
 v1J3QEYGug7n/OGb7iPGF8ILXY18qB9juBgN/7UXxEP+9Gkhn4CxoqgUnhGwAQDIpt/5
 2bCltKe8vijQOohGbkUJInmC61ZhwY2XM+5AWurBcgQ8oLqyFmA5/dasasHr5lEEDL3B
 pOB9OhNwo5BEQAIqx8Ffdf7JBox6SaH9YAmgseNb1OBIozIQ9Xe2eAA1mMBW64QTOnGr qg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s070audkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36OGttYa035600;
        Mon, 24 Jul 2023 18:32:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j3t3ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SghLx5wlEfmV1bTLV1350BPy2QEe7ysk2iMYZbyRtjheoFQFH5xy6aJf1oC5c2vfqi+A3Po7bP05C4AtWmTdqKi5nxaykRsZXBFQu7Zf6bKsXZlSu1RLMRLmT0zI/0e4wI03Rw2QHHOmTWp/cgbKw41pSVCAFT5XFfrK0p/PlIxIrmYkU7T4IfKt5Y8p9X5TB3ugy0ENziTcpAKIJggD+HFmWQpdYa91l2MlpfG2GXLKUP/CFbkmPR3wW2KZNhrOXmAyD9D/fBObADQVJoWSZWTQ0rGnqwM7sVjzwHmzGBMeIoekDE46kW7KSZWz90Hb3S4x24WXeBmXW1O6ZNgMbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zb46HmNu+Kr156lOYkl9NY9ZHNJ1ATbVnkVV/ckLRo=;
 b=cGSTMFmW7N5pPJN10xbXRMLTQynR3NvTKofDUqmNueScyOb5L7PkaWc6te5COsgB+agip84ItibZcXFbg6j2ep/zB0jkMocn9B8giCC/HKcG1wIxNcRd6e+ewIUpBMK1QtXpOaa0QDmWTXP3qHkGSElckmGt7IBezbihxgSZJyXnIaX6N2W6OA2v5WszBGcJOUMkuRGa0GrE+/eMbV20jOPKSDrXsI8riE4HOwSqHXOzjzGTw9XC/WjvX1pE4/EfGw3Q8Z7nhoHJjYqK8CwTOMpwXKHiW2KLY2WdXjjSZYkIwTsklAR1yBS/o3s3FKL5khxyKuVAuVHn4Tcxng7FBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zb46HmNu+Kr156lOYkl9NY9ZHNJ1ATbVnkVV/ckLRo=;
 b=cao6Gg8mwJEiErsw4RN8bmWLRLiZCLoAq39thpoSKdyt6P+5ayjha/uJS5PYpV0SbsCsxwri8bGxSpqKQTQlMo1n/DYtQAZ7SZsVgyRb9hZi0QxOs/DvLig0q/n/LfySetwZrcUNAY/ndtUHsHemdArF+U2TaIF3pr4FOPe8Zus=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5376.namprd10.prod.outlook.com (2603:10b6:5:3a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 18:32:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 18:32:20 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 01/15] maple_tree: Add benchmarking for mas_for_each
Date:   Mon, 24 Jul 2023 14:31:43 -0400
Message-Id: <20230724183157.3939892-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
References: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS7PR10MB5376:EE_
X-MS-Office365-Filtering-Correlation-Id: 6132c62d-6b1e-49ed-3544-08db8c74509d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L64tpCqgkoP2Jks6dVcgqRecoCMI1QovbuZk0Hjqf7Snu/02nOBa8mBWfxo995/5pQS6DU4ol/cJ7gMPolEDnG4WvUPkmH6Upb8pwY8hzu1DZDk+D0d83JTS0eOyGmsjd8uNyPica1JtP5P1V6hyyMTmii3DeEFA2nqvQ7qzR4UygvvMR8L9RaHkHExBU+JHnCN/Y9e1T+/EMazlH+egJYRCCQfsTdA5vZsymCF3cE155fKMUDofvGepMMcST6LbdUD8b64dVc40S3/224S5RGMyjUu8vOzX2UDsaLriIz+jCdeujE2p9yShWUiLH9TrCbJh9MCUPVH0oBAwYdOzcuI0vy04SkIg6JprKUX0NlfCStOUKYdvr6z3tr305nnjPX3fqSxRToIxOUq07qinUXO+tidztJv7V/lBw6qLTlZ76fPe3IHbGVSKxfRt4ooZ/TviCiETtM2U8UVF73ZTycfGOJ38MXDz8bSD00DWarImcTgr8mhVAZTXwYvPEHwK8HzpjGRAlVvN/CABCdcW1eub+ZduckP85qlGkx3fssBZo3XMUJ/icO4VsEIi24gL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199021)(6506007)(26005)(1076003)(186003)(36756003)(5660300002)(8936002)(8676002)(2906002)(38100700002)(107886003)(86362001)(6666004)(6486002)(66476007)(66556008)(6512007)(66946007)(83380400001)(54906003)(478600001)(41300700001)(2616005)(4326008)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AKvq2kHhNCOgBvbliJw0noYh1mEjao2stMXUeEVDSZ1ceAXbiUc5hNCIBM7D?=
 =?us-ascii?Q?Zr+mehVQukMlOuQaw6n+UeKmdgjg92i9WXBb9SwKSQunPnELS+29CrH+ff2D?=
 =?us-ascii?Q?n53T1j+a5bCnUweDLJ3U1agsAVFUsyS8mP5zfkBicokXtJyeuo56Pm+Uyi47?=
 =?us-ascii?Q?srMAFHD0x9RsZOSUKeEorrar6f3Zu9NrZvBIxTMEW0VRjtEBrqny8KsZ0JR4?=
 =?us-ascii?Q?yPqTgVu//C/aPkH5uWGLN31l7zchLCX87faHvH1FBy6nkC1dZIs2ziJq1xQG?=
 =?us-ascii?Q?aiEbmFHs1Up9ANTbrk1jH53oss/h7du6cmIm6FujRpKlk9GHwlWKCTQM3onf?=
 =?us-ascii?Q?ujr3xDmonTqVSF3BS76+X5078/VSdPVofJeeJnZ16WhclaUK/MxBasQFkwvj?=
 =?us-ascii?Q?t6e/EFDEElxxowz9KTp8soEd/NbKGznb9kZh2h9LhTjj/2h2ZbitwNHMhK/2?=
 =?us-ascii?Q?xOsOFFgLrV9+6LuRRbf0ZE7K5UkxphPH4W8/oRPsv3ON29AeuxY8ymhhXTbR?=
 =?us-ascii?Q?bLLIGnn2z667zzu65TSNX4ykhmXWuEpoi0RsLqDhXT5CD/XxwW782GzvO0z8?=
 =?us-ascii?Q?4E1OXF66MpD2PZKs1PButb7c9+e+G+f3SaKgFBGHdWcqn1L+gcXJccyACMfG?=
 =?us-ascii?Q?pqxs8v3IqgKQWhUdxxtWnZHk5zQn6K08gSB34m6hMiXd2p/lcrETGtdV8gQq?=
 =?us-ascii?Q?uNUaVmPziTqzaSqSK4GlfF7AuX6/hhzkzttTQIbeOGY1rJHfbShLpZq5m+GC?=
 =?us-ascii?Q?w6ogwdaOSIx2q8/ZK7eVFxCun9Qmupb8WLI0DFQCG2oaKfhi8FuTApGIjM/f?=
 =?us-ascii?Q?VLyODs3Jn7jaGm9feVT2hJ1K12EJ0b4WhZOnw4m0orv2R5fZpec+bvTBuqxy?=
 =?us-ascii?Q?615qTOQd5vnPHDPNjXqZnds8Azq4pDBI2eiBTkW5NjQuRmXWDPaZ7Kc1iNJ3?=
 =?us-ascii?Q?LcRUGVq7a3CA8GVt4+Bv3+7cbNu7F14Blmuudu4SkjtFxWzhhf46f1ekt91Y?=
 =?us-ascii?Q?HpqBLNSMaMZv314dvVIiiINg4RoFkK6tKyTCG3nCCB1b45EzdDlH6/XQ6Nzp?=
 =?us-ascii?Q?L8auSRz+cUpXA41ql2XFvimKIV4woAtmTewtFQOZ2Y21QjevUyMFfKmQ76MI?=
 =?us-ascii?Q?fBPzM3fR/Z2B5XSCLuFYd9YudHTsKigj23p78Oqky3NibNwtKi7JK8ddKDzU?=
 =?us-ascii?Q?m6gARcYUSK7KJ7RuJJoKfHxwlE+J5eTmesGrBWQg02U+ZGhNBFq/00Ivp3X+?=
 =?us-ascii?Q?hlYfrPinrlVh+JPLlcdoqUKJyPuPavqQXH/SI5lzzRIJAz3rnvMhqSj4PDJN?=
 =?us-ascii?Q?GqxycSU1mVqLQ6vNbCaLBXA6diC/gijlMZNt5Pu2/SdqyuxEWNjyrLHSIIRt?=
 =?us-ascii?Q?8sZF87pDs+RT/W+fECQQLrQz3e4CIg5D/O/fT/sDpb7HWfF61OJCbW4FPa58?=
 =?us-ascii?Q?HpTHKx4RH8zHQVDMUas4fBstwp+fmjZ78mQcLsaRUoVf7fLD8bTgLhtcaY1L?=
 =?us-ascii?Q?WQmY3DQQQF1dBDFfWV9rngFU1d3x5ipVicIydOWSNkYjBJArpsD8ltAGZclr?=
 =?us-ascii?Q?swINmh2YfOkZ3pbZg+xdo1U/Mu4Hq9QUwFxQ9Ka/YlEtvIlwPRJ41eMmWM6M?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ae+41SInphsyyXbUNy1Pi4KxnvZ75fL3BnKYpK6Y4wqDQMLNlvvIHy39U2IWZMmqiqOD6YCce3tKTgQeUBBVNjYmqLoT0hunSt9FvSnTCEAxLM+3mTVaDEhfKHnBXYg0OKkp2Psi2NXomMmfJjVwhtubFRhTOVuiRNhdlDSL4crhcaKWVluxIENuafOEmgpIllZ67nGUrtnHE9Vnt0UUiTxx8IfV5DvVpYnxZZSfIw8jJOYaiGOuEQ5UvpnN+e5lG/rlbFj4eSjOaMHUAgCZeRKPOzU4dSW/PlXFnHhmmC7ku1tQ24MYGY1RVv6ZLCILQpbdEBwVwCrzZPLnUBd6Q7Okx7teqIk1oai4fXYqpW2VcE2NQydtvKty97yc/mJDVCB8IQkvTgAmhPI+dHxRPUHbslhj3cAgCbx7Qoo5o7edsr8T8kiJiB9ElmQgWZ6kwtDHXx7INck3lWQDBVpyFowlqwGadxEUtvFbxdkxau+W+JXOhx7d/iCKpiVOI/dSkiHmoe11AH+Mc4Nm5G/YmpSLFPb3guDOucjORcpjiK9jnuzyVxPW7HxUn77pQ3rX8iyIVq+zWRW4rOENnn68qIm8oWOha9Iy447TLp4ltjp43Amlp+1uit3MmERVM/Bg0afEd/E7pj4obYaFzauo6CoyNBziv7qNIXnpvI+D9V+lTNFW5CB/h2e9ETaFppdTU5VTF/+Cg9yJGqBFH0b/9saa7We2nvMbzwkbDd3j8wAgol4CN1iMW6BVZpLtaTGGdcNTw0xHG1hsrrn0GAqs61Ac9QMxRuJGy8k2ERW5GqkEAPUdLxIYIoXoySKh7kN1UggCDf0q7oGW7lLB2VsxgTdDjKWjxJIiRp4J6v43H7/vPFm9TJ06shkTd516Brg55xez8Kc//XJWPG7eqOCsMnX2wlLIeW2lhUkrxfi5agE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6132c62d-6b1e-49ed-3544-08db8c74509d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 18:32:20.1005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhC8IByMKawYLfnnYVQLy6CUcWgAuqmUe1SFQ+rDkKcjL1PvVUZPBefJBqz81IPWtqkW0m48KnqZB2S2Sy7ZzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5376
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_14,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240164
X-Proofpoint-GUID: kkMJntR40tT7YVovkE37iUu0Q4JvqGr6
X-Proofpoint-ORIG-GUID: kkMJntR40tT7YVovkE37iUu0Q4JvqGr6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a way to test the speed of mas_for_each() to the testing code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 3207c2107918..9c4cf5fb2b7f 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -44,6 +44,7 @@ atomic_t maple_tree_tests_passed;
 /* #define BENCH_WALK */
 /* #define BENCH_MT_FOR_EACH */
 /* #define BENCH_FORK */
+/* #define BENCH_MAS_FOR_EACH */
 
 #ifdef __KERNEL__
 #define mt_set_non_kernel(x)		do {} while (0)
@@ -1770,6 +1771,37 @@ static noinline void __init bench_mt_for_each(struct maple_tree *mt)
 }
 #endif
 
+#if defined(BENCH_MAS_FOR_EACH)
+static noinline void __init bench_mas_for_each(struct maple_tree *mt)
+{
+	int i, count = 1000000;
+	unsigned long max = 2500;
+	void *entry;
+	MA_STATE(mas, mt, 0, 0);
+
+	for (i = 0; i < max; i += 5) {
+		int gap = 4;
+
+		if (i % 30 == 0)
+			gap = 3;
+		mtree_store_range(mt, i, i + gap, xa_mk_value(i), GFP_KERNEL);
+	}
+
+	rcu_read_lock();
+	for (i = 0; i < count; i++) {
+		unsigned long j = 0;
+
+		mas_for_each(&mas, entry, max) {
+			MT_BUG_ON(mt, entry != xa_mk_value(j));
+			j += 5;
+		}
+		mas_set(&mas, 0);
+	}
+	rcu_read_unlock();
+
+}
+#endif
+
 /* check_forking - simulate the kernel forking sequence with the tree. */
 static noinline void __init check_forking(struct maple_tree *mt)
 {
@@ -3498,6 +3530,13 @@ static int __init maple_tree_seed(void)
 	mtree_destroy(&tree);
 	goto skip;
 #endif
+#if defined(BENCH_MAS_FOR_EACH)
+#define BENCH
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	bench_mas_for_each(&tree);
+	mtree_destroy(&tree);
+	goto skip;
+#endif
 
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_iteration(&tree);
-- 
2.39.2

