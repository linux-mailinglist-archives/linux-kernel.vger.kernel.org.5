Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB41777CC26
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbjHOLxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236984AbjHOLxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:53:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3AD173C;
        Tue, 15 Aug 2023 04:53:03 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FAg0ZT004807;
        Tue, 15 Aug 2023 11:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=7E0uXqGclzM/1d//wdrT4WexD6JOcU4jHvfMywnhYGg=;
 b=QA7oSOkGtVMgwISn9nFfA8U/f2f1PYEF1WIq/Xu0h9qUClNkwkrByjLOfZHblZkHml62
 eKMfmorOk/+j5mTtMqYRDCtDBI/iLE9HgOirAjFubWCSZiwDeRWuPaMnFNGm5U4EzMdq
 tEO8CKmg8e1Xha97Jkifd7prhWrgyqnC1Gwe5M+K4JEo/CAdy/ChAfqvFwD+cMclK7iK
 rubEQZT5m5U3dHl1Q8UbjnK+bY0JCVIn52OpAO2E3+1RnKVniqxzmbDgtrdTyhscLKPK
 dSPTLfy0Fuvq7F3Bx9f2LkWW/0JghJ34GoYFwCAlVD2CTf86q0RGWv6ept+n0EPgEl5x Bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se349cgk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 11:52:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37F9Vaxa019924;
        Tue, 15 Aug 2023 11:52:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey3v7tnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 11:52:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+REnMujas5pnfcWSUwT9TKGufh6RNHkKAioRaiZEat2W5AfM2GUFHUJtw9J/EmqLZ1CVAMVhnPe9uL9zB/99A9PG8fwrVJyZ/dOT4H582lH3l+ZYJXQ798U/75vXnguLXc5zHqfymihNYZtqX6Jdb7++8TpuPEY5rg2GY4j3qYQs4LjSddWzpIq4hAsprtxtsd56o3PESjraXCxdf9RQJpembnKhPt0t22sKAehgP4h8aKnue9Kaa99afJAOG1lAVTvLABT5ONVC8jlUItUlXO8Pie3Hk2Gv43hc6kDtPMKvcT/aS50Py4vrHtj73bQpgK8ErP2ZgoV2pHFl31LfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7E0uXqGclzM/1d//wdrT4WexD6JOcU4jHvfMywnhYGg=;
 b=YSl0AuXq34aVTBkt0n8th1eOT8lqTudkY4dqFppotUgHCnrpl65QFrdBO3spUJVaTfUVAO7F9g1IRNG4BWru24Z15ydUI1Wb0J3c5/Ryx+XN+Uax6zXo54QsVTvDLlGIdiLsLYC7LQJfuLcUELxJqibuzyFmdcVkFNkLy9n+h5TMeSX/GJI3huPWr7Gb87+4zGKQB5P8dU2H5a8dVqG+sCfhBiIcLk44wd76OOdmP17P+nZAnAOReCjKWFmdQNu+/kCWvmr0dG8LgLQALdSMDWVoIZ19lK0TEXzaCw3mxLjyw4dYY/p6/18G3Y67Lk075opVLt0TpE1MGAzBoMB/jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7E0uXqGclzM/1d//wdrT4WexD6JOcU4jHvfMywnhYGg=;
 b=qntWYvu1Uw8sQZc2R9nqEVyd8eLPqwLmpvPKgT0ikMk+5pvdfbF0y8+q+kILODLjZ8fzn16G8OFxhl8wFAqStOQtLkEhq3Q8auyNW1GBEfaNZjYUI4wipDTbbHRr2tIElwXMSMPdFdg6+VO7sqK61DNhDmpM6ZIhcKyVIxbG26g=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6710.namprd10.prod.outlook.com (2603:10b6:208:419::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 11:52:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 11:52:45 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        chenxiang66@hisilicon.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, jinpu.wang@cloud.ionos.com, dlemoal@kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 10/10] scsi: libsas: Delete sas_ata_task.retry_count
