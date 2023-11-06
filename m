Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C757E30C8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjKFXMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbjKFXMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:12:20 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEFB10CA;
        Mon,  6 Nov 2023 15:12:16 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6Mgb2F007667;
        Mon, 6 Nov 2023 23:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=uAuv5aXQiANLa6avktd+szCJ5g5DQK6cNa+t+byYV/w=;
 b=eBO/+o0mRtv7fyYigyyRI1yXlWyEORUFJRk1JU1t85XZCDgln1htXsL1QfvissyQNHS1
 nDzes0rxRosla7en24Hvc1KfQREdxuXrjrpwEZyJNZO8niDs6tIHCHY3m1c2FsQVBfeh
 M+Tm6sCRxRTTbWLgrxkmhoeyK8J2K2PgWRoRYoaHvl/U4xdSGpsJ0F7foiumkvYbLOco
 mEbin8i27ZpbUnObuR+gwXUgzOx2WHrmfMVfrGfem5SDUJAk4pc5CX/BKxbstuCPWLY8
 siAAWspeFq4Va6IDkzDdAJkKnNyG/lYCTZEG12wm8OfInlxqqIYYg1AbGQMi43G3GXBO LA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u5cj2vn5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Nov 2023 23:11:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6LNQqR026782;
        Mon, 6 Nov 2023 23:11:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u5cd5xdpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Nov 2023 23:11:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnjW6R7+h7oNQUcUmlcEHi2riqDo9xSDUHOpTBwcXGYs6ufB+SxwjyfLYLWllVt2mg+aCXKDclpvCZzYa4RvVL2estttTqzYu7z9U5BSIyzyNt7TLM0JlsMyhhfWXoLpoH/Kh8y9TTcgPeBhc72Sv7K+ZzQPa229S+CNU52BKNfjJ666jMIMLtX5KmPiKbB63uUzBjvhtWp2gudUjbiJKD6rop2Y3NIy4/pGe6xVa61qA/yLxGp3eQB09RnvJJlBqRnLUvaJpEl9nuDYPIMfFXMrOqfbPGsyNCTcvPzAW+dzMyCTMa57giB11LWuDJgPPtM5psHt6nb9GnzN7HvXrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAuv5aXQiANLa6avktd+szCJ5g5DQK6cNa+t+byYV/w=;
 b=XdOSXfEHxOzYpsCvbSYsCBozwmhrH6Y6UR4QxgP9n9mRvdeOVrYTeJZ/twAPH8kTuGcVRHjT7mXrI9dfcPqEHs1jRGs/3ynk40wjhCrWLa1SALUdY8Fg1PUTSILjwaOC0grlkHWR9amLIaqAIxvEHWBlAyA69M5d1DpfmbntJK7ET+W0ZJrKla0Y037jmryC/QRA2vMM5Bx2Jf0IOnZA3/twkzS82hYtmSEfvE7DKuMxpE2RcyzcTqIn9qLu036i21uzGzRYhKckyyuKA6xdCi9bPH0NAESywEZ6IgXGRC+8aeV1sCJo4vOMedAIkECB2naG71Oy4RS6AQDCiHJJaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAuv5aXQiANLa6avktd+szCJ5g5DQK6cNa+t+byYV/w=;
 b=SmbnmMnB66265pyFlL7ktlfiSv/65KnauNaRwaSEcg/7jD8VP3Iv2QGfW6e2PwtzBkMl2NT1s4kbRCFUlGh3DLF9RkevJxeOe2JCloX/I67k3xyOdiXl0ev3Viesswh/qW9AtCCIwXyshCcY2zJw7AuxvbKB4Z8oUN0UvacfWe0=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS0PR10MB7479.namprd10.prod.outlook.com (2603:10b6:8:164::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 23:11:56 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::adf2:9029:9b90:56f0]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::adf2:9029:9b90:56f0%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 23:11:56 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     zohar@linux.ibm.com
