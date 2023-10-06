Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B687BBD35
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjJFQtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjJFQtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:49:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FAAC2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 09:49:14 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 396Cc2C5015185;
        Fri, 6 Oct 2023 16:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Nyo/JUteoHWhnrItA+pXfIbkdnBEpDSMID/AHbCFhfI=;
 b=epsZIgRiHs5pZfkNzM0215gcTdTARVXwxvTUr1SfuGKe0vWz70HAFcmhEiyKBT5l2YCz
 ZF3JFB7CRJ3n77vMw72ZMJRydhoV02b72Ds64tlFwsYLt+PrE2u+aOjY139vSKGxg4do
 K1tI5jlrKhqLL7izsFPRfLMJYmis3LyRHabwXYCIh/bTheO9ZF1ZF+Jdk5cHOUIQT5wb
 TJ0dSqJPtSQToFx3ddyjsQN0zGJB1RsOet9N2fqGyVj/YyUwkp6M8FvudBjaObv8Uvh8
 mDS1k0/YjquPmKaVinFFx1s2V1ivsLYAztikOM7R11AZ46bLu1SN3NiZ78gw0stekmO4 MA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebqe4d10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 16:48:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 396FfNln000395;
        Fri, 6 Oct 2023 16:48:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea4auk6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 16:48:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sb49YqYsSpILg8ShccJcJrbs/s597QYLY0sPxQquACqSxHfrTb+9/JxLzzWLIlQOKbLoPxM9I/Av0BsR7znJei3X3DaYeik8QMuOfB76bXaaQjLatYYhElaGDRLMTHzYtkki+rufzSB3YSTuFIJuiX1R4ieqHm+tCXxSJu8m1t6q1SOuPS3XvL+DLiM4VmL3huropIjq9gEqBNmLzTjKOqHjt8q3/GQR1BULJ8ZDi10F8dL+lxyi6mGwqgKSSBgfhIpmBk4kWNHGmj0432XF8Rw7/EDnKjU1LbAo8VbFF6bsjVBf3VrHQdM2Js2x1/6mG7IUdPMGFDBaJskfCYFI3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nyo/JUteoHWhnrItA+pXfIbkdnBEpDSMID/AHbCFhfI=;
 b=D+FHxMg7+Pa56gPYROpJwWZEool0LnA9pWteVVIOBrQCEuj6PLh8LuZJs+ckVKZa8u/u+ILMLap6aJuiTr2PCzyHWO4v/VR/LuFiOBoWpM6mfZRfSilJEXm9fXNXw3P72yacGQZcfL0kT9O9/zVDNvHuk5ErLPdgG7k1yzCrhXR3O88CkzXXsykzntZz0Ob9RWe5NoroiJ9sUaAx6J3U0YHS4S2W7EoWHy31XZyPOFf4VSPd3zFQCk19vmn1hi6DKyOXBnQWLpkAc76CSPYcQ1WYnosL1zr3jHj+Be6KQyXd3piD7Xo81VDsi0bTWycIMzW8X2uDRYO0YOLpO4fO2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nyo/JUteoHWhnrItA+pXfIbkdnBEpDSMID/AHbCFhfI=;
 b=A8Ry1XHFwn2GGAbXCCXBCC8B47yj+a5oo5vI83ldCGw5YtDCtFjIqaabBTVytm5WG8dA9iLh6Z4w5aZS7T7Ub6KSQ/0VrquLAZewjeC0fVnZQPjek7UqPclqpU/EJ2p0Mf9I3lOH5z35Tu2TQtODDevCG+jmhtDc/hDGtyeGu5w=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by BL3PR10MB6115.namprd10.prod.outlook.com (2603:10b6:208:3ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Fri, 6 Oct
 2023 16:48:29 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::1aa1:e3a9:cfdd:f48]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::1aa1:e3a9:cfdd:f48%4]) with mapi id 15.20.6792.026; Fri, 6 Oct 2023
 16:48:29 +0000
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     peterz@infradead.org
Cc:     bristot@redhat.com, bsegall@google.com, chris.hyser@oracle.com,
        corbet@lwn.net, dietmar.eggemann@arm.com, efault@gmx.de,
        joel@joelfernandes.org, joshdon@google.com, juri.lelli@redhat.com,
        kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@kernel.org, patrick.bellasi@matbug.net,
        pavel@ucw.cz, pjt@google.com, qperret@google.com,
        qyousef@layalina.io, rostedt@goodmis.org, tglx@linutronix.de,
        tim.c.chen@linux.intel.com, timj@gnu.org,
        vincent.guittot@linaro.org, youssefesmat@chromium.org,
        yu.c.chen@intel.com, daniel.m.jordan@oracle.com
