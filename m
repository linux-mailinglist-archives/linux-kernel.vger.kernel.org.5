Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7B777BB42
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjHNOL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjHNOLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:11:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D156172D;
        Mon, 14 Aug 2023 07:11:26 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECiUar017544;
        Mon, 14 Aug 2023 14:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=SXL00vZJ65cJMEZiZDLFVAjY4Bbu6xFQVUenk9XEqWc=;
 b=cEFRIflb7sDv1Mr8Fr56ZxZelnNemciBxxogTYhJYN68+LIAH7YfYR8EhYaqzknSz53z
 HexC8oDm6Q12Dr+WzGhVJ1PK3e2317AhSLW8dhPsH8c269XkseVEdqlBLW0ZT65YEr0b
 wjElGJ0IbiFycYLkDyMFoXAn4U+zDNw2U9a9BQtScGsacuULYoAU/1E7Sqyf3Wz3gP48
 fDPjSJSgYe3nZ+nJuxfnKwdK3/AnWhUKoi5QOJ2tCGD1y0VK7262Al27VKqS3tvYraat
 jjM4qHEgWQsrzlhCH2bk4QiFJyd759ahcaZ7FVyGqhEqj/9daO45pLlTNb79Xjk9WoRq vw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se61c2kfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 14:11:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EDYajB007170;
        Mon, 14 Aug 2023 14:11:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2bxfj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 14:11:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTqbT+9s74NQ6K7CVYiQMaZYJoC+RxkRZ5PIMTKkYe07KuO8pnQgeDm88IjpUygN+xbfGDbpRMTsfRpE/EkVgW/muicCkjgBBeeqAmxLD01YlXhIYd2lbk5mVnbRl1S6l+Jk3/CxcQkpiiExTkO6255Z16OlcWOU1BGoPpnP5Cj/2cBiDkkmuWFPoE+/+9JqpyJqozLFtm7fd3jmp2ppytrSueLFI5o2mjw+un01wzlL5IEjIvSyA8UTia0CuFb3Xy/8CkVcXvx7M9CDbTHESSIxY1QlnYkuRm5crfQ1HALfBbVXbB6nlkMas0DSHSnoOzFwk37LxR+0M8t2AClfwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXL00vZJ65cJMEZiZDLFVAjY4Bbu6xFQVUenk9XEqWc=;
 b=GVeagHpPWgX/RcBx2ib75726+hSbNKi8gwHSguiY89ZLC4gPDfbbUldMzJz+Hh0meyLx3zXzYntYJ75s+rEWuTppOXUjRV2CNG+lIGFybA4afg+1dgpz4iuTStU8a31zl7w8Q+NzdsNwfWGaaOX59T6uSr3w2oBvksEZp5FK7lEV2ptohFysecinefPwTDV1vRZjFR3n+OA2oHxnvXrsA62WVDQgj3ZhOvoKD+71cwARKs88IU/lH+2VI4uzgRR30v0z3hhIFbVb22bWGddEOfE86DX6tjK87phXx+jhlC66bU3frdUK8hQnjzbT2u6u6XT3i0/VbVXET0FxRJak/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXL00vZJ65cJMEZiZDLFVAjY4Bbu6xFQVUenk9XEqWc=;
 b=GLB15qc2z5uewkfk/g/4CtZVifsPmyGSSNkxSF26o38prZ3fw+qAl1Mzd85ay2au6FH4wUOp1/IAbBprwagWtwO4i0NP0cudgOjDx9GobGJJnvsBnCwHm+9vTyW85NFHDDPFl80fSL4QXbbDw1ufnt0wu3R7ANa7QiKAQgPU9YE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 14:11:05 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 14:11:05 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        chenxiang66@hisilicon.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlemoal@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 06/10] scsi: libsas: Delete sas_ssp_task.enable_first_burst
