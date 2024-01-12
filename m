Return-Path: <linux-kernel+bounces-24956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 099A582C53F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7FF1C2264E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E91B25609;
	Fri, 12 Jan 2024 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iO/GHbma";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yg7IiEyC"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6E817C8D;
	Fri, 12 Jan 2024 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40CGpYfN023299;
	Fri, 12 Jan 2024 18:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=2FzQuBuxQ2rPsRQ0wedz5ohOwfUSodfekKrmkiDznVE=;
 b=iO/GHbma8dUy64lmtqsXBc6glv4S3Kz53BTFs4/dR8AazGnNeYzlXtCTcrJmIcOACVKO
 hCiScuNO/A/CSf9l6Hs926TOaLqlsnN3gYsp0HylNKoKVwD0XjvydlsUhdtxuyxJxKh8
 IeESXIhh1vyGe5Ay/red+pIlYxYti9aTLfMXViwFyy/mEym07SqGlDwKWmKGPqoLXfXD
 Zz9VPNP5VHD9irHaXhtnpND9yGP6xdwBiAklmBU3cg9JGXluRCrPo2t0xLMd3S7jXiBq
 2lowqa4I2E4/PbgryIDlghsRstti96ZksV+5cJ6KELWtyXpmKynqW54JRWHyOu6SfOkB gg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vk9acr4u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 18:09:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40CHLIX2012477;
	Fri, 12 Jan 2024 18:08:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuwnvh5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 18:08:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3GO+rnu/+Tz2hiQ4gsqLU175y5B6T40G6ASBCA69PTLYQElFV7r7jTOf5j+9jKP45AHFtdxGhgm5dV0wWBzqsL02pGuYcfgQi/2lHjrZonGivtQzd69/7y2737YgYhMpM0csw3/NYweQWExTczL5NhIKPJDsebgeEWvwwh9XG2ByyousKAeXdNhfmGCLTrrRUJHEu/9euqK34Ux9OULOrP1KzgjloQDte9QBpIHS9l7wOglIOsFpohfQ00MxZD2YnVyPIAPb7HYSMks/D1EqAe6ToG/AcmfHtGueNCbaokZylDp8bYxHkKjIZ18ZU0VLx/Tl+BQYDBdbRW7YTzSrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FzQuBuxQ2rPsRQ0wedz5ohOwfUSodfekKrmkiDznVE=;
 b=NkBDO4012O076hFrX+PE4ve0+eLrcD7ARZB1+nlj3EFB3uCF5Xikkwzo5tODHLUkob34HOC3v4agVAFZZlAc2NLi0FZHA2fQ7cP0rvJ4dgVzVy9WX26rvYQjEETKLETvcnH1iYHQEu/ggyb2SoSnNJrmh255hkiK3TPVPPVimeyhw0PRzPynfz0aGEBZJLs+K4+/Gd7FVrkP+sXAY/yiMUw/sqAEwFK7q4946bO3dlAHw1ZGvLUKHWJtHF5maxjbVUsa/am+NoJilVJ17zFHVCAvVPFkHeYguif2iMDkD7d3Blp3lVo8tkS8Dcg18hhwGnGcYNgUacnNOOIdMeFzCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FzQuBuxQ2rPsRQ0wedz5ohOwfUSodfekKrmkiDznVE=;
 b=yg7IiEyCW24WX3AgazB+M7+ldAjKAoO1aHOx8UmfqyfI81aIxO1yfLH48/AuDtHQVyspua968OeLvhWfi7vXM8Uw7noSuK+cW2W1b1SGGpLniTjUEo599CVDY5qtS5QCibeqfYEKlcrjxyeSWps4In45CEaB9PDUvFDhHVEZUDk=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 18:08:51 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::78b9:5082:241a:d1fb]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::78b9:5082:241a:d1fb%3]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 18:08:51 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, usama.anjum@collabora.com,
        muchun.song@linux.dev, jiaqiyan@google.com, willy@infradead.org,
        linmiaohe@huawei.com, naoya.horiguchi@nec.com, shy828301@gmail.com,
        jthoughton@google.com, jane.chu@oracle.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>, stable@vger.kernel.org
Subject: [PATCH v2] fs/hugetlbfs/inode.c: mm/memory-failure.c: fix hugetlbfs hwpoison handling
Date: Fri, 12 Jan 2024 10:08:40 -0800
Message-ID: <20240112180840.367006-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0208.namprd05.prod.outlook.com
 (2603:10b6:a03:330::33) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|BY5PR10MB4129:EE_
