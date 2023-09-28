Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E461E7B238D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjI1RRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjI1RRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:17:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBBFC0;
        Thu, 28 Sep 2023 10:17:16 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SGihMB007048;
        Thu, 28 Sep 2023 17:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=KdpvLeiQzpN6qyRq5Qgq0mEAcAwcBRptjh4Tlk+3k54=;
 b=HfWjbu3XbnMoUsEGdV4ph+FN3RAGIHjZhHk/kA8jl3pyTaHD6dc8XBKL6dBhFZjRO2sX
 cRZ9fn/uD9QWqA8nhPz9hXvEFJ6QFAgI/YRj7Qa3V4JX1YVzySGqDt2q2BPjfNk23Fx+
 ZuILOe+gtFhYMyCbQUfuw5OdDIyDa63PexFkb6OHzAQtLDpOMuLMQfPo9MDCk3QkOaw6
 ZyV+035N3nJE3Ygat/eF+qx6YHASPbD4l17yPqrbwlUUOmuDSYTquDpF8Kj5jESRq8F8
 kXzXXQzaz1UXc219B4it/YaZXpx36TmwL8WReppM0rC6Qdz5/Hj1KQacQHjy62jEDhYw +g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pxc56d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 17:16:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38SH2Nad008178;
        Thu, 28 Sep 2023 17:16:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfa3t23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 17:16:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrE96nmG6hPwtisVSOa0GXu2I4nRWCplIEvUSyxhNmIJMzj++ifeS0tho7d91ObaLuVlMckvneW1/KSOYAc+XLG6isJHgQu3tGuxCqA95C7F4kumHO3V6HhmER4RLYh3umK7DThAxPgykLKI6ILNxK+oGoktlr9gWJ3EuOVl+vY2hAWmu6LAezRmmdoNMpCvBMybHLjxMWDQ0spcheFNJPpglu8B5/za0JUlf6ksGHDfaxDl8dyUTzWuuUTA5/UBVQ/pln2qQmbyDBqF/IjMb8CkMCLq52kog+up/Qnfn0+Wki6n2xOd1B5RzuW81EWYfqc5+iuBMQGgLF/Bm2CGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdpvLeiQzpN6qyRq5Qgq0mEAcAwcBRptjh4Tlk+3k54=;
 b=MYAHljti3RzC8M5Jf188aBM5Ba/7zx7TwW+kDTRHua01KBOHbgDzForQ4uWHjtkLYwYjQTzdqJF5lew4/wvCuVx5WhEe1WcXt7AUcNXAEX55A6EDxKvo1cZsT6skGPKFNdUGPvBX1dI/Q8YDrNeWmmIAAPkvS5bNSPpk42fQavUlPKfaIueLTPXhjzfxJTyUntPmXdcrZ2Ia21JPVTYYwbTBdpQ9VQXP3m3VaxGj6RoUntxSzYlWichhGINGKMiSDNmmrDw6eEby30r6DChG6JvTKN7RGe+W0YXfNSMp49kdnVtS/pcP431uYP/g/7uH+fmaBHR6wqblJNVCHe6dkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdpvLeiQzpN6qyRq5Qgq0mEAcAwcBRptjh4Tlk+3k54=;
 b=q85CU17NqXaVGmzEiMkqYj+CARUY1xRusRLtItPdT0HprenR3X0bFp4eoWy5U78mqER0gudcMSY/r4SA9UM3GyC4OwqMxuG+7Wzxrw5XgbgGdgGxQB97FYHL5YxHw7sERI40vseTgtlTvPBD7yzG6PcOIKjRTytHfOLaVJcWZpA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5273.namprd10.prod.outlook.com (2603:10b6:610:db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 17:16:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 17:16:45 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 2/3] mmap: Fix error paths with dup_anon_vma()