Date:   Mon, 14 Aug 2023 14:10:18 +0000
Message-Id: <20230814141022.36875-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230814141022.36875-1-john.g.garry@oracle.com>
References: <20230814141022.36875-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR11CA0062.namprd11.prod.outlook.com
 (2603:10b6:5:14c::39) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 0138b009-0170-4f14-d314-08db9cd04c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7PdWpC0o41cCZ0uU0tGWv8TZuRZFcfrrWtljjY0sfp8z7Qb2sWEw1Pses5MCsfUqJquHgwpDck6sCR+lA5JO++JG6Fml23pQFnQvr380Wu+9T1xgF/QPXS3+z3lQ4xd6ZrgT46Gvi8LlDrNMr1Qnkk0qzkZ9MofVmC2KuYZolLkEU1XPVI7ZX9ie/BeXlktedBZ5QA9zi8YooWU6B+nuRpibAM17ntHRG7Z7HrRxTqP+0I5Dizz5FjroJnSsZO9iIbKONFvbtBjYQqK0shc55PrPGkEvc5jFq6qw1QmE1u/3CsK5my9XIXn+C55PM1QchpoDaKQV7YIbt95zWcesmMsBwz115Mzl6baLxl8Xhleje+kqHGZOIPx1mVK3RPcHEtuq8H8EbG0DDZEz/IjyYgIvNmyNWeOHizflz92GNXOiQ4VBemztJzDN4LTHBEG5qDnKfC989mwFwUz20IuXrd4lpo/jGlqaElNy10sRhBhHS6jpN3EzNoisLh5TcTt28les1B4jnTGGSlkAKRhkHb6eba8Yh+lzzSq/plOhNHGCt28y4F9hki8XeXzxdt8iUCDzncR0w8v0XU8w7l7tDMKD4hhXnMYRpFSR0HpKxxfPDe98usk0JYex+eEm/OJp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199021)(1800799006)(186006)(6666004)(6486002)(6506007)(478600001)(103116003)(36756003)(86362001)(83380400001)(6512007)(26005)(107886003)(1076003)(66946007)(2616005)(2906002)(38100700002)(316002)(4326008)(66556008)(66476007)(8676002)(5660300002)(8936002)(41300700001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lw+VlDxjuzTg8aClhR1T6N9apzCkEEMHoutnOZAsHKKQG167kLZ89V00ILbX?=
 =?us-ascii?Q?3q8URmyA/wOU0CAzrzdwvkg0CtreHTBgTgu29cvy9kR7ERj+qjH3W4i31hjH?=
 =?us-ascii?Q?EVs3F1eJE8nTRTQh7HOZa90GKDi5meys4tirMqRkbTB+647IPued3QY2rz7R?=
 =?us-ascii?Q?hFky6ePXDPe3dOhHdV5/HK8vELgimkJVo0hRZ9eT4Xdh9EbqO4XwVb/HdjwR?=
 =?us-ascii?Q?x8Mg5chSfuF4tEDkdd50h645aBZCnpPk99qmdAdfnEpwANwqpe26FZZZmCnE?=
 =?us-ascii?Q?VkdCmGGRjXSpadbAaNJMCdUPs6IHX7yHQip44FYOQBLxX4wOBpEOHPZaRyNe?=
 =?us-ascii?Q?BAFPt1lPUtpqmX2aMssbg1x3abImO7PfuVmfEhwqBBrLU8PKV/uRxO3pCG7I?=
 =?us-ascii?Q?FYNGsEMXz0mUiHdYlr1bd8KUj82TmEXbms+XDUHPjXwE6KZmFhSNRTuKCHPb?=
 =?us-ascii?Q?Np2gvJ85vLn5rY5jln6pott8rmJFWvwA3w1OWPXqI/KdIU0gLPoHTNwicmua?=
 =?us-ascii?Q?T+IyvR3fMockpI9JG0/Ixevrsb5vzjL4XzoUng2HQrZ+ZN94ZGyK+J4oaA0R?=
 =?us-ascii?Q?ZGKTmQWmzjhjtzLpcrSrn3ftxVRuthmEBar8Kl+AaL1L3zLCGSjxDWvy++EJ?=
 =?us-ascii?Q?v4INuRqtvGr0YQmYpsX0eKiYI1o0kVcCFOK4nT5Vn+YNBvJNl5/8nmngZqRd?=
 =?us-ascii?Q?12yLfruPTO9nA5l00TLtJrXoycIIcUUL+ZchApz9r58JsOy4AP3qZwJbB/Rs?=
 =?us-ascii?Q?5Yv3AmeEIQwk9pBF3he2lmOM16+Q19Feid2GuwOzX1rjhK65D8YjyJ4ZTirB?=
 =?us-ascii?Q?3KzQeNHEBEy/cFLLJtELup4p9q6V9ZZlEhIW3Z+oGdvheuuJBEJurpiWiwoT?=
 =?us-ascii?Q?c06b0OCf2HIEYnE1vzqXAcUSx+CQkBrDLhvu+HtEODHZZr83Li+t9kCjy7n5?=
 =?us-ascii?Q?N/H2ChbsoXCPIXHhDl5osdjOueIXPUMJ5MAdvVo6Kpn90l05zd+60JatfsUM?=
 =?us-ascii?Q?o+KnfGIPqGzxRV1TXmaASPRtbhTcYGW3qUbyBSWIGNU5Y7H+AcnS0FGMZXHZ?=
 =?us-ascii?Q?H7hlyGqaw4u57O1Xc8oEP8Mp5VWwG8XuosK43wqyFn7G3c7PlU2op2zWmFCq?=
 =?us-ascii?Q?fkUYFHGo/5AhRWjDj59QEIxcnAiX0d2ZZTim0jCFP8JQTM2HMvB4Y9gY9mPq?=
 =?us-ascii?Q?U43WyKXfRgzDzEH26lW49PYVw5OW1a02sGLoOM95qIh+QSzsp2kNWQBZi2pQ?=
 =?us-ascii?Q?FJnaLVzw9OoEogn2udwM5CFAua58oUnoELcUKCB9MsEvMBF4xGCq4QiUvhYL?=
 =?us-ascii?Q?qLIy1iCyMKupzWd+ne6fgU3LKzLFZHcw4pYAGTlA3gpPkGvtyZO2Iiuhmabi?=
 =?us-ascii?Q?lEbdFXZ4eKsmcbbF4xZU10elswEwhomEtLiV73H/oBM+AuTf/BzqwA7ySjLu?=
 =?us-ascii?Q?GGpJDbgahWkIsRLlxzAqOSkGui+47zBUufI8VPWz1KoD5WV7dDB/csmIYCsa?=
 =?us-ascii?Q?YItGmn75JrQ9UHAPg/cKn/+TKfzU/nTOwizKOshX+bFos0NYEGP51cS4YDkW?=
 =?us-ascii?Q?3conP/1torIW7n8/P2QNoY0G/svNoxKODiM73bqXK1L59DpRkIHfqooLdOgk?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?1hv22XQSBYefmwyNDd9PRxYWykk7CdblNiC7cz9kT5vmS6iCDWt04LTCQLff?=
 =?us-ascii?Q?VCsi8tQjJz7eKRorgbUKd4ujYEaXvZUZtXGRyyK2DwMkCQL8okaVzCqmsx6n?=
 =?us-ascii?Q?VsM8zqutD86j6QCkQi1+DH/dYOYM2D7pniF+7FxvMCOfqDjuj/XNSlus4c9N?=
 =?us-ascii?Q?kyFDL7cbAdjYn25YoHfzA5VlESPIYYqx4mJ8V2TXLYKIO8PpoUg52pu18x1b?=
 =?us-ascii?Q?7cIQasizYhpb+YzEX7wJC1ZT3YxEELi7qUvtn7DYvSBx45N2ITSJuok8NCgC?=
 =?us-ascii?Q?BFnzAHkqtZ9OBwvSGn3VVmUPTPyy/itLOApeJN2hCVvd1akVFNFJQ1bavTca?=
 =?us-ascii?Q?0QVPOOXrddMb+667FfWvbTgbc59EXU6FS23oVSzjZ+PGFjXu/+ElZW7d3k9W?=
 =?us-ascii?Q?stsWnx6VmDiITUpuqUYG4GwDsr+fpwj0kFinD2lcZ3iR0CWIWjnXIBKiggaz?=
 =?us-ascii?Q?r5ycjzc7xXsWvcbqCCnjGb0hFpb7G1EkFf7f4NoTsz77dJc6wJI9Rvlo8MO1?=
 =?us-ascii?Q?QaH4r9b2MMqtn3qv8XnnAiiA0BVMvI4YE9IPX1zVoXSj5rJMuZsathBRLfoB?=
 =?us-ascii?Q?MD6LGdksXdzhVVL8exGBh9R1nA+WDLEDppUUfAjSd/Gr1H9Euoa5Q1iuw6g8?=
 =?us-ascii?Q?bWdDWUS8WwvMcx5lTkdGII3PJN2KmLLiY6x0O1lQN85mgnGJFqFKeLPA4bX+?=
 =?us-ascii?Q?+47tAuP0xmWfv/VKDQJyFuetjxqwHvPzvjHhrIgEdHairAlV8M/U7GYUUqce?=
 =?us-ascii?Q?w94AxeQUEkEOiEhpPIg5X0BmBYlcygRXp91nMjWxVsjSR2XNwty7Wz0cSkVm?=
 =?us-ascii?Q?PohmDGq4n1lTndiH8lnVsEjNz6OQYqZpPC4ZALnxM91O2PSQwGfWf/7MlfSz?=
 =?us-ascii?Q?cac1HDAobikK+itGVt/3dbUlY4O9MqyLqXVM7dYEQt9CBpuifU4MzZHCv0xi?=
 =?us-ascii?Q?Rq9uqFm+UVYgmbuTxVKTeA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0138b009-0170-4f14-d314-08db9cd04c7f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:11:05.5151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: neJ6S5nwL9HtpoEiWjODpf70cLXlc+TlS4Zch5SLyTuvLZpTsr9nTNcWY+CoQDWZpVpPCAmOOIXibdZa9CJ6IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140131
X-Proofpoint-GUID: al29xDqfyc7Fr4mWeCaWcJrX6hNdEK-o
X-Proofpoint-ORIG-GUID: al29xDqfyc7Fr4mWeCaWcJrX6hNdEK-o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since libsas was introduced in commit 2908d778ab3e ("[SCSI] aic94xx: new
driver"), sas_ssp_task.enable_first_burst is never set, so delete it and
any references.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/aic94xx/aic94xx_task.c    | 2 --
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 8 ++------
 drivers/scsi/mvsas/mv_sas.c            | 8 ++------
 drivers/scsi/pm8001/pm8001_hwi.c       | 2 --
 drivers/scsi/pm8001/pm80xx_hwi.c       | 2 --
 include/scsi/libsas.h                  | 1 -
 6 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
index 7f0208300110..1ac4d3afc1a1 100644
--- a/drivers/scsi/aic94xx/aic94xx_task.c
+++ b/drivers/scsi/aic94xx/aic94xx_task.c
@@ -485,8 +485,6 @@ static int asd_build_ssp_ascb(struct asd_ascb *ascb, struct sas_task *task,
 	scb->ssp_task.ssp_frame.tptt = cpu_to_be16(0xFFFF);
 
 	memcpy(scb->ssp_task.ssp_cmd.lun, task->ssp_task.LUN, 8);
-	if (task->ssp_task.enable_first_burst)
-		scb->ssp_task.ssp_cmd.efb_prio_attr |= EFB_MASK;
 	scb->ssp_task.ssp_cmd.efb_prio_attr |= (task->ssp_task.task_prio << 3);
 	scb->ssp_task.ssp_cmd.efb_prio_attr |= (task->ssp_task.task_attr & 7);
 	memcpy(scb->ssp_task.ssp_cmd.cdb, task->ssp_task.cmd->cmnd,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 94fbbceddc2e..d4e3c3a058e0 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -960,7 +960,7 @@ static void prep_ssp_v1_hw(struct hisi_hba *hisi_hba,
 	struct scsi_cmnd *scsi_cmnd = ssp_task->cmd;
 	struct sas_tmf_task *tmf = slot->tmf;
 	int has_data = 0, priority = !!tmf;
-	u8 *buf_cmd, fburst = 0;
+	u8 *buf_cmd;
 	u32 dw1, dw2;
 
 	/* create header */
@@ -1018,15 +1018,11 @@ static void prep_ssp_v1_hw(struct hisi_hba *hisi_hba,
 
 	buf_cmd = hisi_sas_cmd_hdr_addr_mem(slot) +
 		sizeof(struct ssp_frame_hdr);
-	if (task->ssp_task.enable_first_burst) {
-		fburst = (1 << 7);
-		dw2 |= 1 << CMD_HDR_FIRST_BURST_OFF;
-	}
 	hdr->dw2 = cpu_to_le32(dw2);
 
 	memcpy(buf_cmd, &task->ssp_task.LUN, 8);
 	if (!tmf) {
-		buf_cmd[9] = fburst | task->ssp_task.task_attr |
+		buf_cmd[9] = task->ssp_task.task_attr |
 				(task->ssp_task.task_prio << 3);
 		memcpy(buf_cmd + 12, task->ssp_task.cmd->cmnd,
 				task->ssp_task.cmd->cmd_len);
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index 9978c424214c..165f46320bd2 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -564,7 +564,7 @@ static int mvs_task_prep_ssp(struct mvs_info *mvi,
 	void *buf_prd;
 	struct ssp_frame_hdr *ssp_hdr;
 	void *buf_tmp;
-	u8 *buf_cmd, *buf_oaf, fburst = 0;
+	u8 *buf_cmd, *buf_oaf;
 	dma_addr_t buf_tmp_dma;
 	u32 flags;
 	u32 resp_len, req_len, i, tag = tei->tag;
@@ -582,10 +582,6 @@ static int mvs_task_prep_ssp(struct mvs_info *mvi,
 				(phy_mask << TXQ_PHY_SHIFT));
 
 	flags = MCH_RETRY;
-	if (task->ssp_task.enable_first_burst) {
-		flags |= MCH_FBURST;
-		fburst = (1 << 7);
-	}
 	if (is_tmf)
 		flags |= (MCH_SSP_FR_TASK << MCH_SSP_FR_TYPE_SHIFT);
 	else
@@ -667,7 +663,7 @@ static int mvs_task_prep_ssp(struct mvs_info *mvi,
 	memcpy(buf_cmd, &task->ssp_task.LUN, 8);
 
 	if (ssp_hdr->frame_type != SSP_TASK) {
-		buf_cmd[9] = fburst | task->ssp_task.task_attr |
+		buf_cmd[9] = task->ssp_task.task_attr |
 				(task->ssp_task.task_prio << 3);
 		memcpy(buf_cmd + 12, task->ssp_task.cmd->cmnd,
 		       task->ssp_task.cmd->cmd_len);
diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index 73cd25f30ca5..18070e0e06d5 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -4053,8 +4053,6 @@ static int pm8001_chip_ssp_io_req(struct pm8001_hba_info *pm8001_ha,
 	ssp_cmd.data_len = cpu_to_le32(task->total_xfer_len);
 	ssp_cmd.device_id = cpu_to_le32(pm8001_dev->device_id);
 	ssp_cmd.tag = cpu_to_le32(tag);
-	if (task->ssp_task.enable_first_burst)
-		ssp_cmd.ssp_iu.efb_prio_attr |= 0x80;
 	ssp_cmd.ssp_iu.efb_prio_attr |= (task->ssp_task.task_prio << 3);
 	ssp_cmd.ssp_iu.efb_prio_attr |= (task->ssp_task.task_attr & 7);
 	memcpy(ssp_cmd.ssp_iu.cdb, task->ssp_task.cmd->cmnd,
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 39a12ee94a72..ad5a73b86415 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -4316,8 +4316,6 @@ static int pm80xx_chip_ssp_io_req(struct pm8001_hba_info *pm8001_ha,
 	ssp_cmd.data_len = cpu_to_le32(task->total_xfer_len);
 	ssp_cmd.device_id = cpu_to_le32(pm8001_dev->device_id);
 	ssp_cmd.tag = cpu_to_le32(tag);
-	if (task->ssp_task.enable_first_burst)
-		ssp_cmd.ssp_iu.efb_prio_attr = 0x80;
 	ssp_cmd.ssp_iu.efb_prio_attr |= (task->ssp_task.task_prio << 3);
 	ssp_cmd.ssp_iu.efb_prio_attr |= (task->ssp_task.task_attr & 7);
 	memcpy(ssp_cmd.ssp_iu.cdb, task->ssp_task.cmd->cmnd,
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index d8222c442640..d77db53cbd8d 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -564,7 +564,6 @@ enum task_attribute {
 
 struct sas_ssp_task {
 	u8     LUN[8];
-	u8     enable_first_burst:1;
 	enum   task_attribute task_attr;
 	u8     task_prio;
 	struct scsi_cmnd *cmd;
-- 
2.35.3

