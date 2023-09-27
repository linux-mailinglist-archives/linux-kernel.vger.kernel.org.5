Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935907B0995
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjI0QFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjI0QFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:05:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D04193
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:05:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RFslo4006104;
        Wed, 27 Sep 2023 16:05:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=i925ATwJ5OzaFKtSYuUijzeMW1Sa/u4mDt9np0ZF/mY=;
 b=1jdKO0L3+HZKWWL3pKCbHtSquVl6UdEeHRr1K+GwE7fjl7cVXri3gY3ozNFxKLCD8VZ1
 U/uO3FYa7+VXVCp1nJFNvtWI2oZL2y/rpWJXR61bUpUhrDkdFB8aY161fCw0w3X/OWlC
 cPou3qwQAVdnoootIpZBO16fyVj2ERNdpat8DNh1PjyLVplBO1gfet930VJ+XitkPnpK
 xoYYUpUlTdtFu8HhVxlW7X0gwAwmhyfFmHZGRvCScOAkzBdSP35Hfrvc0dVxwygMk1Mh
 1aKmhECllg0PvJFzvZAg9GatmR06XEb9mJgADO/OA+GOvWRT/i2x58UyufdNVTJMjOwq tA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3synq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 16:05:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RFPWmM003267;
        Wed, 27 Sep 2023 16:04:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf8f455-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 16:04:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfbznxgEpj8xT+wItVNoCccNzmHgk5Cu2IOo0NI9q2C+/51EsbeTPoVdWENJjvzXbUFO4F4ikgC1ysn/nqlZKp2KmK8eH6u6407Tm94XdPp2ZxkW6tIt1FS9qM7v16336H/9qWY11xIyMFJhIJ/kxMsNeeLXGymuK07VU1Jl4iPqVZA/wguWusrJTULcf2tAWu0pyLDV8ekkZPF9uzloBiSZbGkUoW0dMFVzQXGRCdFhYU6CecxD/GugD7QLbbln/tfxz/Jk+ZFMKdlEdCp19XZI9ffsmVgMnvbeIZvVKqWd/P33i2hXPt4j4isuhPMsOlf9jsTRxhpS33ERYYhLhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i925ATwJ5OzaFKtSYuUijzeMW1Sa/u4mDt9np0ZF/mY=;
 b=ToB/L2Ud5NJnF3VaXJ0UbxCScrHXw5TCOkqgBF9aaJnKCol58NAKKOb/h6+dyd4SThQPHvxXWQ6kYew9m4IDdljj+LcEO4/zG3oYpX1v0hM3ZQvmd7Jfv/fc0XDkNVAlUSri1G0Huy0dxOJgyxSlZzmHeuCNmS9VReEsXkefiNJMZLHjI1ojaoux5XnnCloUbZkt873f9P23qFmVR44+v5fskUCZ2Cl1nbPgrlbJgZ+8KAcWSnRFBqA1GKHFZgnLWj+GzVloLrtXMn/Q+zykOHhelenQMuEZggWgqlMHi6G83iJEs278cwNPJDzBIqY461RLWmFvUdhq4ZvXPtlp4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i925ATwJ5OzaFKtSYuUijzeMW1Sa/u4mDt9np0ZF/mY=;
 b=ua+6q073i8Xt2pnc2I0i8OU2cHZYe1tIrRsGv/j8bXlfh6uUCD+VZVZugtq0rz9zcpBAq+DXGyMR+lgioGfZCGfcty1EQ6LGWrRqnfPhsDId5+D8wspRiakCWhbAHMWiNV1J9d0hXFs3AWM2Nd5jqsItmfor33oGva02VqR+QWY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 16:04:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 16:04:56 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 0/3] Fixes for vma_merge() error path
