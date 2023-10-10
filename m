Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C757C01D8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjJJQks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjJJQkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:40:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064B394
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696956045; x=1728492045;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g0uHhLvAoz/2hE22EaSa6j1uwqlyHR3dqitcfXy6vn8=;
  b=T2aYxoC/XdOcil3MeZNBtjHtm7heG/dEjvQuDXGssbgMjycU3HZ2ZgIM
   khkh8t6eeNJ1DWC5QdiX53lJ2wYm2xNY2iEoihdL1msqcbGzFoQhPt2xi
   z7VO7XEHaU+w0Q/GeeriZOtwakKtj7rAh2Lq2RsQpNY1bvRJPdrAYJ5Sd
   jU0tJPey5ue9PpweGu7XCaJXFBgvQT/qQN583WXo71JZF3ZIQvYlI2Y3Q
   Va93jYlVcaxyfVPqwQsW2vgiLsALbqdrx0s5IOLG1cOVm6Vkuww9G53s1
   SDBWcKbyFxGmtPPTn7yKnftaagISERvF5BKNvxOLk2WRE6hqUpMtf4fno
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="388317376"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="388317376"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 09:40:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="927220013"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="927220013"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 09:40:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 09:40:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 09:40:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 09:40:43 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 09:40:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duLHojLFtBSq1HP5G+TJqa06bYpTwFsKjxCuFRhPs1nmyIB7vmCwWcouGXPTNtU2wdKMmXN8G4ZHalzR495im5GkUNEX1j5gmbMiqJBbeXEOExi9Za3vCxaEejFArF+saSGmh/WSKWhMqWdp/sudlWt2k28YTYqbFAqaYLB0HF7Sd2Gws5zw93Qp99LoiWyupPsy0Fn00qykie67TQZCUXYjUvFjT68koA6vzVYQYxoVj3DBhaYk3LNWrnGceI3BH2U4p3Yc8jkqi/rqZhngXUrq2f5fr8LcAQLWUK+6DJn/eAoSyVUS7G21AglfBUm928/u32MH+YrsNI2pVqYeog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyYW/PuDng/j1NypbN7zvFh++y3yMW2Yspa8AeSp2ZE=;
 b=LN19AgWlyYALspxn8Z+10fhme2kw7Fw62ZE0ftSG7YABiIJsgjWUF/EZV38h3e8bBnMtHsS3C051qLryciIvAeUFn1vlnLpSEDHPHaAgi3o6gbYpvwjvd/mule/+Dq+6Tt7TkiXlVGOFStuURXXXuGKWAD2pLSVGtw/75l34hBiFqAU8z7V/QrWgeCbosHsEY/dP+LCEx29ZNB53BDfG55J+x7tlRRrllgSKYIvO+BB5GRJBC4CujIEn7VFBiIb33vAa9sIoIJUYllHmINKGoNRwSd1pQBage7M31tGOhOnWXLL5P9Vw1fXxj6d/TXg6radiScwT9fyVpxNJSHOUSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB8761.namprd11.prod.outlook.com (2603:10b6:8:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 16:40:41 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 16:40:41 +0000
Message-ID: <360270f1-8bd8-40de-af54-5527fb1106c9@intel.com>
Date:   Tue, 10 Oct 2023 09:40:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: arch/x86/kernel/cpu/resctrl/rdtgroup.c:1196: warning: Function
 parameter or member 'type' not described in '__rdtgroup_cbm_overlaps'
Content-Language: en-US
To:     James Morse <james.morse@arm.com>,
        kernel test robot <lkp@intel.com>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Borislav Petkov" <bp@suse.de>, Jamie Iles <jamie@nuviainc.com>
References: <202310070434.mD8eRNAz-lkp@intel.com>
 <58306525-bd92-18d9-b25a-9c030518cfa6@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <58306525-bd92-18d9-b25a-9c030518cfa6@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0277.namprd04.prod.outlook.com
 (2603:10b6:303:89::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7c129f-653f-4d53-2d53-08dbc9afa426
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJ7qictyjE4H0lq0LpOyU0ajvY+yLW0DP/j7sB8CYxJrL5CaPQJ8LvtZMulI0cuffiKFUJFZMvE8lNmAOBjbD0fLQJwRki9BQwC6NIyB2aSVsgRLfdBmGFaITDcHqQ2j/pCgMAkfzmbBt2+aS7gm6KAzEjo0W0Emv4Hg94Dx9PsSxyisgZPAGJE3w/PhyY/ktZArC3/JqPAsaVceG74R5RjXxjZsjEAocg95rDxQ8KxdTGRP6y1V9zC7JMahk1f5KyAIpG0iKb/zFDmzretP1mSCtHBNtniBFeb15CqcMUjgVTzADqcxIH8yxUtPhkZ0YnZ2fmAQew5KLj+WtlOLP9+i3EkSTWz41oE845qHoORSASEItKNVHBbmTO8r/rXoN+s+GZzJDd3HKN8rkaW0X9XN4ZryChNaEkMpf03HV2VqKN7tyRNL9rF46q5+oGohYSLRqCGxsrOVGSbKzlbBn4TovlmkEfFF0kaY4HHf5dH2kIy7NsQtB2S7eUzSGKdg00vY/EVFavGoii3ipuK8l355BOVSQ1xMc6X3sJVLsmRaLKdoCyiYmcSK2Cu0Ftc4MB5MZlpQzdxtYbs1VnL/wj6Lz4b00GXlhtqWyq7FJL7BdIi1JuxvQGTH6TNzeokCLbuTqNmM9UGcwpTLtQNY+tYXT8MlzZS2piHTYAM7tWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(366004)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6512007)(53546011)(6506007)(2616005)(478600001)(966005)(6486002)(44832011)(26005)(83380400001)(2906002)(5660300002)(66476007)(66556008)(110136005)(54906003)(66946007)(8676002)(8936002)(6636002)(4326008)(316002)(41300700001)(82960400001)(36756003)(38100700002)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUhac3REVjJPeGY1Y1ZwYkZoRm9MdStxWlVMLy9IaG1uQk1nVjg3TUREbUx5?=
 =?utf-8?B?R0xXajVqU21HSWd2L2xwci9IdjRaREhLNTVaWVVsbjRscGYreWRsUW9zT2lY?=
 =?utf-8?B?SFVubW8wdlBNYmRCdFJaTFFablE5UmFJRmFydXpUcTJJZE8wUzZUbnNUZVYw?=
 =?utf-8?B?d2pqVDhpQ0lLYmFKcWd2RU8veHh0M1dFMGdPdEFFb21pNGFrdmU5R1hWOFJw?=
 =?utf-8?B?Y3dQcExLV1JsN2hsT3p1VVBFbmhDTXZhNlpCcG9iVU03NEdqTWIrRVV1NVd4?=
 =?utf-8?B?K2ZvSVBKcU9aY2k4YmFaUll0aTZ1RXFGVElGV2tZeWFvRTBieFhpRUwrVEFX?=
 =?utf-8?B?cXJ0Qks0OXZJQlgrVVoxalcrWHJRUmhCMFNrTXBaMVJBOGs4NnRmSUhlYkJ6?=
 =?utf-8?B?TjRHMENtcXJKRkFpUElMUnF2N3g4cEhWVFk5MnpobnNMT2xIbDFxSUZHNlRC?=
 =?utf-8?B?SHRnaXFOTkhmQzNIVTcyRVR4SmtZTUE5c2wzdERuSVhubEhGbmR1dnd2djcv?=
 =?utf-8?B?SEM0K2pidEx6cmkwb015dWwzb2MwanZweGdYcU14dSsvc2h0cXNyY2dCUHN4?=
 =?utf-8?B?UWlMUzIybHhjbHpYZGtsOXcyQlVNR05uWEZnVTAyOTZSckNIQWgwQUQwUWhI?=
 =?utf-8?B?TWRyZEtvYlByN3ZyMlRwSmhGYjBubnFmNit1T2FVcCtLVEJrQkVMTEh1TXoz?=
 =?utf-8?B?RkpNdGRVTEQ3QlR4ckkvc0RuVjVEL05zY2R5bEZ5UHIzWDBzcDdVakxxeVh2?=
 =?utf-8?B?V3kvb0w1SExhUEl5MjFqK054Mi9QbkI2Mml5OGZWL1d1MmI3ZjNxWU1oNjZF?=
 =?utf-8?B?ZGQ3aGRYbXFvNytFM2xjQ0N5TnpXTHIxcVBYNG1PSU9BaUt1ZktpV2pZRjYw?=
 =?utf-8?B?NEhoUzhFMzR3anRsQ0o5YTFYamR3RkQyMDFvVlQ5ZFdYdWVMaFpqZU1BS2p0?=
 =?utf-8?B?RXBIRHFFMExudHp0VWlLNjc3UU9LdzEvaWJrU2JENC96RWdCUW4rbG13bjZG?=
 =?utf-8?B?Si9OOStTSkovYUpjT2VPcHIyMVRQT0NKNEg1VjIySFJSRUVqVFQvTGpjRWNV?=
 =?utf-8?B?WUwrc3ozS1gyWCtOWXVZZUpCSFBmVzNReFRBMysxazVqR3JmTEhHekJYMnFQ?=
 =?utf-8?B?M2N2RXM5SmF3d0VQd0luSUF3V3FtZW9LeGZrdEFmaVlKbTlnZDdhTzBNTWF0?=
 =?utf-8?B?R0ZhcWxVMEFFM2pZcVhUbmNCa05ucDEzSFNxMldRUWMxMWZFN0gyZS9BNFdr?=
 =?utf-8?B?SmhRR1c4cm0zbHE1Q3ZDZUdxMEhIdDZ3T0MzOHVRSkJMdDU5VmdveTNNMGdt?=
 =?utf-8?B?TkxJUkN3Z3dlbVV4MUxTdG1OMGxGcGc1cXFuM3JuQjVLOU55N0x3elhHdUE5?=
 =?utf-8?B?YjVWWkpzbjJWUUN6T3lkeGVnVTlOQXVoUUxZYXFYNGN5aFB1QTN4QnJjd1Rs?=
 =?utf-8?B?QWtNZS9jeElLYTZCOCtzNSs0aUFKVnROS29ETDFsK25Oa2xIRHF6L29nUk54?=
 =?utf-8?B?L21uWHkxRjdQY2ZUcGk5bDl0clZpUTJWM2cwWjk5YVJCZVRWOVFnSVpyZE5D?=
 =?utf-8?B?Z2VIZHcxSkxIaFltOWd5STNLRXM0Sm45SW5USkFmMk12ZVVBZlFJK2FLRUVB?=
 =?utf-8?B?YllpVDAyU0psTzBLVlZ0Y1ZDeVdBcDl1c2hLdXRwNmc5ZGs4bUFocmkyeEQ1?=
 =?utf-8?B?VjN6SG5qWVN0dkVWMWNFRFJ1WnpIazN0Mmd6QzhuUVAwRTJCWFVDSWF5UXQ2?=
 =?utf-8?B?YnMxMnY5TVIrcmwvbndreWxNUEt5Y0lObE1kcmFuaTFlS3llKzVVdk8xZVAv?=
 =?utf-8?B?ZUNpbkhNQnE5b3VZUjZaV3B3MGh2VE02NEFSWkx5aWh4bFd3cEs3ekNocUFz?=
 =?utf-8?B?eVdNMDhqbDhnaDd2QnQ2UVd2VjE1dzdjVjlLMFNTZktZS3g3cmJrVnVHdjhi?=
 =?utf-8?B?MmNmM0EvNk9IRW1hajg4aVJzRVVDRW9Sb0p4eFpJb1ZJbFJ2UC9GRWhCNEJM?=
 =?utf-8?B?Smk4Zm9LTkl3YjFMYUIyUzRyZ2NIdDJmZml6VUxlZWh3ODhRKytzejFGaGNj?=
 =?utf-8?B?V2NrQ1VXSFFFbGt5b1FOUFBySWVGLzc2OWpZaURuUTh0VWh6aktORjdaekw4?=
 =?utf-8?B?SzlSb2t5cmJGSnN3RjFQczhaK0d1aENpa05ZQkcrTjZaTzdNNXplYWNYaEcw?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7c129f-653f-4d53-2d53-08dbc9afa426
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 16:40:41.4989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0awBkg6rfUpaapi62BeyVCVAWNEbF2/7duXawr5igPuBcniu+h59T1NXDaWPDStcvgBdZui391d83gw7wDjteRs72/kUTs8+h1TshmPEXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8761
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

Hi James,

On 10/10/2023 8:25 AM, James Morse wrote:
> 'lo,
> 
> On 06/10/2023 22:03, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   af95dc6fdc25e616051d0234aad638e15c02ec8f
>> commit: fa8f711d2f14381d1a47420b6da94b62e6484c56 x86/resctrl: Pass configuration type to resctrl_arch_get_config()
>> date:   2 years, 2 months ago
> 
> So, recently.
> 
> 
>> config: x86_64-randconfig-003-20230909 (https://download.01.org/0day-ci/archive/20231007/202310070434.mD8eRNAz-lkp@intel.com/config)
>> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310070434.mD8eRNAz-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202310070434.mD8eRNAz-lkp@intel.com/
> 
> I'll float a patch fixing all these - otherwise I get the blame for the whole lot when the
> code gets moved!

Cleaning this up is already in progress. A fix from Randy addressing a few of the warnings
has already been merged into x86/urgent and Maciej has a patch ready addressing the rest that
he will send upstream shortly.

Reinette

