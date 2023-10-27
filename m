Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1B07DA259
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346535AbjJ0VUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjJ0VUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:20:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6141B4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 14:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698441648; x=1729977648;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yv15JNz2FjUbKhrQClUxFnKA445zwsDJj9xK5OBcMkg=;
  b=ODRr3P3VKRkxyRox7MSaYIVfMpYMkweQ1oIEE4PIo9QDBpZhSJHOHgF7
   dNlhNjzqmM+lP9OmFp/ShbQXuGtNVO9AQmXbCsXK/EYDgSzeeXypeHsiR
   vIa62vuHC1eLcj7PqXmFExcEQaqE5RKX7QDjlHJHnaZySe9wyUsFB/61u
   ci0YUhimE1pyA76+0L8sGHFB3xIOvJw5GCXltAlaolj/vTO6lYmOi7ZND
   HVXinMwyOPKjD/GTcfaK4n1LgxM8l2TmzAyk6VeLphoK4NpnhoOHcJI/s
   IQ6XYiUdV/LHzv9eowfFjbTDW91f3GQyXdoHuT4eQ3meq3K/1J3BUH1XI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="385059522"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="385059522"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 14:20:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="736194367"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="736194367"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 14:20:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 14:20:46 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 14:20:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 14:20:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 14:20:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1poGIT44lwS9QJ5+LICdjQ2P+ygFf1ZGxdgpnbSc5nORHYMTo5Pyoaopdm8KseCKhSWwXGRGbFc8J56/zko//CDTHICh5kVasuQZ7stjsTznHxb4CqHgZwujunf63PHJTJaa8yA4QKXNk5DwOyScggy+jiiBhAQm00aXWbRTzDijSadTd3aBQVP++Z3mLJR/OuNCX2Bge/52s06eEiTio0LA9uro+q7S4mrS3PtTCfz2cWt6Km1u98wQ/3Y1+hQnoO1jO8cafqVTRvHeFBdlQTJNklZlzcBhUS62jovmCMLY18Rlx2KA/O1khHZ1DV68H38SUt5A1YLtra6LvbPOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLF57sVWxhSn1xDz416PUt6BCHHXkoaxdyPRzsd9VGw=;
 b=TGgy6fV8QCCyiT+7Rxn5f7Q8L6Yfop1UPPGypGLDBg2GnNryUG6qRCIGbZPVPUOBEKWwTJUyNm3OluQdGYYete1B8s60tdsaw4+O/BbkiYcJz3sr4y0+qfwGV1CzTAKuM3lusUVj+EXf+OGYxWMx26wfdRIOQgNeul0xaINn7M9db/kuErl/1DbpfaptiR9VUZhGUWKuzKt+pn9+e/7UHnzqOvvNH4bvsBnG8m1sLNnZPbn5VPImlCgo6PwiKVTFkSA/6L6Jp616g81UDQgPtuyptTJZ5hEllhDP61VDwuDdQBYZlOa2+E956ImCdpXndHABdagzrSkgJ4VhZvpvFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB5025.namprd11.prod.outlook.com (2603:10b6:303:9e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 21:20:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6933.022; Fri, 27 Oct 2023
 21:20:44 +0000
Message-ID: <d0d5c81a-1eb1-43e1-a5c5-e5b2511ffcd8@intel.com>
Date:   Fri, 27 Oct 2023 14:20:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 21/24] x86/resctrl: Allow overflow/limbo handlers to be
 scheduled on any-but cpu
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-22-james.morse@arm.com>
 <a7b99b15-5c26-3a73-b41d-c64b59126f8e@intel.com>
 <5f8c45cc-780e-92ca-4b99-6dcfd6db4d01@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <5f8c45cc-780e-92ca-4b99-6dcfd6db4d01@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0305.namprd03.prod.outlook.com
 (2603:10b6:303:dd::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB5025:EE_
X-MS-Office365-Filtering-Correlation-Id: 13769dd1-0272-4cc8-0b20-08dbd7329441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cU1WmI0pUDnIxYmI75z64sLGfWNMlAYy/BhepZWFU1Wo+hvfzPTRdc+5UiWsx2p1jctWYH9jdxaOfTZv1f0rhGIBLrqZwPozWSxy9qdaaoSQPjNbtzsiLcsPCgOFPmKtlJ727W6zbpmDLU72ddMGjRCAiP1RTBp38w3v+TkMhrJrjMeHBHvA2rRv3R6iGp2Jj/d78V4mGlcGV8vfJ1XsG+JwWP45uumgdJj5il7/KOrd3FM46bsr9lo9CCIbT8n+4n4WvLDQ/A0fTVmxnpHCMfcHIRiBPLE4ZspzMWII5m4k7RTyWuG+bhtvGZceEAFfOH4dqQtHXtr/afnITMvbodauKB8UiIQL8oN7V0iuU/ZAV0x2iYBiqTU4Ecbz7aB73usASfiHSnSRDxrElPL+1x2sUsWg7jkQD89Jbe3FRi09if2hQjkOKdZUkM3VfH+6W5qU5bwzZckCdJiExSUUZ8TPAdV9USUGi3+xT1YyvIjmA90qLW8hPITI4M0NSMn8k1IjYefPXL+ISA36eU2xrxtW7oCWrubJALZZBpHYZlNPKSuvt+cYly0RUBDUSY3MbBeRX5SXAcu0L5SoOrtf4TH5ILTidv4eqiUgi73oLCK2lhWHF9FPW33QeGsnSESydAup0h9MrkJrCTaGDF8FSeAIz0vqD31++w0Z+26MlDfcUEWTNGbXml6vOlXFZtat
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(396003)(39860400002)(230922051799003)(230173577357003)(230273577357003)(1800799009)(451199024)(186009)(64100799003)(53546011)(6666004)(6506007)(38100700002)(31696002)(82960400001)(86362001)(36756003)(83380400001)(2616005)(6512007)(26005)(7416002)(316002)(66946007)(54906003)(66556008)(66476007)(44832011)(41300700001)(31686004)(5660300002)(6486002)(2906002)(478600001)(8676002)(4326008)(4744005)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWU3c0V6NkEySVBDUHdnblIvT2Q0dUIzQ3ZWcHR3UFRKN3JTby9rcW50MnNz?=
 =?utf-8?B?VERXZk8vNURSYzVQaVJIalNNQ2x4SWJ5dWRZQ1FvSEpxaTduVmRvb2J4aDla?=
 =?utf-8?B?b0ZiQlprQzhRb1hkenR0RDYrc1hyNVlNY2l5UkJUWmNQdGZzRUREd1pwOHVu?=
 =?utf-8?B?OU1ac2hYQWEyREJ3Yk4xS2ZyS0hOZnAwWDZlMSt6aEM3aEhlZmhuU2lhUW9v?=
 =?utf-8?B?SG9oaUJZK3pRT20veDJaVjdDZ281SzlXQUhDQTd0K2UrbnluMUtyTm5xUlpi?=
 =?utf-8?B?aGczamFyVmZ1TC9idTdrUnZPK2xEUzFFc3JZeGowK3lBSEppM3ZlbnhMdEdp?=
 =?utf-8?B?M0FKUmZxZ1dRSkR0UWlWQWU3Q0ZFY2EvM2JsUFJiWkZFRDcyVWphZE1DcHc0?=
 =?utf-8?B?QjZzRy9GdGdjY2RveElrZVBPNmxGb3o0SXptU2pYaGFacnNJR28rRW1uaUox?=
 =?utf-8?B?QTMyU0tNK3FhWjcwVDdjcnUyR2UycG5uRWdORG5ZWFBEVGtiWlpTYS9FbEtT?=
 =?utf-8?B?NjRNbCtydXp5VmhuZkZlVmxVNTFQWm5ON2I1M1NiVGxGYlhRaGh4dXdkS3hO?=
 =?utf-8?B?OVNHVUlaQjlHNUlZZTBubG1FQzllczFwUDFuRE9QQ2ZHQmdQYnAxOXh3SGVk?=
 =?utf-8?B?eDY0bnhkcFJOY040YWRxbmFLTVhzeUJYc3V3ZEh6dmp5bHhlaVc1d1pUa3NL?=
 =?utf-8?B?Y1QxRVZ5SUorM3VybUJWNXZYb096Y0JyWktSbTVJSlNUYVhJSXBRN3p0ZVZN?=
 =?utf-8?B?enhTMVorNVBHc21iamlSNDdsWThRV2Yzc0Y0d0hZcW45L2VvWlhEU3czQkp0?=
 =?utf-8?B?RXpiQ29GdUhpWjZGK2E3eWZjMldUSGxGSWlyOWxDemxFZVNDMUE4b2pqeXBG?=
 =?utf-8?B?cVFsemNCS2F5b1Zvclp1anlyUnBac2FHWHdvUEdhSUZpWkxkNi8rYUdJODJJ?=
 =?utf-8?B?ZDBjYkhqWUN0U2RYd0FXYkJXYkZ0YjBlTXVsRWJWbEVZN24xaDJCdjJsZXBY?=
 =?utf-8?B?U2Z6QnkxK1UvVWFFRmF3UlRJN1FTQVRFQUViYUhjMVdkeHh0QlBOSDl6MTJv?=
 =?utf-8?B?M09EVEg5UU5uYUpiYy9CSUhvMDBZZVJpNzJNRWVjdUFwVzJZZVdaeGlzejFT?=
 =?utf-8?B?dFRwTmZHd2hhRFdKR0t6M2hNU1RMbFZBdGl4MG9YdFNMb1Fmajh1KzRKekFN?=
 =?utf-8?B?OUNCanhENy9idUo0b3l6V1M1VUwzSWFsdjRQY0szeE8zdTA0cXpPOEJ1cGI3?=
 =?utf-8?B?T091TWZGTDVILzV4YTkrZUMwYzNCQ0wwQ0VMQXdoemw3YWx5cCsyd3VqZysv?=
 =?utf-8?B?SWRkaFNtRmt6NzFaN1ZsMXhZNFFsRGxqUEEvaWNTYWE5N0NaRVNaMjdvUjFV?=
 =?utf-8?B?YmhUZ1p4RHFnWllWNHVmbVRqNGNsZWJRWHhGLzRpdHNraFM0NnVKRmxQUEZz?=
 =?utf-8?B?TTFHVExzbUpsbVFzR2RPeHI3TDdBTXAyWFFGZ1FlRHBZOHN6aUFmRnUwQUQy?=
 =?utf-8?B?QnVTeGsranBsR3krbVc5OHNxOUJJUFdqZ0tvd3dYdzFGU05nMHY1SU44TXNi?=
 =?utf-8?B?bUtQTkJpTFhsU2tPT0U0cU0raVNyWmR2U1lnbXROQTZUWkkrRXpIV1RndWNu?=
 =?utf-8?B?azJjdUhMOEZUTXRTVEVPZHZJR2J5dHhCeWpwKzNJNWZISmF3QVZkQU52WGR3?=
 =?utf-8?B?ek9ITXBYTmhIdlozdzQvZ0ZYL3JzVW1IMlZMem1hRDVNbFpaVzN5aGN6VlVV?=
 =?utf-8?B?Y2krSHNPWlN2TnM0QUNBUmwyQlE4aDdBbXN2MXlETEhtRlYrZnhWbnVmeFZy?=
 =?utf-8?B?S0RMbG9ZemJteUx6N0lwT2ZET2hzYzlzeW14NnB5Tkt4d1pRVC9MSHhCS21j?=
 =?utf-8?B?OWV2SGZhNVVoeXdzYVlnTlNPVVJ4eUJLRWdFeWxtWkVKNWROUkR3MGlGL1kv?=
 =?utf-8?B?K0xnU1AxWkJ5TkY2YkhHYVV5amVRZmgycnkrQUV4RlRvN0lyUHdrclN5c1gv?=
 =?utf-8?B?a2xteDdXYjBGTGRYSWJHZm5Zck1jQmNzMWdLSGN4c2ZSMC9VWitQekt1aXV5?=
 =?utf-8?B?VXpHaWFuTTdCV0Y2TVArb0ZXMWdDK1VySlhBbE5zS2FiZlJtWXVtUks3d0pX?=
 =?utf-8?B?T1hIRURyZ21qVW91dGRkS2VZdmRhTnM4SGNTbDFrdHRkMTRtQ1BkOFZzQVdN?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13769dd1-0272-4cc8-0b20-08dbd7329441
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 21:20:44.0493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 103HGRIKXBZmERgTMN+ICzDg3owjOb9lcYI9jVtgTntUlw0T7sskfGTPcgb/GhRnQJX+znhgaiRs+dttjf+wxwIdZ944p2L8rY491bLcL8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5025
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/2023 10:57 AM, James Morse wrote:
> On 03/10/2023 22:22, Reinette Chatre wrote:

...

> 
>> arch/x86/kernel/cpu/resctrl/monitor.c:824: info: Scanning doc for function cqm_setup_limbo_handler
>> arch/x86/kernel/cpu/resctrl/monitor.c:832: warning: Function parameter or member 'dom' not described in 'cqm_setup_limbo_handler'
> 
> What tool outputs this? I've run 'make ARCH=x86 htmldocs', which outputs a tonne of stuff,
> but I've never found lines about resctrl in there:
> | morse@eglon:~/kernel/mpam/build_x86_64$ make ARCH=x86 htmldocs &> tee  output.log
> | morse@eglon:~/kernel/mpam/build_x86_64$ cat output.log | grep resctrl
> | morse@eglon:~/kernel/mpam/build_x86_64$
> 

(copied from Documentation/doc-guide/kernel-doc.rst:)
	scripts/kernel-doc -v -none drivers/foo/bar.c

Reinette
