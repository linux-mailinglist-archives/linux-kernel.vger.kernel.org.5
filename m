Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDB57FA83B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjK0Rlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjK0Rlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:41:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C20BF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701106906; x=1732642906;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IOdRKu/3USkrR1SdI68gXGGhR5HVAqkW4C93uwg7w64=;
  b=kd5m1iOQSDePjkxP20k+Bwdd93sBAsGSRWAaxhJhSl4Ix1GNrxzHfXjg
   Ce3EXsc8Tl9Z9m9ZY3U3ZSvgNfKoWbtJ0nYIcKpME6j5Apu7zQWsKMJiC
   RWYBgrhFRpKNA0sBWxWIhPPZ3nD6vpiiW3+bXbIUWD5UznFQULCfUBIID
   WVZsqmplyPx/CkpZXStLcFLTnRg7iOJDXPr2BqZVcRhRBDoP1GwLv3WMW
   B120XBQ95EHxAB98rOBxy34bgBRIXR5ymP2Mjaar/waAvaF+Q26TvKmuc
   KgskzhWw25mc3tmCjmef0PBnpj9NKfPE6lJJhjpcebYwdl+QRn/8DBl3d
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="372130728"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="372130728"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 09:41:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="744632676"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="744632676"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 09:41:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 09:41:32 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 09:41:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 09:41:31 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 09:41:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqEFrAY6I/z0q0pYnw6BTQJ1X3skvHQzmNEEVCk7+usd8o5KC5kwSnwDZKkQasFxg54y3SdWE0/DMZLcZLXIuEU90/mUmWDcQnNwhrNenMjyV/2f6XdAjzc5GMGGi0puM9ZM4i3E4GiaWtc2Bq9qRML4ylXa/KDZpfOkGloGv0TJilkrHT0e3d51GNPa8JEZtkRt3UQdFci0MACu/uUlboDPgvyAf7DctUVUK7wMhS7zxJQsPOALhXJ+0OzXRdiV8AixWIGJ5KE/rtEQYUWOln+LIwcPKOAcbfohXEONbEFS9vcttWryv6XLzGkkdiOOqqk4gl8JHLqnWakhIbk9Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOdRKu/3USkrR1SdI68gXGGhR5HVAqkW4C93uwg7w64=;
 b=YJUEssn7U+BHAnvi6LFTQZSl7TwmvPiPI5gUTrNcf1DQ1zbweQdF1aMyrwDs8D+DZuRApM/kUzlc29w4q3ffOS/hpaJrncv19DbtbnwPzmD1P3AI6oIvsSilqr1qcLlQoY+wLt+noqGNlABPHkM30gsPS3joqI74M260OtkijtFWl33vH6jkd0g+F9ovM/uktRK/QrRaSseUPMiOlqEscyE1yJGrkfhlxIF11gHUxtuPka2XdRQP25XHJCV6td9hvE3iJd0OQPqaDN2+bOnRZzMDfTyT3wB7VqKXNCtz/C2nNnbW2cZ0+empjXk+UPeuVfEU+ZT3MnkGItOVGr6zsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by LV8PR11MB8679.namprd11.prod.outlook.com (2603:10b6:408:1f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 17:41:16 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9%6]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 17:41:16 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "kito.cheng@sifive.com" <kito.cheng@sifive.com>
