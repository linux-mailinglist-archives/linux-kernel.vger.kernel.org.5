Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270E07E2907
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjKFPtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjKFPtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:49:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F53EC9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 07:49:19 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6FkcTX027200;
        Mon, 6 Nov 2023 15:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=DB89cTA1fUIpnaQ4SV8enbXF8YcmstW0VPHPjs4vlsY=;
 b=TAx7XMJGrNIClSTk+SyW+8oCJuFZpbzSP3zy1FzgiUFwswx6yiT9tOVIWRWQhdXFG8mn
 5HCJzFyB7gZ0sEatIMZJ0dXoQJh/wzr7zX4puYYqrI6cNELx5eGfkMX43wmMZcmaCcz+
 sOLx9dzVu6dNSqLYy+0qixK5wecGnthkBUxqLMcsUJUvKmxtrMVHEHFukLrixNeIjkvN
 OBddku8TLUatKSDqu2CcGvwGqRW4c5NOLWkk4ocqyCCE1DIWiuP8b3Lz280hk0EDEFEm
 wlhFEY3zcJXDdZ6/+Q4G0C1Q3COHmJiCbJlUrrUBYe6PrYgOHo+5K0C1vPpyKdYXDxs0 pg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u5dub3jw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Nov 2023 15:48:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6FVW6N024765;
        Mon, 6 Nov 2023 15:48:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u5cdbjvpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Nov 2023 15:48:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/wTT1rErC+NpBpdrcXxXvpqvYYPi4QGSpe5bLIP/hUNi4lKuz1c6i1iDR8MYijoVmA/Sox3/CRdAhuA3OBuwx4b/3WgZPneJvj2KYQFeUu6px0QwISrs/ylHh7U5bYIy5Aoj3dpDJi8luTNCR12wyTJu3UCN2tytzLsZkAdUXLumn+/rNDmV+mpgILsx9EBKWfvZNRuNe51Ctz4YGDu18fBl5/RfbCbDl50epi+TGyZ/jhnAHiMgDPnCWCL6ScbAefNoyXfZzFEtOAPsQODZ1o2ewE45C3zN8wEalS2dSlAH9gJ9aTTTnAnLAbE8wWCk11Ub6WzzFKAoVaLTVh6cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DB89cTA1fUIpnaQ4SV8enbXF8YcmstW0VPHPjs4vlsY=;
 b=Y7ETobtgYgtu4W91N/q/cda0jAb5EeAjkHo5wDrazD/WTgTCoI2hSQ9CNcE5kuVaVt39MXcgUKaMtvJRsCdmgD13ajsqsO2+EAe2VXF/u6isouEiHUY4goo7LO4cazOkRwTR3s3u0fj6ZjKR6UUmlqgFwEz87VvbhktCXxahER49kZsbZlxZ58jFEJv43QgF39u3RMO5/EI7niaov+9e7+VqZeBlqJhdjcmQB04D37mb1y1W02EAx0QIAwYr8tXsUh+JITaIeSlZZML4BDXWMAE76oNSBCo1jnR/5Cz0AGdNu3vvlZCx1T7APXtzjeyvZzTpXejokZgLKsHz/owmmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DB89cTA1fUIpnaQ4SV8enbXF8YcmstW0VPHPjs4vlsY=;
 b=mo1eDsrd0VicmeU+CCLfQt+PS2A1lQyYFyb7l05d1LgNqQq8doUL46doc5vmiyyLGzorVre0970f8Xuw553vMrleVaVFo5DBcBCJdt4eLp20Tcpm7gW926/fhXx4ljoa/GPSIXGJ6zI2jS1P2aYQ/qBelzlbwG2wENJlhXnKrHQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4180.namprd10.prod.outlook.com (2603:10b6:a03:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 15:48:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e6f9:64b:ef82:2baa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e6f9:64b:ef82:2baa%4]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 15:48:51 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH] maple_tree: Update forking to separate maple state and node
