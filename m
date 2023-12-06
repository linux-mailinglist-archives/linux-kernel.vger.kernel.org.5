Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3009C8064DD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376605AbjLFBx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376635AbjLFBxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:53:54 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8DD1BC;
        Tue,  5 Dec 2023 17:54:00 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B61aBCU014937;
        Wed, 6 Dec 2023 01:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=23hKHmbbALm+t8Psdu5EM4lKkNtNMEctJJNYUfuNo70=;
 b=kQ+i3KlEujnkD8Xzday87jUjAWXQL+2pv0fWK1BcffRzsu6mGMM4eGxrmyHO+sp8J/sY
 AVnfspOdIDh1AYQS+0zgBCgwdPeOijT0qpSmpskxeBigPtvNGhpBjsnKDJzPBEfmNOT6
 3fm1tESv7nVoDbbuaTob7QY4SK6z6oWmhWi5TXI0vVoR3HlmDe6G02JecadQ14wLBgHZ
 iipQdxoYEwYUCc/AQM145Eq+yfIuuP56hgAF1J6ATyP3NpvvHVgoMJ9BtjoriQ1TbVib
 2wfA0USANqklihTGvysj7GRoQP7jPEgY+In59aeBvFdFydmeS2jfRqP6gQRQ6/eBoowG KQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdmbg4aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Dec 2023 01:53:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B608wCa032249;
        Wed, 6 Dec 2023 01:53:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3utan8buxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Dec 2023 01:53:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtjU8JfXx4WCxsUCKeYIBWuoDaiCninOeVNi5gPcv4mvnOAdWHAb3dvXs/0F25WWhxehMfAZ2G9fDuUlRoXO2yp5eF8AbK73VpAGYYp/owBkqr/4fR634IoB9w/BhD/XhuG5KA1wAiVGAtQjWM6MWTyOjZ42/goi3AEihFdDVhbkyMxKHI2eGdcMNmShyAlLr0DhrTnAKP+qPDuyXKVEgl9juqT+S+XEjUC848bMK4q3WwmPIpYQuyoV1af8Gd1U/N2p5+lKAkRFjcRkSlblgHKn2NNgZnyGvf7IUP2BFO9beyuuwdTliRjESyQcbmgcG2nRyV8hBKj0ymiA4hYlHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23hKHmbbALm+t8Psdu5EM4lKkNtNMEctJJNYUfuNo70=;
 b=YtP5VGQpYWCrWazRP/H+plzTTOteZN6ekifsrnnM2lC81BxYUizUjhHcR3XB1IexHLFd7zV9GkcvqPykCK2L4d6ddwDPjInubgQ4y1udpqwuiTeF6tQdhjmhvECRNdcY2BmU3FkAEhpH8Rp0BWjCFrP3otv6Y0ffOrnDzwbHENeeVo4Cvvfay8n3nv4bzeE6Akq3znHWw/jxGVEJMPu0bhBi6x9YNf0ZLwPqjinwiaB7Iv/miGSFyWUgY+bZQsU5nt6juM3UQNb6eK1jmEUPB2/T8KllvR/PgCzsbMJAByXVG7dtb8Bn/mzpmOPVI4FSZ1OgqRwNeBue/W+aWgQZuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23hKHmbbALm+t8Psdu5EM4lKkNtNMEctJJNYUfuNo70=;
 b=Kp1ZudE+SUIxV+kfaXg9Ek+402sf3HWrx+B5I4E6HfvO8N+ir706vbkyfXw94FDXlNfJUGnYpLOPbKC0btlnc30OvYvslD/T+jIbdrusYshpwYcLMbZj5dvceKBwoip7EhDRy58frIzkEJfl1FBZ35gcF/P4JiZJFtXGXD46L30=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY5PR10MB6096.namprd10.prod.outlook.com (2603:10b6:930:37::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Wed, 6 Dec
 2023 01:53:50 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%3]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 01:53:50 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Steffen Maier <maier@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] scsi: zfcp: Replace strlcpy() with strscpy()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11qc0p04d.fsf@ca-mkp.ca.oracle.com>
