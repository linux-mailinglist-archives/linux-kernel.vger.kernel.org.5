Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B510E7DF868
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377146AbjKBRMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377122AbjKBRMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:12:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61387133;
        Thu,  2 Nov 2023 10:12:07 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2FjZYq001860;
        Thu, 2 Nov 2023 17:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=bFmmbL12J5HalLQ/ajq0zSQv9/smlcU0k2yvP02zq0g=;
 b=gEAHsfkYtKmkpklNOgGZU2xxXlRY2zJ6sg6j/yZvcq7c3lX3GMauv7N5efhrDMBz7rsJ
 LMY/hIgjE3vZUw+4bqG8jTIfZWzvTJt5vmRLb9ziaLnKGM2U2T2CWKtP58xaaJNiRfwJ
 bgoj9FG3V6fhG/O0Eiz2DKFYyU740AmvgNeeUiPZ2bN12TbakD5K1GwSDI+nK/1RWhPv
 fqd6zQfEQeDA0DdsxKJg//Id9q0xF0PaWb+kgkw0LIYjgzK8ZFZgVaNSZ5Dxq+6Ji/XI
 opu7ND8+NxdRQUB/6beqRQk3WaF9lWaDy1C5+jTyQznK94qiy3WsuHMDggAeXauORc3F OA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tbdtc4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 17:11:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2H6k9c022542;
        Thu, 2 Nov 2023 17:11:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr8wgq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 17:11:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6U0tbA5U1NqCLLkxVq8ifwgJ0x8RKRTUCyS2AFrKJCCYoPi8aTxdMfZFMVBaf8jukFquF7KARB+m6sDTfDGoLQzc0P1p5VLzZ9+8zfLxm+YbUOqWWG7FopqUpgyHA+d48ZZqEqMAHD02IpyHInfOAEgBnVSOADavxKDpEwOgRGVIyKW5K7UdtRmkguW5gMYSL9Vo1NrCA5X+AquXp/moNn2HLsFpiJHUZ5FDW8eaEbNUV0ZwCZmKsQW+oL/B/W0DlJ/8pO81mCmZl5Q7QnJnHbzrXoWXd2U8mWdwNXclLz75psGcnNcJm5qhzQ+89RIluWcOuOZd+jXuI7Nrb5kgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFmmbL12J5HalLQ/ajq0zSQv9/smlcU0k2yvP02zq0g=;
 b=TPIWtJ2HwbPDrngdkmntwijOvPN+wir5T4FKu5ATwWP9u7poIjgpwkns7Z6iCqA539Sj0hpqRurBwe6GzL9DzHyBgAobDLW6nVMMT8cPy00FkZ1DV50qr5xIkga6IbveuJCxHrwxOx77FoFNi11kWsORKwKNYgrVPYRdZ1ewgWLu3fNi6W/MSkSKwDKhOPOvQbxswx/TlLRzEg0ti0yEqSVfRPcYel3VU3W4TMISSt+gtVlCHgHpYIzUi4qFCTl9iUhfocTaA5C3BADk003HKx0GGpNevDeCB8wyNgrJRW4kvMT4Xgoay1NrXjjtSv7tccJRJq5lrSl1jXYLf1Ytrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFmmbL12J5HalLQ/ajq0zSQv9/smlcU0k2yvP02zq0g=;
 b=b42iOmZ7liLDAfKInZuqjTQrMA6QI9AZQT31g84ZT5Z3d9tMRPMjoAaPYUI7+4k2Wv5RD+nqYrhAznw25BbozBT+Z+uUqloQ9se3ij3GzwBUhRaQR/PfFiNJOWxX/9TisfR96xyisUW3YMDknX9uuyiANepGWBSRVAUko5LOn9A=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH3PR10MB7139.namprd10.prod.outlook.com (2603:10b6:610:127::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 17:11:44 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::adf2:9029:9b90:56f0]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::adf2:9029:9b90:56f0%7]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 17:11:44 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     zohar@linux.ibm.com
