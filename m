Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE78677FE69
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 21:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354400AbjHQTQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 15:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354410AbjHQTPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 15:15:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97CD30D1;
        Thu, 17 Aug 2023 12:15:29 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HI4Rup011209;
        Thu, 17 Aug 2023 19:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=5RamWKiLdkEaDiqSBw2gtXgT+/BnWPl6WXQ6gnjpZNQ=;
 b=Bt9hF2ygN2EYaMfuptPb8RDabCzrGyM3704HaeKMxQMRzciFEn3LNCTUQmGzyZFOjdQO
 C6nqe6N+WXCcmnXuMx3jLcUUyOc1fEesP7TDS4evILYgJytWPDpN4zlgYlAz9+mp9B1v
 eCnpWjmbDEWlUc13JaSTeK/6TmMKlFx7mh7iX8IwqaYxNluspnKKxVEZ9o9dzRb9RTpU
 Es925KoxIlDKl31ARg13BszxYKQC2Q5od+TM2HLqumfFU5PI83c8FHGcIWNY1C1pyPIP
 4ZZY57S/dMVTCFU+waLNXayM2RJYNnGCX3rAsqqPx20qf4HMKUm9wLr+YqrN/nxesTZ2 Uw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se61ca8cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 19:15:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37HIfIlu040055;
        Thu, 17 Aug 2023 19:15:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0u0fgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 19:15:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPpvh4qRlKXyd3Nw5BQmfy+HHiawm0krlFYS2XMnpMtQ9iVt0uy9xStPG/CaTA0Pq0ZbTw1/DkxZIVOd6Q8kiFY9yDQZo7w/WOm2+XaCP/A3eVY5ZBdWfZX8hklt1dHeVYXFRoR0kOZ7Qt3iGuJYdvAOgEoFKqtbA0nYBXB1jfjyyicLg8T88K96UDpBT7A1pbrT/vHg0PSHhjRsbtzx4Qqc2ZYNhIOg5sJcEzTt7VtrXXZgXZTAFruuk5boozR9mSF7rrAlg22O7U3sehxeg+VUiB5/P8AUqj53cYTNAizAUHdV+U1id+NTONw2ah5SA7gjVudysXGgkIaRF8ifVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RamWKiLdkEaDiqSBw2gtXgT+/BnWPl6WXQ6gnjpZNQ=;
 b=cHD93fRGvfc6FWLp6QWfED74cNRTUexLwf2azf+iM7vcLMAQPgn0HDhLNZmuRCCh5l/yrEYNZG6LA9WrRI3PhY/MFvNmfbnK0p7XlG7TMon6Rzf9bwDJXmJohU6AqkZ+IILzOlhpeXAFjq3x58eh3FaPAfRe6LDcUxtuxjFgSwdO6Vr8sUuyYODWwqeAHNTNsDA9zKABVacwgOUKutm0jHLf0RS1o8cK/1kZJIryUG506fT6y9o7th5OZH+jNmTNTocmZge8kwJyWKqfczpVDjVBL3yrmBbdsd7O/8nJh4FjIsklrCCTG0U+6/v1KMblAd05pR9ywmqx4cRIl0gxgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RamWKiLdkEaDiqSBw2gtXgT+/BnWPl6WXQ6gnjpZNQ=;
 b=iJe6Zif1iiMtHWc37SlFNjYVCIfnXOnfl2GRNq/9exC39pNOBaDCTKkmiPgqGgLURIDHzFiqmmQgPDVfZH2q5oMpDC+Gy3jXdzmYa1lTIiC1nJYAngsEN80m/BpzsMRp85sXZyDz5SdeOG9RAht3LmhArlgNSSQRBx9gZvpbpn0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4148.namprd10.prod.outlook.com (2603:10b6:a03:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Thu, 17 Aug
 2023 19:15:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 19:15:13 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, stable@vger.kernel.org
Subject: [PATCH 1/2] maple_tree: Disable mas_wr_append() when other readers are possible
Date:   Thu, 17 Aug 2023 15:15:04 -0400
Message-Id: <20230817191505.1170876-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::35) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BY5PR10MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: d2698b26-6856-46b4-f896-08db9f564864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A3TNhfrrI1QNnR8LO+eaB2lEXSpZisDXOTR6Z69V2NZHN8eSpjRMnOXO1tyPCitYNpx35pMGSQ+nDCnVfhKDPbPYHnrU/yl5ZbQlZ0TwouMRSTSWqWXr8vWs/XS2Ojf8NUd11vEhRqikSMH5U5eq9yCTb3zjxNWYmyGfjznJoBO0gJWzg6xLQCqtiFXF+i7wTT3ball3MNBUalgTyIxRfWLCemwEAscgLeGhmOIxkLF6VP0h1wNyiVMdNs+Qf/p/3T+HOsJbDHygptTthY2NBySV1RgVTarXEdM8/6BcxYfnqvko+PgAaPOrumj+OMhohuIADOvrXuchnFb/sic/6wy0yR1NI/scAIUNXqPy6NDUNuzfCkzZIXLiYWy+CHRDHPaJGTKd5vRqOkzYkLy4M7oxMlxXpBobLgZif2tAd+ll/lvOywnxqQHJpP7V/ZYLWTjQyC4qZ6FZx5nOeiON+sqEPL/eQ0KDwSnpsPLqUmlhgefBgvkDDf3Clqg2nuUzEyMvsvJd1WFpTBosC6ncTk6jVnW4hIC67voIbQw0PIDX8CZPMLZXz+X3jFZvry+k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39860400002)(186009)(451199024)(1800799009)(36756003)(86362001)(83380400001)(4326008)(8676002)(2906002)(5660300002)(8936002)(41300700001)(1076003)(6506007)(26005)(6486002)(6666004)(2616005)(6512007)(478600001)(316002)(66946007)(6916009)(66476007)(38100700002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jzh1YVnc1RB9GG0WXIfpVzsClJE+ecvUmLnwcWpmv0ZE/NcAv1rIe1xOKzn2?=
 =?us-ascii?Q?3LLTzlbCfG0BkHOnT3xi9gcqtKzm8smOd/z2wdxT36335mU7eoySCDVq9qCz?=
 =?us-ascii?Q?ZlxPsojo2NprDDRX7+nPZ1x8nqAfZcFHNH3ZRcRWB2wwFeVcGJHZM/PzYYOh?=
 =?us-ascii?Q?hngJHQ8rZ85hKyqypwt8lN0UZt/XfXd7MVwicYTz5NAekMSjPrgj0FGiEp3O?=
 =?us-ascii?Q?zmcz9KWCtPsRbchCERESf6UpmxAgC5OPT6ywVAhpTnT+qMb0I0pqFKZQakzl?=
 =?us-ascii?Q?OHf4hBXUpeferwlf4ckRsZOufBzYxsR+99e3+ahX9QDMIcQGdQe+YRxDavM7?=
 =?us-ascii?Q?F5bzantSrhcVbolfPzEq77Pmpkn5tchHU/G8ecQBfhkILvW4c4J10qqM9VFc?=
 =?us-ascii?Q?kvc99Lt1NEh+eiUSkv6ctn7741wQVHKfRlIENGMSg+DCceKdOrYZxHWZCKs8?=
 =?us-ascii?Q?EST6gNS8UXGPreDWue6IQfnniWYZEapzXBRxKLFtEZg3JzokaKMMn2lcI2r0?=
 =?us-ascii?Q?jLxxDZj1nW/HSYFffE5w6yUFWQKX+0jdBpVmDxR6gMjPcben2BT54EOI6Ykp?=
 =?us-ascii?Q?QKSh2oPMxlsgfH7DNgQcllsEHIkIyliKESAqNHuTLXtdP9PerfNe90y8POvY?=
 =?us-ascii?Q?XKDDGfAVN4y29vbjLaEZYuOhRKpu4bYRIrqisgvB1wKPPXoTHTwZ3RhvTIQH?=
 =?us-ascii?Q?eFfZlp9mGc1VQE4EwYQKIGXSFRke9yYrKA/bAbq+9SUxz4MVlrBkQMJGcjnG?=
 =?us-ascii?Q?DydMyUqWr9ZA1fpDSSkZtkWfcUIZ6rn/IAwPHhwOWQqjLV82jerjsVompWZN?=
 =?us-ascii?Q?EY9s6eGYPU+N87atWw+LKLJWtUYeV6SwF37WYEtYfuIfFn81tMfCuuxjKEY9?=
 =?us-ascii?Q?d4Z2g9078ZF4TxUWs8j6o2pODolQS4XIF3HojUu8CHVZ6iuRKOXxywz0eyYs?=
 =?us-ascii?Q?SxVuqnlrz4BE8xfackFTAIAWhjvxbsK8QtKpWntKe3W6rL1wkfy70IqiZIM0?=
 =?us-ascii?Q?++VC44xWK9A31y3f8rgkJjnBifjYhe5SL6nS8/YnOa/vZP4IxZ5oyUHAlipM?=
 =?us-ascii?Q?SOqfadN3/svB1ncMAA3Ne+lYBVb2VTLhvr7cnI6nxA+80xOagzUo8/HaXugg?=
 =?us-ascii?Q?LHQAwHpn8vkDNcUNro7uVs+5M7mbgGME2+TtRbNvYwGNqJnq8gl7TtFNZZIM?=
 =?us-ascii?Q?BSZ0Gmb6PSN0iS8+Yi5PeKLqSAYS8lXm/Y1503E/I3L1huT3F0rRUFTEi7Mr?=
 =?us-ascii?Q?OKEEBgFJa/LKKKzdG7xEBXkS44GGHqyyZ/85ihIOdO/pT8Tqq7TXPbbXBS0K?=
 =?us-ascii?Q?9gXQOPR5cE9j8Acnp8fOeEVlmoG+X/4qBEIE1Fr/U4drq59wx2mYXaELKmXk?=
 =?us-ascii?Q?YlOcRiPqpxHa2QvehlH11gmaQ69nLicBaWLuiOUl7BZjt9Cg5+HmaE94+Kb3?=
 =?us-ascii?Q?9pOVe9VYhjYOho+/CmMRfMq7nolUrZIADaEkn3d86v2u5fz7J3qTrDt2ItRE?=
 =?us-ascii?Q?om8m9IAW5Cwbs4OPP66P2qwm7ZbmyThKYc3Q64cvvKIwKBQhCX3BhfVyMfgT?=
 =?us-ascii?Q?D2OO3I8XLTtlv0yWBlT197EIycSvdeb7WM3FRL8w?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ABL0MwMbiy2UpT6rG7GiKmgqRkWCwP/SrTc8XRUVtnFN5kafh32UsfiJ2c8F8ZEArIhDO/lIq3jAWiHMHlUUt1uimZASgxuhbo4y1hrZ4Xz+W/QNaQ4gQg4XjMfsNYC+eaN75TKB4eLJnTX1ognBsQUU6djW9jlVZKFrAxrzOlKIQ4JVgsmLZrn6G8AWO/MOi0gSJM9PmdSs9eRe5zOMk2FE+5oMLC9D2wRM3lnuR1ICQBsRQhNoxI9QU0pPKGDwUvB9QPnyK853YBNQaCEfx2UmcKS9HwKLTgc2LipLs52vgduAKiTwgnq+sEo/K57eWokaMOBSmCX3YgcWJVPx6DvQKRiTC9m22T6qqaF+JLK4SMbCOPuamSRTjJ0ws+gxV4REXhQWOj1x1fJI9oz3rOK1Erret8JvJjyYdALHAHfPc2WImUXB79Cw5Izl7hiDkB+2TynMA5R6XmS1jsmLJ9zoOyncO4RMsnvsBHUTTS71uvtg2LlpEGDBsJK7P9jx6n0voxYhKwANGUP5kAK3gPiLH99ltUyb3q+Ok9ic+4vOEHGxiQDj0vLR8caHnfy2g4M613mvyXtu/LVgwHY/2S1OT6U5cc8na1mxXNpw0OXPeRwGnHe2b0pKMXguX1la6NLaVlPkFC7G50qiRyWqgXZv4tcDBCo7FlpF8S8CY5XN4YfsXZyvG5m2PaULi5I7U3/DqJnMuoDxvjle7N15cILSxN10LRzFuYLyTYnCESSD7LDXM2biEC29ScADIFUisIf8DWH6cuWM4+smHBjGFekJpumiJwmhX4l5MfSfNUuJRNd8x20K+YU80eLNxTXFIExe/YsvxweLPeEigS6kiN38crAjP1XHEWbnsQXFq4MXrUN0fsr+YpdC/7xoPb7XO7n2zP2SQ0go2XSnkjaT9w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2698b26-6856-46b4-f896-08db9f564864
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 19:15:13.5033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OsNmT5gKt807h3iF3eq5KrIRRmpJLM5QxIDSh707zI7+v/MnJBHAyibsiVx8TWnMihI+RhTUtsGXy2JM+GR9ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_15,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308170173
X-Proofpoint-GUID: rlEViHo9uv0vmDzLaSXy7Tw_ZX0TS_t8
X-Proofpoint-ORIG-GUID: rlEViHo9uv0vmDzLaSXy7Tw_ZX0TS_t8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of append may cause duplicate data and/or
incorrect ranges to be returned to a reader during an update.  Although
this has not been reported or seen, disable the append write operation
while the tree is in rcu mode out of an abundance of caution.

During the analysis of the mas_next_slot() the following was
artificially created by separating the writer and reader code:

Writer:                                 reader:
mas_wr_append
    set end pivot
    updates end metata
    Detects write to last slot
    last slot write is to start of slot
    store current contents in slot
    overwrite old end pivot
                                        mas_next_slot():
                                                read end metadata
                                                read old end pivot
                                                return with incorrect range
    store new value

Alternatively:

Writer:                                 reader:
mas_wr_append
    set end pivot
    updates end metata
    Detects write to last slot
    last lost write to end of slot
    store value
                                        mas_next_slot():
                                                read end metadata
                                                read old end pivot
                                                read new end pivot
                                                return with incorrect range
    set old end pivot

There may be other accesses that are not safe since we are now updating
both metadata and pointers, so disabling append if there could be rcu
readers is the safest action.

Cc: stable@vger.kernel.org
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index ffb9d15bd815..05d5db255c39 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4107,6 +4107,10 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
  * mas_wr_append: Attempt to append
  * @wr_mas: the maple write state
  *
+ * This is currently unsafe in rcu mode since the end of the node may be cached
+ * by readers while the node contents may be updated which could result in
+ * inaccurate information.
+ *
  * Return: True if appended, false otherwise
  */
 static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
@@ -4116,6 +4120,9 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
 	struct ma_state *mas = wr_mas->mas;
 	unsigned char node_pivots = mt_pivots[wr_mas->type];
 
+	if (mt_in_rcu(mas->tree))
+		return false;
+
 	if (mas->offset != wr_mas->node_end)
 		return false;
 
-- 
2.39.2

