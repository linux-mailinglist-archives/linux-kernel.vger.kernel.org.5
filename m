Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F5578CD61
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240425AbjH2ULf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240381AbjH2ULY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:11:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17888DB;
        Tue, 29 Aug 2023 13:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693339881; x=1724875881;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I3nZdqA3mfXgwSpsA+zbyhJUMgfiaB4rPp5CXSXmQt0=;
  b=YjJDTg99yX2cyeQbNRWgdy5qT2DqXIVPWalyGkdXBvYuI+fl+tggzciw
   xXU8dhUp6gMuE4W57vLIrJZQXKuGS4w0yjGTcYbS7g9JcP+eKAgSSlRgG
   //JIPN6jdwWFtho7dzvqWPhyV4GeVn6Zvaox0Em2PmhMcCWaeRHqff/io
   TT0xmHOitT/VOWM2HYE+REIgz3Z8eDOtIg9pLuiO1dfdXy2NE02miCW83
   Q7moIK1BJ2bfUkXoJiq69D54eR4tWcvidNiQQAWWI44mJ8fKeGekYlpaZ
   LCKZ5deE/mT6iFnKij9tg/KZT8jWpjuWBGPiZGVp3mY2beX9tvXJZRBYC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="372880054"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="372880054"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 13:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="862349773"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="862349773"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 29 Aug 2023 13:11:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 13:11:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 13:11:17 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 13:11:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnPbJWqu6VEW6iTWbr9f8LVZ886O2XMA1jndI385N7XAUIT5XzGZgLxkAkzYcXaSe+9KZJoCoCPX0AXfi1vz/663Xyp9ixXjaHU4fyzZpu0/2/ocDwx9FYePF60/SnzWOVos4MGCSzAOzepKwA1T55WV/0p6UEBlGoyjB8ffKwxjkocOrvTwoHHb0rVTiSY/ZAkbs3xp/S3do+lR9mANsmMZxJup455/q3LSU1I7RYoUydLeyjC8OQgMTk5TICp9IAJrokyEOzvOpmQp4Fi0IQoFuzBsY33coa+sh2SxhuXXSCXdtPWR3WPnN5WwfdGGIo757Ei/OUflnfxzyrLwpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1myvPDweN/cW+wnwHZEN+5blQNNFXlxeN1S54Pyio1E=;
 b=b+uiz+8y8IfTrm/GDUXIf7yiXAGp3ay9RwZOSk8voSC71+/iD/z2fcno6BT+rRvkWbxBnaOZPQGqWtfkOCMv/mM7vayu79gvXXxFwzSRGgvpwfkvknWIECphjHn+uP8AssELrLgkYe4W3KG8Q/HvUVTBzLhXi9EQ+37Lr+b13DM3cm6ZkW2ovV42FrqQCcyWIDKjsh4h/iktRGFalBSsqamMSo3/vE32F2ywqH6eXMnhgXpxy0omXGOvoaTw/9lusMgq/Ec7BKdeCy6vdZ8lJeVdQ63E6XVzu5frqdWAtfMYa0WgY9tu467bMO7TQjTXpbe5MaIyrz9XSZt4PNLLmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7002.namprd11.prod.outlook.com (2603:10b6:510:209::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Tue, 29 Aug
 2023 20:11:14 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 20:11:14 +0000
Message-ID: <972db626-1d74-679d-72f2-3e122f95c314@intel.com>
Date:   Tue, 29 Aug 2023 13:11:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v8 6/8] x86/resctrl: Move default group file creation to
 mount
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
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-7-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230821233048.434531-7-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: ff602368-e31f-49b0-5096-08dba8cc187c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p4h5BJpLNTiBWGsUzqQ08kNbKXDZPcD4fjPxgCNOk4th6ZG2EEYBPwRvy5Th2RKCd1R2a+MI9Yw36sIxyFiZ/LKdZQjzNt9wI7zgus/7agFGxh3ziMAdJ+lxJD5iaOsv3ojqJzJNld8bIA7ZvliTbS31EJLyKtTXnePpCfohpr0ct29xBrpmlUZ/F7lRfzAWqiuORxFuTmtk91On603Ro3++JPGV5VaIZx8saRsT9DNXvc8R/OxFFu3VGG6ZboLyeBkm55JApbfAl5IPW/4vXDuHgb5pmUS0pd0KEXO+EBi0+qphmfe9eTIal9tgydR0hZILc3bH5H/CfokPSh8pldBFzR4qaFCH3wjXq/ZVLvBOayS6G/rERYdEkoalLVj2YXVzuaH+/6NR8DOHobGCD53/8LHKhmqj7Vuj7bX3cETzhiEUbZWjtZg8x9RR7+JWKZd9qDF9a7Q8hi/7xU5joObOZqvMyA2/y42qwxiQJs7ps4seEBhUEubE24WjRqd49dXSBB/2yhv51p6zqYcFFCAMv+LArx79GknJkv1Uj1aek6b7LIiNrGAy6khD+WAn3XobjGG2nzzEY0y1gFXbMB+VCKnNJLAshEzru2Kn2zNS/J0SChZJ6uFsvk2hSW9s3S0gTzJiXkR5jz3UKJz6sQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39860400002)(1800799009)(186009)(451199024)(8936002)(6666004)(53546011)(478600001)(31686004)(6506007)(66556008)(66946007)(66476007)(6486002)(316002)(38100700002)(41300700001)(82960400001)(6512007)(36756003)(26005)(44832011)(8676002)(5660300002)(2906002)(31696002)(83380400001)(2616005)(86362001)(7416002)(7406005)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnM0QnJ2YTdldEcwSG9jUU43MGlaOTZya05nSEtvWklvdDVGR2F0YUhrWHRs?=
 =?utf-8?B?YzdocDhDQjR6QVJrTHJlUmVoTFErUFdBdndkckFDS1IwckFRREdnUkNxTWtW?=
 =?utf-8?B?NWowb3J5L2RlQi80TkZUSURqQkN5OWpPdUJrdEs3SHlhdzVSdlVjM2ZjMVp3?=
 =?utf-8?B?U1FYWnhUME84MW53bklLUW5zZ3RUS2E4b2JlR1JablpTM29kNHd1eGd0elR2?=
 =?utf-8?B?MWFBOXBPQ0pUOEVLWHdXeHkrYUZCRnNwNUZGd2JnQVJDVGszZTNNSlU1WmJL?=
 =?utf-8?B?MWo5bEhRcHJrNnVtR3NVTHA2SSszOFJJaDUzOHNNM2RXWVo4MFhyaFpoYnVi?=
 =?utf-8?B?Qm5PVDFQR1U1OEp1akgzZlIrd0crMnFRWVM0b28zbEZiVU1idENZQUd4Vmti?=
 =?utf-8?B?c0IyNzEzK3pkSWx4L3NTbXZHMHQyYWNJMUsvSmhOREttd0RDTGU4MUt1WWRa?=
 =?utf-8?B?c1R0NTJwZjBYMFh3YU8vOFRId2NBdkY4QTZId3pUMmhLVmEzS21mQllkTnBV?=
 =?utf-8?B?NStKcUNBUUVTcEFtc04vTXFKQVpyQ2l6c21SV3NwVXVrK1pKUU5jci83WHlK?=
 =?utf-8?B?WjlHUXR3Vk5tTFQ5a1R4YmtCRytYYWxaZXFUenFtNVdlSGRnWk1FRGl1bDYz?=
 =?utf-8?B?MWV2WEM2MGFHREJHa25WWUkvek8xY1NNc0s1RzlIaXNMTE94a1IzclZvOUJ2?=
 =?utf-8?B?alpwazR0M2FJd0NKOTJTV3dGYUJ1VmdSQU4va2dTQXRjZFFLOXllMzBVZkhw?=
 =?utf-8?B?bnVxM21BZ2UvWkpSOGFXb3Qram03WFE3YnltQVJHQi92eWVwMFlhU21DVmVl?=
 =?utf-8?B?SkpaWjh2UUlXRDBSWXd1K0U3S2o2Rzg2TXAyVkxCbDRJNVFGenY5VFZPRDhC?=
 =?utf-8?B?M0VGbzBnUmVnWTVWNmFyTmRhOEh1L1I4bjJaaDhqMWdWMXF1cnRJUm5iTTE2?=
 =?utf-8?B?ZUpmQlZmcEZ4UU1keG1aSEc1RC9jK0VRTS8zbU9WK0xqd21rek5YNE9PREl5?=
 =?utf-8?B?ZWY4YTI5bG5NVWVua2ZDZTVscGNhaW5tNU92cFFxc1F5YTkzMlV6SGFUQStI?=
 =?utf-8?B?c3hWUGhJdUZTNHFXdk9RdGJ5Q0ZhUlI3UUdtVW9MdHo2aHo3b0N3MjZMTGc5?=
 =?utf-8?B?cWQyOXhVeHRmS2E3R2szNE9QNmNaV1k3a1h1MWhQY0U2MVRmTkNzTmpqaWs4?=
 =?utf-8?B?YndnYWltVFRPVnNocDFXV2lxaG5GcDJSSEZxSjU0ZVdNaEMxNTE4TWo3OExV?=
 =?utf-8?B?OGtwbXdxUy9udVhuWG5XTnc1dHBha1N4R21GZkgwRG5uNUpjMWF5bWlOR3lN?=
 =?utf-8?B?ZHlZYVN5RXdLNGorelRsckhEbjBYWktxMmFGSWpDRFBPNG56US9MMjBDbmVE?=
 =?utf-8?B?TEpSYTlLcUFqYnNmc3hXNmNZR0RzMXNXVllMU25aUHh4ai81RWdBZkw1WXFC?=
 =?utf-8?B?T0ZObjJEd2Nxdy9VV0tKWE9kVXo2Z295enEzc1Rxa0tQT0syM0Q0WDVyQk42?=
 =?utf-8?B?dERYVklRR3ArNU5ya2o4VUxCZ3NYWUhhZGRMd1lJTzN3ajY1bUxvd3pIbU9S?=
 =?utf-8?B?Szk2b1EvS1phUTlldElXbUNFNlFsKzNHMkcwNk5Kd3dXVy8xek5Eb2k2VTFR?=
 =?utf-8?B?ZHdaUUdKVFJCbkFIQnFBbU9Kb1V2bU9LRkNHU21Cc1BwQjdOMmJndzMyY2pa?=
 =?utf-8?B?cGx0SFM5OXlmc2VsZ1MxNWExSjlkMlNMeXlRT0FVS3J5UmVGcC9tOGtMMVV6?=
 =?utf-8?B?M3ZsYk9ncmFmVWxrdXU1bUZ0d3lkTlFYb2Q0VklJSjNBMXlzbnNra1AybFdE?=
 =?utf-8?B?VDF3dHVZb2tDZHhrYUlibDdtbS9GUU1NWHpmdXM3Y29KODUvL2NIamc4b3NB?=
 =?utf-8?B?bWpsRUQ5RmtFVkZtRGtYSURZdFNjQi9Wei9KZGtGYzJZbTRweXJRVDJueTJK?=
 =?utf-8?B?RUovWjkvV0dJazhEQ1ArRVZDWFBRQ09mQnAwZHVIbzR2aitWMlV1TlJXblp2?=
 =?utf-8?B?TVZFTWpKSGNYc1hmT3BUOGtpbm1xZnpvQUJ2YkNUajJQbzRkQ1p2VWowdDNE?=
 =?utf-8?B?MXVLQTZWeGhLVjlYTVFRdGc2R0h2ZnVDVm9Da09Jc0cxRTVYbi9MeGFLajR1?=
 =?utf-8?B?U3FBdXZjRDJDbURWK0dvb0MrSnR5cEs5N0Nyek1POWRRU2d2THRGbmpkdG01?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff602368-e31f-49b0-5096-08dba8cc187c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 20:11:14.3151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/RlzHrPdFIWx5wn4Azkh6Uqke8+ChcOFRWQSFNOzp8ym36Iv6H8o5Kxj7TS4j7b0KjAicbNtztB62bD9p48yvjqq7VIa5VyGUCzPAFNGsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7002
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/21/2023 4:30 PM, Babu Moger wrote:
> The default resource group and its files are created during kernel
> init time. Upcoming changes will make some resctrl files optional
> based on a mount parameter. If optional files are to be added to the
> default group based on the mount option, then each new file needs to
> be created separately and call kernfs_activate() again.
> 
> Create all files of the default resource group during resctrl
> mount, destroyed during unmount, to avoid scattering resctrl
> file addition across two separate code flows.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  2 +
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 55 +++++++++++++++-----------
>  2 files changed, 33 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index b09e7abd1299..44ad98f8c7af 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -611,5 +611,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>  void __init thread_throttle_mode_init(void);
>  void __init mbm_config_rftype_init(const char *config);
>  void rdt_staged_configs_clear(void);
> +int rdtgroup_setup_root(struct rdt_fs_context *ctx);
> +void rdtgroup_destroy_root(void);
>  