Date:   Thu, 28 Sep 2023 13:16:33 -0400
Message-Id: <20230928171634.2245042-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928171634.2245042-1-Liam.Howlett@oracle.com>
References: <20230928171634.2245042-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0229.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: 6181460b-f4aa-4af9-cca8-08dbc046b13d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wKgrae15V+HXnMhuP9IjIfLC/dPDwpk3yDU2Q8Ag+py38K7jKKm7Mw2uogNuZtdTxbqtDvPIcdQiv4oV2tN3tXjtQ5WgifNHMF+QqqVOPc/wHYjj3WdyArxnMdfaHQjN+gfcKK4eGm+JWWjVb5GaVJEHltop2Mg5KtW/ei2epabE+WPyJZ3UimpnGboH1Vo3Kkny0+7MQvhHb74G+sTsVZjrfLwxedferVbeUUbyEX01yG9HRTGclHnf/HEmEQKT2wuTLJGWhvUPmdYdNUgCov8Kef1tQciH2Gehjb42Nd1IxBlMEZTteFPTZ6nyK7Flj9OFGikkFYmwV2Lxa7eCJLMdVhutCNzikba/FqPJyFYLydxZXBUuW3SCCf10q+Z1mqxSjPhEgxi3SnsNHxmGUwaCACm0zk1GKQAtEOW0OqcX4aJjVdJKZrU/ijHj7UPm9RsZi+m+8iVqHnXzB4zGxwP9AevN0GIHUFKKklWxO+hgxLH05fVWMJXxvjcv6PdlwX1ussYJMISrHaj/alYwSuxyO9nXd7WwnXAYJSyARQAKTtqMPqrK2LXvAnVonpud
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(4326008)(5660300002)(107886003)(66556008)(26005)(83380400001)(1076003)(66476007)(8936002)(54906003)(316002)(478600001)(66946007)(2906002)(2616005)(6916009)(41300700001)(6486002)(6666004)(8676002)(6512007)(7416002)(6506007)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tlf6bDLdMfdk08czVEB8k3FwJbj4/P11Hgi+6rF8FI0Qe+orfZkUPeIcmnjW?=
 =?us-ascii?Q?Duu1pHZvvt3ZgKXl05QmUs1n7Ts20chPMrm9GM/GVWScQIJLtNRO0uYP6MnR?=
 =?us-ascii?Q?vLRfjFbXwaNwZh9R05bvWL1JOG7FnpjQrVVf397wUF9NqdChZ4aMTaIncV85?=
 =?us-ascii?Q?G9F5rWdepWfLDy7iC/FcZ+oKJtgsn4ll2WgioDCDsXmaF26Oe6MOmre1L0Fk?=
 =?us-ascii?Q?aJlGNPj7JCF1tTB0Cuxv8szmJGyvDtXMN1a2axG0TD3aQpylVgI/ydiuJ8mm?=
 =?us-ascii?Q?Za8VC12VqIT0jTygXPSbcpc/8NyCb542Gal+5qVNuhNZpmxBF8rgqP9L4Mnw?=
 =?us-ascii?Q?klxmEi8ADH8hrWWCR6z9QjfgRzVYNnnJRgCxoHwvItNq0kU6DICFa4DwVIat?=
 =?us-ascii?Q?/VPVzxYJjpzUbLgWBnQ4Zc12V0RDWooISf00m4q6Fgt6XFRR3ku7QLly8A6U?=
 =?us-ascii?Q?PHQd2ecQWuqs5f7gPa6jWiwNoxtdh69sqqcHQq4qkkNPzFhHo8ZQcuR9Du2I?=
 =?us-ascii?Q?EGrrdZwKvDZByHj1hYO/yQuDjpv4Md1r7SPWrBhg1pd+RIfNZ3ClCbfthDEm?=
 =?us-ascii?Q?TQQQmMdzkpxioiAxtVxebwI+fC8y2ap2dO5JJ6QjKdVVMbfENiYuq/UVjAG0?=
 =?us-ascii?Q?T1rQ4iS8HgkA7mtcfz1C8iK/mYh6R0Yw83BJADWhsuuRnBToDxHJN14NhlXZ?=
 =?us-ascii?Q?XyLMektM9mYPSTQFvsqXcijJGge65T2Vootxj8TGZrTmhUUV6ioiq25djnxL?=
 =?us-ascii?Q?lMbTdmZ6ql2nQzMqO1rniiTYiwPfw1jSf9dhAd4HJAb9F089qcfWMKiMjyav?=
 =?us-ascii?Q?Nu4uxlRJNE0a9K/l0iuMzmXHNuvAR8P4v7fx4G/7InflDDfa4wlFVQFE6+rJ?=
 =?us-ascii?Q?JBz3JH36ILL769tDOb4/SOYUS6rgEh3OnmlfRqG5vumW5wi67yj29whXQrao?=
 =?us-ascii?Q?azpto6yQF7G0Pu0J5T9CvcArJzNCzMaJsKadT3s0KdkLPpkHAbNaamIEFqwh?=
 =?us-ascii?Q?8gJEFV+G3ZipcU6RwbjLmm76St9aA9HdIuDolGgRzFLTbFD/K/xsRbAfGzFn?=
 =?us-ascii?Q?P495y5BJUtxR5CY9w6zyB2v5jwd0T/6+p7KXR/QmhDlegNDgq/quxuZ2GG83?=
 =?us-ascii?Q?e5ZSm5cfAJEKHgmK1Uw8fFRNEa/u8HPz1Xv1XkryLUtNtTk0cMSrW/NRcwu/?=
 =?us-ascii?Q?NAgBRqAsP5nnvUvjINYl8qaxWOtjuiFl/MZuGDSorG/zFAEdtULNuBBoxjMc?=
 =?us-ascii?Q?AXUqcVA73wB7rda9zLUwz28vrRP4la09Qx75hy+tJWNpL7Jbw0s1IasjWMCT?=
 =?us-ascii?Q?7R5qO0a1I+QICx5cysZ3OLlUNE248Y4+tHEQGNHkWKYPBJuCfUuCVRNmIm08?=
 =?us-ascii?Q?yo/qZ7CsNYU7ZDz/XyS3YhaQMiQ4QQrFaFMTQp2qS11gjLXR/0yhCycQxbA6?=
 =?us-ascii?Q?5uC9WrqpSUoCaN5YkKFp0mLEekmEcG3ZeGXHj65Q8Wjq0j/vJqWOFAoKh/f5?=
 =?us-ascii?Q?+bcDs/oP8XsdiTxmrSrjOnzn4rRUmiT6NX6UsQPYzO35GO2fo46xjC7sZ8Xi?=
 =?us-ascii?Q?0dkv1vyIQ0gZWN6/If2wz8g+h/2FdJzyCBOKOog3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?78S4LYmEP+vvdwbseOVQFYOkq2lFN63TBU54QMOnaxAtsC9EisQv2faQOODO?=
 =?us-ascii?Q?K6K1UKj21YVcQLC36L/lv/dIThcBtdTNyBVxfybYtqM3Yc2aU34Ru1IWzEdh?=
 =?us-ascii?Q?OpdehpnsyvyLkByB7vdx+/ZuBMyKLkzfdcpaeVvT8d7TjOxcYWYpAQZuLUaz?=
 =?us-ascii?Q?i+tATWku2+GQcjZs2WumHNn40U6lELkBRN9X+VBA6DSU+nQ6L9nd3+72VFRr?=
 =?us-ascii?Q?sFNV3GjIX8uhHzvDb1NNTTRouKfUH6rvG/3gCsuJv9HHQWrhV7HDZ0Nw4KdM?=
 =?us-ascii?Q?RCau6V6NCiv6wPL081G42h1cn92hVGnao2Jli4JL1QIdw8a8oJRced85HBAy?=
 =?us-ascii?Q?qkncsWCj98VjuZnouIK17fz4FHF2EDJnPGmnK4i2SG9pes7gbLXgPCtPVDPh?=
 =?us-ascii?Q?RuaJmWHV1IzKta0TE35MaJ3FQDR7qngkfRV2qEhq6Dn3N5eQe6A+uAC5cPif?=
 =?us-ascii?Q?18fahVrUiq0M/oV5cKJBuTmxnAgg4d7uO63WlDVL7rf0ANyzHD3nWms1zS/a?=
 =?us-ascii?Q?UQKBsf8HRG+PoU9rcEz304/8mSFU1pTYPLiWnvS6xVHb4ulLIODIe6xIzghp?=
 =?us-ascii?Q?IBtqWyIwD4mST69SqOpdXQN2oN7Kt+y1l/E0K+xx7Z9NVYoFRBRjUKibbUba?=
 =?us-ascii?Q?Gu6db+DILYWApyM1MlN+Jk6fqTe+Bk/e43l/I9NahMoRj75vVAQMz/nGQgzG?=
 =?us-ascii?Q?jTtk9rvWItwAg9WtrWuLBDNSfaH8nlpKYPZHKxmxctg2e0+SuvC5lME0pLW2?=
 =?us-ascii?Q?ruRaweTQ7bjI3OQRyE7XZEfTPZ/k4Saq/51J0Bs8ZLd4XgeWf/79nB2znyjP?=
 =?us-ascii?Q?rrzOErTgbyil4aSYfUEPRpEEjFUxj/m5DsQyI5hKE6qedW3Ku53zMch++mCI?=
 =?us-ascii?Q?/oliESToAj5d6KZS4c0CsSH4R034pl9U4vEy+RSZmX0b9XeVBtLTwnuOyTB0?=
 =?us-ascii?Q?9c2UDVQJFQhJ60Z8TjFjjHLKBngKNFUq0gbAvI8BtBaDYbfT+ot1T0Dw36Sb?=
 =?us-ascii?Q?dszf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6181460b-f4aa-4af9-cca8-08dbc046b13d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 17:16:45.8786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHfX4cqSql+kqm0njoeFp/OVUnHCm8mXJ6Q+PI7HOufyEpAjH1QMVLNElI/cDvdKOuNTWG/4Sj8xtqqhlEUAAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_16,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280150
