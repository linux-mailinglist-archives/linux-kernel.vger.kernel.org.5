Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779EA764113
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 23:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjGZVXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 17:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGZVXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 17:23:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5314E2685;
        Wed, 26 Jul 2023 14:23:12 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QL0HiL019182;
        Wed, 26 Jul 2023 21:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=phhxsGOQ3VoUQmCSJTAB3nQN15S9CFnOPSbcHOIyIMg=;
 b=W88PNrFzcySXx9IeN8nS6UOLPgtXRoTKnIIMzCeLogaYpXUG22w7DmRTkXtGmKXs9bUD
 rFV0HT2KfThIriR8QsXpb+5IKUVZnVYdCIB28zWbVM+dRanfhMDxVBCpu6CeL+zvQIb8
 ZgShftxSH8ljnTbX9kMkFNqZErJhQf+kNQAXkqnDw73v4XOLx6JE4echfheTGtOjMYux
 SlXBVGwsdvmdh/u1BtyUfhbKVlEIhZd1wWfgyW5kPR9d09O+r9fAAjobJRV5BTBCHwME
 ZuFUP5s99mcSbmmAUIbZEniV+b8OWag4YKqSP49NA5uUhtgLtP8OQycUdHuevIb/4Lyn HA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05he0f5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 21:22:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36QKfPqf033337;
        Wed, 26 Jul 2023 21:22:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jd2s6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 21:22:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cp5180kfA0UEw0zH+VAiNfYcKdEzWeqa1kF74E2ntUNaNZdcE4py+8B6rT+kMMTeZPawHMHCU+4SaeVEuaAYYmdeiL5znHf3icKyu1lz8gw2asy+ab7kJtIcFCKtXcVe+E0AdKgL14Uj7oGnc7HlnPIak36sCwhC+RhnfINYIGWTSlk/w922xrneKkiVcQSJ4e1os1/fYh63BigLI/tobOPJzmqOe+eXBj3vmhXYCUIpRTJJSQJchdCkWyuVyTbq1QpHBYhCAwTKhwSVGGK4fRioQeih/oDTvWIDQTnCy7R96yDLz7PYelYJsdAplejzd7JCjIT/BUqjf1bMsmH1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phhxsGOQ3VoUQmCSJTAB3nQN15S9CFnOPSbcHOIyIMg=;
 b=I8aSlNRsclz3nIT6DfEq6BwYRYMuzgH9UsfJJGdpPlGZ1JrEq7GrC43Ul4qx+sueIqwZaIazQsrl1CvDbwdIctqs3WtnldfvJDYMpV8kdRgSrsMQaBvVl6xw4uDJp04P2nzv/3e5ijEaWV5NQxU+RuCB3BIvkEI2WuRsrngG3CWK9iaELd2uS1AhMEf5gAaCiKltOPSJDD6iXkPQom774bXIElIDjFONc0Cq4KrVlV3vvArLTzCO91rFk/zobPULtrNr8EqcQTgwVSk77dFa/iImaDhKMWj7auWA2T07mNAWBaIBvXKJcCyL/tvQJZoSEKZdtrz2uT08snDcNM83Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phhxsGOQ3VoUQmCSJTAB3nQN15S9CFnOPSbcHOIyIMg=;
 b=m/dPcHozjyMAaQZWmDgf8SleVK/GFJBkVpPVPzWL96KJTlL8jAoaveiES+8CEEiInNHft0/Gv5uh5HGYNh6t/oDjZwrC+jQ7/d1+/xL7NH55qmYkVcKzOSDoWMTLI8S1KYy+5WRTD/laGs/Ng582cKdtbbvUb2WRLVxoNna7ZcU=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CY8PR10MB6801.namprd10.prod.outlook.com (2603:10b6:930:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 21:22:54 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::3f7b:855:6a95:8aed]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::3f7b:855:6a95:8aed%4]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 21:22:54 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     zohar@linux.ibm.com