From what I can tell these functions are only used in rdtgroup.c.
Can this export be avoided by just moving these functions within
rdtgroup.c and making them static?

>  #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 80a4f76bc34b..98f9f880c30b 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2516,10 +2516,14 @@ static int rdt_get_tree(struct fs_context *fc)
>  		goto out;
>  	}
>  
> -	ret = rdt_enable_ctx(ctx);
> +	ret = rdtgroup_setup_root(ctx);
>  	if (ret)
>  		goto out;
>  
> +	ret = rdt_enable_ctx(ctx);
> +	if (ret)
> +		goto out_root;
> +
>  	ret = schemata_list_create();
>  	if (ret) {
>  		schemata_list_destroy();
> @@ -2528,6 +2532,12 @@ static int rdt_get_tree(struct fs_context *fc)
>  
>  	closid_init();
>  
> +	ret = rdtgroup_add_files(rdtgroup_default.kn, RFTYPE_CTRL_BASE);
> +	if (ret)
> +		goto out_schemata_free;
> +
> +	kernfs_activate(rdtgroup_default.kn);
> +
>  	ret = rdtgroup_create_info_dir(rdtgroup_default.kn);
>  	if (ret < 0)
>  		goto out_schemata_free;
> @@ -2584,6 +2594,8 @@ static int rdt_get_tree(struct fs_context *fc)
>  	schemata_list_destroy();
>  out_ctx:
>  	rdt_disable_ctx();
> +out_root:
> +	rdtgroup_destroy_root();
>  out:
>  	rdt_last_cmd_clear();
>  	mutex_unlock(&rdtgroup_mutex);
> @@ -2654,7 +2666,6 @@ static int rdt_init_fs_context(struct fs_context *fc)
>  	if (!ctx)
>  		return -ENOMEM;
>  
> -	ctx->kfc.root = rdt_root;
>  	ctx->kfc.magic = RDTGROUP_SUPER_MAGIC;
>  	fc->fs_private = &ctx->kfc;
>  	fc->ops = &rdt_fs_context_ops;
> @@ -2824,6 +2835,7 @@ static void rdt_kill_sb(struct super_block *sb)
>  	rdt_pseudo_lock_release();
>  	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
>  	schemata_list_destroy();
> +	rdtgroup_destroy_root();
>  	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
>  	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
>  	static_branch_disable_cpuslocked(&rdt_enable_key);
> @@ -3705,10 +3717,8 @@ static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
>  	.show_options	= rdtgroup_show_options,
>  };
>  
> -static int __init rdtgroup_setup_root(void)
> +int rdtgroup_setup_root(struct rdt_fs_context *ctx)
>  {
> -	int ret;
> -
>  	rdt_root = kernfs_create_root(&rdtgroup_kf_syscall_ops,
>  				      KERNFS_ROOT_CREATE_DEACTIVATED |
>  				      KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
> @@ -3716,6 +3726,20 @@ static int __init rdtgroup_setup_root(void)
>  	if (IS_ERR(rdt_root))
>  		return PTR_ERR(rdt_root);
>  
> +	ctx->kfc.root = rdt_root;
> +	rdtgroup_default.kn = kernfs_root_to_node(rdt_root);
> +
> +	return 0;
> +}
> +
> +void rdtgroup_destroy_root(void)
> +{
> +	kernfs_destroy_root(rdt_root);
> +	rdtgroup_default.kn = NULL;
> +}
> +
> +static void __init rdtgroup_setup_default(void)
> +{
>  	mutex_lock(&rdtgroup_mutex);
>  
>  	rdtgroup_default.closid = 0;
> @@ -3725,19 +3749,7 @@ static int __init rdtgroup_setup_root(void)
>  
>  	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
>  
> -	ret = rdtgroup_add_files(kernfs_root_to_node(rdt_root), RFTYPE_CTRL_BASE);
> -	if (ret) {
> -		kernfs_destroy_root(rdt_root);
> -		goto out;
> -	}
> -
> -	rdtgroup_default.kn = kernfs_root_to_node(rdt_root);
> -	kernfs_activate(rdtgroup_default.kn);
> -
> -out:
>  	mutex_unlock(&rdtgroup_mutex);
> -
> -	return ret;
>  }
>  
>  static void domain_destroy_mon_state(struct rdt_domain *d)
> @@ -3859,13 +3871,11 @@ int __init rdtgroup_init(void)
>  	seq_buf_init(&last_cmd_status, last_cmd_status_buf,
>  		     sizeof(last_cmd_status_buf));
>  
> -	ret = rdtgroup_setup_root();
> -	if (ret)
> -		return ret;
> +	rdtgroup_setup_default();
>  
>  	ret = sysfs_create_mount_point(fs_kobj, "resctrl");
>  	if (ret)
> -		goto cleanup_root;
> +		return ret;
>  
>  	ret = register_filesystem(&rdt_fs_type);
>  	if (ret)
> @@ -3898,8 +3908,6 @@ int __init rdtgroup_init(void)
>  
>  cleanup_mountpoint:
>  	sysfs_remove_mount_point(fs_kobj, "resctrl");
> -cleanup_root:
> -	kernfs_destroy_root(rdt_root);
>  
>  	return ret;
>  }
> @@ -3909,5 +3917,4 @@ void __exit rdtgroup_exit(void)
>  	debugfs_remove_recursive(debugfs_resctrl);
>  	unregister_filesystem(&rdt_fs_type);
>  	sysfs_remove_mount_point(fs_kobj, "resctrl");
> -	kernfs_destroy_root(rdt_root);
>  }


The rest of this patch looks good to me.

Reinette
