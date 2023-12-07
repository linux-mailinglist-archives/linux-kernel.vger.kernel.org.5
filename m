Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E54807F6E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 05:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjLGEMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 23:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjLGEMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 23:12:08 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E201B4;
        Wed,  6 Dec 2023 20:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701922334; x=1733458334;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CmLWeZKS56eQJOv54YrdR6g6h9E+jb1/kqmJYpCAloE=;
  b=MyeU1zVAXAU3Uo4fVppYC20dSn/DTrj6PJn2aflOnsGUNvcToue8+2fw
   fLuOMzBUbhf2+FpToTtndbCEuKzVoki6Yh3K+LdFQw8ASua2v6KJuQj6y
   25Id3GgM2WsMr2qprXLuKCEwSlPg0LD2PuF09yJkEBE8EbZsW13coY8IN
   onw8Hq637kRsx2UIfb97nKD5OHu/vEFLHbCV9C3/m5XV32/bbJR9okAAE
   2G+q4sNmRBQXfphOWtaoHVWo5QGxnbBm3bk7eJgA6X6z20cXsPxTmddAe
   W8hv86WVJGRfkzfGe3tK74BEJ/iiW7gw3zLWWpurn5CJQwE4hKXmLBO2z
   g==;
X-CSE-ConnectionGUID: sAIZf3dMTPWGMSKJfhi5gw==
X-CSE-MsgGUID: YD8BhDTZSHK7tp+mLnZ5QA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="243589200"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2023 21:12:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 21:11:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 21:11:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/ewJ31XgqTvOON3u3PO9mLujAAUtCxrWC2PKK8zLXOr7soQhMpyIJQvB5U9mQeOG9ceXnq+yXJskeUXeWop3jeRr2y1u62HQQwop1dLQEJKKaBNy5WlEAva1284QS7FBMwFiHxU7lc0iRKVmiQqkSjVnvyi0pZ8znKwgF7v25LfqwVe1FkkBIVsZZtXXo6dj/a6wiT1DAHdLIVLI0JltQHS8v3yu+282ub5TkvwOO8JAAbSbjdkLQcuteCL8nwZ52QQoSHoVneLUy9UHlQ5kPrgxe9QfwL4+P+ooBk2u/1QMu+lbKPOmOf+1hPxNxrmEVFVRbzShx2uw4AUyeZjWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmLWeZKS56eQJOv54YrdR6g6h9E+jb1/kqmJYpCAloE=;
 b=MXUoiiZlmd47wJuvEaa3u4bbxQu5kHw/vNKv+2yojX2cRZ4M3xtUBRKHCFuUPW/RQRF9LeWPUaX3C3MVlhy+r3s8yDf25lh01/aU+UTuuAN0MP2Y306np9RxxIngeKYkKmQMf0sFfwnjtm4+yKiROW5a7QEQYvhueuGESSxnZB6N4NBcLFvfBhsj9iDOXep4gjuafdvf3VPIr/iBv3ILX6qSU7NxprlfM1q16C6OHJlEICUFthD3dmHp4oXpwVmPDRkTt5BOPMdxmYufBPQvU7NpIV03rEn1hP2Pt1wfGK9C9NgIZffExnsAe2qksNGK659FIZCRuHZceVzj85WkMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmLWeZKS56eQJOv54YrdR6g6h9E+jb1/kqmJYpCAloE=;
 b=eFUAxTCOvNEwSX0xikUH6oVnkZnbg8jI7vWAwaiHGjFo4S7ri3xZWQGdAzqZ3T2sa62jzMEEE605dsygbOgF9n8shGAfocFZJRDKA7DAka/jbSJoIO2vNgmdN7I/vcftcf/i0izgLfhrAMcDWxus/6RSsnz/4S7TFIY468EkBLRTaaST8Ni+hoZFicsvz2Y5OkhBjee/DFrfknMypZ+MUgxI3v2XgFx8aUFVYPAtBYrhK+4dXbqcvro/OYqZKJfu/b+HptGpCG4J5yxt0xZhB1V5/waXzQrgXFMw/LEooBeYUl75YoxFuGX0tLoIst1o355Ja78z0RGVYaWSb+uYDg==
