Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DF47DC1CD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjJ3VVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjJ3VVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:21:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B83F7;
        Mon, 30 Oct 2023 14:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698700893; x=1730236893;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NHQAl1mvT4REZIFPXQdH9kjT9A0zC11d8hlJVVYtz98=;
  b=KJ9UExJvekKRTmMwyySY/6v0LAcMQRyXgyVJb64DAj9jOEjZl8BxepGj
   x4YD97UNIcxJQ8uyALBCHvgMr5xjXF4guQWEuQgSpXp19TWnGG4OlRG+7
   DZHnq9PdiN6ybyxq7VbjNNUAdM+cRChWj1zhCG8GTv6RzI1GGitzepGDQ
   VvzklVYYwma9FpxVapMeKTATEUWFBz9FK+ZeOKNdzqwQcNYwCCJCWm/qo
   EeNru3tkIVmNDyA4ssPjQnaCKfOxPPNjHwYM66ujtnj9mLp5iYZKnKThs
   DWypf0RIFG0F5EFXqFo5e70Aa8vErV9Pe3pU5uXUuB92LGjF8s560jelt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="474407027"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="474407027"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 14:21:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="826180414"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="826180414"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 14:21:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 14:21:32 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 14:21:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 14:21:31 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 14:21:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hx95kaxM4yHftYSeLIu4Q/IKt8Sm/1P04EJeK+BdtzUxpJ5XoskSCwP4O0dWcNC6ubGxT1jgcMYVytNDjnA/RwYfNeZY5m2yeHtK18vz2/hbcsw2KYL9cL1sDybaRSFPr1Pfxd8R+tMQY7QCYEsdgvHgd2g53WJsmN7H4PUD6GNkahz2YYUnOEjzMw386nD+L4HYZosLB5acxev82YRXsYjbT6rXpbW5q0uhunu7Cmtf/EdHRgNAM8BltmZ6qCu0dON1nFUm3mN59afdXIgRjYSruLDLLIXVT3Ldo3DGHs2K8hKxuhLNUMbDSB3Je0LdxTrVOEY7GTcWo2OFDVtqxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBlWJmfC4BM3AJEMBIrBr+mz0PrAKvmyH2nY+eazKP4=;
 b=gv1ecBXkYpTCAn8+Dhtndq61DbtqCkSTLV5l0XoXWB7/p1YgyYHC+J9sSDRRysOznpzR7S8PAcgBm8taQn7mzgS7AJchubWdrUTqgd/7M2lgkvXlkAJeWWsf6OY3hRy3W6B1+/PPBZO0mbltvlmjo4wNF6GPPZrxT0HTPSiXZjYjQk2+Xj+nrtda23h97Y09ik4+5YCimXBHdbGjpHetxiGAZ/umVtmUjKnlQZnIdJ4qkstFjxDA6V3pQ//qPYv+F4+eEzAhZz/mvDKcaqKocHaZiNQCpyaLlmlu0gUGIm8aKQ1xTVCk51Dqc8ww+rgp5FBuHUdru1EcHDF5jwpRSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB8136.namprd11.prod.outlook.com (2603:10b6:8:159::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 21:21:30 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 21:21:29 +0000
