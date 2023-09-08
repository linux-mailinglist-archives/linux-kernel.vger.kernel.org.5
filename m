Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE39799195
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 23:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344173AbjIHVoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 17:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344166AbjIHVon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 17:44:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0F3DC;
        Fri,  8 Sep 2023 14:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694209479; x=1725745479;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AUGUL763/i16gGPDwvCnvQyFF7TB2VOpKrgJs6Wtfl4=;
  b=QpgMTtV+FaVv2qBKZDDbsDdBGbjiWpPeqLN/niZMvZJE6Zu0tQlv8/Au
   afLaE2gVnnqfcMW9/ce8PsfFXIWD0kUrqqSeHjJmd43lxXvrZxsWyOIgt
   88+lgjgab85NbNWGkRXsHplEmboVyhXQACvx9nVnHMbd1N8ofpcQWcD0o
   hWO9GgcJCyxVPoU9UH128Vb+YzplFAp3p7+mJjU1REVnvKP03RC/xVxhV
   gHm6q58N2OEnAao/bVJ41KUj9iv+sELwLgHluHYlP28/uTfda8wPgBMi9
   cPYWlBinMz5ggqbaO83L4yksStVBu7FrJk5uSnSVg7wgpyNnB2ovWvIEO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="464123651"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="464123651"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 14:44:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="812706857"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="812706857"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2023 14:44:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 14:44:32 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 14:44:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 8 Sep 2023 14:44:31 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 8 Sep 2023 14:44:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMrgNQrhteDW570b79kCjIPduAC/ReKK5lspppxrs061oJPubKPztdUhVAFvtViMAdePHGMtQ1+JWZBkeLnev//ZJjv2ieJZei9C2Z2sIJrkAcbPkDl1WuWWSYl9zoNDu2JZR6O4o/za/60o6pnJU6vCBUy1ECOKCmlQryQjBHNEnM2pNlqwQMPPuzBSnIhpshWylcikguhPaQBhp9BE/kxxa+1cqFujVETWVQTyrawpcmZHW5XUApGtf2TlTQzpw3KajM6+CWjahTcnv+uSB47asM1TSLmN6PmlSMnTLZdQw+HtSx66PupwL4/0qriAaT4PZap0lKjNNoxMd+PR/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbHQSgugrxg/cn4ZxYDkl8Vpdoc4nL9UWYmd7mOcbOc=;
 b=MhJ02oyPsjIikAc71mvQiTV8bla0Qb1MOatD6g6THF8OHdJeDSAxhfPs01n44Im8T1Rw22/GNAFx+piICTtHw2YBRveiQYd0Ubk0lfuBdrUHDG8O/C5Qoz6/E5/3K5qn42YBtN3ecqu7mz2mSLfTP8xBN7LH9cVjPeX1pJAfY4dD5qh0NLxzCDsrFbNkoxRk9sqmFPlFsjHSOjlQKf2mf3e/iO922k0jSGZaTT/WaLIR9PNQWPy8dNw7fAGx4dpfU+K01ezrvVFCWsizGx3cNZ9W3beOrrv4Yz8MZUH5G6vKOgG0Yv4BohPs4xfRq99rhjqvJJ6G+K3RCalh1TQlvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB8020.namprd11.prod.outlook.com (2603:10b6:8:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 21:44:29 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 21:44:29 +0000
Message-ID: <f60c01b3-a06e-7627-002b-09224000a784@intel.com>
Date:   Fri, 8 Sep 2023 14:44:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH AUTOSEL 5.15 01/15] devlink: remove reload failed checks
 in params get/set callbacks
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
CC:     Jiri Pirko <jiri@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <jiri@resnulli.us>,
        <michal.wilczynski@intel.com>, <shayd@nvidia.com>,
        <netdev@vger.kernel.org>