Cc:     dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v4] integrity: Always reference the blacklist keyring with appraisal
Date:   Wed, 26 Jul 2023 17:17:25 -0400
Message-Id: <20230726211725.393056-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0133.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::12) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|CY8PR10MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: c810b999-b98b-4459-4b0c-08db8e1e7946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rncMLZuBQ402PlID4RUditO9iV1lOA3IhPHWAiWTinF+CYrJC6AqS6FA9a6GE8Zao+YaAn5f/0hcC9/vPVsG+1aOgX7/YOVZjRjGUVlUO9CUzxSj/NRro/LCtKYdw0Ws0PTr/oWOgDWfhOtCUGnghmxdHaErSnfLlHXeL4cl7cBOhIMx+2C7KgBrBtkt4+QXLRwwo8ZROMbU/vvjI+H6lYksSk/hsUSI1KvyhtZ9NRebVFaLvUAwwwTbam1gqSirf8X6TfAbSrMPOjD0u3/nAO7vnT2ggVwjKrKS+QxkCSZDbblyR9Z2ra51szVcfX2pVtKdQavCpHJJgP7kLXbu3NpmYHYKbxIUacojeMA+XDGqFPySCE1S+kzQDBJC0UQy2VtxmXcgVjjIbMXwE214uJvVKnmbge9udcRcT5HXJ/OznAzUYTdP00PrZQoGPH5ABduGhwiEdvDBfq7WQjk4VWiPzCs+9+Z3LPpdEvgKG1M9rb6mpYzJSLG1TNfHcSJ3nIjfkmbthcogJvXkPpECLIoQzZesrD4OTBfXF8YwCiovB+6r2vDtCIhjfRAixRG1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(36756003)(86362001)(2906002)(44832011)(83380400001)(186003)(6506007)(1076003)(6486002)(6512007)(38100700002)(6666004)(478600001)(316002)(4326008)(66946007)(6916009)(8676002)(66556008)(66476007)(2616005)(8936002)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FA7r6VEBRi+kAWBf/kbgd9PHhkpe+Sus9heiMBthJ1DrhLPx5a/1ebYEUMdN?=
 =?us-ascii?Q?tQ9GAGrTFxdYZRMXavbGDMOqHR1UnOo3qoZklie2e7wXBtznnoXdMcJtP3Zp?=
 =?us-ascii?Q?2AzMQt36cIaYBFMi2h0NqQFJ4AxY2/V7x8RthExoxy6ZMYv6W5eTiWAklYLI?=
 =?us-ascii?Q?kpMYFZJ4Nivo0KXpZU61P5AaOPWCO0Zzlwwcobp0SOWoYxqkDvjtXraA52Y3?=
 =?us-ascii?Q?CkBS2bMfr26ZqNtWgULqoPkZYwuqNVfpWh8/RI5QSp8d/QbU+MdmjmOfr3zX?=
 =?us-ascii?Q?hXCzA/R9QNXRgHbXyc2GCMH6ARcegyOScwzdkpLnUq9sCLtqTtGvE0gONQhl?=
 =?us-ascii?Q?JSmE8+Kj+Af+DT10LxEPm6BkG9rkGGnY5BeVgxodQ8QEYw2md8umT7VOJEAz?=
 =?us-ascii?Q?ry36ZAYcr2kTvgGIMpc+zL8MTdBtXFjj+wzZWd1hQhdDw2dZ4ttJ6AtdopmR?=
 =?us-ascii?Q?a7FFZ9uSVmRLS3xcRmcEQSqbavEb4ylcXlKUPP2UUtFH87TOJz2aAOCwseRp?=
 =?us-ascii?Q?fT9tbJbDBMGxtFbgD2uDSt013FZJdXnSypnjt/ezmJ9GzRGIAYVv/LboESAV?=
 =?us-ascii?Q?H0SSF4Rr5maqtL5HhYjvEfWZ+smHveCtTn2vC5gt3w0E9f63miQvuHK8gbwM?=
 =?us-ascii?Q?L2CPuaOb3yIS03XeC1M5xq6rFOOLMAPqy04/tCsKpbbJOQNJmqJJJyweBOB9?=
 =?us-ascii?Q?ldbnR6ZBjvSH7RdVutaQU0NXk7Wmar32McpQ2Y2hI3N+FTUzWEwtweq71uPk?=
 =?us-ascii?Q?v9aJNfrLI4sqaz9UVE46XiO0Ax5KInTJwFcsSkQgu5wDwvPji8bUkHc948EC?=
 =?us-ascii?Q?e/LlqHQMJ4CMIzkgVe4DJ3gdNsGqLb89zqYY6yl5nLq0qK/9t1wU78kbMCFa?=
 =?us-ascii?Q?SlF/gVeYbyEM3pyjdIiQmtflpiOHqYayhAGW85tu7uyGZ2ONtQ/ybavC9KGg?=
 =?us-ascii?Q?W2DV9cOLmpP8cfZUvvlEDq/6I1FJRlbOapR7qF2F3m9ab3zYr+XjYXSNMSgs?=
 =?us-ascii?Q?SNDlUI+wjHp2wzeH6Z19yiNmMCuSRo5qVTllXW7uHyvxIr35b/tm1XlLTCIz?=
 =?us-ascii?Q?RIBTTLM/neIb4xQxFye0CJIfnDJM5JWPum40ipDFWooSfi0X639CCw+KxVKW?=
 =?us-ascii?Q?jao0wO4wOizb0C+FFJQSECLzHRrl+2P1Qk5xgb3Ysgy6Uk81zMEfuvbz3cCe?=
 =?us-ascii?Q?kHVLUl1T8DDFVncHB4MRhjRskx8Vv84tmrOJoaeEYr9s1MnavVMow7a1wTMM?=
 =?us-ascii?Q?111VbFUslHMDXBc/dQ2Li/Hvb7EBZP3site23L8LjpgspBb3aO+zms8ZE+mk?=
 =?us-ascii?Q?Uf9sYcsQYblfqtLy7HFOadzUrWJTA5H8BdeLaiSS5PFzE6VmEZtiQ2YSGqEx?=
 =?us-ascii?Q?5+TtLEWIBJR7WMnHLx7e9lA3YOuBbebeQ7JzBFChRvlpiNd36flhD1qLiEmB?=
 =?us-ascii?Q?yJ4fsJIQTB0CJgrxYmx5Tt8XDCb7IPtTCi5SQ32o3NdVXezf4lLHEmKmiH+7?=
 =?us-ascii?Q?crgKZ0mQ+5wSV8Zu5dQNpUZVckuillmyRa3XuLvb59FjjmvHI+KKX0ArbJj2?=
 =?us-ascii?Q?ARAh5BYsA8ixeZVf49Fc5C3N0cA6xHbH66WxvspAWu/lEi+KM3jRTmeedhd2?=
 =?us-ascii?Q?QbVzUQJrsAc95dqZ8o7FW5I=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?QzmCWOc0TRgxaM1+shF8ieXGWmnNJZetIJgNhOXauPvzaGaCNQ+xuQGElp+t?=
 =?us-ascii?Q?f3N+EpWr7u9vFM8rD0PecXrsZxN9Ozp9rUbKMb3y6FtwwBz1Otmot3cpVE0w?=
 =?us-ascii?Q?ikvXx60vuXtH72Uo4kbQ4Me39n3vsXyjzsa7yocTCQHZkxvbx2zrmPHGvpyq?=
 =?us-ascii?Q?58iq3F9LwK4j6OFcb8gJvA/ONysSWu/Oez9EFu3GhOpE5gHlJ0SScIqQl0go?=
 =?us-ascii?Q?av4ki3o7S4sY+LSYwnbUNrJIgA0LaGu9freETatwmXVTC0+qrFvI+7lxRT2T?=
 =?us-ascii?Q?9dhVXMJmag0uQqLOSQjcA13p62z0WH+95uraM38jd9eKGIC9CofFCEtYx2Rx?=
 =?us-ascii?Q?XUgnx+BiemV51P5MB0c4YnGEyXHDF1sxhWwkzK1IbuDAlovNF1Ap+0W6/4ra?=
 =?us-ascii?Q?iE9Om1Xd/CwiK2pO7LxbMUSyAQHfxjOdzuHC0SLrc4qKAeb5ELctXd0veM/M?=
 =?us-ascii?Q?Wnawf56EgzlbnVWaGEFDz/to0R28q0p2ikEva/JOYY9J7ic/9G4h0D5YXZ/S?=
 =?us-ascii?Q?ccx8F3vhcoNt4/q49wcGFOS2E1nAxYiLMWCsvAk5wqh4PyYyG561OD8KgJR2?=
 =?us-ascii?Q?V7x74shnmEd08EGc0iMyLFGSe1viHTmwDDZzov3nn5WNRCCeisNv39JemedR?=
 =?us-ascii?Q?ZdzRj2NwUFQ/bGd72ASoKWVv0rzfHZhZD3oo92vYVB5vKFG6HUQ0h2WSqJW2?=
 =?us-ascii?Q?EkfdnJSQmk20iPsjnl2MxekZW9gnjBVeIvqNGnZrcMeZMF+9Arniu7KyHNVV?=
 =?us-ascii?Q?dMsAk9W4ntsTWWCadnkkzrsvsfaGd0muCA8lIv19WnTsm8TmHWOueNJOr+JC?=
 =?us-ascii?Q?7uHyFPvZI6jQ7dADRn2rpzlp6NRCYw4QQyfhVv+K+D9L4DsvoBVlNcI0Ycpy?=
 =?us-ascii?Q?/8oGF4RvEkQLTEwMGEjo4FkGzldye/F+gXiMHprsN2SOn1bGTBpPijqEmqcP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c810b999-b98b-4459-4b0c-08db8e1e7946
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 21:22:54.0914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9pfVwrxPAVNuIRiaiovaskRbmfEmAjzvj0ctv3MxrmDm5lM0Kj8TXqX55vzDlNeSOV2Xch4ULNqAyaVqY99qQ7Tj9jEJvKKHRP/T5ZCmJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6801
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307260190
X-Proofpoint-ORIG-GUID: IRbIFlrjb70RTNlRdsl2Lafq4C8vXFEj
X-Proofpoint-GUID: IRbIFlrjb70RTNlRdsl2Lafq4C8vXFEj
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 273df864cf746 ("ima: Check against blacklisted hashes for files with
modsig") introduced an appraise_flag option for referencing the blacklist
keyring.  Any matching binary found on this keyring fails signature
validation. This flag only works with module appended signatures.

An important part of a PKI infrastructure is to have the ability to do
revocation at a later time should a vulnerability be found.  Expand the
revocation flag usage to all appraisal functions. The flag is now
enabled by default. Setting the flag with an IMA policy has been
deprecated. Without a revocation capability like this in place, only
authenticity can be maintained. With this change, integrity can now be
achieved with digital signature based IMA appraisal.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v4 changes:
  Fixed typo
  Also did some performance testing with this patch. With the associative array
  implementation used within the keyring code, there doesn't seem to be much of a
  difference between doing  an appraisal with an empty blacklist keyring and one
  containing 1500 entries.  At this time it is unknown how many entries a user
  would place in this keyring, but this seemed like a bigger number than most use
  cases.  With the 1500 entries, there were only 7 lookups to get through the
  entire list for a file not contained within it.  For something that was
  on the list, there was an average of 4 lookups and a single string compare.
  Based on this testing, IMHO, there could be a lot more entries added to the
  blacklist keyring without any real performance issues.

v3 changes:
  No longer display appraise_flag=check_blacklist in the policy

v2 changes:
  Update the "case Opt_apprase_flag"
  Removed "appraise_flag=" in the powerpc arch specific policy rules
---
 Documentation/ABI/testing/ima_policy  |  6 +++---
 arch/powerpc/kernel/ima_arch.c        |  8 ++++----
 security/integrity/ima/ima_appraise.c | 12 +++++++-----
 security/integrity/ima/ima_policy.c   | 17 +++++------------
 4 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 49db0ff288e5..c2385183826c 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -57,9 +57,9 @@ Description:
 				stored in security.ima xattr. Requires
 				specifying "digest_type=verity" first.)
 
