Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D41275FF1C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjGXScr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGXSck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:32:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768D010E0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:32:39 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OFOICk005703;
        Mon, 24 Jul 2023 18:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=vKI4jF0FtObHem0Hi41uzc+Zn3+lkEYthQhCGxO7fCk=;
 b=DzfjMj7fY/XYAVOhm+/B4UzPo0tPGUw+JF79lXe9NyZkR1B4aJUHxrqQk3wvBT9xaiHB
 juE8uOtpXA+1sWoXvo1GpBaCuwyrVmGtprNVtp3XTCcKkEhYBDgfjCtxVCHbBeaaa9va
 niW7SSs754FGl1TyoKVR4niVN9aXbfnBx5PaU7F2+FnJ1/DidMrGUQcRV1OoyGUrEI3y
 AwMEpOVtPT1CuCsIbeTArZmRT/V8LoLtrhbOnYcDAb6xUktbX7HLb3bN2wR7ZbZnmHOk
 hBK4WZKeIQxRubOZijOzjjVWiE4sdu6bWHXCDHVovIBeQS6sdpDihZTx0T+0JM/q3T0U YQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s061c3fu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36OI3jBo035471;
        Mon, 24 Jul 2023 18:32:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j3t3f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBpCB8fq6750d9bUG7igLzKqi1E7tfQDPsWGaRN9F/W7D3PG/++qAlzv1pMEA0IvdpQS3TTX9pcbJyymm7jm3V2IGMiv3jiBgBSZ77MZp68mAWCgRQ1tS1swQAugN9cLdxOsF96zhqCUougm+MyOvPoskw6aDKH9WxGf2ImXPxJI01zBbbKw/tWZf8SwTD5gMTOMyGwJGg0ypJZD0sw25f54kCA/JbOkMV/vHqbQEco61xp3V2uIc5imMxkT0GXp87wgJq7BsHwUA9VN3C7WgQw/AP7FCqURj0t5BESCL/Ic+XGPIG2xeexT8TYWo4PJJJZa+aop8c5X0B6ARqZZ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKI4jF0FtObHem0Hi41uzc+Zn3+lkEYthQhCGxO7fCk=;
 b=V6G0dl1kIOG0nmtpbZVqhSqBb+YNvbb18kpWt8SmIG81SQMEfevmfpZeadLGElotqFA986BYeRFB7nTN/V5xjEschlM8FNyGcca5u5x+QdarzqJBzVbljK5wrjKz8xlvsm51KfVW3HsduQI+ltTvhSdkwomk/CiXdxu2NAvcaRx87QIrHH0Nfjxz95QSW78Ilpbxtuo5mloTJ/AwsbLSM0kW60sJt9BeiqAQOkz6LogpofoLh6stz5X3K0VsnRL3e9QKrMxW2182M6iuNKDjtiFalr7f7lfpNlKCVLcYqlLHM9cFDVeOO1z0lECcfoEDQ9Lvf1IaXevpaaKkrczGkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKI4jF0FtObHem0Hi41uzc+Zn3+lkEYthQhCGxO7fCk=;
 b=agVLfm+mnqEb7Zu6Po2JmR/+ol1Vb2g72UlXw6sFNTEwb93nWQO1J0bAxmqDQHt9YF0sU0Kpi5Ub+oqUbeL1AFociDvwIpLB29SpPMn8CL6AYlWGKGWCWaM6YjmV7niwszezDx2AI+AcVm8IP8VVtN3bwxErn0fkgCo8BeUz+68=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB6654.namprd10.prod.outlook.com (2603:10b6:303:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Mon, 24 Jul
 2023 18:32:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 18:32:25 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 03/15] mm: Change do_vmi_align_munmap() tracking of VMAs to remove
