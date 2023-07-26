Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06370763132
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjGZJHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjGZJE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:04:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C3F3A8F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690362204; x=1721898204;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EXhpn91VmuxciT0CG81MYpmT/9KcbWVHY0ipWWh0/i4=;
  b=XzAfFK9AqZYUpmLNncohJ80tsAJPL6N53QoVyCJsC2dZJmmCNW/qt2Xx
   gC3rFNaXnnU6MdsdOB2xM/7ts0Aefqu3sy1FlY8FQ6VtTXeWgAHc/swFt
   ONjJnMsLMbpyqvADO8G5GiLPM7EXUExogUwxtmeS9UONs4Gm6o+2sbJ5D
   CJg9XGQ27FFT+fEghNmahv4uNftv5ygkabFNfNOHhnojOyHs5WhXb65s2
   r1b0X2MZY1bhuOLwro+ezUIEVNLdIboTxvApgbE7T/OWnKt09Vjs2yscN
   cZrAQMVBKGWgFEAjYW8lw+fqAbHEUmegS3Y/kVeSx62kNm6HtYRXLPGsw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="352860916"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="352860916"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 02:03:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="816589873"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="816589873"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jul 2023 02:03:21 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 02:03:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 02:03:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 02:03:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 02:03:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrvqs95dP0qK04X5DKsvT0Js3eJqATMJb4G3BbnVQ2y4b68na2srFOa+k6LI/sWotv+heXDZZJc1C3QKWZbDs1dy/FdBzU3DL5dayWCJ8j2hdAl/PCUc6OqNuJMqGyplshkC66Ur2ZBzLBC4+AhvUFRf6oINiP6ndfnjJF+/PH/yVIb4Ecn9o2oUX0ZVKDA/fWgbiVxSxjVhA2w6+nDTNwgdYTwOpcm3UFRa3drLvXa48NOSjgETSdNcE/58cWY++xj61h77mfNhs8viE2jK+0Vp1VDelco4x+4zw7pXVTma1FAfSnInVXkUXXNsuWZ0fsV9HD8oGc9oigZZtwMMyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXhpn91VmuxciT0CG81MYpmT/9KcbWVHY0ipWWh0/i4=;
 b=KvnftV4yYigpbG5Zp3EneNNQ/Mej+IBITFcWKiTXUbXZ7/78yFmVJ+U4U5weVGM6F2EvNXOQVuzfEVODe99feOt6Xm9DIfKbPawO+KM66hgHe9wJDqWUzXaDrUotcmcONvjxRynHOn2QruBCFbDiYd94twFEmaI3HX0CEgtbZbBi+237ZnAmgDmBwTHnwkyLg8eosMx5KVmHWR7cbeai1bq3HpOf7EvriOG11RatAQVhSbY7/4MXNQg1DwzZgS5+td331RZoKxPGFBQ7I3eHp76Cd+pKr9OO1fwCrtWDcx2rxZmiboDQMFiXlNe/NWpkwuwrm6LuP8yxbwWGEhQtXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6257.namprd11.prod.outlook.com (2603:10b6:930:26::22)
 by CO1PR11MB5059.namprd11.prod.outlook.com (2603:10b6:303:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 09:03:17 +0000
Received: from CY5PR11MB6257.namprd11.prod.outlook.com
 ([fe80::12c9:6f97:4016:eabb]) by CY5PR11MB6257.namprd11.prod.outlook.com
 ([fe80::12c9:6f97:4016:eabb%7]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 09:03:17 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        Terry Cheong <htcheong@chromium.org>,
        "Bhat, Uday M" <uday.m.bhat@intel.com>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        "R, Dharageswari" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH v2 1/2] ASoC: Intel: maxim-common: get codec number from
 ACPI
Thread-Topic: [PATCH v2 1/2] ASoC: Intel: maxim-common: get codec number from
 ACPI
Thread-Index: AQHZv4iOElXQr78YhkykGlIThIMz5K/Ls3wAgAADvOCAAAbXgIAAAn/Q
Date:   Wed, 26 Jul 2023 09:03:16 +0000
Message-ID: <CY5PR11MB6257A9E85B4543D40AF6FD859700A@CY5PR11MB6257.namprd11.prod.outlook.com>
References: <20230726140848.2267568-1-brent.lu@intel.com>
 <20230726140848.2267568-2-brent.lu@intel.com>
 <7349d6f4-4866-6fb3-57c9-9ce2d6989576@linux.intel.com>
 <CY5PR11MB625741E8CCBA25EAA82739579700A@CY5PR11MB6257.namprd11.prod.outlook.com>
 <9e8892cd-4c31-61a2-94e0-379e576cb7d6@linux.intel.com>
In-Reply-To: <9e8892cd-4c31-61a2-94e0-379e576cb7d6@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6257:EE_|CO1PR11MB5059:EE_
x-ms-office365-filtering-correlation-id: 7aca381b-b773-4a39-dfd0-08db8db726a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fh5juPTN7Yi3eZLpiCXgFnH+Znb9wSY3gQr0RhnVv+8g5J6D3jvRsxMVbNCSKTE2fh4C2OHNDL8btpo5fu/padfXTnNvci3Q3VqsEyCVONh0u8PVciF9pFImtkgtxLWCl88Ee+jXgXgvcksdZArMgaCEEkpxo7IKhoV/Eu58uGnSrbXXewIGkMS/TmQWmlBSVbbsUUFSH/rizAlfEehN6D5ArRBohQrmqcz0YAm8mw4Uts1strEfcmf50JgQ9PAZt5X+33EbKG+K8/DSa7aqXnUvNrqZQHqUNYDT9tzeWi6uuOD9RH49K2Q+Kvwu0R4AnrCRmvdLAsO7a2z5+5aCHO4axBEFAJ23bKsUZ/A/sEn2lBm02IJW1kkB+Y/kAfkTiVvRTZ29wVwPXzsjTNlth99tsOIXOJjLYYl5yCEAJmKgEPumQTWvlD7IquKhgDZO8bwFpTeP/S839UdCMRx9Ah+ek6jo1Y59e4JvCrtoS7nMhw2MmM8AdmvFFr2GrzXSMA8MbuFlkzlEVPtnywQeEgkSQRf8tmouFpHUVmxW8RSnNz3AOz0TQIms1VsNhWZey2qHldQX45y7DVf3R5wVhG1uLA+KKiayiHbu2B56BQk66Pahvr4nwTnX4cDNIoM8ZPSuQaHj3qD/XU8g5C74DA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6257.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199021)(54906003)(110136005)(478600001)(7696005)(9686003)(33656002)(86362001)(55016003)(38070700005)(4744005)(2906002)(66556008)(66476007)(186003)(6506007)(71200400001)(26005)(66446008)(64756008)(82960400001)(122000001)(38100700002)(76116006)(66946007)(316002)(4326008)(52536014)(41300700001)(8936002)(8676002)(7416002)(5660300002)(11716005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnBqSUNKaGlKVEdVbFE2M2tSMVF5b3ZCVTAvR0pTL3ZUSUt6MWYxYXhTc2hr?=
 =?utf-8?B?bHFldnRyNkdZWUcrK3BucFRvalZjRjlaaHNzTG9nZHluK2p2YkFDVFdwRFJC?=
 =?utf-8?B?UVVjOGkySkgyaUZWbytoSzFkbXFGTWJJM0F6bWtlbXVaakNYMFBFV3dTTnR0?=
 =?utf-8?B?RHlISGw3ejZLR1JFNHdPbElsYnIrZnp5c1E5NnNlNnNUTzZ2dFFKWU9hYVNv?=
 =?utf-8?B?RnQyU1pLeGgxVjNNblJ4QWpUcFVibEdkTSs1V2Z2NWZlY2VMdVJwN2RpbElz?=
 =?utf-8?B?U1QwUjg3bmVYV2hGaVVLOUNCbEFzaVdEaCtpUHk2MTR5ajlVWWd3UDhlWElJ?=
 =?utf-8?B?dHFVOEoxMzNQT3ZnbVgwZGF4UVRhbU1ZNFIrWWNFTVdlUkRYWnpGaW1oeXRV?=
 =?utf-8?B?Uloxd3FlRUt5aUo2d1ZYOERSM3BycGZEVnFBaUh5dmt6L3ozVzFQK00vMGRl?=
 =?utf-8?B?NDk3UjhIQXZUU25sczdNcnB5K0lnSkpSdlVyajRuNXVkd3J0bHc4K3hIR0VZ?=
 =?utf-8?B?L0l0NVpzeHczalI3V1Bia1dvcFMvbTBwekRHZWxvT0VkZ3pCOHg3aDdEOXJF?=
 =?utf-8?B?ektpWk9oZHhJam90TGJ1OUpmb09jc0I4T0xyaG9BUkR2OEFjTWVyLzkrZkti?=
 =?utf-8?B?UmlpYjhzSUhSSlAyaTdaSFFteFd0SW9hNnZKcDFISWZEUzBjTS9VL3RNLzZI?=
 =?utf-8?B?eTFZbDh0cmtkTmExWWR5T2NPb0sxSzl6bUVubk96UENwV2M0bkNFN25Ta2Ra?=
 =?utf-8?B?Y2lOb0I2UUtSQVFua014MHNJWjdDcnlEZWVNV205WXdndEJXdUgwbFFObFoz?=
 =?utf-8?B?bnNybGVBTkw0NlBDN1h6RlJNdG1qVFRSNnl2OVNpZXZCTlBPbDFMY0I1N1lu?=
 =?utf-8?B?WlpnTzJqOFVXNGpWUHhXeFduSmo0dThpQWFuV2hsbXBaaXVkZWVLeW4zTlY2?=
 =?utf-8?B?ZS9tZVFEQys4RnJITHphZWZUc2tQQVNFRmNUUGV1R3lEMk9pcW45TmJockhR?=
 =?utf-8?B?VkhYTm5PYU9kcWVlOVhIUCs4MUVOLytxRmYwT09hTDQ2UEY1Q2cvT2lzdE5M?=
 =?utf-8?B?cEk1cENoTTB0dFNFZE11dUV0K0FPeU1DQ2JmMUZpU3ExUzhzWmE3a2RJcS92?=
 =?utf-8?B?UkR1NFkrNHo5a0ZJVnIySHdqTncrZXZna2Y2U1VHcjZZTTBBOE94OGVQVHJT?=
 =?utf-8?B?T01hcDlYVWxabklLRFkxWmcxd2hmdWN0QXN2b1dkNXpRU3dvd2RNV2VpemtU?=
 =?utf-8?B?SzVRd2c4THNnekUwWVg3Rmw0K2FOTG5MTkFIU0g4QlNnNVdDN2YzOVh3eldL?=
 =?utf-8?B?eHhZM2FvUmZmMHRhRmxGalJOazhQVnJmVGZMZGJKRlNFME1Ycnl5cVNyZjg1?=
 =?utf-8?B?UjJtd3JaZUxDeUhLVEJKN0VkOUZGbFQ3ekR0cXB0VVFmRUxCYjl2bTNkMEJL?=
 =?utf-8?B?ckU5b3J5RHhERFNnUUcwMDdGbkRudWR3bmZ2QkpUZG5MUTRNcVd5QnI2ZlE5?=
 =?utf-8?B?VmtDbjk3N1VTclRodHBNYS9pak5EKy9PQ0t2SmpJVEVQRUFPL2UvN3p0S2lx?=
 =?utf-8?B?LzdXR3Nkc251NGFIZTZleDNNTGlHWStnTEQ3N2FOeGJ4Z2ZKc2docGhUeVQ1?=
 =?utf-8?B?bTQybVd2MlFmdzFrMzBZVlpJdGdLRThWK0lYSHEvQzJFM1dGb0lYQ1BLL0VY?=
 =?utf-8?B?alJCYWxtcG40L1h3Qzl3c28wejZ5YTBmUTVnQnF4eUFGWVVhTnE4UU9Od1VI?=
 =?utf-8?B?elZMMGhjSzNGSnowWGUyZUlkdDlQMEtJbFhReDZxNFVmQVIxNWJVNURRVnVF?=
 =?utf-8?B?VnVMeDF0SnlSYzR2YVRvRzFtWGQ1YitmMC8yQnNoQ0lQL1hhUHVvdzhmcXNE?=
 =?utf-8?B?TG5zYTZUdU90RXFVUDV1TU9lS0VhaFc1dithTkdBcXY2bkljaW16a3dPcTNu?=
 =?utf-8?B?MytHVlRmUi9mSGptT0Jzd2VaWDRYOW1PbzR2a21KazBEVjZxOGJFa0FGc0c4?=
 =?utf-8?B?UkJFR0lySDFNTmZrSm5rT1kybkZlbGs0U3h2d3ZmNVVxZ3duWnlmaUJJYk9y?=
 =?utf-8?B?RTB0M3dodDVBZHNRSkd0NDIvNXNNcE8wQXZHVzZ5OXlkV25rVjhmS3hsYWtr?=
 =?utf-8?Q?zuXQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6257.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aca381b-b773-4a39-dfd0-08db8db726a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 09:03:16.9614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IabNq5UmRzrVhe+O4Uav6tzH98WVjbSMV8QbKxK258wr7jHkPLVcy/WNd07EXsPKAUDDa3VDPpvr8fZflrF8Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5059
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gUm91dGVzIGFuZCBjb2RlYyBjb25mIGFyZSBkaWZmZXJlbnQgdGhpbmdzLCBub3QgZm9s
bG93aW5nIGhvdyB5b3UgY2FuIG1lcmdlDQo+IHRoZW0/DQo+IA0KPiBXb25kZXJpbmcgaWYgeW91
IGFyZSByZWZlcnJpbmcgdG8gYSBkaWZmZXJlbnQgYXJyYXksIGkuZS4NCj4gDQo+IHN0YXRpYyBz
dHJ1Y3Qgc25kX3NvY19jb2RlY19jb25mIG1heF85ODM5MF9jb2RlY19jb25mW10NCj4gDQo+IHN0
YXRpYyBzdHJ1Y3Qgc25kX3NvY19jb2RlY19jb25mIG1heF85ODM5MF80c3BrX2NvZGVjX2NvbmZb
XQ0KPiANCg0KWWVzIEkgbWVhbiBtYXhfOTgzOTBfY29kZWNfY29uZiBhbmQgbWF4Xzk4MzkwXzRz
cGtfY29kZWNfY29uZi4gU29ycnkNCmZvciB0aGUgbWlzdGFrZS4NCg0KUmVnYXJkcywNCkJyZW50
DQoNCg==
