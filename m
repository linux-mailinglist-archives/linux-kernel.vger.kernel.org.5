Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A0E77BB3D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjHNOLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjHNOLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:11:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6348FB;
        Mon, 14 Aug 2023 07:11:13 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECia1v026755;
        Mon, 14 Aug 2023 14:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=3WXkvEQKLOgtMgs1SPXN1oJ7XewkcWl2WWbWZAwWh0I=;
 b=nN2olyAA4F1EEUdddnnCvq1IzGBEd0oti00KOhke+XY+upaoKVAD74TT5w3Kp0+0zBEo
 ay74ZwrBkb4q9x+XxsYar6gvLUFNE5d92iR/hrnvP6aZDqva5ahEImHU5GU5xp24CzPP
 wDC7mzUBe45xoPjvkJxJyKcfgvV/KLFfTUKT+h/vVds6xmbUQGnrDiQHX7+f1+EDySA2
 iAzP98XLLwkOV5N8sXA+jTfVraR9XjX6DNvNKRNEu0IHWcXRZlRSVUL4eku07f4cWAdP
 ItZY1eUKunYh3kvKJ+dB0PX5+r4PFPxtMQxp7QO9xygkZu1RUJQif9azV48F0icsms7r Eg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwjp97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 14:10:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EDPw9B040114;
        Mon, 14 Aug 2023 14:10:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0ppnna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 14:10:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmJSgIPr0dB/BBJXCVgh4acBNC5kCT90AKxPWiweIRlnQJnoc7xgJSsQJrBRoJoviRZDuGST2s4oyx6xRK8W47pObfBRLxqfcnLUhBvH/XF+wtt/U+rr0XisjwX52G7MFFQYt4DVEkqSuTrEn+WzdGuFbFkRhjGsMAR7FoiHsFxzETvvjI+RtH0RXj2FmGjwB1+GEL2pJLRFGzYsrYDXTbnKCrFRjUKEk1xJgmgOAodjoT/cQAOyZbbnG5dHk/KTnAkwHPr0rI8FCM8yCVsyhqSPGZrlOihfBUveHKgijgKWkxcQKlGRTdm5b8gu97+ofq06kbUjKGz+5QVLw9QHdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WXkvEQKLOgtMgs1SPXN1oJ7XewkcWl2WWbWZAwWh0I=;
 b=UYTShILQDSu1advIPHBUP07XpcGXFByuNWSUsC9ei2V6ubQlTLmtxUurpnYCXVVHCzy/f3BupqF50CT1R2myYK/3l8Qx/pgqdFLBoaC8zsSufGCqjQL4AVDd2um4yjvZ2qw/9vde/gMCvgpQl47WAN0+eZ3+UF9GRTMOAd/A6vgHoNo2iMH+AjraJhEuZO6MJu24SribsMO8VrH3l4bRhP6ajvBZU70cpWux/NKfSoLe3IqJbtmayvdtQLzvCUUhKhJCqXBH4rGuhGDTc4OH+Aa/oPimYMmb/iWcPiuVmKpdBKCbLiyXrCTs1sKygUvtaxWETHTcWtSNTs8yBau1kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WXkvEQKLOgtMgs1SPXN1oJ7XewkcWl2WWbWZAwWh0I=;
 b=soucGVQPXaHLpuSOWBDU9PECT6WJBLaXOSHkviRTMxTkUE7QZGq14Ktb38gFSHUX1C4fVnHCv4C+ift/d7QWybyEuOSLkGGiPYpbZd9tA7TK4eDDlUDVDIjenLh4R2AjVTnBd6OJBO6oKHc7JhkKg5kT69I4fc8Hxbo/oFphswk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 14:10:52 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 14:10:51 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        chenxiang66@hisilicon.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlemoal@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 03/10] scsi: libsas: Delete enum sas_phy_type
