Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903067D694A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbjJYKpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbjJYKpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:45:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ACE18E;
        Wed, 25 Oct 2023 03:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698230698; x=1729766698;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bmCx1Ax5vfql01sG15GolfbAJ36rW8FiAgbFU1nYr5w=;
  b=oDFHe4If7X+QUgrZXJDYTXP/8eK/d2hYGJfqMwp8j24RU3dckPzvn4+x
   t/NVzfE/epjJ//s2dzwQhlRdCnxtl+2Kksuf50qbIPne9pYbQgntti3lI
   HIVKiEYcheIUEhdPCbL1IUeZGzkBYItyvcslPHYkErSXWBf1sH6uJV57C
   wWX1ijhMz0AC3SWrL+RePjlaOuaC8C34qhivYlHo8PzCZRqeD3Eq3yp6s
   HiLzGnoZQaoZ+LK/6l/LT8TNmvkfHBTomk4iMO6540rETnaIpEGRBF0zF
   O6b7clCsHlsan7HLi/i1eetTR6NW/2yh5cXKb4dBUnqxY7tedQJXUcLxd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="386165107"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="386165107"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 03:44:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="902520922"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="902520922"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 03:42:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 03:44:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 03:44:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 03:44:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7X5YFwArcl1fMwmkUrjjwuGI94rEl/bqWOBLfLcIMtHF2Ex4IxDRhxubOaYkBOlDVsHtHHdw/QKXBxU26oUxMrd6pvTDJYHJ/dWw+Lkjh25Dkb46akysvQUgaClVAj+WTRUHhzaScrTJKq6WoCDfE8ILsPX3bW8xIu5L8tLApq7y8J49lcTD23uvBZD3okyWuOO35OQe8fSo46GPUbZoRTdddz6xfspNpw9AItNLi4gd7hxwGjGpd9s1q4oDfs7OvZ3OmrGy0oUqmS8yEKBZb+tzcSWQpSFVZ3HqAGLlpk97kKAGcc8JHikTfB5H2TFsdHkdsLjCg4zj9q2FdDl6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vz89rZT467YLMxmJtjI6aWeEfi97gh+00z4C3urd0QE=;
 b=kjVVoL8N6ePqvBE+PIw30nGuhBgeZrb6RrlUcSIhCF0e8DFMj/yGD0io98W95BX8tCH0pTtV9nORtFW7mGdZj9M7DZnAUtMQ4YFiITiET3H1JFZDGUTMbUW1/rQMpClno5rPFjXlhxL5Hpk0vjzGy5ImHwsf6QtIcFH3wMB70SQ4XMkQvG3yA5bEDu/rLw5J/xafVgWXrz50eMbdI7Y0wCD2Tes9MnFUvs5JiTKtrQBK4xP/TqAwLDQs/NCa27/XTD1p3kYCLRC71Ml/6/KiCjW1yY5/KvFSkxlCIF4YyiC8jy9Dd86pIj533xXjKzBFxY6meGTTW6Q9OxnQqNKQNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH0PR11MB5829.namprd11.prod.outlook.com (2603:10b6:510:140::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 10:44:48 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 10:44:48 +0000
Message-ID: <1551303b-1936-4e87-9444-d991bf3474a1@intel.com>
Date:   Wed, 25 Oct 2023 12:44:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 2/2] i40e: Move inline helpers to
 i40e_prototype.h
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>
References: <20231025103315.1149589-1-ivecera@redhat.com>
 <20231025103315.1149589-3-ivecera@redhat.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231025103315.1149589-3-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::20) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH0PR11MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c1af40-86e6-451a-1742-08dbd54768a6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BlpAGG/VkYCjbq8gIS1CREI750/9ttBHXbgnkqA9+sNbSOuMhQPt1rC8eNlJJMGOBlOz56jq8tTAc0ZlQCDPNUhOrihZC2TNVXdzfU2xyM+CrEM071gs+DZURHzZVLMBhX27m/Y2ya4/TBt9ox6D5TiF9miOXHz56NRRgF0qwk+euR1TywrjG/BYCR680nRcGd603hCPwlgz9RlQu5GI8l2hNr7I94qeX2vA2/iJeE4TTJe+iNMzYyToDMc1+dlDh+DveZTHyQXJgeEfIzXG3OPgw5oMo2+YFll8ItPgIpv9IDIas841rMCxXvrH9RArb83R6Nz1xvj8pNH256RE3VazZR6UVf5/ewasWdpw+q+Y0qcVTbVqYBooxvAcNiMm0WDzy4gDazgdgkyislhu6bEowZ0ifoC8lMn1xqdY28q4hgECdjJOuNWF6vQddmG5dfFAjo79pG4WAuRPCbR1j1OrylwmP4VfGNROXKpU+H5fSugWtpcPjYNDv9Ivi/dqZtP68HsrZy6t8o2Dmgm7L873UxkE6PyMCR6j7OZrqd92hExLEMHetuM4S7rjnan4arXJLg4tH6s/LkaMF/HipotXnOXFoNkMn54y7EOcnmzdFYZXLsib3NrNsVBVB1FK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(376002)(366004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(83380400001)(36756003)(4326008)(8936002)(8676002)(26005)(82960400001)(38100700002)(86362001)(31696002)(2906002)(5660300002)(44832011)(41300700001)(966005)(6486002)(31686004)(6506007)(478600001)(66946007)(6666004)(6512007)(66556008)(66476007)(54906003)(316002)(107886003)(53546011)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGZVNEt6QTFWSlg3cXN0M2pJRnRlUjBEc3NIRFVIT0xUdkozYy96VzArOVE4?=
 =?utf-8?B?VTdBclVjcFJxV1ZRQkpIWkRlZWpmZ3RzVEdiOU9zeXNsYW5kS1htNFppczZz?=
 =?utf-8?B?YjZjV1VJbHpQU1V6eWlFVlovZGJPTllrTXdhR0I0OXplS3NUMEdkR2xNUzU0?=
 =?utf-8?B?YUhPU1JLYVpURmJzUGRtRFQwNEdzd0lQSDR5akZTeGNUaGdQQ3RLRDlRM29q?=
 =?utf-8?B?ZGNHNzBlbVd1N0h4K0hvRzlYUXRQYWxwUVdCczk5MVZlV1Q4U0ZrczkzMUoz?=
 =?utf-8?B?S3RuS3dMbkF1U2lvZUsreURITWwxQ1kzZ09CRkRNc2owZnM3VFMyeGJlZytx?=
 =?utf-8?B?UVlaZ2w2VjI4dmgwbXpkRG5Xdk1QaHdDSGpvNk9LNE56VVY5STc0aDNLZW1r?=
 =?utf-8?B?RGpPeDUxL0sxZ2tMYVJJOWE0Q1VLUm1ic3UxckdoVkcrQzFWOGI3VE9NVDVv?=
 =?utf-8?B?ZzRCY1FqN3lzWTg2Tlo5YUlYL21vZ3A5bjFUYkVJM28vQXQ2ZnQrd0xiWVh1?=
 =?utf-8?B?bFZMWjkxaGhXeDcwYjhHcHN4MEtWRjkxemk3QmZzZ0dNbVg2d0JzMnpWaXF6?=
 =?utf-8?B?VTJEelE2OHVaQXR5NGNicGxmc2owdng0TVVpS0tHcmNRY2pUQTBwVnBaSldO?=
 =?utf-8?B?OFhJOW93eUxrUmtVS0E5NW1EREVVTkxyME91eDU5ckc5LzJGN0RSczI0QnhM?=
 =?utf-8?B?V2tBSUhsZ0V0d3h2c1RVN0ZrWE5zcndCNmpkVXltOEhtZ1B3QVF3N1VwcE1M?=
 =?utf-8?B?Rm9JdnZNVmg5aGF4MHJHQ2YwSmQ3eXNSY29IRDVYZk5GUnhNMlhlKzNtS3JZ?=
 =?utf-8?B?MDByOWRUVVBDc1h2QWU5K3h3WStuKzFpNGtRRGVYUndNeVlTNEJYRFVNTTl3?=
 =?utf-8?B?aWliUVlmMTBCRUFoN3g4Rjc0bGkxbXAzQng2VW5XOE1XM2RPbU1HNGRyV3M1?=
 =?utf-8?B?dDdsOThmUVZkb1VidmplbFZIN2pxQjZ3MUlDd2pGUEtqTDl1MU1ZeVFkekl4?=
 =?utf-8?B?Wkd2TzlRNUczV1RMQzJ3T20wQUVlSDdtdnZlL0xlL3RIV0dUT3oyREt6V05N?=
 =?utf-8?B?NkI1SmZjc1lKQkVESDhtb3R0UUNhV2dRT1hrQmFTQ0ZzTXpFd3ZCUDBUenk5?=
 =?utf-8?B?SUdlVmNrVTZJSE9FNkh3azZrS3ZEZzYyWFc3ZGJxWXNncEtCMkg3Qm1SWTlN?=
 =?utf-8?B?ZWNZb2xyVlcyWXorTGQvR3dveWpzZnJUQVJpZDg0aWk2WGFBQnB6NzZXWERS?=
 =?utf-8?B?dFBROTJ4ODdad3RCbDZZZVEyMkpIMzExcEdrRFJ1VHJPT1FJVlN0eEd6R2Fj?=
 =?utf-8?B?dHlvTXRGeWFOYzMrLzY0dU5WMTNnS1NhdXhieXNYcXY3NEhLY2pKZHNqbkRz?=
 =?utf-8?B?ZTFJNkRJVDNIeUpjdHFEUXJYRXdRdDBvYWk3V0NYSHNUd0gwZEdCZGorNlpS?=
 =?utf-8?B?M1FFbUcwS2I1V1ZIYklYSGRGT2JVdjd3MDVnZE4xcTZYc2xFL1FGKytqbHlB?=
 =?utf-8?B?WFlnb1Q3SVpLQmh3WElJM3EyTVlWRVRYRUxLdzJpQmNPMEU5ci9OcHR5RWFQ?=
 =?utf-8?B?RngvaDFWbEpQcERaRlpjNzRlTis3azRSWk1Yd25KejY4aDhENE9WVC80NDUz?=
 =?utf-8?B?K09yd3AzS0FYc1Z1M0puQU5Vd1V0QUxJckxyR3lXYjEvYXpBRUJ6ZVBwS2Zo?=
 =?utf-8?B?b1NGOXZKdEVYUDBXSWkzb0FsS2JNenVUdVhYWG1jQlRObmxidnVSTGQrUDUz?=
 =?utf-8?B?eDhOYjRSaUp0dU9Nc01LOUdOZTJuUUNwUVVMNmxJTXc3cmJiZXdScFNzQ0pu?=
 =?utf-8?B?dENreEplS3MzdU9ldXQzUUQ3aEZ5TlBoWDl4Mms3TTNjMDBLNzkxMmY1c2VB?=
 =?utf-8?B?UmV2b2x0V0N1MjNwamdSZVpIS0JrMk82a1htYWU3YVIxM1h3SkhTUGJXY0x3?=
 =?utf-8?B?TFRENmxhU1VIUGVMMmw0dkVmNnZmSUtXbTVlZGpyNXZhT0JVYlVVWG9nVzNr?=
 =?utf-8?B?d0grV2h2dVMzS0dNNVlXbksrVmhiMGNuck4rZmROZytleUQybzFiZ3RUb0Rn?=
 =?utf-8?B?STU3QlBXSTZOVUVkbmpvQjltM0ZSMkNVVG5yejBxQyt3UnJFTkVRekUrZmcz?=
 =?utf-8?B?ZW80UW12VVg3QnpKZFozR1VHeEJWSTdweFo2SFJUMDB3Z3NNajdYc3hmM3pI?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c1af40-86e6-451a-1742-08dbd54768a6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 10:44:48.0717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b33NngN1fz9gcmI8///o53BlAx9gfXi8Iyzu4ByiBENsIqhvQw/Emf7gAxp9wyn/Tt+4VdQPYYeX/HBF6uZLCMOAB5Ei9jKd9QbthhQIEZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5829
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.10.2023 12:33, Ivan Vecera wrote:
> Move version check helper functions from i40e_type.h to
> i40e_prototype.h as per discussion [1].
> 
> [1] https://lore.kernel.org/all/cdcd6b97-1138-4cd7-854f-b3faa1f475f8@intel.com/#t
> 
> Cc: Wojciech Drewek <wojciech.drewek@intel.com>
> Cc: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---

Thanks Ivan!
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  .../net/ethernet/intel/i40e/i40e_prototype.h  | 70 +++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_type.h   | 68 ------------------
>  2 files changed, 70 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
> index 001162042050..af4269330581 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
> @@ -501,4 +501,74 @@ i40e_add_pinfo_to_list(struct i40e_hw *hw,
>  /* i40e_ddp */
>  int i40e_ddp_flash(struct net_device *netdev, struct ethtool_flash *flash);
>  
> +/* Firmware and AdminQ version check helpers */
> +
> +/**
> + * i40e_is_aq_api_ver_ge
> + * @hw: pointer to i40e_hw structure
> + * @maj: API major value to compare
> + * @min: API minor value to compare
> + *
> + * Assert whether current HW API version is greater/equal than provided.
> + **/
> +static inline bool i40e_is_aq_api_ver_ge(struct i40e_hw *hw, u16 maj, u16 min)
> +{
> +	return (hw->aq.api_maj_ver > maj ||
> +		(hw->aq.api_maj_ver == maj && hw->aq.api_min_ver >= min));
> +}
> +
> +/**
> + * i40e_is_aq_api_ver_lt
> + * @hw: pointer to i40e_hw structure
> + * @maj: API major value to compare
> + * @min: API minor value to compare
> + *
> + * Assert whether current HW API version is less than provided.
> + **/
> +static inline bool i40e_is_aq_api_ver_lt(struct i40e_hw *hw, u16 maj, u16 min)
> +{
> +	return !i40e_is_aq_api_ver_ge(hw, maj, min);
> +}
> +
> +/**
> + * i40e_is_fw_ver_ge
> + * @hw: pointer to i40e_hw structure
> + * @maj: API major value to compare
> + * @min: API minor value to compare
> + *
> + * Assert whether current firmware version is greater/equal than provided.
> + **/
> +static inline bool i40e_is_fw_ver_ge(struct i40e_hw *hw, u16 maj, u16 min)
> +{
> +	return (hw->aq.fw_maj_ver > maj ||
> +		(hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver >= min));
> +}
> +
> +/**
> + * i40e_is_fw_ver_lt
> + * @hw: pointer to i40e_hw structure
> + * @maj: API major value to compare
> + * @min: API minor value to compare
> + *
> + * Assert whether current firmware version is less than provided.
> + **/
> +static inline bool i40e_is_fw_ver_lt(struct i40e_hw *hw, u16 maj, u16 min)
> +{
> +	return !i40e_is_fw_ver_ge(hw, maj, min);
> +}
> +
> +/**
> + * i40e_is_fw_ver_eq
> + * @hw: pointer to i40e_hw structure
> + * @maj: API major value to compare
> + * @min: API minor value to compare
> + *
> + * Assert whether current firmware version is equal to provided.
> + **/
> +static inline bool i40e_is_fw_ver_eq(struct i40e_hw *hw, u16 maj, u16 min)
> +{
> +	return (hw->aq.fw_maj_ver > maj ||
> +		(hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver == min));
> +}
> +
>  #endif /* _I40E_PROTOTYPE_H_ */
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
> index 7eaf8b013125..e3d40630f689 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_type.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
> @@ -586,74 +586,6 @@ struct i40e_hw {
>  	char err_str[16];
>  };
>  
> -/**
> - * i40e_is_aq_api_ver_ge
> - * @hw: pointer to i40e_hw structure
> - * @maj: API major value to compare
> - * @min: API minor value to compare
> - *
> - * Assert whether current HW API version is greater/equal than provided.
> - **/
> -static inline bool i40e_is_aq_api_ver_ge(struct i40e_hw *hw, u16 maj, u16 min)
> -{
> -	return (hw->aq.api_maj_ver > maj ||
> -		(hw->aq.api_maj_ver == maj && hw->aq.api_min_ver >= min));
> -}
> -
> -/**
> - * i40e_is_aq_api_ver_lt
> - * @hw: pointer to i40e_hw structure
> - * @maj: API major value to compare
> - * @min: API minor value to compare
> - *
> - * Assert whether current HW API version is less than provided.
> - **/
> -static inline bool i40e_is_aq_api_ver_lt(struct i40e_hw *hw, u16 maj, u16 min)
> -{
> -	return !i40e_is_aq_api_ver_ge(hw, maj, min);
> -}
> -
> -/**
> - * i40e_is_fw_ver_ge
> - * @hw: pointer to i40e_hw structure
> - * @maj: API major value to compare
> - * @min: API minor value to compare
> - *
> - * Assert whether current firmware version is greater/equal than provided.
> - **/
> -static inline bool i40e_is_fw_ver_ge(struct i40e_hw *hw, u16 maj, u16 min)
> -{
> -	return (hw->aq.fw_maj_ver > maj ||
> -		(hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver >= min));
> -}
> -
> -/**
> - * i40e_is_fw_ver_lt
> - * @hw: pointer to i40e_hw structure
> - * @maj: API major value to compare
> - * @min: API minor value to compare
> - *
> - * Assert whether current firmware version is less than provided.
> - **/
> -static inline bool i40e_is_fw_ver_lt(struct i40e_hw *hw, u16 maj, u16 min)
> -{
> -	return !i40e_is_fw_ver_ge(hw, maj, min);
> -}
> -
> -/**
> - * i40e_is_fw_ver_eq
> - * @hw: pointer to i40e_hw structure
> - * @maj: API major value to compare
> - * @min: API minor value to compare
> - *
> - * Assert whether current firmware version is equal to provided.
> - **/
> -static inline bool i40e_is_fw_ver_eq(struct i40e_hw *hw, u16 maj, u16 min)
> -{
> -	return (hw->aq.fw_maj_ver > maj ||
> -		(hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver == min));
> -}
> -
>  struct i40e_driver_version {
>  	u8 major_version;
>  	u8 minor_version;
