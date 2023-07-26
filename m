Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEA9762862
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 03:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjGZB4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 21:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjGZB4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 21:56:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC99E26AE;
        Tue, 25 Jul 2023 18:56:12 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PJIvlj029527;
        Wed, 26 Jul 2023 01:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=MVjEdLERmnlHfWNici4+rrL2wmtJixGDeVn10O1hEuA=;
 b=gfJ9w55JLcICHv7Xi2PC+G5YEU55OhwzXvF5R817ZTB9qjvhjZ8DUCF/J5ofukUmG8zn
 1SJRyy4yEBx5z3ueM6bJ2e+YVUeQkUUAcO9ZWw2znvhOw/pxhBCi5GVklcis3RrKjEKg
 Y58/30hvvKsqZWhTNcwuBawDn+eYv3ehSFbLE+efVazJ8Dj7hRvh7Pc9WzQ0xTPYhWyt
 jKUQy37YMo/NGNES0Z6AUUzM6T94o4P/V7uihKZ17kLgCD7tw37pFMYa2ccfEEp6obw6
 gY3UggZeT9vDe4Zs12xzEnCLWak1Oz5t9AehbkdCdFlIKsKDwDBp+/1/DN/Faq8BuT/q 9Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05q1xetq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 01:55:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q0R9xW030420;
        Wed, 26 Jul 2023 01:55:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jbu8ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 01:55:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIGCYNtVYupnQQ3Ajl8NV4PhxoHeAx6khK6YCTRGPe0RvWlzsC2gEfFGuak5F9shlmHbjT7Pcj8B4XbsMiYdjA3UbCqPlSgUuoC61oUqJ3h4OiYvID5A+XjUJXnbD3I+kncNoYPllrivwpNFCUQilBFK+OaDO6zESl0RBWF5xNiN68s3gwlR/4TTSB8tc4WJhwEpai4DxV1ciMmjPbqjMaDxGfUTGIh8mzF48VgKK+ju7YZRstQHOCRcgvhmWJ7es5tKw7t+4wfiD/72CkepMWQcD5Tp+VbTXh/ryqGUZaGaRHTAhbnEaeYX3QFu0CHNZblFawFtKuehxBVBX5gzXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVjEdLERmnlHfWNici4+rrL2wmtJixGDeVn10O1hEuA=;
 b=gCs2mgP7Rl2JI8r3y8BBMOSwSnSqN86EVjEF5Ppbg6utX84Gj6QkitEGvJVq9+cVqha0gco3Z5NA5FcDbYHLdeKWv7bgKpfftr11TCHGILNwmRj1YBMmONmFIVcpVutyzx3GFubP7myYe3yIxNNDjV65czWWxfbdWhscbE6IHxBesoJaJ4n2SF0XYERcyf7s9ijnHBkNVmdPpPeVmiZvd8YdzzNwhbbXtzEvb6TqYXsRt+TKG4Jn0EqnR0yco8U7t2Th3KN5MoxR7YODaKvvwzny64g22xwvpEJHmXIkjtFGKGN0HUexQYeXcsTyeX/7J1yl4g7Y7owzsPJA2yVjyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVjEdLERmnlHfWNici4+rrL2wmtJixGDeVn10O1hEuA=;
 b=F9t0ICEcZC4F915t2O0z4YLsIi1HnLs9CSo4I0BDT4KaOiF70yalx3JLJOyL/9kGr9lxjE3LsazTVSqvIMU86n/NfqYFk4LBqxN/kkSMFfeu7//mAELNRLxDcSd6Km9uuvoYNMDy2LQZGoVe0s7bnRUubgreBm78+W3ENIbdCHw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS0PR10MB7152.namprd10.prod.outlook.com (2603:10b6:8:f1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.33; Wed, 26 Jul 2023 01:55:55 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2dff:95b6:e767:d012]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2dff:95b6:e767:d012%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 01:55:55 +0000
