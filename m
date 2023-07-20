Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3476675A881
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjGTIBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjGTIAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:00:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E5E269E;
        Thu, 20 Jul 2023 01:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689840049; x=1721376049;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eJm8zdkgAXTxhAUxFG3eAre6ihcKT0rWpqS/BqiFz6s=;
  b=CBhDIn/AZrTzoXPzzi3o3jgOnwx+YWGLn0xa5kKlb8yWSl8B3IhK9+Pt
   x/ZNasWuEP9zx9kAZEueEkCdYy28cVnmv03tIn3hFF3VG/jAr5VFv+OHt
   jy5d941jiLfEZBT4lhLsbOM0FLlRhe7Abq1GZU5Yq3XCDa8RkRIGZBb9t
   CDr/hXhoWgaBnqm1VNFqA8EmkATbXmugQjNyABt1xauU3cEq3jwIGhDdg
   0tGL0zfFrcSXIlE/r7BGH1R3U4jyK2zvIB08Mod2lNCQWui0FXghlTydw
   yTWAR8mBmiIephXkQNBckEGIQ/7GuEEzh+xSoeT+zgzo0Xy74rqvX66xP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="430434045"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="430434045"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 01:00:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="789696196"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="789696196"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jul 2023 01:00:47 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 01:00:46 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 01:00:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 01:00:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 01:00:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfoFrB4h8xh+ohK6QgHf5hvRYzi3r0/FjIU69/Pd7QSiw6MFK15bknpw2VTQhDtNF7X+tFLuIDGS/vbzakIwGdIdABKogucDUVpNkTep+N//ZWKfR+/+QjKhcOrWDwSJqv9umc8nPvlbu55HV8odtkkSs/45jode2ik9G5LCniFPBaRDwxuK84os/i9jRgZT1TmWr6yGri+aPYlZpaCRrOcSAYXpQM6AVRnjyqtLL1diIX8SnMUSZsAa4aeKDTVt1dgVyRba8SXV1hNyqFgQlGvBX8m1l/1MumWT0m3vONl+QE8H2goODvTmAHo5+Bb7spdPQm4jg4FOEp7ICa/gHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJm8zdkgAXTxhAUxFG3eAre6ihcKT0rWpqS/BqiFz6s=;
 b=oFYg/FUGQYVdmuDMEyOaIAHqiRQye3g5TnYsKuCIxd0hlLQv38g90Y4mBmTqJZTvz9APeGyk018c46glGwI0NLDQO1zfkBKi1TBkYixD5NDD75IomKeo8UTucars9tCNzYsaIEJlGkGSnSr24s9fIcbNYL7U3JpIOr/anJAAOrSgpqQ7i+oboKB2FSL35ky4s1D369kjpMvL+iRebZu58HvLWkSchwLxkzB/7Vt+aCfxcXUAg4C0CdGMd88ifL3+/7X+SMmxnuDuKulnjJczuBaqWJhCFU06mMWl2qtemJOpHvOqBPANAvlkDbOCajfmND/cVot34O9bCJseqDqvPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5823.namprd11.prod.outlook.com (2603:10b6:303:186::12)
 by DM4PR11MB5501.namprd11.prod.outlook.com (2603:10b6:5:388::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Thu, 20 Jul
 2023 08:00:37 +0000
Received: from MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::2f24:2dc9:60b:a244]) by MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::2f24:2dc9:60b:a244%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 08:00:37 +0000
From:   "Winiarska, Iwona" <iwona.winiarska@intel.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "avifishman70@gmail.com" <avifishman70@gmail.com>,
        "Fair, Benjamin" <benjaminfair@google.com>,
        "tmaimon77@gmail.com" <tmaimon77@gmail.com>,
        "yuenn@google.com" <yuenn@google.com>,
        "venture@google.com" <venture@google.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 0/4] Add support for PECI Nuvoton
