Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BE579C162
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjILA6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 20:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjILA6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 20:58:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5FA144EB1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 17:49:10 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BJwh10022398;
        Mon, 11 Sep 2023 23:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=s4UqAn3TGIOnCa7+Rw1a5zMWGW+KKaz5V15nkisenJo=;
 b=ce/0euE/6MEVN84vAybK2yibyVh0XB8aZo31whXbL2G3B2nmyXFBVt6mzsy/Sp+tPN+a
 w2ZfBFpp2UbC3Mt5vp09e5ADA+tXbwj2/L52sYj81335McuBa87CACG96bBlaRBPos0O
 ENTJTNoOsUSvpjDKsfuFz0jw6Yz3W3gLsHHnNiE1o3YcC7SOJLU6ulvvY+ANq04HiM2K
 FYNwQmjP0rPiC5KimF42d5UhSrCYg+xmLZpbYYVmcnCQ7vrjeJq3YDRD3MuWdJNqPW3+
 FyfJtYL9+TKobzBh0gHnDwUGWlwLUamGX53RtpCLVAMbidfsB/jw0bH0ErzdoUWsKpTp 6Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1k4caknf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 23:10:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38BMett2007794;
        Mon, 11 Sep 2023 23:10:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f54x997-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 23:10:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNPdOGcwvLQA202BwCkA0KqSrTsEcfCGTqVrAKQR87rmux99RplH0EBdmpRrEqQmMVrNXdMNhYWesOwJwryNJZeF0aLVbSvOXdOSKi7ph4xMBixE48xsFwfo9df6Nk257u74jZhdZHnqvjqFnUHGKmsq0ox1ftfHj3IGGPoXUwnPJgW+NOo2uzDlZ4c02nI5qK2zu5PFida/VX3jfcb4pQkY5F84Ip36sZG4oG6mKT+EAbCYApihKIJOYfprkdjaI2hBmfkF/yvOE6aE6VxIw/OGSwNDUjsU+tKZyGvTMI1Dcf8nbLe8EHyTNsjUnF2hc8GeUg8MZs1L5ABrsT/0qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4UqAn3TGIOnCa7+Rw1a5zMWGW+KKaz5V15nkisenJo=;
 b=CIdyl9AkTMU2OPReVvUSh53ij484lBGNVrGrOHRDxGhsPA1yrNoh2cKilNL6Gfvh/j0XVHAQ/u/+bHw3WHvka73nINZ0lJvC3AWir5qoqmQ8iAwYIXm5l1xws7mSUhzCAIfBknQuIgNe/B0dtan8QXuMUa8bJQAObfZdz81bBccpxaz9D0EWhr2+WqbSIvUtcMjAkfueAijwG8OTqsQjYsZ46zuUBu6TpqnPhVAA+egiPgBbSiZ0NBf2MNK2UGzJHQK7X55aSCxCcD1TL/BtxvVRirI/ca04nV5nQ8bv48LiFGcsKc//aq/j5oEyPan2iT+q64kp2ngCKDsOdJgpog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4UqAn3TGIOnCa7+Rw1a5zMWGW+KKaz5V15nkisenJo=;
 b=udJgjhqMNNotU4tjMdNIf+YzCQf6AyUq/0Nrnz1ZG7sEQXU5giJg7XHorOypmYUtAG8z0CF0ciLIwcupV5gP/6IMlNEbhoj0Yry8XBLOhRPNby/2lZJ1hU5TZY922zwVXjMiw7eNrkYwGvv1elQpX5RJo6VbjknYo9CWBPCxDOQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB6172.namprd10.prod.outlook.com (2603:10b6:208:3a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 23:10:33 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03%5]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 23:10:33 +0000
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com>
 <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com>
 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <20230911124856.453fba22@gandalf.local.home>
 <CAHk-=whpYjm_AizQij6XEfTd7xvGjrVCx5gzHcHm=2Xijt+Kyg@mail.gmail.com>
 <20230911182012.7f1f35c1@gandalf.local.home>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, tglx@linutronix.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-reply-to: <20230911182012.7f1f35c1@gandalf.local.home>
