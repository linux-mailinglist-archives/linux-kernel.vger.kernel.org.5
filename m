Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B811B7B7329
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241180AbjJCVPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241179AbjJCVPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:15:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACC4BD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696367716; x=1727903716;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u3yWX5ZWpRco3odSudNrXpBqp1eh4j+PiNUFxX1VH/k=;
  b=EM4eZPcVjS1tGEZNcl0+cIFYCkQvUUG7tS1/r3mRcnh3xHJBN59CmJyU
   Nd6+3EDzHb6dIYSzhRbeOsKzg1pcJF78my/tRfYkTtLi7KuNpFk1lMzWk
   QKXKdL+sJhxBnDIjGcOv+5BZvxFBT1VnF3vapkNDtWr5JUITz6ShbWv+C
   kWwsxXLzyVcBP+ifayjgskZ4IVIZh1023t/5rQrtFq3MmlCqeo/7i69IO
   nFai9VuTzJxbUbirc6TBLvo/1+GMZJkrAt8Zid7dp4fgKaUapDraAePUK
   F6OtrnH4M+zSWOAqzF8Ohj+kxb2r7mGoA63lwQcCniRS5lwmUuKg4WLHl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="368038012"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="368038012"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 14:15:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="751040996"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="751040996"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 14:15:15 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:15:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 14:15:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 14:15:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCd6y65yfPtt39lxQnPVBuMNxzkqjE/Sa3B/MN+snfApAnaVOgx+nTYPBHoMhKT7gRVEJsMOxgTuE55WqjEERiFJizaesXick+bhUhq5rhv34IJn/q8tNnlTS3iiObTurhHsBE2S8UhT245ctbqiJwqEO3aVWFc0SeyRnKZSmu6DaZ7bsYyPWuhQu4AnL3qX5T8J6Ysr3lc8zoFWs2ngqINaHjfDwJ61+Fj7AEsTq43tccGQN+2MM55HZDJwblzeGUJ78kCBI8gAigELT1/oe/pC+XtEuoXiRj1xMgRKnOhbcrJrkfwGPKtfuMQJ/X/aWYCEtoXTvHIUm4EjZLSUrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEtmGS08KBSMqP0k+rN5h2C0WB13GQVcAiGhlCNrsQ4=;
 b=THH/N90kbDDv5EtogkMJ7Jng3idd7n9ZhjiD/S6majj8/ZVLaQCttCoAzzdTtjYqvccsy4SQZaWtNNR4rvmgMbI6qLkR1I1VMzx9fYQ73ToaAWRWXAjsdP44UGlozPfaO0uhjaRh7eP7Tx/+qXxewVEyMXm6MhzaV1sTLC4sl6rck0SAnHMhpWsWHUPsK0ma9mdWK89w8Dl9ocTsPaHRB3/Zpbb/K8nK2hTXHEJ3kV/83SrUlvvbviOcRgi0VIABGGyCrLZpsHtsAeAt7tpndkPD5aEcoXQSSBJVKb+geBxmj3ypSgMfywGg+VbRt9SJ3CJgrbYDyUvNXsLBMPweNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Tue, 3 Oct
 2023 21:15:13 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:15:13 +0000