Date:   Wed, 27 Sep 2023 12:04:40 -0400
Message-Id: <20230927160443.1927534-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BY5PR10MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: c88d57df-2d62-4c1c-07b3-08dbbf737e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2NDl0uvijYlmf+y106RpXh09KwTbmSwq8xbk8NKnQEJmcaf7OJ74u8kU5g5WuC7CoTx2TfP/EAOaiCtCLbajvqhhUm3CcaOv0u4PsXPQEPGUeLzWZw/Psy3z2kz4d34JjYnyGCJdfgQyj2YmShyBiuQ9pmzFWK3VuEsC0/1ZiGVQNNv2Vv9h2Jgg1J8jBE62yxeaOhAL0eRhVbo2TeKJFquPrz8bLnzoucJzJldiu2VBne4mqnpUacyVbN7uGF+6Gz9sPjeDUhyJ1RpVodMLJIdGrCaLZF5ustlJW7giYac0NhYZ6RrYPOcWDD4NuucTXTvpTlH2/970srg+lihL9pSpHJuqxz3rwNYkY/BJLxKxw9BChFLa/7KYVlTHGlLY5x/6TbBTmJ7DQIoiucyGdDp0LMlD0Grc5AM8G43XBqgsD3latHCjoFNfWG7aJMv3MfxR1gx2vDmw5cUDscD6orsUusbSmK/T2K1NTSdF8NR+xjS6uhXNydWnN4KviDjL9vdBhNN8J9ahzRtmN79MWqxm1Q2O46Ovvmba5/iTG22x3lAktm+BClR8PNuuir8M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(136003)(366004)(230922051799003)(186009)(451199024)(1800799009)(36756003)(38100700002)(86362001)(2906002)(4744005)(66476007)(2616005)(66946007)(41300700001)(66556008)(478600001)(316002)(6486002)(54906003)(5660300002)(6666004)(6506007)(6916009)(6512007)(107886003)(83380400001)(4326008)(8936002)(8676002)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OFKWeC3fVYSTdV1zDEitvgqEz7BuYzkln50cKw3JCM13lI8MO54tBgfNYWNX?=
 =?us-ascii?Q?QBYGTVOI0c8dec1r3GF3fH3b9mjEEc7OxfXLejzadt2ZrRF1xn9Leeqv2Slb?=
 =?us-ascii?Q?DLD4vecWmOGDCl++VtPJ90FTqXiy3ySxRMIfz3TmPbSOcd7RaOIpHGtDNQAo?=
 =?us-ascii?Q?c26WOD1seI46OBheboHj6pgLdigzUzo9Ti82vIXU/Dnfv4URJcOpAGMQ5Qa3?=
 =?us-ascii?Q?DPu74D+peMq9/kRexjOHX5f/5Pkd6n7Nl0B9Rmwkg+W5NT1xqlaFf+0ThCkv?=
 =?us-ascii?Q?M+wRkztFcuENJA/6K1tHapHGtiakW3xi4s7ynO2CE+wclG9qYdLPXvrsk6TO?=
 =?us-ascii?Q?4lpphvMlJZG0G7TI/l1g0rV6KAaxIOI5TQ/80kKv6vazFzKc59k24wFYySDj?=
 =?us-ascii?Q?F5Mqc0S0p+ZX5bBk/4al07iCIu8h3DjHVPCa3RBduNQn6xhlAAGw2l/tMXLb?=
 =?us-ascii?Q?hjwg5OAqIvj3Cvhnp/21k+NCJA24ElpqUCk/+TQ6zCECk9cE4TWoRceiGZmU?=
 =?us-ascii?Q?KJ8046C4gzNLCku74tTYxL8U7nmu7IojTTHFRozRqKo3TquHVhko7KmOfFp8?=
 =?us-ascii?Q?VHGh/wocvreQ79s2WjOGgTYddcdYQ7zYxerit8nN89d+aou0Kr+S2nUhlm0g?=
 =?us-ascii?Q?iwnTrqgo8jIRLelQDadpHWtVpvVyRanSoXkYsv7+m2h1vcCdP06jTbvLRAne?=
 =?us-ascii?Q?x7XShJ5kARgOGF1s/szke0hzhAW6cgyYtmI1JbiznLWOwk3ep0lHwBetkoKH?=
 =?us-ascii?Q?YJ1wfDghVa4TuYgVk4VYtWV546SVxQRgLvM5PRto2U+915h+ql1M/Qc2SA2L?=
 =?us-ascii?Q?D3NffSfQ9oogQP3MGgrTCRF++6g3qsD8KVxlsiMww3VuDTb80+9f2GBZu8XV?=
 =?us-ascii?Q?0VQI7AhsS0x/bG6Cfc6GbQCdKmfrtKzezVZgUXSsHIR7aBVkcEcNbhE74h9k?=
 =?us-ascii?Q?pYNgt9raFUWHiHxUSMY+2y18hTWnggmPLfc6Cd+BduUrA0MfRY6AMgCiGBta?=
 =?us-ascii?Q?QiQQ+xalDvcrh+qJZfSdtjE5PYrwX6MNyLNYeXOCQNp7v+nnNMMJP+mTwvQz?=
 =?us-ascii?Q?TggYIN9ln7ILlEFyImsJs251ccg27bRxBOB0HOLX3TsO9y8ZvHG+Cp12lTGX?=
 =?us-ascii?Q?zwrGASgE/j7rdWW6TaCJpyyyztQfUR+YPXa+81WwcxL7hmsmT6j/u1yIFvrn?=
 =?us-ascii?Q?jLc/8O/In4cHGaABMA40zqOWkkV8DgG24mVUGzJI5LbIiSv/xp4UWeY2u+OI?=
 =?us-ascii?Q?/9OZdB0DEiou3udmXZNEzRgb/aJIrfSwhq0cDzboravLldDKXJ7HJWtiNZ9O?=
 =?us-ascii?Q?W3ZIh053sYWoq1kK6wNKgveH797ya4ipRAqM6a9WXbVzKXfeJFml9tOt61Gn?=
 =?us-ascii?Q?mKRpw2rAlCbcIzLKEKQhZzDKDqHh1Wfaot5hgoMyGGY1NzbkJfXKy5wf/H9+?=
 =?us-ascii?Q?EE3YBsmpNOsW2ubSVGz68WWjYOL4Tzm2+aSyuBIImqapr/uEvcguD72V+s8R?=
 =?us-ascii?Q?bAXZbjnYXxJFR1IJUKoyVOuBijbDzGZM6jB+W268mMDbPYisA7CJ24i7X9ve?=
 =?us-ascii?Q?A8ygDuohOz/x2hugF6iw0UPKbAmeRxLQC+7uSJy4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?jdwQeh6gP1kVI+ZttQ2f3OOeeDSMCluQb8kzNdHRuops91tqtdYIIs+kwlRd?=
 =?us-ascii?Q?mYFMWYz5N3BkGIDvPB5zETmEoYLYmnS/HnSfIc5/ciIe/U5hWgTzVhkJnAlJ?=
 =?us-ascii?Q?FrfgY8Ro6OympJaFhISoLzEHL+88XEBiUJvf/OnG+1pgDv7H3WvCGjChXPP0?=
 =?us-ascii?Q?kWhhcWP4G/ZCn/RBqxu6i8LRrTqRQ7zXv/OakbOt9yeFDlEysp/3z2ASnxW3?=
 =?us-ascii?Q?YgWozKK11/dWVgNhj2KBtqva0+aQSYqCKtXEoM03/Ht/m4T9RILqujFrDmxy?=
 =?us-ascii?Q?Y/mshpW4thlRFhQk+NO05/fTTWt43mbkPdNZjvoL15xjbacUsN8TdM2HrwLX?=
 =?us-ascii?Q?jezdV2B39wtcUmZC+aw2UqAusM3AKyBLGxfQPr8usf2V08PTTPhmYe60V/9X?=
 =?us-ascii?Q?ca6wyVXFFKI72T7bMXejHYtYlQn2uI2TEoKQoR20I93DOj6iE6u9QTjnaJYx?=
 =?us-ascii?Q?T7y49Gp0zFj/nq+zEM/d2y3U4nxV1cs/INTkodMELRYyrpfkeprPocLgftHI?=
 =?us-ascii?Q?hSbVuXcsKjHord2HIGBnU1km0ZxWtxG5oAATzOsirhEDSR0h9PYf4VDxBGYv?=
 =?us-ascii?Q?+Fou0YyOmfVGAm8HFk6MB1f2O76pcqTiMTvQfz0fGbj+jOwaTxdPmRnR7evm?=
 =?us-ascii?Q?MBqhg45EHMUYSa12sz7B78msA/KFEPaiAenXN5E/J8zOp87BdthhLYR5gyJj?=
 =?us-ascii?Q?nu+88BhIHz/RLAxGDjoSAwQK+Z2oLlAK8BwbsvVgqB9IjGMqqzjo38aegCJH?=
 =?us-ascii?Q?AWfO2oNaggJK771vTekbe6XMx4VuFvkRfNtEqOEDNk+oTOGGeWhLgBh6dksY?=
 =?us-ascii?Q?m7kiX58GS861kXT+OvmSobMwVxC8U1rEQh3IdYzDdaTaD8R1Sk5cYzV7s29x?=
 =?us-ascii?Q?ahJeXgK49af6RAvwJ7W1r31kBSpIVqzvY+4jC6UO4R0MfKvTiJWADO1otM/K?=
 =?us-ascii?Q?idfvAsfRUsJamCupesOVcS7ic937+GSCHKRJRT86gcadWzKniLkXIC4KGPgg?=
 =?us-ascii?Q?cqzq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88d57df-2d62-4c1c-07b3-08dbbf737e4a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 16:04:56.5252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xi/OqPpAyU6QazH6VTuWkLLnHZWbK1kxKd19YEcycWnoXuSBc+PjDhMSiHjRqYNMpZ5FmEFqTQBG0ITjS1JP+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_10,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=295 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309270136
X-Proofpoint-ORIG-GUID: xybcwYmAlghaDBQW_xWyFYJMJuamKdyM
X-Proofpoint-GUID: xybcwYmAlghaDBQW_xWyFYJMJuamKdyM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn reported a potential vma iterator issue in the failure path of
the vma_merge() code.  After examining the interface, it seemed the best
course of action is to simply add an undo path in the unlikely case of
an error.

On examining the vma iterator issue, another issue was discovered that
would increase the memory usage during failure scenarios, so this is
addressed in patch 2.

Since it is unclear in the code, another patch adds comments to the
vma_merge() function on why dup_anon_vma() is safe in 'case 6'.

Liam R. Howlett (3):
  mmap: Fix vma_iterator in error path of vma_merge()
  mmap: Fix error paths with dup_anon_vma()
  mmap: Add clarifying comment to vma_merge() code

 mm/mmap.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

-- 
2.40.1

