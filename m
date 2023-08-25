Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D759788DFE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 19:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbjHYRsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 13:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237732AbjHYRri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:47:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6022128
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 10:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692985656; x=1724521656;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fUkUBcRoWOkf+UOm7+UFi8bNy/e/uqm+oVE4jRfbujs=;
  b=bB94gLiqCWR0021UMQMm0pf0d7W/+/XiuoaGwTscMao1XhF1syAst12C
   +v4iqWyr1chA+v3kHvmA9/b29HIZVPZ2c6xh5eT1Gotf2D2n/61ZLkc/0
   OHnp4r+aoEddvgm+FbvYxYWF1PGNo39v3pu5ESfmBRsGrZ9puZaAJ20Ur
   AukDqMYJ0w5jfyEVy0NDPUcdpqxC3oyDmqgQiH7MB50W0fWwEMciFOgW+
   Uw2QJ9x9LwGxOYAPmyBANlrT2MwVnFgBf+/i3DxQmFx2bKTcsE91w9QNt
   qZ1JLVN1DX01VZ9Ij8Gis+kaCrVTnQ7GPlakTlsxjsK98If6a31VSmYLP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="355097249"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="355097249"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 10:47:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="687399925"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="687399925"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 25 Aug 2023 10:47:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 10:47:18 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 10:47:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 10:47:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 10:47:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YihFrnB3VV3nAx27g9NTNaLSMC3Cw2aPSycdLjDAFEF0CzyQvkHqeXDuxjtIhbdF/VMJHGPCRRCUHTmQ/rS0jfdT8bJfCrrIfwKB4H/NjdW6fFnvQ4yPQfWQEpOSKBpWTgO5I+pWzA7HbfooUbtDV29EIZizgbOBOQzwao2+7Pz3HFI8mAbk7YQmoMjmkNfTkDIr4tSXxDEKQbEMjV+8H1l050bJgcaSohOpd7kad2ty9ErazLXgzkNDHOj/zdh/pJQAfjDKZRnaYmt76/q6LXSfO6h4q7q7MY/fmpT6l66Owa27ykSdY3j/poXgY/1onOk88a+7Fqm3/uTZz2/k3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZnzSzmRFgM1XRBhctc2MpsCNSpSZN6qRs8nFqkaHpM=;
 b=fn1hA+o0HdfyFVMyTQCMi6u10npOFENx+UDLMBy1ckM7eICNiy2LSUbhvnPIjRsa3YxAKtrfreEcFC2AuEVu41Pl6JkXzWiCY5go3GimVm+T9EzXPVc8d6KpTeGWCzZJQJJqO88Rk66XeSZS+hl17txY2W429K/9ZwLNfJ+Tm9/LvlQoyfkwxugvWYDSjZ5g3p8fPxoJMDtl9SQUfARSiFvRWfO6jtVfAGypsFtvOjov7zpq26bkGCqqphaMZFbJGhZ7Q1g/W0l+jg2kzQOX4Dz2aZXT4zSEM00oa0USTkvdra4sI0P2N/AT0M1vStLa2DwmV5BzK2YLbaJcOor6dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM3PR11MB8683.namprd11.prod.outlook.com (2603:10b6:8:1ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30; Fri, 25 Aug
 2023 17:47:15 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 17:47:15 +0000
Message-ID: <35f05064-a412-ad29-5352-277fb147bbc4@intel.com>
Date:   Fri, 25 Aug 2023 10:47:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: resctrl2 - status
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        Amit Singh Tomar <amitsinght@marvell.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        George Cherian <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "peternewman@google.com" <peternewman@google.com>,
        Drew Fustini <dfustini@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <DS7PR11MB6077FE180B11A9138D8E7ED7FC1DA@DS7PR11MB6077.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <DS7PR11MB6077FE180B11A9138D8E7ED7FC1DA@DS7PR11MB6077.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0360.namprd04.prod.outlook.com
 (2603:10b6:303:8a::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM3PR11MB8683:EE_
X-MS-Office365-Filtering-Correlation-Id: 15654548-0326-4f41-7b51-08dba59351df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MTce3k+rt7zxAtRKFaWptLAFU2kGuBxOY8HUI6GC46ThGNQ7TIgd9MB+XYNkGrzf/gKUmLMvJq0HDm2VjENytV4Q9/bCbEaBLgQI4n+R9os7l8lYoCN+IyRm+ixSNTiDidTmuK8L4SzRbuTun4oZ2q9wsCocmm11PQKWY/FPzTBC6Fm4o2RNJZ4WBMkfvcCGtO+5WZH2Y3yi4zgRBkKVhKKxOhA11UrGc0BdEllpswLwfw16ktcI0gLa6umZtWJKPXi3fYe6MZ6kRu7h6iKk/6egYf7qXVRtyqY9NouiOPuifpmfm+z3qCiG22ILFsM9pLczktBtqVJSTLAQmLMu61JQPf4bvTcr1ZYfqvD6rH/herzuSI4asFTxE3R2TI1T8n7SdcmzRCLcNkbJ0NgISlplV8wqiM7jGEDJiZFp2YM3IfhDbbB0xlvGD4iof8jLQ8QvAdELFbdFOf8Je1mBSLtKF7H8gW+TAsEW+JNz19lAifncfvZ8WPNDGbTtRzVm6WxOh7VdBsKnSiFabOwiJa5MhbY4nQChZXeJXvqg6dCgrfRiYhPhSCOI3bE+OU9ABxlLC+FXt/3lGcHAcEgEpakOPQLQ1imnsERfcDOMbxEvCK1mDm8lnV3W9l9MLtSriJ293+OOBAk2zJKkDcWSfIzlL+eR8XK6SaH4EmmHxLg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(366004)(346002)(1800799009)(451199024)(186009)(5660300002)(8676002)(31686004)(8936002)(4326008)(2616005)(26005)(316002)(66476007)(41300700001)(2906002)(66946007)(54906003)(110136005)(66556008)(44832011)(478600001)(66899024)(6666004)(6486002)(6506007)(53546011)(6512007)(36756003)(83380400001)(921005)(82960400001)(38100700002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG9ocGxRQzBQdSszU1N5RTlSUzZNL1RacHQ2cUc1SmdHMEkrVkF6SlQvb2VP?=
 =?utf-8?B?MkFEaklPc29HSWg1THBOMTd3MlZaRDdPT1VTZzc0MlZlQ3ZiVkIzUVJnVnQ1?=
 =?utf-8?B?ektBL0hxVHJjaUNtNVc5SzN5VFRiUm5nMEVRYUVrMlFVbk9xQlBvVHAzc3Zl?=
 =?utf-8?B?ZE4rL1BKeUpncERCbzRLQlhkWFpHNDRJa0dIZmkzYXBGa2NZY2VMRWo3R01T?=
 =?utf-8?B?TFhzRnhnckV2Umt5TGxIdWpieHBhR2JZVFR6M0ZmTDNDOTQycitpTHk4eXk5?=
 =?utf-8?B?djBpcFlUWGdRNkRhL2VLSlI2WE11VzdUQWZCcUEzK0diZGxrWGp2THcwaXJW?=
 =?utf-8?B?RHl2QkIrS2FmbXBsbGE4TkY0T05yNzIwdDJXQW9FTzNuaERjZ3EvbitHWHM2?=
 =?utf-8?B?S1ROU3ZMdWFHMkpEcWM3MFBtbHZTVlZpYjRBSUJEUHA0YnhDNjNkTkFsOXE3?=
 =?utf-8?B?dDBDSlg2NG5nMUtydzhYbFdGUitOYXNyVGt5ZWhablo1aU5yaTE5VldGcDRu?=
 =?utf-8?B?VHh2WTlYVkdxbldoU0NhbUZqeXlHdHY5UE1RdmlOODNIVndJUHhES29tZ09D?=
 =?utf-8?B?cXFBSzR2NS91WFBzWXpuYVFzZjVtb0pWbXkyNmRyYXpmMGQxcHorcFVkRFlS?=
 =?utf-8?B?dVJaQS9OMGQwMklXN1h0OXZLSlNXU2l3QjBIbnhwSzEyK25McEF5TlpWdWpt?=
 =?utf-8?B?Z09yK3VlbEVVQjJlRkdncGJiSmpXL2srV281U0N1RHJjOUhpaFpHcitMTlJi?=
 =?utf-8?B?amhScWd0WWVVZGE3NkZWejlJTUY3WjNMYTR2UDBvZ3Fwekt0RkFvbzR2YXI1?=
 =?utf-8?B?TkNjaEVOTy9DRm9GUkIveUxHYXZFWHdDVHJ5aUV0SGQvbmNVbDIzVXBRTGtK?=
 =?utf-8?B?U04wZEdtdTJ0QzdCaWx4NDJ5ZFNXVXRLKzIzYi84NHRpc3VOelhRZmduNVE1?=
 =?utf-8?B?bmVOVUNMZS9BRDRqdmh3dE9TWmhYeUY5Ykw3blZYS3RpQlFlUXM1OCtYTENU?=
 =?utf-8?B?MUhHNmNRUnJWS0JVSzZNZDlDTW5UNWFWUXNGOWUzQnVyemd1YS9vcTdoQzJF?=
 =?utf-8?B?VWhUa1FJOXJsdzhkMU1wWTQ2SWwyL25pOTNhdHBRNnRMZzJTckdqMTdGY01q?=
 =?utf-8?B?eHI3R3c3bm02WllDWE4zS09sTUw4UVdzTHRKdmN0WU0rTFRwNTFucVFEVnZZ?=
 =?utf-8?B?RzZhWXNBanVLNHRLcFNrL0dNSmdWMzJVejhoVWJ5MWVjZVM4RFM0SE9CVHgw?=
 =?utf-8?B?KzRDTTV3anlvVzhaMjZvYkhLZVlNaW5sRDRGS3JsNS9Va1lZaDViTHdlT3Va?=
 =?utf-8?B?VHJHRTM2d0ZyTVM4TWJGS3k5RFF5OVJXdkN0dUZvYnduamY0bHlBbTBGVmZ1?=
 =?utf-8?B?aVB4L1BrUi91TGpTSHBJQkN6M3U4dzR0b2wzWUt0bjBCakVRWWVHckFvRzAz?=
 =?utf-8?B?dWpVUHA1UzNDeVlPWWl2VThGR1FFU2FsYW9lZGVrQ1dUV0l4TkJwTEdtci9S?=
 =?utf-8?B?RWdtcTdFMkswUjRSdjBlZUtxU3pxaE1YQmYxTUhBeUh0cUlDOGo3NlFEMFE1?=
 =?utf-8?B?a1JBcmVCY09JdWxvaStVUzNKdWs5cWxLdW1iL0M2amJDY3FLK0UxT0FLU1BS?=
 =?utf-8?B?K0ltckhWNHBaczRoVXc4TDJobmgxM2NEV2pnYXExNmlkM0RsQmNBU3F0SnZX?=
 =?utf-8?B?V3FlN3UyQUJ2OEp5WVExTzFPc2FRWFo2U0l3NWZuSGhzbC9nSHhyQlpCc2lD?=
 =?utf-8?B?enY2TncwY3ZNM0xFandYQVRldTV4cEFDTVJ2WXl0eHZoOVduWFczNG45Qjk2?=
 =?utf-8?B?dU9XTVVBcEpEUnZWTHZTZVRWQmlkS0tXWC9wWUczdTU4UFIrOWExMUpHTjl0?=
 =?utf-8?B?Z1h5SWU0dFpNRXMydDgxMEdnV2JyMDNyMjRtZTVhY3lEUG42N0podGM3WStW?=
 =?utf-8?B?QTdpczkwL0xIZHFLNHc4L2dWU0g4WDI3VjB2VVRYSTYvbzdlN09QaVBldjl3?=
 =?utf-8?B?aTJIUU0zRGsxREZJZ3J3VldOcWlXVDk5SnRBaHI4MjZMdklud0M0LzZscmJz?=
 =?utf-8?B?WmN6M2RpYmNOdDNvc3hIRHlMdU5XeHZWUDFBNDhTSDJnMHkya1JlN3dQUFpO?=
 =?utf-8?B?cERDSDJsc1pSQzNSTGtod29aWnZST3FUaHF3UFRrQVd1bGl2MTNkVU5tTDl5?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15654548-0326-4f41-7b51-08dba59351df
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 17:47:15.7172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Try8R9JKdFsY6/PTcRRw6vD2W2upZlGeR4JJxVDZxLdywIQsIEifvC/FA5cZJWZdEiKw5hcjX3E0yxocJmREXUIvsQxx5VF/dow5yYhEF5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8683
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 8/24/2023 11:10 AM, Luck, Tony wrote:

..

> After booting load the modules you want for the features you want
> before (or after) mounting /sys/fs/resctrl.

Could you please elaborate how user space is expected to
operate? For example, focusing on "load the modules you want",
sounds like user space is required to know what feature is supported
by the underlying hardware and load appropriate module in response.

In current resctrl the agreement is that the features are no longer
visible in /proc/cpuinfo if their support can be discovered via resctrl.
See, for example, how SMBA and BMEC does not appear in /proc/cpuinfo
because user space can learn about them via content in
/sys/fs/resctrl/info.
User space thus cannot rely on parsing /proc/cpuinfo to know which
modules to load. resctrl also supports module specific features,
like pseudo-locking making feature detection more complicated.
I'd expect that in the near future there will be a variety of ways
(beyond just running CPUID) in which features should be enumerated.
Is the expectation that user space needs to know how to enumerate
all the various features to know which modules can/should be loaded?

Alternatively, can user space just take a "load all resctrl modules
and see what sticks" (even modules of different architectures since
a user space may want to be generic) approach? 

This work is stated to "make it easier for CPU architectures
with different underlying resource control and monitoring capabilities to
implement those features without being unduly constrained by the quirks
of other architectural designs". It is not clear to me why making
the code modular requires everything to be modules. 

Finally, what is the plan to deal with current users that just mount
resctrl and expect to learn from it what features are supported?

> 
> There are no mount options. Just pick the right modules. E.g.
> 
> # modprobe rdt_l3_cat
> 
> for basic L3 cache control
> 
> # modprobe rdt_l3_cdp
> 
> for L3 cache control with code/data prioritization
> 
> # modprobe rdt_l3_pseudolock
> 
> for L3 cache control with pseudo cache locking support

Reinette
