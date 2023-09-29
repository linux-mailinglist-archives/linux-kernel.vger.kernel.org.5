Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB19E7B2A19
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 03:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjI2BI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 21:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjI2BIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 21:08:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96795B4;
        Thu, 28 Sep 2023 18:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695949702; x=1727485702;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ReDqxmJgg9iO083yUY8r+vaVpQYHu9xUNvJXex+UqYg=;
  b=fBxO7Xb4Py/yixRMOCLQEoW5IcyhKbr9Q/RuU8mhh3Roi3hwiwTwc2OP
   XFYoQ4doKvOXGjloD0OggsNlDFvQK7txN40Pl+BneYRnvI7uPiGiCVsR6
   Lb+k1IwwahNKYIFNPHmWqdFsBGFBo0RykdKD97TJb5GebPNUZYLh7Gna2
   EWM8ILHxpBowXN2mAWl9nHsitvc0wFReY4VK+2KnhCJcoIK0+fFKQL/MZ
   bO+ZvlY3bJk5cFyHWQPnz5AUqdHgOBbCOKf0hM5R/FkSkpI6Xo7+TAgEE
   EZVenRgnrw2BkNFlvI3bOh9RWTrax7v8v163Pjnyt5kXowRfhEqzk4JZa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="379483739"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="379483739"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 18:08:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="749808354"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="749808354"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 18:08:21 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 18:08:21 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 18:08:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 18:08:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 18:08:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEabzzS8Ma82HQSH4oqn1p/Vy0ygagAk9A4tAtVF0gZKz6wVptnlzQeSusfSThyhYHn+0WWFyKmH6yCdDsI3ZB0cICU80xtcpvzJoaizmHuJW47KGR5Q9BQHouz6pc6FsFrp1QpBfO7PenCK712NQcGapT3eIwHEYVxhI/5vpRdDp97FTTVJZR4TJTWcbkZ3GEWIPJ3MMBEXYWLKb7ZCnL/ylWfHN3esP7i5Pm2tq9DettHoW4wRNG1Zs6YT0UJksjY1t73k5ndm18biRdvDFIKpBfzJSmuXpA2BTG9Qfc9PIOsWnGlhjLErhAfqvYmZFiypGNa4QXMUMD7FM2csMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqpWehchNym0VB6QNqrx7ReoDzvwRs/WCQdmK71rWYA=;
 b=Fw1MN5LorUXZvDwc/RY6qiklL6Akpyp0etDu9U3PyV820vNGonHrJ9le0O+Gz0r/6gHgzoqtHR4GqYaeZs4PeFuJyDXUgDtDOrDmMdgLEVsAaemRsCRZz1S+RleJQkyJ68LgarTq0E0PsYqOvUNz77CDNlk9JJYmA+XraOeIGAr/VsfezS9IXuZ/00NlrjF/DfgWn7/urQnxU3AMlbo56wb4izKvkHfkfzFKyJ+4YL0c9VZTvSCApEIgEceAOxwqDJXQTZ1ZTZA5wenJc2zzuYEgS7hwiaoUfNA70+BnYtfJMo8+Zpc2kOnw+VrSFiHt7db61t4XlqbmuFoUkuveGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6676.namprd11.prod.outlook.com (2603:10b6:510:1ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 29 Sep
 2023 01:08:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 01:08:11 +0000
Message-ID: <4cfe090b-cd59-1901-9e8e-3da7e85ba5a2@intel.com>
Date:   Thu, 28 Sep 2023 18:08:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6] x86/sgx: Resolves SECS reclaim vs. page fault for EAUG
 race
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <kai.huang@intel.com>,
        <jarkko@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-sgx@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
CC:     <kristen@linux.intel.com>, <seanjc@google.com>,
        <stable@vger.kernel.org>, <sohil.mehta@intel.com>
