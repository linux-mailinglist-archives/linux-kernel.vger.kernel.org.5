Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08A578284D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbjHULyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbjHULyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:54:37 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C44690;
        Mon, 21 Aug 2023 04:54:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nipsf7uzGkGdHMP3Lj0XB5h6N4/fM0mnhekONj3mlp9CxB/W8iJSkqq1hMrVupUttKhJSdDu1iYTLN8EyOEcNXIx14Aml9nHzJAzwuj81MgVrekDm8NLPER3GxK6Q6uK5if+pGiVwpf8AaQQuu17is2aHxZKDRfLNlgh7ToZ+HOu3fcQFG9Np+Qd1/bqs8SXj5B9DiV06iMKbb0iEp2Sk0sTRQqDz3tA//RP25mcmLtAu+YpycZfjTQ0OLEgQEn3BS4beHSGH3kni9oegajDv2Di1MF+I4qS06m+wl2bACEaMt3wqHiliLgPkQb58/8QIDB5Uh3VwSkFa1fgyR2PZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7bCijop8ua7fyMKfxf8tPhpv50m9K4/UBtWb7TTlJA=;
 b=jHJDByh3InyOnZAOJx9avOx7NUUnsmidhcC0CJOLUImurHQEpO3alPN6ye8+kMuIUFNuEkNMJz26BLeFuwked5vUyFPXWMWm3HcMCIxCnbzd5KW7MiCMl6X0FUur7rDF/cx5B6oO3Q5+W9SO8w/Ar+r8nD5FL78Xgoe90W7AL40AdLTsjVcK3fD27/mipwVXFVF+fNBJDNTwb6k0/g6X+EmPI6+2FVZGdWXWbAm/bxVPkA1I29WIUBwC1tFGUwNzK1pdg3hTAK7AW7rwDahI1iNYkZu9C69hTW5rfAGRlVJ6uUvNVtpMB5HJpxQGOE2KyG/yGxPcjmG0G1JkBfHE8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7bCijop8ua7fyMKfxf8tPhpv50m9K4/UBtWb7TTlJA=;
 b=bbIx99JzieIMNle4ZCFBKFLZGzRU9mSRSCZ/daCRV1B3zYiKoR5hhW7vS7J/XmYe6yhmE4e6MLPjYwSPigYO5n5MQSMgFc+FUKAoye4jaCOhjlMNSnv/hmGuE/uITtXZnIGWH7KU6j/e0Q8vmAwFyexJxqXZbZfZtBtxC4IbC3CCEX/wjJDTlekwXr+nytsICIJNy/r8d0BZk0A9W3+crT+yuUxvUifjGu1y8X/guyv9nWLLe+KdLYD3EGKLFROVis1R1sUnDHouxNEBGqq4Ij/WlgF8BTLfEGrV+I/vJUA//HAQcNr3e1N3jbcz4f86TXmpuMrdV6UZNAHVfvP3/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SJ0PR12MB5439.namprd12.prod.outlook.com (2603:10b6:a03:3ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 11:54:33 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::3bf6:11f3:64d7:2475]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::3bf6:11f3:64d7:2475%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 11:54:33 +0000
References: <20230721012932.190742-1-ying.huang@intel.com>
 <20230721012932.190742-4-ying.huang@intel.com>
 <87ila8zo80.fsf@nvdebian.thelocal>
 <87h6psxzak.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH RESEND 3/4] acpi, hmat: calculate abstract distance with
 HMAT