Thread-Topic: [PATCH 0/4] Add support for PECI Nuvoton
Thread-Index: AQHZuo24Hm9PV44gH0SjPkNEG1z6cq/CLrMAgAAcuQA=
Date:   Thu, 20 Jul 2023 08:00:37 +0000
Message-ID: <9a400a1be13adb87002ae476839e235aea117060.camel@intel.com>
References: <20230719220853.1029316-1-iwona.winiarska@intel.com>
         <b0993a11-6589-2fcd-3487-2e6eb68e18e4@linaro.org>
In-Reply-To: <b0993a11-6589-2fcd-3487-2e6eb68e18e4@linaro.org>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5823:EE_|DM4PR11MB5501:EE_
x-ms-office365-filtering-correlation-id: 50e4ee11-c6fe-451c-0ee4-08db88f76778
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xIQyeA2kUjPunTKZ45Io+F1CYXLRYi+/8j9PDqSQ2SADBZGrn6CQfo+EGpX9XLnqQ0Z3KumaUbloFi8oJd2DVvuqF8lppK/+dAA5ym9J6/JaXyVMPlErjmauzVA6RCMI/eXCTHjJWx9wVybbB07vAODMw3e+/ckBl2zxaLHBVY2+zK62z/nXgryB8ZlOMOZlrWcFFiuWHOKT08ISpp/lQWdUanRs4ZxB3HfF61+8ZnH3OP6erUcoK3/1hrOIHgmpFswpV8RI27xfqc5LNktYUn9YBQkOD0k8QgcEXBp5p3ronmZzkKflgO43g9lUE/3xP6j1okggjML0HEsDIRg5q0QjrKkxwwNm9pR26nyi9ElWumCQ+mfwJ+HOKXPTqcDvtqeSyL/bVXr5W4L52hLVFfelRBGttds3APIMNrzOBtu3UrJM4y1wnt69Nuh1Kh+aTDaqKpjlh/+mMWxl+qtYxMqlX0eRc2+kYuB5hXf8kQUnWrzVD6ILVor5O+wNzdEeGdf6gtaI++0U3cjhkEFtqFM3KX54IDIcaCmmk3eyEt0XHEfYgcrjTOV0DaRxb/9+oSKexbiIPneaePU5pHGYZ+EXH4SnRpkO7a45q21TiQk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5823.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199021)(82960400001)(478600001)(53546011)(26005)(6506007)(6512007)(966005)(6486002)(71200400001)(8676002)(8936002)(38070700005)(7416002)(5660300002)(2616005)(4326008)(41300700001)(316002)(86362001)(4744005)(2906002)(186003)(38100700002)(122000001)(36756003)(54906003)(66946007)(66476007)(64756008)(66446008)(91956017)(66556008)(76116006)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0Q2YS93azRNTC9MME9jOHgvbm5vRDRrTFZkMTVqdHdaRXZBNC82dEI2ZEtw?=
 =?utf-8?B?Nkt2SHpOam5ib1N0d1pHdzFKeHNZQ1d6cGFub1pJQXdQaFdKYlI2U2JSZ1Ny?=
 =?utf-8?B?UFhsZElRQjM5ZW5vK1oreHR6TG41L3hSbllBcDBzMWYycHpubldXWWcwaDRu?=
 =?utf-8?B?MXlFajQzM29wNFRmK25EdUVNTkh1K05FenhJejRqTnpjZ1dscnRIemtodllV?=
 =?utf-8?B?bmNvOVFENVIwYUx2OTZZUHpMN1lzNTY4ZWx6dHV4MzdTOTAvNXRHWVVUUEdD?=
 =?utf-8?B?T1AwN2FvNm56T3M2N1lPd1RoQThGQk5SWVJUS2dGRHB4QlBsR0lmYlhzMmVV?=
 =?utf-8?B?QWNDSkpvNUkrZGVOMTBjZm1BeVlWWk5XeXk5RnNiL2pvc29FM0dSVFJ4RzBF?=
 =?utf-8?B?OW1VV2Z2TlcraG1vQVppNkQwQ1RxTGc3UjNRdm5LT0RXaFYwUFcyWkd4UkRY?=
 =?utf-8?B?UW40c2dnMXdrSUxiYUU5Sm1nK3p5ZWFYeVdQbU9DbXZSRkhpcnllOTNqcXcr?=
 =?utf-8?B?R0FYaFdGZ3BOcWhkMVNmSXFSeUxKcFBSdFpXMGQycE1rSklUQzhncHVKM0Rl?=
 =?utf-8?B?YkMzd0dtaFZuYWhicVpzV0c3YlhKNXB2Mjdqa0NBSTUxTmNLVGZ5OEMwZnVG?=
 =?utf-8?B?VjhxNGdldkxoWG02UUtVQ1RrRmpKV2szbDUyYlJ0Ym5HajEwWEpEdllUUERU?=
 =?utf-8?B?SFI4MUNua294QWNDaktiZ2k4eDVvUU1FNWRFM1pKcXdrb2hUTkV3K0k2VUUv?=
 =?utf-8?B?YjZwYTIrZndodlpsQ1Jzenl1U25PN0E2Z1ovQVh2SkpuSnA0TWdOK2xYZ2F2?=
 =?utf-8?B?TGNHcU1IVERnVVNyS3Fpdi9lNnQvaTE5akN2VCt0TVNwNGc5MFFLNzlyN0Ft?=
 =?utf-8?B?dFZIZloyTUh4eE5RTDdod3AwblF2YU5GRjVkUnJaOGc2TkkvKzRKMXBteElr?=
 =?utf-8?B?QlQ0TExQa01QcDRIQ09WU2YzK0FMMEsrZE5OdmtpT21xZW1lUFZldVFZQU1Y?=
 =?utf-8?B?R3NTdU1mUFRxcVN1YnM5VnpOU3FKQ3lxY3lpWVhEUjJlS3FEM1NsbXdNMWhv?=
 =?utf-8?B?R0JiRzd2RWtiOGc0eWV4a2N0RnVyNXhUU1RySlVCdU9rajhoUFN6SklRaWlT?=
 =?utf-8?B?MGIzQ3VDN0JJMEo3RTBrTzhIQXdveDk0MXBLSnl4QkJXN1ZXYVU2N0RSUk1v?=
 =?utf-8?B?bm9qaEJidGdYSDFNaldGQ3F5c2JkdExLZSt1NDI5dDArNS9PdUltTFVuTVdi?=
 =?utf-8?B?RWoxR05XYXJXdmRtWHJiQitWREFUTC9pOG9EL1BvUnBQWDFMZVQ4MTkrSXk2?=
 =?utf-8?B?R3Z0S3k0OG5HUlovVFkyN3NINXA4ZUpkM0pTZTBVTTZwQ3NpTnl4TFhzcjEx?=
 =?utf-8?B?YUZPSW1yR21TSzJWUjJ5RW1PS3RIOE9NeVJHajJGN1VnYmI0eGhLckZyUlhl?=
 =?utf-8?B?S2JsTFc0TmxzU1NCTldsUFMvWkFtR1cyd1FYUndKWW0xMXRyeVV4czgweDRU?=
 =?utf-8?B?TFJGK0U4MUN3UEpObzdyVlZiZUtRLy9WU0taRlV5OFpPNUNvN2J2ZmpOM0lR?=
 =?utf-8?B?MlJJanErT2svQnRFOW5IeTBHQ3E0ZnVPbXJvMU04UmNGUkhERzJMUmpudVBB?=
 =?utf-8?B?bkd3eDZkR2p5L1dyQUpSZmlaeGpjNmFpcm11aHNmVmZsTko4MlRGMkNScXVE?=
 =?utf-8?B?QU8xK0JCNE9Ya1dsSERzNmFZb2o3YTE0dUhRdFZ3Y1JhbWtHbVJTK3ozTnNQ?=
 =?utf-8?B?MDFubjJMZlhSVDl4Vm0rWE52UjZiZFVOMUsvNTZUTXVjWEZSM3NkLyt3N29P?=
 =?utf-8?B?MytJU0oxSm9BQTZnazNaVGUvUUZVUkpJMXg2eWNETE5rdmdvbUxpa1NoSEpp?=
 =?utf-8?B?THlweFBJV1lmVEVhYk9hR25LZjZob0FKTGdJSUhRMk9aOC9aSmZLVFpvNEFB?=
 =?utf-8?B?OTRpeS9xZU5abVB1dENLWVYyTE11WjRBaWJwajhMV2VhNkZWOHUwUFhCRGt3?=
 =?utf-8?B?V3dpTU5jU1FsYUNBT3NYYXM3UVExSU0vMjFKeWtEZUp3ZUU1TFVNNmZTaStX?=
 =?utf-8?B?VUtZWkFONmFWNWVvVUZpblBBZm94YXFoOThKVklqZEtCZjl4WXBzZC9zbzN1?=
 =?utf-8?B?M1oyU0RPa25VOG84bW40RVFXRjU3eDh6SmJZeFJMR1AxZFpreVV6SEhCSTl5?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C70C6D968CBE5B4DAE52D68698C6A90B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5823.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e4ee11-c6fe-451c-0ee4-08db88f76778
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 08:00:37.6678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u8GuMFh+vKTpHuKFHTLU2sROYGZTrp3AKHJSoAgtqpuVEUuhU5T7OGtHri7v1Jz1XV4xl8bfOJ1vCMpeyi7eCS1HBv+qIh97xOdahyvvuDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5501
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA3LTIwIGF0IDA4OjE3ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAyMC8wNy8yMDIzIDAwOjA4LCBJd29uYSBXaW5pYXJza2Egd3JvdGU6DQo+ID4g
SGkhDQo+ID4gDQo+ID4gVGhlIHNlcmllcyBhZGRzIHN1cHBvcnQgZm9yIFBFQ0kgb24gTnV2b3Rv
bi1iYXNlZCBCTUMgYm9hcmRzLg0KPiA+IEl0IGlzIGJhc2VkIG9uIHBhdGNoZXMgdGhhdCB3ZXJl
IHNlbnQgYnkgVG9tZXIgTWFpbW9uIGZyb20NCj4gPiBOdXZvdG9uIFsxXS4NCj4gPiBTaW1pbGFy
IHRvIEFzcGVlZCBkcml2ZXIsIHVudXNlZCAoYXMgaW4sIGRlZmF1bHQgdmFsdWVzIHdlcmUgdXNl
ZCBpbg0KPiA+IGFsbCBvZiB0aGUgYXZhaWxhYmxlIERUUyBmaWxlcykgdmVuZG9yLXNwZWNpZmlj
IHByb3BlcnRpZXMgd2VyZQ0KPiA+IHJlbW92ZWQuDQo+ID4gSWYgdGhlcmUgaXMgYSB1c2UtY2Fz
ZSBmb3Igc3VjaCBwcm9wZXJ0aWVzLCB0aGV5IGNhbiBiZSBhZGRlZCBpbg0KPiA+IGEgc2VwYXJh
dGUgc2VyaWVzLg0KPiA+IA0KPiA+IFRoYW5rIHlvdSBUb21lciBmb3IgdGVzdGluZyB0aGlzIHNl
cmllcyBvbiBOdXZvdG9uIGhhcmR3YXJlLg0KPiA+IA0KPiA+IFRoYW5rcw0KPiA+IC1Jd29uYQ0K
PiA+IA0KPiA+IFsxXQ0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29wZW5ibWMvQ0FQNlpx
MWpuYlE4azlWRXlmOVdnVnE1RFJyRXpmNVY2a2FZUDMwUzdnOUJWOWpLdGFRQG1haWwuZ21haWwu
Y29tLw0KPiA+IA0KPiANCj4gVGhpcyBpcyBub3QgdjEgYnV0IHYzIG9yIHY0LiBQbGVhc2UgcHJv
dmlkZSBwcm9wZXIgY2hhbmdlbG9nIGFuZCB2ZXJzaW9uaW5nLg0KDQpUaGlzIGlzIHRoZSBmaXJz
dCBzdWJtaXNzaW9uIC0gYWxzbyBrbm93biBhcyB2MSA6KQ0KQ291bGQgeW91IGVsYWJvcmF0ZSBv
biB3aHkgZG8geW91IGJlbGlldmUgdGhhdCB0aGlzIGlzIHYzIG9yIHY0Pw0KDQotSXdvbmENCg0K
PiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCg==