Date:   Mon,  6 Nov 2023 10:45:51 -0500
Message-Id: <20231106154551.615042-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231101171629.3612299-9-Liam.Howlett@oracle.com>
References: <20231101171629.3612299-9-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:408:143::24) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BY5PR10MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ada49fd-ef87-4370-2aef-08dbdedfdf79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iGmAC8lfeB0PzmipIRuLtaS6aQewNBOgAIbLaCWNQvPMrlsWg08BmzY4bXxTujpxciNnEj//Px3UZGoS/adOVDoFjNYU/IP6QZaPYPBC5TJ0e2ckx/Jficl0S76jItac5vRM0J7f8HTX6mfKbpHgOTKNJwcCVd+98zM3WX3DQeK0s6BtsbYZ+F7UQzvI8bNM6l3XNdLkgbZTMdqwr2h1dgYy7sgIYfr0Tnww/TgGrW5vmdXX7Typen1wLU8Sa7wpLz06jYHMuMnijI+XlfW9/ZYUtzLoTwSRGiivZVa/edtVoVaY1Weo5pv4nMJHcUXlOjSEYrRc4ABQea6phJc+KwKfHPx99oLmScI8zh8b8louhk715ERd3DSWk9H6KVuEZS9oqygij2DRvW21R9bmgyo7g/cr3neAXxlFxiZLJ4AHB/t2qLP1YIz9BFfp1lnTS2vh+XHF40+t+fZPn4HTroGOuE68xPEgm37Q/0BXrDIHG70iODX7Sn0Z4RVBwnE4BLZ2h90w53yvBJaQY91vegkyfda+OyovXRqyT9Um7UUKPaolZUz8PuUQ2kXXk+2j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(15650500001)(83380400001)(38100700002)(86362001)(36756003)(26005)(6506007)(8676002)(8936002)(4326008)(41300700001)(6512007)(6486002)(478600001)(66946007)(316002)(6916009)(54906003)(66556008)(66476007)(107886003)(5660300002)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IVJL47fXP8iaA/zluAy2V+OrfW3bmsF6dAaEsZu93ynD3J3UmqwKdBRcJ+J1?=
 =?us-ascii?Q?79Df+8re20tj3OGRYtDOweqfxI2Gj4d6UoMGQASi/aIjbsVDKWxQfBgEGyOK?=
 =?us-ascii?Q?X7d0eeiP+TF4KPFxZMku7isUlF38osUgHyC+GK+oREO7dZ9CZ0Utz2UHrzvg?=
 =?us-ascii?Q?XM55t32cZRTd/cruGSwiUYRidhClLr1fv6jeck/L5JYOh6oCHaJQDYBv0+0o?=
 =?us-ascii?Q?C9fQVXLJ2zWlC9itsjbgotH/KsqAyewFBMuU3dmiUfiPm/ewLtpMtxmVGYUe?=
 =?us-ascii?Q?jKYiLMfxq3w8o+eEUAvn941hrZ7TsT3VRiMmWxqQy4/8835bBlFUnQvQxFGF?=
 =?us-ascii?Q?dXqwtOJrQzxfjzXtjQOSJgMPz1/jOYal2wXOp1466CCTrUAIjQjIrj4Tw9yC?=
 =?us-ascii?Q?n80jm6aYG3CCN7X9gYm6jesYtMZa+5ScT/jwQmUTSouwkfBxLQpdu0n8p18d?=
 =?us-ascii?Q?3MonFIVBGgMzwe1FFx9Km3w5hCKkOyqYLPm7Br8/HRC841JcLHJpPVg84fb0?=
 =?us-ascii?Q?J6kR+ILL6s6qqGxUk0H/U3egCJTetpeJbWbTwZmMK+XMCOo8iRtrM7y2Co2c?=
 =?us-ascii?Q?dLCcKG77ynNHglUfRVtFRyOCryYDFIdYzxsb8KuX6zfvAHK8ackfG2V8+yIN?=
 =?us-ascii?Q?ApfrVI1zR8KDSYt1kAUqdlx0OoK4aX8ZNWrH2L6fPHeleANhnlX6fKB//qg3?=
 =?us-ascii?Q?SZC8wYC3F6iWno1L4rJG2e3mUOalq62hNOdl5F4RL7/R4yaM1kCGMFM4i5Jy?=
 =?us-ascii?Q?P+eRyszoxfZOiKAhrsLd51mCejvjdGYjDcPAPylIBbRge/hwDaK7YeJwVDix?=
 =?us-ascii?Q?gQytZl82ZEJd1kgYmTvkJ4nc3hYVa2yVVyUcaK+X+fq5ZwFrPUMLxG/L0suw?=
 =?us-ascii?Q?+BJmSlP1ven0ImetHjBpRuNY6Kw9LnSUIEedonMqhDQrqfRfUC6AC/D1DoO7?=
 =?us-ascii?Q?SeL2+i5kw4P/njkoxL8orOVqP33Fs1MUxxbP9jNVOYiuJGazxhjTLPZ7MN4b?=
 =?us-ascii?Q?lqNiM3ciQm7zQFeGosSKN8VGQhU/MkrleTiFeOzMKRZCQW1PzmRzrnqV0DiW?=
 =?us-ascii?Q?NtCxYYiVWPG9W1pUc2Iu+QdXnPcJhtI+X9N7Viy/G/BUl8RRxIyfvgX4mFHE?=
 =?us-ascii?Q?8nwhhxvwoSopnH8rSV5bTX3z31+NWi3duosHJZ+yBmhYU2/5li4LQDWupksM?=
 =?us-ascii?Q?90bREb125zCfSbvFBZWqmsafhFwPCbwGmJ7A0Hk7kANv1Er+EBpJaVv6+Mwi?=
 =?us-ascii?Q?vyLhVKX1IlA2wukjCQhouKjqPFaa5ScCP+USFnZtgWlrA8hmR+n985E/Y02f?=
 =?us-ascii?Q?U+zbP6w6u7mQgr5Wi/boSiuW8rpJtMDXzRZyckBOnqaTrhzwEEKeB0bXT656?=
 =?us-ascii?Q?GT9zbdebEeo/xegTC8EEh9OXGbPZ3OBC6+07YKEGVHR2KfO3jsj2zXbjcjui?=
 =?us-ascii?Q?i2YmzMyCuiR69IMKXAO1MkVGe3x9jQZnPzi2hlZs0S2/lM0055wvPTOXrULa?=
 =?us-ascii?Q?ET5l8bZeYiwqzb8UWSEj/uyPjFcwsFZvumXx2iKq6qZscmzKo6ADiQlFaFsU?=
 =?us-ascii?Q?E/tu/EN9Fyc0SFsKilMScDRyqHvqANK4nSpLs6mJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CjDI80dgobTMOPzBOzmcPr/MLLR3sqPax7d0z2woTLrRbul32XZfTj75/miA?=
 =?us-ascii?Q?3QPYPDFKwUJkvjzD8Qxj7ZJUSKWEzJfuhrLcrvVch2xoUwI3L8iJWeWWJ9LN?=
 =?us-ascii?Q?OpgWvsqUx3g0ddTyQlKuxVzaGvA5LdtJpIKIhKwt6RO3XQrePvI2DgTcpiaO?=
 =?us-ascii?Q?27e6YbKY+FlSCD8ynN53RijZGl7GAtMOXl9IBfq4HGDyCKB1NcnLmxdZPY7p?=
 =?us-ascii?Q?wHB6wHV5j5wWlwXj7hfSeW3hYH1sDPNJiLjGuF5x4lZqs6mY9uUAx/vQs0Fo?=
 =?us-ascii?Q?mjY9sEDwVmYa3EfOyxCbwVangIDvEmX5DojMXR+mHhq+9XooOcMPiD9idppU?=
 =?us-ascii?Q?iA03zRA1ci2dmZqlEwHcTCms3BvCH6tkdttKlRKYPZd0/arCkOYkv2Lp3Q4E?=
 =?us-ascii?Q?uzCvmEcei8IlnFNAF2H+etw1LTeX6k2flBs+tTljAUEUNfSEhMTOj4weGhTC?=
 =?us-ascii?Q?hM8b8tBy2le36sBaJ25ZaMt4H3aI1OUhqKWDVjIECsB0+6m3q1dSf9sx+tnA?=
 =?us-ascii?Q?X7WkXoWsVuCRlOOKpHSbP3Nt79euyiT+499+h4QN/ncIkbXlVgokq38fnMHT?=
 =?us-ascii?Q?cXMC1gx4OLbnZfCSJTZ1u16EMOUy3/benqEPZM+5k3D8CGaNAHo6XAPSo4Qq?=
 =?us-ascii?Q?W0e3bBa8tb/BmQW3+MhhbpF+WeUlNd36FrMdWGhVEw2lKR21uLQzVhaNMKk4?=
 =?us-ascii?Q?sOMj2I3GFx58X7aNdmtpkaPBZCyda8HWqQvfmCrKi9T+envPqx/dpnOPeBTp?=
 =?us-ascii?Q?Mejq50yRYaDwrCHAJrYPAHg/7QRRhiiAbOX5hO6zYPOYzsRjZJdN7yX35hS7?=
 =?us-ascii?Q?NyKphvG8MeltpKD3fQIenKVrHBX/qhpq56DPvUeWdjbQFlM81PKHQTPITc1F?=
 =?us-ascii?Q?2WOH0elttiaeC7BGoGnlURGNX5y2MnJ0wpUIZPUJCbD5WK8o/tBVHy2L+KN1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ada49fd-ef87-4370-2aef-08dbdedfdf79
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 15:48:51.2424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4A+FIX0EgHOKXmto2Qf2yy1lgAaNkGwnJhukPZvlmO+FIiFOdFJ1SITccra+RZYL7NKXlYIj1ytHdH60uuFEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060126
X-Proofpoint-GUID: lWuLXseu9GgF44HKsiwgCGB4ZOQPz3xs
X-Proofpoint-ORIG-GUID: lWuLXseu9GgF44HKsiwgCGB4ZOQPz3xs
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a small change to the forking code after rebasing the maple status
changes on top.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c                 | 2 +-
 tools/testing/radix-tree/maple.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

