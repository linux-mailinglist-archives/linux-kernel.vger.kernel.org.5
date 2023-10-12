Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260EB7C71E1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379320AbjJLPxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347251AbjJLPxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:53:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7A6C0;
        Thu, 12 Oct 2023 08:53:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CFhvft015593;
        Thu, 12 Oct 2023 15:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=uo0J0y2wZAfyRd007HRZ9GIgmtHcn9aktFI0QEMNW7Y=;
 b=SfeLiC/ZhcmPKEc6vrt6xg0Cs85TACRqL/Zg2lrXbADJVRgj6ZxV6yuekak4HkAFV714
 0Jlj6jMwETa+o3y7boomlXkuv5mfgTY5LYtsNF8H8lGJ+gZMKNqncCNTf9xJ46vUjV7R
 anQfn5e5VQV8JON954K5lT+F73fb6OG3WkSbE75k3GV+ZxhQ00bnHNJyGz7jKcwbgAaM
 A6j/Zq3VbXKc3ieNwuBRYXzanX5Pe1rkw00xI4bihK+sNcfnhrPjry1DiiyFuUhlxrqw
 oVP27sw0Dp8wdZ/ku5ib8ZrUDama6tJXMVSKnuwjjIjbVt6W0s8zfLkddPSlyFrMmPFv Dg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tmh8a0geq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 15:52:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39CEXmBO037414;
        Thu, 12 Oct 2023 15:52:42 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tmfhtn74w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 15:52:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBo3+dpiKv8nPAsk02jlEMrfhqA+e4lX3VeJLoOC9brUHFnQn6oRyLP73F69aOn0piZjfRcGlLza2QHg8tWL8Hew4s1wOlCsu0VRfnVhSFoZwJGwfHVIGM+DitWxNon62BR/KSI7byKd19oUdMKZHAf2feO4gk1ktbNC5LZJAlNfxq+wsj5h+IwLgp5kAzIAVDHllCEKu5/zk2I/e55VyrfkHXGOR9rYmPxSdVmLyyFuHEakZya8cf/3QFGdq1yOJ5Zaj4UQ5JsWzQ0n+GZaT5HIlVjGnfBU0owjDIRI8iMmtkOf4X3+3Dl3PPMQMYFmcS5PETW3pDIgiVoOdqJznQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uo0J0y2wZAfyRd007HRZ9GIgmtHcn9aktFI0QEMNW7Y=;
 b=igeTrJy6L0CLkfWWlp2zPb4UoTkI6y7sdfbQ1uL1t/TQTP9UnOEcogoGiiKAc0qgEWhVnXObzcWpf8NIixWt11hdTrWV44efMkvkwboCXDVUsrwvAUjoIi8e+1trdDaKSo/CQ4Xw/z3fa7RjHbdP1nyYrzcD4tP5l/5S7utwWRQyqHKykXrzY6nePdHs3EV1d1iSv0vdeg2LjsvFsMECpHrWrcpVe9cKoYzh5XgZ5eH3KkV+9nakxrZ9ZwhG9VZFBV1A/cOVmC+OLJux0hjn1xccioNgEteIPtiik0UWgg4F56xA1BXYTjkhLweymZAGzto0lPsls61T92AEOoiUbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uo0J0y2wZAfyRd007HRZ9GIgmtHcn9aktFI0QEMNW7Y=;
 b=veEHJxGF/BN1aFuPIPwpYIon+3L2lGY1307xKov0Mseiq8rWSLIo8mHZvr0CfXjR3y63sWW9gsIogJ3sh50pKWoJputYtI4yie46ZWCKJQ6wWIIbPVsUSgOPOkzgrAU2fDH/fpW6haT1cV6d/MfZi7Znh8io9fWE35dOxwbaG0E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4724.namprd10.prod.outlook.com (2603:10b6:303:96::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 15:52:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 15:52:39 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        stable@vger.kernel.org, jason.sim@samsung.com,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2] maple_tree: Add GFP_KERNEL to allocations in mas_expected_entries()
