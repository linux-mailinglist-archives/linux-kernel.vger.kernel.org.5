Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F1480F71C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377150AbjLLTrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjLLTrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:47:12 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCDF9A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:47:18 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCDimJO007180;
        Tue, 12 Dec 2023 19:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=6UC8hkFahL7aKwhDPSawosYujclYVfTtKyTxfQMfUIU=;
 b=WOWvBeFyFLLTTr6IuxVx234T+1lwjV4IdSWX6JUkpDGxMji0vt+xOf1KMJyolEYgdl5v
 KkeJtsGb13vPf8KF1OzCXJqklGWpkCWPOX9ZXKFd35xeR/tRtaFAe6Ek0alKVjjyBIwY
 DPuOLtUuwmp5OohmzVt/ETPPL3kTOfJnnBFSndJiWIdHC/HQaXDcYJWLRRRHeImVezjh
 Pv3rPSjZKNo7jn/x6o3cGoGs8nWM6MCOwkXdMo8yxfWROiERDoKvzGrFgn75OKK3Jr9i
 lHMuRd/qLSlAuecQen1BdCsff/ial/y3H3Dt5U88zCv8el7QfKDtssKbkX8QcicSAAcF Sw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwgn3mtr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 19:46:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCIUpJE008298;
        Tue, 12 Dec 2023 19:46:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep732ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 19:46:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLQWr4qGVEjl+3LfQCW/fJjTwcbgXq+N7iTcyx4LDtTTwiW03scq3+xV+TkF20KuE61jbG3FwE7x74b9aIVaWOIyW7zvTtIVvO6v26BuICGKdwNWMz1vYrXaK3HqZlxKUATBwsOzCxJkoiLATF9KTAmtJu/XClwkVxiAVIpOWPpejHM/sPyr1Y2G2U9L6rwaek+lbv6Mdmb3mI/tMP42jOiOs/pat6PI49b3mJAVhmvKlsULoigeR7vnvh1l53a7pksnDCPfCGknAz3MMNO90M7UJbvcnaoynUiykX9+GBhS7uFmuVBRKKm86gQQ2HKUfBj5LK+9qIQDf3gZ4J8MGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UC8hkFahL7aKwhDPSawosYujclYVfTtKyTxfQMfUIU=;
 b=Sk5icE1YfN/UDIk+cLqVhNXN3mS4cW7QuoGZ0bVQH2aB1XYMtIclxOFt/+146eL4vy48HvLtHhiu+fnEQ0gxuyxptYGX6pv/LTFS4h7qzfF3RhpQWPIaQLsYNU+g+tjGSw/e/qIBKJvMcZshB3uyg0S8y02tplgUjfPxI4WYrq4TAWyoqA3AyvokSXxNh0r69yex9GSSTWE/r7D3JqGnhH+6Qkor/HsNZQGkmwf+UtMO+sbhX+lI+luGn2c/jFSR/ABEK8H1Iu7tAP1se49lBVykEizw0ZtYE2vPCgkUx7rZRS8u19uWbt8ZRkmyAacR/iOqfJXypsM87n/88GgJWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UC8hkFahL7aKwhDPSawosYujclYVfTtKyTxfQMfUIU=;
 b=UT38FeiU1RIQV9mG6r1tSzE3n8NnZnvG99pSl9xs3hZv/L60maqnHViUUArBJAA3YUgxQjVgKShfa3KO0ZlOdaLBOfpkEnLo8osaEY8wIjAqm8qNjyUu/wicVfcjyoeegi/n5D3LTOE12Obz76Tz9C/b56A7jMM3W7P5vdxWekM=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DS7PR10MB5309.namprd10.prod.outlook.com (2603:10b6:5:3a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.36; Tue, 12 Dec
 2023 19:46:45 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7361:23aa:7669:bcce]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7361:23aa:7669:bcce%7]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 19:46:45 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        liam.howlett@oracle.com, zhangpeng.00@bytedance.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH] maple_tree: do not preallocate nodes for slot stores
