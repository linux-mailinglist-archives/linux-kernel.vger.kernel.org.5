Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AEB799C75
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 05:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240336AbjIJDtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 23:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjIJDtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 23:49:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A4F19E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 20:49:32 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38A3jO5c010975;
        Sun, 10 Sep 2023 03:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=P368rcA+UPoZreAK93mr6tJOo0+Ap3FraG5UcOB3kVQ=;
 b=VUercNgcFtcyrZBTc4YmA5OmO2XqOVEk0h2Pb+tSi8obkc4Sj5zgdW7lZ/jI1WKyoU56
 HaLKjOnVgcIjm2fXtiHMQnCgAPun7qj3vwZjgR7PwvLig7PcohzJYXHqOqgLjiMEwt6I
 esfOnUHLJaSbqDp+9PFi8+aLxbuoZhfJWjWclU575wEe83oCb/eVrVjRxNoQc4DbxlGS
 xeJVRIL1+eu73C48Bv48CkY/HBetFip60W1PFS7Pu95X3w9KCM17fk9vmR8DAOdHyHbs
 b1/YSvgZil/W63tHhf5ZnvzFLgPqo2ywCqZolq3f0Fj8Tp64yRh8/vbZmp46j6A/5Osa qA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t165fg01u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Sep 2023 03:48:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38A02O8p002345;
        Sun, 10 Sep 2023 03:48:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f597mby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Sep 2023 03:48:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEH/rYcEDneRU8t8rrZCygzX5TlUBf4eiWRpX3rLRlK4oEG7/xl4rQZInhF86PCJwpBvgRalFyNV7RjsEx+/WisU14NVyfanAXWCG09fTlpsq4A/KW9hrcxxrJe9reSflRA8cDMa5brQg+F3ZlsIibJmzZsPq7UI9VnppZo93LjvPS8oQ0RQKgXZbLY6FZtcNBeves323jUIkZNx3i4DeMNz934ulC1g/FsnA8TEED5vDAAv72J5SWdf0hewytMH7Yk5X+hp0Gk4oE73YCBkuiEIk00+030Tr8NMeqqe8fK7w2uNU9bhqoLZQpIUXASzAOUfC1L3ZcdbUl0xmuVZIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P368rcA+UPoZreAK93mr6tJOo0+Ap3FraG5UcOB3kVQ=;
 b=MAan6L2Zz/xXgYhH5bCKa/IIlgd4C+JD5moBe2B33oVV9IA0X/cEeTR+73dcVWXCK2bNzPIWAMdEdvC+HPV6cUCvBovn67bhDttv0EB7IKDgoxLgdSyDQR/hRu8CozhGO4hsncWSLODIbyQGotZq6ixucbQLbRoZn5B7X0MIjjVlmPTcNOSU5JGyiExdN3mhjL/2hRVnNTT3W7SU3Otg4hEgB8drcGn5PZPeC4hxKdU/cE8s5OSfrKfieNshKikbD01N6oGH7KYKV+61agHhiq3XDdqEf2dCMfzOzSB6fyF/N7PDlzieO2fIuYyIEW1tUvntoSf0eKzQae2bpCcP2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P368rcA+UPoZreAK93mr6tJOo0+Ap3FraG5UcOB3kVQ=;
 b=lBx2OJYW9E8hiLzaQ5iM7ri7mAxFGBgV7EJn87lqmn403Nrrm3AE+Z5c10quMOp7byhQMA4pQHVLF9M5kchj7fS/M26m/b9t8dVHd9dNk4xqIIsyncvLIg/DnHVLupOq40uQpzLYyYTwanM4716jtAo/rAQ1RxYeOYSe1m7KeTw=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB7645.namprd10.prod.outlook.com (2603:10b6:610:17a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Sun, 10 Sep
 2023 03:48:53 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03%5]) with mapi id 15.20.6768.029; Sun, 10 Sep 2023
 03:48:53 +0000
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com>
 <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-reply-to: <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
