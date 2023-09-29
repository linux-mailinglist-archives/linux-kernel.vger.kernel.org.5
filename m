Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1967B2C44
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 08:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjI2GVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 02:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjI2GVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 02:21:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0ED1A7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 23:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695968470; x=1727504470;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=7zabm8oG4JzzfduIlW0LTOcE7V4tGzx0uqU10R6jeAU=;
  b=F1OLKyHgeh3VHU10k1CSrMwBs7DrKV6x91VnfyNuKK71XIdI4tBG7Gst
   JQe4hgZGBHCa7225kGP7mX+qVAOFwIm+QHZiPW49XiLrq882LRE4r96iL
   F7TTEd8ebUGUNTCX/JDgLOR8JUdq1INRgbDPwSMgE276EyXH4gJwe7MSc
   fI909pBrf2g7bPlTyY4uc7Lh/IjkggmHJV0139C6/0rdELxhkxO3LqjX4
   cP8x7R75qjS1QUrU9c02TlFBwzOBgQmYqgtWwo4mQJR+PyhkP8JK67RtU
   W1ByWoc/PYCUIPplSBWW4beIUd6oZ1xlpLjYDXfDLrU9BcOv9X0cZn24c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="386105280"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="386105280"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 23:21:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="923521728"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="923521728"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 23:21:10 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 23:21:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 23:21:09 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 23:21:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIYMFAHYIFxZg5i9tBdRLyslXj26YkVSL4r4nenwuX7e1xVBb3DvpbGmxjPpPBkflib9cjE4XSStctmaWQp5K00T5AoNmxJ4R/cQLLl0gzDu/d3SDb/BN5C7dgqQSjzNISeCZ+1eMv3AfmJ5W9JmXPpG605icbVq5lCFm/ycSQ/qDokEgO7zg0Al6H4vhrPnmog728gIwA8Ce7bwS6KWixSA3tecK3Fxu5O6NhWpuV1V2yLVpEhiljHucZtmAMCcOiMB2jM8fdno1a4y9l2F7OboNnBPXbjFXwS8sNhevEeXV5jFz+bqTvBZTgpr2M/i0iqB50YuZhSqnjrxV1pchw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cg92XZpMTr/x2N8uYAZWMvdTyX23qVGCe7IRy4VOwGY=;
 b=PYdYUMFzt9fW7Z3sD/LuCk/+DfxkYUpUcJeedFJsFUv2iT1o3EgLXl9YS7GL99DeNOaLwTHuw1RSPd0JBs/NwP1seNXiyNs37B+UYNUmCPTE42BMNutwptSsWO+rvdZ0ThyhL6KH/kPiXoXfieelcjFMdEzJ8RFL6K3Yh3GLN8D0RyPWPZyYlSZ4knFws6tpywxi2Q3nkzXb9HysM7WumZhjNBx8NRhmw+zx2roiPwQjeCRhwFXn0nwrSUoZPQ1fYecuRTqvnZqINzha5WSTOLRrvQd/DBM3WDj2o/+H+zKpQyzbSE19bcO6bv32YV4KKJrZXtICDue3txl95C1bHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by BN9PR11MB5529.namprd11.prod.outlook.com (2603:10b6:408:102::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Fri, 29 Sep
 2023 06:21:07 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3%5]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 06:21:00 +0000
Date:   Fri, 29 Sep 2023 08:20:54 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] x86/resctrl: Rename arch_has_sparse_bitmaps
Message-ID: <27gd4em7og62jn4v364emkthna5a2f63nvlxigvyh4p74bcyzo@llgj56vewc73>
References: <cover.1695371055.git.maciej.wieczor-retman@intel.com>
 <e689caf9dbb7664c26515a980084b5f17cb0644e.1695371055.git.maciej.wieczor-retman@intel.com>
 <a1eedcbb-3797-dc0a-918f-eea8a58bbf52@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1eedcbb-3797-dc0a-918f-eea8a58bbf52@intel.com>
