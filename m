Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DAD75437D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbjGNT4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbjGNT4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:56:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF3E3A84
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:56:16 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EDYHh6018937;
        Fri, 14 Jul 2023 19:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=xm/+H+gq7iEoFQgqJq4P6qGurENe+48qBKgm1HBTaNQ=;
 b=fYXMWdA+JhSewkwaCg3YGeXws8lzj1aysE8edzDyyzN/mc30bt5Z28o2HqhJchrJ2MG7
 abC83k7d9+bTMkTmaFXvxpxxqUf4FV1Ptox2V0LAAQykgZbRp76ufM7QozowrBW9P7cs
 VQdIB20RGO+y/Il0pis3Jj2UwFjb2kYcMxgfdTxksmMxS4tkwi06sYZhG+Ehzle2L+bX
 Avn8Gy5nknl/KGuzDj8ABnjUzu48KT0u9I71aeWyUhj2Fbki8TPy7/31xNt5AdECrmxZ
 +1mKh6eZpZSwoOFLrCEUifVmx5z1ab911ioZhrNIxKmvfqaua2hPlbInrS3wbkzTxpKs Dw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rtqnct51m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 19:56:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36EHwsJr013836;
        Fri, 14 Jul 2023 19:56:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rtpvs5c78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 19:56:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWhZDCsMkF6BNzFbCoosiStUwl+iREaamKsjbL4b5fh3GllaojgImDeXFpq6nku1fB16ISCzEZz7i7KNUhKcTfpBeXv38rOg0J19F7pgcf1QJjTAXuztC4LwhM39F4IfJZs26YQNwwm9HBbkZycoOZzfz6YIPUfJWAhu9g4r9NnqckmmPs+HJPCprSpvZ5H7P0swZBO8oAy7m/Xe8GNk6VxaKgSx1qftuJvxoLa8rAWdW2W3GcIEFTyIjLfWrVdOdORU2Bzbkgq8PrSXuVAL/kou4CPx3qoGQ6mkjowEuPYiubJ6Gxb8CpAMEiYHgH0nky+9efcaSXIcQWnid4TgaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xm/+H+gq7iEoFQgqJq4P6qGurENe+48qBKgm1HBTaNQ=;
 b=BBgVQhTTKnjZ7xchVAsR9ljGbAWr2Ju6KVY7gE5T0OlAnCw0OdLg9lLvaSTllEtx6wclkEdM5hWMBCBmrvhUHlnotEyIPw3asNbchZiuEkXeRvc8uwcg/A7L1yFBUn5Nw/83dXrFbm+ivHH6NOUrGT3D6vsDAaCqQnSUxW596jO7jC4xahQHW3kexLVtmlg1KdantUijGbgcNdSqZt3DqywMcXCzvnfqWzlwQs1Yc0136WFyLu5mJ9163LN6yGjTb3ScHab+FxqjtRcbQi4vRVlhc6oIazGGT2UI9f02xh2MZ6KPfHxnCJ1IkYbI3ccHp1I9/vYPQKndlnZxOz+Pjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xm/+H+gq7iEoFQgqJq4P6qGurENe+48qBKgm1HBTaNQ=;
 b=z9Vi5PJup3Wncb5H6poF/SuNKlijZOV2W6Curx7VYRj9pf3JThbF3m6XqncmIcGILGWhWku+iG2f8A2BeNxtjYkWKqgRORwpOUs8e3E0TakiGBBgOQUG89hzrtf8d/VvYU1z+kE/3eBRGjdA2Jh5BEMI4j+07xPJColG+uSWbFM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB5922.namprd10.prod.outlook.com (2603:10b6:208:3d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 19:56:03 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 19:56:03 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 3/4] mm/mmap: Change detached vma locking scheme