Message-ID: <967f9b61-41d6-4a4a-adc4-0b3c742bcddc@intel.com>
Date:   Mon, 30 Oct 2023 14:21:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/8] x86/resctrl: Split the rdt_domain and
 rdt_hw_domain structures
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Shuah Khan" <skhan@linuxfoundation.org>, <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20231003213043.13565-1-tony.luck@intel.com>
 <20231020213100.123598-1-tony.luck@intel.com>
 <20231020213100.123598-5-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231020213100.123598-5-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0277.namprd04.prod.outlook.com
 (2603:10b6:303:89::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: e6330b06-a191-4c9a-7fdb-08dbd98e2ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cSru9+igyFYVtX5Mjy76JcIozPRuKBSev95rUf5DhivaLhjpbkd19SnpkuwTVeQ0oMFICELZPlK1GwUQJLhXXNO1HIHPUXmS9AkhDcVjueu2J2knUHeDZcDbcmH3JVKVzUdWYyejoR4J+9upZBGnUQh8vvKc6E/vWamafy/tddW0f2rbF2vPGLti1SOMarb7IR8DPkTmh+4pYe/8EIJcnzfACxIGwLsWeLvftaJaKt6eYVNXN9Kf3TCd09VXj5wuCJpYPkTMk//13gnXGDXTKLBiS6lsp9Z0lI8sQbAL5lKs+GzlzAnWzxoNx/wxZLohdCGRGVA2jQ+NhwP69QPJ/ACRheRJVy2IHoTmU1mAOjwsAYaZcMZerG7o8nB8YI4GcZRejTYytt1x7qsk+2VU2PtO3DKzNj2mqjaa8jkbsGVIAIR8pkmzTu2PprKJx9+vNdCXSVvwncZRGDH/2/1REgZ9JGd4GUwjlEfFi0/kXsfMW6Ey1b5JNu9UvBFiLPjSt03cNXIC2EnvSjP5CjgArQqO6YiERpE1VGN7orb3sLp54aKoo6IXej7fHk8nkV3MiCs/gVRaIlZ1I9t3nX2M3bMoCl0BdoOSQWNs/OZQMlulCQdCOVXMKXVpPWZaxsWiF3IsKzFqgJi8wYRJLsAdMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31686004)(478600001)(110136005)(6506007)(6486002)(66946007)(82960400001)(36756003)(38100700002)(2616005)(41300700001)(66476007)(2906002)(6512007)(26005)(66556008)(53546011)(44832011)(86362001)(31696002)(8676002)(8936002)(4744005)(54906003)(7416002)(4326008)(5660300002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzNlT1l0VjkzVDFlUTUzRTBUSTRKQVVINHQzdWlUVnY5ZDNOZ0ttUzFJeXlj?=
 =?utf-8?B?ZndYU3pzTE5aZzg2K01nRGlxQ2lTZ0JPUlZZY2tQdUUyUlA1L0xRbjZSWDI0?=
 =?utf-8?B?RktjWEEySytqSG9lbk5zamxaZG5YN2NjR3ZyZEx2eUhEUmhvWmlrZEtvcTQ4?=
 =?utf-8?B?eTlzTkwyZ0Q2bkUrNnNpMVNRN05iNlptMGFCVUpVZ3NoZnFEVTVyWWpnRW1k?=
 =?utf-8?B?ZmYyYy95eC92NngzY2RQWG95em50bjBkbkpTNWhMdWs0S01ETUtmanI4VDdm?=
 =?utf-8?B?MzFZcEFYQllBMWZoTzhNY2hyM2xNbEVMZkNhZ3ZQdUdSdEZ1Y1Y3VHl6bHZk?=
 =?utf-8?B?bmJ6bmg2YmxGS3hIV1JKdllSbEpJRXBabTFMVVJhOC9DVlMwTS9aQ0ZxcDlJ?=
 =?utf-8?B?ZGZqU1dBRTJuTFZCOXM3OWx2cmdwT3F6SmlmNGw5bWNZY3R1TVd6aHZOOTZM?=
 =?utf-8?B?MmVKTEtQQmllUGZQWU10YzgxNUo0Z3FlLzZRdTdyaFlZb2w5RHZnaWdhRDVI?=
 =?utf-8?B?YVNKbXJNWXBLNjNMUVZMQjJHS0ZqWFdWcmFOamdVK2t2WEpneGpmekQxektX?=
 =?utf-8?B?RFNuN0dmOHJHQUV2c1F0UzBKSXRrNmsySTU5NWJYSE82U1o4MXphdE9iUjg2?=
 =?utf-8?B?Z0N0QTY2bng1Mlk5YXMxMHpVR2dTcXJLMTM3R0RIcy9tVTRkbE9wbENRcU9l?=
 =?utf-8?B?VjZiNnZOOS96ckhtKzBRRDE5SVRJM0FqS1VHZTE4d1VMRU5lbExyNENVcWRt?=
 =?utf-8?B?Q2s1ZzRac1Jqa20rc2lEUTBzTVNqQkZBSkNQbitJWWhMd2JuWFhqVXA3bGtU?=
 =?utf-8?B?dExNMFc2enN5M2lBbFpmdHFDQUJUR2MxNVZ4L2pnMWxXR3dPSlJnV2VzbzBZ?=
 =?utf-8?B?UHVmV2pHMGxIcDlySWdrTjJRY3pSeGVDaHJ2NWh6RmJldG1odVR1ZTVWRzZt?=
 =?utf-8?B?Ulg1M0RnUXk2SzdMQjN1S1FjYjNTZzRMV0kyempuYS8wcGNXVDV4MmJnMEVl?=
 =?utf-8?B?NXA5UElNbWJzSG1IcTNmUm5ER1pXZG1sVHZzWE05M3hOTWRXdkZiblZ0ZkxK?=
 =?utf-8?B?SHFuVlpYaHJsb3ZJUkRxNHJDQlcyQ0xjM25zekFaTlV3SUlnZFQvMUZrV0Nt?=
 =?utf-8?B?ZXRIWUgxT2E1SUMvNlRBcWRoaFlnU1M0K3phNjQ4S2MwdFo0cGhTS3h2K1Jm?=
 =?utf-8?B?bGVPZ0xSWWN6emptVU9HTk84bTdYM1F1WFFFQm5NR1pCQXBmODhsV0o4UEZr?=
 =?utf-8?B?bmFYeWFIN2xCR29JaHRHcTdnUlVLRUI5ZFp0RzdEWDliM1VnK2ZNWFBmb0h5?=
 =?utf-8?B?TlpYZTdDWnpjZ0lUNHNGNFhSSHRSbnUzdXo5dmZYSnF1TTQ4MXRBV0JVdkln?=
 =?utf-8?B?N2JtbWRiSE55aStCOWo1THczUWp3ZUlWVkVLWXRIZkdOSkRsbUJtVkNUSEFX?=
 =?utf-8?B?TXBWdXVjdDhmUitCdFNBQUwzNUpPV2xSbityY0VMWDBHUjdzUDZHUXplckVy?=
 =?utf-8?B?WjV5L21tU1ZsNjJ0bXhCZ3BmbHdvNlVUbUxwb0hHVy9NakFob0F3ZjdLM3hj?=
 =?utf-8?B?dHd3UUVUdGdObTJpUGwxU013ZWM3UHNZd3VBblQ3amV6ZGdPNmt0ZlErZk0v?=
 =?utf-8?B?TEl6d2ZyaFhhZWswTXdJbUY3RVVWcDdNeVVXaEtmaTVSc01WaGE0WTNlTnJ1?=
 =?utf-8?B?aTdDZHVEWGNWRnpBZ3dXenlYMjVnL1l6bUg4cHJ6aE0xalBqamJTdFBYK3Er?=
 =?utf-8?B?ZzVVVEFRVTJCK0xPTExkWjBsOHczTlFBdHBQTVg2eCtxU1BxK0I5YklEa1lX?=
 =?utf-8?B?OTE2TjQ4U3k2TXMwMXJVZmZXemxNRnc1bE9xS0lWOFpCbXY5T25HaTFvSkhG?=
 =?utf-8?B?TVhXM0pIbnphUzRiV2d3R0VNNHdENzVMZVhld0hhMFp3UFRQbTcva2RqSHRS?=
 =?utf-8?B?TlUxQ3d1NFRVNDRURjBVK1QrRG91Slc0R1JLbHZrUXdSVkR5T3VJVW1OdUg5?=
 =?utf-8?B?UEFuK0ptVmtSYTFzdGt6d0NpcmY5Zys1eTB5T0ZnSWFHUU1HdllmbDEyc1hz?=
 =?utf-8?B?dXZVRlA5VHZoRmV0eUc3VHV3OGV1YVdmanJldFg2a05uUkRMY3J0NEM0TE9B?=
 =?utf-8?B?QW10RjIvVFp4RGg0ODBSNWh5WERCZEw2dEVTTElUQ0hERW5zb0lKSTRwRWg3?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6330b06-a191-4c9a-7fdb-08dbd98e2ed8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 21:21:29.8768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufcONHr857vlF0g9PbVqveBP8SkaN3EaJNDcnvmKXVOVJh4UML7HT4Bff05URL5QR69AOfhnyIa4nsEbLsRDOu+5XRgcV33+GJfFaplFjfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8136
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 10/20/2023 2:30 PM, Tony Luck wrote:
> The same rdt_domain structure is used for both control and monitor
> functions. But this results in wasted memory as some of the fields are
> only used by control functions, while most are only used for monitor
> functions.
> 
> Split into separate rdt_ctrl_domain and rdt_mon_domain structures with
> just the fields required for control and monitoring respectively.

Sounds like a motivation for the cpumask to form part of the
common header?

Reinette
