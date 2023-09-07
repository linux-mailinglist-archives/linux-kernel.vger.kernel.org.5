Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7867976FC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjIGQTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242912AbjIGQSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:18:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FAE7D80;
        Thu,  7 Sep 2023 08:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694102093; x=1725638093;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9NCxisDaOZqi36j+x5nwcL5dO5PvxCuHq0x5CA3iE0U=;
  b=AM01QD8G3WosA93CL3nJXjJsngJFvqR4iUZ8X61RIJSOkmYpiPlu365D
   9nlWGtqrnfFKqNhee5J1x4KnXF2qTKl8XYvA6Y79AAsmynXGV466kFzeb
   1eL9IRnMJ3kyAY68jddAUTg3e7fNPSV/FsL/m5nMtapDr+u5XrnWWQiZm
   cPfb7PCvfbF4OLrUCKdRB+HvBl18LpwGXqERkFGI3YISUoL4FBBHtAluM
   7U0+5N6CR1ngr29BK0Z6fJToLN4rrWCI9PU02n02DwHRu0PnGzFNinH2z
   NxtSM6H4klkAktZziNkBl0WgfKZKmaMcXtasLdTBXVjnEgJvV0NilioFI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="356847105"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="356847105"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 07:51:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="777102798"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="777102798"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Sep 2023 07:51:48 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 07:51:47 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 07:51:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 7 Sep 2023 07:51:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 7 Sep 2023 07:51:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfocSHH1HsZTg8T4P8QAbgXNBjxvbHygeVuQ3k9R/4ZjiEzYfyc84M2/Ufv1SJRBnTkyGsOqdsY2a8kT5AML9wddTqLGQQgZ2mvIaU25wcD2nQ1w9h2tR49u7qj6OLlppd7i3xFnhDExvMpAoocQTPEjlsyh2NptC4jDPaJK2HYuuOyHhPIsnzsbJVBECGnyrqVKghUtqH6h4eyApJ++hUrsor/tj6h7wfZtIIP0QzCLVGW9tH2LMfTzGfKAUjcilpc2gi6V9oDjr0p2liqyK7OmU9HZciPDXhtmWhthJLF3c0bsfCizWL35sLLntjxmh/H1cO2LBX1t2FFDSUNUUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XH9zqGVaD55oJQK0nS/07rIF/SrPUpTKYQdo3kloGJQ=;
 b=QO9RvQC2ChQWN9Ux5Qw1uO7V1KIalmDRruDzqbWlnUh3wGpunQ4Xj3W3OOVambmCZSO6FXNZPIOCYJzB3/REzJHVtcboG10f9Dmvy+vOOwK6jkIFiYoBfth6xqydjC2LwlWJDbkV+QwBAZVqtedIgW5cNcUhyTB5sLyr9siYBAj3lHtm8yVrCV4Upr2HbPiC0XVoNUJGb5YzQjicO5jQ7aIQcY2R2Xw3IicH3ctUZ4D2yi0oxa6YgE0cTgIigfExWZ+2x0OLUIxAJpuE+RI58tHyIX/dHP+FsuqvtilPvWEn8Hx3xnKsSrwUhNYVVvZyJavDcoOwozWR4Ts54PyNIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH7PR11MB6497.namprd11.prod.outlook.com (2603:10b6:510:1f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Thu, 7 Sep
 2023 14:51:43 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 14:51:43 +0000
Message-ID: <8ed66ba8-f611-ec92-2e0c-9d4d403894c2@intel.com>
Date:   Thu, 7 Sep 2023 07:51:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v8 1/8] x86/resctrl: Add multiple tasks to the resctrl
 group at once
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>,
        <reinette.chatre@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <paulmck@kernel.org>, <akpm@linux-foundation.org>,
        <quic_neeraju@quicinc.com>, <rdunlap@infradead.org>,
        <damien.lemoal@opensource.wdc.com>, <songmuchun@bytedance.com>,
        <peterz@infradead.org>, <jpoimboe@kernel.org>,
        <pbonzini@redhat.com>, <chang.seok.bae@intel.com>,
        <pawan.kumar.gupta@linux.intel.com>, <jmattson@google.com>,
        <daniel.sneddon@linux.intel.com>, <sandipan.das@amd.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bagasdotme@gmail.com>, <eranian@google.com>,
        <christophe.leroy@csgroup.eu>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-2-babu.moger@amd.com>
 <a59be218-350b-b88b-2b02-be9c1d2bf797@intel.com>
 <fda1fea1-5e39-8a54-ab97-78d182c54801@amd.com>
 <80cad07b-27e8-ab80-24f2-c6befa5db710@intel.com>
 <dd8d6beb-a24d-afe8-929f-acdfef544a39@amd.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <dd8d6beb-a24d-afe8-929f-acdfef544a39@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0057.namprd17.prod.outlook.com
 (2603:10b6:a03:167::34) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|PH7PR11MB6497:EE_
