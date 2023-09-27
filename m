Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4597B09A6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjI0QJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjI0QJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:09:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C7EF3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:09:35 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RFswqn017171;
        Wed, 27 Sep 2023 16:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=i925ATwJ5OzaFKtSYuUijzeMW1Sa/u4mDt9np0ZF/mY=;
 b=0GebmamyOl45vR/K1dS4HPyAj2ZXcWtgV/ZxS1LMUJD8cqihgwVxa2ww1KXlYL3OzV4w
 fa/QogHwodCHcbaT5P8OSFprGr8eXoYB7DbqFp4skA88pE04o+WrwoMoRweP1O9JqmeH
 Y6HXBf5E6rS6GS6xlCHC1KeEuBES/NpocOHindC3KC7R67Bk13h9REKZiYWd50AZErQt
 qab2YvRNhoSeW0lhQHwMBs0sYx/a68dYosJGEeUhXOHILVBXr4NnIHv++psacRgFVKid
 sRH0bEwZ+vksy22JTfeqmm9dplbN67KaWrEUcvvyXvjN2AKlrBSzGoWeiBujt7WmhMVG Iw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pxc22dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 16:09:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RG1nli039491;
        Wed, 27 Sep 2023 16:09:05 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfe7x2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 16:09:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0mnvNcci/UGJEF8hCsc/sLGK75Azq+D1y27fwvkOn1kL1EzKGhUykPfTAjvfi4TarrsTNI4Kyw2lsRnGdODP1SyfufHY4+CeehmkHxU53c6qaXHhwiEHf4GLv8XGulKfMmqmvUM4ZveezddpU74ZLU7aD2fIDh09TQjDiM9lzlQhIZDGm1c6T4L6/+SbFEr3qyy/7pw5zN47Br3z4w/bgtVnEhVl35xURzlYOQFQLXWFUyzHhQkJVlAxKH3V3pm9juStqkDRIjg5AhRDKd9GkwR3WoVn3X9Tg7pyuGLOkp8wsWHy78dVzbxMaB1xbB/4fPaTnNaF5kKhe/ema8UaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i925ATwJ5OzaFKtSYuUijzeMW1Sa/u4mDt9np0ZF/mY=;
 b=UBrU5gLLBgwDQhJ5nc1+dDQaEY01NgCUgbzzlYb3ASAUL9tXzppQBbx1CupLpjxoz9tPlOSxwMjxfdYXooAQyxP8WYyzk2SWCs3/O7DjbPcChkilee6i6luIHk4wK6eaIFfRWbcUSiLvGldaX2H6XAk7VbC0TRdqzk23Vh8P51FsCTYTAyxeOmL8t7k9vV2VD8A949dzK9oB5sklTO4Ie1CdaIbCVJA0/+zK+ZMbqSJcvse6f1mWBPrZujDmiD5rLFDc546EJMG20jTE/i2DPw+f0vREUQglb2uwIi+9RAInMyJWNPyZU9K76HDqor/hMmS3R0nm15Ag5Jckt++2nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i925ATwJ5OzaFKtSYuUijzeMW1Sa/u4mDt9np0ZF/mY=;
 b=TSEfmmnSr7nEQlLsShcWnNaLj0v5bYBq9FWa+UViM86xmpABrrMzJiQBOLnMiUaLL4XjgueyFhalvCfbCKvhXGBLVEoj0LzxqfZT4M6fHFzVX3zBjqWwwXQLWiIbM5135TVSrOYrhY7jJrHIR0MrgAzMEJN1e9xnjh4+HvGXQWY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY8PR10MB6732.namprd10.prod.outlook.com (2603:10b6:930:97::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 27 Sep
 2023 16:09:03 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 16:09:03 +0000
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
Date:   Wed, 27 Sep 2023 12:07:43 -0400
Message-Id: <20230927160746.1928098-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0469.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::7) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY8PR10MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2586ab-dcf5-44e9-9c61-08dbbf7411ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 78P1wbDHpA8Lmnex34VLlqAm3bGCgXkwWJ5DxsByC8Kk4naOa10l8NkC/R89AD04e/gx8XdsPfa6ViPCYhN9FrquLoHXm+XN7FT8m38LoMXhUEuE+L2d2KFB5IlhfVcx0gXQZPUrK2hr13WmmKSp1aWMMYNFurYALX35e2OVnsb/HmxPm5iVoG4gT0rvZ6Ygg2nd1AEEd7s8Pa4/tnLFq6JOIZnQrboC0DdrwG7GLs3i638uJZLqkKeJlYIXc31LIqwOVedIe6UY/e1w01SPaMueCR5FlZHYp/tU63cdLhYUHN1ruK9N2NK4Ai6Vqc4RQ5RJOLr+RCxEwhAnI2m1NbBnYwWoCJFavRMzww27k/pZDDur07XNDTBLYtGbc3CqPmB6A+ZOn8xHXQsj3F60fWr1PUVqdrVdoZvVNPnzIorFZLjTia2AoBTZVweLlp33HjRrBYsc4kCS/1MK1CqZpxmTuNn137/VnCYupFM2qsukBwFdMIn73mYLqz+iERXlefjciy9Kae/4Jlx9Z2juuXYT+vwolUF8ntWdNK8MfGCaKLNh1GXIcPTqmmdmVyN0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(366004)(396003)(230922051799003)(451199024)(186009)(1800799009)(6506007)(6486002)(6666004)(8676002)(478600001)(26005)(8936002)(54906003)(66946007)(2906002)(316002)(66476007)(5660300002)(38100700002)(4744005)(4326008)(66556008)(41300700001)(36756003)(6512007)(1076003)(6916009)(2616005)(107886003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TeUaayxlefOdiLavOXX0kfgigBB8oVta4kqNlzO6/7q/FVfYXtR/mR4ujmKN?=
 =?us-ascii?Q?fohBYtc0sKllbte8v05lixTQQ8wGgfcpWKg0waoC6RaGhLCvhMoeoiTxoAKw?=
 =?us-ascii?Q?Nnk0YgJkg3B0AtRxzIzqNdRVa8MoYFA6p6nNMRVT9doCrzx1UrNyOn1Wfwyv?=
 =?us-ascii?Q?HoVv03HZRTWTC4n0l1MPXVtVIUl6n8jbefRdg6iZTcmeaMQVyRIuKeIhFsNn?=
 =?us-ascii?Q?i5tTVHuhifeeeZIp1Oe0Hi5rGSP6i+BAbpNMtyzc4K9fw5Led9WqmgduKT7W?=
 =?us-ascii?Q?kqtQlPK09zuWHGGqYW+tXkLQaugCFwK1rYygSElATf7r9leuZSiDJOQzPwWA?=
 =?us-ascii?Q?w0FVWN6YOd6R5Xf3C2da0tbzrtovqdgDEdEutxa5LPxOPXIiH7x8GcfND5z7?=
 =?us-ascii?Q?GTe2IW0Rawf3i2Or4h/S8y4wrcSSYlNwC889dl6nd9tB89RADn84UeucdP5j?=
 =?us-ascii?Q?qoOR9++YCCLL9EgtevKDCooaC8VXGJdvjY+tWYKvh1jFHKHSs77tQgHTmJQu?=
 =?us-ascii?Q?XTkNbRi58UxYdMLkHs7bcxTly7S+TFDujxAjYt2a4Sccz09SuqWzi+J9CuWP?=
 =?us-ascii?Q?/O9rWgPvggM4qq7SHmL4jDJRB93dEToIbhI2Oruva8/DH+gg5fe67K/rGx75?=
 =?us-ascii?Q?F5P2DzI/AriyoTQvwoXZp1Drn6xPEU02Ne+7TES4thl/9hA33zew5wAEhNlO?=
 =?us-ascii?Q?qf5uxdnvOK4k1u6ZFzv48ixUI3WGBBcTGg9YPWljDWhOh3xkjAK4T6l+L9qI?=
 =?us-ascii?Q?n3cXsJXfJfTyDGx1dgwc3gfagGunFr64IKb0MLw/cGiSZo0x/GMsFD/L6N1l?=
 =?us-ascii?Q?Obt7UCDRHK3KGpqrKz6gnbHQkEm4neRu26gO42Xj9fKHO82j00ZVFH3yWLkH?=
 =?us-ascii?Q?NTbe08e//+45gJs+HaCKx2o+9jtspAJoORlfxt2s34yj6zm5Xp8bh+/KyskH?=
 =?us-ascii?Q?ApcjhHT0uQjCScypdrwYyfdWkp2RO2/vNI0GSUBEwmS7Z3y4fqMD3cSr8Kd1?=
 =?us-ascii?Q?rFAxy0b3Fo4Sz/E2Km6Tcff5egnLkgHGmYWhJSlkG7xhIi4YPfBeregv4VDj?=
 =?us-ascii?Q?9Jvc58LLrUb0BFOozkW6Wfn+1ER6aUycBkTISliyQkpnD9hJ9nfYaOrsUBHB?=
 =?us-ascii?Q?7LKbVd744VxDTz3rGe5izslQVxwn66xqTzN5B/804RqkBICEU0ioh79tvT1A?=
 =?us-ascii?Q?QtmVRQlm5f5Q5IoRMu/xAahbVEcm+un4JrFHppxb+CUyOK62toE/zcwHsF07?=
 =?us-ascii?Q?dXPkXAg4nUao6Xtl0DQTEaA1Utxoou8iMVpEnq1EucWI/8p2ioj7QyztYQN/?=
 =?us-ascii?Q?30S+M2GZtVyAiOqbh7nihGYAx0NuE+eR7qSgurrZ3OtfkdyKPtJMpUotrZyg?=
 =?us-ascii?Q?gYE74EjDsQRzo6aPTbcvPxlq42Zmt0gOmMhDZeJ2k5+jV0iSnpc96Qo7WVBL?=
 =?us-ascii?Q?vcOCDgmkYpFQGbWhxBf34NACXvb05hxa2ZI7xbknfMo8vh3WLgwG5wNLOBwg?=
 =?us-ascii?Q?AHmhS8y/kBkHtjDAhYEcZ61VVKlIkq969NiOoyY20brA7ng5pC9/8Mfn9ocp?=
 =?us-ascii?Q?433n09F2yRLK7ewoMJdsJ3DxLe3EqoPfoGvuA6k/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Zxehnlo848anGKt3u9k9kvPfbj7uBzzYsxg9ELUQDzo5KNiksRPTAs4zek7G?=
 =?us-ascii?Q?tZIi+6H9ZZjaK2gMMBgGxhFTjUeRA4v+X95eS/Hrg8DHVSejZxbjBICx83j2?=
 =?us-ascii?Q?342URfrHb+H/pMYsWeTnAlHkvp99rvPG49muDp5Bs9nOVa+zgDbqcIzj4QQn?=
 =?us-ascii?Q?vzz+I+EUDhVXWObF3orZJws86/Ca/N9+45s79RgYU5/5VYCPqVk1QyZLSJIs?=
 =?us-ascii?Q?1m8L+n5agexqiKAAKEfGwb2YLzp16+SsqfFHzypuF5k6z2BmySyofcW68cgY?=
 =?us-ascii?Q?AQuwa/lq4/lnH3E/dTui3oX+EbYtaE/B4dy1CrVuoSFOAcRHC5V80LEfY+X3?=
 =?us-ascii?Q?D0ZRUifJatzBSFuBU6fOrzo19FpOqkc8xkM0KjcNLxAnvpqlWvRw+VSl9aLn?=
 =?us-ascii?Q?TukfivQoRFoP7b0XA+sogmK/gFtb68m4+MAgCnpKHYiloj42wzCyQynT48ZN?=
 =?us-ascii?Q?ngOufTvsezm4IcLLeZ4tcgkYIgS0Jbgh3w1Jhq2GYXQg3eBGh4G8OOdWeUlN?=
 =?us-ascii?Q?D8sHvkLICJ+PFDARxXHwPG8MzPfcgCtcYiDQnK0k2zEEXRTPs2Nki197489x?=
 =?us-ascii?Q?6U3L15nV1QWPfh1gszEKJdHV5iWd7ET+55SXwwoOQ72UCFRJxNO5FgF46Gix?=
 =?us-ascii?Q?cYsjHZO6oTfNv9aSfLXZc5Op+BgQfd+yyejgikHyzLxgoDGudgNJ0RAtSkZU?=
 =?us-ascii?Q?DZjuDUUtXkkELiamwcABbJEKA1ER/Eh7VxqQkJsEbjiybd0kRw/d+iKa+5OK?=
 =?us-ascii?Q?P8CRi8Smgm29z3l6iB8UQgGP8Qx0v3yq3KbgO6l5WBKKwu6fc+H2PKcWDzF7?=
 =?us-ascii?Q?dcwXzyRqbz9j/gZ/Q1/hjuy5MwzBcGK+TQu8IHBE41xoY4uZBYBLXsAVwazP?=
 =?us-ascii?Q?3mZNp5wibEFNpu2ZS18I1uxrAnVDuJOFGRtSM+JALvvE40UWOscWhv6Hlep8?=
 =?us-ascii?Q?oJfIbG1AQnSMwVagVZiMPWFWjsjFxw4PjlbCpe5NIzuHixjbik22OHQCw9UW?=
 =?us-ascii?Q?sHCG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2586ab-dcf5-44e9-9c61-08dbbf7411ab
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 16:09:03.7599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldwKfh6YwPbtDu2R2GF4PcdKwKeIIsSPkULcwq1UVHGoabLRfEjaR6C8ocrmtlTRNZZZlAWAF8WHA1f37YzKDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6732
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_10,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=295 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270137
X-Proofpoint-GUID: zLQ9Vdg5JJw6ydibhO3WNaophoJ_Yn6U
X-Proofpoint-ORIG-GUID: zLQ9Vdg5JJw6ydibhO3WNaophoJ_Yn6U
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