Date:   Mon, 24 Jul 2023 14:31:45 -0400
Message-Id: <20230724183157.3939892-4-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
References: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::27) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW4PR10MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: f7443e4e-fbc4-4831-4c16-08db8c74540f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQ2980l/nUBrfLtHFz5rSvkbOnehsaLI0eH18XK3rPyWAlwM9WOLevZdhF1jcqBUa2RCPSOMfJyec/BtF3hw701DUiO3ZVCW34777tP5mbka8Egdnzf3C0R0APbdgCsCBeXXQdESeFuGwFXue37/OsgmD5cPF5W8mNuu0mAzL7Ktrdn/+FJRl/KfsQqRBnW9nIBNwTFtR8fRPN1TKIlW0RpxGnj5BCloK7qKPsWLfVnQHoGTlABEjMaVMJgSS6WuawhBOJOIXJx+f3/GuGQM2tJV30I6WpNkuZLJ/ZQvuCkkqePLNveN31YROPzW6g4tW+QN1Qehb6K//zP+Y7aDz7FqTokTBhnOYbqIgLO8W7iV8nR/VxOg2At27tFSOcmXAGfBFV6bm3bchMKcuki3ElA59MlDLP5IzL++N/79tHDyB+NgfgaVTaihDAUGoufkQaZEPPyzu3E12JnN4v76VcDg/vHZKqF5TL5ZIjDqu865IzVJq9H8xaqdGNDMW0hkRU7t6vOYRVIWeRqxjQdkPoTaSCCyiGayTmoc7/fC47d1OKqpisdaYmqzXDnYbPdq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(2906002)(66946007)(66476007)(66556008)(6916009)(6666004)(478600001)(6486002)(6512007)(86362001)(54906003)(83380400001)(36756003)(186003)(2616005)(1076003)(107886003)(6506007)(38100700002)(26005)(4326008)(41300700001)(8936002)(8676002)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ByI23vQNSfATDok913S1WYNMKIsxwZLt1ul143F0FxzT0T//MyEUWpWnsSqo?=
 =?us-ascii?Q?1fz0NijL5U4Vs+oqTGqK0LwYzi4K6D2LDS5jW8P98XGNwxF6jtWnkNGlLha2?=
 =?us-ascii?Q?kD8ZZxJmWEsbbXPpdPoHicYWkdsqvaJdFu9WDcln49Qd4V0Hd3b4YGJAxtF4?=
 =?us-ascii?Q?eIqsgAC+2hpr48BeR+rcsqlKm6YgdM8CypjMVAih9Xk3W3Jdp4YVzaoVuYmZ?=
 =?us-ascii?Q?hUegAioJI755Fk93H1n6eJOvn2eusQwbpe6y6gX8QXmn6CHmpmQ3FGZu/Pfq?=
 =?us-ascii?Q?nKEqurhKt8FFjfsHs+pAyLwh+NNjjcGWxJEGu+awIFPjLVVrIYjJh/Msagex?=
 =?us-ascii?Q?H/QuYPzJBdsWjFHiYQmgxmxipZa0TvH3w9me+49O7hCsnFM9NwCzkRe5J09U?=
 =?us-ascii?Q?5Go67X3USKVjy4LhxG7OUVwCudH2BzKzuKz772wtTHpTd+DDZQIhWrcz8npc?=
 =?us-ascii?Q?jV+clUxJDP44KdEze+1oi+SyIIjZdFBIRgSkNxhqS05MY4Qu22DriArG71Lj?=
 =?us-ascii?Q?olanIJXI3r+igB1EcVc3g5SGc4jXv0cFB8bkEESnUGWrb4ui9w8VZsTTQmNE?=
 =?us-ascii?Q?RVKWa0TOcfJqoa2uZvJC9/BZByz0bq1bLPMIvDfD/YwsKGxAARFeiB+kV0K4?=
 =?us-ascii?Q?SNKC/E2Zs/JvqszM6dsq2401XitqpmJ3pb9i+vjaLZgpXmCIBYRFMYIxUM1r?=
 =?us-ascii?Q?6i7sDzBQWTZrlHjx8HjdeKG5Wp4w/pyQePfRJdV1CtNMcwKrSwWY+Sl6zX/q?=
 =?us-ascii?Q?9/m91jUhz62I7RmxF3COLnt5eIZF5Ysfx1gYeGf9oS5ohjOJpTm6zAn1gbP2?=
 =?us-ascii?Q?jKDnXyzgqMqmOArtBd+CaNpWv+Dhbv5IBsz0c23a8FQysqFJR2Q4GSgiwdU1?=
 =?us-ascii?Q?AajQFvzRIk1A6iZvo154OLf0uRU1Hy4trRZMIAtKKij2tg0/coy5gX+8nkXS?=
 =?us-ascii?Q?MZA6W32E+KpvwsU6+d7REMBGxaLZi3RQwFkOtDDd0nYKHqp8Vhbjq/5YkQQP?=
 =?us-ascii?Q?aO+6H4XGngW35a0L3syJ7JJKTuwoyjJdmp4uS1t/vTJc7VSlyYGgt71QgieR?=
 =?us-ascii?Q?jTFYfccFgsUYBIa4JB1TQKYOiEJ0BLzgeiZM9bkacugXkd/JyhuLYK0NB9pz?=
 =?us-ascii?Q?t21bYbbgrcOAhN0FZ4sCZ2k1o0Gd7QLDqUnAe1QR7fiwIoMlbuFX9qIwNFAC?=
 =?us-ascii?Q?OFNRAM0esNH0D2gzVq6XuA0ZsVGDHW+vpWb2jbYMRTe/l+ZuYipgctrlkoM7?=
 =?us-ascii?Q?BUQN0c1jtB6AnkP8/874+NEPQT8biQizR0r6yCNcPl3pdd7r5zMlB8h0qhH8?=
 =?us-ascii?Q?62Cl1dVZgcHHlVQx6OVwcGv0ZbIbyje3h7pmRmxJmiyltQC2w0xBg/OzeVhZ?=
 =?us-ascii?Q?5AO606oZquRnTJRtLtHjzURba/ndYxC+r5Dmi25tEaNFghW2NK45L5Q6UIMj?=
 =?us-ascii?Q?WEdCD6usSyMLy60bYqzhbMdNocxUgCBJK3ToQMJC+A3sqo+m25CRTehdvrmO?=
 =?us-ascii?Q?2jZE6VjoKjZHIqgz3pbCK6ZJvuzbb70tsYayAk4ysRhmk23y5vEL5fpbvZRH?=
 =?us-ascii?Q?GEWFALe96+/cRdEsRMN2jKBUryKm5H36z6YU8s0scRPjOTgQ6yiVekrUUYua?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FbwWKRY6aKJzIAOo46ggoToQSNKctdqMrx6y6701Gb5Rnd6LfiSx9MMUekPqnCA7oJAd4xknvcRfXkhVGssgM8LvaZfGnhy8hoTH9P+25cIehwzr84ruI7DfjxU0w3fCTqbAOYgjfTrXs1U5auJoiX+whwoxk6tabSJoRHR6TwyQHA2T8qgeSCenvOiVeGuSbeM+wydYObjZDF7vnph+Q7Sa9NfwKSqE9CiPYQfnfR/KytzExj7hOOgysDbzxBg4R0nY9qffeB7741PfaPCNT0GoJipfuCUOFyL+kjp5wGL9sglYFWIa1pzam9pyHiedik9bXoQthTQnA2HxhVGbozR7EpYjKCAYU7p69lwUZSyY5dWeXOwRu2/9WInFBE5zT2OlaNfOoT/q4qb9pkp023TP+cDyUhGdwfZ+1r90/mVpi3djGUkGYspqUPQ2QzQTuVb9nXgZNnTXZaqPvN4nKY39amAjdn7wJ6O0i7ZQeBQkhdRqng2UBPiU+l5jHeyjb3rBidiY6bvlOqbGC9goygzKPfPQyz7OJZRSk7S8jt1Uth9Bh9CQnQj5aTsE9vSTDIUWHj8QqRbT8II3l1aEOK8EuiVShW/yckZRzEIzlhlRpYgOgE47GzUdQv15UWZ+M7S5WKm/HEnYGmmscBWAgeN2JXv2xgtUGHwe1pgT0dqs5cuwMBkfDWKEebgUfuplLDY5VBOIqpy8tGFO+Goc69oHmwGbuLjm3MocEDkFNSPZTZ8N5cffBpn/Q+sGuB7xEF0zy1kc4KHqVNTcouquNLmOwLsvQQkY3s/XBjgIhMpC1cUuHZ/w1Rar3PCa8a+rngdgreYWVfIrmLbYqjbwW61lzih2G+Npqh+NeeZeppKTNSA7Vg2N5Xkzy23KZnmjKUXsJIkdfVaKPzDqpLMrjcU/doniZzd+Y1X55CYVl2s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7443e4e-fbc4-4831-4c16-08db8c74540f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 18:32:25.8689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACJnt/G9kr4Wt8S6jg7wLXqj8XJF3yPsV9iafoK8w1Cx0YmHBW5YG460uJl3eiRwkcBChYBwIkWhKnQg9K5Vfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_14,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240164
