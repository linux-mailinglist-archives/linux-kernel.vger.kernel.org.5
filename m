Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B757AA48F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjIUWME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjIUWLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:11:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CAD900E2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:13:12 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LI5Vs1023667;
        Thu, 21 Sep 2023 18:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=wmamTxLzqcXd0eRCuD3mAlI9D2cG4lkSui9Yzhv2fUc=;
 b=Ph0hapUeblRM/Gi11PJfuKw2QD+xPwEXO7b+zzWwlqVyKs2JoPxqAr0z+AUovpf+TIxt
 r2c77hLw7njkWfW8NBWF9U4qLVAuih2+CwPSBCVxu1NO2Kf2e6FEd66nkahJUtv0qhMp
 Bdq5EqlkbFbqnyDh9rO6XP9lmPaoQLtjlf/5FWBLlT3BRjVImMtk1ZY2hhseEXLmblwP
 AGT85Fj7uhh+ZrDkKEDYYn62IRMDbKttfzKRRmlR7qX4t3hXHol0dUdEkAMWTJkcNCE7
 BvBs8OHbtjPCdKCO6fiWVIrJSAv3UJ70wMm8D22xil2kbPh/iTqHashlLJxcxSVlRsZi JA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tt000hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 18:12:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38LI24vp030252;
        Thu, 21 Sep 2023 18:12:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t8yw1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 18:12:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbshtDtsXuQR4gI31b7Ns1p5trsqynyWdAbSgrqDVW8S4LZisHhS1CdigHAoGh4zS/IV8khA/s0ljUvE8G4dN3B0qAkFGm6he9sTH0KlqFJEhDnpZQpSuF9Sn+RrHU/ti29wwHWBJw53B9GpHDsanQT8f+owNR5gFaHUhEgTsMkuI1UeDdtcdmJ7woUFl0y0ZVr9byl+1B/8O30ZyR56Xwo/srKpGfpzw9EIzMJ1E/VePf78FsCdnWggAQYrgXLjYfIeLhXdHwm2ZD87s3ucPW4ej/XOG/O0krPoG+XJGNs+fORl30/m1RGx66I5WAQTGgpvGwIHFalPLZ72EINq/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmamTxLzqcXd0eRCuD3mAlI9D2cG4lkSui9Yzhv2fUc=;
 b=UOeHaZ5NUk/sJ8SbvQlkZt4QhEip3nIx8Mc/cR3XVQIbQde8wD4cdcuQp8Ypm1rdasAaEL2bCkjbVogN8/XX9v0PuPVrZiuCI0dS16Q9Jei8kE9hsEyKt+/iJ9d41eIYt16oaEDx/I7pnjJC5D0ZVLOJwF0hIRVklepBHFWHdWD7wYVBRLrChNOicgEwr6TYNAl7X0Rc2RGAXVtfPkClo9ZPjnvxnIh1BxDaM3MAYEOZ2nRGaDaY/FxyZyJ8nHGCyPVUrYOYYV5ViBEaroG9K472/BLIDdSaHl1zdPoVTTCEdTWba8l8GH9ot5tAYq4RVkW6FERg6GOH43/5clKHvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmamTxLzqcXd0eRCuD3mAlI9D2cG4lkSui9Yzhv2fUc=;
 b=cTog2XGO1MsL2VADO8vZpOZxcsFcg8a5Q+muWVWO+v4zfGN+p0s3RZSz08bT0mCD5po19LCdKgKLmCkF1nTkh9ERam605G8Yb0ewPQu0OLv9E++6UNpxovadqdkjxdvnwELN2URX0cOul5EYJSQcGBaZ73JUWmtuDFkfgvN+aU4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6080.namprd10.prod.outlook.com (2603:10b6:8:c8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 18:12:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 18:12:52 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        stable <stable@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 0/2] maple_tree: Fix mas_prev() state regression.
