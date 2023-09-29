Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECA77B2F60
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 11:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjI2Jig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 05:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjI2Jic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:38:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430BE1AB;
        Fri, 29 Sep 2023 02:38:31 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK9Wn6011902;
        Fri, 29 Sep 2023 09:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=9GQJcZ37W7JCKiCpJzkcGdZwr9NNU5Er8nVCAxQEX5Q=;
 b=zbPnEP/b6fZBGpGP4lxWLPdo/0z+e24tjK+lmcztEG9qLEdVdFFiwC7KiWnFbKHHXjyq
 B2Gf5ZE3yxFt/Wurklk/s450o0ufXW9p7oLZgmUka9plYt7rphOuE6My7ONWk3MVQ9pk
 zDM8Krvbh7jrQ3abzM+h8OEiU4FC0zJdx29MbnEQ8lid6ubnXsVnGRxBaWoQ9AD99D9S
 CE8yK7WkAvWpPV0Q4l9OnRimKChtFxcSKKgJGK6hY7BJaMe3qoBGjv4vFmCXsiOX2kT8
 /bLpnkAZl1icUkNQF4PD9QYzei03IlkzZKOFhbn/iZBbv+eLtXmMIYlE0+kYuBbrGxe/ ug== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pm2efdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 09:38:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38T7msw5014617;
        Fri, 29 Sep 2023 09:38:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfbk60g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 09:38:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSk7h3mwJb4RRBkRMPbmsxx6PDrT4uTSVvdlJQ8es2a9CUXm7Zow0NTA5XhUFCZHXy1nsEvWZyrXvHo4eYtFU8Q33mzW4KjuIEiEOYEpWMyI1reYbJjssLMan8aYZGvrhmPVkX/UYefQ997pesj5jVg4hnjrl0+QTwcKAXWtP9DQKjVG9G5QoSdma8a030L3DQt20nPBMKinzDbRwp/WGXI+h0DMGGfjYW4srXX3jeEcQQVZSaD7ieDq7dSuOcIevHEvtLegPy0xNt+MqGaAThOBASdcBlMweWNIA0D5v6JdfIBujfxBC28l9LGaz5N8w6eGzNXMNVkujXv/9mWZfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GQJcZ37W7JCKiCpJzkcGdZwr9NNU5Er8nVCAxQEX5Q=;
 b=CAn4UzLV5tH/W67djbGbMpcum3usRuOr8GXLVAQqT33/kZQrGDpd/K8Uq32IDbyqjt9uE8vBilyDlfig+2WjlP/47TE+HHFHHG5bBSOwNQfCs5HOp5h+OyJNQeG/J4Hs2yNHpz1UXV9IjC950U/G0xiR69fxzFkWVVTRl5bnxCBMHjQVJn1Gr5U0geOtS67oBSjwKhTlfFntJnJxQYBPvMmETnTs9NmK1nhORlqMepHc/cQQ6UOHxIRC7oQC7s3UFPETDEc0Evr1qzYSHyoTpY0Hh00Ve4BmgV4jS4U4iRgNCOT1nvZAzZa0sjwLjRhbwL5Hl4kyAxUrRdXfUWwFpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GQJcZ37W7JCKiCpJzkcGdZwr9NNU5Er8nVCAxQEX5Q=;
 b=ZrHAbCRpnTVGYBu+V8KYkmaH3cfGHBF1V99yDcb+9eWVSea2CE7wdi8QtrHBVcbDCSZ+e5ZSkQg1Ho9VGb73UcksS+ePz9kqBlK9KgJjGODcnskkJLLVEoTBM9Po1pZX6b5MXEFnxN+422dqk+C35Mr1WmJKzkDRIEtb+QeoI8Q=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB7197.namprd10.prod.outlook.com (2603:10b6:208:3f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 09:37:50 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 09:37:50 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     martin.petersen@oracle.com, djwong@kernel.org, david@fromorbit.com,
        himanshu.madhani@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 2/4] readv.2: Document RWF_ATOMIC flag
