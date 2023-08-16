Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0B377DCF2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243167AbjHPJFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243313AbjHPJFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:05:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5211BFB;
        Wed, 16 Aug 2023 02:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692176729; x=1723712729;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nrRsezk1WzBG1CHOZaIO6ZzhRkMmxlbExysttYRpHS4=;
  b=Vs1TXr2xeuXGFILvC3sJ18fiASO7AcjHBlKhB3gJr8mTxm9sfAImdW9L
   jnEwFA+6OryN5PWXgzusM3IwfM67pDM0TMGJ9CCjAg3+4W9/I1J8yDgRs
   j8URqqF+wbjuxQWXQT4P4ROO4j9gR3wgEsPD6AsL2IjY09d8qaFzVOfr8
   w1LCY4MdKQgkm3fcl3scsTRJKemTk5RspMH5Lo8e4Yfqt7Bt0MoqPqkrL
   SWsG4tP0z8yGuxlOnKS1TaiCkfqmyhQk3vSeeXQIJ18E9Ru90lm6aJvnG
   2g/CQt07QltEiibXNGgwNEzRLSiE2K3TEm2m4F2445xtG6Xbjq8+W2vc/
   g==;
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="229206990"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Aug 2023 02:05:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 16 Aug 2023 02:05:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 16 Aug 2023 02:05:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVeDE2elAah8JbMPuJdY0qX5Fm+Hqjwg1VFI2QW1kIy/OxfXfSLGTxdJEbCiKsUHUGqkOZnwOKfFyt1tT9tUF/jK/IJyOyMh1aazGZqHMZRdAFUnwd83Mqel329w84ZkjE9tJq61vZndcHYpzdFh+37ph5aGXF6RtXSqpGq9o4Fg2D4/HugAXmdBJHMdCZtokSANkywDsZ6NRiTE00Ej5FYLnpcDy5k1m/q4IR03Jyf06mPwcSIWkck1GDQ74MeBsGgVVEFdlJjpQoTzRDCK1lcDxPEi2Ya1b85+w6cxXoiMx29l18DgAtSqp3a8BT2S6wO4X0c4NKKKyq9+f/HapQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrRsezk1WzBG1CHOZaIO6ZzhRkMmxlbExysttYRpHS4=;
 b=nxXCTiPcsuiWnJ1pUTuJRRG52IpQLsz5qYeNe63HvUFBq5yYVZnhERIRV0lzNu7SmGZwZOelxti+REHzPjJOmV/+F3KRpegQdfOHvZN2UWIBu2l2CcdFWPfxxVacOPhyEgGCfk3C2DBClZZUjIwMQfL01/0ZjaEerzowuzmzAgkQ4kjyDW6hvnkwbYs73UbVuQ2nBj4Q/lHiDnShPHXfnzKIhLApm7Nsb85lqzlUtlxfCGUP6/0O0emhblJMmjAdfxFSs8IbO28eefji4ZNktXYlm5JrwAC3ezYkAPrke15oqIPSEw5N12WhOQpT/+sgvG2MSFliWxcQZOnkq2/5JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrRsezk1WzBG1CHOZaIO6ZzhRkMmxlbExysttYRpHS4=;
 b=piaLSyhAv7Bdbc1VJOzhdM+RCUUusTt1cbmyl6YgotIpy5DuTLG2+NLDao0MQcpIVTRQUHcro2TMstf3cW9fOwFYNL7OTcBE8/2W/5aWYYNitMq8KemKkUUzHXSxfCBZ1rhoq8ZPqqh/0Iki+tDvy31EaXn8fUoFALys3q2t9SI=
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by PH7PR11MB6007.namprd11.prod.outlook.com (2603:10b6:510:1e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 09:05:19 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::c03b:7225:e395:9abf]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::c03b:7225:e395:9abf%4]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 09:05:19 +0000
From:   <Mihai.Sain@microchip.com>
To:     <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <Cristian.Birsan@microchip.com>,
        <alexandre.belloni@bootlin.com>, <andre.przywara@arm.com>,
        <Jerry.Ray@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Andrei.Simion@microchip.com>
