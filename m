Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E2B754384
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbjGNT51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbjGNT5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:57:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5477A3ABC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:56:42 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EDQexe029776;
        Fri, 14 Jul 2023 19:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=t5gb/T3w432joNG/2gI1QE1Bp6jtHJ86EE12igifPPA=;
 b=OFrs5lDp41gPQxhWpITgpfrYdOBC8G3kEnb3xBZKcEHiT0oTZL8ufwmD+XERCHnSskdT
 u9Ng8vr7Z817tAmNFr1D13w5AmH8mUzP2Cu301S5cbO1cSqNNC4tT99pt+eQLWFTWFDX
 tahm3mCiXBKJf6eGkPLL745OlUP9/A/gdzIR+r20xcJ5OO4W+CnT3y4Aft3LAAN/kvTt
 iN7tORAYNQYLsnMhci79gnuyfO9A2otlJk5ihKgIzCTOLNcDheftAeK4C+WhBBkoGnHZ
 8obyxnso7bpT72SSXvPwFJEdsdUyVOTlKr2Wk6eSnzDxqs5B5pxMSOZbxCwsLMEd0C3T ZA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rtq9ta7w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 19:56:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36EJnhnQ013820;
        Fri, 14 Jul 2023 19:56:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rtpvs5c4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 19:56:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itDPUJ2qCPHK5ks9sCAwl6d9gimOdXDZ/m0POltgJefoEVws37ngTWHUfC/GNOUsyjkWW51f1rmym3U4261qro1XJu31pZ3ifT5XNudKkPAqL2gC9DJ37fBqZDI17uJlrMotlYyGgD7sLu0/xuQmrWnmEE8vmO+oYEHEZRfPvbLiscY5O0H2Ik2x6q3LEA64O2ndmxfrY57sP+04SKZkn6WXh826tsAg59aOmZQLtVn85DGF4hlCKGaEjY+eIMgFy/B5smKUgceKeX3TED3seYOZl5/M2L1Go5MqSubWTMtaXKieqcOzoI2tOvL7tVZ+RYTCkcJTnP2bP0EbmtBiwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5gb/T3w432joNG/2gI1QE1Bp6jtHJ86EE12igifPPA=;
 b=lsEHITJNOoKVHPaaw+ig5odknVUGuEYUgZS+TXvVJsJh74J2jmos4v0BqLEUGSvl5zC64SKUHSPomGUe8e8lPAcRVS/dTNaVM28KIcmKVgdyhZ8ECwybrRSDz5TndfuiPKrFzYf+Srx9+LRFQ0lBMvNXJD3HOIorXoTgL+03zEZ3Nb8NEgWRVHadMMmPK6d4rPMyOgd7PoCnXEoT24huD7pzuUjUI2bfR1k5cXxiMgVD9G2/DFhvwr1GMz8WtI21T90HiJjS8TB2ZRaR/CplzL/nL0f9ABx/ZyBCWTznxOMBBfQsjiJohCOxSQq3khYyVJHXJ35Obee0qLX9hA7S+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5gb/T3w432joNG/2gI1QE1Bp6jtHJ86EE12igifPPA=;
 b=edwosIxv+KS6TWXltU5J1JQtk5DpqqSe7r9SK74YGI57bA/6xoSHYMR68MqncOjkwG2TukpW2AqO1A451MLbG0B2oMWWhghULRRnzAODe7h/2c+tlo4/CworvYrGZ0T2AQDUlq6QH1WSUGOr4153H8vXO8wAKI+Cx8am6OLS4ag=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB5922.namprd10.prod.outlook.com (2603:10b6:208:3d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 19:55:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 19:55:59 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Oliver Sang <oliver.sang@intel.com>
Subject: [PATCH v2 1/4] mm/mmap: Clean up validate_mm() calls
Date:   Fri, 14 Jul 2023 15:55:48 -0400
Message-Id: <20230714195551.894800-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714195551.894800-1-Liam.Howlett@oracle.com>
References: <20230714195551.894800-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0031.namprd02.prod.outlook.com
 (2603:10b6:207:3c::44) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: b093ebc8-040b-4183-b662-08db84a45866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kMx1/ZX/tHMUpMRzohSMRIgxklAjOi7eKNFoxT20aUdzYEpRmUMnGBVpqo7HMehSRUafbQVNkj6ZSWqBHFW2APzbfByt+HYuiVTS3PFIiuzYut5J7ynXw2ZUK8GcN+eG2zDnC2sDK3+0umzjGS9EVMShNluWsTtqNBw3XwVm8mxlfkt+2dB7GW55zFZeG5ez3Q3p0llHJqCZnV/2jxPuoVsimzp/2TmD9yCX31AuKhDCIus8V/ZEqsA8q1F1kWQoaWxhPkO8VOKI0r+NjNrCdG4ZIKUFu5iCTAgi45T3wqDHE4PuZB5gaJvpyTrMw6BiCDrcGirna9b4gkmo3GHF5DGYU/FVIEhufVGqa0YF2XuguKHhDRkvtOFyEs03LBpRoY2rFLusvC7DMr0lmMcHeATkMJ/JVtGJr+DG/rxEe3YmrXW5H3Od9jL8KlMQg1qWaMvGXOmYY2g2dZ6y5SW0uuo3rvJ4dmczrIaQ2+9ELtBTW8OAoV1LI/8yD08nvmoYPxWDhpj7I790Xjpw5T3BgGfm57nSYq3MOBVHF7rSPlss+QYr8N+/vid5JAnqTDLm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199021)(83380400001)(2906002)(15650500001)(2616005)(6486002)(66476007)(66556008)(4326008)(6916009)(66946007)(316002)(6512007)(478600001)(1076003)(5660300002)(6666004)(54906003)(186003)(6506007)(41300700001)(26005)(8676002)(8936002)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?14AKRdrBYrNKBpzYUHNrt4Sal3k2k1cPfHeVy4bcQGK37wxidessCqUPO/CC?=
 =?us-ascii?Q?9iJS4iD4yaF2uRdsm4Oa+QlufyX3aq4vXWeuyQLZWHCZuHEd5Va3ia7KXXDG?=
 =?us-ascii?Q?BsLju352tY+5pAYTx80QyB+DTM7vv5kl+vvvwcoYI/ALhBqV5LChkwywOQje?=
 =?us-ascii?Q?7xbvyEJwO/3ZdRg2b1DxbxK1DlSCI7grsixKqLfIq/CzexStTWFklNmbt2sg?=
 =?us-ascii?Q?zkazrAUwZqRuBI7zDTE5YtaJ8DYmIdEmQuJWs5GZv4q0cSFtxYc790OGLpHk?=
 =?us-ascii?Q?HuCoXrfembFrBuXX1oh92Kz0q5UuWNDFE5vUYnjVNADnb9hGDLKOnPGGKBRs?=
 =?us-ascii?Q?SvfGhxZvJ3CBkoGJjA/OmfbsmY66RBKYFlctyvAZUI2x6xEVL1Jy+R4BaJd8?=
 =?us-ascii?Q?IfOJQN9Nlvl1dpeiP+W2bx4dYBTdNUuazJd9jz5/AeEFHN8KypuJxIENAnjm?=
 =?us-ascii?Q?m+ZIhr5H3agoCi1IvxCGbRFxqsJadEcfjiXbX5SU8oBEjaYmlar5+jMPT+CF?=
 =?us-ascii?Q?hL4U0cvj+UElW5Smqpe2qsCp7w6E9fEY1UDRMqtXaohz6GXUd9gUmQvFdkU5?=
 =?us-ascii?Q?PSCmgVWDjSMeUyvTlBH1NT5EXVo4sruojjh18FPzp78MlsNPGY+lxKs+L4/z?=
 =?us-ascii?Q?SY+AWji6vFv+poaOV2xngFOUCp90+VOolcNwlkdb+N9s0M7W6gnTqb6+/SV4?=
 =?us-ascii?Q?nMSXGSrp0z4oPAo9uD/4eZYyMl/lN/SXCsQdBFkWRddiRDgKjiTBDg2CHIBQ?=
 =?us-ascii?Q?C8SerqiGW2rE+HYVoNgDAowuvvblNwgKvRt6qVKaXZSp470atQpzx3yMDl82?=
 =?us-ascii?Q?YfytK9K/WRuqacZezU9AzBOZ49dk5/VTeAXGHsWJHLMTzXsUY1ya53AKkE4q?=
 =?us-ascii?Q?Ql7aRDR2DjRy4iqXE5jMMVfGZnM+ezkpTwXc9Sb7GCKHVa8XiLTxzSlyiK+U?=
 =?us-ascii?Q?xaSbR4prv/eYHVb0gUFdTibkrDWObyIykohmi05wfBkWrBEi/vTkXzHeXhoS?=
 =?us-ascii?Q?mYULXsd8q1IyW0MVW8u+4oQaogWQMMqBu94RsFch8SB1xQ0pwAMGwXEW1mMW?=
 =?us-ascii?Q?3nNe48nHe9p+cigIX66+oa8LTdanfkH18nUruYiATFmXCCsfl5slM6PcfMUQ?=
 =?us-ascii?Q?wv7RNgk2VYFLjOdOrloeJoZ9wcs852uYfxvSq7MtfGJb+iJPxEw4DCuA8Zr6?=
 =?us-ascii?Q?8ht652pTVO2MjpOb7xk7UYUmX7c3Q9zcG34uocAEUp0/0YwWx00OztUhMZmu?=
 =?us-ascii?Q?A7MToNSHkLK7x7woId3eH1ss75pNumtVaYrfI998emJ5hbdmYSWyZIvRYG/t?=
 =?us-ascii?Q?I3q0IKqkUQbGxcHYwAHJT6wSMNlhjvxATAtEw613e6Lk8w6OV13ujUfB6Fl/?=
 =?us-ascii?Q?q1aJBYJydvG/73KwBei9UMRPez2v4kubP++gYSRGmJtyxxa1WNOVZIDm7uCK?=
 =?us-ascii?Q?HkGO8WggpRWiQc4mrmxmtOPbPKMkcx1GypL/3rd2TvB72u+kXguMcqZ2qbuc?=
 =?us-ascii?Q?Pm9ns/kNh7T9HOmC9ODHeyEhEe9a4V5kgyLLhSH8fZjvZGGkmFBvuDrimbSN?=
 =?us-ascii?Q?ZBCU/cUfsH79/TIb5URcU5lnefBoBzuIBART8lz7CRHmpywxAjOMVtNR/RKQ?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fP0W9FQrhAuPXGTP1eNjXq+TYGaLW5nZtxJ3zhhtCa2XRx+lrjuRDEFUsPxNVLlrwfTAFVtYlMEW4IdCjMZpAH6OMdnLsiiN4JEGKWtW/kkjzToZYAnV03y3hSViqp+leWdk6I6kr/q7PUa9Jhl3gLK+724AdoxX8s7HLogi2VNDU48LK3b9lSG1DeZDBymYo/yvZ/2TxfB8nqDFHX7Fgfil4s2AQvm+tObf5lLhX+F2P6M/yLXf2rVzOLInmXESYzhGeDKteEzTDSL+1geQHx64v168GFS8sT78hiJwVS52zFTJiDRvsIhDIyOFfGSPa/0giiRUG5eNsuoyOPPVDGRsfp+WHluhNvGP/DmX1RoFM0KWmqs0gFexIk8jXGkxmVMnfZVz7RDyjZlM7uERyRJfj1C1scXaK5P1YM4H5Qd9WPM8NdCQHYp+ZrBXyzxYIK0devVchxIFMCtxGPQ78PT0qd7rOzoVkfRyAZaZ3QVTM8E0XgAx4Dyl9GZt1hXybHYtoUsrWf4cR+Ol+lSkz9FhQgUEYbHW7vwTw7hoRuhJOlXlPetCTscxw4yLSvt895bS7rIKUb7scMFzy0lvUTl+8zHgK66Otv6MfXU4zUeaBc7llAao59VU9QrDrBiJr78XmFh9hGdi47kZjL/i5K/L5p3djOY2/wv9MWSo/Glkyd2b75gP0+m7I6dpkWyDpDe+uuNTrJPaBYYT4f2DNvD/reZWItsP7xAMQ410S+lJNNcV5EoBzDr9NdkXBl35InqusIZvzBGCRsjxm14njEE2B2y8Ax7kaJq26Bma73+t7mnqpMJ8T0srGmwDJil98zLnNQRgPL6irO8Uu+akqGXgl3m2ESmcTVXvm4ZqB27kDDAnOZpCiSsVe2hICRhLYUegvVFjkIB4mjPOPwhkfjq4p953Yy81QsFKnyu75dU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b093ebc8-040b-4183-b662-08db84a45866
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 19:55:59.7888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+W7m2LgoP+7z8wpEhe1YFDTgyMNPdRYtVM8CdD7hyhnoxrqCafQtMwBHIrItdKM6TwAudQfIfSmWc+lMtUXBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5922
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_10,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307140182
X-Proofpoint-ORIG-GUID: MZT5doZm4xE9tiSDqPsZem_KvUM6ya-7
X-Proofpoint-GUID: MZT5doZm4xE9tiSDqPsZem_KvUM6ya-7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