Subject: [PATCH] sched/fair: Always update_curr() before placing at enqueue
Date:   Fri,  6 Oct 2023 12:48:26 -0400
Message-ID: <20231006164826.335223-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230531124604.068911180@infradead.org>
References: <20230531124604.068911180@infradead.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:208:d4::27) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|BL3PR10MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 491913fd-1e0e-4c0a-068e-08dbc68c112e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jXiLwbaVG1AnztI6Yzev3xvv9WPbNkDfkFReATEuVEn481QZN7HtdLSGmcz/EFkfLgpt6ONKES9KGotbsBhlsrW9qBZDz95BfXkKhfMIdAH5nxLoPJrgDUMwEKPqS2qE8aqwUJWX1IdmJrFpwqtyLVoXCR6v046jwWSWzD2M7L2w8BYnTLIUJdoWHXh5lwvMoBY2LMeqsprty2vBXaU63b6I8vSgVKVcWaZjKy9YfqVk2/ZCBSgrgTQZqlAdcSaFwTk2/8NJU1sY3Ohc0qKIruDEvUhICYtNMHJdS+PxUQO+EsL/w7JMbDYr4mG1zLMWBRLLD9ZME1sx+tlu6xj3q9BScHLpGrJyd9YJ03jwNY7vdVJMdUig82427fsK+MvO9J7FRILDYahUioUQcJcMG8pbPB5AVHdUR06kLNEivMKeVQgj4AGpQHiLQyCs2VUYGctY3w3ZGSatZsHQ2eKEA65CbQg38N8+Yw+Chzc/R4BVA7Cm7NaWAo+juGJls84dhY4CjPrcdvrTCHAp9hfKw9AoTYgmmfDq+Cb8Cti6tO1M5ik6uyDHkALVDjCzu0V9Q8Uk8QcqfNkvRJc5wooK/15uz4CqWqSynmUVRXgpNPE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(6506007)(6666004)(15650500001)(478600001)(6486002)(83380400001)(26005)(107886003)(2616005)(7416002)(6916009)(41300700001)(66476007)(4326008)(66946007)(8936002)(5660300002)(316002)(8676002)(36756003)(103116003)(66556008)(38100700002)(86362001)(1076003)(6512007)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DWbHc2jnnhtyAvtqIvub2poR7A62Hw1pPmrUVC5VNX3TEb37ge81dVUPFHVq?=
 =?us-ascii?Q?469zQTsc2Ndra1f8L7T9oHwnS2eFhvGJ7SIFARFcZwOo6P/GSylTRreOehD4?=
 =?us-ascii?Q?uknqF17f8j5Hux3NZC1ytjrTEnL2oxBppo8TyARJHzco4npiraCl0VJhu/3A?=
 =?us-ascii?Q?IxBpnOIyUV3IrWCps8ZRDZ5dwTu/Q6TqWqR72v3swLYmyuoRRmhPnO0U9JUE?=
 =?us-ascii?Q?LdiTKnVjTu1LIavM6ZT5pmV4Jubheh9BegzX/7MSI6R6sH2tSPIu/WE5Kog5?=
 =?us-ascii?Q?55Up5woHMPtCxUPxRkZf0v3QFdftiWZn+sLFfgqSqB6VwsP8cAOARAWysEjL?=
 =?us-ascii?Q?tP3ljpu03uIAgkExGZfMwdMEQINHe1KcjJVGlBBM7F88p58F1xn1xI8yfJmX?=
 =?us-ascii?Q?9/dvwXPV1JHEF2eABCBffIqzSqsIgi/5puRXbIpBglyTEVw30f7Rzl2X/grf?=
 =?us-ascii?Q?RgRXJqN2ngF1sGhF4nPFAJSrV2l1WPimpd6tte7NDIohiQGdP22Ugv5AC9EV?=
 =?us-ascii?Q?jCG8cJWVTpuFZao4AIXZnHoPgNRu2fPMqqdhscfLDy2oPqQ02FB0drowGl9N?=
 =?us-ascii?Q?KND0SpWFlf6FhZR4DfTK5/57lqx95AL0UuUtG7YQx9P2bc4VMvcrrwUR6FN/?=
 =?us-ascii?Q?O773ShO2358foYKggX4aDeUv+Vj28e52VAE2ffNAiG5y6ENEVPmG+nS+Y2pO?=
 =?us-ascii?Q?BtD1EJcTGTzsfAL2b4yd3G41gL8a9UIzmQgDEHSM3t2kEJ3imnp69+d2pHu0?=
 =?us-ascii?Q?wmQ1UcpjgcsJjWqIm0f/Ncvh6A6vfO5xvU0+ClpI5KE3l5zc654xFeKCDhMR?=
 =?us-ascii?Q?jAY7Bk37d5Ww/U7zLiLARUvGtxG2qSO34wdKNBqc9RWyKP7X5T2nH1HxJNCy?=
 =?us-ascii?Q?XbAjEdE91zZBwYRjPlWTQdt+dPE29WFngDiqBo9PTsWb5LRbqNVvvKZ4Pqsw?=
 =?us-ascii?Q?X64ZcTqTdkdcANtJ/pW3H30HGudVVp29VRH6lflFX1rtHQyyRjKPxOW8OfZy?=
 =?us-ascii?Q?QSEs75GnoVLXj2jf0BmEIAOh27OmkrPJCqH0oRQSZDVmUb5umS7tLOIL4T6W?=
 =?us-ascii?Q?Lw8ym6cahnfw37EkKwjB/n8TwRQ1NPnwdDHdFTFMFIUY6rxzO0KSMF3Y7Olt?=
 =?us-ascii?Q?sRxYN/zs0BuvP/fYzIOBo7UiAbqbAbqRKV+OpPLSrq4ud9dGaB2BBtvFbRXT?=
 =?us-ascii?Q?EWmHmGRAJrGyLcaT/5bXUJS0ajIbYU08uJvzIoI6xptaV378GIlKy3ZTjmG3?=
 =?us-ascii?Q?cCJ9KigTjQbQAi0eighYlWRcr9gp+GcgehXBs9oyQFY6v2R1Shmubt64/GJi?=
 =?us-ascii?Q?OeWehy0gF/uRyhWD6g6jqDmG3Zc9rt0Izuj0NPnlplZJj4Pp0YmyuvC38+8I?=
 =?us-ascii?Q?oEDOlgLHC5rzHsYKAztvWktA+zXH12QYSxPfhPopIk4HbWkqSUxRXhyc3rPN?=
 =?us-ascii?Q?Mcc1hak5YVLQjxTakOlgvAgZPG7WVrN9+I+c8RLJD/SYiRZESCRpvLH5b1EN?=
 =?us-ascii?Q?hEtCAj6KhkT9ExyRpjFTpM32Fr4msG+K2PiexzZluRIezkqFxhv0azHFhwI7?=
 =?us-ascii?Q?axlxE7NBmQm57sP4Z/PaOLo0c9FLYwKbFuu9yo6b75SRTODBvJ75uB9gYZx7?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ZW5eFcOmiZAXBUwHQOQZSDCEOTnehAlJPSI5esXaTDqEX8mHCX7q0QBBmGkx?=
 =?us-ascii?Q?xNGDhsG6duoc0rDgMdXX2tzk/SXo8B6AaJ0Ylrs3U4tVg3pune9/9nGSGqiz?=
 =?us-ascii?Q?3UQrbrc78Ucf4ipqCnxn+dcCPlitmeNgnF20TGdySH7OxZ2GtieDCDP8bztR?=
 =?us-ascii?Q?+HvLrPf9LBsK7gRLW2rQypgn8dHJ3EXHtsSyE4KubSnh7fOsX0q9Yr8Ssapn?=
 =?us-ascii?Q?CF7Vg8Sr3p+LO22UCIz5r1pqXaWVQ1MFYV/OwVmfnkG3WmjfA6xC9LSJbKBC?=
 =?us-ascii?Q?rrRsCum62r4kiZe5Jl6AwM4ckV9Czz5vyf/eMIR8MBfQstfexjxU79ZF7HIy?=
 =?us-ascii?Q?Zp7OFR8ySRj1nHdeaHaDpVhqnpsP9mGFc7KucHlnoD0oq8zuv4IbkiE71rds?=
 =?us-ascii?Q?NaQ2Myno4NhqdGknSl1S4X1QAHDa3fAwOXgqFNcEkpof/8BnsYCtwUKd8hdB?=
 =?us-ascii?Q?a7iw7FG6r232g4aMsHeMFNZU4xPAcdWA0RudKrMJNBzkdeDrvq2It9avo8SY?=
 =?us-ascii?Q?Req8/qxtpXEB4iVkH7DMfPv5m69XtLjO/2sOv68TPZdEfYzBGUKeMveTGitw?=
 =?us-ascii?Q?ZVhYbsVrlWVSD18V+GBcssCjWqsD93SYJhGWQOWY2/8BzgPU1dLVsHQedvT7?=
 =?us-ascii?Q?ijQjlD5tdOEyq2FPQwr9XDc8Eq38a9IsH1Rh0tfawNrdgmrbYBVb95I4g3l1?=
 =?us-ascii?Q?YkUxcH4tpT7Qsfig9X5VvAqaCc6jBcur0IH7QtV8kj5z1FIzKIXGvmdPU4K8?=
 =?us-ascii?Q?UMksCpXvynOx+Hx5jqKkBN7cfK/nOj9ubUMRrF/7Z+r79Ipz0OuR7x8hEg97?=
 =?us-ascii?Q?EhBaOUQoFstzq7FxPlRV8fvGimNl3zZTRvywAGfxtgotwYl6rIT5tq18cfzc?=
 =?us-ascii?Q?Pr7E+d+QSW6BK2kvOewAYNr4CSakJHiRNAQFAHTROUusN1VAV8pB8uj+MMZE?=
 =?us-ascii?Q?VLOKE9q85JoHPlNbf8u5qkNStlXK06Mf+vSfOpsrS6yHIHZLFHi8s4Vp5D3l?=
 =?us-ascii?Q?6EhfAbQq0dIKiuzipmJPlN8N3R8gLsaihk9E9bARFdjqm7a/bVwy56j8gZdT?=
 =?us-ascii?Q?ZjAiDBt+7sC3M9FcJ1kkIx5gT+eNvcZmg83Ivy3ES7Cw9pUXWCv3hCr6Z8/M?=
 =?us-ascii?Q?0PW/+iKcgP6geenYIPUJsMxgpdNC8K1yADRBG1TFkRiVkpXyaV7DgqwY0vpR?=
 =?us-ascii?Q?bsalBkb+j2rBmeCiJoV+25/gp3FCkIGjoI4jSXac707PSeSc0FOiB/XrcyOV?=
 =?us-ascii?Q?cIaP5Bx48aBox4F5IJ4pbaWVbCGAjkqngRPJQhBG2++EyOJZVjKioLokPmk/?=
 =?us-ascii?Q?UQ8vzqBO1qAu6TL4ktJmIN0fL4Zp4nsLcd0nZk2RUGioBQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 491913fd-1e0e-4c0a-068e-08dbc68c112e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 16:48:29.0661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cy0iwv6GnHbCbN6ZtSbSSyA+W48BGzzTIvvvwfeXfSm9pQyobDv+ggzOuos5nJQBwyJ4ZKaAg6+Ib3Mtg9dZBbj/KEodgZpGD2/K8o5xk80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_12,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310060126
