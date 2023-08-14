Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F339A77BB45
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjHNOMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjHNOLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:11:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B941733;
        Mon, 14 Aug 2023 07:11:27 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECiLYl019898;
        Mon, 14 Aug 2023 14:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=O89KATuYE0Xz6rGVCvGlsHv2ER42sMTFoKma5SIKQBQ=;
 b=PJGOsStBSPjkgXhQfADj0omnd9yn3J/LSb0z7recMprRU67xlh6U/bT6Az7hAJS9Aed7
 vcGDgwA+YQKeNdPaVxTJuF0avRZ0jjPJKoG0/sg0R6N5avEKNOcukBLt/zReJpSa3K9C
 YpTyLp3h5DgJhXgESAtqgadjtklvtUGKLhZ6A+ux9Vzv0Aqu4Cad5+yreKtYbJSOfRvY
 zQpvyqZzDVy7F5ec/CalkFc4I5zbAhPFeu4uCeWQSHo08tKR4DhDvKlEaLO6m605E3ax
 nyfHfQTAes57Po4YFNmCqzRLIBXkAFU/b9s79XQSzp73/h6X/GVGW0MXasRZItynuISA Kg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se30stpq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 14:11:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EDWinQ027316;
        Mon, 14 Aug 2023 14:11:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1qxjdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 14:11:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWCGEv8PXqPUjqYVkPgwWps20DiiXdF7pP4boU5Myo/Epp1/xGG2T93PxPw5RCrLYQAAN1MnjoQotu1w8jiflDSmnDWGgNEbCD68nFGeO+ekj0TpJzvl2GrNmVdJwmoZPwareTm3i1anbjxI1pYK65swZxx16AAx56E/70xo3EBrfeY3OoNddr5Zetx2FAA1RA9uhNOQak52IoSGUFs7hwuwgRTIY1eppYhJ74dU2JqJS7BnM+oE7ol2ddfO7dhtYNVaRbxRYvs9r0B+2wvPsX10KdP1u88+lcfN5hQCqoNsShhBkGVh2EsZMVUoBVKJgP3Khg1IUoka5lxtKH8i8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O89KATuYE0Xz6rGVCvGlsHv2ER42sMTFoKma5SIKQBQ=;
 b=YlhgaSXiSKufJCcuaMYELo2rVCySd3/X7TDBFdPo5SYyzMT/h3SHi95Hj4EWisEbDv3ErfXa+xIFhH8gNGAxTtG0TsGXQYqz445vImu6rg/fiSxXaPwiadduHfLHr5paOixJZRxw3C0lXD/346DMMdgF/EdagQ5gN8JEKD2H6lsjmuPMEC02+31wabU9q+jetvMGzCrqyImrX5mo3Lf5AGkn4fJdnWJ5Riua5SF7eA3VqBgM08+HaphvYQuXd9HAkEvlL3kwJsWMODNzTJTmN8dU1HuPoBsOKogRx9XiEzsbTa0vV6yCj999frIsn1z2YlA6bdvjgsb7VvxhNMii/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O89KATuYE0Xz6rGVCvGlsHv2ER42sMTFoKma5SIKQBQ=;
 b=LrmR7P/i2Af26rrky1I9Mjfm5em1w7Q+DirUtywLXAFT0yO+I5V4cxk2gd5hVVoqK64JD537DKvNC/T2/lN8FYm4OQkRDmFxHsUwQvmESfbvU3oVsBYvkDpn4oStzaCcoxr942k3K0Qm5kCH2hG7oKPl/MlgR8oF5KACZSh3aBs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6417.namprd10.prod.outlook.com (2603:10b6:303:1e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 14:11:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 14:11:08 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        chenxiang66@hisilicon.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlemoal@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 08/10] scsi: libsas: Delete sas_ata_task.set_affil_pol