X-Proofpoint-ORIG-GUID: YSsSbsConz-RKE0TL3_UbDWCRBfe-KHw
X-Proofpoint-GUID: YSsSbsConz-RKE0TL3_UbDWCRBfe-KHw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The majority of the calls to munmap a vm range is within a single vma.
The maple tree is able to store a single entry at 0, with a size of 1 as
a pointer and avoid any allocations.  Change do_vmi_align_munmap() to
store the VMAs being munmap()'ed into a tree indexed by the count.  This
will leverage the ability to store the first entry without a node
allocation.

Storing the entries into a tree by the count and not the vma start and
end means changing the functions which iterate over the entries.  Update
unmap_vmas() and free_pgtables() to take a maple state and a tree end
address to support this functionality.

Passing through the same maple state to unmap_vmas() and free_pgtables()
means the state needs to be reset between calls.  This happens in the
static unmap_region() and exit_mmap().

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h |  4 ++--
 mm/internal.h      |  2 +-
 mm/memory.c        | 16 +++++++---------
 mm/mmap.c          | 41 ++++++++++++++++++++++++-----------------
 4 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5b866c07be42..65292eae0fda 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2310,9 +2310,9 @@ static inline void zap_vma_pages(struct vm_area_struct *vma)
 	zap_page_range_single(vma, vma->vm_start,
 			      vma->vm_end - vma->vm_start, NULL);
 }
