Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDAC7D3CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjJWRBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJWRBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:01:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49E7102;
        Mon, 23 Oct 2023 10:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698080498; x=1729616498;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=+G4c7HxrNbF8B4v6ly4sSEudlvl91tU+dM38xqrSEss=;
  b=m9P+N19o0Kzn8rng7n6DkWaF6uTrpOA66kQlgq3qr03chFgVdQen6pkx
   D/t6770gzxRtqhCX5sxouniB92uD4owa4Xx98ScvCwDx2hiHrwF6K0N0t
   r+g4RbbM1qeg0bmFWc37xyFnl2o7EFIZRAd6kFUEmL3L9LUx5+kB+uEDX
   NCZwlIQMJhoe4V0Ceq2+jEoR6OsWC9jTDv7njdNkRrjPiJpPu2awgCsdN
   f02D+9wfQbLlaZmEPtEzO638zkC6119P2Vj5n6qieuOj6ltDoxFBfcQlB
   IPBq3r3CvWNKnQu0+N0LVly+3UmmuIG6llgA2sO9GmV9JSrK6CvCeJ1Pn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="385781472"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="385781472"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 10:01:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="901868766"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="901868766"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 09:59:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 10:01:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 10:01:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 10:01:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3MWAtagbmQLQzlJA5i5GnpXlXDolf3MquUhm6rTix7/FWd3BOVicoJ6NNpH8sV1kJ5D0mG0o4l+2iRhPjkxCIMZAxPzHsVEGN3o41xa7HC2o32HJhw9hjoYyGa0Kwta8V5YWnQswxEC2Sv0u/CyrV+2xRG2ILpxJDNfFQ5OtyZGmU4hCf1RFxZoMEfUUdbTpghT1WWa+4HD+oxfZOE3wDHyMfsVvyOU2+psg/V/RIcSTL4Wx/0KKuRN8E7csFP5cNmTmbaysyjbAkpnQ0YDYy9UzP4Rlm+6uzQSKYbY046VJXT/sLpwN5uXFY9PRWxClCpLrMKKGICKozMgdjiUBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+G4c7HxrNbF8B4v6ly4sSEudlvl91tU+dM38xqrSEss=;
 b=bm8LlvMgXeH+oC2QqsJpfFeG+Xn0m4HX/e7TfkPQOknO1IhZOXszrcXo25tYswISt7dE+JvFtvzObBL6MeKXkXxywg1dnJm0pJT/arEZ7rDSJxJnww8wOukd4siIlZf1v9LWo+j8reTwx7QPXXp8bonjPrg7m9IGWSgLyQOP8QJF0CMllMpPGxAM4Vd+yC68YNP2AIvjNgWppA30Wpe4TTm3ZvDH+N/Qx4qtEoCeFhMRw3DlbzNI9z9/VKQOurU3TC1/8mUZ5w1vW1oJ7d7yp2kNUVXteyqqSqllZTq5AgTr6+HEEKwEA416zYCD901KyUPD5YoXI9BWSFtxxR7bfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH0PR11MB4823.namprd11.prod.outlook.com (2603:10b6:510:43::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 17:01:28 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1%4]) with mapi id 15.20.6907.028; Mon, 23 Oct 2023
 17:01:28 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 00/10] Handle set_memory_XXcrypted() errors
Thread-Topic: [PATCH 00/10] Handle set_memory_XXcrypted() errors
Thread-Index: AQHaATgYDiWliu1dgUGgxVK01y3gA7BRWnyAgAAjuACABiCYgIAAA+KA
Date:   Mon, 23 Oct 2023 17:01:28 +0000
Message-ID: <c825265908fe4a0ea7b8ac77e4dc7c81918bbe66.camel@intel.com>
References: <20231017202505.340906-1-rick.p.edgecombe@intel.com>
         <BYAPR21MB1688075D6262FAA18941E40AD7D4A@BYAPR21MB1688.namprd21.prod.outlook.com>
         <73b02835-dbd6-4662-91f9-e8324d8cbf98@intel.com>
         <BYAPR21MB16883646AA820D5FD7EA2C1AD7D8A@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB16883646AA820D5FD7EA2C1AD7D8A@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH0PR11MB4823:EE_