X-MS-Office365-Filtering-Correlation-Id: 12fbac28-687f-452a-a329-08dbafb1f3a6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZwFnSRv/kznPk8M5Gd03D4b6qLj0XXmXJ/WeWVLQ9AZ7sxSbf/QV0HujfiXFkOmhzxt7LX3XRFCEI0zd2wlhnh36xd14wIKORaHKAlZ1BUN/Dmt44IOYPv6kzQrRUmieWXkWSvnzeC5NvWyrVlEkkjREIIjtpCoLCLog9s9C4GuR8d0wukr7oZZHtjlIzpW8vWar+KoyA/gqmWmksf2A1n6QfcBGOqRGs2yvHP9tu0hw0IDzLjE5LuyZGHd+MWNN5ivdHPfYfIqx9xotacCV0fEtMfh00JVCONOYIfz1wXtGr9GrNwSGJ2gT9XJX6bYZDRfheCREv/3cpdNPXlmav+YPYUD5IEpP5xLgj6A8g9ft6rLQxo8NmwjSBUq8R0gWAA1Wxb2FktBJXVWwgo+bvh1b5dBGP/csv+ws36FbEZe1xIGgnzWcVYwcE7OmmyLh44qw7q0P7TMer1sR2AzAAKANp6hXWHi00nq6MaZFlz/oO26TcQXjYtOWa8GbKii4+UtbboXz5vXwBFcCGFj9heKEjMmP4Cy2LsmqZK/vpqNbHNoInrXtRl9b2cPI2GcodAAbEeJRXUJg83iswynGzBiaaEh6mDgLi9ef6ZJ5Cn89WhkfPrXGD10FFw8LhjkFwpfqcMsqb32NaXwIRWxnaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199024)(186009)(1800799009)(26005)(2906002)(83380400001)(8676002)(8936002)(31696002)(2616005)(6512007)(6486002)(6506007)(31686004)(36756003)(86362001)(7416002)(7406005)(53546011)(82960400001)(44832011)(5660300002)(38100700002)(478600001)(966005)(4326008)(66946007)(316002)(66556008)(66476007)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTVpeXEydHEvd3ljNkdSS3hDZXh5bFZ3Y1RuTVNOLzJ1SXdvQWZjTFByN1Jp?=
 =?utf-8?B?VjIzWUFrcTFrN0ZMVTRjVmtVWjFqc3ZUOWUwTk5sbElDK1F6SDdFSWw1OU1X?=
 =?utf-8?B?NUJaa0ZWUk9JdnBQN05rZm9WQ0ZZVGFzbHVTUjIvL3pHUHJzNFNjSExIY2FN?=
 =?utf-8?B?WTJOeEFxYzNZcFBEZzR1WUZZNTMzR1hUMUJ4dGhYSXZhMWJhblhVSGMwUUlT?=
 =?utf-8?B?NHY1ZEkvMDRIRU9pdHByZ0pubzk5aGUrR3NmNTZRLzQ0bG9lL2k5Z3dUd09l?=
 =?utf-8?B?UlIzVmpHVVJQMENTbnRpRUoySHFlUVpBWmJQNmFOcUxUNis2NGovVW1TdXll?=
 =?utf-8?B?QnBxZWNEZlZvdlgyRXUya29tbW1LcllUUTRzc0lZd0VwNm42VjlrMTZvRS9y?=
 =?utf-8?B?b3hFOVBqUnIxRlNkL0YzZ1FmUElJVlNUblJTTHczTzhUV084Qzhkc1JCbSsr?=
 =?utf-8?B?dGEySXpZRVovRG00ejJyV3NNbE9pYWZYb01FMzlpL2JnN2FrVGx2dDMxeHg0?=
 =?utf-8?B?bzNPN2Jscy9xM1VOcXRwRCtBTVQ3RkZRWVRoRzQ5am4xcFkxQlBNeEN0b214?=
 =?utf-8?B?dFFLaTRKVjdwM2pQZWlwTEJEMkJJWDloRCtNb2dTTTZJSVpzMzlVcXNKNkRJ?=
 =?utf-8?B?cEQzeDJ3L2VHWVA2MGc2QmUvS1U3blRuK0hNRUIvTWJIeGhoSnlvSHJ5Y2tI?=
 =?utf-8?B?VHRVZE5majBGaE82ZXVsV2FLcVFmdzdrVFdiMkFZekF2cjZ6VnFxVGNTdHhI?=
 =?utf-8?B?YmRud3pnd0E5b1BnNDJIQWRiYWFNa2s4aFRQM2Y3YjZYVlJFNWlpenJkMFE5?=
 =?utf-8?B?OHREeFRoWlNFWWkwQUR4L1BPZlRvRVh3K3Fzd0JEbHJpSjE0RWNZeC9ZcWtR?=
 =?utf-8?B?bUFnd05tZ3FXS251VkVmdUlHRjNGVzE0MFBWV0VKTmZOYkJ5QlUrM2xnWTRi?=
 =?utf-8?B?TTlUWkZDaWFGR01FS3ZWemJKbkVwZHZCS0lRdW1ydS9zTXhTME5WZ0djOXB4?=
 =?utf-8?B?a0g2cmp3dUt4SDVkdE5nNW9PbTlnNlV6eTVWRnRMS3Z5Z0JlN0FFN0VpaGVS?=
 =?utf-8?B?ZWdDcXlvdEJiTGhIUHR5V3lsV0krNWxsVHJDQ1pUUFBZMmpoZUQ5ZTFCMzNl?=
 =?utf-8?B?eGZ6VXo4TDNyb01hRWJkUmdHK2twWHBRNmUrd2tWUnd6Y21mcXRHSG41ZVR3?=
 =?utf-8?B?Wk1DMiszYUNwZ0VoQUpGdkF6cURvRVFnS2t0UXBxazdHb1FsRVJZeHZxZlp4?=
 =?utf-8?B?VTdKTXlDOUhaTkZtU2ZxeUdWdytMbklhSllzN1FyV215NkRHcTR3NHVUbVdK?=
 =?utf-8?B?bGZtelY2Tk1IUTlnVVlsTTZneEhjT2hpVU96YXVteW9KYlRjVmwwRTJZODNX?=
 =?utf-8?B?aG1WZ0IyOWI3WGdjVXN2c0E0UWl0SFpaSG1yUWFlMDEzZmV5UHNYY21iYjhP?=
 =?utf-8?B?V1laaTk2MnFiZ0lwd0l5NUV3bTIxWUpNTFNvNkxmblFIUFBLOWc5WWVQakd3?=
 =?utf-8?B?UDZUalJJUGh3clowdWpnUHhDNzNzOVZDOEFxZXBjZkwvMEFLWlYrMFdrb3Fo?=
 =?utf-8?B?VVVQTlAzNWxEYjkxYnlDN3pkNS9Tc1FwVWdDTlhBVm9wNUlsbktFY1FmenVR?=
 =?utf-8?B?VkUzZEZkQm9TVTZGdnM2WUQvcnJpNTVqWHMrMGFDbFBGdm9UR1N1elZuekhN?=
 =?utf-8?B?SnlGZE51dWVMSGtaaVFjdGg0NjRtdXBudDFoTHYwV3AwRmRpUHlSTkJkRk82?=
 =?utf-8?B?VngzRGhZZlRuYlA1ZjFBcXE4emR1M3ZhMGtUR3pjbnBienRrTkovR1VWZmc4?=
 =?utf-8?B?aVRaNWIzblBwUVp3S2ZBOXZscjk2b0lkOE9leUdXaVRWQWx6YkdZelVQbUow?=
 =?utf-8?B?OXdKNjhmNWlKaGRKRjEzWVUrZUhSeU5Fc0k0alZjdXpKaHozWk9GQTVUcXpP?=
 =?utf-8?B?SU93WCt2OFZtSEtiMk5VRnVFbkIyeEdiaTk4UFVRaVFpc21EZTNVdkVjak9v?=
 =?utf-8?B?M0hXSU5jaDlvZFZEL3NQOTkzc3ZWdm5TN3V0V1NteFdiRU5ieUJMbEVDTGJ1?=
 =?utf-8?B?VnZyb1NXSHNNcCtwem9zMTdjT284UnFYeFRDVWpXR0NqNFlEU2hzN1I2WDNW?=
 =?utf-8?Q?8L2v0JnTLdAjzzqJNEV68dwnV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fbac28-687f-452a-a329-08dbafb1f3a6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 14:51:43.7403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0prw5m2g9CIDdS+hp0psDpkjddC7342aEsxUO0xHc4KhI/ZMllkl17IQHpFJfC17Chlfuh9QFlu33DHSsRpvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6497
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