To:     Lin Ma <linma@zju.edu.cn>
Cc:     lduncan@suse.com, cleech@redhat.com, michael.christie@oracle.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        vikas.chaudhary@qlogic.com, JBottomley@Parallels.com,
        mchan@broadcom.com, benli@broadcom.com, ogerlitz@voltaire.com,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] scsi: iscsi: Add length check for nlattr payload
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1351bzba8.fsf@ca-mkp.ca.oracle.com>
References: <20230725024529.428311-1-linma@zju.edu.cn>
Date:   Tue, 25 Jul 2023 21:55:53 -0400
In-Reply-To: <20230725024529.428311-1-linma@zju.edu.cn> (Lin Ma's message of
        "Tue, 25 Jul 2023 10:45:29 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:805:f2::49) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS0PR10MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: ef0ba2bd-37ba-4237-ecc4-08db8d7b72b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8gatd8xCgW78JgMTh0DiWmfh78JBX175nHfORhUTweZKPUJD3iinp9inNG2c?=
 =?us-ascii?Q?DrP9S4VVy+t9XTy//aonu3R1TWgUA69vTXDS6eSNVvIsuew2/somVv8Oox5B?=
 =?us-ascii?Q?yfcetqOX1+iagZTa6O41/f7ISY4Mdywp6c12K/ClBAsfmV+PoJGGRWeUfDEN?=
 =?us-ascii?Q?Xwm2UQJkIogd6a7wtGO3SL+vhyhlYfhdOVHYSTWG8l7W8ePa5K9H7QjUEnib?=
 =?us-ascii?Q?393P9yW29ocWGjfLSa4VS4DDwsHwbVslCAFX7WqOQFCfAruCqyytMaMKtIIV?=
 =?us-ascii?Q?/GhRZVhsexb1Duob5g1YD1h5JkQ2zfz8HdFur7xHoPTYIRP3ZerTTD8cr9gf?=
 =?us-ascii?Q?ptg8RdQ55aU4uI3qiIHOBHls8yWRxPfQuw0D0nif48HhNMI2c1lzvYCfYM3F?=
 =?us-ascii?Q?D2A8oIYnBAZ9QLcnnGq0ga3V72HMvsiewhWNga00Z9aTr1Oek5ZBUB3Hj2HG?=
 =?us-ascii?Q?/aeUOlNBGBMgjQprXOayqQR4aRMk3eu++7/+cHNDpSbG91j8Mgr6m34fqozO?=
 =?us-ascii?Q?AC1Q8vYCXzruTLNgYv1l/PrU7EQPI2xzKyOnb7Ck1V8CRM1XaVc/u/3B+Zq7?=
 =?us-ascii?Q?4+YbE00CDb5qshs0ddCF2cGhir9Ue3Ux2lS8PVHCe2VkcKUaZJ3FFWwWtqRk?=
 =?us-ascii?Q?dMDprz8UigI5/4idtGiwDpU37qryuA/dSP6VWUWmeUvigYj0Tz8NCMASlH+u?=
 =?us-ascii?Q?vKJEWaJUpTCCBETEk5vMLMlWz6Y8MSHhfTZyeCWZsagD4pdMI/4FgvOxulmL?=
 =?us-ascii?Q?BFOzaD2OeXoD8/s6q8SpzaGkc1ADQos4rwIWHA6bstpcJs0/g3TK8KzecQ0q?=
 =?us-ascii?Q?LL2hBSZ3vJJw/ThRwrju/z7sPreJjnTLmB2BHEWcaUL3x1AoPdrdN9TLhxBl?=
 =?us-ascii?Q?aG9g6C7aRA4nPtei4tYbAmc1ez11sxPMoB07u2hooMztnL8zKEAEhNphJxGy?=
 =?us-ascii?Q?USjw9mZYAFSgDvPN1D3u/YUSMTvj2yzZq2+OetQBHx6v9QePnFixUnlfSrrI?=
 =?us-ascii?Q?BRxS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230028)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199021)(6486002)(66476007)(66556008)(66946007)(86362001)(38100700002)(478600001)(26005)(6512007)(36916002)(186003)(6506007)(558084003)(41300700001)(5660300002)(2906002)(316002)(6916009)(4326008)(7416002)(8936002)(8676002)(59833002);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5t4oiLZO8lVRv/nTP2L7x8mXipasEr0jDnhEo1Z0+oe6lvRql2HnlecwUjJV?=
 =?us-ascii?Q?UBYMIz0vo8cOtByuhmyY7cMSQJuIIkToT/PrB3ixDybjQyJC/EkTJpIjym4D?=
 =?us-ascii?Q?G6+qLu0gMymswxHZPRbTmlM2gH5YcuBmBThh1p2Yd7WdAhsohKVd8Xck44dK?=
 =?us-ascii?Q?64FUD0Cbvb44AgU71wHgyNSxqSaPjeizPwzdLnPSXTqO+hiJ/O4zZKGjdGlI?=
 =?us-ascii?Q?0j1sdbdNagXNqp4Kh+mgJ/VG1PVPkuAQEPRj/aZT3TMq3nJ5O/SEDEeA5jgw?=
 =?us-ascii?Q?AYJcSyhYE2BXzTMZM3ZKjXb0f/agh7KgzXyIGS+Sn6EVxf1/PFICKs7FKNZ6?=
 =?us-ascii?Q?yPrIRaKN53AnySEu8xC9TjtwHgZtUfZnGpqtB7ET5zrFx4EIR3aOOoPBGcji?=
 =?us-ascii?Q?vMBbukqf5kPoZun9dFP6GSn1N7ukV8lARrilUFs7OJeZ9nc3PfikKzI7YTp4?=
 =?us-ascii?Q?0cpjTllx0Eo1YKQCFWPYgArExF3ssF0CmpanTNjzZUlrjvuc02i0jsDypDmA?=
 =?us-ascii?Q?fNAcIQ4A36Imw46Pq2zn9xum1zeJ1C8GQRlQo2JF1Umi+Wy8Kin3KPlS+wq+?=
 =?us-ascii?Q?xBKxkO/kXvob4Tv14A68psiBk2FkwgM1YVPmFGLG/9/rXYSIkZO0Knx56hh4?=
 =?us-ascii?Q?P76ctd2yW2VQEkQdURVs9w7CWUZA+YdWzvVqfVI9jdWykqRg4QcbQSQeOsw+?=
 =?us-ascii?Q?Wg8n/EKQKdYBk3QPri9yQ0qnLFASIVDYUN8sfATCBEKO+RywKkwgggcK8Ex7?=
 =?us-ascii?Q?/Pi2r5wG/wSs+Nl8mdMsBBnXtcwA/cuBKT5/xgryAtbgPtdZpuJ2269XVbzA?=
 =?us-ascii?Q?aqFeW6uadj7tQ/SkGtV6gKU0FIFsY0ajsX3l/XITO+d+fZ0lhotJcpnHaku1?=
 =?us-ascii?Q?62TWNiUbm4cxrpLSLzDASwOxoXtt/x7eLdf4FwEihPTf2znFgG9UU04mjW+e?=
 =?us-ascii?Q?nV357SBSiKDvZ+B4V4ieMtRe8UD9esLQchx8XcN7TP2bwr082cuuPFK0SRb+?=
 =?us-ascii?Q?5j2642pZMQibZcwHsM0urs1/kUlIWdbZ4aByzxCjenz+hHLD0GWocXvuc8Z+?=
 =?us-ascii?Q?KkM7Dda0yzSAP3c69Yh3fykCeu45eGjrr05TGbYPQ5adwsNSF4w25eiUL/GK?=
 =?us-ascii?Q?vso4bqlwQsIZEX1cUIy06I53VUwGzVOD/3DXvcNRqi3Ai4xDG4izZfkIiz3b?=
 =?us-ascii?Q?ooR9tNzU1nBgcK84/v4tC9xbzoWaRM3MsJ2G/jW6/zBQH736EbV6WPpCiGcs?=
 =?us-ascii?Q?BavpRlCFSQ4TYRdcO74kpBqF8Jg3ifq+X4hxupDM5e3P2NMvotBdxU/V8X3U?=
 =?us-ascii?Q?uKmfmsRT33XwV7ObQy4amCVPPqARYju9/ZyLvGNu8gSku91OlWfHeilkVzKD?=
 =?us-ascii?Q?6HUbMZlD6bXCxH3+PTstHzZKR7va83zK6Z5jdz1emRb9OVaOnn0+6BrAJ4fT?=
 =?us-ascii?Q?OC6KMvgoaHySNFGjmxAlxbaNwJpLQrdMoTYonE2R7Y4frwxYuUdQQ4phC9Jd?=
 =?us-ascii?Q?f9nd7vWMHsXeoV957qo7m7aTqakoTGWIYipk1WEG+m+OX6n0513nfFdzh8+q?=
 =?us-ascii?Q?b3cgObIGxD1SGySeISVhXTBO0FZCMg4FtfQdlSXOfo2+Mf+JQLXokH6Agb22?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?b6MVSdsaRp/3aOH8dWlj9+q+hhUzfle1V7yyp5ioUh0tgzERNxThRmncmNni?=
 =?us-ascii?Q?5m8SV9RkDc5X0O6QmUUPx3gu2qPxc3hBkXr5iORlhmBd/RwRmR6q5cTPVyKC?=
 =?us-ascii?Q?iCjquoIzEhCkeyJclCrzNZYwiSMVOHbOQyhe5umQUoUIwHRCYgtLU//QSeNs?=
 =?us-ascii?Q?JaIZyZCo85kP23kBW8yA2M0geD1FizWrQbnCT8eM9tPqQuF8AmsB3N/xydou?=
 =?us-ascii?Q?ZRC/fiBN7opJ6evZpPA+jhSIKUF6cNbZ6rNh+NjKhOLTD99E7vWdwHX/zTRz?=
 =?us-ascii?Q?DmZcerLJbodZg+cGP1cmHY12J7xee1Ccj22mgORJR4oool6XX4fPwjxeFQ5X?=
 =?us-ascii?Q?dglTTD6yaoSL/ENe517ydZOmSExQia/m+HsuxueFAtDtsrBAmMWnweNi2T9s?=
 =?us-ascii?Q?doroFQPZCVeRw0PHRzDe0q3tUGGOh5pIvKfqyVkxU3yfoReIdHUR0a2E6iLK?=
 =?us-ascii?Q?LVVkKMDBW99BownNVPnTUnu27Ai2CjNSEcQFduHF1BZARJRxsoDfkDwQa3ZZ?=
 =?us-ascii?Q?DoBUYF4gmYnTnBn5Jgq31i0BYgNrZr0zCG2cN5oPcxWDyMZ1yVvSu3jtYTTP?=
 =?us-ascii?Q?TtZVeSPhaGJt5k5B1xj7SFW5n3Go5nT0JOLyGR5wzlStAKJcIMaglYKk3FUU?=
 =?us-ascii?Q?NBjsjFBqH4MWZa+RDnErpmLVR6lyV1HbCmtXm2I8b5t32+LbIay0c9b6hrsA?=
 =?us-ascii?Q?64t8SyD745u0YYe/7J0u/8v9AaQzD8WReGqYZGKqOIUtng5UyA/UT1bmR3rW?=
 =?us-ascii?Q?vxVKYlc8fnoMvVEYQoOd9g1dxs9nTV5HcHFdG6AZ7nHG83g2iksyLKSinX27?=
 =?us-ascii?Q?GN2VlG8oMm0ZlERnjhtjhxMQLLVk8Lje4pqkf90bDWU8rY+Vb2Y3weJkB8n6?=
 =?us-ascii?Q?TMBRQF6keQ7Y/8axxUpOTOeBtsOkEHf1tWW1cxN4OfZoEJbtqnAUTQwqqoc3?=
 =?us-ascii?Q?A8RllXTtuGflgDTrwihNI2uNBN77ajroEeGWHUjia02hb5r+qKTtVYazbmsD?=
 =?us-ascii?Q?EbH+uuEmNgVz6Hi/ZYSwbx4X8UZIRRUihMas1kkt9iRU8ylg5T4UIGJYx44w?=
 =?us-ascii?Q?q7i7EWZk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0ba2bd-37ba-4237-ecc4-08db8d7b72b0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 01:55:55.0010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +o/FRamNQOO908QfcFTEvN5iMnl7U9qdwl5H0ogVGFZPgST8Wpp3le/smFdd3qdi6MDUaFkdk79d8v7liFfxWf9mqPfnQWJzG+gYQ4OeAtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_14,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260014
X-Proofpoint-GUID: lBYts2OW49kvYu47VDNPGiy4Dtmv-8wB
X-Proofpoint-ORIG-GUID: lBYts2OW49kvYu47VDNPGiy4Dtmv-8wB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lin,

> The current NETLINK_ISCSI netlink parsing loop checks every nlmsg to
> make sure the length is bigger than the sizeof(struct iscsi_uevent)
> and then calls iscsi_if_recv_msg(...).

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
