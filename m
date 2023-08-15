Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE05377CC1D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbjHOLx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbjHOLwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:52:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AFB10CF;
        Tue, 15 Aug 2023 04:52:49 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FBGvtp021641;
        Tue, 15 Aug 2023 11:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=9rkNVAXQ9TIaoMIXM6CLKENhq80E9mKmUm/e3qP47wE=;
 b=g3hNsGy1q9/zxh92Yfpp5IFWH40SRZ+L03axCUhi3P+1BS83NIVFIGoTuhmhIfDzqG7C
 hIXFQCh9HP93HUdZ57n8+VF4jefYs5Lw0A7Ym+HVto89PYIMj8Nc/CIcWSG0TYtqmzZc
 Uuq6nlgrUv08QIv2JXewlivwUkS2P/uvJOqdnOXnXvq5DtFxMwIR2k9LuRgBgOzJhLws
 LdzUo+RCeHju8NppDMbpRVZEsiEXoXS8oeCdP1Z8NyyczJd5qyENIRZSwr6zwCxWG7V+
 fA+bCu5qkvm+UeUC59vzNz+xcOlx1TgIiZc1XvhRKsSUszbpNnyVcWW5rRp9XS3oxEgc /w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yfmg4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 11:52:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37F8kk5F003975;
        Tue, 15 Aug 2023 11:52:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sexyhr8ga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 11:52:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmjNcP64hgTOy1QoNupZ0eF4n4HWHxOk/CdKvipIWcjIqKofaFCR6SNbaxhPHG6pkIFATrsO63dDpfuwdb6UDXWDXGoX809fBGGTsz1SYMjSy/Q+OD4RxO4Z3AA9DkqrlSXdMja8rTY3rmR7+pxITd1RndiSMzlSGGq0EKzdrOUUcjq31tIwaZgqxnP7ckijXN9lOmITI3ymb6vzNv9ySajSircMMJbD2Ctmggpy7MpSE7WicWZoid99W6w9QkdEns5rAqwyVJmErZwE3LHv8heDfetheBg0X3GZKZ6xAWiAp77AMyj/ez+RfODL0yZ58DyG6lQ+hk7ZHx2rwmMuIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rkNVAXQ9TIaoMIXM6CLKENhq80E9mKmUm/e3qP47wE=;
 b=VlCIrtKqBeADFtu1gxeACs9KUCLgaiRpUna4sh6GlnRUlCuKt4FUcORdfoNpZ6wJZmZQ+AIPf+nRmjPOSqrQJtYCF/XspcnQ7VM1WjWkgDCZyDC2aK444W9OeFDgv5PrYXi9wUgukkqyggQ6nKeAvGVLUWgY53Mvl7dpjs0lJlzo/HUHgvxF3BS9+usVBMmQ5SnA6Kl8QXK3eRDWiZRg0G2u7qtsTT/y5gELVW99SfwtQ9+JqUbzp53xB/4xduMnIdbHJAA59OzjFu/cQLN/iP5VWedOy5FJrqKk3sTg4qSxGZf1j9/IdpVR98tALSwQDwi/RfZNA6M34GyFiiXUrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rkNVAXQ9TIaoMIXM6CLKENhq80E9mKmUm/e3qP47wE=;
 b=NMWlbDACfqW7auez4gqUusvQw8BRr6sph+eWMILnT3SLR8m5yV5INStAUHMmA+6ah79+BPMOlve5G3Vqcex3QYXsCC7/p8QoVkrMCcM843eNFtUUVjQuOJYPOXDxCf8/H+3WHpyaXeP+YO65yvBzPxQ3jckOxT+k9smEeovnoUs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6710.namprd10.prod.outlook.com (2603:10b6:208:419::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 11:52:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 11:52:33 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        chenxiang66@hisilicon.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, jinpu.wang@cloud.ionos.com, dlemoal@kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 09/10] scsi: libsas: Delete sas_ata_task.stp_affil_pol
