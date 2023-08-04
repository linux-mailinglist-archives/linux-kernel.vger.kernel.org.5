Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79FB770730
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjHDRdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjHDRdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:33:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE5549F9;
        Fri,  4 Aug 2023 10:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691170424; x=1722706424;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AYNTeSZqv5tXaMgIe3bSMoMzm0V9uvygcWDBCjrSY/M=;
  b=e0dpbhC9YSCeOlg/X41Zr5JCKFLwLEVaJBHU+RTjkmy+YChV1mAmqTVC
   48Iq3PiBnYGpA9g56LB9reammPxe9mkAd6yzzSrJ6B3pmAl11JFxB2vWQ
   osfUkgOp4AJ5htmajDL4z/khWE76ib55g4vmoCiNmGWZVuSDivF6qhFrA
   VEPPu4BfAlxfjbiYDPTK4D+1reiG8a+oObHkbxtyevXhpWOLVQAMkiahK
   vtxVwJd6umCpBbkZa57fT/xPgqUgDMu2+DcCKRwMnwVxdsQpehSMQnILH
   5mIq/xXlZuABwDwHxqLh48o3YFBzR6Ii2aN8gXRUvkzSZ7b4Mt+pTXIi4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="456584439"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="456584439"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 10:33:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="853832213"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="853832213"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 04 Aug 2023 10:33:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 10:33:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 10:33:42 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 10:33:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0fgbHXsewAn3Fjk3nuUmaSG9CcLePAdB0bJeu8V0TQpsDBFPBJmyMa+7eNX+js2gFukpoGsrUKIOpuKzAvZN3l3n/ZQMa0cdLHmevDi9yUpoa9YGUeKnZarqJhnCsyMXWA0nyQ2rr/8iBkXDVligPsiGtpmmtvBJUpKNBu1BYg2c2my67U/wP2F6xqBN/feH0+IkNrrrx4dMF49bHrq46VcVPaLDC8of9GoC5CNxVhEdsuvqsXRZMQynOPFqsjWC1Gdy2s08PjLeZf4oNlgmok/lsNaGTMHpzISaxAMo0UKZNMyTXHwlFgszrthkrpxeTzfojSomfYFALAm2eXu6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qo4rxFWfNuChuecnP/JH3O8Elib7cJ6PhUAkfLiurng=;
 b=TEgQ+JJKgKo/uLyrN4/WR5HC8L9JQ4C6JwOVMRuNXSfCKeEMVaH+3ZnaA+yYJ4l3ZnYB9Mc88QpEYoyqMXKehOjtGTHsDTPWt1/4ySRm9x7uyJyvn/L8wmGvuIStLVu4WSPIlYpLVer6m9eywEQ6VF410FYkeAJTJhZ+hrjfGvp2YAB5S5QVXWpTlXxz/8Ky8u1BFyIwkb/FpG/Z95j694zOrNY3RqmmAr/MYOT/ce5qRGeLPfYA9WsciSfk2miM5532QoRsGwbRCq4LG5Ih5BK3vS5H8enSdX/mgCg+YlWhCT9vVQzbX0QDdXgb+K7eUAF1CJkVwTgZvaeFfv5hRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH7PR11MB7572.namprd11.prod.outlook.com (2603:10b6:510:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 17:33:40 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 17:33:40 +0000
Message-ID: <d89e76ab-4db8-9307-6c31-628df3b4fd94@intel.com>
Date:   Fri, 4 Aug 2023 19:33:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next 1/3] virtchnl: fix fake 1-elem arrays in structs
 allocated as `nents + 1` - 1
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        <netdev@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20230728155207.10042-1-aleksander.lobakin@intel.com>
 <20230728155207.10042-2-aleksander.lobakin@intel.com>
 <202308040126.ADDA993@keescook>
 <49b0d7bd-2bc1-c994-7780-35554a399242@intel.com>
 <202308041029.74FF3CCD@keescook>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <202308041029.74FF3CCD@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0272.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:84::16) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH7PR11MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c257630-30f3-43cd-6f7d-08db9510f11e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uNMcJpTdJkmUgwc7pzNftOlgHY847xv35jOlgiU7VOS3tuFixdAOZ6OU4o0E8o8DONisVm3FATfWymNbCXocSJL1EVfooyDWHllGADAKLju1ZKNUtG9hgZtCvusAl0xw+2hLaIClWvp9eN3ul/QYgGJ9EiU12hfOt4JHUEK2DmeryXuEUT2sFnsINInAsF5j+T01E5GnbOQZ97jfisxM3iKCQ4rPNPu2BrrG3/lvr5gQ5ZenGgvKBYxWP3bBA6bdXN+gxUFsYMuHUFxdkhBkcbYC0oxSWqmmgsc8jfmheURBYR+I1fVcYvFeWHDIoIVMUCyXKB8Tlj5omSvzMsonKNEriMpZ+H0lnKPVW3XeUW8B9zHPbs28AA+M3LQhEksusuWDOizN4X2t71YxdamUUNc1o9amd0rCaLYGPWFk316TUFBo0ggjocCyzN8tmqAjwRF2Q+d5lBwgyTyKDvBA8d9eJx6Pg9E2SeZREjzChg8blVzambMNW0DdM9sKgPdlBoPcNEtSJsS/9QXo8UV8h3m/+No2PbbIV75n9d+gtyrvBJyCPn28UBpvANlCfgr8k5Y5ANUB/SJMmlV+kUhtidPGEMvVp5yELn/qixqV+fvBrtFbyLFPrRsPeeqluj/z3Fjh1lGx0Syx5aDn1c1gBBuJoQv7BqKzZgx6xZxAul4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199021)(186006)(1800799003)(6666004)(6486002)(6512007)(966005)(86362001)(31696002)(6506007)(26005)(36756003)(2616005)(83380400001)(38100700002)(82960400001)(5660300002)(41300700001)(8936002)(8676002)(31686004)(4326008)(6916009)(2906002)(66556008)(66476007)(66946007)(316002)(7416002)(478600001)(54906003)(81973001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkxueEVBZnhZR3A1WWZWMlA2ZkEzajJZdHZSME1vcnZvWGFLb2pRYXJ4S29m?=
 =?utf-8?B?SzRiSzgrOFhSb1pCb1ZjVE15V0U1bFhOaDZtZ2wwQXE1RUdaR1BlaXNQZlVO?=
 =?utf-8?B?WWYvaDM1U3pER3dkTHVjTzlYT1QxOEJ1b0JYUzBxbVRxS0RvRVBhNnpTTjFG?=
 =?utf-8?B?OE1DTWpTRjgxNkkzUG5vem5zazNIY0lVM3IvYXVpTTVDKzhGWE1TZ2czQS9j?=
 =?utf-8?B?SzJZWDdLMDI5MTFadGwrMHkvVG03bXVFYUgrTkxBODdnWXR5dkRvUStDVHAw?=
 =?utf-8?B?VVdrNXZ2ejhuUHllVTVTdVBvUnhlVm5JRUpmNUhQUlhXaUhrRXBDL0R4dUt2?=
 =?utf-8?B?amVacjhkYUF4OFo0dk1vK095eU1vTGpTK0o0OHk4c2xxS3QwWnBINFZSbWJl?=
 =?utf-8?B?N1NyNnora1VnSnM3WTFXdHc1aXlsUXpVWGhnSjNBYnMvUzhIcWpXV3c0dC9h?=
 =?utf-8?B?RlBMSzIyVThVWThxSndicmhDTk1yc2xPZ1lKYlp6YklSZjJlRkRZdzg0bkdt?=
 =?utf-8?B?OVVKY3hWWkd1REtHRTRWTmRvbi8wQWJ0T2paeks1dGFDMGVZb3ZoREYrSXFx?=
 =?utf-8?B?TlQ1OXQySW5sUVZ4Z2llcE1KUThsYW0wN2Z6Njc2UGI3TnV5SFpoRG5na1Z0?=
 =?utf-8?B?Vkw3TTZtRXpBTFFUWTFWZEpRQzR5RW9MMDVOdGw3MVkxWmxuNndpN0Z0WXAx?=
 =?utf-8?B?UEhMODdGYndQeTJ4eWhhVU0zdDJ0bCtQZXorTW42LzdlbUI2TDYzOWZyN1FS?=
 =?utf-8?B?U1JVUzFFTlo5Q2J1RHdjSGo5QmtjSmQ4NDVhZTJ5K1NJL3liYVZMdUZ4eWg4?=
 =?utf-8?B?TDFKQXFvWW1nRTl4b1J2SzJtandRWmVRR0lCeWtlN2p1MzhxNTZlYkFCUjZW?=
 =?utf-8?B?dmI4K2hqekdWUllHaVA1bStlMm42dEdIdlZIWWN5RzNaQUZHalFYU3MxZjNm?=
 =?utf-8?B?TVpUS2xLdzd5UW5CSWlBS3IxT09yUmlNTGJwL0VPVWJKd2duakQ5UFlLSis2?=
 =?utf-8?B?aXM2ZUFybnJUOWNPVUpCYU9uamxqMVc4UHRmeCtTOXY0S0JDY2VVVzBDMnlZ?=
 =?utf-8?B?aEJ2Y1RXYllkK2RPcVZCQUlTaVRMRDg1TDFvWGlpVWxxcFBPWitnd1dLMUVC?=
 =?utf-8?B?NVloQzZzdEJlTVp0MWxtR2t6b0dWOEJWS3dQcFBMVWh2eDlFSUNudG1YMHJW?=
 =?utf-8?B?aFJ3T3JJcGs1V0EwUUs1R0FWTFRHaytRZ0Ridm1ZSDNkUGREcnlLNVhGTUdP?=
 =?utf-8?B?TURtaHhqR2dvOEozdlVXckRuY2FoYU5hNkNYeGR1SHlGRFhhYjdlOFVoeXpC?=
 =?utf-8?B?c0tCam1xQXI5M1hDdWU2VUswYlBDU0xKR0hUbldKWTB4MUFLODdwNW9CN09P?=
 =?utf-8?B?SFpjVmw4RDJadzVLMDAvbWt4ek93YVpqbjBvRmlxMCtjZEpCS1d4aUhYcDNp?=
 =?utf-8?B?ZUNlMityTEtXQjA5OFZ2VjY5WWJ2V1BBYzZDUS9KamFNTDZKUnU4Vm1XanV2?=
 =?utf-8?B?dnhXSXRNTlBIOVV1am5hSXBVRk10S3RNWGN1WGdNdzBma04xSHZWanlIeXpU?=
 =?utf-8?B?MURldkFCdTFnc3NWRUtWcEpRWGxoT0gwQjdkcitBSXhxVk1saFZXT1JTYkh4?=
 =?utf-8?B?akUxRHFHMVdQbzhiMzMreDVBQzJURVdUamhJcUZ4WTg4S3hiZC9zQm5QZkpi?=
 =?utf-8?B?TVNjVUc2cmhxZ3c5VmRiTFZzVm5wLzJnaXJHWGpvZlZ0R2NWcDFWYWl6d3po?=
 =?utf-8?B?NiswaGFhV0NEaVNra1psQXErb1o3Z0xmVHR5VTdRRnNoVEU1T2tWM3F1OFZX?=
 =?utf-8?B?OW5na0hoVzYxWDRxajlMVUdmcDBFOEYrekxJMTYwZTJYcFdCcXgwRWUwWW41?=
 =?utf-8?B?cTdRQ3RPYWk0VFkwNzNvbzRBbCtXK1EzUnVWT3AvcC80V3ZYbnVzRzgzVGdz?=
 =?utf-8?B?UXFNL2tEOFM0aHM2bEhZTW1uZWtKdUFCTHJxSzZKYitHQ2phSmRLZGxMUDZX?=
 =?utf-8?B?L01hYmFTeWhLREpQTVlpeUVmak9uSTVjemNnUEpUVTd5SVkxMVhSejN1NTdN?=
 =?utf-8?B?ZS9CbXQ4UUVXNU0rUHdndEh3VzNmaTVjcjdQRkYyY2lmMnNSSXByUEZ2eFZ3?=
 =?utf-8?B?aTExR09Qa1Y5eGNiT3dpZVB5VWNVdThpdlV2UjdWTkJNT2Zld0V1cDh1Qzh6?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c257630-30f3-43cd-6f7d-08db9510f11e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 17:33:40.3424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8PG9S+bGXzaWTcg7mjGS+1K3qtr+O0jP/W3ppkd6PDwXMld+W/zkTC3pOs4/iUtSqDp7LmDWpwWWR8R4zZRrTuTWEk9HmctlHhscG4SLGp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7572
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Fri, 4 Aug 2023 10:29:48 -0700

> On Fri, Aug 04, 2023 at 05:42:19PM +0200, Alexander Lobakin wrote:
>> From: Kees Cook <keescook@chromium.org>
>> Date: Fri, 4 Aug 2023 01:27:02 -0700
>>
>>> On Fri, Jul 28, 2023 at 05:52:05PM +0200, Alexander Lobakin wrote:
>>>> The two most problematic virtchnl structures are virtchnl_rss_key and
>>>> virtchnl_rss_lut. Their "flex" arrays have the type of u8, thus, when
>>>> allocating / checking, the actual size is calculated as `sizeof +
>>>> nents - 1 byte`. But their sizeof() is not 1 byte larger than the size
>>>> of such structure with proper flex array, it's two bytes larger due to
>>>> the padding. That said, their size is always 1 byte larger unless
>>>> there are no tail elements -- then it's +2 bytes.
>>>> Add virtchnl_struct_size() macro which will handle this case (and later
>>>> other cases as well). Make its calling conv the same as we call
>>>> struct_size() to allow it to be drop-in, even though it's unlikely to
>>>> become possible to switch to generic API. The macro will calculate a
>>>> proper size of a structure with a flex array at the end, so that it
>>>> becomes transparent for the compilers, but add the difference from the
>>>> old values, so that the real size of sorta-ABI-messages doesn't change.
>>>> Use it on the allocation side in IAVF and the receiving side (defined
>>>> as static inline in virtchnl.h) for the mentioned two structures.
>>>>
>>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>>
>>> This is a novel approach to solving the ABI issues for a 1-elem
>>> conversion, but I have been convinced it's a workable approach here. :)
>>> Thanks for doing this conversion!
>>>
>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>>
>>
>> Thanks a lot!
>> You gave Reviewed-by for patches #1 and #3, does it mean the whole
>> series or something is wrong with the patch #2? :D
> 
> Hm, maybe delivery was delayed? I see it on lore:
> https://lore.kernel.org/all/202308040128.667940394B@keescook/
> 

Nevermind, my mail rules did put it in the folder other than the one
where the main thread was, sorry :s
Much thanks, I'm now a fan of _Generic() too :D

Olek
