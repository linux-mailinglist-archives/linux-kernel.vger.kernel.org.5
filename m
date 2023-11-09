Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41257E708D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344767AbjKIRmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjKIRmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:42:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23513D58
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699551763; x=1731087763;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KBBOecATKBiTLQeDJaD414uk7sPY9QF5F4V+i9/mxUg=;
  b=WDGJXqlRo8+SG4TjBwiwpsJS7oXOXQ+6iXr8j+19sou3e7T9W0a/hRwT
   kyVZXWOHRQ0OB8XmbSp+7EbGKlG0ZAv+94Fz8iu1fg32U/lMAQ8ADMdPv
   /Cs4omBurYcc9KoZqoPNoHRn83r+1oeBX7HGWDtLWdcPIg0nMKHUqXYol
   1Up3amU6iPNchKbkvxhvK6S+dk4KksAk6WmXbSsrYB/7ivPPsWtaI1+Uh
   TDA3P+557b6tuH1e8uhL+jvJTiC7heQCSnB46jD3hP2VtmnxjD9a3MQpG
   gV7DG53yIPCKcKklAT2fKqFlk2mKAKeGE9K8uHFAtWDNGEHe9htL6ntzD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="375075658"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="375075658"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 09:42:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="713390646"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="713390646"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 09:42:41 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 09:42:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 09:42:40 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 09:42:40 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 09:42:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFpvQdWsXUeA/KBaqzgRmYUMxtsY2xeQ32jCUc2NH8Z77McLKc3OJOCGvaPuk08l5HD73Kjq6HXCcrFvLpTiX76eulbkO8BryCSpqFqqghlEy/K66/HVWnBzuWbYmbydmwXviTTgpBpEGD5hvHSYwYGlHZU/G+Czevz5fBfQaErfTGDh8k09bePw9Y5AUbUuyHvqfnkXcfNaEETy4ZZu93uY/OM/8gpgLycOef1z1XjpJBK5cY5FI1GclpySBFcDktzvLxF4DXdSWd1lSNJYyLGoLhewFyk6J/XN3dC0Cd6a8wyqxlWb/PhT9hR0T70HPQMLla1Wi0m7r21MbXDbeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyoT7OU9iCgNtlQoZuOFJ4w0MME41OZDlXzpcmaEBsI=;
 b=ni3weIV5gKm2W7LmzNnlNgaF/Ui/U6FeLMUkWBZbfIn6r/IY/I56Sot+Vc/rQgBV/0W1xr+qbeZ66ST3bcu5AAfPgEAbcPgSJRvmmEoGfkw6YimJ6Xfy8Jr0NIFQAcwbSB6XTkswTCVgEJIlta80VBxL8afWlxDXpv9CAy1j6J5/SqwCCBq9Ch75zi165shifDO8ty1tWxGZ5o6ITIctCTFnz7Oo4JIbXfQsKTXfJME4GEE3AlwOfHOECN0EuVf7t9roCVtX64gXXnVHR/wOvhidx4kw0xi8EE3EGYXImEe2KtWOxe4xvoGRTEJPd27tsLfKOdL6iO5WdRj5U2oh7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4707.namprd11.prod.outlook.com (2603:10b6:5:2a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 17:42:38 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 17:42:38 +0000
Message-ID: <ee2cd6ee-4dd5-4505-b059-b65f030a1e1e@intel.com>
Date:   Thu, 9 Nov 2023 09:42:36 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/24] x86/resctrl: Access per-rmid structures by index
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
        <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-7-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231025180345.28061-7-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0225.namprd04.prod.outlook.com
 (2603:10b6:303:87::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4707:EE_
X-MS-Office365-Filtering-Correlation-Id: 378964dd-e8d6-49bf-5a06-08dbe14b43bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Y0VtOFXKDnuKvlG4MwSZWD3wX1W/ftiNinktqWuq4iAJWEGDhfWt7X2yA6sPWr/bGEH37cqf5Q65kSm8vzt87LxsgaIlxFWLeKM7tEZ3d5OJJUZFRL2Cdyg/tC8txQP9pG18XbKQ8ZmdrMWd5PdZtioykWwKEoyt1yPo+zK4kDQuSNuCX4ArsEKp2MSors4DV+wiBOqWu+s4boDcZAwC89szzymi2JiM6dCxbXtx4/mP3tkWjKvhn67K1EXPpCLaY/uFf2qu8V3yBhXojkT41A36MfCA+RLwY/PMSL38c2nIpgFBbih2Rl4pA8X1qzTXbz3Lv/gLVGnCjhMrOAnloKD0pcjPwXU0c3OTd1TbaIaw3ssgyoFSKNVMjckWqHYsT4liGP9OwQtiPF4/Itw2q15xP9JB/AkRSpd5SuId9s+vOKgzj6M60qQOyvIUHjMX/DBOuIi0pjB5tNygElOKl1qjatp6KVUhv5/3XXGcQUaDBnFLV5yQpGsJrzOC5/0X6YlPANwXB3gjNE+PydBHCutTZzA8uT8arnzf9exUPLabHQz57f048VSGPON6ZPZ41b+ZwujBPNFdVMuCvL7QLZ4nTKJ+7qDSWrvzj0faOKh8U2lbmZUhpK32EnmlSSigOCKh7wWKVr71xbCMdxWBF300u872S+I6XF5SwaX5JoaMD8PgdLdeQ25nWZCv59h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(230273577357003)(230173577357003)(186009)(451199024)(64100799003)(1800799009)(31686004)(54906003)(38100700002)(66946007)(66556008)(86362001)(31696002)(36756003)(66476007)(82960400001)(83380400001)(26005)(2616005)(7416002)(4326008)(6512007)(53546011)(6506007)(478600001)(2906002)(6486002)(316002)(8936002)(5660300002)(8676002)(41300700001)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVVkNXdiY3J1ZVQzcGZNUjNRbDY5VHgvOTF4dWN6RjdiU2FWWjlWa0lSTlBv?=
 =?utf-8?B?OGFVRm1ha0NRc3Vxa0cvQVUvOFRKL1F0OGZGWnVnc0ROb3BWUFl4RHhKYUtm?=
 =?utf-8?B?d3prcTlESmFkd21IT084d0Znamh3VFk0NDlYa2cyV3k1L1YyeHlmd0JySWs3?=
 =?utf-8?B?OUpSdVk3N0VSTWFJNkhOQm1iWFlMZlJDTTRWb0I2ak9sQ3dCTmJueWRGMmFj?=
 =?utf-8?B?S2YxQmJvbDlKcHd5SFB6YTVvUlJ2TnVFajh4Um4vZFhYaDVUYitVbC9mU2dN?=
 =?utf-8?B?VG9ZUU4xUzkzUStteXpZb3d3aGk5cG51Vm1SMENhd2tzT2hXQXlFSVA4OW8r?=
 =?utf-8?B?RWppT3E2SlA2bjI4ay9RSVpaajNvZFRNNlM0YWt5aHh1S2xrNVN6eXRuak9v?=
 =?utf-8?B?Tmc0SlBGaDBQaUNWa0RWYklMZjBqbEtVdFN5bWhTVEFrRVhGbTk0V1czSndK?=
 =?utf-8?B?VDZ0Q0tHaWRwZS8xdjlKeFI3UmFnZmhONDN2b256UzkyWithOVZmbitDOCt5?=
 =?utf-8?B?Rk10WkViY0ZrV2wvTjlkNlBWWXpjVExscmJjM25UMnhFZGt2OVNKclIwTXJ6?=
 =?utf-8?B?NXBtRzV4aUVkaytDWWdja2ZFM24wVlNjOGlvOFpsa2VIZ1VYMW8yTXNZQUF1?=
 =?utf-8?B?b1hqR3RVUmxORTc1QnhiWWh6SWl6T0hTR3g1a1lVVTNMYk5HYXZjVEl6Y1NB?=
 =?utf-8?B?M0JoRjE0RW9RaU9UWExpNnJhQmo3dXlIUStKS1grMEhZN2hONmFiUXIzaGV5?=
 =?utf-8?B?Z2pFM3Q4Y0szQ1hsVThSYzYzV2tia1JtWk16MTZycGNySnl1SDltb3hweU9K?=
 =?utf-8?B?R3RjMjQwUS9uQ1lMclJYdVBWcnUyMnFqRGpOczYzN0cwRzhtUytmZHlNSDJk?=
 =?utf-8?B?eVMyTzkzM3Ftc3NyOENTN0RzU2hJd291emdSWmlhR3lLdDVuZXRFVTVZMU1w?=
 =?utf-8?B?U1JuVXQ5U0tnbHpKc0Vtc1RyMWlQUGpCT2h2UmRVU1psU0VmNWJoTHkzVlNj?=
 =?utf-8?B?cXhXTkZBbjk3eHhrN1djMHFoajVOYTBUOTBDTDdrZ3VMZFJWNWF1TGg4ay9R?=
 =?utf-8?B?S1FXTXFaeFNHVGd4S1M0K3VSdWZvQ3RONENSdzlmRGU2eUh4MDJKcVNXMzN2?=
 =?utf-8?B?emtqN0ZFSDR5RlA4YVR5SW1zS1RYWW1OelZmaGdxUTM0ZjR0OFk4MlNjMXpw?=
 =?utf-8?B?RVp0ajYvdGxKMU1wNjIzbFFqRHZrQnBuaWQ4MW80RlBPM280Y1NYbVdEOXRP?=
 =?utf-8?B?YVNaWkNicW1zTDFqOG5ITCtBRldXRHMvSlc3UnM5Y1Y4YXNDNkhmVVdNb21v?=
 =?utf-8?B?UWtGdEcwM244M083ZjcraUI3LzhTck96a0U0UU1Db3hHU1pYbndmQWF3RHJL?=
 =?utf-8?B?dlpxOHBvcC9YZ29RT2pCWWkwVzNJSTdxSzRKM1M5NEU2V1pSbWJzdTl0SVpQ?=
 =?utf-8?B?SWdjcFZOdDZYYkZtVUpQWUczTkJlMkpLM0JTQkRTcWp6dy9aNmpCT01pYldp?=
 =?utf-8?B?OTY0NXRKVWd5UmZ4TWZJL2NXbDMxZHJqM01lS0Z6Mm91MTlFSG4vYTl0Qmow?=
 =?utf-8?B?d1g1SGRKckRsNXRZM1kvWDdMQjZUc00zMEhNZFpWMldOaTNGT0kwUXo3bm1H?=
 =?utf-8?B?RDBKMTIzNm5ONEJuZ0dnS1dMeWZLeUxiRjl6NXhBYWlMRnRuR2lDUjluZVUv?=
 =?utf-8?B?aWc4T25UaG9meG5PVWVDYjI4YmJmMGZDS1l3blBwQllMQUtOMk42NnpiT09r?=
 =?utf-8?B?bk55V1NSM2ZRSU0zZDZJS3BZRkc1TzRsNVpTVVcrRmtYRjZlc3VYRjlRRVl0?=
 =?utf-8?B?eitFaFI2MmN1TlBERW80bFMreHNnakRacWFwNG5EYmtSSzlaU0dYRlV5NHhJ?=
 =?utf-8?B?WWdmYmlhczMzOEJ4L3VKK01VYTcyUG5ON2NnbU8rb2hGdFp1UEtLOFdXQ1FO?=
 =?utf-8?B?MzZVcEdvMnlraEp2WCt1ZWp4cVZqY241RHZBNWVIbWR1bmZMMGI3S1VGeEsy?=
 =?utf-8?B?RnpseW5RYkFjQmNzL2tYWTVSQ2NzcWc5TGp0eW9LZjArcTN2bll0aXkrT3FY?=
 =?utf-8?B?UnBGUmNXL3dUL2FqNnh4VUxhQXNJei9UYVZMeDRKQ05YTWxTYU9WZENsSS9t?=
 =?utf-8?B?bkVNQ2VsdzVWVjlFa3A5cVRtMjBybWpNaWdMK2RvWDE1SG9LUElvUkw4TWRx?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 378964dd-e8d6-49bf-5a06-08dbe14b43bd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 17:42:37.9653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIaJy6mJZwzZoxHDpFYKku5FtuizCBKbkkNOe/ERryqn+U8MJF3ueq/rMCFJwCGXScxqBANHiJxAN9DYQDmbb6gtoUjazkR1hCuHlF7EcWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4707
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/25/2023 11:03 AM, James Morse wrote:


...
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 0056c9962a44..fc70a2650729 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -589,7 +589,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  			mbm_setup_overflow_handler(d, 0);
>  		}
>  		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
> -		    has_busy_rmid(r, d)) {
> +		    has_busy_rmid(d)) {
>  			cancel_delayed_work(&d->cqm_limbo);
>  			cqm_setup_limbo_handler(d, 0);
>  		}
> @@ -604,7 +604,8 @@ static void clear_closid_rmid(int cpu)
>  	state->default_rmid = 0;
>  	state->cur_closid = 0;
>  	state->cur_rmid = 0;

These assignments can also use the new RESERVED defines, no?

> -	wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
> +	wrmsr(MSR_IA32_PQR_ASSOC, RESCTRL_RESERVED_RMID,
> +	      RESCTRL_RESERVED_CLOSID);
>  }
>  


Looks like rdtgroup_setup_default() is also a candidate to replace
hardcoded "0" for closid and rmid with the new defines.


...

> @@ -670,7 +703,7 @@ void cqm_handle_limbo(struct work_struct *work)
>  
>  	__check_limbo(d, false);
>  
> -	if (has_busy_rmid(r, d))
> +	if (has_busy_rmid(d))
>  		schedule_delayed_work_on(cpu, &d->cqm_limbo, delay);
>  

This change results in a new compile warning:

arch/x86/kernel/cpu/resctrl/monitor.c: In function ‘cqm_handle_limbo’:
arch/x86/kernel/cpu/resctrl/monitor.c:805:30: warning: variable ‘r’ set but not used [-Wunused-but-set-variable]
  805 |         struct rdt_resource *r; 


Reinette
