Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115037D7BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjJZFFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJZFFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:05:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BED93
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:05:42 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q3XZ7h032133;
        Thu, 26 Oct 2023 05:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=sXb8QmVjwjYfmW8JB/Wa5mI4WZSyeYCHoUhd+C+kKzE=;
 b=KnU9UUdqY+aIFmKIhpbPeXRzii4eRyrOGqLvJpLgZfcxIk+9PYf/SJTMOe/eqZfg9HDs
 YOf7RAAAdYcFilS2Jufpg1kSsq7nXPHyTD5dvw2g+ZMQffvlEv3IYV15gfW7keoWyzfS
 cbAEX1uMzXBhalB4QkHolKG+lDArqpmZNz2Yett/Adwdt9ENM2A6rPT+D78fF7cdTbki
 EceCJ3dBCKZJCnoqexiXr9QM9r/0FSBah0XHrNKIuY8ub6rOvr4PA8vKAF8IT6NHTtYL
 e5ewBgEAx/C/dFrY0DuFkKkuXTxirbqlAccUPgqAHIO1NOIh4VsX3mhPxF+QI423fzW0 Og== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv6haswu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 05:04:07 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q3pmRL034681;
        Thu, 26 Oct 2023 05:03:52 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv537mufq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 05:03:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBk8A7lTnOcw/TsqcCKniNQlxGoeFt6DlKdtArGVBxvV0fdSTsTRfewLZhLEMZutdv9sf5OXD2d9YREPBMkU0MrYGfYDUi9DLKpM1Xlmk2I+fl5r2NTHlr1Z7igUHluBXPTH1SmQ++iZOIJyWfd8OGaF6ZO/oWDJ/jmaM7yX6yzsfnOFWR+QEGqXN6/mPATlIvp/9y2igJy0N1VgVb4/zXLVa67j4OWLkLZKiRaeaR8hyGFv7LlIPepVUStf5mctbNdWjFr2J8c/T7Rr8O/7fYtLHC2VsCF1Rhhet68RSF2v8D/sa1mSaO82O8hBht5GKx428EItajkskMwY7I0Gng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXb8QmVjwjYfmW8JB/Wa5mI4WZSyeYCHoUhd+C+kKzE=;
 b=F+AI4v86OU4M8BcsLKOzHapUNJ3PTmd+isPSYckO1xom2csFzqz8g+XYZte219zhPOO3xUXxu/5D4sMqWktL2QFC9duFphBY8N/letj2ctWw1aN6Wiv4iCEAU99kZAoye45kZssWcO1CDNCHd5Pk0KlSZi5POdIBdvRh75l1x8ToxhLD9CEXtRTtnMqgdTKUecr0+bQfwjC/BwyTowLjg2ZRLeK1U1OLFEGyIqzUouNlh3r3UR7Wsp1dKiIKZ887jdimilZF71g/Wr2X5tWH/3vSrIZ2bWZNvZ8GllOYO0etPlRaizv7juRdgb2gvHUdktEDGXe5oIOH/Z3fiFBgJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXb8QmVjwjYfmW8JB/Wa5mI4WZSyeYCHoUhd+C+kKzE=;
 b=oEjm9jZ/KEd+4c0rsp0311dWR6KMeniXurQiTrBhquPT8oqwr3erlsL0snKXLNiZxRo0j3r8wBJM8KyeqojEyB06T6PUK1LAvbnXEzlNl4Tf8fXy14V+qba810quiN8d+LxQdqVGLaLGwgxTd/V2Tg1YRoB9Q+5aQNlNs9T6zHc=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6873.namprd10.prod.outlook.com (2603:10b6:930:84::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 05:03:50 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%6]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 05:03:50 +0000
References: <20231025054219.1acaa3dd@gandalf.local.home>
 <20231025102952.GG37471@noisy.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Youssef Esmat <youssefesmat@chromium.org>,
        Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: Re: [POC][RFC][PATCH] sched: Extended Scheduler Time Slice
