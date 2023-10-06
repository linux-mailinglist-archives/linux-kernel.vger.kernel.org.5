Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171B77BBCDC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjJFQgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjJFQgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:36:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64D0C5
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 09:36:10 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 396Cc8kp028633;
        Fri, 6 Oct 2023 16:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=wAb0N6j3PmEwf2FVRIJp5NiOMKu8QQ9l9M9VJ05Abpo=;
 b=cQpBZp+GoJtzMRWzFxACwJan4Mzj/ZEU6CruHJL80arEQW6Plk07OhqEyRt5eSfEiPkz
 zYEFWYwCWP/sgWChXV4xNo3KMnwBV45CLb1Zg8xN8rOfFnH4NNCtD909ulBSsItNXwMF
 Xm3R83A4scyJ+CS2uReKasZ5VOZhsyVbwJxlE2gPOqFWmTK38UmcfKuE3TG6dMgcOha7
 EFck2XXk/OGJI+jBTkbd8dADcT/SN71Zecy+PtPPPNRt3pwVEDyMhFP0PSuD7NPUgswG
 S0bRY0lOtCoiCs3TCiYWYaETPEgd5zeS1ct9+OvGKO4cXRXqZeDec82QONk6wrn3cjaX zQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea3em936-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 16:35:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 396F1Gdv010517;
        Fri, 6 Oct 2023 16:35:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3thcx8r1tq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 16:35:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=em1QlTpj9rN9/lEuw6wAnanKJbmQd5lIKOHSU/kpaRhItc3tyoyfflNx1BVCPZUhw238viF+Swj1fOZkLjjvbj0ac08m1QcyDVyu4ruvjsLJaMty5StY4eq7MqMqapCni/Wy06oCIAr/flj2cJP5bJsNvwORUVYOlBuXMFRvnD5XJDPLGVQt8Zzg6RrmwgVMq4EMIR3+j6VT5JnbecReFGSD0eCK+BV/ymVuHjZxNFV6bd7OuKloKwVofDyQ4eoYwQ2DNgHsohokLxhqS1K62nt9OGV4Sz0zZjVoPbMeeXCUQV76V1qUHauVP1GTW55xAmOzTEQSD/CP0lrjuEexfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAb0N6j3PmEwf2FVRIJp5NiOMKu8QQ9l9M9VJ05Abpo=;
 b=fD9FE0ZGUeA+0FvVas6xKDzY894Gt7fse5N5jqxg/lf+YP+C3hOsMH6qV3789cEo/I1pa4Ffzt3v0HF2y1gEjFahbl2bl6srZ5tdXE6pipDTfHkCLDW3gp+bf6+C+qNJL32tdixmIuhKxSYVYSUGxv9yRqwrMClpQlTqCD3g+95aWrf7tn51umlFogqzPzYcu/Iu+fGoGzlYqqJqDy0wSUFPay7xMiKGyJxOwIGMaZIRX8qgvluBmQWn0ZFd5qcPsPU9SOGzd/jFKvw5OGRDVSMlLyF0CN2x2WocC+Z779A7LPuz4oKGilxmOsC4+KkpE7DKB8aKJQAMHj9xSycuUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAb0N6j3PmEwf2FVRIJp5NiOMKu8QQ9l9M9VJ05Abpo=;
 b=IjuS9cPmQhNilxDcPiHK43+tH+emF7CfkRbPHfckrR085EQ1cMgCavoU23vt13AN72exj31+hg9vVFOmAzqRKhEiSxGd7+wxakDyxrvlQsJsy9PFCaY77ip0oqmaqvWnJp9yNL6ElzFvASA8dKLQOPZ0E25ZEDHSGxmLNKGegfo=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by DM4PR10MB7525.namprd10.prod.outlook.com (2603:10b6:8:188::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Fri, 6 Oct
 2023 16:35:24 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::1aa1:e3a9:cfdd:f48]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::1aa1:e3a9:cfdd:f48%4]) with mapi id 15.20.6792.026; Fri, 6 Oct 2023
 16:35:24 +0000
