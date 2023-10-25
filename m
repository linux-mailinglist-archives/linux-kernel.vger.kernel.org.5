Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB78E7D6B89
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343840AbjJYM1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjJYM1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:27:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91C29C;
        Wed, 25 Oct 2023 05:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698236841; x=1729772841;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xNiDZoiljT8FH7RshGjmJdlAU/xTfaaXDgz/Ox1vc1s=;
  b=TM0y9o0hgwyFqwmGQiQ97cfr7hblL0jp9/I8b9jDq0QfA4OMIilTSpK5
   PA80vDtspxDjsUQvK0qLHxWZJP8IBSgNAY06GF0uWg7iKItK9xilh5/nI
   /Yyw5Z2BZXA+tz7/bfz2+HCTBgYk5odAteKvQcyvXaYtaBXONQHuFO0Iq
   cAyxkUHA1QyInf6wBgqkDV+r3mdmX6UKdmaHufePBzXa2NGdCowiypWwC
   dIKPdPKp4pueJ6LUgrbbL5f+916tpeRkf20FtoFApkFw143eq3azu0bQB
   fMvgvtjF+7i3y7cDWJ8S0qtiUMQHXsupYfTM2hFotSXu4ZQ9T+i3d56uA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="451521966"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="451521966"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 05:27:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="1090190279"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="1090190279"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 05:27:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 05:27:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 05:27:19 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 05:27:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4128LubpF2VwXrsdJ5HozO7O8IVSlGiqovEUKF+vEfyv1aV+o11wUm/iIOIaxFjiDTyEA6ev9Zgnwu4LIEChDYzxS6GyqBWXZvr20n1wvhXz7bJCAwKOVqxz2umKOdKrCOQ7w4u4wgCQQB56aR7E8dEkH/HhsflOH+h+0MbXUnfBhMv9esl/haOehFRVZb8q8XF3XCFgK0OWGzkc+vV69qp1QxtyEH3uZyp88NJPKw8gBcV9L/30ip4Zm6m7EfN0UPI3EB/mTmKA3X1OsV3KZP6Df0h9L3H4OJBWiILH3OlUDnHs9GDDWiXkp37J1Iv35FA0RfvwNUxr8sb+x1+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEZDYmx/uAMBtIRrN5midfTPMcWjWgzXz1JU/3QCKeQ=;
 b=P31ulpLbmtX8f/byKsmElBMndoXwqzLq5Mj1kbgUTYvDw3Tl6KGzBGB7cu8TjbqDeXPtVT73OZVDjkkSgPjdOGAqZlqTi3h38mJyXhFTkUZHvybHUeHvT0FgGhN1pOHGt347GpEbCNmw87xhg4IfNN/vVAKxPdm7AjRE6q76W/Og3fFwhF6PDUhtpBLXOrqs9cnylsJUq1tvBHy+HBUYjc+1dLlthL9Eo9bMU0c9sIsc1IY9AaUt3AM1tVsQoP3TlTDqwLFnxcajLTgAk9ZFVuQx4TDtQrH3EY0+7AlfPHS8txnIkN7eECr8rG5EqxMGUwao0MuXdCIG5fuFuQu21Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DS0PR11MB7213.namprd11.prod.outlook.com (2603:10b6:8:132::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 12:27:15 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 12:27:15 +0000
Message-ID: <6cb52295-a20c-47ae-b75e-c841f665fdaf@intel.com>
Date:   Wed, 25 Oct 2023 14:27:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 1/2] i40e: Remove VF MAC types
Content-Language: en-US
To:     Jiri Pirko <jiri@resnulli.us>
CC:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>,
        "Jesse Brandeburg" <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>