Date:   Mon, 21 Aug 2023 21:53:13 +1000
In-reply-to: <87h6psxzak.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <878ra4wqz0.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0090.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:201::17) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|SJ0PR12MB5439:EE_
X-MS-Office365-Filtering-Correlation-Id: 473b8acb-ea9b-41f0-176d-08dba23d625b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m6aymPqBS1eWbbuheOlpRkdLubidxmZMTKV3TTXR4mU4AGViXHP6U0/j8Rs7b0/zhcxXwaNcZEJubLoEO0ahoa1/258zblbQrzJCKGPJP/5FCyBUbSZLJCYXUTj7k/3DPznMbLM6g0RaecQL/UQuLHSAV6Hc6NeKB9y3UKr6WiCXZNQAJzqyxpDz74U3VK5mDsf9He4HPy/O9IDVV5Q9bewM/PjLWW6SMpyoqzBuMKc+fOZrHnqyeuZf7RZ+M4sucvMc/ePtcAXQWgAaK4uxLot8ta61a2dTFCRzRO8JfmhkYgB306G5jml3E/jGNG4/Y8gnp2q0WCrWMKAkjgG+lBZnlgnDB8hw3IQINhmRlTaJz1sLmgBN9ITXtfn7sL4HUy/pHzxHXMrYp5frhWL1uN2VbAR9P+QctImY9H7rZ7nDdr9yeesYEfvmUosa/yx9AcU+Mm1VCQWwHY1udqCgdRu9vNrOBS2IysR2+5ccqT6vrt/b7K+zksAnWun1SUcGuoieh+DNpbHUEy+qxgOEg45Gdw3jq9sAIi1Ei5fhraw1EePgNdTdWHmgxWVPZjYE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199024)(1800799009)(186009)(2906002)(83380400001)(7416002)(38100700002)(6506007)(6486002)(5660300002)(26005)(86362001)(8676002)(8936002)(4326008)(316002)(6512007)(9686003)(66476007)(6916009)(54906003)(66946007)(66556008)(478600001)(6666004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9GFIovdmzfUV3Etv8AohJmp8AHZJW6EQ3yjU1qHnu+uJRxhNgAVf/a3Zwx+p?=
 =?us-ascii?Q?sDxxn8IFpXFgIx4vyG5P9HIU87gK0YyaMIDs+IEKMhtT8HzvOE/XHtW/b5Z/?=
 =?us-ascii?Q?SJ2CLF+ftdpFXWsd7/4I4n4O2imy2YaGr5xSw7IU5MqD2xUFsbFVOS3FVwUS?=
 =?us-ascii?Q?fpkt0Cdg54AYr+Zm11RzTaG1DIX+eV6cXgF6VeLHu8kmX5NSg5DemfFfCLWX?=
 =?us-ascii?Q?Ta+NYoNzdeYn1clh8kuvbNUwlTvKN1Sh3TkFtrQ9ir19L1Kfyj+QhOaVZkEl?=
 =?us-ascii?Q?eIdfILk21JVVV5BybwLSUHd1nuaogboObuEpYNMZ/VBN4L1luUGMoASqSzPf?=
 =?us-ascii?Q?5twARvMbdYPlfSiasx6QEhVydpySj6YSHUFuJS+Mm6v9FEIeMjUfV9glx4j7?=
 =?us-ascii?Q?IQD99QrzJrO3MPMAPy+eW8R/vXJ2lzFMY9Lp+ubh937bkYmJTnYhfNCBdkIz?=
 =?us-ascii?Q?/PBz1mkN/H+m4A74bcp8rtIicIQjAhAdtoYHIB/XyCz6JqsMH2CR4fAKds3Q?=
 =?us-ascii?Q?F7zTVvTSCJet27Du7xJ0AAjy4nrQZN1lsSjqarCWBqe1j+wH/i+vuDInb92u?=
 =?us-ascii?Q?HWEyuF8EI1ue25nbo2cbOdqVPDopn2aFFYdLc6Lsu1M+PllNAJ/KOXpPUtrK?=
 =?us-ascii?Q?QZ4bT2q/M8tGNqbT64HeFll0Q33x5/ORnL56cA073OcAsce4FxLPXULdW4gI?=
 =?us-ascii?Q?pq3MlMGylottX1BGcA25nMYMVqptTIJqP7XU4NGPFGsIak4MZuvIf/s0hqRq?=
 =?us-ascii?Q?bikc+S5suurC/ho5Lvu+io7bBOVkPgeLKEqF9Ra18T3Yct6nzCGeHDEFNkfM?=
 =?us-ascii?Q?X3Wd7SN/1/UAscESXdB4GqjL5NlGVKtPL85LIB4GxdstCJyn4To6QMxa6IdI?=
 =?us-ascii?Q?lma5IgjV08vtRCCikq9Y0LURD+96ke4Rt3PuWAmP6k7Px2XMqLfVHopVpqb+?=
 =?us-ascii?Q?63F2xFjOyIisXHMkhf/zMaqDhiK4FS+WPs6M8KbsSCVLihBrjq9Et3GpsYdC?=
 =?us-ascii?Q?TmKafpYBVA17i71FHLNqdgEIuv3LvAYVm95HABJhRszybSA8THhSalzZSuWp?=
 =?us-ascii?Q?7zC8RjPm5roGZ3iKDij9vTD2RaaIKaqWqX0XalC5uJJdzYJsU+g+sS7sP2xp?=
 =?us-ascii?Q?OFK4l+AHOEwzsd7CcmOHu9lVJzrzdWYdExXYcTPFkV/+wwLuJr1vZhZ7ibx1?=
 =?us-ascii?Q?Td0H6hNh6/ty5+TNgRqlzHfpQmPmUWB3lmXTQg8oJgBHiUJM4hng+svXMHzq?=
 =?us-ascii?Q?FefNh1gP2sk5XlKKh2PHMKd6/ejQc8BXzmBD1y3ku0FEksW28Cv/JV3J4RJ1?=
 =?us-ascii?Q?YBK0smvrA4l4GIy2R1CVFMTPYrwI7YhbIJQlLlrQRGoNA9qeQhsclMtnc+Z4?=
 =?us-ascii?Q?vAuaTwtZTFOTtcMFtuiubBFuwjrQB+z5igT4dbf9XVRne3TS1sWHMz4oZAIf?=
 =?us-ascii?Q?uo93Q/A8tUls8AN1Ie5XNpA4m6JjGwNeLuvO7UI+4htnUrdrrA3E2vzM51n8?=
 =?us-ascii?Q?vW7yXbztYFZUQvHG5J+TmC1C9J3C7n0oiHK2CzVY1PF7qSWGQwLsaHEWCyF9?=
 =?us-ascii?Q?BeT9oMDuL6NxYon+rvsasc4UUp2yyigDH/xdQ97X?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 473b8acb-ea9b-41f0-176d-08dba23d625b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 11:54:33.1179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYPZAGVLyOPTV5YUqQNeXhq0rRH+CAYnQc/bTEGNe52JePnWrXQRm9/7r/zr8RO4cWMYTkeWl6dqPJqAuFU9bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5439
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Huang, Ying" <ying.huang@intel.com> writes:

> Alistair Popple <apopple@nvidia.com> writes:
>
>> Huang Ying <ying.huang@intel.com> writes:
>>
>>> A memory tiering abstract distance calculation algorithm based on ACPI
>>> HMAT is implemented.  The basic idea is as follows.
>>>
>>> The performance attributes of system default DRAM nodes are recorded
>>> as the base line.  Whose abstract distance is MEMTIER_ADISTANCE_DRAM.
>>> Then, the ratio of the abstract distance of a memory node (target) to
>>> MEMTIER_ADISTANCE_DRAM is scaled based on the ratio of the performance
>>> attributes of the node to that of the default DRAM nodes.
>>
>> The problem I encountered here with the calculations is that HBM memory
>> ended up in a lower-tiered node which isn't what I wanted (at least when
>> that HBM is attached to a GPU say).
>
> I have tested the series on a server machine with HBM (pure HBM, not
> attached to a GPU).  Where, HBM is placed in a higher tier than DRAM.