X-MS-Office365-Filtering-Correlation-Id: e6efeed2-a8e0-4400-5193-08dc13998803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IJ5KuHDKasVcYNiLDT8knw5lw8G1eboAHbYrjJvgz98iJ6Y/somrrjQERDPBNrPWv3vcKLTljvm7gcjdXEG+5LpfNzqgoKljQz/CfXw8EARzaw9l6dgnTYx0iDTyA5h12lgOZfvEIy7BoS73IgKBVeXB4heXU+TK6cAnIrR5YZAveBqweVayxC72daER/NHxrD/Sf84jRZY/dmnWazp9DjlPGLWYIyOAHS303S8/HMG/dMnHtfyZwNe548o7g8K9BALIk00LhlmS2+fhCfgqWIQ1f27fvy2C2FVr0NZt5BcFQCdQHQc4N4aexixrSbOE7wpn7sFQW/CAUigoy+Ljhc10/bbt5LRBEIjsH4MHELq0LiKKVTfC+F2WuFp5LtBzHMrsMtf4xgtDVsxU+HHOVJZ3ZrIYLQkWYu+bEtxJUOxV4qdznGwgaTwcwyR264CdWROvaLXVSbhKfwp9qnqQAG9MiD0PTb4TVpfPVp3dXgnhOoCB7RT57YOpsOyZ0daLxNAuXFepUaSLEARNQiMJC1Sqsz3NcmFiIZ4SDzHW8w0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6666004)(478600001)(6506007)(6512007)(2616005)(1076003)(86362001)(36756003)(38100700002)(2906002)(44832011)(7416002)(41300700001)(966005)(83380400001)(4326008)(5660300002)(8676002)(66476007)(6486002)(66946007)(316002)(66556008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6uXE0/xhVic2PZedu7GjCFmJpkSvIV8GC9ktctrkFcJsQGkYblUTfIlVIuwf?=
 =?us-ascii?Q?7c5MUkDV42zhwaCl1MQs7OLK1DHd1Df8KaqUd3o5ZEhtk+IqipQAdG7ZAjhv?=
 =?us-ascii?Q?/uCN86+QMuvisbKX+tmb8MkUJDNeF7kF5JBpZxB7KoXsYEaClNYY2jXfKw/U?=
 =?us-ascii?Q?CB4Df+IYBvZxwn1xkgNlis+470rZxUcNTl5SCzZfdpq23IiecZOubqfq7+W7?=
 =?us-ascii?Q?PZU2PJzjxF60s1elmi4jwA2jmbtY9qw5dWxf8gEb2W2A4SFXC+sAu3FmXTVv?=
 =?us-ascii?Q?c3PpJxhc5/hUeW5IStEIRNM1sgw9YjYQVVQdKNXCE7LufJ5jGIKsc5hpZpA/?=
 =?us-ascii?Q?RjwTDQuOdWKQZu2kVarMFUNeERppaRwVWe8EnQg0baTTjPJY62UhGIT4U4jt?=
 =?us-ascii?Q?T3vUatXcXUpfmpfgX+FAhXy8+zjj7OABUNU5bb+IRDup8vOq8m1xCJiBM82/?=
 =?us-ascii?Q?NftPAujlLerGzBPWAT/0VsKEOxqhOMDJO5gBU5aMfnT1gOpp/hJLsI5s5aZe?=
 =?us-ascii?Q?WMRbzG3fIM1tRTRHnoBZ37ZpA0PymV30BiISUj/zTTQmQeuKE7D5OcXpcTML?=
 =?us-ascii?Q?yYi3UUBPAK9cBvVvT8JOchuKUQ1m/qSTKREVsXzNRIQo/2wOssCbrh4W82Mt?=
 =?us-ascii?Q?ZRWlrKkkiFyutt8zzpd7zujw6G6vkdRHSgvBDgQELGKEPfi0uot7ix2jpE3s?=
 =?us-ascii?Q?vggqpIcQiUSXk4Pbc7EbxfMNhkP3BbYCGt2qm/tLa4i/BcdpP4X1KS8Nh8OQ?=
 =?us-ascii?Q?THTVqWusiU0qXwkXV0VodS9k6sy1HAQSJwHTYTtH+Fw25dh2ozpOTyAyFeNh?=
 =?us-ascii?Q?eN8GeRMQ+hXw3Arxhljp95Yo1+kwlNznH5UMnd/Td31Jxc22gxOmorAnpWu5?=
 =?us-ascii?Q?yxfJXrICRterWo3zRMfjoOB7Q3rD9JxnyofMiUghwgNgZmTSdKFdAyjXV8FJ?=
 =?us-ascii?Q?M+3nhpkgpIkQ5U6uOhRmshehtEUyhIX13PeMnsvRRY/ps1yvwj/o5h52gSx0?=
 =?us-ascii?Q?u7zx69ZFR8YXcSQSi9MMU1GpYZaSfus+EUP6v8mRH2SvO7vLoP1Cm84Snpi+?=
 =?us-ascii?Q?4vPznN02kbWgT8rORfJqIfo3/om+e4QJWYUR8P3Pqql311bug4AdTPhdQ5DD?=
 =?us-ascii?Q?vcdItsuTRnKzGEOfyjYB0hQfqkaP2WJmNMU+k//FIqTEUAnNT4/xsuXNYGHr?=
 =?us-ascii?Q?qfGEvj/ldV5jHcu3fUminDYv19TfX13vr4lWPEJhRrW4uGAEY/ASIvstFhGX?=
 =?us-ascii?Q?7GE1UHMhatoy65RGldiScIf3vVuw5kGeL8nrfQjTTpTrK85EHIWFMFLGCJub?=
 =?us-ascii?Q?fJd1zKjLfLh9oNF4UVF103VjlqT+zUIIevsVNrd68RhB7lMzdNZLlTD/fuCA?=
 =?us-ascii?Q?qj9t0UazUBQdSAD4uhQt1qkURTkzRxkPtArRVXhPrbfV0z9mAWecL2pKzd+/?=
 =?us-ascii?Q?qo2adO9dlyBn2G00ptRAbt1sBxAYh9GOTDnK4iWwukMMn72KSDEDg09j37U3?=
 =?us-ascii?Q?8o62WSpEuAbkxs07G4ynEFHc7vquoVn/QSGO26tqCASrhOrfbi/ZMYmpzzNv?=
 =?us-ascii?Q?m33hhu4WO3YU5KaLhmsn1xa2XrGw29DBMTKeUipLKPYplSNZPvvcInI/8pow?=
 =?us-ascii?Q?hAhczOP0ZxyMHduW93ZHKjg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jEW2ctMbgIbZ7vLv9r8bKi1VBfkWgsufe3dkcaUTSvRJSf3r+9OzFS3j2uFe/gLndKkc8Nc3M30dFw5BTHRR2XmeU795h/I35TcuN/n1u4Xid29XTZGDYlHprDbR/9GpQMwb5xFgFN1OyW6dpj+PxrSJW72r+XSnkb4A/SoLl5ujQn3NfIX1yRgDsqTIXQ0MdQotyHRIMdzDu2/T6rAufyDQW9x16q+z8FY+N6HiZgAv6rCKMK/IcDnkFIapRTlmmjTpWklvbjQ6cfo4rFH6J9PSs0GzYPcqV9RecQy18RlxdFSSv9b5mgpZKMUrX7eG8TPB0aTjjLnzn98wWm8+ial3YhrNgHxZe5yGdpEKZ05Vl5+QAg4g16utMnmonOyQD2jKQMRq8Pwajpbi6mgL7zmdhKAbvetnUkxvR4wCwb4MQn3aU+1Yj4QRQIkOvEcZVSUkQZ3ivtEYxv8jauRBMVmCLSdyUdkMhJgPvdnVPtPz8Yhfo1OgnyLLDM2SNhtRbbk6emyyRXINZEl+p9dCKiyoL6es4xJEGiibnS/OLPF7JlTowLW36nnLkviB7C1XZnnSXrBcHYtMdg2qPxUNxzYB85IAyBS8xcQ8emJh3ws=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6efeed2-a8e0-4400-5193-08dc13998803
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 18:08:51.3927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwAhfaHv2rpn1h+2xlhTeLAFl8puOVpe8eZjMPQ2p3CsnnmcTS/a9Hyxe9NoK3AcE1GRqM3Q0dZ2Y2/Zj2mc/bZl9jQc8wmiqckIZ/QTsUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-12_09,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401120142
X-Proofpoint-GUID: YYuoMMNDTCClZ_nT8JI-bM73H8CD-B1F
X-Proofpoint-ORIG-GUID: YYuoMMNDTCClZ_nT8JI-bM73H8CD-B1F

has_extra_refcount() makes the assumption that the page cache adds a ref
count of 1 and subtracts this in the extra_pins case. Commit a08c7193e4f1
(mm/filemap: remove hugetlb special casing in filemap.c) modifies
__filemap_add_folio() by calling folio_ref_add(folio, nr); for all cases
(including hugtetlb) where nr is the number of pages in the folio. We
should adjust the number of references coming from the page cache by
subtracing the number of pages rather than 1.

In hugetlbfs_read_iter(), folio_test_has_hwpoisoned() is testing the wrong
flag as, in the hugetlb case, memory-failure code calls
folio_test_set_hwpoison() to indicate poison. folio_test_hwpoison() is the
correct function to test for that flag.

After these fixes, the hugetlb hwpoison read selftest passes all cases.

Fixes: a08c7193e4f1 ("mm/filemap: remove hugetlb special casing in filemap.c")
Closes: https://lore.kernel.org/linux-mm/20230713001833.3778937-1-jiaqiyan@google.com/T/#m8e1469119e5b831bbd05d495f96b842e4a1c5519
Cc: <stable@vger.kernel.org> # 6.7+
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---

v1 -> v2:
    move ref_count adjustment to if(extra_pins) block as that represents
    ref counts from the page cache per Miaohe Lin.

 fs/hugetlbfs/inode.c | 2 +-
 mm/memory-failure.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 36132c9125f9..3a248e4f7e93 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -340,7 +340,7 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		} else {
 			folio_unlock(folio);
 
-			if (!folio_test_has_hwpoisoned(folio))
+			if (!folio_test_hwpoison(folio))
 				want = nr;
 			else {
 				/*
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index d8c853b35dbb..ef7ae73b65bd 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -976,7 +976,7 @@ static bool has_extra_refcount(struct page_state *ps, struct page *p,
 	int count = page_count(p) - 1;
 
 	if (extra_pins)
-		count -= 1;
+		count -= folio_nr_pages(page_folio(p));
 
 	if (count > 0) {
 		pr_err("%#lx: %s still referenced by %d users\n",
-- 
2.31.1


