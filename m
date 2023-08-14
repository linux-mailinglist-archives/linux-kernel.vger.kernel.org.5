Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5D177BB33
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjHNOLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjHNOLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:11:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F07694;
        Mon, 14 Aug 2023 07:11:11 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECiJmg017448;
        Mon, 14 Aug 2023 14:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=xz2K7S3FbZ5CBBES1zqqQB/T3Y+Jj/BeJJPzHBWM2Nk=;
 b=E+0j5iMNBuzJn0hVeA5Tycr5vRFPS9Q7YIwtqNYzZ4n8saSeSReizMCu+KksxpzE8v2V
 oNnKgcwMMk1/cfPbUhvR49mqQYtd9N5RLdABSJNp6aC4ElHSpOQNZ1lqmgPRMSeV4kNb
 /GzvIsD38q0Sxo0Cgby4+sukawAU6aRflU8q9J2162RjBbrGDBxm+rOnc4hbwE0tJMdX
 Id8WXucHW5yCVyt9bm0AxdflKXI0ae60vbFLKwXj/IQSfDXWOtj52l4j/dg2WUez6Z8Z
 JIL1n99AI4EjDsYM82cHWgbKRIo0VoHge21y1i4J3oYFwo400NnuTROWt7IUwjeELgkT 6A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se61c2kf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 14:10:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EDT0IG000676;
        Mon, 14 Aug 2023 14:10:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0ppnj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 14:10:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yb8MIcdbiyHqCVPnEhMrufLv7TRKG1LAQDiOg07vJ7Htqow2VZxrSfuecARUyy1ukTZmEPUETCMnor2RcqPqV+F6+bA82Lqbwe99hrbVuTMIMrdNBgNEqosmUeIL34k/SPB4Lj9eT27nvbQsn9g1DNTs84sRgL7//iGU59IDfsK8q6qO0Fany2dirfQ+s5GeCw9O1b0xTEgzv0HwihNu6Cp/GPt0/F6V3VloP0zwHN9czbIBPDJYfP1Lzp46ccdDD9Y5VhPIIqLUDIGKEFpRRfN/ODfktJfJyxwYV9UiEWwhBBudVDcnOIeW5RB+TT3hmTtTL58KiDeAro5hnQhjAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xz2K7S3FbZ5CBBES1zqqQB/T3Y+Jj/BeJJPzHBWM2Nk=;
 b=NDOzsEcYfpXjlKNMLAmYbB0gCISUR7R6veJt1+U54H9utNz/k/18Wnho1T9Sz8dcOvJY2heZlm5Go8bSIGOb0MixiIOgUXKMlWRPXJxpuiCAOkUgo1TlGlNc1s1yLnakA4CPqa++ycKuJ0Kw510e2XKettnZAKopI6KzBVBxjn2gWFaKH6Ecj0QhlvZjV8r1uSblRprycVp4jJP07u6s8eQGc4VpTeDzrN/ZVStwv832minVQZlq3VdZjoQBzrXRdmWJ4FJ8OamygES50gXBrNrgPMg7t3YvedMrDI5v4AF5eW0sWo6yP7DYrBzxcknRKJz8kl9r7pcOKhr3Os5X5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xz2K7S3FbZ5CBBES1zqqQB/T3Y+Jj/BeJJPzHBWM2Nk=;
 b=vIGFldVVLg6FoiTdm6nAZUT5v8Bj7GJAgUDq3JneXOQavmr0+jkHNr+0+lT81yOu1ozFulnn8GyQ8ZY/FOAuJs1xCDMfynwt8hRYP5h2zcXA+HcRkiw/6tIaVi2XTSRSpSh+kyNEXI0Wqv6xeDhyBuMD1AN6pq+8nqPfHEkNBII=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 14:10:46 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 14:10:46 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        chenxiang66@hisilicon.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlemoal@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 00/10] libsas: Some tidy-up