In-reply-to: <20231025102952.GG37471@noisy.programming.kicks-ass.net>
Date:   Wed, 25 Oct 2023 22:03:48 -0700
Message-ID: <8734xyf00b.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0074.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::15) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf30699-8bc6-4b6c-53f2-08dbd5e0f12d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lu4ZwaNRSbp8OnKTieTewsZAxPamHTZJbiKitwvcyx3XA/S28obsUIH3GggwzlsJxkbNlaTCQlvUyld9ryRssnnS1AC5euzGVY3jYgxgF9Du/Ox45KwIvJqXNdrCYxJB49o3WibG+IptipFsn48X5UBIGHWRGaZHjJGAN/cOqKn+0LEk+6tRywj8CSO4Q/ddZxaUF0h+alP8Vd6byTWCWcW9V5p5ICFWcNf7eVwKQU2luETNOjSVNot/xLiUSbhCRh3Q3Os+m9isJ04IjSG/Wrdnn3vQ7tHyPFqr3BtTvifz5142OTlM5bvZWFR9DS4wCDX7p8lUL7cvaB8JW5dUtDzz3422Kjkf5SDojrd5FFDrUe7HZG599i4YStKIKwqAMobG9t/4NgeTuswsvg29p2tseyL3lDrd3a3AwJBZ86DK4taTsoRwsxUCIuD02NE/2kPel4sxoGmn6nQxA22KxPP/3lMH5eFmjE5A40pKP/Y+IGSWKXmXJB+bXqXPpkzk1PHle9fBGQfGNIGyehLZVdgmnRZWrlnxaoke21Kkkr8RoHydkNDW3BTgaapOG0+T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(41300700001)(2906002)(38100700002)(54906003)(478600001)(66556008)(316002)(66946007)(66476007)(6916009)(2616005)(6506007)(6512007)(6486002)(83380400001)(86362001)(36756003)(5660300002)(7416002)(8936002)(4326008)(8676002)(26005)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rBLvn9karW6H3p15HAYDREFl4FZviaidM54Xu6wHrfILPSGLGqSeNr7qMjOJ?=
 =?us-ascii?Q?4ehv9Bd9d66/n2zAiJ7qrSQWev3XaPQyBYrkZEKFhcctCoMgrBPwxu04p1PE?=
 =?us-ascii?Q?1UyOnc7dT65ZUCC4+iN9A7ZOQ38PVdlw7nF80NzUX8dMIgSc7N53Hft7R4mU?=
 =?us-ascii?Q?dr8ymdp/nSO8YmxHJFD/glSkh9+CW0W4SBQIoSjAKg/BAkHKrfGMP8eWFYVL?=
 =?us-ascii?Q?iJfZbv8LM3agVZRkjFGDrEuB611Mw/L1woaZ8BdoXPNUBCk+v08DJSwFOD+s?=
 =?us-ascii?Q?lDVkqDHa1vUOWB+IevNxJFhi4DwMReu3rtU4jDXMh80dCiF2/O7jHPlyX7gx?=
 =?us-ascii?Q?9VreJeG3FSOWzdJfeiU2FNk00Q2FlqwnJwSXIABmNxNVOuqj14bJqdIDfuz+?=
 =?us-ascii?Q?4NCliwr6pOwxBOFT36r1CZykcSleo0MnTRHvUTHhpJ6ncNNsuY80vhMUP/M6?=
 =?us-ascii?Q?5/RKa+hzuvL10aMP/+Vz4oT8RtLLOki/Cnv25W0hdYEwu17m9GCzKRdHhl2Z?=
 =?us-ascii?Q?Dp+ywJqY4IKom/ZT2mzTJszW5igGMuCL5WcZV+U62Q+ew+BfFXPhQX/rjh8Q?=
 =?us-ascii?Q?UhexeB8VnvZe5wZDmN+HnBFlz0qZVDhSolm0TdS6zfxeCYOOO5xZaMwqZ9nz?=
 =?us-ascii?Q?XrZ1WGjJ8pOJp36ihGFzf+RhudhewZzuQ7get8uRIfZbqmhk9yeqJaAr4R0r?=
 =?us-ascii?Q?0262QAx/BIyky0nX3sXUwALyXSfGZViOTAl5NqADdf06dn+n8wtJl9zs0iuo?=
 =?us-ascii?Q?rKK10mfKsO6DbOhKckLlaKvZtLh8MVBQmtVIFYy8kSUFWFoQFFuT/qdqq22B?=
 =?us-ascii?Q?K9+4bjrqYtB3d3jv4EUe0bOL3H4v1IVVaJjKW5jAmhVbUjU5J7ThEHPGxzro?=
 =?us-ascii?Q?dmkhWiOqHHpeWARZkH8vE6soCQeJ7zrnefzzakk0Gy5ftDUBS1l51ei1dfEF?=
 =?us-ascii?Q?K16l0ndCZZ7HjHzev4ekm/f3mg0EMYDFUuuR+QUZkCyKtUF+tIMt+/zV2mNu?=
 =?us-ascii?Q?kVKCSM5+jeBQ/6mXiCirqn7SUysksAFuHu/qg/FnS2lNgSs1/APmCqgKwRHf?=
 =?us-ascii?Q?8MAjDGM2Vb2bqU/go5tF8PPq3kxi5jyfmNMjJ7taFoQJAM1IkUjqxhrzT9S2?=
 =?us-ascii?Q?FWKtXNFegYbpVr+7v3hdVQsnAm+BVx4moSKZc16vFXQptmfOiEl2pdYplUyR?=
 =?us-ascii?Q?EaCZdHAJmKY2pVor1A22Rqe90NZynziBw3d4mRrZzcEi0mCxxN73p9BiEjAm?=
 =?us-ascii?Q?omVQxFYZv1yb/xVuxjRDwxlxxrScq0E05Cc82vpS6vnaA0Wzq4pD1gCLtW4a?=
 =?us-ascii?Q?YvRVeyfnEsNJ5HISTH0gWn6E8jN+SRGbsZC4TLceEyRdgA2rYW2vQYMKpNEf?=
 =?us-ascii?Q?8gZM3xvHVclglfI3R1II1OA+WHHrUWjrG/3rwg17FpJ2ID5lF1Fkn4uRioQX?=
 =?us-ascii?Q?MSXGDS269+bSCqKv2RC/HOtN6LokHmnNmS+OVdGlWV5dKB8Qdrv3vSuDCi5p?=
 =?us-ascii?Q?AGasl9gjrzW1JBT1gEU1olW89XCRvxoDK5iUihYaVBfFVJvPzr02I5oSBSKX?=
 =?us-ascii?Q?SYkfrbIfQ70UWUwB0psPnn7w5XnuLRAV+fNHOsFt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?DTxGMPNCAAgEVas1a4oO6vNx+ZbmGPGEqXBQqFJvHkTY6zKGHIrTvO+YBaRx?=
 =?us-ascii?Q?CRz1Hhe8AKnoufdYiZzqvy/oSamkvR8OhbNI6pTStmofdMAlyYtD7twgWQQI?=
 =?us-ascii?Q?EYgFoH5YppVENab9VWn+LGPgSjafXwgL0PFbsFvg6acMQmIIf/EfQviN9125?=
 =?us-ascii?Q?zxBdXHXVm2P0Fxh1o23lPOPgTC1NbpMKmVIX2TUEud4mGY01IEWJSDxZGC2f?=
 =?us-ascii?Q?2XSrHXVe717BhIMbyiVHL2laMThnJG3rMDsIwSepcSG8OgBWUC+Sme0Bx3c4?=
 =?us-ascii?Q?tT1004TJG287Nl0+o8+8ou9mMnu04R4asjAC3+Q+yTJMQI6aEjeKCy+AebY/?=
 =?us-ascii?Q?PrYS9f91kgHFPnsddrs03ivcEZt/UX2J96MpKj/FhUSXe9vuQiYh0SPAG/ui?=
 =?us-ascii?Q?j5AnZK01gK8Bu4yomC/uPO/ww4X/1JC6OLyg8rX6iyC5fptDldyS7HNjSGLe?=
 =?us-ascii?Q?Uvpjp9XTywE3PaAmChejz75dNF8X7sCjpAAWjx4tU4ORoANCULdnjv63p/+X?=
 =?us-ascii?Q?szpWvBRFyOTF66pdutIYY79sbvEJlUNfnvSENneKlmB2atvDLCpr1KZIgSs0?=
 =?us-ascii?Q?EP6AYYJ5C8Ft0Gp0lUtX+yikM+gMTLYnb8aU+TXE1JXlGP7GgHR9w9XlHLqB?=
 =?us-ascii?Q?2S/DaKzAD2Wdjbwg9piBjR91/iZHeer7cBc7wvPygqVYK3jkvyngkGnpjxOp?=
 =?us-ascii?Q?R5Mo/SGEtozceCB+Fb0If2DucEwlzGdOPG0U1X1NB4pjymbQeGbhGQdMxGZz?=
 =?us-ascii?Q?9OxCz0KpJyMTqyRdDvIs17ouAsB0ZD0ShUzX1Z486CBgSsVbWQF2kOs9pXo7?=
 =?us-ascii?Q?Ymd1Aw8GjA+4WeUGP5sOJlu2a/AHTgRBth9qTn9Hpq+W8S8ZBskfVhtnEq+1?=
 =?us-ascii?Q?qGjmyDq4f3YPbnLLgU3J2WE8kJzYfeThkfSua/QidouKLB9kiLw+PUiw4kFT?=
 =?us-ascii?Q?vMvyI8M5x71b9lD+Z7BSfVgqii+uX+Eek+Is+cMBNHWeQqvdxRdN8We2qNoe?=
 =?us-ascii?Q?aCJMeHTxg+ptaKuu1uWfCkRRBDDT0AvPso1Tsn5HhCaMbP6x1n7DTive3/oj?=
 =?us-ascii?Q?tJlLRPEG6cMyJvBXiOlyedaf4qYK/+pnTb/MADpt78gDCAD9Mmin17qxytQ7?=
 =?us-ascii?Q?rydfuKb7Rmg7q3QaAYdRS/LvFzGY9EcUBaHBd5Kn4qoF5Em/aKjF4uF1CKhR?=
 =?us-ascii?Q?M29H3gu8rmbHlyHeTfyck1fuB5Dl44T7s1Y7GM1qh+WVUSQxRI1hxrilzNSh?=
 =?us-ascii?Q?DqC3LvXtzqjypEpGvu5wSUOg9fYrujxEpb+SjUA/W/JYo3c+oTHiMk22nTyL?=
 =?us-ascii?Q?/8CwJJqEFrY3SzTmZ/RvnOmejUWBzpDYVUz+0oUeNFan3w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf30699-8bc6-4b6c-53f2-08dbd5e0f12d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 05:03:50.0402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2ZCnphnKLpAL4T/DoczWkuV4ZakLpCaHaPRBEif6bEmdVOwIUqO8Pw2Rlx1ZEn7x3l/sw14T9Cju7Cif/8rFGBi1uz8yjPrsIPO6Q5lqRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6873
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_02,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=764 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310260041
X-Proofpoint-GUID: Ej_HO50yeQ25GHwhBTFeUniMNXKYQNd1
X-Proofpoint-ORIG-GUID: Ej_HO50yeQ25GHwhBTFeUniMNXKYQNd1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, Oct 25, 2023 at 05:42:19AM -0400, Steven Rostedt wrote:
>
>> So, bit 1 is for user space to tell the kernel "please extend me", and bit
>> two is for the kernel to tell user space "OK, I extended you, but call
>> sched_yield() when done".
>
> So what if it doesn't ? Can we kill it for not playing nice ?
>
> [ aside from it being bit 0 and bit 1 as you yourself point out, it is
>   also jarring you use a numeral for one and write out the other. ]
>
> That said, I properly hate all these things, extending a slice doesn't
> reliably work and we're always left with people demanding an ever longer
> extension.
>
> The *much* better heuristic is what the kernel uses, don't spin if the
> lock holder isn't running.

Something like vcpu_is_preempted()? That helps deal with preemption
once it has happened, but an ahead of time signal would be much more
efficient.

And, guest lock holder preemption was a big enough issue that we drop
down to test-and-set spinlocks in some cases.


Thanks

--
ankur
