Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC7380914A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443807AbjLGT3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443571AbjLGT3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:29:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D57A10DC;
        Thu,  7 Dec 2023 11:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701977381; x=1733513381;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aD/vNzAp+849lcIFu5LwWYy9zdWsk2PHa7Pz22mqeyc=;
  b=fq21e0Yt1FzY5jlsG4amMvT/50uM6lSQ6Kaf+0WZ2e0NTcvLTkmtoBZ2
   D8lsvTJzg3RrTRdrX2agr+sSby1k5F0PnHBX6Zy3k7qqhHWgM475te+Dq
   OHjxvNP/YHkoMv3UOVbia5m+GH2cZN7Br7qLC7ZHNiYYZgHS/wx3N7Bzd
   A5aYGij/9Ut2kmfsCVjiSVQpMSujTeDSzpO2zlyYEi2+Nzlgl18bGfWzy
   ZarYitLWsqJAJxGPC2YBjzkS7rJlE+lM0tP2n6c+mvofm4VthvZ7qWlQO
   OaIMW6DlR1ioMpMcfHWe5n+eT86JntgfklDoqbmcECjY/eeO+EyTAqFUz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="374460380"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="374460380"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 11:29:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="748076413"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="748076413"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 11:29:39 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 11:29:38 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 11:29:38 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 11:29:38 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 11:29:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVTQV14y+eCHUXQIcrHJn/QgCKLSoNCT384qq76QfR6JrJS0lkWvg+kMQV0HFVDNfjHtjPXYIPRjhYLAL3HoUC60ry+6vMHX/L/XDRBsHoYeKafRr20RFVXZQl8M7JqZ0Ijjr1dqFcGuI0tpYZFJ6W9mhS6H+erW7FTnaP3hinbvmRZgamyXkShyRQHOuTlUFm8SPKTk37pBhUqcfdU/vWX5S8sdW2MA9E9RlbqFffFTZEKHuLIDgjqL4nwqn+ZUVrNrZpaTOG3vRwDKjLBqQsa8DSP4yaAeBsX8VWNw0l3OjW2w3ofwPWryPDdtcGvBfBfzHEjw0o9ILFkrjwH3MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/EpyKucQCxUop/kkZO6IhJpQHXJRSiSVgDpMBPtbbs=;
 b=T8Cn9G1HkVqkKKfZRPuhAICXHMI2KorRgMKLKsyzACP8toc9AlG1lfxl+jt+gWQKLANfLtPopwiToMTB/jIH1UM4ps19MasqIu81b+yxwm/kabn7xmeVy872Z0oJyRy6wpK+5v17JxjBVS2q7EfV78R4qnSi0oY5ydNpH6LWhyipfigb2hxk19poz7YVf6/+4jkM3PocCH4+ObSGnsDXysjiMPuZhb7mkvKzUe6nyzFuHOa1DqBo4MCK7rFuvYiaNQwOboOem2r5XKNxkBF4CRN4xJdoAP3acGEX6YX5ANlrBkiJr2jAfeVQ03gd/4TDf/wQ6/keXoJKS2PGCW6+Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6688.namprd11.prod.outlook.com (2603:10b6:806:25b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 19:29:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 19:29:27 +0000
Message-ID: <390bbb7b-e709-4290-9bef-eed373e469b2@intel.com>
Date:   Thu, 7 Dec 2023 11:29:14 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] x86/resctrl : Support AMD QoS RMID Pinning feature
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, James Morse <james.morse@arm.com>
CC:     <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
        <seanjc@google.com>, <kim.phillips@amd.com>, <jmattson@google.com>,
        <ilpo.jarvinen@linux.intel.com>, <jithu.joseph@intel.com>,
        <kan.liang@linux.intel.com>, <nikunj@amd.com>,
        <daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
        <rick.p.edgecombe@intel.com>, <rppt@kernel.org>,
        <maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <eranian@google.com>,
        <peternewman@google.com>, <dhagiani@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <d97cbeba-af6d-4b64-b5c8-32dc437a67b6@intel.com>
 <71e85bf3-a451-4adf-ad5e-d39f7935efa0@amd.com>
 <e36699cf-c73e-401b-b770-63eba708df38@intel.com>
 <5ce67d8f-e207-4029-8fb3-0bc7deab1e9f@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <5ce67d8f-e207-4029-8fb3-0bc7deab1e9f@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:303:b6::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: a4848c78-66a1-43ec-9d70-08dbf75ad238
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3DHWox+9+KbLqsXeNiXzmwqq7zNl46Q7VGokkikp6fy8o/e05AqJwWIcqrKqynhcIqSolqlWm7C21VTK8oUQ6PTYkl2tGaTeBYLwNhsF51Df2Kttc3wHYiB40B9e3+Hzaix+qmf+Edmx24+643fNEx4liVY/p995SM9vwA6mmx5oXTqU+FGYnyH0GiOPJilvZPmov32IBx+dojtrrbhMHQG8fy3Hc5LPtLemf+YKj6Rf9ppFnC0fa1FBr8S0ZzowYGMaxhEJBrfEKpDzxIC/UL8xQl/Oa2+O0dlHyBXy5HmgK5+sM6cpwqrwQ0Vcur1JBFegnfPXGAOuTHtZOkoZ2mUtvpudmyHrEY/BlqxsoyhJ7nVgFSPwDfPVaSDnDX2QcZuZBaK+sOSTETkQCeqeOnitfvw5RNzIwjCkQX98frqe4Mxpec0ZCAjdiiy0zskkchBu7v82Mfbh5Dw/SbVZZJ3UPwy1k2DaFe44oGwW6ZPPBpsyE000UDewwK9k4qDhc+Qngf4eMMyWDxAcmL6g4tXLxQDGfgIQ0GLIcccxHddMZ+tFN/8mjP9ik3CThKasiCjztTNiOdZ/9UcDv5gMB36A3r+4VjzXixzOvAfqmeVgDkEvrzuJL1gIMXetzsOGO0o2kkfftjO1CMhYBHC0Sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(396003)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6666004)(6506007)(2616005)(26005)(38100700002)(41300700001)(82960400001)(53546011)(6512007)(83380400001)(316002)(6916009)(66946007)(66556008)(66476007)(478600001)(6486002)(31686004)(86362001)(44832011)(7416002)(5660300002)(2906002)(4326008)(31696002)(8936002)(8676002)(36756003)(66899024)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjZucXVpRHVnb0lSNWdKcW9WekVzRUIraFdka2JYOXRVOU40ZHRQYUhqVVl1?=
 =?utf-8?B?bVR3blRCalJLQW1JRmdHUkF6eHdPNTBpVTk1Ky9zZVVxNCtmWThDMkZFNXBN?=
 =?utf-8?B?M2hneWp5SXJuU1JnL3ozTVdTZWx2MFZnUk1QbXA3YjZhbVkydUhJVTI0R1BS?=
 =?utf-8?B?R2diL2w2NnF5NElqV2tqZ3VvZGFXMnFFM0ZQWmRXWnFrRkUzeXZmVE84QTgv?=
 =?utf-8?B?R2huMENGeTJYaGRhb2RZTUszYjUxdmNYS01nZmtFZld4V0NhdHQ5OUQ5OWhl?=
 =?utf-8?B?WHNob09aY21kM1dIMGZNWFFyaW5RRk54UE9DU25kbU9mRFB6emg0LzFWaG55?=
 =?utf-8?B?Snl2MFQvNFRiOG5lcWxWU1RIaDRQY3VmdUhGTUR4cXJCU2RsZXdNcUdkZWh6?=
 =?utf-8?B?NGp0WkRhOUxieWtoTVZLdzRXblFPVnA1cVZFNTVoYnBEUEUvUE5kZ3E5c1dR?=
 =?utf-8?B?SkRHZjgxU3ZnMDdVcXhaNGVJY0J3Z0J3aHc1elJQby9jdUtEeURtU3plbS9I?=
 =?utf-8?B?TTRpOGwwRmwra3BHc0ZWY3YveDIxSzloa3IwWWlxNGNqMVBqM3dQT1BFcVl3?=
 =?utf-8?B?QmRtYlRzZlE2MnR1RE9qcXhINVhKNHZRQ09rME5CbGd2bzNEQkpad21UZ2Y5?=
 =?utf-8?B?eXg3NE5XMmNyblNudHZkMVFoTi9GbFJKbDBTWnB1VTMwUU1EQ2JPWllnYTlx?=
 =?utf-8?B?UURPaERvTmh3M1Y1NDdId2QzaHJ2WGJUV3pVbXNHL3p6NVhRZ0loRVQyWjhz?=
 =?utf-8?B?YlJRcGRTNXB1aTJoNWw3SzgvZHg0WjJrdnBacTl3bWFSUnRCajFNdHpVOVZG?=
 =?utf-8?B?aHNicGxjZHZXa0F5YTFBYWh4QUlEQlN5VUJCZnBROXo1MUlPR3BGckc1R2hv?=
 =?utf-8?B?TmlJK1IrV1ZIU2hFUGIxb3cybUR6ZHROVnNZaW1LS3g2dUFlMDhwb2Y4Qi9L?=
 =?utf-8?B?bmt5ajhtdjZKNUIxa3ZicHBKVUNKdCtxeVdhS3BudE5aSE9KYVJ3YkdDRW1O?=
 =?utf-8?B?ejIrRjgzRXI4Qld4M3VadjRtOE5KYWk2RkVGcERmUUs0ZysvT2pxeThpQXFm?=
 =?utf-8?B?KzR4bkdVRFN3VS9ucXIzNDJ5dCtWWkZhWXF2cnFrY1FiME9pVGdTNGgzTDRs?=
 =?utf-8?B?TkhhTVBrc2ZrZFZ2NVM3eUY2RW1YU3FGWjhFdXdERTNXYnl0alpHY2R2dUVw?=
 =?utf-8?B?MFJMWEZ1RUFkdjg0OG81a1VwWC9kVkVnUHcycUtrdS9WdHYyU0paNk5PWXFv?=
 =?utf-8?B?czZheHhzOHIzQ3BSeS9HSTQ0Z2Mwc1l5U3l4RzRJd01VWHp4SGNmb0RqMVhD?=
 =?utf-8?B?WGpMUFFxeVRwNitoUVl1VmgrTFFIbUppS05jaXBIVHhFRGJ5NHRsQkM1NFZG?=
 =?utf-8?B?ZFh2WVlCeHNsaWx1WnI5ZStpdGNHQnhrbjBwZ3BNMm5kQlRsQXlGWlFTbkY3?=
 =?utf-8?B?bGhERy9POE9wVkc0L3RTR1RHaUJ5dUlkamt2cS96VGtkUE9pZnVGemtnSFdi?=
 =?utf-8?B?UTc5SjQvaHQ2MjNTcGN2QlZTaU5Ec0gvN2Y0dDVia0JvdGxzYjY3bDhtZlFV?=
 =?utf-8?B?Ni9JanREZFpUUFc2NUxUd2NkM2RPUmFxNHVRd2QxQXdSSlNGWDJGNGhldVRL?=
 =?utf-8?B?b3BCUm5zTmNpVFN0c3dOajRwWjZEM0pSRG15MkxCTWRjN0VhWHFDVC9YbGw4?=
 =?utf-8?B?bUtPSlRadDlzVWlMMjU3NEl4MjVTeVVST0dnYVljMno2b0FySkt3VjVBMzVy?=
 =?utf-8?B?dXpLSjg4cE1tWnhJalNGOUZuZEZPdTB1emRNTGRGM0dValEwZDZabW1mcmtK?=
 =?utf-8?B?Z0dpUVpQZ0xoUkd6dG5oNlpMbzhlM2RvcVVGSzlsczl2aWRsUHVZUHZUVnRi?=
 =?utf-8?B?TGFzVitURFVsSUNsVWNiSWd4TlNFQ0lNMWZlNXRhSkVDVmRvdEVycEFrNDJH?=
 =?utf-8?B?aXZwWHBzMDYvUGtla1hWQUVHTEliZHRBSVFadC9qMnJMZk5EK1VyQ2dMWlRU?=
 =?utf-8?B?S1U1SWZtdnBtZU9jc2x6NUFXU3padzZ1R09aNFZDeitRQXUrdWV4WXFWUTgz?=
 =?utf-8?B?R0tIdGE2bnhKczRuZ1dxdHk1aElab0tiMVUxejlFbEdtUnhmdkl3SnNuUUFT?=
 =?utf-8?B?MEE3UW5ZaHZVSUZUTzlXdnBSWHNNMnBjYUw3QVRwZm41cldQUXNjTy8xak9T?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4848c78-66a1-43ec-9d70-08dbf75ad238
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 19:29:27.1355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFW9Do5sFy7Y47VE1MiRRPLs2TZ6mBaJd13M+QP5RKkP4ZRN/HDHJQT5L18JnYY6wNJWcFVtB98eUyrf1oyVSKzKCylY4PCZssRAu8cjqhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6688
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 12/7/2023 8:12 AM, Moger, Babu wrote:
> On 12/6/23 12:49, Reinette Chatre wrote:
>> On 12/6/2023 7:40 AM, Moger, Babu wrote:
>>> On 12/5/23 17:17, Reinette Chatre wrote:
>>>> On 11/30/2023 4:57 PM, Babu Moger wrote:


>>>>> b. Mount with ABMC support
>>>>> 	#umount /sys/fs/resctrl/
>>>>> 	#mount  -o abmc -t resctrl resctrl /sys/fs/resctrl/
>>>>> 	
>>>>
>>>> hmmm ... so this requires the user to mount resctrl, determine if the
>>>> feature is supported, unmount resctrl, remount resctrl with feature enabled.
>>>> Could you please elaborate what prevents this feature from being enabled
>>>> without needing to remount resctrl?
>>>
>>> Spec says
>>> "Enabling ABMC: ABMC is enabled by setting L3_QOS_EXT_CFG.ABMC_En=1 (see
>>> Figure 19-7). When the state of ABMC_En is changed, it must be changed to
>>> the updated value on all logical processors in the QOS Domain.
>>> Upon transitions of the ABMC_En the following actions take place:
>>> All ABMC assignable bandwidth counters are reset to 0.
>>> The L3 default mode bandwidth counters are reset to 0.
>>> The L3_QOS_ABMC_CFG MSR is reset to 0."
>>>
>>> So, all the monitoring group counters will be reset.
>>>
>>> It is technically possible to enable without remount. But ABMC mode
>>> requires few new files(in each group) which I added when mounted with "-o
>>> abmc". Thought it is a better option.
>>>
>>> Otherwise we need to add these files when ABMC is supported(not when
>>> enabled). Need to add another file in /sys/fs/resctrl/info/L3_MON to
>>> enable the feature on the fly.
>>>
>>> Both are acceptable options. Any thoughts?
>>
>> The new resctrl files in info/ could always be present. For example,
>> user space may want to know how many counters are available before
>> enabling the feature.
>>
>> It is not yet obvious to me that this feature requires new files
>> in monitor groups.
> 
> There are two MBM events(total and local) in each group.
> We should provide an interface to assign each event independently.
> User can assign only one event in a group. We should also provide an
> option assign both the events in the group. This needs to be done at
> resctrl group level.