Date:   Mon, 11 Sep 2023 16:10:31 -0700
Message-ID: <877cowz4pk.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0099.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::40) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 763229fb-8a35-4738-51b1-08dbb31c4cf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AoHZG42r4wj8mKoHWfo9UH3IMTeyYXJyHy0cQ6wi/xMVEicn2kt1J6Q+eqWorr+F5IdTe0PT92TiMvZDTkyrGlBQfbtLktGU8nCxN/rGNe3j7rqTsMSIM14Rs0KvtFDhnfA7t2e+Z4b4cOw0+/EW6EeEGB3BXBBm+bBIvt+QOOwTjD5FJ4pSoQyg/w1cMhHaf2L9SsnIptd/Su0AUb4stIb63yweq4F+xBswQtWJfWAhMGIRGYxWHWp0OUDc/sa9LyzOKZLNCOh8u2vArljcLXgaxxMSBe5Qa99BKt+OQVKFmbUhya7TwKrgpmlU2a2n4iSvbZ785yU0NaKy9Nlgqu1auya+9hJkGnuawDT7xErldj+HJtcLPJOV1uTW0NLzzlP8drG6DUKItZg3bWaIbXKA6JS/ayqwgbiWkLBGXF8ZEtuy5qyhsFewsSjkZA5elDJLXdppTDXP6pFQGbzjthQA1Kab0TzbAcBNYbg24+r/Mg/CQ9px/u85+WyZlJ4kEKPYBEbx8VpMP7o++YXG9y1UJa64u5gzvNM+m9h8nsTSs2g+NdmDa3uNSlq5xJwq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39860400002)(186009)(1800799009)(451199024)(41300700001)(6486002)(6506007)(6512007)(478600001)(83380400001)(2616005)(2906002)(7416002)(5660300002)(66476007)(66946007)(66556008)(54906003)(6916009)(316002)(8936002)(26005)(4326008)(107886003)(8676002)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Cp/BUwF4XokpzWfiwDd1lffENMymQTw8/lQXwz4cZGSN0y1qitJdFsleEDl?=
 =?us-ascii?Q?DdGna4RaRRkgLjATmYMIqiubuqmOkdUn+x74wiq6fGaGUSN5KXwDkSowW2qq?=
 =?us-ascii?Q?gXlg5KkAulAf40cfMO76E7bhxcIOWXPjQ17auVDjGiNNmBV//e1pMqFshoR8?=
 =?us-ascii?Q?mDTRc8JmAInmiZ+GODyelsm70q3KCuW9J2bg/fohd/hgXdilPRe6UIgGeody?=
 =?us-ascii?Q?Q/15SwO0lKuVv9q5EFWlYH+lz1/5RAqyRx2Heh0u9XXy41T8trn3CBrjcZyg?=
 =?us-ascii?Q?30QK5rbbVkeKl9ZLI4uCm339fWJKW0ZSwrT1Kioin/b3uyAHMZ1P/dVjRVzM?=
 =?us-ascii?Q?p0GMgzkyWhV55Q1ceqDOsqwZJMtzwl7Go+X4jbCqAWtriP7xQYMmnG9uzKSG?=
 =?us-ascii?Q?+zFZO4fKP43l5Bo6cp0KpgIttqlKMLLlbxxPeLEiaxuQGC9M7An4joIsMRUF?=
 =?us-ascii?Q?U3f/3mOj4GSDUwKAZshzBYIrUuMe00Z4lZuIVJsrTjEsQd9nYnctIWBm0aIV?=
 =?us-ascii?Q?8DvrbJkAwoY9yTHUJvs6m+LMXQtAP6ZVl3q5+oCX4IPgQXDXtZqUSNnEQirM?=
 =?us-ascii?Q?B9E9QT9ysuD3XykWTDnbOSfwbchWhJdJk2lyhUYhS42m4yo8vHpoEW3xOEkR?=
 =?us-ascii?Q?lfXeHZLzkZGpSYX2CojEzLk2vd3Bx2iuMPZoUD5AU/GqXWj1Hl11sa70af99?=
 =?us-ascii?Q?4CWpte+aNJg49/kV5iWR/2C6P/e1JlP47x7ZEqHI0tztUSGxZNN5SgXqfbTo?=
 =?us-ascii?Q?2B9NeMlvs0BGoo2n44FkX1zANy/KBdOvPvS2M79QKv89bp+hK2eSUQl28Iur?=
 =?us-ascii?Q?0zosauRuz0/2PZp2ArGhcrdNO1Bc69ftGZ7nAZ/3UDSf1q8m+JshvqkZiTyK?=
 =?us-ascii?Q?OJF8u3cDOjgekc0KD1mLMM7RKlEW900F+04LyEwarxwjUwVBh1TnWkszaA3I?=
 =?us-ascii?Q?J7+bw+fmYk7UcxFuciwfHxbyscrUDM10Y61niJdBcyAZa+57KAASLZV9pWoo?=
 =?us-ascii?Q?g09Om5jLuuS/yPArYOa8gHdAlYaE3ZgcXPZxQgt+BHYMyQRaQyTsa+DKE6fH?=
 =?us-ascii?Q?L4ItbmTrdyJIy1oK5ESwEKunhs29BBS19OrZyEmN4ejSlnBqCqdIFYeEuVOx?=
 =?us-ascii?Q?3k83ZRjcvbSASPA/C57fkBZQZ/b0D5SqmVfQMLreysA53cSrT8AHIJubtYqV?=
 =?us-ascii?Q?B/uUaltRQNSJ5l+6Z2JMLHyU/ky2WprYxNZURVGKCpqfOzI6l+NOvarPjGDa?=
 =?us-ascii?Q?mLAkBRk3fWLnpwqtT9u6idzkKbKPFwZvpoH+9LG5LfhY65JnODPxDjJYqAIt?=
 =?us-ascii?Q?ltNqRxp34EueafRhY9OihKDYDE68rONj2opwG7uD2UHZxD0RwO9hjzYOCF7C?=
 =?us-ascii?Q?V/O8XNmPCBdoh9l6wTHKX8CdEY778G5tBFoX6xg/ueOn1yHx6Hg0Yy09Mw6k?=
 =?us-ascii?Q?ikljZh23vxS60gAcaTOlOZtroPrBHCcVS4SzhboTtzKoAfgdd5XGkDlTNDkn?=
 =?us-ascii?Q?JKGCA7Qu9cqpHJtj4R5EZdZ5rEdF2vnfhwKNH0En11GGXdOfX3a9EQQGnAki?=
 =?us-ascii?Q?A5OB8kxYKOqVQQ2aYC9yaEDnGqhTpn+iB0akysUnT/+cwbry0PzbXfMCPQi9?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lhBhqCNJvVKM34ft8dnGNrZZrVJihOGK+JVspSe3/OAeSYgAvn+pYyK8EwLV?=
 =?us-ascii?Q?lwcHOVR+cpi6lcN90Pe6DZDPRyFPAO4T+qrMbrndOIyA0AdDIKspDPZMV0K6?=
 =?us-ascii?Q?sU96ycpShbYLYTTlWkgU+wsGmxmAp+RKPHA5ZpEfCwKQJ97J/2NfhyHuvrNN?=
 =?us-ascii?Q?kQeuOcyhCugQPXRzxsT6HtuSVR66RRv5Bvw20Sy2oy7VByX3gfww2zJU/iNf?=
 =?us-ascii?Q?edJQfTcWwx/2OxmGrk2+gPqX/z02UHKYGvE0sZRnYj3LNoLK4GFxC8EpVTJ0?=
 =?us-ascii?Q?MT2Tmm4hGdwHzP4iLMEqxMjbyT6HZ7Hufnf4I1jNaZ44sWrCatw1y0mZ19eb?=
 =?us-ascii?Q?chaRLfAi/D7olOSWKDZbi/6izcFQFkTnlH6WvMA8ckFyZMCikEm83DjpeLCd?=
 =?us-ascii?Q?biuQ2Yi8Itiruth+R0htwtkebIZCltdMNhGtmJv2dCgHwReN92Aam6qbxM/m?=
 =?us-ascii?Q?zgsAJXJeEUbVH1PJm6ltCgaYEeE2UBseSepfX4XGA4WjDWT/b5KKmxGZjaYz?=
 =?us-ascii?Q?IuU7FeG0lAuB4NKNYWns/uSGkI+3Ds2vGMGZXiF2wWykRycrMDf9Djbi6J80?=
 =?us-ascii?Q?emWpgcFEbpXKDWlI1reSPOWT27nAD242sTXcSeYryiSHtaSgnu2Kdj55AdaP?=
 =?us-ascii?Q?jCLt7GIFrTv2Wt0jAS8HeAPAhC2iak4srcrbKK1DOuXesEjmfdHR3rBCqaYU?=
 =?us-ascii?Q?Z0btRRJ5faya85XpRJL0cE4TnM8j21KlDePYTwqFGLEvzodIhflFLJgOZJIf?=
 =?us-ascii?Q?7cx15CzRHPr4RPqlJIGi8iVZpyxzyhR/AcX91FdPYNNr5hqBi0BTQhY4FqO6?=
 =?us-ascii?Q?mFE/GuEAV5oFmCIJuMd7HRLBYFAy8opOkXQLcqfp8M2f7hDLdndJJuq7NDzS?=
 =?us-ascii?Q?SK5IRQthZeB6LZFHPZXFcZrSGyHr/iIU3lV//aiiIbM3dnJFyAXhoydvKsqd?=
 =?us-ascii?Q?uZ6nRz3w9mH6fA996Ws6DT8FuuL6+7rxQ9/NNbJDw09p8ZA+r8PPrs2phYID?=
 =?us-ascii?Q?VMv+nmEiV/jTKLxxLW9/WWzbSNo2wufdLal/nGK6ZBXfypSA6d7a5yMaGinc?=
 =?us-ascii?Q?wGFs8EWwlDknWICnCTA2B/H9+GzZZajpqH+QPIdDJQoLHYX3eJ1dYF/OGJhh?=
 =?us-ascii?Q?MWzgamtJxsWIq8wjkHT/cIHrNIFn2dIAiHNNGM/8cc58v6DDFO5q/EU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763229fb-8a35-4738-51b1-08dbb31c4cf5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 23:10:33.6167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1jMgVf2YKJPRB6uSC4gAta8vJWXGrU5Rs7KubhZQVHV9pb1mZuCn7w7S4HRmBIeHCfRLQAsvFLEK++e3WM4gdspL90cHqr/x+OlaVN5atI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=514 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110213
