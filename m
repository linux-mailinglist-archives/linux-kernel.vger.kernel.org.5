Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D387D80AED3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574785AbjLHVZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHVZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:25:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA78A9;
        Fri,  8 Dec 2023 13:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702070760; x=1733606760;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=twwZhhTkpzAYa5RjxKkZ57V0MKHQ6eH1Q9W+kt6+oYs=;
  b=hIOsdCn9N0YQS7Kryk8Ghr1r5SrgJWa+PAzvFFwC5jh39oGOI2/qkQwr
   tujxpOSI/9lzmJrcnXbVxC/5mgRH5tpEkKKlOkCCt55/7/Me9dtj5N/qF
   cUwnMptHazYBMlbiN5WQxGcrugBHnFIhUg99zH0vW4tMWccoC3P7F9Uh1
   R72loJTKxas7ffJv4+MLRJat/HobRBnyuj5zJef6o86Cz4pOfWjjeSuHX
   M1e8VyWigOhpPFnePl4OUjBD83IgvpSQGaLHucrR1H0+UZBbYOpOdzorK
   baC926+N3iqm54IR09fwzYHCZLdXR1KksdP0iokZiNAx/F3zI1MFmOZPf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="393332795"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="393332795"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 13:25:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="806530492"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="806530492"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2023 13:25:59 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 13:25:58 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 13:25:58 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Dec 2023 13:25:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMv1K8Z24OaL6F6GLQ7ZMbpoGsCKDWjyICI+4ewmvg3VbKcSXS9igPnLoTvviYjT/fMxisCowOWvAdODoQZI1SL1zsnHntiKFchtnCRdz6XwHQnxgXCYMpLzo5nGKnjlmd9cGEkYgxMNxEUTNbNuZrKJRCEiaOcUUgzQ/iCBUiexRJ7i4dt0KloE6PCl6cP9YnSsQdMoa8DH/R6W5kQQILdZWpOnY+bvSi+1zixlxdKsidtZsNr1LFMCTwy1VTSyVHN2tt6iAicf9ptDR7mWDBDomqfZvueZeVANdwdZXa5LffA/TmA9jEr4jUs6IF6VfBK1SFid+0v2vhGqmjlTiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twwZhhTkpzAYa5RjxKkZ57V0MKHQ6eH1Q9W+kt6+oYs=;
 b=nhYULOofepws0NlQ8DHzFTgtkey+DiQRgKh4jbzrzKchK7fQ/u5WaCc67HgDc31GTw6x574X9kfyRR0w/pvss5YnuuX+bObvMAUcwXPLoJ1LNqCnYjokxe51bTnV2+0tuKvIVuk/i72BAkZLYy5MOwQtalVVxTGGVkdfLVU/r7aC4KP4zQwiROE7wpNcGPdjRCn5AAgP9PVEq0GVxZ9+nzmDToLAWjioyv5UJwrJOI1h/rGAo3CJpd65IG5sFJqCzof/N9PP38wl1/sfvXVh1ipOZwC70TLE4f7yQ7pthbSEkxkm7VWpHILugY0clBSDsL1Lig46GCbWrRFlB4Btxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by SA1PR11MB6894.namprd11.prod.outlook.com (2603:10b6:806:2b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 21:25:56 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694%7]) with mapi id 15.20.7025.022; Fri, 8 Dec 2023
 21:25:56 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     "david@redhat.com" <david@redhat.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v2 2/2] dax: add a sysfs knob to control memmap_on_memory
 behavior
Thread-Topic: [PATCH v2 2/2] dax: add a sysfs knob to control memmap_on_memory
 behavior
Thread-Index: AQHaKMbu7P34L+weQECt+BHOvhNpUbCeuCMXgAEwkIA=
Date:   Fri, 8 Dec 2023 21:25:56 +0000
Message-ID: <1892d70bda0967284c1e94370a03c7c67e00533d.camel@intel.com>
References: <20231206-vv-dax_abi-v2-0-f4f4f2336d08@intel.com>
         <20231206-vv-dax_abi-v2-2-f4f4f2336d08@intel.com>
         <8734wd1j4z.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <8734wd1j4z.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|SA1PR11MB6894:EE_
