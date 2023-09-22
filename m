Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B2D7AB4E8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjIVPjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjIVPja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:39:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637F2136
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:39:24 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MEFQ8F024722;
        Fri, 22 Sep 2023 15:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=mWWJYan22KD/ahSDQMy+JSbP13BGKbZ5O9crtSXopfo=;
 b=S/nUminaotxMJjAw7QObSTW7EoJvZwI/Yv0OypSHo9DS7udLfZRqHvYN0IlFukGB0MkS
 VcBTEy2ukch+M1++CvcSoMgnd9mmpMTpJwZDsMJ+CvUBJtjEjJzVQo0+CgSAqGVPmRD4
 B8vVH5WOI8gWgNACmK+L6F12etrpAXOFkWsGkeRK+bYKlEWioymvdyotO0FYepyilKPZ
 UkX7rQOH6AlASB0xcen93xdfTEkzWX0PNVOMfC53Gaa/A28WLyCEUQbje6C+i79T5Vfd
 CdJVLELuTyIlryQa56Jkmi2trk+Wt5BTLC6sQJCtZfLcg51P2bYpUvwmBGoxld0ctxVI YA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsxt4aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 15:39:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38MFPtPK035050;
        Fri, 22 Sep 2023 15:38:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t8ty2qpmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 15:38:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnLJP62oZ3iMTBlu4Owhvfdy0F+j6T7dO6rGfe/QpL6KnjE9JjMbUpkR3rhZqC8+LmZSNq7RrKtBEQzs2LWOp+J0s3lD5CO7q3KGw4AE0V2R0iK0l/Y9SGvz5C1iEcT01nyqoSMKnMXpfosmkt56X+T9z9ezeug3KzGoaPEtpXy+z4H1D1WLjlVj3Avh2/l5/9p5nhubY9D6sMP4gEiLRt6lIuO5jGf6s+E4b0848ZpB5rUjQdaPclxYVmuQ29qbmndvaFfiiO9CSvq8zAfr/pmPORq3ZnCatWINV8knhv58liDJvgG24Sf5xPABinNVVig6/PCxSDiqqwsGQtSEFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWWJYan22KD/ahSDQMy+JSbP13BGKbZ5O9crtSXopfo=;
 b=lUSXKwAc6uzzy6k3HfoEaC+01CxA1ePVVviDG94PlML4UXbU5NbSB5a396GUim1KaH4h/pgnWmyjHgag5IR1u+oO7eRReRLwTsNA+GmooafpFT/+fTgWIkrdJzK6xvtUJBQla3Onk/iv9tgBu2qrGGMM6JEEr6lVdpixsB5ZasU3sIohyr9srwTpaXk9+hC4uJbcqZ1kB77xFX2gi7NcRWnSXGKQC84nYy7y9xdIXKC+5WKc2PvBPXUPKnUvcgrUKt10/5lQG9uUnkVKs4Wmp9kOREvtdRyiyvfW36OaYE2C+0ee7y1ekwgpKIwDNlYoOI2cB3+pnFlZKC99Vjt5rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWWJYan22KD/ahSDQMy+JSbP13BGKbZ5O9crtSXopfo=;
 b=gPmCV6hYJeF/k65NXQSI3WzKl1RZM+BhTVR0ykZ87Sv6c0tGSBbRDGyOCwr7/nlbXbqXrHtOj35Z8sfhn1f2JA2SMrQs//G/hgfh8xVvIS6TuteEcQKKBBdJ9DtwFHdu+efpgw2+zOdgwQWW5Te7UBp0gzRLEQKXAfve3LgsRm0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 15:38:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 15:38:57 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        stable@kernel.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 0/2] maple_tree: Fix mas_prev() state regression.
