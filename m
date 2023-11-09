Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D827E745F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 23:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbjKIW3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 17:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjKIW3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 17:29:21 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C663C01
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 14:29:18 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9ME275007496;
        Thu, 9 Nov 2023 22:27:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=X7VVIDCLwXiJ1wJNOWGhqxuDDdxZXfpEAWPwuaR3s9k=;
 b=DdUMpQ1DZeW/mo+p0f3kMLdUSztdu+zaMUkmHziJ8WWiYn5JoZIVBXFAloBwBaD5WAdX
 CNZ6FaBJ2SNHjTSLoKKdvm+5VOnVBb255QiAM3wPYGOEkQvg4MMsipAa5DS0bK+gZVRC
 VYkiAGef+iLUOvEautk8yDZRnsf9k/LlsK0ndpP2DiC08yRHu2sGShsUwfo9hDKGMHLx
 DJV6XcZVCSt7hKnxp0+fkgW46gtjF76SJpOvimpuJ6o4P499GuA9Vm3iWoZc+3KCndst
 nt3KROjteNLpBMB/GivYF1cLqnDwz70bpwKS8P/WAxFhDPGX4VIBHfr/M/VPX228GyL0 9g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w22n292-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Nov 2023 22:27:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9KrTx0000641;
        Thu, 9 Nov 2023 22:27:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w2143bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Nov 2023 22:27:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ap9RLyyaQZM7TG545cw8QYWuJmCY5M+cNUzKVomgQUpqZ0OihrJG5D7eQBe9PEIltvcOfNR472BiWF5s2fqaLE5xzJBUQ9Jivqb8aKcLCiS+HlO1kDgQ/3yDnSRZ0Tzd1pKaWiAQphbUEIx2QyxHvtSRVlPqZPwLbYsvka+gU4nTetJZDtwC5mnzZ4sA7kvkQRML6NbhT9XN7Wxzpb0tB5FLhZCNAZzdaE6u9q3CDMMHGnyFXJmjjnC4IF/2tNH7Z6koZmu3S8FzPBv+AU7DmwEarTwYzXvE36AUvuvSBfNe5Xr0JhXHS+Cfp+FCKTtfsR6bsHWzk5aI0samV2W5PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7VVIDCLwXiJ1wJNOWGhqxuDDdxZXfpEAWPwuaR3s9k=;
 b=hv7Wi5wMqT0f3QqvZf58yq04t+EnomTAbxoCRafI85y9msRzcUYkdracQkJHT3xFYkuyiHVUkKBWDyGD+znJh2OsEvgnkxmO2znC27LOUKGFMwgzd1W2nAYBigjfIyNHbn6tk1Yr0FsQqj0f205r+cBi+ltZeBY71QmGLT/eXrjjJR+pNbCPanzOmCihGeYeMbUgdvOf0e9/cDtoitDNHEZElCiyQM84vNkTsa59X9Gxg+aqVt/bXG86+LyywVgxbHIvhEdRS14UyxuuVhA2ODKo7aq4R8rfCeyEIeAeWxjNR79gqzwoM7swHg6spzuaoEAyghMk4zdkjwAS+zHFnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7VVIDCLwXiJ1wJNOWGhqxuDDdxZXfpEAWPwuaR3s9k=;
 b=Xec3o2rwXVOb5k4SZhWGntKdtnO+5vonAcFtF8FrGhmlVq3CArC5eJcBeH4BMZn28KaRAzN9vIYrP6tjrmD1LABR2yJk6DmIiiGWSJYJET4bE30JEkfa0uK3dGE9a1kyA1ctt9HDjmV0p/0SjKIAMMITYwyymTF+7PXyOn3BVY4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BLAPR10MB5297.namprd10.prod.outlook.com (2603:10b6:208:326::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Thu, 9 Nov
 2023 22:27:43 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 22:27:43 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-55-ankur.a.arora@oracle.com> <87cywjfa2h.ffs@tglx>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: Re: [RFC PATCH 54/86] sched: add cond_resched_stall()
In-reply-to: <87cywjfa2h.ffs@tglx>
Date:   Thu, 09 Nov 2023 14:27:41 -0800
Message-ID: <87edgyd0ki.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:303:8f::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BLAPR10MB5297:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf7f562-6c90-49d6-5a70-08dbe1731707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r29pgsxgPq85Z0W/7S63UBgjWO1Uf1MuX/cUomrKOlHl0bAQIKfD9FtZLh0zcdadymVVIEvj2Sok+IP2xryWpPgiWflJWChpOfnyabItBNh7+Lx5O6VmWbMC4S7xF17qJC3CqcWa/ifHNHu39j7JUM4kkE8BPRJ4JXwTc0ctRZhoHmgNYmFXXmT7VlWs10Ag9MKQLUGlb9pi//ipN5TrNv1OCYOOAhVdnTGALLBHDPlXxtxLjgL69hl9l39Qy4p/JJrMeaGOHoYOjGCzM/NNgvaXIFUSzYZndeDPKa6OyYt9YE8RguLHHIRAWOko4UK29cUQJ0N0Or7Kq0ze71dliKQqohiSJMpddB03lLTT+azMy0TohUp4idK3Wm8uQcOdukyLzWWi01a6TQn5hadaCo2eLlAjBgeJR80xrrUiazIJNva4aEq68peAjiih49JOtgBGVtTslzG1jf3PhiHH4JBf6OeCEJnRW73yxU54HZujc2j/k3rClxpUu/lcAqO8lTBFOoOmT1tPdavCsYF/zdBuB1paZn8O4Q11UMmOADgXOWebdL+/i/AlsNi2uaWw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(346002)(366004)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(2906002)(26005)(83380400001)(41300700001)(5660300002)(7406005)(107886003)(2616005)(7416002)(6512007)(6486002)(66899024)(6506007)(36756003)(8936002)(478600001)(86362001)(38100700002)(4326008)(8676002)(316002)(6916009)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ff4Dl/4k89++b/F3qJQrNsbj+2orNvC/mOYZ5YCBov+zUkB1JD0oOimq92dg?=
 =?us-ascii?Q?LIh2Yk8boXrsRdZXR9mOd+CqPGayIg0Y+02sglLqcccIE/7JJVfiPz4FaD2T?=
 =?us-ascii?Q?pqjF90i3oLvU3oXdtt29lb9WTbE/APk5VvxYkjC8oJG5ClucFiIICc+KCZUY?=
 =?us-ascii?Q?nT6iFs7/ist+wGVXfbAuJ/75fNBn6UOwO2clIGDsrd5BFhQhCHWDzHUC7gVq?=
 =?us-ascii?Q?AgyeNW6++ugd3ED/+oxC5arKsxJI59igl4s+bOHfZOOOCZc83ifV6/Yv10VB?=
 =?us-ascii?Q?auwoL9afm1bBsl9h5AUO2kJPq9AwU2pOQko/fBdXzvLHzjZF9FTnE6FXU7Pe?=
 =?us-ascii?Q?NLdt+BGE77AOtbU3G+CgeE7MrdRj86ZItK8HmY6W5a3WxuiwmVFACC1qNFx+?=
 =?us-ascii?Q?J053rC3GK77n13lBbRP7JFVi4Ebdhsq62aHuDqBD/RLRDz5AR24LOgB2u8dj?=
 =?us-ascii?Q?D60bdwiM5D7NYqx7KVS7csGIdsN2gINt86Z9L1qEfJGU9frs8jrCnzOPgSgG?=
 =?us-ascii?Q?V6W9M/kU1F982YutjcGKrxUqDd5VQA9jqX/cSxM9uKrFSjzssO53QlphbkS+?=
 =?us-ascii?Q?3noiynrV30jH0aPgMi1PEQCyH7CHU86g6fslyhdvpdzdjy8z4p9nQR1mPMHD?=
 =?us-ascii?Q?7GbICJLFDtp6x18P+m6qpeFpXhbhq1OUXRUcge5VhPXkf19Dex9gykJO5Iqf?=
 =?us-ascii?Q?gqYwwhJhWbO/wxZ5NEJp0fLfoFQdKaS6BubrnC7CByHutPq/V0kUlISXBBhB?=
 =?us-ascii?Q?u/zdurH2Xc1gGIEg4bdJt93w28MNowCcQ++zVeKmbTTJw6MCi4DG0/vDXmDm?=
 =?us-ascii?Q?eylP+JC2aDWzG8AXVgmHGba5IaKhv66mt8tOw8uyd7MSI2JuB+VGyzsZTDNw?=
 =?us-ascii?Q?XNulN5YYan5itVzTT6XqQ/YovTzGb+1RxQSYrxSUvWcXq5L4DOvwOTWcgeca?=
 =?us-ascii?Q?3BcTfnaZUdEWZo8Lt/i7xo9yMX2neRBviOO/D5pRDG93rV/K427KX/VQQkM2?=
 =?us-ascii?Q?3tqS2aEYPG+CvEWmSKUkOr0uUn+F8U+2hM2mhJ/1X4Kt8SNdeTHng1qYUlVl?=
 =?us-ascii?Q?lEimCBo/aaAvIob5RVZNkKFMPXhAS7TwFq1d21JU2V6jFAPVoxpKcGjIJWM3?=
 =?us-ascii?Q?C44YPtK2XJNc1Yc4vsulNo1XeFaAnwoWFkHj0Phk7lN9/nUkUr0X8H/7i4xe?=
 =?us-ascii?Q?aautVxLStAi0+a1Q9EXaGa5Hz0lk+MkTXF3cb82QBeXvYhViLWc5WXV4s+rQ?=
 =?us-ascii?Q?9+vKCHbr8/62ZjHR7UpYOodcRvVOV5ZllOePn4vV4qT5RGSZkEEVKH9Ha3vP?=
 =?us-ascii?Q?yZ58nIcgulsFKCmdmOCnUMsxsTABtPTvw1X7i91qZUN8cHmIi/VCDE4PPvXw?=
 =?us-ascii?Q?XLi1Z6VcsF8Wf2qYN4C9WEefxKGUDB405AduIcK/62ZV3L2MWkGipMAYIb7g?=
 =?us-ascii?Q?eh4gtu7Aa1U9UelCkw5AKdU5kstt96T2V/OtEcfSmDjWY6LVMfDazRXSqRxL?=
 =?us-ascii?Q?WQSh/FGCatvg2F0VTqCgJ/1MOsJLWQSi1kLn0lie0nwDMpANF7VurvFMzSca?=
 =?us-ascii?Q?TyYnri88tql14VknzGRdyxDLUhPfI0MzZMIQ4WKENGTtPfpPEUJZ+INTyU4/?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?QEW7C6gUJ14Kqyvu3C5eeSob0aHkF2N6gImuf9Ip8TVcmt7puF5Cm+q/2zix?=
 =?us-ascii?Q?UurOo1PmhtWuuT/qL2lVpV2UTybB4LQO/chTA/r4A0RR5Rdzd/HNB+AXZohD?=
 =?us-ascii?Q?sU76OT10Qb0yec2prv/xF8D3DsSVBuRDZ01HmB2RBmGraADb0Pr8Yf7aSYn+?=
 =?us-ascii?Q?42qBr1AZpv5tI6sJKvnH2+hFYaTL/cmyjA/MXdeORym2ZS9ng+KbQHtIUHuf?=
 =?us-ascii?Q?WnR+pO/IIMMqLGtCXJjleEuVDjmy+DTeMhUI2XqWBickpc6/6NJw+KD42dUW?=
 =?us-ascii?Q?g20faClEq0BlFQSlZA7K80RJHsgPG+iE5fAlLbnBMXLj9q34ZWet1O2GWmhr?=
 =?us-ascii?Q?BkTf+5sH7Drl+Jkos43fSrcOqbs15IxlgA2uawx3A4R0Zvh9V85dwIKEULn2?=
 =?us-ascii?Q?7hw+45CbhwYTdFFjO3g1AhWpCweaVOUyVMCcD7otlkxwN55OPPebFcAjNO+E?=
 =?us-ascii?Q?0bR/v/ftPiJ4nqX5S3/VdJYW/DqT0u/g1B3o/bBsdAdyay2OK1gevzmHn/Kp?=
 =?us-ascii?Q?5/kvzKwgjLD5kSHjBqh11OEZT6aPsEgk8HSV7EHWSihTpIgBEmx47oqN6Blc?=
 =?us-ascii?Q?hssXGwlRG2D1eYHe5+IHmduSIgDv7W7yS8R3oS3WTnFBBdavjOrkrrDC/CYG?=
 =?us-ascii?Q?5QzTkM2Zv+Qhswuyo+ilWQyfD5cY4ReLA2/FXauO5GAwsiWlsdbyrlbOyvXq?=
 =?us-ascii?Q?zUhNyx+liAOMD8EaGyFCq5DvP4pyfEdggN+1LjUpAAeDUiYWpYJkFD+htfZv?=
 =?us-ascii?Q?iQL9JS4E9wpHoEsfNpzmhnszQNDl5YCvw2OsCeWbAiAdyw5d2wsSbyf4rXKq?=
 =?us-ascii?Q?Ra1pqvq2V7xQcLySvK/HAUs2kD7VCoAqr317SY9Q87pY6jV1gHbAQTAwvACt?=
 =?us-ascii?Q?uQZx3JWQ8/Bde40AfKZaZjeimfHD2prpr01eePZ2oZE9jTaQt9p7+d46F7CS?=
 =?us-ascii?Q?VOVtte1zUdAs7HCLxhxowbK/yhzRllULKFl5oV1reMC539HNJKeL9BUwczoG?=
 =?us-ascii?Q?cQWBdAbzUYjsKEXtu92RU9tWl/egt1NdlGjeMBGRyBbi04talRHgjHt0qJJ3?=
 =?us-ascii?Q?LVODW+CghY7lURk3aZHBr5AYKjPPrhgEfbtU3zfZfCOFtRPk/aA8gS8b4PM9?=
 =?us-ascii?Q?8QaleCDpbbHunSRoeIy90K/d1ZCaQPH7uBjXYfOlJxK8og2m3KugAz0lUZJU?=
 =?us-ascii?Q?iozGTdiQlSiR/Nu0oyeNCBfcuvmvWTDQweAWaHMdl63EWRxtQAqR8ReR5ji/?=
 =?us-ascii?Q?ORbmboqG+cfARl1WiJHRPeSCUUBK1M5S3buz2ZPh9gbIQ1iLMZwvWtnSbP9h?=
 =?us-ascii?Q?wtVGInu0jMxav+YtB19cX5qAZrl1WyK9h/gSJRKRhnOUw0QXZRZhbwVuA15q?=
 =?us-ascii?Q?PRHk6eFUJzezv7l26YVGSMaV7WY1egmrL8SDFHMI6UZQIcSFBKN0+Ui2qHi7?=
 =?us-ascii?Q?6eDJhWEfWhQjxvHiGTds34ox3Ce0my/j0SkkMp6rEO0jx2BzM+Wib6QOlaRo?=
 =?us-ascii?Q?17k2BfY+o4O9V5TQE/rJvMyt1mvSNION0uKhec/3gpLJK3VzEkgymWmgZQ?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf7f562-6c90-49d6-5a70-08dbe1731707
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 22:27:42.9718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tyHW0+mwXjOh1xzlZGFdFtDTosyxnV908Y8InhAXNkoGyFQ+XEZA4nFRvVEM3hNWfYZ6ot4EAOPveaM5RJEz1u2jKiKjuYmHtgMBpG93+Xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5297
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_15,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090163
X-Proofpoint-ORIG-GUID: l-JqCpufFQ7kHTapdNk2pv5tlKjJWSwT
X-Proofpoint-GUID: l-JqCpufFQ7kHTapdNk2pv5tlKjJWSwT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, Nov 07 2023 at 13:57, Ankur Arora wrote:
>> The kernel has a lot of intances of cond_resched() where it is used
>> as an alternative to spinning in a tight-loop while waiting to
>> retry an operation, or while waiting for a device state to change.
>>
>> Unfortunately, because the scheduler is unlikely to have an
>> interminable supply of runnable tasks on the runqueue, this just
>> amounts to spinning in a tight-loop with a cond_resched().
>> (When running in a fully preemptible kernel, cond_resched()
>> calls are stubbed out so it amounts to even less.)
>>
>> In sum, cond_resched() in error handling/retry contexts might
>> be useful in avoiding softlockup splats, but not very good at
>> error handling. Ideally, these should be replaced with some kind
>> of timed or event wait.
>>
>> For now add cond_resched_stall(), which tries to schedule if
>> possible, and failing that executes a cpu_relax().
>
> What's the point of this new variant of cond_resched()? We really do not
> want it at all.
>
>> +int __cond_resched_stall(void)
>> +{
>> +	if (tif_need_resched(RESCHED_eager)) {
>> +		__preempt_schedule();
>
> Under the new model TIF_NEED_RESCHED is going to reschedule if the
> preemption counter goes to zero.

Yes agreed. cond_resched_stall() was just meant to be window dressing.

> So the typical
>
>    while (readl(mmio) & BUSY)
>    	cpu_relax();
>
> will just be preempted like any other loop, no?

Yeah. But drivers could be using that right now as well. I suspect people
don't like the idea of spinning in a loop and, that's why they use
cond_resched(). Which in loops like this, is pretty much:

     while (readl(mmio) & BUSY)
     	   ;

The reason I added cond_resched_stall() was as an analogue to
cond_resched_lock() etc. Here, explicitly giving up CPU.

Though, someone pointed out a much better interface to do that sort
of thing: readb_poll_timeout(). Not all but a fair number of sites
could be converted to that.

Ankur