Date:   Thu, 12 Oct 2023 11:52:33 -0400
Message-Id: <20231012155233.2272446-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::33) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CO1PR10MB4724:EE_
X-MS-Office365-Filtering-Correlation-Id: 6677da88-ea5d-48fc-c226-08dbcb3b4342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 92Cta4dkLMxlEhUfD6lY9UHsT1k9eh/oNXo4zsM0rVYy70lMlu19dXuw7oFW3cdURU4ACu/1HtMX+XsQRlIT3LQdWE96LCtkLTM7UJs+cMZz2Vp1Q8jhw/Mw0llqBnkFzhFQcB3LobTSTXT/Cp1V27NwJDXblGhMsd3TLnOao4lblkIaqWbNGHlBtaCJeGOs2IKJ4mMMeKkabE1eo758w+ETkhhnUuHL9f8zmf2LpZArgL+IR6WOZ+F0dthfhzBDEHU4tkuqRteMSrcp0xOTQI2nlFDopQFCAh7UDOFpdBfto4/GvgtpxqxJ4sC4aNjpT3Q/ekGvJMGpA80FxA5s+jf0XxGag6n6m6Ap1XlLRmkU+LTHV9xsAm7eQqT61j51rUrNVG/4gGLjyL+vMzcJKsfZFcV/7OfMiYnNflIchMSE0wBP83nziDRfTQETl6IsIT076Fr+HX5Nvja5/MS3AoX68xdGvn6jOCmjve99Xcq21X8e8SgMM3tkqb+jpZZg89m6Dkhh+AGPCoNHj+/kZOnOgps7tNniuYIfNlqo6wZ6/L2TI3FBjcjDI1UW4+TrSjv6e9fmx5PDp2UB1n5ebg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6506007)(6666004)(6512007)(2616005)(38100700002)(36756003)(86362001)(26005)(1076003)(83380400001)(66476007)(6916009)(316002)(66556008)(54906003)(66946007)(2906002)(8676002)(8936002)(4326008)(5660300002)(41300700001)(966005)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7zgHxd7rS88oi2TaIz7Smu6OnAyvmNd0c7QmyCgIOz6NF+rDwTsWagid2MTR?=
 =?us-ascii?Q?Bqc6fOvOyUZ5lhurVaxwszoWqcARknz26IeipcMuXmywjykwBld8jo/PBWmJ?=
 =?us-ascii?Q?EB4ZxB+crOpe5Odna+6I036AcfWGRRuX+xQTFITP7976RpEqF0BEKgtC49p4?=
 =?us-ascii?Q?/+b8P6JqyDZvpHSk4RkeU4XXGqa+Q5JZTZIU9kOgapwT3OpalT0fF2icnv5f?=
 =?us-ascii?Q?NxkS3fJviJJZTTpLWNCVhaLWcxv42UTg0XNJ/UqzL2i8K9oM/0vLn9KrdjTi?=
 =?us-ascii?Q?krSSun4pRduRnnbRMjEAhgsx9Ko3e6S6YZygnKNqOjOQwcW8M91+4dL54y4j?=
 =?us-ascii?Q?PHS/XLPNR69QwfLaA04j9WAuA+SD7oI6qwxxag4W51PfV65FNoR8QggUzjg7?=
 =?us-ascii?Q?iLbJ9htrCwNQpqKLeVJ3wZcaD8asWc/yPTAIOrcDtx/vVM7Y6HVeuZ/a9H8h?=
 =?us-ascii?Q?F/NxYDYOa8K9/2gcmy5Pxem8addjWfoc5UhqqVpdstYrCXBc582Dnmb9jTtM?=
 =?us-ascii?Q?vcDnaiHBnF+rfV9ncS4LSyW7XJ9kJPspc+ZC7ow2V752OtV/OgyFMdZMfGEN?=
 =?us-ascii?Q?TRyMfD9laFFx4vbMeCDaYWljQzS/DuajqphxLLzPNhPcgjF+33QjN2w9LGFt?=
 =?us-ascii?Q?vONpjCW8K9HnDFtOJOhz9LrZ3tGsvYyHOUz4O3Hs2hYazmcZuWTCjXzSwP0E?=
 =?us-ascii?Q?pjZJN5jqhLl2ShZo0BE+9Bjk2pFvOBMz4YFhKUPir23izxLzKPKQLU7azRfL?=
 =?us-ascii?Q?1zaQurLzvOMJdbODxcv68ked/QgYC+08GY/uUXUDM+UelPD49/RKrWRE3/sR?=
 =?us-ascii?Q?hnYj3kbTNK5aSdNbQKT8IO745vr7pYTQ31bMW7udsZymaIJ9Z9AMj21CAaKn?=
 =?us-ascii?Q?4EWYO6VNSlsCD129NnNUVj2KEPYPE88+DRTiv+uGP0+LRx99v8obQANwJPPz?=
 =?us-ascii?Q?cZj3YRmnyeU8K+CXlubMPWwQcV23VLVp0iMubUz+SWdJU38YmP1x0jt+5d6Z?=
 =?us-ascii?Q?MIeFVtGDbMWT1+o2PkIUZrVP0i1u6MlPJhiVPuY7b5czcKa9iRXILTuIxtPK?=
 =?us-ascii?Q?zWq141DliPtFM+rqUtQnjStIr2aelti0Bmw8zlC/48Awnr19wJJIKDOr2gKw?=
 =?us-ascii?Q?U3JdVNrW2b4fk5bZnhgJIWTOqbC7Bmf+kLwfr8YjUnD+JEhZDaU1ux96SU5E?=
 =?us-ascii?Q?O/Ay6XMkbSec5GB/oGDI5zBghH/oGSyJaqsvmj2d6m7Ss4ppEDgCkL4e1uSJ?=
 =?us-ascii?Q?Go0P8KIV1NzeOigA4rliZt64bE2FtZbKPYb2BNecQfSc1csbJ8UhnGxkNqG+?=
 =?us-ascii?Q?W29DwAvyugzfzSRZfelaBVmvts8Kwg6fc9Adaskxi2LIuHcCn91uoMo/YY8v?=
 =?us-ascii?Q?OtozIgMvMT5vKMpGi57GfrRzE8jDf7cGEpsaEvkPp7+31W21ZOpYcvFgecky?=
 =?us-ascii?Q?MM4e1wYCXbumfvK28JfxQ/KcAD6nlOdLFa6vGUmI0+H44iI8t7nhFUiLWJtT?=
 =?us-ascii?Q?ueGDci5UgSix2mEEROFc5GSOvUDDgyrQXRIPFUfIjw3DGpHeveGEjuqk7sHI?=
 =?us-ascii?Q?85qlAhCDpEl+Uh13CHE+zXO3CR/gDFn3BZzGgEq0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ux/RxFzZ8XkWrJbgNz6XQcLZ9vE0zsWkOC4LBq3JMEC4WHeDl5O9RbouNP24?=
 =?us-ascii?Q?4lDyUJg7P70FHGSC5wI02mPqamQdL+4e7Eeqwk3nwipkw7NxiPuhIupwFUgr?=
 =?us-ascii?Q?d6/gqgoOOiPlyG2Dfxi2VgzbMnTc4w6bVoG/Z2N1ngLKM+pkLhZuj/EeBmqD?=
 =?us-ascii?Q?whrsdg+J5CyQHQhOqbDaXwIhhp74Zhhdsqjg8SAYKeuGG/HXubThXAcYIAAO?=
 =?us-ascii?Q?GVHLsiqFN7dxi0uxSGGQ9/ZQ6yxphDGulTqMD+p1sjkLkDJ6JN4enDeC7tVJ?=
 =?us-ascii?Q?02jshKtQ6n+VQ+Cex2nPr+zUb+kl+OYNl64z3jFX39hslANIBesthmDyGTgl?=
 =?us-ascii?Q?Dm9M21yq6ZaY/RnSj5vaX6sxg22CWMf0zwmDlczecKpSwsaVDpZ+IjEb0t+D?=
 =?us-ascii?Q?74yBtoDUzl2Mkw7N4HhOCGp/m/ONjNjbY9R+Sh039Yeh2NdkTBGToFu/4h6c?=
 =?us-ascii?Q?JmzAnDzAIi/Kilh6VA2kw8ubdzcW22a5ymiXAEX4uEhAORZrdgMks/0Mcw/s?=
 =?us-ascii?Q?HIlHSVGkQ67/T28Q7mEdjxRE6oHi1bCDAFtp8zqhWzgTITNH/RUZTMi5Fzc2?=
 =?us-ascii?Q?TZJ8a5jRjzqdH2lvZeuCwUL1A/CfiEqzadmv1+uxBQwUuqx0zBlhxzs3PVR7?=
 =?us-ascii?Q?Mu1IxIm3QyvvPsTy2PCLfMGuKDSQQ9CV8n4zZifb2y1Xi7g6pTTguUhacFcM?=
 =?us-ascii?Q?TGG6KdW7Z/olPZNdXxluhPF0RDB5+Qp7inhehkRfJ2ES5CQwMTnl9pP6po34?=
 =?us-ascii?Q?heUrjvUGj9WroB+N8Thl76nAiH83YdzWq7m9DHZmvD6YTw75P8nF91iWBMPX?=
 =?us-ascii?Q?tLRTnK8cgsakpVufoww9KyUCbsKE0I4xW8k0khDH3qZALhYrKqlowABkwweT?=
 =?us-ascii?Q?n9EKaKgR5rBKdczvc93bkxzLqyJUk7WU1sqDz06Q9oPaSJP4w+mt8OKm6pRY?=
 =?us-ascii?Q?gmYU1YQd9FsmJ8fcwwqOAQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6677da88-ea5d-48fc-c226-08dbcb3b4342
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 15:52:39.5962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgDW/lgeceNFZL1ZJLl/9hUMKu9FIlEnGZRF5Yo/8kXfDv0S3qSlqQduczM+hVWJM0VBc/8m4tYgIcjrSJjtJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120131
X-Proofpoint-GUID: Y7pBMi26s3NDRxkK_xDaqW5w8dDAJUoq
X-Proofpoint-ORIG-GUID: Y7pBMi26s3NDRxkK_xDaqW5w8dDAJUoq
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users complained about OOM errors during fork without triggering
compaction.  This can be fixed by modifying the flags used in
mas_expected_entries() so that the compaction will be triggered in low
memory situations.  Since mas_expected_entries() is only used during
fork, the extra argument does not need to be passed through.

