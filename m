Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA3B7E5CC3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjKHRyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKHRyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:54:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BB81BEF;
        Wed,  8 Nov 2023 09:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699466059; x=1731002059;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WIL7julJhFCkhUwdQ4fjCZrcFfmTmm7Rt0Im9odKDMI=;
  b=gEtX1vKilowj4QNcAtWbUUnh1VbbCuSqElglnX0UJL9LfAF8g3vHuDNQ
   kY48JKJtNHLVLvA2bXcoUQ7sICy5P2Of8oFSvDb4G/ZvgV9W2MoZmc7bl
   AWLd5gYRlm8Z0eIxrfPN0C1/AuvNEps4cF+eDnJ9+lUMmBAGeeAi1b2ST
   ytByOQMwoYso+yrr/O2bDHbSiyGIzFHY2gWSyWORn5YgL9rU5iNGfpX5/
   3m4Pgnliv170amqxRVSQJUAb0HjXS6D0xY/lJDDnR5cC8qC79buN782gR
   gouwq9p14s/SZeOg6+lTg0jyAZHu9gCa8JYoB7G38L5L1XNIrv7NwBSuT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="389628652"
X-IronPort-AV: E=Sophos;i="6.03,286,1694761200"; 
   d="scan'208";a="389628652"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 09:54:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="713010922"
X-IronPort-AV: E=Sophos;i="6.03,286,1694761200"; 
   d="scan'208";a="713010922"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2023 09:54:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 09:54:17 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 09:54:17 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 09:54:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCe/+plA5y5uXB9why7vEeFNx3I3wu8uFU0Kh+ISM84L95Ah9ewEQUwnwBK9ZHbpbKxfvvjADNoFZd5GUPKxlygmmJgjQvR7iZu1Cm0W8Yv7h+GEB4FCP/bAnpwHsAFVhwaT5kkbuKvxmCEPQxJ/d5zNIzeOG866fKGr2b+Y939edvWTWgRMwOl5D9LGNU0an836jZ9JRo7RJmyFeI4JXF1BuYAkJ6VuL4HoA1lQtJgR82CDzuBd4GBgctvf6LZopWrK2gnP0jHscf+7QQJ4YuFNQ6fonsBrH/D5eyAirDCRmpQ7nJTm6ohP9et2jjcQLr8LxsCtdyszSxaJBlldIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1QmiblKkIGachKbZ2fpnQkGCd631Dz2JKmfoESTSgw=;
 b=BoDp68KbKfw5BR+03374/pdPXa5IpfVaBvyqFSVkaJDMCYi7UUJD23ExIEARhIHKdAxig4cclNT47LC23VeSdbndzc9LwE0U+/2TOpmqt3xqqtHc02/qIYEam1BreT+Ojp5biKkBmLo4+NUIo6Y30XRIL3hLfEnBfN17F5J/QpO3NSwjT6YNCYPrHXSEmtALnP3k+Rn8nQ4IrUYAJaV9lx7f0N6tH8zVAc85eL9djJkhsTvjBEvES9/m8gHY1PsnBJhZJHiZEPiVlnH0UnaGXZ6q6k5BH/qTG7krDqlhiZCglhj0fX7lztK/8WyMZGYAauHj2QGDgHbJk8n5NH38qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ2PR11MB7453.namprd11.prod.outlook.com (2603:10b6:a03:4cb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Wed, 8 Nov
 2023 17:54:09 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 17:54:09 +0000
Message-ID: <0a203988-1062-4dc8-96f6-cab800c03026@intel.com>
Date:   Wed, 8 Nov 2023 09:54:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] i40e: Fix waiting for queues of all VSIs to be
 disabled
To:     Ivan Vecera <ivecera@redhat.com>,
        <intel-wired-lan@lists.osuosl.org>
CC:     Wojciech Drewek <wojciech.drewek@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Jeff Kirsher" <jeffrey.t.kirsher@intel.com>,
        Neerav Parikh <neerav.parikh@intel.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231108160104.86140-1-ivecera@redhat.com>
