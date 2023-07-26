Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5693B762FF4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjGZIgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjGZIfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:35:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B66A245
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690359878; x=1721895878;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8LVSj+UaL+bii+iABC4aeVrlEAXBLGNzhEYO2g83iUc=;
  b=RcEKajasiNlNx4b3dcq9K+d5a36WFpuv8OLburr4zTf45nbegqQyfYR2
   gj4YvdIiU1GcsHlOlXo0Zh4m4fC4oVHxUAVhoUalaVd3QTOxDOIFZLXgZ
   idzTOoxiEY5vHxinFfw8M5krCZpSukcSrkn6DHx6eq1SiOUar86dQv6bB
   mLYtSlzW9fQlIVW1KqVdKyBb1lOREegM9CsupY60ABo4fD38iP27R3TRU
   isilVgmsLI13WllP1vQib8epbdkrq/quwb9s3HNsoIGrb7Z9I3LGiuR2/
   j0jB/dMOYVV7KHTlQKUIF0V/AS3FE5wi8W7Sx8ZymrAV8tHT1EtEHRtms
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="347566386"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="347566386"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 01:24:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="676584479"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="676584479"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 26 Jul 2023 01:24:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 01:24:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 01:24:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 01:24:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 01:24:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoQEZSfao+6mayPR0HzIcZUUWV9BWbTXCWuDPWnDI5w7Jw8MP9H3pv5NVBfSHR4ujh5Ofz2PGnIojrfT5r1xb7WeBmvfpz67LBmhow146zZRJgRgLoeJoC4stS8wfrx5u8CLNU0OGW0cQRXqZdNqkF9m7bTBvetJLRqtQk+Y7mwW+rDHbuAFPgSRzUl5TqRMb2fr/bbRq2XIgV1heyURxOLahflTMuN3GDwL02Vg0j54qSNH8bmW7Sd6yEWlN/9xsWxb9fpVKQvJc/BQBYi5LCnvEuOPpqMb13RdRWfRjMPaKFFFAQg04tHWXMJVPJEaVKD/2izC7sCx/yrr5iR0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LVSj+UaL+bii+iABC4aeVrlEAXBLGNzhEYO2g83iUc=;
 b=c/pZUXY9Mg+r/lqsANAgnbBzWCopN70J66M+QNqC6ATef3dHm2FXh3jmRin/zCoIZi63K9V0aSoNt9keqz7Lsi8Csf4qDBKvZyigDjoYNPxBe75vS0YI3ks1WxSWrlht+qsEsSDxzAqIMMNTAKAE+IoarqiUuAlWwoNAqZsYv1+Bpi8iDU+1Sm1SrrcJU+tt3gqYf5Ttg/3UAxWgMMKNR8v5sNjQYBBFpYH1HJQaiBjmNM+BGPjEXP2p3O52sfUsFMozRPU5G9SOm7VK9ZlYbZTM2ugSBBF2U7IWmrPY4zHKpq6dSjQsT3ACFPAppl/QVGZ+6LJZYoR6eX46sz8Zkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by BL1PR11MB5350.namprd11.prod.outlook.com (2603:10b6:208:31c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 08:24:31 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::cd4b:70e7:dadf:68f6]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::cd4b:70e7:dadf:68f6%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 08:24:31 +0000
From:   "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Nikula, Jarkko" <jarkko.nikula@intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Srikandan, Nandhini" <nandhini.srikandan@intel.com>,
        "A, Rashmi" <rashmi.a@intel.com>
Subject: RE: [PATCH v1] mtd: spi-nor: macronix: Add support for MX77U25650F
Thread-Topic: [PATCH v1] mtd: spi-nor: macronix: Add support for MX77U25650F
Thread-Index: AQHZukezhnuwLSWDtEONN1YsR0u8b6/BNBsAgAqMA5A=
Date:   Wed, 26 Jul 2023 08:24:31 +0000
Message-ID: <SJ0PR11MB561367FC6A2A9984E636A25DA500A@SJ0PR11MB5613.namprd11.prod.outlook.com>
References: <20230719132700.15274-1-mahesh.r.vaidya@intel.com>
 <b6725f64-7d08-5966-e0bc-17c5b2e846ad@linaro.org>