References: <20231130204056.it.978-kees@kernel.org>
Date:   Tue, 05 Dec 2023 20:53:48 -0500
In-Reply-To: <20231130204056.it.978-kees@kernel.org> (Kees Cook's message of
        "Thu, 30 Nov 2023 12:41:00 -0800")
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:a03:255::22) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CY5PR10MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 34df966b-6130-475a-d718-08dbf5fe3156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zPMdVMG41y7KlDgIWNXahi6qsEgeb6oCJkzsKDiIssDnHRjoCv1IfyOiwT/5M2YNQuHRky/qWw3Y9lPB3+USS/2SPqvSDbxlfzfFEe596UP4dFW6jvdrOLbsF+kPe9RQpgkG5GWLoTkIHglSM+Nncs48pqrP8Q2aDqsljkc+QeIKDdD4bRQGhjnnoDzEMx6hRTNaF94Cjpqrfyphx+aJ/oqzPfcCc09XYmelhz5yPS8uEY+4XBwmEJXK26WLFT8PyMgJZwbiq3M44eYXbOesO7hAD0rch01g36RiqYClGBMZxRO3XbNKNpXO/mJgRhOMbEIXhSRfLgOEiOB8Kz5EbfAF6P84DOgXKfw0+llEp0GhBO8ZGwWlHlwb/Z39fbyrp1pMMrwseIfH/DrcjCEwakOWvjXmzOYjirAX1Ce2i8BdLggGuld9LQoaaQ7F/6x5M+w4CS4tdjzI67vk9dTerAwlqz4PF/gzDk3bejtgeJdw/3wdvcTu3ODjW2fH8U14GK8jcoG7CBbEFCLH6Qp+YOV9XlRChaiojMFcWasKaWFOfkogH2pf9ly9h1N+f29L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6486002)(8936002)(6916009)(4326008)(66556008)(54906003)(66476007)(316002)(66946007)(8676002)(478600001)(7416002)(41300700001)(86362001)(4744005)(2906002)(5660300002)(6506007)(26005)(38100700002)(83380400001)(36916002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8b8LPoksWDVJ7ckCiOhBVJk5FPCXZXgf92+qV/TCNowrB+B7oAbRDjzuGQn0?=
 =?us-ascii?Q?MqK6SvYPxe5Um4Up6pDD2RzoflrG3/w8/ZPP/+SWpoRzM6vQHsAbgVld9sys?=
 =?us-ascii?Q?c1DI/4FLFtNrWpwdiQvq/XrkmVVXNQD5L7fnY8aYE4Qg/4zoYtC3GyJFhGc3?=
 =?us-ascii?Q?z+oxL5v2EGB7JuoZkEj4okmay/4xOUh/JFB1wMEtLqaap6PsBHE4K4o6yu9j?=
 =?us-ascii?Q?M3YieuTZEbCbkruMxk3NSmLObDNxlAqHbu9IlatPmMjlz83Ka4Sp6IJDN0Md?=
 =?us-ascii?Q?zuijSDqbQL7it8SYaWyeJB9YNPR2Z6HJM8G2VzRrk/OPwuUWEHEXslvM8NE9?=
 =?us-ascii?Q?EkzAMvTDbY6mbT9WqhQQJ79oOoY8heFhCvZQDdKgTbQyTQ6+7LXm4wSMIMrc?=
 =?us-ascii?Q?zhfDHB0xu9WHtSxcwYYRvSUS4t3FGzGS+a9K4dYRC6u0bGXkDZLEGkof+hkQ?=
 =?us-ascii?Q?lYXYAtChLfpeVYzXMJmN7DSyRTD/7/yae6rnlooKCjlfyvk0wEtIie5zommB?=
 =?us-ascii?Q?w544xOwronqjvfH+Skmd1I0PFYu9hv8c8Eo7f89RW6o8NSx7q2YjUQyxf0xm?=
 =?us-ascii?Q?PSktHepYcafsg2CYvOS8wJ7T1WZaezOBJwh8ypB87xXaFeaTADwvkKhKTX2d?=
 =?us-ascii?Q?am3LSWFr6CP2r1veqz0RBier1F4sEl32wz1eowp2xNicjhnrrGcQlPMYaVI8?=
 =?us-ascii?Q?Chu4BKIVD20whMZjRLUpfwtrBCag8p9dmAdWSG5z0wJNH2oKgK3bp4UPq0Wq?=
 =?us-ascii?Q?WnWyFpT4IG+EYVEsP4pxmmKDEXke0+x8gYsVdGoHOJ4cERjRAv+ITa6u/tKe?=
 =?us-ascii?Q?rjlL/wnEbyt1UJz0rFoUaia6GNzzJY4HYaSCetdLJJzyEJ1puxJDiWhJaVT5?=
 =?us-ascii?Q?kQ/COjBApBpE8aRoHj6AJP7s9Fz6bxR/gae9HlElR6cCWEvMbKPGQD9raipN?=
 =?us-ascii?Q?igBvSaYLvqWFH42KbtkS9Uj0SL05SxTYGdM6djsJiSi9VAE1idDUUE+FnaW2?=
 =?us-ascii?Q?hKZSRNBeV1fiUEX/Tg7CnvyPnVZEtmiTuSzFmf0RwvQVl4urbbXUKIaKvOvG?=
 =?us-ascii?Q?9nhdy6VfkaHHdqhmiLYO+DHV6HQoEqVWCgXHFaVo9XSkJQ3sNWfvux9bm2pj?=
 =?us-ascii?Q?uv33A4BB8kMpWxeX+8774LkZQZ/RDK+0Rwa7cZUCDl1tqiLGt87ZGb5UHWtn?=
 =?us-ascii?Q?1H+cEphaHFu1pP/A/iMFyYAl2Y4ar5SXRhV+3Q3GyoEYxMCePKA5f9V42xJW?=
 =?us-ascii?Q?7E7ekbaxbQWfFJL3r5GCrxrR8qkibbGj2rQ7X0faPY2Lq0GUYXvXQUF2ApMs?=
 =?us-ascii?Q?CHGqrEUd0aWP4FqPp6LUosknHxFUJ0mOWMdfz/mRIEP1d4cYYC0VV6TG9wCF?=
 =?us-ascii?Q?a5ci8rM+WdpttEOtLAM8dRcQjl+gBjGF0FXqh7iN3f1ZeaR8G24yATzTj4hh?=
 =?us-ascii?Q?sS1Aaf3q1h6q0T2QAXuTxSEQHnG2UzbYUDq5nGwRsvL/cvm9glyXWKzz1cEe?=
 =?us-ascii?Q?vlkdfSasJoan91CysOAuR0pucObLntcTuVB1bEcSPKbc97cECUD42ffInMuH?=
 =?us-ascii?Q?7oplahcSbGGsKickGLdUGczQcmThk/wGg0WN3Rzw09M03STxe/3yGiZ8cBem?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: i0CFhaEYNBztQd1CRTNaCQIeuPI337G7OetcP39wWwMxEEUMILpaF+X5ozAxj5fjx9Jo2XaQpvovJhEyYt0oJly/GCb7nT7gwdzy0BhmQ/gWXDczX6Myw1yLbz3DaM3bcUKT91RTV6frzqLOLoCYec3rrifLLcWfyB7I4WeXnjtAsOttNpslYpFXUmPXu33py9h56XaUhVrC/42CZ4OT4XLb6DEFpqYVUYhUL68jGc2t0/RkU2aNgX5Yw/TGsRNSvyp5yID3XcelBiu3vIcvhUj647VDIAdGyQ1WYa1m+y1omseXqOgMRnpIknyweLvcFF9Yp3WVhCP+E+2hRSAtRaEkGvZTch1BxgP3pmZXp7fVoDUmJfrIEoxsSNgHKSO+8QJt9/Uva+/mhwe6A5eEUKd4j8Iu6gohc8ZWJRQNsccQkWql8Bh8pHzAemcFcA1zZVB81DXPbSWO2Y0vFySSnF02tOdqEV0wdk1Zfttc8vxHm9cluSsni5P1/Z3AsPH2VvkcUoHKP374SPLEYvIlH4xKd7BZyLb0NjtlMWMoSh23uI3LRuj2TrN+XkHMAmrGpELrUesZEXDZZrtHSdSchVpMS3xHRthugGB3at0bpQjFEt4nqA6eHzHKcw7dq9Lo7FqmWrlKqzdCKOvaycfAKCQM++SMClp016dkv1fEScgdAGqzFRkFpnH7kbvV0HIExh99EL51VnB5pPBCiJHkr4P8Z259QDQU3vMLfU067uxIC8ZsmyVtzE8CSRIbgnhJ9jH6WTl8KXTTUWm7sAydWBfcy4gabzdVXPSQ6R76zjonj3zT8IjXJmwOCeOvGRK051I8LtSD703+oh4T7UgIRja/0cJAW9IsD9K2eP5BWUc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34df966b-6130-475a-d718-08dbf5fe3156
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 01:53:50.2647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+8/BiShufQ4AjWPhZV4MUGS+8yefqxQgJB0VzGa0enwaxyp1k7MrTOgD1//sTSvS66/eoMKjj0kFXTf3AL6PPLH+Ak3fAhNlPjd0M0oUlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6096
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_01,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060014
X-Proofpoint-ORIG-GUID: auxKadd7K4NR7815_xHwW4hVXKyH4BIu
X-Proofpoint-GUID: auxKadd7K4NR7815_xHwW4hVXKyH4BIu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kees,

> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead to
> linear read overflows if a source string is not NUL-terminated[1].
> Additionally, it returns the size of the source string, not the
> resulting size of the destination string. In an effort to remove
> strlcpy() completely[2], replace strlcpy() here with strscpy().

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