Subject: RE: [PATCH] ARM: dts: at91: sama5d29_curiosity: Add device tree for
 sama5d29_curiosity board
Thread-Topic: [PATCH] ARM: dts: at91: sama5d29_curiosity: Add device tree for
 sama5d29_curiosity board
Thread-Index: AQHZxrwJPBN0Q8jsykCuVX+kL6bwXq/hbkiAgAGsN2CAB8g8AIABzaWQ
Date:   Wed, 16 Aug 2023 09:05:19 +0000
Message-ID: <PH8PR11MB6804B1C6466C7A450A180D1D8215A@PH8PR11MB6804.namprd11.prod.outlook.com>
References: <20230804101043.4063-1-mihai.sain@microchip.com>
 <127fc712-d924-f27f-5449-33385e89d6c3@tuxon.dev>
 <PH8PR11MB6804E49B5946F4A9D60837E18213A@PH8PR11MB6804.namprd11.prod.outlook.com>
 <98d01db3-3eba-0731-0dd9-4310ed293bd6@tuxon.dev>
In-Reply-To: <98d01db3-3eba-0731-0dd9-4310ed293bd6@tuxon.dev>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|PH7PR11MB6007:EE_
x-ms-office365-filtering-correlation-id: 45870b72-c82f-42fc-42ee-08db9e37ea3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +j7w7xduT5EmSn0dCwLpW0w5VSoX/gnsuq+PiY+nTZFe/wu4DvRu6nHN+uSPORJHMr8vGxkl0R087S7xI2ASSU4LI5PIh51KRAKgCfmUphnF5hrDnW+JmTVhgdFBAoQV7CwFBnbcyrMxDgjNlhObPbDcby4R5wqNuCCT78Z9T+inVGZquiQyA6ixlbx7B2H3Yzr35lgRmdQTfv529f6GwF89QCqaLQSi7zqHnKsy9tMYeEuwelyvVgIqxNPSw3NEkoMzL/RKlu6r9Om9HLgZar/C/LV5q0h1Xnm639IgGcs9EZbKr76Ba+58yvTcgeyngiH9du/ZM47d6/J4aY10VsOSrVSD1+6yzDPg/76G0MTU5B6hHhflnPjAZsaJw4CkrqR5olzLJFP1dywpfgFSk0KsvdCXFRbsxruGTxn00g0GgCJC+7k24/yZ0Bxzxe2KOTlQkvMc9y8g+J2x2BYGISmZuZLY6ztKyxH+AibS6tsou1mD62b+TCnoNTG3ek+tNJnrTy7WaS9jODsviLYIG1Ew7tSBsjukCB1E2OzQMYGuI9NGSgxDbQt9byD3fIqZQO63J4TChBm2TZedPyNFY2Bs+xYfWvxFeeBmeSqDCgbD2fWftZ++uoP6dmcMuCpNfXOpDq14E7+zr1V4PjAskA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6804.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(1800799009)(451199024)(186009)(2906002)(4744005)(86362001)(478600001)(7696005)(6506007)(71200400001)(107886003)(33656002)(9686003)(53546011)(26005)(55016003)(5660300002)(52536014)(41300700001)(122000001)(316002)(921005)(66946007)(66556008)(66476007)(66446008)(64756008)(110136005)(76116006)(4326008)(8676002)(8936002)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UU5MbFhNbkY4WWpBS2hNcGRobjNiTzUzWmUwd3dHdklZcWlCUEVsZWNlZWxh?=
 =?utf-8?B?Ujk4NzgwU3VxRTFLalBKM2x5SHZRUjczZjdFUHljVEdHdS9ZWWdmQ3FBSnlq?=
 =?utf-8?B?bGNVTXdRUzBsZG5KMjN5TlBoYnNPWTBPQzZwWXBiTVJOVm1WNzE2NWl2MEpZ?=
 =?utf-8?B?ZUl2U1gwUlB2U1lMUVJaaHlHTENxTjhRRUFXNlBOdHFEbnRVSTNkM1dPOGNH?=
 =?utf-8?B?c2hhMEhrSG9IQnJaWC96V0Y3aE93ak02bVdXVWQwMWRCaUFXUURwUjdvaEFI?=
 =?utf-8?B?dXpDbmhEZk9mdVNDVFowMVlNbE1KUmVCNjlJSVkwcjcvOWZXVWYzdEJwRi9m?=
 =?utf-8?B?YUFvQk1qUkJHdVV0UU9FZjdqRTJzd05EYUZjZHNxUEJ3ZVNyQ1NYTWRsUzZa?=
 =?utf-8?B?WWpSTldKWEVUV24yYzRxWlI0cjQ3QlJ4RDgrRm1reno2cDJ6SG9oL1JMdTFH?=
 =?utf-8?B?Mjh6a3FRdnlMM25vdURGVndDQXhONkpNc1ZFblNYWEg1clRzN3ZYVlNnQUtQ?=
 =?utf-8?B?TmY0dGw3TEM0ZFo0SlVpYjEybXFwS0QvS2dzaVhvNDRpb055QUlEWFNncDEw?=
 =?utf-8?B?YmtzWHVWYzMwME5mVXk3TEhIWnVhOXg4UmNCaE4yYzUrQ3VCbDFHSmRnYm10?=
 =?utf-8?B?djNXQmFkYUlVRVdhL0oyYlQ2VktQdGRjSDRYYnpHNk1rVUhDVW92RW5zWGhj?=
 =?utf-8?B?S1JSY3Z1WUVkUjJJdzdaWnlZTEN3Q0hTODEyK3JhNkMzbFlJRWVINnFEVGRY?=
 =?utf-8?B?QnNVU0x5SVgxdER5VzFMalo0cDVBU0VTZUxHK2VWNFhQYjRDOHFHRWMxNVdK?=
 =?utf-8?B?UW9naS9UbTdOSU82eG51UG41OVV0SVpsd0xBOEIwM0dpN0s3NXBLQ25zUGFC?=
 =?utf-8?B?KzJENjAvbHV3OU8vQmhxNENGVEZ0Q2pwTnRjMUh1R3oyVHBIMllwMWFQTTRn?=
 =?utf-8?B?a2lJWWpWRVZ4WDF4NDVGUzRmK3lYaXhkYTkrQ2hyTWVROTFTc1ZCbmpkSGEy?=
 =?utf-8?B?eVNEblVaWjBzS0hpNVdJSmRldVVQNWhzNlJBTHdGSFE2Y2orUTdDUVAveUZi?=
 =?utf-8?B?UGgraFNzYll5bWlpRGt2dDhSWkNlRW55TVFLTFdRNjh5UjQ4TWx5alM1VkpU?=
 =?utf-8?B?QllxUFRDTTgvM0FzMVRWS2ROV1hIcnovN0xpRmtwMkR5SFU3TGNKeVVRTDJW?=
 =?utf-8?B?ZlZSVUE4bEgzbE5yNGVCcm44eExwUVcwV2MwMmFPSnJsejF2Y0gwRGxudml1?=
 =?utf-8?B?L2lUT3F2UEZBN1FJdEpqRWlEQURxNWpwUUsrRkdiUVR6ck1wSFFRYmNZNWtl?=
 =?utf-8?B?SHc2MnJmL3ppdmJiVmp0SHRkditxTVYwcmJ2TEs2YktSTS93RTRjQXFaV3pq?=
 =?utf-8?B?YTdoelFKV2ZoZlpYcnZvOFNib0dSNTk4TlJOMDVaUUVQZ21oTTc5eHhqSHdZ?=
 =?utf-8?B?WUR5QUY5bkRmSDdOZzZqRW5qQU5xU0xmZ1VRVTdsWk94aW5QRCtadGtIdENK?=
 =?utf-8?B?YlJ1SHQ1UXAvY1FKQzJHNFF1MElzbHFYYjVUNzBNS2lKWlNnTUROS2R3dHk0?=
 =?utf-8?B?QzdXQW4rNWxOeStyb1gxbmNkQ2dheS9DSlUvaDZyWTZJOGRuNE9hZzIzeTA1?=
 =?utf-8?B?cDVmQUdRWFZjNllNeVhscTBJa0ROQWJ0RWdvR0djaFNrNlhJY2c5b2lSZ2hs?=
 =?utf-8?B?SzR2QzdEYWs4WmZyR1EzaUtmUjlIMjNxd05sOWhlYkpzbzdFcGVIRStLZUV1?=
 =?utf-8?B?ZFZUaUJsY1Y3OHU2MW1nUGU5dVQwU011cXpyWkZhTkJBZU1KOE5UOGtVS28w?=
 =?utf-8?B?d1VONjdjbUNUVzJ4UDFqOXpCclVyL3ArRmJ6cWN4RUZ5eHdlRmxVbDdnKzJF?=
 =?utf-8?B?MHZoTzNXV0xmQ2NHL0V6KzBtTm82eWJNL2hNS3VWMGVDN24xSVdOM1dqaVkr?=
 =?utf-8?B?TVJPR1Z3QVRVSHFuTFJGZlMwNmpqZGRrcXNrUDdReWx2cklSSW8zeHc5L3ZT?=
 =?utf-8?B?eFdKYmhXbUdNeER6RmNEK3piOFZBaUVVQTl6NkRNemxDZVp5cUltNHBTbVJ3?=
 =?utf-8?B?dDIzVDA3SWhpVUlkbmJyMHE0Z3RYRDY1UmZvODVtUElKMDNIbU92SEZlLzRO?=
 =?utf-8?Q?MIgOqAUT22w4LGeKsvK9Do4lw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45870b72-c82f-42fc-42ee-08db9e37ea3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 09:05:19.3117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vRlg09I4erMxUCXcRg87ue0j8/DX39QBocRY3MnQKIasX3PV1eQjgUP8h5LE7mAhlFaunc+WplDEOBex0uc36FFJ/l/WQ9IqSaacOW+RgFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6007
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2xhdWRpdSwNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpIaSwgTWloYWksDQoNCk9u
IDgvMTAvMjMgMDk6NDcsIE1paGFpLlNhaW5AbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+ICsmaTJz
MCB7DQo+PiArICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPj4gKyAgICAgcGluY3Ry
bC0wID0gPCZwaW5jdHJsX2kyczBfZGVmYXVsdD47DQo+PiArICAgICBzdGF0dXMgPSAib2theSI7
DQo+IEkgc2VlIG5vIHNvdW5kIGJpbmRpbmdzIG9uIERULiBJcyB0aGVyZSBhbnkgcmVhc29uIGZv
ciBoYXZpbmcgdGhpcyBoZXJlPw0KPiAjIGkyczAgYnVzIGlzIHdpcmVkIHRvIFJQaSA0MC1waW4g
Y29ubmVjdG9yLiBJIHdhbnQgdG8gaGF2ZSB0aGlzIG5vZGUgYW5kIGl0cyBwaW5jdHJsIGhlcmUu
DQo+ICMgaTJjMSwgZmx4NC1zcGksIHB3bTAsIHVhcnQxIGFyZSBhbHNvIHdpcmVkIHRvIFJwaSBj
b25uZWN0b3IsIGFuZCBhcmUgZGVmaW5lZCBoZXJlLg0KPiAjIFRoZSBzYW1lIGxvZ2ljIHdlIGFw
cGx5IGFsc28gZm9yIG1pa3JvQlVTIHNvY2tldHM6IGkyYywgcHdtLCBzcGkgYW5kIHVhcnQgbm9k
ZXMgYXJlIGRlZmluZWQgaGVyZS4NCj4NCg0KQ2FuIHlvdSB1c2UgaXQgKGVpdGhlciB3aXRoIHVz
ZXIgc3BhY2UgdG9vbHMgb3Igb3RoZXIga2VybmVsIGNvbnN1bWVycykgdy9vIGFkZGl0aW9uYWwg
ZGV2aWNlIHRyZWUgYmluZGluZ3M/DQojIFllcy4gV2UgaGF2ZSBhZGRlZCBpbiBkdC1vdmVybGF5
IHRoZSBjb2RlYyB3aGljaCB1c2VzIHRoZSBpMnMwIGFuZCBpMmMxIG5vZGVzIGFuZCBwaW5jdHJs
cy4NCg==
