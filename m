Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24997E46C8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343616AbjKGRYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbjKGRYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:24:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC22CDF;
        Tue,  7 Nov 2023 09:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699377854; x=1730913854;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uUk8rqUH4aD9I44Kegkd3dW+HgyDghKN2aBKObM4/W4=;
  b=naMsk9RG0esgK7KXyM6bawY6vI7TWPR1Vfl+L2m3Oby2V1esK4solLGX
   +nvCfvHI5GdBFUOSSy8dMOdiTXbZIyHoZgF6BK0JFzGqB5Xf2fbvwQAl3
   vxgDKVwh+VOa3ms2Ht6OqjsDNcT+zqqJYWCCaVJeIZ3ketg3Tgqd0lA+z
   mElYrZ1OD9oO1W+UD5fR5hHKn7uZWKV3CraOPmC/6tPGsyfy+gYLcgr7L
   yKAckXkxVMDEmuKDOfO4dvBwdQrU0yG2ntVlxqUsOOCAzkzweagJyuELY
   TrBXDh+C7W3UblHuybjvgSP24NjM3IbyUI/iJHuDbLb+D0JB25K7HayYV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="369754124"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="369754124"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 09:24:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="833172877"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="833172877"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2023 09:24:12 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 09:24:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 09:24:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 7 Nov 2023 09:24:11 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 7 Nov 2023 09:24:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUaqtaLaTjd1dQO71N79W4p1LKtQENq4SGCPjHLK5gBwaOjro40EK+hZEevFmmH1SWTN3+vblWhMWvsAiM4EsX30eNdRGK5BwBA/SBYK50FDVYq/Glslu9ok6RkecGRHt7befR4GFKgu0DK+6dAiTKZ9M8/nSQ+4OteWZLp57VTTahu8xUikrMGp1/7m+zVvOqhH3/xbbGx04QiPaGspXybJDAC4jO2fLDpBxNGz8hFI12V5zthcpE+OUMfoVD1DV8UOjcVXmy3IE9sAoE0eZsJGpSKQuGu9auStEtw9ldJ12WnNuedal5EMc2biSG51Hae5Joe9yRmyaCTRHJquFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yib1vAu6W0oBfBkRvakDCCZVsTrSwcpYqQ0eUk7aI7s=;
 b=WWxD37zRfYUg15RyH+V6i7rmPP70QVUZJrT5uLUxo4EjgOfmrD2mibuHHSHbV/mlBdptIHSQ01rzQXEQo6+vC3iDVAzSA2Ox28wZ8qCTHgX8VgOnS/W9f7DHb9Hhk9ZHkQV4WbJi1OoozPAlGwpDrQp/966HtbKnMbADISYhYcdFtRrFcuqwp0lywZvWSXQmkRCPDzJOoSBSgNzltkionyg6n5z/Su4Ne23LMLEniZWEXabSRGOmKnOW8cUGtuA65k9TzWb1RbGGNOGnjWsLk6Jlyz6FzI0/fjiOv/3ILG4bE42Q3Bp5CsYpy7FPrIeRlgyNvVlp+u68WyA/maf7wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CO1PR11MB5027.namprd11.prod.outlook.com (2603:10b6:303:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 17:24:09 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 17:24:09 +0000
Message-ID: <e3b4b1a6-5383-4bfb-ba83-ab27d58dae29@intel.com>
Date:   Tue, 7 Nov 2023 18:24:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [alobakin:pfcp 11/19] include/linux/bitmap.h:642:17: warning:
 array subscript [1, 1024] is outside array bounds of 'long unsigned int[1]'
Content-Language: en-US
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     Alexander Potapenko <glider@google.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        <oe-kbuild-all@lists.linux.dev>, <linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <202310170708.fJzLlgDM-lkp@intel.com>
 <bd7fe929-c6fc-42be-9d2f-3f53ec21fd10@intel.com>
 <ZUkvOCxyiin_77qd@smile.fi.intel.com>
 <0a29df6b-bc27-43e9-a97d-57ecabb29a9e@intel.com>
 <CAG_fn=VtA6e3oGm4WVnxmy9yMBab780-U_4VoHSqm4tcd2UTzQ@mail.gmail.com>
 <ca0ad357-727b-4f41-a3d6-2c48a9dd5836@intel.com>
In-Reply-To: <ca0ad357-727b-4f41-a3d6-2c48a9dd5836@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::7) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CO1PR11MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: a20448a9-06e9-4989-7574-08dbdfb65a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RsznJrANkPM1HtCxy/l0TWXAFfe1iK1xcC6P6NidjCnkx2KQgJNLCNXsC2uz3ph8MzcgsPwuPTtr37S5XNC7A8VwnqIkW2GfXRydFOj4/6qxTVNKtC4gp9GkedvIHgJp1zYaUqkvQaMejusLK5352IeJ8Lpmn3v61R+V0tdrl6bY933eAuw73O3PYU8moS4hHV6WlvZtfCXg/sH6JtJ+BfS/j9G9BGpT4dkK8cMa7zuZHNk4+V/F73KeJh0pWb9rvINdZE0omSbyXil+yC1ijhJi5EdG56+sTEDZtoaXAESyu2TgZlKJOXTYa0Kx9jXvrh88hMpwZQ2PGHZdcrx0OcfNwp0yzkYhrHHiIBWktWOYT+qQH2A21YH9qiu5Nw9QRxRIvoB5ppUA+zLNhzgDvxm0u/7DCEYR8F0GFJennmNjGCg6RwSUZmBMy5ioElLiznHNeX5xGWVeYTL4UZa/04btEa6LcBYzqn2uMmBO1lBwTcuLpcZKzmYpAuBdAPdItngFu2jwYXQKyw9b+NHh3DDQrnHKVgeP1Qp+vJQsj6f0MkdSSXY3YnDlTAgVWB4G4oTZbvg+K6r3d9zW+S04M41doaT7j/gq/ToytlHpb3/sqC5shSu9HI/Dgt4xcHzVlCt8nkbfXi98X2LVA37Kj00AJdVfhz/ul+JFwmzfl1DMFBdf+MCJ17XW4BhbdtUG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230273577357003)(230173577357003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(66899024)(2616005)(83380400001)(26005)(66556008)(54906003)(66476007)(66946007)(6916009)(316002)(6506007)(53546011)(2906002)(5660300002)(6512007)(31696002)(478600001)(6486002)(86362001)(38100700002)(6666004)(82960400001)(31686004)(36756003)(4326008)(8936002)(8676002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmlqSGlOTFhhcytVRzBmRWk3OUR2WGhmKzZGYjhDOVJzTzQ2WEVPTFVjQ3Rn?=
 =?utf-8?B?cWprZ2lJU3R4eEEzSjBiQUFsRmFKZ2NxOFhKWThWOWp2Y25QMkd3QTJzemZp?=
 =?utf-8?B?Nm9ieUtLK2NyZC85akg2eWhiZzJFYWFFdVgxMXY0enVsQVY2bGtNbU9HMUJJ?=
 =?utf-8?B?NWNRNzJrMHZUL29tZ3RGSDNzaEhBd0JyQzk1Z3dXNWdIa1Z3U2pUSXk1WVRr?=
 =?utf-8?B?WlNmQVF0MFAvUEJwMUtSTVBuMWpwdEl4VWFKa1k3RmN4L2xES0dGOWdWbktp?=
 =?utf-8?B?bFNHcFBLN3I0UzJsT0NFWDhuRldPZ1hNejQ2VGR0SkRBbmEvOGxZaE5GbGpi?=
 =?utf-8?B?TkRzbVlDeFF3SUsrMk9aOXFzbnJHYzZFRTJCVUFKc0ovNm9tbFoyZFhCVG9k?=
 =?utf-8?B?aHFvTEVGSmFXTDg3ODMzV2hDL1ROU2NERHR5ZklYdGVQNWEzb2ZBWmlLdGxs?=
 =?utf-8?B?Mk1SR2hhbCtUMXF0MXozNDQxYitvTWJJNXJJQjZCbC9ndXhKWC9tZEkxQXVi?=
 =?utf-8?B?UHJ1dStRTnVwTjJ3aFFOSzAybjVWZU5mZGNlTmVYS3VBV2x4RHd5Tlk1Rmt4?=
 =?utf-8?B?S2dmK2JKbk1UNmF6ek8zUjg1NElBekJ0eS9wdCtxY1ppRExCZlQwdEExYmlZ?=
 =?utf-8?B?Qk1OYTU5dWc0RVhHcy9yNUt5Tm9YV0pwaG9KeldRSUVsMit4U0ZRWGlKUmRj?=
 =?utf-8?B?a1Q1bm5OSENob1RwR0NuQVovdmlzTDhnRk9lbi96Q0QxOHBYSmE1WEg4d0x6?=
 =?utf-8?B?TFFPVmJsNzJlaWFRVjdDMCtPOUtheVVIUVpZRTN4OExQVFAzNkFiVDhlNkpv?=
 =?utf-8?B?clkxOEVRYWFRL29uc1VpRnZWc2RmMVh4SHhvSmIxL2x6RzI5anZlMGVXK1FR?=
 =?utf-8?B?VHNueVlYUlVWMVM3S1pTWHBqS2plWnB6NlVqbVlQalNxdmV1WGVKdFZiVlE4?=
 =?utf-8?B?dG5XeHlvYlFiZzBHVW53K2tTczlxcXRjS2ozMHRJVEE5L3BNRW9hSFZ0L3Jp?=
 =?utf-8?B?L1V6VkJiU29jN1hyRXdHRVUzSjJJUEpwVUNXNWV3Smo4ZVZSNHJaTmppQ2R0?=
 =?utf-8?B?N1c4c0hWcFd6UUk2ZTlHcE82Rm44dkVJYWtBVG1rN2hJNFl2OGdDUUtQSDhr?=
 =?utf-8?B?VDNOVEFySWdxRSs2dEdHYTFBTDZ1b2xKREthZy9wc2xhNVo2WHMrNU9JS0R5?=
 =?utf-8?B?SHAzZlBITVpCVFVCNHgrYjl2U3dsQzVBelVldzZ6b2xVQkpaVzdobC9BbTlh?=
 =?utf-8?B?NzNzcWVKaDVXenFpMkVsNGc2aFU5NEUrT25LZzJ6a1ZFMlk5WE5KYi9PTnNa?=
 =?utf-8?B?S201OHo0dHIyaGIrdXlybUF4MjZyQWlrTGZmak80S2ZZSWRBdSt5cExXakNM?=
 =?utf-8?B?dDRBSTQvem82cE4wdUFUNnpHYmU2L3JrRHBDU0NrNllqSVhSb1Y0cC9xSDRk?=
 =?utf-8?B?dG5jbTczenJVV1BYRGVubjFLTis4SnVXTkUyUlVGbG1NYVNGNnVrNDRHbkYx?=
 =?utf-8?B?U2Jlb2JaU2ZlRXdQdlhTVzcxVnppeTdpWHo5Y3NROFlwVVVURWJCTHM3dWZK?=
 =?utf-8?B?N3J2U3lwTll3REo2ZEZIcWoxanZaRVhoVmVuNVVyTHp4VUhrSkpSTExsa09Y?=
 =?utf-8?B?aHZnU0FydjhpSStoMGlNaVNqWUdma1JvVUJtSlNxNnhQdVRjdnpEQjNTdHlO?=
 =?utf-8?B?MVdldTVSUTJ2SGx6bnJ2VVV3WDhnQTdvcVVKekw1WTRqQ2FYR0FrN0ErUWl0?=
 =?utf-8?B?Zjh2WEpNbCtSa2RodkZLNVFsL0hmSmFYRzliNW5DTXFPOGczYnBkcWs1cUlv?=
 =?utf-8?B?c1NaSUh4YVpXY2tyMzlpZWtUOFRpd3ZZeWN0MCs4d0FvcW5SSUdDaXh6UTB1?=
 =?utf-8?B?OHUwa0pXMmdXOXorQVVMbUh6SElyUXpTbHlwdGVDMGQyc0NYeGRYVTg0VVJv?=
 =?utf-8?B?bnYvVEs3SDJGSmU5YkJDNGFPT2ZaT2MvM1RzS3NaU1hjYmxMeTg4RVM4dkEr?=
 =?utf-8?B?WWlLa1V2SlhNODIzTStuN1BIMkRnVi9EYXpzNmJZSVFGUk5LbTNwaEpaRW1X?=
 =?utf-8?B?MmRkZ2dnMTgza3VnUXU0cCtqUGx6OTk3YkFUSzBJb2FKOEcvcm1QdTFzanla?=
 =?utf-8?B?VEszelovM01uRUNaYXBRNi85dHRpTDhKbzVNMDR5WGF5TmdpZVNEZ3p4WWYx?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a20448a9-06e9-4989-7574-08dbdfb65a0f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 17:24:09.3608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Zuk5YhvsN9vck4nDaPxt/be2KUrvEDXVHztffRVPJl1Jb93XFC/33+3TBtFQGU9/0PKfZi1u47kX0VkgWc8SZw7UidFitrv/q5vqJ0dh28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5027
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Tue, 7 Nov 2023 17:44:00 +0100

> From: Alexander Potapenko <glider@google.com>
> Date: Tue, 7 Nov 2023 17:33:56 +0100
> 
>> On Tue, Nov 7, 2023 at 2:23 PM Alexander Lobakin
>> <aleksander.lobakin@intel.com> wrote:

[...]

> I tested it on GCC 9 using modified make.cross from lkp and it triggers
> on one more file:
> 
> drivers/thermal/intel/intel_soc_dts_iosf.c: In function 'sys_get_curr_temp':
> ./include/linux/bitmap.h:601:18: error: array subscript [1,
> 288230376151711744] is outside array bounds of 'long unsigned int[1]'
> [-Werror=array-bounds]
> 
>> to give the compiler some hints about the range of values passed to
>> bitmap_write() rather than suppressing the optimizations.
> 
> OPTIMIZER_HIDE_VAR() doesn't disable optimizations if I get it
> correctly, rather shuts up the compiler in cases like this one.
> 
> I've been thinking of using __member_size() from fortify-string.h, we
> could probably optimize the object code even a bit more while silencing
> this warning.
> Adding Kees, maybe he'd like to participate in sorting this out as well.

This one seems to work. At least previously mad GCC 9.3.0 now sits
quietly, as if I added OPTIMIZER_HIDE_VAR() as Yury suggested.

Note that ideally @map should be marked as `POS` in both cases to help
Clang, but `POS` gets undefined at the end of fortify-string.h, so I
decided to not do that within this draft.

Thanks,
Olek
---
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index e8031a157db5..efa0a0287d7c 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -589,12 +589,14 @@ static inline unsigned long bitmap_read(const
unsigned long *map,
 	size_t index = BIT_WORD(start);
 	unsigned long offset = start % BITS_PER_LONG;
 	unsigned long space = BITS_PER_LONG - offset;
+	const size_t map_size = __member_size(map);
 	unsigned long value_low, value_high;

 	if (unlikely(!nbits || nbits > BITS_PER_LONG))
 		return 0;

-	if (space >= nbits)
+	if ((__builtin_constant_p(map_size) && map_size != SIZE_MAX &&
+	     index + 1 >= map_size / sizeof(long)) || space >= nbits)
 		return (map[index] >> offset) & BITMAP_LAST_WORD_MASK(nbits);

 	value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
@@ -620,6 +622,7 @@ static inline unsigned long bitmap_read(const
unsigned long *map,
 static inline void bitmap_write(unsigned long *map, unsigned long value,
 				unsigned long start, unsigned long nbits)
 {
+	const size_t map_size = __member_size(map);
 	size_t index;
 	unsigned long offset;
 	unsigned long space;
@@ -638,7 +641,9 @@ static inline void bitmap_write(unsigned long *map,
unsigned long value,

 	map[index] &= (fit ? (~(mask << offset)) :
~BITMAP_FIRST_WORD_MASK(start));
 	map[index] |= value << offset;
-	if (fit)
+
+	if ((__builtin_constant_p(map_size) && map_size != SIZE_MAX &&
+	     index + 1 >= map_size / sizeof(long)) || fit)
 		return;

 	map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
