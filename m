Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB957C71FE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbjJLQEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347323AbjJLQEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:04:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54EDC0;
        Thu, 12 Oct 2023 09:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697126680; x=1728662680;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qEHKdRatn5dlssUjppfSz+RuwNqUkQpseEM/apErzGs=;
  b=LKSKZUdyjNeZ6NA6WVsoy0CPsUq8ayrPEhRLPVC3Ztbpy0Vu1ORdaxxS
   fiuFCqgjtKP8tvcR5iJHwl0ERVaz9wqdWrLFS5WKPk3E4PraqEbb4rdL0
   u9f+zoghfpb+W4ZqjSsp1FHyMqyQLdxaSw6VKKNb7Du9VYRrSw9z/Ju1J
   hWS5AwBfd3DM9EFZbdB1WeRLrN8E+MPaZw0f3yrJJDfpMJRKLrfSaJtYY
   rMFljlDKNgtq/ckCl+dMfj5ryG2Fk579tTn9KM3IdxLBzj72JX+2z8gCX
   /IhWdh+PrvQaDGW/pWOaSpTRdQzw+nlKK0R5LwojIzqp+GXg+miUUHyih
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="383815661"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="383815661"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 09:02:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="898172106"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="898172106"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 09:00:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 09:02:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 09:02:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 09:02:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 09:02:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1cZg6o49H9mIPhDgY6mjdWZpjgnTikGbYa3k7sPW2JkjQWXZvcVhZeF0P7VvGFMrTGiAiQqAXU7q5/Cof4AiTkF+xB6VOJ0umJgDExJNRzvISRv913Mr2ed6CTM3OkAgwm5DkmKuOnpsAF0NQq7XbvJC5g0zhjL/ruKAuP2zrn0XwxvStzpVcxcojoE+kr8gDHj8hUaAzMnbAMDTqjas/kwQn02RnUywdgBaHkDrUXEwhyLTmr+qpeJ6SHHjPvQYR2idOBU88YSk2M1Gd8i4/qqcxpmPSsvlN2vHapQyh6lWykrbJ836BwVYnv2vFVY7tFrPepTeiUvSOwDUw1JzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zZeDKF9v+022tZtOVU1gH7TF+dhZwcqrLmbnUjfqug=;
 b=miQYCzl6gzNqrotKLs3zn30zVsyfb9fXXLZLFGO3pu9ghqINKF9lW2cXiN4UavNfHZiON/Kf7W2/7E0zx4V6XZeLHB5otRdX9nOdCHX6w4ve2Wxv7bgZ9l2SqCL3UmRyw1Wx+DQnDw6XEiaCNVrFrg/TE8QOqEpQFLu1wkC5pr6sOp6vIAl4aQl+GWNLQlCHfW8EzzmRSU9/cKmkaWoqSwfAGJ0dG5N2q/RUQYdzKtOntej5Z367swCja/LEAzR6eGb12Wx+NcGqCb5I95nCwBpGCDd0PFdCystyaZ7PmRLvBdj3aJQuFmaazDYri1cXfwNW+tdR0t62C+8NqDygXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6120.namprd11.prod.outlook.com (2603:10b6:8:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 16:02:15 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 16:02:15 +0000
Message-ID: <28f089f4-992b-4331-81cb-100a1814fc56@intel.com>
Date:   Thu, 12 Oct 2023 09:02:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 09/10] x86/resctrl: Add support for the files for MON
 groups only
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
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
 <20231010233335.998475-10-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231010233335.998475-10-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:303:6a::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: cf6b5ea8-e579-41a8-5ae5-08dbcb3c9aa0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /lIkJkxf/hEbvOZvILAoprV+dXJJP0fJ7hDxvNUEOOqyP4OZtgEmYx3vazOrPyVQbHvpnnLm5q4611TIxleNKpFGG0SySaqE8XUMRjXcKXNblQvI4LMznm5eANn3Oq8rukCZD0GtpOR8+XFQd7FiMCS8trfIgdB0RMZUZQs492Cf3D+zwag+eRGjpK0k4XumhDcTtbLK2ZUAcc6Qj6f7H122EELf8k1g/bTewUb1OxbiklepIbzDNEwdXD8ap2h4me3/+iy7gONDa/2HyfwDa0/H0rXkEKJ9omv7JT7X276/gPqausVUBCf6+x+KZH033w6Ad2B4HQ0th16fWLO0Z1yIDbrm7hlXUP4ywBtdYV3xp3+Xa2Qkn6JntpGOHPS5sbzmKtAggXENjQmaZUzTCsD7noqpBc6GtK5KzNTN9cWoZofdWQscRL/LBc0p9Hu7rAVjO+xqwywPh/3oVU7CTLirBG7AJQtAFC4TRzg9v/AzfDFF/CRn1vVevsaDReHBDx5k7AhSvc/WErZMS1TWvwMF8WVbU938Z3n/JN46VHah/u622Qfa0CEk3U/XnbYOS+nYKQobSc2GIhNWo26tY9H3sAq0gJXdjCa43qlbC7DhMNugKyP8eGqDrvaTTxbLHiicYjrJuaKMXt+kHArVfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(136003)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(82960400001)(4326008)(8676002)(8936002)(2906002)(6486002)(31686004)(5660300002)(44832011)(86362001)(6506007)(478600001)(31696002)(53546011)(6512007)(7416002)(36756003)(41300700001)(7406005)(38100700002)(316002)(66946007)(26005)(66476007)(66556008)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTJuWEhqbW1WWnZKTUJLcEtCZ09wUzlibzltcG1yVS9JQmx1Q0FnTDlYWEJI?=
 =?utf-8?B?WVRCWThDT2NJek9VZC9sSWZLVXdXV2ZOVHVNYjE5b0dyOWlsS1p3Mm4zMUk5?=
 =?utf-8?B?VDNNZjdaYlpSQ1dOVnpOczgvVHViQjREa3BWcjIyYW5CL0ZQT0V6RDFOMWZ2?=
 =?utf-8?B?bEFtSkl3SzRVZFBENVBkcmtyOW5pZ1JWRTRRbm9uejAzck4xb09tNldlNlZD?=
 =?utf-8?B?MkpYZlJ5YjNPZE8wRCtRb01kVHVsNGx6N1k3ZTlTa0VVbjgrUkxuQ2ovQU5m?=
 =?utf-8?B?dCs3NjJqV2RCTGI4a0tveSsxWFV0RVYwU1pIdGNFZ25TM0pOaVhINFloUGgy?=
 =?utf-8?B?a3hyM3FNVnVGTkc3SDYyRnNLYmlKeGpQQlNXQmZPYXFGeTlveTUrZURXYWxD?=
 =?utf-8?B?Tno3Rm1aK0gyUXdhWkcyZ0xqaXE2a1BhZEN4bjRTT2FpaUJuZWx4ZU9FWE5K?=
 =?utf-8?B?MGkyTHBDd3RHKzNYQzh2dkIzTFV5YzBsSzduRy80cGI4SWNYbkIrMEtmWGlH?=
 =?utf-8?B?SEFkUUYvRkJhbVZadUNVK3g1M2MzR3JmZzdhMGFacGI4a1RoRk9uYUJSQWdq?=
 =?utf-8?B?OWRwUmpPeHZaWXRVbDN6bEpnWjNoYkpvWU9ydzJQRUNaUUVrVHdOUitsQU9C?=
 =?utf-8?B?eUhwajE0Q1UzVE9lSU1FWm4yaTFmV3JhYnFUVHJ6Z2dWa0VXOW1hU1VUSW9N?=
 =?utf-8?B?NWd0YXg5dTFhY0x2eHJHYUEyZUZyYU55dFFBWWprUm5NbElJZFpCMWMzM3J4?=
 =?utf-8?B?ZERsYjNtRC9VdFhSTDRLaUJIWHRMMEM2dk9OcTBWWmpQa3l0U3A1R0ZRZlB6?=
 =?utf-8?B?anA2WGdPZ0FQWU5IRER6N1V3Q1I5VkNDWmhBMDJOUk1FVEpCUkorYnI5NllF?=
 =?utf-8?B?clQ3R2ZqSmgvSy9OUmtPZU9YOVVPY2MwRXhXOU5WU0NhY1hQSTR3Z3k5SG5t?=
 =?utf-8?B?VGY1T2FIK0tRdVJRZDR0dm9MYkh3blFUbDNQUElBazZjMGJlMDF3dUtQcHdF?=
 =?utf-8?B?UDdJd0NYQVZQOVpCd0M3R1JKV1RNNkdPdHM5SGVNOWI2WmZuem0zZ21QUmFk?=
 =?utf-8?B?MlZLZXdBVDVJcWhETHh5RFlHSVUrRkdSL1NvazYybDNobnhrZUhwRTNVczZQ?=
 =?utf-8?B?Z2VhazVuUG5YQXFTa2kreUZFdHlqaytIbjJHcHNtcWVGQXZ5RmFwa1hqOWZl?=
 =?utf-8?B?NllHTWo4RXFEN1k2TEgxM25xT01XRmFpTkhac2pPVkVmRGRucVZtbGdoVUNs?=
 =?utf-8?B?LzhnK1ZUZ283MjU4ZnE5aGszSDJSQjJ0Uk8ySUFkSlY5SUxoL1Ird1JBQTQ3?=
 =?utf-8?B?TmR2T0N5NEJTclZYZWRTTmR6ekZvK2JnclJQUCtXNDYyWWlXVXkzNTBseC9Z?=
 =?utf-8?B?UUpTbzlOdGFObTROQ0JuMVlzMkFaV0QzVnRoUGtBYlR6M2JXN1Y1Z1dlUzVp?=
 =?utf-8?B?Y051UEoxMlBqNUE1TC9xMFlwRU9wQlRmNDkwS2pKVFRtMlJVVjIxb2hUQVV2?=
 =?utf-8?B?Mk1PdzIvNDA4YzFpNjNENnM0M2U1MXk0WElxeDJ3aEJrMVROVmc2THcrdlBE?=
 =?utf-8?B?d01US2xNa0IvQlFEL3FEcTBnTnB2RURIalQvOXpEYWVSYmU4R3hkcnc4bXdP?=
 =?utf-8?B?SGtUT1FmMU5xamxLZXlPRUFkSlVydTZWZGxGcGNSQkp2U1NRNXd2TS9iaWwr?=
 =?utf-8?B?eW5wUTY4dk04WjRJaFdpd1crZWk1SW9PdXpyRVY5TW1ZaXNLdm9GUVBnM3JK?=
 =?utf-8?B?ZXA0K1Zrak9hajZUdGh0SDdzTG5uUnJPeEdPWitCb254d1RrTExVL0ZCNjlN?=
 =?utf-8?B?MVFzdjRuRWYwUUQyRWRua2wwQzZaOW9taW04TzVlaWpQdFgzVTZ3UjVJbVF1?=
 =?utf-8?B?UjlGL01mdWE5bG9hdHJFaEpkZDFZbDk4Z3FDSEhUL1QxdG0xUkVRQXE2Y1I2?=
 =?utf-8?B?L202OVR2aDk2bHFwcTUxY0d1QU1ZOWpqRWNMTU5kYVdLem9GVDZqZDAzMURL?=
 =?utf-8?B?bndpNm1qQm1Fbyszbk1CcCtjNGQySm9WUW9xcjVEOWd0Z05HWW5vZzhjdlo3?=
 =?utf-8?B?dUs4MWVVZVNlQkpOTHEzSnJjOFRTKzRDaXZXVCtmQmIyd2lnU2NTeWZ5TnJO?=
 =?utf-8?B?bVRMdWxaSzdtVi9XTHJmK1FlOEdRUDd6ZTJGdFoxTGVyRUFKQmRGYXJOZzBw?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6b5ea8-e579-41a8-5ae5-08dbcb3c9aa0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 16:02:15.7267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGa62EsJVsh5bgScDYSFR4m2BToAM406rivcJTmANESyQyTdtQJEmezT1gfqpjMv/VuU1O0dG1P/GxCxFXkq7OlyY8put1MwlVhKUwDrj1Y=
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

On 10/10/2023 4:33 PM, Babu Moger wrote:
> Files unique to monitoring groups have the RFTYPE_MON flag. When a new
> monitoring group is created the resctrl files with flags RFTYPE_BASE
> (files common to all resource groups) and RFTYPE_MON (files unique to
> monitoring groups) are created to support interacting with the new
> monitoring group.
> 
> A resource group can support both monitoring and control, also termed
> a CTRL_MON resource group. CTRL_MON groups should get both monitoring
> and control resctrl files but that is not the case. Only the
> RFTYPE_BASE and RFTYPE_CTRL files are created for CTRL_MON groups.

There can be an empty line here to make this easier to read since that would
separate the problem from the solution.

> Ensure that files with the RFTYPE_MON flag are created for CTRL_MON groups.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Peter Newman <peternewman@google.com>
> Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> --

Missing a "-" that will make the patch description not be as intended.

Reinette
