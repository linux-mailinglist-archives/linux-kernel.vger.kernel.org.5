Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A917DFC54
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377476AbjKBWXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjKBWXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:23:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98331DC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 15:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698963819; x=1730499819;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/XhZBxUtGvA1Nrro7SOGe89mpwZQ4mvQseoJGMcuvgM=;
  b=iCKyhj6y4eUhCahSjH8YinGxFJK0DD10ItPZmaEEu7TAmDb2G8vlcX1E
   loEcilmzzFGnwLxgJ5HLMlt8//ouDIMrE5Okofe3BlcnayaAdNmQ8qX2o
   Neu6XJyBE+mIcyX7J5EQi3S9nglhgQPhVRN+lV/oion6EX7D28+xOP7aq
   tt5MPP8pDFtZWt4jDnkPG5vUQfKmtuXyYBuPsS/2VzLGa9b7oqnwVntlQ
   ZAhr9MSdwTNzoAZwZuAaFGsysU54jqMuVV90NyKGnEdeBDkTNl+4XFXRz
   81QzLt9WNRiWaNskN0ftXSml5U1vWoA0qkiPYWPP6ik0Z0KBBZSm5nXEo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="475071441"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="475071441"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 15:23:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="765069227"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="765069227"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 15:23:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 15:23:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 15:23:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 15:23:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 15:23:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iryx+Jah1qrt/mrCtHpfJ7yjMojIykXbGJ+7I1q/DF+Q02/CS7MyvDpmy9nQ3PRbq0Bck9LZrFiO3Xxbsv84DAr9fk4cZOTdtGwHddCAjv4Aut0J1gVSKyxzYJ+e+tZvTwxr9xR/4q6ymGcN2fZZyKzAwVFPz2Ppos5Po1m+2bzPcIeaDepoxv54C4ZlUH2uN1C4U3qSHd13rzkKhu0Ln3tbUL9tIlXspl8dem3rRDFm7uizzFO/hGSGNT90RS8fzbt2nzR7t3QZaO1Yk8iwuVoIh8ea2k4OTmB32XU+XLw4EnEdCuvhCbqSTLngpyB2GxG3M8AJB6KtnX2YHlTVdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwrJWWNweB66nrKhPVr6+5P8VJC1QjXRJ3dqyCB2Hh0=;
 b=O5aPtcbzbmI9h7Qsj1Dgcc5XyN9Us6f7p5/cl2AiLiO3LmOwl+xQ1SNm4QukmCvXlfhnMNqQEQedvBWgofxyN9lvripJaZ/qx5Rk8w8p6rhSV51vxnzU3C10ZobUdX5kjd4d15eCffZTWbmTWfTAptdkz4jLK/VQayF9cXZHGKML4/HgYdJqkqElZuwHQho1lU84fP844d6qGVhZxyWmdF0ESRTwn2BAv+TehlSLYgrjJblsQpE/aHAba0I/KoHnqQglprBUlkEziElagea/BRSM3Zj6W80B5hb42wMVViWvCHySuhktpT3GJUizv2bEcMvCvEWE6le5FGHdvoasrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB5521.namprd11.prod.outlook.com (2603:10b6:610:d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 22:23:30 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 22:23:30 +0000
Message-ID: <0f8bd2b0-025b-424e-823e-03e51e99cfcd@intel.com>
Date:   Thu, 2 Nov 2023 15:23:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/resctrl: Fix unused variable warning in
 cache_alloc_hsw_probe()
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Moger, Babu" <babu.moger@amd.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20231031220534.37730-1-tony.luck@intel.com>
 <d47235e0-7ecd-483e-82c3-78f13c77df67@amd.com>
 <SJ1PR11MB6083C14236AC0AFCB49DFB15FCA7A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <9e6a979a-48db-4b25-884f-ac8d4c2bb078@amd.com>
 <ZULCd/TGJL9Dmncf@agluck-desk3>
 <3ca2b0ed-6732-4fc4-a5fe-1846b873b02c@intel.com>
 <SJ1PR11MB6083D8F1467F094A5F1993EAFCA6A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB6083D8F1467F094A5F1993EAFCA6A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:303:16d::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB5521:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0703bc-b5d0-4d28-4b24-08dbdbf2577d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EiUr8TyrN9bRQ+SEj9TL6zm3/sbO1nlyZefTkXsUmb1JrKJSpb24XRsTxUBv6crchyMftjTZhArMY4Fuyt4Wncyj9lr4Omd4ZRwSfMBOARNhhm+DoBL20hU2P+nDdXT2S8WYeUOyB+zrYGEVE0ARzPmRzkeF7xToKsuNyiVqWpW72U6ugjXaHXIBFwIQ5OU3WzSuBQVe/wexIua/YOYYXmiYNHRqwRDMhVPztykZ3odGN7QzctMtjhowuaidI+gnEBdbYQE0SipCRS2cISufT/1VVpgVEOTFHsgEyOBuDifl+YXytw1kAzD5yXHmtwiLd53xuccL3RssmMTbCgyIS8FRXmDHXCZnzSckp0eG+n7igYU8CXfvjSn5CJDByeitxBNvO0wpfreyOJfTC12mZ0w4YYWP9/T5ZNfVf2UQI60bw1qKGum/srQL8xvDUoL/hy90nLUKkDFh8ObJ9C1Yt/TWEeTSEhgoIfw+muJosn6gegGk7dyHzYL52eMWIQCUteM3gNgUJH0XgGEL681cFGpTyUBBDzq/DgK4uLgFDgzo8BB0zzAt4q/qaaQti/U6MJROC4Fsw6+pmZ0I6qiIbPYhzfdhqtnDpl6ORTqhD2/swTZ9qD9FDgpY1EBjM8wmQKy4i/xJ+KT8motDGtOGL30tcWfl8vW56pt37L32KdlAmZ1fJtSiq24BPS+2QvOYrM42IzarSUabdsRYbr3pKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(230173577357003)(230273577357003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(36756003)(26005)(6512007)(6506007)(53546011)(41300700001)(86362001)(6666004)(31696002)(2616005)(38100700002)(83380400001)(82960400001)(6486002)(478600001)(31686004)(110136005)(316002)(66556008)(66946007)(66476007)(54906003)(4326008)(44832011)(8676002)(8936002)(5660300002)(2004002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NS9XRGppeUREUFZWOWIrT3JCOGxtd2Q5TEM2UCtMZi9QNlBaR1U5RjZZVFZE?=
 =?utf-8?B?YXVKLzJ2dTkyQmQxenpIMmFLU0dtNVFuSGw3UEw5ZEpSTUNEdldHcWM3OFNS?=
 =?utf-8?B?bTdCcjYrN2RmMFVwSi9jS25keWtURHRPenJMN3d4OS9TdVZsMkZwMWw0Y0hk?=
 =?utf-8?B?dHN0YzRTU1lNMCtKc2pIek04ZUxYakJVT0hDbWhZekpBMWU4TkhCaWZpTEZh?=
 =?utf-8?B?R1J1TWVCWGovWGExWWVFQ3c4b1lBcUlmK1dFb0xnYmJEUkI3VmYrWmxlNmRW?=
 =?utf-8?B?eTBWZ1JHTWtvN0R4UzRzSGxTTzBWR2JNOElKZlFkRUdzaHNkMjRuWGpzWndz?=
 =?utf-8?B?ZVQ0V0Iwc0dlRWRqUW1KbGRhbi8veklBbnpObkl1N0hSeEN0VllyUmFVS3F2?=
 =?utf-8?B?blJMWTI1ck5XTUR6UnNuSTM4d1k2WjJBMmlmVGx4Wk1ZVGdveVJRRDVNYit6?=
 =?utf-8?B?RURiVnhQbDFSZDNwK1RSRXZzaXNXV0VGK20ySmRQaTdwRzRZTUZBQ1VUMjF6?=
 =?utf-8?B?YWd2QUZkNzJPeGpqTzdBMjlHMzRrdjJqMUR4cStoR3o3eG42MVZGRW82aTlM?=
 =?utf-8?B?QStxbE1Sd09KTnQrNGcycWxObTZsNlcxd1cxYjVnUzJtNlJOSU1NZ3JBSnZI?=
 =?utf-8?B?QzBzNklTYzluWHhldUg1UllaMVVhMGtiOFpKNW5SblMyc1FHZlhRS3FyejEv?=
 =?utf-8?B?Mm5vZmdZcklRd0tETmNvWXRMNGJXMnh0QStXVC9Sd05nc3N2bXpxOFk5Zis5?=
 =?utf-8?B?Ym5xT2xrUEhGZjBFS2JMN2FEWUN4NklBSlZoRG1HVlVyRGdYT21ZZytQcHo5?=
 =?utf-8?B?Z05SLzF3TWNPVkY2dHVsZWV6NmVsVFVuOUJPUEhGaHF6NmVJMFJyOW9MZExO?=
 =?utf-8?B?dHZsVzJ3K3lKMHVVUzlZQkFUMU5Hak4xRXE2dGNDdWVmVkRUMjl4QlRwU3di?=
 =?utf-8?B?TU10Y3pqaDk0UW1EM05DL1RZbEFYNUc5c0c0dDZyL2U2akhpT3B2MVcwVFI3?=
 =?utf-8?B?dnJTcElkelZ6VmpJUUlKUGp0RFdBL1dPN2VRaXZ1S1RnWGhSR3NueG1vSk1I?=
 =?utf-8?B?Mzd5K0tsbVgzdUdsMUhFbG9MRVV3OHN5d0pjTTdjUHl5MHlGdDkwa0ptRG5C?=
 =?utf-8?B?aG1IY3VSMmExekphWVBjempuV0Fsc3g4WjFPNUdMNHVNRGt5eE5EQWdDaGlC?=
 =?utf-8?B?WmNnRFJxamE3d0Q3Q1p0S0R0Tk92M3BpR1Via0R5blZodzc0MXVJZWU4cDlD?=
 =?utf-8?B?eU5MdSszQk9rTWgzekJ4eVBxbnBZV2xsRmFxTmxienhTRHh2ajNnTkc0S2FI?=
 =?utf-8?B?ZEtzRUREU1lJaXlvYmVkQ28wOHpLWEkra2pUdklEdHd0QVJ2Y3p6SVUva1Jq?=
 =?utf-8?B?R1VnblBqeTJtMkV4ZEJrdGxUSGxLZmtOT2xmNjFXekN0WlpTVUJVYVRtU3RL?=
 =?utf-8?B?bnRaK1JaUG1JZVdqL1JsUDJKYWVzd2c1cFFTMmJOK1g5dXBoYm9OWS80dVJv?=
 =?utf-8?B?cUt2SmRkSEx1RWRMRGliR096T2tBMkZhQWRhdXljMktibm9BZ1lLRmFiNm1R?=
 =?utf-8?B?UmFBTjRINXdtUy8xQTBHdHVscjhoSTAyVmNGUlFXSHRpWEtLNkk1K0R4VWNU?=
 =?utf-8?B?TENPNGhSa0p1Z05OUnlBZk1LdU4rcVIzc0dKOEVCQWpzQkNMakVhaDZCbkJt?=
 =?utf-8?B?SUhOTmNlRVFEYVpSeHR6UllZVjdBMlYvNWpabWlobmdETS9QK0dUcUl6VTcr?=
 =?utf-8?B?T2laV285OHlrT2ZHQzB1MHhtZlpOdVpYNmUwVXJFMnkyaFRQRlRFc1JXUFFk?=
 =?utf-8?B?WmJWZ1puYlNJdGFBMnFKQmszQ2VXdVVtWnZkKy9LZ2R5QVRpampaL3VpZ2VM?=
 =?utf-8?B?eXlvbFVyUGl6cXFVdnZFejluMXFmUnpYS1FiV3l2dXQzL2Rhb2E3WERJMVBr?=
 =?utf-8?B?QVRnOTJvbk82aVpqczVYaDBYV1U0UDBLWDlnRHZvTEhtYldEWXZ6QjdiZHlT?=
 =?utf-8?B?OU94VFJ2S05FL1ZvS25ScktrcTZ0dmh5SEx2amxJeUlINGNUTmlSMFdDQkNP?=
 =?utf-8?B?K3pTMzEzeTl2VXpSeVhaK1lXdllRQUZiWTgrVVM2MTZYSVFRNklmTHlWeW82?=
 =?utf-8?B?c1BET0J3MlUzanZRR3owSHZWNUpFcXFKSXFWM245VXNoZXpkckFzYjR6RlB3?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0703bc-b5d0-4d28-4b24-08dbdbf2577d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 22:23:30.0952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9/4qzJvjhYEEo3e9+CqSeuO5VOm714U4vjB/5f/B217WWMagdxtHn/0x8ihEtOmXgNnas+VoVpE3wRwo8lBMHyv0zowicEk45/241aJ3vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5521
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 11/2/2023 3:02 PM, Luck, Tony wrote:
>> This is strange, I am not able to encounter this warning. Is my gcc perhaps
>> too old? I know there were some specific versions needed to reproduce similar
>> warnings with clang (see reference commit 793207bad71c ("x86/resctrl: Fix a silly
>> -Wunused-but-set-variable warning")).
> 
> I'm using the default install from Fedora 38:
> 
> $ gcc --version
> gcc (GCC) 13.2.1 20230728 (Red Hat 13.2.1-1)
> Copyright (C) 2023 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
Thank you for confirming. I tested with the same version. Strange, I see other
instances of this warning but not the resctrl one:

$ grep "set but not used" ~/t/log | wc -l
20
$ grep resctrl ~/t/log
  CC      arch/x86/kernel/cpu/resctrl/core.o
  CC      arch/x86/kernel/cpu/resctrl/rdtgroup.o
  CC      arch/x86/kernel/cpu/resctrl/monitor.o
  CC      arch/x86/kernel/cpu/resctrl/ctrlmondata.o
  CC      arch/x86/kernel/cpu/resctrl/pseudo_lock.o
  AR      arch/x86/kernel/cpu/resctrl/built-in.a

This does seem a valid issue and my Ack remains. I'm just puzzled why I do not
encounter the same warning.

Reinette
