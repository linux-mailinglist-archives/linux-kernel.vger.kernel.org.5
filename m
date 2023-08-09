Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31F5776C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjHIWgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjHIWgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:36:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E904DA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691620601; x=1723156601;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gd9IYUwW2f1S/sq+2loSMJb8njF2RdlWrSkTXNLoj5g=;
  b=MDRU2+Hl6LG4vIHB4Y5DxY5O920x3FvGuSqGXejIANPQ0pUmYZHzmiHC
   w6tAiBxd8/ZARbIzemzM882akS+Rs6J5XTTbBngpJDFJWEoDfziLTJtak
   cyHCQkpRJsfCTLe9TlPZ8Fkx9ZTP86A3z93KWiiados54pW/dblWZGD/5
   +wFNOpwrl7kj6SjMSw2zuncxIcj4gupw+r5BnAa4yup6zpRlkZrzUuDgb
   EHNfK+uYqqXgEB24lAPeUiIe4qZt8U8+mpy7aHQ4tcc2DwT1kp6CCUwNp
   QruhgoUyRkGsp+CTkqELVVGvDYwwkUZG4ZyI8Msul3xCMEgDqcykIjm32
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="374961494"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="374961494"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 15:36:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="875461456"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 09 Aug 2023 15:36:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 15:36:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 15:36:39 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 15:36:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGX5mt65I8hU4AsckxknFtk+Pb/dxwV6XF1X1zfdS8LjrqZPFTrKKyERPbWN/nWxcKzZqMTg2wV6a+0XjFTeSIj9ZJXmB0aLrDzK20XhkisOydQkRR0t+q1RFDTxwD895pXPHIupwZL96L71xJcC0W4/3g3CwClS9FE0YWSG36C5GALHHSFvaPpp124lMkiv9/FdQwALfM1A7Jpn5YSxI1DpeHQBuAtWJF2TCthvTOAdxtUqX6UXe43FcZNwKW3PYTFd+MqALcwlwD0CszwNtw88/UWz8XUWSalAz+F20Rm57V8iPoG4gJF8aV5fOm+OL/EgtRGnmFh8n7xNtosN+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHVLdkvfXcldU0dD4dSATJ8FeBYy8qif2vwEIso+Lw8=;
 b=LBoSQoeO+ZT03Aw/6PZolsg+Tr5C/FHopaLEXFu+TUQ5h9x//bpq2p10fZ3gDBq0MJv4UjFGtQ0u+hXr2k7phqgu5jQeqKxzt5S03/senrQmsJuYiTl5hr/kencFlWSblnK2otCBi5Hwc7V6P8Ny0l9osL3HzoBhGSYVL4lr0E7UjtZ/5G0ADUwp+QWjaymX/W4bdyyF6JESbCuG9JmW/bksKTLtxSVx3axF6+Lr7AlBcIVlBQSfv6qU49Cnh79RkHt3HNzI/2enT440m4dc6YM4UasA73bo6qcyrEDFIxUoIuJBXL+y8qnf8CH2DH01kc/AISf5E+WVSVkM11RN6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB7413.namprd11.prod.outlook.com (2603:10b6:806:31a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 22:36:31 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 22:36:31 +0000
