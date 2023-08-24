Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F25787BC4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 01:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243983AbjHXXCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 19:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243956AbjHXXB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 19:01:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9189F1BD8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 16:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692918116; x=1724454116;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rY/YDE/lVAr9PABPHfHlHIvMFU4XWT2jDGEj53zieSU=;
  b=jD17Yj9sdiEqOVvz4zazVz5GdRr3Gyfkn0dT1tdwrfsHfXki4LCf2wAl
   LI+so/yO/GEREC7ElCNLbqaHWs0Papyw2VZdV5jfQ+gKIRMY4a8vB00/Q
   TBQWlC82BWpmSjo7eaiEWh87UzyPDLVqIA6PfwbPWpk+JSAQj6aKqogfw
   Ox6K1gw73v6zX038bAKsSYVLaRBUonDtFXr7de6lvcEqPfuXDirGk/sMo
   ca0pDvXqIyou8i1RylpcoEYZYKJeivtv+R8LV1duQc7GCWFZ7hmU1nHcR
   TivBkdUTOSq2jVrmTNQTTkFknMI6Rm8PUbRxKlilt3HdnI+5HSYg/5Djy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="364770507"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="364770507"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 16:01:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="983881438"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="983881438"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 24 Aug 2023 16:01:54 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 16:01:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 16:01:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 16:01:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1juP/WxvhPnY9Y8Ovp85LtpYF2mX3AbM58HWjWFWe+uQpq9eEL/M1sIqOA3Swhx4ukRdr5+CXQD4pegTJSk5eOnrf8mNP4TrKY5cQHoikaTlZKBQMPw2FxhoIV5rKgRLhyiyyESa5JKnJO5sO+SFzbpOyZiCbnczpVH/r7axekNA629Sb8AU2pgjdOP8ZGEskMSnp676Za1ffI+Ke6+yUGOu2ZTecierQMomCZ6n0Z9U81uDMHAx1czos/qd8r5px4A2z0g+DpBmaodMpW1eP//swl7bctV4z+yFQYtJ8/uSTqOPcbAIOzR33p6jsRTR1akheWgaQr6oqncZcLlgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKUaJvn8UrmZNe3InVoh2YPs7/JdOurABdzzlnMwSTw=;
 b=aDt2mcxEVzQAB4HbSn23TC+97XUMwnlSBXiKW5SXG2NTeULEwlaOrgOouAC/QFXuGaHNEaupJ0F1szByLMx9Gcx2LhpUNWqw96cJfCQnMpjy06veDqVEPd+3DYTsAO+MzEJ1jYHTlUK73ns1weV1T4iHRiXglbUh7Yb54GlKWnQZzkNCtCM623zHXbDpwnGRP0V2Y/0CChaSozUEr6Xic598zyzNkJfVjueGwqolvvcIMqMiJZAegTogr4A/6E+xCYHvc6ODGFAH72eovqq2JXWGhnNZ/m3BJMxaAEwTiw9pSjq0E5CEF5CQCq29/1oXV4euj3TP8OwAlL79fhY17A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7137.namprd11.prod.outlook.com (2603:10b6:806:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 24 Aug
 2023 23:01:52 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 23:01:52 +0000
Message-ID: <4006d76c-f3de-3484-844a-f54f692ece50@intel.com>
Date:   Thu, 24 Aug 2023 16:01:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v5 12/24] x86/resctrl: Make resctrl_arch_rmid_read() retry
 when it is interrupted
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
        <dfustini@baylibre.com>