Understood. I would like to start by considering how (if at all) existing
files may be used, thus my example of using mbm_total_bytes, before adding
more files.


...

>>>>> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes 
>>>>> 	Unavailable
>>>>
>>>> I believe that "Unavailable" already has an accepted meaning within current
>>>> interface and is associated with temporary failure. Even the AMD spec states "This
>>>> is generally a temporary condition and subsequent reads may succeed". In the
>>>> scenario above there is no chance that this counter would produce a value later.
>>>> I do not think it is ideal to overload existing interface with different meanings
>>>> associated with a new hardware specific feature ... something like "Disabled" seems
>>>> more appropriate.
>>>
>>> Hardware still reports it as unavailable. Also, there are some error cases
>>> hardware can report unavailable. We may not be able to differentiate that.
>>
>> This highlights that this resctrl feature is currently latched to AMD's 
>> ABMC. I do not think we should require that this resctrl feature is backed
>> by hardware that can support reads of counters that are disabled. A counter
>> read really only needs to be sent to hardware if it is enabled.
>>
>>>> Considering this we may even consider using these files themselves as a
>>>> way to enable the counters if they are disabled. For example, just
>>>> "echo 1 > /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes" can be used
>>>
>>> I am not sure about this. This is specific to domain 0. This group can
>>> have cpus from multiple domains. I think we should have the interface for
>>> all the domains(not for specific domain).
>>
>> Are the ABMC registers not per CPU? This is unclear to me at this time
>> since changelog of patch #13 states it is per-CPU but yet the code
>> uses smp_call_function_any().
> 
> Here are the clarifications from hardware engineer about this.
> 
> # While configuring the counter, should we have to write (L3_QOS_ABMC_CFG)
> on all the logical processors in a domain?
> 
> No.  In order to configure a specific counter, you only need to write it
> on a  single logical processor in a domain.  Configuring the actual ABMC
> counter is a side-effect of the write to this register.  And the actual
> ABMC counter configuration is a  global state.
> 
> "Each logical processor implements a separate copy of these registers"
> identifies that if you write a 5 to L3_QOS_ABMC_CFG on C0T0, you will not
> read a 5 from the L3_QOS_ABMC_CFG register on C1T0.

Thank you for this information. Would reading L3_QOS_ABMC_DSC register on
C1T0 return the configuration written to L3_QOS_ABMC_CFG on C0T0 ?

Even so, you do confirm that the counter configuration is per domain. If I
understand correctly the implementation in this series assumes the counters
are programmed identically on all domains, but theoretically the system can support
domains with different counter configurations. For example, if a resource group
is limited to CPUs in one domain it would be unnecessary to consume the other
domain's counters.

This also ties into what this feature may morph into when considering the
non-ABMC AMD hardware needing similar interface as well as MPAM. I understand
for MPAM that resources are required for a counter but I do not know their
scope.

Reinette
