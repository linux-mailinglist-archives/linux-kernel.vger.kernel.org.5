Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5120680AED2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbjLHV0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHV0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:26:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC67A9;
        Fri,  8 Dec 2023 13:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702070812; x=1733606812;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Hc9V5yYGZxZlhaHFz8cITqO2DVyKkkWh8Nln0lagrqU=;
  b=TjeZ8rBMZPukN3pmsLn2k1mbWaWu81wHHnxvw7UGMFTBdvddDdknbGM4
   dXEtN2hB9cpv9m5tQZN7ygOj6pmHS1BqcYxDuOCRc6YIE1HEaVITb8a9n
   ZFFh1Bi0UxcYukxtbYmvUD0oexloOu4U2LitwdqDIVEnczyYkqixx8RfQ
   eHTCX5GXrIGu/lqEn5cLPNWTGnWe/cv92AsDotUXXSiDSiVmEkr949kH4
   QST9oBh8hhbZWM1J9OPLz+ggE5IVJIR1cz0U9Mne+frjPo1t+FDUTdEVH
   4ip1xd38owaOYYcQTQVoeCbRz5uaR9xghLPE3QYDQL1bwYg3fyyKTFYf1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1533784"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="1533784"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 13:26:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="722000231"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="722000231"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2023 13:26:51 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 13:26:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 13:26:51 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Dec 2023 13:26:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0+amoLORORFrrgN9ppq6XA40yxyp6aIj6VaBBBHNlvdWDlLGsynjVHPtNd9jvXDHD6/SV3+Kz3jGzT1zsYAYWNbfdMLySuRm+zKTveOVpKuZ3FFodtQ+fvisLE+6+68pLHe8RoV7bLl9RAHpp41TCAiGNxOFEa08WTogXp1YdJMY8v6RWU6VJSCEZLG8rCsbZkoVXu+kIJENV/hjNfZnxOCqNbbvCw5qv9dL9CiAa3j3j8d2aZS9GRIrEyoBGjHlnC8Ogkn0Tn5nZKHtFO7n/y0SKdzIHfGcQbGtg29gWAGOHP5Vw37W9X0kx9SK1Nw7NSmAL+PmtBRBKu6UNaBsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hc9V5yYGZxZlhaHFz8cITqO2DVyKkkWh8Nln0lagrqU=;
 b=cYEbBMd1kCYOZ8a7+aXa5/XImNxH30eB9muj8eHcYmKcrnSEgVwew8eQ/CNroElj5+4tz/Nf25+elrcz2sUi0Jg28M+qdygW/sSGhIMQE8okKIg37ZzqFl2tzqMUxLKKxJ6VCnAscmGMdM76qRS+tl3UvZpP6jK6kGjRlWNo3u1BHnXyF59k1vNMxLsMMFR0LolNZrROauH3KJ/cLbpT2zEX8dgodQYaE1RrWONe3dKCTJAXHjm91cQEPBDjM+Ftw2QPktS3CAtbkbbDGLAcIlNKfuwxbWoDQRBRGpXJ2U7/9Ce/ZIfJOFB/pnavPQx2B2LBz4cFI7IjRHu78e0UPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by CH0PR11MB5705.namprd11.prod.outlook.com (2603:10b6:610:ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 21:26:49 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694%7]) with mapi id 15.20.7025.022; Fri, 8 Dec 2023
 21:26:49 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Jiang, Dave" <dave.jiang@intel.com>,
        "david@redhat.com" <david@redhat.com>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2 2/2] dax: add a sysfs knob to control memmap_on_memory
 behavior
Thread-Topic: [PATCH v2 2/2] dax: add a sysfs knob to control memmap_on_memory
 behavior
Thread-Index: AQHaKMbu7P34L+weQECt+BHOvhNpUbCfRCCAgACk0YA=
Date:   Fri, 8 Dec 2023 21:26:48 +0000
Message-ID: <8bc94ef9834569f5b1e330ca7cde22b183d94444.camel@intel.com>
References: <20231206-vv-dax_abi-v2-0-f4f4f2336d08@intel.com>
         <20231206-vv-dax_abi-v2-2-f4f4f2336d08@intel.com>
         <e9323c58-6a99-436f-b8c5-ffc68b940de3@redhat.com>
