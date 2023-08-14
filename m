Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD22E77BB39
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjHNOLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjHNOLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:11:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB4A94;
        Mon, 14 Aug 2023 07:11:13 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECiTWX015383;
        Mon, 14 Aug 2023 14:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=jklFQAOl9tTDQoGuFFQT5JmktCXzpyfFlaUn746imQM=;
 b=gY8AjMEASjav3USZ1iOppY3olS47kMTfHfLges/pWEXA9/v9EWNP5N/4VV2cYnuLASoW
 Gpak74065bsAAqbKLobbbxJRCNGDxXV0AeTreLlF/pi2G8UPkqwdkWd5sL6nrzqJ5A3E
 BtK8o9Nn/K9j9MT27RePRNwfwC6/rzgB4lkNAqf2drg4DeSFf91FuiotMwGrmnnMvLCa
 Ds7lT+Bjfc0KUdH9w4hKbE3JCXa4slzbeI4gigFNRmZ+zuEk+O+WUe7ogIiDdQBQUn1h
 h0JOYZp0Ql5fSckDl9Y9antJrM2N8nnYGg8lgIC+CrxypaGM6TVOOQrsfOnXiXs1HmJj Mw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yfjqc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 14:10:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EDT0II000676;
        Mon, 14 Aug 2023 14:10:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0ppnj3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 14:10:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kl0Hoku3NgZkyHFClHYULBH0wd/NAxocBqvLZ+vv8ynwCN77InduvJJWoTWV1itATeP99qqRNRNB2jbd68W2ijy0wj2Olfhw5NJTxGfTp6cQzEFoNAXJ0fncZQVSpuG2nQVoOXVnL3cdfriiD8G/5s3MGHN94Fbr4m/mMFTCDfjmvrEC4Faruhh6EzXj8f+Xasa+qxH77QAaudbE/Fd+pLWJcAvKzn5AdFv9cDedADUtyMl5Jubu+kS4dB+dkafe8J+XduWe38MXIr+0ykAqjAw4CuN8i+6o+2ryLevBXx/LeoitS56Y7kt2+0MdLHi9N9MkjThVA5w+uR/gm/EGWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jklFQAOl9tTDQoGuFFQT5JmktCXzpyfFlaUn746imQM=;
 b=gpe614xOtoWQ51RX/qasd6mpJIhLJMzqm6v2UkBUSGnsvRDphvL+p4DCWLV49RK5kbSV+60+TdlZPNuBEpre04W3xPaYUkSkSqCsWTIGaBcZFlsJz3oXCe92PF3Yy4qk63KZrOfgQFO3M/3TkStk0l6raweXfcUB3UuB/9lTiznqi7YOCrNraAAiKGhX+D1ogFBiPPixnomPkmadnokv8kaVymAzY3GlIT7oGpS3lxoz/SZDs+T0Z3TUkFZZrVgjFOFTap9X+PJQDoBS8acBDlso0Bc6MqVQp1O1vLE2E673/652/HgutRJn5EGC67a74PpQdxD05XiKHrCDkqS9Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jklFQAOl9tTDQoGuFFQT5JmktCXzpyfFlaUn746imQM=;
 b=uUNRxjYc+W+CR0MF/5SjPUqjWamkqp69GCaK/dcCUU7rYuEfl9eroE6Gqbks7qQh9gtAVLK6e5haDClT+GiWlVrSvCWOCX+h5nGM7gEqq4KbJPgxbhHVcRiKgoDlKfeEcrMroaxA49bWrK/+Vs0d3q+AD8X2so4KzMixc6lMHIk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 14:10:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 14:10:47 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        chenxiang66@hisilicon.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlemoal@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 01/10] scsi: libsas: Delete sas_ha_struct.lldd_module
