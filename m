Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02AC77BB44
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjHNOME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjHNOLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:11:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCD5173F;
        Mon, 14 Aug 2023 07:11:29 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECidfx024708;
        Mon, 14 Aug 2023 14:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=/buDIqr2qKnYA8Rh8knn35deNgWe8nw5dXeXqIyfWuw=;
 b=IWyRTt6iICtSFOdUqHgSQgZAx8+Ioo9HWn9mLQgNbrOXxJKi/G0g5pbfdh0Tbv9XHbAm
 7zVD+f9BP2bdnrHqQx5PdT5bBjkWsa4DRRfxPRP0xli76aYsxSNnVJ3HQMy+hgP108Fm
 HFHWqfSlf/6FvBPDtwC8bvJPz4Mh9cUKUYoU6YyhC0fR0CnEr3wgw3cpta/A5ivTJVzk
 S8CkgnJnk+PngGQxcDWCcwlRKBpoIowwAc4aFJlRoSlESn4wTe3ElzKZJQfSBtFf7Ore
 s9ZBibj94RvghyHMpwkYUWckh5trYUFbZs0GJH40KoS7mV1+oE33x+KQ0lhrCvoE1X1+ Iw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se3142pa7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 14:11:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EDS08I027629;
        Mon, 14 Aug 2023 14:11:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1qxjbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 14:11:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZr71wq+/8THMYbs74ypJ/2HZu/SwdW3hKHY+8/vWhU0JZWnO2qsz+OYoMwBlEdlnvAaqK2CjyCa7yWE30U/H1CVfeQZqMm5cWwVsMWQxGTHN/XO0p4+sDZ7R0O3J8SkkgorjxLu7XYVJ2MMGDkqVl1bPqHMxYquhBrc+K0+Z3GvmUzabKvgGfW4o2FWpIO/jDiPnkfpTYBZEfz5Q+VbpSir/6qHLDxHuk1S7YtwJ8/ddZaCMMqQBc9xv07RTFhTIKX1v8YUIsC4rWA5QEKS22BmCiZtqBYLXfFhXP4JoEYjOqpF2oz+xksCA4MIwTbQzHvICYKoTIxGbFatPSqC1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/buDIqr2qKnYA8Rh8knn35deNgWe8nw5dXeXqIyfWuw=;
 b=Y8p8ShBBfO/MhiAja0qr2ejprC6J723iyJkHTQ/8Z0BW2pzwFWou88Cvwhl85GR7Rjpce2IFj+PX1QzbwGJrLHbbctBq3xC+5dBMnWY6VeNFHbWtKIHJHBgbSaMnJ8CnNmqHWrOH3JSvwAE2tKtBLRQ9k4W4ZVcKa6i8jps/MlrX5AR6Q5f78rKS+QOSkLworB7vMBzMkpKADBNb1jAePXZApA5LcTmDFwOC9j2dheN8jWVvtzdhpBARnLnqidKzPxXRHmoVIeYb0qMrQ/yh+5xfCaIr8Y0IAHkrYxLdToZApn+Xj9QCiznTP0TXuEBPYyMdDkSit17YDyjUWLls/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/buDIqr2qKnYA8Rh8knn35deNgWe8nw5dXeXqIyfWuw=;
 b=ZvYX7ruU5Bah4S9M3Itbp1oDIXNrG/TZocto+phQYUyUWqvNtT0iszQWvwMlU/j4doQcRbkNE+P295nBcIPaDVahRnbJvfSWuQikIApMT/XvNPsroA46aFS2MxxDFhlkPVjqgbvNJjzbVU/lkoaDf5vo7s6Ro++JGMeecZFCcw0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 14:11:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 14:11:06 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        chenxiang66@hisilicon.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlemoal@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 07/10] scsi: libsas: Delete sas_ssp_task.task_prio