Message-ID: <94a80f47-d28d-5638-1492-f1b4a3e3410c@intel.com>
Date:   Tue, 3 Oct 2023 14:15:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6 11/24] x86/resctrl: Move CLOSID/RMID matching and
 setting to use helpers
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
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-12-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230914172138.11977-12-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: ce94bda8-f007-460e-5385-08dbc455d528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3PPtd91g4EZGJevwaZQdpzhwGHh9tErNg9YfyNAIEpkBIJPxLil/d8btZ+1sGrGqYdkXSGwK9urEnFp5Kgew+f0ebkBGFH4Wm3caO+9DTHuJC0CaiklQdy3ST02F3T5zOUhyn/GTTDWRRvJsEDpjJSkIQOOb2Q3YCGS0Q19NKWshZ0H5OD6790Ob8BNmz+QeTQgdnynZ9oS1kcND+8F88ZuyLNvEpPmpeWbAX1J3ySRN35JMjSk3LskFhy2JFI132GkuTokbZR5bQnfIK03ldS6BIcVB+bIr71BJZD2C+etNCAbUdN3UHgsrPlXOOdC031z2eckOhMZn+GKvNx1nLibLZXGlEsS+qLRgSERlF0DAMuXdOmBPtZEyLhGzvB/ulOOD4EcyH4aOxF2eHmFZ8AXqE7rvBOT8EYUGAUp6HcZAwLM+O9S+DVWQ9RfmWZYsyrtAW8s0JZJRMcm+lLEA5BStXFWaIwUyaEoKWs4tfDNu6KasZz2+zjumttwoDsOQsOpxSJDAf/sGJVvxkSEl/LH7Rr8aVwOSz+9KYX0Gs4gkQs4Ah/2s11Vld6ix6iq+3wDboUpxVH4RgxsKqylQj/PCZ3OdzqnOO6Z4BC6BcwG691M/AOPR0fIySVrTNeONK8g7kb+MkUpxBOkZZZSefA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(2906002)(66946007)(8936002)(44832011)(5660300002)(54906003)(4326008)(66476007)(66556008)(8676002)(41300700001)(6486002)(6512007)(478600001)(53546011)(31686004)(7416002)(6506007)(26005)(2616005)(316002)(83380400001)(82960400001)(38100700002)(31696002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3FqTDJrV1J2NFZwa2J5dTZ0ZlNrTXZVV3BGdU1jZzRLS1FXVW1pMmhLQ3lD?=
 =?utf-8?B?dFN6WlNKNHFKWkgwRWI1OEo0Ymg5SkZIelVQSEpUMldRbndZVFl6MVk2TVNL?=
 =?utf-8?B?SmZiZVVGZ2kzSDE0MXFSeVJ6U2ZNMXZQUER0R1E0SW9NUnM3dXpEVmFVRnRQ?=
 =?utf-8?B?WWFURnlRUGF6OXZTS05nT0FYVUVySWRVdGlpN1dPTjNsZXUvZHVmdlYwZjVY?=
 =?utf-8?B?OE5VUWV4UGtobUF0TWxxL0pORDIzS0V1TUhzQUNFemsxdHVKbjdSaVYxU0tF?=
 =?utf-8?B?UGxpMHFCZzROVisyYVZvcC9JUUZUbHpYamttRC92N2dvQXBOSENBWU1wU2lv?=
 =?utf-8?B?U3lOVDBOOVkrcnhES3g0bkRtYk9zL3ZDZ1dPVzFvZVRMSkZ3alduYmVHZGV6?=
 =?utf-8?B?Z1NVb0RYeXlFV0VrNzRVS25SR0Y5VjVIWGREcW4yNUJDUjBGTC9kUnBHdDI5?=
 =?utf-8?B?Qk93aE1mM3cvamNhRHBVZEtjcjJUc2dMOWFMTHQ0T2xYQmZDVVQxREI3bDlq?=
 =?utf-8?B?UHdIMXhEbEhGUnFIMGdYMmNSU0p5YW16cy9HQmo0YWJsSXVNZmMwQnFCdjcr?=
 =?utf-8?B?a3p0U3dVMW5nc0NrRHJOcmtoNytrRkJ2dFBheW85RHZ4aVpvMGZKRzgzNXJu?=
 =?utf-8?B?S20xS3ZsMzRDOE5MT2pNd3RZdUdDbUQ1ekgvWmNLMHBFTFdVYnN3YVFJZWIr?=
 =?utf-8?B?bkxlME9tRW4ybUJodWtTc2hYdmMwTGNCL3hjSXBnS2FiaEJoT2ZTSURJSmc0?=
 =?utf-8?B?U0VuakZLWU54YVR1Ry9jVVdrczFGWEMvYjg4MUl2YmpNOEZTZDNCR2M2dGJo?=
 =?utf-8?B?OFhMWXRRNWQ4b0Q1c1l2UitkZ2VmUVdPZkJhcE9aUVhxaG52Ky9zcmxKWkZJ?=
 =?utf-8?B?Q0s3Tm8wTFkzTnF2NFBFeGFrVGl6N1NzanBtbHJERFdmOGdFWWRseXh1VnEz?=
 =?utf-8?B?Qk1yaU5vdW1ZMFZsOERENEJBVzUzRHJyb3N3MkRlYnVjOTZrOU0zSlJ3d29w?=
 =?utf-8?B?OTlXTzFVWFpZcFUrM2hlbm43UHAvNVgvZS9CODFDRnJwS0RDVzlaN3hKa3Yx?=
 =?utf-8?B?TGcyQTNhSjF1UWszTVJNMmpkWXhRV3BSTXh3Zk9nSXZWekQvQXBHYlJ0S280?=
 =?utf-8?B?ZWpOMzhJM3ZMd3N6QlNuNk1VNDRPZ1ZtZ1I2SWFkSXV5aWgyN25vL0w2STdD?=
 =?utf-8?B?ZmRIVmdlV1lGNWIvclRIaloydjdYZ014a1BEUGlJTnVrb3hGRkQ5dEMydHhZ?=
 =?utf-8?B?T2JqNkJ4Vk9CRm1kQjdaODk1MFhUU0EvZ1J5UnErK01GNEtMYVFEZjdzelZa?=
 =?utf-8?B?Mjl2VjB3Z1VHYm9oV2ExZG1oUlRvT3RIclQ4YkczdGNlZXlCOXNFMVY1SzRh?=
 =?utf-8?B?cXZkbjNMTzl2ZFlPS1VRMDd5NytvUkhpYWZWSk5hNnVET09aNjF2YUV1emsr?=
 =?utf-8?B?QmFnRmRva2tyY3duRERqSDd0L21weEoxYlhoQzIzb3E3ZzUwakJhKzAycXFN?=
 =?utf-8?B?a0N5RkJKQzdDK2ExMDd1SWsrenlNS055Nm1jb2t5MHBxaUFsUnE4SGJmenNX?=
 =?utf-8?B?RGY5OEFQRE90eVh2ZnNMT09ENUE0bnZMVldXdjI5Q3dOcHVVM1Y4NlR2T0ty?=
 =?utf-8?B?SU9SdnlVZ2dYREVEbGhpcUJnR1FhaTU0R3QrdlZZZk9veFpFTlZjcHZCQnB3?=
 =?utf-8?B?UkNPekFnbVVhWE9zaldTemlKYWJUU2hlRkYweC9ZQlIzaWtMQXJLWThqTGlY?=
 =?utf-8?B?V296TWdTTFBVZmZNUXhYQlN3TDFVY05EMnBjcFBTTFVnOE1VVCtENm9tc3ha?=
 =?utf-8?B?Y2N6THFqWHl5bHZja2xFWVhzSnBkMUs3ZW9YV09nVE5wbkd2Z2l1VERsRHBZ?=
 =?utf-8?B?ZTN1MWRFZlppMkorZHpFZ1g4Q1QyMXhpc1JNZklTY2V3Y2NLZHQvK3hXYjYv?=
 =?utf-8?B?OEZGMlcyL0o0ZlN5K1lWMDI2cW5WeEdVcVlWMk52MnJuWmdUQk0vMlBId1Ri?=
 =?utf-8?B?dEE3YzdYMlZZRmFQMHVHdllnbStvVGFIdWwwSjZFWDlzdWUwVStSMDliMFBi?=
 =?utf-8?B?b1dhQnNNMmQ5N21SbGpycGRBbS9ZYXdUUWcxd25NOGFIRDNqaUpUVDhpcVph?=
 =?utf-8?B?OEZVQWFGOXpoTTlHczgwWXJuY3NoUk12VkkrSW4wbVoreG1sdFRSODZQWTE3?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce94bda8-f007-460e-5385-08dbc455d528
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:15:13.1796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSKM6N0h2Janjdl4v6Gj5VRivc3M7WATXONRm4NILyVl8vX0WwVuVPv6PXAdeM78UCetKBXWgC64eFvbnQt9lBPdlcHrlEwLEeegaKNkLn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6059
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/14/2023 10:21 AM, James Morse wrote:
> When switching tasks, the CLOSID and RMID that the new task should
> use are stored in struct task_struct. For x86 the CLOSID known by resctrl,
> the value in task_struct, and the value written to the CPU register are
> all the same thing.
> 
> MPAM's CPU interface has two different PARTID's one for data accesses
> the other for instruction fetch. Storing resctrl's CLOSID value in
> struct task_struct implies the arch code knows whether resctrl is using
> CDP.
> 
> Move the matching and setting of the struct task_struct properties
> to use helpers. This allows arm64 to store the hardware format of
> the register, instead of having to convert it each time.
> 
> __rdtgroup_move_task()s use of READ_ONCE()/WRITE_ONCE() ensures torn
> values aren't seen as another CPU may schedule the task being moved
> while the value is being changed. MPAM has an additional corner-case
> here as the PMG bits extend the PARTID space. If the scheduler sees a
> new-CLOSID but old-RMID, the task will dirty an RMID that the limbo code
> is not watching causing an inaccurate count. x86's RMID are independent
> values, so the limbo code will still be watching the old-RMID in this
> circumstance.
> To avoid this, arm64 needs both the CLOSID/RMID WRITE_ONCE()d together.
> Both values must be provided together.
> 
> Because MPAM's RMID values are not unique, the CLOSID must be provided
> when matching the RMID.
> 
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-By: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