Date:   Fri, 22 Sep 2023 11:38:51 -0400
Message-Id: <20230922153853.767603-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0017.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::30)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CO1PR10MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: 2067cfc6-808f-4386-5220-08dbbb8208e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1E0k+zO94oIDgN6yO4zV/GxolOxYxl6b0y+b8Sqriy8nULjt4KfcjJV9ojFcL9UfUF9UrtS8TPF2BANEZ8lZUGN9XfwvGHJTn6aVNGMsLdiXm83nNplWyBK6MMHrLTEPCCVKGe3wMannUVanOIrHHMmxP52SXiLl69ic/5PAzDHGDkbSth6cQXdXIvxQeSf5KZxqWcmPSQvPrGtrj5Wnzc93pZo6FbJ4ojlmpfVRKCVuGnlPs49XCT6avqbrkmrpx9vHyHrIsLPUwJJ9v38CoZeMQRIjuyHgx1k7yFOeNVxrxMNqcoV++evsaxab/eJRIG092EIXnMw56abtbSMJfx7FSkVIWnoKc5jRrw6AJpCKXKKiibXBxTuzthElQV8rymYZoRN0tEmaHKLKl2sxBTwvwMy2Z8gqZJ1B21Ybi+lRRXB/RUjn7iIkI6d9qYBmR2ylkmdZbdfZsXyjbatB52JPOm7cMNdIRF3qFOSS3ZE+PC91MYz2/uEb7LpLnR9lbuavRTyJXdzsOzQHujLPfOgInUTEC423wxn94RKXKbA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(366004)(346002)(1800799009)(451199024)(186009)(107886003)(316002)(66556008)(66476007)(6916009)(66946007)(83380400001)(6512007)(6666004)(6486002)(6506007)(1076003)(2616005)(26005)(36756003)(478600001)(966005)(5660300002)(2906002)(38100700002)(8676002)(8936002)(4326008)(86362001)(4744005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?319cuHik2YqpA939lKP5ZdX2muurV/RGsUJ8OwjcNDMWn5/aDHU1+o1GvovK?=
 =?us-ascii?Q?gyKCRWiz/TIKGSWKWa1qgrsnydg3yI3R49Ld9Xmd6v0aeLyIfEFTUE/sdC99?=
 =?us-ascii?Q?a2Nz77mvLUgGCkToaSb0mKvnxNjVfcln0nisI/cSZ7KAx3jewm0OfeqfumG1?=
 =?us-ascii?Q?iq4WVaIXlHrZCX92Xn+K0q7Jw7FzFaMgzttgb0jcdkTQU+tNh/oz+Gp4QubV?=
 =?us-ascii?Q?k8aT8kt/qNRlmw9JguW455euqudpCJfxQUoOu9SeGqvUGLcTj7dMCIGXpRHK?=
 =?us-ascii?Q?LtBpkZR/fGOv5t1oO6vWvCE3/lcmVyQSfwoQUW00pxAXuuzaSUJFCQ3GtSuP?=
 =?us-ascii?Q?s7eojN6lNfl4YXCmlTAgaXxFBVZrV68cS1g+yWkyuVkqDcOXnxFlIcuynTvg?=
 =?us-ascii?Q?LS4tEgf8oNcDUAs94RWFW+yyl5AQDT1GfmFYzvjaao+6tJf5Fg//Mgq/9OLW?=
 =?us-ascii?Q?6wvafCJ79wDdBLczC1PgyKS2MHyAZyzWz0Sowkih5A1/dsA4i7GPOm6e3O1h?=
 =?us-ascii?Q?hwU9Cx/XkJq6WXb4FVfGLF8E9JLgD/sz2unFO2BEsnppZzNlOfOwbCjcjHxc?=
 =?us-ascii?Q?GkR7m4MwoHOaMPIBNcHcXT6rdgVZoDnXXsPaU2qBJcO7mcJC7BVzhu/tEGH4?=
 =?us-ascii?Q?qJxXWIqnrH4IRzQeAFTv/+76tApJOuLuTSNeqQiO9oxrEedPmgDAL/9y1rZk?=
 =?us-ascii?Q?aLZkBdP5x3tWqVBwMb3SDOf8Pw4hxHt8xEbkXPoRcqKhWUNTxQlpFIYXHhwn?=
 =?us-ascii?Q?qCjQV0T3OxEnM5eOd1vhuMY9h3gDfj+0G7Wu1A9X75zXdEGEvdrzuDF/ZZip?=
 =?us-ascii?Q?U834DlieuKdfmCQ1gFXhJzlYlOXKX2Fx9wwK50P96QZRfp1mmMa+2CPuc0i2?=
 =?us-ascii?Q?aoZiG42iVkoP+Hzcve2/zmUbIdpmrLuuGH+8N3PCuz6bujKUYMJ82JV1bxG6?=
 =?us-ascii?Q?f0RjL130AO+ypHrERAGHUVEaBNy+fbERdJupYXsWQ3pK4rU8mGAkQVAGJ6QP?=
 =?us-ascii?Q?hRbqquZENNAVGyFrf8QmSA3gDEfb/l2nppqltKFWqFILQcmEj7UoR766srWx?=
 =?us-ascii?Q?tSEIlaA/1cxJj4q5Ld8Q5QwVlrRqd5iH8yULcIkw9PUM6aZH96cxcNQIWKim?=
 =?us-ascii?Q?sY82A9tSeikFHNpX61KP61rup7MPSw3g9WfFUjgUfFcH1Kj+/k7WzfPj9NaC?=
 =?us-ascii?Q?5TF+rtcYbgIULxSucY4AQvrbDDNaDA7WAL+Qg3X9B59FYn5VGFTOBeiPupc0?=
 =?us-ascii?Q?06R1X9ykcpnSGyajkQfwY5s54Ut1fCY8OTylM04uWxiNgzfj4OXkFBXmseud?=
 =?us-ascii?Q?s/NPhyYHP9OJqkfwaKmObxUDOIGNcmo3/uoRyfzq/9YZ8sx32KkxEA3Bc5B8?=
 =?us-ascii?Q?GN+AAW+RMZjTHgD8LuB8RVvsX0wrbRg7LJA556Ok/2Ewj4wyOhAqwFw4BWSn?=
 =?us-ascii?Q?VGwtHcSn2fO5KTvBwLW8hAodnZNHAOUYt8CgHigtKqa1ofyBV9+yNEmfx/UL?=
 =?us-ascii?Q?+VXpyGjEb2y/Fo7+PHnhHCc/HPSzJrKpLAfv1RjpE/9MabHWCjM3tpAlcNwf?=
 =?us-ascii?Q?zuuEwUnarqdpAXk9YUDWfxvjIUoFNYeHPYtzlvwfSOVu2HKc7aPHJZGMASSX?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?s7KJz25rL3o34EAnLxQB4Ub8uy+pBUgj224QlIW+jCG/8dELVaXcodNR6pC1?=
 =?us-ascii?Q?fD+t6Ax+YtjYg551IEHLRi7gtBUBGPT8wk8Qzpn3E+YLTPB8AG330x7zCaoo?=
 =?us-ascii?Q?Ge1m5mLJDtYzoNJNSJImKYSp1PNkHrtNcubzkxwADUDfM99RougyZTgU1DlT?=
 =?us-ascii?Q?z0kAwUFR1Jh89xVAIeMBxjuOKhdnx2sfm2FU7TG6psjXYZ3h3L0EBkbAoz3F?=
 =?us-ascii?Q?A/f7hvpEaLMctGxwoghTTfI1+27RwoONTZ1WlPitoPmmHTwuR+h6qwyu6m1U?=
 =?us-ascii?Q?TOulhqRguYSzF874halajfA1/CxMlKAYS9lLXCQZIJN0uSU3nBFytpm9ZNF+?=
 =?us-ascii?Q?Sv97s/LVbbSfQ5hLNvpjBEsQMDMb57SKmVoxXv0KpCYXD5E8nT0tlxdBmJIs?=
 =?us-ascii?Q?fMPjAhty+V+n1FlmL82EvISWj+03brXBrCeXiz2FfFIf9PkLuhwSXpbm5z/l?=
 =?us-ascii?Q?jygnljray/8Tl4wYpS6vJBzQD0pp/AoRar2IQ8dEWnz2iOC6gTcX/yPjZYUN?=
 =?us-ascii?Q?JlHGcjUloYHa2uVVTNN0P3JbXRlRIoffAtk7fSGWxmbd4YbJy+NVdLvTWF1h?=
 =?us-ascii?Q?b3TKLQGuYrkuCT5/Oq7mVkZpaYfflvv1DE/rNaSxI6vcfoCjMD6KuKATVUlB?=
 =?us-ascii?Q?x+2wgkm2ZMzIr9KHLqL1zLqWp1wTHn37CDQ1NZxVmoOUTOsC16ljM4Q+cWPJ?=
 =?us-ascii?Q?0KgHr2qRN1Eb1c+cKVgXdO9VLV2ZBKDxQy+yer2PDGr5p9t0olzz1ISwtbVh?=
 =?us-ascii?Q?VsJSWIPXtJLy92WNyLpA1NUprrWZwMdDwsT+hIosy8p4h0QmTPdj1aRqPqsh?=
 =?us-ascii?Q?24O1WgwAP2lYfz3dzAgn/Q7jZBNagMXVnhodn3/mSXSgpl9/zZh1/0bVCR1m?=
 =?us-ascii?Q?Vs/Kxr64wWQ/6ONwIkGfPB7q5Y5dF2/m7CR7B6V+QfqHCHaognLtx8Ewh2P9?=
 =?us-ascii?Q?y+Il0dXPBakdu4ZHlM7b2A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2067cfc6-808f-4386-5220-08dbbb8208e3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 15:38:57.3456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1zIDXmEjTxlULVVPMEkDBq3q1V7qSz3Jxv/eWbeCj1CZkjtkL+3PHz/ZuyC+FlnGdIykmiltU2jAj4xUPkrxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_13,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=437 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220135
X-Proofpoint-ORIG-GUID: lv3OfA532ZYrZ4RpiBuKtMlK8bfTrm1a
X-Proofpoint-GUID: lv3OfA532ZYrZ4RpiBuKtMlK8bfTrm1a
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pedro Falcato retported an mprotect regression [1] which was bisected back
to the iterator changes for maple tree.  Root cause analysis showed the
mas_prev() running off the end of the VMA space (previous from 0)
followed by mas_find(), would skip the first value.

This patch set introduces maple state underflow/overflow so the sequence
of calls on the maple state will return what the user expects.

Users who encounter this bug may see mprotect(), userfaultfd_register(),
and mlock() fail on VMAs mapped with address 0.

[1]  https://bugs.archlinux.org/task/79656

Liam R. Howlett (2):
  maple_tree: Add mas_is_active() to detect in-tree walks
  maple_tree: Add MAS_UNDERFLOW and MAS_OVERFLOW states

 include/linux/maple_tree.h |  11 ++
 lib/maple_tree.c           | 221 +++++++++++++++++++++++++++----------
 lib/test_maple_tree.c      |  87 ++++++++++++---
 3 files changed, 246 insertions(+), 73 deletions(-)

-- 
2.40.1

