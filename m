Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D5D7B82CB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243002AbjJDOzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjJDOzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:55:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C96ABD;
        Wed,  4 Oct 2023 07:55:08 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3948j1GW009244;
        Wed, 4 Oct 2023 14:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=YZm0eS5BPCMCVynYBlAQtddu66AV9mRiJKuunkL1Arc=;
 b=XHLkqTx1uY0cM3e1s+8Zo9Yx70n1YmVJPVDWdAjCiIcyP6u7tEq2SBVUPMKbqNo87/Mo
 cctpfVMw8vX6f1MYNp6Wzr2cmPKZUAUE8MheB8FvZ3f6An+jgqkfV6LNQ89EZMwylyYr
 9ZdP/mayIfzJKy88EBhoGg3nFZQWHOYk2XUaot4Hu044qr5NBFlfwEmMjUy+HiFufC3j
 xoIyA3anMf2cAdgkJ/3rA1Sd2T9/T3osbg9OnVCIWwGS2IhJRnkalM4suqKh74FDPY40
 G9rdEoXCadV1rx32hwUBWEt8s7+K3uXVMR+mfODSjCh4I2DKLXRYSYYDubCf/n6kS+oP wg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebjby6wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 14:55:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 394Dd2fO006102;
        Wed, 4 Oct 2023 14:55:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea47qrk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 14:55:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gonmGGFzXt3vhpehImBe1MABWfoaKkaqeFBQ4JcrIjFYIDSJdzTsh0KXM0LpG5iF4Zfhe0sufeelTs3BvdivWPfXvkf0wDWal4oAY9Vi36zm+xWilHXlUHRvxbEuZlOi/jFEWkFyVrtWI+HiDzo+2aLlMJINJQru5mFBCtTqeIZ/HnYzSjoDhH5l3cxbYN+lq//Z9KfeDJ3xFImI0wfLYdnYYGgt4eEGg8HN4PLvzjtRMyYG65hcRBu48oF1Bf4Ug9PnBUriNaG1dzCDce7rAZqiDMXUdtKm13/7jQjp8BD3rBx+7CtChpYTEB3xl64NGWuFLAqzdXEVCysFgu8nzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZm0eS5BPCMCVynYBlAQtddu66AV9mRiJKuunkL1Arc=;
 b=YSwZMol5Es0OV/r5zAmwmF/5cANGOPP2RXWhmb5ofSyWa0nGXj7Te/mSaNYjRV3Ltfiv2SL7KntL+sOJzXQSCF1iQ4P3hVoomzlNkagV9h24yz7xeOkl/LiTpRKMXsY1q/muoCjOHI7+GJlUZtV8wRIbRXqLiTXjUBpX9eE9Q2v286pvXCGh2IGbQlrME4aaXqVZfRIn4hZ3lahlX4OCYb/zHYY39LssO4Pf8Z3gTcLT1pzu/E6pKXVWXZ/7s6w9pnda5pMmudtnQ/ecFzZRENPDIqXuPdweDp1r3GWxXW+2tQ3U4MKWWQBPW8O7fEPJHskB3PATiuSkByA+J/Z4MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZm0eS5BPCMCVynYBlAQtddu66AV9mRiJKuunkL1Arc=;
 b=kFlac2DkQmKJ/JKmRH5+bSgUo+yyI8czH+jqDZCgSmesr7TrpJOJld9kBVHeP4EI1Fe4HacIfSzJv01sfKmlknM/xZDq0khfGx+m8vxmOQI9FmK/248C9dOsv2wjGJ//35WS3IEu/D8Jm3aEKz0McD/2EmDrHV170TNw3n1M404=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by CO1PR10MB4546.namprd10.prod.outlook.com (2603:10b6:303:6e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Wed, 4 Oct
 2023 14:54:59 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::1aa1:e3a9:cfdd:f48]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::1aa1:e3a9:cfdd:f48%4]) with mapi id 15.20.6792.026; Wed, 4 Oct 2023
 14:54:59 +0000
