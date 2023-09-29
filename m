Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30617B2F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 11:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjI2Jic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 05:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjI2Ji0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:38:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D0C1A5;
        Fri, 29 Sep 2023 02:38:23 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK9uhS020207;
        Fri, 29 Sep 2023 09:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=cB2dvNd8c26enk8ct08GHLYV4CjtYHjIUQSAXzr5vao=;
 b=pKeeFfIC6jtxJUHyGZHsJdVW5ssteAzH5Fv93y2bcj4+jXUPuhnB6ZiI2nJZ3IYgID8w
 Wh7VxLtSYS2UxFsrSIPNeox100K+d0TSPF8zI6AyGcpr9huAQUonfHv4OvOLnAAI/OZd
 DgORTEybB0+ywyXprQN2cAJGBHXScTuLxxldNECiD0f30RGVLNos4uisKx9WYa2rCo3e
 wh4OldV8pEK3D7XhZktOTjX7nMUtmSyNF4EnoB/ERjl8gKyNiOwsoZj2uy1hZF/kRNL2
 yRWw8mWFgliIo21GyGhgaooCYwfdLK+eVQdFznGqSGHcV1xYxJBUJ2fi3xjtpSFby3vn kQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9peee7ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 09:38:19 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38T7msw7014617;
        Fri, 29 Sep 2023 09:38:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfbk60g-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 09:38:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=la83E3u2k4W6nTq6kd72SFQcxXWFf0FQqjzIir0IrK8Qn4eYn/Q82116Oa6npBeYpRlFyhOcDDFPH68e4i0CE8w+wM+LDUX1yeDYTWO8GRMW11w8+qSpcMF9PFAY5RQKAwAcgf4UMpqjLZ4IH2a7C17c/KZ3UJ6qgAPsmWIEhY84LH9rzB0VV71GsWGqXwiw7qiei9kLpvFlJ0eXrq8KpB5PusrtSKRsa+BZ1TsIXVHwC7FTkKFrmQ221d1OtC1sla8CxFCjld1r2AHUwlnXMcUoDrSTXJs2j1Ly0i/GOFGM1MFY05cFjEquPyhEji6e7UN0K0ksfcCHAISQ9eGF3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cB2dvNd8c26enk8ct08GHLYV4CjtYHjIUQSAXzr5vao=;
 b=kMZNuFG0dT/uYh0256UCTi0EsZ2C08ULYzNJb9VJkKerUaKagG1LfDf5p51Jb7Ycg5x5DZSuBv+d0SrrZayovwkwrmHO03WV+qfHqi6mpx/yaQmyzptYqaJAItxQk55ZhZk9cn/zdE1UBswaj426bZAg287d9Z9XALa7vKMRCRkWMB9AwiBFx5qV6k4WDIeQ9Y3GOsa5MCuXUPGKJyKhZk3qGzBOMBxeQ3e2TbSh4gRMuo194OLiGfDZda5kTqxuVH5af44d4878GHyI1PGBDNN2P+HB9/jAqXfKpyqEU6wbW07FgAwk6YgipxdJTH+NDCBiO6rnPq8NOVKr4ZK4Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cB2dvNd8c26enk8ct08GHLYV4CjtYHjIUQSAXzr5vao=;
 b=FyYD2rrB7jcURui5oNRjcLx10l779jAath30gVUQshMcoThCo4N2xsmiUy6ngGrCZA5pyndddq9+dydl235ZKEEmkxn/kzrN0ITJlPTWAxJ/22yKMjnYWtHAA84JkmtY80+w9tqfz6jikVDhdDWQf8dt76OYObv7lz9Vue+e64I=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB7197.namprd10.prod.outlook.com (2603:10b6:208:3f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 09:37:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 09:37:54 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     martin.petersen@oracle.com, djwong@kernel.org, david@fromorbit.com,
        himanshu.madhani@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 4/4] io_submit.2: Document RWF_ATOMIC