Date:   Mon, 14 Aug 2023 14:10:13 +0000
Message-Id: <20230814141022.36875-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230814141022.36875-1-john.g.garry@oracle.com>
References: <20230814141022.36875-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: c0dbbe38-4712-4c19-0ab6-08db9cd041d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HEI/t8Dm9FYnQcMbS1dHBHPP0p7cri+lsy2DaMgMEvnmvxhXMVc+KoBhTqvqJcYE4wiEqa84yK/2zMft/toveHAPDPM2oyP9Qs5idqJJwTcR4K/zwuyc2/czfKETqpY/lRo/SNphiSZ2DB864e8OryqxMlhKr9+sJGYXIUXHktWWpk3K2ZCDsmZhkLYOgdysbICm+oIbpNwQPGyvmIARFD1xKS6T9CHKuS4TVdqgfvEDpeR4xX1+/PNDQDI+xhukbHLWMkLtRLIJYpqHeLKa8DzQfUxsz9/+P/N4X7fso5jAsbdxUs39mBDCqDigYaDMqjTjbHKBVcwdUIY1KGTdI1nM/ERiY01vJxILWtX7jsbmdpowlEGSXyPi/iK+ja4JCIn+Cx+m4JzSjbyLntPzkU9DeDkxIMdL3Ka2DH3NdCfCmUF+vleqL+TR6vbFYcNdNt/1nL8ZUPB+UMrUBYpyWur2xorlrvSIIT/HS1p1ulJTykzHA4o6C6gkh0NhD9Km/Jn9kXAlJ3ZIPUWFaAgLtBySI9p/fWo1umHQDDtjx6sommjblwuP9w0vqOSmLc9k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199021)(1800799006)(186006)(6666004)(6486002)(6506007)(478600001)(103116003)(36756003)(86362001)(83380400001)(6512007)(26005)(107886003)(1076003)(66946007)(2616005)(2906002)(38100700002)(316002)(4326008)(66556008)(66476007)(8676002)(5660300002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9OKib1x9EwHyjhJfEIJJVkhG858MARqJm1ww58Gmvq/9MNxuR3yR5zb7mjkN?=
 =?us-ascii?Q?sgtXJoeR55l5eSTuxrhmtSeTB6L5u2snYyk5FDy3H+76zbmFDCVAb1LGXwWn?=
 =?us-ascii?Q?P9L8p72dwOSzHxiOxju4xz54GwnCtS5dVO7scayVjlQUBKRPeWu+jdp6Sak4?=
 =?us-ascii?Q?v1MVLc2oOB98cMbTYs60wNG4Wr1QWavaSxG8tKJx9lFSzxWhgi/ZJLPcexUd?=
 =?us-ascii?Q?wRbjUVj7Z9bJYDO6kxucQxGg0kAjL9ZxNPXdiOeEiPR9t7/iIWc2ebo0LtIl?=
 =?us-ascii?Q?BRg82JSsrTaFwjrtl/67vAut2nw040IWvpo5etnxd01Ial3VLlxEEXosjDhS?=
 =?us-ascii?Q?WD77sr1/lDOjDuZWjE9xjSbuROiZ1gVueTGPUls3W1i8xQb4Hm7lnPI4J/Gx?=
 =?us-ascii?Q?02C2hw8HSxVUOHXtWpipLI3EHzwI6uZ2LGHBhTW1ZuIwyyuIHOkA2ymgaBPf?=
 =?us-ascii?Q?QDVhqE8VwGqd1Vyi+Och4yfYTOvkqvDGJPwZZJ8mBctOh0gLpal6VHnGCk3y?=
 =?us-ascii?Q?gZFijQl8iVZ+v0ylP/kmVdISE4tXwTBdEPpwQOUIxcacWN7cfrI4k43Lbrdo?=
 =?us-ascii?Q?3vGrUtbVCR5vlNRmP3704hjtODuWxetZZZaPSaa7Rx853+d2EtVFQLuSITc4?=
 =?us-ascii?Q?1DQQ2RunkrFN9CT7WUSoae/hwqnd00rLqJRCanVypjwNUkBH00NSRqnsL5QI?=
 =?us-ascii?Q?qouaSXQgKEzhE5DbcI8jYSesJsWfpWWhnx1/z2DeTWuK7EW7Cc2wvpnf7dvA?=
 =?us-ascii?Q?2m0Jv4dznx6899xq82pQmHgf5NrdGKugEvy+V89I27cMSLS+/mCIQct252rm?=
 =?us-ascii?Q?rq4jma9nL3SyDtsEJmPsdCM0tMxRyp3CE7JFf14gTX6KXqYgMryIfE7zKyu4?=
 =?us-ascii?Q?/Eru80VPg/jApoGrB0gWwzv6hSs3m6EDH+zR6f079eoKMEexdJCzH/AGUnaI?=
 =?us-ascii?Q?eQCSo3IRuB5eTV8OhXRPyRJXB034JAe9KTlpEEazMU3rVdX1i45P2XwJK5IU?=
 =?us-ascii?Q?J+TgPyHYBZTwZRBNBhKIXocn+9gEJzvAkoc+4ZmfjivXaapxWSCLxAN33dqn?=
 =?us-ascii?Q?fG0cOm9n+IdJKGNlFtOFAqYXaTNZiKRy5MYHSzbgKtT5Lq6+DNvjjSsHhgKl?=
 =?us-ascii?Q?/CplHkgfqZ7Aal6RtN3J+xCZ4G3SqkmhXm+SlzALmnR11FDjjAktUO5hz4LP?=
 =?us-ascii?Q?nHmcvVQWffLxNx34z6FMfeqpGNnIBiPQL+tLu0SoD606if0c60+A+zx9uDNT?=
 =?us-ascii?Q?Oq+4dFUHhO+eCkPK0Y5duRdQwjOeTzfAzMoE/HuI8+kz29ahyYwv9pCkNBn2?=
 =?us-ascii?Q?ahMhsGTpVnbAWvi66V4LU+VTgK1GWYJRO3QRTMe9KG3AR6Jx4jTlpnh5lEv8?=
 =?us-ascii?Q?AN624nJDOQRnWznCQRPBzSU2J87RON0fA5b9E81AQCCXdvMo47q+IaqjuQci?=
 =?us-ascii?Q?ZsY72cfEJUmiC5mHENo0JAjgnvV722UOPIOdUMDe1Wf47f+by4zmkaHG1fH8?=
 =?us-ascii?Q?H907z2bHt+45F0g6/jenGomazGQluM8DnZfLyjlT82BzY3tIVYANLU3q+qXg?=
 =?us-ascii?Q?pdUFbCVekgiVlpurSm8YMUJTEllUXAu7khNFgotg+DnvYK1V/uaWAsu0nuWl?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?FvzrXOJfkLMlYoGnPfW+QK67Xl31I/xcfPmKvp2XM0MsKyT4WoXdxTxql1JU?=
 =?us-ascii?Q?l0XoSZpJ2zrbSl6MxT2JRIdegWPgSOKSu45yeTIQZE3NHDHK+3KKt5MH56wP?=
 =?us-ascii?Q?vaQ3l0KtO73LCvo7jmLbsQt8J7e6I2mOssESWmjucvU+mY9MB0gXug7Lkbre?=
 =?us-ascii?Q?O8/bwfjOUVztKg73nFHoK1NDT60bqdS0+g5ux5jT/ETMcv8kwlQt1Qyig6K+?=
 =?us-ascii?Q?OmFJilGR0Quo7uD4J1cQd2i+4qUDVuOavY/qXH5ag4rF/HFo32jtGdp7QSZd?=
 =?us-ascii?Q?owiQi048oNJz8fRJxG+YIop8Hw0YMwC4f3H0L0gjbwahS32ZUB/5Q+XZV71t?=
 =?us-ascii?Q?il5LEn+P2+AR0ngD4LMhtZ7qc2DhyQZkUJddh0mWmKS3c9Yuy4hyvVMB3yzA?=
 =?us-ascii?Q?moHBiug428qFvv/hbilUz5bI158A0w607aNRl1idaokJPkCjyVADEphbKBQ8?=
 =?us-ascii?Q?IUqzZ4FooqG/QOQdmX47BWOCHLQAuUoTEZLsKP30qbqYX47gZQ5ojGnsZHNg?=
 =?us-ascii?Q?0Fk3CL6ab8zw34drhF6LfJnsVJ/iZ+Xds/dqQuByAFC6iDCMj5UiMS9nbnWT?=
 =?us-ascii?Q?z1AQIYZAt0kKrf+W2TVjO6R3mi4wXS3ZnFnYdbjbAiXioVdhf1thNt4KlL7i?=
 =?us-ascii?Q?BcnSRdjmsJOFgtYNvxMmfxYEqzQxwfWZ7D8/nAyhXah/IUkXFN5rBqlkeUTR?=
 =?us-ascii?Q?QodomqvNmRwXAcnv5T6fbFugfg5hVY8fMNZntQ+glQ0VIXtB/yHzEUliEv3C?=
 =?us-ascii?Q?X5s9x564qpFxPPBqh9G//6w0LtWjuOJevpfESw5TyF/BS3q1GMK/n88B3Xtg?=
 =?us-ascii?Q?oGmfEz8DZXy17tA7RpL0X/8rmoQMeqpS1HDWDNn7ZFD/FkyoOwSCbMKhllmm?=
 =?us-ascii?Q?6WvT9x7Cd3j2s5dSs9twVuIE/iONVtExwO7yFgxzzQpOSEsbA5mHJuLRvgzg?=
 =?us-ascii?Q?1tJ4vAbkU7SZsf38NN5ufw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0dbbe38-4712-4c19-0ab6-08db9cd041d4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:10:47.5370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tV+7JBBMSOs3k4NbPt4+clne4RHET4adb5HYbWPfdxvemqRZvbae4vtcxIdGNtNiNnUOXk8RZT8XpyDoapexCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140131
X-Proofpoint-ORIG-GUID: gRxQfdXhIxjsCJLPOBabcqBPa9nMPHT4
X-Proofpoint-GUID: gRxQfdXhIxjsCJLPOBabcqBPa9nMPHT4
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
driver"), sas_ha_struct.lldd_module has only ever been set, so remove it.

Struct scsi_host_template already has a reference to the LLD driver
module as to stop the driver being removed unexpectedly.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/aic94xx/aic94xx_init.c    | 1 -
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 1 -
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 1 -
 drivers/scsi/isci/init.c               | 1 -
 drivers/scsi/mvsas/mv_init.c           | 1 -
 drivers/scsi/pm8001/pm8001_init.c      | 1 -
 include/scsi/libsas.h                  | 1 -
 7 files changed, 7 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index f7f81f6c3fbf..6603e91cee8a 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -667,7 +667,6 @@ static int asd_register_sas_ha(struct asd_ha_struct *asd_ha)
 	}
 
 	asd_ha->sas_ha.sas_ha_name = (char *) asd_ha->name;
