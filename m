Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C929E8073F4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379428AbjLFPrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379415AbjLFPrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:47:40 -0500
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEDE9C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 07:47:46 -0800 (PST)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B67PWEK018017;
        Wed, 6 Dec 2023 07:47:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=date:from:to:cc:subject:message-id:references:content-type
        :in-reply-to:mime-version; s=PPS06212021; bh=fX5SHfxTiLBevpMRFz7
        3Mqt0GwNmbMltLktu4gZoxDY=; b=pw2y91M7r75VMO/9C4NLh47qzH00MhTxIeS
        hY+erS1iy27lDBqtzTvOalFfV7cjiSKPjF8g7Q1V91tNXyNWG2bOUb4t7iDJo4hP
        0FVaVkPNy6VouqhAEUyZKBruo0AyqqGLjpwhUVY8RLiNS8L0XwfSIpR1Zc/epJ/i
        1vKGTQ7hurH2z8o45xFdqoHtAfFY8sXEMTjREWwyRP0SEunch6eJVQKnY+t2LN82
        TV0dgN7REZq5U6eM9oa89Jem2V3eQDVwBVLK8i5SLtheR8XPfT+O2YNAaEVHBc4v
        4gimBslpLUayCzOPHGZc4dAiP44moX41UZYtXMLh0BL6BtJbp7w==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3utd2rrpep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 07:47:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+2fOVXn+bE4SctXQXrmZNrtOicCojM5X9zvWT2gI0CbQAsQFHUpCRUHgBZSw0tTCbSlMiDjNck0of2Ut9l1LAtRvhZgPnTBEDcn1Dll7BaxYHfyuZ8Nw6eBgrUbFdwDnrcinMrMVIUWmBW7PZ+MYUd3Oc59XbuLqUBY6R7OWkmM1xWuc9Bmga3U1sQGxi3XEh13a1a7m5MLDEXHamKAbKIL0IFaoPguT6ijJcTA1RGs74mJfLFCkDIVnhLHRgc79OZR5puaijj8H7m1iil4CgzsI36CR9f+vEOBknR1ogvyD+Des3rWRDnyWShnGNXSDgoboJ+KBr3MEDqMhYPrpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fX5SHfxTiLBevpMRFz73Mqt0GwNmbMltLktu4gZoxDY=;
 b=X8CczJoFTthP+G6qIG0Yhi1nKAwVAVo/w7/bIx5Bl9w2yWbsOi9f8jCNaqIm6Eu1jwmWplkfL2uh3+CKmm+u8lf8z2NOMBOWwCpbznhhqCsySA+wIkNgQusboKscUjwfISmXn6CbhI+TJtwgWvbEWOn2/OS27xtq7nFmsZ7oYwB9BepYAQ6LCHkr0dr78zecqaGISK/+x112KEzKQfmTVolheYsNagaRT7F9OoniSUd540I9ecVd8V+N3zP1vmZBpRQ1VPwIdewI0iIFLDhU8RUOOJPX51kWOINj99Y1+x4ekhE8VXfNFJ7kPjZxMWYFMzuDIaX7xfHAKtPfs7ygrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8)
 by CY5PR11MB6233.namprd11.prod.outlook.com (2603:10b6:930:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 15:47:02 +0000
Received: from IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::5548:b43c:f9ac:7b95]) by IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::5548:b43c:f9ac:7b95%4]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 15:47:02 +0000
Date:   Wed, 6 Dec 2023 10:46:59 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>, bp@alien8.de,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        richard.purdie@linuxfoundation.org, x86@kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: 32 bit qemu regression from v6.5 tip pull [6c480f222128
 x86/alternative: Rewrite optimize_nops() some]
Message-ID: <ZXCXc+BtnLzqMbFv@windriver.com>
References: <ZUEgAAGDVqXz2Seo@windriver.com>
 <0adb772c-e8d2-4444-92b0-00cbfdaf1fac@leemhuis.info>
 <87r0k9ym0y.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0k9ym0y.ffs@tglx>