Date:   Mon, 14 Aug 2023 14:10:15 +0000
Message-Id: <20230814141022.36875-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230814141022.36875-1-john.g.garry@oracle.com>
References: <20230814141022.36875-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0070.namprd07.prod.outlook.com
 (2603:10b6:5:74::47) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 39587792-7c4a-4002-fde6-08db9cd04408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8bXCwlYWT3+yUh/2VP8tWJ9j+1xGfmOGgDYo0ih+xT3tzBqsZANLxaB04hvF/EVmaF8VtebpOl3HHHcP5t4yEkax2HP4i6TJAq4k9gOqN/bh8M2EMMsbJC2A1RhS+8k6brIX3PMmGOGuZLhChBQh29jtWSx7vdPemMExeAZvWmLpFnB5pAGB7lX9AEojWybaI1xWN8MKn1I+QGY3ARt8+dSl81nrbQhLAdJwu+1UwwAyjzDCJYXhPatdzMlbMfiVu1ZlMTix4m5aCSURy4iB5CMQ31ZEqvewZfkCoA3Zdh2VALYZllTVvjT3/NyNwHD8Km3AHB+O1cOySwgGDNxSufcpi2Tg62xo6X/jYgWPFDrMnXeMZ0jLTIQH9CdV7ONfZELLudaNbwZ3Z+uW2oePBQziXDpP7ndRyGYPr9lkIfsLjFX/tnvSqM0YTlKTXxR7IdlXuUv9v08FvtFfthtrmzA22zJs5B+CKjYeorbE25rJw5I320gjueRHZudCQOpCJ83cu7DZIb4Kg2jSoEBpNu9h0owAmJJS9sx6sqtzK3SAkhVHjIhCz+YRrvujGfz3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199021)(1800799006)(186006)(6666004)(6486002)(6506007)(478600001)(103116003)(36756003)(86362001)(83380400001)(6512007)(26005)(107886003)(1076003)(66946007)(2616005)(2906002)(38100700002)(316002)(4326008)(66556008)(66476007)(8676002)(5660300002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RGFa3pq9ws/DJ0hTrnp20HqoG8/bOfqJp5CT9uGl19S2LcQf8vOPoivRJwDT?=
 =?us-ascii?Q?WPhPNyIqk9WeH8zJwE4/xAvKUY47vj2mN2K3K3sQZXKr8UeKXsUOBiEOkiaF?=
 =?us-ascii?Q?XyzMGlFHl+2PNT5uBk7PBfSIgtxF0mF8wVB+M5pQmUveINywXkXjlEfCBMA7?=
 =?us-ascii?Q?AfN3x1iUCYbGf9g3mrXLL+0uHgwOBnR1ZSeXylmYW9v4bHNSliVENA+I7IaV?=
 =?us-ascii?Q?ahflh4WDxt9IcMnXQs5k1FCgtBVidkO2r7cS5OUqbBXa4cGfAiaD2uleTJcV?=
 =?us-ascii?Q?Njkog+CBJVPuMUChqEN03qlQHcucJ4HReWlYoHOQ3bGYOw/ar5UjnkhwsFGw?=
 =?us-ascii?Q?0WCqwV18/5XyDZWo5cUZWfHLEoN0Eu5E1E6gq5Q9q7W4FjeL2cPGlsHZH4DV?=
 =?us-ascii?Q?16aCCNSjFgewz/0Llz7fvc7XYWfg+VA0fMeWp5WORe9G7HwqvHjIck3YXT8K?=
 =?us-ascii?Q?4elwrPSbc5Vz8iOxZwnucEJ3j9P6yF+cd5rk0CvAI3UOUMG9mzdOktpMMWXQ?=
 =?us-ascii?Q?dcbUWgAhxp4FwYyi4Q0Xu7OrDSYBNhF2GnFNVB1CLiVxm/2xKt9wSO434qxU?=
 =?us-ascii?Q?FwTgHVO4V51bHx8iTlhE66oL+ZFqLTJHfUtKC3ONEDYTUNo9DsniZLlRLyrh?=
 =?us-ascii?Q?BpP1q0L63+enaYEC8XMrnpU33dqhnrxYmA2zHhg7wJDB624aPPmCRGIIUTMV?=
 =?us-ascii?Q?7hXZDfa1Zjo+B1ZUcnHJeVML0CyfskzbrLmxR1d3f2AOSVIRDzbvQgT8TU6K?=
 =?us-ascii?Q?3j8szqk6pbBIksBNKPlOf4uqCREbf2bAOdrJrSLUJ9q/eHiAVK32rXDoAkr4?=
 =?us-ascii?Q?XoZQgKCRZAEy6nkyyXnwyeugV1NjtZceYeYNqESO1dkQUt7dzSYqAS+/boht?=
 =?us-ascii?Q?Wt3+I/91AOTMPah75BQkrIj9QqgUI2yaoSlZN4H0RlXAU8/j5LsTlVV9+l7O?=
 =?us-ascii?Q?8dg0ndQKI4ePM9Yv1Pwtjf8pnEslJIoKZXKAF0JGD+y9AQaJiJgIc8GsH4D3?=
 =?us-ascii?Q?WdzH9/4Avwn4oCfT1y6lc6txsHOkKh5JRhCJqfuO5SFO5FdsfQdkW1SeINDJ?=
 =?us-ascii?Q?n2A2xIqbCiuzncQ2D3XupjSP6oty3IJ+09cDbxTwHeTjBnm1zyVos3xZvKdF?=
 =?us-ascii?Q?g40ySPv7GYU8EE8LvLkISNNEJs1F7Se9QhfgApR3FgP/MBL97vtY5S0OJP8q?=
 =?us-ascii?Q?aOS7JHWxPy659JIv2wFbn/hJ0IpJ1TQK+IS8ofmRJUTaZautHbr5b1/bSctb?=
 =?us-ascii?Q?nGmzJ+ZeGVQIpt+4zKT7WCepMXtf6UcHJQAffHpwkB0peWnwmEIfUOkf1Te6?=
 =?us-ascii?Q?Wj4Ug4sOxaUwwkuf8yylk0DyZP1d/3XvLJIu/sc0c9UCmdT3LprqOnX2wa4q?=
 =?us-ascii?Q?WoKAKbXnBuEoIbvoq24EGma/8Fcag+iqVBBO1jmBDZGClwi9cDcYYkGvRuXI?=
 =?us-ascii?Q?JoU+2BA2CEWIqqvobX0itZ09JPMWO6AHYuidBwsJL+5+hA87VHGFLZ3gr/co?=
 =?us-ascii?Q?B/WrOtnXnho7RSFPiXZ+bVKJCEUJCq0vqupaglu1A93GVJCTcAlJqnpWQUIn?=
 =?us-ascii?Q?cCuFg8IK9KfncJJMfT9CHc5KWNZ5f5Ja1ZQHW+kmm8xawLs1JeP4Sbv1xmD3?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?gFFJO2vF3XL9GuCzKtAos1A9K/1YUmoa0Fyp4PVgUZbuy/cFORsRVPhw2otH?=
 =?us-ascii?Q?AUGFffI5uCMIdljxd1GCO3jZBOW8hPYTxivDlQPPdKn687toGb89180V8XZk?=
 =?us-ascii?Q?RkfBM6Nm8YyCDQGr8IyTMnXDpG0iMuUnaMroQ2Ia8h7g5g5wfbRqFqp84ouo?=
 =?us-ascii?Q?TUCcauduyy+OzJAgIvslGQceEiWAqVA6/4anhE9Px6BlxYogZ4UeIJaT5RHp?=
 =?us-ascii?Q?q2Q4A611VZnAD0NlXpv8nq22Zn3vroalAAuIked7FzYwi8nyfZEJ4Ej5QQLb?=
 =?us-ascii?Q?FcslghXW8KLrPuCw4KZn2vEdkVMy4g73fcZes/xQF7Fmyvd1JOZRygy36UQA?=
 =?us-ascii?Q?4l4DbsIu6dr9GX+nswQZRmb1LIYwBo5Tfe4WeUwkncisa0HLSLyi59kaBB6Q?=
 =?us-ascii?Q?xl219BOpjAmohomhFJE2nlQvrnZllFhkFZnpPhXBqAdC8/IO6wQjC9IliHH7?=
 =?us-ascii?Q?uHXm0D/rjHKUZKzGVtcPrf9hbqiOH9GiX6Vlnhr7VNPIvdQbhgzGJi3RxLtE?=
 =?us-ascii?Q?htte1XEtMd2thKKKNDClHFrwMcydakntMdSsJlJ7/X8sBR5+yyAJCYpHSC6z?=
 =?us-ascii?Q?s27lsmD8sJDn30/rWdPuHWRbBGlLZmz3NX5roGbkwSCrT6dGRJuhH31PVubj?=
 =?us-ascii?Q?NI0iEfNd6h0T95S3cUyqJuVK9CXLel7YTW24Lt75XachfOd8cS8W17fNowU/?=
 =?us-ascii?Q?GR2og+6yLsMsnP05gOIYwKT1VyeacEgNbklZQUfD1KFAqjrOrcKa5XO5Ls/J?=
 =?us-ascii?Q?+cooDIJG7G4rBR00g+Xexf7c/p61vwlHE1QFMvH5lvXcVluQ5nYEt5nvfI3I?=
 =?us-ascii?Q?RStBm025j+sfcYTHtMRE4iHqtcZQecTa8F6P+zum0+Lq44noHFcgNBDKicqT?=
 =?us-ascii?Q?Iftkv0daYOjF3r8ViGr1VrONWQF+1/M9i+DGIcFpgTsxTq5hyvWLlw2rzVQA?=
 =?us-ascii?Q?1As7VyN8Fzq5chPXWXelIA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39587792-7c4a-4002-fde6-08db9cd04408
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:10:51.2735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5TDtilFnYWH7pJhzAdMLfUznF0i8n5GqPY84rLy5jqsIwl8hGOtR+TX7PtVaWwFhIKAixjSjPu6jwrruIA2mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140131
X-Proofpoint-ORIG-GUID: Qb71WqwpJLoVFnUzKIamqMw8GpYdyrrR
X-Proofpoint-GUID: Qb71WqwpJLoVFnUzKIamqMw8GpYdyrrR
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enum sas_phy_type is used for asd_sas_phy.type, which is only ever set,
so delete this member and the enum.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/aic94xx/aic94xx_hwi.c    | 1 -
 drivers/scsi/hisi_sas/hisi_sas_main.c | 1 -
 drivers/scsi/isci/phy.c               | 1 -
 drivers/scsi/mvsas/mv_init.c          | 1 -
 drivers/scsi/pm8001/pm8001_init.c     | 1 -
 include/scsi/libsas.h                 | 6 ------
 6 files changed, 11 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_hwi.c b/drivers/scsi/aic94xx/aic94xx_hwi.c
index d8f56e528877..75848de13818 100644
--- a/drivers/scsi/aic94xx/aic94xx_hwi.c
+++ b/drivers/scsi/aic94xx/aic94xx_hwi.c
@@ -74,7 +74,6 @@ static int asd_init_phy(struct asd_phy *phy)
 	sas_phy->enabled = 1;
 	sas_phy->iproto = SAS_PROTOCOL_ALL;
 	sas_phy->tproto = 0;
-	sas_phy->type = PHY_TYPE_PHYSICAL;
 	sas_phy->role = PHY_ROLE_INITIATOR;
 	sas_phy->oob_mode = OOB_NOT_CONNECTED;
 	sas_phy->linkrate = SAS_LINK_RATE_UNKNOWN;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 1172065c1d7d..72dd5e3ad9da 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1020,7 +1020,6 @@ static void hisi_sas_phy_init(struct hisi_hba *hisi_hba, int phy_no)
 	sas_phy->enabled = (phy_no < hisi_hba->n_phy) ? 1 : 0;
 	sas_phy->iproto = SAS_PROTOCOL_ALL;
 	sas_phy->tproto = 0;
-	sas_phy->type = PHY_TYPE_PHYSICAL;
 	sas_phy->role = PHY_ROLE_INITIATOR;
 	sas_phy->oob_mode = OOB_NOT_CONNECTED;
 	sas_phy->linkrate = SAS_LINK_RATE_UNKNOWN;
diff --git a/drivers/scsi/isci/phy.c b/drivers/scsi/isci/phy.c
index ea2e339f5b1a..743a3c64b0da 100644
--- a/drivers/scsi/isci/phy.c
+++ b/drivers/scsi/isci/phy.c
@@ -1406,7 +1406,6 @@ void isci_phy_init(struct isci_phy *iphy, struct isci_host *ihost, int index)
 	iphy->sas_phy.enabled = 1;
 	iphy->sas_phy.iproto = SAS_PROTOCOL_ALL;
 	iphy->sas_phy.tproto = 0;
-	iphy->sas_phy.type = PHY_TYPE_PHYSICAL;
 	iphy->sas_phy.role = PHY_ROLE_INITIATOR;
 	iphy->sas_phy.oob_mode = OOB_NOT_CONNECTED;
 	iphy->sas_phy.linkrate = SAS_LINK_RATE_UNKNOWN;
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 408113bf506d..d5cf563e9094 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -86,7 +86,6 @@ static void mvs_phy_init(struct mvs_info *mvi, int phy_id)
 	sas_phy->enabled = (phy_id < mvi->chip->n_phy) ? 1 : 0;
 	sas_phy->iproto = SAS_PROTOCOL_ALL;
 	sas_phy->tproto = 0;
-	sas_phy->type = PHY_TYPE_PHYSICAL;
 	sas_phy->role = PHY_ROLE_INITIATOR;
 	sas_phy->oob_mode = OOB_NOT_CONNECTED;
 	sas_phy->linkrate = SAS_LINK_RATE_UNKNOWN;
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index e5d794a97b14..0ffde0bcd737 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -164,7 +164,6 @@ static void pm8001_phy_init(struct pm8001_hba_info *pm8001_ha, int phy_id)
 	sas_phy->enabled = (phy_id < pm8001_ha->chip->n_phy) ? 1 : 0;
 	sas_phy->iproto = SAS_PROTOCOL_ALL;
 	sas_phy->tproto = 0;
-	sas_phy->type = PHY_TYPE_PHYSICAL;
 	sas_phy->role = PHY_ROLE_INITIATOR;
 	sas_phy->oob_mode = OOB_NOT_CONNECTED;
 	sas_phy->linkrate = SAS_LINK_RATE_UNKNOWN;
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 3048660ff107..e54bcdc1ecd1 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -29,11 +29,6 @@ enum sas_phy_role {
 	PHY_ROLE_INITIATOR = 0x80,
 };
 
-enum sas_phy_type {
-	PHY_TYPE_PHYSICAL,
-	PHY_TYPE_VIRTUAL
-};
-
 /* The events are mnemonically described in sas_dump.c
  * so when updating/adding events here, please also
  * update the other file too.
@@ -316,7 +311,6 @@ struct asd_sas_phy {
 	enum sas_protocol iproto;
 	enum sas_protocol tproto;
 
-	enum sas_phy_type  type;
 	enum sas_phy_role  role;
 	enum sas_oob_mode  oob_mode;
 	enum sas_linkrate linkrate;
-- 
2.35.3

