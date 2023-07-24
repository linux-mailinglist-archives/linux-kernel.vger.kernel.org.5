Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D3D75FF18
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjGXSch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjGXScf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:32:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAF9A6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:32:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OFONQo022015;
        Mon, 24 Jul 2023 18:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=FXPXjGpaCtsC+0Ps/QRAFiV4KxNx9qV7bNKLKH32hFk=;
 b=INJpAIC0s8brZ/OKSYim8z1NjxworaakTKPxt1+SjI3Xv+55ltFGw4svSFBXKvrpwAp5
 5Yp9e/taCa1RwgDGw27gWTSj3K+6VuI+gdDtEKfuxi+vrh6bMAca/9N88dWlaBVfQR9R
 Sl9IqQoan/TO8d8E5/4SBAQzv377cOX15DBMdg3cYHjRh2ph/8AmUPopcp7yJ2J7SDrh
 ov9KJNmkR6WIFjarziwUsex3n0Fem6ak5TuEX5ye4kTpnEC5fQzeQ550ZmhJYmXplzBp
 WF2TuoHnyflCH6sKuLa/KYegmE81mRIAWaCUHvTTpjkQ8h4QnU7kFrvaMKbOZNUMYpyy Kw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s070audkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36OGlZZN028603;
        Mon, 24 Jul 2023 18:32:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j41w8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bg1kweD3n9MhB+6ZinmkTjbxnqmXbabDSz44lhFj0kCUleW8SIRgnfXY8wLEXJzJ/Fbc/W91ZYDOCq4d5y+ENBj9fCsS1gvSzfpMLGabqvkcKqPp8ncM7NHo43ly326+EGu0tDgXQg0Fx38yD1dZG/sB256vEzzTHV9Y7hce4nkZQDD+0t7KjBApk+EXqR8eMG9wLE8frrOxk4kEY69MA4fI8pSysajAuUcB8mKxwQK65Fb+aXZFHcQr0cqQQIJoVokwjjSrwcB+kGLg6VCaC7tBAzVKvzP2bVjOCRSRQUo/5J3xygK5DkQnWPbxuWg9B4almYCWn8ye+6qK19zFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXPXjGpaCtsC+0Ps/QRAFiV4KxNx9qV7bNKLKH32hFk=;
 b=ayXf1zfupZCjigfXRG6qVHtxrorYFsDT8VdWnMXIO/bJZqLluaPxy8WxkCCv75USENi6nLLFHZ8/PBEjM401eYXZwmyEUS1QMtslNaLZ9hvIUkXr9q0zN/g404LjM8sDCt96328YdJwNHRTZ5nvg9juOk6z4PWkuMYHPJ0fMy13H36RjCRZ6D5fJgFXzxKc5+9xv4zmI9yMMMfcIzbumiHkEVlIdOlY1F+9pnWLbIYWic3OMNBn44dWIHi8X8Q4A2ViGeKoCdckMPKbF4ee/enyyMEDqbPjFZgJJgLZ3/v5/XyyFz2CDXrFRSk3SO7ozQ84K1Y+0tuOQTbbmMGe/bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXPXjGpaCtsC+0Ps/QRAFiV4KxNx9qV7bNKLKH32hFk=;
 b=zVAYs31Mw4R5mEY+c+U4R0HNO06GT0pTnr1L4EEQSMfQRUdv3OcwX9Sm8NTktReFyNWoxsP7m0HdId54qnaxEbX2L7YHIffeGrGz8JsIUYs4XRwoou/B7OzTBE1YxFvcIZYuZopVeqwJ9whn4AWwB2kxU/PDQjsqKNZuaSOXr0I=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB6654.namprd10.prod.outlook.com (2603:10b6:303:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Mon, 24 Jul
 2023 18:32:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 18:32:17 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 00/15] Reduce preallocations for maple tree
