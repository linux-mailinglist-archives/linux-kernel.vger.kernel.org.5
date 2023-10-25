Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AA87D5FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 04:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjJYCbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 22:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjJYCbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 22:31:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31751B0;
        Tue, 24 Oct 2023 19:31:44 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OLUSKg017506;
        Wed, 25 Oct 2023 02:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=M0348xx4p11NtqbP9B5tWm/RUhNh36Z1tyYGK+KC8WQ=;
 b=jpx71zbY1G1KVTnIGxTICugn15+MEjh4wmQKCtc2cRjSYJYs6g3bFNIO5aLEdpK8UJPD
 iBJ+X4Qnz9zcI/STV8Kt4hjugqw1z2GsI7r2+DT/f+m+Co4K3cMKoq+usm1u4TXOugSS
 ZRjoE59rY/NvkBJHwwXLOKjo2mbrnTvX68VjjZOquYq1o8xqh2yz8ChFSxsx4KZws8gB
 LCg3xGlDcmdun75wOldjEge80+ILe3GNeCt6y0z2ddVYhM45xPzg30xl5i/TiSb49GK4
 7dmiJsXWI8SZEJyIV8WF+a+5VHKK68ySuBopXh1PpKXsrhAOXM364OD3jRPgrSIxo0oJ WQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv52dxrtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 02:31:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39ONY78U018969;
        Wed, 25 Oct 2023 02:31:31 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv536a2t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 02:31:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfQ5Ps14WOYYsrL78l8ZRa/9Nv1SZykI+S2N1sMi4hJxXjtkJh29PYssu2Jof9MdviGpXsI68sILrf0BythrzVUR2I6FzRwCLywEoVHSawLC9z+9RCabkRADVCNXngzOcn3UlpSw59MNc5cMToEXMiEFCzFMHsELYK7KnBBJQy52OO2rf+sgB9vbxOLhdRb2zZrm6YYjpw93JTO5jT8DIFi5I9TkP3yjEqoaBY4oIFAdfhszD2ZelBeCqInU7rHBgP2Z5kOv9a9iXO/6CMLdPAJNcVAeQC22eBy2BvAmzFSqUtIaeQ/2flyhvKFzuxs63dqplrgZYyHjRRH5mKDFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0348xx4p11NtqbP9B5tWm/RUhNh36Z1tyYGK+KC8WQ=;
 b=gEL2K4WrnApstKpsFEC8WKgLvV6YO5ltGvNXGOP1hPlZi4IaX7QT8L0HkRfE8a4qZZlwURQGn2PBy3PbHeHbeOv63GBsWJ4XwoVQ/BzxszBbjoir5Rco5ltQN8P2zHqk8vOcQ01EpLLmDIkj+pLeq4qQdNQ+zd9TJFmdTyqlxg3mYYe9gNelYeQmkkcVmJe+DOpMYdjvwQLD73bobZiwe94twKLGfBWHYeBkkj8RI5T49AKHvosDDV+YuQA8ZXpENVwx5uT+q7v/GQZj5gk4ZvFnNgSU+QbluvHC2BYrc2AC0yOZb8lMvSbEG0CT9aHzIXbWIbCnK/Lzg7gxD3CuTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0348xx4p11NtqbP9B5tWm/RUhNh36Z1tyYGK+KC8WQ=;
 b=nUWfWqmil35pwztaRTxHnJfl/NFV/i40E+ihjI67IQc1W9J8/xo/8PPQNvz/oAv0D30Z+CZboUwg5sL6X4Yetb3lyGRSX1SKJRTZcj5kvn4oWEevO7oPjz5n+Yp0jcYb435hWitWWVYXBkrZk5DUtY3ejuAAeW5FzBEKGJVWc/o=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY8PR10MB7268.namprd10.prod.outlook.com (2603:10b6:930:7d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 02:31:29 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7afa:f0a6:e2d6:8e20]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7afa:f0a6:e2d6:8e20%3]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 02:31:29 +0000