Date:   Sat, 09 Sep 2023 20:48:50 -0700
Message-ID: <87edj64rj1.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0267.namprd04.prod.outlook.com
 (2603:10b6:303:88::32) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: 897baa86-24c7-4d81-b553-08dbb1b0d9de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6NxE6qi1h5HsX0allB/ZrBcYeTmYpmncIpRP8RacwcB/w0+mPcvNjAr10xL+yGdixf6uL+bu0HRpHp+3khQieItMfhAnR+RLvMzDHNNq35mYR7i382J6l7AZjxkZnXPTPKnFMPY83A7Qs9aIjwJIQg6pJC2xAE8sOjExhRKEgrH7BhCGXTv7JW93Iy9B1uuxuBfadkgy/W0SLknW3opaTCfGeEEnklIsSQe/mMRAihTHIg0TvWdAJInR9gdd0UkQ1nrDlCdYcyENwHbdtCGRmLJ31L943hG5AXYNGDrVZRCkhwPJZ+XlQMInxjgGCBZ8a1XhuYO92roAdVtY0SEPOgByn9Bxb1SsCKI02KqZl3VkYAk9rkplvY38YE9FDN1ru4ctfx2R4mTn9zfBtxSbnsZ0rp3t37QFmdZE6lVi0vLAXJA86w7qjebMhenPYqz80Tkrgrhq4Sor59alEAaagiNuAD/wgghCE1C1dCGlGaTmGXtT63JOsO7cSqwJ798nZi00DSaAiPs7/u3yNTBcw3a250GsDeU0p9L5HvNyxCQVpGpUdYpZ4BjFiTOKZbhz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(1800799009)(186009)(451199024)(6506007)(6486002)(6512007)(478600001)(83380400001)(107886003)(2616005)(2906002)(7416002)(54906003)(66476007)(66556008)(66946007)(6916009)(26005)(316002)(41300700001)(5660300002)(4326008)(8936002)(8676002)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z8wcMs7iIlf752rMcom3BA72PBjxjBrh6uyA/NBPtjuqsBGo1ANCMZV2G8Lu?=
 =?us-ascii?Q?p+5NFZeurdasULZFmZ8RJ/8daXmRGoyd3EGhjVouzZeMONetPWyicHKI7xSW?=
 =?us-ascii?Q?oW8agnBPA576IdLvWmKi5GYzJlR9rKIrSINEN0odxjNIksR3NmdL73pyCCED?=
 =?us-ascii?Q?gLlBBIxcbhqkVB1U2gnzvVKI7SgR27zEVZ1WhlbJJgAHbqgfz9THlzgp7ND9?=
 =?us-ascii?Q?NPLC/5txr+zLHVq0LpyRDxKVib8WiZJicBgbxCbTlKDedK/LC8RywYYASh8o?=
 =?us-ascii?Q?gc6VFTajxRdmwa1ShXR6M9YVZihMjRO25F7RQ5vF0G90zupOYmCl171auP/C?=
 =?us-ascii?Q?qxLVj+8uUYTM84dQ8/ixtqu8t8ZHEf+Qy5RRW29zzQusSB/FMrpBtWiiLTEK?=
 =?us-ascii?Q?xvUc60UlX+jgEKLVmklMelYo5NyFImKKQG+SLxLliQPnvg4gN9/BcbffIAWU?=
 =?us-ascii?Q?fjbsFNoOe8WFOHo4qF2i/KmUbR4aHtf1dy3AU9vtOvwnewnaUgb3OJ+ZGErw?=
 =?us-ascii?Q?HcgYONLm/34nTWu4Y7v1NHDFuRBGn1WcwBDV68niK8iYzM2C/2xJ6dWtz7tj?=
 =?us-ascii?Q?TjUBNmuHTPv6BHcAzjbC+7a0xHdlGX8PA4QyQ5wCIVyP2Lvv0KgapL1xUSAd?=
 =?us-ascii?Q?6zvwVlsrmnv/Lb5u6vJQJWtLdiRusGw3UhyJDOZ/P2sWnTwy52kdCYdFMOI8?=
 =?us-ascii?Q?SPV59KsmDn6RmpyWj4WIQfl/CD+Ygia/eKiACa84hUjDj/MAjcaGPCaMz2L+?=
 =?us-ascii?Q?IwX/kdGLNbTEr/gpAl+4CwjzTvYDT4RfzmJJ/4wnE6LFP03jzq0apvr433fx?=
 =?us-ascii?Q?+5wPaYXVUJGWbU3Fui8VvsP+YNqD7ThOtztgCv8AObeKx+kNa67f6l6M75Yw?=
 =?us-ascii?Q?moInOQrq6fp99m2gJUmuD4eQ0LlMcD9DYTu4AkiazpANuo8iOEQQTmN9h6ul?=
 =?us-ascii?Q?URPDGqMmclFj2DT1kBtqVDNL4eYlY836pohglZZbUrCbb2b2xGdtpk6kJrnj?=
 =?us-ascii?Q?sXpj4C9gCyy1+youkgy7ZzpuTKwwFBZU4R1Fhkrjaj/sWKTOloL/QZ8XfJhA?=
 =?us-ascii?Q?1qJdY+YEFmdwAnfxLOeZ+5t6jq/Hf1qukCX4R0XB19DePJS4yWRTfYO1k0AJ?=
 =?us-ascii?Q?jbnAofVu+O2BxyBw+O8ieCAPjApBTm4DBL4JUFjVM80ThGyjDuvDHba6V/gY?=
 =?us-ascii?Q?zxA1XeTujg2ftL/FbZzCj/7UQE++gM2GJ1vUJ7HTHROG8SnP0yQ6D8reK9R5?=
 =?us-ascii?Q?KMtAOv3UleU5cDwFkdfjfdgA9BROEnkXs5Ytw3xY8/J4sBLdG3EkIT4vs8hq?=
 =?us-ascii?Q?FHhxxtlC5Gs/J5LWOrmXLpd1Lpkls5M0BLG8vTuBFntWxEB+IfwkoHngkC7r?=
 =?us-ascii?Q?vf0571nwNKYW20jGq4Ki3lyUbVgMJcuLCdmmThSJeSCLiTu3an9OrDqo8kfl?=
 =?us-ascii?Q?ZUMIaqv7Jnr085tmu22PfJO0xmHAbkaF7BBte2+KqzxuZWFR4dQIqKgnmKF7?=
 =?us-ascii?Q?HBnySSTpf2qfzrg12byua+wFAjQ1Uxn7WXW3TRGeGNds7lxSds1Vy7XseogW?=
 =?us-ascii?Q?BpJIpQ1+AGNynbSiOw7n5IYqpxNQTibIHryjtZzs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?8mYUg3V3hkq2jQ72Bh7mZZDdRwA63b3eE5tSFjha9oMVWZUjYDUfFJNHb6Kv?=
 =?us-ascii?Q?d8ZJpfwq61Hn/s9maLqV3vzbDvuhkk0y28eM6IjKRWf1LU5t4dDLjjRZOGu1?=
 =?us-ascii?Q?Z3EP8S+M+JIg82bXjH1eHXBfGo4eLhKR0QMVLJYx4qtXhnb/EPD1gDpvlocA?=
 =?us-ascii?Q?+lv4ovIAzTh75Ql6pnANjQc7Zh05oowCrX0H1hzGo18MdEoG/rXhjkzCP+A6?=
 =?us-ascii?Q?e9eqWZ/UswrnixbDL7dFQb+t5cjteGoctGXs69m7ISmUva86ADRf/MzoMxhM?=
 =?us-ascii?Q?RMh4YQNF2cTdEE8+T1tz1lQGSlzJ7ahnUgXEvAhftnbV2Sv3Gmt7pA8yOmP2?=
 =?us-ascii?Q?fw7W7E7ZptppptBrCUqwkzS38Cq8UTXwnhtY6sSYB+P1l7mluXjQwHp5Ddru?=
 =?us-ascii?Q?aM26s1KP+sk3iVa+O+FBVbIgBE0wMjDovM1PehmY3QByYNTG6kbp7PQPfUVO?=
 =?us-ascii?Q?TzUgMIjHTwWrVfEbzCHUocrgA7YOXV2YcB27srlhUf1I/uU5RcGRQl9+fiU9?=
 =?us-ascii?Q?QgViSKZHLQP6uZKEwK8aPKk5mQ5ev9ctIMGXX4bqSpLkHI70tXrKhix3ifSz?=
 =?us-ascii?Q?rjeMJZhv6vJ02tc0s5Km8Aa1mZKH8t7Kb0B1O4ji7ke37cyOLIEhB933n/sI?=
 =?us-ascii?Q?eLVzNG4rNcEAGdwcPo2/mvEhngIpWzS46jlpyvdm9NYyswPlRyVpq8QqF7+s?=
 =?us-ascii?Q?vpGw3bMnHztCNURh488eNyhFVx2RM+SBvVHlPsDGC2joCh4yiwJOhOWpcOiE?=
 =?us-ascii?Q?Dv9gTvEmcLgQd1AVo8+IvrA2+0dGA0EchOpGZCVkvkIGoDEJVJCIR3yDwsGM?=
 =?us-ascii?Q?ZXakaSpxYFOoVx6tt+U4dD34TzsFNJq/Q3CElwYUjGYI/21JSzV/9drjGH1R?=
 =?us-ascii?Q?0u5BOht+9Tx2QEckF23m8Mw+BIseWYBU9hZ1oitS3omUVaa1jUQXO5m9MVsU?=
 =?us-ascii?Q?zcI2UDt021V6fKlqX7MjuP6fvNVBBQ4tYFZAtfLolA8WfGx5fBFmJ3bqf5CS?=
 =?us-ascii?Q?bPsl4mmJVt3LCGLAT76dCv98nTGxTDUrA9pt61BG29lqD4hOJj5a8O4jCGfB?=
 =?us-ascii?Q?2S3T0QTYgzsUA2xkbEB4iRKlb6AT9GJourxom0w53s7rOlX4qp4ZnFyvabmF?=
 =?us-ascii?Q?66vIt9vIB34vL96HD6fnBdY8TkxmnYByufIN4bES22QEah+xY/Ewpj8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897baa86-24c7-4d81-b553-08dbb1b0d9de
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2023 03:48:53.4209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSmKAzpEh1aq0OC10wDZHxgDgS6t5lod9kdwWJYmhtwU+ExW+811w0AaVz+tmVgM4PcYvrYeDVWZGK/NBhlErPCeSqfLNZBCHsNVX22j/ig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-09_22,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=987 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309100033
X-Proofpoint-GUID: TSwoD0tlS1rjF1h_1RsR1DagMCJbpI2n
X-Proofpoint-ORIG-GUID: TSwoD0tlS1rjF1h_1RsR1DagMCJbpI2n
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 9 Sept 2023 at 13:16, Ankur Arora <ankur.a.arora@oracle.com> wrote:
>>
>> > +     if (WARN_ON(resched_allowed()))
>> > +             return;
>>
>> And, maybe something like this to guard against __this_cpu_read()
>> etc:
>>
>> +++ b/lib/smp_processor_id.c
>> @@ -13,6 +13,9 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
>>  {
>>         int this_cpu = raw_smp_processor_id();
>>
>> +       if (unlikely(resched_allowed()))
>> +               goto out_error;
>
> Again, both of those checks are WRONG.
>
> They'll error out even in exceptions / interrupts, when we have a
> preempt count already from the exception itself.
>
> So testing "resched_allowed()" that only tests the TIF_RESCHED_ALLOW
> bit is wrong, wrong, wrong.

Yeah, you are right.

I think we can keep these checks, but with this fixed definition of
resched_allowed(). This might be better:

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2260,7 +2260,8 @@ static inline void disallow_resched(void)

 static __always_inline bool resched_allowed(void)
 {
-       return unlikely(test_tsk_thread_flag(current, TIF_RESCHED_ALLOW));
+       return unlikely(!preempt_count() &&
+                        test_tsk_thread_flag(current, TIF_RESCHED_ALLOW));
 }

Ankur

> These situations aren't errors if we already had a preemption count
> for other reasons. Only trying to disable preemption when in process
> context (while TIF_RESCHED_ALLOW) is a problem. Your patch is missing
> the check for "are we in a process context" part.
>
>                 Linus
