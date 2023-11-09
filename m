Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872837E708E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344735AbjKIRnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjKIRnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:43:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDABC1BFD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699551785; x=1731087785;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r2iQnaUWXtCIkJw1Pz+Wxav0kwdzwIycEgDIdPHvOkY=;
  b=IBIdzh+TcK8dao5Dqgo9QNGvYQuzWUQ8uJBBXe2GMb387A1Wwm3Dttlx
   cd56sC5/Spk5kgWJBaL/rteyTEg9xq9QPgFbp4PyyYqSUuiw8vI7MvBAE
   NM3cRUPWnWV17nJpXZqKRzf3+aQTDzIeP7xzVsQQQPpH+cL8b/8PVOPZx
   eH2EQOJQTJ0l6kiFFVuLoiFhopH8T45lBgwtX788ibdY0NDQZq+4TDWw9
   tqWMeJLQNMtfDxG+aD3h/yuDor6WrnbmIVBvNQIucO7QBeuOyeF58/ZLF
   0DO2JPlwJehOpXIa/6peTeJSzjbplFR+aQpoWHAFKnTQ9ECDNVFR+RX+o
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="375075796"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="375075796"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 09:43:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="907207628"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="907207628"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 09:43:04 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 09:43:04 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 09:43:04 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 09:43:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hxeje0Ds2rsB2trcq8KWeE4+Sv1LN5saTHRVsxYWzApCwu4kNaIJpMI4CkdqgLKEcornRpI/1yZtDU/s7HSIye8lZR5+49LuPoH90Wm0gTbo7+pcwkp+fWs1AM27qDiA/LmRXATYmtrTjVmuE1rvGcWaeDQLcq0Be8CvSGWgMYwFLLQnQQf+1hmfqA7dW/VLCJv8Q982xN4S+x/N+/t8gOMbwtY3lrierLh0llsdqoQcvv14c6PqFse8B/El9GhBbMhzv47YwbVEK4ldmCbspyiTDtwR7js4LaKMd0mwj/2bGSYVl4WaQi05nWPjMgl+eV7hKwTLuBuAU3tquHsTfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VUtFw8x+3+KHNNx+0kHKJIUzArtKvdS7o00T7vlk5g=;
 b=XZmdUqWKFoe/GZd9kqbcxPVQhsaH0DKZCFBjZUzzaN39rlXLN3eX625mr1LX3jklLb1bjlZK8sg45+6FE2tT4MbenaSN2YTxTzOWmnIaFm1uTDa2JaQbhalpoaQO5M75DJQMwix8clMyt+9jyvXOOn7e8Cj/gUq91PphMJ3wqppNcUrjjq88826G/2kf6c9fCVUzGsAqeoFyae0+KIQrGMJRWkuUhghHIu2GCNKBChNxqGd2ERiro3TsYL48yq2Yp06b1kqb7Y9Z7/YJ1y5q9Kdmhq42Wk8ovl+gdaumYoZP+wlBQ5DRXJau+Mo3ul79Hw03bg98JVlwGwc7Cqv7aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4707.namprd11.prod.outlook.com (2603:10b6:5:2a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 17:42:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 17:42:59 +0000
Message-ID: <27da2a50-bb35-4c96-a780-3571a2c08770@intel.com>
Date:   Thu, 9 Nov 2023 09:42:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/24] x86/resctrl: Allow RMID allocation to be scoped
 by CLOSID
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
 <20231025180345.28061-8-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231025180345.28061-8-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0225.namprd04.prod.outlook.com
 (2603:10b6:303:87::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4707:EE_
X-MS-Office365-Filtering-Correlation-Id: 81089c35-70e5-4812-e19b-08dbe14b5048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 98Rid5sglJxi3fvYqJmqWM0rnoqqIBWUxBsupZ+Tn5cmgSFPrWAAVhPkgXRw61UuS/4TDpN1jp2jQ/OupgGT8/2iPjprOzDp1FFDdMYdaZJSN3ISgh+hkNMSfLkpJk4Nszjfrs1greJRupjecvNO7UtGGLCzV/eTrrcxRhqs05dHUp9CccLvt04mFss79RjKS7U9Zaf8xQQUu/IVodYFpoHc3O3QyeJuwRo1k7dcsTJ4ctgUQczOZzrr1FvwbQAUhqSo23jEFabh1/EwcgwaplQwxsqBO4WNb/ZRxRX8OYYw06aDgoK3Azi24iXY+P3AUIoQFEw2UP8YYtxAUQv77J7HM0JXTuqU1AXxDJA8jOiRbi1I3smUPSY7R1WIxh2l0p+fUfqiLJ3lZAKzpbMzH2b5BWWX99IpjfHZGrTkaBV15cAPcAlrTWUdhJSYrB6NP1/6p0PSonnLyKTTVC01fMbUu4MWQty1hhBWHKrwhGNkOudNwKpkqQJAdHnOLjjfIjNN5Y/1/65eX+zF1KdOZp0lOR6xNQc1GQfmO6XKj0fk7I+NBtd6lWf8tEmnW6zGUiRiL8xooiLizXWeMko7WWIyNBClMtqzzF5NGpihqGrqqTpPrNhU0pEXSFGcE210icun0svgn1W1j/ApZeqSSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(31686004)(54906003)(38100700002)(66946007)(66556008)(86362001)(31696002)(36756003)(66476007)(82960400001)(4744005)(26005)(2616005)(7416002)(4326008)(6512007)(53546011)(6506007)(478600001)(2906002)(6486002)(316002)(8936002)(5660300002)(8676002)(41300700001)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVpWUy9rZ25oS1NFMmlBV3pzbzFjSEp0ZUprVXl3bDlNMklBSGNjU3RtVDRi?=
 =?utf-8?B?dFI4V3dFZDNUQnRNd2JKeFpGU3dtK000SHF5Z2NMSUpGVkZvWVhyWldiMkNT?=
 =?utf-8?B?NDNoK1dZb2psaFRzbWpaaUtGNHE4cW1CTThhYnQrTHptSktNOTVqNU51MWxV?=
 =?utf-8?B?UWZNRmhYOE5pa1ZLYTJaSXBNdzQvUnlwb2ppeDJjSk9OUUt3R0hrSFYvVWto?=
 =?utf-8?B?aWdIZ3dRK3dMR2VjTE14WFRKc1dqdE84QkZOVU5tanA2eDRlbkQzVkYvd1or?=
 =?utf-8?B?NkY4WlM1Um9PY0E0RHVVeENqVlNQdm5JcFdrTkhOb0lOZERLaEhaeWErOTY3?=
 =?utf-8?B?NGF0a0g4T1h5K2pETWdqQXhIRzZVMERNN0kxN1IvRmpTS25iVmh1bHNqVzRR?=
 =?utf-8?B?ODU1SktaN2UvQzJVUTNUb21TUVhYYUlXVXZJMDhoeEtiWEFRMW9XdUlKYitJ?=
 =?utf-8?B?RlgvV1krV1c1SEMrQythUWo2K1VhcWJNNi90UXdwWVFxSTFzOHEvSzFzZ2Iw?=
 =?utf-8?B?Uk1lV1JYeENUZXJyYUdKVVEzaFJNR1VFeTVseHl1cUxsWEJSeXJLckxEUDJC?=
 =?utf-8?B?YUowSHVzV25PWFlVMk5hRjg4RjdvM1dBSmptMDZmM09HVnhZRFpPWU9qbndX?=
 =?utf-8?B?ZzJmeHlHQnRQWmk5RWR3NFowNXNDTEN2dlNmd0U0b0J5eXFyY3FPL3QwSmN6?=
 =?utf-8?B?czhaYjRJMHhNMlAwZ3VTOThaUnp3c08xRU9iMlhMbStZakIrSzQ2d0t6N1Zu?=
 =?utf-8?B?VDh3dGx3N3FMR3JveUxiVDZtaW5QUGljZFJqNWhJcGtocHpqZzZmdDZpK0RM?=
 =?utf-8?B?ai9aSWlVN0E1KzhoVEpTTU9xT1Z5NUtBU1RHUGJDWmd3K3FzcDFMZ3dFZUdU?=
 =?utf-8?B?RmlpS0R4ZVRzTnhjSkpaYTJuZXhqVHliZ0Z1NFBjVHJjVHRkZGROeWI2RFQy?=
 =?utf-8?B?SnJ2VVpBVThSRTJyR09aL3pGeVNwNFlMcDdjSjM1bjdQaHl1QTN4bzFXTkNB?=
 =?utf-8?B?cDlVVEJ2eVcwQUU4d2QrL0FvaXA1Q3FxOXdhSnEweGd6cVRFZCtEK1RscEpm?=
 =?utf-8?B?V3N0cFUrdlpOVlRmWkU2dHlmdDFDOEtxcXhBQlVGUlR2dWV4eGZNc2t2ZEZs?=
 =?utf-8?B?dGlFWkFaWjVvaWplc0VBelhtL2FIU2R3QW13MnVRWmdrbmFDMGlQTHY0ZlNo?=
 =?utf-8?B?VVpSUnNXK0xTUUlodWZHeDZKRlJIRW5waW90d3BMY1B3WjhpamdTQ2d2ejgx?=
 =?utf-8?B?dkdVK1FLcFRZNmpDYUE3enN0RU9qYXJsTk1BV1k1TWlPY3ZGY2hWWGV2Rzcw?=
 =?utf-8?B?SDlINjBvN1V6Q1EvYkE3azFRQkxrcmRJaWcrKzFiTmlINXBqSlZ4R1hveW1q?=
 =?utf-8?B?emVwNWdCUE5XTk1Vamxhc0lXS3Fta043UHAybG9hZ05zeFVoS2xDVlg5S1RS?=
 =?utf-8?B?WFpKeFg3TFJDRE5BMDJoM1dCaTBXREdTOHd4SUoxdzkyOHJzeWhVYnBISEov?=
 =?utf-8?B?Sks0aWlpS2FxcnNEQkRhWU5reEdoWUdER2xzaFhTcG5TNnBpcVZBb3QrdkVW?=
 =?utf-8?B?SVNlMjFJb0hRNW9nZ2p1L2pVd3R4V2hOejJHL0MrcGZ0Zy9BVlNjd3g2RVVk?=
 =?utf-8?B?N3ExM1Z4dmppVTIvQjRIUXZ5bWdGRzdWWi91cHFYWDgrTFI4MXRlYlRWWVlr?=
 =?utf-8?B?VktjKzlMUjU1b2dIYXBWU0xVNlYwaWxBZDNXL3hNVnM5eXFFVHdPYUZoS2RC?=
 =?utf-8?B?T2V6dEdleS9nUExHcnVpMDY4MmwxRHFNeFBkM1ZtamNRN3o0ZGlQUm5LMktT?=
 =?utf-8?B?cDY2V0twMUlMK1JPNThRVlNqZldQWFpWOTd3QzRidGFnUmdkaDFWMkdDODRI?=
 =?utf-8?B?K0N2N2VCL3ErUjBvYmJJR01YZVBDcjd1WDN5VU5wNzV6QkR3bnJzMnh4eG1u?=
 =?utf-8?B?QUdrUFdGcXZpTzJnN2hHTU9JWWpMUnBKaFZUUG1DV09yNUNrRXRTeHNXVkZy?=
 =?utf-8?B?RmRFU0I5ajQrY1lqbFROMlpnalRqckNzcWhVemNyUXZqOUIrVS9TWFhpaVlk?=
 =?utf-8?B?R0FrUVFLS3lMRFhyYW4zOGhmNXhBK0hlQkVpeDBrYWVxRzMwWXhUYWlCVmpS?=
 =?utf-8?B?b3B6SmFIbDJCTmhlUG5iR29hTERSVENJbkRKZ0t6aDlGaGNWcjVFU1VTSGoy?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81089c35-70e5-4812-e19b-08dbe14b5048
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 17:42:58.9929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyAlL4Yan7rysttt1dTx9T2TeCMiVWwCUJliXn54YPL3gKQeVSuKVBJZq/fLp8aF4dfSwrl9ikLFGH1s93wZcJ+H82EsecD6eB8RdoT1/Ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4707
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/25/2023 11:03 AM, James Morse wrote:
> MPAMs RMID values are not unique unless the CLOSID is considered as well.
> 
> alloc_rmid() expects the RMID to be an independent number.
> 
> Pass the CLOSID in to alloc_rmid(). Use this to compare indexes when
> allocating. If the CLOSID is not relevant to the index, this ends up
> comparing the free RMID with itself, and the first free entry will be
> used. With MPAM the CLOSID is included in the index, so this becomes a
> walk of the free RMID entries, until one that matches the supplied
> CLOSID is found.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
