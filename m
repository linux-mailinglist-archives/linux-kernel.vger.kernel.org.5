Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53BC7ACD07
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 02:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjIYAOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 20:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjIYAOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 20:14:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11914E8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 17:14:39 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38OMUEpR007234;
        Mon, 25 Sep 2023 00:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=vcBModgJKRPITatfHFBrip0yxhQuJRYIRqa+BYgHySc=;
 b=adCE8c6wDU51eob2+lHoj83OjFK1JsOGTnaiTCE2bjMaTqlgJrLwmlXHfCrJY+Nj3hXQ
 FvEhdSxVGe1z9Yimv+14VBZ7O2h5cgrme1tzxYL2i+8D8niAxgWKkEWavgQW9LCkSTR7
 Bx0TGyOi883K2f3/VYmNC9Y3efCrtfZyfVT0Lia2v9NzDddLBw2E0YikS7HZmcEDjuaz
 i/SAt1CgG2rwDgxTHhBnyLsKKsVjbglacnG8RWhpo/p5eX5gWFB/De2Mnpv1C69MuleO
 jX+z27fWoG2KZypQv3pLscDHGHQbOIX45r3WWtDrZmpO3VRY6XB4jftktP/VahQXyl/Z gQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pxbtfgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 00:13:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38OMj2Bl034947;
        Mon, 25 Sep 2023 00:13:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf40s3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 00:13:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ob+FeP76H8cM4r+voBiSzVB9A+6q268QYMF0n/tL2UqAaHsG2VK3N1gscq8nada/y+7i14rE55hqbq1SjvuPX7+wAnDg4I6k+e66CrJvN+FIstdqP6MRmrhXAYX8CqWQXBG4ywMNVJAxf0+aR2TTCsdwDxj7BP/N6WLAGEdRvz21p1Lywu5OOzA9rdsIZ1I7rrsKhlMp+lskPwcpXFc32U6y0UN4ajWtwXB2WjeDDUk3KEOTPLGqEBPTVWRN94UJ30PVYcjkIBpQVRPpYjwu7W6pKhQFpiCos68sfKCJoN8oiiZIDRlNay2hBUdVoMcaYPvBQx+w5umS6I0mu75Lag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcBModgJKRPITatfHFBrip0yxhQuJRYIRqa+BYgHySc=;
 b=fcOLNi/8UFZk3PcpdYzLRUnDMW1bARe4wQxpIPSQlDxSgVhywaL/MvB2WXn18Advk4xXitzWTLIbtDxw06Hem3QHSLBCKktuoriqPAWvnikuDWh9K81rFQJCf9ajjx8QfhgYomPzIlqVv7VcQrwWmIXTaKxrXpfK0Ld+p2xAfmmIhej+VdeMtCH4V8AJ2FEosD55TYZO9AxKwJHxkyekJRiLztcmqms22ylhGVYs669n68Gr2RVDp8+MmynJMP0Npjf9WXbA9ZAdEvHq3sxXGNnkThoO5qYGoYprXJft3mmb95V2KcLqHD9/7CJWTSpNE4JdcKdxSOYEGxoFkRMRww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcBModgJKRPITatfHFBrip0yxhQuJRYIRqa+BYgHySc=;
 b=bBwpiEMd/kksN3vXE/Ssr/I1sGb/KTIYGT4H1x603PoqbNUv8YmQ/vI/rWn8w09JvYB1dUcu0X6BOylcsOUD/Y9a/K1D+iL/OJ8JpPq9LD0VfnJcGwu29MXSeQcQjqUi/F9zwC9EaE3vkZnM8PVg0sVHr1NKstW6Lu6CUdhf9Eg=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB7472.namprd10.prod.outlook.com (2603:10b6:208:454::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 00:13:28 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03%5]) with mapi id 15.20.6813.018; Mon, 25 Sep 2023
 00:13:27 +0000
References: <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com>
 <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com>
 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <87h6nkh5bw.ffs@tglx>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-reply-to: <87h6nkh5bw.ffs@tglx>
