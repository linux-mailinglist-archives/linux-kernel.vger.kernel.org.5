Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF827E20A0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjKFMCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKFMCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:02:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5D194;
        Mon,  6 Nov 2023 04:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699272127; x=1730808127;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tWd+p1H+UpMpwiYMtHYFe64odqrnVHJJABgzRZuTNmU=;
  b=M7x5GATzQkIxoy3zyd19dYtsnVNKXKU9Q4SYhHh+eJsLvO+vEdwwVwrm
   vIwkhXMPaVfBBBugL+gm+Mkxi7Ha9MBR3763Z2iL/bgPtk7KXbpCjLl+N
   Mk/8KFIl1ooQIpC9GfDh6OnC+E3dWdkeqphS45M3UAhV7yr/mR9aXffv4
   0G0aNfdDcj4iy4GmBNe9BDEvtvsnEyV7khvmxTJ/DrBEDT2hF8zBEypoe
   OJBoFBHZEbIzOV/PqHY8zGn15pqQopCc2rnnBDUWRltroNvxmejrGvh10
   6ryBHUfY+r1z6bFy05qeUuOWzdKzYzJcFvfiolHc0zpStJJLUI7BL14lr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="2169631"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="2169631"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 04:02:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="797284741"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="797284741"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 04:02:05 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 04:02:04 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 04:02:03 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 04:02:03 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 04:02:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKXoCWIZx2VH7f+7RuAxp9ogPwt+PNJ9hQPQPfmlMVeDxE8M+aZx6sR9EeCObsT4Hf2vEZXyL/iJMk2GLvs/IuGq5CyqFfKJc7Fu7no87AJ+s/H+QId+vSS7tbOTn/37VBvEjeBs6CXmuzAY6eTOdPIpozoj9T7yHHdKkwlijBBtPpPnIcWEe/o5IqplSsHkIWHYRkJtn4dap1oO1PpFciApIFRDFIb/VuGQjgXlWKHRfRYT4HPgwBudFOzuBwxyHA0+SexYLaSPZhHEFcif5bGcPx4KBfd4XT+BjqaA3H6sP6qQ/YvKLAYc6CGAjSErsfsI4yQiZwR1fXoWlnUg5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZudkllo3MjmuVUfNiNq0HSW2o3V0CIXVlwztQFo17Y=;
 b=Gp471Y8I0Xx4taEFH1tt2CUGQxQg9Hhp7D6/B8wKfkrhndbO4IiyX1LMqx6llgeSFgpikipOPyQboUp4iO+e/4TsiPS7S1KpXHQDWBtHkXCS3BqvBgNyJ1iucq/RghzyzbiD7Xh/MdbIU15kBH32Tgutzb82xhFfss2hGIZLjJ0RTz1QprMWge1kXi4MPQRtjt0Ne9uhW0J0iRJoc4iPEFYqmu4sumDhSIrfPHmwyVAteL+/7OLUL+o7dEAXcaPAhPOHAFkw8tSZHMjbsiUG7OF7RV3yMbEUS74jkhUeEhnrJbdTD+TKMonClCPXwHb9ywW3xYenSqKhFSC5pnWjxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DM6PR11MB4625.namprd11.prod.outlook.com (2603:10b6:5:2a8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 12:02:00 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::1b1e:8472:f24b:6693]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::1b1e:8472:f24b:6693%3]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 12:02:00 +0000
Message-ID: <2a5434e8-ece3-422b-99bf-d3f56750d408@intel.com>
Date:   Mon, 6 Nov 2023 13:01:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: Add missing icss_iep_put to
 error path
Content-Language: en-US
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>,
        Nishanth Menon <nm@ti.com>,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