Date:   Mon, 24 Jul 2023 14:31:42 -0400
Message-Id: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW4PR10MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 96bb7935-7391-481f-c398-08db8c744f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xP93KmTGMZhS5zWR7nlpsp/RGwEVUzZvwL516Q3888OuZEqxWwipjVHiRK6HykDNbvNAK3ZxrM1wF8EZtNv64R2/5dd2Go3YIMIzj3U2EdRtY0G9p7Tet5iLlSNnfMns4cpETQU2Jm0K7W/LxivloBicwHdfWtyHt2pGVVLMF295UanmIFQsyupt4KLIm1ikTTJm3M6NfZzvWpHaMCuQNRAVHLTl83elLFmqO+ZZnLbQ4g3xj6FKjY9CInp9i4dI2kvIxgnDMnM56j5LPZol8fzAfuTsM4JwO1+JFWMrpeCifELLjs/vCuDWGWUXyT3Ej+qqd0tVA9/gfsddThhtBdDdIfgxxHwjYadW+R3fYM1YqHctoqJEGG304wBmaBXoBVaBOaNVCjmREIw3LVBZILsAFsUOn5hpUIk62iQJiU1Iiy8cLIHu9Q8rCroFLecfXQ+ivxkOL3kEDUBDTP2jnfvpLtG/vMaM51kO5tc2/L85l+kcM2qvBS1MlAFkHddl5TAT/FMxHeES5sflJjJT3N3yaNtG/A/zA5T+aWeZIKV1ADOv9SDFBggoazOdX/Z9ttDv6L5rNOAvn8QUjmK/tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(2906002)(66946007)(66476007)(66556008)(6916009)(6666004)(478600001)(6486002)(6512007)(966005)(86362001)(54906003)(83380400001)(36756003)(186003)(2616005)(1076003)(107886003)(6506007)(38100700002)(26005)(4326008)(41300700001)(8936002)(8676002)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cHWAaQS8fUIVV/0W3E1iERBB4hfMIVaf05mn3iW7kYAcrVyQSpcW/USaCmRJ?=
 =?us-ascii?Q?eDiyfCQyHZlxpZ/rZJmUS5gsOArbO7rnG00GCfi9Eafdw3PHi93dVAU2ckru?=
 =?us-ascii?Q?FG7LeDqVRqKCWqZcLJxijQyRSDFDgfm6atiBwudwJAHfuNOtl1R77NhcnbqV?=
 =?us-ascii?Q?lSe5bVe33Tk0/UkLxzsW+98UAJ+5qFYmwLyjRUZh+K31eLuyjk/enKMnGBfg?=
 =?us-ascii?Q?kh2glOVL3Y1EkPYlmI0gR6Pp6OIWlU6ZhUcDuqlYz878+i5V4wSIqP6+qIix?=
 =?us-ascii?Q?VFvRVlk49s0S2apKehmHkEpQZPWPsb++4P+EnvzpBUVqUtm3eBD5I011d9GL?=
 =?us-ascii?Q?NPeiJSXB6KtBuuLZqHDx38/Q2IFWND6PwUCQ0AM9EVFDlrJQOX0nQJiivIXP?=
 =?us-ascii?Q?5g6uFUpvGRZDZM52ns2Hgim00QkdisHkcZBF6eejymqVwo8loEj83W5Vp+az?=
 =?us-ascii?Q?XP+UIKR/lkiTvs0JBOiPQJBWoXdZK5le5GYPz8Pxuli7kpuX3tGDRD5hTTf9?=
 =?us-ascii?Q?BA4k/0wN0Xz+SESNaziyRp4K2rWe4yRIBHZeQRj0JzISoympUk0kcBxP9XWn?=
 =?us-ascii?Q?cd9lkIdby0GNBEKpdf0IGRhl3SSErozkxG+t5ca3Hw6gPLjJJF0YpNJY74E4?=
 =?us-ascii?Q?CNhn4cOT5kg+VtnjFL+REdKHWOITpuKpnwbkhL8aY27VfuoxdfxgnO7rARlQ?=
 =?us-ascii?Q?Y3eXRCJd7TQUROd5sBl+areBNq9AR5ZrUkaTQeGpC/oziBmyjse9///CrcPz?=
 =?us-ascii?Q?+mrr1/R0gTZ76XNzoKo5UujUDIT2s2TPgGSLnuyGsATksRVp28LArwBPgfkU?=
 =?us-ascii?Q?noiCXsp22xDROABePSsol7XCP9sccqbHiDwObv2dqGxwVGnIeOT+iKwvo23n?=
 =?us-ascii?Q?DjwN+IZxzEuJYMsBv5GVzdfUMPAWtCzLEO6dJPJok73vwAXzzuPQzo07Opbh?=
 =?us-ascii?Q?wDuWCDNddDVIwgQaYI0nOx5CvcfeBgzD0gfTyP1Z93cR5xwomvSigTY/lDQd?=
 =?us-ascii?Q?1ua7xWNg4vEU1wGS9yNhcJVq8WFyaATlmreuQ+0R/LSzWF7j2aRryMecC1N4?=
 =?us-ascii?Q?WA6q/4yfj4svPTCGFrs0JYiqyI4amnKUBJJAusiMFfH+vqXbJlBrAgiofCmu?=
 =?us-ascii?Q?t39e1GbrNiLMsMlwoT5+Xd9Rs0yvDGtgZUnuy2ZSSfVaQP0MwgUPfA6NMtiN?=
 =?us-ascii?Q?AGWe8t+GvaqM8+s2vc9yY0M9lQP1Xkq+derlGme0MICONjQN3vx8QnKRw+mv?=
 =?us-ascii?Q?UYp7IsPMcp21Elidl8rz21rPN/vKAesJ66h8kXjPbDze60oUlmfogUg5Fqdo?=
 =?us-ascii?Q?+Qhy9/inET1Rxmhya8OosNT+2dnCEqpzeiGAIbRNJqWVjX760B7CcPjkovQ5?=
 =?us-ascii?Q?yywsaLkgrtghGP7z3/QffC/wlxHO3xkmEtjJRGTo108EssEFgRpYj4Gcp1HG?=
 =?us-ascii?Q?KcBnx6n6eRtMIA8LDH5hlbgH6kseRjSFEA5fIm1y1rMPrlExO71nTAHoVNlh?=
 =?us-ascii?Q?dowgjAGLDU5CA3WWXLklE4Uq1syZw/m8Bb8FANikDrBxier/WMaPMpBS2/S0?=
 =?us-ascii?Q?iFLw9fZQ0w14uIaskhobnrZ0uCtmM8a/axyeDwX7FU2zToARlx+6d1TsO88E?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Mnl0FWZjgUXcAs2NAM1GVR/KgeoM3NtVemh8oi9/kAQjBD7skcAGnOdVWUXHc/lcn0Dn6RmurZuMzmXjTll3rWEDpo+wzoPltN6Z+IdU8rvvDL6BidBcvrfErgJ9vIu9mwLGmW3vdVjYc3TTd/+ml2+YXqNOd9J3i16BNXIX96ceIX2JHhSohdxI9bbqDiveEcbDG3tjYPmihSZbKu6MN6MqbKvOgn2kwAYcBMoFh3L9PPMGRl4LPe7OQcnmLYtFULXU92D3Be/nUrYah4v1r4eUFhAHprubmmfDBzV/YpsaNDodu/EkC0YRyHYJyip/IVhZdXHIMJcQ0hXOU/lIDGStxSVkDHtvBYtKyFWGHzi8EZ6iV0WPzYYMGtykE6wUB9QKD9N6HoJdycc/swC0i+qPzypbkbTJsR9C9trMH6AwoLqe/vCPUy+1DjfwY4Kz3Zvg+hArCs1f0jyMmGiYGuk5csZWRfYAgiUgl75Jo3h8BcZ4pxnk1VkOLNP8VTrQ0l6G2RNLTXffKpgfc/0YU+KMexryHVd4bM2eCpF+6o6chFm5aQS9DpLbyXuJal9wUqLofmybhAtl9vN8yfLZPon+TI+EI/2wKnwsduzOcU2juDR2UMbyaIFSP42fXkOLE+zqJseKalt0nEIRd9WRTemgmdkL7PsPMefr+VDfO6Q+BKjlh0su0qk37j4xAdmFNSTOT5hYZMFdG1RJVyI+LePOuley5Pu+BbKCEKO+hJZoWLegvH9xdb8hFniSvRDqcFhDdDxXCnTNo3R1LoizqJ+yuPi030NYpDF4BMNQUnCuQ5MPYN8gyvdPAg8+KqnLo9EdZrMksTTVOijYyho2SLxqUJJgApITHpGTq4B3Oo6jURr4gDU7Is2+yxZRguhYCHs2kfNxhfk6lU8J/G0zNpuDKliIsQ55dS2xp1LFUME=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96bb7935-7391-481f-c398-08db8c744f1f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 18:32:17.6307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGzes2Eo3sbJbNrNEsOJrjCC/qe8cwTH3qvvO8BUdXhUEhW6rDNia057xXsGv2PC8Qxifm+oPoLkWuvQ0JcYZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_14,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240164