Date:   Thu, 21 Sep 2023 14:12:34 -0400
Message-Id: <20230921181236.509072-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0426.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::10) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f85d47-01e1-4850-b3a7-08dbbace5f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1+bpAWcdgKaL5VW1C3srHBieVyQwJA1biZKYxluulyWLwh3T8WS07IWOmOAfLMAfGqkvHoCwp2XiQPo3XDfZAZMWy/2gL098GtuupEWxpXtAuaXeuyMqVqhu2W7Iln3biYGkjKu2pbVwA8a7ydJgnaHIYY7tksb59lthC1eIcHiHeBch+3t6Mzqw0amW3btY0p5s3v4nIDcn107zzL49D8nU2vsBDrHxY2ekUMhLE/hbNcFt/+CTuXe0wmteAg8gVcZNpDG7SkyNzuKulu6n/93ahBUdgm4Cg4Fbxhj3MF4DKEpSKOsFNXgESS5hZjK4oXN4RbqzZkVdhDeKcF9Q0b9yP4g7GLvEgG5S5t+QTQoDTJoOLIc1FB8v9k4bAZkNqPAd9k7kIj2266aplvE2+b+72UcxifOyCP5uG0vXvrFFZMiv6Jn++BizKoAEqqFhyIzKon6DIW2QjY8pxmg1E5hMOlMN5nXdmMWAF6nX9dbsv43Y/SRuUu8zlfy/7t8jLIQnD23QFL4iwvGxCekXi8HUMkE9NyLrPhiKY61UsUn0BT7Sx0eWxaEKy9YxwIkY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(186009)(1800799009)(451199024)(41300700001)(6506007)(66946007)(66476007)(2906002)(54906003)(6916009)(66556008)(316002)(38100700002)(478600001)(5660300002)(8936002)(4326008)(4744005)(8676002)(83380400001)(6512007)(2616005)(26005)(1076003)(6666004)(6486002)(86362001)(107886003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AII49SLA/T0XpH2ZCMTxnELYm4e34j7afngtF5rxprOPDAGrNsFfVW+iH3kv?=
 =?us-ascii?Q?vWTqZMQ57jKPJYAUwTRU/yx+cM4nltKcTy+Wz8Ysw53PqThAq82/nDDbMe9+?=
 =?us-ascii?Q?oVKHt6S75pxXAmhZJqrOjdF+fd1/LaLM5SX4DyuX73d+SIIZJDEW+HXTNH9x?=
 =?us-ascii?Q?8F08uW0Me9IRt4W9vSRjdsJi1r71opGeAVoQ+qe1R7AnA/QSI6tAsteqDYao?=
 =?us-ascii?Q?c5TIG5WAoHks86tkXsoXJw5B5THm2Zn29H1mb1cdvD8k2cXNdQiEAUg90Lst?=
 =?us-ascii?Q?rGkXJ9t52ZY8Y8Ey9Pm9kUez/6niPikcUZq2IZr+KQ9L7oH4uQQZ/dYNV+tu?=
 =?us-ascii?Q?SNx5hh1Tpsxk/pj8R0gKUveOaE0Wt1NH2m0Liblye4COR51N3mc4okSvbXq5?=
 =?us-ascii?Q?C+rTa975zmwAW0RwxpQ6ZSiV1o4dh3Kztn2BqhvktleRA/GQA+85HWaxZnVn?=
 =?us-ascii?Q?m2t+1bQuK2VxTVV11CZ8V3JOAXNlqqWUDRwi2KDBBhbngWjhHMdQrwkVDICu?=
 =?us-ascii?Q?O8B7bmhxNr32sq9CP7HpfL4wK865a79TZ1mav8zt+JBeleJLqRyvmoctf6yU?=
 =?us-ascii?Q?02zI4AieR2DgEt18vboXfVEzfwTvU/Cj5wQ/Q2Oty0XcMdY07eKskBhB867h?=
 =?us-ascii?Q?ajj2cb4/A1aM4JnBXDlup40C1zZdkbKVqa4LEq1h5DldthcFsxu+fTiqSK6X?=
 =?us-ascii?Q?TxDYZC/cNFOEY88qo90mcyXU0P8Xf8jXY2qq7xPQ5Jm9ykxPlz+4cjSHf8py?=
 =?us-ascii?Q?pLO4a1MznFBofMVObp2OxZ7j9h7hiSAcxiKsUwa5RcPIf1n1bJK69Q7JkqlN?=
 =?us-ascii?Q?Upl3mMFV2PR/7CrYlk7VwvL7T2H7RhcMMPBPFAfDmSq0MISWnq1d9irPWLC2?=
 =?us-ascii?Q?V4+7Zg7E4Wyct5BTooQwohA0I+tEm8OF+lkYK+vyw53m/spgH+IEZxmqs4OX?=
 =?us-ascii?Q?wxhe6EyS2O3zB4qidzKdOF8a9tyInVZtAnHXThuZFraiAVmzTyyr6ZmcAvAh?=
 =?us-ascii?Q?0Vxk3iViYh2Gfj7YSpiu/GjGhxCNxsJOiIPuJgnpkpEZZBI32HAdA0c7Dt06?=
 =?us-ascii?Q?u21YVK0pOK6JYAc254OlEc8gLW0QjYb6CjwawBn53QL0WILLrdTfapnIAIE2?=
 =?us-ascii?Q?0mzXpHpNyY5mmnNyNXb45d3be3yZiAd2S2+sRv7FCqvRmahhmZnV/8ChdzLv?=
 =?us-ascii?Q?3Cdzspmkm4aQzcTddtwektAsJDdoF4Y88iBrokvYrb1CPG/Ea72s/fV3GYxY?=
 =?us-ascii?Q?/HhO/jCgVNBinD6k5rB1Uk2ZmyO2M79PQo4h//543ptxnitMb9VlM9L/+lEc?=
 =?us-ascii?Q?QRGHqasAUk7qWxkS+KeIPvxwCg4OOGYv5uCag06je6AXniCMSfpmFQ2GDucU?=
 =?us-ascii?Q?bQLCul+DsrVwiJveLt/tF6RUNPbw7vdD+zSyMHATDBihd83yGVbadr6maLf+?=
 =?us-ascii?Q?uqJ1GTJuMykzot7nu0qqtD2Rf0UObUiw8QivgU6QqAVbu9khEv4sel/ggSpZ?=
 =?us-ascii?Q?wS/3B41J7uoKGEnZZt7TuSZOSH6fVwRA3zUTVscezr40KCn+pqQnPhNYIHLf?=
 =?us-ascii?Q?YYgeMaV1/DKObUwZKlmcU6mQgOpQgla0SQbYUkKT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?LPoaUw/VADf/vSk2M6FJP89Ik1KibBa5kF8nJn3z1ZnPMdiTqxXnKSW4ThcK?=
 =?us-ascii?Q?4fCrfQ27Lff98JtCfjEHyQbUeTrDUjVGzTecwGaflMd+lm5df3R/IAcw8VRJ?=
 =?us-ascii?Q?Thk4QR0KSanZZ3eoGmnpDIfBvg/KG00ssEMU/Ker89QNRFUc/ch79GKaY7Q2?=
 =?us-ascii?Q?GfYHro/1u31TmXQ7ClNLHWXhnZSxGUYaLPJ3c9XWbrH4VBOjDPf05gbc/6fe?=
 =?us-ascii?Q?hFzOP2zG8YsSDRP8LEA8jw4WvDEabT+0TG06x4Wap0TMXDGePQvRdi0vR6D1?=
 =?us-ascii?Q?EGMA4XH6oehiHptloHsYfERz3F65K9BaHFfPFcorlev2xMBJbVoqDS0I+JbY?=
 =?us-ascii?Q?RdItyUin4b/58gV5z2FOOnSyo50+bbwNoF2s/cqjBbypdSUYnDben7afwQ3F?=
 =?us-ascii?Q?/KcJchKxn2PuHnjduOws5P0lNJR0OBitCPM8OlgL699DDCTmn1i1VZXzjvqK?=
 =?us-ascii?Q?nlEYLRbNJ+r9A7v5b1KEQ+GiArcO88JQODYSkk7xwgIP0WobdYSWYjc9hFTZ?=
 =?us-ascii?Q?uVSUM+0D6f1jKjPsyjLvPLKrFxEyVa1GPZve2ZOhAx8Z9wgdfw+RNNITuye5?=
 =?us-ascii?Q?tPsU9xyifljFCQv2d244xR1+Xo+1zEackoNz7ACQnaeDxIJ0H0T/kUCf0AbQ?=
 =?us-ascii?Q?+pKbJgzQ+UJhj8K3thEaqfcO38CcwGy7i4ce6VWT3xf6ChhcElG52aH5BPvy?=
 =?us-ascii?Q?RI2AZTFCtKZPSgHlS2FX9o1PY6gsXUaN7ss0oBfhadQPBK0p7k8b4MA6OFxq?=
 =?us-ascii?Q?G923MUX/w3J3N9OROyr8tYX2Iig9Bub9WA9tuWnVIlZsPCCBW4/mVy+i5eDF?=
 =?us-ascii?Q?luOcVCamuWdLFmFqArJoYSFZxVObsu7IGS+AntDHdTW2pSiJYDHdooffWKpq?=
 =?us-ascii?Q?GhMHqXaf+dLwY6lXz9VzoXsJB8koAvNw2EDyVtmD5bQ6h3qksKYM5CywZwkh?=
 =?us-ascii?Q?0SP+ZFlA1amYxbuRUmNRrA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f85d47-01e1-4850-b3a7-08dbbace5f38
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 18:12:52.8012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZOjGm1ocv+yTjdT5Qj22kp+IcxZLD6ArHbNp5w7uy/fapvHXHn1fRyaUDHImHOtwVN9Cbc1shvB6VKIpY+t6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6080
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_16,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=540 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309210158
X-Proofpoint-GUID: 6Dl2L-HFdtoHvOYj_zkSS2qhKGeWHOTI
X-Proofpoint-ORIG-GUID: 6Dl2L-HFdtoHvOYj_zkSS2qhKGeWHOTI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pedro Falcato contacted me on IRC with an mprotect regression which was
bisected back to the iterator changes for maple tree.  Root cause
analysis showed the mas_prev() running off the end of the VMA space
(previous from 0) followed by mas_find(), would skip the first value.

This patch set introduces maple state underflow/overflow so the sequence
of calls on the maple state will return what the user expects.

Liam R. Howlett (2):
  maple_tree: Add mas_active() to detect in-tree walks
  maple_tree: Add MAS_UNDERFLOW and MAS_OVERFLOW states

 include/linux/maple_tree.h |  11 ++
 lib/maple_tree.c           | 221 +++++++++++++++++++++++++++----------
 lib/test_maple_tree.c      |  87 ++++++++++++---
 3 files changed, 246 insertions(+), 73 deletions(-)

-- 
2.39.2

