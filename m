Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598E87D7F6A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjJZJRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZJRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:17:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42872184;
        Thu, 26 Oct 2023 02:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698311851; x=1729847851;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FLj48Qp4sEQj3y1y5bEj9oMe5zSwpxo00P6ZDmmvNG0=;
  b=U3RmnSH6LKL5+UDdcQ1be/8JAmvsvIlf2rQ/5IvtA/J4gOxd9upnIJ/c
   3OnwbgGVhGM3WomtZ54mPVoESb0F4Cs1P+dP6KXY2bmb6ymgkhX9/teBY
   gQvzKIRRIn8DtLZeIO2A4Ns9S27HcVJYxGDAOw+ICxg86bWYJfTCV3Ggy
   Fd6LmvwYt3Onqx7+OFFUfg9zDeNoCJNNLcCC0F3gkIVZHNbcvtkgv7KE+
   TOc3wFt60FeM2YuBhLNNp1yfsgf8DaosDJxaXZKPNN3GmAUz8bSc3Cq/z
   e/TKDhEmohsVYISSSYHFtYyOw1bU+HuTVtUzzVUiZwo8W2RYL1CBUIys7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="366844586"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="366844586"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 02:17:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="902829339"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="902829339"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 02:15:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 02:17:26 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 02:17:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 02:17:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 02:17:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdHBZQc/fWQgyTGNHoXyDaNsdj6BW+g/QTkPM2fcfveXVN8NVfmWbCWBU7IzrFTZ1kdb2W1Z9mkpiwgAtJC7T1NdPJwUyJDuNTxvlPT3nG6y5rkd4JR2mijuWVBVaDlzRTPCNVQkKqMol23W3AyZN2Y5pjgPlTmqY4+EBYm8R0w8gi9r/jv3Nh2VN978GvXkRLMqVT3wVFcAKg3hHKQxXGtHgJQGXzvBqct7ZLdxoe5J6ZXSlGsvZLzkJYxtJOb3CZgZAR+wckOtGxDptJw2v1K2KwtCv598zrWnknVDq8pPv5QPv/WZ2BsYWXtLOr8/DVBylWUQqcFCUkJBfjAG6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwJpumcAP7Mi+gww++qZ4o8GRVpz2ZyWPP5Cbv79rgw=;
 b=ieFEgSpotZdceHLnDLdWcdN+eNW9c2zf5x+hNOjPQZSYnnLbVlQEqVfQacpfLb5QB4sZNhkQfVL7neYUUMxwPYxuz8Bi561/cOpKIcQK4ti3TOekH2yFwm00DIHvHNAaGDicsk4xRJ0nmr9YQSQoZUegzPOxB6PyuwIzATkNhtVTT35qfQTT1IGfTMziGp7g4hlEZn1gPD/bhRfyc2xU20AayWCKxVV+c9ttZGtrw+/wuFDwrfBrGCPa/6/Y/sJvJG/pCyBwobRsigCxhXEFIKsleylp8vjzFIk8F1aXYCurQNrffgDnAvNZOOFNqHOoqCaGPODWDql4NqhZIvvHpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by CH0PR11MB5396.namprd11.prod.outlook.com (2603:10b6:610:bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 09:17:21 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6907.021; Thu, 26 Oct 2023
 09:17:21 +0000
Message-ID: <5b9282c7-f2a0-a853-e1f9-a6e27e57aa11@intel.com>
Date:   Thu, 26 Oct 2023 11:17:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] i40e: Remove AQ register
 definitions for VF types
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     Wojciech Drewek <wojciech.drewek@intel.com>,
        <intel-wired-lan@lists.osuosl.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20231026083822.2622930-1-ivecera@redhat.com>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231026083822.2622930-1-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::10) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|CH0PR11MB5396:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e88bb3-a57f-4bb6-d8a5-08dbd6045bcc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jw3/lMZ37OAlLFtTY635YcUeMXa0LeiUjde6IfAteXiubVMzPKCsRY8T0ckDuax9FqTHxynIPBQcxhgk8lQkigcSb3JKLTy0NGWhIjxQqYSg8iGsdmMnxrNYTGJ98jb4mkeGMQzOG5J3s7/ixqtS1EXawRx8sla152+F/k3ADHk+3H0Xs/TAtiI1y9Y2xXwOaxiJVu5RLxM9ei1W2dzWXZc82kSJ4+xoTmJXQCPzvD029jijOVr30JCc9FftQRhFKAd/mBKqP0TPN6Bus64CJ5rHJJS21hNeoeQSKgsG9onX+GdDEwdo5d+g6Dxe1V3mINrPTdweOGEPaWFiFEc8HhtJKIZ3tOBb/8YKLTjWAFsimpjI2eUeh/pyZXpiREToiG/XjYJ+wTpVKIg4e+XPG1sFQKOZl8rVYSqOBRBqMVJ9BXSPYeGcLbYyHlnL1lEexyU+/TvNy3AWB1GxTOo4vJ8IHSxZtz2B3PqF8pBs46/vZrGC756pMXgLDsKcnXfvhCo2Uo6FhYEt2l5K2G4c9FujkN262Xms8SnEexTlPHsTnf0+YBfl2/N5hg57N0XxNFes98Me8A0rSqz4u3wMOIR0bNy/BpiPcUej97TqJqEHhJZbbqkx7rN0AODhV2HXvmgZY8aqxR8m6DKF8yhZmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(31696002)(6486002)(8936002)(8676002)(31686004)(66946007)(66476007)(54906003)(66556008)(86362001)(478600001)(5660300002)(41300700001)(316002)(4326008)(6666004)(2906002)(6512007)(6506007)(53546011)(36756003)(38100700002)(2616005)(26005)(82960400001)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2t4ajJvUjB2UXRvZHNyOTJ2VEowM1RjbVdLTFp5WTZFSFNpRDgvSW1uSFZ5?=
 =?utf-8?B?N2pVcmRHalZIMTdtYnRxZko2RkllZG1COStoRU1TOVpTOGVHL0RmTGY4aGR6?=
 =?utf-8?B?SmM1ZDVjR2VHajJHOGxXcmtIQlR5S1Qvckc2MzNWRHZ4bHhGQlZlaURSNlhB?=
 =?utf-8?B?TGx3WFJ0Zkh6WkZVVVBxbW1DVVVzTkk0QUd5RVFuTHFkcFNqMkMvSDRtUlRp?=
 =?utf-8?B?MjFvYjV5ZUsyQk1TbVRFSUNWNm9nSHNjR0ZRVkZyQ0ZvMjFtdTVCV0w2dGlH?=
 =?utf-8?B?K24yS21VeS9XYzcwNTYyYno4NHdVSWNUdFJOenNOSGZMM3c5emhUR2c5eWVH?=
 =?utf-8?B?d3pOTzRRNHU1dFc0c0swbGdBVk5sMlB2TWc1YnVPMmFGSktDM2F0d1dhU05N?=
 =?utf-8?B?MW5iRnJFUWErQUZjaElNR2xjV2VpNHljSVhyT2xWZXRZZ0owM0FKaE96KzFu?=
 =?utf-8?B?Mk9aVGNIRnYvTEg0TTA1dGpWdm5kNUR4MG1zOU42Y3lZa1NXR2pHQkxic1d4?=
 =?utf-8?B?ZDU3NkVTY2dEdmU4YnZhcW9lczh3NVJjSVY3aGV6ek5uVFhuSk1IS2cxODJR?=
 =?utf-8?B?RFJMSzlZaUVFWEJrWEljRDliU2poc1dIa2FNcGtqZ291c2Izd2xWeDNiTnZr?=
 =?utf-8?B?dVVWY3JGYW10N0RIN0lqUW84S2NPSERKSkpsRFpzbUdxQmRWOWRzWEVpRzB5?=
 =?utf-8?B?b3BjM3gvRVZnZkRhK3BxNXJaL01mdVNpMkhEVFVSQkFNaktYVFBrOUVnYVpu?=
 =?utf-8?B?d1hKSk5YTDUwYTNYTDBxRklFQmhJZFNVZlVuS1p3YW9zUUUyOFhaVkVDNmtv?=
 =?utf-8?B?UmlXMVNlRjFBamZBUTRwV00vNjZFNjJScC8xcVVLRDhXbkxwbEMvZEZlaVJw?=
 =?utf-8?B?NklPK1V1Q0Npb0NMR1NobzhtWmlxQjV5MHJnQk00UkVpR3lGeG91VHRIR1Z3?=
 =?utf-8?B?NTNBYnpmM0tpUXA4NDlJQkNUQjJzakxKbW5VVGxJSFp1NTBxWjFCQjlqZzA0?=
 =?utf-8?B?YmN6VDBsSkRiZk5JenBsVzBZREJHNkhuSjZhKzlBV3ZkaUdSQjF0OEsveVY3?=
 =?utf-8?B?Tm0xd2hRWVdqZUVpbThmL3V0czZvZE1lVVd2NFdNQUtrMHpPNDY2eGZnWkZD?=
 =?utf-8?B?NjRlZEpSdTZKSHVQVVQ4ZTFURFUzTHhQaXIxUkFOeEdrTzRwN2lMY2N1aTE3?=
 =?utf-8?B?TGI1cWpmLzRqeFBlWW1sRzdtV2pUR1UzaCtkY3lGVzVVRDZ4OTJvVDYrUjhV?=
 =?utf-8?B?aVR6S05JMTJzbzJtb3Fuemo4Z2NGUjFwZzBhVGFnYVhDbDFHY0NlNGgwa3oz?=
 =?utf-8?B?Qm5lbU84UExVQ1BVMXJjOUZxcXQ1QWRCUUN5bVMzRGcrMldSQXJGQ3ZTWU9O?=
 =?utf-8?B?OXY0WHU0TWhlT3pzTkcwZDcwYnZVbFNuTEpUcUpWQ0cvUko1NW1CWTRkOEdB?=
 =?utf-8?B?dTQwR0pGU0ZCVGFRS3picUpuY0xNVllIYTkxdmNxTVIxLzd5RUJQV2lRVmpr?=
 =?utf-8?B?SWtHb083MFJiVTZDOHdpdGxwL3JlMTVRZnhnWWkrTTVYVU5MN3Vrbksya0Rr?=
 =?utf-8?B?WjA4cGdqYVluTTBUMG82b0tiWnptcXkxL25WV2ZhNmIxc2VISGpVU0twTDBV?=
 =?utf-8?B?TVBjblNjbWJ0Y3E5UnBOV1BicHNPemU4VWJwS3hEaGRUUjJBa0xqVytvWFE0?=
 =?utf-8?B?WnpWUUhrZHRrVHV5b1lIZFUxSmVRRGRYN3oyWlhXY3Q0dUwvNXVoZFFFU21x?=
 =?utf-8?B?THUwRTliTGM4MXUrRHRaWW0rSzNlTW1jR1Y4NytIN1l5elRuL1QxaFZiR0Ru?=
 =?utf-8?B?UEI5M1VkSGlUcTZzdEhsNkxaZGJUQ0x1MEhGQU5kUDhRWjluajFjVHRsUU1T?=
 =?utf-8?B?Nm10MnVZMUVwQXQvWnFqSEdHSTBZUG84b0NWK0hvMFUxOTRGMG1ESGlLRlF4?=
 =?utf-8?B?amY0VVY0b3pJbnFXNzRIa1Q4MEJnYnBKOHY4QzhRck0rZnZXSTN4UGVkQ0cv?=
 =?utf-8?B?c244aGpURUMyV2tPQ08zRDhTMk4zd1NHeHo5K0JGdlVoOHhmRmMveXpuR01O?=
 =?utf-8?B?YkdkM05YSjdKcU9GQXBlVzErSVFXcGhGVDZKQndZc2tFUjJKNm1pbWcwaXIz?=
 =?utf-8?B?N1BOQUN0c1o2VVh2K1FHcGhkOFR1a1JoMkdhTnFybUxyQjBUL3VZL2xIQ081?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e88bb3-a57f-4bb6-d8a5-08dbd6045bcc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 09:17:21.3716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecgW5L6DCoAw4J0T/Uk23Im1zkHHp1BdphXmX7rvDYHbxC1ROefdajcBjq7HIGorNVhFLWctdnQoJAOBpipAmxlO+7OQo4ZSgOo9Wzen5hY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5396
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/23 10:38, Ivan Vecera wrote:
> The i40e driver does not handle its VF device types so there
> is no need to keep AdminQ register definitions for such
> device types. Remove them.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_register.h | 10 ----------
>   1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
> index d561687303ea..2e1eaca44343 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_register.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
> @@ -863,16 +863,6 @@
>   #define I40E_PFPM_WUFC 0x0006B400 /* Reset: POR */
>   #define I40E_PFPM_WUFC_MAG_SHIFT 1
>   #define I40E_PFPM_WUFC_MAG_MASK I40E_MASK(0x1, I40E_PFPM_WUFC_MAG_SHIFT)
> -#define I40E_VF_ARQBAH1 0x00006000 /* Reset: EMPR */
> -#define I40E_VF_ARQBAL1 0x00006C00 /* Reset: EMPR */
> -#define I40E_VF_ARQH1 0x00007400 /* Reset: EMPR */
> -#define I40E_VF_ARQLEN1 0x00008000 /* Reset: EMPR */
> -#define I40E_VF_ARQT1 0x00007000 /* Reset: EMPR */
> -#define I40E_VF_ATQBAH1 0x00007800 /* Reset: EMPR */
> -#define I40E_VF_ATQBAL1 0x00007C00 /* Reset: EMPR */
> -#define I40E_VF_ATQH1 0x00006400 /* Reset: EMPR */
> -#define I40E_VF_ATQLEN1 0x00006800 /* Reset: EMPR */
> -#define I40E_VF_ATQT1 0x00008400 /* Reset: EMPR */
>   #define I40E_VFQF_HLUT_MAX_INDEX 15
>   
>   

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