References: <20230728164254.27562-1-james.morse@arm.com>
 <20230728164254.27562-13-james.morse@arm.com>
 <192aa189-8b08-c8c1-15dc-722e196493f4@intel.com>
 <5f5c2ca9-4a27-616f-1838-0740ced4525f@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <5f5c2ca9-4a27-616f-1838-0740ced4525f@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:303:b4::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: 6847b2b6-1d66-4ceb-e0e9-08dba4f61ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JBY6DpJ2lYS7zWnXZPJPBs0v2MPakDLKsj8WCqLKV9zrCBZZWNOWYvxSjjx3ijQ6CYzxjJgl5YZmMTtI7gIpaVCfJraZiCGAMDJEim8VUe4uDELWD34Yuk4K4cSQDHfSp3aXsH8ebYhEIhU1Upw0K8JK6IYl86Q3u7Ww3LJ/r+YRrJ54IEia7WHe+ro2mmTG9ee5BJBnuK8TYtVxogAr+lEfcuIXTB8Wjcscb43tneCDujuKu2jxfcn1lVDT0xFmKl2YYSzej1zpHPfhN9GmrNeiO0FM1CryMHN901pQvrsRQSILVZVT2egl6KZZJFuMNWP6mT0Ja/CFN0WEjOSFh8Fx1miSSq5mK8uogRWiNj++lYcjV4Z2RJN3AtNZXWrborPivmOCCKhGXdD9MAfm1fdrtRl+9ghUTM+WkXg57wBO3n2D8g3xlpGmnK/+l2KJ+EvP6be99B5p9h93r2WNF8N3SNklyvHHUXntMc8B9Ocahr1QlqgjNYPmaurGxE4LKNY5LAt6fHII6RSWOAoBKu0Ihy4xalD51WG2glCdYoSavq7owjyvZE0jxT4ztYry9U19isG+GfyreCXclRRO/07g4sYpaJ55Mo4lT0nShftRoC9W97cZOx9OIFBYmhjQZWc+uoyMEG1nyzdzEXryDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199024)(1800799009)(186009)(36756003)(86362001)(31686004)(31696002)(38100700002)(82960400001)(44832011)(54906003)(66476007)(6666004)(6506007)(66556008)(6486002)(4326008)(5660300002)(53546011)(26005)(316002)(41300700001)(6512007)(8676002)(8936002)(2616005)(478600001)(83380400001)(66946007)(7416002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVV3OFhWU0lUdXZUQjlxYWN6Q0wzOHorTGJUaEIvaEtjQk9vb3IvZWtId05z?=
 =?utf-8?B?TWVmZW9Ed3lSclhGYWlBSEFYb1BxcWhTaWIxQlJ3QllCVzJWS1B4QW9MK0Rz?=
 =?utf-8?B?bGxNTmxXZlJNUnNHK1JsaE5HSWVScStKWHlPU3JCN2JDa2laSW9lck9QOFgz?=
 =?utf-8?B?a0FhS0xRdFFocEdiSlV6RmE2WkxFQm5nUjVjYndQQjJMQlBnemQxazJmOXNu?=
 =?utf-8?B?QnN3d0tPdjJsa3VhWDlEKzF2eEMrbFFOU1AyYStkbjVKK2orWGFOK0QzRms0?=
 =?utf-8?B?TG5mQXpXcFdCQWQyQzFzZENDRWtwd2ZBNHh3dUZCMTlSWjVRQTg4S2puUVNN?=
 =?utf-8?B?QzVHV2VUZTRMWVduaXh4K2tWZFd2d24zQWEyMlRCN3FuazBtbndmVDFLUll2?=
 =?utf-8?B?ZXJKL3dmb2tVaGRDWlEzTENLQ3UyUkVFL3hGbW9OQ0diTStlSFdkRlZPeUl0?=
 =?utf-8?B?VE5sZWxrZGh0ZDlEelIxOXFDUGxURkwxeTBYZFRhT2NqMEIzdnZLYjJPSllr?=
 =?utf-8?B?NzhpL0t5Qk43V0dnMkRuVmk5ZGtSYVArZWpuREFQcG16WlMxdFZuUFZXZEU4?=
 =?utf-8?B?ZXptK0xscXhGWWthQVlzMU82WHJ2MUNlWlZObkgrcmFmUlJkRWd1aVpGNXQ4?=
 =?utf-8?B?TUhpa3Y4Y1N1MVdZeE12Y09vYzgwcmQ0YUVkTFBvbGd5b0tDU2Jzb0Exa1Bp?=
 =?utf-8?B?azIxeldUa1lzU3poS083eXVFRGFXNEhXZ3k3bk9saDAycFVSd29adWtmU1N3?=
 =?utf-8?B?MDdIcUl5NWlvS3lCVklYcU9MY25zdjd5VmRHSGJRRTVMT2o4RldBRkN3Z2Yy?=
 =?utf-8?B?VEJtU01tMGJKamZQZUs3U0RrZnhMWEYzUUdVNUpzdmhNSTJjT3Y0clhIaFE5?=
 =?utf-8?B?cTFGdDlCQml5bU9YMlFKc0lsckFmT0wwRFhjNVJ4MXNvNng2aWlZam5WZDRj?=
 =?utf-8?B?YVNKSGJ3TkV4MC9EcFBudnJBVkZyc3FOUWxZVmRBNitNS0gxTjMvRk0xb3ZH?=
 =?utf-8?B?MDA1eEJmYTQxbnd4YW5XR2pmZFAxa1VTN0hwZzAvQWwycks3VEZ4REJlVit3?=
 =?utf-8?B?QjlhWHdnV21xaEhzc1N3eFpBd2l0RFNnSzZQcFJWRjRpTU5jWU1teURTZUNx?=
 =?utf-8?B?Z0d5eXVIQTVSK2MzZzFCUXdQUnNHMmxWbFAvOTlrUnBMZ213NkJIenVnOC9s?=
 =?utf-8?B?RG52YUh4Nk5oWDJ5UVIvNUtZbHVRM3l3Vm5hV0FrdWtkVGVWb3ZmQ2NhZFlC?=
 =?utf-8?B?OW9wVkNoRDRxSFJlWmZrdU1KOWlOSGJQdXRYbW8wUS9VSS9jWm9YWS9CTDdR?=
 =?utf-8?B?MUY2M25sVW9GV2tJL1dnNGpwMFl2bkt3VkEzcG5DOTVDN3ZiREl4Ujg0YkpT?=
 =?utf-8?B?c281QXVDOGJ3bjV4SzhUL2F2UGxocDBkV2FTa2RCektDZXB0K1cyWlAwOEdO?=
 =?utf-8?B?RWNuSHphMjJoRzM1ek1Uc1NxMFIyUXFCT2wrdFVmN0FNbE5RR0s0MkpHZm9l?=
 =?utf-8?B?NnJQUGlEejRQOEVaTVFmUkRSbCtQZGg3MW05TDdpcWN0ckg1OUhWWmZxalB0?=
 =?utf-8?B?NkdlVjE3WHJWS01JT3g3Zms5Zm9vVlhCY3ptbGp4RG1ETFRrZWQyT1o4T092?=
 =?utf-8?B?ZzRyVW9Eczl0QUxLeWFwYU5aU01xcU4ycUp2SGJkNEtRUWc3T2xIeEgySGhD?=
 =?utf-8?B?Y3pCSmh0R1B4QlBFRTBNNU85OHN0MFR2TDdqUEdFcWJVZ3FDVWxqZERRdVlU?=
 =?utf-8?B?MC9kK28rVlJYSFo0Wm9Ec3RCdkFMT015QTIwNXBubGd4bmRrZDhaU2Z0VWFx?=
 =?utf-8?B?TVZHdkxHdUdtYW1Td2dwMlNJQmtyTmQ1TERUWHI0KzdlM3JmMksyNlRWRXVH?=
 =?utf-8?B?S09OclRMeE96SG5Fc3FIQ3ZBT010bURoSWR0ZWcyb0pwdDhDZjNsNTQwRXpu?=
 =?utf-8?B?NXFHNnJVRi8zMThzZURSZHRkb3d4M2pISnFvNVlQaDNjK2VpQTAzVGkrai83?=
 =?utf-8?B?ZGtNMUg3U0ZOZSthWlJBZ0prWkVHYmw1WTRPOXZWSmRoK2FOUkgwS2VGQ3JX?=
 =?utf-8?B?SUkxVXh4M0pKNDM3N2RVbSsyb3NTSEd3SlBBS01MdU1KbEVkWFVwdSsyczZL?=
 =?utf-8?B?dVhhSGJQaEozaFBqOWVRSVFLbUo5Z0t3Y1ZYbWZGSnRUYmhXMVFia2daRFFK?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6847b2b6-1d66-4ceb-e0e9-08dba4f61ac4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 23:01:52.2977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHzGuDeqbfxtZKCNdo1JV1Yn2AwryIHG8eoNU26DNtuOC0pVKZsHk0QECeXnxj0DBo8PX58bQCQvIWi77Sn5yx3N/a205G//kHF2f409fh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7137
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 8/24/2023 9:55 AM, James Morse wrote:
> Hi Reinette,
> 
> On 09/08/2023 23:35, Reinette Chatre wrote:
>> On 7/28/2023 9:42 AM, James Morse wrote:
>>> resctrl_arch_rmid_read() could be called by resctrl in process context,
>>> and then called by the PMU driver from irq context on the same CPU.
>>
>> The changelog is written as a bug report of current behavior.
>> This does not seem to describe current but instead planned future behavior.
> 
> I pulled this patch from much later in the tree as it's about to be a problem in this
> series. I haven't yet decided if its an existing bug in resctrl....
> 
> ... it doesn't look like this can affect the path through mon_event_read(), as
> generic_exec_single() masks interrupts.
> But an incoming IPI from mon_event_read can corrupt the values for the limbo worker, which
> at the worst would result in early re-use. And the MBM overflow worker ... which would
> corrupt the value seen by user-space.
> free_rmid() is equally affected, the outcome for limbo is the same spurious delay or early
> re-use.

Apologies but these races are not obvious to me. Let me take the first, where the
race could be between mon_event_read() and the limbo worker. From what I can tell
mon_event_read() can be called from user space when creating a new monitoring
group or when viewing data associated with a monitoring group. In both cases
rdtgroup_mutex is held from the time user space triggers the request until
all IPIs are completed. Compare that with the limbo worker, cqm_handle_limbo(),
that also obtains rdtgroup_mutex before it attempts to do its work.
Considering this example I am not able to see how an incoming IPI from
mon_event_read() can interfere with the limbo worker since both
holding rdtgroup_mutex prevents them from running concurrently.

Similarly, the MBM overflow worker takes rdtgroup_mutex, and free_rmid()
is run with rdtgroup_mutex held.

> I'll change the commit messages to describe that, and float this earlier in the series.
> The backport will be a problem. This applies cleanly to v6.1.46, but for v5.15.127 there
> are at least 13 dependencies ... its probably not worth trying to fix as chances are
> no-one is seeing this happen in reality.
> 
> 
>>> This could cause struct arch_mbm_state's prev_msr value to go backwards,
>>> leading to the chunks value being incremented multiple times.
>>>
>>> The struct arch_mbm_state holds both the previous msr value, and a count
>>> of the number of chunks. These two fields need to be updated atomically.
>>> Similarly __rmid_read() must write to one MSR and read from another,
>>> this must be proteted from re-entrance.
>>
>> proteted -> protected
>>
>>>
>>> Read the prev_msr before accessing the hardware, and cmpxchg() the value
>>> back. If the value has changed, the whole thing is re-attempted. To protect
>>> the MSR, __rmid_read() will retry reads for QM_CTR if QM_EVTSEL has changed
>>> from the selected value.
>>
>> The latter part of the sentence does not seem to match with what the
>> patch does.
> 
> 
>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> index f0670795b446..62350bbd23e0 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> @@ -266,23 +279,35 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>>>  {
>>>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>>  	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>>> +	u64 start_msr_val, old_msr_val, msr_val, chunks;
>>>  	struct arch_mbm_state *am;
>>> -	u64 msr_val, chunks;
>>> -	int ret;
>>> +	int ret = 0;
>>>  
>>>  	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
>>>  		return -EINVAL;
>>>  
>>> +interrupted:
>>> +	am = get_arch_mbm_state(hw_dom, rmid, eventid);
>>> +	if (am)
>>> +		start_msr_val = atomic64_read(&am->prev_msr);
>>> +
>>>  	ret = __rmid_read(rmid, eventid, &msr_val);
>>>  	if (ret)
>>>  		return ret;
>>>  
>>>  	am = get_arch_mbm_state(hw_dom, rmid, eventid);
>>>  	if (am) {
>>> -		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
>>> -						 hw_res->mbm_width);
>>> -		chunks = get_corrected_mbm_count(rmid, am->chunks);
>>> -		am->prev_msr = msr_val;
>>> +		old_msr_val = atomic64_cmpxchg(&am->prev_msr, start_msr_val,
>>> +					       msr_val);
>>> +		if (old_msr_val != start_msr_val)
>>> +			goto interrupted;
>>> +
> 
>> hmmm ... what if interruption occurs here? 
> 
> This is after the MSR write/read, so this function can't get a torn value from the
> hardware. (e.g. reads the wrong RMID). The operations on struct arch_mbm_state are atomic,
> so are still safe if the function becomes re-entrant.
> 
> If the re-entrant call accessed the same RMID and the same counter, its atomic64_add()
> would be based on the prev_msr value this call read - because the above cmpxchg succeeded.
> 
> (put another way:)
> The interrupting call returns a lower value, consistent with the first call not having
> finished yet. The interrupted call returns the correct value, which is larger than it
> read, because it completed after the interrupting call.
> 

I see, thank you. If this does end up being needed for a future
concurrency issue, could you please add a comment describing
this behavior where a later call can return a lower value and
why that is ok? It looks to me, as accomplished with the use of
atomic64_add(), as though this scenario would
end with the correct arch_mbm_state even though the members
are not updated atomically as a unit. 

> 
>>> +		chunks = mbm_overflow_count(start_msr_val, msr_val,
>>> +					    hw_res->mbm_width);
>>> +		atomic64_add(chunks, &am->chunks);
>>> +
>>> +		chunks = get_corrected_mbm_count(rmid,
>>> +						 atomic64_read(&am->chunks));
>>>  	} else {
>>>  		chunks = msr_val;
>>>  	}
> 
> 

Reinette

