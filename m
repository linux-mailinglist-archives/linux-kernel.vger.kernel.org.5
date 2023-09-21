Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EB97AA562
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjIUW5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjIUW47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:56:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9639FE47;
        Thu, 21 Sep 2023 15:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695337007; x=1726873007;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i0CFkLRhnW9qNEAuqg35tHbQFkgZvN+KctJJ1HZqHyk=;
  b=I+Ru+h/t6OEhv0ogYlc2tdk8LXiPuqYLNzYQ9E4e5+eKP2Q0mFn7T50m
   0meWcUoDTnYYu7j4RnQDxbNPPeZRYvmhlbPP/38qshMHxjq0W98ZxhYRS
   bOs1y1DOqOAAsUl+HnqgvMv/Kw9LlrF/6y3GxHJlbauavIWYm5rVemErt
   Z2u0i86KNG4Q0SBBVOXtZUhmDjiWf/RwGpyv3j51sMoR722fx2ix/VVhN
   /a7gkh6oIooOM6zzUgix9+avbCTBSp6gv/ZhzJa3n4enWPEWvSUhbVH2D
   ewRNJcCv9U1KZVJl8U8CGpdalWy1t06jW4eAJgaDoSAOCL7WMGarH3tmj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="383440577"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="383440577"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 15:56:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="920923313"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="920923313"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 15:56:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 15:56:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 15:56:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 15:56:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 15:56:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNmcXG/FZrHGG84qH9PWJzRNyL8yENXsqnPhcuSIe/4BVojp01b2dARM8fQFMrLGoADbD5GnQralgYlZbaoPnOBylAEZDeSvQitGlLmIvBHRjxE9FkEZAx4T6FToM+GGyi9XhU3pG6PtdScQ//klffwz2STEXXhG35Wr5smKzS8K/17rwb1cJ3gPL8Txx/2xqIPusKIFh0KWTgx+r5WicNBB18zqDZUCJI87e1H8whD9DfammlkuGS21jvsZGalf9V8gdYCTiGFCuNdrOc4JKIGK8hS4VsKEdX/mE6klUQ00YnQauoSR9xFdi4pbpPlldalBN4oQDKQORLOIJD9Zeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUfvKZj9z89H9cEIaaClgvxl4gcgp3zQzSMORD2XRek=;
 b=d8zYJzyq07LUq5DewH4ajMsuT86oq7OebTFL0z10d1pT7TQA0oMoLbDaMc8FoSz9U+NlWn/rgidh2YO+AjeTlDayWWkMWMBKC1G70qVEzBUtwFc0nTBFjO7ZgINym0oXBdG+DKAa5IOrVMxJ4e/sKDe3Kl5XNBCybezRmhU79JLgw/hE6GFL2Y0apcHZNyJwiDavhJzKC5amD/6y/m1fTFa7LdR3lNpT0fgJnw+eSfjNTdDjEOvWVVV+xnC4JGQcWQnoi06wwJvQbT4M/0ZqX170+wjef7M0W2pvENcur/iodcnbib5jA6YcP9u58WqEfW1BIywe1n5J5cJyZXv1pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CY8PR11MB6988.namprd11.prod.outlook.com (2603:10b6:930:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Thu, 21 Sep
 2023 22:56:37 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 22:56:37 +0000
Message-ID: <d4c305b9-00ea-e135-bce6-aa502012f922@intel.com>
Date:   Thu, 21 Sep 2023 15:56:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH 5/7] cxl: Fix block comment style
To:     Jeongtae Park <jtp.park@samsung.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        "Wonjae Lee" <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        "Jeongtae Park" <jeongtae.park@gmail.com>
References: <20230921025110.3717583-1-jtp.park@samsung.com>
 <CGME20230921024832epcas2p4ecfc828890e076024e402fd5ef7d8c70@epcas2p4.samsung.com>
 <20230921025110.3717583-6-jtp.park@samsung.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230921025110.3717583-6-jtp.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0058.namprd17.prod.outlook.com
 (2603:10b6:a03:167::35) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CY8PR11MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c77c326-5c2f-4b83-5693-08dbbaf60294
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: StWlu9x4As+8zvrAW8M4Bp+UZDmmbfcLCSVRi5B5X17mOBsJL+jKFQv5QkVu/MqhHnTkUP18GD6i+qoCyUGGKU314Ido5oQG907mXFGVD4D50aymbFOZFrjTXq9FAfViw77qy00r5jVHIliKckZAjH03F3dqMdE4RFesI9yAtsrhqDzIPBOXTkTKLmn3oh6lhlh1hCwRLkDwpg52nFXEtstH074yEAFHyGajNCt5HehhGUvRuqhJW0AJmfIHkZTwdqsZmTEmt5SC5mbvW+agIC4SM2arVD6P0B5vrj3tVG1YXVOvFkFvSPdXjAtwHFlh9LBaWWdMhFUkRB0a1A8KEGAF+9XfbM2kV8wTe5t+JgsGA4PAno6QluPV+C9V/QO7ssPWPY1+LEmEnrM/NuyAOg6ZMKVLVH+8Ec6VXFi0ofodHKhgUpmoH3UzCp7j9at8pxJrVC26L1LKtzF55uxi459+KL9o4Q8MTjflJJRiI27Qxo5hhRXCrti8Oyj/abfxHorEIRy/mF0jyhWR0hYPzYLnabdt6hiJyBEEugy1pG1E1AyFskYTLOliJWi1r+QmzWxJKab+yMJm+YruuQGL818ls087nsCwDXuJqKylVNoXk7es0/39v9cPYBgSRlhV4OwZtEbhwkQie8UH33wKNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(39860400002)(136003)(1800799009)(186009)(451199024)(26005)(8936002)(2616005)(82960400001)(8676002)(4326008)(7416002)(83380400001)(2906002)(31696002)(36756003)(4744005)(44832011)(86362001)(53546011)(6506007)(6486002)(6666004)(478600001)(5660300002)(316002)(54906003)(6512007)(41300700001)(66946007)(31686004)(110136005)(38100700002)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFVQd2E0dXRGN3lMRE9UWFBSU1JNRVlUdk9ZV1p3ZFdSc1Z2YmhhcG92OFRZ?=
 =?utf-8?B?eWUrdmpzcURNVGZ6K1hoQjZHY3ZQVEtDc3krMkJEQ1NIOGZYUUJUWFkrMXN2?=
 =?utf-8?B?aXBNTnlmVEM4cmNXNEdTRTV6a0d6Y1FaczE3SkNrbWtkU2JUZncxWGJpdjRy?=
 =?utf-8?B?bWw5ZFdxLzcrdi9UUGhhS3FHN1hlNVB6QmpHMXRMTHRWcTI5RGxlME9xVUZx?=
 =?utf-8?B?ZWRUanRkMy9lWGduWUF4WGo4K0E1dlUxT1M4QXBWZ0JMQlhkVTFGdER0TElh?=
 =?utf-8?B?UkRZV3NyOWN4bTU1M01rU3pxMW5GaHZOSVMwaUYrdzNseG82Rnp2M2ZQOGlC?=
 =?utf-8?B?ZnV1bkNMa3hQY2cveE5MUUxmQmhraFJKVmRyWDM3Unl5VEtpcDg5UzRGNEc1?=
 =?utf-8?B?QVVFOW9ON1ZROTI0d2NYTFJGWFhZWEJhaE9WaFhubk9BTXVadjdNM3JsRHJF?=
 =?utf-8?B?Vm11YmM3M1o5c1RQcnpUaWtyREV4ZVpnM3VsYktvZEpOS3V5RzQwOHVKYlRC?=
 =?utf-8?B?WXdlZURQSDl3MC9CcTVkcStZaTh0OHVZWm9pdUxESm14K0Y5YUhYMU1JS0ox?=
 =?utf-8?B?T244eWxteWh0K1J0dGhXUlFmYUdHd2JubDFoM2ZBTDlxenI4cWg1NHlubkps?=
 =?utf-8?B?ajBkNnU2cjl2dGFRTURYZVdsNGd0dk1MbVd3a2pHMmp1OGZGR1VxUzd3Vk1W?=
 =?utf-8?B?a1dPM1k0OGxWN1hGck1aUVJ2VW55c0dmKzNzR1Y3SkdJTHhUYi9LekZyUDVn?=
 =?utf-8?B?M1A1U0J4djdnbERMM0kzZnJkRi9YVEdKQUFHbmtyUjFJMXM1NEJSNEJNVlN6?=
 =?utf-8?B?azVMYUNBUkw2VVBxbThuRzByRmZRajZLdGJMMWJkSGRDUTRHbTVQcTJBZEow?=
 =?utf-8?B?SEhGZm9GcjhhUEhsaEdoMHM1MWRNeDJVTHZrazZwSFN0c09hWTUrVEp5QkxS?=
 =?utf-8?B?TlpjZStZWVhqcGVxV0JvSFJvWnpHWVJMdWZLTXcvbE9BMndyNmVTZVM0NGFN?=
 =?utf-8?B?eXBBejQwRTQ0QmUrVHZNdm1nRWhkUTRqNHBaTFpzaGxmYW5obTF1eDZMUkRB?=
 =?utf-8?B?UnFINE5xSWw0U2VBTmRoM2lFam1UdzFMN1YzRnVGMWFDL3A1a0RXS3I2TDNE?=
 =?utf-8?B?WjQwVlhVcE9kOGtxNTdoMzJWKytVbWt6WTVuSFN2TmVLWC8wMFQ3WUpyc0xy?=
 =?utf-8?B?NkFFWHlMSkJtUndiYUE3VytNV2pOb2xsQW4yRlN6SVQzWVgydmk2NjB5eFM0?=
 =?utf-8?B?d0pmb3NFRWpnOEN1RXlmZm9FZktMQ1h5cmtVMXhwUHNKZU95dnEwdGVLUHgx?=
 =?utf-8?B?ZSt0SDdFTkhXV21QTEgrYTZTZ3VsbXFyZW8vTDRzcU8xYUxJN1J6QXdWYmtG?=
 =?utf-8?B?VExwcDFPejNTUnRrUnVyYzdhL0hTSTlwNkRSNm9qTjU0VmhEaytDN1RRMDgr?=
 =?utf-8?B?aW1JWElKTkJkM3VsWHdEMnhZVWh5K1Q0SFNETzlnbGhuSG1wU2RsU3djYXRL?=
 =?utf-8?B?dVJCMUY1dW5NYzJhYnlvTjlYdUZhN3A4TTVUakJ0OXpQN0lRQ0RLcG1iVEo3?=
 =?utf-8?B?L1ZVV24ycXdMK09FUFhpUDZBL0NsM2dwS2tXUkJNRDRQVW5qWjBPUUJ2N0do?=
 =?utf-8?B?T0Z4Ylc0U3ZPVXBEaXJiRkRxMnBwOWo3cGVyblpGdSs3Z0VMY0w5UlRVdTVp?=
 =?utf-8?B?U0NlK3lpSEk5Sjlqb3FYVDhVVHpYTHFIMk9TVjJ4R092aE9DMFV0WGhXNm1C?=
 =?utf-8?B?eVk4Z3Y1QW5lZ0lmME1JWUU1K1ZFczFTMDFraGxYd2pLdVNDaHJQdDh0dVRG?=
 =?utf-8?B?TDhoSGM1MHJwWDBjSjFZaVljNENkNEFyZXVCRkM3clFMZkY2L1lRb3MyeENm?=
 =?utf-8?B?YUJSVVF3Yk9kYVJSWmxqYjBrREpCSVB0Vkx2dGN4WXVld2ZJMDdrN1krUkNo?=
 =?utf-8?B?OG5uckZDYWxsVkNWcUtTb1FUOUI0WndZLytEUDB5QzgybkRXVW1kT0RLSGlL?=
 =?utf-8?B?K2YrdHBPUFFQVE9Zc0x4bXQvY1pTSjRXY0h6NzYzNUtvSU0wekhlRmE1ZHZr?=
 =?utf-8?B?ck1nR3hCSlU2ZWU5NkNxSEUzQ1dpMXdyNk9hSHNaOExnY3I3MHhMMDJ3cksw?=
 =?utf-8?Q?HmQ7jX2PmO0mMRJWeLBUldFve?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c77c326-5c2f-4b83-5693-08dbbaf60294
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 22:56:37.2624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+WE/uvy/Gg7flU3y+gcCj9jIp0WvxqBVYEU7MWwVyiUX6Q0VeQ5McbKrKHwtlJwWgBdX58rrLBtcqNAzYJQPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6988
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/23 19:51, Jeongtae Park wrote:
> WARNING: Block comments should align the * on each line
> 
> Signed-off-by: Jeongtae Park <jtp.park@samsung.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/cxl.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 545381355efb..0bbe0c15bfa9 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -334,7 +334,7 @@ enum cxl_decoder_type {
>   * @flags: memory type capabilities and locking
>   * @commit: device/decoder-type specific callback to commit settings to hw
>   * @reset: device/decoder-type specific callback to reset hw settings
> -*/
> + */
>  struct cxl_decoder {
>  	struct device dev;
>  	int id;