Good to know.

>> I suspect this is because the calculations are based on the CPU
>> point-of-view (access1) which still sees lower bandwidth to remote HBM
>> than local DRAM, even though the remote GPU has higher bandwidth access
>> to that memory. Perhaps we need to be considering access0 as well?
>> Ie. HBM directly attached to a generic initiator should be in a higher
>> tier regardless of CPU access characteristics?
>
> What's your requirements for memory tiers on the machine?  I guess you
> want to put GPU attache HBM in a higher tier and put DRAM in a lower
> tier.  So, cold HBM pages can be demoted to DRAM when there are memory
> pressure on HBM?  This sounds reasonable from GPU point of view.

Yes, that is what I would like to implement.

> The above requirements may be satisfied via calculating abstract
> distance based on access0 (or combined with access1).  But I suspect
> this will be a general solution.  I guess that any memory devices that
> are used mainly by the memory initiators other than CPUs want to put
> themselves in a higher memory tier than DRAM, regardless of its
> access0.

Right. I'm still figuring out how ACPI HMAT fits together but that
sounds reasonable.

> One solution is to put GPU HBM in the highest memory tier (with smallest
> abstract distance) always in GPU device driver regardless its HMAT
> performance attributes.  Is it possible?

It's certainly possible and easy enough to do, although I think it would
be good to provide upper and lower bounds for HMAT derived adistances to
make that easier. It does make me wonder what the point of HMAT is if we
have to ignore it in some scenarios though. But perhaps I need to dig
deeper into the GPU values to figure out how it can be applied correctly
there.

>> That said I'm not entirely convinced the HMAT tables I'm testing against
>> are accurate/complete.