-void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
+void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
 		struct vm_area_struct *start_vma, unsigned long start,
-		unsigned long end, bool mm_wr_locked);
+		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
 
 struct mmu_notifier_range;
 
diff --git a/mm/internal.h b/mm/internal.h
index 483add0bfb28..7d11ebe5d11c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -109,7 +109,7 @@ bool __folio_end_writeback(struct folio *folio);
 void deactivate_file_folio(struct folio *folio);
 void folio_activate(struct folio *folio);
 
-void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
+void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		   struct vm_area_struct *start_vma, unsigned long floor,
 		   unsigned long ceiling, bool mm_wr_locked);
 void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
diff --git a/mm/memory.c b/mm/memory.c
index 8dca54461567..a7b31f9efcc0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -361,12 +361,10 @@ void free_pgd_range(struct mmu_gather *tlb,
 	} while (pgd++, addr = next, addr != end);
 }
 
-void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
+void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		   struct vm_area_struct *vma, unsigned long floor,
 		   unsigned long ceiling, bool mm_wr_locked)
 {
-	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
-
 	do {
 		unsigned long addr = vma->vm_start;
 		struct vm_area_struct *next;
@@ -375,7 +373,7 @@ void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
 		 * Note: USER_PGTABLES_CEILING may be passed as ceiling and may
 		 * be 0.  This will underflow and is okay.
 		 */
-		next = mas_find(&mas, ceiling - 1);
+		next = mas_find(mas, ceiling - 1);
 
 		/*
 		 * Hide vma from rmap and truncate_pagecache before freeing
@@ -396,7 +394,7 @@ void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
 			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
 			       && !is_vm_hugetlb_page(next)) {
 				vma = next;
-				next = mas_find(&mas, ceiling - 1);
+				next = mas_find(mas, ceiling - 1);
 				if (mm_wr_locked)
 					vma_start_write(vma);
 				unlink_anon_vmas(vma);
@@ -1713,9 +1711,10 @@ static void unmap_single_vma(struct mmu_gather *tlb,
  * ensure that any thus-far unmapped pages are flushed before unmap_vmas()
  * drops the lock and schedules.
  */
-void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
+void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
 		struct vm_area_struct *vma, unsigned long start_addr,
-		unsigned long end_addr, bool mm_wr_locked)
+		unsigned long end_addr, unsigned long tree_end,
+		bool mm_wr_locked)
 {
 	struct mmu_notifier_range range;
 	struct zap_details details = {
@@ -1723,7 +1722,6 @@ void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
 		/* Careful - we need to zap private pages too! */
 		.even_cows = true,
 	};
-	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma->vm_mm,
 				start_addr, end_addr);
@@ -1731,7 +1729,7 @@ void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
 	do {
 		unmap_single_vma(tlb, vma, start_addr, end_addr, &details,
 				 mm_wr_locked);
-	} while ((vma = mas_find(&mas, end_addr - 1)) != NULL);
+	} while ((vma = mas_find(mas, tree_end - 1)) != NULL);
 	mmu_notifier_invalidate_range_end(&range);
 }
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 18971ab91633..fa388eab8074 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -76,10 +76,10 @@ int mmap_rnd_compat_bits __read_mostly = CONFIG_ARCH_MMAP_RND_COMPAT_BITS;
 static bool ignore_rlimit_data;
 core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
 