Date:   Fri, 14 Jul 2023 15:55:50 -0400
Message-Id: <20230714195551.894800-4-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714195551.894800-1-Liam.Howlett@oracle.com>
References: <20230714195551.894800-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0014.prod.exchangelabs.com
 (2603:10b6:207:18::27) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f7f86e-c73d-4a2d-6a1d-08db84a45aac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SH+W+IoVxsjMTooXtmOUOSE+xRedKaBjcxqtDReYwtG8Nyv44CVxUON7RmT9VVtfBqMnFsI35oEkD6nJPSanpfeQip4RY5uHWVGT0cfsVBWG2wXrXEppSR/fhi5Ia5v9IAHoXuaEb+r1SGlO1VcazeUg0Ba1EG3qasnYIIWrPFyeyjhOjdH+HgeTLyzIpc7EwQF0R5EdGGgpDwRbf3wEseyqC/fpQAkbWFk8CrUXd2nVOAc5zUm5Nyzha8WXgG7slBgQxc3By9rnlBJkw+ikXsp3auoJcOuAOGq5V3fVYa2tXRjnQ6Mqw3kwJvke9ttnN+j8pdJRlZUnlUBBnMjVPsuVIWfxhk/1+cRFxp8ph1YuliD+tU0LYCRfHyzF6Zx3E/5gTIno4E47VsR84HTS0Eq9wKjmZwIJwNNB5bqcqWmSNlqL+mIKQjh/STuWGb+sIx3phzOvyxZ38/bP2tZ/VLiAYdRmQ3dsC7XrrPmfAlC4JVW9poSNTUeuYcUJ7wA6W+siBeoHWLr/o6xCQddZlbdULTEgFCpbCPKcltcv0jPlS9hkVGvopXDdsdA0SzFo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199021)(83380400001)(2906002)(2616005)(6486002)(66476007)(66556008)(4326008)(6916009)(66946007)(316002)(6512007)(478600001)(1076003)(5660300002)(6666004)(54906003)(186003)(6506007)(41300700001)(26005)(107886003)(8676002)(8936002)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yn3AQLtt/H5RN9MH2C7ied+PJHkce7aRmz29ubL8+ik4cn6eTriDITPjzhE/?=
 =?us-ascii?Q?t1OCeA90Y8KBIVIBAJa23uGlhY0hVlEl5BZtM9o/v91K5PPpmWz6SIXjNTC8?=
 =?us-ascii?Q?eIymneCI26fOOAeA/qQyoUrUIMI7frl8w8DYVgMVLJW8DlhK+UkLBVVHKFqF?=
 =?us-ascii?Q?+PNrI+V5uU5yEAzMreutfo/G6vMgle/WGdsD4lxdtDL/MzfzjKVMnxSuSFTY?=
 =?us-ascii?Q?noSakg0BfpfSB4hTs7Ksd0z3mWvZBiK37QCmJOey0Uy1SiN/qTkYCWoUra+J?=
 =?us-ascii?Q?pQUY9YANEvDSiZhzY/WisYPyT/4XQaVoqGf00CaqRhdLkXDgI8hGnE35pcMO?=
 =?us-ascii?Q?En9LiUpJBYkxnUVRk8sTOcEZ04HgiwhYdqFW0QOeELQWuf4Xv+otgKo0N8yo?=
 =?us-ascii?Q?3FkHO3wVcHNCAfINAZoNzP4V9tcvNsFHJiDnOFxj0X0iWGoVvJBq6cQKTBpk?=
 =?us-ascii?Q?452gWJC2lPiE7YxA8FgKRV+duqOM3dyZacgmAHEbXjj8JOnk9cT0BXkT7QL0?=
 =?us-ascii?Q?3VW7YQ9eGJg4nj2Z/drder7D9FYAov8yMeaIerikS+39LJo1bLMoiVlnf+0c?=
 =?us-ascii?Q?lSjsu4ASJeS+/qhh1wiUHx7I98aR5IaX1U2PneHVrkrg0GyDPK0JwUAoKnEE?=
 =?us-ascii?Q?4t8sBvLk7+6wShVZZc2SJ1LHPVHjx4a8qr8J9f3LC1cL98hOWrvHpq3nqP/J?=
 =?us-ascii?Q?Df2Y1OTT50kvvkZMf5hmcmQD1XWjB6pEl/PtzjXezBE+4xa4MMO/WYc+Tx59?=
 =?us-ascii?Q?lIf7UbFCkQN1b9tuBmZB3GBAwtG1L7o/FBvjkV1XxsRx/KNu+ZBFn1YjTzSy?=
 =?us-ascii?Q?2He/bzWFXEWo0UnoYUYMM5WQDz0nkSVjvuddZyzbxcAXECyCOe/0ctsiUCgL?=
 =?us-ascii?Q?/edi8OZ1jQsXtOy96kB+W7m/wJbP7YHFSUoEymmukkrBViAPCgggoO3gyMHs?=
 =?us-ascii?Q?8kIH8a+sXmnVsuZkriaKc+4k60Jjr2mvsu7WynvhMQ46tjSlvsXU55L0hME3?=
 =?us-ascii?Q?W063143/SQtj1LR48ugyGi4gK2MtcSvWrT4dPZ3Nyb3LJHzmG31SzjmQ9uZt?=
 =?us-ascii?Q?HL7wmDuBs6bUJdNv/LBGtrtNXZdcFl14XJWGvn0jQFsmB9HEgvR3R10p5M9/?=
 =?us-ascii?Q?9xHPbBLE/WaP3c4uYA30yYxZIzI4sDV/f7/sI3NOSau9RPag9L0EK5EC9rB/?=
 =?us-ascii?Q?dE+cDWT8cd4P8vUEwZjCGo/6npkgMokM5e6NCxkXq71RDJRv4R/Vvy+W4BRh?=
 =?us-ascii?Q?RzBJatX6+kkdCRHeZcMn/cEBl+Yldz80uGqsnqp9OY2qMwZT1f/oB8WU1aPp?=
 =?us-ascii?Q?yQ7wzn0ikQX9IrkJYN6nQd8MDSC1TBcfqfR2YZQh1VJA+kXFxRw/zvj0uxcU?=
 =?us-ascii?Q?wlYNZfQ0yj5XKNy8ObtX4COdu//JZfcO7aHBx4Q0z0/tlCXkh6E/Q4NHcoBr?=
 =?us-ascii?Q?SncVivE/d63zxrYDCecfY59kUi1rYgFzXZr2cs74bwec7kMN9s17RTdH9Wrm?=
 =?us-ascii?Q?TmMLY7CMbdWt7I7uGeeKaquMceD/AT1I5sym8X+m/j+rbbc0UPiAYC92Tg7f?=
 =?us-ascii?Q?B7JgKwqzzIdfX3cEyXl8hx7z+8LyjonBvZTjT+kbbZGWW73o+yZRPBd65Djy?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PYllGzkFrE9so/0oHS4kyhJJyKReraDslRreozEOeafHl7Xfok51Xa6aikMlHsme0xGbVdQKXVqnNaK9ciUFC7587uoGYlB3ReZ0EwMdcYobCDaFSkF8YTA+gaoUY8bkD+Q8dy6lbMR6J3GrybxdM6KajzvQn6LZZqsnupaXRY6wQNbl4UdWnzXDh4qNeSn2WCZuwd1BrRYC0iwPEbRevdXMu0hmsrhZ5FE9ADzsQbdprBMBBkKpLgx4R54YcxZgMIRqfexgoY1+7w/3AQ+rsVL2hNduys1wL5VNWSTuWIOw4cOFoJvPOdHhWixZV0yVGQe5DmTmc1YYiSmHlm5fytAJeg8dQwrcENmp/ncAj5jc6PCqLXjZsza2igp173Mg7OsOggYbhZinQGGCX60Pv8p0Ha3gvAeX+xulKUeMOL1LE/Bfkn5lG7Q839oprrsTr+zEtv2MaKGzdp1ePNoh4t2PwOm0mLPi5hpBTb72C63P3R4uoznUmuNlq6+9z2j1Dh2p6QZymceAB8KAk+f5hEU6OGwvEvVgTiUXnUB992breKltVQivE3fG7ioWVg2ozOazFwddklj83xp90fnIrQC60b64iuwMu+cE3Rf+AKixC/qx7SKZwxfPqXLeZ2J6TM2KesWZPReruGq7vEvEvDq+8AEpKKdbxH7i8xaFHs18/cakOPqLginwHGoEuzAZ9WAuSkZZco0Ujc4Tmz7ELK6fQCTeQw5MK6cuhakwkUysAKmQfYpc/nc7b4W/vdYzFh7UtlCZFSxIXy319r5BjpHWTK3BAkyeLhHZE8aXCYAmV76Mo2LYsPADIc4IHy8tmv3VKGChP2hOw+Z1FIBwrU1bN85XaXMR7O/RWr9r7kdKGzFPCGR3s91O+wM0ojh2AZ/8WeFcZd2kJd2YRoBZTw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f7f86e-c73d-4a2d-6a1d-08db84a45aac
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 19:56:03.5467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpeN3JEus21dxYE1BHvq0xYgOIzd++qRCKOw6CnqNjfN+JqVJAlUcVmn1wwc2l3I6ldzP8C9rF2/HfNUfT64bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5922
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_10,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307140182
X-Proofpoint-GUID: ZDFcvA5kkpZgPM3MwRBRzlyM2VVPKz3T
X-Proofpoint-ORIG-GUID: ZDFcvA5kkpZgPM3MwRBRzlyM2VVPKz3T
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't set the lock to the mm lock so that the detached VMA tree does not
complain about being unlocked when the mmap_lock is dropped prior to
freeing the tree.

Move the destroying of the detached tree outside the mmap lock all
together.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7b70379a8b3e..ab6cb00d377a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2427,7 +2427,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	unsigned long locked_vm = 0;
 	MA_STATE(mas_detach, &mt_detach, 0, 0);
 	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
-	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
+	mt_detach.ma_external_lock = NULL;
 
 	/*
 	 * If we need to split any vma, do it now to save pain later.
@@ -2545,11 +2545,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	/* Statistics and freeing VMAs */
 	mas_set(&mas_detach, start);
 	remove_mt(mm, &mas_detach);
-	__mt_destroy(&mt_detach);
 	validate_mm(mm);
 	if (unlock)
 		mmap_read_unlock(mm);
 
+	__mt_destroy(&mt_detach);
 	return 0;
 
 clear_tree_failed:
-- 
2.39.2

