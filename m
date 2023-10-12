Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A0E7C71F9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344081AbjJLQDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbjJLQDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:03:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E67C0;
        Thu, 12 Oct 2023 09:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697126624; x=1728662624;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jiv2nPHXDw93DsN3eYFv4pTo38BYiwufAiyZGuzOs9g=;
  b=NmhSgcohraRjXAUigdUQ0pjq+VmBGFtAyjrVVFCJpZTgIK6EjJovJmUb
   Nx/0QOWFJEShWxd7QQO8hJeRwrCuSMVjDJRY90ijaQXGsL67g8OpDOMEM
   BMORVRjSr15XHbYBGQj0RY7gvRrvQHJswVDW8YPNjOKFWEdTQmCZKdPss
   fTXJJEeBMjvHiuGDP9hfYAminBzW7SINCGr44L6K0YuSzyX6puHAc6aCG
   AMMz6h3vPri6IxPkOFry20k1CwzYF4ckMLBH2XlPParsiZMYl5JKah1AX
   gcFVq4ecDq0/Jwb7Gsoztr6yX6CY8gzVYugBYIkGX2URGnujsJ0TK4Pz+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="383815489"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="383815489"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 09:02:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="898171905"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="898171905"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 09:00:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 09:02:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 09:02:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 09:01:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6KfuY625BqDDERSd09lXpSkh1paNwTQau1PmsbK9AX4VnKOEIWIWbVWO1zyAJNhk1g6xSzx/nNWl9oo3nLMb+x9Sy+3b5pob3EO4R4yU7Xkg88hr/gNBolSspJji8l8KwhLduEy2DxviitZmnccsi5Fj/vANa8FsQ1CvV6mgK8+qVvzsx1lybDKUPOIL9lCZ/OXMY5Y9VszpZKlSvpym4G9KT59C8x+efz3ik8W7HWBNxNQrIdrpC6g2TSEBVQLQcAfkHcDse8Dizz+D7dhNwDUNwPFHWDsHjWawSUyghnTF8CAGFd2epT55u9mIfM+8W3f/+15qDzFSApuegxG9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiv2nPHXDw93DsN3eYFv4pTo38BYiwufAiyZGuzOs9g=;
 b=DAU0Dew3gogGerKBHPlq/WsmJHbs0+e7wGcGKKOcDWNjxEtMI+Z7RaZs/W/Rf5lnkG+fFt0nS7SKn05uTonAVZb3W7KT2JlbT68T7U+Xppzikfn7wUYQcF5NKzl7fBT08DFj07ErIzah1WP/5y9h72JBCJoc3RF4Xw9ZPyCsUFYW+KSsndoJmHBUYhA7AGJyWeyHZDsidmqhnwaos44V4BjZEQ+IBLjkUGkUfgTmsL2uzfyTnFeqLgMgIWYvxi1Y9f/KfqwZhCN/ynYgdtSjLyZz3TnTDTEBLxFL/IxaaW/BqSH9tO0ZD3T/XcvksI+qzJJAU1SSN+/5YY+geqOAFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6120.namprd11.prod.outlook.com (2603:10b6:8:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 16:01:56 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 16:01:56 +0000
Message-ID: <a02c0f3b-2258-425f-94e4-a76739a24f00@intel.com>
Date:   Thu, 12 Oct 2023 09:01:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 04/10] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <20231010233335.998475-1-babu.moger@amd.com>
 <20231010233335.998475-5-babu.moger@amd.com>
 <71539687-13cf-405d-bf7c-27480e49e872@intel.com>
 <fa03a5ca-fb16-47bb-a2c8-5cc4d96e54a9@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <fa03a5ca-fb16-47bb-a2c8-5cc4d96e54a9@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:303:6a::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d8d0a83-7040-40c8-0b03-08dbcb3c8f3d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RAzDdDk6euzF1zluMUophLbDn2yP7mFZdfWTM6AMQKpZJvZGq5QDGAjRxZPqu00ChWEqaq3zMg2ewDUL/I1Hgi5xJlNN8xsqYgggt1/rRCOqIgAS3dUISzaxKLjdsHOFv+2tSFCUwUnO+q9rKK0cue/j9pqhvJXTBCXvSuuIa6EosCClTbKktOTZjjV9AFu7aT9SJmMim+7Wj/0TotC9g96HTExodpnlcuj8lz4WbUOK3XirRGs3XrD+6HBvbA7enQd2okoXNzWWQ0KrBMO2ojp2jUa9rk8OGPMYLkow5QZ10cvYJVX38n/NppjxIRRBvD+4WtChi+7j84ci+NaoBsjXkRHkWQAeNZP2KTgt71ME78yqBh9adh0g7IWb4KJl+Qsi6MXyutNnwysLg/kr3SDO1sio/WBZBfGRz5WHOwpDHEUwNKqB+ewGaLLzgJJ5tSxuwOI6Z+3OSewdiTM/i616dLIbN87tazEsybXx4VW1Xea5mShscOQ+1U+i4u3gQSyegykGbXcoZUp9JYoPgxfQtaCFWEUAqQy3Prw0rZI+cPSVLILH4NhxS4wx5IYdJgcifbEf9PQPCa36irHeU82MZhsiDZtfoEyKRR3Nqzn/OBvYAcWgk+M0zgNEK5RsNJfHUFwNTpm6xYNuU9WsNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(136003)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(82960400001)(4326008)(8676002)(8936002)(2906002)(4744005)(6486002)(31686004)(5660300002)(44832011)(6666004)(86362001)(6506007)(478600001)(31696002)(53546011)(6512007)(7416002)(36756003)(41300700001)(7406005)(38100700002)(83380400001)(316002)(66946007)(26005)(66476007)(66556008)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVYyNTJ1YnlSS3ovMWRRVmppZHBzTjIydmhlU3VTTGc2eUY0YW1JTlM0L1dh?=
 =?utf-8?B?Mjl3Q1R5SjN4QWZJeW5NRnU2b2Z4ck1XcHhxRWRXSWY2dDJqamdIcTFaSmlv?=
 =?utf-8?B?Y3BienVNMGh3cXBOU1N5ek5PWTBRUU9FVE90aEhYVWdUNW5rSjRITlNFV0Fo?=
 =?utf-8?B?eGdYRnJzbzVOZ001SDRMdTd2ME85UURHVGJlY1QvNDNoN1BzTnpVWk51cXFs?=
 =?utf-8?B?WXc5OEltcVhsZldBdXVjdWFVcnpyRkFNellRMWozQmVIU0ltdmJiYTdRbzRB?=
 =?utf-8?B?dENveWdUMkdLcE4wMFBUOThnUEY1d0ZYZTl6ZUEyWjNhQ3ZDbUhmdXRaemg4?=
 =?utf-8?B?a0xHN3ZYMUxVYmt0RWR6SlVIMTAramhRckNoK3JBWFVUR0N3TFF3dFI1WWtM?=
 =?utf-8?B?RFNYSXlPeTZGOWFGNmd0T0t4bSs2aGkxaVZXalB3T2NMU01MeFR6eEFVUHhx?=
 =?utf-8?B?S3dxVEllWnMvQW1udWNtZnN3SFZ1bXF2WklWR0xoUmFicStCNFhmM3dFcWhp?=
 =?utf-8?B?LzBROW5YUEJDWTJOR3kwZ0JsSzFCb0lua3cyT25BTG9Gd0VmWTExVlFXdVBQ?=
 =?utf-8?B?SitYem4vanJGaWZFV0hTc1MrNHF1SG5SQmJJTjlaZG5oRmM3aWJ2WTZZTkth?=
 =?utf-8?B?aW9OZVNKODNzN256b1NRTFFEdUg4V0JOQnRLVHZlajI0dys1Y0pFOHRPMkcr?=
 =?utf-8?B?SDU0Rkx1OG51eEFVYnF1bEZBZWh3WWUrYUJXZlNUVnRDdlR6dVQxYXF6Qm43?=
 =?utf-8?B?RDVjbm9yRWhleXVuZ3hnUjFhQWllREZMQlVLMmc2Z0Z0RFpnVGJ6WElJZTFI?=
 =?utf-8?B?enVqQ3ZlSGhBS0RqKzVITzZFL1VHOXpWZ2dBQ3B6eC9zUStTSkJVdy9kUTN3?=
 =?utf-8?B?MXpuSzIrUzRkOEdPNmFINmdHaW5tTXZFNTZkMURTbitoNnhDSTM4QlZ6NVVv?=
 =?utf-8?B?OFNabitiWFEvMS9BWEU1WS8rQVJkMFl5V0hjZ24vZWdLam9QbDNmTnJ4a0dn?=
 =?utf-8?B?Q05KWTlXNXozemttQzBwTTNOWkpuUklodlFLdmYwMVVEVlBIeHVoeDNoSTJB?=
 =?utf-8?B?bVFXUUJEckNLVTduR1l0a0VLNUVoUExHbTExbUhVTm41NlBvdEJMV2JleWxQ?=
 =?utf-8?B?MjVrNXlIajJubmp4bEM1cWk5dGZ4bGxhZEpVekJwcnlFUnVuUXlVaVpBelEr?=
 =?utf-8?B?M2svQzZWK3dBaE9pZFBaTE9UWVI5Z3RrUGROS2JFM01WSnd6SkRKQ3RBZUdt?=
 =?utf-8?B?SWdIdnlMakRpTDBsSk9zRHNtNHhncGh1cWJVOUM3ZlcrNDJRcjl4c3hPK0dn?=
 =?utf-8?B?RWI4MzN4ZFN3aCtDVk44OVREeURrTG9TMHZpbXFjdENEOWI2NVRvMDlEbW8v?=
 =?utf-8?B?SGxRRm9IZkJkcFlzWGlmN2JJczFDVlFKaFVlQTc0YUo2V0JtbkVVRXF4SU10?=
 =?utf-8?B?NGhBWkIxUkQwNlNxT1NJSTRvMkJDUVBmNFFHaVlmMU94Q0l3bzNBOTN2WUVM?=
 =?utf-8?B?T3FnWWJzWVQ5c3JkN0F4VjhpOHZlbUF2dDJsNHNQVTNTWTF2SlM1RExBdnpT?=
 =?utf-8?B?UUFCQVNwald1RjRNQzdSTzRwWHBRdld0K0Z2NS93b2lvZEFRaDZYV09SVjJX?=
 =?utf-8?B?WEJ4WTFPd2sybGNxTSsydWk4dHpyaExUY01VRjVNbXJ2VVltQzNnN2JYYzBC?=
 =?utf-8?B?a0lqQTlyZmJSY1l3RVBtU2FXWTBNM2ZxeXlIQ0Y3ODgzT3Z3ZWlmSFpUM21t?=
 =?utf-8?B?NzU5L3lZcWdJdVYrN0tQNFBvYkFDOStpcy9ZTTJrOTVoYzRCc2NCMDBHY0pX?=
 =?utf-8?B?d2xLMmxZbEJ2UkVPdHhsdW1uenN6RUlJZ0NjeTdTbVZLaWdwQ0dOZUtFNU02?=
 =?utf-8?B?SktDbytFTkl0Q2o2d0FRV1hCenIwT3NxUUxQMUlEaFFvMU1jOFNERldhRzRU?=
 =?utf-8?B?aWw4Y3UreFVlbFdsY0c0VnlFbkJUR28yNGhpRUh2OS93SXNpSjIwb1NScUNC?=
 =?utf-8?B?TWJleXF1OTgrN1ZpWWEvdTRWMWZWaWsrWENTN2RLMUkxSzZzaDZvS0tMeWJW?=
 =?utf-8?B?dFRqblJ5QThneXQrMkJ6OFFDNkxIcENNQmlPbEY2V2E4RUQ0THJBZ3Z6Tm8z?=
 =?utf-8?B?K0Jjc1Q0UDZjcCtja01VUWVwSlFUcjdkWkx4QjdMeXdJeFNDamNoUWtMRkVq?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8d0a83-7040-40c8-0b03-08dbcb3c8f3d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 16:01:56.6309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqHUyZ5U550ny+aBTSzYFJUTDmEFeemCG8dl1oRAzNCTZLVWhPqMkBQbqxrRykKACSUkIiFu+RlSeurSfcvbk8ZgbrJRQ/u772jBkNVMFsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6120
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 10/11/2023 9:57 AM, Moger, Babu wrote:
> Sure. Will remove Reviewed-by on this patch. Please let me know about
> other patches when you get a chance.

From what I can tell, apart from moving the flags text to Documentation,
there is only one other code related change and that is just moving the
RFTYPE_MON_BASE definition to a later patch. That looks good to me.

The other changes are all in the commit messages and that mostly looks
good to me ... some issues seemed to have slipped in during this version
and I will point them out in responses to the individual patches.

Reinette