References: <20231025103315.1149589-1-ivecera@redhat.com>
 <20231025103315.1149589-2-ivecera@redhat.com>
 <8a8f54a8-1a18-4797-a592-b57bc6fc45c1@intel.com>
 <ZTkHJ6IP4tj3EmCV@nanopsycho> <ZTkIH68kCzb+4VME@nanopsycho>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <ZTkIH68kCzb+4VME@nanopsycho>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0008.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::21) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DS0PR11MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: af7e4051-c4c7-4e6b-010f-08dbd555b8c5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8m6v1niUZNQtdJFww76xPZXA72Resbdyq/WH8+TuR6PEzYytHV6WjjrPm35v/ZXE7wXDY5fL8RwtUwlb4vNabvETvKhiCjVdNW7I/WVoLnEWtcQdne7I38F+H4XmN+eCfeT6LIcPSxNEvndfeJrEhzOAtppXyHKLBt4tgmJ8TS17+Cr/llfoK2Xxj2ejqvPia5gfkKbUtsqYsDrLfJnmb+tcIYT9HTlEeLEgJdEGVaoucF/NxnVTkgQrPz8n+AgHwTOciAt/4jw4ZXo/hdLohk6yXf4yZ0AOKge3a/orKEMqn+Va3UNeWS7NDFDeum/37QlzsqyzEIZ1sjdrdbIBLe/gewj8hwDvAQ1wEuqj5aUUgXBQt2w6I0y7TQ1VWsqa5VnsiOcFQ0IErcVVEBmL+0eyv3IkKRXceKxn9Y4Nh1hsXgfD4OP91OYLepc1y3lh5f3HRkg9jid5pL/nvz1qFD07KgGuN33Ibg/0KS3vu1M2R8/4uuel6Ymi+2Ze5H3XPJVi3hrFGBelTi72YUvXC1qgiJSwjw1SPoGLtTGHyqeOM2nth3FpAFpTuG/76T+d1irt8xI1mvVI6075CMS4AOFpFqcgono3YuHa3ZjzhByZlBVbs0pVAokjogb0tYXchGi1GqfztLV6J7FTpQPDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2906002)(83380400001)(4326008)(8936002)(44832011)(8676002)(6486002)(107886003)(82960400001)(53546011)(31696002)(31686004)(5660300002)(41300700001)(86362001)(6512007)(6666004)(6506007)(316002)(6916009)(478600001)(26005)(2616005)(36756003)(54906003)(66946007)(38100700002)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VCtycDNxbWdLa0VhSmZqQ2tVSEdoK3hUV0wxaXN3d0FqaW5rbEJCemtyeHdj?=
 =?utf-8?B?ZWdTRkFSTyt6ejBQOE9yNDcrVHlPWmlYWlNhWkdzSVRwdklZenhHNVJndEI0?=
 =?utf-8?B?YVloMFltaTBZWDVzTnBvQ2VZUXUrSmJmVWRuT0ZXNVMzbytBWDRhTFZMN1dh?=
 =?utf-8?B?dzJlSmtrZUZ1VDB6MVlWalFNUVRqZy80WUFhZGZXZFdBeDNJMEFzK3N5ZWFD?=
 =?utf-8?B?OFNRd0crNE9ma1FhK1pCQjNHNlFraVMxcEZWWUFtNU5kVENNN0M2eHpBYjI4?=
 =?utf-8?B?bGdjVUNCQ2hZS2dlMzl1RnNEdXREODdGWmJKbnBrQTdWVEdSQlJsZGd0Uzgv?=
 =?utf-8?B?Vm41MUpjZFdHMXFnUU1QNVVNeHRBczY1YlFsSWljVXA1YmUxTFNkVCtHNm5T?=
 =?utf-8?B?UlFwVHFEaktkUENjVlcyWjNsOEFTVXI3cHJ1ZGtoaU1uanhTVk1MTnlHMVg2?=
 =?utf-8?B?R2ZGY0xtWTFxaFhQQm1HVkNxY2hhc29SN0xTYWZ1NENBRWdyTXFFdUNEeURi?=
 =?utf-8?B?YTZFY3BuOVVaT2hBellGVy9wYU5pVllQRzFCZkZJdTljSlo3Y1Nhb3I3blcz?=
 =?utf-8?B?Mlo0N0paRjE0S1QvSFpDbjErTTJnMWtpS2JaY2FzZjZlSDhRbVp3bU4yaXQ0?=
 =?utf-8?B?cHJjelRVbXFhWHZTSUlwekZHN0pOdkx3ZnRmUXV0MnZzYTRza2IycFR3S215?=
 =?utf-8?B?Z3pUVUg5VXhSTCtDUUIyQks3WlZBVnJhVm5CajRNNGlNVDFJY2xYQm50WDda?=
 =?utf-8?B?NkE1QURtSGM5VHVzTUg4U2JydytwemxxRG5veW1wVG5qVVZEeE82Vm5HdjhU?=
 =?utf-8?B?NGU2Rzh2S2I1cDRYb2VtOTZQOVBrYnVnalJiNGlCU1ZSM2JTMDNVeW0yU2RW?=
 =?utf-8?B?eFFhVHNOdisyenRFV01SSDlNWlJ1bFoxZmsyL3VaZG04WUozZWc0S1A3TFFO?=
 =?utf-8?B?c1BDM2cxL2JOc1ltdVRXbnFDN3I2UzNVOHBNNDgzYUh6ZWRMNHJSbnE2ZG5o?=
 =?utf-8?B?UkdFMjBwVmtldHJNQkRXdHBYdGZ3djFzRXZQL1RjdFhDRW1wWGJLOEdaMjB4?=
 =?utf-8?B?TEtBNHRtVGdMOEkzQXVoZkhaS1VucHd0TlVxbms2K2U3NEFTMTVvVWhTN2FF?=
 =?utf-8?B?M1RLNHBXYkhhcDN0YVBzTm9KL3NBbE5tTW9kV1h2akpjTmkzeFFYcG91aVJv?=
 =?utf-8?B?QkVNUWJLZEE3WG9CbkxzeWdONElTNVFBKzBrVklZOXJwMkwzdzdDUFRWK0I2?=
 =?utf-8?B?eUMxRWNPZ05iZGx6aUNpblRJR1JmMWE4YzhZM2ZPRFlFYkVYTFBLSkVzczJR?=
 =?utf-8?B?clZ2V2R3dW9JVEczMzFUT0lIMW1kMXJsanMrbG1pZHo2aHJTVWg5TFJKaFU2?=
 =?utf-8?B?WTU0dnpvTDhVb0dKN0kralhYTmdjZThlVDZ3V3UzNm1VV0xKMjZyY056MWp5?=
 =?utf-8?B?cG04NlFFdFA1ZUpSd3EreFcxUXJaSEh2S1FDdjhCTUFKeVlPZG1yeW1IdVRJ?=
 =?utf-8?B?elcrYm9ibmhkb1kweTZJZ0Y5b05mZFA0MkgwRDNnZktEbm1TYjFiZEd6b2Rx?=
 =?utf-8?B?K1ZmcG52cnZDZTliM2VTTE1paEMzOXZpNTJMRkVpeDJFOUtBWWpuM0FRYy8z?=
 =?utf-8?B?UlhTZzdobGxTM29FWEJyUVE0NVhQbTd3dWxYMUFXL0tVREI1eWYyeitPMEsr?=
 =?utf-8?B?ZVU5c1p5NFkyVGlyaHV0dEYvZDhLUVlBZ25vUlBSSTJpRDdzUUtYT0J3dFNj?=
 =?utf-8?B?MU01VVBjNVNnQWg1eitsUHFoUnM5aGFLZ1djTm1TS0pzRE5JdWpXSGpnR01W?=
 =?utf-8?B?Q1p4TSszRlQ0Rm85REE3YWtlTzdNU3J6OFA3djZwcmpIZ2dBUFFtRyt5TnhC?=
 =?utf-8?B?R3F1UkdQd0dCWWRhUGNIOHRqaWtZRk9HYzArM3dOM0l6UWZtUkpkVCtVS3lm?=
 =?utf-8?B?dS8xUDBkMS9JV0JZOVR2a1Zlbm45ZHdNVS9CakozS2w2NjNSSXpqZllIVjYy?=
 =?utf-8?B?VkxhQWlOam16SnB5dVVPZERMdnplUjkrT2JSWVd5V1VoN3BEMk1VTVRCTFI1?=
 =?utf-8?B?ekt5bWFLdCtid2htTDQxNDlSbHlLMjhIcTN3QXhJbnVJSmZXTWpUc1B3QWs2?=
 =?utf-8?B?ejA1WWRNV2c0RGxxMEVLZGFKeDk5RFFQa1MybG0vb1RDcXk1MjBTV3BSTEV3?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af7e4051-c4c7-4e6b-010f-08dbd555b8c5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 12:27:15.4561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYTwZauP8yu6cXAuVkLCBKnf7mNh++Jsm87pKugTCQ1tktH9Z3CINYBoZV/2kusMtoIma8x6/eO5Ob6jbGaqSovBuqQRhFIz0RYTmPDTZeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7213
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.10.2023 14:20, Jiri Pirko wrote:
> Wed, Oct 25, 2023 at 02:16:39PM CEST, jiri@resnulli.us wrote:
>> Wed, Oct 25, 2023 at 12:48:37PM CEST, wojciech.drewek@intel.com wrote:
>>>
>>>
>>> On 25.10.2023 12:33, Ivan Vecera wrote:
>>>> The i40e_hw.mac.type cannot to be equal to I40E_MAC_VF or
>>>> I40E_MAC_X722_VF so remove helper i40e_is_vf(), simplify
>>>> i40e_adminq_init_regs() and remove enums for these VF MAC types.
>>>>
>>>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>>>> ---
>>>>  drivers/net/ethernet/intel/i40e/i40e_adminq.c | 33 ++++++-------------
>>>>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  8 -----
>>>>  2 files changed, 10 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>>>> index 29fc46abf690..896c43905309 100644
>>>> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>>>> @@ -17,29 +17,16 @@ static void i40e_resume_aq(struct i40e_hw *hw);
>>>>  static void i40e_adminq_init_regs(struct i40e_hw *hw)
>>>>  {
>>>>  	/* set head and tail registers in our local struct */
>>>> -	if (i40e_is_vf(hw)) {
>>>> -		hw->aq.asq.tail = I40E_VF_ATQT1;
>>>> -		hw->aq.asq.head = I40E_VF_ATQH1;
>>>> -		hw->aq.asq.len  = I40E_VF_ATQLEN1;
>>>> -		hw->aq.asq.bal  = I40E_VF_ATQBAL1;
>>>> -		hw->aq.asq.bah  = I40E_VF_ATQBAH1;
>>>> -		hw->aq.arq.tail = I40E_VF_ARQT1;
>>>> -		hw->aq.arq.head = I40E_VF_ARQH1;
>>>> -		hw->aq.arq.len  = I40E_VF_ARQLEN1;
>>>> -		hw->aq.arq.bal  = I40E_VF_ARQBAL1;
>>>> -		hw->aq.arq.bah  = I40E_VF_ARQBAH1;
>>>
>>> What about removing those I40E_VF_* defines?
>>> This is their only usage here, right?
>>
>> Wait, do you suggest to use the values directly? That would be
>> wild even for i40e :)
> 
> Ah, sec. This is duplicated in
> drivers/net/ethernet/intel/iavf/iavf_register.h. That confused me.

Indeed, in case of i40e they're going be unused after this patch so
there is no point in keeping them, I think.

> 
> 
> 
>>
>>
>>>
>>>> -	} else {
>>>> -		hw->aq.asq.tail = I40E_PF_ATQT;
>>>> -		hw->aq.asq.head = I40E_PF_ATQH;
>>>> -		hw->aq.asq.len  = I40E_PF_ATQLEN;
>>>> -		hw->aq.asq.bal  = I40E_PF_ATQBAL;
>>>> -		hw->aq.asq.bah  = I40E_PF_ATQBAH;
>>>> -		hw->aq.arq.tail = I40E_PF_ARQT;
>>>> -		hw->aq.arq.head = I40E_PF_ARQH;
>>>> -		hw->aq.arq.len  = I40E_PF_ARQLEN;
>>>> -		hw->aq.arq.bal  = I40E_PF_ARQBAL;
>>>> -		hw->aq.arq.bah  = I40E_PF_ARQBAH;
>>>> -	}
>>>> +	hw->aq.asq.tail = I40E_PF_ATQT;
>>>> +	hw->aq.asq.head = I40E_PF_ATQH;
>>>> +	hw->aq.asq.len  = I40E_PF_ATQLEN;
>>>> +	hw->aq.asq.bal  = I40E_PF_ATQBAL;
>>>> +	hw->aq.asq.bah  = I40E_PF_ATQBAH;
>>>> +	hw->aq.arq.tail = I40E_PF_ARQT;
>>>> +	hw->aq.arq.head = I40E_PF_ARQH;
>>>> +	hw->aq.arq.len  = I40E_PF_ARQLEN;
>>>> +	hw->aq.arq.bal  = I40E_PF_ARQBAL;
>>>> +	hw->aq.arq.bah  = I40E_PF_ARQBAH;
>>>>  }
>>>>  
>>>>  /**
>>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
>>>> index 9fda0cb6bdbe..7eaf8b013125 100644
>>>> --- a/drivers/net/ethernet/intel/i40e/i40e_type.h
>>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
>>>> @@ -64,9 +64,7 @@ typedef void (*I40E_ADMINQ_CALLBACK)(struct i40e_hw *, struct i40e_aq_desc *);
>>>>  enum i40e_mac_type {
>>>>  	I40E_MAC_UNKNOWN = 0,
>>>>  	I40E_MAC_XL710,
>>>> -	I40E_MAC_VF,
>>>>  	I40E_MAC_X722,
>>>> -	I40E_MAC_X722_VF,
>>>>  	I40E_MAC_GENERIC,
>>>>  };
>>>>  
>>>> @@ -588,12 +586,6 @@ struct i40e_hw {
>>>>  	char err_str[16];
>>>>  };
>>>>  
>>>> -static inline bool i40e_is_vf(struct i40e_hw *hw)
>>>> -{
>>>> -	return (hw->mac.type == I40E_MAC_VF ||
>>>> -		hw->mac.type == I40E_MAC_X722_VF);
>>>> -}
>>>> -
>>>>  /**
>>>>   * i40e_is_aq_api_ver_ge
>>>>   * @hw: pointer to i40e_hw structure
>>>