x-ms-office365-filtering-correlation-id: e23a4db9-c078-412f-887a-08dbd3e9b30f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d3/Cj8j5pbzIZ6HE8L8Q3aU6jBoslELbxoJLdrnqX4MdCiFtv84PfIq3NfjEH5gUqDzIFrZlweGJ82APugtFxdIw+iVz+oMZgsToUheYc1pIopJUeYrC8TxleRWda7/1lPkgkiLNspLvunA1eZidWB2D/r4qf/5T+JkpQeS7d0d8L3KgRCemDDGQM9NGENamIMHgkvqXF1K4aEiJd6epUPVngwZWCBN2N//Cs6OqhI8+A2BQj/ER5oAhMCQgKHBW0pNH0zgp6ZhG1+pOm0fHLFWnMNzF1nDg0Bjb2evYOenWKljNJFjGK+VnOzyfyWFAwaL5TFpgn1DnexT2zRTkTWftZyXXPYpTyT4xTItPaMBImi6cCewo+XwZj4YXnZaAZYgXXECAzqf5XS/ywyK327fF3cKLJIpBM2sRgf5/kF7c0+qQH/WtNw9kMowOaeIzA/Yq7p/Runh4qYuC8/6FkhC7wwQ3DHIC07hn2bIBAfHzFtClEQm79K75vTCvO9ryXDNSLlz0KKl+m9FtrrxrLHmJ4PpGqOMXjVxXBYBUQ5JWhpjuKK0fzaqx3P5EzbgAi7dWwoxMKs7UDYFOfvzmpnEYsRBZr1i/44MeK82MHY5Bt/IlfbIcTgBrRml/eWIZ35qiaEAMnUJFAeDZ1NFRew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2906002)(4001150100001)(2616005)(6512007)(26005)(6506007)(110136005)(91956017)(66946007)(66476007)(76116006)(66556008)(86362001)(6486002)(71200400001)(53546011)(83380400001)(82960400001)(122000001)(64756008)(38100700002)(5660300002)(7416002)(316002)(66446008)(41300700001)(8936002)(8676002)(36756003)(921008)(38070700009)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjVKTHpUK2I5Y2pFU0VyeVdsSHgwQUwwUzYrazVNSEVSbzFISTBheDRlNk0w?=
 =?utf-8?B?dkNUNlp0MENVbi9Gb1VtaUhDdHZ4bExNdW5rdXAvaS9PalM5d1VkQ1VEU2hL?=
 =?utf-8?B?Y212U1ZaSkxCTUozVUo3SEp1YkZSOGtLSzQwMUJQN1JZb3ZrSTVkdnhzQ3Nh?=
 =?utf-8?B?eDZRT3ZEcEgxRVErbkk3blVKU3EySnZFSVZPR3BaK0Rmd212N2lwaGlsR2I1?=
 =?utf-8?B?R1lkRkYzQVZNZzB5czVxQkRhaHNodHI2RGIyUUoycDBIRVJoVTNNTEhQVHdE?=
 =?utf-8?B?QUEwUVdEbDhHeDcwcC8vVVQxdTFjeUxUV0ZyVC9oQVlsYkxPR25vU1MrQ3FC?=
 =?utf-8?B?TWhycnhjOHhXejlHc21rcVI4Nlc0UGNwRk56Tk9OYmsyL1VMaTdsUjNMeTFF?=
 =?utf-8?B?WlZ4N1EvMW1rMml5Y09sYmc2SUZRV3lCWWRlU255VzdwbElXYTBGUkJRNzNo?=
 =?utf-8?B?dlk0YXM4bGtMbmpLNTdqa25kQXBES0dIR1lRQ2R0cm5BanpnZWFIWEIvVHdw?=
 =?utf-8?B?TGRyRTkzRWdHekUxVjNiamtPdVlsZlZBN0VFK2NjOUFRWFJEeVdkcERkdHdJ?=
 =?utf-8?B?SCtDUWFUNklpMzJVNWxFVTRwSUZ2TWdOd2VOSWttMEY4ZlpUcXVaRFAzOXln?=
 =?utf-8?B?VEZJN2RzSTY2MmhleUVnTWNETDBnWFV2SktPV1RHTWZZRGtmVHlRUy9JZ25o?=
 =?utf-8?B?S1JYSitvRld5cGxHbnBPQWRDaVdOaG00cldpRkFmckFMaEcxejBXbjJ0bWpu?=
 =?utf-8?B?QWZsNWs4T25BKy8rb2MvY0lud3BYYzNHLzFaWTRES0R6V1k3TW9LdHVtVEtL?=
 =?utf-8?B?V1VCMVhTOTJPbyttUlhIOGR3aWRtMUJtQjNLV1pmQkExVWIrU3llQ0NzWGVB?=
 =?utf-8?B?ODNnZmZNeUE5SmVuUWp5STUvSlJKVVQyTElvV0NOQUJLOTEySFJSUStXYXl1?=
 =?utf-8?B?RitycTUrQXVEQ0hBSkxKSVhMYTZjbXY4RVRkZ2VMalRzKzIrTkp0Zm9FN053?=
 =?utf-8?B?THJYdE5OOXNxUVlRYjBJVmtaV3kvV0pLSmpvMXdhbTJwdjZ4V1BRRDY4TTVJ?=
 =?utf-8?B?ZGJJRUM5TEF4K1dSNk5xaTdBaGhCYWRBWktROHNlS3hjY3dBMnVjUFF5c3JN?=
 =?utf-8?B?b1ByMStpU1A0UjBxWTVyTVBxSUlsUmtuVTYvNUlaNGFrTEhXVUIyQmJBaTNx?=
 =?utf-8?B?aWhsVGo4Y1pDZys2U2hCUTg5NFRqNGdkbEZkZXZmSDEwU2ZwaFlBWDE5WFBH?=
 =?utf-8?B?akdXd3ZHU1RhTjdWdit0YXNOQzRMWXpabHhDNUdwNHZIdDJZUlp3ZE8zQ2Uw?=
 =?utf-8?B?NlUvZzRyMjZBVUFlMk1sWnB6SzhMdks4eXJtSzRDMmorb1g5dmhwNzdxc3ZB?=
 =?utf-8?B?R2Y1TmplZzdnVDJIZ2o0R2RycTExS2tqYlJBMzRNUno2SmcyMTRkdG0xZTZQ?=
 =?utf-8?B?ei9BZkxhMWpEUDQ5bjI2QmU0QmhreWpiaEZJYTNucm5OUG4zQnBCSmhXYmlu?=
 =?utf-8?B?Vm1VWmtlMW1UZDVNbnhyTkx2RXF0SCszeXhmMU82eDJkYnE0NXR0dU1xYlh2?=
 =?utf-8?B?eXdmVyt6ZFc2SklLRDdhdVdYcjFYWEVFME5mZW9INmFpSlB1WmVKZ2Zydy9S?=
 =?utf-8?B?di8rL2hONGl3RzRaMGkvbXduKy84WXZDRlkzd0YvVTVadWZUOW5SY0VpNXBj?=
 =?utf-8?B?ckxORGh3Nk5wNTVUUHRJcDNySDhoMXAvdkIra2tZblRFeHNDVkJQaExBSDlk?=
 =?utf-8?B?V0dmQWVFQXJ1a01reVljVWpUaU43Wjg4U3EyL0VOdzNVdTdzZVp6TjdMNTNE?=
 =?utf-8?B?V3F6SXdJUzFheDlUT1pKQytraGJCbEhWS2FiNDNKZ0VHcExXRUtURk9HN1Y0?=
 =?utf-8?B?VnNYMnVqdmtybktISEtDa2lPcmdweC9JSHRkZDUvQkg3cHRoUFlpNmg0Y2Nk?=
 =?utf-8?B?N2pFZzRkQWVGWHVyWmNZcHdsM2VMOTJSdWVOM0FhY2pVUlB5THVFOERGcE9D?=
 =?utf-8?B?bkdoVUk0eFRwTmhJQWZ0eUpNeklkdHZFd1ZneEpmdHRteWF2d2p1QlR3QmVx?=
 =?utf-8?B?cGE4KytwdklDdlZIZ1ZybW03djlpb0o1d2puQWJRYmVQM1FZeXBUMFAzRHdL?=
 =?utf-8?B?eHY4T3BUSm12bVBtZ25yY3A2WW9ITHhZUUJXWmZZamdobWdQSXl3VThRT0x1?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF398847AEA25742B0C13867A46186EC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23a4db9-c078-412f-887a-08dbd3e9b30f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 17:01:28.7816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YEXsiSCcL6EtJV6xrgJ5IX6HNYMHMXRAZDPLid20DandjaKd3PHpJfkT1UmJLwe5vUSf3hrwV7tRFH+6YTmHv77+8HdFaTV+PQ5+G5Fpgpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4823
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTEwLTIzIGF0IDE2OjQ3ICswMDAwLCBNaWNoYWVsIEtlbGxleSAoTElOVVgp
IHdyb3RlOg0KPiBGcm9tOiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPiBTZW50
OiBUaHVyc2RheSwgT2N0b2JlciAxOSwNCj4gMjAyMyAxMjoxMyBQTQ0KPiA+IA0KPiA+IE9uIDEw
LzE5LzIzIDEwOjA1LCBNaWNoYWVsIEtlbGxleSAoTElOVVgpIHdyb3RlOg0KPiA+ID4gSSdtIG1v
cmUgaW4gZmF2b3Igb2YgdGhlICJzaW1wbHkgcGFuaWMiIGFwcHJvYWNoLsKgwqAgV2hhdCB5b3Un
dmUNCj4gPiA+IGRvbmUNCj4gPiA+IGluIHlvdXIgUGF0Y2ggMSBhbmQgUGF0Y2ggMiBpcyBhbiBp
bnRyaWd1aW5nIHdheSB0byB0cnkgdG8gZ2V0DQo+ID4gPiB0aGUgbWVtb3J5DQo+ID4gPiBiYWNr
IGludG8gYSBjb25zaXN0ZW50IHN0YXRlLsKgIEJ1dCBJJ20gY29uY2VybmVkIHRoYXQgdGhlcmUg
YXJlDQo+ID4gPiBmYWlsdXJlDQo+ID4gPiBtb2RlcyB0aGF0IG1ha2UgaXQgbGVzcyB0aGFuIDEw
MCUgZm9vbHByb29mIChtb3JlIG9uIHRoYXQNCj4gPiA+IGJlbG93KS7CoCBJZg0KPiA+ID4gd2Ug
Y2FuJ3QgYmUgc3VyZSB0aGF0IHRoZSBtZW1vcnkgaXMgYmFjayBpbiBhIGNvbnNpc3RlbnQgc3Rh
dGUsDQo+ID4gPiB0aGVuIHRoZQ0KPiA+ID4gb3JpZ2luYWwgcHJvYmxlbSBpc24ndCBmdWxseSBz
b2x2ZWQuwqDCoCBJJ20gYWxzbyBub3Qgc3VyZSBvZiB0aGUNCj4gPiA+IHZhbHVlIG9mDQo+ID4g
PiBpbnZlc3RpbmcgZWZmb3J0IHRvIGVuc3VyZSB0aGF0IHNvbWUgZXJyb3JzIGNhc2VzIGFyZSBo
YW5kbGVkDQo+ID4gPiB3aXRob3V0DQo+ID4gPiBwYW5pYydpbmcuwqAgVGhlIHVwc2lkZSBiZW5l
Zml0IG9mIG5vdCBwYW5pYydpbmcgc2VlbXMgc21hbGwNCj4gPiA+IGNvbXBhcmVkIHRvDQo+ID4g
PiB0aGUgZG93bnNpZGUgcmlzayBvZiBsZWFraW5nIGd1ZXN0IFZNIGRhdGEgdG8gdGhlIGhvc3Qu
DQo+ID4gDQo+ID4gcGFuaWMoKSBzaG91bGQgYmUgYSBsYXN0IHJlc29ydC7CoCBXZSAqYWx3YXlz
KiBjb250aW51ZSB1bmxlc3Mgd2UNCj4gPiBrbm93DQo+ID4gdGhhdCBzb21ldGhpbmcgaXMgc28g
YmFkIHRoYXQgd2UncmUgZ29pbmcgdG8gbWFrZSB0aGluZ3Mgd29yc2UgYnkNCj4gPiBjb250aW51
aW5nIHRvIHJ1bi4NCj4gPiANCj4gPiBXZSBzaG91bGRuJ3QgcGFuaWMoKSBvbiB0aGUgZmlyc3Qg
bGl0dGxlIHRoaW5nIHRoYXQgZ29lcyB3cm9uZy7CoCBJZg0KPiA+IGZvbGtzIHdhbnQgKnRoYXQq
LCB0aGVuIHRoZXkgY2FuIHNldCBwYW5pY19vbl93YXJuLg0KPiA+IA0KPiA+ID4gTXkgY29uY2Vy
biBhYm91dCBQYXRjaGVzIDEgYW5kIDIgaXMgdGhhdCB0aGUgZW5jcnlwdGlvbiBiaXQgaW4NCj4g
PiA+IHRoZSBQVEUNCj4gPiA+IGlzIG5vdCBhIHJlbGlhYmxlIGluZGljYXRvciBvZiB0aGUgc3Rh
dGUgdGhhdCB0aGUgaG9zdCB0aGlua3MgdGhlDQo+ID4gPiBwYWdlIGlzDQo+ID4gPiBpbi7CoCBD
aGFuZ2luZyB0aGUgc3RhdGUgcmVxdWlyZXMgdHdvIHN0ZXBzIChpbiBlaXRoZXIgb3JkZXIpOsKg
IDEpDQo+ID4gPiB1cGRhdGluZw0KPiA+ID4gdGhlIGd1ZXN0IFZNIFBURXMsIGFuZCAyKSB1cGRh
dGluZyB0aGUgaG9zdCdzIHZpZXcgb2YgdGhlIHBhZ2UNCj4gPiA+IHN0YXRlLg0KPiA+ID4gQm90
aCBzdGVwcyBtYXkgYmUgZG9uZSBvbiBhIHJhbmdlIG9mIHBhZ2VzLsKgIElmICMyIGZhaWxzLCB0
aGUNCj4gPiA+IGd1ZXN0DQo+ID4gPiBkb2Vzbid0IGtub3cgd2hpY2ggcGFnZXMgaW4gdGhlIGJh
dGNoIHdlcmUgdXBkYXRlZCBhbmQgd2hpY2ggd2VyZQ0KPiA+ID4gbm90LCBzbyB0aGUgZ3Vlc3Qg
UFRFcyBtYXkgbm90IG1hdGNoIHRoZSBob3N0IHN0YXRlLsKgIEluIHN1Y2ggYQ0KPiA+ID4gY2Fz
ZSwNCj4gPiA+IHNldF9tZW1vcnlfZW5jcnlwdGVkKCkgY291bGQgc3VjY2VlZCBiYXNlZCBvbiBj
aGVja2luZyB0aGUNCj4gPiA+IFBURXMgd2hlbiBpbiBmYWN0IHRoZSBob3N0IHN0aWxsIHRoaW5r
cyBzb21lIG9mIHRoZSBwYWdlcyBhcmUNCj4gPiA+IHNoYXJlZC4NCj4gPiA+IFN1Y2ggYSBtaXNt
YXRjaCB3aWxsIHByb2R1Y2UgYSBndWVzdCBwYW5pYyBsYXRlciBvbiBpZiB0aGUgcGFnZQ0KPiA+
ID4gaXMNCj4gPiA+IHJlZmVyZW5jZWQuDQo+ID4gDQo+ID4gSSB0aGluayB0aGF0J3MgT0suwqAg
SW4gdGhlIGVuZCwgdGhlIHBhZ2Ugc3RhdGUgaXMgY29udHJvbGxlZCBieSB0aGUNCj4gPiBWTU0u
DQo+ID4gwqAgVGhlIGd1ZXN0IGhhcyB6ZXJvIGNvbnRyb2wuwqAgQWxsIGl0IGNhbiBkbyBpcyBt
YWtlIHRoZSBQVEVzDQo+ID4gY29uc2lzdGVudA0KPiA+IGFuZCBob2xkIG9uIGZvciBkZWFyIGxp
ZmUuwqAgVGhhdCdzIGEgZ2VuZXJhbCBzdGF0ZW1lbnQgYW5kIG5vdA0KPiA+IHNwZWNpZmljDQo+
ID4gdG8gdGhpcyBwcm9ibGVtLg0KPiA+IA0KPiA+IEluIG90aGVyIHdvcmRzLCBpdCdzIGZpbmUg
Zm9yIENvQ28gZm9sa3MgdG8gYmUgcGFyYW5vaWQuwqAgSXQncyBmaW5lDQo+ID4gZm9yDQo+ID4g
dGhlbSB0byBzZXQgcGFuaWNfb25fe3dhcm4sb29wcyx3aGF0ZXZlcn09MS7CoCBCdXQgaXQncyAq
Tk9UKiBmaW5lDQo+ID4gdG8gc2F5DQo+ID4gdGhhdCBldmVyeSBURFggZ3Vlc3Qgd2lsbCB3YW50
IHRvIGRvIHRoYXQuDQo+IA0KPiBUaGUgcHJlbWlzZSBvZiB0aGlzIHBhdGNoIHNldCBpcyB0byBu
b3QgcHV0IHBhZ2VzIG9uIHRoZSBMaW51eA0KPiBndWVzdCBmcmVlIGxpc3QgdGhhdCBhcmUgc2hh
cmVkLsKgIEkgYWdyZWUgd2l0aCB0aGF0IHByZW1pc2UuwqAgQnV0DQo+IG1vcmUgcHJlY2lzZWx5
LCB0aGUgYmVzdCB3ZSBjYW4gZG8gaXMgbm90IHB1dCBwYWdlcyBvbiB0aGUgZnJlZQ0KPiBsaXN0
IHdoZXJlIHRoZSBndWVzdCBQVEUgaW5kaWNhdGVzICJzaGFyZWQiLsKgIEV2ZW4gaWYgdGhlIGhv
c3QgaXMNCj4gbm90IGFjdGluZyBtYWxpY2lvdXNseSwgZXJyb3JzIGNhbiBjYXVzZSB0aGUgZ3Vl
c3QgYW5kIGhvc3QgdG8gYmUNCj4gb3V0LW9mLXN5bmMgcmVnYXJkaW5nIGEgcGFnZSdzIHByaXZh
dGUvc2hhcmVkIHN0YXR1cy7CoCBUaGVyZSdzIG5vDQo+IHdheSB0byBmaW5kIG91dCBmb3Igc3Vy
ZSBpZiB0aGUgaG9zdCBzdGF0dXMgaXMgInByaXZhdGUiIGJlZm9yZQ0KPiByZXR1cm5pbmcgc3Vj
aCBhIHBhZ2UgdG8gdGhlIGZyZWUgbGlzdCwgdGhvdWdoIGlmDQo+IHNldF9tZW1vcnlfZW5jcnlw
dGVkKCkgc3VjY2VlZHMgYW5kIHRoZSBob3N0IGlzIG5vdA0KPiBtYWxpY2lvdXMsIHdlIHNob3Vs
ZCBiZSByZWFzb25hYmx5IHNhZmUuDQo+IA0KPiBGb3IgcGFyYW5vaWQgQ29DbyBWTSB1c2Vycywg
dXNpbmcgcGFuaWNfb25fd2Fybj0xIHNlZW1zDQo+IHdvcmthYmxlLsKgIEhvd2V2ZXIsIHdpdGgg
Y3VycmVudCBjb2RlIGFuZCB0aGlzIHBhdGNoIHNlcmllcywNCj4gaXQncyBwb3NzaWJsZSBoYXZl
IHNldF9tZW1vcnlfZGVjcnlwdGVkKCkgcmV0dXJuIGFuIGVycm9yIGFuZA0KPiBoYXZlIHNldF9t
ZW1vcnlfZW5jcnlwdGVkKCkgZml4IHRoaW5ncyB1cCBhcyBiZXN0IGl0IGNhbiANCj4gd2l0aG91
dCBnZW5lcmF0aW5nIGFueSB3YXJuaW5ncy7CoCBJdCBzZWVtcyBsaWtlIHdlIG5lZWQgYQ0KPiBX
QVJOIG9yIHNvbWUgZXF1aXZhbGVudCBtZWNoYW5pc20gaWYgZWl0aGVyIG9mIHRoZXNlIGZhaWxz
LA0KPiBzbyB0aGF0IENvQ28gVk1zIGNhbiBwYW5pYyBpZiB0aGV5IGRvbid0IHdhbnQgdG8gcnVu
IHdpdGggYW55DQo+IGluY29uc2lzdGVuY2llcyAoYWdhaW4sIGFzc3VtaW5nIHRoZSBob3N0IGlz
bid0IG1hbGljaW91cykuDQoNCkFsd2F5cyB3YXJuaW5nIHNlZW1zIHJlYXNvbmFibGUsIGdpdmVu
IHRoZSBhZGRlZCBsb2dpYyBhcm91bmQgcmV0cnlpbmcuDQpUaGlzIGlzIHNvbWV0aGluZyB0aGF0
IHRoZSBHSENJIHNwZWMgc2F5cyBpcyBzb21ldGhpbmcgdGhhdCBjYW4gaGFwcGVuDQp0aG91Z2gu
IFNvIHRoZSB3YXJuaW5nIGlzIGtpbmQgb2YgbGlrZSAidGhlIGhvc3QgaXMgYmVpbmcgbGVnYWws
IGJ1dCBhDQpiaXQgdW5yZWFzb25hYmxlIi4gVGhpcyB3aWxsIGFsc28gc2F2ZSBoYXZpbmcgdG8g
YWRkIHdhcm5pbmdzIGluIGFsbCBvZg0KdGhlIGNhbGxlcnMsIHdoaWNoIGFyZSBtaXNzaW5nIGlu
IHNvbWUgc3BvdHMgY3VycmVudGx5Lg0KDQo+IA0KPiBBbHNvLCBmcm9tIGEgdHJvdWJsZXNob290
aW5nIHN0YW5kcG9pbnQsIHBhbmljX29uX3dhcm49MQ0KPiB3aWxsIG1ha2UgaXQgZWFzaWVyIHRv
IGRpYWdub3NlIGEgZmFpbHVyZSBvZg0KPiBzZXRfbWVtb3J5X2VuY3J5cHRlZCgpL2RlY3J5cHRl
ZCgpIGlmIGl0IGlzIGNhdWdodA0KPiBpbW1lZGlhdGVseSwgdmVyc3VzIHB1dHRpbmcgYSBwYWdl
IHdpdGggYW4gaW5jb25zaXN0ZW50IHN0YXRlIA0KPiBvbiB0aGUgZnJlZSBsaXN0IGFuZCBoYXZp
bmcgdGhpbmdzIGJsb3cgdXAgbGF0ZXIuDQoNCklmIHRoZSBndWVzdCBkb2Vzbid0IG5vdGlmeSBh
bnl0aGluZyB0byB0aGUgaG9zdCwgSSB3b25kZXIgaWYgdGhlcmUNCndpbGwgYmUgc2NlbmFyaW9z
IHdoZXJlIHRoZSBob3N0IGRvZXNuJ3Qga25vdyB0aGF0IHRoZXJlIGlzIGFueXRoaW5nDQp3cm9u
ZyBpbiB0aGUgVEQuIE1heWJlIGEgbmFpdmUgcXVlc3Rpb24sIGJ1dCBkbyB5b3UgaGF2ZSBhbnkg
aW5zaWdodA0KaW50byBob3cgZXJyb3JzIGluIGd1ZXN0IGxvZ3MgbWlnaHQgbWFrZSB0aGVyZSB3
YXkgdG8gdGhlIGhvc3QgYWRtaW4gaW4NCnR5cGljYWwgdXNhZ2U/DQo=