In-Reply-To: <e9323c58-6a99-436f-b8c5-ffc68b940de3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|CH0PR11MB5705:EE_
x-ms-office365-filtering-correlation-id: 59b8c56f-7163-4dbb-ad66-08dbf834633d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gxmj7MXaYvs0u2pYGR6HQ4m1KcGB+o7MOCTYJzqn7QCRROyozP2dVqSCDIDSc6mCCShQVdJhrE65cu8uAENeUcx+csqfm4SdAGBwogW8LEXjcS6kC/wAv+GMhDFcmf1catzdNVCcfTxjtcI6928Xxi/HKoQ5meVbypiN5VYG1+dJKz160WUn0xsuP5TFOOzI5ktkmpfsnLU+0dSY42Q+E52Q0AWgX9py2Y8ob7JqALBWIS3lWYtviMq6tBFBBk1CjzwxuRTxdPJIPQGekRZm9fj0ho2GGAOtfGE2lhy/tGUt4LDQx6PMLyEUiy6YYH0BYOOgKl2ULVxAzBHb2dYyZukdYJB19WYFuY/iBpbQZxirNGKFhrV9Qj13v/kZBVagBtpJbPjbxrbSATBF+g50iW8eiWwuDceXdZjuJueoESSdJ1rxNEc19SrZaDG9gaTXZUkUXxPUjblc3j/ALx/8oxUldzmQEcA6rUxKMh/ZNRZjUe3DKQx9t03pyUPmXUVpoggnXxB+gOl0XEaJ4h4K6+hm5ot0uCkWEUtLaaDYhxa+lRJWHxE2ql4T5186MnGsQOMlwU9cHJpVvVv5uCbOWPiRKr1W17RGxyZOePVZo47wInDKmmt9KfIUt5rVkywr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(36756003)(38070700009)(86362001)(38100700002)(66946007)(76116006)(66556008)(66476007)(54906003)(66446008)(64756008)(82960400001)(122000001)(26005)(2616005)(6512007)(53546011)(6506007)(6486002)(4744005)(2906002)(316002)(110136005)(478600001)(71200400001)(4326008)(5660300002)(8936002)(8676002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWVnT3BGeUlKSGc4V3JrNkQ1VGgzSnRoc0ZIb0JlU1RlMG1qTVR0Z3Iwa1d2?=
 =?utf-8?B?ZTNaakFDSHNkUXlEYTNualZDdmlpZkpLbk91UUhZaFNQNHdBZFhnUlEvVTcz?=
 =?utf-8?B?dmRlSmliVlY1Sy9mUnV2NzVVYm5QdUtRYW5XanIvZG1OY0JRN2kxQzZOaFl1?=
 =?utf-8?B?QTdlSjlsS0JnWXl5VHhWdEN0VWY5c1BOVDBva2I5ZHFFU0VCaFdDdDdEREhC?=
 =?utf-8?B?MEN3VUJXZFlBNGtuc1k2ZG5IdDNvd3JaUFZsUHh6M2pPWUFKK0dTR0xuamov?=
 =?utf-8?B?OHJJU3VSNzBnOGFCSXYxR2IreEdTMkx6Vnl5UDM4aUVSWGtMai94RkRvNmN6?=
 =?utf-8?B?ZGdVRVI0MnRYN3pISzV4QXpJYVlCYXNSSzQvVTFGaG1BdDFqSHBQNWdUUURJ?=
 =?utf-8?B?bEdaYzhWVm9GaW9hemRJWHJ5ZzVFQTRnTy9WSjh3MXZZMTYyK1owbXdFS3VQ?=
 =?utf-8?B?TFdkUzZQZHJadGJKWGgxd0NHNTR6VXllL0RYd1NPd3luaFhUNHdZSWhTWmRT?=
 =?utf-8?B?eGZMRHJ6NDlvUm9aVVhodU1YR2VObW5nWnZ1OGhUcEtZdE54U0RNT3dMVHNn?=
 =?utf-8?B?L09CVEQ5bE9hYmYzUEoxV2ZDRHp2ZTFTaUZXT3ZaTkNNTVBtZXZVd2o5OHFv?=
 =?utf-8?B?dWdVekxXaTdoWFB4WDlUa2R5TXRmV0UxZCtBMkxMM1RJaVNDdFNSblYrNHE3?=
 =?utf-8?B?anRReGh4WFhDcllsMGl4SVhjaml3NzFKemxoSXJnSGluY1dRUWhNSVRReXJw?=
 =?utf-8?B?Mm5jSEFvTG05WFFjZm1IdWUxaGladnZIQVJoSkY3aTdNSVlhajBJV2dPaTNY?=
 =?utf-8?B?eklnYjlGQXdJUHA4UkVUaERPSnhMZlUydXhmVjA4ZmdvUzhnV1NjSldQTW1x?=
 =?utf-8?B?SDN0TnZ5WUpCc2w3MWVoeHhOc0l3bFhQbmNlQ1dkZlZUYy90WVl0T25hNjRh?=
 =?utf-8?B?dHp4STlNb1YwcHhKMml0T3lHODluTUltOG9JOHJzNGgxL0pYWjdUSVBkYXJk?=
 =?utf-8?B?ampuZEFTR3ZOYzVBWE1XbjczRTRFQUk4Wklqd0N5S1UwaUtycnRXSm5kYVRq?=
 =?utf-8?B?ZnozMTkwZjJKQTVyZWZmdUYxWm5LUUFKZjUzR3JmdHV0YlFBcGdSak5USTkw?=
 =?utf-8?B?Z0lMR2dvMnYrdXVmaWJxaGlDN0VxeXkzbThLT0U2TlZCSk05NHhBVEdndlp2?=
 =?utf-8?B?Z1ZoRVhkNFdJYi9YSitHUitJQnJqVWtSYzRRaTJCaTl6aCtnVjBKL0N5eGdJ?=
 =?utf-8?B?dDlIV0lKR28vYytjbHJUcmlTdktLNElnRmNIN2QvazE4YXJXTWtoSGdydzdS?=
 =?utf-8?B?UWx6Z0RpTVRqK3ZDcTdIMkJ2S2FKcDZOcWZneld6ejdnMzdxS0tUdFl3a0Vs?=
 =?utf-8?B?YjVzZUdac09keUpqNmhCMEJ0Z0hORzFYaWN3Ykg5MnVoOFpSSytDUDZLcnp6?=
 =?utf-8?B?YWtoOElTRHJrOTIxQTR4NFBvSW1mRmhUSU9JTW1BdFFHeUdiNGdld2lrTFQy?=
 =?utf-8?B?SWx0RTFYblhEb2dLcDM3VHRDaGV4SFZsK2VyQTVkaUQrVkIwa3U5bmI2YkVT?=
 =?utf-8?B?L2JDaVc3N1AwRkdrUnpyOEdXZ1Q3ZkRkbDhrOUZUMkNscUZ0amxOSFY0Q3dH?=
 =?utf-8?B?c1NiWTF5cUFLODB0TWl0YnEydU5TSUdSOXltNmpvTFBsSFNZNXZFellRMUpK?=
 =?utf-8?B?R0RqVDN5L3dIY0M3REdCTHF4M0o0dU5hRGNaR2p3TVlNYW9sMS9PdDVHa01R?=
 =?utf-8?B?TTN0cDBVV3JvOU5mY2lTK244anR3eTBsamdNQWdxQlRVTTJRWTVkTXhiQ2gw?=
 =?utf-8?B?aU1MYzY1dFA3Rnpxb2M4QjdVdUhUQnhCVVg3bmsyTmZTV0ZVbWxtemZHSElL?=
 =?utf-8?B?QjkzelM2ckY4eXJyeGFpL2pKVnpNeUNYTEIxNFVlc09GMG9CN3cxS3ZYa2VC?=
 =?utf-8?B?SnFoUEFwQWhCTEhPZDl5WFgzMTFkWktmNHVXRVBRdG9YSzhYa0VJeXQ5Qnpt?=
 =?utf-8?B?V2RDU01iMlhvN1dMNTRuMzJSNFE3QzlrSTNBcEdQUDhnTy9pWVNGUjBITTlE?=
 =?utf-8?B?cXdISnNCcWhlMXQ0ei9QSlZ2L1hFeEo0NmdhZ2NkRm1hb3dReWl1THFJUGVF?=
 =?utf-8?B?OFFueWlOa1oweE5Ea0NRWXBNV094N1h2SDJqSHE4NnN0eHlnaDdxcUpRb2o2?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DD0251DB96C164F81B585F4C00D966E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b8c56f-7163-4dbb-ad66-08dbf834633d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 21:26:48.9648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GzILkkJQO7eaXM8i7XRLigFixoSUsVSE07JdZ3mP/jqexY8ifA5AkYvL6fFogPtbdCLQo6iNVBjG+Cz06UjenZzImjqvEijqbf2U9HzqQio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5705
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

T24gRnJpLCAyMDIzLTEyLTA4IGF0IDEyOjM2ICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToKPiBPbiAwNy4xMi4yMyAwNTozNiwgVmlzaGFsIFZlcm1hIHdyb3RlOgpbLi5dCj4gPiAKPiA+
ICsKPiA+ICtXaGF0OsKgwqDCoMKgwqDCoMKgwqDCoMKgL3N5cy9idXMvZGF4L2RldmljZXMvZGF4
WC5ZL21lbW1hcF9vbl9tZW1vcnkKPiA+ICtEYXRlOsKgwqDCoMKgwqDCoMKgwqDCoMKgT2N0b2Jl
ciwgMjAyMwo+ID4gK0tlcm5lbFZlcnNpb246wqB2Ni44Cj4gPiArQ29udGFjdDrCoMKgwqDCoMKg
wqDCoG52ZGltbUBsaXN0cy5saW51eC5kZXYKPiA+ICtEZXNjcmlwdGlvbjoKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAoUlcpIENvbnRyb2wgdGhlIG1lbW1hcF9vbl9tZW1vcnkg
c2V0dGluZyBpZiB0aGUgZGF4IGRldmljZQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHdlcmUgdG8gYmUgaG90cGx1Z2dlZCBhcyBzeXN0ZW0gbWVtb3J5LiBUaGlzIGRldGVybWlu
ZXMgd2hldGhlcgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRoZSAnYWx0bWFw
JyBmb3IgdGhlIGhvdHBsdWdnZWQgbWVtb3J5IHdpbGwgYmUgcGxhY2VkIG9uIHRoZQo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldmljZSBiZWluZyBob3RwbHVnZ2VkIChtZW1t
YXBfb24rbWVtb3J5PTEpIG9yIGlmIGl0IHdpbGwgYmUKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBwbGFjZWQgb24gcmVndWxhciBtZW1vcnkgKG1lbW1hcF9vbl9tZW1vcnk9MCku
IFRoaXMgYXR0cmlidXRlCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbXVzdCBi
ZSBzZXQgYmVmb3JlIHRoZSBkZXZpY2UgaXMgaGFuZGVkIG92ZXIgdG8gdGhlICdrbWVtJwo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRyaXZlciAoaS5lLsKgIGhvdHBsdWdnZWQg
aW50byBzeXN0ZW0tcmFtKS4KPiA+IAo+IAo+IFNob3VsZCB3ZSBub3RlIHRoZSBkZXBlbmRlbmN5
IG9uIG90aGVyIGZhY3RvcnMgYXMgZ2l2ZW4gaW4gCj4gbWhwX3N1cHBvcnRzX21lbW1hcF9vbl9t
ZW1vcnkoKSwgZXNwZWNpYWxseSwgdGhlIHN5c3RlbS13aWRlIHNldHRpbmcgYW5kIAo+IHNvbWUg
d2VpcmQga2VybmVsIGNvbmZpZ3VyYXRpb25zPwo+IApZZXAgZ29vZCBpZGVhLCBJJ2xsIG1ha2Ug
YSBub3RlIG9mIHRob3NlIGZvciB2My4K