Cc:     dmitry.kasatkin@gmail.com, jarkko@kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, eric.snowberg@oracle.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ima: Reword IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
Date:   Mon,  6 Nov 2023 18:06:25 -0500
Message-Id: <20231106230626.2730342-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231106230626.2730342-1-eric.snowberg@oracle.com>
References: <20231106230626.2730342-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:510:23d::18) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|DS0PR10MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 769efc03-cca2-4214-d966-08dbdf1dc562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uh+koWAHYRhusUTPq8WVyBYPI0Ka/Zj3bupdh1pTcLm9LPSP4sx9UwJ47yTjHaMnHhWKHvqaB54i3NMrTLbbRi5FyK1OrCJq157ngXj5gsvnFnE5MCi9KxmcedMI0PzubXxvpSRAWZRg3WLwHb4cmPIvAVCNolmp/pAaa7fnfJx+bIj/e2Yip5QJGQ4plJ85G2QEycYBpK72rhzcwgUy1EdIJP7h5ds6TWLCZhRV69jYgIIZx/FbeContUcF40wshJbt0QeshNRPkBcBgnMLqFLIcPtEWOlycGvlm7WVOs61bABFTh7pYNTvpWyaoTMDMEBjDfGidKu8seXqf4Qm2XZrDusmKRhSDuceL3+FEfSh88mziZXCWe7/ZdpyIxoZZc+wBXvsQmqJJm/OOGwm5FB11uGChgxV9qjSo0R2kZqSUYW2zSJNqyaxJBsv8pVN4ytnbde5Byn5QV7SXTcaU+SuGlqaMCa1ATpxn/CAd/ZmAtg0fiAes39lWDEl0wTZFf/bNbIsZ2QzDsRqlFBn+8pkTGUjIBexTbqjHnE1FCTs99C9nCK7cPdlCLzFHfwa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(36756003)(86362001)(2906002)(6486002)(1076003)(41300700001)(83380400001)(478600001)(8676002)(8936002)(4326008)(5660300002)(6506007)(6512007)(6666004)(2616005)(44832011)(38100700002)(6916009)(66556008)(66476007)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xQyr1+8ClT1Vl7BJ+VHKqtk4ZzCT0Shx6H1THiFp/iGRj74+/tLi0Sb25vrX?=
 =?us-ascii?Q?/ySpl1P+VgqcLyYOfnyy7bGt/xi1SerlmZBeD04KY0eA/RZH0B4ym9p7ntJx?=
 =?us-ascii?Q?ABWf2ZvCG3tDodLU5ORmt1cq0eNRAmGCI6qGHzcWklHbiMObAgd4t8NHWrgO?=
 =?us-ascii?Q?89EWvZ+h+URk6VJOJv/k4Y09x72N3FX5KsBvahcaBcU1Cp0yLGuXxafhe5Rl?=
 =?us-ascii?Q?ZKTBcELt0JpOpDKktwt2emaH7kSINsOpQcBDcfSoi8iWDqBP4mYQ/lcpE1ap?=
 =?us-ascii?Q?AcLxSfHyzxn3ItvZBtcUNV55cP4Fah3HHVyH07BwZq7/RQbpEFNThpzOUWU3?=
 =?us-ascii?Q?eJX9x4RlLJZQFz9PHWL9+tKTvWK+0C4aENwgty3gVK1cqzcd02HxdltvzAVC?=
 =?us-ascii?Q?Mpbhp0/qN4RWSQrKvB3oEwRqxXsLAG9GULNwqoDKUpWXyDASDGjbSTA2Cnnn?=
 =?us-ascii?Q?GrGS+hIPRPZLcBiCW2nHcjzPVT/fzsFYf/LonD7IX5ixoNQCucMVRZK3x+9K?=
 =?us-ascii?Q?FDMh8wLj+/X4+ns/qm/Hte2p3YCxoxKPN2F5Lub5cw4tl5AkwWpYBrYExYF/?=
 =?us-ascii?Q?o9m69PhnpEOM01isn3m/EklwpaYPh8BZNr4fB3wnyWDlnQBYSZ8pX4R1p7Q/?=
 =?us-ascii?Q?xB0s19Nw6eOJkVYChIbvjmRqbV5jd3nTPJKplhftGvXilTlzDbDP1rHt4CQU?=
 =?us-ascii?Q?rJbPM3QpvMZKbR0MchpXDLfc1QCslsrvFC1xVChV5bYb9XGO7zgFRciNTefB?=
 =?us-ascii?Q?mPHbSBuiIwlsM6WPqkJG4LP6cnajkN6PW/Gv3/LtYP5hOgMWKzZRKTzeQcst?=
 =?us-ascii?Q?eucb9FgRU9dApXbK4GojG8nd6+yRBVKNaBeYqZUnPq26ZQcPF/9h5unql0f2?=
 =?us-ascii?Q?TvfDbR0I6AH9GqcAG/z5Ie4mh2Svkzazr/YtkBuQikAEFyfdF45k7BXnPhE2?=
 =?us-ascii?Q?6eH4qWuiriBJQfuAp5v9wGXe1vRuD/KMkpc4wnujmnsX6wjx2jwRZQM6LxLF?=
 =?us-ascii?Q?rfSPZO4Rkyim+0IY4A84A3pSDyj+vZnBNPxXh9CHNmlT271/6P3hGtqwHqFP?=
 =?us-ascii?Q?UJC7tDssmqRQ04++5+B3BSMDy/Wj0/UeVjbq6QzpF5wnfg//uX4A4xaWM6B2?=
 =?us-ascii?Q?rc6++z6gy0z6+DnhNcurUivjf89QyziMQ5+9dLLsFVPwVNjxAtmrfYR1goBS?=
 =?us-ascii?Q?RGo5QTJm7eV6Z+7DDadkxEWC4uJw28Kzk+BuHe7Qci+zTNRQyhX+wxnYL09L?=
 =?us-ascii?Q?BeNRSyy4ULoPhh7Kcy6Ey/FEdonLCuewaKGgpwShng4FF9GMeqnczxp2nwSV?=
 =?us-ascii?Q?UL6GEGcwFymBNOdNteQMZAKfySn5j14AOpDQtN/f/mDqBalFx3M9k6ITXKe1?=
 =?us-ascii?Q?oXuu1OT9SF/Jku7EZPorLhzlIKkeJbTLQgSUU9ygE/wpsis03+QLe+nJdfSm?=
 =?us-ascii?Q?KwWoigUL7jdw0D8W3mOg5UvxdHmhbf92DHS+jWe98L62LMA3LXNFUZog6Nah?=
 =?us-ascii?Q?ZJugD55Zk2j7JEoisRSDVedlETGoYVQoKur3UjjkmgSm54q+TpxqdbVGBrLO?=
 =?us-ascii?Q?pxpOt48kQbY7XHc8o+jcxBOOlnUq92pFqM/VsCI815MNhleFIiYkbH6JCFct?=
 =?us-ascii?Q?s4y/tm/4ddAm6wvPnfbGV/E=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?REZ0RnTI175oKRXYl+kL1IjxuZCxjeehD2zTDjn37inWOEsK2ZOq4DvfUMn9?=
 =?us-ascii?Q?iowZc7PHNWT+Ew6Voqs1oC+gSEXDy3xnm8ow6oj4u6VrBliqnLAxjNdo7qRY?=
 =?us-ascii?Q?CMWh/ERwpYmtp6ylyYhFOiPNSC0RgpdjxBe8ppT1YE4AE0RRdz6JaAIdlMqK?=
 =?us-ascii?Q?lG+PbWRGzZCjEiYpSxBxfTZ99tDUVKmTrJURD2iO8IYzF1IdyK902o85U65m?=
 =?us-ascii?Q?7f4WKa6d44vZJDybCH6ryLPgu0E1YF0AJPIpC37sz0usez5rIgLEOPMNlUcS?=
 =?us-ascii?Q?wwzVxJn3vpB5f+zzkpkX/Q7YXIChHaILIVet9its2AfDfOYcTvDlIQT+rpZD?=
 =?us-ascii?Q?b78+a0fV0e/9C1XXeJvrec/icbHpPMNCK3NMlFV6jQvk5nv50ZkwDhdfJrUP?=
 =?us-ascii?Q?dxDLM/wQwv1uUa1q8yj7JzO64tnDThXIT4dqNg2uLoXr2kiiI1LXrje/O4To?=
 =?us-ascii?Q?SiLlNR+xHmlupO+2mIXJp33rAprKnH1xuUd67ePZCBoNK7ifmdxIxW/odiVp?=
 =?us-ascii?Q?5vIeeDrrpSjelLLJAd8svHkznJ2CkTb3G0uPIfBRgNpA+ilfR2JBWE+jJKOz?=
 =?us-ascii?Q?UncnbNCifn3OC5vyHBYQMm/6anmuPueZJro0d4me3/MWFI4Uc4Jn0RPkQloJ?=
 =?us-ascii?Q?7IAcpXOlje4GyNaUCszW0cVQVZJ0SLdfjT86JV5pHTjwbCBeo3s+phiZRTsd?=
 =?us-ascii?Q?1IBcxbjZt5Zibg+ZFkCxGFlOfJ/CytIEUaB9lldvRKqxJBR1Y5qn9fvjvYq7?=
 =?us-ascii?Q?lCR3bpvVG1x4IQ4kdi24rm9vFOurIgtnyWWw2oVK/cavtxvV77hHE7ZgGq3U?=
 =?us-ascii?Q?6AF3Ei5Rfe3GCPf8KnjzkRWYEUBl1FE6F0WqFzrD6+NshH0uNO0PNs5ZhzUT?=
 =?us-ascii?Q?qTtQuTnQ9VroQNr1/CzogrWD8ULrPrx6jRGDyPJUUcVzAYUAI5O7HatesotP?=
 =?us-ascii?Q?TCoiZVHrDDHtr8GbwDzxIg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 769efc03-cca2-4214-d966-08dbdf1dc562
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 23:11:56.3758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCvj6gPI7BrFbfJPCb315EwJAssUV8vE+ZK7+ISk+7S70sIw6NwzgDRhETryX0+QI1qMuFHfpFaBY1BxieZexa7rqmzKjhN8h+/sUkRJhbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311060190
X-Proofpoint-ORIG-GUID: 8EHlRJTn7f4BrNednzVdqEYz-pnE_9DH
X-Proofpoint-GUID: 8EHlRJTn7f4BrNednzVdqEYz-pnE_9DH
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the machine keyring is enabled, it may be used as a trust source
for the .ima keyring.  Add a reference to this in
IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 security/integrity/ima/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index a6bd817efc1a..a0a767dc5c04 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -243,7 +243,7 @@ config IMA_APPRAISE_MODSIG
 	   to accept such signatures.
 
 config IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
