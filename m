Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BFC7D7FC2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344531AbjJZJkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZJkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:40:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4581718F;
        Thu, 26 Oct 2023 02:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698313235; x=1729849235;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Coay/re5rMZkrDLSPkXXr7pTFI430Ly8cDFueJt3VbI=;
  b=DWpV1W0MvjO0KHACnwQiTwF9p6qrcSPSZN1a4/Ke/x+TDpQhywuOHcZZ
   Xh1d4vSP6YcpuY/8zRGL1PaOBddmeUxjekgLGfMJy8+lzZ2l0WOqOY4VJ
   fK64HEQuYmZe51zOfIGocgoCVmqiekjILxqSUufkabrNdrqtbhLBHG/9C
   /3RBtMi+sORbGYe6bZRL9ywyvQQvI3KYMbLqojPclApt3zUMhhHAm3Y3y
   1cu/jArhVqToKdN59Wei8pIHzo3Q3zQN5YkFL9oIh78X7Ik87FC9VcO3F
   I4J+wxTBrEWQfCYR1lIf3Z+FOTBZCz1s7U+kF9TclMdY5Y+jGm80sM8V5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="390360668"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="390360668"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 02:40:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="1006311168"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="1006311168"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 02:40:33 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 02:40:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 02:40:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 26 Oct 2023 02:40:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOh2uXwW5hIYaO/Kb7Szi/aUyoN0yVKFJNdLgE9pdEbfW6+T7IC76dFRcsPQHzW7QAi1I/Gpb/w7FLPFG0YK6UxNz1DhOkknhLgoDo6ZtX8hfidzmEkKSFoaUwnUS3RpoFcdK2My5fTCP8F8Z9WZq8z2oRCamRQ03sVbkyychz/mcuQYISkwDVg3IRNAuqRg0255t8UjKHZEDS4iRjmmbKs1MxP2K6+oDez6MD0BP0GyfG0nVf0AzdpYY1Tk6Sw8T/q5V4Thgj1PuAGgVRrolrYEQ+m5X8mh5Gm4MGYMwVmOsBUcy/FQ50pN6F0+jMFXeOaLGM1AryAya8UTOFVzSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VBJz6mR+OggAH+qPqcL2dYIyLRmZ04rCgMjauvN7Y4=;
 b=GeDRhrub2tMS4qg/JB2ulqel20O7P8t3KiXnYTLmcXhOhVWwaPglTSOceo7N0GfNUO9P0ywxGBkURztF0Ffansi7pG4HECOE/wx87YECHS1+5MVMa2lzUC/UDGDxHT0i3L7T+f5nv5o/mutGhR/G1kCA2TbGTSU65MDer9CToewHBVeRlv6WzpfUcD5OlhvpXIvZDDjSybA0x53VuFTTSryAjL8OBWTF7ycz7KbCi4cZ1ghJWrpTEGjptrzmHhHYFz9YwM5fYtHwasG7tX34AsNI0FtZAdX4YDHjnPD75AWMFkf4fkWyOSDW73oAFrQl9C2DapXTZiDX17udHXlUEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by BL3PR11MB6481.namprd11.prod.outlook.com (2603:10b6:208:3bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 09:40:29 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 09:40:29 +0000
Message-ID: <b3e2e8ca-eec6-45fd-bc67-53fe0d8daffd@intel.com>
Date:   Thu, 26 Oct 2023 11:40:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next] i40e: Delete unused and useless i40e_pf fields
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
References: <20231025145937.1873040-1-ivecera@redhat.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231025145937.1873040-1-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0017.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::17) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|BL3PR11MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: b19e95eb-bfbb-4b70-8670-08dbd6079718
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D7hx7e3cjteKPZkFd1ZC+dG1hjFPF9a7vLjJNAhUU6kV/oGAp5LpwT+DZu/gJ2I9BI+gkWPJ7ryYcWHGRVqD5+mDMeAL/UsOAEiEUxlukvqxtmOlcxVJC9y7T1EX7UKtbh9Ui13B07D9vddz89kxmrJsLTPa/hKLyW/ihEhnshkUhIyqRpEilPd1/bteDtL4Eb3GQHAXfQNMpEgp2qDFjJAk7DPcJ5HEM4ZOLMr3UPGTSv+5rBXIsVrshxp/CQ8CVZF5WLSxhf1VTeEIc872pD3GWhpNCpuKLOzcg611T7asTe2yAoX+yNIjpJcx232J+8otuzVIm1gTYm7AWdpk/6s6w2RrnsbM04UEDfJJ9r0XJwtNQouGuClYvj92hXxGA+pqCn74oSGUq+2u13ndFYQJqWeuEI23MKHGW+GBPc/atfM8rxnv/pOFazRp24H46BlH3E6049GCRz7i+pZWEfB3tVnOkMUa1YlXwaqYLZHZgrjTHZryV2GMot2y4yed4LlRTE1b0LTRpDKE6zXPkhBUQySZKtgCy8fQyE95kjeA8lEy+3jRoWRyrJXKfCDFYnCUItD02Q86GtIRIlqcTcm0G5/1DSpf7OUGeYXrWb0F4D7tTH9nzkfQZT/NdC2dNQvGYAPZQm+VXM2cmw3fXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(86362001)(31686004)(478600001)(2906002)(4326008)(5660300002)(38100700002)(44832011)(8676002)(8936002)(36756003)(66476007)(41300700001)(316002)(54906003)(26005)(6666004)(6486002)(31696002)(66556008)(2616005)(107886003)(6512007)(6506007)(53546011)(66946007)(82960400001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzdTQmNZU3hjMnNWTm5GR0p4bHN4dEQyVlAyVnlIMXhxOUF0UnFrRnFRZk1q?=
 =?utf-8?B?S01HODVJNldRZzhrSlFwR1h4Z1BYbWNYSmU2TVp3WmtDajBWaWJaV205S3NO?=
 =?utf-8?B?VlQ2UVQxbmJST3NrMSswbXEvMXBhUzZ4cHUrNFp0QndMOTRrMHhFQUVtK3Jj?=
 =?utf-8?B?K3k3VWswclBsZFNkZVlRcFNvNGxIL1RLNUVmZlF1SVpOaXFEc0lTalkzQ0VJ?=
 =?utf-8?B?MVh2ZnlMLzl2TkEzS3hjVDhrYkdKMVlxWTg2UndpRkJnSzh3eDhRclJKUVVy?=
 =?utf-8?B?MlVleVJ6eThIbDJkQjZ4ZTdQb2RSbG1KRlNYeTVGVWczRWwza2xTRWlyZ1NH?=
 =?utf-8?B?VWREYStaZHBnTXpybWViYk5odlVCcTJuMERiVVRhM1lPSDYrRWE4S3FBeTVF?=
 =?utf-8?B?UEZXNnVEeFJ3VmdyNGxBdWx4WGN0c1locnRFNlZ6ZUdtZkVaRzFBVlNlZGI2?=
 =?utf-8?B?aFE0bzV0REptWWpTR0Jvakd3dGJzQVpieW9nZHpvSmVYMXUzL3ovU3dlbTBI?=
 =?utf-8?B?L0QxR2I2bWZGd2RPKzMwd3lUdDk3SVU5bnRTTzc2eXV4YnNvSjFSZ2lrM1N1?=
 =?utf-8?B?ZFhPL3d3WGkvamE2cXRpbkl5RFZJQmhHTm9kZm5GN2wrUGtyM0JJb0xkdjZk?=
 =?utf-8?B?VGd1SitnZlRMR0k2QnF4Q205czFGY1FWVG1iYTlldTNSQkdBTGZuZTVVT2hO?=
 =?utf-8?B?c2cwNlR4ME9Cb1h2ZW1SbXg3a3BqUTZYUHA0N2FnQ1o4S0cyYk02MGxnTTNr?=
 =?utf-8?B?UklQU0NOV3ZRQ3VPVmNoMGk2VjFYZU0rWnBraTVLTGdVSW1YcE82SFZDM0Vl?=
 =?utf-8?B?WXRXUkQwS0MxTU5Oa0pXWTM0RThpMEsxSmxmdDhjMzVoMHpKenZCdXN1VDND?=
 =?utf-8?B?c2dwd0c3OGJhSTdRdXo1OC9BSCtMM1ZhSFIybWZUUVAyUm5VU251WEZ6Mklk?=
 =?utf-8?B?Uy90eUZqWkNRei9UMWsyRjlWUnRKbG1oTXlXd2tuY01JWnFDWE1UVFdYa3Ri?=
 =?utf-8?B?MXRFOGNEaUVvOTgzTzhmMVU5aHZISzFnMXdLZTNyeEc5RUpGSU02KzBCTGIx?=
 =?utf-8?B?U0FuRzN4eCtqSkk5Nk85VU9hRlBVc0p5Z1JmaytxcHc4L2xLOGVvSnNERzV0?=
 =?utf-8?B?QiszMWw4N1lkZU5HVThXbWpHRWZhRlIzSWovS25VOThQeldQZDZnMEZzdGx1?=
 =?utf-8?B?M0xvLytzMmxsMTMvMStxblltKy9rQzVlclhsNmF4TlF3VlFMeW9hQWhxZkNJ?=
 =?utf-8?B?UE90aGJKVVNvMGpZMXhYaUtiZFBqa3pOWi9iNEU0ZGs1QzJjVS9JQ1dzMUxv?=
 =?utf-8?B?Q2FQck1VclArVjhUekR6NUx4QjA5enBOM0s1RWZnY3ZQNzhjdzZrS2NSVm9G?=
 =?utf-8?B?MEhqQWdNRUVJWG53WmZEL3JhOFVwcG9OYk9KNmhSaE1ORHJBNHNqYW45cFVU?=
 =?utf-8?B?aVBhVHkvV0RQOXpEL0d5ZnF6bjdaN1RRL00yL1FVZWRYaUdzYVFOTno0WDJ4?=
 =?utf-8?B?N0Rwb2QyQ0ZmU3ZoMElNU0x6ZHduamRIWUZlcllrYmJud1dpK3dRNjJ4ejlq?=
 =?utf-8?B?OEFNbzM3cEt3UFJNWmMzci83NGVSRWxqYjl4RFNzOURDMklRT08zci9RV3Rj?=
 =?utf-8?B?Q2Jia0hPUnJuZUludUh3OEhxN1k2NjBZcG03L1dtR2U5eHVOWEdWcVhrRTV6?=
 =?utf-8?B?aTREZWE4YkFXbDMyNkpDZWZydHdIbVNnV1VKK1FJYlg4cGl6M3g2bURKTGMr?=
 =?utf-8?B?UnZMMm5tZ0FGazFoVEhuWXg0dkljcHpjUUYwM1RRaDNCNWhVVjJ6WlBmSnhK?=
 =?utf-8?B?SC9RVk9qaE9xUXhBL0Z4NURsWHYwTElSckxnMWtCekw4dmtIMGRHMmxhTytU?=
 =?utf-8?B?UDNRSDlESlp0Q00rckpBdnNWRzYvdjNEUkRoZWdUaHZoUURsS1pPVW5PWmtM?=
 =?utf-8?B?RmFYbTA5R1pLaE1vblZac25hK093Z0JJV245Q3ZnZVV1Q0JVZ3krMHNuUTEr?=
 =?utf-8?B?bWtSVkE0cVhmWVFNM09VT3B0emo2dTJWb3BBZ2VhQlk1WlptYjc1eE0yUXN0?=
 =?utf-8?B?NWNtVHRjZW1LcUlBaWxxMHU2MWljK1o0eHhZTVl3Lzl3N0wzUzNMWGVhOFlq?=
 =?utf-8?B?SUFHUlQ2M2YyTmtiMlNJRXlEQWlxYmN3dlZ0dDhOMmw2WURMRXlxRVhyT2M5?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b19e95eb-bfbb-4b70-8670-08dbd6079718
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 09:40:29.3669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jW+VO51iVl1ZaTLx7Z4iHuPc7s8d6aJmSrGAQurmiOMjsTn72Ncp3yhXFv+ITHxzIn2SPkQcBDbEqI23cMRx9GsS5zhzTz9xq3gS3z0xBa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6481
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.10.2023 16:59, Ivan Vecera wrote:
> Removed fields:
> .fc_autoneg_status
>     Since commit c56999f94876 ("i40e/i40evf: Add set_fc and init of
>     FC settings") write-only and otherwise unused
> .eeprom_version
>     Write-only and otherwise unused
> .atr_sample_rate
>     Has only one possible value (I40E_DEFAULT_ATR_SAMPLE_RATE). Remove
>     it and replace its occurrences by I40E_DEFAULT_ATR_SAMPLE_RATE
> .adminq_work_limit
>     Has only one possible value (I40E_AQ_WORK_LIMIT). Remove it and
>     replace its occurrences by I40E_AQ_WORK_LIMIT
> .tx_sluggish_count
>     Unused, never written
> .pf_seid
>     Used to store VSI downlink seid and it is referenced only once
>     in the same codepath. There is no need to save it into i40e_pf.
>     Remove it and use downlink_seid directly in the mentioned log
>     message.
> .instance
>     Write only. Remove it as well as ugly static local variable
>     'pfs_found' in i40e_probe.
> .int_policy
> .switch_kobj
> .ptp_pps_work
> .ptp_extts1_work
> .ptp_pps_start
> .pps_delay
> .ptp_pin
> .override_q_count
>     All these unused at all
> 
> Prior the patch:
> pahole -Ci40e_pf drivers/net/ethernet/intel/i40e/i40e.ko | tail -5
>         /* size: 5368, cachelines: 84, members: 127 */
>         /* sum members: 5297, holes: 20, sum holes: 71 */
>         /* paddings: 6, sum paddings: 19 */
>         /* last cacheline: 56 bytes */
> };
> 
> After the patch:
> pahole -Ci40e_pf drivers/net/ethernet/intel/i40e/i40e.ko | tail -5
>         /* size: 4976, cachelines: 78, members: 112 */
>         /* sum members: 4905, holes: 17, sum holes: 71 */
>         /* paddings: 6, sum paddings: 19 */
>         /* last cacheline: 48 bytes */
> };
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---