Additionally, the two test_maple_tree test cases and one benchmark test
were altered to use the correct locking type so that allocations would
not trigger sleeping and thus fail.  Testing was completed with lockdep
atomic sleep detection.

The additional locking change requires rwsem support additions to the
tools/ directory through the use of pthreads pthread_rwlock_t.  With
this change test_maple_tree works in userspace, as a module, and
in-kernel.

Users may notice that the system gave up early on attempting to start
new processes instead of attempting to reclaim memory.

Link: https://lkml.kernel.org/r/20230915093243epcms1p46fa00bbac1ab7b7dca94acb66c44c456@epcms1p4
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Cc: <stable@vger.kernel.org>
Cc: jason.sim@samsung.com
Cc: Peng Zhang <zhangpeng.00@bytedance.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---

v1: https://lore.kernel.org/linux-mm/20231010141737.1592866-1-Liam.Howlett@oracle.com/

Changes in v2:
 - Updated benchmarking to use the rw_semaphore lock (not strictly necessary)
 - Updated check_forking() to use the rw_semaphore lock.
 - Testing now completed with lockdep atomic sleep checking.

 lib/maple_tree.c            |  2 +-
 lib/test_maple_tree.c       | 35 ++++++++++++++++++++++----------
 tools/include/linux/rwsem.h | 40 +++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 12 deletions(-)
 create mode 100644 tools/include/linux/rwsem.h

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 0e00a84e8e8f..bb24d84a4922 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5627,7 +5627,7 @@ int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries)
 	/* Internal nodes */
 	nr_nodes += DIV_ROUND_UP(nr_nodes, nonleaf_cap);
 	/* Add working room for split (2 nodes) + new parents */
