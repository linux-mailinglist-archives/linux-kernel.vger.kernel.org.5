Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0992A7C7202
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbjJLQFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbjJLQFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:05:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76819C0;
        Thu, 12 Oct 2023 09:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697126710; x=1728662710;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QBwEc74I3NNJ1rikNQwHPy/BvLnJn96mtSYgemTOv8Q=;
  b=Z59m4bLSJPQ0QDjbIrhazzlNXyC2Sk859y5lCrRFX+3/uUkBQ5R7GbWL
   /KD5PaZnKPxGc2vUuQ/zg2oaVDmRqyQqzDEfBLJaT64p5aR/PZmlU/6sK
   +nCdNXK/1WJA8cJN5gMKj7xCYbbdHRqVctsx5UC6s52ry7MPTjneGZG/2
   o18NlfIXinPlQWuYCvPrdq23H0WYs10KbSTNJM5TQY3AlJhRLNuWo1kEq
   GqLithemNYn8LxBDQ+gQMowr6vws7AhQQIL9vXA5zzjIm7LhAh+4hLcAf
   14Om8M3dhvmcuDr/ukw7lPINmk4IstfkcQ2LFlTiqRcpUfw7UiPqBNal5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="383815844"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="383815844"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 09:02:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="898172233"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="898172233"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 09:00:54 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 09:02:42 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 09:02:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 09:02:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 09:02:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dv1W1fWUYqp9v9iOjjNMAK1MH894UIUywjF4mcR4JFUH3dLQuLQdQYcdLLDNgdGOgNqPM/scQhzUCwTo02fdRmv2/auQGs0sukv92/xz85Mu9gw8YpINcgGxGpK1JTwogCrXyX0TnOcRHsdP19Hdv9bjgd9EAMzA1IowHEt5cFEzoj5tFHkIA8iQnTfuytMxqjOS7FcAq+nG5lgZipS0ITGPY5k3G+zG37dCIuTF9v82VSDn5SuJgyzR20dw/2vr35NB1J4RxODFGL/toQJcjtz7sVxLbIp7oGzbwCeurmb6kCQHHDqTAvDGnTaVdeUk4A+uB9Rzd1RCLK3/vFH+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHfUvePBgDlf0wJhc8e3CfX2tOzdQbPfz9/nNtrVS2k=;
 b=T29HKhTyjPTYu4keoAZ+lswhlfIG02zlE8sXgaS5/NOIZRfntIMR+5sjc+t28RwwDxDBbnG/4QWzECgmfNLgcGPerfTEW79oOmYKmg8fOazsN/CsELx7ruB1i0zE6GT72YQQ1+KCAf0JJNwJIWr3j6u8yafILHiIl3Jla0YaPeY8jJlNPI+6Arkzs78bluyOo+mHswzeUEMd5qnh11OKdacjfoOF+oU2sK0Nvi5XVqd8ybDudbu3poizr0uvXTzKrWnf5mNglSkvx2y2SGI5vXp9ry7+JDJ3k2W3BcY0UK6vW3zOJAb9MJTEfOFt3/VheRaBcf6JkhIv9hF8QGP+yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB5139.namprd11.prod.outlook.com (2603:10b6:303:95::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Thu, 12 Oct
 2023 16:02:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 16:02:39 +0000
Message-ID: <c030c50a-201b-4a73-b3d6-b9b298f1b251@intel.com>
Date:   Thu, 12 Oct 2023 09:02:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 10/10] x86/resctrl: Display RMID of resource group
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
 <20231010233335.998475-11-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231010233335.998475-11-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:303:6a::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c1d59cb-3e10-47da-bd9c-08dbcb3ca87d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G9sMEzy8wIv3Pi00lGFa5+qddgeacdTHs7HrMOZEgwOFvZEoS8n3FgOdYNEW45XH5xwk1/WIOtlx3eaP+qj9rBjQj0U2ZEIlT5/VbH+RpHiZP/qui3P2HBXlsUrfa27op1x5nP8g58c3oDX1fndq+hX4WIDwhL4QsqcuOByDZqaA7KhN810xOFiU6i1c2/ihCAUDU6Tc4NT3oSyiTqX9XI9PmVNY2f3SInu8OWqpOgVypi1HYt4HZg8oqI2auXG0ZpUh24nxvxN2h4oS+qhdcrx66wSBBA5YqrnmMinF5VeDxz/C4tEoaQqzJqBcBe1CPQuCMO5cTUPL6tpJdsEUq/Bh0Y8W+wvalHc1B2Kf1FVHupPvX+akZkLhfF9Rmmm6dqhzyDrYgzmG9hP1Vrg0c/nRt7SClfdPKdhfWX+RKSuvzNWPF9+ewb6HRg/6drSZ/73qoHd0QSojhhUU3Q19Dr6A7T30q1BKO4uQ+rSUPI0tVUjDo8/7Rj18A5dmQa5i1AEuK40jllv+QKQB3vRgCwZVhdsmxz4LWI2QavrrRRq0q15mlkhk1DFTvvQC8jOnmSwbGBJMLZn57k+lCrE/WGsf31DKlXZY/h5bb+Ub5GOF0rGASebw4n+KoOrn6iWzK9DoAjTo/xECN6K4Aanr9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(41300700001)(316002)(2906002)(66556008)(31696002)(86362001)(66476007)(5660300002)(7416002)(7406005)(66946007)(4744005)(4326008)(8676002)(44832011)(8936002)(38100700002)(26005)(31686004)(6486002)(478600001)(36756003)(2616005)(82960400001)(53546011)(6512007)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXVNbm5WYml4cDRUdCs2OExNV29ET3hoR0puZk1jOXBRbE1rYllTNHN2NGY5?=
 =?utf-8?B?M2tPTnU4ck1DRFc5OER1U3o0cW1KZnJHMnAyQlZxekV5a3VpRDczVDhQWUQ4?=
 =?utf-8?B?MjhnKzdGZmQwY2RUYTA4eFVKQTBlTGtvcVl1NjFsb2plVkptVTgrQ1QvN2ha?=
 =?utf-8?B?aUFJS09Pek9EWEt2Y09Nc2YxT2FoWS9laDgwVVBaY0JUTFZWZnRnSlMwYjVG?=
 =?utf-8?B?R0wyaGE3OCtxdC9wdnBkb2pSVUhOcVRMTUZmUkswQ29LUUhMNnlkMDRHYTYy?=
 =?utf-8?B?ZzZVZzczSUhOSG1xUmJCWXJYMGhoQjdNOEt0N01vUDUvTzA3R2U3ZmJFWGJT?=
 =?utf-8?B?TDFCcURuQmdEaWloditCVy9vSy9GQkNUblRNcWJqS1VIem5IbWVGL0pCNThF?=
 =?utf-8?B?d2xPYmk4c2hJNWdWdlBrN1hRMjhrbVNVYmk0dzdJQngxeCtaanFWcjMzSUJD?=
 =?utf-8?B?ZGxZQVZOcnY5djhKSlZNdzN0Z0lMV3c0OGZCUS9BanRnQlhjU21kUzdmdGNm?=
 =?utf-8?B?UEtJTDdmQlgrMVFnbGMzcUpCYlI5dGc5Wm13b2E1TSsxek9DbmtMdU1zZ2g5?=
 =?utf-8?B?Wm1vdFZndk9DM29kbXcreW9zM2w3Mzgzc2E1VmZBV3R0dmxCLzZWYnhRTi9K?=
 =?utf-8?B?SGpEZEM4V2oyKzY1S1haSlQvL3d5SERKUUlvSXVHcVlrbkxxSitGUEtORWNk?=
 =?utf-8?B?SkMyUjF2R1ZPVTBsdGNQRmczUjNHRitNVHR1NDVWQ0tYbzZEQldwMTE3TDlC?=
 =?utf-8?B?RDgvb1ZrVjJWeEl5RW1CbHVCZElPY1NtL2Q3Qkpqck1uSFJzS0VuNmc5QklC?=
 =?utf-8?B?UlR0M2JoV3YvM1EyVE1Ebk1zUVM1L2xjaVVqejlQcU9wKy9TbWp6SDJldWIy?=
 =?utf-8?B?ZWdFVXg4cFBGb1RyTDVtcTlQc1d1clNXN2wyeExoanZzVXAwdEw3OUVmb3Ir?=
 =?utf-8?B?T3h1ZFYxc01Sek56L0xaNHJKQ0JKM1ljNmQwOUNoMUlkUDc0YlZ2eW1QZDk2?=
 =?utf-8?B?SFlMbE80OUh3bGJxUXRaZVBzN09PWTF1Q2lHWkNMTGp1YVpETkNSOEJvNkMy?=
 =?utf-8?B?ZnFIajdKQlRxVDVOc0E1amNodUxDeUdjbTU5Q09HbVpVR004Rlh2NnpITkQx?=
 =?utf-8?B?YlAxUFlXQnNIcTZMUHljbFNIZFd3V0xJYXVXc2M2M2xQVTRCb1JUZmZlVUxn?=
 =?utf-8?B?bnlTNU1Ebno4VHk4dTZPU0RQTEU1M2N5aDlVYlBRU01FZ2FKcXJkNmZ0RFdl?=
 =?utf-8?B?TVlCbm5ZbFBPSWpSYnlVM2o0L1V1TnZaNmwzc1lZVllPMDh6OWRZNFhTUE5t?=
 =?utf-8?B?WUw5SjhERm8xR0MwUktNWmNsQ2w5WVBuWEM5TEdNQ29aclNXTFRPVk10SkFV?=
 =?utf-8?B?K25kdnlQUkdOdXlLdGYzNU1QdUZKS1N4dFB3T2dvY3BicE0zS2xCeHRkVHB1?=
 =?utf-8?B?dWN6S3VTeHlvQ05XZy9XT0hMbXptc1RRVWdCem03dGkydVk0Q3BJQlN4YkRX?=
 =?utf-8?B?UFJhVDJEQXBGU3VPVUcxVTJ0ZFM5ZUtYdzUycDlCVVVldTdKbkVRQUdIV0g1?=
 =?utf-8?B?bTZIY3lMK3RHNUVYVy85WDVydDExa2F4SEgxc3o4YUhnUGZDdG9tN0RjNXJD?=
 =?utf-8?B?SEp6UHJ1OUFWTFp6b1U5VnFsaFZWR1JzM0RkZEtDbUhMRVp0YlBVbmQ1TTAx?=
 =?utf-8?B?KzVoM2NyeGxtTHFyays4RFd3NkoySmtwRSswZ21HWGdTQUxYZmV4bDdnSlFP?=
 =?utf-8?B?aFlRUG5yYzlsYXdZeEgyOTR4MUdCRHdsT0FxUkIxT2kvY2Q1NWIybDZTZ3JB?=
 =?utf-8?B?WTJNYUJYVG91R3lyUzJaN29DMzBQN2NyY04vNTVhTUh5VVFzSlovU1Y2OUFh?=
 =?utf-8?B?eTZjMnVoUG1IengzQVFEeVZLWDNNYVNtNFBHMFpjbmVsNWt6ZUZQRFlSdDBn?=
 =?utf-8?B?YS9RTVJrazZrbVAreTNkbXFaRitKbVlaSWFqNWlDNmF0cGMycS8xZy91Y0w5?=
 =?utf-8?B?bU5TUHZjMlJ6RGNwaWw2SWdaWDd0MGFOVVQwSjJIL0RHOEhJZDZvazluQWFE?=
 =?utf-8?B?MTQySDJpampZd3N6TUJiYkFlK01ITUo5WlJMUEhBVkJENUFTRnRJSDRTMFVW?=
 =?utf-8?B?bWZ2MUFyMGpyNEZKa1dTak8xdm00dG5ZVE9nQXZJWXA2OXBqRWdVaFhGckpG?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1d59cb-3e10-47da-bd9c-08dbcb3ca87d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 16:02:38.9777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUXd14E5IniCviSMmxdos5eZF+d0UD1GkpfJNPDG6NM1SpbmwNXJk5c5j5FqekHWVMQIkYWcEfXh9IU+pdcAOXxA17T2dXgzrxI2o1sps3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5139
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
> In x86, hardware uses RMID to identify a monitoring group. When a user
> creates a monitor group these details are not visible. These details
> can help resctrl debugging.
> 
> Add RMID(mon_hw_id) to the monitor groups display in resctrl interface.
> Users can see these details when resctrl is mounted with "-o debug" option.
> 
> Add RFTYPE_MON_BASE complements existing RFTYPE_CTRL_BASE and represents
> files belonging to monitoring groups.

"Add RFTYPE_MON_BASE complements ... " -> "Add RFTYPE_MON_BASE that complements ..."?

Reinette
