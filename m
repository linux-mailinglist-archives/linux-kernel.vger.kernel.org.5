Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9468A807DF6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442957AbjLGBf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441937AbjLGBfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:35:25 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22F310D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:35:31 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B70ocKD001337;
        Thu, 7 Dec 2023 01:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=hEkw0Ryx4PyfouLF9/8BLLj5LcIPtiixHu7uaY0GxfU=;
 b=CaRS+VHsDL+30rfpNnclD9/8nPqLepDfdNoFAEKnAnktvXEDCL9VOQaFqI/LnvZHj6QE
 ZKfYzMqStjTThWB6rIl9EhCfTFman0fA+wUsP5Mu6JL8kv8vn1rQYEmh80IeCznnq/w1
 uZT0LmU2CBHjZJcu25418rY+odt1gYrZCKvKxKoEvMEheMIkJJw2B6OzjPmNHaJvLaus
 AdbFF8vvwKhpngyU3TUziMVTBj4r9G7hvk0ZpixG4F5AD0V7blqD6qcQvAiCRmmjfd7U
 l5JRQvcBpLNOuZKKFZ2hKsMXIKQxZOFZ3nDJ59Pv5mjshQE5YOn9C8IdOWIwig/QH/fN eQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd0mjt2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Dec 2023 01:33:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6NxbK3036728;
        Thu, 7 Dec 2023 01:33:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3utanar9sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Dec 2023 01:33:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=As3H6oXhyNUfIeD1kV/fB6RM1HSTTBXsNXAyc7vEWqV11p21RRwMFaKU1GvVvhcEqmXkPsqausFxkhml8MLeGX7pjBZtpZagCMa+zWeQYj9xeCHso3016hh4vXYUCBDgGi5SQqsKpwT0L3sEJDtcjnMv16jRJfn9Xq6H0fP+oIfaVivdzM4/13IVk59ACIO4at4DNITAaUeqZ40eNxbHa0ib9+gkFqqqzxeVN85/e+vvTpNJRVAugpp+9wn7RQPNQE2HvYrAfpfCOwUjfHRbDTa0yRormtupZUBwNUW1eBTbDDxV9dHf5XQLqAVp8gW6Ok8/4Ks3oiPtitwm2WvR7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEkw0Ryx4PyfouLF9/8BLLj5LcIPtiixHu7uaY0GxfU=;
 b=V53ow5P6svSwZsu+ENHiWpseQ2BvqJGAyR4d4nV82jQClPw+iQKoQz30TL4aqg2Ep24MtpGu8JFo72U+kAY0OhZMH0iwiXkAecVSnuL1O4qJtYrQm/KsbDcFH3bt5ymGsKK3Vf93Y74Otka/lMHpvDP9Lqajkygkcm2o5ahALdhMwlgwrZEZZiMhcoz0wUU8cfLJ8BHZWHoiIOsSaxgLoDeAACl6uHXIiPAvpQh2s44sfo6fXVitKckAJ+6PDScWPs5VTMS/bm57myOdUlOifNjQ5eXthdME3XmljKh/sMCPm2FL0abFrVg5OgzC+ZJEKZcMD12BzxhEpE6dzpp1Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEkw0Ryx4PyfouLF9/8BLLj5LcIPtiixHu7uaY0GxfU=;
 b=UMM2Vy7TlrmfO6+A0jR3qeJoCbmNpRlpcSlVfWaDMx3LvPPnXg7OJy10qE5JJyNY2blpgwkmj5UgUuyvJ5BSIpHe8X8CV+04aJsqqoqls3237HQ2/Id5vZTM+34yC0KakLrQ6g0bVAqQogd2uDE8C4NCtsmanmK55EzgU3j7dPM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA1PR10MB7699.namprd10.prod.outlook.com (2603:10b6:806:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 01:33:10 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 01:33:10 +0000
References: <e939c924-1dfa-4a6a-9309-2430f19467f5@paulmck-laptop>
 <87wmu2ywrk.ffs@tglx>
 <fa1249f7-9a5d-4696-9246-4913365b6715@paulmck-laptop>
 <20231205100114.0bd3c4a2@gandalf.local.home>
 <1375e409-2593-45e1-b27e-3699c17c47dd@paulmck-laptop>
 <87il5cpfn1.fsf@oracle.com>
 <106ab2d8-f63b-4c52-a93f-fc499d43fc13@paulmck-laptop>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     paulmck@kernel.org
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com,
        Simon Horman <horms@verge.net.au>,
        Julian Anastasov <ja@ssi.bg>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RFC PATCH 47/86] rcu: select PREEMPT_RCU if PREEMPT
