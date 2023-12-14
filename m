Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB82813A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573145AbjLNSxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLNSx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:53:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EBDA0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702580015; x=1734116015;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lKNJnabv0BqZnrbwl8lHblJvfba3dp/zFDJCBL4z2w0=;
  b=WMLAs956zfWyubNTV9aas5+U2EfK3It5R4kWj+m+JCXZe0ZzmqNPAk2P
   tbHPAT0FLXu+HKWlJejFFbD/uyiYGC9LQhsXGb3IcWd3stRxizTyyB5Xr
   lAZW7kZMfeMeb0h5glcyNa6XZG3P2S6osJKGOPUnNIocSL3lm7FSnNCjL
   dML5ZecIeaVgrGXQluotiHdHxxamJXA6ApXlmAx5qhaRq3XO86knUDh6X
   Um0eEHgghnqoBckXFcRXkqJyfMzmk3VHO7+aeNtlOEJDexL4bAevOQ8IK
   F3+AMKRQxbYEcXOMyARSfi+Km/vr5h92HGixmBuPLCGPVmk8wmIc4wiBQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="16722401"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="16722401"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 10:53:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1105835937"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="1105835937"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 10:53:33 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 10:53:33 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 10:53:33 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 10:53:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuH3MlzyX1fu8lvX4lnKLUmFUGVk2WE9fz4i8OWo+h7AOV7xt6ysveWtSYD2jLJRHZcIK99nIAB2kCTlgbYidHcEWdhHXkKI9tKDxtnG+RjrRlyHSkeppIiKPHzVFjkz9MXK7ldnHuiZDe7kFdNG28J+eO/qjO63IW2Qn2iaxjZ+Dz9D9Bdczub7T9R6UHEp0KaR8SQ8B1uwHTzEGBHnqFEMnMN8ckBjo0tQldANVq6JR5iekWBpkKdiFuJG8g+gDY1UmOZvs04oyQk+PgRREdti540mTbW3Hf3ffZguzKTi9R1dt4DNGyAcjwXwN9Aa/OgoojekibTVJPPmYQfP1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyCt1cvegHSIEqwLsTU31V4Cxv8X7HZ1ihM1iibLecg=;
 b=ekWZIHAY2RH0tIG606jARLldmxN2Yrcxf+7Bv4RHy8j8nF5BtR4/komaS/exPT+N6a0sAgSAPvgr4SVKnABtVTMP7mwoRfgguhUHTlHv5gMuEv9gvwbC8Uknj+xXQiI4FEdQPJQr8O68U4I8+iW4cBy/9rIlBY10bj01QM2p8Gx5Y3pBYuv0QMnk5hz3uDCuL5kDQng27iwYIZ7YkVpfdvrT2nilK7Xmhm3Ld6UlOQ2Ac1TaBNYAwZXVCRvlGS7Jdpwjrq0H/5hayVeMULYff58TrWvSf0DGexMcMFr/t3M/9agwyizvFEQRaPJnX0zyWTkR151kr/CSvJLKASQ23w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6242.namprd11.prod.outlook.com (2603:10b6:208:3e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 18:53:25 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 18:53:25 +0000
Message-ID: <9a66b7f8-097b-45af-97b2-4c403c295301@intel.com>
Date:   Thu, 14 Dec 2023 10:53:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 21/24] x86/resctrl: Allow overflow/limbo handlers to be
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
        <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-22-james.morse@arm.com>
 <9084cb79-22bd-4cb3-b48d-f0d8d71aa47c@intel.com>
 <b077b38f-b42c-f679-1e08-70b55d116e17@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <b077b38f-b42c-f679-1e08-70b55d116e17@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0291.namprd04.prod.outlook.com
 (2603:10b6:303:89::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 88447f1b-abcd-49f8-9ed4-08dbfcd5f3e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QrIhg/vyQ26q66KrtBLETupOt7c6mBmQxgGFAL5XWQf42Xz3gxzxYL7XnXK0boTaFf0E05A9lHA9gLiBb/n57Ne1jn5EcI/R5JQGqparH7pI21IzZMh88yAfZ8kBhkltxgmawV7zUOi4NZ/GDLEk8f2/5Ce8X+Piq2m8+CSAAzF7kgMj1TNLheKKmploTFRi482dRJjWXWwh9Zc3zHiGhKrJq01S7lolzWfWTg5PvPgfIVrDzrVmjmapMbJfTXwAx4Qg2C+Cev78x5CsZTybTV/TyFaXADQ4+gS6uCBQfNq0BBKs/gpaqL0mrq/0mN7+kg8i00hltHCFa+i6N3qYS4m0Utx1ygA1/2sLAqM+2SNp8sPMn+2MWMkRuqmoqsP0fgRyvrLgiG6ASQQxG76qBYRvu8NYXIf92abynoubEHNqJteqyRhc7G2/3pfNS6PcIOQBIxPdgxpQIglcLMpKNA0OTEO3AVu/Xw7AMzSkZuKAR8g9sqqiTSVzFlqXkTl6ICFj7OfsfcrqRLJ2GDwAb63VAiOvCnkWllXukSg5oiEC/HLVlSXnqPyFbC7eQWGvrZ7eTWDCtZVP3uIGR/2oxwq3/f+NgRRUaomkuxn31yOcSuWtZtpcUUo4mcMdocluyOMYEdllmhbJOqgJjV2eug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(5660300002)(26005)(2616005)(7416002)(83380400001)(6486002)(44832011)(2906002)(478600001)(316002)(36756003)(66556008)(66476007)(54906003)(41300700001)(66946007)(4326008)(8676002)(8936002)(53546011)(6506007)(6512007)(31686004)(82960400001)(38100700002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dS91QUgxYXFmUEN2em44TFI1blJNVGk5OUMxcHM4WmZVamczUVdQWHF4eVpZ?=
 =?utf-8?B?RG1DTEdrZm8zSEMvVTZvbGFYNFk5OGdCRnNLcnZ5cU1iTjJrNjVac1JwSmZ1?=
 =?utf-8?B?SXF1NU1nNVJVM1lMQUNZbjk4WnBEVzAxRm9rZWdlN3hhRkpoN2c0RWRYREp6?=
 =?utf-8?B?R1FrakVYM2NmbSsxa0UzVUp5WTQyejJoYXpXTU1SUFVOWlNOTHVYK3E1Qnky?=
 =?utf-8?B?K0dHN0dhQmxqWXJYYnRIL0NMUDJHTEZZdTdnN1ltVGs5NmRSeC8xWmFiS2Ja?=
 =?utf-8?B?clpqNjhQaUtMNTB5MS9EODFnUDBVRGRTNzVlNHlKN0tCT29Ra2RJbkUvbXhW?=
 =?utf-8?B?cHY1TkJVUFNDcEo2eWIvN3JyUTVDOVAyR0ptamZQbDF6aktxbTdJS1Y5MC9L?=
 =?utf-8?B?VUVxRkd3alRybGtIMmw1MnQvcGhvcGtPOTl0OTZsM0hOMWgrWERHTXVFS2Qx?=
 =?utf-8?B?NW50bkRhdmxQOVFhTVNCaFFiNzZra29RN0t0ZWt3TXdNZ1NZSmNWZWRZaEJM?=
 =?utf-8?B?bkhMNTN5MjhwVDl2OEVvNldoYlRSZWJBU2hDQXVmakgzR21QZ292OHQ3S2hC?=
 =?utf-8?B?cDlYbzBHZUlBanhtRXR3MWRDRG1BZldTS002Yko3V1RJeVdxbzZJaCtmZ3FG?=
 =?utf-8?B?M0JWakpvaG1IaWJ5bG9GdFFUeW1Db1ZkenNnZ0JpaXZ4bXBhN0tObE15QjNR?=
 =?utf-8?B?WWxKL1NTOUtET2tWdUVlaVNBTVJ2SFo3a1Zka1U2M21OdVVKcWdRTWlKU1RY?=
 =?utf-8?B?N0xzdnloRTlEVkwwVS94TXJUZVdJMmN1Wmxxd3RIRjA0L0ZmM0xRRTdRRU94?=
 =?utf-8?B?Tzh0SFM2RW0vd2luS21hS01zTjE0dm9POU9YcU1BYnJQamRrT1VESGJNcjNR?=
 =?utf-8?B?Sis4Q25nSWlRUEZyM0phekdaaitVVlJQR0VPbE11OVpnYzVhZmZvUE5BOHZz?=
 =?utf-8?B?bHFvMGxPZVpIOXRUd0tRK215T244amZJbHZadk5ZK0hUVHZjN3dOVjBtNkh0?=
 =?utf-8?B?UTIwK0xMQnFWYXJSOHFOazBVYUhVU3FYOFNETjd6OWt3cWtQc3p6NnRhSlJk?=
 =?utf-8?B?UVp2V3hrQUd1ZUJzK0x0RmlMWjFFTzgrOEFXTU94NGNIaWNHSHdtMWxPNFBL?=
 =?utf-8?B?YTdFZFl4R3l5ZXV4dEpYMm9jemVId0o4VXI5QVJvZE8xSnh4ZmdqS3FuZzFI?=
 =?utf-8?B?V3NaTE56L2laVmRZblpJUmp4NXRlRUNESkUrK0FzakkvbXc4bXJ5ekJlRGlJ?=
 =?utf-8?B?TThkT0FpNmZzK0U1Q3diTXBSVGcvWUt2QzBtK0dHS1JxUFIzd3I2a2ovTnVm?=
 =?utf-8?B?WnoyNjF5WHRsM2RaVnRoS0xOL1BOWFNBL1dGb2hmOGZGcDFQVkNKSUJpaVgy?=
 =?utf-8?B?WERtVzlVUm9SRy93TUtpblIxWXlvb0ZKSW1YVkdkaXA4QzdkNTUyMzZHVk5O?=
 =?utf-8?B?cGNTSmE3YUdRTGNic2Z3eStVRmM3WitoWnJrR3RDeldBbE5MYWVNNmVYQjZu?=
 =?utf-8?B?Z0Q2dkFCZzJoQ3JBYkVtbDBMeE83WDBpVTVFc1NJaDdxU081WVVOeTlReVJm?=
 =?utf-8?B?V3lDaFJVVUlnSGhURkJjZThXVWFDWDRDS29kNGVocURCOFJFNWcxMFk3Kzdj?=
 =?utf-8?B?UzZjak1HQy9lc1JTblVGdFY0SmlQcElQSi9CYi9neWRqcVF1bURuVGI0TDdJ?=
 =?utf-8?B?Z294QTFMUC9RemhtMnpIUnpPYTVZRkVqcXA2VHREbHR6bVIzUGpJRDA5VTVV?=
 =?utf-8?B?T3RzWVJ4bkN3aGJqUVpUSlhnVkZUckM5VmF5bUUvdEhiNTlpZEZEc0UyelJS?=
 =?utf-8?B?QWNOZXcrVG1jRkdUZEtWVGNWZGcyeDh5bGUrbjBLS0Z2THRTT2FkNjN3SGYr?=
 =?utf-8?B?ZkVSZEVrejByWW16NzZIOEtDaDh3QnlrWnZhRjh1MnBabm5yU0tPUzNXOTFr?=
 =?utf-8?B?aDZ3WDFINnM5bi9KUTJZWW4wd0ZhdWQ2NmNYRWpJc3hoc1E5NUk5YnBSa1FR?=
 =?utf-8?B?UDFiSldNK0ZJRVR4ZWZOYXBIZFQ5aWZtaGpDcWJjcnNWUnNrY050RSs3Rmc3?=
 =?utf-8?B?WE1laHZuZFhLSGN0anlHc1owdjVBZFZISmdCbThrelBSRjltWFpnOUxZczNU?=
 =?utf-8?B?aGxTYmllOE82R1B5czEyREMwSzVkVHJjTW9xMkIwOHdVeG1uZVdVK1RYWG1H?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88447f1b-abcd-49f8-9ed4-08dbfcd5f3e9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 18:53:25.4709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0QSVHmmubGx9XB/A55JHfOaI4WCElovub4BrsQE8cayAz0DMM7LuNDmwRL+v8+pOf5v12O52/zeCt8cSNWAwinXjWDdJGCafIFAv0rehsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6242
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 12/14/2023 3:38 AM, James Morse wrote:
> On 09/11/2023 17:48, Reinette Chatre wrote:
>> On 10/25/2023 11:03 AM, James Morse wrote:

>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>>> index c4c1e1909058..f5fff2f0d866 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>> @@ -61,19 +61,36 @@
>>>   * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
>>>   *			        aren't marked nohz_full
>>>   * @mask:	The mask to pick a CPU from.
>>> + * @exclude_cpu:The CPU to avoid picking.
>>>   *
>>> - * Returns a CPU in @mask. If there are housekeeping CPUs that don't use
>>> - * nohz_full, these are preferred.
>>> + * Returns a CPU from @mask, but not @exclude_cpu. If there are housekeeping
>>> + * CPUs that don't use nohz_full, these are preferred. Pass
>>> + * RESCTRL_PICK_ANY_CPU to avoid excluding any CPUs.
>>> + *
>>> + * When a CPU is excluded, returns >= nr_cpu_ids if no CPUs are available.
>>>   */
>>> -static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
>>> +static inline unsigned int
>>> +cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
>>>  {
>>>  	unsigned int cpu, hk_cpu;
>>>  
>>> -	cpu = cpumask_any(mask);
>>> -	if (!tick_nohz_full_cpu(cpu))
>>> +	if (exclude_cpu == RESCTRL_PICK_ANY_CPU)
>>> +		cpu = cpumask_any(mask);
>>> +	else
>>> +		cpu = cpumask_any_but(mask, exclude_cpu);
>>> +
>>> +	if (!IS_ENABLED(CONFIG_NO_HZ_FULL))
>>> +		return cpu;
>>
>> It is not clear to me how cpumask_any_but() failure is handled.
>>
>> cpumask_any_but() returns ">= nr_cpu_ids if no cpus set" ...
> 
> It wasn't a satisfiable request, there are no CPUs for this domain other than the one that
> was excluded. cpumask_any_but() also describes its errors as "returns >= nr_cpu_ids if no
> CPUs are available".
> 
> The places this can happen in resctrl are:
> cqm_setup_limbo_handler(), where it causes the schedule_delayed_work_on() call to be skipped.
> mbm_setup_overflow_handler(), which does similar.
> 
> These two cases are triggered from resctrl_offline_cpu() when the last CPU in a domain is
> going offline, and the domain is about to be free()d. This is how the limbo/overflow
> 'threads' stop.

Right ... yet this is a generic function, if there are any requirements on when/how it should
be called then it needs to be specified in the function comments. I do not expect this to
be the case for this function.

>>> +
>>> +	/* If the CPU picked isn't marked nohz_full, we're done */
>>
>> Please don't impersonate code.
>>
>>> +	if (cpu <= nr_cpu_ids && !tick_nohz_full_cpu(cpu))
>>>  		return cpu;
>>
>> Is this intended to be "cpu < nr_cpu_ids"?
> 
> Yes, fixed - thanks!
> 
> 
>> But that would have
>> code continue ... so maybe it needs explicit error check of
>> cpumask_any_but() failure with an earlier exit?
> 
> I'm not sure what the problem you refer to here is.
> If 'cpu' is valid, and not marked nohz_full, nothing more needs doing.
> If 'cpu' is invalid or a CPU marked nohz_full, then a second attempt is made to find a
> housekeeping CPU into 'hk_cpu'. If the second attempt is valid, it's used in preference.

Considering that the second attempt can only be on the same or smaller set of CPUs,
how could the second attempt ever succeed if the first attempt failed? I do not see
why it is worth continuing.

> An error is returned if the request couldn't be satisfied, i.e. an empty mask was passed,
> or the only CPU set in the mask was excluded.
> There is a second attempt in this case for a housekeeping CPU - but that will fail too.
> As above, this only happens when CPUs are going offline, and this error is handled by the
> caller.

Reinette
