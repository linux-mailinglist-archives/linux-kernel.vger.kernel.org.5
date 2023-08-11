Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46644779795
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 21:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbjHKTNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 15:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjHKTNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:13:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BECE30CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 12:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691781217; x=1723317217;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qm9dwa3MTnOQeECF0VUR4WO/gTCQwY9Kl2amPd29mAQ=;
  b=Sgc0w+wVz2T6dtHCfoKHH1L6u54zHBBRM4kNQkItM+0Jjrz+53rbUBfj
   K78mcwQilSUVTSIAeNiQlqtOcTHsbmc3SvAQsbUy2mh1N/85WYpp5P5Xj
   MTc6FFO+n8InNQ0UnCpMcPrcUZLqiW2JpvJwzHxAHGJf0NSfuwaZelToj
   XhtTtDBErRruTqjOnOwSJSB7RPzcCbAwxYpf69WNANVH/EGIZOloK7LaZ
   RRbaPR9mRiGj+UJu3pOODlPg4pgPESUfFMp8IsdF4H7zBkRCY1DQ/VtMK
   oplpfhgdDXauqTSyCV7D33O01EfA0sgG85I+h5YWCpuRL6AtTJK6qNGZ1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="371753571"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="371753571"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 12:13:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="735874234"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="735874234"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 11 Aug 2023 12:13:36 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 12:13:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 12:13:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 11 Aug 2023 12:13:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 11 Aug 2023 12:13:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bc5TNVZzxcu+xHUVSsmQNqg7Ope8cw0dhKPZpCvdYnHPfaK+i4kNMSmh9ECGCyJ0Z/1rb0fZLTvSepieoCLQgDPhOKh50yTMXZQbvqaQYYs3te37yHO92Xvh6NPuqxQic23EfAe2AzYZczRcPQggSYGtLe8sEDaZTN4TijKLh8dnTx8ZoI2DqTdNrca/UPAoW7d8DY9uvpw4RElRQXK5T6YtpeQicL21dy/sJJdL8znelHb2KSrdpaITlsT30LOw1z2ypz7h6g53Qan5AVVj1IXMYCvGsDipTq3A6XZdaF8oNpbBsS4GTycQryPTT448LNFq3gHtt4QECtUOYODLnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYR5gLbxA+KnP7WOIkY5bgxSODiMjOjEL9uZY6dbDKs=;
 b=CxhI0EHFDwtGusk1eE9dtXu1wl+lZGKMrF9HLpQcjyARlmoGrdLKceXK76bttKiBas0sSA7hjuHGolzkcq40enS8vjGiVSQK4NhNzhgAcTGN3vaU56R+Fmz70WgGU9hhmgZDd9fLGx4mBx0xyL0w3Ofcp9wykk+mhFnmzfEVvOdYai1JBkP16V/nWDSiQJzz0v1adY2PqagmVOqM+ZM+bUqtYdo6CWlXwiHVhVVetXGp15I5ctrQNodt47J8l1kDizMR2M5NyE6EEo/mVgh4gIhfLSVFlnBn8U8NdBxDncE9KLBbbsfV0VS3mNE4Ei99kMd2sALynnHJ9dBWd9h9kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH0PR11MB7634.namprd11.prod.outlook.com (2603:10b6:510:28d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 19:13:32 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::ad4c:86ce:d99e:9740]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::ad4c:86ce:d99e:9740%3]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 19:13:32 +0000
Message-ID: <c22d7613-fb2e-11ec-9544-a39ffc7fd955@intel.com>
Date:   Fri, 11 Aug 2023 12:13:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RESEND] x86/pti: Fix kernel warnings for pti= and nopti
 cmdline options.
To:     Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
        <linux-kernel@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <luto@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>
CC:     <x86@kernel.org>, <bp@alien8.de>, <tglx@linutronix.de>,
        <hpa@zytor.com>
References: <20230808195615.9795-1-jo.vanbulck@cs.kuleuven.be>
 <c0aed6a4-23e0-d947-5c17-26e580d5c40a@intel.com>
 <405927c5-91bf-144d-a3d7-b82f5527f3c9@cs.kuleuven.be>