References: <20230728051024.33063-1-haitao.huang@linux.intel.com>
 <f2b00069-e837-ff1e-2d03-b446df49bff0@intel.com>
 <e24da7cd-fcfd-e4d3-16dd-9bb102adcab4@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <e24da7cd-fcfd-e4d3-16dd-9bb102adcab4@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0003.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 627994a6-7f1f-4ac2-50d1-08dbc0888c2d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8LbenDi2EOWEbR0Hbwumnv8SBqARTvzW0NMxz1Y2vWfR5Vzc3b5LaEA/ZV2h5xmm7QoLTLrlUW/agPSUsaZlAH9T3EeH8CRD2NICNYCnimsPyXCu7M7MSy+DuQDk3J1+l2FTCVV0IQ9CUzG4gyEJt4bsnBmc82TlTedC53vguolseg+FZZPS/QaVati6ihPD1zBdhiuOzgTI0/ydSDBj9/Usq4G7NhkYK/vW4c9ws6EsFZEWpLpw7lQkzYn+/yPURo62BJlTHLJJhEFKHx+FD9XAajmSjjn3iEx+n6mtVuDevpgf5SHveS2TSt4UW573oHfteWzgh9+FtV6LDlOrl+XtkTo5Q17dGaaYwYtYtNS8iyga7Ock8Z6FqnoVO2VwY3wTTDeeV8fufpzuT4u+Ilnk3vm5oyusYJ7pl5mI2pe6aIc2mET8aLC88dT/4SKTzeMHdubNlBYOOedaTknWB6O6nFwBFm3WAbjVFYVwWHu+gW2OgDfRQjXcvBzSuGFCpCfmnqBfaDJzUfndQ5W8tmdfDHu1+fqMh8NusfdY0JmrkysnJPvwJ8s5inknifM/P4E2/i0s59/z/g2ieHBpV/2M9MieXwYEqLPDsmRtH1qRpOx9s0fsK90ckoGFnw7VcGkdXvcVK4dUo3TkwkMckGNDUUxM+1LHA2LvZzt72uw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(31686004)(31696002)(38100700002)(8676002)(86362001)(8936002)(44832011)(5660300002)(4326008)(66476007)(66556008)(41300700001)(316002)(110136005)(7416002)(4744005)(2906002)(66946007)(36756003)(478600001)(83380400001)(6512007)(82960400001)(26005)(921005)(2616005)(53546011)(6506007)(6486002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFBsdjVmOTdPVlVHSU1iTGt6bnYyZkxKcWxnV3dndS9UL3RsU3M5eXZSTDVB?=
 =?utf-8?B?OFJhMnhPVnhMbDJNbzduS2FtZm9GNGlyYWw3OW5ZWTRqLzkrOVFZZEVyOHBY?=
 =?utf-8?B?c0E4RUhMUmJ5R0VXOUtPSFBKcUE3dW0wQ0JVZmZOUldaMVdHV2F5M3dmQWlv?=
 =?utf-8?B?Q0Z0VnM3QXZlYnN2WUozR1Vjb0FyMkE3amg4ZGE3YlBwZHRqZkNibm1ONDNr?=
 =?utf-8?B?SzNsZ3krUHYrSDVjeXNFNkRTMDU5ZmNUckNMc2pDOUNZVVBVdmNITzRPMmJQ?=
 =?utf-8?B?aitURFpwc2FKVkExZnhwY3BScjhkRXRrVHJVc3pxVG9jTGxZV1VKZXN0N3pU?=
 =?utf-8?B?NGlTWUoxcGxMUUdnZm1ydjRRUkdIdThNVGYwckROdERLKy9kbnRIL2g4WjVB?=
 =?utf-8?B?YmFrY0ZlRTcvcXN1UEVoTWd3Q2NDSjA5MmtydS9McHYyVGljR244ZnVTY0V0?=
 =?utf-8?B?ZEFYYkN4cDdRTWJsVzZmZm02T1pmZVpwa3hpaU9WcWVveEdRbjh3MEZDa0FN?=
 =?utf-8?B?dWV5SDZQRW0zZU5pNjF2RUFoekpPSUlWRS9kcm9tWnpTcHVheFh6R2Rab1FN?=
 =?utf-8?B?UXdqWGNTZTVVbjc1R01TSkp0V240czFmTW1UK0FOQnFxSHR0NndhWlVtcWtF?=
 =?utf-8?B?UXVqWG1CM3VSMzA3VzE1MGFwL3NHMS93SWRoU0tNS1cvdTJQeFN4N0hKRGRV?=
 =?utf-8?B?NmFLTGlOdVN2eHdxbFdzdi96U0pwRllJdjI4WnZTdFRQUVIvU0ZPK25TaUdi?=
 =?utf-8?B?bnNpTEptNnJlZHIyUXZ6NlBUMVl6bmliTlJYeVhQd1BXOXdjSnY4VUYvQXB2?=
 =?utf-8?B?WUpwOTE5Y0hDTnkzeGtKSDRra1hlU0hJMVVoNDhZSk10QklLUWZlSVZDbDU2?=
 =?utf-8?B?dHNDWXlGaHp6VFVuR3RYNEx6ajA1azJIeXIycE5XMU9Nd00yRTBrU0krSDVS?=
 =?utf-8?B?WmFyejZaUFNKZFpSeXQ2V21ucjliMGlQM3lJbmVnSXVXSUdwdWprR3JoTTlj?=
 =?utf-8?B?S0RSazlxZm9SYlVCTnQ0N0laeE5RNDlDWjd5TDJLdCs1WGpGVElOZ1N0WnFr?=
 =?utf-8?B?TllqWUE0QVd1WkdMaFZ2ZElURnpuMC9XM0JSRURmTmNRU2NpNlNXWDljaEsx?=
 =?utf-8?B?c2JNWGFDTTZRYVlOMjJvL25aQXBhUUxCbnhDV0c2K2JZR2JJVi83eHF5YTdl?=
 =?utf-8?B?dGRxV1RDblRVcGVsM21jN1JKMElQS0dLZVdlSXhYQWF3U0FYaFl6ODhTRXhN?=
 =?utf-8?B?OWtHWG9xMXBUNEFHUHA2SzF3ZWs5VFJLWnRkdFMvQ01SSmZLOEgxdlB5WmNK?=
 =?utf-8?B?UUJlMGVxUUU4Z254RGhuWHFjZlYvWWs5MmtZTXJzY1A4N3ZYSy94eEJHaUpl?=
 =?utf-8?B?Vmppd1NzWGZiZ3l1ckhmV3VIL3EvcG9SOEthZlRRNElBMkhXc0FPNlUzTW1q?=
 =?utf-8?B?VDlEQmF3eElYWVovYmYwcUZVd0RJbGlaNEJJNEJVa1NYRHJNWWJ4Y2hMaERU?=
 =?utf-8?B?ZVh6SzB6eG54NkEwWCtjRFgrczNVSytUMks4R1NYUGdUa0hRV1Nac3RLc2Nt?=
 =?utf-8?B?cjRmZWM1bll4YzlXY21DanF5cHBTQWdyYWhWL2RpanphRjV5cWlETGk4dUZG?=
 =?utf-8?B?bngveWgxR3FjTHRaNVhGdGJmYjVuVS82WnZZMXBDbHFjNVZ5SjFxRnUxNnlR?=
 =?utf-8?B?cjJpd1diQTJQcmVIVVJmNUYxS2huUWlOeFN1TENQdEZMcElsajExRjVhWDZO?=
 =?utf-8?B?QlZoTWRZS3V0VFlReFFpQVhZUlQ4aHZxOGVvVVR5RzBVem9jNWZ1Y3Q5NnJV?=
 =?utf-8?B?QUl4clpqZGYxRlQ5VURoNWhKYTgyZVpWNFpVLzh3cmE5TmJRT25Ma3A0UDNw?=
 =?utf-8?B?bXkwMGN3V0lwUkxTN2RKV1M2NWlTQ0IyNmlDVi9XdlVTK3N4UFM0aUdOWUZn?=
 =?utf-8?B?OHZweXZSN0JUZE1hcHQ4WkFHemk4T2R5V2ZqczFpTFZxQXlFbXVON3E1dUt1?=
 =?utf-8?B?QVJkRFc3KytmK3VYeE1QZjAvWW53SUIyNVAvUFhYak8yd2RwOWxHbjd2dHBQ?=
 =?utf-8?B?MGx5WjhPeTZra0dES0JXT09LM0xpYVUrdUlZNGswM3o0SGhzL1NvVnoxMFN3?=
 =?utf-8?B?Sm5OZjltRjR1ZUZRTzhWRFpJOVU1MXkvT2hJK0VOMUlDV0trMmo0WlhGVEZP?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 627994a6-7f1f-4ac2-50d1-08dbc0888c2d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 01:08:11.6238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yChkUm33YuhTe4eSJSX2pwJs9ytAspx6uYCKJH5mwFgT2MIGqL5HcOQyJJ7rkeD33XDSs7KTmenYLGllg3bteoXTGcEAbYRLU6IM3ZTtFcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6676
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 9/28/2023 5:11 PM, Dave Hansen wrote:
> On 9/28/23 16:08, Reinette Chatre wrote:
>> I'd like to check in on the status of this patch. This two month old
>> patch looks to be a needed fix and has Jarkko and Kai's review tags,
>> but I am not able to find it queued or merged in tip or upstream.
>> Apologies if I did not look in the right spot, I just want to make
>> sure it did not fall through the cracks if deemed needed.
> 
> It fell through the cracks.  Sorry about that.  It's in x86/urgent now.

No problem. Thank you very much for including it.

Reinette