-			appraise_flag:= [check_blacklist]
-			Currently, blacklist check is only for files signed with appended
-			signature.
+			appraise_flag:= [check_blacklist] (deprecated)
+			Setting the check_blacklist flag is no longer necessary.
+			All appraisal functions set it by default.
 			digest_type:= verity
 			    Require fs-verity's file digest instead of the
 			    regular IMA file hash.
diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arch.c
index 957abd592075..b7029beed847 100644
--- a/arch/powerpc/kernel/ima_arch.c
+++ b/arch/powerpc/kernel/ima_arch.c
@@ -23,9 +23,9 @@ bool arch_ima_get_secureboot(void)
  * is not enabled.
  */
 static const char *const secure_rules[] = {
-	"appraise func=KEXEC_KERNEL_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
+	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
 #ifndef CONFIG_MODULE_SIG
-	"appraise func=MODULE_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
+	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
 #endif
 	NULL
 };
@@ -49,9 +49,9 @@ static const char *const trusted_rules[] = {
 static const char *const secure_and_trusted_rules[] = {
 	"measure func=KEXEC_KERNEL_CHECK template=ima-modsig",
 	"measure func=MODULE_CHECK template=ima-modsig",
-	"appraise func=KEXEC_KERNEL_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
+	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
 #ifndef CONFIG_MODULE_SIG
-	"appraise func=MODULE_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
+	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
 #endif
 	NULL
 };
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 491c1aca0b1c..870dde67707b 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -458,11 +458,13 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
 		ima_get_modsig_digest(modsig, &hash_algo, &digest, &digestsize);
 
 		rc = is_binary_blacklisted(digest, digestsize);
-		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
-			process_buffer_measurement(&nop_mnt_idmap, NULL, digest, digestsize,
-						   "blacklisted-hash", NONE,
-						   pcr, NULL, false, NULL, 0);
-	}
+	} else if (iint->flags & IMA_DIGSIG_REQUIRED && iint->ima_hash)
+		rc = is_binary_blacklisted(iint->ima_hash->digest, iint->ima_hash->length);
+
+	if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
+		process_buffer_measurement(&nop_mnt_idmap, NULL, digest, digestsize,
+					   "blacklisted-hash", NONE,
+					   pcr, NULL, false, NULL, 0);
 
 	return rc;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index c9b3bd8f1bb9..69452b79686b 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1280,7 +1280,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 				     IMA_FSNAME | IMA_GID | IMA_EGID |
 				     IMA_FGROUP | IMA_DIGSIG_REQUIRED |
 				     IMA_PERMIT_DIRECTIO | IMA_VALIDATE_ALGOS |