In-Reply-To: <b6725f64-7d08-5966-e0bc-17c5b2e846ad@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5613:EE_|BL1PR11MB5350:EE_
x-ms-office365-filtering-correlation-id: 5d92fe0d-d73c-4db2-10f6-08db8db1bc68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wXv+bMx8phfQUd5baLxvMJsuE4/tMUu76XKX+qrTOS/zjtNipPYQoiksS6m+ApPed29vXQjn9Fl0VqSzkdsOzLjuesdFsgX+uB9dlz7aRJFYmnwgmaSD42YwJdgs18iNa0QPugPhceCPn/MCfnLSmoXDnxb1JIv4EKMnKx+/8DU3PE8wIOjN8pMuzuVcyfRmv4g6CVo00XHbj4063BfKK5JfSnoOJf9aG2OYFsA7uFKxlysV5LH2/49eW08LvxXKLpUnqP+zjSyvE5O0lhv/sBPpSvkY8K2/CqXu2DQ5gpsYq+Wj2gp3vOdiUs4wefMXZk5NLiTe3OCKJKH9XWNt/UfUWWbBrfISHKLz7pya4X3YVmLwlZdnBRNaclY9CqGYl86wSbbP44iVtQXoS4oPEONfAQumYwyiENPtVa0my5M5zBziGbAjWvkF51mPasJqT8tiNZkbVhrE9MYwyNiowRdMlEUxpj8jmu0NGr1YWDjK77d73wjcw2cW3y/8zfz2KI3n61/GmP02Xset4PUfl3uq0h9428abzCeeGYe7FbwRPbZWFhv33Pk1/dMN592emxs4I75olRnORCUhkr15F1ouWjzZaSAFb+H4jVbP2TA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(110136005)(54906003)(71200400001)(7696005)(2906002)(122000001)(478600001)(82960400001)(316002)(8676002)(8936002)(5660300002)(52536014)(41300700001)(38100700002)(55016003)(38070700005)(76116006)(66946007)(4326008)(64756008)(66446008)(66476007)(66556008)(33656002)(53546011)(55236004)(186003)(86362001)(6506007)(26005)(83380400001)(9686003)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RldSdG5lOEEveWsrOFVzUHJXNGdoZ2tkVFpYdTFKNUVPeGNSejg5SnVYc3ZH?=
 =?utf-8?B?OGtjc1dabVRqOUJWQ0YzOHJiZ3dNQzlxRUJJNVJhWFZrcWFWV0pQSHZTWE1O?=
 =?utf-8?B?YmREeDNiRVJraUtUZ0JlVmlYS2FCRG9BaVRJY0t6Vmxsd3BCVUZZUEFhM2M3?=
 =?utf-8?B?MEg1Ymd5bUpzbks2c1FFV3VWdzVSWU5kc3g0T0tUaXlKRnN2SFB5Y3ZoR3ZB?=
 =?utf-8?B?cGxaV3VUbFRweitKSVRkU2p3NFpkMlhqdGVjUXdKOC9pdElDY2QrOEgvOFkv?=
 =?utf-8?B?dzBPMlM1eXBvM1ExekltSlZGZ2RKYTFrWUo0a2ZrbEdYcU5SLzQrRkNDd2lS?=
 =?utf-8?B?R1M4TWFTSnUyZ3ZPL1hPckc3cmx6T2NtcGJnOWFDb1FGTE5nZWk0Zit3TWZB?=
 =?utf-8?B?UlRCUUJ2NzZRN0FYQnRsNEpkSVczUGN5TDRtVVdQUEFwakpHRVVaRmxCaEto?=
 =?utf-8?B?S0lOM0RjT3pmcnUvTzl5TFpETnFVWHdVUzZMbWEwMzBWeTZaaXZOaEt5dDdV?=
 =?utf-8?B?ajBkNzlQZENKRDZDcUlveWtad3FpSDFib2x3NFE2TlpBcUdkTEJua25wTE16?=
 =?utf-8?B?OUYvVmJiWFg2WmpDbGQ1RTZ0d1Z2NVZ3czFrQVd1OFBnMmpEQzRXcEw3cW85?=
 =?utf-8?B?cEdkMnQ3T2VpVjVNSENmeENia3RsMkFVZTZuTFdmV081SnVhZVdDZW1FZU5Q?=
 =?utf-8?B?TU0zN0dNcTFPTVhaU09tUzZ2S0QzQ0JrZHphd1ZjUDhLSVdIRlV3WXZGVzJS?=
 =?utf-8?B?OXBIVFRSVzRYSnFPTHFkeUNSOHdoQjdmd0kyV0dDalZzVVNBSWszaCt0Q1k0?=
 =?utf-8?B?bnhETlppNEFuNEdXTTVCYWZjV1IyUWlsUURrczRCaFdoTCswK053V1g3YlNP?=
 =?utf-8?B?Q2dzZm1KSlJXLy9LWXhRdERVNW8xem16bEdoWmwvaGh6WTE4ZUxFTHBWQVIw?=
 =?utf-8?B?cWtzVm4xaytqOTBLS3ljOTh3MWZXbjd2L3M5cEJpWXEwT0dMY1FRZ3hMUXgr?=
 =?utf-8?B?OGwxZEhkRC9hUVVpcFFwRzZKdi9yWDNOY29XbmNUQWkyUmozSmZaYzJiNXgx?=
 =?utf-8?B?Rll0NjdNNjhOcDFvangybVlBWnFyZ1hqREMveC83ZnFVY0NuS1BaZG51L0RC?=
 =?utf-8?B?Z3c4SW9RYUl1WitpOVFHeUJzSGdnTEphdkl5cEQ0VzVaMTJsM25Fc1JpU0ZD?=
 =?utf-8?B?OE8zckdhS0JSOS9vaFBDNndCQjg2ZUZ4STkxSzVoQnduSFRaUGZqU24zUU41?=
 =?utf-8?B?YXN0ci8rS0NGN0dTei9VUlhmOHlYeU1qV0JXRE5BcDNRL2ZuWVR5dWM2QlhI?=
 =?utf-8?B?S0Q4UW1MaXJDN042QzB3ZUpqNm0zK3FvZ1RwNWNPRjB4aFZ5WlMxQzZtWEsv?=
 =?utf-8?B?UjVqbGUxZUsya000ZkR3bklYZWp4dW81N2xSc0NqTGRna0dIWmlIYUp1aHdZ?=
 =?utf-8?B?Z2hFeisrSFl1SElVeWNpY3B1V2JnR3lZd3RwdVVidmZjYVhIaFY5SzlKMEx3?=
 =?utf-8?B?eFdFTE1JazkydVFuekVqTlZLL2NFWEwrNXhjUHQxMUFCNENnY1RCcHdzSHY4?=
 =?utf-8?B?bUNULzFoMUpCdjh3L3gwM1FtY0d1RVNidGJwR2tIbVZBRXJINUpCV1ZmUlNn?=
 =?utf-8?B?ZXFXSGUvbjVISys4ZGRkS2llTG4zazFPSlExM3htTEhhZlhrdzcrV2RWdXhV?=
 =?utf-8?B?OUNpNkhsbWkrZ1dlMklqMFY0dkxMMUhuSGhoYitwNmlkSFZFY1hWMnd2cHlD?=
 =?utf-8?B?dTRlNk13bUVPV2RtWmI3c1dyZDNkcWp6eEw3dUsvU0hPZ1VSanVPWi80TFR3?=
 =?utf-8?B?Q1V6L0cwSW51UHFWU0pHYVQzZjF1eHY0bWxOSGUrcFErdnk2VERQTWZEOWRt?=
 =?utf-8?B?R3lGQjluQ1F0R1h4aml0YWJHNUhlOFZkQ1RtTUM1Z0h4SGNsZmJwQlRNK21r?=
 =?utf-8?B?VDZwL2E1Rjk5NzJnY3BXRjNxNTlGeGlIRmVIWk4vcWlyNXZQZXQxYi9keXBk?=
 =?utf-8?B?dmZ5QzA3cFdzcGRrWjRlaVFYd2pmNnZxODNjb25PYVFBVXJwZmF4OU1MMTB4?=
 =?utf-8?B?bUp6R2hzUkpxT2xNdTIrUHRGWitVRStiWW1pZU85RnNZOTRVU1Bhb3pJdnpq?=
 =?utf-8?Q?ned069/95L+RNXMj/AQQnvMzS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d92fe0d-d73c-4db2-10f6-08db8db1bc68
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 08:24:31.2335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L6kfixAqa1gDS3daB4LkojKUxJwb9A6CC/26WqqAXsrALaQ4tprXcPNYELI8PnEkrAP2CZVR6/uVb2s12uggdZSW4+aPaWyXUXccw/CI4/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5350
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVkb3IgQW1iYXJ1cyA8
dHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMTksIDIw
MjMgODo0OSBQTQ0KPiBUbzogVmFpZHlhLCBNYWhlc2ggUiA8bWFoZXNoLnIudmFpZHlhQGludGVs
LmNvbT47IHByYXR5dXNoQGtlcm5lbC5vcmc7DQo+IG1pY2hhZWxAd2FsbGUuY2M7IG1pcXVlbC5y
YXluYWxAYm9vdGxpbi5jb207IHJpY2hhcmRAbm9kLmF0Ow0KPiB2aWduZXNockB0aS5jb207IGxp
bnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQo+IENjOiBhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb207IE5pa3VsYSwgSmFya2tv
DQo+IDxqYXJra28ubmlrdWxhQGludGVsLmNvbT47IFpob3UsIEZ1cm9uZyA8ZnVyb25nLnpob3VA
aW50ZWwuY29tPjsgU2FuZ2FubmF2YXIsDQo+IE1hbGxpa2FyanVuYXBwYSA8bWFsbGlrYXJqdW5h
cHBhLnNhbmdhbm5hdmFyQGludGVsLmNvbT47IFNyaWthbmRhbiwgTmFuZGhpbmkNCj4gPG5hbmRo
aW5pLnNyaWthbmRhbkBpbnRlbC5jb20+OyBBLCBSYXNobWkgPHJhc2htaS5hQGludGVsLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gbXRkOiBzcGktbm9yOiBtYWNyb25peDogQWRkIHN1
cHBvcnQgZm9yIE1YNzdVMjU2NTBGDQo+IA0KPiBIaSwNCj4gDQo+IE9uIDcvMTkvMjMgMTQ6Mjcs
IG1haGVzaC5yLnZhaWR5YUBpbnRlbC5jb20gd3JvdGU6DQo+ID4gRnJvbTogTWFoZXNoIFIgVmFp
ZHlhIDxtYWhlc2guci52YWlkeWFAaW50ZWwuY29tPg0KPiA+DQo+ID4gVGhlIE1YNzcyNTY1MEYg
aXMgcHJvZHVjdGlvbiBjaGlwIGZvciBuZXcgZGVzaWduIGZyb20gTWFjcm9uaXggd2l0aCBhDQo+
ID4gbGVzc2VyIG1lbW9yeSBvZiAyNTZNYml0IHdpdGggdW5pcXVlIHNlY3VyaXR5IGZlYXR1cmVz
IGxpa2UgUGVybWFuZW50DQo+ID4gNCBJL08gUlBNQywgU2VjdXJlZCA4SyBPVFAgc3VwcG9ydC4N
Cj4gPg0KPiA+IFZhbGlkYXRlZCBieSByZWFkLCBlcmFzZSwgd3JpdGUgYW5kIHJlYWQgYmFjay4N
Cj4gPiBUZXN0ZWQgb24gSW50ZWwgUlBMLCBQQVNTLg0KPiA+IFRlc3RlZC1ieTogTWFoZXNoIFIg
VmFpZHlhIDxtYWhlc2guci52YWlkeWFAaW50ZWwuY29tPg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogTWFoZXNoIFIgVmFpZHlhIDxtYWhlc2guci52YWlkeWFAaW50ZWwuY29tPg0KPiA+IFJldmll
d2VkLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNv
bT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tdGQvc3BpLW5vci9tYWNyb25peC5jIHwgMyArKysN
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvbWFjcm9uaXguYw0KPiA+IGIvZHJpdmVycy9tdGQvc3Bp
LW5vci9tYWNyb25peC5jIGluZGV4IDA0ODg4MjU4ZTg5MS4uOTk1OTM2YmE1OGUyDQo+ID4gMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9tYWNyb25peC5jDQo+ID4gKysrIGIv
ZHJpdmVycy9tdGQvc3BpLW5vci9tYWNyb25peC5jDQo+ID4gQEAgLTEwMyw2ICsxMDMsOSBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IGZsYXNoX2luZm8gbWFjcm9uaXhfbm9yX3BhcnRzW10gPSB7DQo+
ID4gIAl7ICJteDY2dTJnNDVnIiwJIElORk8oMHhjMjI1M2MsIDAsIDY0ICogMTAyNCwgNDA5NikN
Cj4gPiAgCQlOT19TRkRQX0ZMQUdTKFNFQ1RfNEsgfCBTUElfTk9SX0RVQUxfUkVBRCB8DQo+IFNQ
SV9OT1JfUVVBRF9SRUFEKQ0KPiA+ICAJCUZJWFVQX0ZMQUdTKFNQSV9OT1JfNEJfT1BDT0RFUykg
fSwNCj4gPiArCXsgIm14Nzd1MjU2NTBmIiwgIElORk8oMHhjMjc1MzksIDAsIDY0ICogMTAyNCwg
NTEyKQ0KPiA+ICsJCU5PX1NGRFBfRkxBR1MoU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFEIHwN
Cj4gU1BJX05PUl9RVUFEX1JFQUQpDQo+ID4gKwkJRklYVVBfRkxBR1MoU1BJX05PUl80Ql9PUENP
REVTKSB9LA0KPiA+ICB9Ow0KPiA+DQo+IA0KPiBEb2VzIHRoaXMgZmxhc2ggc3VwcG9ydCBTRkRQ
IHRhYmxlcz8gSGVyZSdzIGhvdyB5b3UgY2FuIGRldGVybWluZSB0aGF0Og0KPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC0NCj4gbXRkL2NvdmVyLjE2ODY1NTcxMzkuZ2l0LlRha2FoaXJv
Lkt1d2Fub0BpbmZpbmVvbi5jb20vDQo+IA0KPiBJZiB5ZXMsIHRoZW4geW91IGNvdWxkIHVzZSB0
aGUgZ2VuZXJpYyBzcGktbm9yIGRyaXZlciwgdGh1cyB5b3Ugd29uJ3QgbmVlZCB0bw0KPiBleHBs
aWNpdGx5IGRlZmluZSBhIGZsYXNoIGVudHJ5LA0KPiBTZWU6DQo+IDc3M2JiZTEwNDQ5NyBtdGQ6
IHNwaS1ub3I6IGFkZCBnZW5lcmljIGZsYXNoIGRyaXZlcg0KDQpTdXJlLCB3ZSB3aWxsIGNoZWNr
IG9uIHRoaXMgZmxhc2ggYW5kIHVwZGF0ZSBvbiB0aGUgU0ZEUCBzdXBwb3J0Lg0K