Date:   Mon, 14 Aug 2023 14:10:12 +0000
Message-Id: <20230814141022.36875-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR08CA0043.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c639346-f1d3-4a97-f540-08db9cd04112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1AKlZxjB0frEmbs3sD2BZCk8mxohLhxIwQpVgQ7dmCSNRlZ5Or969soD/Mg9jp9mxL3S9aiIMCy+aYsomtC8aQzyiAMdEOrV4moVSE2p2ChNCIhlzjR8jgQz18hLx78U01x5ctC2MVnRlQj2BijW1Bh+THIzSobpWRgNQuGKDv/yfKnNeG8fjIGcxUFbcS6iBOK0xduXTkmjQ65wmiaX66AK7J6UujKzphtOmKSAfVr7Xe0CjZws7S5Mdrp5GMg/0uVyRioCzTpQzSf89OWC576gLUATwLpPxTEg3M/qlSRIMbPX8w7o9io+OL+PUb2zAaXKBc5UTfEUmTHjdftyw+S4d+AIRUqaxgiU22Kr20d7zl9OZWx+bLRNNHR4d0UySxXlXftlJUiMmCHEING2CJ3uLETvl2i2+UDI6qvv+Nl8S53y2Q5Hu+36E0N8FZkxkxZqu5kyaskj464RP0VP4YjjhFj5RRdLbF/w/281rVtA5PBo5XVIWjB5NfynAFmtjbdPxBdB4bXW7nAVh8bumD/hWdKdlKx5LmMGdcIyN2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199021)(1800799006)(186006)(6666004)(966005)(6486002)(6506007)(478600001)(103116003)(36756003)(86362001)(83380400001)(6512007)(26005)(107886003)(1076003)(66946007)(2616005)(2906002)(38100700002)(316002)(4326008)(66556008)(66476007)(8676002)(5660300002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WeuXvIPvjor6HsSpVihOO9lSD1PkqCEUVAPSVQtdfSA/VtT8VhajohSPF/n1?=
 =?us-ascii?Q?Cn/tMRgTkceSL3tR93LchaAEkL3QQRteyqWS4XX5XKmwU9vu2zTtKU8A1DwC?=
 =?us-ascii?Q?ypunkUic2MytN85QyVFCXJFTTMjFuTpfLba/J2blvIf7jwNjwYbPeAcLHJjo?=
 =?us-ascii?Q?H2eYSKVrZMExowxQ+iT9zeDfZRFssAPXpIwvPJ9w1oSPZQnshxeRZVwkn4yq?=
 =?us-ascii?Q?wj7bUZTfLrU2f0dYB3l+/ZdCxXVUlMd9A5tg+xnxUW+xeA4lNXw6qYYQBA1R?=
 =?us-ascii?Q?zNhnYLI67sC7hXNQWg4547dSad14Kfn2uqZUanYeedoN6yuP13vCtJaItWfK?=
 =?us-ascii?Q?uTeFTnQ2F08SXinVQzgNcGLXg17OWP06T9Ihrc29XgkMC7RT5Sj2dSCr9x7X?=
 =?us-ascii?Q?AH9Elb4VuyhFcxGolKnp74JaG7DVtekERkhv4aEmCJC0r0MLAggUIo2Uqwyw?=
 =?us-ascii?Q?0gYp5N+YaYz9zmERfh1Y70Tf3RLkpBM3V3aQMnKa4YU3O58wodaW6vrqvPK7?=
 =?us-ascii?Q?I83BY7szXBjJx5ZbNcZhE9r9PeLDSqYBDhggdfkNsNHSEqo+bfpzA2hUY+Py?=
 =?us-ascii?Q?xRUALuCGFvrJ/kgKcv0Bz7ETnn1nNlwIFEcWwNnN/LeKlc9Ux4jQYc/KPiY5?=
 =?us-ascii?Q?LqGoVqHc3KHlNu7dbanDewTbF8A4iPNPbB2Wy0ovXhZq2TqAHApURfs+MUtJ?=
 =?us-ascii?Q?kVdKG9t5ITVGY2Ozqj9xcnWWYF7yQKfvJWZW6i3zP4uBpW3Iru20m2geZq0/?=
 =?us-ascii?Q?GegJpAuCbQPpNWbtqr7Pn0V2BY5Lbuow7pZhN6VXscOy/cze0wL5k0vEDr3B?=
 =?us-ascii?Q?jp0cUKpBpbHu3f1c5Rfo9ntsgJEW4MTL20izFfkoV4bKeXBoUFvsL0BWyNMP?=
 =?us-ascii?Q?vU6ydiizvB4E6Gp1lZgXaMiC0Q1h1zzhnyPxOkxV+0XhsWKvcs4+TKz1sB97?=
 =?us-ascii?Q?E8Y/r6BC30sIknLAoHSfc6+R7shrg8+Hsl+KtyiUwTvhzJSaYu8bBVhSMGdC?=
 =?us-ascii?Q?4tYf/eZCQxZZybgQe/IutAc2KnjoAGbknrGmv75D73t3xOMaUkm0q0AmmqYl?=
 =?us-ascii?Q?foV64wNpyCkh12XY0Hk0AlZUSOViqxCTcxvvaZfTO0cAnti/yUPi/qwnUu1d?=
 =?us-ascii?Q?K5K38DJaKhHEpaX9bv++hhbZEG4iVppFqzsjMBBh7tBtNMhOsFV580K9k3qD?=
 =?us-ascii?Q?YhJapDkAOT4C1+61yEk8wETD9tpOF3m6MQS2zWcnhoGm9DiGR7Kx6FoHTatf?=
 =?us-ascii?Q?Y/xdzsNBgW/UvEMeJMoAE9a7H4CsytUY3wLktSRdWesFKXb8nkh6ECHGDcOu?=
 =?us-ascii?Q?ZYZB8DQDQQJKZ54Sy9azYQRphmY0tJ7rXXgcRsgb8uLCu3/EElQvTdAumYSP?=
 =?us-ascii?Q?4Dx+zLDEKZ/s9pMdK61ehaOR89zUJdFpspRrRz7e7HCgmBqyo+XxKt/I2U/Y?=
 =?us-ascii?Q?k6G4wWaMqclQL3JLadURtfeXq9GYnK0EBMonV9VyUkJnYWL52G7KDFkFupau?=
 =?us-ascii?Q?fDGykYFChl6RW8ciA4j8MS5eDc93zzupkVLW+Y4b6tH6y5NM3QStESM6NKTw?=
 =?us-ascii?Q?FV5RgDbaylXbFB6hQluXI2Nrv9gPKWIdZcCCogY/u4+dRRzFo6DJgPDI3K36?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?6oR2VgRgVts7jjs7IisA0Wog53pjgMnxQjqFBFW0KGp5J50I0i8TPoTZOExh?=
 =?us-ascii?Q?P1wfQDy452Ee0XLrStX8CsAGGkSAcy6NU7xuoRIP3QkS7wrV1eyBjgGr4d4W?=
 =?us-ascii?Q?xCC7xaukqBiKoC/ccamt7tQK+AdH1hcwg8glonAzy/jcNDWCkc0KOyW1hZDI?=
 =?us-ascii?Q?n/wp5vtnOiUbLgjLxSbtMy18XbPWnIPd1vlJCUqKfiS+50Y25mL8m69Adi47?=
 =?us-ascii?Q?1xX9y9o07mHmrIvLPN3iIkHLVToqZklI/vMv6OvhrCoKeL1eLccRvwMsiS53?=
 =?us-ascii?Q?x+pZmaPpLNHasD1ufFT6kBJFowExYGmqWIGelA8ZEHsG9vLmjCFweOzE1mWz?=
 =?us-ascii?Q?/XszpLDS4LWKlnJsVNnpRvgyB+CSxvA5JCzl5vG/QXEFnlSsozZfU6V27GQJ?=
 =?us-ascii?Q?lHEyCIjXKOTuouNOMVBTruKIvYUSwLY+lgp+Y2JdS6jUiskwLpxl0iXg8fhl?=
 =?us-ascii?Q?/u5ZqpaSiBj9kKgrZ4DCMaEe+9lPS08m4MDdX0CLTs0VZs+mMofG5OlpFrKW?=
 =?us-ascii?Q?EXZoasXkuEpXaaJZDu5M/pYKJuvC+DCYmh3kioqU50EJeeRVVNQUUM+KXdUU?=
 =?us-ascii?Q?Mni6CAR+tHPtirPXC+yZ3a6PrA8RXGjvXSik8Uj/Xs7WznRAfi3/cStX/ais?=
 =?us-ascii?Q?V4EFWm6uekXNVOi4dZKIKZkCqIlEpRM6A7/yT/GApmqjEBslWt8JSnruYlCn?=
 =?us-ascii?Q?lY4TnaFDzpTW/Moo7P+ioTXZ2seOzNZYtWk+nEm4VposzQ+l5gjA2DoU+6fh?=
 =?us-ascii?Q?+VQ+j4Fh78Z9ocEqTm1csUqsL5Ay35tiDjiueJIqMFFzM2rvEXR1XxiTQnmm?=
 =?us-ascii?Q?6NvkGi5fWMXpxdV+wlbU9RQmKKtLrnyfrcaHwvHQpsKnQM1ZATlcMWuWAUcQ?=
 =?us-ascii?Q?eyhQUwg0OkJWf53f6qTJJhcHUHORGZybirhO8iFl1ghZ08iovnBxkJFSC1b7?=
 =?us-ascii?Q?KsCKkphVlJFJXaY5RNHCXw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c639346-f1d3-4a97-f540-08db9cd04112
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:10:46.2726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dc8av4/043pueX9oDMzMLiH6bUmZFtBUkzAqrKGrN1Q+sr1wkZkQsuc+r8Ag/AMkOUyGRlfc0VGC1zWI41nBlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140131
X-Proofpoint-GUID: OlCkq3XynY0M-7jNdiQx4GjdX1orUN1I
X-Proofpoint-ORIG-GUID: OlCkq3XynY0M-7jNdiQx4GjdX1orUN1I
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series tidies-up libsas a bit, including:
- delete structure(s) with only one member
- delete structure members which are only ever set
- delete structure members which are never set and code which relies on
  that member being set
  
This conflicts with the following series:
https://lore.kernel.org/linux-scsi/20230809132249.37948-1-yuehaibing@huawei.com/

Any conflict should be trivial to resolve.

Based on mkp-scsi staging at a18e81d17a7e ("scsi: ufs: ufs-pci: Add support for QEMU")

This series is compile tested only.

John Garry (10):
  scsi: libsas: Delete sas_ha_struct.lldd_module
  scsi: libsas: Delete enum sas_class
  scsi: libsas: Delete enum sas_phy_type
  scsi: libsas: Delete struct scsi_core
  scsi: libsas: Delete sas_ssp_task.retry_count
  scsi: libsas: Delete sas_ssp_task.enable_first_burst
  scsi: libsas: Delete sas_ssp_task.task_prio
  scsi: libsas: Delete sas_ata_task.set_affil_pol
  scsi: libsas: Delete sas_ata_task.stp_affil_pol
  scsi: libsas: Delete sas_ata_task.retry_count

 drivers/scsi/aic94xx/aic94xx_hwi.c     |  4 +---
 drivers/scsi/aic94xx/aic94xx_init.c    |  7 +++----
 drivers/scsi/aic94xx/aic94xx_task.c    | 12 ++---------
 drivers/scsi/hisi_sas/hisi_sas_main.c  |  9 +++-----
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  9 ++------
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  3 +--
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  9 ++++----
 drivers/scsi/isci/host.h               |  2 +-
 drivers/scsi/isci/init.c               |  5 ++---
 drivers/scsi/isci/phy.c                |  2 --
 drivers/scsi/isci/request.c            |  1 -
 drivers/scsi/libsas/sas_ata.c          |  9 ++++----
 drivers/scsi/libsas/sas_discover.c     |  8 +++----
 drivers/scsi/libsas/sas_expander.c     |  2 +-
 drivers/scsi/libsas/sas_host_smp.c     |  4 ++--
 drivers/scsi/libsas/sas_init.c         | 16 +++++++-------
 drivers/scsi/libsas/sas_internal.h     |  1 -
 drivers/scsi/libsas/sas_phy.c          |  8 +++----
 drivers/scsi/libsas/sas_port.c         |  8 +++----
 drivers/scsi/libsas/sas_scsi_host.c    | 15 +++++++------
 drivers/scsi/mvsas/mv_init.c           |  7 ++-----
 drivers/scsi/mvsas/mv_sas.c            |  9 ++------
 drivers/scsi/pm8001/pm8001_hwi.c       |  3 ---
 drivers/scsi/pm8001/pm8001_init.c      |  5 +----
 drivers/scsi/pm8001/pm80xx_hwi.c       |  3 ---
 include/scsi/libsas.h                  | 29 +-------------------------
 26 files changed, 58 insertions(+), 132 deletions(-)

-- 
2.35.3

