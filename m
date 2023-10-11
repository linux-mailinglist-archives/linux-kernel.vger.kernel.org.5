Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3767C46F0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 02:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344571AbjJKA47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 20:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343612AbjJKA45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 20:56:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEEF8F;
        Tue, 10 Oct 2023 17:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696985816; x=1728521816;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=StPi0ZO1esCDuybCPzmu8Bhb4obPrToPg3/SIeoXjkU=;
  b=iaUpMEMiEYaYDExRAnPrPpqz6vHaZV+hnOJ0KxyeP3Rzbo77ZIlu4EH3
   ONCT7hGAbC1QOcIX6HLQPUDQIUgbBW/6rPf32NZfkP4sArl4Y9BH1ygS2
   JYLBEW7Ur6aQnvgDOZN0+EdTBsqldnSi6X7qImLDhYb7pFej8es/RiBdF
   wN67nxnw9olDkOywJPYYzzFVJgb+ux/PXh/1A4nwhtwmhNbwgPiSPcuoS
   tlC7koLM8EYhkxiltGVOVaqAmtfeEohlFoTpe55ErC4xkYHwV2Nft+PfF
   6UW4H4Pob9AJeCQbw/vL/+1Vxo6tofPD6CKg1ndRXT/MLggo34VQVdWL9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="388418247"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="388418247"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 17:56:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="823973419"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="823973419"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 17:56:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 17:56:54 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 17:56:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 17:56:54 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 17:56:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBiwtaVNF03j0fLnlN0jg9SoGWFg8NGQQZtMrNSGqcQxwyxabUNqyM8+FNeKYYvHpaCB2zVfedLbqG4NvATCEqdOtQI4tloiyrXS63h9Z3PbB3A5Jt9Yxf5a67JuA7QrB3YCFpu99UH9v8ShB3DXdPv2glx4WaPNfgnO2HS/uChgXUoibVNjpnfhd83pIRPARvN/MXmhIgrqzgOPpuDoiH9wEQkf47hK1CP1EbA/2imNljyRnkuag6O2Ria3EH34gVq5mOVgu9KWq9OVFS7w/DuuvrfsdtGhf8dSYS0zT2zt9qImDBecFUraKVC2G8uyoiUZTU6wEZ8BJird37rYog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJBIMFfON5PZGNPkhk+lqsXqsxjS9+LRVROlOCTbO28=;
 b=hkBSynhdSGhvbV7EbW82a+Mpc5pzPowsFdsRlOXOE5UT26Ix1ml086+ib4U7gXxZ9c99TKjJ1SgVqVYyhZrj300WBm3D8yv6mRB9TXgd+1roRhMh+uthB8seta+cchcHO28BMS+qjqYDiKpjRkEwohMHViHdsOXgymMMLp61FZPcDCeXcDLeA0agq9GKF2p6ajqyodVJJTwGVo3kShLruNNhpxdMPGb5OA4lkdvBKo8R+i7YCkUjrQI5XKlQg6G3wjhs8IskziU2vastIe0N4dl0S8W/6JCTbazsW5aKrXzaLn7ydxx35KdfZ86FMWV+kkE5a3rOpQw7Csh6Dj1RNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BY1PR11MB8030.namprd11.prod.outlook.com (2603:10b6:a03:522::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 00:56:52 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 00:56:52 +0000
Message-ID: <71539687-13cf-405d-bf7c-27480e49e872@intel.com>
Date:   Tue, 10 Oct 2023 17:56:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 04/10] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
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
 <20231010233335.998475-5-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231010233335.998475-5-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0002.namprd16.prod.outlook.com (2603:10b6:907::15)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BY1PR11MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: 03991aab-df28-4f92-c201-08dbc9f4e96f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAnlqW35k5SCHoxDQSpCvYJB37PIM7trjK3y76NLizOpWkODmy39YzHZN+ElhitO1Px12A4TAdG/TGe41l6jFI9zPCdY8JZzRy7GQOHyF5i/vGOBa+5JUFe06nuOuoEr1FhcB67h7pSjySq/u/w5ToDAlI3Y1Vh37HTwB6MXwqwaCJhDtzs5mXdy2+j/e2imJbUw9kZTnw5SxcUcD0Q78w6q0mTPvd5KcL9Bc+J2KLU73tIp4NGOiftOlDsqQZxiSxm1BfwrAe71MKbGNUZbSLW2/rTjN5e0Dggck0307CjiOwJ93VnrDbknmD2kTG2nJ89CXUMa1IpDXx4fUInixDqTssGZ4uMjSj2iixw1igSkPqem1NUuewQecqbfNCoaE9ALBhFy8/jfq0NxsWps28roIT/dtGu5Cmi+T+3Hk+rb4dQciYnZIfee8YBLWj9y6tOFLcvqYvpJWen4WVKJ3HaVu6s0JL5q/cMhiQu6mlPp9Q+rR6GHtzBkrRQQSfcA4ucjEm0r4APymh3R7a4oYMqFkc5B8lJT7k67kDl4UcyVBvEss2HpS7cB8+Bsx6l/4E9raSKXphNwgp8a5fyaccAMVr5JrFD4YKYuYhRwVdTuqQaGGmIcP820jXYuFq0+RnF+Xm3lyaxa+YcO1eIWWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6666004)(478600001)(82960400001)(36756003)(66574015)(26005)(83380400001)(53546011)(6506007)(2616005)(31696002)(86362001)(2906002)(6512007)(6486002)(38100700002)(5660300002)(41300700001)(44832011)(66556008)(66476007)(66946007)(316002)(31686004)(8676002)(8936002)(4326008)(7406005)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cy9OZ2xJSDJoa2taeXY4bndJWXZJN0hVcWVTcVNqMC9kM0JFNzd1elFiaHJB?=
 =?utf-8?B?dXh3SlV1dmJmaDN4eEVpWEMyNkZZQjlGOWV3Wjc3anEzVWl5dnhvZHNNejcx?=
 =?utf-8?B?Z09lTWF5eERueGU2K1FTMkY0U0lvK3FYR0daZ1pYaVA2UE83VVRpUnFqMlJH?=
 =?utf-8?B?K1IxbnRrMmJZTXdoa0paSlpDSlBKYjN2amdEK28wWGxOSThUZVJBTUthaHc5?=
 =?utf-8?B?cWdSZkYrQW5pVUw0M1plWEphaVpEaCt6L3NzalhiUlZXcGE2R1dvNlNsczF5?=
 =?utf-8?B?T0ZKRVh3bWhJc2RSTWlZL0VRbjBWVlI3M3NRNEtuOXFVbmRaQjZyKzdXd2RL?=
 =?utf-8?B?Nys5eUgxdDZ5QzNISW9aUC9meThYejZ0eDdYOWhtcG5PK2FDWkFQUXlXVG50?=
 =?utf-8?B?Qm54clJLa2JrT1ZYS054UWhOckFSenYzanpBUElBSkYxM0lWNmluVitSWW9D?=
 =?utf-8?B?SVhCRU9KNGNBQlQ2NFJ1cVBtc0lZM0crTmFlUVFhaWJLWGlHby9TeEwrMWRk?=
 =?utf-8?B?RXRzWTlZY1gyTFhmYS9wSHF5YUE5dGJBR0R3eTlJdkhVUEw2SGd1VlFUOG50?=
 =?utf-8?B?Zm5LOGYwWmphd2hnM0Q4T2JRZGcvL09IODA0SjZ0MWg4TU1scmRJRGFEWWlP?=
 =?utf-8?B?WU5kbnpsZWlZcmNuZGcvR2RvaW01bXVsN0FqZ1FDSlF1QUhoYXV2ZkJKMDRR?=
 =?utf-8?B?YXRobkU1QkxKMHJUeVBHTVllN2ZjYlRoTXpvWnExc1NmYnV1aGU2VyswMU5C?=
 =?utf-8?B?ZnZ5R0huYkVvRk1hQ3FYOGtTbFhTM29naVc5Snk0YXNOem9ydlZjNVZ3NGxZ?=
 =?utf-8?B?ZjRtT2VDV1hZbVNST25pazFnbkJLQUJ5eXNoU2hwVjgxU3lwTmZ4b0RhRDA2?=
 =?utf-8?B?c0JNM1UybTNKR3RiQ2Q3dTN3cmQ4NjhkOG55R0E1UThRY0ZiNlF0VjVXcW9i?=
 =?utf-8?B?NXNVb1ZyWTFnZGdHb3BGblRWYUVxMUpFRlNqYitUeHZDK3hhRzhmY1hac0hR?=
 =?utf-8?B?d1FFWUtaVUF5S2pqU2J0QWU4djA0K0JSSEhZbml0dzl2Z0NKQmcwdWpyL3dm?=
 =?utf-8?B?bUlXL1FGSlpOaG5OcnJYSFZ3OTNxeWtRM1Nwa1dGVmdsU21WU0lOZmNnTlBQ?=
 =?utf-8?B?bE94TGVEOEFkczZHUUNJdE1qeVZVU1pSc0RYeGhITTVoRnJKbXBGL3JsME9h?=
 =?utf-8?B?bjRleXdLZXpVcHRaM2d4bzdSeHZLd1VrYTZxQ2RmOFg5NUZicmNHVUdhSEFV?=
 =?utf-8?B?QlRYNWlyeVNDL2I2R1ZUS3RtMnU1WmUyQUcvU1EzTlF4bVdNNHFJbmFyeGVJ?=
 =?utf-8?B?RTdqT2VhVW1lWEFTN2lZODdTQmdsVGlLRHN2WFE4K1VVcUMxMUdIZTZuMDRy?=
 =?utf-8?B?TEVmWFFyV2kxQTBMV3VpNTVPaGVUcWtCKzRienV6Ni9qV09QTnIyWEs1WXJB?=
 =?utf-8?B?d1N0N0E2eGZuakhiQzVxTUxxOEhkMm5uYUhOSllpQTlUMnlTQVZESHRobzgv?=
 =?utf-8?B?empkOWpqbWh6YnNDRm1PTnlXRHhidk9tTUV5TEhOZUNiYmV6Q0tkcjZ0d2lK?=
 =?utf-8?B?R2h4R0R6bDd5NnVVSUtMdnlMUHNqV3VENGxkd1cvNXRlRlRGY2xGNVFXOGNq?=
 =?utf-8?B?aFRjTjVGbUNuYVlaOUVqaUZzdUV6ZlJJbERkY2VjK2lEbWZ1T2lXa2dVS3F6?=
 =?utf-8?B?WlhQNG1XNkxJc3V2VWttSFN3QWxLa2lRVTRHbjd0N25xZ2ZIZUsyV3pYMkNl?=
 =?utf-8?B?SGNZK3FUUCtEbTlzY3g5YmRBdld6K0w1MXJrOHdNejRMVzR2T3poZTlPNVlu?=
 =?utf-8?B?NDhYbkdtMHp0aGdUcDVnNFRMc3A1a25RM2lic2hZUFZHaW9HZE9VTktjUzF2?=
 =?utf-8?B?MW85eVFBczJhWFBZNUFsQWErR0dHekY0S3ZVVUMvcnJjYlJCSUU2SGR2QnVQ?=
 =?utf-8?B?N3g4aWVJYTc3alc0Q0NHdDg3TlR4b0Qwbk5YWlpBRjNGSnJWbE42WndTS0Fh?=
 =?utf-8?B?emVtUUVNTGZpQ0lYOVkxNE51ejZzT0JueDlQaGFkLzV3NSt4cG1rSVV2RmtK?=
 =?utf-8?B?eU9xNzNQY0JOR251Rmx2UnBXeXV4am1kOWROVnNqbE96d3VaWG9DK2lCclhY?=
 =?utf-8?B?QndkK0I1b25zc29hQVZDK2xzRWl6emlWOHprL3hTZS9QMHdUMzhLUFNYNUZG?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03991aab-df28-4f92-c201-08dbc9f4e96f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 00:56:33.0407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0XO5nAGwaInx2qdiYhagR8+qpnuoNr1OUttBsaU8k/dHaw50l3Hl/hJPFT5s+os6if9pcp8wCYQr0ONd1qJkyk2qTdNlckQA+GQTUWQ7ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8030
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 10/10/2023 4:33 PM, Babu Moger wrote:
> resctrl uses RFTYPE flags for creating resctrl directory structure.
> 
> Definitions and directory structures are not documented. Add
> comments to improve the readability and help future additions.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Peter Newman <peternewman@google.com>
> Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> v12: Moved the comments from arch/x86/kernel/cpu/resctrl/internal.h
>      to Documentation/arch/x86/resctrl.rst. (Boris)
> ---

It seems like you just copied the text to the documentation without
taking into account the destination's use of reST syntax.

I tried a "make htmldocs" to see how this looks but encountered:
docutils.utils.SystemMessage: [snip]/linux/Documentation/arch/x86/resctrl.rst:398: (SEVERE/4) Unexpected section title.

Please remove my Reviewed-by.

Reinette
