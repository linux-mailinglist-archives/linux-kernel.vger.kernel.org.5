Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06D0800506
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377770AbjLAHuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjLAHuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:50:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F312F128;
        Thu, 30 Nov 2023 23:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701417044; x=1732953044;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8S3h46NRaOEAExVR0Ary+mtnV3ZiLARSTGfWti2JUr4=;
  b=FH8hS4qsbDrSmbhZLSDDBkBAcMseatADFAJBPkEfaUWnGWtCATI6TWcp
   5nZYUPayc4YR/hr/o+ZwA5m/qFJHPUIYDMuSUj5E9pxgQLshbTMvr8c/j
   slvugYeG5SyGDfHGUNroE9QfK4LIzw7WwQIaUZujkR3hHTmlCRROTYc2H
   U3QJPAz5j5kIbbOdy49BIsCCVraKYrRCjJ8XA4yYxjKWZ4DRuN+m6gRBZ
   cR5d/fCqwbJGtevt17/uSLrTDV6nPoi55jlg/P98anMUzrgwnftoxlTAI
   1W7154L4kZK3LIl2H1Blr+y0GCHDAWe4s/s5PrZNhrjL5jBxU2w93H5Qv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="6733105"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="6733105"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 23:49:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="887548751"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="887548751"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 23:49:41 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 23:49:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 23:49:40 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 23:49:40 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 23:49:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhIUd8UPyMBoiHMy5C6N/d/HawDaEQC+1/RyVPwIzfNncUFCb5P6g+YJjnQxXR8aaFperbB2Ie4mLVORKSnkn3T/mubbnoGwZO3CwNCK6GEMlM2CwvmreaSmk7O3lxfyTEwgttgK/STSYtK321bxLAG1NJ/eHPf+0yFev1Dly2sz2AiFuT2H7B0ykZSho6pSuUpeERnwARUOd9irNBxgVaCyCSxMKVX9hIsoJg95xgc28T8H1da1kKW/s7Y2NUT8J9PWYp7bSefKm+i6trad/siSO0LwIfe4d3VSGtNlwDXLWjkhg59+0q4youFc8c9TY3W9PKQcw82CaLikFd8F0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMVDQUvD7plK+R5+J2kbXXCo66Egpmre5Kek6L5qkbk=;
 b=ILb2vg1hLtlcPKUlhsRw7yLKvfOWQ7KrOpsIneQD6VZnz6zGH+mbXeVC/qOptsl/JJyRYpdMHUjAyTZ8Cinrmq0HA65vdnOsys8jaQm2MtVDQaACNFDkIe/E0VK6/ya58kFzdnCBCD4rQdPTC+GPZhRr9Dwkb4D6emTqM+ezm0GfrbZL7QWiSqaN9haaeP1hZfUcIWzpZLhtBdGavyutNvwgP8w26AVMQz3Be62bJZy6yPzPEGWBYUrzhBCspw1twxHlJm9MoqqQkKi+0BB/Hw17g8BjKXuGDDLFLn4cSZVR88p8wNwvqyjXefoPuf6GZ1Z3FDxSvWLF4m4ddFlnaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by SJ2PR11MB8402.namprd11.prod.outlook.com (2603:10b6:a03:545::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 07:49:37 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7%5]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 07:49:37 +0000
