Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30AA7B3A10
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjI2Sb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjI2SbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:31:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D810A1A8;
        Fri, 29 Sep 2023 11:31:20 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TIJBea014141;
        Fri, 29 Sep 2023 18:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=GQCFQQrDB4sf0IsWat8O5FSMncreJxteifxHXWGhx+E=;
 b=K5fKt7fTk8QxdMyJprMpzeyOKR/SmJK8c3ZNM3WaVBY8oN4cZFYsFuj6mGwgIln3Vd+r
 u2/Zs6RCnUfPxzFHt2FxhdJJUccQ9+mNRKp0291EeuSUONJn8IMBL4EbXOYU3CW75u5T
 x0zVIa/z8njvrhTJfa6hqOhjwni+HCE9E6JJ1OspY+IPQOhVM8J7bgIgf/XbDeCPx+++
 V7mibjLmnXf/5kIrdsAYFCk7OngkKE8ufTXvx4I4+e0+2PG+pHdVRGB0ljZnGPJfC6Ve
 A6l4gOT2r6rSlvt9I23SVpGqKfY0ERA0kOtKjnchpHHgB3SY2dKTbOzrtUMHxlyvIdL9 KQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qmuqcca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 18:30:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38TI0Ot6014442;
        Fri, 29 Sep 2023 18:30:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfc7f7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 18:30:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKExDybcUQdymgUsDwzNF09D48APFxhH7GdEdXX1ZYMPrnI95lIHcg7XAWGGfEkx2/y6U1PgqiBGP7y0xHD9rnyeqG/5KDc02/ZGl4ZeK9lIe7M1XUMoAi/ywec25CZP47Oje8tG4smBCPE16tDKkJnAtTE/C+N8KMOEi33CNWphXHfbQzjQbsHjYwWrqnIK2tdUafajZORckjEzP1Qarvw4exU2F8lO0i0rtgmrcmqUJdDhSJLnGgiSpfgSWy0RTgkk3vZ6tnBiWhiHF7cYH9mpIrJcFGeRn3Oo1j8U1rAkvaG0UNcB3IyG30UQW0BMuQd31wrgjYazVJVYv+QvwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQCFQQrDB4sf0IsWat8O5FSMncreJxteifxHXWGhx+E=;
 b=k3cgoNtX0BZlMYLLN3DwuzywI08dNjxngbHoUl27vv0bpZo4QFrsZ1nlWRshoPqGR/wgCHq4D91GNcHeFay+MBmznpsDPuV0ZYfFdfKpkFIcwKsZ+T8CCO69q+pWiWgNH+MrtFLViAC1LZ1rg8YzUoy5amWTLL6f4eMxBJdpUXQS/OCp8FqNeFLgYnjF9xIh8DdB3Y8K20pqkNUoBwMVlcpxnDDI5n6YOwK663QkV4VvsvCKSPXV6p2fQfJFFjM66ehjIAhCcSExvHLAW1nKmzArxABMZxXFMi7A5LGgUeAn7zZ2zARZhnKSGr3y4m6y7M9KB4B2bk5iQ+wXh9qmUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQCFQQrDB4sf0IsWat8O5FSMncreJxteifxHXWGhx+E=;
 b=qgQepXnruzA2jaIivpai40rznTsxZ+yG9XOX7x8Q9KiSr0KpfOedego+p3P5ngQ/MgclyB9ZyEUaAEdincMWOt0LFgRTc6SqLg5u17FzCLTnGorz3eBIyKiWAWELfgayroeVRuLw3+o2UIEPXLS5UoGadfTitisCPYzTX/UXN+k=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB7482.namprd10.prod.outlook.com (2603:10b6:610:18b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.35; Fri, 29 Sep
 2023 18:30:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 18:30:52 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, stable@vger.kernel.org
Subject: [PATCH v3 2/3] mmap: Fix error paths with dup_anon_vma()
Date:   Fri, 29 Sep 2023 14:30:40 -0400
Message-Id: <20230929183041.2835469-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230929183041.2835469-1-Liam.Howlett@oracle.com>
References: <20230929183041.2835469-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0023.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::24) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: 935d10c3-8e28-4a25-3419-08dbc11a3610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DnLZr1t/Ne92qL1pMz2t4Nt3YJ58AqTOKT2hkJYR9QCBFBmDWxrukADTeKce87MUrq+O22XV2BDs1MD/f3awN1ic58PlYikoamBUUlmj66q8o57cZzI5vPDFdvlbY/jHWa98Q39/xur74Pa1AwpElu0MI09YNjJ4IrIqEuab98Edk2vx18ZuMzv3vhLNoHrt2eWY9h3VX4tWlOIpggUl+qx5OYjGPOpqLiFIJEMi9vOdZPEMQ124102PhpwHZiM+qZ+vwI3QOngZ2qphJr9dqi717+tnr0HVlAnn8TfdIP8yJXvsX4dW5AK9f+D1H/KTDW3sEW9fQx4YHu4zQWM6qbMiuZK2PfIaFChLJc3NHuunaL11VxQzxpcJ1qo2s/CkkeYeBwehmFsLuIzn9nEVyoZaJbwoU1Ha2r/vfboWANgGHIENYv4zTRa5QVyAa2n1ghQ8Fc2T+/o4vBE9B9upoDcymIP6cydgGWfC5uvNfxmLE4aqa6rCI/Edyc6XLETaHnTjTWuwkXTa0gir1RB1+6e5RsoPwMIrw9F5YfnXg4UeWMS8pktE1lz8q4tJ8azcly+KNQw9Pu5gfOupDRRlKX8MNvzSKyeoD40oIOjwu6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(41300700001)(54906003)(316002)(6916009)(66946007)(8676002)(4326008)(8936002)(66476007)(66556008)(5660300002)(83380400001)(6666004)(478600001)(6506007)(26005)(6512007)(1076003)(2616005)(38100700002)(86362001)(36756003)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l+zogb8dGhDELDNZQtg/b6LjEl5l4Nuaulb66pwLdQFZPCjkAJZdcaVLVR31?=
 =?us-ascii?Q?L2W8283z03gVHF+/3agiHRGHSD23yU8wfb1pVq+BqCqnLhGoaNUpzEOGsc2x?=
 =?us-ascii?Q?x8zNxZggWyffxnUl90IT8+Q3OGCaP/bUTUjwYEySiA3W7Mpyouz6TLMDXzjg?=
 =?us-ascii?Q?ofYNE98KfBgEj9tM47Dx1zvVfHvGzZSzkc3WAkOO4W3q6PANNK6susdKtoAV?=
 =?us-ascii?Q?FLp0pZvg3AwYuwFWtNVmM2jL32A7iETDQrgzzEmwOCKpcJXStKfgDIY11mrE?=
 =?us-ascii?Q?6FJXNvxw7YboiWUIT1pnRU+ctIrgP98RyZEYV8R3wo2vhe1JmPi3bsMy5GoU?=
 =?us-ascii?Q?4eBreDi3NUsSPGyH5sq6DAOh3HlSVlGhSy1EW5NbF1Qem8h8h4FfVkEZIe8p?=
 =?us-ascii?Q?WMo4CRWraLSu0g4ZZnxV/apXikvF0dwH2cfwBl0s397GwqdF7S5I/t2a4Y0I?=
 =?us-ascii?Q?LY91Hr9jcF2Erya3CcQV2icfs5y0GntniZFup89SM0D7kUwtADgiV8eOjhIU?=
 =?us-ascii?Q?H1U8tGwIpUiHEkgSZbS9crvKg33tIwgYOoRf3+9yxJg3yqXsc1jSrxcgQRKU?=
 =?us-ascii?Q?/XRjzrSnITWaWGL7f4eQ0SMYR2YYVEmBTgFV3H2TujUErvh+Ehiv8NW86rG3?=
 =?us-ascii?Q?cgolKkhI+EwauZp3Iv+cqvlOJ0VC252aC8zD01eJGoqX/RQAX8ehSeKeRmh7?=
 =?us-ascii?Q?8o492m2B6ejt3yZe3S4uQO3jRZWnZPhcbl9ol+wLK0/2LsRoVqIKdzLdYxpr?=
 =?us-ascii?Q?e5yZ3DJPYC13g+pEBrB96UJCimlYW90bWhLevE1sR+jSCssBoXTlo2m2mAdF?=
 =?us-ascii?Q?5N67Ce4vzknM7PJb1Ex4HUB25lwQ7+vl6F1cI11qCSzqgsmYI2BfK6kAJP4h?=
 =?us-ascii?Q?06DCRLIru3F2no3pHNA3SfpCb01OS6Zk2DxPI5dPTWCZeA5Egh0ngF8N5tbL?=
 =?us-ascii?Q?+G/8vJSBbwRl09n8ztKApwLbKwmR7S/afA63+DDZhvFhMEqX2jKZUDb7txl/?=
 =?us-ascii?Q?oFjdJpeBWPGe9VglXyhmqN1V8Y1WJB9HsZSCxtMqQaDTvqEpDpbEFePezNqD?=
 =?us-ascii?Q?Ae5o07P2Hl/hTMihKFp41qc/oiSMWvPcWaVBLY7lRZixkfVZPW42z6GWr2oO?=
 =?us-ascii?Q?ZX+cu02ET9sh6oz5HkwM6o1DezGT0gCXpxk/+1z60dg+sQBxci2TP71Myr7f?=
 =?us-ascii?Q?5NfhcgIx2R5AkcpTynp9JezjOT5ZIQDohXB7vfZNwQZup3xonpqkfLfsfjCo?=
 =?us-ascii?Q?m0QUbUKbILDkB0fenbr59/RF+duad+SqbsKV59+8LTyI4XRucg8dkxJ5UkQ3?=
 =?us-ascii?Q?1bPxTONS7X96iSyjb2I0/Uykt4/gdzkfNO79mcmWGECHbBUIE6Il+r8g68Fw?=
 =?us-ascii?Q?Sl7l81fM1NQ1I8vxIRXLIcscv4SsYHE9+NmhINDiA0LPAtSpfVZt1dgIlQj2?=
 =?us-ascii?Q?jcGMEG6Q5wwqhNxmMZ5II6uIDLKhakFypcUEifBb8+KdfgrdfZJhBVjlrQgm?=
 =?us-ascii?Q?oXk87l4uN66dNnsHuygwyV1NmyfKP4TmVTULXNtQKXntfXQ18iMhKhP13G50?=
 =?us-ascii?Q?pUGGvWa5BON6wJY1M23CcfF2w2n4Eczqnwgcb4zf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?4S4VkMebMJF+I2zqSPJ4pJ/tCBeEjFwG2hPCTd55suUJmM459AZxE4DS9Cpd?=
 =?us-ascii?Q?LrESXel6RYD7PQCQRMfii4QjNZJJv5SytBCl/L+XkYkQPiw+M2d689PbatF3?=
 =?us-ascii?Q?ZwfxNMZjSdCa8tznksFQjXjpRN+s8olFhCUm6pUzvB6TvB8cO/iaGjDfUQQ5?=
 =?us-ascii?Q?N+fveDX5zFCSdvJRLmNLZVSa/mHglI6PbkLM3Jp9b5WhCGi0GFXzH+6r5U7+?=
 =?us-ascii?Q?wccB0Udpp1f64FeO5e3uuHe7uTwwrBkB4gWIKHgPunrSI9fx7cujHmg3xg7G?=
 =?us-ascii?Q?thlP2jPoIvbSAAZT6S3XeQnKPjC4IbQs/TKPBfyNb7ZimrAUPMv5IeKC0ApW?=
 =?us-ascii?Q?Nd5HMJJnK7j1kTyisOtfr9RSUcQpg1SkWQmsCw76+r1xox+l52jSA9Egtes2?=
 =?us-ascii?Q?Z0t+pSsgFTKasp3dpUX7uFpGySC+rAXQCOlC4+7FBpcyhZev1rwJRLURWLoC?=
 =?us-ascii?Q?52y1jqiEMfrrDfTGSxTJqam2nyr7lMAoOkGSk/hyryV2nole8NJqTmPkw+Uu?=
 =?us-ascii?Q?y1xtjHlcBdv34W3vN0NEFuA4ghui7Sv4nZVZm5suXNe/lItS8iMqEK5xrphM?=
 =?us-ascii?Q?HmK1721l8WIz9RzTd7KOIPTghzINBV5vXWJv61hemMjFtGrABRSd70PRSoe/?=
 =?us-ascii?Q?YqkaaI9a2J4198pAMqwJVfl/Rz88fAfYLKXRZS9vsIJ/4gDoqVASQJZRj5ju?=
 =?us-ascii?Q?LFJHIR6ppUBbicXMXzxKn+eJzSNfSQT76VGC3McHeVUC+1WjGc4V/4+4QS14?=
 =?us-ascii?Q?xZywk7O06M9YgaogeyrDXA6KcDCOwV6WyEGedVjn6fEyveFfli8W09ntxbuD?=
 =?us-ascii?Q?Fel33YCWXoqu+TpS4mZWVyeVtLbr1z3FLg69BEUH7uiM3uZIkzlp1SABBdtY?=
 =?us-ascii?Q?71bbMj9pM40P0UvHZRpsytwHWMBnsqwebR4MDzMeuaSgC5cfpQpkLLwlxqoO?=
 =?us-ascii?Q?3vvROGQFp9F/xM+3gWK4Hg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 935d10c3-8e28-4a25-3419-08dbc11a3610
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 18:30:52.5034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5dSuGunbf8O6xQ++SQJKVrGQwp5NgdZTLIP6iPhayNBj8+02mdI6v+YuIfMDJ8s0s381j6hVVm88gGGwL4Emw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7482
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_16,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=939 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290160
X-Proofpoint-GUID: qGKedXrmf0HFkzM0JaFUnsA7PO3Z4LSM
X-Proofpoint-ORIG-GUID: qGKedXrmf0HFkzM0JaFUnsA7PO3Z4LSM
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the calling function fails after the dup_anon_vma(), the
duplication of the anon_vma is not being undone.  Add the necessary
unlink_anon_vma() call to the error paths that are missing them.