X-Proofpoint-GUID: QYXOvFYtnNNnUdgfYWAZ2xynS5-x8W_R
X-Proofpoint-ORIG-GUID: QYXOvFYtnNNnUdgfYWAZ2xynS5-x8W_R
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Steven Rostedt <rostedt@goodmis.org> writes:

> On Mon, 11 Sep 2023 13:50:53 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>> And it seems like it's actually server people who want the "no
>> preemption" (and presumably avoid all the preempt count stuff entirely
>> - it's not necessarily the *preemption* that is the cost, it's the
>> incessant preempt count updates)
>
> I'm sure there's some overhead with the preemption itself. With the
> meltdown/spectre mitigations going into and out of the kernel does add some
> more overhead. And finishing a system call before being preempted may give
> some performance benefits for some micro benchmark out there.
>
> Going out on a crazy idea, I wonder if we could get the compiler to help us
> here. As all preempt disabled locations are static, and as for functions,
> they can be called with preemption enabled or disabled. Would it be
> possible for the compiler to mark all locations that need preemption disabled?

An even crazier version of that idea would be to have
preempt_disable/enable() demarcate regions, and the compiler putting all
of the preemption disabled region out-of-line to a special section.
Seems to me, that then we could do away to preempt_enable/disable()?
(Ignoring the preempt_count used in hardirq etc.)

This would allow preemption always, unless executing in the
preemption-disabled section.

Though I don't have any intuition for how much extra call overhead this
would add.

Ankur

> If a function is called in a preempt disabled section and also called in a
> preempt enable section, it could make two versions of the function (one
> where preemption is disabled and one where it is enabled).
>
> Then all we would need is a look up table to know if preemption is safe or
> not by looking at the instruction pointer.
>
> Yes, I know this is kind of a wild idea, but I do believe it is possible.
>
> The compiler wouldn't need to know of the concept of "preemption" just a
> "make this location special, and keep functions called by that location
> special and duplicate them if they are are called outside of this special
> section".
>
>  ;-)
>
> -- Steve