CC:     "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Shadow stack enabling from dynamic loader v/s kernel on exec
Thread-Topic: Shadow stack enabling from dynamic loader v/s kernel on exec
Thread-Index: AQHaHaLVAy4ouJt4Q0WQalPzbfPTrrCOdpGA
Date:   Mon, 27 Nov 2023 17:41:16 +0000
Message-ID: <d36b02fc0da364ea0d660e5e5ecac9df7e327f79.camel@intel.com>
References: <CAKC1njRkpaqbAFWrZpz75u4M-T8mniY2QHVZEENameqnHOOGPg@mail.gmail.com>
In-Reply-To: <CAKC1njRkpaqbAFWrZpz75u4M-T8mniY2QHVZEENameqnHOOGPg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|LV8PR11MB8679:EE_
x-ms-office365-filtering-correlation-id: 0bb07c22-e8fe-45d7-b141-08dbef700e6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 33/4RHAOTtQtAFthKq3QhTXgEHcnMbeN+P7vLDGzvu5gz0dDGJd9c/cfqpQxAaktucZiT5JqXOX7Awh9yjJ5c/cwWmDBNHv93G4/BHuG5CMMfWMR2laZ5mjUu8FuUTDT1l1pA1VsTqBF9HvxrqMs38n2lsnHzdDb2lHUBQEVrMNCXRig5AxwyInAic3TsJIfyBNTm9Kfn6o8GnR6pjgO4rXWazbb3Swo2MQhHNm3xteJw/XVrhqdTQFFFQgCGtUolyhzGm4VHyp2HdJissOuz8NQRx8fcPUcACht51WP4zjarXWfjhF4u/RG5dXiGHh/XH5nFHcT8emmaQ1XUGtOcpa2Z1VTXNuCUe7oEkUAmRVch5LQs+Xdx5Z4MhvNuI6Co3CtECzv64XUxMAQZ6Fldcs0uG3lMLLxkDFKygHo0bw2dylnFN5IGN9QvB47YyLL2IyoqQsdl+ab7ZyLDi7gNKvLzGeIoAe0Jc4mAQ0iOvQwk9BwsYboy6swg5AClabganmDY9ziJMiIWqhdQ+lmrJ6axMvRIlZtOwMm9veQ/h2qjszHt2MGIITgHJ9B5IKSbrmq2Ae6vZGSF6nwZpklbIgu+dhn5GiX7cNB01H4Qiod326ansoJTnJvIaTbDX6M
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(136003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(41300700001)(36756003)(86362001)(4001150100001)(38070700009)(122000001)(83380400001)(5660300002)(82960400001)(26005)(2616005)(2906002)(6512007)(6506007)(71200400001)(8676002)(4326008)(8936002)(478600001)(6486002)(66899024)(66446008)(64756008)(54906003)(66946007)(76116006)(110136005)(91956017)(66476007)(66556008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTJoWXVXUXRsVFBsVURvUThaQndnQ3JGRnc0UFRITktvemtwV1VqcVkzUWRv?=
 =?utf-8?B?djZyVW9xbUZKYWxoMUIwQmpENndzR1Z2ZERKY21kaWJwbFZPeW5mVlNpY3Na?=
 =?utf-8?B?Vk9CRXBlOFRWTFBXS0ZCaUxscGNnMURWSGhFSmdaSHBla2tKTWFaRm9oQXdu?=
 =?utf-8?B?ejlzTWhobENqcWQzTGQ5c3JWVmo5aWN2bTgwWlp6ZmhRbEl2VUhkbEZmZEs4?=
 =?utf-8?B?S2ltMXFUUjBjeDZUVWdjQkJvZ2Q5ajNJNTZ2Z3hmYy94R3BrQnF1TTZjb1pp?=
 =?utf-8?B?bWNtVUpMK21lcDlJOFVpUFpTbjRDQ1EwZklKK0VXSGlHclcrOFEzR1JwaUpN?=
 =?utf-8?B?M3AyWE5xTEVxd0JGQVc1VHdvQmhTZEZBb0dXSjJyeWh0ckk3OHdIaVpKVDRq?=
 =?utf-8?B?MDYwUjZ2aU1hbms0dWRDZno5SUNjUmdDVzRac0lsSmhkMm1ib1VuM2dHR1FF?=
 =?utf-8?B?MzI3ZXZ5SjVuS0hBOGd6bXdEdVRkWkxqVGlINytNSTBhUElZaXpGUDBkaXZL?=
 =?utf-8?B?R1pzRUIyd3Y5VlpaTUk1WGt5UnVaOWRBdHNLM0lvRnQ1cTY5aFZ2QVJNNmNt?=
 =?utf-8?B?RWlpZWFiT0FMZ1BqZ1pkNXFGK2xpYWo1ejFSU29sYTdXRDgya0tJaGp5ekd4?=
 =?utf-8?B?cXR6TkhNL0pDa1BGNjk0TlVHalZvMGlnc2ZQeXMyTlhSemZjYmgwektXQXNH?=
 =?utf-8?B?MXNkcUpRMlFZS1ZZQUd2YXVQK2s4OWtGcTlVS1pLWUdLb2FUdXRlb3FQRTlU?=
 =?utf-8?B?YVJGWG9BSjJjVkJMeWMrV3ZwTThDbFdJL3Zlc3dWU0tsczdWOWtmN1cxbWxY?=
 =?utf-8?B?YW43cWhKam1HeW44cmJUS2hBT1VLZ0hVMnN3QWNnelBvL1RPMllTVFp0aGZl?=
 =?utf-8?B?ME1vYisrblF0TG93eGFsdzJCN2FiNDdaQUllcXAvcTVDd1V4eHRiTTVGNDFT?=
 =?utf-8?B?MDV5SVZFWFNIN0k1V1dodlQzNnhIVVg2SHNYYUZjK1N6WlpyRElNdXBVdk5X?=
 =?utf-8?B?OVh4NVlFTDlOc0FjMk1SYWl6dFNubmRjVnVYODRGTnhlUlJBYlNrcWRmWU5N?=
 =?utf-8?B?NGhwbzM1ZFhNcXM3SnlIZDVSNjV6eU9GUHZPSmN6VG1mWjc4dEZ6dW5ZcVQw?=
 =?utf-8?B?NE15dER6VzNmeEg4UnF2ZVZtRytZT0cyV2ZlMnk0WHppZU1zWDRlSm1pdUEy?=
 =?utf-8?B?S0RveWVKOFgzaHE2TVcrVG1OYjg1aEVGall2Y1ZGa0NzWUJzaC9HOVYwd1RI?=
 =?utf-8?B?NzNrT0k2K1R4WWtCaVdDelorUmQ4b0dFTmV4MWcvcHZvbG1IYUhSRkU5Vy9V?=
 =?utf-8?B?V1NYbTdtWFU2NzJybXMrWTg1WjRaY1RYbnY0c1Y0T09wSWVKeUsvQWVEZVdB?=
 =?utf-8?B?ZC9wcXgybDFGUUpnbGVJNFJuZWRycTNEK1labWhhUmpmdWZscEttSnZzVlh2?=
 =?utf-8?B?OTVGNkN6OVIvWnNRNEw0YjZPWkVoVUYxbE5WUzM0QklZSHVSYTB0RC95YXVj?=
 =?utf-8?B?N2M4c1dCOXQvUTg1TmFrSk5jazloeHZMbkJxZysxak02UW42ckpnaUFBeXRn?=
 =?utf-8?B?OVNhVWRRaGFwQ1NWUjZUend1eERGWXl1MzlLOVNXTjlQTTZMM2crOFhJcThB?=
 =?utf-8?B?RnlyaCt3QXlyRjNkdGFqUGc5VzdHb280MjhNMlFzZFJkN2VmQloxbGNQaDFa?=
 =?utf-8?B?U1FiQjJIU05RUzZXeUorWm1lTFNmK0F0Mk5WZ2piajhBazdVWDh5dHFIWlJH?=
 =?utf-8?B?cm40YStBY2NZODlrYkJGS0NWSHNYZzRvSHcrSjYvRzREQjYwSFdQb2ppa3RL?=
 =?utf-8?B?MFphZXNHMUFCMkRQc3dkOEhLNUc0ZllOR05CUHVJMW8rRHdTZ2h6c3BGN1ZG?=
 =?utf-8?B?NFBnd1RxcWVudGhkd0NidVlzN0pacXFBM1E2N2dNU3h1TGFnai9EQjZZc3BE?=
 =?utf-8?B?MWgwKzFtT2xTbUpEZFlKQzJLY3Baa2FiRkNLVHVxbCtZM2dBODdxUEZ3UHFw?=
 =?utf-8?B?VWlVa2I4RnpWVDA2bnJHSU5SOW5KMlh5V3l4ZTRIdWpZaDd2TVJNdGxnRjJL?=
 =?utf-8?B?RWp2aE1QSWR3K2czalBidjZyemFNM1RaRHVsdU5ENmw1ZUdrUi9VRzlkbGFD?=
 =?utf-8?B?MWd3N2NlRGk4L1pzcGp1Mkp2Q3VTVzRhUnZJc2lYaTFhTzlDT1Z0ZGUrR1oz?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E0BDC81E5876E4D9E3B9D0E36BA5BBA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb07c22-e8fe-45d7-b141-08dbef700e6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 17:41:16.0329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ayFTDRuM3SDiSQikXemKcKt3ibQP0qCGzGi/lmMU0zOdxeqyB7ttpNVenCOW8YG9qh9P7c1hx6jTW/zYCn67lAm+D0rhx3iKasW3tRXRjnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8679
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTExLTIyIGF0IDE2OjE5IC0wODAwLCBEZWVwYWsgR3VwdGEgd3JvdGU6DQo+
IEkgZG9uJ3Qgd2FudCB0byBkaXZlcnQgZm9jdXMgZnJvbSBwYXRjaCBzcGVjaWZpYyBjb21tZW50
cyBvbiBzaGFkb3cNCj4gc3RhY2sgcGF0Y2hlcyB0aGF0J3JlIGJlaW5nDQo+IGRpc2N1c3NlZCBp
biB0aGUgbWFpbGluZyBsaXN0LiBBbmQgdGhhdCdzIHN0YXJ0aW5nIHRoaXMgc2VwYXJhdGUNCj4g
dGhyZWFkIGFib3V0IGVuYWJsaW5nIHRoZSBzaGFkb3cNCj4gc3RhY2sgaW4gdGhlIGR5bmFtaWMg
bG9hZGVyIHYvcyBrZXJuZWwuIEkndmUgcHV0IHJlbGV2YW50IGZvbGtzIGluDQo+ICJUbyIgYW5k
ICJrZXJuZWwiIGFuZCAibGliYyIgaW4gQ0MuDQoNClRoYW5rcy4gQXMgd2UgbG9vayBhdCBhZGRp
bmcgc29tZSBmaW5hbCBnbGliYyBzdXBwb3J0LCBJJ3ZlIHdvbmRlcmVkIGlmDQp0aGVyZSBtaWdo
dCBiZSBlbm91Z2ggdG9waWNzIHRvIHdhcnJhbnQgYW4gb2NjYXNpb25hbCBtZWV0aW5nIHRvDQpk
aXNjdXNzIHN0dWZmIGxpa2UgdGhpcy4gSSdkIGFsc28gbGlrZSB0byBkaXNjdXNzIHRoZSBzaGFk
b3cgc3RhY2sgbGlmZQ0KY3ljbGUgaXNzdWVzICh1bmNvbnRleHQsIGV0YyksIGFsdCBzaGFkb3cg
c3RhY2tzIGFuZCBhbGwgb2YgdGhlDQpjb21wYXRpYmlsaXR5IGxhc3QgbWlsZSBwcm9ibGVtcy4g
VG93YXJkcyB0aGUgZ29hbCBvZiBhdm9pZGluZw0KdW5uZWNlc3NhcnkgZGl2ZXJnZW5jZSBvbiBh
cHAgZGV2ZWxvcGVyIGV4cGVjdGF0aW9ucy4NCg0KPiBUaGlzIGhhcyBtYW55IGFkdmFudGFnZXMN
Cj4gLSBkeW5hbWljIGxvYWRlcnMgKGFuZCBzdGF0aWMgYmluYXJ5KSBhcmUgcHJvdGVjdGVkIGZy
b20gbG9hZGVyDQo+IHNwZWNpZmljIFJPUCBhdHRhY2sgaW4gYSBzbWFsbCB3aW5kb3cNCg0KTG9h
ZGVycyBjYW4gY2FsbCB0aGUgcHJjdGwoKSBhcyB0aGUgZmlyc3Qgc3RlcCwgc28gdGhlIGxvYWRl
ciBpcw0KcHJvdGVjdGVkLiBUaGUgeDg2IGdsaWJjIHBhdGNoZXMgZGlkIHRoaXMgYXQgb25lIHBv
aW50LiBTbyB0aGUgcHJjdGwNCnN1cHBvcnRzIGVuYWJsaW5nIGF0IHByZXR0eSBjbG9zZSB0byBl
aXRoZXIgcG9pbnQsICJleGVjIHRpbWUiIG9yIGxhdGVyDQppbiB0aGUgbG9hZGVyIHByb2Nlc3Mu
IEVuYWJsaW5nIGJlZm9yZSB0aGUgZmlyc3QgQ0FMTCAob3IgdW53b3VuZCB0bw0KdGhhdCBwb2lu
dCkgbGVhdmVzIHRoZSBzaGFkb3cgc3RhY2sncyBiYWxhbmNlZC4NCg0KSSB0aGluayB0aGUgbWFp
biBkaXNhZHZhbnRhZ2UgYXJlOg0KIC0gKk1heWJlKiBpdCByZXF1aXJlcyBkdXBsaWNhdGlvbiBm
b3IgdGhlIHNlY2NvbXAgdXNlIGNhc2UNCiAtIFJlcXVpcmVzIG1hcHBpbmcsIHRoZW4gdW5tYXBw
aW5nIHNoYWRvdyBzdGFjayBmb3IgY2FzZXMgb2YNCmluY29tcGF0aWJsZSBEU08gb3IgZGlzYWJs
ZSB2aWEgVFVOQUJMRQ0KDQpJdCBpcyBwcm9iYWJseSB3b3J0aCBub3RpbmcsIHRoZSBvbGQgZWxm
IGJpdCBiYXNlZCBlbmFibGluZyB3b3VsZA0KZW5hYmxlIHNoYWRvdyBzdGFjayBpZiB0aGUgKmxv
YWRlciogRFNPIGhhZCB0aGUgZWxmIGJpdCBzZXQuIFRoZW4gdGhlDQpsb2FkZXIgd291bGQgY2hl
Y2sgdGhlIGVsZiBiaXQgb2YgdGhlIGV4ZWNpbmcgYmluYXJ5LCBhbmQgZGlzYWJsZQ0Kc2hhZG93
IHN0YWNrIGlmIG5vdCBzdXBwb3J0ZWQuIFRoaXMgbWVhbnMgd2l0aCBzaGFkb3cgc3RhY2sgZW5h
YmxlZA0Ka2VybmVsIGFuZCBnbGliYywgYWxsIGxlZ2FjeSBhcHBzIHdvdWxkIGJlIHN1YmplY3Rl
ZCB0byBhIG1hcCBhbmQgdW5tYXANCm9mIHRoZSBzaGFkb3cgc3RhY2suIEl0IHByb2JhYmx5IGlz
bid0IHRoZSBiaWdnZXN0IGRlYWwsIGJ1dCBpdCdzIG5pY2UNCnRvIGF2b2lkLg0K