-				     IMA_VERITY_REQUIRED))
+				     IMA_CHECK_BLACKLIST | IMA_VERITY_REQUIRED))
 			return false;
 
 		break;
@@ -1355,7 +1355,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 
 	/* Ensure that combinations of flags are compatible with each other */
 	if (entry->flags & IMA_CHECK_BLACKLIST &&
-	    !(entry->flags & IMA_MODSIG_ALLOWED))
+	    !(entry->flags & IMA_DIGSIG_REQUIRED))
 		return false;
 
 	/*
@@ -1803,11 +1803,11 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				if (entry->flags & IMA_VERITY_REQUIRED)
 					result = -EINVAL;
 				else
-					entry->flags |= IMA_DIGSIG_REQUIRED;
+					entry->flags |= IMA_DIGSIG_REQUIRED | IMA_CHECK_BLACKLIST;
 			} else if (strcmp(args[0].from, "sigv3") == 0) {
 				/* Only fsverity supports sigv3 for now */
 				if (entry->flags & IMA_VERITY_REQUIRED)
-					entry->flags |= IMA_DIGSIG_REQUIRED;
+					entry->flags |= IMA_DIGSIG_REQUIRED | IMA_CHECK_BLACKLIST;
 				else
 					result = -EINVAL;
 			} else if (IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG) &&
@@ -1816,18 +1816,13 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 					result = -EINVAL;
 				else
 					entry->flags |= IMA_DIGSIG_REQUIRED |
-						IMA_MODSIG_ALLOWED;
+						IMA_MODSIG_ALLOWED | IMA_CHECK_BLACKLIST;
 			} else {
 				result = -EINVAL;
 			}
 			break;
 		case Opt_appraise_flag:
 			ima_log_string(ab, "appraise_flag", args[0].from);
-			if (IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG) &&
-			    strstr(args[0].from, "blacklist"))
-				entry->flags |= IMA_CHECK_BLACKLIST;
-			else
-				result = -EINVAL;
 			break;
 		case Opt_appraise_algos:
 			ima_log_string(ab, "appraise_algos", args[0].from);
@@ -2271,8 +2266,6 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 	if (entry->flags & IMA_VERITY_REQUIRED)
 		seq_puts(m, "digest_type=verity ");
-	if (entry->flags & IMA_CHECK_BLACKLIST)
-		seq_puts(m, "appraise_flag=check_blacklist ");
 	if (entry->flags & IMA_PERMIT_DIRECTIO)
 		seq_puts(m, "permit_directio ");
 	rcu_read_unlock();
-- 
2.39.3