Date:   Tue, 15 Aug 2023 11:51:56 +0000
Message-Id: <20230815115156.343535-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230815115156.343535-1-john.g.garry@oracle.com>
References: <20230815115156.343535-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:806:24::32) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6eb8c6-13d8-465e-f9f6-08db9d8623be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ryRsVNceQx6kfcNJH8+GSMmcJOPl5sKOSRe35IhU3/vYGjSoKagbdY8QrWyEp8xx6ynT9hNxSDJtdDRbs/27sv7jLtajaDysqR7wYCIjT439jv9JaZZtbeFnNtEWDuLKrDSwOAPte5QKnSKkJrBgB4rDaLke4j8M5IwDzWHl/ksRNfDZUuyf81PMyJvhPedvUjVjccK8SyUZNw2KEG7ObtVVl3RxOTd4rCSO5Sgkip6jMzzfTZd2cT1Ui4Zym0mni76+iTSuz76oJS7VaboX0VTwZ1WoiUEL6iR6ypjbfmHgLeHfBkDcAvFaqkENA84pt3om3n7IyZ0SRDGJBrGMr8ftIjEzzGINQSIk3iHJ5l/VKQfeGXQHRU3rctfLQQpKUbLQ+I6Pb260k3RtrISNJP3A1yS5oQiJyu/tlvBGphhtc+MKNKXf7Qjm4y7O2I/hL5gb7Fg0ZDh9H7SOBTckT2YVtKbmYvSh65iWMCM1+L5V/xv7H+iOPfSZVesPmeoCecevqVnjIcL00EDlduOFX+pAoG6fVY21PkGsS/0YhEt0TimcsJ9DwnZIQ9Xz131V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230030)(366004)(346002)(396003)(376002)(39860400002)(136003)(1800799009)(186009)(451199023)(38100700002)(41300700001)(107886003)(6512007)(2616005)(5660300002)(103116003)(2906002)(36756003)(4326008)(316002)(66946007)(66476007)(6666004)(83380400001)(478600001)(8936002)(66556008)(26005)(1076003)(86362001)(8676002)(6486002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zwx/q7l3TlUPi35GRJzWGrTvaZKP9ytHcF2qRbedQXs9N7Gd6f7Ts3cJYTvt?=
 =?us-ascii?Q?KoZ+oTYguVj284D/p4IjiPe5EkNc2EC6w9Z9R7JTGiKnFpFWRbHXJCgc9FP6?=
 =?us-ascii?Q?tuBtlVpX0ohzUetIa3mkT7k0FF8lbaiGGkiC1hMp5xZ9DIgYORum1pyiYE1J?=
 =?us-ascii?Q?Lhp7OLXlFJ2zmcP6IJYP2i7HgDv8hia64YtudTKn70Etb5DFFrDLqcoyyriz?=
 =?us-ascii?Q?CZhWxo6fOhTef59YhP/pGB5nEiyBFcRi6TyMGf5u9ubam3PFuLaaKOjHvD8a?=
 =?us-ascii?Q?GiSK8qP/mA2ZUJqsQP0bV4T31cJ8WaAs5Whmfh2kriAPokSKSiGlR8WYyr0d?=
 =?us-ascii?Q?2dWSqPdvNsV91fDJ2fpxzKo1AjM1R2x4d06UBXiU6fWSGADvAWsELvnpj3V0?=
 =?us-ascii?Q?fx8pcuiPLqj3hJ7nR5E4RJWBsRZVtdgFBvftKRiU7hS3sJvSZoaFHECltpk9?=
 =?us-ascii?Q?7PqxwiIPHcmV8VXuSM0CzGU7Iebz2dXAxeLqFxaqd4sl17W2eU50Xx14EMSS?=
 =?us-ascii?Q?++6NYE4dsW66ORzcahTWMdDqt6+WZiXfKo/jWLsot8NbZ8wnuet6aZvzlp08?=
 =?us-ascii?Q?ROLQsNbMIQM+UzC+6oQ/jPKmUO1rd10OvCWzmCebswDLSS60hvunSdcXLe7F?=
 =?us-ascii?Q?MoJQ+gTVuVYFiJhICxjakM97UIRZcIp4RxJ/uPcOIxZr3l981ibbrz9rBfvr?=
 =?us-ascii?Q?QUaPBfJL5AnL4Kg6LF1Vt7O6H3qT1E2+ZhmcVPIRq/2yKxHQpiKRN5I/Bnbf?=
 =?us-ascii?Q?gJ1md51jkxwaeecGSZHxEpDRocrSyTPmZQn8BpUzqHfrkZLxerZ4xdYl8gkv?=
 =?us-ascii?Q?0zrRmRlg6+HCYlYDJTBYB3BxeEhYbzuO++LsM1FAW+43oBuxMrbrUt82J9FL?=
 =?us-ascii?Q?8ixiOvrgMXNG3bTnX19KgEatCoC+azgAfrFiaei0XxeuDg+sEX10nQknM9SJ?=
 =?us-ascii?Q?ph3yg0ez7ZV2MhjKPYhZD55Xapz2FoObzYz6yuyJijsH6ZueB3ydpdQdu28p?=
 =?us-ascii?Q?f3LZCoEE+W39hbBpRGgVi1cf2x+bq0sdXQXNClfbnEJ+SbIJ+i2Dvt/1viN9?=
 =?us-ascii?Q?Al2PdUAitJxDMwtbCUq+1az/PDoDWPJEziyl8cl9UvqRFlkOO3PjFqkywNXp?=
 =?us-ascii?Q?Pg5fIwrS0RyrRLJ1qtPdtIXS+i/DFdaFdV62Z1PmS12pg4i8ToV/OqlEF6vd?=
 =?us-ascii?Q?5yv4VYqZEg+fE7ZEPzFC7Pp1HLJzS0OC13Xil7zCvffQ6MqlQT/JwYxOSYs9?=
 =?us-ascii?Q?9iPyxh4HLobxiybsowz2ALFq1veXuCWH6zV7sh3uK1vMRl5u5poEgtvjgZVA?=
 =?us-ascii?Q?1nsLzA40dVm8MzZsUxlSX5IPVgeMC6Scpl7n/5fuBY9RtpioSJCDgY1AOaSN?=
 =?us-ascii?Q?hSCe1snqAvUsqQYNNG2S/g7YvahDD8ZZIqHn/rj/j+jFpK018zsUwNLrAuS7?=
 =?us-ascii?Q?BOnBI5JIkeNZpqBCbNx+K1P4tqamu8PzADtYOXHe6sIZ7jCuS4ujv1+Eal99?=
 =?us-ascii?Q?YvrmOgCH7k9tgsD6a9AAeCDxytJAX9+VAVVAYo1CSurzSP+SifVHkSU3+35y?=
 =?us-ascii?Q?E7yko3qOiWDJqMbLxbLnu4yOScaj0O7TbP77WK4f0qqE5+ACXNgfNrAxHgFk?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PY9oA//1nDuOZs/aubH6scI7HEVlOZ9HS/RPka7sbvEx0asRs0/hGKcpycAl?=
 =?us-ascii?Q?OlEdqXB9Kf8kBdxefiiI0vVOFnQssBd0Hws9ik9DmYBw3ws41/koNh9MopSH?=
 =?us-ascii?Q?TvteoyjLy2iMQi/FaQxLLMU73WKGMJM1ov4PHzDHE9rnb121mD365AW8xjfb?=
 =?us-ascii?Q?ivELnrT3DpLoU3c7If5TWdMP7yRgq6TIpl++9c7d2OmRk0ho4enafh9jp5eT?=
 =?us-ascii?Q?f94oRCBYWp5q0XPztdaR4/xLVEvHrYja+9bESxmBkIVB8fBJOZ0JeRfBBTyg?=
 =?us-ascii?Q?2pIr/tng0qLVc0weX2sOKlgdYkdj2LzAAaOnOHJSuKZObnw3ZKNGfSKggPX4?=
 =?us-ascii?Q?Qe6m8SmSReGhsyOpHVluE5mxsyFodkdCltsJ5ErqFUBPDJwYCmMUVybvT+A2?=
 =?us-ascii?Q?fe8Jd3YhHjYlRfec44180yKlsnhPueqPkpQxPL9UYFaERJGNRA8GcYpd/Ram?=
 =?us-ascii?Q?5KtWW23s7NBaJrgXZoJIDBzdhw8IfemOzvgcKqfJDFXEWpbhVMqYxGLYP6Lm?=
 =?us-ascii?Q?zL+opRO3vkecAychQF1MSwUyGUJdcsb3JsfPC0g8Ea6HjK6XPA4ldCaiF/i2?=
 =?us-ascii?Q?OvuhL7rKrDSn9+LVal/xYfA8bdsGYjyXPLqm/YLPFd5323t1IAb52oaaonzS?=
 =?us-ascii?Q?aQL+XCvWCtOJYE/RU5LEs5E6DWHhc2wDykU6hyF6vd+21vjbF0pAMDk00SBn?=
 =?us-ascii?Q?qA56Eb46lrzFwzvrC8QmoQrcv+SF/TnZ2yK1VnMxOU0bYg9BsE6aR9QxxqOZ?=
 =?us-ascii?Q?t00k2yQS019CA6OWK6gE1sa8+zJg2CPeDUOn/XtRFOJQjYdAilW0xFao1bsr?=
 =?us-ascii?Q?4QBKurnOYI09upWG2I9gh5r9Us6y8zzmb/JZmvOAm/EyZmr8zUmJXg6jh2+u?=
 =?us-ascii?Q?Ld1DKymYev4A2CEfZHC6HqXiWgEwchCuROkIGwHZfrykvbL8Onkv64gmYWYS?=
 =?us-ascii?Q?qclxxGW52nZcsxGJzSpIKQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6eb8c6-13d8-465e-f9f6-08db9d8623be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 11:52:45.5965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dI1+hKWOeE+d3teDAPw+HMvmEoRnWcFrJ7kN30BY8cvGoY9MOf49a3OImmukIJHUzaBuSO6WwFjNb0cHd20Flw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_10,2023-08-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150106
X-Proofpoint-GUID: LmaKw13GmYBHo0sbG9VTBZUAbNhvtspu
X-Proofpoint-ORIG-GUID: LmaKw13GmYBHo0sbG9VTBZUAbNhvtspu
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since libsas was introduced in commit 2908d778ab3e ("[SCSI] aic94xx: new
driver"), sas_ata_task.retry_count is never set, so delete it and the
reference in asd_build_ata_ascb().

Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/aic94xx/aic94xx_task.c | 2 +-
 include/scsi/libsas.h               | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
index 21b69e592664..4bfd03724ad6 100644
--- a/drivers/scsi/aic94xx/aic94xx_task.c
+++ b/drivers/scsi/aic94xx/aic94xx_task.c
@@ -388,7 +388,7 @@ static int asd_build_ata_ascb(struct asd_ascb *ascb, struct sas_task *task,
 		flags |= data_dir_flags[task->data_dir];
 		scb->ata_task.ata_flags = flags;
 
-		scb->ata_task.retry_count = task->ata_task.retry_count;
+		scb->ata_task.retry_count = 0;
 
 		scb->ata_task.flags = 0;
 	}
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index a65c16643315..2601f5775a99 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -525,8 +525,6 @@ struct sas_ata_task {
 	struct host_to_dev_fis fis;
 	u8     atapi_packet[16];  /* 0 if not ATAPI task */
 
-	u8     retry_count;	  /* hardware retry, should be > 0 */
-
 	u8     dma_xfer:1;	  /* PIO:0 or DMA:1 */
 	u8     use_ncq:1;
 
-- 
2.31.1