X-ClientProxiedBy: YT4PR01CA0300.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::25) To IA0PR11MB7378.namprd11.prod.outlook.com
 (2603:10b6:208:432::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7378:EE_|CY5PR11MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: addf37e8-2bf8-4c42-83de-08dbf67296e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vo3cxD1b5zHu/NZh7WUbYghPwThsQSmQ4o9wmb9kCw8E4t8tg48EgcZgrXb44iSXLUccgpVJOKRDunPZHdQdoY93I6EhnMtidykjXNvZHUgI32ytQdZHqQCNjRykNnsQi7DGYW1D5IEqytOkLrZnxTitfSM/W7+WzSEeNnHtLtHl9OVzTPei4n+Xp2gfEiRSvwCkwr1khaStAleKJrj1Kf+1W8qfyFfhewEf095PX/Q9n6wAny59o0OvCjorTlAxprS9/a/XCtL79xeiLMfL/5ojwrEgO20ADgbhGwiVTepn8FhMz7LTB18o5I+4joa3/RCmwpq57f4jq1C5giL+6C+Y17wPHTCZUKmVTNhvT8qwuaG5x8btw6behw6O8Oz4FWh6vADPg13GaKVBKNSYB/sf9YZM3up+dLRCyLnYEoPZMTeUyl5XOOhIi+olIMW+4GAnPH7QtqJAS0usVcc/Y7DSsPJEyd9CEQDLVjnp7DIPEEZCLLfpJCiCw1uD4bTnuarUzbxFiEzPepBpzpZmoUJ66iTO8eoIE9mdP+r5Y2CawpB+uOSoiHin41Ad1QbJZq9F4+GY7VpwkIyC5yRXfgcQClXT+070P27J+Uae8Ds=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7378.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39850400004)(376002)(396003)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(478600001)(8676002)(6486002)(966005)(2616005)(6506007)(6666004)(26005)(54906003)(4326008)(66476007)(66556008)(66946007)(6916009)(316002)(8936002)(38100700002)(6512007)(44832011)(41300700001)(36756003)(2906002)(5660300002)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AoJK37anaV1u1vvRnRQoA9Uynt97QLchh4GBRtsswtA01UjzIaYTFiuC3u/2?=
 =?us-ascii?Q?iBb8oRIL95NS2M4RlybfXerTDzg8j+p8kh8xN0UmnZGRyF2mZAhLMdj+dDmW?=
 =?us-ascii?Q?IUzcfFugfClUCMEG/xcasC907lnunOMBjnhjQpMbydzgLCHCYBHQF0LOU/Zq?=
 =?us-ascii?Q?qvEAxnIE9KG9PcfMotbdq2ouQ2P5BFyqtWTCdpsGQW9gD6/6WGMdI3nHCgSZ?=
 =?us-ascii?Q?tOvlDNUgu3hcl3P0BiE7kAzWsax/A6C0lO7ruzldGfDPEP2igLpcWW0NhVXN?=
 =?us-ascii?Q?6Z9++ue1GoRQ1GAb6dWQN6viLh065Ewij8bGca38CFtafAS/a0d7ncdPFFPp?=
 =?us-ascii?Q?qL8Fot2nM84Ep3CgiwGFTI0hROOSioKa/MHEm+vzqMrZlLyIjWp2HhIO9clV?=
 =?us-ascii?Q?Bzc1ugu8ibc6E1EqMk2lWsrx72+Yz3LuzqRXyGH0QRTvJmvI2DrkaJzikapD?=
 =?us-ascii?Q?2JARtjG18ZSzDZdJDN716t682PoUd7ijvfl2k0UpRU/CPQSYBoBYU/Eph5K1?=
 =?us-ascii?Q?TO4AKhAtFpwShNd+SkRFOVU3vDYf4eqQpo9Tp8EzDSQh0oRHLpuuA66iUY+g?=
 =?us-ascii?Q?unDCwvNa9qIqIEMT8K5Pg8dVSGTfNhKTMgEuX33pqdQLrVtmryMrnn9uZcqw?=
 =?us-ascii?Q?B46veDYllzC2Ip/jiAzIoZHtvWpC2ymn/BkykQ6FdsBp5u2DNyOSSdB65sm0?=
 =?us-ascii?Q?VMsKl0yaEpEJmQM7ppoaabCh3WpKuyPsAaEbw8OPS76hWzteN50dIsq60h66?=
 =?us-ascii?Q?bn/Bj5MCLWIx2F45EQir9CNIX6SvDOq7PpQQjRjnXeYOq1gWrZ88TP4t8fQP?=
 =?us-ascii?Q?I36B1pnpoFHhYgxaFWxAf4HedEotxAVQvFch1vHrCuuZ7pMbY9wYAC0dSzP8?=
 =?us-ascii?Q?FyWCv2sEZ5dimdLB1Uiu87WnHQcHEYCG5Ro4KqNZoCMZMPT8AiIc9vNBDkAV?=
 =?us-ascii?Q?gtBqmTJheyed6yC2fRJYUAg8qMAeO6JFuTuajXHjqTS4XekVoDkPQjVkIyGC?=
 =?us-ascii?Q?EDgRMasv06LA0a//9RVtq87JgGkFwfJOQ8kLEGP2a7KmasgzaTUN7eU/nv2Q?=
 =?us-ascii?Q?kC++LvH1UbhYm8I1d5s3A2631Hq4JYbfqOy/pQObZPx+PaNtOrjndyp8r9Cl?=
 =?us-ascii?Q?MZuQkVsWBZTvU+nj5DyL3wgZ9+sTyKFcqNKtlwjrZBmBygKAFrWiPiK42MoL?=
 =?us-ascii?Q?JzIKffwWm/kqqIlB4nGf9jujAc7fk3tMSbU0e7QjKnCoYR9D4xgVbpF26i+a?=
 =?us-ascii?Q?yjA+7vQ1jdvw3DAeiNRnFP7+x/dnxKfM0OHaiELvQRd4ZsxNXSzuhhBWRLSj?=
 =?us-ascii?Q?xhiplbBt5tHZbgV4VAAvGsf1dZV9dNGq4g2i+Hx5VtfThwM5ksmkEbrHLZOo?=
 =?us-ascii?Q?SpcjScfs89fIZGFvkX++ecB2+mrMlWcXEkWTuiex4MfVVML97x3RH17BSEVa?=
 =?us-ascii?Q?9Ahr5FhpP42idgI86JrY0twQBOaGuB4iVWQZWyXbpeIwgbW1DRkmW1LdWPNa?=
 =?us-ascii?Q?2DMwPFYC3oILJZVY7qXvCjy9vn9CM0xFGIVZJhBiqXgQw4nZsDzNurQMYoFg?=
 =?us-ascii?Q?nvyjVBRqnUGEbRyy/b8lCbGI6Kogeh7G8O/UKNJPfvTUymERpuWWRdevHJYh?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: addf37e8-2bf8-4c42-83de-08dbf67296e7
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7378.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 15:47:02.4257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1RUcodBX4LcelTm9N5bjVCVPj73Bo3Qp0jfYlwf3nBB/WrFliT8kndvt0cokixQIfg8kRwyJNThsxBqMtcR8jkhheoj6XEVWdUPfhLwyHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6233
X-Proofpoint-GUID: 6ErXZOrAhz3GaNztaXPjpnyCvyhzzfEZ
X-Proofpoint-ORIG-GUID: 6ErXZOrAhz3GaNztaXPjpnyCvyhzzfEZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=733
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312060128
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: 32 bit qemu regression from v6.5 tip pull [6c480f222128 x86/alternative: Rewrite optimize_nops() some]] On 29/11/2023 (Wed 09:57) Thomas Gleixner wrote:

[...]

> > Paul, was this regression ever solved? I wonder as I could not find
> > anything with a "Fixes: 6c480f222128 [...]" tag on lore and this thread
> > looks stalled.
> 
> Hmm. I was waiting for the .config file to materialize and for an
> eventual analysis of the alternatives debug output....

Sorry - was off for a week vacation, and was playing catch-up on my
return and 32 bit non-KVM qemu wasn't top on my priority list.

Then I did a batch of runs to get a fail, but without also booting with
"ignore-loglevel" - since the lines are debug and don't show on the
crashed console by default - start over!  :(

The config file and both "good" and "bad" files are there now:

https://bugzilla.yoctoproject.org/show_bug.cgi?id=15230

There are a lot more debug lines in the good/working output!

$ grep alternatives: dmesg-debug-alt-good.txt | wc -l
4868
$ grep alternatives: dmesg-debug-alt.txt | wc -l
19

Paul
--