-	mas_node_count(mas, nr_nodes + 3);
+	mas_node_count_gfp(mas, nr_nodes + 3, GFP_KERNEL);
 
 	/* Detect if allocations run out */
 	mas->mas_flags |= MA_STATE_PREALLOC;
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 06959165e2f9..464eeb90d5ad 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -9,6 +9,7 @@
 
 #include <linux/maple_tree.h>
 #include <linux/module.h>
+#include <linux/rwsem.h>
 
 #define MTREE_ALLOC_MAX 0x2000000000000Ul
 #define CONFIG_MAPLE_SEARCH
@@ -1841,17 +1842,21 @@ static noinline void __init check_forking(struct maple_tree *mt)
 	void *val;
 	MA_STATE(mas, mt, 0, 0);
 	MA_STATE(newmas, mt, 0, 0);
+	struct rw_semaphore newmt_lock;
+
+	init_rwsem(&newmt_lock);
 
 	for (i = 0; i <= nr_entries; i++)
 		mtree_store_range(mt, i*10, i*10 + 5,
 				  xa_mk_value(i), GFP_KERNEL);
 
 	mt_set_non_kernel(99999);
-	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE);
+	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN);
+	mt_set_external_lock(&newmt, &newmt_lock);
 	newmas.tree = &newmt;
 	mas_reset(&newmas);
 	mas_reset(&mas);
-	mas_lock(&newmas);
+	down_write(&newmt_lock);
 	mas.index = 0;
 	mas.last = 0;
 	if (mas_expected_entries(&newmas, nr_entries)) {
@@ -1866,10 +1871,10 @@ static noinline void __init check_forking(struct maple_tree *mt)
 	}
 	rcu_read_unlock();
 	mas_destroy(&newmas);
