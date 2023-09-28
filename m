Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166477B23CC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjI1RYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjI1RYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:24:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8CD1A5;
        Thu, 28 Sep 2023 10:24:51 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SGiA3S011528;
        Thu, 28 Sep 2023 17:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=xS6ZZlPsVWC+ae4meDVEh4kPWgFjyo5rR5PFYCb4LHI=;
 b=dYrOEzbM7PWW4DiM0devR8s5jvRrg5AfoFudMNSl35mgIk+hYiNv6KB49It/QQ/WiHtB
 Jcb13W7fz4BnBsPH6ms74ncwU27eszFReMrrQDaDCQHAsf3rq3qhUDyHnI3dx8xmNnBu
 LegLnLFKUkXlEX1MA8Jp9vDgDE047HQyGOPLsT3FMEf1O4nOWtYEpE/BfyW3c0eS2LAi
 xzrVf2wPBQf5oZb2Q/ds8jxnTiNUZzffF9tqcY4fNb9h6vJnfeuAIZvB1B4mTYSvHK+q
 HR5nM0bbw5HSH4ey03FYADq2DZxSoRD2TF8uGcuVDKqxs660+UtS2ymc3LxSNFyFVR05 jA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3w36v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 17:24:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38SH2MC1004871;
        Thu, 28 Sep 2023 17:24:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfafb7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 17:24:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRs/BAHkhVvzNz8UFjrM+82wtPyo4YKtT4zM0hmCznS2JMP8KpbO4YtlB6OFvIfhKHRhijw8DCGFPu/zbxJZjAn6n98nUeNuDrjuyhs87yI2MUxqu2b+3Q5vfYN7J0MW8TaRd/IvgaNehaIdS7OtA+reAY4R9tfJxpclT9oYiJOzDgPFe1DfhOYuD/ZvGbKJa99FOSBmNUBi4dL8ENo+XuGxTa8tW8iK4sccBIPs5vLuFxvOssjSbK2lozt720IAm8DY1XvgLGwJ9ImPCZCN6mXDE2t/NsgV00LcabWLb+SvTr41oGzAqJ5BBf08d5apGGGFBQvVnW/diXNvAa42Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xS6ZZlPsVWC+ae4meDVEh4kPWgFjyo5rR5PFYCb4LHI=;
 b=IfFq5AE68ltfrl3fai36Z1BeAQGSJ0ECjvCpRkvpAn4lDIWx8ZoM7OXJ4fVdN57fbXe9MA1qY+0adqaWiX49TUVF+06xeDSfxV5cj8CqMYRMhJwkToLxCCaNAviYPiTJhyJy77/at/8U9PAn/q42zJk4ycLCsr7aRd+3QTFKeYUpRj/gKTKGVke87nXVSTOlXkD3s/hw9ZVIvtPhJCt92jN2Xw7O1Quf1UaYNsyHWyaGPy1UJDrs4eL/ZlDBr1LPPVuHEbC/b5yNGjrihs7ES+jT2WKxMVbMSF9E8Lk0hZqtMr0iTVhrJX+nlcPyayCvSRbO6rklcT/OTh3M6ba9Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xS6ZZlPsVWC+ae4meDVEh4kPWgFjyo5rR5PFYCb4LHI=;
 b=q4L5FSK3aHtddbWBOXEktqYOrmtH4RW7b4zSwtNTugDZmm67Noy71CBKJrF4AaEkIsdRjSEJ0m/fYw22oHDr0Qfy0PXeKrNabD0yfHFD8XqnS9lEshQW5Sai2UjnsDWg0knoK4rQtd4Gb78HUZRq4o9doAm0amqoHD75CVMdjuk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5273.namprd10.prod.outlook.com (2603:10b6:610:db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 17:24:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 17:24:42 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Lorenzo Stoakes <lstoakes@gmail.com>, stable@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Yikebaer Aizezi <yikebaer61@gmail.com>
Subject: [PATCH] mm/mempolicy: Fix set_mempolicy_home_node() previous VMA pointer
Date:   Thu, 28 Sep 2023 13:24:32 -0400
Message-Id: <20230928172432.2246534-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0223.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: eeac5366-aaa2-40db-1a03-08dbc047cd6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A2xt3QWO04Hs+vZ3z3+4PXRJFJVnvBERUAVwsSdcKcEmYYyENr9YBsZRz+GA76LzOXLXYb/b4f0q87JcTSPeSrIh0FIIO3fgWvnfdYqZYBJVj6fv8Sz8w8fabSWpHAVQQWeI5z8M/kw7TEw7c2avQEjzNh9AWIMX4/DiK1khKIICaXUkDqwJ1IVyWhBWOdSyz6MqOTv7QDWcaSVYOAM6DlHyf+8/W+SnHH2pf9hAZFYim7d3bUGT0lsatx9+m2rjqqpUlQqAQ53EOLyKmbWh0VeAXhuPegrg//ci3RYhPoF5NceHkxU8GUDMZOdEAIKCcfg8bcIazivpcJnm2mn3fx+tgMAtNh/Hlw4cod1112oKc9SJxd5o7inpMVSil1bAIXN8lpRO6Z3LHWqh9tdMo9czD645EO1ZsVpFf0i2Ku2dQ58nXaaywFh24wP8lXJ5axItxqX03yGW/jmB10iHyEbrpvmuq6rFKOXeTthhzHVNwWFr1X4yMbsJeGMGWhxgRcTVXA9mmQT2paCJjwCedsdAU85dlyhOzC0ZYosWW5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(4326008)(5660300002)(66556008)(26005)(83380400001)(1076003)(66476007)(8936002)(54906003)(316002)(478600001)(66946007)(2906002)(2616005)(6916009)(966005)(41300700001)(6486002)(6666004)(8676002)(6512007)(6506007)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3H/K25v69WaGaPxVXd/xeCO2d0QO2SYNQZ5H1Yi7gNV4LhbrO6jlotZkqK5U?=
 =?us-ascii?Q?PVvzQwecWq9sdJc7tzrlZtPHFUBFuF3MT9dXDMhlMrpdwKXB+Z03LDcXwwC/?=
 =?us-ascii?Q?V0dVdWbWTTYRzUbH7YEkCj8wvv1oW/Y3E14H4nfx63lUJQs4QjSpQhL1tLEe?=
 =?us-ascii?Q?cjDoZAUsxOSznyi0KOPdZwePQUwhmvNlzebJqNqIy2WLeuIJc+n16x8P+/vd?=
 =?us-ascii?Q?gct9oRo3hftzteGr3wKP18WojSKvgpSDEOH6GSxNxWexzrgZd7Cd5WjPA0Bg?=
 =?us-ascii?Q?GgwiMz2zJ5ZmvcBTLyn/3+bJhNDQpDd+2D5sV9CK1l/gMtExZQS2PBRAhzEy?=
 =?us-ascii?Q?eHKH7wbOjMnI2mo3skPUyelxvEqvPndYkxKlknQK70umfQFvXWbbal3xDEtr?=
 =?us-ascii?Q?E8pTjBvr5iRncX7r8TvKYqUQq22whGr86u57l1BJHS+6Oi3Npbr/SBF7okpk?=
 =?us-ascii?Q?GuhCJhyVcSoJ+YW24v5/Jh0AiCC1GgCMyaoRixdoaR1e2ZCnej0t9pXh5N7B?=
 =?us-ascii?Q?kPP9iNO0QDHi7YDuhNR/Lkxs3Bv19wuCtOTzwHDgA3FRAyaMdUAw7Ct3nIx5?=
 =?us-ascii?Q?Ro8CYYv/g8pb/SLJSSVA63blJrmMsVbdMdFUfK/MegjZ8pEbPN/ITNN5948Y?=
 =?us-ascii?Q?+hhZGS7qtSHpbAzJTpugzShJXSL7GnFAAQYO3dzgZX64yelINCFijxnWqnaF?=
 =?us-ascii?Q?8ASxugRiBy+18fYWyb4fMJ6YFxm+notWZuuNR4sI/TUtECqE2WG66lF4WsQF?=
 =?us-ascii?Q?4PbJDA97ukkjameybU9R8OLrwXSKPPYyLxCU27g6zci0dGR/pyXHnwl1N2UI?=
 =?us-ascii?Q?DoNDleLA92G7R1aUzkoRcBS8jx1viyFT93BIkDdpiw0I7uwLcnyORDf2ViU5?=
 =?us-ascii?Q?19jaYwF16Qxht7WqrSn/hyjmX2mxrYcYWo/vgxJFL3S8m0uM3gnJkHzYbd/p?=
 =?us-ascii?Q?bF1ygWmLMl3CJLJONhgIipQha9IxYCAFFEFsZx5uYP9NmfuloVnRBb1WVeDh?=
 =?us-ascii?Q?NyDFB4SGFvJ5Gou+ZSlOISfGZpcbGDRzIw1UJt4a3kenMyRZuWp4E+3SidP/?=
 =?us-ascii?Q?6VqKw3jeW3ojCBk0Vv/MzE42PbWaxWKyFOBQRHF40Ro0/JjkN65O9uZ0oloZ?=
 =?us-ascii?Q?7PuVGQrH0BH8BRHAl8cTHYAN9QUha28JBhmyqAol2NUlob7hfl5zuC8uEpC1?=
 =?us-ascii?Q?YblCKBusLARAweGiZnm2K0Kn3T5EmvnQmzEY9LbW3DzSjv0fNao6r8c8GKzt?=
 =?us-ascii?Q?omJSdQI2h/9HaycXK1VrJl7/bmKW+X9Z78KHvjH8oWhw/XyN6gTY1aTGbNBz?=
 =?us-ascii?Q?uO4r0Xk09EI/DWlIpuIgDxHuXpeOa5K4ErtUKp7wvz58lmjtw9sdZjuLl8R1?=
 =?us-ascii?Q?me5IvSBEvLnmEm2DBnyCU55hytdymN0ObBiZezZlZJ0jwwjnMN5fr59MXfl4?=
 =?us-ascii?Q?0ogYXF50RyK63XQfoh4jseliLrdNkh0vdNptgg1h2+0E2orVDwyXyRzU1TUB?=
 =?us-ascii?Q?1nU7onwj65d0zF8ITjvAH7jxDPMUb7We3Un8jTRPDSCJhUEJRoGhKrINtgFH?=
 =?us-ascii?Q?6ysKH9oJNGwbKpJQk8lHV2uss2aZyGGZzwejpMfA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MsajK1WBEPFPl6wqUhAyd26AlXQejHbrjwS0jxhTm9tLEsKwL+Ca0hZrcun8pUMxtNw6MwKvy5ydlrgIgKDegwwhXmNEKjGK4VKSidk4csXnaOftVuwY8Dafut/vUfadOqOzxkn02ED+QkBfaIJ5IGmEOkhpVBxPsKUoh77JwfDA/muJnnPNNQu+anvNd39k11LD27I1i6YEKRGfzcpi6e742+OCyeenuCbk7Epi7L5AqSS0nMTivriZ1jQfC4Xo4uDVzohbbOi9FEpzNv6nIdS8SCqtTZJMz0qQxMMWBoiSbMPcQgh4Q4C34NGnsfePQbU7xgnIwS+weRVLY0ZhvC8OLW5JZyF03Wn1NV8ybEtdQ3NoBqLMLf1V3nZT+4LptmqrdQUdPCEyE5hj5TnStQ4OXOMS/Q8m9BvvJ/v10uQG6D82TdveDe+JXLhzZRN1YwbEAnuV4b0Fg4EGON/V4KtqcgNDKcRmZNvAbemcY0+5BpEt2RJqcecNpjTHQaro/dLOSAxbquzKpqhgyKfuHFQsnzSZyJ7oIb1c+PDeKwtOzfzMq+0IiiIh2sdI8TDsiszVPpC+RDAgilvxt7bDwmyqri+qcLMNJkxwhQj6z4FRKj8LKOGs6WLpkq8Z/f8ACa8yKHX+qdP+lzOoTbp68Obdgtyd+5ttupB5TyniYBgIt/7tZQViCa3p81TJt7S6cemm8rzrs9tL0TZvg0jKcmVDytiip7Csf9ec5pyb1V4YAIpWRFFG3Yb6ReBSJ6eYUE3VG97bXA20q4wOjpt8aH0qOJWd6AMZiJ4STXonR8Rwh5mHbF6VnOfq8Ewyrjb2ANYDVD/Rrgm5KgAU+RwL5ODuAnwes0EwRQja798wCSrHpfqqAcNvUHgj5+1w2Rpp
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeac5366-aaa2-40db-1a03-08dbc047cd6f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 17:24:42.6121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9poflh0epD/VTg1zBQq4KZtwnegXE8XshYCbCRyu5J2pHXLJHIrzxlV3Rj1wvVkreRlObMheV4Dwq1Mm89d84w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_16,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=764 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280152
X-Proofpoint-ORIG-GUID: mTUg0IfIfwQckJYzAU_SoBLKbbgDV8o2
X-Proofpoint-GUID: mTUg0IfIfwQckJYzAU_SoBLKbbgDV8o2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two users of mbind_range() are expecting that mbind_range() will
update the pointer to the previous VMA, or return an error.  However,
set_mempolicy_home_node() does not call mbind_range() if there is no VMA
policy.  The fix is to update the pointer to the previous VMA prior to
continuing iterating the VMAs when there is no policy.

Users may experience a WARN_ON() during VMA policy updates when updating
a range of VMAs on the home node.

Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>
Closes: https://lore.kernel.org/linux-mm/CALcu4rbT+fMVNaO_F2izaCT+e7jzcAciFkOvk21HGJsmLcUuwQ@mail.gmail.com/
Link: https://lore.kernel.org/linux-mm/CALcu4rbT+fMVNaO_F2izaCT+e7jzcAciFkOvk21HGJsmLcUuwQ@mail.gmail.com/
Fixes: f4e9e0e69468 ("mm/mempolicy: fix use-after-free of VMA iterator")
Cc: stable@vger.kernel.org
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mempolicy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


For completeness, here is the syzbot reproducer so that it is available
from the mailing list:

#define _GNU_SOURCE 

#include <endian.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef __NR_set_mempolicy_home_node
#define __NR_set_mempolicy_home_node 450
#endif

int main(void)
{
                syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul, /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
        syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul, /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
        syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul, /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);

*(uint64_t*)0x20000000 = 0xffffffffffffff81;
        syscall(__NR_mbind, /*addr=*/0x20ffa000ul, /*len=*/0x4000ul, /*mode=*/2ul, /*nodemask=*/0x20000000ul, /*maxnode=*/7ul, /*flags=*/0ul);
        syscall(__NR_mbind, /*addr=*/0x20ff9000ul, /*len=*/0x3000ul, /*mode=*/0ul, /*nodemask=*/0ul, /*maxnode=*/0ul, /*flags=*/0ul);
        syscall(__NR_set_mempolicy_home_node, /*addr=*/0x20ffa000ul, /*len=*/0x4000ul, /*home_node=*/0ul, /*flags=*/0ul);
        return 0;
}

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 42b5567e3773..717d93c175f2 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1544,8 +1544,10 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
 		 * the home node for vmas we already updated before.
 		 */
 		old = vma_policy(vma);
-		if (!old)
+		if (!old) {
+			prev = vma;
 			continue;
+		}
 		if (old->mode != MPOL_BIND && old->mode != MPOL_PREFERRED_MANY) {
 			err = -EOPNOTSUPP;
 			break;
-- 
2.40.1