Date:   Mon, 14 Aug 2023 14:10:19 +0000
Message-Id: <20230814141022.36875-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230814141022.36875-1-john.g.garry@oracle.com>
References: <20230814141022.36875-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0219.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: b13fc41f-25d8-4cad-241b-08db9cd04d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vrAHTl8pqwKUAAZVxBzDNv6pwj2pWHQ8vt/yZ25cRIyrEnfXNOhS0LnGHnJaL25vpZ+IraDEyrHAoHRhH2c953SAhVbW21pXI8XpwD76rVJUjPYiYKCIGkjnoQfyIjFT4KZC6l7uGq6lvblGcsrM+QWqLUhFbLrp8Menx8xT8BBliW2BW20uAucpUHvueNOn+sq/mdtdXmZZQT3gHGQFEPomfZ+9nekkh310T7+r7I2IJ5e9ESEO0YJuDFh1o2pQr/oBAGVnAKdYxQ+jW7Awun/DkBVymJ57NnibroiYK088eKV1XX5pwjmLpuig1k3So5J51gu4/FwIGTSdGu7jAwep9BUglyxEvj7TpCOSPMEy3SLwRpql6x7uBs6jused4wWNOXc1+fjf9fLtZVKsoRmIEtjL1akx/pIX9EvWQ416U58QZoCS5ja9XCGBL8iVqpl0kG/JHmVt/eZ2ZpuVJ8QTDUDuF53KAdSVK8tBhgUA2KDULkefI9svtZO7P2mVLTa4D+MJ//Gon7cYggPDnwlL30gcy5menGi2W35JCw6czk5eB4KO8qBV5XmyM8q5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199021)(1800799006)(186006)(6666004)(6486002)(6506007)(478600001)(103116003)(36756003)(86362001)(83380400001)(6512007)(26005)(107886003)(1076003)(66946007)(2616005)(2906002)(38100700002)(316002)(4326008)(66556008)(66476007)(8676002)(5660300002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xD3dupzE1089iaN/4ohN2GlDRJdr0Km45ei7QKA3XCRq/1rtxsjCwN/0AW/y?=
 =?us-ascii?Q?zm/ibt6VZ2a9p2fNUG5j0MXv9heScquio2RmECWFlNAFxTIFNWkY7Vn+75z6?=
 =?us-ascii?Q?eo5dZDR7fXzk1emA37wAxf/X83XCluV0MZjfJrdZX0/J/fRfQGHMZlUpGF55?=
 =?us-ascii?Q?iTvX3aud2vpcwxvVWTsvweX7dFYnikjHrOhm7lLfKa0FkOk+2Ik/XUqvcFfG?=
 =?us-ascii?Q?3MZrc/HQntaAlt3jOAZk9ms51My9jo5QAWc1o+NWS5stO6CkeKMM8dRzU7vP?=
 =?us-ascii?Q?qiQ5wvRWkM5yjL3K/vpjwoQXckL+ADaGTpQf+fkq1JJAVuwQZMJYJhssID+c?=
 =?us-ascii?Q?9mI7bOB924Ac9bS1WW2cu7av/T/f06mY0nN3/IIF4htL5zKd4Rc8yrjoHaIa?=
 =?us-ascii?Q?HVDgJ3ftxHTEpqAw9JGXu0vFS2EV8KwO2qoHNh5Rh2+aSVlGei1RbYC2gE0h?=
 =?us-ascii?Q?151mV5hYk7yPoXGZv9f/ZjnmCFkgnl3EvwTDTZR+kLjRHLPe+QMwlqLKbCbR?=
 =?us-ascii?Q?S/HSoMwL2/1gUH4GP6I2U4MYuHIwAT75PJ8OkSELrTJ8bxYkF50dX49Ww07l?=
 =?us-ascii?Q?cLRUcWkaxGALBCEl9hMCl9J0RUYz4BPK7xe64fCPnmgDmNjuk93pdvjCM2ac?=
 =?us-ascii?Q?e1RUUZapwm16JrrzfkKXzZT7oF3QyalOnS11paC3yavylWoC+TXQJDH4qKO6?=
 =?us-ascii?Q?FPbHVe5/OBTnedaF0dKzcUas3JTMz60qODyLT+andGU1t/BPUG50DxEQYXXM?=
 =?us-ascii?Q?erslWzKcusiXPQ9GHQkqXrlt38t0yTd0F23I0+ZAp26G4gsSn72YpJZq455c?=
 =?us-ascii?Q?pzDbtewNTxX2Hz4gXqck2M0LC75g1vYw4ok+xlRJikfUEjKUYFst7WYbJk77?=
 =?us-ascii?Q?LXtNqBmYRtFls+XqVniI7BZH1KTeAwrba3lQGR+6wb1uWLdaiEpTpWCzG4+F?=
 =?us-ascii?Q?vYXx3eIG76f4tZeph96x+1qPd8OQx5Y0Izc3FIgkxXYBi6j7PAda3GEa3twy?=
 =?us-ascii?Q?poqyO4uE6gq6qiLG4fzk51/ZdQkse5DM+MDMkdGlE3wpI6XbfApYg8e8GSTZ?=
 =?us-ascii?Q?2UwBPRtGwK++V6crON2Uo1XJ5s1Yhv+fO1yx/4YZOsD3EG84o/WoDfDryiAF?=
 =?us-ascii?Q?ks+WWmW/gIaKjM/6uVHJx40RqoHLvQYHX3/dlSGZw2bSHwS0/VIWl9/59gjF?=
 =?us-ascii?Q?xdTrc2U5Ritz74ys3XVoAx18Qa9myQAmjYKq8q5lkLdkfWCGNAU6g8OCh5O5?=
 =?us-ascii?Q?BAmhG685TgmjMqK3nIPGwNhKyAbb5m5oFULzPd6E6NsEseentNiSUfuPnWza?=
 =?us-ascii?Q?6aT7Fb0rCnZdqhfyZSAs1YE30wg3LDAZeXk6xSPXrxQj1SROMcIiQRfhFbk4?=
 =?us-ascii?Q?EivBPp32O9mTEe7Zmke1kjZIi+Rh5jnXOKnz2O2PqPiv58fbR/n3+X0xUp4v?=
 =?us-ascii?Q?IJVKPm8KgBk8FYwXEX8RGNZ+f/6PrxmQlhRlj652vG/cYcN0N+OqlfRx6dwW?=
 =?us-ascii?Q?b4nC9RqxDEsbz0JFMQqZG7zKWOXYROZFgbifVCNBw4l4AvHO/euZxhrURfWp?=
 =?us-ascii?Q?4jTg9QioZULrsls6tBVsbiN5awGevLnwGv/C4Pu3t2N+zrmt0yfSsgjQd3Tk?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?SHQW9P4EmpQMEc7oE8viVlvoaE+jEQcQ3d8k0ktdUqYvrW3mrBnXDUAblXiO?=
 =?us-ascii?Q?fdyTPaIBF1kSpnkukKzWRU5I0io2mesWIOpHMrjj1S7IrAia4Sfblk+yZkQB?=
 =?us-ascii?Q?/gzDh60oebES8bk+/7ELqGy2n5zh9iX6wLHA/Lw/RRmSXCffbJFHVFzFwqMH?=
 =?us-ascii?Q?REYP7PP57iRFOz1Qi6LjGua6975caNLwJwU89T0/LvWwt9sPxH22bgCyEqLs?=
 =?us-ascii?Q?vNmF9RUYZY24Blrlw2P1kipVhKZNvJFsdPyPSTyxPVCkJAk1+XZxIgoa2qYd?=
 =?us-ascii?Q?72K/LezThuwYlhen4OQg0zFgbv2y+A1KrlBCN00Ov+yAXNEaEu/aVl/eEumU?=
 =?us-ascii?Q?WiIY+aZP+xHhtX1EtNz5+oH75f2IwURHnPNtu6S4nqKeFvbnKZn2QdJdRGIm?=
 =?us-ascii?Q?xN2dRMjx1fA43RlCykL3bM7ZX8QSRkDASe9/oypI3jJgngzvw5+RmAJr6fWq?=
 =?us-ascii?Q?QV+eVs8OR2KWDbBSc0e3hMi4VKVNlphUe1A0QCJsZgctQDNu4dxez78/F7Gi?=
 =?us-ascii?Q?0Aznd/xhIOzEtqau4ZUY971qVIR36ADOfoJJz0S48JYVsXZOqPcbVdAeFihK?=
 =?us-ascii?Q?0zrFidyWXHXTnvBEVP4ubfs6/tKdxmjjqrRjJEDCk+BgXeYyhRsx9nTzzmHi?=
 =?us-ascii?Q?5JC1GUw82mKHQpRK0Yky4rCWF14nZfy2lslA8hNpUh3yg5W0dOe76r3Bu0OO?=
 =?us-ascii?Q?Is+f7Zfqlm9k7qK+xG4RIEQV0++ZU9OtTySbJZCfSn5oY50L7foht2/Oqxz7?=
 =?us-ascii?Q?yaabGBm1HRTp80DfKqXBlArkLbr4XS1IGS4Yx3deomEr6gMnRtRwi3PKU3Cf?=
 =?us-ascii?Q?UKjIROL4+wQCoU8DNGxEeKwn1VKPf+zoIqMdkadAzIHxTo7pyQS0/WEl1FhT?=
 =?us-ascii?Q?HzU0S2cz0/7q8SvSoFaDsFe5BBW6eNxPb7N+nS0+wxxOELqB/4Fl5MX15Kk0?=
 =?us-ascii?Q?iZ6lnJrmSsbhqctCeYiLKw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13fc41f-25d8-4cad-241b-08db9cd04d3c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:11:06.7703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLx/DcDEW/dhKd2Yb0u+S3rjZhczmKl1IdtpIF4ezqzVn7x0WOEv61wZWk/ASsBR5FCvBfPOpm7O7Ocvt1Z3qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140131