Content-Language: en-US
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231108160104.86140-1-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0307.namprd03.prod.outlook.com
 (2603:10b6:303:dd::12) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ2PR11MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: bd87a3fb-15c0-4760-8ee6-08dbe083b545
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKEXaMA9y34L2802sxZBkSCHdaY/OuVGy++RtpeUQBKgrUi986MXD3Hz5K7/d2OsGQ4Nwc0OEpBPRYhz9Cv5IW6jjtlPM68gdikYKfqdHnC1yasttbuTDGOLGhhxE5tHWvWviDHNzs4dn0G/fgULNfNGnK6zv38czDtgW1pLfJfIW92zfALvCiKLGHO/GI8yGZz+CL/VHahGankVH1TRPRi0y6y1YKFVv2v/Lble5cxWnfbr3hfxB6aUFIaMv3jqUP7ekLAJa0jbqqlSe5JEKSEMQqIbwg9m9fJ//ehzrPsk3tZkqWwRdRi4i/lpEn2nKmMVbyIWnADEfyjvVumZ4UGDyZ5qHOweum2QA7QzsTF21jgb4go1+yJ1eBAT7b9LuREmBeoKz8h1sBF8vi0CagGUz0WEry1SfWnUIKK5f2um2F14sNvxxyhnN+oWiB+CYJ6h+JG7DYx8lDlw2e0MtB0t61iNUKJuYC5HRk+5kNpGctzcPPdakFS3yB3TwFKBEhD0A66RmMZCfQTGD9Hve8trjdYbYMSuIbqZhk28eEtIvMmAEmvOt72jVBdaT7Njpq3y1ph4NqbT3OWcVeF9FECAyhcOe3TIYaeCLtQP9PlnrfxK2mOkUvldE9EXc6a+rZRZsORMXCdeSVBnrlT27w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(136003)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(31686004)(6512007)(82960400001)(66556008)(54906003)(316002)(86362001)(38100700002)(31696002)(66476007)(66946007)(4326008)(2616005)(26005)(6506007)(83380400001)(6486002)(2906002)(53546011)(478600001)(5660300002)(8676002)(36756003)(41300700001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGREWmdOdDVaSDVXcTJENER3YWhCQkNMUmF4WUFZemh5MW91alk2YUU2Z21W?=
 =?utf-8?B?MXZxbHhXY1ppeUFETkgyc0hVNEJqMXZUZG1JUTJJcXlDUitoVnFYYklmanI3?=
 =?utf-8?B?SUFCWEtoVEJBZURWRWhsUW50VG1jTDJQMUp3MkY2eUFlb09TSXdaN2FudXJv?=
 =?utf-8?B?QU5tZTFVWDZvZWlUOTExaExja1E5MGo2Y1JOTzI3R3p6WWFITkpPUXpZQUtk?=
 =?utf-8?B?QXVsSnJiV3lpZzJVZWFjendNRUlPWTZBNjc4djF3bnRqdXBHUW5kSVVJSzRY?=
 =?utf-8?B?SGY4WEF4RGowZ1ArTlJFWTNzMWZmbms2a3BmZXhTVlU0MS9LcnVHZ2FGL0hx?=
 =?utf-8?B?Y0Fkd1VHR215ajRoaUlnSEhnTVdwWHQ5VUUvR1FLMnV2SnFwUUdNbk5OZHZL?=
 =?utf-8?B?ckRTSnI1b1RkcWpabFhxeFVGWk5WMS9lZWdJYldHZ3hYTmhuSTVtd3pyK3h4?=
 =?utf-8?B?cFFYdHNaOUJ5SUxiall2dkJjOXF2SGQvQUQ2dmpwOG5OQ1VNR3JCY3lIYTdq?=
 =?utf-8?B?ck4veko0NERjUkx6NW5XcW9JaG9jKyt3NVVEVkJPNEMzRXQ5aHpZdGxteThT?=
 =?utf-8?B?d0VJdFhacHB0SkNxUncrUUpqZUtQWG9pTnRrM2o2Mi9xaFA4M0FHc21qcFVN?=
 =?utf-8?B?V0RqQlFabmVxTFlZUkx4b3J6Z0NtM3VncCtxd0JLZGdjVlR0a3NBWmUxekt1?=
 =?utf-8?B?SThWM05aK29CQnpzZ1JLOE8rYllNbUNabXhWNVpSQ1g5dWdud05vSVFUVm9Z?=
 =?utf-8?B?QVpSSFNKK2g4RU5wd2w0WXFNMUtFb0ZVUGFxbkFXT2pjWVpXaEN3NkFBd2p1?=
 =?utf-8?B?dUd1ejZXVExWN1ptbjhEd0VIYVVXbFFTcmZ5Q1E5cVBjYzdlQk42aDVhMTNL?=
 =?utf-8?B?VjNraHdzUWJiMnRnV010cDNzYzhyeEEyT3dqQk9JR1RsanowWG5BdlNWTnpG?=
 =?utf-8?B?L0NIVytyRCtIWldoSGZMOE1Bc2JqQ240MzJMa0l3dE5IbjNXMDMwQzFJdEtS?=
 =?utf-8?B?QzlTc2xKMkUwbWtUSGRwQlROdFgySE0zMm01MUk5aWFHaGdhNVRuNUZhVEdN?=
 =?utf-8?B?bVZLcWtNdkJTVDg3ek95Z1A0SVVLNVowOVQzS0lkakF0OU1XNnQwanJHWU1a?=
 =?utf-8?B?RENka0FCdFdHeGJOckhSSHBTRWttMVZmaUIyS205czhlNm9VZHYxVzlXYUly?=
 =?utf-8?B?dU9mSGEvcEJJa0lFYkI5ZEpCTG5GUHBmcWZwYU9aSVBMZDJ6ZWwrdzB1eGFI?=
 =?utf-8?B?dE5jWFNoTGQ5NVlkczMyRnJUUmh4NFdTdVRja1BNeUJ6L0g4ZU5LaGpEMEY2?=
 =?utf-8?B?K3kxOXcvaGliRlFzeHh2alBBQVdVckdZWVJMa0lWbXZKTUtNZktmTU40Q1V1?=
 =?utf-8?B?TFZDS2JuUlVUTEpmbEk5cXlTTW9xUVJoWExKNUJRNHJhcjdtSm1SaW1XWmNw?=
 =?utf-8?B?SXNqNXlwcjNQNjZBd2tSV0JkTDRtSXZ4SGFtKzVPNWVXR3BQQzNlSHJkenUv?=
 =?utf-8?B?L3F3NXlwKzdCcG05VGtKam4vUzg0QW5ZZjZIaG9ZbkVsd0l5d0JtQ2hCNGJM?=
 =?utf-8?B?SEYwK2pPYW8wcXlwbjl1ZHRFem4vcDEySTZzUElMMjcxWjdheW5FNmtKSyts?=
 =?utf-8?B?TGpzaGRORHFiUHNQRkllMUtHRS9rUG9WaHQwZzdKZ2pUdXRvWW9nbmhibm5q?=
 =?utf-8?B?RE9TZTNnY3lWWTF4ZFpRRXRuRU5LWnUydEpybm5nVnZhMEN2TTdkOWN2MnJV?=
 =?utf-8?B?d0FLRTdDN2tvRFo1eUJ2YjVPK0FzOVNzckJVRzZQMElDUDdGNlpmeDczZEV0?=
 =?utf-8?B?OGJXTEFUQWRtbkxtd0tvOVVPbjBFZFdXYXV6ekliOFVkcUxDZU1vTThpeTdR?=
 =?utf-8?B?S3ptRVQxRUsyRy84bnRvUWY5aUlQSzZabDVieWl0WkliYlU5eGdkaUpvN0E1?=
 =?utf-8?B?dGhqbTFFa2JZbnNGVll3dHRxYVVDRmpBdkJKN0E5eVJoVHE2bWRuQ2ZGQzFt?=
 =?utf-8?B?bEVLc1Foc25GalFzd1BEMERpNURHMUNINTZad0FRaSt4SkxQa0kzV3ZmeTJ2?=
 =?utf-8?B?ckV1bDBrcGVLTzR3UFQ2M2tHckVKVnZrZ0x5dFN2MEpmVWUvVHFZamhJYWJO?=
 =?utf-8?B?bUhKYjVaMUN5dEhzSHdMdS90dHdMSVFzYUtCQmxlME5GbTJiMWNrV0c1RCtS?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd87a3fb-15c0-4760-8ee6-08dbe083b545
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 17:54:09.1443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q04e3hMF6B/9dKGjmjFr2p5RowbkKAoDaB1GqHp8/ngDltRt/X3Ly0nYs0D0A9/WVrFqj1wTufZzJAZBcXXdr4jAIkezVbRp6wQnF1RcPlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7453
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/8/2023 8:01 AM, Ivan Vecera wrote:
> The function i40e_pf_wait_queues_disabled() iterates all PF's VSIs
> up to 'pf->hw.func_caps.num_vsis' but this is incorrect because
> the real number of VSIs can be up to 'pf->num_alloc_vsi' that
> can be higher. Fix this loop.