X-Proofpoint-GUID: NIj1khmkR6pwjMmpm4yirPHp6kL2TxqR
X-Proofpoint-ORIG-GUID: NIj1khmkR6pwjMmpm4yirPHp6kL2TxqR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial work on preallocations showed no regression in performance
during testing, but recently some users (both on [1] and off [android]
list) have reported that preallocating the worst-case number of nodes
has caused some slow down.  This patch set addresses the number of
allocations in a few ways.

During munmap() most munmap() operations will remove a single VMA, so
leverage the fact that the maple tree can place a single pointer at
range 0 - 0 without allocating.  This is done by changing the index of
the VMAs to be indexed by the count, starting at 0.

Re-introduce the entry argument to mas_preallocate() so that a more
intelligent guess of the node count can be made.

Implement the more intelligent guess of the node count, although there
is more work to be done.

During development of v2 of this patch set, I also noticed that the
number of nodes being allocated for a rebalance was beyond what could
possibly be needed.  This is addressed in patch 0008.

Patches are in the following order:
0001-0002: Testing framework for benchmarking some operations
0003:      Reduction of maple node allocation in sidetree
0004:      Small cleanup of do_vmi_align_munmap()
0005-0014: mas_preallocate() calculation change
0015:      Change the vma iterator order

Changes since v2:
 - No longer moving the unmap_vmas() definition - Thanks Mike Kravetz
 - Rebase on top of stack changes in do_vmi_align_munmap()