validate_mm() calls are too spread out and duplicated in numerous
locations.  Also, now that the stack write is done under the write lock,
it is not necessary to validate the mm prior to write operations.

Add a validate_mm() to the stack expansions, and to vma_complete() so
that numerous others may be dropped.

Note that vma_link() (and also insert_vm_struct() by call path) already
call validate_mm().

vma_merge() also had an unnecessary call to vma_iter_free() since the
logic change to abort earlier if no merging is necessary.

Drop extra validate_mm() calls at the start of functions and error paths
which won't write to the tree.

Relocate the validate_mm() call in the do_brk_flags() to avoid
re-running the same test when vma_complete() is used.

The call within the error path of mmap_region() is left intentionally
because of the complexity of the function and the potential of drivers
modifying the tree.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oliver Sang <oliver.sang@intel.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index ce31aec82e82..7b70379a8b3e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -594,6 +594,7 @@ static inline void vma_complete(struct vma_prepare *vp,
 	}
 	if (vp->insert && vp->file)
 		uprobe_mmap(vp->insert);
+	validate_mm(mm);
 }
 
 /*
@@ -675,7 +676,6 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_store(vmi, vma);
 
 	vma_complete(&vp, vmi, vma->vm_mm);
-	validate_mm(vma->vm_mm);
 	return 0;
 
 nomem:
@@ -715,7 +715,6 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma->vm_end = end;
 	vma->vm_pgoff = pgoff;
 	vma_complete(&vp, vmi, vma->vm_mm);
-	validate_mm(vma->vm_mm);
 	return 0;
 }
 
@@ -888,7 +887,6 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
 	long adj_start = 0;
 
-	validate_mm(mm);
 	/*
 	 * We later require that vma->vm_flags == vm_flags,
 	 * so this tests vma->vm_flags & VM_SPECIAL, too.
@@ -1015,10 +1013,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	}
 
 	vma_complete(&vp, vmi, mm);
-	vma_iter_free(vmi);
-	validate_mm(mm);
 	khugepaged_enter_vma(res, vm_flags);
-
 	return res;
 }
 
@@ -1193,7 +1188,6 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	vm_flags_t vm_flags;
 	int pkey = 0;
 
-	validate_mm(mm);
 	*populate = 0;
 
 	if (!len)
@@ -2022,6 +2016,7 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma(vma, vma->vm_flags);
 	mas_destroy(&mas);
+	validate_mm(mm);
 	return error;
 }
 #endif /* CONFIG_STACK_GROWSUP || CONFIG_IA64 */