Cc:     dmitry.kasatkin@gmail.com, jarkko@kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, eric.snowberg@oracle.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ima: IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY cleanup
Date:   Thu,  2 Nov 2023 13:06:15 -0400
Message-Id: <20231102170617.2403495-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:510:23d::19) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|CH3PR10MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: b1345cc1-1a09-41c3-4933-08dbdbc6c9b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hZtP9wxwy5/+4+JTXo6lPn6r3jAP4n3jFy22nbTYWO36V5SJNuvGlB/aNBvjuB+cfDSFSDh/xosk2KchoBsZDKsHUYky9fI67zTY7MglED4PaX3pq35BhnEiSavda01peJfBb2XFTPARQ7UcFEL/PHKqxe+ixvOHL/xw2LKscKZOMpNLr9iLhOFI+yqivMsHpzoacmNLJY/SS+0JZJC2EE3iOXf0+OIpOZ7MU0NEw5Y/65UC39hEURbxYrTYtHkT6EN5RxKwUk1HKWd4kjdQXbxvB/E0nlw0KYd/RQ21+4YllaL4az2ICN5G2LWuPpcaUT0JCd0rQGRHyInrmyff/X/PnfGra4+N6JGXwULGOdDlPyEUciBdmxRrEREoLEWAWPdxIIoPq7J5dhYiNbBQptDnlJJ/Oi3UaConn52qbuT7hN04JNa198dV3UsWgYslq2+8VCDcKSJa4E+sOqPNlYJynRLYUk6xJ/50wYJgDnmJfUtcPRO5SIrbfQQgf4QqCmBzS7m/0M02VkE+vr5QhNNdgFqr4Vwn4Mof6JAhi2O/wdKc0KeGfiGD6BukVUwt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(5660300002)(4326008)(41300700001)(66946007)(66556008)(66476007)(6916009)(316002)(8936002)(4744005)(44832011)(6486002)(2906002)(478600001)(8676002)(6666004)(6512007)(36756003)(83380400001)(6506007)(1076003)(2616005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GWWJe9LkJezaN6OlBFDY1FHMihRDC9LbRzqrwuygeKkM6ZqRVx7h68GCBmPX?=
 =?us-ascii?Q?QhZ+cRGfnTlcvBjo3I/rDI8P1iVhg/jBqFubHpzt5iMnSD4377DmCPqBJuqU?=
 =?us-ascii?Q?YXkNrP1nVKOoSqK86fGxvJdQNX0ZjrhrAg24TpRlVRNThFrHmtRJOFvGA27B?=
 =?us-ascii?Q?Aa2fI7NMBaBJ01zuYH6oEB/w+BffMmN95APsj3/tPPpBKk8Vtd8FRwLcoOsY?=
 =?us-ascii?Q?Cz0879jjnFrSH6F8Ud4ST4ry+WEC35Kkpsu9AUzn3nWYTRYTrBesjWRt4Bz4?=
 =?us-ascii?Q?N/hqkgDTRhxHSDRKz538YNTM6Z9XpQFwSgqY+QBhkDAF+Z3KwIFQ7AkM79Rh?=
 =?us-ascii?Q?D39YFiCmeBFgrh+OD4o+4I9B0Seo7DWwrAWleFaf8Sn2CNN1SrkkWjkyFSES?=
 =?us-ascii?Q?nCrjY4rB2axj1/njdyPqv6Kn/xRWwDz9Dr5MnX0nLg47dBLM11kIYeg9jk9w?=
 =?us-ascii?Q?SBiWBshUFP16RP8LW6D0ddRga5ma/dtQ6j6oz3vxgzqshUbbzhQwwj485A6W?=
 =?us-ascii?Q?qtRSiJnQfMbwkwbOmrnVHYwdr71F8CEGE/LHN7kyu0dJlkO5w2dJfTDjZ64m?=
 =?us-ascii?Q?ih//kEAGVF37n9g2riIkbnYBngnV8yAV/UUIn+jZ+u7CgBvf4mnu/zsQH7iB?=
 =?us-ascii?Q?vvS99jsp0ZyGOJdrCveJVhJ54KHOoIh3u41fqjVFL13vfJIvxexkWuQgfZoR?=
 =?us-ascii?Q?j3YI1/VgmyZDzF6t6nEI2rFp1Z+9NbacL37rgEixsJxMHf+8IABBz2qwgHw5?=
 =?us-ascii?Q?9ZtyL2dByn59kIvBlbDvj/gyUwJX8GK1UQNgE1/x/cWIDoI40wZSdv2cMJUN?=
 =?us-ascii?Q?s6PZMa5O1auZ+TUr7un9ln1F6RxRol+C/CO9AvevVFpsEE9/Y2BFx0ETSUbl?=
 =?us-ascii?Q?MtaQ8IPEO7CqRNwLmvlPUzTwlgAx/KgTAzGVWbG8Y1x/H0OJyTH9n/wkJxlm?=
 =?us-ascii?Q?R7jbswuW6zxBQiZkrE/YCByQ5QKUEcYxNnbphQIGwKT34d/NUNPFyYWYPl9g?=
 =?us-ascii?Q?PxqG11c6SOKUzkY+eFQHBz723LOH1bCGbsDz08Zv7AHSS30buIB3hh2hn2+h?=
 =?us-ascii?Q?bjvpI3eifijqgLi2Aet5AW4ON1P5I+PdC43bPMoDLY+xJ5KJo6FjZnA3QPlj?=
 =?us-ascii?Q?nWsT8t2e9pUzNXY0lTpM72CC60bO+rEIXMVUTYrca1qO27GRiYlp9Hi1ZOY5?=
 =?us-ascii?Q?QF2DdEkvR/5zG7mitVtsFry+t45hr4vuNnipVyvDSzMupfa/j6B143zgoY/l?=
 =?us-ascii?Q?r6rVOcuhz2J22wJI4QESoiFmnq9bNkFzT4pxnWmCWwZLvB2xMQagemM8QwFC?=
 =?us-ascii?Q?2GJrdBzEJGOWpYmMZRqX3U8uRxC3SuAreAklv7j7cyHqPv8P6lAPBG2zbN1L?=
 =?us-ascii?Q?qMxoiYBktJUJUju5fUPslwQ36tlTzqbWRAxanMRykymLX8D8RGuQdjn10XpM?=
 =?us-ascii?Q?8vyqUMfjpeV5W4b9Hu37Vv6jefZQIpP059dsKfOo5TDKDdxZeVl/iYuOsrVr?=
 =?us-ascii?Q?g/hUedoPMdYZcdgYSTD8i3tt45xiO1HWfF4CiOKqXERzByE4aQj2dw2S5nMJ?=
 =?us-ascii?Q?ssnTB733IJDc8W7vnvfDfA9P/7Nh7Oazy0sdZAAZ1hJoHOxkAF6zoAiooYFn?=
 =?us-ascii?Q?9xlKrC90qUYAo8yQ4TxRrV0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?llRgFJOTiRlxE3mBN8u4KGTr3hJ1s1yUbORAI3U7zYRnYbfGVoebQG4dkG8l?=
 =?us-ascii?Q?08oKMKFLE/n8OUuthksICTJngsrrPLC17oVTF//fBstUdkVEv7bwOzbjxK1w?=
 =?us-ascii?Q?NaBRpvvavbkp5PLiJc1MWhLe8nJqPYZHni/Oz1kgt8QpWZZUBVmiGWSOQeQ6?=
 =?us-ascii?Q?O36q8Nyrax9tyBgE21LFYnRUa4J0yhs5bxNQjEjYa38Fc3w2vWYhflyA8qDG?=
 =?us-ascii?Q?uDNqOhZtjvfJA28LlzCiUagJK39rleYsQJMbR/waO5F+tApfwRQsSRICOIl/?=
 =?us-ascii?Q?H9mJ8Gk9eaqiO66Qe4pGk4RfY3Z0zmKuJ5HSOV0GAXljGbpXD+hImq9yYIR4?=
 =?us-ascii?Q?XCQhL8tm737G2PCQssupHXsepP8jMnZMQa4h/C17gWR/seVgJHkXK5QSyPmI?=
 =?us-ascii?Q?DbYXbclEzkoOCSFLNQftxlOEt3xpgAxcLu5zurKahB+g6iwT4kdm4CHAXm/8?=
 =?us-ascii?Q?lurgTguFY1WCOJBX+s8/cgsV+ny2UJ7eAsFpzVQHzPdUH4RKtA3X5u54NjiW?=
 =?us-ascii?Q?yqQHvNu9rI9fuBWVAc9StjM9kXxOoOmMP2LbjnDp/KDue9DYMoHWwK8pEu6Q?=
 =?us-ascii?Q?O1Nt7QWWXWxVLjFtyfAPzLujuOoybN1BLjhgiqneyFsLECXTIQiDGJ403kqY?=
 =?us-ascii?Q?Ffy6ru8fmZdSeozmXhNepYzTHGe7SW6eRa4qkezFrIhLDLj7yQN0j43tmIlu?=
 =?us-ascii?Q?eujx+iSvaYaFfzpkwNPkwDbO5Jn0pGx7PphGJY1iRN3llELJ+TCMo3IliUL7?=
 =?us-ascii?Q?zEX7vSKAdDiql8HyaM4xUmcL+nT+xDBpnxfEHXCjoZXv0z3LZkSuaYnqkpqM?=
 =?us-ascii?Q?MHTpPU158dhR+919dmxE73jrpVoUyn7AOY3CclDgljfl5xNzId+TaY3rwLNT?=
 =?us-ascii?Q?dSkQWBjwg3T1I8actqDJmkLlSfzVPycN9fFrLqL6cfc3yWxETzymTcsB9hI5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1345cc1-1a09-41c3-4933-08dbdbc6c9b9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 17:11:43.9605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FckmO9NPFgJ6a4s9Bby/vbfsufRCUqLDnF0vHzsA+t2zHoodRtUBaVeJKGa3cHSYP6PpUJj+iia48hoqsuZYRipWVUWA72WUm28+0v6gvy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_07,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=609 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020140
X-Proofpoint-GUID: 6mkTpPighDp1STLUGJ83d0b0KgLRdkmg
X-Proofpoint-ORIG-GUID: 6mkTpPighDp1STLUGJ83d0b0KgLRdkmg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the information in the
IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY Kconfig.

Eric Snowberg (2):
  ima: Add machine keyring reference to
    IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
  ima: Remove EXPERIMENTAL from
    IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY

 security/integrity/ima/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)


base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
-- 
2.39.3