Received: from DM5PR11MB0076.namprd11.prod.outlook.com (2603:10b6:4:6b::28) by
 SJ1PR11MB6155.namprd11.prod.outlook.com (2603:10b6:a03:45e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Thu, 7 Dec
 2023 04:11:42 +0000
Received: from DM5PR11MB0076.namprd11.prod.outlook.com
 ([fe80::4f7c:a191:fa1e:6fcb]) by DM5PR11MB0076.namprd11.prod.outlook.com
 ([fe80::4f7c:a191:fa1e:6fcb%6]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 04:11:41 +0000
From:   <Arun.Ramadoss@microchip.com>
To:     <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
        <Woojung.Huh@microchip.com>, <pabeni@redhat.com>,
        <sean@geanix.com>, <f.fainelli@gmail.com>, <edumazet@google.com>,
        <UNGLinuxDriver@microchip.com>, <kuba@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next] net: dsa: microchip: use DSA_TAG_PROTO
 without _VALUE define
Thread-Topic: [PATCH v2 net-next] net: dsa: microchip: use DSA_TAG_PROTO
 without _VALUE define
Thread-Index: AQHaKF2b+ISnpmOIcU6Qpm2wbeTU5bCdNjGA
Date:   Thu, 7 Dec 2023 04:11:41 +0000
Message-ID: <6f6aeb6233c58e929aa2b370a29882f24447b947.camel@microchip.com>
References: <20231206160124.1935451-1-sean@geanix.com>
In-Reply-To: <20231206160124.1935451-1-sean@geanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR11MB0076:EE_|SJ1PR11MB6155:EE_
x-ms-office365-filtering-correlation-id: 1660a68c-8edf-4776-6195-08dbf6da9e07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p2ytC+n6p/ZH1Udz9bHSedz+tPQ2ccSmFObPiE4epPUmERW0+n8x2l+BB6OCbOnVnGs1Ol1z76mHXnirjhTs3Gzbggus2ex2Jhc25e9Kf8xrS7R8aBT1FxS7T9JOelhxUDd8eAv9zsw1SdfpN2CjLzX5VuIOPlMJuJaPhpG10a54Ipf5UjI1yEOyvWrLTZns2SYKDpTyPJ8pGq3fGyg8HJAPvxJPtQuibp9sxu67ssV4GOQ7U9kGSU/0wE//jCzTQgBfzq6vpE1c+i614ynoYd0xnjptgs0DXaMQ7eYIMVcRjLcgkuoKldXIpwDH4oljuMvJYVoia4F/jZn6ccNupv0/9hru5BpcWC1lY/H6zUvxbPm+KMjmEVyz6KkjTTd/FrVy/4K5Mqo1diS/GAbgrk2rF7Fhh8SaClYJ45xYwzrWcuEUNnsz3UlvrL3xbxWVkuiesxjUD4dOuzo+O7qMc+MPOLn2/Ap+goppkxJQX/z3q20zViD4eCswF9eCFK0lYkqDnOb3W3FucldBI5pyYGairSVq7UjSUKjFWm3MbWzu+JqKsCiwQsnE5X5dtFqdhqEW1jodx1UoDc6jGKXTrxvk7HvTEus45JtWUXSgpGgu4dQLNcH59Vcoh/tZfq5wnQLAfnR2gJ+p9sJNb4FWRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB0076.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38070700009)(5660300002)(2906002)(558084003)(6512007)(38100700002)(122000001)(7416002)(921008)(2616005)(6506007)(71200400001)(26005)(91956017)(66946007)(478600001)(36756003)(41300700001)(66556008)(110136005)(316002)(66476007)(64756008)(4326008)(6486002)(66446008)(76116006)(86362001)(54906003)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0grZGRIek1IcmhDY3k5Smw5cEFDVnVoWVZiT2tESUJ3dGxsQmJVU0xtWTNL?=
 =?utf-8?B?RXlHMGNiZDY4NktkM2pZUUlldTJ4MHRnTG9rVUNSRFBMRjZPUmtudjNzU3M4?=
 =?utf-8?B?L0V0dXNNa1JFMEJvcUY4N3hLNWNoRU1GLzhKNys5SmJ3UWRkaHdRSlVldllh?=
 =?utf-8?B?K1pNOWZTS2l3eUR5M1BKV295Q3BKRWFlKzFHWHdIb1dMQ3VIdnY0Q3dCLzRL?=
 =?utf-8?B?TGxiQnVXeDNZQ3Y0SCs3VlFRa0gyaTdLVStZT3VqUjhTaHpFazk5Z01helRL?=
 =?utf-8?B?NGczaWI1WTlaNGZUTzNJUkJhRzhwRDlhbEtBNm1wODlrZU9JZ3lYT3E4K0hq?=
 =?utf-8?B?Vk5mY0J6eGNzeEk2bTB3YXFtdksrTHJwbjZ6bHFGMGhyRXhRdFJ6ak90QS83?=
 =?utf-8?B?bmVVVEk5bEVNSjJiaWNxb09PZ0hYeGVsQlVTQ2JBazI2emp2dW1zbmdzVVVE?=
 =?utf-8?B?eVcwMitzYmxKbGVkV1d0cWRLN3BHSkpxZWt5Z3YrR0haZjNBQ0ttVzQwWUV0?=
 =?utf-8?B?aGVXQlRYWk1MbFcyL3NLa0srdVVIdWg4Q21SMjdvTDRPUHlQTWs4eml2eEN1?=
 =?utf-8?B?cUZVQzNzTDdPTlRGQTFObTg3SGI2NnVCZjdxUzlkbDFxdDRnQkkvUE5ZQ09r?=
 =?utf-8?B?SFd0bHphVmRYZHVjdTVZUlpSMGVQQnR3blBmR1NSZysvYXE1S3d5MUZkRmNS?=
 =?utf-8?B?SFc0U3loTVU3ZENUR3ozU09ST1lha0FFSWlWWHBRZW5kRlBKU0xDQ1VtS1Zq?=
 =?utf-8?B?Si9kNWYwc1FqUW9YSk5jbThxQ2xDYmlUWURDWFo4Q3RVUjF6QVZ4SDFKWVRk?=
 =?utf-8?B?NHB2VHlFc2pMenhFRTdaeGVJc0Z5TkdOZEVIV0Yvdmtnd1hBSXpMa0ZZMGw2?=
 =?utf-8?B?SHp3bjExS0lkYnZKc0lub2FmZi9KUldZVVc4M3VUbWlNSVZaZVJSREtzaGRz?=
 =?utf-8?B?Qm1Hc043K3dramY1VmVWZUk3V09yUTU4WEN6eFQwbFhhL2QvWG1NMDczOGpi?=
 =?utf-8?B?S2FZMFhpRkErZVJ3UUJUQnE3c1IrUlFqQk9VdXRycFFIdTFUblZrMlM3U0FX?=
 =?utf-8?B?ZmVGNGZaK1VBTUc5TVcraHoybVhGYmVONUwzRTlhUyt0MUZOZk5vZjBEaXcw?=
 =?utf-8?B?S0VrWWR1dFIyUFhwbHcxaTNPK1VwQmVkRWZyVitqTFpnTWlsRUp2MUgzdGM1?=
 =?utf-8?B?ZzBNL2NRSEtHd1FJc1c1ZlpPNm43NVNnQ2VXL3M2Njl3VGNTbFZaYUNWK2cz?=
 =?utf-8?B?THE5amcyT3A2NVJTTW8zS25UZldiU2VNcnQxQ2Zzb2hqaEY4Y0R6RUdpZ2F5?=
 =?utf-8?B?R29SUDNqS2VvK0xGb1hKV1dIV2t2c0Z6KzBxSE1WTCsrWkQ2Qi9Sa3dyTjVH?=
 =?utf-8?B?SEp6RWVSTll0QmxHUGZ4Q3lUbHJaS3NrV1ZmZUZIZzFZanhITkJoSUMyd2dL?=
 =?utf-8?B?TFQ3SzdycEdMblhxRnJZRjZBNkxXUXRDbml0L25FalZNTzlyT1NBbzd2cGVT?=
 =?utf-8?B?aDBkbjlEZFV1NEY4eW1LVFl2bjRuTjJzbkdMU1h1bnFMNnlhWEFicDFseUhz?=
 =?utf-8?B?U01Ma2ZTQWdXZVFaVlJWOG9tT2hsZlFYZmdWL2ZMT3JnSVA1ekowYVczTDVI?=
 =?utf-8?B?UkJqNjlrTjJ3TmozY2ZWeVlRNEx4cVdKa1hLZUloOXh5RkZQYmtNaWN1T1l2?=
 =?utf-8?B?QUpGTkVQa1hyaEtkN2NhbExEUk5YRGt5ZC82MlNOS0swSGEzTHNiM0JxN1JR?=
 =?utf-8?B?czVZc1hkc1VSbHkyREFrUDQwc2JwL3JJc0ZYOXBaZU5vM1FyWmd5U2RUdnpO?=
 =?utf-8?B?REx1dHJabUhIMXNTdzV4SXV2eUU4eWVMUWZIVm9paE1RcmVtYlQzLzZGNWdE?=
 =?utf-8?B?SlRtcERrYmVDT3YzOWw3U3VaY1lmWXR0R0NheWR6UXJXU0Q4K0RpaGgzTVFx?=
 =?utf-8?B?TGp6eC9tTmJwOE5FVTBid1A3bW1KbHMrdGdtWWxKRCtKMzRGQ01aa1YyNW5t?=
 =?utf-8?B?YlBCWkNtcUhua1Q2dlZOUURPcFN3enpscnBkTjdnT0QrMmR4SkR5bGdBbVEy?=
 =?utf-8?B?d1g0YWg5WjYraENGZExFc1JTSVVvTzRUK3BRU2VvUFh0NE1kcUY4YlZxQll6?=
 =?utf-8?B?MTViRTlPMVZqNXBlcDlPRG44M0IxcWJKQ0o0Vyt3MjFhN0t2VVJXdllpWU9s?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9EF47A7BD3B7D45ACB73E9ACCAC1F88@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB0076.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1660a68c-8edf-4776-6195-08dbf6da9e07
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 04:11:41.7206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v7t2UKdxkPIoTUYmPp/kLOt2ASAG+7g3mYIVPjhfvMb5gHzmyMGGnD6O/QSuoNDqKQK11DnWhcaNigb38Mpe7nKsPy6CMKkLpd6hle0lOPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6155
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBXZWQsIDIwMjMtMTItMDYgYXQgMTc6MDEgKzAxMDAsIFNlYW4gTnlla2phZXIgd3JvdGU6
DQo+IENvcnJlY3QgdGhlIHVzZSBvZiBkZWZpbmUgRFNBX1RBR19QUk9UT19MQU45MzdYX1ZBTFVF
IHRvDQo+IERTQV9UQUdfUFJPVE9fTEFOOTM3WCB0byBpbXByb3ZlIHJlYWRhYmlsaXR5Lg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogU2VhbiBOeWVramFlciA8c2VhbkBnZWFuaXguY29tPg0KDQpBY2tl
ZC1ieTogQXJ1biBSYW1hZG9zcyA8YXJ1bi5yYW1hZG9zc0BtaWNyb2NoaXAuY29tPg0KDQo=