-	mas_unlock(&newmas);
 	mt_validate(&newmt);
 	mt_set_non_kernel(0);
-	mtree_destroy(&newmt);
+	__mt_destroy(&newmt);
+	up_write(&newmt_lock);
 }
 
 static noinline void __init check_iteration(struct maple_tree *mt)
@@ -1980,6 +1985,10 @@ static noinline void __init bench_forking(struct maple_tree *mt)
 	void *val;
 	MA_STATE(mas, mt, 0, 0);
 	MA_STATE(newmas, mt, 0, 0);
+	struct rw_semaphore newmt_lock;
+
+	init_rwsem(&newmt_lock);
+	mt_set_external_lock(&newmt, &newmt_lock);
 
 	for (i = 0; i <= nr_entries; i++)
 		mtree_store_range(mt, i*10, i*10 + 5,
@@ -1994,7 +2003,7 @@ static noinline void __init bench_forking(struct maple_tree *mt)
 		mas.index = 0;
 		mas.last = 0;
 		rcu_read_lock();
-		mas_lock(&newmas);
+		down_write(&newmt_lock);
 		if (mas_expected_entries(&newmas, nr_entries)) {
 			printk("OOM!");
 			BUG_ON(1);
@@ -2005,11 +2014,11 @@ static noinline void __init bench_forking(struct maple_tree *mt)
 			mas_store(&newmas, val);
 		}
 		mas_destroy(&newmas);
-		mas_unlock(&newmas);
 		rcu_read_unlock();
 		mt_validate(&newmt);
 		mt_set_non_kernel(0);
-		mtree_destroy(&newmt);
+		__mt_destroy(&newmt);
+		up_write(&newmt_lock);
 	}
 }
 #endif
@@ -2616,6 +2625,10 @@ static noinline void __init check_dup_gaps(struct maple_tree *mt,
 	void *tmp;
 	MA_STATE(mas, mt, 0, 0);
 	MA_STATE(newmas, &newmt, 0, 0);
+	struct rw_semaphore newmt_lock;
+
+	init_rwsem(&newmt_lock);
+	mt_set_external_lock(&newmt, &newmt_lock);
 
 	if (!zero_start)
 		i = 1;
@@ -2625,9 +2638,9 @@ static noinline void __init check_dup_gaps(struct maple_tree *mt,
 		mtree_store_range(mt, i*10, (i+1)*10 - gap,
 				  xa_mk_value(i), GFP_KERNEL);
 
-	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE);
+	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN);
 	mt_set_non_kernel(99999);
-	mas_lock(&newmas);
+	down_write(&newmt_lock);
 	ret = mas_expected_entries(&newmas, nr_entries);
 	mt_set_non_kernel(0);
 	MT_BUG_ON(mt, ret != 0);
@@ -2640,9 +2653,9 @@ static noinline void __init check_dup_gaps(struct maple_tree *mt,
 	}
 	rcu_read_unlock();
 	mas_destroy(&newmas);
-	mas_unlock(&newmas);
 
-	mtree_destroy(&newmt);
+	__mt_destroy(&newmt);
+	up_write(&newmt_lock);
 }
 
 /* Duplicate many sizes of trees.  Mainly to test expected entry values */
diff --git a/tools/include/linux/rwsem.h b/tools/include/linux/rwsem.h
new file mode 100644
index 000000000000..83971b3cbfce
--- /dev/null
+++ b/tools/include/linux/rwsem.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef _TOOLS__RWSEM_H
+#define _TOOLS__RWSEM_H
+
+#include <pthread.h>
+
+struct rw_semaphore {
+	pthread_rwlock_t lock;
+};
+
+static inline int init_rwsem(struct rw_semaphore *sem)
+{
+	return pthread_rwlock_init(&sem->lock, NULL);
+}
+
+static inline int exit_rwsem(struct rw_semaphore *sem)
+{
+	return pthread_rwlock_destroy(&sem->lock);
+}
+
+static inline int down_read(struct rw_semaphore *sem)
+{
+	return pthread_rwlock_rdlock(&sem->lock);
+}
+
+static inline int up_read(struct rw_semaphore *sem)
+{
+	return pthread_rwlock_unlock(&sem->lock);
+}
+
+static inline int down_write(struct rw_semaphore *sem)
+{
+	return pthread_rwlock_wrlock(&sem->lock);
+}
+
+static inline int up_write(struct rw_semaphore *sem)
+{
+	return pthread_rwlock_unlock(&sem->lock);
+}
+#endif /* _TOOLS_RWSEM_H */
-- 
2.40.1