x-ms-office365-filtering-correlation-id: 787f1d62-139a-4d7f-2579-08dbf8344414
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xu+tYrWDDE/mp/Sj9667fEe7dx5YPE4dAglEM4vk49/z6fjZyv9MwJqQGSlgsfi9fkNkrUvxeQW9LP3CrkIATHjqoVmYzUXBRzb0GFP5DQX59iEVpHqfRGVt9PWe3Zsx16WfgkvOeQjj4Pow9ou5W3fsqUDdVwKrQ6rPTa4sLHnBqtqBlujBc9FOD7BzQGg2HAm475lnYm84T30BaX96Xnowz9ajfdCT+NdtU4xTFkVnMT9B4cfwH5815bORiUjZhm3NNq8fGFBVoyOjVKkriQ4Dkj34HDC3iVQPx9GwhnmH/E+at/112l0I4BVrI8gyuH4/K7ri1vls7nGo7KjWIEeL+A6+zfz9hFImjRN3KF94wZp5gfTfGG+4QXlSTJFmXpGuZCSLn59rAY+ZfSl3XBT0w/VMMl7xSz9KMtIk2r00tXYxuazkxbEZsYMSI9eHfK0CiDVewxPwIowrsC0EnoqbTwhKLR39H5jnbg55UD4FuCYV8Ns9/b5tuVEilsOYPGqWE5p3t/ojjkaqzeUhTwivyhi6l7atqh9KoqFzLVqgK7jwiny9KLbsrk5ELcTwtU87AyV7e2FRum1u3jHZn7/rjYUg5SgS2rhSl7wTIa4++bFWDOx8ykJ+rpbeY2hD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(66476007)(66946007)(66556008)(316002)(6636002)(66446008)(37006003)(64756008)(54906003)(76116006)(122000001)(38100700002)(36756003)(2906002)(4744005)(86362001)(41300700001)(4326008)(5660300002)(38070700009)(6862004)(82960400001)(8676002)(8936002)(83380400001)(26005)(6506007)(71200400001)(2616005)(478600001)(6512007)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjZoZDcyM2VvaVNOZitib2dVVEVIMkErZ0oxeGFZU1dmVlN6RmVTdk5VeENq?=
 =?utf-8?B?eDhhUW01bnRSVEg0SFZHcy9HYWM0cVp1ditYSDNlRzlaWVpCdEc5eHJ3MVpR?=
 =?utf-8?B?TmliaHF0OEovaTRTRXNFbEtmM1hteE8yZituRGFjbGNJaW9VdmVEdElnTUZC?=
 =?utf-8?B?ekcyWS9kUTd4UFhIOHN5RVpWSFZjcEFNdDRVblBIQ3E4UUpKRUhmb2ppK1NI?=
 =?utf-8?B?a1R2TXJDUDVXTTMxSGJhUW9SL0VQTG90S0ZsakFEdDVMYTY4Y3kxRmd5OURI?=
 =?utf-8?B?aTF5aHpoTThQNGRxcW9SY0xOQ2VvcjlpTTJiaDVxYVd2U29ZTnAySCtsVlB5?=
 =?utf-8?B?Mk1zUE1PQ3UwQitjS2RDeWdjazZtd1AxREVsRitTMWM4RVo0b2FOalFKVmNP?=
 =?utf-8?B?NjVweFZkTVFub0s3OTlGZ3dKaVVoTi8vQzU5S1hTd2dwTVBVRUUwYkwxZ0Vo?=
 =?utf-8?B?WnoySklDd2h4Zis0bDcyNnpFVFdreHRtOTc3cjMybDh0czlWRG9TR1hIYldi?=
 =?utf-8?B?RDBtU1dCUThRU2ZSQ0ttTjJFVUhmWWl1SFVwUURYWVB3bVo0QmlZbnk5N2JX?=
 =?utf-8?B?UzhaYzMyTkNFY2M5MmFnUm5mS01Bck1oSG0wSEx3RmJuaXN1aDFVaFc4YVBp?=
 =?utf-8?B?dkIrRUVGejNhMlpROTEyeG5vVG14RmZVaXdvNWs2UjZ1V1VzUVdicDlpSlA2?=
 =?utf-8?B?aUNWeUd4dlJia3l3Z2pMMTV3WmR3Y2w2bXMvMTJCcFpIUUNZVVo0aHpzaStY?=
 =?utf-8?B?VHdnMU9DSFJDemU1V083ZkZaU0tDYnVwdlp0VXdya3VKdTBPVy9JQWdjY2hi?=
 =?utf-8?B?ZUF1NXlrTWdZZmwrNEFrK0lLMHpyT3VhYVlVZmg3L1dTZkg0UmNVclkwVEhm?=
 =?utf-8?B?cEoxTzNVTStxUVUzT0Mrejc1QmhKOU0xTVNUTk9BTmZWU3AzTURmM0ZJcUQ1?=
 =?utf-8?B?Rmlrc29ZR3J0cXJ3ZTZBT1FpNzF6U2VqT2hFMDZVZittQTFNaFQxQWpUTGhN?=
 =?utf-8?B?QithRGg0bmdEK2NCTUdGM1pSY2V6UGc5aU9GSWVEdjZ4WW1QYk1xbS9KUlEr?=
 =?utf-8?B?ZTJJc1prZ2QzZ1FPRlYrTCtoZ3BMZkRpR2hucHpUeGtOOS9nbU0xZC9tT1lO?=
 =?utf-8?B?WDNTMzhodkh4YVBzbGViNTBZZkU2ck5KTDR3V3VLVkRCSnE5K1FoZGlvS3ht?=
 =?utf-8?B?T2hJNUhxK0pMYVVTTTl3MTVKbXpEQ2Q0Y1dTeFpkREt5aUNQZS9UNElZY0dz?=
 =?utf-8?B?Z0Q2RlZkbG9XVVFVSEV1eFRRaTlZemtpRytaZWZVK201bXBycXhtNlRlZTBm?=
 =?utf-8?B?WG40WGRmUVE0TVUwa2xFS1dDZVVSSzVUNUd3aVdGQzF6Z0R5Vi9ESEFoK2la?=
 =?utf-8?B?TTY0THllRWdYa3lYa0t0Wks4V3NZa1hwbjRDcmoxamtYbzZyNnlsUmgxSlJV?=
 =?utf-8?B?Z1lXUUo5ZFBndVpZaWRjdDM0ZkxaVFV3VUpINkVWYVczYWQ0VktHeHZEaG1S?=
 =?utf-8?B?OFNyUXB0eVA4empzUHcxTEZIc2s2OGNzR1dkUGlsd1d1RGFwRkloZTI3N002?=
 =?utf-8?B?M2ZYRGpmUHF4RSt6NzBkNmVQT2hQaUtMZHpTZUhHTzlMSUl1a1hndDBiRmZx?=
 =?utf-8?B?L2FhWE5RUVNoZnBLOEdhOUYvWW1xdG94OE94a3RpNjVBamh1aUpSVWcyYXhx?=
 =?utf-8?B?a0VYOWhTNk5VTkhrb2crUExDVy9OdUVsVzFaeDlFYWdXcmlnVUp1ZFJhVzl6?=
 =?utf-8?B?OVJaeFl6QmRLdGtFRElaVnh6cFZ6YXhvTVUweERPUWs2NlBlMFB4dFpPUG9w?=
 =?utf-8?B?NjNOMU5YNFJib25FdkMrZVpLNy8vdUNlYnJtUkEvdVhKa0p0bjg2UkVTZlZG?=
 =?utf-8?B?TS80b2dEZTFBZ3dRTlREeGxSdktpTDlSSENhVXh1NEhmWVhxRGdRakFJeHQw?=
 =?utf-8?B?Z2ZTOHR5ZldMbGNvcFpCb1FEN21XdExwQVprNzZJb205YmFjOW5mdi9ldVly?=
 =?utf-8?B?ZlVzdEVlN0NMZUNmeUlLTXI3aFJieFQ5Si9Oazc2UURramQ3UnMwbGE2a1Ay?=
 =?utf-8?B?aWVCa2h0VjBnYkE2M0ZHWTFSYTcwMlMzcExSTnBEL3BqTzY2WkJZdEMrNXJY?=
 =?utf-8?B?NHVqcVZYOUVZL2RHQ3o2YWV4SDRXcTlzZVNKNDR3czJXWGtSMHI5cEZCTHBQ?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2277841CE77DB648A1708924268865AC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787f1d62-139a-4d7f-2579-08dbf8344414
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 21:25:56.6630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWI1fT6eLe4yoIl3pK1t1GHE9I8aGiZAh4s13AKxVHRAiwFY+XSdRpId1euCXGYKsJy9LuOqS4FfX9MNhZvxiLX8dUi+CIZv18SaKJuxPeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6894
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

