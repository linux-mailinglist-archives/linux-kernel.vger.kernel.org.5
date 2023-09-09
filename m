Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AED799AB8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 22:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244078AbjIIUQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 16:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjIIUQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 16:16:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB5519E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 13:16:29 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 389KAB8R027904;
        Sat, 9 Sep 2023 20:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : message-id : date : content-type :
 mime-version; s=corp-2023-03-30;
 bh=qZukP4wbbpRluT1Q2/opsQozyOwkACTZuaCy+Wtx6cU=;
 b=Mtr8SbpjsupGeA8amHQOF9Ru7JlOT7quPHs/+Zxr3FgKJIHFo19A3LeZ5+RIXNH617qe
 j6s3lgRiP11a3jPQKKTCIOJO3xXBWl3ffXCFfu1+a4TmyxSzfYTJLZJLQcjmUHrK5oCV
 VRevzWQ2KHjIDcX92R4bxQR46GgPnP8LCriLxK7DX6AzlS0EulGg4B3e4OzZsaXrKsG4
 Xa7hE9qQJ6hkvUsoHSac+woytUPe+F9tDJgxlYHkvwmT5swClz+Bb8k0JKz74t3jd7y2
 Hct/KgLOBpCVWvx+vcK9F71o3VLJsFBXC8vur5pJxVC0lF7g87oi85vNhv9TNbZHv96d XA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t0ygd805b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Sep 2023 20:16:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 389HCBfG023021;
        Sat, 9 Sep 2023 20:16:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f531xkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Sep 2023 20:16:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElGQVx1chEZ9OvOpLCc17F1n0cm+o7HWSSB3KEtjf43MLjhclJYlwqld5sp84IaCZshiBpn0Wj1+H/xkTULl4C0VX2ZkzZO6GtTdNEvdrBj80Ah3vV66nQOJ7ZDHjfrSYwLCw03kOeqV/IDTYqARpnfLpB6mxn7UUISPf/HsTfgYInIdLc4Ot2yPIHLt7zBmqKAS5zc+iZQqGQ2ywGU8z6qVYmnmUVH23QIPJm0hE0SKi2w0Du5X/fGe7qLSPvuFuKbIUHI8o+iafQctQ/2cxo/6vmHujr2BZKGCSKiUH9SHgDfRdgIIst9ZK/PlY8lc3oVhPjopMJ4HiRaPj8uECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZukP4wbbpRluT1Q2/opsQozyOwkACTZuaCy+Wtx6cU=;
 b=V+CoFBk9aMNvvELVaXIB3/d91LikNGFcwY1jAF/sJTkncV2PkG46/Fxch1osthxIJ4IWFu7sWej+HjtOJyTLVebn3OUZIH74iTULewcyghxMywVhA1/htWyvgm/pzLRIDcm9XGAkJIuOqPRnXGVy84Sbqndmq9B/UA5IBjMLGJhHw4k4F90OhroswTd9N6b9PKRzNudzcjVMAlol31K2PBb68ruUQRzjJTqteAkjKgb8u+g9OkjXyMMibmdSd5a+tJTLSbZ9pYwn5eSe1QCP5UwlPVMthErFexiqZeNIVuvRwsoTKg+IJ2fYmasFhN8/elykvR6H12BsxvOrclufew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZukP4wbbpRluT1Q2/opsQozyOwkACTZuaCy+Wtx6cU=;
 b=zTTW1Bqa8l+1lX0iiNFdzTjsw37WhsqEslJuS7TPnM/aXuBG/GhUhXtet4vfT3qlT7BlfKgbmIFYYHfO7gNtdNqS805sHEy1E6bjT0Y1LIs+sydKPZC6IFvcsOuxsc7XJDXIbfQZzrGzJGQraAYOZMbfNaNeBgJg8WTc427Cji4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ0PR10MB4703.namprd10.prod.outlook.com (2603:10b6:a03:2d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Sat, 9 Sep
 2023 20:15:57 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03%5]) with mapi id 15.20.6768.029; Sat, 9 Sep 2023
 20:15:57 +0000
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-reply-to: <20230908070258.GA19320@noisy.programming.kicks-ass.net>
Message-ID: <87zg1v3xxh.fsf@oracle.com>
Date:   Sat, 09 Sep 2023 13:15:54 -0700
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:a03:338::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ0PR10MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d048acd-9aef-4561-392c-08dbb171939b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVF32dB//omAWaXDkSLNegm0KQCddArXOFKcvK8s477tO4CwvCF/PTfgo3ONe04FqyV7LzNXCY4pN1uWFtiSmR4bwNWZHTiBsUjV5cW1nqbzW9SeMB+dqyMsBXHU3IVsaeULtNPeo8XkMYaNYDBZJKeMhK/exDmU9VLKm18JUXSHE6gGY2TJayQpXN8EXA4GZz3j/BZRzPZShVU0YsgBWAvmE4z+Ztq22GZEmpD9y6zQeot49HPkwtSwmaQ1vVdS+HsTl4J/qmF9N+5GZLrTQR7nlMbopN6jeSS+/x8vSVX03avrkSrKRabVZjM/Y1O2ijMdbMV/gIYYRfe9+2QZpxdIcAMsd5qWooqQ6ZW8wQACxsUJmu8koxt9KY0ZVYs6haexdDVKmo3ga5ZYnkXDW9NCegHx/QuJXbRXhOvGf8o2j4o3Am4SnSY4tnVIzrikV2QnORigGCrJcnwkPX4ARF5Nvu6WstbKHZmw1qz40CEYvhR5fm9NvkW/ge/ENX5zsWGDHo+I+y75JPpZRznzEQjiAeJ1c/6U3e+SkXQqB3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(396003)(136003)(186009)(1800799009)(451199024)(26005)(5660300002)(8936002)(2616005)(4326008)(8676002)(2906002)(83380400001)(86362001)(38100700002)(36756003)(316002)(6506007)(6486002)(66556008)(66946007)(54906003)(6916009)(66476007)(478600001)(6666004)(84970400001)(7416002)(6512007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fUP+WamU2chVWI61TwO80N60OgN5JNIFx0U15P2F6lYABRRwTOLYsJqldutq?=
 =?us-ascii?Q?+CsyDS3f4r57CE+JAXLbBm9ao2WUi3kC6AFwLWoDbDpigtycwj0FfjwCWwLr?=
 =?us-ascii?Q?EKpGH+YYguiM6oyEjlRaCsOf01jFUiR68xCsQqQJjerPu2GsOcy7ANP0hz3U?=
 =?us-ascii?Q?yg7yAH+gRnVju3AHWYh6HTglGOutKdbI1FkQaRg9Juw1XBQcop9QWPEn/+j3?=
 =?us-ascii?Q?44ItkevbEAPD0z0J95hvMlLMu0q9T5wJ7YhqIiVj08DKkHES37lSsct/OVRV?=
 =?us-ascii?Q?QW27RJ1BcG5rzcE0Clrf9+e7NJu18ULk8XxgYclpO2n/18+ELAvpt6PBVapz?=
 =?us-ascii?Q?y0EpBSVFVpIVveSGEGTeOzxIxkm8HKiO93lLhNhUqEpo7h/cVtFBYiqwoWlb?=
 =?us-ascii?Q?RYPmR8pJz1R9qD1u2tgkbutGa0xi/7KMvNXz/puTH3ZAN8zmgvwUPB+/tg5H?=
 =?us-ascii?Q?1S5Vnjt5hQ5kusn7NvqvSKijJzCr1Ri5Ve8GNpgU70ehyoJdS2L7uUYxw5X0?=
 =?us-ascii?Q?1O8+QC4kBd3mClygcEuSLiMAn2/x3+6wf76xFIAD8xL+fm8Q7riwXrlHdSFq?=
 =?us-ascii?Q?Tqzg6KX6m7Pf0FHBE5puKCTJhtmhLsLSRWGhRSremnddWsV7xgBkbKgtHn/L?=
 =?us-ascii?Q?DHUcJlV8b2ucnCv/MIAACV6vpORCLc9Vss1WtV7bUlH0mhA3eImX8uQsu4th?=
 =?us-ascii?Q?/DYMPNc+jdEOYN6TVEFkwjKt/0i+SHqQYCJTnSuZ9YvSVbyH0cBmNSmwsmXY?=
 =?us-ascii?Q?7paM3s6iILoKE90DkbpiH2SaBbjWPGbonPrxv3KEB5sWpe+Vpemk5uvqLT/+?=
 =?us-ascii?Q?QVH+fjuEzfPoIfX3t7MwikMkW1PQjj6kT5ulxFnZ5GleJUPwqo0l1jit4Jl/?=
 =?us-ascii?Q?fhroUAc5I57OCBfegJt2ftx+gLYaiZIEzSzkvmdSXV84ydovlyD6A/pw995R?=
 =?us-ascii?Q?mepe2yuHzlWSzeBo0n1kzBzUrja60AAMoPm7k2dAaDuDQRHasJFYT95KYEUP?=
 =?us-ascii?Q?tYvjyX7fSkTneyqJGX2D9KP9pXbYDMUYe+7zEqKLx+0D9Q1sDdoJmlOB9zYJ?=
 =?us-ascii?Q?6+Nb0a+O5mkgM9v7BBeeRzVeRu8dOC+LcVm8gFq/4yeCFFafuz01pe3DzAWU?=
 =?us-ascii?Q?TfN3AsXyplM+4o92c0I9eaZHqOdyBlMWJk0/oHf+Csk49vJ9Tz7yg/NE0EMr?=
 =?us-ascii?Q?XUVl0d6UunPuH7ga/e3j/TeyEWYLBWs329TRFCVvH7be9Fnw4grHcqPTe2Cb?=
 =?us-ascii?Q?fDHmETSKbStaDIgN+1nFRjyPGWnf5Ab10Zn+fgFRNcsvSYUabrzXc8VWU5hi?=
 =?us-ascii?Q?GUKs/I6bLCyARjvG0vnAhGReTR/dZdsVgNsoVuRQr9UWjd2GGTkQV85ft9s6?=
 =?us-ascii?Q?B6RquwpSlm3vXfxJ3/EodiqOawUX49KMo/pFUUEU0/sU9NFOIC8bAZiL/IyS?=
 =?us-ascii?Q?srOUX/vKzCQEhT0jvThDNK1q4WASGL4uryJ53tTRtjz0nB17WVA9+JXdGas2?=
 =?us-ascii?Q?L24zjyvKmRh80SsC9NqK5fgcwYM0sSJqJnwXS68B+SODHzr1Tt7thXxfSjqt?=
 =?us-ascii?Q?t1dosqVywYFDRjQXDE+G0Kz62+eYyQ+fLy7P5DD88MByucky24cu5/xFm8cg?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?8gUOb3cLVHHxUKoUwlzTg9hZwVnnyrtbjVvngaZlKMKescPvjfQpqNSgPHuo?=
 =?us-ascii?Q?RrlaxYsPUywuinCVvdBXkXyIS5VwgnK7kg5gprdhLQCihOmOpm8yKXowmPnq?=
 =?us-ascii?Q?oLV2pjc95aqT7uozLdJQ6XiZLsgLooxbFeiUzIqVL+xK9lJtgmf1Xfj/Tlzo?=
 =?us-ascii?Q?SFPsoi0iOxqPqiJ20fhOR5BaJODZJCAIoLGUfWGEH9Fmh0fOZ26yehWeCTqm?=
 =?us-ascii?Q?q1XGymuHNOf3bFi0a5hGeoSU2vndEqqqqH5xBSQnpdEYBlhUy/emWcEz2OgM?=
 =?us-ascii?Q?1dHLSPuAPA9Oso4kuRmknYNq6M3MT9BtmE+c+DKqKl1YNdUiGCL2E3VZDeL5?=
 =?us-ascii?Q?zfLdgeDSl6x0lgZcU7fvTufvprpwTQiWrv7cX1xlvBJRTD4Z/bshQX3mGQT1?=
 =?us-ascii?Q?kiOXCyn7nsv698TORtGOY3t1eyuwJMalVv1FvldlzqbPl1NDIHcOoN3LsSjy?=
 =?us-ascii?Q?A9Xlpzvw8N0DuG31m3vwKCUCk56Aq7UewfIlSaXFakPpL67c1uK64HnbG6QZ?=
 =?us-ascii?Q?dyL/sOkadkX6TlxMO4/wCk72DkgVmdBTVoglYnVCEdXM9lkHfSMXW8jYlNl+?=
 =?us-ascii?Q?BpngynzNquD6M3fY+u++JD5QKxcqj2wOWMKoWj+QbEQypfZJn8khSskx75Lp?=
 =?us-ascii?Q?l+/eLJg/Q/+a+hUPDD7xZtRFLz4bAR0/yAJWzw+rpcjOIoPMxQSoHmVjQZJI?=
 =?us-ascii?Q?WwLyn89tM6lPdB6AE79fGYcuh2zfEaNOQl5kEcnpnmg4nxUNCBIrH4WWjXbK?=
 =?us-ascii?Q?aFeeXhfKsvk+GLdniNe6ky2aKMNhMicbC9ekMY7RwnGvV1LvdWV/6H7N/7Id?=
 =?us-ascii?Q?0kCceUnzljKSFo6nPpPiY535+8DBdSIYztgLJGaV4CmGv3YdLm2xaJvAj1X7?=
 =?us-ascii?Q?20kN79rkJq1QnNYnlXSufFub/PF6K+nsPDacDOmDz0bw2EllMtlMZ73uOqVU?=
 =?us-ascii?Q?l+MRTMt7+dfPc03BH5NTUOVV+rPJTQ9qD3NZ3DbTgEU1o1dQPmkRWGwr+m6S?=
 =?us-ascii?Q?GgGRKW4PdyJXAyxeaGTU8nsNtCTszZiS5oDRm+CcoMhoBjhhhzUI0X17HB5B?=
 =?us-ascii?Q?RBAkqI+hMtkwbIQw31NqJ+HZfUFYWTpVatK3BgwbVuDf5NKPjcQB97dR00KZ?=
 =?us-ascii?Q?Ik3OJi2aCroPK0aVMADtZU18ShiUEO/ipaSkRBcwAnBpz1pd5nrWoaI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d048acd-9aef-4561-392c-08dbb171939b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2023 20:15:57.1096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RL3Mp0CctC1cgHRK8XhZmAKZpJL4/zh5g6dCbUhjZxNTc9nMN554QZjL5bO1a9M1+QI9U6Z+MjaT07FrxMfIdDK0BiC5N7ZWxFF2PtcwSf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-09_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309090187