Date:   Fri, 29 Sep 2023 09:37:15 +0000
Message-Id: <20230929093717.2972367-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929093717.2972367-1-john.g.garry@oracle.com>
References: <20230929093717.2972367-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db892d2-3c53-47f3-30f4-08dbc0cfbf50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cR9g4lYJfU5dsJnxbVPD+rQqm92VmPSfx4GSgN7DhaTnkJBfmJqko3zkNjEEJb/QOpMckWfDIKNQBNIyQ11IW72HokqOeGn2Fi5taPtPo+U67JLHDEEjf6s0BX4v9UsedQumnYJfueOi0tDIef8dR14Oef64psAtY9mqt9H7wxjPF8aJxvkjSn1HvfHe2XCRpiGkAS3cF0nlyThz249UzX7uN18MXxOWLgcJHA4M9/MaXy3WiOJRMMIrW0SNbUFVQBLYy+//tE9usjOh6qJEbySfg6kocXNm47WKzb4lwB4zRbclUl24FWyPwLZNl7REEdsxgBKFOeP4T+3izhafp6/LN3/QTxcsQLIjXhS8sBFvbS5rXJ1xWSNyXwjIOct8DxEsUMRvXCbPJVt8XB3RwrUjOs4YatkyEIUmhMWA2ctEbZIm1QmEgPOMBCo/TynPUePbeXQgbQpce6RbmFZA4AIWTjLqN6Qi3JUVrOlHDV/5E3ROzOOJ8arLna2Gz0YwtI3aTB4CwM5DW7W2TYPuh2eMbg4mJge5gaad72+EFM5s9FoxE0kbimBdGbS95AH9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2906002)(86362001)(103116003)(6506007)(6666004)(83380400001)(6512007)(5660300002)(38100700002)(6486002)(478600001)(36756003)(8676002)(8936002)(4326008)(1076003)(107886003)(2616005)(41300700001)(26005)(66556008)(66946007)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0PMY7oc0udatbggKglm/Xi0CO3HS01/O8EFTketJzHPSJ2jv/E9FcTVogKqJ?=
 =?us-ascii?Q?66nVP1eMP5rGluyJHE8mbxofDVW+aZvHZjqpEwCfYzpUjIOYUFz7XKNJHeBY?=
 =?us-ascii?Q?ibFVXpgyow8Yun18laFxVJ4lZk4cBIrNckP7itpEP7E6VAxzdXHXrRN44zc9?=
 =?us-ascii?Q?Xlt74qbyUdQY6tV3edZHegocw8ktIpEdEIHoJI8Sf4gI6sag1BQeuos/e/PU?=
 =?us-ascii?Q?jwgGiUVeUjS5ruWIQZDQDu3C2R/szGehlPs57dv87YYAvciT9l1NiClTuOZ5?=
 =?us-ascii?Q?xDWPanwkeCLIubXDCxpEBpaBRzWr+aydVUi4NsSIKsB+XRM0EZxb1j1xc2mW?=
 =?us-ascii?Q?9Di0Kfk7s/OcXV4Xu6U3PHLmAyg58wfPVYfFKs6Mp5CO+lxXIayRljpBIoj+?=
 =?us-ascii?Q?Fan4o2iCkhKX7mP+0B5EHBbqNYBJ3ojLgroG8TbI+qVXTOrKFpKehd2Bo2Ar?=
 =?us-ascii?Q?m6TnowUbWtqu7PZtucfANxoDxKd68uL3UGDzti0QZDOPupvxvw5sQJF38OTO?=
 =?us-ascii?Q?+0+i+HwnUh0TvLB9ZltUW56F9lPOqXuyuyfd+r8rHnd9S7MuxK0bmO9k5UIk?=
 =?us-ascii?Q?M46D/lHtgEUPjzg8Jc7b8TRQncvMzXbdRwe1vy4qn9gt9x3rpf7w7Gakls4P?=
 =?us-ascii?Q?IjS8nklOwzG1aszJZNZPomxKRZ5n5/lCwM/AyCmn/mINTc5gURUZAhX4JONZ?=
 =?us-ascii?Q?/Uf5L5t4JHyrd9Sj9QJ/slgOKw7VjXng3qLptjpWRFrSUsedEMxwu9Rbjht8?=
 =?us-ascii?Q?7fm5+f3X/T6wU9RZd8vVrNHBfkTWaP9rV9ym3CKa4ixHslGB1TMoBTfZS7ko?=
 =?us-ascii?Q?3fXxQFAgczYCqz2MELMblX/aYgNUIYJBTQCWk1CRg27OfMNSoCOYv6x5zl4w?=
 =?us-ascii?Q?+3wDYSxXhrGeiFcmzGcE19wUZPsJwPDZ35wVYdwu2bAcyLYkRcFw4+uJ0zCF?=
 =?us-ascii?Q?8AwAHfxR4FFVsSmNezmQsihb8zXbo0T2JR0Zuo8OvXpc/JJFHbcqWaR93Hy6?=
 =?us-ascii?Q?otp0e5srDyiKsDy6p8IONn24eEzCnpVB9cBxONGocN3bsDHnld6R++kSt48q?=
 =?us-ascii?Q?yFvp1hPI5w0HYdZfkE00pfLd2gkzkW/x4W17EcaFLTlRqJgcpNu4nvDORxUV?=
 =?us-ascii?Q?YlkH8YM64fsCBfq+9BMAhaSt9gLnxVgA8WRLG19zdof3X71ty2Jt6SGSEY1p?=
 =?us-ascii?Q?COA43s/pTH+gjvLR8jFqf2BbqhVV11X+/N22kcvSSkIL5YuiuOBwP9n/G5+f?=
 =?us-ascii?Q?2rGOc3smnoL1gNGBRsGXyfhdZJhvxcQe+62TluOwqeS4JEL2SUzeXCDyg7/d?=
 =?us-ascii?Q?MSLMirEu40xFGqt697aLPwZpGFfNjuwYvJQVVuH7xZTcogJJF+ifEeJKq4TT?=
 =?us-ascii?Q?HYu9k9oXp9c9AyCdVoTv5fKBawDHx7BI1FueriqnnZs2VQunROhxgP7UZa1k?=
 =?us-ascii?Q?wckGq9Y+9Okc5KpkKAgSxJz3Uh8WpYkjPa40S+zepsRrRTB/4wfywNZOKk0+?=
 =?us-ascii?Q?zWBpJPicRS8WJ6ZuIDy0IZ5amBrLMWBPFy/RrTFcxWDnKrVhtds0qT/TwrHU?=
 =?us-ascii?Q?nA4IpuDUcZKk0UfY8ibgoUBl3i18qJoF6EuRq7TXkX1xkjbgluhoxgqRgrYp?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xQfkns7B3pbW8Vn6CQ0x7Esccm6jOG9urUEGMV0zeauqvCxuEVs3besLeklLSxn/ssNccv+DWumOtvxMmSeYfF2o83KbbsfgYTCU/acAO2gh0PSKoM15ebJmV16uyw3s7zrLEbmOglN4dIiwbS6RNEjK1y53ljwVzmsmlRBzPAsxjzdqC2sxQPvV9RiJwiFCYIe5BpQ08uvSZ8++fDHr6Oks/tl6SOyXH64ecjHXtZulqz73bjlPTKVjBtFLUdRDPRnyit1rDqb3yZB41ma0BQwmHBOKpsHmXAwSMz7cgGTEzByS32IVIcyFqXdvlGnUDI0FIS6pMK+teS82JZqDhEBT0LeIhZSoaLDqaao7itPp2w/jSjrKARStS8JX7nAra4M69uxhhiIBZjFhz0LOIpHINYWcewbnAbBzznj0LtXlbHPjHb3HChfz6HObaKxB6IJaR0vRUg+s053hZQ6fLiSiawVxwNBVsY2vy0KrZEO8C+E9UN+dUEiKO5Jfj6eNbTzoST/x1ePGOAsVuHM1KWuVSr9VcGy4w855qXwx8LLOxc0W0zz0neHguG1YmEA2rvfBv9K5LrMmAEwndCajScMR40CaydBb1MFdNOqM/nvNJd6CP63/64VOSidcf9N877M4Of/AwJ7PeOKcxAeFbMYaOLA979DyFEJrSUfECQduSVVpqAqnEJTRclSJeX6jUfyrDxDUKNJ4t8tflQP4Cyb2hYK5NwFe49nnFEiKzPCOVzofI7lqzk6yDTL8mFpiERGLT2Io6xvf/+aXWdeoRR+T21EZnSpKW71RDqBwZ58B3kyw3g9XLGNOCA1G4iuZlnsXfvMu/UCaJNxPgzFc5w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db892d2-3c53-47f3-30f4-08dbc0cfbf50
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 09:37:50.4997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ux9e3Q3ycltU5cxyF4Q0SDl/mA8J25PX6PrR7rht+b32CI95tLp+QbwGyloPXYrgkbuN8BbsElJNAtAV/ZEXUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7197
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_07,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290083
X-Proofpoint-ORIG-GUID: uUq2pdZimbRws6NHWX4lcaeNOOed3oUi
X-Proofpoint-GUID: uUq2pdZimbRws6NHWX4lcaeNOOed3oUi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Himanshu Madhani <himanshu.madhani@oracle.com>