Date:   Wed, 4 Oct 2023 10:54:55 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Wang Jinchao <wangjinchao@xfusion.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        nstange@suse.de, tangqingmei@xfusion.com, stone.xulei@xfusion.com
Subject: Re: Issue: padata: UAF in padata_serial_worker reproduce
Message-ID: <g6gbj5ailv5q2olhhlgpgkr3vuolvbagpf3bff5pxqkpikerj7@qyix5rcdkzyw>
References: <ZQft1jGSMSTRlxfi@fedora>
 <lq67pqfz4ucmrpbwmor7h23x2iafsnyh4yuz3mfrfaxrsqbyxz@wqp5rih7grwp>
 <ZQuTSeIskyDjkiMg@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQuTSeIskyDjkiMg@fedora>
X-ClientProxiedBy: MN2PR01CA0054.prod.exchangelabs.com (2603:10b6:208:23f::23)
 To SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|CO1PR10MB4546:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab7f28c-d73f-4967-084e-08dbc4e9e177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eqNe5lA/i9ftpmJn8ZU8Coj49G60t3ZSs0vtVUTbLCCBruWdcnZeNbk+tAQ3BFymAqbBdL/cu0Id1WwSowAydHKJMV0rD0iTFtkq+e9Ewylt9q4utGdT4LDJwFFme4DxEwNnw6rzJkVxa+fgb+DrtIknkYI85UnzoQuZ2tf3zedhECDMUxXTZkcJC6jRraNjZfpH6SlnSLJUsvNBLepy6JHN+4pp6OrWDovAcR3TNWPKArgWZkdwDJWchR8jq/LlO4WlaUDooqzWUDMzZ2wp9yvAdrbtjVVl6ODRaanTUdMesC0ITAF1pii6ZxQ/Y3d8aHG3+APDWyYEMNN79iYJCdrlZamQOkaE51VMjWbr/i8lTAOGuQRgMxQDHo99xpgHJVajF/aU9CT0hZGV6+s0EOJ+I/E52FpNpls5ANb6DWTiHfCYn1zjEURdtvzr/ud3rdHF5Y7mcbynRW2F5GOpkoI5GUXIIKFFjatZ9RN64PgIIaHPmBnYUsMy4QadBL/Q9ofDAS7Hdyb1dq1Gx94r7Xw5L3k1MZ89icH3Gsp+U+bwG3Oreha9WGWfaQH6gTQrvLo1raTvM2BlaPAL7Cyr9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6512007)(26005)(9686003)(86362001)(33716001)(38100700002)(83380400001)(8936002)(66476007)(66556008)(478600001)(6506007)(66946007)(316002)(6916009)(5660300002)(6486002)(966005)(4326008)(8676002)(41300700001)(6666004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?27RTh6eHh667GOb3B6wlCH9Kso3WgvKhJd8xvbRegqg4Zx2cGudGsNoDIZAk?=
 =?us-ascii?Q?WRKGYttSRCBoivQHDmXUDqg4lSebqHED18vdxBkv9o/tn2s5GxVdeZ10EaJb?=
 =?us-ascii?Q?K76JHxQREzHPjDNlxOQmSdcTTObDOmtGvytJFNBQ8P2IVODxR+HlUMHhVIvp?=
 =?us-ascii?Q?17SemEM4lUV3oFYaDjlfD3hd0/9v1JoIsQY6ycpR6OzFf3ZGt5JipeIh5kE4?=
 =?us-ascii?Q?/fSsYao+fkial30daH6Bra1szwPYFzhuTPQoqWYgd8YFYNACBZn/bhZwKbfS?=
 =?us-ascii?Q?3UH4el/7HpLRfAa2Sy/jYEMWJkpD1UUoY6lVQXosqflkq1TkAJF2ca1GEAxX?=
 =?us-ascii?Q?EeYny3I7oWvO8jjxLJQd6r1J68p/ekisOKYJLMpC/SOW6JbW37AGo2ldQxyI?=
 =?us-ascii?Q?4NjTVVHMjJ9mHC9F6NxbhggvZWNZblXfVZ0ydbpUlfejwbuxf1mgvBEsh4fg?=
 =?us-ascii?Q?gFoLAwhBXGAevcWxpVnwZh/m/55xtopfBau9+IBaT7q7VVLtk8bIiYcYUWmV?=
 =?us-ascii?Q?rgPlYlKsgGK9LAwneFwb0R9j7WH0Jb5o5HqYU8hgGye3Q8In6rya+DgqLLvZ?=
 =?us-ascii?Q?E/7kX0ikaOjrKVH2tHLBSz9dyeKnr0YLF+1Vvdiq+CMkk6Hcvcr9FTk6XtDT?=
 =?us-ascii?Q?XhVUtdU0eLmmL1DxzUniBPOVCS6S5YY7Qw4VOacK6ukuRbz2l5/1o7eERwqe?=
 =?us-ascii?Q?6hoCOkFLlk/38Cb1nV2FtEcm0PtoTvgRff42YMHJfzFcJ1EaWIEpSr8M58hS?=
 =?us-ascii?Q?c2pLxEIw8Keo9t87HZZ7ne8q5rMrlFGu1/zA8gZbOaJWKbTRuI2gtG8iP7F6?=
 =?us-ascii?Q?8OopnWV9ay3UK3WC1tdoO8j5/FBalW9DF7DA8qaEX9DE5e9JnGILFPBkfdL8?=
 =?us-ascii?Q?l0P0ElSKw978KIGOEYXnIfgL6qVoiXL+Yi07aYWj68penjRnD71fdO3CNpCO?=
 =?us-ascii?Q?5WVwBKs2Qc22CyCr+Zl5IQrapZGW7SMDXGy7yY+6jsSxJVbpcib7k9HpvZIh?=
 =?us-ascii?Q?CEJl+Jo9jo2RFLVpZTc42L2qBPWeMiJtv9BKhGR19PyKsFNxaA4y8KnkJ3GX?=
 =?us-ascii?Q?iV5R6plg1XLIGM/rn6MaZNp0rKSSqMI6Wl01ft+HucpUQgHTcfDMu5z2GZDZ?=
 =?us-ascii?Q?tSnwYniys9yNvPu46rpE+z3ppEyCZAIjiT0stteRhbXUrHqZvaoOqW7fm+ps?=
 =?us-ascii?Q?VHZQFs1Kj6lEFMTVdXsZbF4qQ+68ozxjp36p+TvDZeNTITEs5ohv4x1wcTg0?=
 =?us-ascii?Q?eJPvp9gIPGOnxDfbHMw0RH++sjUEiYPXJahB5brfDMUmnmJ+u4d5fO3/JX2u?=
 =?us-ascii?Q?y0zMNb2vSEsEm6uW6wPcVCMtBpS8sQdx8IAEMDIzAIoD6q4Md0wPH2mWqIhs?=
 =?us-ascii?Q?9Z9LOkKBxW6MfUitYY2o4RPeDUUB0/jJ2Yhif4InNPswBxY6XVNXBAIEwpDc?=
 =?us-ascii?Q?oKOIeERr88blnH+p1GHUKMkl4JHV54U8rvviIgMqH2RePpahs9Y45HImWkjg?=
 =?us-ascii?Q?ejALp7IG4JbYJBL/i2x1bw/pxZIVuCqH1xsxi2hNbwaCHgJkCRSJQ07TlboL?=
 =?us-ascii?Q?wHRhknw62EG2KrXchXlxTumMdqkAYyGzIVwXvktjNiWpW4wUB6CE4PqhFw6+?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fK6IBIgtl4N0+eefvGxyaN2w+RBYR/Ufsh79GczZ3FjPDl3aVjY8vxhrm7ZIf4C91ZhmYvyo2ARzFEVf1eWibdYwR4fPu8/7vxfMuCkmW2lYaZJeUhbYnqnBKAnR/J5iNGie7xHJ7A8UZ3euooPNsjmSA8Jg9RMSsvkeP4Qgo5Z47zTtKl65lSz0k4cHog3sounLPA918A0EsxYOGDC4yuslVhkokOp8Wpn7BsUJARxCf+WxLScpxJN9WzRkCRbRVfRXnsFlGeGI7xo1XRwVASbNPZChnX4yKLPgvrN/gKArM5J8fRIzonfaLb3R20YHebZOQsJ1YTcD7iGL/ER6G7tacT7UWeHQ3JkJSzlVPOqPHfZJmKZwzp42CdhxZis6w9WIm3D0FdwCrdLWqEU5TO2i4iqc6wD6949dPO0qlADIWMerRXF+ZzSNcGJ8AJFdUeTQrqwD4ynV9iqrRWnU7iqPTo55LiknSJ6h5gLx3v6XLOgyg3ipHGztn8H93f+eZRWnQzpcAUettOV3X+kvHYWkGOC6yszsHR/jz8m60943IBRIymci7CFH33ZIoeGVxJzABUuozr6kVJQBGkRdMT1dBFfa13mA5TSQNLeYSE+mYTu+XBF0HPqEY+bNr4RGczKu8W1oJHApsi3oI2AMb75cwFYq7Py3rvzWzYqHQR99p03fqJfJhKriw/ANoJyKFGNZ9z9SbnsQS+22quaqLTDXmAt+0owBkOjEBlpIqnU33U6x4TfMx+eHne3Wop4wkEHPp7Fe11CIczMZvUKMIZ1pKairJ4ydyxcrhyNHXuWYGSwlj6ZuU5dWgDK6qznhFNMX56s06+KM4/tkgVeaCzUyUIEOpsh09nCcxwWVdIU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab7f28c-d73f-4967-084e-08dbc4e9e177
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 14:54:59.3596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBsgxt9v2bJChkZFFjlarGnl9yP0k3ivPt8IZZOWUiWXyCeKp8FRT/SaJDozuJkz8KR+MzHbqYaeTLaElfVpz5IW+JKIKl7M2nT9+OnLFSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4546
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_07,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=614 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040108
X-Proofpoint-GUID: H5YT-5JYiaq10DVG242EY_VdHK0jaq7h
X-Proofpoint-ORIG-GUID: H5YT-5JYiaq10DVG242EY_VdHK0jaq7h
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Sep 21, 2023 at 08:50:17AM +0800, Wang Jinchao wrote:
> On Mon, Sep 18, 2023 at 09:21:59AM -0400, Daniel Jordan wrote:
> > Hi,
> > 
> > On Mon, Sep 18, 2023 at 02:27:34PM +0800, Wang Jinchao wrote:
> > > Hello, I have reproduced the issue mentioned by Nicolai Stange on an arm64 server.
> > > After applying Nicolai Stange's patch, the issue did not reoccur even after running for two days.
> > > The test tools used were ltp20220121 and stress-ng-0.15.06.tar.gz.
> > > 
> > > refurl: https://lore.kernel.org/all/20221028160401.cccypv4euxikusiq@parnassus.localdomain/T/#u
> > 
> > Yeah, this series seems close to being finished, just hasn't made it
> > over the finish line quite yet.  I wonder if Nicolai has plans to
> > ressurect or whether someone else should take it over.
> 
> Hello, I'd like to inquire about something:
> 
> Since users of padata_free_shell need to ensure that all tasks in padata_shell have completed, 
> how can they confirm this when they are uncertain? Would it be better if Padata provided a mechanism, 
> such as padata_shell_status(), to maintain statistics like the number of tasks?

Looks like you found a way here:

    https://lore.kernel.org/all/ZRTLHY5A+VqIKhA2@fedora/