Date:   Tue, 15 Aug 2023 11:51:55 +0000
Message-Id: <20230815115156.343535-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230815115156.343535-1-john.g.garry@oracle.com>
References: <20230815115156.343535-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:805:de::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: 665d3988-d730-4c03-1586-08db9d861ccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PsqyQRz90p/BNOiHXxd/RHFw49Pgi587q3Rlkyp/MK2zvosKiDC+qw5Va8jKLDCQipcgFHcJYyMpgBqgoYTBY+1F9cDyxQM1r0aKWWrc/DXkqyNWTibi+L5fKg6xhfQ4gNDuctgDf6zir/BMSisSQ0WKSZCp9euPF9owbkq/+5XSGjxXpI5II0OdvPQPXr6lj6ewyCN+A9Ydk43fPte55rWb175QfASokYXP/IBijmpOTXIGbcAI8qJQsXlBBSfN4QeJXTz4+JoTZZf9tKGVehoODelVzW4H70Tc/7/rn9n5RXNpo/Q2gEVJ4skmXwdRaR5EStaWEyTpvklARNp3duu7pu/d/KGziar+TXjwaJpomTxIVCYHEggGPWbEUU/zwQ5y9pJ1ztFPeQJ+0mJVuyhClGyeFF+HuSxs0nvUGyzDKx9Po2PWhTxQGcLlfPEEB84K+g3LQtATX9gDNMFw4EuPx+FxbRPWcb07pc+f74E1NpBAMYIJ8iuTaYVwJuxaAQJzMCiV2taZG/QPsfKHMn9jCWmQfmG22ZD5djLP5y2uYyaJ+sJsX09nHuQOJaxM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230030)(366004)(346002)(396003)(376002)(39860400002)(136003)(1800799009)(186009)(451199023)(38100700002)(41300700001)(107886003)(6512007)(2616005)(5660300002)(103116003)(2906002)(36756003)(4326008)(316002)(66946007)(66476007)(6666004)(83380400001)(478600001)(8936002)(66556008)(26005)(1076003)(86362001)(8676002)(6486002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O9YhOGmUil9XeBR4cDj+UNXJW5AHrrX35HhT7MutOUHOgfLqJTxNnIEVPBx1?=
 =?us-ascii?Q?Yehg/D3VmIYCVUixBEzAZwP0HrCtNJWvScbbzINyWl04II5E2ODhVOo2ID/V?=
 =?us-ascii?Q?mSSt6nVcCCm/MwaU0dkNoLj8TZ+DqfmHklNYR3cH/Yk+jJjdOrga3tRIo9bX?=
 =?us-ascii?Q?0UcKGjGU9thhl3OgHdtyvPamtpX7YP2U2s7btQQHNYGjJH4Jq4xvTJkLca7/?=
 =?us-ascii?Q?sQQwTeU6jlkfHvbhvhZBfbbdDDO/bveI22Y47/qeXYWx22Xeux6DxMZApDG7?=
 =?us-ascii?Q?D9Mzwy9ndV3Nsf9S6AzYhIrfQcHaNiHRtL/ti3Eht0VJsH5emd74sjnPurfe?=
 =?us-ascii?Q?E1dN0o8vWcFT6MKRfT9ydB4hMN/IR4hQ4qHDT7E/aIW8OgIUt13xRyXQ6dfM?=
 =?us-ascii?Q?KgQlzNqXSDrPAInujJo0kO6LdumP8vtYacs2b4B4veTi3eK2wUr3fZeZWf1e?=
 =?us-ascii?Q?nKc6cdnDaTsQ/dVFLkCK5ABD42zeBjB0YObjlfLum9uNmdtsO+JIZU9v0HUD?=
 =?us-ascii?Q?EjLrGz0qwvwfWZLdDpcmfgooMgV28ArCQxCe4ZqOWuzn1jePaF/t2J8BI46h?=
 =?us-ascii?Q?Za5Ha7h6j86mILVB45WIoiMUUfyUp/3Gv3u9oNN8QDSU6/QdEMqdleKzl8Kd?=
 =?us-ascii?Q?N4yV5AgV0ArOvan5PwE5ldxnWRkQd3q7MMoGtcIgoFeEz7h8fo0VFXenxaTF?=
 =?us-ascii?Q?62o6NVdOHdF6sNwrX3ZSjrvJz3bl6bmmNaZ70qqNI/sik+Y6kZcLWLXwKQ+q?=
 =?us-ascii?Q?l6Lcq72t7yPpAYTi8WUGxRcA2J2F26vgKrPH9mKOvY+OZ2ielMod5Xt6oP0a?=
 =?us-ascii?Q?S7b+RqQiX7IIIbe56sv/5zoiyo3QDx7qG3V65FW3xol8Ev6cnr6Va8D+37c3?=
 =?us-ascii?Q?p7I46IUdcIk1/wgk5c14CpjA87JxMgklD4TVB3V180aDxXBZfVERbBpQ+Uah?=
 =?us-ascii?Q?N0rtRsBwGkUZoRsoT5fnXU9HVNxBMu56RVvSTAS+XqrFAbMB7RycdlCTpVbK?=
 =?us-ascii?Q?jP4OStR0UOxuMlr1Wrp5y4fRaiKcrn6StycnrVn4wqx518AsBBBIoRXRw9Pd?=
 =?us-ascii?Q?kFf6QtZWNKf/S9sAzZ8loIB52Pla5O54j2cWZl7Pd0WOH4QEME4WPg6hJXwi?=
 =?us-ascii?Q?6FiT77F8NjjUcXi4ZloQz9IcP7/E/AO6Fy8sGy7v4mUkQT/vpnHVsRhlffL/?=
 =?us-ascii?Q?MgdlRckL1HmTFNKruo+fGd6Y6JbQvMYqyjB2TlHpeQ0uUjgPcMTji7oPR137?=
 =?us-ascii?Q?hfbEfYB7KLWjVUiDdFlHl7OI5u+yvUXC2i+4SHW/2KfGtjSLlfdmXQDgpJy6?=
 =?us-ascii?Q?QPmYd7zYa3esddJWlPKj1doERqX7p/Eyz2V4W3ANA5ERwlae8GVohO7FIqXk?=
 =?us-ascii?Q?ReU+7GZRc1jZWGWmfrE3vWjeMY+/6ChHsHiPtrFYLaPCtOxB6OKItbHnB/XN?=
 =?us-ascii?Q?/X7TkDv5ACrxc6Z6FOQNuZgBTUX291RYccKmuIbM0OAdppMLEw23YOEQI8eF?=
 =?us-ascii?Q?JvKrORXEyoZJWj6MFfy8wAUVmhGYW0Gg5phpJUgmiKvNHmgYBJLjZKXRVa4b?=
 =?us-ascii?Q?5TKCEUAL3Lg2kTh5XIksfZm7DoDLihQUAtamo2jZO7PlZ/CHwf55D/uMmzwT?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?pcY/+O7sLlvVmGXimFV6Gq+ZIHG6Y9XZ/R8N/6COROwd8XTT2jMLm5wS6t74?=
 =?us-ascii?Q?HeSnJNsJpqtaLZb4be5I3eE8jnrnpuEGYqeziz1Wt4HzBncx36roIMGjTGtK?=
 =?us-ascii?Q?XaFs5AL/EaQdZ9qFdrkDo5g9CbYUYwsZZ5nN0Bl4KXqgbFfdG6xpc/0T5lFa?=
 =?us-ascii?Q?2VwU1Dg6ky6ymyt9KTNpDEJ89kIyjk8ZFr1WGJ+kfPZu5FZJuHr7seGREvXf?=
 =?us-ascii?Q?ob9KVLUjYVilIAG8hmmX/rH+YWjwXa4aQwW6vFFJMuJ5wHCUjhWeh9O6Xg7U?=
 =?us-ascii?Q?aKupKmLfOhKnSKW3zvaGTFckXdUjGRvWLhpWAxpXIpN3UaI4C5jejox7geru?=
 =?us-ascii?Q?WlrA+zEBLmPBqGw2iDyA+aK/5cru93I8vA9uEQDsDy8Xf/wDsOa5Ib8keK7K?=
 =?us-ascii?Q?eqZJuuUDm6m6qzlgmcYlGB4LNWo6EwaiFivBSXqJ3aL1mxQy90Nkat4VSXFR?=
 =?us-ascii?Q?RcUbU6RYfex6L6M7MsY/W4acxQuJzIqKEv0x46Z357NMBDbVA1iStq+iIFbM?=
 =?us-ascii?Q?m1jLQ/ur8JChdv87raykbfyQ4MZx5KCNqiiB0Au3jMubZ77thJCP3ip626R4?=
 =?us-ascii?Q?HMTGQDpujHBa/8Zp99pw2cdwJVxLUwUBax94Uki7W45pOgbH9YRHv6bBsHwx?=
 =?us-ascii?Q?CgL+4ys3/ilP2fc+oRhuq4Vqd+W1bVuiWyUkan9baYmBaMhkDWKuUzniprp+?=
 =?us-ascii?Q?kToR15cgHgtLl3eBJhGR5qNizhh7dj5fgVCCFBbnSURpK4OvZPA4fHOFqyeq?=
 =?us-ascii?Q?6c7b0y8i4pilCHGyQ7k/3dn3LXYv27pIu/2G3R65xlZIac7CVuXp8xeWkY3F?=
 =?us-ascii?Q?rykNhuw8SPPsRM5w651uxB/8drvaPZZZb2pqXiTkGYQZcNTZ4Mu3kvdrdA8K?=
 =?us-ascii?Q?t64j+N3iCIhSMfZ4m9s9V1MRAHzu0WQkqdlGglESnkFQf49fR1FtCEqvDJ0d?=
 =?us-ascii?Q?1CcqA82prgUh6mGWsC2Ciw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 665d3988-d730-4c03-1586-08db9d861ccf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 11:52:33.8603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORYvaOT62t5ivZFbiIJSY2MKDsxPsn5jls2Z9UWvmbsEDL6JcdsGzO7VR6ep96j4SvH4tOINlJs2nVvsz02iXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_10,2023-08-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150106
X-Proofpoint-ORIG-GUID: H1qH4yevsR_bYY6phDYL2JCcaNx6IQUF
X-Proofpoint-GUID: H1qH4yevsR_bYY6phDYL2JCcaNx6IQUF
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
driver"), sas_ata_task.stp_affil_pol is never set, so delete it and the
reference in asd_build_ata_ascb().

Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/aic94xx/aic94xx_task.c | 6 +-----
 include/scsi/libsas.h               | 1 -
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
index ca435811c310..21b69e592664 100644
--- a/drivers/scsi/aic94xx/aic94xx_task.c
+++ b/drivers/scsi/aic94xx/aic94xx_task.c
@@ -390,11 +390,7 @@ static int asd_build_ata_ascb(struct asd_ascb *ascb, struct sas_task *task,
 
 		scb->ata_task.retry_count = task->ata_task.retry_count;
 
-		if (task->ata_task.stp_affil_pol)
-			flags = STP_AFFIL_POLICY;
-		else
-			flags = 0;
-		scb->ata_task.flags = flags;
+		scb->ata_task.flags = 0;
 	}
 	ascb->tasklet_complete = asd_task_tasklet_complete;
 
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 3a52094090a1..a65c16643315 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -529,7 +529,6 @@ struct sas_ata_task {
 
 	u8     dma_xfer:1;	  /* PIO:0 or DMA:1 */
 	u8     use_ncq:1;
-	u8     stp_affil_pol:1;
 
 	u8     device_control_reg_update:1;
 
-- 
2.31.1