X-ClientProxiedBy: BE1P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8d::15) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|BN9PR11MB5529:EE_
X-MS-Office365-Filtering-Correlation-Id: 4339bf6b-4524-435b-1f5d-08dbc0b44018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +3RiZM2yGB0dHlz0U5B2vlvuwCd0otlSvgSK+3wOA14j/mtsZA3h9dDCKaPb+yYNiHx/uBunJtD55wFf7dOrrVnKtrgbYKpFfhtL9+SqOT7OPxebKm1Ust7uEVaHgZ1Sgz7BAb+pCBsLAn6bhkH9yFw8k0F0EmZdKtaW5ZJiFRuwayBPi+IUK63zztupdZkHfGV9Iuro8oFuvzPZKF+NLLQ67ymNzuTA1r91ki9vxU+3Nf4KILpHOywiUZLGMSiXfNGJDuCaAUoM9gQBxlx64O8apJthbwTfCddkk4O6WDwTw7fhj82P+uXEQmzvw6jK0HsfCjog0jKJmEZ0kLKt1BrNAWnScIYkIZl4HdQGqPG0e+/Jgks069Y5TufK/EDP5LVd/xoRJ4XdUe9WYdeVn7h3BhaCHBMkoe4fWeCby/L+yTb/ZDE72xLUkM3xo+uijn6OWvl/X161Hd91VYT8fU46o4c68dRL9g7Ivjl41cfxE/k+BMm20u3JFFz1g2jOPJARDuaZeNFNdy3uiaDFZV+a52an4PEEcVNT0nYxHRH41iipIM9fXsjOgn2pk7Ud
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2906002)(8676002)(8936002)(5660300002)(41300700001)(6862004)(4326008)(66556008)(54906003)(316002)(66946007)(6636002)(478600001)(6486002)(33716001)(6512007)(6666004)(9686003)(26005)(83380400001)(53546011)(38100700002)(82960400001)(66476007)(6506007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/rct5pBHoSFoHZX64pc6iGgN4bwN3ilkhrHC3lDvG1vh8tL3usZz8e50bs?=
 =?iso-8859-1?Q?+/3T1/auuXhMBj1Rqpx9rBd/zd0tw8fyDaILqTR7JBk0KVU46UtIVciFwF?=
 =?iso-8859-1?Q?v8IBbrHd0g88h6N+LqBbOm30V7FrldXAaXl2iP6sOTQtCGzmxn7NUg+ZZx?=
 =?iso-8859-1?Q?Ia4LY7B1cPGbET8OWHtF/D/MPQd7VlgZjBj28sJizEM1FXxASE67bKseWY?=
 =?iso-8859-1?Q?TBX7VwR6JH6Pj6zczbKQjy5LKXpxl2GTGekGssm2m80c64YFSm6nMnNMXM?=
 =?iso-8859-1?Q?Pe1HSvRY0U7M9yfaidafq1p1ueTz4Nyt45fi8XGD8HFiOhOn5FIQp8oTpk?=
 =?iso-8859-1?Q?YMHNuK8ywGOC6ByJ+YbJtJbc1lzms7I4Oa01t1XAL2bBeo2YTv4y3/2/b9?=
 =?iso-8859-1?Q?6K0CPi7k94MxbXSSkFz17O1WI+naTChHGOZs+rTqUVMp9FilchgFFyxtX3?=
 =?iso-8859-1?Q?nakIe2PEB7IxSg2fxJa4otmPlF3yaLWPLnHvOzR9VdzkdzxEeFgk0cTFct?=
 =?iso-8859-1?Q?OWBNyOK0ZIAfeMzSfH29kZ9BZWY7rJg2kcJkYtHrbtOXy7SmkCG2KjBTR9?=
 =?iso-8859-1?Q?P9s7pE99qykMqLdXW01zGel/2/leu8qTmhH0VcXr8z7xPKGydHVBMQE9Gq?=
 =?iso-8859-1?Q?asb0D+gmzfBraL5Z11Z3RTm+qcRgL1Wfg+WDST0xLeINEuWOqeNBc5x/k5?=
 =?iso-8859-1?Q?et0wdv6WxTqaYbvUFusKpjVdSAFIV9az3riCM2JShwt+dxU2PBjsP6tOWb?=
 =?iso-8859-1?Q?u9Ilo9vMg4R/TaEHZS8J5d8GRIg9jVGwLqDjys9dxYidgJ4BI3W1TMdp0h?=
 =?iso-8859-1?Q?/bm70T9wbP7ipXrXSOFe7f/HX0Z3B+JadIriEy6Z65wr3tiFjuhWJt1b6Z?=
 =?iso-8859-1?Q?NsVtVdq6UV4aL+d6tkvE2J3dmXWA4YoQXmsSG3Bg4H77gezOFqW+e8vzOe?=
 =?iso-8859-1?Q?F5YmV9ZJ8yhM4oLd7qwOJpEHc07QLiMcP5Idybwg4WvX/pmTz4h7XWAcmg?=
 =?iso-8859-1?Q?a54ocfmGXqvKfTGMW5VBGNfWDKJTUprxDaI+h1WaH0wxDmGvUaUjf4Sh9J?=
 =?iso-8859-1?Q?CMnY+ZycS2ou4q49ZrLZ+uDOir/J6yGXJ5ve8DeWaKaArX2hH7aWM5WN0a?=
 =?iso-8859-1?Q?e9wlCurZy6gPgAavWymGkDSS7QqXu6aVGNOTYuYW7P2BKduwDHDJgKDz7p?=
 =?iso-8859-1?Q?Y1sSf7YFgypfmmU/Gp3gptOw5bg+/8RbANisiV1Vmc7t2HgEd4fe3RS1cP?=
 =?iso-8859-1?Q?XjWOPnn2NTxXbcfHeLdXjHE9aUfQUPVlGdjDbGMCcdt3kLzhlzQwva0e2e?=
 =?iso-8859-1?Q?uLjZM2YUBZpPE10wHGr5otRtYZo4xhUP6eS2t7PSDkPpmD3xe44Kqmzq/a?=
 =?iso-8859-1?Q?RYabsf6PXyV3BIyRphSdSD/TcNnyO8aUqO1fUZQu29SUEYmUlk+VzrSL0m?=
 =?iso-8859-1?Q?DkTuwOy+NdQYqQBfc2if3fTmJAtuJW6cOhtS0ER3oNL2j5HKONb77M2vJQ?=
 =?iso-8859-1?Q?ZShhxIUcs8VeYIHUYtZpZYmdOS3xT3A9m6CRaUovzHBxnaZb0df0HE/C2u?=
 =?iso-8859-1?Q?WwZu6+K1JYNhb3M/66nWpEtwCS29Uwl7XTh07w4dt9EIwT08G4zIkf1hDX?=
 =?iso-8859-1?Q?uzlkYktgT2l5LK+3tuhG8acgTp/y0bdsqN6quwEqRVFJff9rz2rPI2foSp?=
 =?iso-8859-1?Q?Vc/jjlIyH30wNyB8mio=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4339bf6b-4524-435b-1f5d-08dbc0b44018
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 06:21:00.6290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3uUmuyMKEfk4Y1L1zchpQrHGWD2ZpfKkOFVzR0myBYKsLmJ7iHqUcnacAf82SzGHdyyNLCirOvFW5T90NRVE7/aq9wDj0lS3+EGnoMcEnT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5529
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-28 at 13:47:49 -0700, Reinette Chatre wrote:
>Hi Maciej
>
>Could you please move this patch to the beginning of this series?
>Having it in the end results in a lot of churn with significant
>changes to new code introduced in this series. All this can be avoided
>by providing a smaller patch at the beginning of the series.

Sure

>On 9/22/2023 1:48 AM, Maciej Wieczor-Retman wrote:
>> Both AMD and Intel documentations use capacity bitmasks terminology
>> rather than capacity bitmaps. Also bitmask term is much more widely
>> used inside x86 resctrl code.
>
>Since resctrl is intended to support many architectures and Arm coming
>soon (and they use bitmap) I do not think we should use the vendor's
>language as a motivation. For me there are three reasons supporting the
>rename:
>* arch_has_sparse_bitmaps is the *only* instance in resctrl that uses
>  the bitmap term for capacity bitmasks, all other parts of resctrl refers
>  to it as a bitmask
>* bitmask is the established term used in resctrl documentation
>  (Documentation/arch/x86/resctrl.rst)
>* bitmask is the term already exposed to user space via resctrl ("cbm_mask")
>
>Finally, why do the rename as part of this work? This can be motivated
>with something like:
>	A later patch exposes the value of arch_has_sparse_bitmaps to
>	user space via the existing term of a bitmask. Rename
>	arch_has_sparse_bitmaps to arch_has_sparse_bitmasks to ensure 
>	consistent terminology throughout resctrl.

Okay, I see your point. My only reason for mentioning x86 was that the
changes are done in arch/x86 directory. But I can see that there is no
need to mention it here really. I'll redo the patch message accordingly.

>> 
>> Unify the naming convention by renaming arch_has_sparse_bitmaps struct
>> member to arch_has_sparse_bitmasks.
>> 
>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>
>...
>
>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index 8334eeacfec5..83c2cbf7136d 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -57,7 +57,7 @@ struct resctrl_staged_config {
>>   * @list:		all instances of this resource
>>   * @id:			unique id for this instance
>>   * @cpu_mask:		which CPUs share this resource
>> - * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
>> + * @rmid_busy_llc:	bitmask of which limbo RMIDs are above threshold
>>   * @mbm_total:		saved state for MBM total bandwidth
>>   * @mbm_local:		saved state for MBM local bandwidth
>>   * @mbm_over:		worker to periodically read MBM h/w counters
>
>Please drop this hunk. rmid_busy_llc is indeed a bitmap.

Okay, thanks for catching this.

-- 
Kind regards
Maciej Wieczór-Retman