References: <20230908181920.3460520-1-sashal@kernel.org>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230908181920.3460520-1-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0294.namprd03.prod.outlook.com
 (2603:10b6:303:b5::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fcc90ee-9388-4919-c756-08dbb0b4c7ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Ka6SshT2e496OMDog+b3+NXyP1EVHrzTc7m7klVl8vmtbCTv0KDJJETdq/nsyaNTro3NdToupdtfPfj2K8osO2HGO345s6HKk7CSlhx0yZhRHjyq1wYtAOcgKJ1byjzNAN8G03y/+ab86eGrDdyHnGgfO/xI8UGlNd1jNd0PGRnpjnAE2+3cqjBmKLgqBKmUoCol/tZNNWvrX+Vg/L5WQMAzdBRE+jiiVbx/9nhBh2Wn1dPa3nAabWewqpMk8DbCqJctWY0atnC+NFnLIJ3i4A6PL8zlFkj99P8UgZfdN1LPKg5Ey1+q+Y18tA0i4NH4TyOMBs5DndKOM0XjzG+emZpoVMDN3ocZBU04hZizGnoCTw9i5RziJZgXUfbbLFaKxXV8eVlfsgYqWBGChZB22H9JUsk7YOhzJLWxgn2sFcEZh8VeYGeomd4KsNf0IEHiYR997UT+OpB0ZTVHTeFkXwRlujNezikAbqdSoyduu8NM0HFBY1+i88935f9penOjgHZ1gL03Bmbfhtyhp8ELPOOgiU337QE6x1XBViqFQ4QbIwfVYOdapgEzluUyeA8bfgTG+aIlEjJtOHIJE4NmpI66dqgHpgNXN8Me8I0647YLsv/03M97JlVEsRtAxfgmGYjkO2sSE4+ZIBj8x2i0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(136003)(396003)(186009)(1800799009)(451199024)(26005)(5660300002)(8936002)(2616005)(4326008)(8676002)(2906002)(83380400001)(7416002)(31696002)(86362001)(38100700002)(82960400001)(36756003)(53546011)(6506007)(66556008)(6486002)(66946007)(54906003)(66476007)(31686004)(41300700001)(478600001)(6512007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czY2bTE0b3JtWkRZSEVtSzM4cGo5VjkrUEdhcVF6WXY2QmVEcHVobWRBb1ZF?=
 =?utf-8?B?MUZtR1krR3gxWWJGQzBLcFM0cTd4dHJSekFmQ3lRVkFxMFBJTHQreWZhWWtG?=
 =?utf-8?B?a0IwOXhzVmV1ZURqRGhJdmZSUitaZUpEYkU5cVJSNGpKR1V0U1c4SlI5V1Q4?=
 =?utf-8?B?UW16SkZTQzdCY1JCM29ZemNSYmhrZnVZU1J6WDd4R0JLVWx4NVp2YUd3d0xU?=
 =?utf-8?B?Z2xUVWhhTWZiSE5uK0xzMXhsTGtyN04wbGVid2VrOVpxZjBOM1BJb2Vxb0Z0?=
 =?utf-8?B?VWNvSnZoVlVJQnVDS3ZyZUE5NVFvbGp2dTlXZWJwOVNKTnJFRnl5RTA4WVBs?=
 =?utf-8?B?U2RRU2NqSTlxZXJBTXdvRXJib3ZLSW5xYlozK0lyOGxzOEtxV1RxL20wL2NX?=
 =?utf-8?B?MWdmRHluSzZ6eFFPRmFIZVF6TU92LzZpd1NzRnBrTDNFMUxoVCtDM09UcTg2?=
 =?utf-8?B?azNwc2FhT1BabnQ3RG9PdE1Semd3Nmd0STBMektXVE9HZ1BRUVR3QUxLWHV3?=
 =?utf-8?B?aU1QdFJGWGdpNEd4WHg2aEliTmZxejlUUTdoR29yTFI4bGV6NFNKM1hMOVM1?=
 =?utf-8?B?bURPcUdPTXNOSUJZalZzTVFwZldrSCtQRGR6cUJUUzVBem9DZzJyTkM4bzQx?=
 =?utf-8?B?dkV5NDJlMS8xUzRHQW4raXhWR1FsSnhtaHd0aTRCU3Nmc3lzNnVvRHR1M2oy?=
 =?utf-8?B?WHZYUmxKc2dzRjQ1WGhtb2F1RzhkVjV0aGhQd2RlbjU1TkFmdHA4dDIxSHpm?=
 =?utf-8?B?OXZxSkNiL3FkN0ExOHlJLzh1Q05acTVLNG54WXRmdFI4UkpSRUU0SDZWbHRn?=
 =?utf-8?B?dW9KanpWa0JZV2pTUUpnVjdPSVVwcUg1eGNLVkswUWI1L2pvUmwvcXU3ZW85?=
 =?utf-8?B?TFBvcnRqeDhlVmV2MnZBNlVHK0RRaWxoMG1VNDZzTzdrWWNZRFFkdE1wb2VV?=
 =?utf-8?B?NUovNGUycEJoSnY4Z2VCZW8zUU00Skgzb3BiTDFLZ1RNQXhiMVlnRVZWemht?=
 =?utf-8?B?Z1dNaFdJRmpDMWVuY1NVZ0hIMG54ZVV3ZFZRc24wcmxHQ2ErdWFpVWpFMGJV?=
 =?utf-8?B?SUx6VVp6MDRGTXBQSi9sZThsbmZqNkJyZ0lWWUpzN2xNSU16YU1oV0ZJTmxl?=
 =?utf-8?B?ckRkT1ZhRGpHR04xTmF5K2VXS2Q2czlkaGE4VEhxMjFoMWFXMk1sVnZ4dW53?=
 =?utf-8?B?M1ZIeDB5OHAyK1dCeW4vSlNleklpcm4zbk1tOE5WWmJHUTdFQlFNa29XaW1s?=
 =?utf-8?B?Y05kaG1ZUFBMRXBYUnFudkVidDBTS3NhWGRSZzZhb3ozRXpOWldPUy9IL0s5?=
 =?utf-8?B?aUdKcUNib3lGSjN1amNuRlZRbnY3NWsxdmp4UmFjVytCQ0xoTk5rTVVXSCto?=
 =?utf-8?B?YTFZSFBnV0MzbzUyNXQ5MHBPNkVhZHdoTFYvMjNyRWJyMWZCMG1RWWFibFRs?=
 =?utf-8?B?UlZnTURtcE12M29aNkI2Y1lETS92d3pKNjNBYXp6YlZtZ2kxMTB0SkNqVmVs?=
 =?utf-8?B?L2ltdVJDUzc0djFKWkE2OUsydkZCTnQ1ZlhKZy9nb2V5RUVqZEFkYXdiSjRp?=
 =?utf-8?B?TGx1d0tSNk1yczJ6KzQ4dU5TQWFKSXZpZkJ6c2IxUWJQWTlBSkgxbmJxS0dW?=
 =?utf-8?B?M0M1U21rck5ELzhmZEg4NktCS0o4ZHkxQ3M2cUlSdUdaeDRaZU1xL21xS1hO?=
 =?utf-8?B?TEVnNXpzWWZRV0FjSkJFZlU1cSswZDdsK0xBL3NCRldrbE4reTd3RVhpQXMv?=
 =?utf-8?B?cTlxT01zQ2NqRVdGeUVIR0NqQlM3UTZmbjl3RFNLdWltaHJ3cW91dTBuRG9C?=
 =?utf-8?B?Y01VdGE1ZmdGYmE0VHlYYmNIY281blhZbEJOa04zSHlRR2ZsWXpqbVZ2RlZy?=
 =?utf-8?B?QzNCUnVjclpxY0RiTXRJVlVMQmRXVk5OWmJIMTRiSTluVGcxdi9EWXIwandK?=
 =?utf-8?B?ZlU2M0VwVmtqR01BVVgvdTcvNE9nVHloWFdieXpUemtXNEk0S0h1TGFUS1Vl?=
 =?utf-8?B?NldzOVZtUVQzZjYvV0tOdk9QMThlMUtXcFRSUUdoeWZpUEZaSWJCR3pRTEpr?=
 =?utf-8?B?aWN2SlF1WXBlMUZ4ajJqSWdPVEJqc3RVb1NjZUdPYW9qSkVRZUZVdzY4R1JT?=
 =?utf-8?B?LzVOS3V5SzZTSVE1VTIrQVlNcHNTaXAwcG95YnZGS2h5VzIwZjI3N25QYVNS?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcc90ee-9388-4919-c756-08dbb0b4c7ce
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 21:44:29.6772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWjBeuqUg2Awuo+VGk2x2/hR+bLi84LLbetkcQgn6mVL7xysmdU7q8fe62C6QXoQfLzkcep7c2pYN2PfjKQIxvQVDWGdilJaMCWfKOBoojQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8020
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/2023 11:19 AM, Sasha Levin wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> [ Upstream commit 633d76ad01ad0321a1ace3e5cc4fed06753d7ac4 ]
> 
> The checks in question were introduced by:
> commit 6b4db2e528f6 ("devlink: Fix use-after-free after a failed reload").
> That fixed an issue of reload with mlxsw driver.
> 
> Back then, that was a valid fix, because there was a limitation
> in place that prevented drivers from registering/unregistering params
> when devlink instance was registered.
> 
> It was possible to do the fix differently by changing drivers to
> register/unregister params in appropriate places making sure the ops
> operate only on memory which is allocated and initialized. But that,
> as a dependency, would require to remove the limitation mentioned above.
> 
> Eventually, this limitation was lifted by:
> commit 1d18bb1a4ddd ("devlink: allow registering parameters after the instance")
> 
> Also, the alternative fix (which also fixed another issue) was done by:
> commit 74cbc3c03c82 ("mlxsw: spectrum_acl_tcam: Move devlink param to TCAM code").
> 
> Therefore, the checks are no longer relevant. Each driver should make
> sure to have the params registered only when the memory the ops
> are working with is allocated and initialized.
> 
> So remove the checks.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

I believe my comments on the v5.4 backport apply here as well.

Thanks,
Jake
