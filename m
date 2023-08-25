Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05B9787C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 02:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbjHYAaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 20:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbjHYA37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 20:29:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D6E1991
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 17:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692923398; x=1724459398;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dcZI+F+EfECasd+7SHUzsx3XVeiv9Qx6Di5Ix2UWHC0=;
  b=kljjgjEymJClOT2SWEjnC2uYG+7admstj7xQr++6L0sHPvtixvfk3UOU
   EdFIzbK6dlFGq7hR/jEwqV0aFA2TwDkEhinp36HFv31BWJH+ExSISHr3/
   hcPnFOuhLTy+9k50GIwJmEyVeHZjPV/2wfyf01COAdEC847AfGrU9iyzc
   WWCZ+3Yst2fi6cIxoFpw1hZZC0RH4vpBnGwzbu27dr70EavQ/VXb+Vvpn
   nTKTCJm6LvffWC0q/XMLpI00tpUC9HA9hC9AZ9D2RDkwnCyl9JYSxXi4a
   LHbihRRzvaBV3T5+OgsRwnzjhOYElsxPnThjayNFZl2/jinxRk5wrAa2w
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="373468074"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="373468074"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 17:29:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="687088595"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="687088595"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 24 Aug 2023 17:29:56 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 17:29:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 17:29:56 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 17:29:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z01KItPGIPkobc95dtU28T536wnk1t6mC+bCa7HmwatY4KXmrdXKg5m29rzMK+JJ4Zjcvdxt65+xv/0Dg194G0I6cHQu1FC0FbGqLKTlGYS9tsz+7GSzcarINNx5fmLRskNeA9C/6b5+LISmEkAdGEpVBJoNbEay70MSpQcbOqNYhLC5cZEbLvRfc9aXNCvIE5j4gv276iq6STb0A+Eik8FTbB/PLB9Xnc5WnIWrqeT9BiOoKDK7XrA5ko15j0ee0NsTMLx9WjEEwE9/bZbO1OjahpjyoMoWSsc0dwX5EVahzNVWfLS9hHFx1WftP9AwK32F0zWEr5zEGwalo/JYFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/htZhYjLsPMmhAvON9rvocTdLSiue3QpDrX30eyzfFg=;
 b=NoyH7TbtyDviWt6PQwYnIttTZKXWMRgpb5tervO1MoUsPW9yUSJOa/7RWbrMJADEj7IPyOHiBwssCKcEwBdttnBwSQQ+wRNIuzEMcANu8j8HZDkoHlg/kpWQ2eFr35rmPBbzU5EovrgMsp9Bv5zhPtIMh/HoMvdzB04w22vGIP1ZYZ8/A8HCKFYGyPECIDH1sc7tXVthB21IH0KpdkA395Yuym2shPXSB1bAC8v+WZhjANmXZ+WkhrNrzRybjKJdd17dOa8ruCOU6+v8XUA2qpDBZ8A1VntSwtI8thnuDQ7nDmfCZF5IS1Ein+TMOs68FpT2wvUO8XAyCnE8BjZYOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4928.namprd11.prod.outlook.com (2603:10b6:a03:2d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 00:29:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 00:29:54 +0000
Message-ID: <837b1558-1ac9-d05d-e8f2-90d33e259326@intel.com>
Date:   Thu, 24 Aug 2023 17:29:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v5 02/24] x86/resctrl: Access per-rmid structures by index
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
 <20230728164254.27562-3-james.morse@arm.com>
 <d93950f3-1ceb-9652-f223-f6e550f8a818@intel.com>
 <dee72388-764e-a123-13a8-3a47341c8c55@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <dee72388-764e-a123-13a8-3a47341c8c55@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0384.namprd04.prod.outlook.com
 (2603:10b6:303:81::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4928:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f4dfa23-9829-4f1b-58b2-08dba50266f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: je7xcZBEwIlBKsYCWLWNk4/M0mX9orMUXGfNZwe9S38fldQtOuWBJQDhHfGSONZQYWLvrjMxNlrEURE2kDHjK4S7CRRGgY5yP6wn8UzqBY7mexfEiOy7zyaKoyVNhSo2pfwW2svYhbCssCkPb0H/V89rZ6yuo0+yoRGYtVf7OqOTfrO0D7M48YbTgoCFErBQP4ghn7dnTkqd6/+lJ6kZkzx7JuwaBkhpAsYgspCbdtzZXTeEy5H/JMBA5wZOO/fN1UblKfNRF6HlVNsEoCSbFnSumGM/l5YUvUWmpyiI2kj1UIt/HkkrmD4fnRGuA01NIWNjajRR9No9zq+jHYqpqkIn4GUIcegeDHA/I2hJSsAbUcaIM3Kay4SN2griDUG8XmQeiWIifSPSK3TXVJxHgQOcFNLnEBeP1/zau/XsL1ZqUx3ykG+MqSihF+epSiUi0vXq46sBV0IbRQtp7V9eEKnCmdarG58JpkIVMWELD8T+Apgg4edY5PgAyVGiaxUSvDFfndCMYaVhdVXbTyBf6rA6hCVewkydjnrXc2/MgUOYUOC3+dE81NL4qMYAmkPFdBYSJSOGoKDvVIYHn+47JhnpMsj3EeC5LphRzrl2oJZ9mAnlTNt/3WZ7Lqt1gGHec4lILTSy42Zxblyj3cwMuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(396003)(346002)(186009)(1800799009)(451199024)(66476007)(54906003)(66946007)(66556008)(316002)(82960400001)(478600001)(26005)(38100700002)(6666004)(41300700001)(53546011)(31696002)(6506007)(6486002)(86362001)(2906002)(6512007)(31686004)(4326008)(8676002)(8936002)(83380400001)(2616005)(5660300002)(7416002)(44832011)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGVDUWU3Ykt6TXoyTDNiYm5lSXNYR2tFOGpDVmlWRUZIUzFDZ1JrMmtiUHNQ?=
 =?utf-8?B?RmVHVXdEZStYbkRWWlpySlZORGZvUWVyTFMvWmsxdEtlN1VyemQ0K3RZbUY3?=
 =?utf-8?B?azJMcTROVkp4WEJJbXV1cGxEbVJxNzQ1akd3aTloK05nRXJOSmdGTi9kZUli?=
 =?utf-8?B?eWdIclRxSHhlL0ZiYWNvVGZRcUdCakNwZFZCc3FVR1IyQjcwbDFLcGxsZDlp?=
 =?utf-8?B?ejcxbGcyK0xoQ2JWNXVPTThIb3VER3FnMFd4U2dsbFVhRkRZQUNHelBKc1ZM?=
 =?utf-8?B?Z05RWGRtb1p3T0RPSXZRWm5KN1J4UFk4eWNSbnZyRHZtNnRGT1M4d0lvbnB1?=
 =?utf-8?B?TGs4VGJGSWI2bUdOVzA5UEtqTERyY0JiZytIWldhLzhyTENyVHZWSytHWC9X?=
 =?utf-8?B?TzZsSjROdmdXajEwdUVsaDhMdnBkZmJMbmd3VVB0ZndOWDJxZXdneTA3WVJ2?=
 =?utf-8?B?SUt3K21mQWs3Qmx3Q2JLUHpja2kya1JuTGlUVVo3aC9MM1A3K2xtejM4dFdq?=
 =?utf-8?B?UmNWaHVpR3QwZFE0RUhQSytxS3pTak1uRW9hdDRGbitpamlMcENUeWdCMlFx?=
 =?utf-8?B?d1hteThYeU9KMXlzZ29SZEhBbWtnNE9kSkhBTFhKZ3FIVjJ0Q3huaTFMc1oz?=
 =?utf-8?B?U0ZiRGY0L21KbElpTGNKYk5xL0YrS3hkczQ5NlFuL2puRE43NmVDWGVNeTJO?=
 =?utf-8?B?NEc2NnhXU2tHMHZMc1c1cWVhZ0s4d28yVkJiM0hOQytoSGtlMFpKUU1QM1hK?=
 =?utf-8?B?c1dQNlVzZjhHQ1E4Yi9lZHpuSitpT1hTMzVvdHJFaXFMREpyQzNZU2xGblVl?=
 =?utf-8?B?Y1NMelZEUEpMUGdXTjVWdGNkUTRDcWNrcmNiZUlQNEhXMDdCUVBuM0tRR2li?=
 =?utf-8?B?VHZONU52ZjhvdGt6UStuWHo3aWNtMzZmS29vS1RxeW0wdHZYZmhZclJUMDBl?=
 =?utf-8?B?V0N1K1hUSXV4dFpKMFdiVmFLZ2RoTGRNZWJ4VmpZZnRsaVlKY2N6WGhHNEFB?=
 =?utf-8?B?NWhvbmVKa0pPZmFJaTJOUGQ3aWxjVThFbE50eWdaNE1qOU1VSEIyMUgrVnA4?=
 =?utf-8?B?U0IyaFNhdmdSN0hSd2lHTm5xV2JLUDh5RnFna1FLcTJWTExnaUhHdW9wYVFP?=
 =?utf-8?B?aWt4b0NuYnVOQmdYVUtQdWNkc3NxQmVnSnl0K3g5dEVyMkJ6MUorcHVpcW8v?=
 =?utf-8?B?Ui9leXhicGVCQTVMNkI4U0JQbTBuMjVZb1FxckEwS1RzdWlUV29kTlFobm9F?=
 =?utf-8?B?eHZXVjlRSXBZcUdYcnpwUUlab1NjL2NBSXZ3SjF4NTM5NytDalZvTDQ3OUMy?=
 =?utf-8?B?RVlHZStBQjJFRlJ5TktjM0VSUjJOOGxuZk12MS82N09aZUxWakxxTmlJOHFo?=
 =?utf-8?B?YWF2RGdpYWN5SWo0aERDOFNjZXhOOTZadkNKRy9OL0VpVFRzOGZZN2h6UE5W?=
 =?utf-8?B?d3RSWitJb3lYV3I1VFdKM1IvVFBiU2k0VE82OUVYT292YnJ6aWxBd3pteSs1?=
 =?utf-8?B?VDMwTFEwVFl2azM0U1I1M20vQVpCV0RtR2JHZ2tRNUdZTS9kQXgzQzl4Vko0?=
 =?utf-8?B?cnZhUTdQc2JZZ1FGQWVGZmpjdDNveXNWMTB3VDcyRTdrMmNTRWRkOFd2WmdW?=
 =?utf-8?B?YzMxaHBDS0hXV3dJSkFhTk54VzBBbGZKRkIxMGFTL01KU1YxcThqWGxSazFz?=
 =?utf-8?B?RERGdThkVzdvZCtYUzVQRjhMQkpuVUErWUJrVzY4S0VISHlmNllCQkNyTVV1?=
 =?utf-8?B?V0Z5K254TmVOSzdPc0lnZHBYazZna0FFc1N1NGZFZ25sUEpBenBUTCtBVmNW?=
 =?utf-8?B?U1l6d3RjMkEzR3pMNyswQ1VJWk82eTNUa2VLOGo5WmpyekZhZ2hyTEJkUnBD?=
 =?utf-8?B?OGg4RnU4RjlLalY3UE5BOTRkREN3V09QSS9sSUNxMjRJRlJTR0c2VE1uYS80?=
 =?utf-8?B?SDA3Rk9HS2lnMmJaYldRb1dWTXd2dGUyRDVMWlc4MXVkOUdCOVR3cEJCODEz?=
 =?utf-8?B?bU91UW5nUjhIQTV3T2FCUWpLeCtaWGduRDZjMU9PSEd4Y2drQ1VObk02VUhu?=
 =?utf-8?B?VDIyYlQ0bG1VcWhnWDFQcUVLY1EzZXJSK3ZPcDdUQkQxSitiUUZaK01rQlZu?=
 =?utf-8?B?bkhWdzkyRnZzRTBnNDBQNWl5QzdxRFRlQ2h5ZTZ0cjRMd29YME51VEVYS213?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4dfa23-9829-4f1b-58b2-08dba50266f0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 00:29:53.9911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E889CkY1OmIUymLPNgXssOpVd/QxLb0Ghu6ueqew8giZbi0nSXxRA7AhACgu5+aBCJQkk06NVn6vzgSv1eeFYL+h4P1ElknxgfXNVD80EnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4928
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 8/24/2023 9:51 AM, James Morse wrote:
> Hi Reinette,
> 
> On 09/08/2023 23:32, Reinette Chatre wrote:
>> On 7/28/2023 9:42 AM, James Morse wrote:
>>> @@ -377,14 +399,17 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>>>  
>>>  void free_rmid(u32 closid, u32 rmid)
>>>  {
>>> +	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
>>>  	struct rmid_entry *entry;
>>>  
>>> -	if (!rmid)
>>> -		return;
>>> -
>>>  	lockdep_assert_held(&rdtgroup_mutex);
>>>  
>>> -	entry = __rmid_entry(closid, rmid);
>>> +	/* do not allow the default rmid to be free'd */
>>> +	if (idx == resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
>>> +						RESCTRL_RESERVED_RMID))
>>> +		return;
>>> +
> 
>> Why is this encoding necessary? Can the provided function parameters
>> not be tested directly against RESCTRL_RESERVED_CLOSID and
>> RESCTRL_RESERVED_RMID ?
> 
> Doing this by encoding means if the architecture code supplies an
> resctrl_arch_rmid_idx_encode() that ignores the closid, this reduces down to:
> | if (rmid == RESCTRL_RESERVED_RMID)
> 
> which is what the code did before. I'll add a comment:
> |	/*
> |	 * Do not allow RESCTRL_RESERVED_RMID to be free'd. Comparing by index
> |	 * allows architectures that ignore the closid parameter to avoid an
> |	 * unnecessary check.
> |	 */
> 

Sounds good. Thank you.

Reinette
