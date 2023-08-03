Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F4076DF62
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 06:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjHCEXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 00:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjHCEXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 00:23:02 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEAD30C4;
        Wed,  2 Aug 2023 21:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691036581; x=1722572581;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZPmYWPm0TMjdB9q5afdJK/3CzJtgd3kmTKmpJCyKHhM=;
  b=dxm5ZlUt8Pf2yibl/xyPQivqRgigVvtjZLQdFXZI5mZFSc6yIEgmNO0u
   XE2LSqozxZHsEEPWQTwLsMkw1JztRpVAjFsH1iau9CooepbkIc0XVuzrn
   /m0YB6r/B8WE+6938abjW+Xs7fC6x6zbJ/8FkMPTmqxjbsSbnr+wVi8eI
   S0wXTbuo+VrDRnLbPDNoUmbd09e9BebXg3HZLpAh/rEQw/YfjEJ6jkKdT
   WR1tC07fDCA2h+dcXma8M/6APJDni+KLTA29dOS+pQkIYq7xKKwI0YomG
   ropE0i1c2VxDR1igDg5iy9PUdHGCiDDMV42jLBQlgzCJPaLyC1kKtgSOv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="350057536"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="350057536"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 21:23:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="872771527"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 02 Aug 2023 21:23:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 21:23:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 21:22:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 21:22:59 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 21:22:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CORlhbiJ2tkwseu0nj+yvD7PWPU6jacJpyqOVhBMocqm9r6NTro5z9oy7ndzCaUNIwcD1ttA4xr1BJiMH4D5iWGMnnvXLqKv3mfDcFu01miIKmJ6ahp43YWwwJJfT0O0PTqu8U/EbyQ7SxIGEgwJYObxfkzWsFa8aPcnAO8AXzHPuSBVbawKArx5Bi+Mhxg9svGS1J6R7oIsbWI4EZ4VsOGBq4YljCUM9k8JdobnFKyE51aXxsec09xbC9XlpU6aVpiJesA1GKua5qOrkxXFM2W6yzo3kjTAEVdHGZ58o2MY8/KE2+leV7Ck0ByeI+EJmsb0flKXO75xlTdF+lSi6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPmYWPm0TMjdB9q5afdJK/3CzJtgd3kmTKmpJCyKHhM=;
 b=ZipXNIHQqJAdJpmUaRs2IkhywIRZUjs5qEM2/N0odhVMpxKECWjS7JRsu2ZoqYuTugtPRwhRPvR0FrbSG6tC3ALPz94pzghnri5EwCcGgSMf94GEmHzzRtH+18nPnZjlGfYxsFA+zQcPmrVee47EqzOQ2mJsU5iQupzxDqE2mDoKGeU/Cmmm9a3cH3PbpcxRJ6WV6JC9rAjFUpxppmsFyvrlAbro5i7ibrbfsJDm/plps0fThf8rlutYSB1UhoFKywHlX9XCfnwktpmKO4XOMWlGysTBeWVNb0rg2iWfi2AL47/kgJci+x2jIV8dDPaZ1eYEYjRWuIUVug+C5XpKYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5996.namprd11.prod.outlook.com (2603:10b6:8:5f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 04:22:56 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 04:22:56 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Van Bulck, Jo" <jo.vanbulck@cs.kuleuven.be>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 4/5] selftests/sgx: Ensure expected enclave data buffer
 size and placement.
Thread-Topic: [PATCH 4/5] selftests/sgx: Ensure expected enclave data buffer
 size and placement.
Thread-Index: AQHZvlArjuImLhHIgU6DlMvo5rqhNK/YB7aA
Date:   Thu, 3 Aug 2023 04:22:55 +0000
Message-ID: <ea91bcfdf3ae32fb0f7ac4f866c63dbf5bbaa0ab.camel@intel.com>
References: <20230724165832.15797-1-jo.vanbulck@cs.kuleuven.be>
         <20230724165832.15797-5-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230724165832.15797-5-jo.vanbulck@cs.kuleuven.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB5996:EE_
x-ms-office365-filtering-correlation-id: c2e5ee8a-31ca-4ffb-0816-08db93d94fcd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MwvWym1wG84g3CiysJdIlvgROSI0ISK02yHTP+pf2nBes9xw+b9HaenDlq0/6j/HLTiud1hs3o7Di8AWXni+Q7X+1FPYP8I1/nLZ6Sw4XDdjAwkiPNwt5uF7lvjsiiMfUszCvThmMqVMAYGFcnWfe/GIkJw0qbDtmbF/3ZLx4pkmIE1ruEqpH1uqjYk6N07LNkzemqQGj1tKxGmSwrwVW5xoH5MOa0pStllIf+ciRx1E/PIUBTiz0F0KHY3bmMJDUOguzhY7Yei+Bmff1mGhXA3nNIOsKjKJIILR3CO0vqqQhKdWfks0gS3WSr0CHaRbsSLmw3Neyn4jt/QLejS3ckELcLdiLrg+uSzKv1DWMXC7AeWCYRLGUWbt1bg5i4NeMajQyBGLp0gRqyUSrt7tVj3U+59BuQczvsgjf63/wOkVA3onrSus51pGvBiPvQ4Z07RR7PPKVlhv/GRoNG5ODNPixdG+KpyiIw6l9cajmiCrDIt9dDjw8eB+OG56kxJypSxSCqsyyQWNECuNvq7bScj7hSsA2aREbeih/bgcGf86vwz5Sf5Udc3Q2wQTJ/mJ1Ct3z+5ogwepw6+GHzQItMGHvXldg+x6xEouHNwkSLk9nL7oDIfJxAeM2NCtE/ee
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(41300700001)(316002)(4326008)(2906002)(91956017)(76116006)(66556008)(66476007)(66446008)(64756008)(66946007)(8676002)(8936002)(5660300002)(82960400001)(122000001)(38100700002)(26005)(6506007)(36756003)(186003)(38070700005)(86362001)(2616005)(83380400001)(6512007)(478600001)(110136005)(71200400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkljaVJWQW5HTVJpbG1RR0xuYW5MdFNVUkRNN0Q0SDdBbTVNblRsbG5KYXVm?=
 =?utf-8?B?NXVrT3VEOG9xcHNxbm01dllPWStvdk9uejRSWnRERDdwWjZFQ0lNNXJOMVFF?=
 =?utf-8?B?K2RwdjV0QVFrb1lRaVZoNXhEa21jd2s0eTJXN2kzUXgzdnVhQ0NZMHg2c3Nw?=
 =?utf-8?B?WWhWQXRwVHRKS1J6N3dYVHUxUEFsTDVaREZocEdheWhEbWgrZ28xOWdFYlA4?=
 =?utf-8?B?N1dmMmpzdGlrdUxleWo1eHBCSmwzSCtpQTlFVjVQRnRVSnhxbVYwMm9qS09H?=
 =?utf-8?B?QlhwWE5nVWkvUlRqV29Wb3dtbGJ4ckcrUXhxZGptQUJVRmwyOS9MOUdRZnRi?=
 =?utf-8?B?dzRzUUJCWDcvZks5SGxob2tzMTdIZDB2d2RVVTNNSnNXeHdZY0JlT3RxWWd2?=
 =?utf-8?B?YlFIbndGV0ZwVXArT2NKTmc2MjBjdTBpeXlpN2RabVdWeGIwcGYvTDE1RGhP?=
 =?utf-8?B?NlpzU2ZCUjdpd1h5d0ZIZm9rZk9zc0JDbFlFdUZJQ0lWK3JQVFlGdGFMNlNW?=
 =?utf-8?B?QUI3eEhmQ1ZkRks4dEg0Y0NJbzZqWVpKa2UrZmF5MEdZNUlDRjVBYjhSNUZZ?=
 =?utf-8?B?ZHY2eUFESkUwWWNFNE1VMzJrdnlMTmhPWUh3QUV3SGZiNTBYbGs1UjRkUUJ4?=
 =?utf-8?B?M0srSnh2ZHB0NmJrNWJqeUl0MGJIV1l4L3duWlRud3Q5cng0N3dzd0VCL2t5?=
 =?utf-8?B?a0pyWitoMHZ5Nng2QzRNckNCM3ZveTROdnIvZXF4ZkdaQ1RhdURGN2tBYnJG?=
 =?utf-8?B?Q0JCNFJLOWwyRUJhT0ZRV1l0cnBtdXRPWG8yaFQrdzNaNmhTV2swelpsR2dV?=
 =?utf-8?B?WmUvUnh0Y3BlRUJ3a3IrNGcxb0pBeTVPbVR1NFpBci9oaUpVVFFCY1RycWhQ?=
 =?utf-8?B?K2o2NS8xUkV4VGMwb1FYL0w0U2tvL0IzUzBJendodVphOTk1L21Ub2szSHFY?=
 =?utf-8?B?aVJONmJ3aFgwaTNZckRuS0wzMy8xRmwvRkY5T1d3ZXJNNEJVQmZKUnd5ZWF6?=
 =?utf-8?B?eDJNVHA4M2JLaGI4REVnZmpUOUR6aktueS93QVBjYUh4WEdBcHpPYnh1OVBL?=
 =?utf-8?B?c1Y2QWk2MzVDQ1U1c0FrUFNyclNHOCtZQnRBVXpISDNPb2JZK0dhaC9RQ016?=
 =?utf-8?B?ZWtIL2s4YTUrb3hPZXR2VGk4RGtNT3VyMVlnQ3FpVnEySjhCTGZvb1dqYzR6?=
 =?utf-8?B?bDMrSlByeTVqVlZSY29uSkEzbG1UbHRPSEVJbGFpbUdUT2dGa0xtajFkdUVB?=
 =?utf-8?B?Q245eE9uSUJQMGcvR3VJMjRYK3I5SWNqYXNvNlpzeEFINkplNkE5bEw4dk9i?=
 =?utf-8?B?Qnk3bCtFeWdnVzM4SzdwTUswZ2tZeEd1dXNYT0RycS9NQU9NazdJeXBzRDNL?=
 =?utf-8?B?QmhjNHZ5M2lYek9JYm1GTmxkVFZ6NHhDOFJmaUI2YXRHOGlzNnNIUHRjRTVG?=
 =?utf-8?B?YVdFS1gybjI2MTNkNm4wRWFEamZlaXZwOHB0aFpObUhLRUhwbDBRRXVtVkE1?=
 =?utf-8?B?MldnUFVhYURtMTNEQTFyZjNKNURKejdJclFuZzMra2tmeWxabXFwWjhiYlc4?=
 =?utf-8?B?TlhCS3pGZDZHaU9PUCt6dlhNMXhoQzloVUQ1c3dYbitIbWJUMzFzQ292b29D?=
 =?utf-8?B?Z0dmS3BkeldmQkF6Y2d1SEdjMFdwWGZoMlZSY0JZOWdTem1qRWFmamttbEVY?=
 =?utf-8?B?cUJDd3dBNlVtZ09PdDRsSjYwWGk0cm5qUm1kaTZUa21NTFl2NlJjMFJES3NC?=
 =?utf-8?B?NW5mTjhDTXZwYjZ4enY5NDRyOGx2K0FIWHZjajVmb2JoaVZqVnhqd0tqSXow?=
 =?utf-8?B?MXEzdG51Nm5PMHhHSVkzbFE2ZG16b21FRkpyKzZxT1VRSVU5NS8zTmVVUExI?=
 =?utf-8?B?TDdYcSt1eTBqUTJ4MEY2cDBhYU9VdEVTeFZuQWdhUkp5MUwrUVJQTU1wWExX?=
 =?utf-8?B?RExKa0dCem9FcXU1UVlwSVpUQ2V1TFBZdXlvV3VEa1QrV2VpclNmTUVmeWxJ?=
 =?utf-8?B?RWdmT2xOT2FBcUpNOCt4YmlZeEJBUEdndVpRZzVzQWxmWFlXY0pQSGs2RmNt?=
 =?utf-8?B?Qm9GZkNkMlVicTJtWWliN05lb1ZobmZ0RTdPbWc5emxqNllaOGJHYjNRVk1t?=
 =?utf-8?Q?5zvdcBLc7/fXccAT8tFCH3t57?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7ACEFC31D5CC574AA674038EC8968B67@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e5ee8a-31ca-4ffb-0816-08db93d94fcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 04:22:55.8798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sTRGg/mgwZYiuP9dI/nA4+oNfO6EFFxI7ZsOFGFHwp0o8zEB5DscEBdULVRQYKJ88+sYPvJC3BximUSVx8IYBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5996
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

T24gTW9uLCAyMDIzLTA3LTI0IGF0IDE4OjU4ICswMjAwLCBKbyBWYW4gQnVsY2sgd3JvdGU6DQo+
IERvIG5vdCBkZWNsYXJlIHRoZSBlbmNsYXZlIGRhdGEgYnVmZmVyIHN0YXRpYyB0byBlbnN1cmUg
aXQgaXMgbm90IG9wdGltaXplZA0KPiBhd2F5IGJ5IHRoZSBjb21waWxlciwgZXZlbiB3aGVuIG5v
dCB1c2VkIGVudGlyZWx5IGJ5IHRoZSB0ZXN0IGVuY2xhdmUgY29kZS4NCg0KVGhlICJlbmNsX2J1
ZmZlciIgYXJyYXkgaXMgaW5pdGlhbGl6ZWQgdG8gMSBleHBsaWNpdGx5LCB3aGljaCBtZWFucyBp
dCBzaG91bGQgYmUNCmluIC5kYXRhIHNlY3Rpb24uICBBcyBKYXJra28gY29tbWVudGVkLCBjYW4g
eW91IGFkZCBtb3JlIGluZm9ybWF0aW9uIGFib3V0IGluDQp3aGF0IGNhc2VzIGl0IGNhbiBiZSBv
cHRpbWl6ZWQgYXdheT8NCg0KPiBVc2UgLWZQSUUgdG8gbWFrZSB0aGUgY29tcGlsZXIgYWNjZXNz
IHRoZSBub24tc3RhdGljIGJ1ZmZlciB3aXRoDQo+IFJJUC1yZWxhdGl2ZSBhZGRyZXNzaW5nLsKg
DQo+IA0KDQpJIGFtIG5vdCBxdWl0ZSBmb2xsb3dpbmcgaG93IGRvZXMgIlJJUC1yZWxhdGl2ZSBh
ZGRyZXNzaW5nIiBmaXggYW55IHByb2JsZW0/ICBJcw0KdGhlcmUgYW55IGhhcmQgcmVsYXRpb25z
aGlwIGJldHdlZW4gIlJJUC1yZWxhdGl2ZSBhZGRyZXNzaW5nIiBhbmQgdGhlIHByb2JsZW0NCnRo
YXQgeW91IGFyZSBoYXZpbmc/DQoNCj4gUGxhY2UgdGhlIGVuY2xhdmUgZGF0YSBidWZmZXIgaW4g
YSBzZXBhcmF0ZQ0KPiBzZWN0aW9uIHRoYXQgaXMgZXhwbGljaXRseSBwbGFjZWQgYXQgdGhlIHN0
YXJ0IG9mIHRoZSAuZGF0YSBzZWdtZW50IGluIHRoZQ0KPiBsaW5rZXIgc2NyaXB0LCBhcyBleHBl
Y3RlZCBieSB0aGUgZXh0ZXJuYWwgdGVzdHMgbWFuaXB1bGF0aW5nIHBhZ2UNCj4gcGVybWlzc2lv
bnMuDQoNClNvIHRoaXMgY2hhbmdlIGlzIG5vdCB0byBmaXggdGhlIHByb2JsZW0gdGhhdCAidGhl
IGNvbXBpbGVyIG1heSBvcHRpbWl6ZSBhd2F5DQp0aGUgZW5jbF9idWZmZXIgYXJyYXkiLCBjb3Jy
ZWN0Pw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKbyBWYW4gQnVsY2sgPGpvLnZhbmJ1bGNrQGNz
Lmt1bGV1dmVuLmJlPg0KPiAtLS0NCj4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC9NYWtl
ZmlsZSAgICAgIHwgMiArLQ0KPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L3Rlc3RfZW5j
bC5jICAgfCA1ICsrKy0tDQo+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9lbmNs
LmxkcyB8IDEgKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L01h
a2VmaWxlIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L01ha2VmaWxlDQo+IGluZGV4IDUw
YWFiNmI1N2RhMy4uYzU0ODM0NDViYTI4IDEwMDY0NA0KPiAtLS0gYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9zZ3gvTWFrZWZpbGUNCj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4
L01ha2VmaWxlDQo+IEBAIC0xMyw3ICsxMyw3IEBAIGVuZGlmDQo+ICANCj4gIElOQ0xVREVTIDo9
IC1JJCh0b3Bfc3JjZGlyKS90b29scy9pbmNsdWRlDQo+ICBIT1NUX0NGTEFHUyA6PSAtV2FsbCAt
V2Vycm9yIC1nICQoSU5DTFVERVMpIC1mUElDIC16IG5vZXhlY3N0YWNrDQo+IC1FTkNMX0NGTEFH
UyA6PSAtV2FsbCAtV2Vycm9yIC1zdGF0aWMgLW5vc3RkbGliIC1ub3N0YXJ0ZmlsZXMgLWZQSUMg
XA0KPiArRU5DTF9DRkxBR1MgOj0gLVdhbGwgLVdlcnJvciAtc3RhdGljIC1ub3N0ZGxpYiAtbm9z
dGFydGZpbGVzIC1mUElFIFwNCj4gIAkgICAgICAgLWZuby1zdGFjay1wcm90ZWN0b3IgLW1yZHJu
ZCAkKElOQ0xVREVTKQ0KPiAgDQo+ICBURVNUX0NVU1RPTV9QUk9HUyA6PSAkKE9VVFBVVCkvdGVz
dF9zZ3gNCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC90ZXN0X2Vu
Y2wuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC90ZXN0X2VuY2wuYw0KPiBpbmRleCBh
YmEzMDFhYmVmYjguLjVjMjc0ZTUxN2QxMyAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvc2d4L3Rlc3RfZW5jbC5jDQo+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L3NneC90ZXN0X2VuY2wuYw0KPiBAQCAtNyw5ICs3LDEwIEBADQo+ICAvKg0KPiAgICogRGF0YSBi
dWZmZXIgc3Bhbm5pbmcgdHdvIHBhZ2VzIHRoYXQgd2lsbCBiZSBwbGFjZWQgZmlyc3QgaW4gLmRh
dGENCj4gICAqIHNlZ21lbnQuIEV2ZW4gaWYgbm90IHVzZWQgaW50ZXJuYWxseSB0aGUgc2Vjb25k
IHBhZ2UgaXMgbmVlZGVkIGJ5DQo+IC0gKiBleHRlcm5hbCB0ZXN0IG1hbmlwdWxhdGluZyBwYWdl
IHBlcm1pc3Npb25zLg0KPiArICogZXh0ZXJuYWwgdGVzdCBtYW5pcHVsYXRpbmcgcGFnZSBwZXJt
aXNzaW9ucy4gRG8gbm90IGRlY2xhcmUgdGhpcw0KPiArICogYnVmZmVyIGFzIHN0YXRpYywgc28g
dGhlIGNvbXBpbGVyIGNhbm5vdCBvcHRpbWl6ZSBpdCBvdXQuDQo+ICAgKi8NCj4gLXN0YXRpYyB1
aW50OF90IGVuY2xfYnVmZmVyWzgxOTJdID0geyAxIH07DQo+ICt1aW50OF90IF9fYXR0cmlidXRl
X18oKHNlY3Rpb24oIi5kYXRhLmVuY2xfYnVmZmVyIikpKSBlbmNsX2J1ZmZlcls4MTkyXTsNCj4g
IA0KPiAgZW51bSBzZ3hfZW5jbHVfZnVuY3Rpb24gew0KPiAgCUVBQ0NFUFQgPSAweDUsDQo+IGRp
ZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9lbmNsLmxkcyBiL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC90ZXN0X2VuY2wubGRzDQo+IGluZGV4IGNhNjU5ZGIy
YTUzNC4uNzliMWU0MWQ4ZDI0IDEwMDY0NA0KPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9zZ3gvdGVzdF9lbmNsLmxkcw0KPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gv
dGVzdF9lbmNsLmxkcw0KPiBAQCAtMjQsNiArMjQsNyBAQCBTRUNUSU9OUw0KPiAgCX0gOiB0ZXh0
DQo+ICANCj4gIAkuZGF0YSA6IHsNCj4gKwkJKiguZGF0YS5lbmNsX2J1ZmZlcikNCj4gIAkJKigu
ZGF0YSopDQo+ICAJfSA6IGRhdGENCj4gIA0KDQo=