X-Proofpoint-GUID: q26wwM2NSbmFX2pRjBnRRVXfSnmfaqSx
X-Proofpoint-ORIG-GUID: q26wwM2NSbmFX2pRjBnRRVXfSnmfaqSx
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
 mm/mmap.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index a4eb5a5626bb..2f0ee489db8a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -587,7 +587,7 @@ static inline void vma_complete(struct vma_prepare *vp,
  * Returns: 0 on success.
  */
 static inline int dup_anon_vma(struct vm_area_struct *dst,
-			       struct vm_area_struct *src)
+		struct vm_area_struct *src, struct vm_area_struct **dup)
 {
 	/*
 	 * Easily overlooked: when mprotect shifts the boundary, make sure the
@@ -597,6 +597,7 @@ static inline int dup_anon_vma(struct vm_area_struct *dst,
 	if (src->anon_vma && !dst->anon_vma) {
 		vma_assert_write_locked(dst);
 		dst->anon_vma = src->anon_vma;
+		*dup = dst;
 		return anon_vma_clone(dst, src);
 	}
 
@@ -624,6 +625,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       unsigned long start, unsigned long end, pgoff_t pgoff,
 	       struct vm_area_struct *next)
 {
+	struct vm_area_struct *anon_dup = NULL;
 	bool remove_next = false;
 	struct vma_prepare vp;
 
@@ -633,7 +635,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 		remove_next = true;
 		vma_start_write(next);
-		ret = dup_anon_vma(vma, next);
+		ret = dup_anon_vma(vma, next, &anon_dup);
 		if (ret)
 			return ret;
 	}
@@ -661,6 +663,8 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return 0;
 
 nomem:
+	if (anon_dup)
+		unlink_anon_vmas(anon_dup);
 	return -ENOMEM;
 }
 
@@ -860,6 +864,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 {
 	struct vm_area_struct *curr, *next, *res;
 	struct vm_area_struct *vma, *adjust, *remove, *remove2;
+	struct vm_area_struct *anon_dup = NULL;
 	struct vma_prepare vp;
 	pgoff_t vma_pgoff;
 	int err = 0;
@@ -927,18 +932,18 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
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
@@ -954,7 +959,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma_end = addr;
 			adjust = next;
 			adj_start = -(prev->vm_end - addr);
-			err = dup_anon_vma(next, prev);
+			err = dup_anon_vma(next, prev, &anon_dup);
 		} else {
 			/*
 			 * Note that cases 3 and 8 are the ONLY ones where prev
@@ -968,7 +973,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 				vma_pgoff = curr->vm_pgoff;
 				vma_start_write(curr);
 				remove = curr;
-				err = dup_anon_vma(next, curr);
+				err = dup_anon_vma(next, curr, &anon_dup);
 			}
 		}
 	}
@@ -1018,6 +1023,9 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	return res;
 
 prealloc_fail:
+	if (anon_dup)
+		unlink_anon_vmas(anon_dup);
+
 anon_vma_fail:
 	if (merge_prev)
 		vma_next(vmi);
-- 
2.40.1