Message-ID: <6d6f67cd-c0fb-5c91-9a14-0eabafe27e70@intel.com>
Date:   Fri, 1 Dec 2023 08:49:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix wrong mask used
 during DCB config
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        "Tony Nguyen" <anthony.l.nguyen@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
References: <20231130193135.1580284-1-ivecera@redhat.com>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231130193135.1580284-1-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::16) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|SJ2PR11MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: 30fc91cb-2d13-4c03-85ba-08dbf2421131
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XP8yhLTrqTsPKjPvx9GwFlCB0FpYneyUxInob+/kOhCV9YX8QhhlxO38isk7ftTSPABokTJ5xjkGlPDS+BlQ3Lwe3GwIVxOTtSo+mvRkw52GPiW2uSpoFrBeRcRNUJk4N952knBhp/Ic5mZ6pbeeDxdE6EesZAyukeKNtQI1uSCfonbsYLPu4JGhYqPyDfzmIpjX0KnIcaSUAsnR/2aq8NL7wrIjnpv+wYnDAA6Cfw6uEbPIdq7zwvKwJijG1u8axZq6a4RLZb0d4oZZCys5Ifhr1gjhQv1NTiBx4L5P3MwCWa/tCQS192pRtgOJD/64Ym4DNyoqLtzecW68ERy82XyulyAA/GHCNYidJUaAdwJeL7efLzY44Gi4yx+IWi0s3u8fN49ypMAi60CzGdRHreNbRyOK2P2MpssgqLtakhtVRmuC8ELdak5m3IVSnxV6BVRJ9GCNhROuQ7S4Pr+lJuNQccVAPrKJCdhSEN8F0VuygSkQR1IwHlPqbSF2s+GtFS0pzVx0QYWURR99XxdubHfBRepj1av5rs6tV+RaXprxJN3GDVkwL3DKazaYcL9WzKNaLt644hYmpamOlQv0ljgxxw/Kf5yo2smjBIPK4S6mrHkVb3JcusJShi3cw+hEjggBakYPcS3/C04Lgu9W7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(366004)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(31686004)(38100700002)(82960400001)(5660300002)(2906002)(6666004)(6506007)(53546011)(83380400001)(2616005)(6512007)(36756003)(41300700001)(478600001)(86362001)(4326008)(6486002)(66946007)(54906003)(8676002)(66556008)(316002)(66476007)(8936002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0ZraVRNSDdTOVg0eDZreWxac1hhSWs0Q3lhV3YzYU4vajNWejZBWjUxOHkz?=
 =?utf-8?B?T0tuV0lWRTNrUjEwdUhkVEtUbVc0ZUlPZnlrZUxsOHdBaGNWazB4VFMrdEVv?=
 =?utf-8?B?Tk95VGFlaUNSRVI3ckJablNSYURDZVQ0OGZGVkVnVlBtcEJmWFpmK3JyR1JM?=
 =?utf-8?B?cWdpejBmeHNFd3lIbzh5ckRiUmxBODNOdk8yWWZGT1BzNHpvZHo1UEJkdk1S?=
 =?utf-8?B?aGI5aDFnOVJJQUxUL1RaVmxzdXAzNUlMeHBoK2FBUzhxNXk1cW5YdlpBWUZN?=
 =?utf-8?B?aVFDUHJyNjhHUjYrSkZBSHVhMENKcEY4eTd0dmNsZ0VmU1JtQzNzTE1KbjJC?=
 =?utf-8?B?WUlDZmk1ZE04M3ZMQmp4KzMwTStwNm5KRy9vWGdhV0JwVFh2R1JUMnhLRFpC?=
 =?utf-8?B?aVZHNms0RGpFdXZsdlpGeUY2R25lbDl4ZDMyTlRscWhTNUhmSjJ2dmYxMkZh?=
 =?utf-8?B?UGFIY3dMalo0cWxOQVdUWGE1VEVrZHpCS2Z4SEVvNERwWDJiYjlTQ0hNc2Q3?=
 =?utf-8?B?Si9EK050cHdTdi9xM2pZVlpGcS9CYlpRaEZKZGF5SkpWWVY4c1l0NUNmRkxa?=
 =?utf-8?B?S3hsNkc4MmJCSDdGK2k5R1IvN1lWcXEzMWVmMTl1ckpnb3M4RGF0bFdCSUJm?=
 =?utf-8?B?aU5JUTd3c2htc0xxQTF3ejhzV1RDYndmQTlrdnNFR0l0dVlBZjJETTB6R09P?=
 =?utf-8?B?N1JQczNqODBlSmFDc1RKZExLOVdBYWQ5VUFpUFkrQ3hCdDN1N3NCZ1FLbUps?=
 =?utf-8?B?aWFyblYvVkpVQkxwM3Q0bFJRRWd2NTRNanJtZTFtRVV0TDNhUXlhRWJyMEdH?=
 =?utf-8?B?UEl1Q0cxY3hrL0h4SUxVTnJxM3g4b3NHeDdZeDZCeFFaV1FycDN0KzFjNTlG?=
 =?utf-8?B?WW1LT2JsMU8wcWVZR2c0by9VK0s0eXZQMnNBdHJJdUxDaERJRzE0MmNKM00r?=
 =?utf-8?B?SUVtYVZVWDdreGlXcHNwYlIzY0NYUng4b29LZWJhWFVQNEFSU292eTJFanRW?=
 =?utf-8?B?Wk5iTnVGTElSTndsM1kwTGRiWlhiWVlqMmF4d2dQRTgxODBnanRlZFNLSCtK?=
 =?utf-8?B?TmpHRzhiT0Q1czJxUjNTM2tsVjBYVXpRdVducU5sMU1peGFCT3RNTUtKNGwv?=
 =?utf-8?B?bjFBUTZ4WHZCby9QdU1yc3A5K1NzcUFHME9mNWxTNGtjVTJyU1V2MDcwYW9p?=
 =?utf-8?B?VjZrbnBnWisyczBEWXo4L3hBbnBOeVZGV01pMytQb0lnOHpLZG5YQyt5NzBZ?=
 =?utf-8?B?RDZWUFZoZzVybVBDZUtQR2E1Rkp0dUdFNC9nMk5YZy9uVVpHWEJGNklGUUhB?=
 =?utf-8?B?alJPRi9FeUo2U3hvMFZ3U2xJUEtrdGYxRTlhbVR3TXI2QUg3QmFpUDNQOXVu?=
 =?utf-8?B?UG5VMXczczZKNFdiNkZVdVBEazRid0VqUkJxTVN0SUVNNHZFN2M2cTBLenB0?=
 =?utf-8?B?TldLL24zT3VONTFZOXp6aUs1aWg1M0R2T0ZiVmxOVGMwSjh5eXNpTGRvNXRM?=
 =?utf-8?B?VXdMWSt5RFZWU3c1bXV6RkhTckM2OTNKNmFiUitjYTBGUno5OXNVaWQwZXlN?=
 =?utf-8?B?WGh3NzBtTTZMcDFFaVlyNUtieExHdktoVnJ0azlUWmViOU84RVBGTi9CNVVx?=
 =?utf-8?B?cmhaUzJMOGtyNXhNYUQybzdMTGNvV0MyNGZLTWlKRGE1bnRmdS9WOHFBeEF3?=
 =?utf-8?B?dlhNRnJFUVNxZHNWSCt6UC9NRTNaNzRpR0tzaGFXWUNTNEVlanpQUTNEUVlL?=
 =?utf-8?B?UnpzYjAySmhXMElkZWMrT2poUUpjZlY5WWVFZ0dYSnMyUlVqT1hteUtkN1NB?=
 =?utf-8?B?aGY2REpWQ3ZnTE82dFo3aWdTZlV1TWZxTE81MTllcGlHYW1JeC8xRGZQKzdZ?=
 =?utf-8?B?cml0Z0doeDlKSVNlMGV5ZXV5MzBrL1ljSmlQbWg0QzlnL2o2SEsybGJIUnQ0?=
 =?utf-8?B?bG9SM1d0SkNNWW9jaDJnS3VtcE1lUjk5MmtjUmFSQXUzaUcxL1ArcW0xY1hC?=
 =?utf-8?B?QngwQ0FsVXFzUlZpOE1FNEI2MHUyNW9rSml6SnpoQTlNYXdVOWhSVzR0RmJw?=
 =?utf-8?B?aHZ5ZS9TWFlyVmxwNkY5TEdmM2oxMTQvLzY1VmRMektmNFBrL25YMXVZWFJ3?=
 =?utf-8?B?WjRhc0ZCTlZJNUxrQWVPWkdxUGVvbzg1ZEIzU3NZK2lqeWMxVXZGWG9NaFNL?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fc91cb-2d13-4c03-85ba-08dbf2421131
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 07:49:37.5675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/9tyGmtw+XPOwPHH4/MI3o9NY+Ul57McBm7iENjEyWG8DVSvDYOOCYCkh0qKtMCF2bVA8dCHsyHC5OiZfuShFZdXjO4cCOV8nn6iuurerc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8402
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/23 20:31, Ivan Vecera wrote:
> Mask used for clearing PRTDCB_RETSTCC register in function
> i40e_dcb_hw_rx_ets_bw_config() is incorrect as there is used
> define I40E_PRTDCB_RETSTCC_ETSTC_SHIFT instead of define
> I40E_PRTDCB_RETSTCC_ETSTC_MASK.
> 
> The PRTDCB_RETSTCC register is used to configure whether ETS
> or strict priority is used as TSA in Rx for particular TC.
> 
> In practice it means that once the register is set to use ETS
> as TSA then it is not possible to switch back to strict priority
> without CoreR reset.
> 
> Fix the value in the clearing mask.
> 
> Fixes: 90bc8e003be2 ("i40e: Add hardware configuration for software based DCB")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_dcb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
> index 68602fc375f6..073ffbfcbe8d 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
> @@ -1576,7 +1576,7 @@ void i40e_dcb_hw_rx_ets_bw_config(struct i40e_hw *hw, u8 *bw_share,
>   		reg = rd32(hw, I40E_PRTDCB_RETSTCC(i));
>   		reg &= ~(I40E_PRTDCB_RETSTCC_BWSHARE_MASK     |
>   			 I40E_PRTDCB_RETSTCC_UPINTC_MODE_MASK |
> -			 I40E_PRTDCB_RETSTCC_ETSTC_SHIFT);
> +			 I40E_PRTDCB_RETSTCC_ETSTC_MASK);
>   		reg |= ((u32)bw_share[i] << I40E_PRTDCB_RETSTCC_BWSHARE_SHIFT) &
>   			 I40E_PRTDCB_RETSTCC_BWSHARE_MASK;
>   		reg |= ((u32)mode[i] << I40E_PRTDCB_RETSTCC_UPINTC_MODE_SHIFT) &

Thank you!

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