References: <b2857e2c-cacf-4077-8e15-308dce8ccb0b@siemens.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <b2857e2c-cacf-4077-8e15-308dce8ccb0b@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::14) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DM6PR11MB4625:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e8644b0-b9f9-48cb-514c-08dbdec02e9d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LuMJurfx74W27jFBcDaGdCU73eajgynoFollIJygL2Ra+kNQ9NxgOBQBhWtt9+nApJgYCQWm5t/2nejKVw91JY5s9kaIOI38uIhyqc8u+6ug2aWaWLqByix4r4nzq2QJbX9DYT0q2xdwDmC/NkKSp1BsqxBnQSJRNXu8uLCzlKhwQit1ZsNy4RYNFYDjENx+Gq/RIkXwbXa7BTBy9baO9je/xggB2DnIm7mKgiexCV872hWizrnna2IlfslWn1TwelaNqq8InvZf4e3X1YbXs0vnnyOeDLFDPKerAZZxWfOka4L94vwukr+mtpoCRpG0AoWR4rkHCAzoanM11NyD5akCrCJi9L2cnvxFq3kchAoynJiTNKqMi0YL7L0e/4DehpF4tZVSN0BxWA5yhP5cdnKEWLP+ubGqr8Grn9H1gvN98/LO2PuOLQNQv7D6nghwjr2qM8YmtgYwln1mHwZU9OLmPEwa4RT+ThzMrB4wffRFQe6I4WsY+ewz85rvPAkZ0rTYwZMrjaDw43++w0sMMQhp5q7Hhczteol9dDaqdtBZrA8nkVAdTOqSph+8aSZ6u1IL9yV5K4RictXJib3+CQBRbEmQ5Ot43J6eLRT/OnzgAlsP+sU/fVKqxSOfRJ1ysDZCpvLS0Nz8s+1Lk9EVIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(346002)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(478600001)(41300700001)(6512007)(44832011)(7416002)(6506007)(53546011)(2616005)(6486002)(6666004)(83380400001)(8676002)(8936002)(2906002)(5660300002)(66946007)(26005)(316002)(66476007)(110136005)(54906003)(66556008)(38100700002)(82960400001)(4326008)(31686004)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFZLNEF2UHZGRHNDM3k1NmxoNGtMQzl5U0ROSG16MFBSbGRaN0NBVHVtNWYy?=
 =?utf-8?B?ZS9KQ1hBa0VLQnk3cnMydVltdVJHZDdvNyszcUJIKzgvejQvSDdGcGxyQkRJ?=
 =?utf-8?B?K2ptM2t2dWpGaGp1a3pMUmh4NkxWQWpvTEgyN01MdFF2bWcrUTVNenN0VTE0?=
 =?utf-8?B?RXZEM1B5VUNNWGFkTUlCL2gwekswWUJkMFVNOE5GK3lkOE1EN0ZLWVI3bmFM?=
 =?utf-8?B?M01jMHgzZTZaak4zdHVyUTQ0RmJNTXZ6aHllOTM3V3AzaGRUOHA0S1ZPNEU1?=
 =?utf-8?B?MmRXRUR0aE5qemdDS1hrMGVFNkFkOXBtZ29JQStaZSt2MStpVXozamdhaVNQ?=
 =?utf-8?B?M1hIRlhpdXZqRW5XWURCUnh3L1dRV0FtWko0b3JOMFRuK1FLeXFSTG80S0cw?=
 =?utf-8?B?eHQ0NEViQXphN210OFl6S0R3UzdUNGRUMUxFaVl1U2pjZ1VyUlFTT01WaVN6?=
 =?utf-8?B?WVYyVDhSOTFJTzczMkpYN3h4RnJ2aVZtL1ozRm1Eb3gwY2cvVS9mMFdlYXZX?=
 =?utf-8?B?dit0WFY5MHl6d3RoV01RUVloR1N5SHFtN29mTVdkRnVPaWRkSkNhUDBGV1hF?=
 =?utf-8?B?MXFvcnVOalpqdFhoN2UydURGeTNmUTlxOUZIMGtyOHFxdGY0TU5zK2VRamJG?=
 =?utf-8?B?N2RFRm9nT2VNbzBMdXp4Mmw0c0Y5cFI0V3djWE1vWkZxdENjMWVzQ09hY09M?=
 =?utf-8?B?NitYK0lYY0Z5bmFRYnZvZjlscXB4RkN4OGp1Z1ZhRm5IbU53cmZ3SWpwYkFR?=
 =?utf-8?B?Zm9sc2h0S2J3TVYwSStoM1hzZmIyQmlGejI0Z3VOYTlXOExKL3QrNER4S01k?=
 =?utf-8?B?K3VFK2VjKzloWHRHMzFFR1RjSUdQM1FpNW5XZlF5bTN6eVhMMEtqTXNwZEwr?=
 =?utf-8?B?RlFUUEF1T1dLUUxDMStQTWhCS1FkSVVDUVR6WTBSUnFLdkF0UGl0eEFSTzd3?=
 =?utf-8?B?QVIvdVoxeFNCU3lqM2VuSHJKdUtwcU5qODVtZTdMeXBxdGVuK1ZxVHhob0Zs?=
 =?utf-8?B?TU1uOTRmWDdjM2VaTkVqOWVTWUQyRWwvd0NhTWZnTVZuVUVtd25tWEQxL0Rl?=
 =?utf-8?B?RHFpMUdha2tKUEJVUGFsZFlIWXBvN1o4NlN4TzFkT0lDTDNNTVlrWW90K3RF?=
 =?utf-8?B?ME5WNDlmLytQRjlHNDh1bTdYdjFnbUU4ZS9STmx1Yno0TWpGalRoMnVLL1pX?=
 =?utf-8?B?TjhDbkVwblZlMWszUDFNYy9xNVllWVlzQm1WYm5RSG93eUNNM1hnNmQ0Q2pT?=
 =?utf-8?B?UkRabGdXTDY2UzVRWVdYVytRcUlUclZ2U0JwTU96NGdxVWl4NjBHY1FQTDlz?=
 =?utf-8?B?K1dIeDV0WmQwdDZUcndpZG9VYWNhajhwaE5rWjMvQ2FOakxWUllhNEczVXFN?=
 =?utf-8?B?WlRSaldpL29IS0h5NDF0a01CQ1UzSW9lZkVlWTJNMTNnVDFFTEhpNWc1dVJW?=
 =?utf-8?B?K2tkclUvZ2JDWXJLKzQ4MHV1SndOdmx5UFJLYkRrSUVvYUZHa0YvZ0U5YXAx?=
 =?utf-8?B?V1BIM3d2ajVjZCtzZWJNckRGLy9hZjVwNWpUTkN5QkxtenB5TEV5V0t1dmt1?=
 =?utf-8?B?YVBubnBMdjNwU3prSGIxT2hKc2pOdkJ0Nmo0akVGWEk5OFJKakhuYmM4c2sy?=
 =?utf-8?B?dERiVUJsSFRRV21hbFVxK1d0S0tsWEU2bUdjbTdNMHBiNHpaTzZCenVwbTJ1?=
 =?utf-8?B?MnRQbnliaXVFVlJtSTdUU2tCanJxeFRrODhUWUFYRTh0ekdTT0RjOGd6b2pU?=
 =?utf-8?B?QnVpRnljR1dlbmhHUDdhKzVhWUY4Z0Nlb0djcEVzUXlnZVN3aWt6UjVwN29o?=
 =?utf-8?B?RjVpYUYrRDFOcWVyTkE1MXRIem05TGJOK2RLaTdTbGpPQ0M5cHpYZ3BXRG11?=
 =?utf-8?B?cGk0aklJZXFDTEJidkJIS2tQZ3EwbnhtMnRoeTRERk4yTElkZWV2ckhqS05F?=
 =?utf-8?B?amFIRnFKQVcra3JWZ3hYMmtVU3djd0tLNkNOQ250OG9qMHdvTy8rWjcxODZX?=
 =?utf-8?B?TWp6YjZlMFJhRWhNWmN4UU1hR2g1ZFgxTStPMmF3NWIzWTUwSWwrR29SaElP?=
 =?utf-8?B?QlAwOGc1KzdqY0kySjk5TTdaY2pldW16YW9WUHl1RUcvVDF6emVMSVVFOTJk?=
 =?utf-8?B?MkJJellLOWRnaWJ3SkltVXcwRkJXV3BLUHJKN2J1MGxqWUlWVStZdnRDT0tq?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8644b0-b9f9-48cb-514c-08dbdec02e9d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 12:02:00.4452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DuYQ0+/77SGZaYHMLDezlR7dzDxgg8tUyJ8/TBL68tWmXfLW3XQ6HvLmF89Kwa82EwGcB6QpOi7WXG5X5UW8WTnprR7Mk2O8B/AWS3dpTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4625
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.11.2023 12:47, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Analogously to prueth_remove, just also taking care for NULL'ing the
> iep pointers.
> 
> Fixes: 186734c15886 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
> Fixes: 443a2367ba3c ("net: ti: icssg-prueth: am65x SR2.0 add 10M full duplex support")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---