-	bool "Permit keys validly signed by a built-in or secondary CA cert (EXPERIMENTAL)"
+	bool "Permit keys validly signed by a built-in, machine (if configured) or secondary (EXPERIMENTAL)"
 	depends on SYSTEM_TRUSTED_KEYRING
 	depends on SECONDARY_TRUSTED_KEYRING
 	depends on INTEGRITY_ASYMMETRIC_KEYS
@@ -251,14 +251,14 @@ config IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
 	default n
 	help
 	  Keys may be added to the IMA or IMA blacklist keyrings, if the
-	  key is validly signed by a CA cert in the system built-in or
-	  secondary trusted keyrings. The key must also have the
-	  digitalSignature usage set.
+	  key is validly signed by a CA cert in the system built-in,
+	  machine (if configured), or secondary trusted keyrings. The
+	  key must also have the digitalSignature usage set.
 
 	  Intermediate keys between those the kernel has compiled in and the
 	  IMA keys to be added may be added to the system secondary keyring,
 	  provided they are validly signed by a key already resident in the
-	  built-in or secondary trusted keyrings.
+	  built-in, machine (if configured) or secondary trusted keyrings.
 
 config IMA_BLACKLIST_KEYRING
 	bool "Create IMA machine owner blacklist keyrings (EXPERIMENTAL)"
-- 
2.39.3

