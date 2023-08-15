Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15D377CC20
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236954AbjHOLxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236896AbjHOLww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:52:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F13C9;
        Tue, 15 Aug 2023 04:52:51 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37F4sn8O029299;
        Tue, 15 Aug 2023 11:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=HRtKHmGkbpYpx07JeQ7y9ju/rnssIVtZGASOaKBdnjI=;
 b=aGThKn2zL99jJ7WJnnWT7dXccBXpOu2tBkl46PFMxkdzrrO6/R7iTNNnD0izGGII/vMh
 /Fnffq9RBVpHBSP4LGIkihXCl18ZDPdLH2QBYo2F3lyH3Fq6mwD4gpueRysUlO6/TVuv
 Ta46rAV8tnvqxDJFMc/oIfHO7m2Gx+dZQsGgLPZ7PJS/0SnR6N+fJzhlbQnVNAJqLbhs
 1A88RysMwGdCkznNAUZjvh4idNxVBQ534biMEwJstIIQlB0XY1UF6XE6LEFwNaRfbG3p
 EbJcwk5xsQthEy2g25P4pU9cbQdA4TeIHONuFBP4KUoVeqpjCyFRsQgY1WtoIapqgMAR ng== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yfmg47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 11:52:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37F9BhJw019848;
        Tue, 15 Aug 2023 11:52:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey3v7tfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 11:52:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EveKS6gUcDWGO7QFyvXSEa81Xhiy/1o+6+dogNfsNV4UR88nSEvMvogG8pbMgElVk2eZNobRT4tJjjt/0vHxb6S705c3qsfoSngAuEwGEocIJ1dchDzxbM1lX9L27e58t5bK8VLdU5cJHtjRnCML+oBjyRvQRGuVPWaBTIPEd3kxSe9RWA0w78nyx4b2/dnEX+Otub1fbDWoomQryv+NDMZtBfj+2WdVORIcfTs2VZvZ5DMB2NBHlTA2Gyuc/QUjWSAAO6NlWcjWfnVeZgVrvC/fTlMDIxgkjooh6Doikf7DfNDy6C3u84IWJK1WIvgtp8xOib0RfMKlPoS/SnLRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRtKHmGkbpYpx07JeQ7y9ju/rnssIVtZGASOaKBdnjI=;
 b=eGum5CAYtLeyZkCgA5Ib0hqbGA7POeo7/krCztWzZw2U5j4pouw5gsbPzZWwDBCXzJTKKue0fgvWrPemBKST41svxoUoHjCqIsvz9syBkctRO+pZkVodzxUYdD2zaoSl9cfD3zaTz7LHn2q8HWQWjjbSLtZUbE6LOlZo1r5lFD6QyNUBhMoAHn6tTdF2Eracnd3g2Vg1hI8MPUaC36Fm92QAcHUjmrFv+N6XQN7mGFd8yrOun8F+3r97gUq+6UInsqtKkDjZ8bbuQi2VYh4xL3euCN5MUYipsxEBu9zP+pJypmBuhfAtyE3xtU9aaPliS6eOmUA8/7O177eRZCL1Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRtKHmGkbpYpx07JeQ7y9ju/rnssIVtZGASOaKBdnjI=;
 b=X/AVCw+lBu1VDm1KRzn/dqMdU3smETT9IjR2ktimru4Fu4+JXsBbQzftGXnL1tRX8NY0cMUjdpc4e6c+DP/kJHK3YENN6c7ylCEJBH2wYTR3CPgPD+6pPFv53wB6EE9SBKIDWVygymkSe72JUbjG799sAunR/HBDRddCRZvagTE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4488.namprd10.prod.outlook.com (2603:10b6:510:35::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 11:52:22 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 11:52:22 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        chenxiang66@hisilicon.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, jinpu.wang@cloud.ionos.com, dlemoal@kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 02/10] scsi: libsas: Delete enum sas_class