Date:   Sun, 24 Sep 2023 17:13:24 -0700
Message-ID: <87o7hrcdp7.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::25) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 4562e5d6-6907-4843-0021-08dbbd5c3d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bIkMiCExl15Vtj4hky3EK2XHNHghaCFVLb6tHVHoLltj9G/YjZ30a36tTOiPEt3OfRMpQto9btDKnQccJ3HpgglYp3fOTpEXwGD3kYPTp12aYp0gnvZ0VGbSt6H4+sQ3cI7aSDddQvo04eSB4CbKmUjDLMIcyyiNWflhChg7z9zKy5SwX7Q2LzqgzvOlOfrfdq1fF515wabgvh4YlLH3AdZINi2+jomxk/HaXAXnfwozqAiXNdwcqA0xrJI/Irtef8HsU9N+ePo7q9tTiv17mXyBPC34WIHyuvk+JVZCOsA/1NaaXnY+Dku65Yfa1zTxVvUTHypD+uGkbgoqH7QzNt6O7ZvUKD1oALMPhUcHD5K4Btnk/jydNuIaTswCSw2alDFRvB7CIzxRDGlCMf77zX2fJPtHO4GKTjvQQ+BA63Blk1ngqflR6yr7FaX2UrgJqHTdqvPkTSeDeD/HJGXdj/8M0qs2sWxSDFSdPXgfTl8tAqAyFRJWXLLrGjqcJuqrXNiOMAKZGeWKXkS/IL25eNslFi7UHlKeDh1KxdkGL22D0i1yegFYuU6TME1z53lF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(136003)(396003)(230922051799003)(1800799009)(186009)(451199024)(41300700001)(8676002)(5660300002)(4326008)(8936002)(54906003)(66476007)(316002)(7416002)(66556008)(66946007)(36756003)(38100700002)(478600001)(83380400001)(26005)(2906002)(6916009)(6666004)(2616005)(6486002)(6512007)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jim6BcqRwFrPXeRcK10fDHednxnp7MbXiIm44kWOuWXXDXMqH8+M6Qj26JwC?=
 =?us-ascii?Q?JKX1mEP1hgGggcVkjP4qOCgisdXUaClvxHjdagaIarrg1bocMYFRKOiCakb+?=
 =?us-ascii?Q?4l7F56IXT/9+9rICEF4Io4PddGABCCy/iBS8hOmeq39R2+CC7AtHwyqApFBc?=
 =?us-ascii?Q?3aXNArkqkRzyALZpjmoXgc2SVR0FyACQ04fHepV4MScVvZdtMa98wYIKCNs2?=
 =?us-ascii?Q?sZV61kzPPq1B8lDzDAsn+seWoOHLQ5G92nbId8fRxKGDrYpQkPGCVehDIweN?=
 =?us-ascii?Q?YKlL6xVTAMgcqznuqrQxFdAcfz8Xc5NZL66aYMe5tPb8Kg+RNCSXu0qHmIKG?=
 =?us-ascii?Q?VRNRWo/xt5rpTCKnPoi1j37YtpvgRQz3MCSxGYF1HpTgVm98yt5JWlw7nyml?=
 =?us-ascii?Q?bMcKLdx79YGF97tNhHFiKQKWtjknO/83qqL6LG86vTOwVBtV+qxaNF6o034u?=
 =?us-ascii?Q?AEq//qRBUWG4a2L2wtoHbDVLuGgjT5X6e83AYJb6Pz618oA3ZDtPGNtdQGRA?=
 =?us-ascii?Q?qW+qFHFoc19+xvbUE0E6gMS+KtB8e8xn9GMddEEVj/Nglp6td4KngNhbYiu2?=
 =?us-ascii?Q?CwJHThDp8eKS/DuT0Y0w2gee5oPzDlQFVKu7QL8gVQx41m2MPf4tlAt/fDuZ?=
 =?us-ascii?Q?dN8IaZetnEipu/wHjBPSKLIcolr8f1MU2vpwAvGziEuNAKplVGIINyDXZgXQ?=
 =?us-ascii?Q?DK2QLOeYL2awcsY0yb2fe5O0gwNFpACpw+akdF1IFnK3e107AIC3TGG3IXxh?=
 =?us-ascii?Q?4wo9zX25hPyEq5wLAc7Ro7oV2SUk3fpaaPVz3Ka901urJFEd8O+lV/ELMr1A?=
 =?us-ascii?Q?qKThVT9SVuoSk6w368T0fLkgqos1LAyisPneNeVJ9CQewWzhgHaAwOU6nExG?=
 =?us-ascii?Q?v7V2wlSSbTrfL1rwTrugrVgFMtiu0/S+eujKpkip11chLVgCaBC5iEiTlqGT?=
 =?us-ascii?Q?uoq4/7ItL8a68BwyMhPBU0v0KtNtd7eAGF8qwCoONVxDG1JwxpRa/R9alRFr?=
 =?us-ascii?Q?iCiqJhJQdps8A/hS1RYUwEB96V/mqMjv3EtrNlhhRdIqI/iE4iWjrQ6s+v2q?=
 =?us-ascii?Q?UStw/31cN17+Z1a/0Vs7s88qsVx3Vy/FDmncbw8LD//BI6mVz/LFaBcV+pOh?=
 =?us-ascii?Q?PXq6PRvdx+cCGnVmGf73sxV9CQdZqIw8zb4WdzILkWyfOasfDLtKylhELFsW?=
 =?us-ascii?Q?8849kO9ID70TtposyP9bib/nB93UlB1ONBH8EcyTkn5QLZcpwZJTlJ5HTX/R?=
 =?us-ascii?Q?y4TbJ668kARWGqcsuUF6UiB/lRHHWjRR8oVX0Ll3/1d5HL+n6zaGpOVGHQaX?=
 =?us-ascii?Q?Mgv1wVNfWsCF+WF/4jw/MPY5BDkXIP6rW7B7XMhH4SQTKOZ2MKGbtMYzSpGq?=
 =?us-ascii?Q?lu05jvZsrPj1FFItWNoK9Bt386lPoTJjBShqNRE72t9Oy6i13HwxKGTMjg6H?=
 =?us-ascii?Q?k7sTYXpDb4itJZOwirZZ+54/CNveKaCgc30uGSt4wI6kldrs5xvl02xAxRxf?=
 =?us-ascii?Q?nNc8cmR6baODh6azGuy7tMRrlLtkmdI/gulSA9YOWUZnP+4LBIxGhqWVvxV/?=
 =?us-ascii?Q?ebRHVnFt7356dfmKlrwL/lVyT/hsu93rk6j33G2fnpc3oHdCKmEPsqvRAKhy?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lkg4BgHrCUR9BT21i1iRNzVrhqnl2F3CbGXWxbsMUK3w5r9MKbCgelLy0MLU?=
 =?us-ascii?Q?0noTjaYB+v/NXOIX7X3zph7GofQ8X0lTsWeee1hDusvSc8nNTEQ/kNaeHZbj?=
 =?us-ascii?Q?YNI4gvzuM6n99dadk8n9vRjv48GNDwzLr72ArhUOplwGQsuc9rRhbjz8+uUa?=
 =?us-ascii?Q?gSdOStQBZsNasAE6K6mN/MdXKHRO4YMxk2xy1pCzQ1veQAvZFKBruIm14ukS?=
 =?us-ascii?Q?37ogIq/fn4zVUCtwFm8Zuvx8i5Pqlv/1TMDH8tfMz3y62c6ynjdxP6l2VjyP?=
 =?us-ascii?Q?vOFwKiuIn9pp9MSlnionJp4PwvmogPpaAZy4VWyA0AvxSfsWvPTgA5RFqpqD?=
 =?us-ascii?Q?UbW4XnzaBGTlpsjfyjIvxSyMWyb/NgJdqom3WB+WTkWjoY/ZPlfA9K4URRSI?=
 =?us-ascii?Q?ZbOdqaWee1ktzNSJt2Y6yJNsA9Jf5oc1Yo1YWvmK9z9aSUcMbspKoEv6EUDm?=
 =?us-ascii?Q?qpg6+9HlQ3EzqBGSqGT/uuFPZWA936x3HkP9EiuqodWHzWZRH0hgffN3vm8t?=
 =?us-ascii?Q?YxjbnpcUcaCx60HIFnS3NXAyzg1NZus+TyYOI/d9jHIdKlJoQyAfyHpF2ceY?=
 =?us-ascii?Q?d8twWakFrbHXY6AEf7Y6vvXNyOtKe5Kn/6nkLHGQusdFJ+VULJwFqczBFvtC?=
 =?us-ascii?Q?66oed2B/RwH5NVEdkFGqyi/Prh4oWfYs6bscVWGBA/23Wpy26YlklzDPo9DO?=
 =?us-ascii?Q?rNyuuUcB9TVR5JR1CzAel9oIPmST8L4YBfgh5K+0Y2LQvRlyYe6fUUoM70dE?=
 =?us-ascii?Q?iICsoAT63TAN9Ll+OR1aAr2o4TKtcil+BQQfIshQu8WIzMNk0cYVi9hPO+BA?=
 =?us-ascii?Q?v2Z4utHjyOR/mUcQqkABS4becPlZIsqwlLYl+3K9YYli0aJFsgNv8qfTy5Fq?=
 =?us-ascii?Q?0NFr1jHtyklZAi/VitFMzxWcBREaa/c4VfiVgr6oJ71qS2WGPv981J1C1jvb?=
 =?us-ascii?Q?7L+Q7+SUU/zQTemH0VtA7NWr6VsixwJBbrNW9MVXERz1sUpRparSEqomGu2+?=
 =?us-ascii?Q?SapBWbJoQCK/rxHD13OUzsyPJHxca2bDwV7zST8ze8W7SeJLeT0HYeyYC2mp?=
 =?us-ascii?Q?KPkFRR527sYO1JZ5ifr5zrKjDzH3Hwe0E/DsFe77CK4emNhy0ZSFg6vpy4iC?=
 =?us-ascii?Q?lm5QN25Bt1QiYVagTgoT7/7apuJZ1AvbDsSsyRm35MM1o5KKntLj4Vf2KUjj?=
 =?us-ascii?Q?Hl9HWWOe/9xRogzsHcH1Xd+DjmOIXtzl699FBWroVVvHuPR1eGbpvaOvLGo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4562e5d6-6907-4843-0021-08dbbd5c3d9e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 00:13:27.8580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qv/0D1Uyh6PwuQKIKZk5bW7ZHXRk8B+P0sm3sjpNBrya4gSmHd8R3+OMH2aY+yv7fZFnQ3T1o2Z/xpq+dooyPzfjBv5n+GeKq+qSutnIRRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7472
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-24_21,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309240214
X-Proofpoint-GUID: eLwHOQTFeOsnHrwPpzBK974ZR-akctT5
X-Proofpoint-ORIG-GUID: eLwHOQTFeOsnHrwPpzBK974ZR-akctT5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, Sep 19 2023 at 14:30, Thomas Gleixner wrote:
>> On Mon, Sep 18 2023 at 18:57, Linus Torvalds wrote:
>>> Then the question becomes whether we'd want to introduce a *new*
>>> concept, which is a "if you are going to schedule, do it now rather
>>> than later, because I'm taking a lock, and while it's a preemptible
>>> lock, I'd rather not sleep while holding this resource".
>>>
>>> I suspect we want to avoid that for now, on the assumption that it's
>>> hopefully not a problem in practice (the recently addressed problem
>>> with might_sleep() was that it actively *moved* the scheduling point
>>> to a bad place, not that scheduling could happen there, so instead of
>>> optimizing scheduling, it actively pessimized it). But I thought I'd
>>> mention it.
>>
>> I think we want to avoid that completely and if this becomes an issue,
>> we rather be smart about it at the core level.
>>
>> It's trivial enough to have a per task counter which tells whether a
>> preemtible lock is held (or about to be acquired) or not. Then the
>> scheduler can take that hint into account and decide to grant a
>> timeslice extension once in the expectation that the task leaves the
>> lock held section soonish and either returns to user space or schedules
>> out. It still can enforce it later on.
>>
>> We really want to let the scheduler decide and rather give it proper
>> hints at the conceptual level instead of letting developers make random
>> decisions which might work well for a particular use case and completely
>> suck for the rest. I think we wasted enough time already on those.
>
> Finally I realized why cond_resched() & et al. are so disgusting. They
> are scope-less and just a random spot which someone decided to be a good
> place to reschedule.
>
> But in fact the really relevant measure is scope. Full preemption is
> scope based:
>
>       preempt_disable();
>       do_stuff();
>       preempt_enable();
>
> which also nests properly:
>
>       preempt_disable();
>       do_stuff()
>         preempt_disable();
>         do_other_stuff();
>         preempt_enable();
>       preempt_enable();
>
> cond_resched() cannot nest and is obviously scope-less.