Date:   Tue, 12 Dec 2023 11:46:40 -0800
Message-ID: <20231212194640.217966-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::16) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DS7PR10MB5309:EE_
X-MS-Office365-Filtering-Correlation-Id: 8772db88-e214-4dc9-1260-08dbfb4b1275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wqsc2cduc5RT/+IwFBFvynnrDWWA1/I25zYp4hlqRzwAyyEwdSC/vMdXiIQjuOwyJjBjQP7pU1W6TYgRkXlZVheOhsDUF6TYo/xNQIRrBjx5rkKTfpDLtWnxZceqfDnbvdfvarqAigs8sgYJM//8C7kUj6sLxop6eQ3GlC312D5IPpQnVzsoPcuxkRUUstElejIREfogdp/pFyZAL1bCLHsvd41vKvMbGJ/nO+iHaSqiAI+sfyhdfsY/DGZ+37UncfTC6KN1yWp+oBmS04933AQCfyZHsl1gmqAdtq9O0zPTZC/n1d2QOEn+x3hfeX0mvU+ovcvE5a4tzgKpBwR4E57rLIi+ECxat8YCTSWjGzqvxY37R8dlh/MrkvTakI/54/nCacOgh2cNFDxQ8KNc1CFOxQI2hQsnIJaQ3+waShymqJHcw576A22JuJUnGuW2dAIg0qAT3pdr+YURPwD+veuYcBewTI5e+kPZAw7rO/M/PiMExh7ZmHA2EO0Wjvd/InhCuAW9JI9O34wqPNms8DlZsKIdI/9oY9dGALTB2xb9/EjnGyMKQctgTWfDuRHu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(316002)(66556008)(66946007)(66476007)(6512007)(41300700001)(6666004)(36756003)(107886003)(2616005)(1076003)(38100700002)(86362001)(6506007)(83380400001)(478600001)(6486002)(2906002)(44832011)(5660300002)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ESkBIl8cLygxlCLquC3SzKqc2FRvQXu0wN4l4v2gZc72byYgeapKvQXBHnfg?=
 =?us-ascii?Q?U1Ve0W6HJZAEOHDj1xww6cVfvTlTPQzDyrwwGRalN7WG4C9o0/6gu0B3nh9o?=
 =?us-ascii?Q?w8wXkJmnOPUFa6DB5UtMNc2e7pS1iz7EQi5FpBIDkTAPvrofx4QYOBUuvD5s?=
 =?us-ascii?Q?EMZjzNu6tDhsPeJLJNKsqEDbW09QFz+679TtlxSemXrylhw+WxZl2Notv0fR?=
 =?us-ascii?Q?h21mFixIMkgGOdh7IU5AOjxDPiMLM6NwEN/mWCw0eR4ujxn/I6m3dcIP2AbF?=
 =?us-ascii?Q?CldE16925gPzzuoZIAOOgpS2CtYePdKspyAFGzX9zzMHH3cyNe33iR2jDQxX?=
 =?us-ascii?Q?f5ai/2HfDgLS27pPcENasfUq++dv+w6XD4Zp/Gek+Scf2SmvSWhY6dfBlbYn?=
 =?us-ascii?Q?9RQK2JiNnys2HjuO+cLYqqhLKkTf2NeCUYUbAFOGB2h8qVNnZpRz3kfhymVf?=
 =?us-ascii?Q?iRraW3gN76gKN8DJ1FJ1Rz2ntOaVdeReDe2OkRQkQzrEq54UTVbDlPF3hF4z?=
 =?us-ascii?Q?ewcBaw08YTnlze7tYzjNB8NOndxCAZjdhB0Mz5ibrpBE9tzLOvcpU5TAg8XY?=
 =?us-ascii?Q?Xtq2VKi6SX2HeNMmdQpKR03d4LWq+qrDTs+OFCTQ7mQC9fG6lcU2EqqSbD99?=
 =?us-ascii?Q?DSkGQrqSjjaFd/2k4QBJ0izFKOtmEZILwL7HxsPNkyDd3nEdtOjphSbiXKVd?=
 =?us-ascii?Q?svAA+Xbx1T9JaWknbL0NFolBsZgFJr2FT9ZWMRvOch7gE1gqRG/6MDqpEtJu?=
 =?us-ascii?Q?MmIFj55daCQHw2DwfK3s2KYmBAfl0JCt4gjxRh0vtGp5K1NpEnBp2sdWhE/O?=
 =?us-ascii?Q?zZc+d17l7pnAvw6iIQgQ34EhgGZ7DH6Xh6uE6cvaRSuBcLltn9P6X9AaM6Qb?=
 =?us-ascii?Q?2zB3NSAup4JAepHLOmbk7pG4BauqXef6eQ0rq9LG5yRP6uv36sgEKTl2tvQv?=
 =?us-ascii?Q?YnVved7BIVrc3+9mjHjC1+FQ1MsK57yHadWwB5s32BnpcpJOGkOuiNaGyUf/?=
 =?us-ascii?Q?E1rFCslRKXkFTLDpiIq+94V3bWvLEKTlPbH+29lWFqg3ADF8XZFv88bEHALk?=
 =?us-ascii?Q?kqnbKalauT6K1NGPKcnlFCabCKFuFOIsVb3Di4S4nH1jBuT9nxLOtFOQPQvo?=
 =?us-ascii?Q?h50f/IaH7Yu5QOpVm4qaPOukR7Vv7nYOgIRgkjygFZgKPmnwrh2apojmEqBd?=
 =?us-ascii?Q?ivf/Pff+E6QzCWRRMEOSaLFsR2GW+p94ob8+HkEyr4+wnaMqozh/F5ua3xq4?=
 =?us-ascii?Q?g4ewABobJWsEiI37XFnHyKMVHjyc485eeIotaf3v+sjbE5YfMOTTkgBgd2Z/?=
 =?us-ascii?Q?YXNiJyLZTfkaeVTleUi67FEL003HQojrwIny2OHG3+VAOZjrxKG3mbInXdoL?=
 =?us-ascii?Q?3ptPYriznA+Ln7NJSLaLBdJA5VBfKBtu3xrwPtm78RhAw+Kkb8P3Es3yj2Xd?=
 =?us-ascii?Q?x2Zy3cVjh2X3xPfSZ6Hjay3HSr7AU7qDKz1jYnL/p7JfzyEfKnOaAtYj0jrD?=
 =?us-ascii?Q?UgGvtHqL9kJhkT9z4B0C9XOmk9U2bOmwivNgHICvn5eEpq40PliE5nWjJzNH?=
 =?us-ascii?Q?fydm6zzWeOb46FT4dCvEu4Yp7aIjLQXOHGE+WrKPngTLHQPWAB/5i11VriHk?=
 =?us-ascii?Q?P9N4UuxNAb2QVeo3Yr2x/c4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?5rJcYFIa+4WB1FTSkL2lzb07pJJlx6gdnhxNMneehU9nCNIaeoxrzWr3KJL5?=
 =?us-ascii?Q?E1aMyjIauC+0jYwTivHio4h7MjGKVcPLHdFAyMv05NY9KTQi7oWQcDmuW4wt?=
 =?us-ascii?Q?+MSVn1vnncHNiApkDaQKCtK6OIdf4XenMwXYQHxWfwJimAI+Bj08WsXQC5Zt?=
 =?us-ascii?Q?2Qo8ivSJ57xceTJdX2efEYsyOqemT1JboLy5fNlMZOCP+xL9RUg3dviNDtw/?=
 =?us-ascii?Q?4gQRRCSLhsOEjNZVX8yIruAvyYvJ7QwglAUi6mgbxgIenWRnxCcf5dGXYu9l?=
 =?us-ascii?Q?z3278kEfXffNtAjiUuzwkHCdVQVAAcojmU8HyX9GN+uYoPiZcxgcVdwin6y7?=
 =?us-ascii?Q?I9/XtQdOwE16RbbJtRPOpxzoPatY67xag7OsOw2aASR7qkGCKFd2e6iD1V+U?=
 =?us-ascii?Q?3Nhg9yQZM+ZXumTy964UiKIZJ+ZlZ0x4lQSyglUu0gtQt4ZTx0rd7WjyUbOW?=
 =?us-ascii?Q?Ww0XtH9UQ0kgKYb24P3WAXpvUtzbxx8q3sqDkvDC1RtkHfkcxak4g/cgLiiv?=
 =?us-ascii?Q?9c5Knjeh+CiYOexzX6ian7e1oGSHRG3yqGHeI57AU53Qqe4ihvNlmUq6fHQ5?=
 =?us-ascii?Q?IVos4czponF9E7gH0MQRLgWO1MjTE7wVBHWN2q1eqt3aNVIlCBLQ3aqno1M7?=
 =?us-ascii?Q?ba0OfiafIc7Kx9pKs0zO9dYzImPqSBuuNDgzOhO7xyrB83i/Velq4npYwcEG?=
 =?us-ascii?Q?gGooHGb7hCdy7b/5AqxeAVUtf9Gl8YOujWVm6l99T14EDsJGbGtRhMAtKOSO?=
 =?us-ascii?Q?XpacJNBLwEvibeLR2UgZXXwpXdsT9hAKAuOW757C+mp4TNqWn4keKL8S9yuH?=
 =?us-ascii?Q?4B7P4RYVH9MP+oQ37bb7r+NIeKswXWR1snWRsJ4SmTgpQwbtn4ab1M5zer4C?=
 =?us-ascii?Q?h4p+2S8pJYZL6+pNt7QCSqL5RmMtY+wQDT9OO/Hsf5pZmDOIBha3iuAD9Cqt?=
 =?us-ascii?Q?5c5mfJ6XtgiQsOD0eH8CGGgIhE19CEuhnTw3PsbzZGg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8772db88-e214-4dc9-1260-08dbfb4b1275
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 19:46:45.5313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhorIutPTZxous8q/jxxKrVAvLx2mq44fnA8OrFwj2WbanrvXkROkpoSt9eu+IGG3OKoJzEXkWHQtlWfKc9rAcnM+4kuSOys/y2Exz+byXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5309
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_12,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312120151
X-Proofpoint-ORIG-GUID: B8C3UP6f2e5iCrE8-g9P5UWkhwi00Z7q
X-Proofpoint-GUID: B8C3UP6f2e5iCrE8-g9P5UWkhwi00Z7q
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mas_preallocate() defaults to requesting 1 node for preallocation and then
,depending on the type of store, will update the request variable. There
isn't a check for a slot store type, so slot stores are preallocating the
default 1 node. Slot stores do not require any additional nodes, so add a
check for the slot store case that will bypass node_count_gfp(). Update
the tests to reflect that slot stores do not require allocations.

User visible effects of this bug include increased memory usage from the
unneeded node that was allocated.

Fixes: 0b8bb544b1a7 ("maple_tree: update mas_preallocate() testing")
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
This patch passes the maple tree test suite. A seperate patch will be sent
for a 6.6 stable backport as the node_end field was moved from the
ma_wr_state to the ma_state in a recent patch which is not in 6.6.


 lib/maple_tree.c                 | 6 ++++++
 tools/testing/radix-tree/maple.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index e6954fa75eb5..e4a39beb1018 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5475,6 +5475,12 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 
 	mas_wr_end_piv(&wr_mas);
 	node_size = mas_wr_new_end(&wr_mas);
+
+	/* Slot store, does not require additional nodes */
+	if ((node_size == mas->end) && ((!mt_in_rcu(mas->tree))
+		|| (wr_mas.offset_end - mas->offset == 1)))
+		return 0;
+
 	if (node_size >= mt_slots[wr_mas.type]) {
 		/* Split, worst case for now. */
 		request = 1 + mas_mt_height(mas) * 2;
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 687886cebd9d..f1caf4bcf937 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -35545,7 +35545,7 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated != 1);
+	MT_BUG_ON(mt, allocated != 0);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 
-- 
2.42.0