Add RWF_ATOMIC flag description for pwritev2().

Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
#jpg: complete rewrite
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 man2/readv.2 | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/man2/readv.2 b/man2/readv.2
index fa9b0e4e44a2..ff09f3bc9792 100644
--- a/man2/readv.2
+++ b/man2/readv.2
@@ -193,6 +193,51 @@ which provides lower latency, but may use additional resources.
 .B O_DIRECT
 flag.)
 .TP
+.BR RWF_ATOMIC " (since Linux 6.7)"
+Allows block-based filesystems to indicate that write operations will be issued
+with torn-write protection. Torn-write protection means that for a power or any
+other hardware failure, all or none of the data from the write will be stored,
+but never a mix of old and new data. This flag is meaningful only for
+.BR pwritev2 (),
+and its effect applies only to the data range written by the system call.
+The total write length must be power-of-2 and must be sized between
+stx_atomic_write_unit_min and stx_atomic_write_unit_max, both inclusive. The
+write must be at a natural offset within the file with respect to the total
+write length. Torn-write protection only works with
+.B O_DIRECT
+flag, i.e. buffered writes are not supported. To guarantee consistency from
+the write between a file's in-core state with the storage device,
+.BR fdatasync (2)
+or
+.BR fsync (2)
+or
+.BR open (2)
+and
+.B O_SYNC
+or
+.B O_DSYNC
+or
+.B pwritev2 ()
+flag
+.B RWF_SYNC
+or
+.B RWF_DSYNC
+is required.
+For when regular files are opened with
+.BR open (2)
+but without
+.B O_SYNC
+or
+.B O_DSYNC
+and the
+.BR pwritev2()
+call is made without
+.B RWF_SYNC
+or
+.BR RWF_DSYNC
+set, the range metadata must already be flushed to storage and the data range
+must not be in unwritten state, shared, a preallocation, or a hole.
+.TP
 .BR RWF_SYNC " (since Linux 4.7)"
 .\" commit e864f39569f4092c2b2bc72c773b6e486c7e3bd9
 Provide a per-write equivalent of the
-- 
2.31.1

