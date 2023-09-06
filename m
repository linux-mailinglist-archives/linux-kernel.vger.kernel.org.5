Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24651793F22
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbjIFOmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjIFOmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:42:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591BF19AD;
        Wed,  6 Sep 2023 07:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694011328; x=1725547328;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/+Z5J+MwQ6AJdSxNNLQGzZ96cNrtrtXThB1YcVrJn4U=;
  b=MMiG5VKiU70Holwr70qWJGTMveVe7vW2C8N88hfrESimfHNgWMzrksi6
   qsU1c1qpn6RNLUjV1D1tZj9XaOY21K4x1sokOtve9dj7gxmAJ0n5x+XpW
   IrSb6lX55ZExRvSeuKB2WAj52LBLu8reyibRxXBmb73CBXwrR53EXNlfw
   Ve0jSFl8zbuDuLhlCjfrwoXviyirbvzJWbmC/fXd4N+Eo7cBqmVjdN0mC
   VFip4DOCqvcqs+iGd4F3mrkSz84CY8LpBOlTi1xm8MzkNxmGXjK2SMlyr
   5sJZamd5l5BUCSJmzyeges08VfgIbkKYHmd6+1GeGfWus+81cSaKlX6vU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="362113822"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="362113822"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:42:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="741572286"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="741572286"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 07:42:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 07:42:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 6 Sep 2023 07:42:06 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 07:42:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9tj8N9n3ufJJvSZsp7uh/tDwDzWMGX2GfcxUARH4FN0G4kgHj+9oD+VZbZlEE4FBoMjmiw4DpkAto12blu+DVEKfLciUVEhkT7067LP8XVwtuzDPi0chrSzFavhshh8/fg6DkO8u76vf8gjIkV3voywxul5vCtOndt+Ct65aefqnbZoLpsC7NU/BbgLhfsfc0HItbKqpOemXaiUO8iHPhAlx+9htXRjtfGNxBj9AN2rKnLAXw8807KB7d45/wPGBoeHy4sRNmZNhxHaPfjWXg9d7lTgaas4YyAgu++gk18gu5D9ZyIOB5NGnDtFXtmcRZqkPfjnhUl9XpQC30VOiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DolNQugdR4SokeotFovzsFqLWDYfLOb/qAYvgU1ggk=;
 b=nZ+zpXMkK6JbsL2gF4t0rtAJElhU1ZgPVhVbg55ehK72M5D9TFmVxiRvX5WM4PpQ501+lgF5Esfe2tXXMebutGmw7hbPAxYHe9qtVJkJY1bqmOcnschEbIKtIMc2Y/TxBH1fgvXPdr0I5XE6mKQekYN8iVM9JYVrqpHnXP3msp1x5RtsQpzhqX5PmuupviRkvzkY916+JJzx/D61fUeBmLoQ/nQ3Z3lu1LcsOKC7oAgElIHTXAopYm/HjwhTgiOVkkgeMiMTvRR9rfbqhzIoXvcOAF2crLo151m3KSNfuCQ2qfQmI13Eg/7lF1omWjdBXXuqRkMYaOVxUDiWh2sOkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by IA1PR11MB7754.namprd11.prod.outlook.com (2603:10b6:208:421::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 14:41:59 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6745.028; Wed, 6 Sep 2023
 14:41:59 +0000
Message-ID: <05febba8-49a5-5f9d-34b0-d85d976e1416@intel.com>
Date:   Wed, 6 Sep 2023 16:40:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/1] bitops: Share BYTES_TO_BITS() for everyone
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Yury Norov <yury.norov@gmail.com>, Uros Bizjak <ubizjak@gmail.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>
References: <20230824123728.2761663-1-andriy.shevchenko@linux.intel.com>
 <a5574786-0a49-454d-67e3-571983e6a6e8@intel.com>
 <ZPCT2vV0r8l/wxim@smile.fi.intel.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ZPCT2vV0r8l/wxim@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::16) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|IA1PR11MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: 785b2580-066a-4109-7ca9-08dbaee76d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xM3BKDKqIc+ijCLN1N79UNa/DR95t+Nb+Dvfk1czyi2yPHJJAtPmlJh6GdhPlvIkiJbJJwgkxoyZDaOncFO1gBn1rl46rI6LG+w7j0O5mG26T+w03xEniVTYdkLXZMZ4CGHKjDY7iBXGU+GJNfZ7YmzkvKArvjsP+5iE68qVHa/bt+yffxcSLssyPaNceKpqILtBPJKs+TKpuXLr5xr1k1Xyx31alpjKxwN3qamBZ1nyDd/Y1LeJSbaI+DdKvf1an8sFx59SdQIDGc/tJ5eqFoIOuYmnGjfl7NGQ0K/8Rql7HS0OVHgtXRrw8LRb73AppsYX8C+ZNbTSTVVYpF3SlTAITgFTetfcpy4PkstzV9xJTUo6LQlHsNdUVDkrELWpaIJYi5cEHOL6zDea7mZqrskZtnVftfofWjB79GxbeHET9nvBV96GV6RdPjXNgQ2Qtjq5FVlZvb3DFTocsgM8PRGeTJKAZdqxYNBpw90pAGBnAC7In28r8aJ0CDxEsOBLcTRHGJ6EDln04QmBy26DVe4122zt0CAu6bnKdENiNG9YcgObU8A9XJ/LYwN9NveMlPo0U+oXpEAbJAXpdAyoX/fBS0KvkrPD7vUwpQD+t7vKOnPhTJ5QD2kp9oapwRfBcEsZAqvShh8jm1w87IaQLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199024)(1800799009)(186009)(5660300002)(316002)(36756003)(54906003)(6916009)(66556008)(2906002)(66476007)(66946007)(8676002)(8936002)(4326008)(31686004)(6512007)(41300700001)(6486002)(6506007)(38100700002)(82960400001)(6666004)(26005)(478600001)(966005)(86362001)(2616005)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2lLbmsyNDhhbHl5cHAyMEE5K04zM1pld1NFa0YxM0s5MWdNd3FWdmdMTWZq?=
 =?utf-8?B?SUwydXpNZVhGRk1aU1d0clRIZUZOdjRPdEFCMkxDNElOd1cwUFdmbysxS3RJ?=
 =?utf-8?B?SGYvSVBDdGJCbndvZE0vaWhXZTQzQ2lTL2xxaSt4NzBQN09PY2tOTlh2cUh0?=
 =?utf-8?B?eU9BdUNzMFNOY0UzQ0RkU2hML0J2OGoydGhaSWRSTjcvVmc5R0dyak5YbjNL?=
 =?utf-8?B?RDEzcmN6U2p5RUJaM3haWDdIRFJRdEg0Slk2TjJnMy9lM0ZJUmtYSDlwNEkw?=
 =?utf-8?B?STdSNkFsc1dHUzVsRUlsb21sSjhKYllGRlZWUzM4L01KMUlRVTVXRmZrNFFl?=
 =?utf-8?B?N2hpTm9NQUU3ZnU1dis1VG9sRVRNT1BJODYvVjYxdGpIRURuUjZETERKZExs?=
 =?utf-8?B?Qmd5WTBJVXVZZ3VPTm1FelNpcGgxNjNSVEJ6QWtyZXZ5Yjlsc3JNTTZaQ1Ax?=
 =?utf-8?B?SDNWMURlWjRCd2pDWmdOL3M4c1dkSTY3SGYxRXVOU1R3Qk1qWkJnTmZVb1hG?=
 =?utf-8?B?WFFQRWs5YXQ5Q1gxeWhrOFl5Y3hYK3RGRGxmaDVtUVNnZTFsWFV4MUlZWFl4?=
 =?utf-8?B?M1B0dDg5YkpzdUoxQW9VckFSRVB0RjlscFplZ3NoakFqd3pPVWhwQ3A2WDl2?=
 =?utf-8?B?TW5GSHJTZUdxNXBLelgrMW1QRHNPRkpBd2d4UmxPYjFYcXh1VmFwdUFrVzVG?=
 =?utf-8?B?dmkrbGZYdHlRMVlOV1NRSmhjWVFkOEN3YUhtbWtvSXJqeFowYndNdnVOVEg1?=
 =?utf-8?B?V2JncjdkZmIwNFBKWXdobUh4ZVlSWGFuYkNnL2xuSWpxTFg0TDVQUnVRUm5a?=
 =?utf-8?B?dlVHUks4bVp2blZVZUVMdmxRTXRzUDM4NUtsTi93NkcycEVoTFdQUDJZUmIz?=
 =?utf-8?B?aU5lZGZpSzhiVlNyNzFlb3g5K0pZM1N2cUZVT29kUnVNK3ZITnQ1TkcrTldX?=
 =?utf-8?B?SDBMbHg2a2pZbFVJQ05LdVBhYWRUM201S1NkT2FXSEdYUSsyQUI2WEpDOVR2?=
 =?utf-8?B?TFlQdk9yaDZBQWVjTDNOK0ppb1pHZzF2alBHaUk5a0EyRi90djhkTWtiSTY3?=
 =?utf-8?B?U28yd1llYkVmbDlWWXY0d0lxSnVIQitKVUZhTGU3Wlh0Y056Y1NQTUM0dmlR?=
 =?utf-8?B?TWU0VnhtODc0R29mMExmOVo1ekZ4cmR1Mm9qdjJFV3hPaDhJZTdUMExTdGx0?=
 =?utf-8?B?RG1NYmV3MldwdU9ubGhTWklxb1IxL3lzNUlsZThLYjV1UER1UHBsNXZ3QVFN?=
 =?utf-8?B?OTgraHU5TkJRQ2ltZ0FQQjYyZElYWEQrck5iMjV4U3Vmd0VGcE9rdFRxbFJD?=
 =?utf-8?B?b0FWd2dNc0swRktDYTB0Vkt3ZjRFeEdDYkV2WUdET0huek5WZml1T3djYWxZ?=
 =?utf-8?B?NFJKdldBRFdYS2tpUVJFMk8yYTBjV1RJMkNvTDBlcVV2a1djdm54WXZVZU9J?=
 =?utf-8?B?Z3dsb21jK0tkRThGaURUZU55R0RhSEpTR243Wkl5dTBWbk5DSkdaUStLOHhZ?=
 =?utf-8?B?alZkaSszdXY2K0RxZmZ4WHd0dDFOemNqem1rTFVOUllEOXZwVHEvWDRxaEpm?=
 =?utf-8?B?M2pabVJta2drNEQvUXo4UVZWdnFQSmpPS01PM2VMeS9sU1U4UElpRkswdFdE?=
 =?utf-8?B?YlJmd1h5Y2hLcGttRDc1SndHaEg5WjNZc09vdXh0eno1dEVlbGYyMHR3ODNC?=
 =?utf-8?B?RCtmem52TGFUdlBGbi9xamMyRjc0YXJmd0lTcTRJNVhXajhVSG5CRW1RNlJh?=
 =?utf-8?B?c29JRk52STRoRUZRcjZlaEhPTHh4dzdxbXgzT2J1OGU0dVVmWGkrRjRlaEsv?=
 =?utf-8?B?djJMdDN3b0JPcVhTak50RjJEQmlSR0xBZ0YyZnpuZ1lGMkZya2pCZXlaenNt?=
 =?utf-8?B?aUZvQzRNTXNEL2p2N0RBbU1YakRDQm1tTzJSUkJNUy9kaFl6WXc1WHBSS054?=
 =?utf-8?B?UTVhd3pUL3lpc2lJMWhydTQ3OGE4Zjh2Qm1FMmZwb0FaYmtjYzRObG5STExL?=
 =?utf-8?B?Vk9zdnY2b0RYSGhaNnV4eXBqQ0lBTy9kY2psYjhqZ1oySnJtaEVXbEcyOWVi?=
 =?utf-8?B?WWtlbzRaWTlXeExMWmVydFFWUG0ycHNOeTI0S2ZQZlFsTXB5MjY3cnA2SzFC?=
 =?utf-8?B?eVNhNGlXd1VwVjAvS29QL3Jxd3Q3RFUzOXVvRXpmTVg4R1NBamxBRDRmMjFx?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 785b2580-066a-4109-7ca9-08dbaee76d33
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 14:41:59.8784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHSg+PtQhsn0Nv6bC4zhzEGX7mF/yhCElbAT1fl2vIR3QkZ9Hk2JpXkIPvjI7GkaMEj+Ve8Yzdje7XyIgKRdnu9PQlSdJq80lX8UHonsjd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7754
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 31 Aug 2023 16:21:30 +0300

> On Fri, Aug 25, 2023 at 04:49:07PM +0200, Alexander Lobakin wrote:
>> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Date: Thu, 24 Aug 2023 15:37:28 +0300
>>
>>> It may be new callers for the same macro, share it.
>>>
>>> Note, it's unknown why it's represented in the current form instead of
>>> simple multiplication and commit 1ff511e35ed8 ("tracing/kprobes: Add
>>> bitfield type") doesn't explain that neither. Let leave it as is and
>>> we may improve it in the future.
>>
>> Maybe symmetrical change in tools/ like I did[0] an aeon ago?
> 
> Hmm... Why can't you simply upstream your version? It seems better than mine.

It was a part of the Netlink bigint API which is a bit on hold for now
(I needed this macro available treewide).
But I can send it as standalone if you're fine with that.

> 
>> [0]
>> https://github.com/alobakin/linux/commit/fd308001fe6d38837fe820427209a6a99e4850a8
> 

Thanks,
Olek