Hi, Babu,

On 9/7/23 07:44, Moger, Babu wrote:
> Hi Fenghua,
> 
> On 9/6/2023 3:42 PM, Fenghua Yu wrote:
>> Hi, Babu,
>>
>> On 9/6/23 07:56, Moger, Babu wrote:
>>>>> @@ -715,7 +714,27 @@ static ssize_t rdtgroup_tasks_write(struct 
>>>>> kernfs_open_file *of,
>>>>>           goto unlock;
>>>>>       }
>>>>>   -    ret = rdtgroup_move_task(pid, rdtgrp, of);
>>>>> +    while (buf && buf[0] != '\0' && buf[0] != '\n') {
>>>>> +        pid_str = strim(strsep(&buf, ","));
>>>>> +
>>>>> +        if (kstrtoint(pid_str, 0, &pid)) {
>>>>> +            rdt_last_cmd_puts("Task list parsing error\n");
>>>>
>>>> It would be better to show the failed pid string in the failure report:
>>>> +            rdt_last_cmd_puts("Task list parsing error pid %s\n", 
>>>> pid_str);
>>>>
>>>> So user will know which pid string causes the failure?
>>>
>>> It was already discussed. Printing the characters during parsing 
>>> error may not be much useful.
>>
>> Could you please let me know where printing "pid_str" is discussed?
> 
> My bad.  Should have read your comments more carefully.

Thank you for your clarification.

> 
> 
>>
>> My understanding is a similar thing is discussed in v3:
>> https://lore.kernel.org/all/167778866506.1053859.2329229096484796501.stgit@bmoger-ubuntu/ 
>>
>>
>> Then v4 has this code without printing pid_str. In v4, there is a 
>> similar discussion of printing pid, but not pid_str.
>>
>> But I cannot find a discussion of why "pid_str" is not printed.
>>
>> If kstritoint(pid_str, 0, &pid) fails, without printing pid_str, how 
>> can user know which pid string fails? e.g. user tries to move 100 pids 
>> and the 51st pid parsing fails. It's hard for user to know the 51st 
>> pid fails without showing pid_str in the error info and then it's hard 
>> for the user to decide to re-do moving or aborting moving etc.
> 
> That is correct.  Will add following print statement o print the pid_str.
> 
> rdt_last_cmd_printf("Task list parsing error pid %s\n", pid_str);

Great!

Thanks.

-Fenghua