X-Proofpoint-GUID: kFmkKnSXFPh_Os8OkjiySWSFcYijRbGM
X-Proofpoint-ORIG-GUID: kFmkKnSXFPh_Os8OkjiySWSFcYijRbGM
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
driver"), sas_ssp_task.task_prio is never set, so delete it
and any references which depend on it being set (all of them).

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/aic94xx/aic94xx_task.c    | 1 -
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 3 +--
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 3 +--
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 2 +-
 drivers/scsi/isci/request.c            | 1 -
 drivers/scsi/mvsas/mv_sas.c            | 3 +--
 drivers/scsi/pm8001/pm8001_hwi.c       | 1 -
 drivers/scsi/pm8001/pm80xx_hwi.c       | 1 -
 include/scsi/libsas.h                  | 1 -
 9 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
index 1ac4d3afc1a1..f67983e8b262 100644
--- a/drivers/scsi/aic94xx/aic94xx_task.c
+++ b/drivers/scsi/aic94xx/aic94xx_task.c
@@ -485,7 +485,6 @@ static int asd_build_ssp_ascb(struct asd_ascb *ascb, struct sas_task *task,
 	scb->ssp_task.ssp_frame.tptt = cpu_to_be16(0xFFFF);
 
 	memcpy(scb->ssp_task.ssp_cmd.lun, task->ssp_task.LUN, 8);
-	scb->ssp_task.ssp_cmd.efb_prio_attr |= (task->ssp_task.task_prio << 3);
 	scb->ssp_task.ssp_cmd.efb_prio_attr |= (task->ssp_task.task_attr & 7);
 	memcpy(scb->ssp_task.ssp_cmd.cdb, task->ssp_task.cmd->cmnd,
 	       task->ssp_task.cmd->cmd_len);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index d4e3c3a058e0..3c555579f9a1 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1022,8 +1022,7 @@ static void prep_ssp_v1_hw(struct hisi_hba *hisi_hba,
 
 	memcpy(buf_cmd, &task->ssp_task.LUN, 8);
 	if (!tmf) {
-		buf_cmd[9] = task->ssp_task.task_attr |
-				(task->ssp_task.task_prio << 3);
+		buf_cmd[9] = task->ssp_task.task_attr;
 		memcpy(buf_cmd + 12, task->ssp_task.cmd->cmnd,
 				task->ssp_task.cmd->cmd_len);
 	} else {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 404aa7e179cb..73b378837da7 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -1798,8 +1798,7 @@ static void prep_ssp_v2_hw(struct hisi_hba *hisi_hba,
 
 	memcpy(buf_cmd, &task->ssp_task.LUN, 8);
 	if (!tmf) {
-		buf_cmd[9] = task->ssp_task.task_attr |
-				(task->ssp_task.task_prio << 3);
+		buf_cmd[9] = task->ssp_task.task_attr;
 		memcpy(buf_cmd + 12, task->ssp_task.cmd->cmnd,
 				task->ssp_task.cmd->cmd_len);
 	} else {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 813807a24ae1..bbb64ee6afd7 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -1326,7 +1326,7 @@ static void prep_ssp_v3_hw(struct hisi_hba *hisi_hba,
 
 	memcpy(buf_cmd, &task->ssp_task.LUN, 8);
 	if (!tmf) {
-		buf_cmd[9] = ssp_task->task_attr | (ssp_task->task_prio << 3);
+		buf_cmd[9] = ssp_task->task_attr;
 		memcpy(buf_cmd + 12, scsi_cmnd->cmnd, scsi_cmnd->cmd_len);
 	} else {
 		buf_cmd[10] = tmf->tmf;
diff --git a/drivers/scsi/isci/request.c b/drivers/scsi/isci/request.c
index 6370cdbfba08..fdb8dff2e50c 100644
--- a/drivers/scsi/isci/request.c
+++ b/drivers/scsi/isci/request.c
@@ -180,7 +180,6 @@ static void sci_io_request_build_ssp_command_iu(struct isci_request *ireq)
 	cmd_iu->_r_a = 0;
 	cmd_iu->_r_b = 0;
 	cmd_iu->en_fburst = 0; /* unsupported */
-	cmd_iu->task_prio = task->ssp_task.task_prio;
 	cmd_iu->task_attr = task->ssp_task.task_attr;
 	cmd_iu->_r_c = 0;
 
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index 165f46320bd2..1444b1f1c4c8 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -663,8 +663,7 @@ static int mvs_task_prep_ssp(struct mvs_info *mvi,
 	memcpy(buf_cmd, &task->ssp_task.LUN, 8);
 
 	if (ssp_hdr->frame_type != SSP_TASK) {
-		buf_cmd[9] = task->ssp_task.task_attr |
-				(task->ssp_task.task_prio << 3);
+		buf_cmd[9] = task->ssp_task.task_attr;
 		memcpy(buf_cmd + 12, task->ssp_task.cmd->cmnd,
 		       task->ssp_task.cmd->cmd_len);
 	} else{
diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index 18070e0e06d5..35797b56ea0a 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -4053,7 +4053,6 @@ static int pm8001_chip_ssp_io_req(struct pm8001_hba_info *pm8001_ha,
 	ssp_cmd.data_len = cpu_to_le32(task->total_xfer_len);
 	ssp_cmd.device_id = cpu_to_le32(pm8001_dev->device_id);
 	ssp_cmd.tag = cpu_to_le32(tag);
-	ssp_cmd.ssp_iu.efb_prio_attr |= (task->ssp_task.task_prio << 3);
 	ssp_cmd.ssp_iu.efb_prio_attr |= (task->ssp_task.task_attr & 7);
 	memcpy(ssp_cmd.ssp_iu.cdb, task->ssp_task.cmd->cmnd,
 	       task->ssp_task.cmd->cmd_len);
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index ad5a73b86415..1c092ee37bdd 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -4316,7 +4316,6 @@ static int pm80xx_chip_ssp_io_req(struct pm8001_hba_info *pm8001_ha,
 	ssp_cmd.data_len = cpu_to_le32(task->total_xfer_len);
 	ssp_cmd.device_id = cpu_to_le32(pm8001_dev->device_id);
 	ssp_cmd.tag = cpu_to_le32(tag);
-	ssp_cmd.ssp_iu.efb_prio_attr |= (task->ssp_task.task_prio << 3);
 	ssp_cmd.ssp_iu.efb_prio_attr |= (task->ssp_task.task_attr & 7);
 	memcpy(ssp_cmd.ssp_iu.cdb, task->ssp_task.cmd->cmnd,
 		       task->ssp_task.cmd->cmd_len);
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index d77db53cbd8d..5b2e6932c564 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -565,7 +565,6 @@ enum task_attribute {
 struct sas_ssp_task {
 	u8     LUN[8];
 	enum   task_attribute task_attr;
-	u8     task_prio;
 	struct scsi_cmnd *cmd;
 };
 
-- 
2.35.3