Andrew,

This is just to try and make life easier on you when you apply the maple
tree changes.  I have applied my patch set on top of Pengs and found I
would have to update my patches.

After rebasing my latest patchs on top of Peng's changes to fork, there
were a few new uses of the #define states.  This patch removes them.

Please squash this into "[PATCH 08/12] maple_tree: Separate ma_state
node from status."

Thanks,
Liam


diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 59dd0e2325e4..85aac746756a 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6674,7 +6674,7 @@ static inline void mas_dup_build(struct ma_state *mas, struct ma_state *new_mas,
 
 	node = mt_alloc_one(gfp);
 	if (!node) {
-		new_mas->node = MAS_NONE;
+		new_mas->status = ma_none;
 		mas_set_err(mas, -ENOMEM);
 		return;
 	}
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 99275945e6d4..56ae47291ee0 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -35958,7 +35958,7 @@ static int __init compare_tree(struct maple_tree *mt_a, struct maple_tree *mt_b)
 
 	if (mas_is_ptr(&mas_a) || mas_is_ptr(&mas_b)) {
 		if (!(mas_is_ptr(&mas_a) && mas_is_ptr(&mas_b))) {
-			pr_err("One is MAS_ROOT and the other is not.\n");
+			pr_err("One is ma_root and the other is not.\n");
 			return -1;
 		}
 		return 0;
@@ -35967,7 +35967,7 @@ static int __init compare_tree(struct maple_tree *mt_a, struct maple_tree *mt_b)
 	while (!mas_is_none(&mas_a) || !mas_is_none(&mas_b)) {
 
 		if (mas_is_none(&mas_a) || mas_is_none(&mas_b)) {
-			pr_err("One is MAS_NONE and the other is not.\n");
+			pr_err("One is ma_none and the other is not.\n");
 			return -1;
 		}
 
-- 
2.40.1