Message-ID: <4a0f777e-5dec-296e-c326-61e3630c3608@intel.com>
Date:   Wed, 9 Aug 2023 15:36:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v5 14/24] x86/resctrl: Allow resctrl_arch_rmid_read() to
 sleep
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
 <20230728164254.27562-15-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230728164254.27562-15-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: 764ee859-c7a0-42d5-c03d-08db9929143d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VcNmiqdV6Jc0FXOgtuur5vNeFzTg/stoiAma5ZOV5KUlnhY3goUHj+hS2Q+jhrbcgg9NXjh2QPhvzQg0GcGLQ81BUAMhB3u65kdXZyzBz2uR/bS8n2stpL4vOFBDLvtt5Fr9bVLsGndnqK+lIjddV6fJSPLmtNOLPNZ9uJA1hTBzBcnLxMgWQBeqTX3TQjr1sDL/T4yZkvWYypDlMlfGQPT28u/CTokyGIAmjDXxX/YRCe4Q6G9NIJb9UFq0dIxRLJKtpZd7qtdZr+silKsThe8t1nugmZh0iOA+w0G2QFzaah95Pb7g/xMas607hA+mGvm/be2m5x/j36ENwNqBcp9pasR0K12wl3XMiIcTwCLO2TzhZPoy4rTctWz5CXhDVQsEiDtRekLQ0bqOmxX0q1TpsijO7/geojUJFtNwgFoY7rgrsb27n0Hm/z+3tR68WScgxhobX7KMwJqUyF8SQIidPtbKJaninXSEa/FKmwKG+w5B5RYrGAafZyPCxJOAcXzsJ8/RF6ri17SVk2ITfASuUXwI/lOmmEoGX1zgTdc/WnLaFe2VJvenTFnbgvubAcAM4RnCTxpHGS75Akh4vj9MfDh3daFEmLK8RPg8YBS1Ej5WJpFfRauvlA0Z6Hu7y368SfSELO8Fe2UePQGOUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(366004)(136003)(186006)(1800799006)(451199021)(26005)(8936002)(41300700001)(2906002)(44832011)(5660300002)(31686004)(7416002)(83380400001)(8676002)(2616005)(38100700002)(316002)(53546011)(478600001)(31696002)(86362001)(66556008)(6506007)(6486002)(54906003)(82960400001)(66946007)(6666004)(66476007)(6512007)(4326008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVJhNGozN2pHTUp3eEt3cU5TdzFUb3A0UnBBejBKNUg5V0hUS0dIK0c4TklS?=
 =?utf-8?B?WlZyL2p2VFlHNElKdm05TTZuUDJpaUxDUytiSTRvakJNVjVDZWhscW9RcHVq?=
 =?utf-8?B?SjZUSHJEWmNZVHI3WllpeFgvZ0V5UFF2QzRrY2lRWDdTckdaN0NWZk4zYzJv?=
 =?utf-8?B?MFc2WjRIMTBlYXRUL2pDS0dJU3VoZHhaaTcwbXY0dGNMUmVpc2VPTFd2RUhJ?=
 =?utf-8?B?V0dsUHdwWW1Fd0FzL2tlclI1Q3FsVnladjhsSUxhZG45bVMzeGpNT2Y4VWNC?=
 =?utf-8?B?aTRNd1lDS3lZQnZSc1VJZlBmREV1dVpFQStNeHhwT015TTE2UWpXY3pUNkdH?=
 =?utf-8?B?ajF5aFZteGd5VzA3TjRrMCtQOVQyeFE4U1pqZFZtTUpDdCt3NzdZMHAzQjNj?=
 =?utf-8?B?TUMrSkY3SXVGYStaRm1DRUxUNGlibVByWFJzbVlMVUVXNGpwVWFkZWpiMXR5?=
 =?utf-8?B?Zlh0bzQwUkJWWkgrRGMzMVpZRFMrejdrMnRldmdwQ0Zxak9odFRLNlBIWkMr?=
 =?utf-8?B?bFRiMzlNOElUeTFYNXBSMEJwVVVXRUE0cjk4RldLV2J4blNnOXpVNlFERlFY?=
 =?utf-8?B?ZGszNmFRRXNYbDVQZk1ZaDVqRi9hVkpqeGlsY1ZmakdvaDFxMVpWMTEvNVZt?=
 =?utf-8?B?amxnK2huckF6cDF5WDkyWnFBN3Z2VXRiR0F1d0RqSCtTeXd6SE5qdFMzVjd2?=
 =?utf-8?B?RzRRUkoyVXBqaDRWMmxzNEszbXZmdDFGcWMwNXR2Q2JOS21jR3RsR25oeVZ4?=
 =?utf-8?B?REJjenJVeVBNZlpEVVdyRFg4OTQvRlBSWVlGRmJCUDFnZVZuNW84ZUVBd1VY?=
 =?utf-8?B?NlRrUkpJOXVpUjdrYUJQWnQ3UU1BRDd0Ni9Hem1xc25tRzFIb2RiL1ZPWkNF?=
 =?utf-8?B?TmFuQzRzSlpmS3ZjRG9XMGFHbkdnWWI5eUYrSm4xWE5FTU0xb3BMalFmMURR?=
 =?utf-8?B?Z2Fud3lxWFA5REpJbnl1SWdrd09VcEVWRHJnNzJXZEZwZTF3NExJOEtTcWJK?=
 =?utf-8?B?R3U4WldIVG4wcnltYThNR2FaWUVvUU11a21WNDd2T21TdWFvTlR1SUtRYVhT?=
 =?utf-8?B?blRQREtqZER2bzlEWXN1UXNFWlhkRzU4WDUzT2JQVFVNYVVXb0xXc2pQeXp6?=
 =?utf-8?B?Ukh5NHROTnE0T2UvOGJDc3l1ZTZtV2tNZlVQZ1g2RFFqN2xkc0ptc09vNkhX?=
 =?utf-8?B?Q2VZVUVFQnFEYURrdWtRWnFqWStBRm9nditYQXdWY00xRlFRMFdqNjBGMjdy?=
 =?utf-8?B?TVNhTHQvNkhZM1JhMnNBVlJvVE1uREJqRG9NTS9wVElWWllTWXM4dGdFOWV2?=
 =?utf-8?B?eW1vTjYzV1RZYjBCMUo4bHJDU3M1TE4rbS9IZ1V2QWgzT1ozaVAzYTdGaGZ4?=
 =?utf-8?B?WmlyS3M4SU50WVpjdVcxUXRxL0g0TERmclBzU1pLNktSQnJQQmM5c2xNSFMv?=
 =?utf-8?B?SmdOTU1HYXQ1NnlSSVRoTnpiVUk2RG1HZHo2N1d5bHVxNDVLam1JdWNBWmlJ?=
 =?utf-8?B?K3dhdUxYYVV4MDRGUUd4N0JnTHRjU24xMDVDeHl0Z3NQTDc5V253NUY5ZXhS?=
 =?utf-8?B?VXlxV0RhTjYvdzdCR3JwRVNqK2IwT1JPbVFPeU1xMk5GNVpodHZlWE54MDZF?=
 =?utf-8?B?L29pQnRsdU12RXZQT2dabG0rMGJWbzJlcDJlOW8wZktaMzNDZ3VMRUkyTmNU?=
 =?utf-8?B?endsY21GUjFVM2UyWGJSS0wzaUkvczgyOWh5K3NrcUdYMWFnUWlaR3lPK0NC?=
 =?utf-8?B?Q2JpWkVQSUdPTWd5L1JsM1NWWUZLanA2VkhzeS9NSUF1NFRtQlJHS2pqWEN4?=
 =?utf-8?B?WHhlbzQ5cGR2bVFVMTMrMk5jOEZDOWpXcFZ0eWZQWWxHYmcvcFZGeTc0ZFBY?=
 =?utf-8?B?eEFKWVAweFhCQkFJeEJaMlBBTnBuWElPTk9iMWVjeG43alZ0dmIwaW9ES3Fn?=
 =?utf-8?B?TEZDZnhPVWJqSGRTN2QzZzlwSEhvYkxZVGVqb3haMXhEUVRYTHd5NWJvYlBy?=
 =?utf-8?B?Y1ptRzFOaWlZS1pqOE5nb1J4OEFUZE54bnRiVVVGSkE0aGYrdlN5RUVtRzR2?=
 =?utf-8?B?bU05djd5MmRqanV4OVJxTXYyY3RrNTc4MThCRGlDNUtRSlFQa1k2ZGRtN2VF?=
 =?utf-8?B?ME1zSnJPUUJrNmFKZkRLVG9LcnVxSDl5L1kyT2ZGUmJ5MTFkQmpibmU5b0RI?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 764ee859-c7a0-42d5-c03d-08db9929143d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 22:36:31.7022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHqjRma4Sen7882D6PJNPgtaYtSP3BjK9P3rpBAqhNUX97gLaZR/ltlCrS41ZL1BmkMcKwaU3BaxIJm5fYF8MW1+mOfxGLUhM7DqHSvmWbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7413
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 7/28/2023 9:42 AM, James Morse wrote:
> MPAM's cache occupancy counters can take a little while to settle once
> the monitor has been configured. The maximum settling time is described
> to the driver via a firmware table. The value could be large enough
> that it makes sense to sleep. To avoid exposing this to resctrl, it
> should be hidden behind MPAM's resctrl_arch_rmid_read().
> 
> resctrl_arch_rmid_read() may be called via IPI meaning it is unable
> to sleep. In this case resctrl_arch_rmid_read() should return an error
> if it needs to sleep. This will only affect MPAM platforms where
> the cache occupancy counter isn't available immediately, nohz_full is
> in use, and there are there are no housekeeping CPUs in the necessary
> domain.
> 
> There are three callers of resctrl_arch_rmid_read():
> __mon_event_count() and __check_limbo() are both called from a
> non-migrateable context. mon_event_read() invokes __mon_event_count()
> using smp_call_on_cpu(), which adds work to the target CPUs workqueue.
> rdtgroup_mutex() is held, meaning this cannot race with the resctrl
> cpuhp callback. __check_limbo() is invoked via schedule_delayed_work_on()
> also adds work to a per-cpu workqueue.
> 
> The remaining call is add_rmid_to_limbo() which is called in response
> to a user-space syscall that frees an RMID. This opportunistically
> reads the LLC occupancy counter on the current domain to see if the
> RMID is over the dirty threshold. This has to disable preemption to
> avoid reading the wrong domain's value. Disabling pre-emption here
> prevents resctrl_arch_rmid_read() from sleeping.
> 
> add_rmid_to_limbo() walks each domain, but only reads the counter
> on one domain. If the system has more than one domain, the RMID will
> always be added to the limbo list. If the RMIDs usage was not over the
> threshold, it will be removed from the list when __check_limbo() runs.
> Make this the default behaviour. Free RMIDs are always added to the
> limbo list for each domain.
> 
> The user visible effect of this is that a clean RMID is not available
> for re-allocation immediately after 'rmdir()' completes, this behaviour
> was never portable as it never happened on a machine with multiple
> domains.
> 
> Removing this path allows resctrl_arch_rmid_read() to sleep if its called
> with interrupts unmasked. Document this is the expected behaviour, and
> add a might_sleep() annotation to catch changes that won't work on arm64.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> The previous version allowed resctrl_arch_rmid_read() to be called on the
> wrong CPUs, but now that this needs to take nohz_full and housekeeping into
> account, its too complex.
> 
> Changes since v3:
>  * Removed error handling for smp_call_function_any(), this can't race
>    with the cpuhp callbacks as both hold rdtgroup_mutex.
>  * Switched to the alternative of removing the counter read, this simplifies
>    things dramatically.
> 
> Changes since v4:
>  * Messed with capitalisation.
>  * Removed some dead code now that entry->busy will never be zero in
>    add_rmid_to_limbo().
>  * Rephrased the comment above resctrl_arch_rmid_read_context_check().
> ---
>  arch/x86/kernel/cpu/resctrl/monitor.c | 24 +++++-------------------
>  include/linux/resctrl.h               | 18 +++++++++++++++++-
>  2 files changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 32569354c4f1..08e3307863c3 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -283,6 +283,8 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  	struct arch_mbm_state *am;
>  	int ret = 0;
>  
> +	resctrl_arch_rmid_read_context_check();
> +
>  	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
>  		return -EINVAL;
>  
> @@ -470,8 +472,6 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  {
>  	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>  	struct rdt_domain *d;
> -	int cpu, err;
> -	u64 val = 0;
>  	u32 idx;
>  
>  	lockdep_assert_held(&rdtgroup_mutex);
> @@ -479,17 +479,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
>  
>  	entry->busy = 0;
> -	cpu = get_cpu();
>  	list_for_each_entry(d, &r->domains, list) {
> -		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
> -			err = resctrl_arch_rmid_read(r, d, entry->closid,
> -						     entry->rmid,
> -						     QOS_L3_OCCUP_EVENT_ID,
> -						     &val);
> -			if (err || val <= resctrl_rmid_realloc_threshold)
> -				continue;
> -		}
> -
>  		/*
>  		 * For the first limbo RMID in the domain,
>  		 * setup up the limbo worker.
> @@ -499,14 +489,10 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  		set_bit(idx, d->rmid_busy_llc);
>  		entry->busy++;
>  	}
> -	put_cpu();
>  
> -	if (entry->busy) {
> -		rmid_limbo_count++;
> -		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> -			closid_num_dirty_rmid[entry->closid]++;
> -	} else
> -		list_add_tail(&entry->list, &rmid_free_lru);
> +	rmid_limbo_count++;
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> +		closid_num_dirty_rmid[entry->closid]++;
>  }
>  
>  void free_rmid(u32 closid, u32 rmid)
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 660752406174..f7311102e94c 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -236,7 +236,12 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
>   * @eventid:		eventid to read, e.g. L3 occupancy.
>   * @val:		result of the counter read in bytes.
>   *
> - * Call from process context on a CPU that belongs to domain @d.
> + * Some architectures need to sleep when first programming some of the counters.
> + * (specifically: arm64's MPAM cache occupancy counters can return 'not ready'
> + *  for a short period of time). Call from a non-migrateable process context on
> + * a CPU that belongs to domain @d. e.g. use smp_call_on_cpu() or
> + * schedule_work_on(). This function can be called with interrupts masked,
> + * e.g. using smp_call_function_any(), but may consistently return an error.

Considering that smp_call_function_any() explicitly disables preemption I
would like to learn more about why did you chose to word as "interrupts masked" vs
"preemption disabled"?

>   *
>   * Return:
>   * 0 on success, or -EIO, -EINVAL etc on error.
> @@ -245,6 +250,17 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
>  			   u64 *val);
>  
> +/**
> + * resctrl_arch_rmid_read_context_check()  - warn about invalid contexts
> + *
> + * When built with CONFIG_DEBUG_ATOMIC_SLEEP generate a warning when
> + * resctrl_arch_rmid_read() is called with preemption disabled.
> + */
> +static inline void resctrl_arch_rmid_read_context_check(void)
> +{
> +	if (!irqs_disabled())
> +		might_sleep();
> +}

Apologies but even after rereading the patch as well as your response to
the previous patch version several times I am not able to understand why the
code is looking like above. If, like according to the comment above, a
warning should be generated with preemption disabled, then should it not
just be "might_sleep()" without the "!irqs_disabled()" check?

I understand how for MPAM you want its code to be called in two different
contexts so I assume that the MPAM code would have two different paths,
one that can sleep and the other that cannot, both valid. It thus sounds
as though you want the x86 code to have context checks so that any issues
that could impact arm can be caught on x86? In that case, should the
x86 code also rather have two paths (one unused and the other has the
context check)?

>  
>  /**
>   * resctrl_arch_reset_rmid() - Reset any private state associated with rmid

Reinette