This confused me at first, but as described in i40e_probe:

>         /* The number of VSIs reported by the FW is the minimum guaranteed
>          * to us; HW supports far more and we share the remaining pool with
>          * the other PFs. We allocate space for more than the guarantee with
>          * the understanding that we might not get them all later.
>          */
>         if (pf->hw.func_caps.num_vsis < I40E_MIN_VSI_ALLOC)
>                 pf->num_alloc_vsi = I40E_MIN_VSI_ALLOC;
>         else
>                 pf->num_alloc_vsi = pf->hw.func_caps.num_vsis;

The func_caps.num_vsis is really a minimum guaranteed amount and a
single PF could get more from the shared pool.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> 
> Fixes: 69129dc39fac ("i40e: Modify Tx disable wait flow in case of DCB reconfiguration")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 6a2907674583..de19d753ba83 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -5340,7 +5340,7 @@ static int i40e_pf_wait_queues_disabled(struct i40e_pf *pf)
>  {
>  	int v, ret = 0;
>  
> -	for (v = 0; v < pf->hw.func_caps.num_vsis; v++) {
> +	for (v = 0; v < pf->num_alloc_vsi; v++) {
>  		if (pf->vsi[v]) {
>  			ret = i40e_vsi_wait_queues_disabled(pf->vsi[v]);
>  			if (ret)