Nice cleanup! Only one nit.
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/intel/i40e/i40e.h         | 16 ----------------
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c |  3 ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 18 ++++--------------
>  3 files changed, 4 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index 5926bcc76141..f1627ab211cd 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -468,9 +468,7 @@ struct i40e_pf {
>  	struct i40e_hw hw;
>  	DECLARE_BITMAP(state, __I40E_STATE_SIZE__);
>  	struct msix_entry *msix_entries;
> -	bool fc_autoneg_status;
>  
> -	u16 eeprom_version;
>  	u16 num_vmdq_vsis;         /* num vmdq vsis this PF has set up */
>  	u16 num_vmdq_qps;          /* num queue pairs per vmdq pool */
>  	u16 num_vmdq_msix;         /* num queue vectors per vmdq pool */
> @@ -486,7 +484,6 @@ struct i40e_pf {
>  	u16 rss_size_max;          /* HW defined max RSS queues */
>  	u16 fdir_pf_filter_count;  /* num of guaranteed filters for this PF */
>  	u16 num_alloc_vsi;         /* num VSIs this driver supports */
> -	u8 atr_sample_rate;
>  	bool wol_en;
>  
>  	struct hlist_head fdir_filter_list;
> @@ -524,12 +521,10 @@ struct i40e_pf {
>  	struct hlist_head cloud_filter_list;
>  	u16 num_cloud_filters;
>  
> -	enum i40e_interrupt_policy int_policy;
>  	u16 rx_itr_default;
>  	u16 tx_itr_default;
>  	u32 msg_enable;
>  	char int_name[I40E_INT_NAME_STR_LEN];
> -	u16 adminq_work_limit; /* num of admin receive queue desc to process */
>  	unsigned long service_timer_period;
>  	unsigned long service_timer_previous;
>  	struct timer_list service_timer;
> @@ -543,7 +538,6 @@ struct i40e_pf {
>  	u32 tx_timeout_count;
>  	u32 tx_timeout_recovery_level;
>  	unsigned long tx_timeout_last_recovery;
> -	u32 tx_sluggish_count;
>  	u32 hw_csum_rx_error;
>  	u32 led_status;
>  	u16 corer_count; /* Core reset count */
> @@ -565,17 +559,13 @@ struct i40e_pf {
>  	struct i40e_lump_tracking *irq_pile;
>  
>  	/* switch config info */
> -	u16 pf_seid;
>  	u16 main_vsi_seid;
>  	u16 mac_seid;
> -	struct kobject *switch_kobj;
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry *i40e_dbg_pf;
>  #endif /* CONFIG_DEBUG_FS */
>  	bool cur_promisc;
>  
> -	u16 instance; /* A unique number per i40e_pf instance in the system */
> -
>  	/* sr-iov config info */
>  	struct i40e_vf *vf;
>  	int num_alloc_vfs;	/* actual number of VFs allocated */
> @@ -669,9 +659,7 @@ struct i40e_pf {
>  	unsigned long ptp_tx_start;
>  	struct hwtstamp_config tstamp_config;
>  	struct timespec64 ptp_prev_hw_time;
> -	struct work_struct ptp_pps_work;
>  	struct work_struct ptp_extts0_work;
> -	struct work_struct ptp_extts1_work;
>  	ktime_t ptp_reset_start;
>  	struct mutex tmreg_lock; /* Used to protect the SYSTIME registers. */
>  	u32 ptp_adj_mult;
> @@ -679,10 +667,7 @@ struct i40e_pf {
>  	u32 tx_hwtstamp_skipped;
>  	u32 rx_hwtstamp_cleared;
>  	u32 latch_event_flags;
> -	u64 ptp_pps_start;
> -	u32 pps_delay;
>  	spinlock_t ptp_rx_lock; /* Used to protect Rx timestamp registers. */
> -	struct ptp_pin_desc ptp_pin[3];
>  	unsigned long latch_events[4];
>  	bool ptp_tx;
>  	bool ptp_rx;
> @@ -695,7 +680,6 @@ struct i40e_pf {
>  	u32 fd_inv;
>  	u16 phy_led_val;
>  
> -	u16 override_q_count;
>  	u16 last_sw_conf_flags;
>  	u16 last_sw_conf_valid_flags;
>  	/* List to keep previous DDP profiles to be rolled back in the future */
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> index e0849f0c9c27..6f289237a8b0 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> @@ -1029,9 +1029,6 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
>  				 "emp reset count: %d\n", pf->empr_count);
>  			dev_info(&pf->pdev->dev,
>  				 "pf reset count: %d\n", pf->pfr_count);
> -			dev_info(&pf->pdev->dev,
> -				 "pf tx sluggish count: %d\n",
> -				 pf->tx_sluggish_count);
>  		} else if (strncmp(&cmd_buf[5], "port", 4) == 0) {
>  			struct i40e_aqc_query_port_ets_config_resp *bw_data;
>  			struct i40e_dcbx_config *cfg =
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 7169ceb6b757..69dafdecb243 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -3465,7 +3465,7 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
>  
>  	/* some ATR related tx ring init */
>  	if (test_bit(I40E_FLAG_FD_ATR_ENA, vsi->back->flags)) {
> -		ring->atr_sample_rate = vsi->back->atr_sample_rate;
> +		ring->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
>  		ring->atr_count = 0;
>  	} else {
>  		ring->atr_sample_rate = 0;
> @@ -10242,9 +10242,9 @@ static void i40e_clean_adminq_subtask(struct i40e_pf *pf)
>  				 opcode);
>  			break;
>  		}
> -	} while (i++ < pf->adminq_work_limit);
> +	} while (i++ < I40E_AQ_WORK_LIMIT);
>  
> -	if (i < pf->adminq_work_limit)
> +	if (i < I40E_AQ_WORK_LIMIT)
>  		clear_bit(__I40E_ADMINQ_EVENT_PENDING, pf->state);
>  
>  	/* re-enable Admin queue interrupt cause */
> @@ -12785,7 +12785,6 @@ static int i40e_sw_init(struct i40e_pf *pf)
>  	if ((pf->hw.func_caps.fd_filters_guaranteed > 0) ||
>  	    (pf->hw.func_caps.fd_filters_best_effort > 0)) {
>  		set_bit(I40E_FLAG_FD_ATR_ENA, pf->flags);
> -		pf->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
>  		if (test_bit(I40E_FLAG_MFP_ENA, pf->flags) &&
>  		    pf->hw.num_partitions > 1)
>  			dev_info(&pf->pdev->dev,
> @@ -12831,7 +12830,6 @@ static int i40e_sw_init(struct i40e_pf *pf)
>  					I40E_MAX_VF_COUNT);
>  	}
>  #endif /* CONFIG_PCI_IOV */
> -	pf->eeprom_version = 0xDEAD;
>  	pf->lan_veb = I40E_NO_VEB;
>  	pf->lan_vsi = I40E_NO_VSI;
>  
> @@ -14992,12 +14990,11 @@ static void i40e_setup_pf_switch_element(struct i40e_pf *pf,
>  		 * the PF's VSI
>  		 */
>  		pf->mac_seid = uplink_seid;
> -		pf->pf_seid = downlink_seid;
>  		pf->main_vsi_seid = seid;
>  		if (printconfig)
>  			dev_info(&pf->pdev->dev,
>  				 "pf_seid=%d main_vsi_seid=%d\n",

Change the log msg to downlink_seid as well?

> -				 pf->pf_seid, pf->main_vsi_seid);
> +				 downlink_seid, pf->main_vsi_seid);
>  		break;
>  	case I40E_SWITCH_ELEMENT_TYPE_PF:
>  	case I40E_SWITCH_ELEMENT_TYPE_VF:
> @@ -15176,10 +15173,6 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool lock_acqui
>  	/* fill in link information and enable LSE reporting */
>  	i40e_link_event(pf);
>  
> -	/* Initialize user-specific link properties */
> -	pf->fc_autoneg_status = ((pf->hw.phy.link_info.an_info &
> -				  I40E_AQ_AN_COMPLETED) ? true : false);
> -
>  	i40e_ptp_init(pf);
>  
>  	if (!lock_acquired)
> @@ -15654,7 +15647,6 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  #endif /* CONFIG_I40E_DCB */
>  	struct i40e_pf *pf;
>  	struct i40e_hw *hw;
> -	static u16 pfs_found;
>  	u16 wol_nvm_bits;
>  	char nvm_ver[32];
>  	u16 link_status;
> @@ -15732,7 +15724,6 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	hw->bus.device = PCI_SLOT(pdev->devfn);
>  	hw->bus.func = PCI_FUNC(pdev->devfn);
>  	hw->bus.bus_id = pdev->bus->number;
> -	pf->instance = pfs_found;
>  
>  	/* Select something other than the 802.1ad ethertype for the
>  	 * switch to use internally and drop on ingress.
> @@ -15794,7 +15785,6 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	}
>  	hw->aq.arq_buf_size = I40E_MAX_AQ_BUF_SIZE;
>  	hw->aq.asq_buf_size = I40E_MAX_AQ_BUF_SIZE;
> -	pf->adminq_work_limit = I40E_AQ_WORK_LIMIT;
>  
>  	snprintf(pf->int_name, sizeof(pf->int_name) - 1,
>  		 "%s-%s:misc",