v2: https://lore.kernel.org/linux-mm/20230612203953.2093911-1-Liam.Howlett@oracle.com/
v1: https://lore.kernel.org/lkml/20230601021605.2823123-1-Liam.Howlett@oracle.com/

Liam R. Howlett (15):
  maple_tree: Add benchmarking for mas_for_each
  maple_tree: Add benchmarking for mas_prev()
  mm: Change do_vmi_align_munmap() tracking of VMAs to remove
  mm: Remove prev check from do_vmi_align_munmap()
  maple_tree: Introduce __mas_set_range()
  mm: Remove re-walk from mmap_region()
  maple_tree: Re-introduce entry to mas_preallocate() arguments
  maple_tree: Adjust node allocation on mas_rebalance()
  mm: Use vma_iter_clear_gfp() in nommu
  mm: Set up vma iterator for vma_iter_prealloc() calls
  maple_tree: Move mas_wr_end_piv() below mas_wr_extend_null()
  maple_tree: Update mas_preallocate() testing
  maple_tree: Refine mas_preallocate() node calculations
  maple_tree: Reduce resets during store setup
  mm/mmap: Change vma iteration order in do_vmi_align_munmap()

 fs/exec.c                        |   1 +
 include/linux/maple_tree.h       |  23 ++++-
 include/linux/mm.h               |   4 +-
 lib/maple_tree.c                 | 117 +++++++++++++++------
 lib/test_maple_tree.c            |  76 ++++++++++++++
 mm/internal.h                    |  36 +++++--
 mm/memory.c                      |  16 ++-
 mm/mmap.c                        | 170 +++++++++++++++++--------------
 mm/nommu.c                       |  45 ++++----
 tools/testing/radix-tree/maple.c |  59 ++++++-----
 10 files changed, 359 insertions(+), 188 deletions(-)

-- 
2.39.2