To:     Wenchao Hao <haowenchao2@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <louhongxiang@huawei.com>
Subject: Re: [PATCH v3 0/2] cleanup patch
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1r0lje8lp.fsf@ca-mkp.ca.oracle.com>
References: <20231018113746.1940197-1-haowenchao2@huawei.com>
Date:   Tue, 24 Oct 2023 22:31:26 -0400
In-Reply-To: <20231018113746.1940197-1-haowenchao2@huawei.com> (Wenchao Hao's
        message of "Wed, 18 Oct 2023 19:37:44 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CY8PR10MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dca7e05-a5b7-4112-5c2e-08dbd5027e48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L7qjbC6P0kpKUXd0HIEzy9iH2U024QzdX6VG1V+OfvYB2FC5ReLzKPPzvO4+KhaitMqf6uC4/SdHRMfNgT3pusTtZOjdLY5n+0Pz3NMeo8+4/3GCc9kqHZA+NfeYpy8lArrLeuBH5pjgOx1PT9lYilyYF1vnEQN+DWTln5+KTvHwWdEWoMbYSDQ06GD6wUps5RGoVNhwFISG3nKrlXcMFMhJ7wrDif7eSSUMVgn2CoekcV3lqoeHra3HVnrLsCx0iLhuXaDuAwx4BvN8Ywcm3fO/38UH3N193NaqmrCc/TmpchAsY3N6EKllDUduMhUwukUC7dNyyco3tUDi/G+rOsYp0dnh9MnSx3NrDeotiuAWdQ1fQsIhEzD5zBqvSZNhXzmoSYMtmdQRUopZtUTtFckgKZlU8bYzQCCXCn7pMPeazBUzykFXq4cIf5eTcYeCMSh+X8HAxJ1WBlQfMTUzzHe/xb4NFNducyPHgyjvdRIheztGnLfL1ksNuXCVXmtrzPD4NkkRjvOmr6zJcyEJmoiQF3Zm4l3KN85/mCYEP+2bB5J7mIVp8E4gzDArb+u1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(376002)(366004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(5660300002)(6666004)(8936002)(66556008)(41300700001)(86362001)(66946007)(66476007)(478600001)(316002)(6916009)(6506007)(54906003)(6512007)(6486002)(36916002)(8676002)(4326008)(2906002)(26005)(38100700002)(558084003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lgBjfsCelMeAe2EBfdjAEqdi0Ml9T5RzF1CWh4gtX6bgtwsmItrcs8N59Aq6?=
 =?us-ascii?Q?AWb3Gc9lKZtEOFrzyiMdK34s/8xbDcK6uzTxcFD7hel3+1m8RLSkYFkRl84r?=
 =?us-ascii?Q?d4X2cEkoaHzuHnyjZ+q/ZragnHrDAmE5YU6mx7VOrwu92231jdsGSCse/heq?=
 =?us-ascii?Q?cr4wZw0Lsw+8zvGwmhHfx+Cm1gsu2bSx/e/5n4vIR1Vgjyv1e6v8ECglX7vX?=
 =?us-ascii?Q?bVPCmPzmTYdfJinZNbHkl0iQR6oWSz8TBPZquaKJAjvCWCRGRr1zpXCZJ/v6?=
 =?us-ascii?Q?MLNpwyTn0jhN+lA9EyIBvOclVwzIsSTw5vqBXLAodddFj+O3BsjbGCR7xjp1?=
 =?us-ascii?Q?oNGthns2ubQwa63wpT6hQjjanDIoEcnPt+QrkaoMhpmr+EyM3QQP8N57WLjm?=
 =?us-ascii?Q?q5mgvgToUvBA2aFINPpOgffR5lEjM3v26Et0M4uwZVtMl777KjzVcQ2BiKSl?=
 =?us-ascii?Q?QmkDXD8zNW38OESCMypwS215QXKYNlt0eb6E1SMBifgIwb6xcs09aZvUjVJ0?=
 =?us-ascii?Q?XC4AcRy7nN4s6LUd2fWSPtrkNL7U3pJrqAwYokc7PXBoSUoi9mjbT6ffPnas?=
 =?us-ascii?Q?ZQ4VUdsAPT1hgkLAgrkfnYOAzV19GyMmobBu8Bkh5vJ2YjHge/1l8t9uSdlY?=
 =?us-ascii?Q?w5iElfAf6gQovBO/2MTnJXvgfo6aXTqs8bIvgLqkDa73Tf4I3A/fByf4/jsL?=
 =?us-ascii?Q?TRRp8iltcXNFl6w7NavMxJQDD51tr8Dps6ifyArYAFwu8YDKI5yLSvAqi4+q?=
 =?us-ascii?Q?Ne/veS75GijsKhHIu/4Af2QlELLjbCHJe0tzG+gmTlA7dzhWjCwtWvY6iuKe?=
 =?us-ascii?Q?U0VSkYMAdOzo+fuKMuYLBEZzhvcx2IrCsYYZYCvRnSahGFX+G9F39E7BMORm?=
 =?us-ascii?Q?RylxsVk3Y8ekM6xOlxGahJdmoJ4jbwBzQ0OWRRUrB9OVK0y/4tVBKmrgaqr2?=
 =?us-ascii?Q?BgtFOkGolGLE3RG+WP2dqrcZq9EdniusMEWwSXncolqtPq9d+ENZT7o8OL71?=
 =?us-ascii?Q?oEfZCA7PkV0vylAxYuAsgmR76aLXXyySEmT2dBNrmgdOXCumoQIa75s3neDr?=
 =?us-ascii?Q?T/pllZK6h8A8Xg18EmLjIGAkX93pcGtvz/2zqHB6q4pj2Bd0qy1dCvCt+dle?=
 =?us-ascii?Q?5itF9JPjoZiA+qhiWvuMLztsCnMf45UmsLkZbDE/ONKFYLLYVsccCaGlDpx8?=
 =?us-ascii?Q?DJWVqqFaZNUj868rXZnEoFU/NBSMLijh/vE+nta/bzNkPjEiNgBqQBrZNoMr?=
 =?us-ascii?Q?aqtTZDdVVZQm3WP0Xdrtiizorqe/wyG38R5mma1j7SAGC5Zo81BgKkflLYyx?=
 =?us-ascii?Q?nt0mCfFnm8jFBTHrwAf1bpr6jAdO65RnDA9UVCzEApa45R/+3BmJSLPuSK7J?=
 =?us-ascii?Q?DWxedBrbyy0s6dma/0h6yI8iWvTEqKPPXBz95ZS2vGl8ohJlFZdoYWpa8ja5?=
 =?us-ascii?Q?XKdl/XXhaSWv3n992WYJYkpTbEAt24JGMZI1Q/vH8vaSDmRen6Y6cKJEaCHf?=
 =?us-ascii?Q?ik3ctXdQqGmH/GMWadus0fMnJkC0CMw7gVEkq+OxCERtV2K3nvW0dtdzdRy/?=
 =?us-ascii?Q?8tdL0eN8WLwVnAFzz7pRnB55LCYSJmoNOMUFeNSVJGAHQuxUi/6x+cwvhvr0?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iovzvw58SRM5Dh5oWIPGMQjAD/IRa+Wy7f4gumDRTjpPeo+goG1nr6dGgZnpZeSLqpcDbJuk8sLsoqH28Z3MyJjahC6toyh+95+lobHeKHclAYvYixAa3Hqi4CSHBFXJ9ttVDnTWazhI6vgT+jLhAAyVLIlsMQgDPPbKWHRZBe2QniwF0HL54IpayKkf/j8eCV0Y7yQ88glgJZdxiVNQWIFnS7YFWv2MfbovnX4Ud3SMPChbTu2HxbhDKphAqzQnuzmdtplvi0kUasU5Q4xJJlioWlBmzEYVqaE3aPVmrYl4v6lBL3Nb27AmLa2Bs3PFTILONOosWa/nKmKJoZlrc0/DAFEsl1nZoYo/oJXuB2teyP6tLCdG7fgzBv3xWxzQUGBJ6g3meNJErq6Z3w5NcminMe8osnt0Wwss2uDeGnSj4hT9vjSNsxckWehHOt+w5ESlNVCDT+TWG8EEHrsTIMcOVafRb42OtQEQvxuPieYgFV3ubgEYxgtp6B0tsx/LR1/Ex71JDS80+cuHEUbB5UNjdDmv/LKIvViOT71S8HCQ2GUSwbKj3GsF0sV5cPlmoTn3PgWf/qDOjjkZ9i5ccUYmtyNIHfa8a1FG+hDNW+nfvG7oG6VAdThMqOf+5PxOWnkEKGskZo5rkqfT+6WTRvtWFJIzzVBuA/W0+yrDUHEV2O3ReAWQyf/MWWA0veVb4uxNlcAOixxwM149Alwhh71HdeAVA8UVgAM/2t9iUviaJoB1L1Kmoj6NPZXiwx2I4lT0ovLoil6lV9P+f3lL9JVp9QQLEC3zRjztAoCfxAeC7ttFYAK7tOE/Vdq0GLlddK3FuAhjadeYrdjETatZdxwH8SEgDWQUOzuWSHnwNRs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dca7e05-a5b7-4112-5c2e-08dbd5027e48
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:31:29.3058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMEFQuc8cB545dt04Vo74uYHCaTkQsT7DgP78Zvo+oNo097gyBtt4Qs71W/SqAw1jEMHLp6LGn/SXHtGbMvnSaST9iOns0t8YhuVgh+HTVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7268
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=760
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250019
X-Proofpoint-ORIG-GUID: Abh1Bhzf5l-9YlPVIrDB4CFNUEJV8MOM
X-Proofpoint-GUID: Abh1Bhzf5l-9YlPVIrDB4CFNUEJV8MOM
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Wenchao,

> This is a cleanup patchset, no logic changed.
>
> The first patch cleanup scsi_dev_queue_ready();
> The second patch add comment to tell callback target_destroy of
> scsi_host_template must not sleep.

Applied to 6.7/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