Content-Language: en-US
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <405927c5-91bf-144d-a3d7-b82f5527f3c9@cs.kuleuven.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:217::23) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH0PR11MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f4152f-a49a-4b69-4013-08db9a9f0dd5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yShvGuO5+n1IMl7zRyk92kptLorh4X2p/wZeIgSUkToDZsII3mUlhu1NXGLXGLrP8+zEqCBSeRdEsCtZbpvSkXj4K1gM8u7UadHh+Mkiuv4yjcjzBP1Y6qND4Cei59LGZs2wglSCmjRYFKjuJsApJvcRQEjh/akLjpuEYyskybF4lpRGdi1XceCNBMyl7PkjFgvXFFWhjShjChv7AUdrgy4FZDxODab30iJXz4IJpTyAHvYLaxMzreA8gNmy9rF84j4QjZCh34otm7mgXeVYdG5YkuWmRFz1pH5rQooaC/6ITkKFHHQpX4JAYxQaMZXIDr2Y/3QoZBUy5GpSSNNRwN2Mi8/hcYm8n8ZJFOcld04pGZzqQW3WWy9RZjrxGLlAenjlJoSm0g6NSlf8sW+Nw/vB2tvnQRoJ9+8wWoSY1VyA9Y9Ve0uRBP2mmb4ymNnLg3kUzG/PMpUeo4t49FiuaFkJ0H/LOnPSEuj1WKLigWUz2XGhP9oZvrJxbqO7TSkkDv+GFd8XNLKhIkadEv9+HLotZ89MxDVYSFdrvmZIdxEvNaL0gj8Jp1HR1drBUHbleqGhDJpCs3OS6GU/ih1l+R2J/JnetlSenpVmG1tCScjNZTPca8vd+MJODnNComL2zBQ6wKJtZQTnqAENAHvN/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(346002)(366004)(136003)(1800799006)(186006)(451199021)(31686004)(7416002)(4326008)(478600001)(44832011)(5660300002)(6512007)(86362001)(6486002)(38100700002)(8936002)(66946007)(8676002)(53546011)(6506007)(26005)(66476007)(31696002)(66556008)(41300700001)(2906002)(83380400001)(82960400001)(2616005)(316002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1pvSlVzMmtQZENpdkpRZ2wybnFMT2pqQ29WNmlEU3VraTkzald1Y3dINkgr?=
 =?utf-8?B?bnRlK2x1Q0pVNTNKdXhzUkRyN0FXd2w4bTFyNnAySzFlVm5IakFCZG9DNkJw?=
 =?utf-8?B?VktKS2NDU3lSU1dlQWlrMkNXRms4QXhiQkljRkhPZzhCdFRXWEpRbXo4am10?=
 =?utf-8?B?dXdwcVJ6OXhOdktCQTdHcGx6SEMvaDRCOGgwTHVFR3RaQlFHak5SbW5NV2FK?=
 =?utf-8?B?QyttOEJ0enZ2cHc0SlhpTXc5TURvVHJPaEFXZ3h1OTNGT2RJYXdSRVZvc2hN?=
 =?utf-8?B?SDRIblUxazZFZmRlT1paalpIRm40WU1ZVk9Pd3lKeFBCU3BzZ2JUNUdpYXBw?=
 =?utf-8?B?NkdHSHB0MERNS0VnTnVWRk9KeDloM3JQU0tUWTdRWW85NHFBMXpWbktScitl?=
 =?utf-8?B?NGZ5NmdHMDAvRG1leU1KbGY1SmZTQUIvb2FnMGJlTy9OTXJoWVBHbVhHNGUx?=
 =?utf-8?B?aVR2QXVOdk80ZzRYMGxMQ1RxZGtjRXNveExhOFNSRkJMMmxtckd4MFh1TlZi?=
 =?utf-8?B?VGZOSDJiZUFZWDZKQm9CL3VTWWZIWmNDaHpvVWRZUERpakVKY24yN1cvN05V?=
 =?utf-8?B?ZXZNakNUQzAzU3R0aklTWG1xME15LzBQKzdRLzlRZ1hVKzJleklDaERBb3R4?=
 =?utf-8?B?ZmFvQTV1WS9MdEprbjZ4ZGtGWElmRUpxQU5pUHhvVG81alpBZ3V2YWpQd01L?=
 =?utf-8?B?TFd5WTEyeVJNR0RvNUdtQ2ZnVkFXbVM3MHlWcWtxWWlqOUpqTzhrcHh1bS8y?=
 =?utf-8?B?dElhTFoyUFN5SmsvRTBPNjJJbndDZnVYNkZRR3hEZjZnaEMzaW9oS20zUytO?=
 =?utf-8?B?d1ZhdXE0bjU1RkJUbVZVM3NzOHBXT3l2ajZwSTZCSTAzcDlBMitTM0owYzdB?=
 =?utf-8?B?cHJMUW8xbmZOMFVoYVZCc2dIOUtBUEVFQkFMRWVMSWFwN0JVT3o5TWQ4TWlZ?=
 =?utf-8?B?UlM4ZFdZSWhGQnVCS2ZvMWVMWi81RVdFeUFEbUEzS3BVRlZBSDlTVGROUFdV?=
 =?utf-8?B?TzJUT1RQa1hoNlplWG1aTkFVbjhDQ2hmQ2RYLzRHWHpVbHhUblNZQlJ5Ulpn?=
 =?utf-8?B?QS9hN3FuZFNMUlc2blEzNk5KSVZ6aStMZzQ4WFF1QjJiMGVpVHl2YnAvUTF2?=
 =?utf-8?B?bzliN2RMTVVWTmhhaGtMUGMyQlBWWVVEZXJhcmVpV2hzdlJHQjBobUMxdUIz?=
 =?utf-8?B?R1pwUCsxb0hYU0c0VUUxQXBvNVZIdXg5VXphazBkMFR1YzljLzlDZ1RiVDZC?=
 =?utf-8?B?QzRnSkxiL2pBU2krNXk4UkhIbVpHcWwzazBlOWRUTHhyQXpibCtsOWliTnRa?=
 =?utf-8?B?NXdRY3VOa0R6cHN6RVMyeWJUTUZQV1FVZ2N5QVVDOTkzSyt2Tm5vdlY3RFIr?=
 =?utf-8?B?aDFMM0RIVlJjcW5Qazh4SlplaUxkMS9ucEsvTFdvd1BhU0xLZjkxMm1CU3hX?=
 =?utf-8?B?eStuQnJpQUp2ZEQzTWhvWFNRQko0RUpWRjlYelFBcXB3OTlhM1UycjR4U285?=
 =?utf-8?B?Skd5aWlDajJhUVZBdjFTVmorNjVYb1lVdVdpaXNDNzZjQ0VNYS9UeHJUM0Rj?=
 =?utf-8?B?UFhQM3UrSnJDUG1ka09NWXFtNTA0TUxOazgxSytRcVY3SzFka1JQWXIzeldN?=
 =?utf-8?B?U0NHbUhMRStnYU5EMkMxNWsxcmhTdmZnVzZFQkxseGo1SXpiZzdjWDVWelVj?=
 =?utf-8?B?dTdXNHczS0xkZGpwSU1uS3d0Zk1DMWdkdzhCRjBxbHpUVFMxYWw4M0c3QVNF?=
 =?utf-8?B?MmRTU0paSk9jL0NQRHR5ejVmYXNUdC9CUW1abjBQMzBvcE9CTWFMVCs1MXZm?=
 =?utf-8?B?aWdERkg5ak01aTB5L0hScjVRWnBWUU1XdStaZVA0MTZEZFFvTEZKS2ZMMGVr?=
 =?utf-8?B?dnRnVC8ySERHc2c2ZGdaYW9BMTdESm1Pa1dlTzUxOVhMQU4wU09DcGdHOEor?=
 =?utf-8?B?bjVwc0JjK3lXQjhCejlYVHI2T3A0MDZVSjBJN2lqcEJFZndZSndqYnhYbVVD?=
 =?utf-8?B?WlpTb0hWek05amtjV0tGNUl5SG9tWGpQZkdWMEtoY2tXMXR5QmtjYXZWRXJz?=
 =?utf-8?B?U0pkMWJNc2xJYmxzY28vZVFFRU40cnVMUER0bU1YUTNCOGhzZmVnWGZMTTJk?=
 =?utf-8?Q?OHip6BeVsJLxUV1AK3OucBrnZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f4152f-a49a-4b69-4013-08db9a9f0dd5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 19:13:32.6915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/nrrZcCYpdw5uo7CHCmsb4RTT/SopVfTVvmLYWb2rZPLpFkbzaiqSkYFvvOhMJDXeJYXbb56Rp/zqxxvaom9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7634
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/2023 11:23 AM, Jo Van Bulck wrote:

> On 08.08.23 17:13, Sohil Mehta wrote:> Can mitigations be off through 
> some other mechanisms such as kernel config?
> I validated this both with and without the proposed patch.
> 

Great, thanks for checking that. The existing print is accurate then. If
it is printed "disabled on command line.", then PTI has been disabled
due to a command line option.

>> Maybe split the mitigations_off check into a separate if and it's own
>> unique print message?
>> Also, with the separated check you can avoid the unnecessary re-setting
>> of pti_mode when pti_mode == PTI_FORCE_OFF is true.
> 
> Thanks, makes sense. I'll make sure to do this in the next patch revision.
> 

Based on above, even when you split the if check only a single print
would be enough, right?

>> In the rare case that both pti= and nopti is set the existing code seems
>> to ignore the nopti option. Would the new implementation do the same?
> 
> Good point. In my understanding, passing such conflicting options is 
> undefined as per the specification [2] and I'm not sure if backwards 
> compatibility is a requirement?
> 

> That being said, I can see the argument that in this case of 
> security-sensitive functionality, it may be desirable to maintain 
> identical behavior for identical kernel parameter combinations and 
> sequences. 

I don't believe that is a requirement either. Sometimes kernel command
lines can get very long and people make mistakes. I just thought it is
neat that the current code is defaulting that way and we should probably
keep the same behavior since it makes sense.

> 
> --> I can update the patch to ensure backwards-compatible behavior in 
> both cases for the next patch revision.
> 

I agree, in both cases pti= overriding the other option (nopti or
mitigations=off) sounds reasonable to me.

Sohil