This issue showed up during inspection of the error path in vma_merge()
for an unrelated vma iterator issue.

Users may experience increased memory usage, which may be problematic as
the failure would likely be caused by a low memory situation.

Fixes: d4af56c5c7c6 ("mm: start tracking VMAs with maple tree")
Cc: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index acb7dea49e23..f9f0a5fe4db4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -583,11 +583,12 @@ static inline void vma_complete(struct vma_prepare *vp,
  * dup_anon_vma() - Helper function to duplicate anon_vma
  * @dst: The destination VMA
  * @src: The source VMA
+ * @dup: Pointer to the destination VMA when successful.
  *
  * Returns: 0 on success.
  */
 static inline int dup_anon_vma(struct vm_area_struct *dst,
-			       struct vm_area_struct *src)
+		struct vm_area_struct *src, struct vm_area_struct **dup)
 {
 	/*
 	 * Easily overlooked: when mprotect shifts the boundary, make sure the
@@ -595,9 +596,15 @@ static inline int dup_anon_vma(struct vm_area_struct *dst,
 	 * anon pages imported.
 	 */
 	if (src->anon_vma && !dst->anon_vma) {
+		int ret;
+
 		vma_assert_write_locked(dst);
 		dst->anon_vma = src->anon_vma;
-		return anon_vma_clone(dst, src);
+		ret = anon_vma_clone(dst, src);
+		if (ret)
+			return ret;
+
+		*dup = dst;
 	}
 
 	return 0;
@@ -624,6 +631,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       unsigned long start, unsigned long end, pgoff_t pgoff,
 	       struct vm_area_struct *next)
 {
+	struct vm_area_struct *anon_dup = NULL;
 	bool remove_next = false;
 	struct vma_prepare vp;
 
@@ -633,7 +641,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 		remove_next = true;
 		vma_start_write(next);
-		ret = dup_anon_vma(vma, next);
+		ret = dup_anon_vma(vma, next, &anon_dup);
 		if (ret)
 			return ret;
 	}