Date:   Fri, 6 Oct 2023 12:35:19 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     bristot@redhat.com, bsegall@google.com, chris.hyser@oracle.com,
        corbet@lwn.net, dietmar.eggemann@arm.com, efault@gmx.de,
        joel@joelfernandes.org, joshdon@google.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@kernel.org,
        patrick.bellasi@matbug.net, pavel@ucw.cz, pjt@google.com,
        qperret@google.com, qyousef@layalina.io, rostedt@goodmis.org,
        tglx@linutronix.de, tim.c.chen@linux.intel.com, timj@gnu.org,
        vincent.guittot@linaro.org, youssefesmat@chromium.org,
        yu.c.chen@intel.com, peterz@infradead.org
Subject: Re: [PATCH] sched/fair: Preserve PLACE_DEADLINE_INITIAL deadline
Message-ID: <i7tyko4ihijnhomxbuycifjkurscg7n7grebxwz4tanpfzuyjh@tq43m6wtzyx5>
References: <20230531124604.068911180@infradead.org>
 <20231004011737.188682-1-daniel.m.jordan@oracle.com>
 <6b976368-9ed9-e2a9-a725-2f8f7e76d401@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b976368-9ed9-e2a9-a725-2f8f7e76d401@amd.com>
X-ClientProxiedBy: BLAPR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:208:32f::33) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|DM4PR10MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: 297e1e0a-a405-430d-04a0-08dbc68a3d3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: skFvZqZy5QT7LgfI6A+tC/VCUIkOleNLQF+abnOFd+902T3n7OvwUXZtJZx/MOi9nSVbY+b7o23FGcTlF+kZctn51HcfbR1qiMVmBodI3liYhCmUi6usro/beunT+yZpjBg0lY/x94Gu2aqfTVXzpburjH0QZUuSnySYeRVxsD2XUE1741c+jvOYQw+B4Rd59x9Dqv6F38uKBemxGG+7ypwxA85x2+3Et1RquNG19Afv4xosuBcw9evg8wgAnK3E5qphk6N9pFfe9qlT8IFGywHMeEw81iQXzZNRNuQB1kWHKOW52O0N2YVy1rqfwni+2uELRCI73NgiZ6rLlsTouJTuG7cTjKKCi6pIJR5rCvbZTk0zDOwvXoBrrzO7ycg4Pf4yYafclmrpudYG1CUHZ83MXKuoBahpMmD3jp+B1E/hNTj98TtHSA4va4kaH4/gWyKhcOly8XBufn4jIfShC3JfCxiqxsIz+/xo9PnhR/3lhwLjGCiUl463Tridnm1ywWQWNGoGCpnxMaXuiKWfElJV5Ld39c/3sut1hBAkr1cji/G+kq8b6sbabxxwImu8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(366004)(376002)(136003)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(7416002)(8676002)(5660300002)(2906002)(8936002)(4326008)(41300700001)(53546011)(316002)(6916009)(66946007)(66476007)(66556008)(33716001)(26005)(6666004)(6506007)(6512007)(9686003)(83380400001)(86362001)(6486002)(38100700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OHbMyj3M2bkx02vAlzG/v1KFLna8mSZn4mkxTtx8IE0sl4pWJ1D0xpKZf+yl?=
 =?us-ascii?Q?5fr1Tj5tE8kxkkYVFSwt2PDj6WlEF63uoQj+4r9rr0buHCIzSED2QfinTgST?=
 =?us-ascii?Q?YReb17MwC0WnRUA0e7NlFLb1BdJqhNkFuH1YoQME1KDLdegssLF3ayMgxD3S?=
 =?us-ascii?Q?e+bQhfuq+OELd2wBbu/BEtc/mGLy5EmSsWGON7/kJrwctKjMnOVtDUDrtye2?=
 =?us-ascii?Q?gh30iiqXwH+AwlnW0hF0nKyzV5Ek1QTVVgiGFgKz41AEOy+OJ7OdS2bO4WLq?=
 =?us-ascii?Q?15UG7w64JXdnfX/kvAz+Skesg+XBAK8B7WkhYSqaZLCrqtxfOZWuMjx67Ht7?=
 =?us-ascii?Q?cCHOy7f5uy5YfY84MQpdEOL+EYSGoHiOpbMU3ZNaN5YaccKLovP1w2Zs9Vcb?=
 =?us-ascii?Q?PdPZ5ooBnTqWPOgwNAyxzKGKhcI1vmEemHmvqQnMSqhowD2KehnHlR7zHKjk?=
 =?us-ascii?Q?R0xDm5jlwYElYpaTgGsJ+fzNooxTSKH92EWrDeOHYEYP8pgO+ewYX3f5mpVm?=
 =?us-ascii?Q?im1AHBLYuEvLbm8lg/1ZzzDb6zrRGBvmiDvPl4uc3Ab29mt13PEVafwqe+2h?=
 =?us-ascii?Q?Nscz3zGAdDi8l7DCgZL+7yLecla1FAE9Te/LGTx55oi3y4QpsXz64vjHLSNy?=
 =?us-ascii?Q?Aq3mZaEp2S5deNa3synKC6FYBWimcQH9bUuy8hzLr9PzJA3EgSESUKln/JP/?=
 =?us-ascii?Q?Rn3iE+HT5C3FZvSTfYoM4NY/EPuKFdvauiOwolED+02lKu6WI6jbxVsGv7N5?=
 =?us-ascii?Q?gtv1zI24s74pgqomSiaA9YVv8Y/9VtGyvtuAjFYvQS+CY0VmkD8juzOcZ2qB?=
 =?us-ascii?Q?r28J2VCqz62jWNypbyzRHFT/+yIPZGhpCRbwUdJeOX908GgjAoSXacaMzuNA?=
 =?us-ascii?Q?gN/AR+PnjT9pVdpbvKUJzJOUz7+iM6Zt2kYlrZueOsuxmDg4EOK27h4cgTZi?=
 =?us-ascii?Q?Ir7iN3oeJ6um7bbGtTMvCYMyzaDcB5LUPeidd3F4vYFy7F30f/AXzXxzstyn?=
 =?us-ascii?Q?F8UiHV9KfPZaSPeKx8OrfQc7Uw+6oHSaF/1i33Oht1A8+/e4fvpbv31f1oMP?=
 =?us-ascii?Q?szvSAsEIuwIAIsBLsYg9dDT1llv4AZMQNUWR9CQDAZ0OiPlLVoz5e1IianTW?=
 =?us-ascii?Q?cJuX8Ld41p+6bDkWpBOEzrpEk5Q2f05myxgkGKpZ7/nJEFIIg53OmRlL6cV/?=
 =?us-ascii?Q?yk1l5UowNuJlCQlxF/JKCwWZGOoF1DoelCcFyVin6PxTZhts1HVkJtMfGT4v?=
 =?us-ascii?Q?6j5haBqTS51LINa/+NAp4hIfYNvYaaDT5iWltjMkAWoWwPuhlyF5Jj2ljYcL?=
 =?us-ascii?Q?aFHIGlRWsY558leph/Mw4xEa+Bp+LAPf15c7VquHEt4Y4NBXgoFUiVV+TNWb?=
 =?us-ascii?Q?dJhtjM5SjZYx/CPbAj8YMiyjKveIm1wlTL161fGKar6hiA2zjR8DWsVMkcUJ?=
 =?us-ascii?Q?s49Sjj1PADzU7FXAh9DM9qHnQwlDDG8mP1Zd5gJHVbqmRHwepFieOToz292g?=
 =?us-ascii?Q?MP2lv8A8lmvPbEb/E7mgjjTp5B11uZ0c1y5tJir32s5HkymVedReAcPsIhKI?=
 =?us-ascii?Q?P22quA0Jn0KBH1moBq50jiAEkwmmkLhzrlW+m8v5CWuFO4U4xm6n66Z4hkEZ?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mlaZNL9mBbMvfuZpAlDdJGteIkHUjqShoJREA6ddkVzs7Fw0FWPtYcA+KrGD?=
 =?us-ascii?Q?upi59YaTyvjpin5RIb9CFm1I6zA0ZVjhIjFKVrTYUDIY+BGpVgf0wGXafFja?=
 =?us-ascii?Q?nH2B1sEbkUxQYkzxUiNmURshNld3u26BEH8I8rvJJahWbTygSa57j8UFTmBj?=
 =?us-ascii?Q?dltM49HVgwrEG+QhoHuE/rUwH3wG2Q7mQiuoU3V6jxoN+qZyEarKsRri/PNd?=
 =?us-ascii?Q?h/ANhx8QOBVQQNUFLSH934MxKTtMvd1cHK608t+v6jfJEPdlusKG9cBdLJJw?=
 =?us-ascii?Q?TOpxHSFH0hxA9hlLn+UBfAFYghvAdaRe21Di5rxT5ja3Rb/4/C/Txp2cTL5u?=
 =?us-ascii?Q?aOOgdmPgaDSeYM2mIKtkrLgmm0GnHcL4pXW3iDQ2MuG1/rnn+xMeoB3U7Ws0?=
 =?us-ascii?Q?rvxfJPAjtbjBkTr42gyb2dZtiXPAwL6gC7AF9TIpP/Ia5aD6uF+xGVym++wE?=
 =?us-ascii?Q?6IswXcauJh+rwLZMj1cpRw8potAWd2WRKd67CK9vvIyVxZkstZkaHMLOOOmD?=
 =?us-ascii?Q?g+7mGb2RaovHje9Ehl8lI3iciv9ZYmgBGEpLkH0dHCpWkV9DDES8my4i8fNh?=
 =?us-ascii?Q?pKVwh9bVBoa45Df+RW5wvbPxo4i3A1yd4poNQof8Pi8h8SoaaWpz9erkLBAI?=
 =?us-ascii?Q?dxMJMXWAMy31Vv/IOz7v1o1V+n2Kta1XCBG8LGCGl9R3CgKcLJ6vIgYL2Mpg?=
 =?us-ascii?Q?GoTtszWCkz7GwdHgbWTaur8KL3O772LneGI+xbjgzgsg1tXhUe18YMiC09qL?=
 =?us-ascii?Q?aiULGkvexP5Vn6eV/Rovy+Q+BTgmE4kcnLL50KftqMF2CVZ9P9zLNj7Xpp5T?=
 =?us-ascii?Q?8//PN+ZffQGrOaQMQp/b/wVutYeCUVwq6DoXH4b5NLRWEE+8NR5SRAiJhwT3?=
 =?us-ascii?Q?ZRt4DOMriD5VX1P1VYJPzDu0gVIR4U8VR/TR8jl9S2DTeY5FWFPI/Pvw/kcP?=
 =?us-ascii?Q?7kXflggnbJ00n8m3Y+JnoZT3Rt40RxZ8CmcWt9Bifwew2p6q0AQqciAFoEl6?=
 =?us-ascii?Q?3KwKLKbU9XwQfEmgcA36bHzRNjCTZVAg+c4yphdKWABXkZ4q8J5hgSnjBnL8?=
 =?us-ascii?Q?xDL5LqFpfE9buXE4Q7TeskWZSvUEAakuf8vEnmjhFY0aTLJ3h9VnGWgws2Wu?=
 =?us-ascii?Q?VZMCmbI/BVZuUO2AgIv/dMiagKd1Ibf7N6TL/99i4iqUHi6OqboI3+qBP5Vf?=
 =?us-ascii?Q?ilMF05Abdpe1T+67zdDi4J2IAGvxNMoBfF0sdTodqkmCxDv1x5c5feDKOY0T?=
 =?us-ascii?Q?bTD8IXZ2NWmYbW4PE0KtGlt/jwo7z4hWK1nbBLU5NQBNnyRwAu4o/DI9VVJB?=
 =?us-ascii?Q?vFTrC0Fh7+R0ik5MaGcOek5pUQBP4DgtVLYj6lZj+JlnEQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297e1e0a-a405-430d-04a0-08dbc68a3d3f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 16:35:24.0370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAvc1Em9yEx8D9Vly375L1+V5PtiFzyH7QEFgrHI5uJziYThMOETV0vHYy/RZiWul4sucz9QZRfpJa1X0k4lRopaG+9oGDSEBnC74i05n/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7525
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_12,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060124
X-Proofpoint-ORIG-GUID: pp23BNJaxuZueLz30wLVOkorPrhWgT3k
X-Proofpoint-GUID: pp23BNJaxuZueLz30wLVOkorPrhWgT3k
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prateek,

On Thu, Oct 05, 2023 at 11:26:07AM +0530, K Prateek Nayak wrote:
> Hello Daniel,
> 
> On 10/4/2023 6:47 AM, Daniel Jordan wrote:
> > An entity is supposed to get an earlier deadline with
> > PLACE_DEADLINE_INITIAL when it's forked, but the deadline gets
> > overwritten soon after in enqueue_entity() the first time a forked
> > entity is woken so that PLACE_DEADLINE_INITIAL is effectively a no-op.
> > 
> > Placing in task_fork_fair() seems unnecessary since none of the values
> > that get set (slice, vruntime, deadline) are used before they're set
> > again at enqueue time, so get rid of that and just pass ENQUEUE_INITIAL
> > to enqueue_entity() via wake_up_new_task().
> > 
> > Fixes: e8f331bcc270 ("sched/smp: Use lag to simplify cross-runqueue placement")
> > Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> 
> I got a chance to this this on a 3rd Generation EPYC system. I don't
> see anything out of the ordinary except for a small regression on
> hackbench. I'll leave the full result below.

Thanks for testing!

> o System details
> 
> - 3rd Generation EPYC System
> - 2 sockets each with 64C/128T
> - NPS1 (Each socket is a NUMA node)
> - Boost enabled, C2 Disabled (POLL and MWAIT based C1 remained enabled)
> 
> 
> o Kernel Details
> 
> - tip:	tip:sched/core at commit d4d6596b4386 ("sched/headers: Remove
> 	duplicate header inclusions")
> 
> - place-deadline-fix: tip + this patch
> 
> 
> o Benchmark Results
> 
> ==================================================================
> Test          : hackbench
> Units         : Normalized time in seconds
> Interpretation: Lower is better
> Statistic     : AMean
> ==================================================================
> Case:           tip[pct imp](CV)    place-deadline-fix[pct imp](CV)
>  1-groups     1.00 [ -0.00]( 2.58)     1.04 [ -3.63]( 3.14)
>  2-groups     1.00 [ -0.00]( 1.87)     1.03 [ -2.98]( 1.85)
>  4-groups     1.00 [ -0.00]( 1.63)     1.02 [ -2.35]( 1.59)
>  8-groups     1.00 [ -0.00]( 1.38)     1.03 [ -2.92]( 1.20)
> 16-groups     1.00 [ -0.00]( 2.67)     1.02 [ -1.61]( 2.08)

Huh, numbers do seem a bit outside the noise.  Doesn't hackbench only
fork at the beginning?  I glanced at perf messaging source just now, but
not sure if you use that version.  Anyway, I wouldn't expect this patch
to have much of an effect in that case.