That's true. Though, I would argue that another way to look at cond_resched()
might be that it summarizes two kinds of state. First, the timer/resched
activity that might cause you to schedule. The second, as an annotation from
the programmer summarizing their understanding of the state of the execution
stack and that there are no resources held across the current point.

The second is, as you say, hard to get right -- because there's no clear
definition of what it means for us to get it right, resulting in random
placement of cond_rescheds() until latency improves.
In any case this summary of execution state is done better by just always
tracking preemption scope.

> The TIF_ALLOW_RESCHED mechanism, which sparked this discussion only
> pretends to be scoped.
>
> As Peter pointed out it does not properly nest with other mechanisms and
> it cannot even nest in itself because it is boolean.
>
> The worst thing about it is that it is semantically reverse to the
> established model of preempt_disable()/enable(),
> i.e. allow_resched()/disallow_resched().

Can't disagree with that. In part it was that way because I was trying
to provide an alternative to cond_resched() while executing in a particular
preemptible scope -- except for not actually having any real notion of scoping.

>
> So instead of giving the scheduler a hint about 'this might be a good
> place to preempt', providing proper scope would make way more sense:
>
>       preempt_lazy_disable();
>       do_stuff();
>       preempt_lazy_enable();
>
> That would be the obvious and semantically consistent counterpart to the
> existing preemption control primitives with proper nesting support.
>
> might_sleep(), which is in all the lock acquire functions or your
> variant of hint (resched better now before I take the lock) are the
> wrong place.
>
>      hint();
>      lock();
>      do_stuff();
>      unlock();
>
> hint() might schedule and when the task comes back schedule immediately
> again because the lock is contended. hint() does again not have scope
> and might be meaningless or even counterproductive if called in a deeper
> callchain.

Perhaps another problem is that some of these hints are useful for two
different things: as an annotation about the state of execution, and
also as a hint to the scheduler.

For instance, this fix that Linus pointed to a few days ago:
4542057e18ca ("mm: avoid 'might_sleep()' in get_mmap_lock_carefully()").

is using might_sleep() in the first sense.

Thanks

--
ankur