@@ -661,6 +669,8 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return 0;
 
 nomem:
+	if (anon_dup)
+		unlink_anon_vmas(anon_dup);
 	return -ENOMEM;
 }
 
@@ -860,6 +870,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 {
 	struct vm_area_struct *curr, *next, *res;
 	struct vm_area_struct *vma, *adjust, *remove, *remove2;
+	struct vm_area_struct *anon_dup = NULL;
 	struct vma_prepare vp;
 	pgoff_t vma_pgoff;
 	int err = 0;
@@ -927,18 +938,18 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 		vma_start_write(next);
 		remove = next;				/* case 1 */
 		vma_end = next->vm_end;
-		err = dup_anon_vma(prev, next);
+		err = dup_anon_vma(prev, next, &anon_dup);
 		if (curr) {				/* case 6 */
 			vma_start_write(curr);
 			remove = curr;
 			remove2 = next;
 			if (!next->anon_vma)
-				err = dup_anon_vma(prev, curr);
+				err = dup_anon_vma(prev, curr, &anon_dup);
 		}
 	} else if (merge_prev) {			/* case 2 */
 		if (curr) {
 			vma_start_write(curr);
-			err = dup_anon_vma(prev, curr);
+			err = dup_anon_vma(prev, curr, &anon_dup);
 			if (end == curr->vm_end) {	/* case 7 */
 				remove = curr;
 			} else {			/* case 5 */
@@ -954,7 +965,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma_end = addr;
 			adjust = next;
 			adj_start = -(prev->vm_end - addr);
-			err = dup_anon_vma(next, prev);
+			err = dup_anon_vma(next, prev, &anon_dup);
 		} else {
 			/*
 			 * Note that cases 3 and 8 are the ONLY ones where prev
@@ -968,7 +979,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 				vma_pgoff = curr->vm_pgoff;
 				vma_start_write(curr);
 				remove = curr;
-				err = dup_anon_vma(next, curr);
+				err = dup_anon_vma(next, curr, &anon_dup);
 			}
 		}
 	}
@@ -1018,6 +1029,9 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	return res;
 
 prealloc_fail:
+	if (anon_dup)
+		unlink_anon_vmas(anon_dup);
+
 anon_vma_fail:
 	vma_iter_set(vmi, addr);
 	vma_iter_load(vmi);
-- 
2.40.1