Date:   Tue, 15 Aug 2023 11:51:48 +0000
Message-Id: <20230815115156.343535-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230815115156.343535-1-john.g.garry@oracle.com>
References: <20230815115156.343535-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0175.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: bb630045-e908-4ecf-1e78-08db9d8615cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LymqsBY9OfV8pArlkhyBozTZetgKSL52Y2IblaAnD5iA3NWqvQwhk3uoa6yKt7mJ4SgYaTPF2XssJeQ7JkdnG6AxPMTZanV34QrgVnUhye0VttC9XaGg46J0GJ1K8yD7J/yJoL/0R5/HJvaahB5POQ97HxVfb3x8a8Z2C/zelsF/d0WsSPU5nY+llpuxYNPWLMH81zmpKiFTVFxkfOnOG2jL3FlPrElTNcHEYSCGt4PTnfXGkXiUzHOBfTddKtxuy4lojRPI45rgGatbly0Mj8cE/fazMXyrhq9uxIbmhl3mP2Dx1TS3BXdXQmyyCT54jCSa17aaL9IdAJBOBQdjFNJaty5AjEHc8dNP3X3oFNtO8lcJMe6l3bacglPHDDp9pL6UWqpvc5Pz4xgvcjDCekJUa79sFmxm7TVtX/a6NlQDmwZFjEhrxQJC7IjU7BhbtMatkTBkJ/AYWpG86kRa5nrX9e5mp7mEIG0LOWXbmiejh3mRWwtlVsYPtfD/07P8/lie6Qt3zk3mA+R4S0HmDnp3iCvQVAGc2DrGSeJz8SFkQQqMdlI9O7Uzr7T2MF95
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230030)(39860400002)(136003)(366004)(346002)(376002)(396003)(1800799009)(186009)(451199023)(6506007)(107886003)(26005)(1076003)(2616005)(6512007)(86362001)(8676002)(478600001)(4326008)(41300700001)(38100700002)(66946007)(316002)(83380400001)(66476007)(5660300002)(103116003)(6486002)(36756003)(8936002)(66556008)(6666004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DSkojoplS6Sy3YzkyWDOgYbwshPV4uKkimQPeeg7ARpNSTRbRCV9FXCrHA66?=
 =?us-ascii?Q?c5QP8EuLsvN6v9N8xR4uBB9HEAljlFrr/6MK05mrrVQPNP67yUTF+8lAk5fy?=
 =?us-ascii?Q?KSAQjTLoFWvdrxVStBqdkSEVs6m53ID6K9+rBBbNx5IpYTp2AvFBUYtg2OzN?=
 =?us-ascii?Q?zS/h7/8NJTxnvoUnLZ0ZXK4q+dzYosvAJQV/IMlXMrDEUJGYjYDVvtutJHYv?=
 =?us-ascii?Q?Jt5smetvGN8mmCQtVm9mkczN3UvhUlkv75EVkboez9nrOghJvz0py7yE3pe3?=
 =?us-ascii?Q?6ltuK+vP78WyF08UG/4Y66zM7cTu4k+p9Uzgv+c0b+dcWWbYdlx9WqZdOZx8?=
 =?us-ascii?Q?sG1PzngMaUFr0WDTkwAyJJ2NWMwXt0Uvhdf+JrNHpiDQQsGF6tpH4P8PWtin?=
 =?us-ascii?Q?stOzLf4+CPLCdyJ/aULPkfF2/R9x03Ghl2yMOJ9d/sT1QiRvdZC3g/nSI4t7?=
 =?us-ascii?Q?T0+D4v5tx+M4NJ7axE31yQGpuMHKGd13WtfZL5HccnYztElaWi0a5sWEqrUA?=
 =?us-ascii?Q?wRs3TB91kYJt76wVXIywT9pv2kI2ceB1lrhQEFga56VqdknH3NYg8LDiMNBe?=
 =?us-ascii?Q?QcvX7U2DKQA0n7U4w+e1s/nt93HjSIzV0ynFP83dH/ryegQ9VUQtC890+w2D?=
 =?us-ascii?Q?h4QdpDq/fHwwtV3gCvoEl/SRxxMsSE2YFWq4sMHRdP0ugslVrD/7lNkiS1Qz?=
 =?us-ascii?Q?cEZBkwjft3DFUYKpd5Qvl/xdL7eX0BO4lvy6RGOSvK4mcvVE8ia/mKS/sZ6Z?=
 =?us-ascii?Q?FDrd34jOzQ9VxGKXMs+9+ciF6IOh/eVXwvrOrgJei4KH7FCyF0orm63jjs3b?=
 =?us-ascii?Q?UnJ/DZZE05McPh7glpQbIqj418A+YKPRdJwbGOrw0fgdUc0NueVfsSJeD+tA?=
 =?us-ascii?Q?6nkscblO4QBtIjnELLEQPLDGEshD/O9Oh9qGohr52DbA7iZYEfuUNeIkZOtx?=
 =?us-ascii?Q?TPbQeufT5V0jOyFAdPrQ43bPdpkf2Ffjk9hAef8SkNIbpxvwcBWDEKEfLE26?=
 =?us-ascii?Q?vLMzFwmHvvlfQb4hVAIbVlMj0IAwDU5/Uc4OGeLfXnoo/+XoQtqaCTO5mBTS?=
 =?us-ascii?Q?+KtBrLFT5AlgFOWdwCihv5Xn3QTsdjlQE/ErZRcZ4+awJ4MiJPH43vFOK2xf?=
 =?us-ascii?Q?P3TetHAMfoT43+sNnr594ny/VPGjjVLfttbMjktd53vTcO4TxeMOTY833oDm?=
 =?us-ascii?Q?6oTzbZy/sLXG5+oLISjIEYVcVjcxfYAXKHdPLa6IMwdQYeoHAdF1il5gAi+o?=
 =?us-ascii?Q?s1W7ymrr+cMi8WXvpg77e/WIMeBuIuMbj9V/932agyFgWr92GjS4O7zbOEJW?=
 =?us-ascii?Q?SkK7O3F0HUO8cSSOm3Zdsg789WvgWOsBwme6kuu6XEdp5680QFGrwwfHSTel?=
 =?us-ascii?Q?/qk46FbL/BdXyGHvKYfJ9FKcaqMh7w5uCYRji07cNyEStv3ug1NvaZhclbIO?=
 =?us-ascii?Q?sMb+Yp3ckh7PthIxZ/OUlLz/JVZLC6BN2sRFi4C6MqmV87ameGY2oiHLoDxt?=
 =?us-ascii?Q?np4yWjd7usug0Gtg2YQOIANQxX6s4d2AsQthDpZiCYsZmxPuZHP2/p1SklHu?=
 =?us-ascii?Q?g0N51Zv1JWxEIMSCwPiejFosIFKicm/itpQHKZYq3Pf9a52TNbQIcUek1STW?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Z3bdg8mRmQsokGZ6/Rztt/8FpzH+XyAYd+p7foJ9JXCxP6ZMBFJqq2zubEA+?=
 =?us-ascii?Q?aKc6ZhNyM9ZK0CE7OS7LXeHktc2CsPFxyqhQBEd6dRZnI3frYuuuQ1hPLqH2?=
 =?us-ascii?Q?8YdaC1SjdamDv5ywAuAzRh1hvao5beeaXyw/+IYKeOzib/KyyoPYA5/fi4ek?=
 =?us-ascii?Q?m7GTOQDNcClwC32E9F8nsZhcEpIOZ5dK1Rvqez1MbsSlLItgMnSHkMDqUOXT?=
 =?us-ascii?Q?QeRPiyCS85CJMweckuPsKhMxHpyLYntpXpnjI5MtqATxztTK/mC7MdKJBYbK?=
 =?us-ascii?Q?9JnpE/2fKJCEUDfltWlXnsIuT5S1glmNqBK+KdXYZbFTFh8YpCxgtPpXqs3z?=
 =?us-ascii?Q?wQTMHgZ2V2klXvJLonwDxmhsDnUBvJfaufTEwpVlGC0d74fnnc59wXj3N5/s?=
 =?us-ascii?Q?OXCK14NAVfELc521+vW1CiS52SUJiv5jE4TXNKusd7XdGvoylowq90phqSyK?=
 =?us-ascii?Q?rn3bkOIgrwEw1ndmKZVg9iJ8KusfEI/jCwq+pmHoT3U2Punsusjp69roAhqE?=
 =?us-ascii?Q?JGhNwWjJz+rkTwEvyfhglEaWZxhmkoSiQVb7OEsbTK2R8zwrB+xX0zqoJQsF?=
 =?us-ascii?Q?myz/oXnRDmX9SU4bVx6tHytiOuz3YJa9MPbJ0lVP4E5COj3lH4jJ7eS9qG63?=
 =?us-ascii?Q?oAqDbpymqSinyenKlX2P3XfEODxzdNR20gM3jF6SiPyrYCOwfPHCyQCyNClY?=
 =?us-ascii?Q?lDO0I276asUAxtBK4ZcVWzVPav5tuWdhmC7PHj2nGK0q0TNVvY+HTIt8f4sP?=
 =?us-ascii?Q?4tmmetCR2qKG6QEyX7OQrmij3ufQ+nRO7rkr64C2M36DMF+MZIu+yx2Lox3W?=
 =?us-ascii?Q?HCZMg94wZcnDlWPSw00ZnJ10LGO1LX00UDFmwr4BLQl9liNim7FpScRTrvAM?=
 =?us-ascii?Q?ZWNmJwHwTZn7JlcuzgiTMfxy/B8oL1+LOGCclVhYxQjAMe3iQe9IPsVXuD3s?=
 =?us-ascii?Q?n52AdTHqwegiXbag5Ir4tA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb630045-e908-4ecf-1e78-08db9d8615cc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 11:52:22.1078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cbd9v4NTWHQ5MRiwkATcyqP5pNb3hnH6fKhFftOYlnt3LpTqf5Dw58hXD+ijPYUXV1yBgQwKrW5SrSvhMXPQQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4488
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_10,2023-08-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150106
X-Proofpoint-ORIG-GUID: vkuzwXMzB9EFt_XunKLNobSQt4Vtf6Y8
X-Proofpoint-GUID: vkuzwXMzB9EFt_XunKLNobSQt4Vtf6Y8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enum sas_class prob would have been useful if function sas_show_class() was
ever implemented, which it wasn't.

enum sas_class is used as asd_sas_port.class and asd_sas_phy.class, which
are only ever set, so delete these members and the enum.

Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/aic94xx/aic94xx_hwi.c    | 1 -
 drivers/scsi/hisi_sas/hisi_sas_main.c | 1 -
 drivers/scsi/isci/phy.c               | 1 -
 drivers/scsi/libsas/sas_internal.h    | 1 -
 drivers/scsi/libsas/sas_port.c        | 2 --
 drivers/scsi/mvsas/mv_init.c          | 1 -
 drivers/scsi/pm8001/pm8001_init.c     | 1 -
 include/scsi/libsas.h                 | 7 -------
 8 files changed, 15 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_hwi.c b/drivers/scsi/aic94xx/aic94xx_hwi.c
index 3dd110143471..d8f56e528877 100644
--- a/drivers/scsi/aic94xx/aic94xx_hwi.c
+++ b/drivers/scsi/aic94xx/aic94xx_hwi.c
@@ -72,7 +72,6 @@ static int asd_init_phy(struct asd_phy *phy)
 	struct asd_sas_phy *sas_phy = &phy->sas_phy;
 
 	sas_phy->enabled = 1;
-	sas_phy->class = SAS;
 	sas_phy->iproto = SAS_PROTOCOL_ALL;
 	sas_phy->tproto = 0;
 	sas_phy->type = PHY_TYPE_PHYSICAL;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 9585f1ed8ae5..1172065c1d7d 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1018,7 +1018,6 @@ static void hisi_sas_phy_init(struct hisi_hba *hisi_hba, int phy_no)
 	phy->minimum_linkrate = SAS_LINK_RATE_1_5_GBPS;
 	phy->maximum_linkrate = hisi_hba->hw->phy_get_max_linkrate();
 	sas_phy->enabled = (phy_no < hisi_hba->n_phy) ? 1 : 0;
-	sas_phy->class = SAS;
 	sas_phy->iproto = SAS_PROTOCOL_ALL;
 	sas_phy->tproto = 0;
 	sas_phy->type = PHY_TYPE_PHYSICAL;
diff --git a/drivers/scsi/isci/phy.c b/drivers/scsi/isci/phy.c
index aa8787343e83..ea2e339f5b1a 100644
--- a/drivers/scsi/isci/phy.c
+++ b/drivers/scsi/isci/phy.c
@@ -1404,7 +1404,6 @@ void isci_phy_init(struct isci_phy *iphy, struct isci_host *ihost, int index)
 	iphy->sas_phy.ha = &ihost->sas_ha;
 	iphy->sas_phy.lldd_phy = iphy;
 	iphy->sas_phy.enabled = 1;
-	iphy->sas_phy.class = SAS;
 	iphy->sas_phy.iproto = SAS_PROTOCOL_ALL;
 	iphy->sas_phy.tproto = 0;
 	iphy->sas_phy.type = PHY_TYPE_PHYSICAL;
diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index 6f593fa69b58..c06ecbcf1254 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -41,7 +41,6 @@ struct sas_phy_data {
 
 void sas_scsi_recover_host(struct Scsi_Host *shost);
 
-int sas_show_class(enum sas_class class, char *buf);
 int sas_show_proto(enum sas_protocol proto, char *buf);
 int sas_show_linkrate(enum sas_linkrate linkrate, char *buf);
 int sas_show_oob_mode(enum sas_oob_mode oob_mode, char *buf);
diff --git a/drivers/scsi/libsas/sas_port.c b/drivers/scsi/libsas/sas_port.c
index 11599c0e3fc3..7893c462169a 100644
--- a/drivers/scsi/libsas/sas_port.c
+++ b/drivers/scsi/libsas/sas_port.c
@@ -83,7 +83,6 @@ static void sas_form_port_add_phy(struct asd_sas_port *port,
 		memcpy(port->sas_addr, phy->sas_addr, SAS_ADDR_SIZE);
 
 	if (*(u64 *)port->attached_sas_addr == 0) {
-		port->class = phy->class;
 		memcpy(port->attached_sas_addr, phy->attached_sas_addr,
 		       SAS_ADDR_SIZE);
 		port->iproto = phy->iproto;
@@ -249,7 +248,6 @@ void sas_deform_port(struct asd_sas_phy *phy, int gone)
 		INIT_LIST_HEAD(&port->phy_list);
 		memset(port->sas_addr, 0, SAS_ADDR_SIZE);
 		memset(port->attached_sas_addr, 0, SAS_ADDR_SIZE);
-		port->class = 0;
 		port->iproto = 0;
 		port->tproto = 0;
 		port->oob_mode = 0;
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index aea70ec308f9..408113bf506d 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -84,7 +84,6 @@ static void mvs_phy_init(struct mvs_info *mvi, int phy_id)
 	phy->port = NULL;
 	timer_setup(&phy->timer, NULL, 0);
 	sas_phy->enabled = (phy_id < mvi->chip->n_phy) ? 1 : 0;
-	sas_phy->class = SAS;
 	sas_phy->iproto = SAS_PROTOCOL_ALL;
 	sas_phy->tproto = 0;
 	sas_phy->type = PHY_TYPE_PHYSICAL;
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 1e0154d08393..e5d794a97b14 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -162,7 +162,6 @@ static void pm8001_phy_init(struct pm8001_hba_info *pm8001_ha, int phy_id)
 	phy->minimum_linkrate = SAS_LINK_RATE_1_5_GBPS;
 	phy->maximum_linkrate = SAS_LINK_RATE_6_0_GBPS;
 	sas_phy->enabled = (phy_id < pm8001_ha->chip->n_phy) ? 1 : 0;
-	sas_phy->class = SAS;
 	sas_phy->iproto = SAS_PROTOCOL_ALL;
 	sas_phy->tproto = 0;
 	sas_phy->type = PHY_TYPE_PHYSICAL;
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index ccaf8f6b1055..3048660ff107 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -23,11 +23,6 @@
 
 struct block_device;
 
-enum sas_class {
-	SAS,
-	EXPANDER
-};
-
 enum sas_phy_role {
 	PHY_ROLE_NONE = 0,
 	PHY_ROLE_TARGET = 0x40,
@@ -258,7 +253,6 @@ struct asd_sas_port {
 /* public: */
 	int id;
 
-	enum sas_class   class;
 	u8               sas_addr[SAS_ADDR_SIZE];
 	u8               attached_sas_addr[SAS_ADDR_SIZE];
 	enum sas_protocol   iproto;
@@ -319,7 +313,6 @@ struct asd_sas_phy {
 	int            enabled;	  /* must be set */
 
 	int            id;	  /* must be set */
-	enum sas_class class;
 	enum sas_protocol iproto;
 	enum sas_protocol tproto;
 
-- 
2.31.1