-static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
+static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		struct vm_area_struct *next, unsigned long start,
-		unsigned long end, bool mm_wr_locked);
+		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
 
 static pgprot_t vm_pgprot_modify(pgprot_t oldprot, unsigned long vm_flags)
 {
@@ -2292,18 +2292,20 @@ static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
  *
  * Called with the mm semaphore held.
  */
-static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
+static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		struct vm_area_struct *next,
-		unsigned long start, unsigned long end, bool mm_wr_locked)
+		struct vm_area_struct *next, unsigned long start,
+		unsigned long end, unsigned long tree_end, bool mm_wr_locked)
 {
 	struct mmu_gather tlb;
+	unsigned long mt_start = mas->index;
 
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
-	unmap_vmas(&tlb, mt, vma, start, end, mm_wr_locked);
-	free_pgtables(&tlb, mt, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
+	unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
+	mas_set(mas, mt_start);
+	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
 				 next ? next->vm_start : USER_PGTABLES_CEILING,
 				 mm_wr_locked);
 	tlb_finish_mmu(&tlb);
@@ -2471,7 +2473,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 				goto end_split_failed;
 		}
 		vma_start_write(next);
-		mas_set_range(&mas_detach, next->vm_start, next->vm_end - 1);
+		mas_set(&mas_detach, count);
 		error = mas_store_gfp(&mas_detach, next, GFP_KERNEL);
 		if (error)
 			goto munmap_gather_failed;
@@ -2510,17 +2512,17 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
 	{
-		MA_STATE(test, &mt_detach, start, end - 1);
+		MA_STATE(test, &mt_detach, 0, 0);
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count = 0;
 
 		vma_iter_set(vmi, start);
 		rcu_read_lock();
-		vma_test = mas_find(&test, end - 1);
+		vma_test = mas_find(&test, count - 1);
 		for_each_vma_range(*vmi, vma_mas, end) {
 			BUG_ON(vma_mas != vma_test);
 			test_count++;
-			vma_test = mas_next(&test, end - 1);
+			vma_test = mas_next(&test, count - 1);
 		}
 		rcu_read_unlock();
 		BUG_ON(count != test_count);
@@ -2541,9 +2543,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
 	 */
-	unmap_region(mm, &mt_detach, vma, prev, next, start, end, !unlock);
+	mas_set(&mas_detach, 1);
+	unmap_region(mm, &mas_detach, vma, prev, next, start, end, count,
+		     !unlock);
 	/* Statistics and freeing VMAs */
-	mas_set(&mas_detach, start);
+	mas_set(&mas_detach, 0);
 	remove_mt(mm, &mas_detach);
 	validate_mm(mm);
 	if (unlock)
@@ -2863,9 +2867,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		fput(vma->vm_file);
 		vma->vm_file = NULL;
 
+		vma_iter_set(&vmi, vma->vm_end);
 		/* Undo any partial mapping done by a device driver. */
-		unmap_region(mm, &mm->mm_mt, vma, prev, next, vma->vm_start,
-			     vma->vm_end, true);
+		unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start,
+			     vma->vm_end, vma->vm_end, true);
 	}
 	if (file && (vm_flags & VM_SHARED))
 		mapping_unmap_writable(file->f_mapping);
@@ -3184,7 +3189,7 @@ void exit_mmap(struct mm_struct *mm)
 	tlb_gather_mmu_fullmm(&tlb, mm);
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
 	/* Use ULONG_MAX here to ensure all VMAs in the mm are unmapped */
-	unmap_vmas(&tlb, &mm->mm_mt, vma, 0, ULONG_MAX, false);
+	unmap_vmas(&tlb, &mas, vma, 0, ULONG_MAX, ULONG_MAX, false);
 	mmap_read_unlock(mm);
 
 	/*
@@ -3194,7 +3199,8 @@ void exit_mmap(struct mm_struct *mm)
 	set_bit(MMF_OOM_SKIP, &mm->flags);
 	mmap_write_lock(mm);
 	mt_clear_in_rcu(&mm->mm_mt);
-	free_pgtables(&tlb, &mm->mm_mt, vma, FIRST_USER_ADDRESS,
+	mas_set(&mas, vma->vm_end);
+	free_pgtables(&tlb, &mas, vma, FIRST_USER_ADDRESS,
 		      USER_PGTABLES_CEILING, true);
 	tlb_finish_mmu(&tlb);
 
@@ -3203,6 +3209,7 @@ void exit_mmap(struct mm_struct *mm)
 	 * enabled, without holding any MM locks besides the unreachable
 	 * mmap_write_lock.
 	 */
+	mas_set(&mas, vma->vm_end);
 	do {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
-- 
2.39.2