Date:   Fri, 29 Sep 2023 09:37:17 +0000
Message-Id: <20230929093717.2972367-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929093717.2972367-1-john.g.garry@oracle.com>
References: <20230929093717.2972367-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f97f38-4e82-4ced-3036-08dbc0cfc1d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OHIz+1BkDyUM5eWgiQb0Ssi0Ons14ONS2iQFWxv2M58J2tllPvLjGs9LXrriqme8EFwKaTs+KfblmgE6E5AuE8PLcqPiAPlVFIWcCJgDdfYCTsdtNFGCS5uRUS8OqS8wPN29CQ9TQCM+pJb1pAMyknk6BnPfxvbtZu7PgFbKxwzepSOaAvl+sb9yT3KPYrH58v4zCTg+o4kdEyRZfwPXndBM1ORjgyN/5Hw5nQ6AWRsn8KosZwufK17g71VycrzE2LG3nTLaCsNQ6jiIOFjafqRu9dvFuIbn/8gfX1BS+oT7j8QQWhCfsOKChCO6LWbBy4OWnZ9v5uCpktHKEulKtTz9rOtiZoC1kYxCCaU6WgSnJEwgjIAY4HThqbT4CGo/Hg6ko9xWHdik647g2xrbG5/oa4ZKAR7MO/v4k5zwYPBwCdLJl6Oh3HvLOLVhkmu5HZztb/m4RHrTSdvkwMTDunLjeWD+abxghX0EW2qWc5HLZgMooutE2jiMfHs82qnj/yzSGt8OUGA8S2eBkxSixiwv4XyLpGEI68RRdHWYvFgKpUgiwbRuS61qpQbxzAg9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2906002)(86362001)(4744005)(103116003)(6506007)(6666004)(83380400001)(6512007)(5660300002)(38100700002)(6486002)(478600001)(36756003)(8676002)(8936002)(4326008)(1076003)(107886003)(2616005)(41300700001)(26005)(66556008)(66946007)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a15QTDqeSvdDpTIcIsM2jEOdGrwrhCno5v9ntJJYlDsxM65GFmEVWLeINLlm?=
 =?us-ascii?Q?YAtG2k4dHMDHWXyczNKWdxDfTjuTUwTe2KF0vL+OCMR0Uwc9FnXE5J0ecqEY?=
 =?us-ascii?Q?gDR/lL1esZZD06hPtQR7G7VEO46Moie2AvnLZSO2QjEA0peBGOrFvznWiOEX?=
 =?us-ascii?Q?ZiGQ5nFvT2esJ+spsDahfPEM/t+EHC8D/ntye1bXW8rOZ+/OmWAjWpWDNNBC?=
 =?us-ascii?Q?0d4ouk7RXhrksbreOEPkepkJ+h9A2JPOLuVuZbmC6akoMlJrAvdslNY0sE3R?=
 =?us-ascii?Q?t6vDQNU4lqH87eCJ0QOYCfZbfOMBlIeR+g2fAMPc9gq/jPimE9KZSO3iHWDy?=
 =?us-ascii?Q?RrU1AL/dneK2zBFubv3cUzI/XEpDminrK39BJ2gaBC4yO6+nsXVCf1EqJaD5?=
 =?us-ascii?Q?+Kb0243rNuCCiLfHAYKME0bJpErI9KLg8WvQEz0PZALMwQWkbxx4SNUKzP6F?=
 =?us-ascii?Q?6DfGqn2bJOXtR1TEL5EcmnprQd6oYmB75yr2pYb5Hwle4dw9tZbQEjloPSI4?=
 =?us-ascii?Q?84tLCYr3bkMaSgVOEm6ixrPM7X4Cw7TLS+n/Z2SYB+smwk0kBbwhtW4Apc9C?=
 =?us-ascii?Q?30w7vqrpfVhDq8FLJGZUIHPA+6KOf/rOpI57CkJ/WMsqsNa3EUpk//Oj30Nr?=
 =?us-ascii?Q?u7Xb695wfz6q3m6h+HihjZX9cq+UcaaipqBggaJjfXadvUxvEW5iq5esTnju?=
 =?us-ascii?Q?2xitSdpIyV0pXwl0GkZM7I+t0d5c5+nQvPqoC0gYgTcrr83uRvKH/ZiqdY3h?=
 =?us-ascii?Q?/RTKf4moYQZ1n8YhuycTuiT6JGJdwD95we5REDtAITGkmnQEpImQiu5mACxh?=
 =?us-ascii?Q?fS6zaMHxG2Dbm0u/0fsjDpPECQeXFq1TtF3KevPJ+er85zjqX6h537SG8uc2?=
 =?us-ascii?Q?Adsv5rh9SvUWzKLW9/ohjG6ryBos+jmjUQlFNBWzjxVFaz0vUf5Vz4Wlbw1C?=
 =?us-ascii?Q?DTGFOVBEtWpIfVMmDMnzMsRjrKzPcjpXhOHVJyqjyDH1UKN/eT5T3DVA5Bwc?=
 =?us-ascii?Q?DA25JPyzmPzR3cTj01x/iRmHmur/1Y2JXHNqJEk7PBiDS5x6qNdkzq6acTiJ?=
 =?us-ascii?Q?AB9J89c8pP1e1FtqXfbLmXowQn4/pOe0L6cwIaxq2iGvwmnIdMpF4PuqbgpD?=
 =?us-ascii?Q?bUznUuu5nJEKlmAxiZW1VVbiT/mv0K5+bcfUzsWfXS7oe645A6aGsRoyuCii?=
 =?us-ascii?Q?qfvZPuavYOO071fCrWSka6zLAI5wbWeOn2+JTfPHARur9In5C9EIXAnF1oP9?=
 =?us-ascii?Q?nMnmSZlswnZ0va9q8pi6TSeNYDBwT/X43CU6XD1z0K4sCLT6iPTRY1AiLOxL?=
 =?us-ascii?Q?ZJZ4Rzh0qB09Fh/58q1zV5zhGAcIHa9i4bCHgZWxongF1kwnG1E28+8Z/UwP?=
 =?us-ascii?Q?MCLvJREBEE1+YhyOwyWFmMe080DJaAMDQs0Z33m8H/k7bO7AuXzsq8S9yKs3?=
 =?us-ascii?Q?ruzn/a3nJd2sF62ifrtXJbPvAPZAKA8Rs1OU65Ymd3d4Ur9PRFYad/KTRnrn?=
 =?us-ascii?Q?7sf1JKhVCWFFNz4PnZFRZEpMuMHctoScMdksdt3TQ4xbQj+SjWso9KXmASeY?=
 =?us-ascii?Q?du0g+woUEIKZsMrG2kQmM7cv6NGzkgfnK4nAzpQm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TNzWdvA5krFBwvLlNHwxJ/wg4R1Hgbj+b+8OPXvhGpYSnvlpI+SnwT1rwoc5yEsXLnr6NwrHs2c4RIifDlkBXFkyKYPKMTZpmi2tzM8lBlPdyPiy8erbXgxK9S82pbWxxEEYE0UdUEoUFKrO201sjEz0LEcSXZXpkKfS1sHtJjoYdd9lULC4WkDYeEi3glCxRBor+9QPEf6TBWTAXtWZlTW5Zcsg5elfqBZ8SChRILcA4zntiUc201lUiAdLcieWb4yD/fFZJf98ThTC15eoj7kmHmih4mLPr2ukVviSGHUQduNHo8VBGiE1NMOLWQrY5HyKl1KwStR4JypCHnxAMx9/07NaZRVNSrUf8vfvhhHcSXmdRsf9Jxrd1iUuP/pMCgXxPfs9ON9S3OmGmEmYOeZfCiS+Q+Vm6JtLvGx4W3+F/gqKu7gleSHYHc9STnfidU4ZdEGRj2wi7klsFX4GmaFTSUZ3v4kH6B1iDddNEqgcUl/XWNj1nibCL+WFQTJfk6X0daYqN3tmb7fz/HFOx1D+Nw5uOlag9lZ/zLTtsiXsru9cjq68ro4HWo3lNUjkI9HLG/K+HG1u2BxQLMt44wF4DIV2dHkTvzaBT3HJptcHB0tASZZnyqB9r+p3g+tHSXc0g283BbaQyZo0G5uWUseDgZF25QN1Jayo3RhZ1PPmG9eEym4+DkxqAqQl8lEcsRM0bIVl2I2RU6q380WZJOR2sAYQZCXSbFnB0lL+8BAnxE83v/K/4ffbI2LjXkSheqYF0Z4R2XseKPpJUMe84TxUQSPvJ3biUlE7FLkFmUESGGBmkdOsXnvLf+7CIe2rxirPsYrZ4WVIxCb5hGFvYQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f97f38-4e82-4ced-3036-08dbc0cfc1d6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 09:37:54.7629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ooZyV3Ds3mAtUgKq4ZUGLSIlah6g21n2yUeA3NZ9lPbDdr4t0b258hWzk48ibND5kupsWNckf6IBaW422Nuug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7197
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_07,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290083
X-Proofpoint-ORIG-GUID: CyzkjWuJMLdq0PAejmzEemeGfPpKrp95
X-Proofpoint-GUID: CyzkjWuJMLdq0PAejmzEemeGfPpKrp95
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document RWF_ATOMIC for asynchronous I/O.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 man2/io_submit.2 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/man2/io_submit.2 b/man2/io_submit.2
index 1030bb6cd965..beba8865ac2a 100644
--- a/man2/io_submit.2
+++ b/man2/io_submit.2
@@ -140,6 +140,11 @@ as well the description of
 .B O_SYNC
 in
 .BR open (2).
+.TP
+.BR RWF_ATOMIC " (since Linux 6.7)"
+Write a block of data such that a write will never be
+torn from power fail or similar. See See the description
+of the flag of the same name in pwritev2(2).
 .RE
 .TP
 .I aio_lio_opcode
-- 
2.31.1

