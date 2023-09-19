Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37A27A6184
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjISLlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjISLlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:41:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451FDF0;
        Tue, 19 Sep 2023 04:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695123674; x=1726659674;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vja66ddGBqS5hF5d/gmS1HbIvYq9Ti2+lR2TmFhOu6Y=;
  b=WCraDXFrTT9d9wXFovBzlfgxZEJtkx8zmdH5SpsH4hxUObGwwWiSi/Nm
   6MDWY68G8e988L7f8L/4AhPTe6brS0NbPsFiWnKe7UE9D8D4eX6AM5bJ9
   sAhWp7G+qCRyW9F+6KNaPEZBLibDuJA7QiOMjBK2tcMKqSD5JD8j1GZIy
   e1dKlvmlZM2/jRToVhIHIAstWC/4Z7h6ZYYmVnRvH66KSlwLFRYmTGndX
   wAZ0ZDE60uoehz0fe/sWF/WR/lglsI5Z+icOIeZqBB+OqU3oogW9mY7xT
   +LqlrfN+/7uw9YJGbFtzokQmLBPx3lHyCTJFGa/qO8u8wdPhKwDZ6kaLL
   g==;
X-CSE-ConnectionGUID: q3zJodK7RomRx5Yv8O08tg==
X-CSE-MsgGUID: z5JwK/0cSWma345qx41AGg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="5588327"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Sep 2023 04:41:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 19 Sep 2023 04:40:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 19 Sep 2023 04:40:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4nVlfWtVd1e9giJUmB9SXdxwmIYJwqcSO2p2cT89+Xdc33xkvxJHJboANc+6RdpkEckW/z64O3pNy8aY5jQIEUn0IqcP7qytB9i+A4LMySM3I+zKm0LSgJasLVAXFXLONx+t8yaBSRu6kp6nCZYQtRD5RJyE6uO8/dLdfjeRerzwXnte4w2nrvfB1aFmxfZFu2xQyyLjE6TfGjylcWl/09WqWawSlR10VUF/Sg3acHZvw/iF0uXQjzW/hauS4nF0xcsnTenYJ0au+MpKnaj2WPe+REZ4HVhmtAhwsDg97ECu4TojNcgkTaOG5qZ1RZqKhaKgFGxaRUtJHgXyk3H1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vja66ddGBqS5hF5d/gmS1HbIvYq9Ti2+lR2TmFhOu6Y=;
 b=ezkVYLg9L7+KvhVjoDY1cTXqMrNhUCOvYeo2WnT/dgMU6g6HuGLmuiBIHUd7tuZ7EsfpeTY+RLSCgmmcFf/Bud2dgCw3nbHBnzmref5XpZvNs/ygsjFh7G2AQ4BDuXefl0DZJpDYuRztlhUDS47aqm4X6MFz502ieSS1goxwoirtzI4rXLaIXYstm3XaJ45MDEzYnJ+DteZG7w5PsZyc/VDje6h+LAlobVKlc5gryo6WGrvh+WICVjVN0iesZPXchEBnFAnqnHUto0IwZthACz9rE2NoYVLtZb/ds9v459jj3hWQQs6aLpih2fRuDkhw24lu6InEPWSdoW503+pucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vja66ddGBqS5hF5d/gmS1HbIvYq9Ti2+lR2TmFhOu6Y=;
 b=HltNAJvCt763KCnRKARX/G8veho0DBB0FIHs4LjvDJrtQ4OyY02bON/qHFSjM+kHcyK/MC4YdwpOld9BTSy725xNhbhtVMD+NqWtip+qZNazqOSA5diAnPvM6bW5mRc2Or89/7KAFk7pphiKPt9Ody7NE2pSnSNaBqdKkeRDCak=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 DM6PR11MB4659.namprd11.prod.outlook.com (2603:10b6:5:2a5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.28; Tue, 19 Sep 2023 11:40:37 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 11:40:37 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <andrew@lunn.ch>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <Steen.Hegelund@microchip.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>,
        <casper.casan@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
        <Woojung.Huh@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>
Subject: Re: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Thread-Topic: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Thread-Index: AQHZ4mEB+nwP90vbvEyYqcmk7ntkibAYAM8AgAoWpAA=
Date:   Tue, 19 Sep 2023 11:40:37 +0000
Message-ID: <4a16b2f2-5a98-8567-5972-4e2cfa368f0d@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-2-Parthiban.Veerasooran@microchip.com>
 <2464017f-c023-45f7-8eee-6541593e6a6c@lunn.ch>
In-Reply-To: <2464017f-c023-45f7-8eee-6541593e6a6c@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|DM6PR11MB4659:EE_
x-ms-office365-filtering-correlation-id: 079072cc-ce03-40f5-62d8-08dbb9053e29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wamskmkFzALSLTKal1ghHxQ+V4YGU7Hui/xckeKjO4v1Xv6Rs3vCRvG0ufOEYgeQuVBbvFMWA+NHX26+Ba4850ALumv1P6zBT3EPoNFDUUlHAQ+WD76xMGHRQzCZ778oEGNofj2jeSMxHxia0w+OAgiuOnmsI7MPQxd3Rxspbv0drhmzfW713OyQ+VdFGaDn8f7W07cX0q6dy8Ea0k/n0s7JMxvgfJKmKpEJ+7yKmZH40ZRi2j7O36qI9KXEg7kOGsTUPRKrfUdkWPP+bkfkeIyaibpYB/WXVVTMDswZpJBxNAsLt3OpMXMWYfffdNQBDnK6ZFvyortNlz3tuqf3jcs8yp+s9GJZxhuzmMXp7avuPyxSh8qjWram3pMnytpycKWNzYXIZKdb2ewpQuMr1QCZ6UWMExYENLC6f4i0OES9AvkQeNGP93Cqrt42G9IWPoz9f3NQ015H2lfhsspdoKDQamiBTPxoUI3LbrQ+S+re/Na6VKT9WcnDFcHtJOQN1sa+N4oJanNLpvyxbAnjgIxu4WvbivDEi1T7thh9PUymZFL0s9rqMNK5o4ZPfwPJ0V+yl8jd/DhA01ZhYCWSQKSax9/F28Klo6bHwmuCH+rQZOs3Fhf/FC1FlitSBzmrhOZeWqOemx7p5tl3GUWGdfYLrH50AUdHU1SD+73oJ8Bq58klqzvZOSoB++IInYHf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199024)(186009)(1800799009)(26005)(107886003)(2616005)(31686004)(4744005)(6916009)(64756008)(54906003)(66946007)(5660300002)(76116006)(316002)(91956017)(66476007)(66556008)(66446008)(31696002)(7416002)(8936002)(41300700001)(2906002)(8676002)(4326008)(86362001)(38070700005)(38100700002)(478600001)(36756003)(6486002)(6506007)(6512007)(122000001)(53546011)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUhaT1Vpb3QzbzNiazY2aFhGMTcvNVlOSWMzcUpYQ0VEaTFjaDFvTTV6RXhq?=
 =?utf-8?B?K2krUDVFblEveHhiMlEyUEF4dXJsSE5OUDJlVzRha1JnT2MzTHhwVGZWRmtE?=
 =?utf-8?B?c1ZiSTRUZjhyVHUyYWNUTmUrbG1PVnRBUGdxTVhUU21lQkxIVC81QzdST294?=
 =?utf-8?B?Y1VvamVBUDBTcG9MckhpQWh2dmhCWnBYNUg0VlZlMjEvVmErcnVRY3NESHpR?=
 =?utf-8?B?L3lXR0NjQ2tEVm5GM2tBUndIQjgxWmFxVDE5ZWw4bS9UMERzWWxrWi84NWJh?=
 =?utf-8?B?UFJkSEJzNERDSnR3aWRHY0lJN1FqMXJBZCtBU2p0QW9Ua0QxbS9JSE1la0Z0?=
 =?utf-8?B?VVFjWENEaHY5VHg1Z0JLRlZWcHdqK0FVNWNIWVNaekxabjdDdlpZTHVXVlpP?=
 =?utf-8?B?ZTZXWmpvMTgzRGtaT3F6bWk3SVdnRXBKUmw4YWJpWVlyQVNkMG5xczFBTGxL?=
 =?utf-8?B?dzJzdnp5ZWl1QmVnR1FreE1rUmNvRU91Qk04T2VZUXdXdWtqajk3dnlsNHYz?=
 =?utf-8?B?NFNjQk1RNTg5dWxGSG1NcG5aaVFYM2d5VERCR2RrYVVFM2o2ZDFUb3drTHdk?=
 =?utf-8?B?Qm9WSE9KT0lDREFGNW5ZeTZ4QS9PTkwwNEVaMW4wckNxUzJhVzJqNUM2cW1h?=
 =?utf-8?B?dGFmUC9iOSs0ak5OSVlzT1dlQVF0ZWhrZHpmV3cwQzNTYjRUNVBLY3AvSDFS?=
 =?utf-8?B?THptNnUzemFsSStTYzRrZW1YSjB1Nkk2anVMVjJuVHI1UFRKRm9uQ3VYQXlU?=
 =?utf-8?B?K1NHdGxyVG80UHpLS0JidGsrRjBCTWNRYWwvUUdUZ0ZyL3hkOVlGN0E0NFQ4?=
 =?utf-8?B?U3VsbHJFSjdOamF3MGV3czJpNXNmUlRxanJKYzVib2RPWHd2Vk5KOUdFbkY0?=
 =?utf-8?B?cCt0UTZRZVd2eUdodFZJaEt3VTFBL3NTVzBVK1c0YURDUFhic0MwYU1BR1pU?=
 =?utf-8?B?aDdtQ1RncjJSY0R3ZHlEbmg0Y0RxckMvcGlVaHZCckI2ZGEvZnI2RzlsNlBi?=
 =?utf-8?B?QzNQVEdjc1NvQnQrNWNZRGZVbk1rOGU4Z0JrZ1ZZOU1VZ1JVZGhFNFRBVnA1?=
 =?utf-8?B?cFQrVWxtaXJpY0lBWDdrMXJPVHFJQ1I1T0dkT1FsU3pFcjBIb0tRS3orY01t?=
 =?utf-8?B?T2grQTNFMWE0a0NGbVpuYnBHSFp1cHhUdGNEOVEwOElnd2MzMUlOYUFqWno5?=
 =?utf-8?B?cHp4YWxPeExjZ1BOMFo5aVVGRFlMTS8vdFgrUE1QdldsK2VOQUNiTXdqSU9v?=
 =?utf-8?B?dk4vTCtzNlpYZ3o4eEpQcnRETE5NRzJKaThQckNIN1AyZ3Jub0U4dm1VazhI?=
 =?utf-8?B?NVNUalJtdDlQZ1NlREVGR1d4RTFOZEJNSW9qdlFabG9QdG9PcERnVWRmSGQw?=
 =?utf-8?B?M0JRcFpCTysyZUpZaGY4WnhDTmlRQ0UwakI5VmN3ajlhQ1Q0cEJXWmNEeUVs?=
 =?utf-8?B?eDBwNkx1MDdhbUl1M0tsaGlWOGJ4MUxpd3FsdTFiK2dVdlJSOFRHYTZlM0pY?=
 =?utf-8?B?TFRxSTFsbm44WER2emwrOWJKa0Frdlc3VkQ3YXRyS1RPNlR0RVpMZEtuUGVY?=
 =?utf-8?B?UDlSd1R5SjhuSG1EdW1ZcWlyaDlNSFMzTVpxTHNQWGhQaC84VWRlMHB6akIz?=
 =?utf-8?B?L09CSHZJUzRsOEtUam5ITmRnM1ZzbjZySzlXV283THB1Zy9wUUdkZUxxWE1y?=
 =?utf-8?B?eUliOG15L3V2V1BWeUJYeWxYbDVoa2ptVVRPTTQ5aGRQcmdJY1EyMHNFUUYw?=
 =?utf-8?B?bDl4QzFsV09WcHBJMEhUNzl6ZUx4QUdzTWM4Y09QMDQzdkEwdmNZTzJ4Y05v?=
 =?utf-8?B?Vk1XcHBoTmpDUlp6RW5zYVROaEM1eGliR2xZUC9NMS93MmxLcndsd2Irb0pz?=
 =?utf-8?B?ZGFXSkNwOHdFVHUwdExOWU5aU0JVQ3pVTGxoSmFDYUdKK2hOYTRaaWE4NzNO?=
 =?utf-8?B?NFJDZ3dNSEhZSHA2T0dhbzBaL21FenQySmVjZXUxa0FJcjFCZTBCakswVlMz?=
 =?utf-8?B?UDFSWENwcGdlSEtaMjFUZTZaa2NiYnk5QWg3c0llbmIwV0ExR0lmV2ZwMUN0?=
 =?utf-8?B?NkdWR3B2amxuZmZqOURiblF6bGw3UEh3OVIycWxIWmNIa0VCZVRQaVVjMHcz?=
 =?utf-8?B?SndUam9WYnV1N2JHOS9tVElyZHRNdXduUkpoZzZBTnNDU2xxeGFIRkdDTmFk?=
 =?utf-8?Q?fCJGS4UeccR+sjOwuqXgzuU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03FA6F08F4F9FF4581DC151808AFC1EC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 079072cc-ce03-40f5-62d8-08dbb9053e29
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 11:40:37.1701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /W2GfGMLUpXeO/QN/hV2J2n3X/wLZzHa903bb4nu/Z7SJoNmT8KunGO/jNNwzV6NCbFlvuWFPD2R4VeQsV0wyMvKtGhpit454VTUXoJpLvkqkpIfyV1PI/O2jTRnPnY4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4659
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAxMy8wOS8yMyA3OjA2IGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gK2ludCBvYV90YzZfcGVy
Zm9ybV9jdHJsKHN0cnVjdCBvYV90YzYgKnRjNiwgdTMyIGFkZHIsIHUzMiB2YWxbXSwgdTggbGVu
LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGJvb2wgd25yLCBib29sIGN0cmxfcHJvdCkNCj4g
DQo+IFBsZWFzZSBhZGQgc29tZSBrZXJuZWxkb2MgaGVhZGVycyBmb3IgdGhlIEFQSSBtZXRob2Qg
ZXhwb3NlZA0KPiBoZXJlLiBUaGVzZSBhcmUgd2hhdCB0aGUgTUFDIGRyaXZlciBzaG91bGQgYmUg
dXNpbmcsIHNvIHRoZXkgc2hvdWxkIGJlDQo+IHJlYXNvbmFibHkgd2VsbCBkb2N1bWVudGVkLg0K
U3VyZSwgd2lsbCBkbyB0aGF0Lg0KDQpCZXN0IFJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4g
VGhhbmtzDQo+ICAgICAgICAgICAgIEFuZHJldw0KDQo=