In-reply-to: <106ab2d8-f63b-4c52-a93f-fc499d43fc13@paulmck-laptop>
Date:   Wed, 06 Dec 2023 17:33:06 -0800
Message-ID: <87sf4en6el.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0025.namprd06.prod.outlook.com
 (2603:10b6:208:23d::30) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA1PR10MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb17900-be2c-4f7b-1e8c-08dbf6c4787f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +RSSRm3oeTHGwxWeQPL4+lpSn/PqgTO7eGAv2SrOZKiXL2BtXolsCsKtPEh9SOYhhtH4dEsnZFE5OypQcJ/wXf0LHWuUSpzjTEWyscagO56Ho429DMEk53gGtvLDAJ3ifAtUJ7OwK+ORpx3wOWNASZ8XrmfJp0ZNtFT7k/5f6LuXB2cgsxjAHUPZxaw00LuMjQRqcSkP/z4CS+gJVfqzyAWumFwNVmJB6xLruqky7SMeamc+cqGIylG8EH38jLDlzXTIMFJ+C5XizuecHKloO+/FVo5Ma0+TSN0+A4sUaNcKwjYg73N+UDAKlqkaZ3HrivJMVG6QX6OK3eldYn501vTq09sxXfnYOPFWF/7KYjWjBDSt9i+dsShnhLgLZBfQzdL8i8bol4OwhuSQdzm0OXXxt1bWgbZ32Ok9tc83xEL+UOljOAGyrt1fAzK20V8Upy8vnaU26mIHRM8vMI31AM1SY2+1kyLd03nr5pfLMbGcbShSlajxhyErrqs/F25as64UGkfEoJT0EKicbc9H3aQqlNzmzNJ4Iw3b2CJ4dN8hJgVFT5enC2m6dtcsouFg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(478600001)(6506007)(6666004)(6512007)(6486002)(2616005)(26005)(2906002)(316002)(5660300002)(66946007)(6916009)(54906003)(4326008)(66476007)(8676002)(8936002)(7406005)(7416002)(38100700002)(66556008)(86362001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mtcvrvFE8ARUoy1XFiYuTTsf55lc1DKpPCNWIFp0iwfmqrUex/vRBGAJbruM?=
 =?us-ascii?Q?dI12zDy367O2saTfbcpAUfV8bkLgafD//eX5ZnnTbz1YLMForLySCGiToRhU?=
 =?us-ascii?Q?fPP1azON6x0JEPdZp+zTw1i683Qslfeo+bydNw+E4MUnqT1o4VzOMFENUu1F?=
 =?us-ascii?Q?2ADA7+jdzGbu6WBpjzer45NngT+l/fBOcv2A/yZ3yIN4jIWmtEzpYpx0wT/P?=
 =?us-ascii?Q?mRNmkQE45jzL82mXPrUNGC6OIlenZkr4Fa5pzPT5r0aShTUz/aWsIszNd2Ic?=
 =?us-ascii?Q?A2QkydgjI8xGiByohudZLYVgkysjlawJc14Vy+vfZDQlseVpTbimNFazZuly?=
 =?us-ascii?Q?YObSG8LsXVu3SVfygCmtu4cGP+4qADigG/zZ6V2cC2DPJIeT/dtmKqHFcMT/?=
 =?us-ascii?Q?TtF5OU5wtcTlocqU8b//hOrBUcETc9AFpFIczcCWCm+r7XJQ8tDN495wCsYQ?=
 =?us-ascii?Q?nsQJkBa7j0wpSGkjnS1uv4AJUvzkZqnjXvIH0hw+U3+H9y5IgUsFOb9mhbF+?=
 =?us-ascii?Q?g0grrk0sagvYWkzMp4w+ol5ykQlKSERzhIgYM9UT/8VvkShjo8pQLC6lxexm?=
 =?us-ascii?Q?pupdHjx8WuLu5RJO099nAJmTv6drJdvr527QODWskBRajBQrvmyikxfnj2Li?=
 =?us-ascii?Q?MMneyuQkB6MZny4pZ+UX3eugAMz6BU4fCjp8G0km5+ssqQAI5nGPs4H5H+Jh?=
 =?us-ascii?Q?KN9R7alXmqA6F5AVuJBVSYS8wbnySYHWdyHof62C5KC7dg+Ve6jnAhS84bH8?=
 =?us-ascii?Q?3Uqkb7ChpKTWWgfnS2PRW3k6dRd81d01HX3H5pTAjt4bMyDrf9f/C9aaowPO?=
 =?us-ascii?Q?lVVadgKfKen6zbRFe/U5FhwIFLnncG6u79W2sM0z6qwE1ispwws9j2BWScCe?=
 =?us-ascii?Q?+r7B99xMw7LPbNY86z1e2neIuq+W15gla6qiHjeqFLjCCH1NLWSG6CNeP4X9?=
 =?us-ascii?Q?GzZTu9e9Sv5YG8xbRV2h6PD0MKERfbvKtecc4xBhwSSX+QUJ7jarmxoo3Lt9?=
 =?us-ascii?Q?aOipH8r4c+HcPA+A8nf//pGpyaelpH0Q67L92uGRuyBAl7Zo6lZ7rn0KLwVS?=
 =?us-ascii?Q?DVqvDGIr4BTR5ifPiWv8CByEFD3atAphQEwwBVNCItuSs4cFuYg4W43pMHZf?=
 =?us-ascii?Q?M0lCtDr1ToCHEnf4g6JDdPhiO4ep95/RsqdZNITdT+WrpK/5kt6SERO1PKCH?=
 =?us-ascii?Q?L1S1hoLlWGFjDpdZYoc8Ra/doP3RULIWBJcZF0gN3Igcy2OqZLiyIRYtNOgM?=
 =?us-ascii?Q?/WQu0zox+iZb1aYFDbUpS7GG3YaNxGxeXao4S+BF4lsx1jTH9cYTjr3rRplH?=
 =?us-ascii?Q?dOmDKNM/wczQ8LldEZryMK1dvkdyZyQQ7r4ZdDkapGNaoZcHHGywPGtr3i1X?=
 =?us-ascii?Q?9qN6GQGURLIN5v+I4xuyFbeZK/fSMF1nvZaJ2BB5IpKtXV1GXFdRaFAbUK8U?=
 =?us-ascii?Q?otyLkqJuc/BFBDCfs7MqwHWWBciZYFaAJL/UWRu1SaiSwRQmS8BGu3PM0Zed?=
 =?us-ascii?Q?9qzL1LOSfDcnilDPELwDjtxk7LWwKWjF0dBkME4GWkqejolFS8QIrpzeanGd?=
 =?us-ascii?Q?/IFItqxwqjr8T1Q8xtltTw/6Yk2gNmQAI5QKCfYcKx58Nzh9f083PrKn4+qA?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PiqD8tbO1Duiye8NR/9LO2v0UblBhoO4NV1uEE70j5cg7nh36xjI4Z8YhuyY?=
 =?us-ascii?Q?ZJsmHPAARIS9l7ER95BgjQjsJj4sLUqFUNwu2/31W6wK72LQbZoFpZy9ne4x?=
 =?us-ascii?Q?0T3fZFuxiI9+oUlRWpXsoAbEPAwlCXVZz1BBTmQmGAw9zN/7ERA3tUNnwZOb?=
 =?us-ascii?Q?2vtkfGyHSAKUCPdbsOs0xWHm5nzwDsNCvqx+zpQprnI+qjLdVVTS7bd1SmDr?=
 =?us-ascii?Q?c+YaRJFNj+UigMf/6bk608OzAu/BsKwd+8pqcp5BtYCuTibVaZ8bXnKPWNKn?=
 =?us-ascii?Q?yy+FyHUKZQNz0OfMi9TjUJ+SC2iG8VVSmk/DcWz+bMfbH9YoV/5XEHBCw9rz?=
 =?us-ascii?Q?ATDjM+/h6wrbjdcI+mn/jJ5PmM+7diW15lD7PrKP5eBxWvpz2let4duX/bZ0?=
 =?us-ascii?Q?ectLFvtg0NuSZ2/ZNNYZ00mV1ocIt+B1M11yV1ZFxW6o/wEdTVjaw600k6qJ?=
 =?us-ascii?Q?xC8Y9TbY1CIr1ev2q3/r2KSJKuWQiDgTe4oM1uMJbM6pfhctgTFZgA9AMfzP?=
 =?us-ascii?Q?8HjNuZC0EqkaD57zzIH8HLtb9j+xC5LCCu7Toh1w3Pg+ZDy31qqJzZ8Jvoi9?=
 =?us-ascii?Q?3JWHA818ypqDxlzLfutCqWjJoNgp3GuDJFAK5s00QcNmntsLUR6D6TuMAx+k?=
 =?us-ascii?Q?+BI0J4Zzhrhf0zG8v8ztj3MfYuH0VszgwYHVqr4kXUniZyJLoYE9tGl3Z25Q?=
 =?us-ascii?Q?uhsjpK/xoeTT66gw6JUlpYS/1jWo4+RBt9OL/RP24qYqDfWsUX6TRO1Pvu4b?=
 =?us-ascii?Q?nGIAIkADV6hQgSbii4/TjmJ20MjK4+KR2Z4tke2m/11pDCEM9eNputq6aZ7Y?=
 =?us-ascii?Q?zdb7lmDrALfQ0NgeR4yPHDCasJJKnjyGjJsA6QAuPKBnWJmOhMETTnujqz70?=
 =?us-ascii?Q?4y46TpmnjcvzSRsOl/XE9/ZuMKdhSUz76y7jl5FvisnZLnSCFe1n/RRPoL75?=
 =?us-ascii?Q?68endRmrHxEJou5tmaTmMzllWhelPnT3iEjBvS7quxi1o9Yp8HuLCw3ccr+D?=
 =?us-ascii?Q?z6e2rzqQNwNNjN7cDT5Wew3AtQmlmJ4pSj1W+YBANy/TtYWqEOHxkVMqaorL?=
 =?us-ascii?Q?3i0Ixi1BE0CilvlR3YH0gJteXQnCBXXcvA5TdZG5J86Y7y5TEah0+sUojwKe?=
 =?us-ascii?Q?57bL/wi8z9MLU2znzKbxMGNLW9QQLwCXMzDHG3qV4EDYcMm4EexM/fjSd0Rx?=
 =?us-ascii?Q?Euqs9uJ8v2e8HfAocGFhSKVPn1/blIV2fw37i7nVtPci0RHy2+/f9gcT5vFB?=
 =?us-ascii?Q?+M5dWm683fA8cF/6jcC7eaPvFtMuPY7ZJ1ecIQgHs/LJWGfnotLJj2XqmXFW?=
 =?us-ascii?Q?w6RVfQC8LTawQZGbfTY8c8TduER2c8G3ShD/kGkMN7/S9jIaC4jZamFCq50M?=
 =?us-ascii?Q?NLbsud5ofulRx/So6kOOutEE9tF9o7EXTxFtJsZfzHIqiF/MnyXCL0t1IxnB?=
 =?us-ascii?Q?rr/3VruJkpjsDgzwymmc9uxP9TpLSrT8BznTn/QrglSBL9SDiMFTxWDVHr5U?=
 =?us-ascii?Q?hkWlEjKpSIoJ8fpmTPxppTjJSylXxsFQdgpMEXaZXuje4wtkv7hJqBWWfH9m?=
 =?us-ascii?Q?wn8F0lVZnShUwEI1T409/hIWG0uCGZWDS1sVhY5cMdr4AwqIw8jw4lACW/gy?=
 =?us-ascii?Q?to7QSwv+iRz8z71oHTLmMVA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb17900-be2c-4f7b-1e8c-08dbf6c4787f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 01:33:10.0865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzdvx29nW4CY1xItDzPY1w+2P2IRISlcCGb0MC2BdM9dehkKqzlTPvKJiHapGGemJCSMP1GAK3DyfZX1wi1KuAFtD9L57Sstcyfn789HWtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_22,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=799 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312070012
X-Proofpoint-GUID: iotwQ-qKLkI5V8zjkVfmAVDYz6fEp7-2
X-Proofpoint-ORIG-GUID: iotwQ-qKLkI5V8zjkVfmAVDYz6fEp7-2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paul E. McKenney <paulmck@kernel.org> writes:

> On Tue, Dec 05, 2023 at 12:18:26PM -0800, Ankur Arora wrote:
>>
>> Paul E. McKenney <paulmck@kernel.org> writes:
>>
>> > On Tue, Dec 05, 2023 at 10:01:14AM -0500, Steven Rostedt wrote:
>> >> On Mon, 4 Dec 2023 17:01:21 -0800
>> >> "Paul E. McKenney" <paulmck@kernel.org> wrote:
>> >>
>> >> > On Tue, Nov 28, 2023 at 11:53:19AM +0100, Thomas Gleixner wrote:
>> >> > > Paul!
>> >> > >
>> >> > > On Tue, Nov 21 2023 at 07:19, Paul E. McKenney wrote:
>> >> > > > On Tue, Nov 21, 2023 at 10:00:59AM -0500, Steven Rostedt wrote:
>> ...
>> >> > >   3) Looking at the initial problem Ankur was trying to solve there is
>> >> > >      absolutely no acceptable solution to solve that unless you think
>> >> > >      that the semantically invers 'allow_preempt()/disallow_preempt()'
>> >> > >      is anywhere near acceptable.
>> >> >
>> >> > I am not arguing for allow_preempt()/disallow_preempt(), so for that
>> >> > argument, you need to find someone else to argue with.  ;-)
>> >>
>> >> Anyway, there's still a long path before cond_resched() can be removed. It
>> >> was a mistake by Ankur to add those removals this early (and he has
>> >> acknowledged that mistake).
>> >
>> > OK, that I can live with.  But that seems to be a bit different of a
>> > take than that of some earlier emails in this thread.  ;-)
>>
>> Heh I think it's just that this thread goes to (far) too many places :).
>>
>> As Steven says, the initial series touching everything all together
>> was a mistake. V1 adds the new preemption model alongside the existing
>> ones locally defines cond_resched() as nop.
>>
>> That'll allow us to experiment and figure out where there are latency
>> gaps.
>
> Sounds very good!
>
> Again, I am very supportive of the overall direction.  Devils and details
> and all that.  ;-)

Agreed. And thanks!

--
ankur
