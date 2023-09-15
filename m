Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EEC7A2396
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbjIOQ2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbjIOQ2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:28:31 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2114.outbound.protection.outlook.com [40.107.6.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D7EAC;
        Fri, 15 Sep 2023 09:28:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CasTkR2yvqvf9NlspiKnpl7o81qpCiqLeUnnmd9ZVpuefWv+AoTnRBf6RvsxR0By6TWh8bBrpsWYHVBXk7FJbsE7DtkcvnvhRuf71rBvuou7a0YIsjIb24inE/466m0CykM6oMbv2GZl7rWvaFRtQiAopG3X2rw4sPz1gls5Qadbm9oBCbPfd8a00/bXcFRvWqprt4tl6ZgVaNILO3GiVlzjMrNzUgnStZQodqvl1YLwgh6s2rVToEyeFdo1mZ5Rtv6ZIlbraXiYq1kAkWy2PWWipxX/LtLB8CRe3pDzzf2MfEapaaSTbVZ5fgMVx69WPHRMFOr7kDQXrl5kx5NU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIp9c0r4oDhvktFlmE+QUXKFtuojSvUvh6DDju83kTE=;
 b=eoJVhQyZbkZbGugohmBPyOLm7o7SOAGib9HY3he/KaFUF0CfKNWD1+gNQ2+NqU0p1I3vUE0Vhn0usNhTTEpSDB54/uYNJJA4ChlQngoyLGbCfMQYkrpvNkJVjaW0aSZoWtHYlljwJCN7aiSywR5CwH6eUaeTMYUHhRw4Tl5uFPMvWvR5I7gfHoQVPHRZeikktkajYUZAOqa6yEtGJGdPQQIR/ikjdT0Z84kAl7ipBHBw7L7Xr/524GrRUbO9u0bg+3Mv2KBZtZMqGCs/cUyLYD8ZKjPy1HqQm54EhZr2H1xdSgBPWmu2gxm1DyuOsF26pp9MsxtxzZtWww0A3RQCMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIp9c0r4oDhvktFlmE+QUXKFtuojSvUvh6DDju83kTE=;
 b=XKXd1sMVzKMZwM3nmmN3PwW9sziFNvvcLnpPSlddRz6yiBdG+bPUMypyMgQwWm6Lcaj0Zy7tYFcqv2u9KiOEJOZIcmFmmTFHd6B0FjTMil0RMdBDlqc7kwtzIHQs8zuirLhIX3INSFXvVyCZUtEN6hosu+voUNORaTut39o0h5vkkcQCg9eAlDe/5K8XflmUS0VPygC2Pr6YEC8CmqVI4FjabwfFuNBwikvw8D0R0rUgjQyLAuEPwGZF7cstRmfamdf3ODmDwlNUo8tnPVt9lb4OZJf9ad5MdY+he7VRVOoat+u0AGgr+vLbEAzBureOrssY6u5M6Un7Ui1RLhplJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB3298.eurprd08.prod.outlook.com (2603:10a6:208:5e::31)
 by PR3PR08MB5867.eurprd08.prod.outlook.com (2603:10a6:102:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 16:28:22 +0000
Received: from AM0PR08MB3298.eurprd08.prod.outlook.com
 ([fe80::7ca3:ff75:8b46:deb9]) by AM0PR08MB3298.eurprd08.prod.outlook.com
 ([fe80::7ca3:ff75:8b46:deb9%6]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 16:28:22 +0000
Message-ID: <30f16b4f-a2fa-fc42-fe6e-abad01c3f794@virtuozzo.com>
Date:   Fri, 15 Sep 2023 19:27:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: ru-RU, en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux PARISC <linux-parisc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <1694366957@msgid.manchmal.in-ulm.de> <ZQEBkjSgdXSOMq3t@debian.me>
From:   Michael Labiuk <michael.labiuk@virtuozzo.com>
Subject: Re: Possible 6.5 regression: Huge values for "commited memory"
In-Reply-To: <ZQEBkjSgdXSOMq3t@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P191CA0012.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::15) To AM0PR08MB3298.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR08MB3298:EE_|PR3PR08MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d1a7150-e7d3-4290-bdfe-08dbb608c73d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +rXAVkoUg/w77H1KsUpZd9s+c+FHSx1O4bSI4PD3/lbfmVxXx0zIMAf5HOeXGmvlf0l+hoqMIlDt5pwRe9SqVvvGJNT0hJDd/SJJEIXLVUP9UHLXiDLBUcn83Lix9GEyDc9zWqTmwjPhKVgBMBzE27ov+lPlCCg+wC3bynAKisTOg7jlLNhvUZ7SZfpcJBcSJeG9oBQMDAaNZqyEHjUwIxd1106YeVxepdOYuyWH/sdYniJ5iN6dJo1V+s1aclVr5A3w3FhgTh5zbaEKktL75osQOizuTadzfTBJPf03JQ5dPzXLZpsgcN74I5MXsldfmQ13lG3K/9FdCyYVnbj70Os4+EO6uHzP2E/PRhFX5wUeiooZBUfT6HX/CCDXeuW/aKB/VXelM4Axvrn6GZr+18JJO4r0ZC6RJ+ukrqJUOSWazKb9sNTqcjlgT5Tha7/BwUOptvQBtIj29jLUydYqyx+tRIdKqNupVwgSoIQy+b+hRPCS1JhsErhJ3ZuUvf43Xu71xCrXl/Ml+V1zo3B7XajsDQqUTXHdoJiMvqmJktM0AZAlp09NYTL8AOz9ioAO5iKOg0fPGGPUguvHsYXxrPQM1BfTi7x5GLT7Mh5MA4TqLILBYeCsQK/vtzzzBfBI3F8kp4SIMyKcuFrwJVucMKec0mqYrYhRcJ79J5Ogchs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB3298.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39850400004)(376002)(346002)(366004)(186009)(1800799009)(451199024)(41300700001)(316002)(110136005)(86362001)(66946007)(66556008)(66899024)(66476007)(54906003)(478600001)(38100700002)(36756003)(2906002)(31696002)(44832011)(5660300002)(4326008)(8936002)(8676002)(26005)(2616005)(31686004)(6486002)(83380400001)(6506007)(6512007)(6666004)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFBxSENHRHRkR0Y2TWQzQnRHRTBnMnRtRzJnbCtJYllQSkdEZHJRZGc4NVY3?=
 =?utf-8?B?L0YzTkRRRlRSczBNak1SWTY2SDM2NkN3TUMvQU1PazZKa0sybkcyTkp6SkJB?=
 =?utf-8?B?c2pReWhDSUhBN1J4clovSkRMdzlEL1IvZmVwY1VQZlllcWJxdmx4MVQwUmY5?=
 =?utf-8?B?eGlOQXNQNjVhTFhINllSelVXcFpWUGJCT2s4aVNVN2lwTXpjNFlhMWRZNkt0?=
 =?utf-8?B?cVVyWXhIWFEySU9BdUFoUnBXZ1BlY2gwWFhZMHZBeWs5R3hZMWp2NmlxRE9o?=
 =?utf-8?B?bUJKdmk1S3Z6bzc3R1ZYaWZXYldQeElHUnpITE9GSk9WUXFSdEMwbXJoSWRR?=
 =?utf-8?B?YTU1ZnZCODVqSStHcHRsWkFOaUpZYmhTUURvS3hRcXBJV21VcGxSaXNpMDdt?=
 =?utf-8?B?cko2WFVxWEN1ZWlnNXdJUkp1TU95ek85eFhCbk15ekRLNm16SWxZQ1lDOFZC?=
 =?utf-8?B?T0g5dHNKa1N1QmluZHFJVFJqNnNoUFVEQ1pFdCsxSUdYM21rWkRBdVM4Rngr?=
 =?utf-8?B?eFN4U0Y1K1FVSDJmTHB1MG1zQitzcjBzL3dMdlZPM3JiKzVrSDdFekdncUhN?=
 =?utf-8?B?b3BxU1lvR2s4WFFNM2dRNWNXelZMQW16VndvQTVIa2kvampReVliV2JXTzd6?=
 =?utf-8?B?cEM0eFlOajk5UWxkclp1MGtHQ3dRSjAxUVNxQlN1NXdIUnM4M3dya1YzWS9r?=
 =?utf-8?B?L3ZwczJsSlV0WGFPZnFPK2hmU0hFRVV3aWkrdEVxSStrRlJNdWRCUk1zY1hm?=
 =?utf-8?B?MER0WFhDME5WV2JOQ1ZGbGdTRFJCdjk4ZmNreW9sU1BDclpwUGhRSzVXaWJz?=
 =?utf-8?B?eDJxaFNuNzZWbTFIYVliRG5tbWJwaTRvOFZuWWdtdDBFSkVmcnZZcVFqZ0g3?=
 =?utf-8?B?MzFFdXBCc3R5ZXl5YTdISHVQRWUzaTF4OWF0anJiRExjWmQyMmh5aXQ5L0xK?=
 =?utf-8?B?TGtEcVdFbHRrS0llTER0VEhDUEFtMk5hK3pyTDBBQjJ1TWYvVXlZbkpla1hi?=
 =?utf-8?B?SFd6QWs1dVh0eUo4RHBJVTd0OXFtT1FPemNHaFkyTG02Ujk0azB1MExnd25U?=
 =?utf-8?B?SkdlUmNTa3BqOEdZaHhxR09ablI0MlQ2em03RjVRVnkwUllaTWJuNFp6OU9X?=
 =?utf-8?B?bWlVa2RxNkl6TFRyd1M3a0VSRjZGUU9LMjQzZ1h0ZmROdHhpaUxWUHVBdlQz?=
 =?utf-8?B?aERpWnZpbnQ4MWtxVGliM2x2SWU4QmZvMXpITXlxOEhLNE1KZGZKQ2hoc2k1?=
 =?utf-8?B?UzljY0pHK0RwSloybjdPWWZIaVAyNC9Hd1ByTTdQMHVFeXh2YzNoYWlwZndy?=
 =?utf-8?B?NlFzRTlaR2g0SExTejFpZHhLY2ZrNWFpWHo1M0cydmliakY3Q3VETXVheGt2?=
 =?utf-8?B?Nk9HaCtQb3VmcDVVbDFCcnpTYVZOemhGYURyUWswaTV6T09FTFNQM2E5elM1?=
 =?utf-8?B?WWdrbGh6NWRkaC9EVXVWcytRSHdKSlNnRFlRYmZpQk90OURjMVBFbFB4dFJs?=
 =?utf-8?B?cGx1bXpLSUYwSCtoYzEvMTBYQ0hYdjJicmJhbGdZSnhRUE9IbW1zMWttN1Bj?=
 =?utf-8?B?YUd0OEZRam8yTGtvZFAxZmwyWFpCMnpKUVdkQiswMDhseER1VThNT3daN3Bl?=
 =?utf-8?B?YnF3QTBkRTZKVDNhUGRrYXhvWUlvYUVJbG91QmhnYUlSUzQ3M3luSWVMZkRS?=
 =?utf-8?B?MFBpWXVJbkFBdXpwcHl1U2duUjVmTHZHcmVzNmFPOHIzbERmdGhzNWc3OTdO?=
 =?utf-8?B?WFRPWWVlTk9sM2o5anpEcVFrNUE1bDNCMzZHUXd3MlNST2txME9RNllacnJ0?=
 =?utf-8?B?U3hncmdHUHl1OFlmKytJL3lPbUgyVUk2ZldtQWREaWMyd3pWcWllbTBFN2R4?=
 =?utf-8?B?ZGVVNjFldDdWZGVaa2NDUm5kTGRCT3U1VWVkYldJaWc2dzZTN0ZKeElHaVhs?=
 =?utf-8?B?MnFqNmJCRHdTa2thcWxMblo1TGRYUmlkRGc1L0dCYlhOT2FabVVUR1hLZ25R?=
 =?utf-8?B?YUgrU1lzN0ZEVzBuS3pBeW8zRUJDN0NjbnorZlZqYVRpelpjR3d0d1NqZXNS?=
 =?utf-8?B?UmpmVm45YllNcDZmakpINm5rRXZLL1dNaHl2Yld4SkdPVHl4VG50UllyZ0Ex?=
 =?utf-8?B?dlJ3NnVLQVRDVVdxb3d0U1pKQmo2d2VoVS9ZRVYyNkZ6eEtPQ2QwUHlCZnZB?=
 =?utf-8?B?SGc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1a7150-e7d3-4290-bdfe-08dbb608c73d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB3298.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 16:28:22.2986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wz+zYXKMW0fSrSFF4IE5jxn1tPUVJWdrRGRnCra5Ih1KWUllkhLMV2WicDcwjkz4TtRgq8T1WYK15+PnhQjSbay8O9L2lcnn51NHRJrM4wU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5867
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am also reproducing this issue.

Memory overcommit is disabled in my setup. Committed_AS grows to 
mem+swap after 1-2 hours of compilation load and system becomes 
nonoperational.

I've bisected this issue:

$ git bisect log
git bisect start
# status: waiting for both good and bad commits
# bad: [2dde18cd1d8fac735875f2e4987f11817cc0bc2c] Linux 6.5
git bisect bad 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
# status: waiting for good commit(s), bad commit known
# good: [f60d5fd5e950c89a38578ae6f25877de511bb031] Linux 6.4.15
git bisect good f60d5fd5e950c89a38578ae6f25877de511bb031
# good: [6995e2de6891c724bfeb2db33d7b87775f913ad1] Linux 6.4
git bisect good 6995e2de6891c724bfeb2db33d7b87775f913ad1
# good: [b775d6c5859affe00527cbe74263de05cfe6b9f9] Merge tag 'mips_6.5' 
of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
git bisect good b775d6c5859affe00527cbe74263de05cfe6b9f9
# bad: [56cbceab928d7ac3702de172ff8dcc1da2a6aaeb] Merge tag 
'usb-6.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
git bisect bad 56cbceab928d7ac3702de172ff8dcc1da2a6aaeb
# good: [b30d7a77c53ec04a6d94683d7680ec406b7f3ac8] Merge tag 
'perf-tools-for-v6.5-1-2023-06-28' of 
git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next
git bisect good b30d7a77c53ec04a6d94683d7680ec406b7f3ac8
# bad: [dfab92f27c600fea3cadc6e2cb39f092024e1fef] Merge tag 
'nfs-for-6.5-1' of git://git.linux-nfs.org/projects/trondmy/linux-nfs
git bisect bad dfab92f27c600fea3cadc6e2cb39f092024e1fef
# good: [28968f384be3c064d66954aac4c534a5e76bf973] Merge tag 
'pinctrl-v6.5-1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
git bisect good 28968f384be3c064d66954aac4c534a5e76bf973
# good: [5d95ff84e62be914b4a4dabfa814e4096b05b1b0] Merge tag 'v6.5-p1' 
of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect good 5d95ff84e62be914b4a4dabfa814e4096b05b1b0
# bad: [d25f002575146d67b5ebea541e6db3696c957c25] Merge tag 
'cxl-for-6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl
git bisect bad d25f002575146d67b5ebea541e6db3696c957c25
# bad: [0a1c979c6b7dfe5b6c105d0f0f9f068b5eb07e25] Merge tag 
'libnvdimm-for-6.5' of 
git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
git bisect bad 0a1c979c6b7dfe5b6c105d0f0f9f068b5eb07e25
# good: [a507db1d8fdc39802415e4d2ef6d1aecd67927fa] Merge tag 
'6.5-rc-smb3-client-fixes-part1' of git://git.samba.org/sfrench/cifs-2.6
git bisect good a507db1d8fdc39802415e4d2ef6d1aecd67927fa
# good: [46e66dab8565f742374e9cc4ff7d35f344d774e2] dax/kmem: Pass valid 
argument to memory_group_register_static
git bisect good 46e66dab8565f742374e9cc4ff7d35f344d774e2
# bad: [170ab6c51a42a8a1c1a7ce09367b578db6f2f383] Merge tag 
'flex-array-transformations-6.5-rc1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux
git bisect bad 170ab6c51a42a8a1c1a7ce09367b578db6f2f383
# bad: [408579cd627a15bd703fe3eeb8485fd02726e9d3] mm: Update 
do_vmi_align_munmap() return semantics
git bisect bad 408579cd627a15bd703fe3eeb8485fd02726e9d3
# good: [e4bd84c069f212c01258e405f86e91f327888e41] mm: Always downgrade 
mmap_lock if requested
git bisect good e4bd84c069f212c01258e405f86e91f327888e41
# first bad commit: [408579cd627a15bd703fe3eeb8485fd02726e9d3] mm: 
Update do_vmi_align_munmap() return semantics


commit 408579cd627a15bd703fe3eeb8485fd02726e9d3
Author: Liam R. Howlett
Date:   Thu Jun 29 22:28:16 2023 -0400

     mm: Update do_vmi_align_munmap() return semantics

     Since do_vmi_align_munmap() will always honor the downgrade request on
     the success, the callers no longer have to deal with confusing return
     codes.  Since all callers that request downgrade actually want the lock
     to be dropped, change the downgrade to an unlock request.

     Note that the lock still needs to be held in read mode during the page
     table clean up to avoid races with a map request.

     Update do_vmi_align_munmap() to return 0 for success.  Clean up the
     callers and comments to always expect the unlock to be honored on the
     success path.  The error path will always leave the lock untouched.

     As part of the cleanup, the wrapper function do_vmi_munmap() and 
callers
     to the wrapper are also updated.

Looks like memory statistics depends on removed locks.

Thanks.