X-Proofpoint-GUID: 3J0OmotUmCeBpZKPir8eaWAP6sv-VTcd
X-Proofpoint-ORIG-GUID: 3J0OmotUmCeBpZKPir8eaWAP6sv-VTcd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Placing wants current's vruntime and the cfs_rq's min_vruntime up to
date so that avg_runtime() is too, and similarly it wants the entity to
be re-weighted and lag adjusted so vslice and vlag are fresh, so always
do update_curr() and update_cfs_group() beforehand.

There doesn't seem to be a reason to treat the 'curr' case specially
after e8f331bcc270 since vruntime doesn't get normalized anymore.

Fixes: e8f331bcc270 ("sched/smp: Use lag to simplify cross-runqueue placement")
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---

Not sure what the XXX above place_entity() is for, maybe it can go away?

Based on tip/sched/core.

 kernel/sched/fair.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04fbcbda97d5f..db2ca9bf9cc49 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5047,15 +5047,6 @@ static inline bool cfs_bandwidth_used(void);
 static void
 enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
-	bool curr = cfs_rq->curr == se;
-
-	/*
-	 * If we're the current task, we must renormalise before calling
-	 * update_curr().
-	 */
-	if (curr)
-		place_entity(cfs_rq, se, flags);
-
 	update_curr(cfs_rq);
 
 	/*
@@ -5080,8 +5071,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * XXX now that the entity has been re-weighted, and it's lag adjusted,
 	 * we can place the entity.
 	 */
-	if (!curr)
-		place_entity(cfs_rq, se, flags);
+	place_entity(cfs_rq, se, flags);
 
 	account_entity_enqueue(cfs_rq, se);
 
@@ -5091,7 +5081,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	check_schedstat_required();
 	update_stats_enqueue_fair(cfs_rq, se, flags);
-	if (!curr)
+	if (cfs_rq->curr != se)
 		__enqueue_entity(cfs_rq, se);
 	se->on_rq = 1;
 
-- 
2.41.0

