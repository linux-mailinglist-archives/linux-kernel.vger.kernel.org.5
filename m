Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBFA7990E8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241642AbjIHUQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjIHUP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:15:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4688E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 13:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694204154; x=1725740154;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WleZeni8aymF90GuG/Idt7hFqcdAs+l2a39xS8eXsrY=;
  b=RqpBLIaURZ5LmILHE2dFySF+BSlndoz4bBOA5do94maBpJlDCFHbJlN0
   rokaZm8u74yVpoXUcK1n1kaXcbA+TyxRxuHMTrDnAYCDLbW0jeX/ZrAwd
   nlrCSSHeQKLChHq3Iu1/Ayb1hYSInSb4D3dqHkgUP74fMhpXLFhlbQqL+
   374j6kZ7/+9wL/JRoENGVy21tqoPKIqAZi07xLc2MSVVK9Y1xnXXQPngd
   jTmrip3F0GkpQVS92XZXr04WZ5qXJCIl8C758K3XFurJ4fE5a9kc0bLw8
   7cUzN03KBL97xkgyumUzzLyNfheu3xY3YzWV07CUCbZjsqAL5FOdGF9WF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="381559774"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="381559774"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 13:15:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="745728342"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="745728342"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2023 13:15:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 13:15:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 13:15:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 8 Sep 2023 13:15:49 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 8 Sep 2023 13:15:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxC0QfQdKq0xTqrI03GCQNWT+urY8FthIJOpLUpsmgZFaKVCH/G5/Z00d7EJVQvFgDOnvn5AWss7Ac3Sdjg2c8QlRy+fF7eVqHDjQAQIjsMFL5j9jfHw99yMkPkMb87ddzfggWrJzPIB85nifdg6emStpSNvMA0HPW3sem/36KE1GDyxASin9Mwnyjl1ZYO+jWadXG6E6L+FSyw0ZZFrHsASzy28mUX552piW1fFZHwf90WnK9CKiXlvCsmWf07XDk5orUT/TWMZRkWnHqA/x7ki8/nq7PtJv7GRe9zXkVqMTw/fcjOcxRHqmPP3uA+hm/ABg8DBQr7+kIGjbiQykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wR0CWrQxJ2+kjDvLfYVuirWkCeKebhvoBiimch9Nafc=;
 b=cCD7S237WwMCWEJEWSljijebmna0vHbguP7jzXA/MnaZZlD5TljGIy2j0on5pMWjGE/VWDsicFl7RXUVilfu9Q1lgT76BibzWnYvZOhwULPn9aaT9GKMAB6GU2DJDLThSCXktepS/zPX5L2ufbb8oqJCdKWVXrr6f9n8vweLQctXYEl0iqeqb7qtYFgzG7msZNmpFhcUsDd27HOrhJh0fIoaHuaq0ok+gQREJuvPOfrodx4mwULn8fS9rcZrpfUA7je8K0pSz+QfWhtG6DEGzVD04Xn10LvLUyA+khuHp8FYw1V3DKKGFBXc4NE00QAUDH3w/yrg1XMmBAle7J7u1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN2PR11MB4695.namprd11.prod.outlook.com (2603:10b6:208:260::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 20:15:46 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 20:15:46 +0000
Message-ID: <5d4eba94-659f-ba18-6214-027e565e2d45@intel.com>
Date:   Fri, 8 Sep 2023 13:15:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
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
 <4a0f777e-5dec-296e-c326-61e3630c3608@intel.com>
 <b842c00b-7537-a14a-1a2a-a9a17b98bbce@arm.com>
 <5c0a3df6-3b1c-ff99-194e-3c7901ffa716@intel.com>
 <9d69d0ca-212d-9b1b-3001-9f56731e48fd@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <9d69d0ca-212d-9b1b-3001-9f56731e48fd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0052.namprd16.prod.outlook.com
 (2603:10b6:907:1::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN2PR11MB4695:EE_
X-MS-Office365-Filtering-Correlation-Id: b83c8d71-0d29-4f25-3e67-08dbb0a862b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /R2DKuskvATED1bvhrJbdGZV1G+mGdbQt1DXGhh9undfjIjDrQcvc3W9dx+a5E1nS+nIa8Pfn+5ZUmtlq3ANF/RZu/LYNcrXsghamlNAj74azz8kZD9yn2DH3yy7s9YtUnOhudF7lkP6Lkc9ljADTroL/5abWYZBVQIAtlhIkxmKWiQXMDeGISEMI7+PvXjKdHi6X0JQ1Q6o5GCtH+PxRufbzfdH7xADfeNZpW8v6Gtfdzi9QR7uuoYWK2xctHyeBJWnn1o+K/Pyr2UHPk6uOzL+joqaR2Q/qPM0scQuXg4I16dg0f4dR9dX2asoLx3LPWiPBwNaNklxC2ICGkBNsfyIOp8OWSH2pgPPRjD6OfoFBpUu0975RGeSieOq5EN6JXlz8LHR7NIhcs6F0VggVu6fKYiL1uMUnvgDiGgSbqMcwVArfCaWcdkWI3bbleoOdsEAmrGQRCZoOxqLmZ91mocAxPwHaIA428Kcv8sSVLgNN1ru3R7ka+EQg7l/XFDc+aTmbn9tbAKeq3xuxMvuJcUBFoRqth5zckmSqrODdspxyAAOY3DUCWciSilM8HoriyEINXnGmeep6aQlx58DHBZRSIDxtlOKXceiouY0zeelK1Vxl7RDl/lshd6PxA9vTc3W+hMX4QGo6OjtKwD2HA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199024)(186009)(1800799009)(82960400001)(38100700002)(36756003)(86362001)(31696002)(478600001)(2906002)(31686004)(6512007)(53546011)(6666004)(4326008)(6506007)(6486002)(8936002)(8676002)(44832011)(5660300002)(316002)(66476007)(66556008)(54906003)(66946007)(4744005)(41300700001)(7416002)(83380400001)(2616005)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2ViMXRvYk81ZXJUNGkzWG85SXFtdXhoSUsrbER2aXZiZEFNNXhHVlZVaWtx?=
 =?utf-8?B?cHBWYnh2RE5nSjNNNXRNcFFoQjAzcG1VWHFuc0NtcGtuK3A2NDVwaXRhbW95?=
 =?utf-8?B?N01WcVUzU21ENFRNdVFpK0pTZURXa2ptbDhIbEwvQnRLZXFwdkVDZTQyT2ZY?=
 =?utf-8?B?eDhBdGQ2N25QdUdSbXduQ2VtMS96V2t4R0NTWHRsOFZmOFRjT2NWSDFLQXNY?=
 =?utf-8?B?SWZTcFVuYlhhUjMrbVdFVklqaVpxdjcrSDJjZVRCL3dsckRwUjA3Q05IV3Jv?=
 =?utf-8?B?d3h2MUFyaExNSHIvSUY0K25SRWdscHFpb2lja3hiS0oydXBqaS9uQ2ZDczhS?=
 =?utf-8?B?NW9rSFhzTEZWTkN5WCtnSEJQa0FEcXFXdlp6MHdFS1VJSzVNbzhtdGpQajdw?=
 =?utf-8?B?cTV5VGMrZW94TGRrV05vV1ZhMGlyYXdzbjdNR2prWTZjMWk3aE5WL2c2VllB?=
 =?utf-8?B?OGVRUmtQUno3OTR5N2xJWVFqeE1iOVBpYWZDcDE4M3hRRmdWeW9jZDJGZ0Z3?=
 =?utf-8?B?NXFjM2EzT3UvRzM0bjdhSU5UNXFpSDU3cnR6aHpkVnlVUk1aMFMremljd0Ix?=
 =?utf-8?B?M1RpdmQ3dnF2SFk2d3Q5dHhrSFhjWEwzMnQ4cnNrS3lEalk5MmNXTHB4b2FQ?=
 =?utf-8?B?YWxSRy9oQ05rcEhEVlQ3TzRhNWsyd1EydndmYWIySTliMDAyUldrM3lPTUxo?=
 =?utf-8?B?dTBkbWNZenF0bUx0aEduaEFkdzcyT2JZOXNwaTEzdXJkM3kwbEZXNnNtcFlE?=
 =?utf-8?B?U1NtL3JmTzg2NmVudWliNTcwQVk2OUtMTnlIM1daM3p0aWN1R0NyYXp2bDVl?=
 =?utf-8?B?ZHR5MUdGUkxIUFhSZ0JGeWVxTWRaL1lUVkN4NkR0ZHlvV1A2Zy9EUDdZVEtL?=
 =?utf-8?B?QzlTR1l2QVRBdFVrYzczVEJBajRJSWFjcjhVUEUyQnM1TXVMeGpPZVEvSng1?=
 =?utf-8?B?VHZtTlFxV1poWUJxQTRhL2U5Y3k0RnZ0ZnRMdm05aGJqeENjMEk1NmVYL0hH?=
 =?utf-8?B?ZjRHUGNLc2QvamFrdFIyVDd3MDhkMEVvZjdyZnJyS0ZENzJtTFRUT2h4SDZk?=
 =?utf-8?B?cnRGOGdxeDJ3OTZIaFA1aG5HR3Y2SDZJM214WkxkYUNOQnBZeDRTRXNRZ3hv?=
 =?utf-8?B?NngvRjVQYS9rZml3WHdkbXVhcEZNb2RLM21MSklGUm1OZVI3Q25qMTYxU0Fj?=
 =?utf-8?B?NDlHdnJkei9SNWQ4MWpwNXZNdWtobFJvRFFMZGVBWWtkY000OXltam5reVF0?=
 =?utf-8?B?bkxyRTYrYkhBS0ZLRFRTVEVrMWxRWU1wTjVRSjk0Q1BydXpyS2orT1pDSEF0?=
 =?utf-8?B?VTFLZ0JsT1ZyQWZsVDQzSTArQWRxT1J3ZHZLM0NYNGZTMXZQdG1oMHFnNWFk?=
 =?utf-8?B?alZYdlJvY1JIVmtGTk5Fakl6NUNuOGZQNEp5YjZqaEJiSTUwWWNPbGFJZE9S?=
 =?utf-8?B?TEVObGM5ZGNkUVhKcVZTUXRsNVVCSll0WlcrZVVxUmxnMURjT0traVZ0VTli?=
 =?utf-8?B?aC9jN25QeUFCTVVQL0pONGp4OGxGWWtkamI5T3RuYjJ2OUFmdXgyVzA3Ykdz?=
 =?utf-8?B?UnZFVktSTEVwcTRPVnlTZ1pDRlhyTUJjYXBwUWRrYUZzWi9nSnFsWXNyVk1l?=
 =?utf-8?B?ZVJRdzBxUlJDenJNR2s0RXBMa2FNekRBbVQvQjg0SXhVUHdibGRWbnVpcEVX?=
 =?utf-8?B?a2dhZGtFN2NiZnNtSm16OVltZnVPVXFFNWVVWjBCdW5xa1EyeERsZDBMNG9I?=
 =?utf-8?B?OWs3dnMzY0o5ZEJCNCtVMEJoeTkxR3RDUnVneHJGWm1BaitrRWYwNS9xaVpN?=
 =?utf-8?B?NXBmcDA4UmJXOGdpcitZQWh0cXVLbVpoZ0puVzRLd1BEcEZ5K041TDZ1cjhK?=
 =?utf-8?B?TXdqeXppM2NLZGt4ZTlsNGlkMy9aUDlrdGk5MjF2eHk2VXlmcW1IeVRuNDJ0?=
 =?utf-8?B?SFJZMzJOVlRaY3hPTXB3WEx1M2NYVHBFSFE1VTdscXFBTjRnQTA0SlB0UzNs?=
 =?utf-8?B?TDJhSEFxSkNuZy83N21MZDZnNmZjWUErWk93SFE3ZTV6RjBYbFFlRjlneWVN?=
 =?utf-8?B?eFlOSFJTamkycnh5U1QyQTFKaXZsNG8rdmhTOGt6ejdmM3VhREJIR09uZVFP?=
 =?utf-8?B?dWhDRklVZjJvL25WUXhmUnB2Z1VWNEt0ZitnUiswd09oWEU4QnorSGp3cmdy?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b83c8d71-0d29-4f25-3e67-08dbb0a862b1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 20:15:46.1428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: refIWUoomLxI4kYp/HV1gTtasX1OuiYf4nPFaNaMbu7aiQea4E1x7vQZsCXkKUAfm92UvjD9V5xdLEo9Sf64trFMJvfTkO1SFj86jPoK3d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4695
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/8/2023 8:58 AM, James Morse wrote:
> 
> That comment now reads:
>  * resctrl_arch_rmid_read_context_check()  - warn about invalid contexts
>  *
>  * When built with CONFIG_DEBUG_ATOMIC_SLEEP generate a warning when
>  * resctrl_arch_rmid_read() is called with preemption disabled.
>  *
>  * The contract with resctrl_arch_rmid_read() is that if interrupts
>  * are unmasked, it can sleep. This allows NOHZ_FULL systems to use an
>  * IPI, (and fail if the call needed to sleep), while most of the time
>  * the work is scheduled, allowing the call to sleep.
> 

Thank you very much.

Reinette