T24gRnJpLCAyMDIzLTEyLTA4IGF0IDExOjEzICswODAwLCBIdWFuZywgWWluZyB3cm90ZToKPiBW
aXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4gd3JpdGVzOgo+IApbLi5dCj4g
PiAKPiA+ICsKPiA+ICtzdGF0aWMgc3NpemVfdCBtZW1tYXBfb25fbWVtb3J5X3N0b3JlKHN0cnVj
dCBkZXZpY2UgKmRldiwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRldmljZV9hdHRyaWJ1
dGUgKmF0dHIsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGxl
bikKPiA+ICt7Cj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgZGV2X2RheCAqZGV2X2RheCA9IHRv
X2Rldl9kYXgoZGV2KTsKPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBkYXhfcmVnaW9uICpkYXhf
cmVnaW9uID0gZGV2X2RheC0+cmVnaW9uOwo+ID4gK8KgwqDCoMKgwqDCoMKgc3NpemVfdCByYzsK
PiA+ICvCoMKgwqDCoMKgwqDCoGJvb2wgdmFsOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgcmMg
PSBrc3RydG9ib29sKGJ1ZiwgJnZhbCk7Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAocmMpCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJjOwo+ID4gKwo+ID4gK8KgwqDC
oMKgwqDCoMKgaWYgKGRldl9kYXgtPm1lbW1hcF9vbl9tZW1vcnkgPT0gdmFsKQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBsZW47Cj4gPiArCj4gPiArwqDCoMKgwqDC
oMKgwqBkZXZpY2VfbG9jayhkYXhfcmVnaW9uLT5kZXYpOwo+ID4gK8KgwqDCoMKgwqDCoMKgaWYg
KCFkYXhfcmVnaW9uLT5kZXYtPmRyaXZlcikgewo+IAo+IFRoaXMgc3RpbGwgZG9lc24ndCBsb29r
IHJpZ2h0LsKgIENhbiB3ZSBjaGVjayB3aGV0aGVyIHRoZSBjdXJyZW50IGRyaXZlcgo+IGlzIGtt
ZW0/wqAgQW5kIG9ubHkgYWxsb3cgY2hhbmdlIGlmIGl0J3Mgbm90IGttZW0/CgpBaCB5ZXMgSSBs
b3N0IHRyYWNrIG9mIHRoaXMgdG9kbyBiZXR3ZWVuIHJldmlzaW9ucyB3aGVuIEkgc3BsaXQgdGhp
cwpvdXQuIExldCBtZSBmaXggdGhhdCBmb3IgdGhlIG5leHQgcmV2aXNpb24uCgo=
