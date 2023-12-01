Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09312800166
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 03:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376494AbjLACIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 21:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLACIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 21:08:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3EAC4;
        Thu, 30 Nov 2023 18:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701396529; x=1732932529;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7kT+dN0knlYUHf7aQWLA1jlTXI18tp/vci3phrnOXHo=;
  b=VYxJC1wEcV9GwrQNfb7s8xmzLvQaCik4PUyYPpNfNcQ8br+CfAeo+PiR
   PyDX1VwuDRwplHQrjD8YiC7sOL0C+F7HzgtDq3UqwYiKOOD+pPtHsfgyR
   TUsCB1dnpFCosb+jCc223dPljpQ5Y+17F1wWd8KB1exTLXVJSdoxso5p7
   CoD3fho834Pbtro9jZEapj26pZU4gU24aUYraA34t7PEv4rVL5uDRuhqC
   f2mNggZbT3YfC1WmqfXg1IJTxiczi22efGYchmvzDJJQX9qYuptFomkMV
   /3BPts5fkcQyHdtIudKRzHzeRjeC6h4ysJ0zCJ/mrBl56UxTApdmIy9fZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="12134807"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="12134807"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 18:08:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="887450739"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="887450739"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 18:08:42 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 18:08:42 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 18:08:42 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 18:08:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWdEbv2It5xMbAxfygruTNhDag53woaFWt9vaPrls666N7truNSmu8stZVRZmDV33jAjVnmaCEDZjOErCl3JlXlDY24kDWAS6dFLVXA4x3kZLq8Y5seb3+I63cARyC82SLZe90IsmcVWr0tEPrlFfw1Qz0WzQG0l6DBmcSQ/PfoZQkK8DrkbQutqNsGSWiaKAUFgfoi2cYEMi1Quxx5f6jqNVyMw0/Ix80lEb032DCUj6DxYxnCBcrtmgwTPPFuR6cZucI9Fh5o+1E7GYlzgqcxUhyKtKTSquRzIDMCAS7XRFvLMZ3UGgiA2T4xI6X4Lexp7RwuezQSu15PL6xP36w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQNzMNavG1EBDAOCLXZj32SaIvGJ2en9EXKkR8oMhaQ=;
 b=gK/H88aVJLJcDpSHM/VqOfqADFViLj7MzhqmWfWgoeLFqoG+NCrfYqu7VkIkmyt7SQygFZxWWvDLdLimiOnIKo6iM3ve5EnGtALgzwdH76Si1VOdol9POofuY201ut7c+/PjbIuWAGtGt2mPt/hMQgIuIJRr9u7qyQU3cGhvl0ekOHXwTZ9PvZYMsZCV/nPJG2kdwYSdFdxwVon/T1NdVF7Wz8n9kvcmozqDm19qTNjaspeVv+rB1ZH6eXF79ZpO2yGvj/7KBi8OQK8iBmfITqSEOohDMYkBHqhpQRnMDowgUmBarqPvtBdAvrKDi5qcS1JyvyMAOdZOIyJyVI690w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB8688.namprd11.prod.outlook.com (2603:10b6:8:1a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Fri, 1 Dec
 2023 02:08:40 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 02:08:39 +0000
Message-ID: <f86710be-1561-49a5-87ee-b3ce71fc9dc4@intel.com>
Date:   Thu, 30 Nov 2023 18:08:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 7/8] x86/resctrl: Sub NUMA Cluster detection and
 enable
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
CC:     Fam Zheng <fam@euphon.net>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20231109230915.73600-1-tony.luck@intel.com>
 <20231130003418.89964-1-tony.luck@intel.com>
 <20231130003418.89964-8-tony.luck@intel.com> <ZWjOBw0Ygyw226Cc@dell>
 <ZWj3NdI/qLNOgyg0@agluck-desk3>
 <1c1a16a5-f235-4179-9d0f-1556e11d9c11@intel.com>
 <ZWkQBwwtSae4nGgH@agluck-desk3>
 <5078f930-e56e-45b5-9df3-99e88c0858dd@intel.com>
 <ZWkqv+egQuph03Bm@agluck-desk3>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZWkqv+egQuph03Bm@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0214.namprd04.prod.outlook.com
 (2603:10b6:303:87::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB8688:EE_
X-MS-Office365-Filtering-Correlation-Id: 1622eec8-d514-471d-f790-08dbf2126f1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BbT/Sm3ixu3TT4jVijxISvArfBRk+d0LIKsSTEG/TAXQL+/9xrhWG/i8eqWEin0AC7oYWbIC/djHB9gaOEgrg5mMa/xeK1XL7nKiA1RzVhuN1KlT04jMT3MrCb6NitKwOjIvYWTSJzGquiK/itIR7blpDBFY104H7t/vjY0IBoloPKHII+khKl7mAPuTI5ba8EigoK9079slo31IEsN1QtC7LkRObyYJglYNyxJ+8uVb5U0bvaFQ88xLQ1AMmCo/rrifDpR3Z7z3eemK9m7UFAxNZo05YXc8VJvsSsA3Y7mL8FVFcjmK0mg0uCPYbN0spVMjgQU0dWrhWVQHzQsgQtUNbYBm/JJ0ybEu+gj5rh+s1NWoXOvKkIqhvkKhS4jHSfZiEsihHQKBMrrvNkY/XbBrBKtvi+8gRpnBVVL5PkKivcmCfwG269APg/OJ67RkOrbHp8GlzXG0ItlKWEFYxnZDPgTqvxeR0cgXbKdKZ6pqrW27Ry0fUcIc8YdFsfJ4nN4KN4hTOhvdJ+kqgQhYszeHlNI9rFJ9THDULAQQ7kX/YZ0gp+caBN/bfXCrDIQCRFJbm/ZTTfmzk5DsDV5zkVqT6WCiDFZ0hkA0ZVKEKL4oQwdSB8AHdd6zHcMsPBwE1Vs+wY2MUVnHswT76K+dCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(396003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(53546011)(478600001)(6512007)(26005)(6506007)(6666004)(6486002)(7416002)(2906002)(83380400001)(41300700001)(54906003)(66476007)(44832011)(66556008)(5660300002)(66946007)(6636002)(316002)(37006003)(6862004)(8936002)(4744005)(8676002)(4326008)(38100700002)(2616005)(82960400001)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFhVSnRYRDR4YVRsQ0pSRXFLdWN6YXZDK2szZmVVNDBuZ1lFT1BjSHlqSnNL?=
 =?utf-8?B?TnozbDBLeUZmLzM0V1ZCSG1VSnZUd0xvczZmcVJPS280SHNIdzBkb1IwejUw?=
 =?utf-8?B?L0hNOUd4dmZOUUFId1V1YnVDelppWnl1K3FRa3lQYnl5VGMrUWw5ZW52QXpC?=
 =?utf-8?B?YUVScXBnNWFyVTlpQlhCd2R2RW0vaEgxbU1QQnJpYlVlNWczWnZIN1RaQTlJ?=
 =?utf-8?B?YlBqejY0V3FGVHpBdWd5K3BKM0lUR0piYVpnQlcwcXc5dVRzemhTMDcrZm1v?=
 =?utf-8?B?MUhuWTRZL3dMTVFWQ2xNR2x6b01mVFFxMTJwSlVRYXc3UHl4Q2grdFZRQnpR?=
 =?utf-8?B?VWdDTVltV2JaNFBBeUdKRHhpV3NQSGprRDUvNkwwOVA1Z2NmcmhleGhWWWFF?=
 =?utf-8?B?MWdYZllhWHpKV0s3Zm0zQVJuNENLNmM5YW1ad3RLZDFiN1pCdjE5VVg3TzZp?=
 =?utf-8?B?WURkU2RTVUw4Uk91c1dyVzltNmg1YWtsQlpXN3BnVnFDWTdTdmNTUFNyOGd6?=
 =?utf-8?B?djZIMTBPblB1VDJkSThIV1VaVXJHL05mWUR2a0NVOEgyc3RUbDJUWFV3MGJS?=
 =?utf-8?B?RUNBaGRYaUtIWFdLSmNtZjlhcHh0QXJmUGRJeFFacWJoMHZGcmRUcWsyTmRy?=
 =?utf-8?B?TkNBN3VieG1GVHp2WW91VVJKZWtwbnk5c2g1SCtzMmhzdDBOQ1JTMFp4MWVV?=
 =?utf-8?B?TnV5Z1ZFdTF5bE1DREtrNFdXOHhvMkN2aHBxS2NkblBvSGtSZ2tleHlkTU5H?=
 =?utf-8?B?bkhSb05uclBhUUpWTnlGbUpkdjM4OHNWSytJNFU2WjdhaXFGYUJyeHJmb01U?=
 =?utf-8?B?em43MlJiVUZDdHVEYTdSRFNTQXNWN3dBVzg1SEJ2TjhSbnFCemFDQWZOTWxX?=
 =?utf-8?B?ZEtyUUJOUGlsSGhZaFp6NUhaWGU5NG1ycDdVMXRGd2RINGY1Tm9VbjlYUkhM?=
 =?utf-8?B?aVZSS1lFWmxkdHdzaUZQb09LVVpPaTNUOHJQWjFhR21DMTFtTlIyY0Y0ODFI?=
 =?utf-8?B?eVhZZ056d1JqL3FhZ1VJNHNCSUt5dFdnWGJpbThINjM4NThFRWZVWitjK2xy?=
 =?utf-8?B?NUwyWmR6YzBtQVk2YjlQMVZEL0hXUGp2M1c5NmVEV1ZvVDF5Q1VuWU5taGpL?=
 =?utf-8?B?YmlHaTE5MFJzT2NhaGpKMU9CSzh0TmdZTFEzdm5IZzFBeG0zZ05JVWVlSDZY?=
 =?utf-8?B?alVaQzJNL0gxMVEvYzZlZFBjNTFTSzU5T3NLNTFraTAzRHI0SkFlRCszVzBy?=
 =?utf-8?B?RGZlR0dnMURUTm1mRnA1NHdVWFhCN0w4U1N0Tmh5V25hUDR1ZFlJTktlaS9D?=
 =?utf-8?B?S2hxSTdqd3lqSGNPSUNNUjBUTWUvUmlJbyt2VVNSZVlhY1FzaWRmdjJYS3Ew?=
 =?utf-8?B?QzdjQW1VUzZlODZxLzZWQzBRWnJ4SzNIWC9sZUVNMGVmbncydUJNSG5WN2Y2?=
 =?utf-8?B?dXhxczNaTkJtcWtsaHlSY2pyRVVGalUza2E2eTI0eXZKeFp1ZUdtSGdnTHRa?=
 =?utf-8?B?eXU3Q0d6UlkwVUF1aGdpQ0QweGF2Y2pFbHp1MmgybHJiMjRNM0FYUXp3RUlR?=
 =?utf-8?B?UEZqUUoxVjV2QU9ibWZ1eE91Qmk4R0ZVTGV5SmNBdG5WaGF3Qy9YYkllUEZ6?=
 =?utf-8?B?QnF3ZTF1SGJzbmx2Q21nOHkvM0dxMjExSFFxWTB0dFhpWjI5TDlTQyt1N0tW?=
 =?utf-8?B?NFhucTB3NmxVeVB3THdVVGRwM0ZRdTlQdGZCaVJtN255VHdEUGlUY1cvcnJw?=
 =?utf-8?B?K2djcG5UVkNaVVhNM010MTZicjdmTHVmZ0RCMzBuVmRTdy9KZWVBR3B0TlIy?=
 =?utf-8?B?MWZSTXJWbGZ4M3pGOFpaTlM1NTAwdXU1MDVMcXY0dGxIS21HeU14bEpQTXlW?=
 =?utf-8?B?TzFqUmJLK1Z1NW1STytLT3JSVkQySVJGSVpobXkyZHVxMG1XeFFXV2F6Q2Ey?=
 =?utf-8?B?bkMzRVNpZnVzcjRuQyszUUU3UkQ3RWtJNy9LQm03eEFaYnE5bG8wNlRWMXcr?=
 =?utf-8?B?V2FvMDZRWlNabVAyUHJ2U2F2YXdrN2RlZGoyMTlGMDFvVnZWRlJvTHE2MFFX?=
 =?utf-8?B?bTZRM2YwRFhGOHNsWmVNRk9CUzZldGtKejI5cXRkZGpJamY3MkJYMFV0OXFJ?=
 =?utf-8?B?RWJEQ1pYY014WnA3enBySk9PVGtFSkVEaFVJV1FUazBBQ0xMN01Uc0Z6aHZX?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1622eec8-d514-471d-f790-08dbf2126f1c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 02:08:39.2212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6BVOv1VOt84K1Hf8n0Dq0Vx1u40NyCQdYP1rda+FtakHWdwfDxYLXdwuNyjeOs4uy2JW5FZpb91IwgivMsOMu/K25TrBgXnPhTHsUy+tBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8688
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

Hi Tony,

On 11/30/2023 4:37 PM, Tony Luck wrote:
> On Thu, Nov 30, 2023 at 03:40:52PM -0800, Reinette Chatre wrote:
>> Hi Tony,
>>
>> On 11/30/2023 2:43 PM, Tony Luck wrote:
>>> On Thu, Nov 30, 2023 at 01:47:10PM -0800, Reinette Chatre wrote:

>> for something that does not change while not holding the hotplug lock. Reading its
>> description more closely also makes me wonder if the later
>> 	num_online_cpus() != num_present_cpus()
>> should also maybe be 
>> 	num_online_cpus() != num_possible_cpus() ?
>> It seems to more closely match the intention.
> 
> This seems problematic. On a system that does support physical CPU
> hotplug num_possible_cpus() may be some very large number. Reserving
> space for CPUs that can be added later. None of those CPUs can be online
> (obviously!). So this test would fail on such a system.

Thank you for clarifying. It was not obvious to me how these bitmaps are
different with physical hotplug. 

Reinette