-	asd_ha->sas_ha.lldd_module = THIS_MODULE;
 	asd_ha->sas_ha.sas_addr = &asd_ha->hw_prof.sas_addr[0];
 
 	for (i = 0; i < ASD_MAX_PHYS; i++) {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 7a62590f8730..9585f1ed8ae5 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2514,7 +2514,6 @@ int hisi_sas_probe(struct platform_device *pdev,
 
 	sha->sas_ha_name = DRV_NAME;
 	sha->dev = hisi_hba->dev;
-	sha->lldd_module = THIS_MODULE;
 	sha->sas_addr = &hisi_hba->sas_addr[0];
 	sha->num_phys = hisi_hba->n_phy;
 	sha->core.shost = hisi_hba->shost;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index a676558b096b..7b40f0eed703 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -4973,7 +4973,6 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	sha->sas_ha_name = DRV_NAME;
 	sha->dev = dev;
-	sha->lldd_module = THIS_MODULE;
 	sha->sas_addr = &hisi_hba->sas_addr[0];
 	sha->num_phys = hisi_hba->n_phy;
 
diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index ac1e04b86d8f..c3704208511b 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -250,7 +250,6 @@ static int isci_register_sas_ha(struct isci_host *isci_host)
 		return -ENOMEM;
 
 	sas_ha->sas_ha_name = DRV_NAME;
-	sas_ha->lldd_module = THIS_MODULE;
 	sas_ha->sas_addr    = &isci_host->phys[0].sas_addr[0];
 
 	for (i = 0; i < SCI_MAX_PHYS; i++) {
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 49e2a5e7ce54..aea70ec308f9 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -458,7 +458,6 @@ static void  mvs_post_sas_ha_init(struct Scsi_Host *shost,
 
 	sha->sas_ha_name = DRV_NAME;
 	sha->dev = mvi->dev;
-	sha->lldd_module = THIS_MODULE;
 	sha->sas_addr = &mvi->sas_addr[0];
 
 	sha->num_phys = nr_core * chip_info->n_phy;
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 2e886c1d867d..1e0154d08393 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -654,7 +654,6 @@ static void  pm8001_post_sas_ha_init(struct Scsi_Host *shost,
 	sha->sas_ha_name = DRV_NAME;
 	sha->dev = pm8001_ha->dev;
 	sha->strict_wide_ports = 1;
-	sha->lldd_module = THIS_MODULE;
 	sha->sas_addr = &pm8001_ha->sas_addr[0];
 	sha->num_phys = chip_info->n_phy;
 	sha->core.shost = shost;
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 159823e0afbf..ccaf8f6b1055 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -376,7 +376,6 @@ struct sas_ha_struct {
 /* public: */
 	char *sas_ha_name;
 	struct device *dev;	  /* should be set */
-	struct module *lldd_module; /* should be set */
 
 	struct workqueue_struct *event_q;
 	struct workqueue_struct *disco_q;
-- 
2.35.3