Date:   Mon, 14 Aug 2023 14:10:20 +0000
Message-Id: <20230814141022.36875-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230814141022.36875-1-john.g.garry@oracle.com>
References: <20230814141022.36875-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0232.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: a0fdac4f-ca5d-47f7-4898-08db9cd04e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RVea1sYeE9JYi5BQ/JRgGj4ADB90AziF7Vz9TGtDr/KYLa3tItAhB9Ecdd1Ao63tUKh08fQndmpxh4nA2CMWh1Fu6YvSkvmTRigdoEg+flr0L2Q029x3O+BlnJ8FGV6BANoXPmutfs1K0ij8B8djnyTozW2am4YEOKLIJT9E44dZ23EIhuPD2/uZI4lPfaBOSBc7NeIltSY6HOK+tnt08mJQ++dif3K5CCMllWJptdxGeWJhbbRmIHtT8JjAuqScgcqDSJjGfT0JyOx/Xxm5AgYSoG6IUbiSES7zdMLPHpRZkedy3xQxXqRi63yxx21c8X0gPkiZDdyQYe3KsJeRyRVF5x5vR9qS6qc++Vh4kjxDtGlPvMqai/sh5LBQ6R9pWy+4SlkageBwM1s5OZ3Oj09rU7YlKjqHANYMC2R3mYYTu39JjFPO2JcOC4SLEr4+ZCCNpfPWwtf8A9BI8JY2ZFUBVkZOL2Lrpk1BxquoHizL1Gb6fe6iBM44hjnnuoL5erMO9yIzV9JKqeTDuuYFtpz6SRLOkYStKL/TIcLg1VfBAhati54V6JhUgi/8zEEz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(136003)(39860400002)(376002)(1800799006)(186006)(451199021)(38100700002)(36756003)(86362001)(103116003)(6512007)(6506007)(6486002)(6666004)(478600001)(2906002)(1076003)(107886003)(2616005)(26005)(83380400001)(316002)(41300700001)(66946007)(66556008)(66476007)(5660300002)(8676002)(8936002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ChTmqfuIvuO1FH6PObFThDPHnI3B0JGvp/4CSVHkfQB7Uq5doh0G45J8VFw?=
 =?us-ascii?Q?bxKm6on3zTZeKRPLXHEfGYKFgMsM2lAqMtnLJwe9QcwZdrIh6+YtWYkuPE8R?=
 =?us-ascii?Q?TCpG3ryUJdxCMLYGTPcFk2oPbZWwLS+wQWLQR3UGVGeUHhNnWjR2FRIZUlQo?=
 =?us-ascii?Q?Xg0MEQ/3FkFZ4nJydDUA5/9HqAnhPz58UpmJsxxZgBwutDCEEO01ymfaho3E?=
 =?us-ascii?Q?nrGS3IYB8wH+hmL+3Q3WPItbbcNzqy3zdBqwtCAQS+oaMCeys8q0DS+yuaHI?=
 =?us-ascii?Q?u4QMnMBxGqArJNXlTLpwOhbi0Orb4mMpbV+ITuJWtFFXsHyjM2OCX8VQWtNl?=
 =?us-ascii?Q?OBFOUT56J0eyBksEu6IWgJ2kfzAHP94ousytXSG2POMUvtSRBZz5yqCdJDKZ?=
 =?us-ascii?Q?lg9hkzsZLo7vTur3TEegnWbSngAeP2FATWpcS4QSRBfBD0eqZZe4zWu1dbrU?=
 =?us-ascii?Q?IDkHlvMtAlkTGf7xY9ruYcjtzGmEZhDynZutypDQPajKA1Nw369UJXy1fbup?=
 =?us-ascii?Q?rKBdx0t+KB8Q9IOjH/Lo9i+CFZD5txpW+qsMgNZFGJ1YTkdmcxWSLp016R+U?=
 =?us-ascii?Q?MwAiE8+D5Mwj9rdsltZ/aHy3x5yzLcD7ZyRwdOemGRhVvtCHMAp+v2Q6MGgc?=
 =?us-ascii?Q?91MeIqSJHcLfinVEVX5/BWdkWy09IYNVkNoZW34jCTsGAYNT3kO1k22v6yVa?=
 =?us-ascii?Q?CvsEWTdAZvQWDlpJNoNvRpJt060Qstw/6gbvfFPG7FnOQpyAGWoAfO+qtstW?=
 =?us-ascii?Q?E6yOtapG5c+xPQTqeIIt5SgoNKLy3OGsjTLvex2+ocreDW8ZxdVefEiH38jJ?=
 =?us-ascii?Q?rk6Ck046wd3l301FhcClUeYCIQwqZlR71MqOznbNBbD/aCUlgMV4QYP36s+m?=
 =?us-ascii?Q?U4sQCb/kuivF3AisDS81DSGdHDvuCllpau+6ivfbSFgyAvg4uRtBkAVJC/9o?=
 =?us-ascii?Q?IyCGyYStVTPybobUo8Oqk6Bg67HT7HB/Z0lTGPolAb2LzYFeQW3DNbjCIhUo?=
 =?us-ascii?Q?yjnDPQjPPeU3N9TtzrQ2uIS4SKslClnVywGXTjvWi9lw+LmXszL0/J7K7UdP?=
 =?us-ascii?Q?L0PKpoiiiULhLgJPs7yLYvPTHQdboyZBEQiFlHW1cCxA0h/UJQz0OduKYrVD?=
 =?us-ascii?Q?sCmJY+VcwKegVtIs6Paj2fIY4iG2DaVThYPHhye+ZraHJKbXZS7G7Di82IiV?=
 =?us-ascii?Q?bXNOQsYKIMKfVzAtWzjf+LTJ/8rBYJWLMUIcNyfFeglaAHhwQzJG67xPCH4k?=
 =?us-ascii?Q?BIaDaWnBurW3q27KUejKBkK4LY+CFoFmZdr4BggoQMJeGBgwQZyFoZDTuvVr?=
 =?us-ascii?Q?cioVep04zUkIG0Nc1LtmIrJVa3TUjtP5K+76OMgz6LDwCaB1vODAD3Ci+hDz?=
 =?us-ascii?Q?3QKXvgvpfb3xKd1pLLNKph0Af6UmKPBh5AW2fOJo+TNajyroJw2vIrBoHWeh?=
 =?us-ascii?Q?muxnkSpW3LzNwnK6j6PiIFp4R3572he+ig2Lojp+Xtx+ZicbtsK4onG3OYT2?=
 =?us-ascii?Q?/LN1wOIcfiWDJicmEajsibyfSmnS0ZWvsplSuNo64fsbXiooS1qnXePEhG5q?=
 =?us-ascii?Q?ii/sXcV8AXJ+MZs3njhuK+/lj/NX/RyFZKhLZJYsOXvPTIdjuV+48gMBfMqn?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?G8u4gqAR2YRcAq6DeQF20aos1nR6q4k5ESAuvFaA1yDVI49gukE/oBEQPdQp?=
 =?us-ascii?Q?nKcsCxrfQODmNWFM2TOCl4hW602+nSft/hz3u1p2LzTCBUbW9jnnG86FX5pB?=
 =?us-ascii?Q?BTz6tFII7SH+iXY4wzZbwLkQmQLjGixNGFATXCyR2jbg6GMh8USJAD6ewbgh?=
 =?us-ascii?Q?pvGl8NvW2UWAT3j+ov/URV5iGlcX0kkkm+N0yxaNN3v548g7vOy5HOiKa4gY?=
 =?us-ascii?Q?T1viuuYj+yFMy1hTRltpLhbb934bJQbNFhOtX+MMxlfntTnMhhXLGYo7xIDw?=
 =?us-ascii?Q?98OL7xhbQfDy5CjWn0CcgBY2/6l0eK4HbdG439OBeD9Qes6eEGDtaQvOhgnO?=
 =?us-ascii?Q?2Qag2tBo1DVNj9JCcehSbC8GcQ8mPIKq+aFlNuKHRHLvjlgD8WdhOXIArHwN?=
 =?us-ascii?Q?gMtBlN4lX27kUZsJHvlhce4OJ68Rt+/CKZix/ZPDoNvjN+PUMYbqCeO3Aaqb?=
 =?us-ascii?Q?V/E7QJjOfbbWigb8m5kIrJpO+1KAz/JAomAx8V2+mxaOubY6UVO4Nv/zBMKd?=
 =?us-ascii?Q?CIcsrGYfdI9KU9T9t1nVjj+EJhDpfzTL1z7p5/j9FaJR81PZDgNpjk8Aj6Ou?=
 =?us-ascii?Q?hsp/YUW3agDjBBn5g8qDAYu1yReidGRvXghStO6DREbQguxndeV6pUm+FaaS?=
 =?us-ascii?Q?BpQ5QssQwtKwQbDSntJU2Zt7qPkwVKA7R7WBGFH8U6i05rIdf0or1PcAbNTB?=
 =?us-ascii?Q?abQmNhBYsurCgZfTRcsBiuyatIjwf/ID8kA4Tjak+vp8vOBl557/bo5pWEBz?=
 =?us-ascii?Q?5Ii0YAzdr+w76PZUKJszQogu7mg4RI7729LzJPlP2j23nzli+LH31zX8iEuP?=
 =?us-ascii?Q?KVfLYQu3dITcuIZ8dztb4agclJ8RnUAkjctZhLSU5gYT9J4/r/r0W/ohMYon?=
 =?us-ascii?Q?DYMuhb+g5kL/xZgdtqdzPxtztYmtV3t95mdanyk72qXW90jABS0JZwJ4gkvS?=
 =?us-ascii?Q?TAxVUpgVj5+na3YkmXdrsg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0fdac4f-ca5d-47f7-4898-08db9cd04e2f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:11:08.2853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDtk40jcSd5lGxubZ81KqaP4HHAjGPwOz/Ss30Br4wpm5fG61Yg5ZUENiuo9FzN300gxZP3yz6xsFk3JZStmAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6417
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140131
X-Proofpoint-GUID: CIFLY7pnptfGaKeG9XDRX-puzvvtbqtv
X-Proofpoint-ORIG-GUID: CIFLY7pnptfGaKeG9XDRX-puzvvtbqtv
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
driver"), sas_ata_task.set_affil_pol is never set, so delete it and the
reference in asd_build_ata_ascb().

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/aic94xx/aic94xx_task.c | 7 +++----
 include/scsi/libsas.h               | 1 -
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
index f67983e8b262..ca435811c310 100644
--- a/drivers/scsi/aic94xx/aic94xx_task.c
+++ b/drivers/scsi/aic94xx/aic94xx_task.c
@@ -390,11 +390,10 @@ static int asd_build_ata_ascb(struct asd_ascb *ascb, struct sas_task *task,
 
 		scb->ata_task.retry_count = task->ata_task.retry_count;
 
-		flags = 0;
-		if (task->ata_task.set_affil_pol)
-			flags |= SET_AFFIL_POLICY;
 		if (task->ata_task.stp_affil_pol)
-			flags |= STP_AFFIL_POLICY;
+			flags = STP_AFFIL_POLICY;
+		else
+			flags = 0;
 		scb->ata_task.flags = flags;
 	}
 	ascb->tasklet_complete = asd_task_tasklet_complete;
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 5b2e6932c564..3a52094090a1 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -529,7 +529,6 @@ struct sas_ata_task {
 
 	u8     dma_xfer:1;	  /* PIO:0 or DMA:1 */
 	u8     use_ncq:1;
-	u8     set_affil_pol:1;
 	u8     stp_affil_pol:1;
 
 	u8     device_control_reg_update:1;
-- 
2.35.3