Thanks!
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> 
> Changes in v3:
>  - consolidate cleanup logic further [Wojciech]
>  - make sure to NULL iep pointers
> 
> Changes in v2:
>  - add proper tags
> 
> This was lost from the TI SDK version while ripping out SR1.0 support - which we are currently restoring for upstream.
> 
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 6c4b64227ac8..3abbeba26f1b 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -2105,10 +2105,7 @@ static int prueth_probe(struct platform_device *pdev)
>  	prueth->iep1 = icss_iep_get_idx(np, 1);
>  	if (IS_ERR(prueth->iep1)) {
>  		ret = dev_err_probe(dev, PTR_ERR(prueth->iep1), "iep1 get failed\n");
> -		icss_iep_put(prueth->iep0);
> -		prueth->iep0 = NULL;
> -		prueth->iep1 = NULL;
> -		goto free_pool;
> +		goto put_iep0;
>  	}
>  
>  	if (prueth->pdata.quirk_10m_link_issue) {
> @@ -2205,6 +2202,12 @@ static int prueth_probe(struct platform_device *pdev)
>  exit_iep:
>  	if (prueth->pdata.quirk_10m_link_issue)
>  		icss_iep_exit_fw(prueth->iep1);
> +	icss_iep_put(prueth->iep1);
> +
> +put_iep0:
> +	icss_iep_put(prueth->iep0);
> +	prueth->iep0 = NULL;
> +	prueth->iep1 = NULL;
>  
>  free_pool:
>  	gen_pool_free(prueth->sram_pool,