@@ -2112,6 +2107,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma(vma, vma->vm_flags);
 	mas_destroy(&mas);
+	validate_mm(mm);
 	return error;
 }
 
@@ -2289,7 +2285,6 @@ static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
 		remove_vma(vma, false);
 	}
 	vm_unacct_memory(nr_accounted);
-	validate_mm(mm);
 }
 
 /*
@@ -2326,8 +2321,6 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct vm_area_struct *new;
 	int err;
 
-	validate_mm(vma->vm_mm);
-
 	WARN_ON(vma->vm_start >= addr);
 	WARN_ON(vma->vm_end <= addr);
 
@@ -2384,7 +2377,6 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	/* Success. */
 	if (new_below)
 		vma_next(vmi);
-	validate_mm(vma->vm_mm);
 	return 0;
 
 out_free_mpol:
@@ -2393,7 +2385,6 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_free(vmi);
 out_free_vma:
 	vm_area_free(new);
-	validate_mm(vma->vm_mm);
 	return err;
 }
 
@@ -3044,7 +3035,6 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct mm_struct *mm = current->mm;
 	struct vma_prepare vp;
 
-	validate_mm(mm);
 	/*
 	 * Check against address space limits by the changed size
 	 * Note: This happens *after* clearing old mappings in some code paths.
@@ -3096,6 +3086,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto mas_store_fail;
 
 	mm->map_count++;
+	validate_mm(mm);
 	ksm_add_vma(vma);
 out:
 	perf_event_mmap(vma);
@@ -3104,7 +3095,6 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (flags & VM_LOCKED)
 		mm->locked_vm += (len >> PAGE_SHIFT);
 	vm_flags_set(vma, VM_SOFTDIRTY);
-	validate_mm(mm);
 	return 0;
 
 mas_store_fail:
@@ -3285,7 +3275,6 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	bool faulted_in_anon_vma = true;
 	VMA_ITERATOR(vmi, mm, addr);
 
-	validate_mm(mm);
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
 	 * to match new location, to increase its chance of merging.
@@ -3344,7 +3333,6 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 			goto out_vma_link;
 		*need_rmap_locks = false;
 	}
-	validate_mm(mm);
 	return new_vma;
 
 out_vma_link:
@@ -3360,7 +3348,6 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 out_free_vma:
 	vm_area_free(new_vma);
 out:
-	validate_mm(mm);
 	return NULL;
 }
 
@@ -3497,7 +3484,6 @@ static struct vm_area_struct *__install_special_mapping(
 	int ret;
 	struct vm_area_struct *vma;
 
-	validate_mm(mm);
 	vma = vm_area_alloc(mm);
 	if (unlikely(vma == NULL))
 		return ERR_PTR(-ENOMEM);
@@ -3520,12 +3506,10 @@ static struct vm_area_struct *__install_special_mapping(
 
 	perf_event_mmap(vma);
 
-	validate_mm(mm);
 	return vma;
 
 out:
 	vm_area_free(vma);
-	validate_mm(mm);
 	return ERR_PTR(ret);
 }
 
-- 
2.39.2