X-Proofpoint-ORIG-GUID: GZryR-wwb-GxeXqSnro8mCw8PNQCEkUp
X-Proofpoint-GUID: GZryR-wwb-GxeXqSnro8mCw8PNQCEkUp
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, Aug 30, 2023 at 11:49:56AM -0700, Ankur Arora wrote:
>
>> +#ifdef TIF_RESCHED_ALLOW
>> +/*
>> + * allow_resched() .. disallow_resched() demarcate a preemptible section.
>> + *
>> + * Used around primitives where it might not be convenient to periodically
>> + * call cond_resched().
>> + */
>> +static inline void allow_resched(void)
>> +{
>> +	might_sleep();
>> +	set_tsk_thread_flag(current, TIF_RESCHED_ALLOW);
>
> So the might_sleep() ensures we're not currently having preemption
> disabled; but there's nothing that ensures we don't do stupid things
> like:
>
> 	allow_resched();
> 	spin_lock();
> 	...
> 	spin_unlock();
> 	disallow_resched();
>
> Which on a PREEMPT_COUNT=n build will cause preemption while holding the
> spinlock. I think something like the below will cause sufficient
> warnings to avoid growing patterns like that.

Yeah, I agree this is a problem. I'll expand on the comment above
allow_resched() detailing this scenario.

> Index: linux-2.6/kernel/sched/core.c
> ===================================================================
> --- linux-2.6.orig/kernel/sched/core.c
> +++ linux-2.6/kernel/sched/core.c
> @@ -5834,6 +5834,13 @@ void preempt_count_add(int val)
>  {
>  #ifdef CONFIG_DEBUG_PREEMPT
>  	/*
> +	 * Disabling preemption under TIF_RESCHED_ALLOW doesn't
> +	 * work for PREEMPT_COUNT=n builds.
> +	 */
> +	if (WARN_ON(resched_allowed()))
> +		return;
> +
> +	/*
>  	 * Underflow?
>  	 */
>  	if (DEBUG_LOCKS_WARN_ON((preempt_count() < 0)))

And, maybe something like this to guard against __this_cpu_read()
etc:

diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index a2bb7738c373..634788f16e9e 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -13,6 +13,9 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
 {
        int this_cpu = raw_smp_processor_id();

+       if (unlikely(resched_allowed()))
+               goto out_error;
+
        if (likely(preempt_count()))
                goto out;

@@ -33,6 +36,7 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
        if (system_state < SYSTEM_SCHEDULING)
                goto out;

+out_error:
        /*
         * Avoid recursion:
         */

--
ankur
