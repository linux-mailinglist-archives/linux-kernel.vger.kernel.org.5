Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161A17E43AD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344044AbjKGPlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343999AbjKGPlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:41:46 -0500
X-Greylist: delayed 78 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Nov 2023 07:40:57 PST
Received: from us-smtp-delivery-120.mimecast.com (us-smtp-delivery-120.mimecast.com [170.10.133.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F389399
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 07:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mathworks.com;
        s=mimecast20180117; t=1699371657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xYoc1TgFgakUybeq18u4nU7JSFLIPU8XMLHh249ELhE=;
        b=O9ZTf4CVG8/3/XtI8jhqi6SmSwqwMDIccNrvvNKPxyA/nrYxPxdDhsD2tcgaSW4DdcE+tQ
        wOJLuaEWUrPuqRQkY/Ooj/9HWjWxhRxHgGrFoRxopZDi5oSeKNTNTmp082Smh+ATFQ7Kmp
        AbCm63bF9WZKz4hs5Ww5I3a30ycFbYQ=
Received: from BL0PR02CU006.outbound.protection.outlook.com
 (mail-eastusazlp17010001.outbound.protection.outlook.com [40.93.11.1]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-kFYkVMpmPSS4h3C8lUnqdA-1; Tue, 07 Nov 2023 10:39:37 -0500
X-MC-Unique: kFYkVMpmPSS4h3C8lUnqdA-1
Received: from BYAPR05MB4424.namprd05.prod.outlook.com (2603:10b6:a02:f4::10)
 by IA1PR05MB10005.namprd05.prod.outlook.com (2603:10b6:208:3fd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 15:39:33 +0000
Received: from BYAPR05MB4424.namprd05.prod.outlook.com
 ([fe80::afbc:19dc:7dfd:f048]) by BYAPR05MB4424.namprd05.prod.outlook.com
 ([fe80::afbc:19dc:7dfd:f048%5]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 15:39:33 +0000
From:   Robin Getz <rgetz@mathworks.com>
To:     "Marius.Cristea@microchip.com" <Marius.Cristea@microchip.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] iio: adc: adding support for pac193x
Thread-Topic: [PATCH v2 2/2] iio: adc: adding support for pac193x
Thread-Index: AQHaB0mtGa1Cq1s1TU+Mw+PCEyAktLBdwweAgAlbMjCAB8aoAIAAJK2A
Date:   Tue, 7 Nov 2023 15:39:33 +0000
Message-ID: <BYAPR05MB4424A16007E7FA7A00A1F00BA9A9A@BYAPR05MB4424.namprd05.prod.outlook.com>
References: <20231025134404.131485-1-marius.cristea@microchip.com>
         <20231025134404.131485-3-marius.cristea@microchip.com>
         <20231027161813.7bff8866@jic23-huawei>
         <BYAPR05MB4424FBC5CFF90F55198C4351A9A6A@BYAPR05MB4424.namprd05.prod.outlook.com>
 <710b749db585689eb959ccc00a0230a5059b424f.camel@microchip.com>
In-Reply-To: <710b749db585689eb959ccc00a0230a5059b424f.camel@microchip.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB4424:EE_|IA1PR05MB10005:EE_
x-ms-office365-filtering-correlation-id: e0393a4f-bb73-44c4-6ff6-08dbdfa7bd9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: fdkcDIZvPh5JJy6adZde+md5FQrVhAmHq3TJFMglPjMKbeVdXt+IlY2S/W1G3yNzjcTW8YGfWwfy77VhJ38IVrhG/vxa3CLQw1oUhB+uQwqUH4/VXqLZH1VzKzGlItbmV0j0Bf6MnPYVz63Q47IKLKpJCkDzOEmvoqbkxzFw5D0bzAVcpMEC4Kldf/rgQyJfP1mg07E3PnAUbgy5oYaFM5qqdcUWQAz1f7MnLq0rdEDYvHsAsl1IhvXO5VrSvdWznf0b4qIgxugudK7mheA5j0CpQvmfLAdb8puGFJCcFRYvZ+lKh1Cvpr26nfYCHIhEudt7qyq1uazklwpw0AJvhBMBWBRYcw4AVhUEBzip1f1wuI1P4bB/ZaRN7XXna2R7YWHcFb4ivyVSWkp2md2WFVkAkb4FLsZI8B7uJLK+l8HHqg+u/PrejH8u2ZQr5a3N1bMdj5WU3cukA3hAu30fAeWwXL3Y1rvWGK5gm4MCxOBKL3RzaRHVS1v7h2Ll0jlB0mXIe/qMjUuFQ+AVnqud1rZuo/BToC9mjQiV1oeG8fGfqCsJgVrQBEa6jpBo7K0KsKMUQYyQMd1MCNDsBSJypCMXW5H6QO0j0QsIOR/Z/eEGeLbG8rOS5ZYpKGteeoLoF4vfeqEVmC74w+mAFKG5MK73ljJEwEGwyNQgTFoSne4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4424.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(55016003)(38100700002)(7696005)(71200400001)(6506007)(53546011)(83380400001)(9686003)(8676002)(122000001)(41300700001)(86362001)(33656002)(76116006)(2906002)(66446008)(4326008)(5660300002)(8936002)(52536014)(66946007)(316002)(64756008)(54906003)(66556008)(110136005)(66476007)(26005)(478600001)(38070700009);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFZKMUFWb0ZiaXFqUkRsWlJtOFR4RzJjNTlMdDhBQ2lobDlNQmhURktHVlpp?=
 =?utf-8?B?bWI2NklqMDRTTktBa1VCa0lPR0RwQzlLTUV4MGtSQVFFRjVnMXE3dWNRUjdE?=
 =?utf-8?B?bG85a25qOFBpK1NYRWJ6UGE3MDcrVnRVL3dMVjUvdW5KenZ5RFlFUytscGh5?=
 =?utf-8?B?NXNwZ3k4bzVrQWl2WUlGT1daM3ZZd2M5K3pLdmtDUGpwZ2dZTzBVYlNPZi9x?=
 =?utf-8?B?dU5ud0JjZDcrRm5OSzlCQTZKUTM4ei9pMzJ4VGVFQ2Z1amdoODVEVG1idk9Y?=
 =?utf-8?B?WWREMER3cmJlOGVRQ1N6SlBpRE1FMTJHeDNMdnJrRWZKbTV0c2RLdlJTdW01?=
 =?utf-8?B?MDh6T0QwVXpVMEJXRXZQNW4zR3hkWThuK1lFTWlIdm9SV3VjbEx5OVN0V2hQ?=
 =?utf-8?B?aWxJZ2FLSFRadE5PajJkS2dBWEdNQVhBMXplMzRMVWVkUHpyTTZFNHJDNUQv?=
 =?utf-8?B?WWt2Y2xjOTF5c1RFOHd4UlhyRlZZYjZHRXV1TGtGNkd6UjZzK0VSamdnQkxW?=
 =?utf-8?B?L0Rvd2x6K1Mwd1NMNEZleitXYUxnVVl3b3BlRjQ4RkE3OWFLSmhRRjkxODEz?=
 =?utf-8?B?WUNzcFlvSisxWFN2WmlmYkU3ZThVVmJYSFRsQlpxSWdRRWE4bWFpQkV6NnJL?=
 =?utf-8?B?UG0xM0d1TGZKN2JUaXdxRVF3aUwyYjFRUGRrUnpKUlNXclN0MnJBUFpoYlBp?=
 =?utf-8?B?UXZaZDhaUUI1QTdBbldOWjFGelZpVGdTdlZUeVg1SjlKU1BSS2k3RTlUNDJr?=
 =?utf-8?B?RzZwVHVTNmtZWnZHYldFWmxOODZQRFczUTR6VmRqMmpRODJPcnVIMFNTU091?=
 =?utf-8?B?eGpVSWlHV1VhR2U4cloxdE1yN0dUMHhSeC9zTFVZendzT01QQm9nTXVDdUNv?=
 =?utf-8?B?Ym5xc1V1Z2N3VGhINDRreVczMU9qeC8zaGNCR3BEaXk0M1BvcHpkTEZMZUhP?=
 =?utf-8?B?MjRJUE42dkdCYUthRnlNT2JtNFVITERrQ1NmbE5IYWR4Nkg1cjJEWmVobkJv?=
 =?utf-8?B?VVBXY2NKaVhZSDFZRHNzNXJmZzB0djMvR2xMUXFHL21HSmt5Z3UyOWxSS2t3?=
 =?utf-8?B?Y3F1QmtPZUJ1R2s2SmVOeXhLclNNL1QvK1M1dkQ2TmI3cDBtbGNDMFNHMEND?=
 =?utf-8?B?aHZDSzNCN3ZuQmdXS0h3eTBJQlNLdy9SR0xyclhSOXpQR0dTMjQyZnVNdVVK?=
 =?utf-8?B?T2NzRWtmdDhpK2djL0E5blc3TXVLdWJUU0lCd2Q1U3RwQzRNci9XcHZTQ25x?=
 =?utf-8?B?VVJUMnVxVHlMdDFjSk02RE50QllqM0hCbXYzV01ZWTY4R3RBMDRlczI2N0px?=
 =?utf-8?B?dDdIejMvL1pWemc2THRpTm5iTUhvNE1YblpnVlphYWRmT1lleEdmVnd3eTlM?=
 =?utf-8?B?RDc0UG05YmVWUktDT1l0YklqTnlHZ0xTbDM1Q1hER0tyNC9ZYTYxS2tpeDNE?=
 =?utf-8?B?SFNpb0ZiTitHTjBVZHc2UFliT2Y1MXE4L3FOb0dxa3Z6UC9DcWRPQ29QT1V3?=
 =?utf-8?B?VzNEOGVJNG8vaVJOZERwaFdheWJwcnJkdUZpNzFOM3BGcGQ4YjlZU1dib1d0?=
 =?utf-8?B?d0lqSUYvNVJuRnRNQUsrTkh3TVN3cko1SlhWeEJIV285QTg5K3NleHcyT0sr?=
 =?utf-8?B?NFlNVTJWWVFHV1dvZEhvdTNqYXNNMnd6MW5wbE5OVHd0Y0VGTXNLb0V6NkVU?=
 =?utf-8?B?UVpJa2xUY3Y2Mjk4Mm9CTi9pUE1JbFN1Y0NHUlJueUUxNmZuZVJzckpyWlpo?=
 =?utf-8?B?eE9IbzlZc0JzejFubm9UdEVaNVoxWW4yck1XbWUvNitYOG5iVmRhNGpGa28x?=
 =?utf-8?B?OE5qdVJkc0VHc3NPbERPZEdGU0VkR0FuQjNMSVFIUE9vUDltU2lEMzRKT1hT?=
 =?utf-8?B?Uk5ab3pwWkU5RzB4ZklEL0gycEZLWHZCMlljTEtvWUJPMEJzTUN6ZmVGNXZY?=
 =?utf-8?B?aG5BSHhmN1J1bXlScDFwUkhmT3F5MzdLU2cvUk9XYzJCQ0VlaklxU1FlV096?=
 =?utf-8?B?VEo0R1RDeWRoQXR5cWxtY1UxOWRFS2doYXNTWjZnaG9GR0pVbTVlRjBZUHM5?=
 =?utf-8?B?UGJIcEFSZDJaSy9jdUZJRXE5akZTdVhWQkw0aGJad3Z6cm5sY2dkVEhpOXpF?=
 =?utf-8?Q?RglxKNgZZOvqhuMvZQylH1ENu?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9gNQD9AAHaQi+UD7UO6cHScmyhX+317Wy9NQJp+ZUOxISDblue8AL5m1q2AC0dZBZhI66RJpls8pFC4RT465hLo1j8MwdguTsqPXedLZKQ3MYkyVEtYocowitUWAE9zh4FIvv9ZbwviIMuXfAWb1V2XfqV+Jh8Zmy+0JL5CZhBbZU/JyaGI61/Cc73eMaNT8d2TCDgaEN7cg/LePunlTLJXQ/HDkEVj2cTqVPS9KXnyFD/K89pQWOz/s2gX+RZMOItbk+uD9YkqTgC5Kh4bTE8zUzUeNMhTNsZVaDDJu9ezB4I0uvvqtx/XP+cfTPV6mxCgwEiapGlDN67r4TqNLf1zb3qgBQsQyy6E08UrYvs4mCXrbGFB+0HftcqrF9AZ+QGx0r1q5chxUhHIWNKkL64iPAe3824pzgkI3wTFwyncoLYr0a7uOx0HBm/zFbRKi75uv3wTJRkj5vJwhvo7mU/sH6iO9eHmk1R1HyN4xbvSSvzMLEe0Nk/2ykRgVjae8QXaVS9gDbaaA0Vs9iFNXuN8U0ybHs7LLAheA1ghwFnjvj/8Qnfn5kmBzCHZoL3BHw+OTOk0XLJhf2jZs2soQzSbyHS1CEQC69NVFWJW8VRnz+LmDBcxDVLvzwP6B2afvKz3zcDXjhhcGjI97Far8Ime/dI8cwjqJLxPjr3cKWNzLoVo5WhDc0SI9LQ16ULEr2+1xbk5SH0WLwaWRZeuI9Odyg1Id9gY4jfxYXHEuOmFSvb2baoLlCZQi5ImPE9q8oNUn7qIzcm/cTvWs0OOETFM0gnUN8bweMUaCb1IyxnmK+PcM3/I3WWugAZ045UMngmZy1/+uhx/18OSei/1avZaCOckq2lj/iA2uKTRgeBzhYIZ1TPrbCLsME69Jd8hXMpbgyZE4DP0er6laLL6oHA==
X-OriginatorOrg: mathworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4424.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0393a4f-bb73-44c4-6ff6-08dbdfa7bd9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 15:39:33.6386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 99dd3a11-4348-4468-9bdd-e5072b1dc1e6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6EPEXoI9vZAuGL+R0u385WkZhpiteANoIt7Z5IBMBZVGaBwbk7nJty8UVwb95c71JNEm33RqU/cDIVXIzgp4Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR05MB10005
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mathworks.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyaXVzOg0KDQpUaGFua3MgZm9yIGRlc2NyaWJpbmcgdGhlIHVzZSBjYXNlcyAtIHRoYXQg
aGVscHMuDQoNCk9uIFR1ZXNkYXksIE5vdmVtYmVyIDcsIDIwMjMgNzo1NiBBTQ0KTWFyaXVzLkNy
aXN0ZWFAbWljcm9jaGlwLmNvbSB3cm90ZToNCj5IZXJlIHRoZXJlIGFyZSB0d28ga2luZHMgb2Yg
Y3VzdG9tZXJzICh0aGF0IHdlcmUgYXNraW5nIGZvciB0aGlzDQo+ZnVuY3Rpb25hbGl0eSkgZm9y
IHNvbWUgcGFydGljdWxhciB1c2UgY2FzZXMuDQo+DQo+VGhlIGZpcnN0IGNhdGVnb3J5IG9mIGN1
c3RvbWVycyB3YXMgYXNraW5nIHRvIGNoYW5nZSB0aGUgcmVzaXN0b3IgdmFsdWUNCj5mcm9tIHRo
ZSB1c2Vyc3BhY2UgdG8gdXNlIGEgbG93ZXIgY29zdCByZXNpc3Rvciwgd2l0aCBsb3dlciBwcmVj
aXNpb24sDQo+KHRoZSBub21pbmFsIHZhbHVlIHdpbGwgc3RpbGwgYmUgdXNlZCBpbnRvIHRoZSBk
ZXZpY2UgdHJlZSkgYnV0IHRvDQo+bGVhdmUgdGhlIHBvc3NpYmlsaXR5IHRvIGNhbGlicmF0ZSB0
aGUgc3lzdGVtIGFuZCB1cGRhdGUgdGhlIHJlc2lzdG9yDQo+dmFsdWUgYXQgcnVudGltZS4gQ2Fs
aWJyYXRlZCB2YWx1ZSB3aWxsIGJlIGtlcHQgaW50byBhbiBlZXByb20uIA0KDQpUaGUgdXNlIGNh
c2UgbWFrZSBzZW5zZSAtIGJ1dCB0aGF0IGNhbiBiZSBkb25lIGluc2lkZSBVLUJvb3QsIHBhdGNo
aW5nIGRldmljZSB0cmVlLiBUaGlzIGlzIHRoZSB3YXkgdGhhdCBtb3N0IHBlb3BsZSBkbyB0aGlz
IHNvcnQgb2YgdGhpbmcuDQoNClUtQm9vdCBzdXBwb3J0cyAiIGZkdCBnZXQiIGFuZCAiIGZkdCBz
ZXQiIGNvbW1hbmRzIHRvIG1hbmlwdWxhdGUgZGV2aWNlIHRyZWUuIFdoYXQgbW9zdCBwZW9wbGUg
ZG8gaXMgc2V0IHVwIGEgdmFsdWUvcGFpciBpbiB1LWJvb3QgZW52LCBhbmQgaWYgaXQgZXhpc3Rz
LCByZXBsYWNlIHRoZSB2YWx1ZSBpbiBkZXZpY2UgdHJlZS4gRm9yIGV4YW1wbGUNCg0KVGhpcyBz
ZXRzIGEgY2xvY2ssIHRvIHdoYXRldmVyIHlvdSBtZWFzdXJlIGl0IChmb3IgdGhlIHNhbWUgcmVh
c29uIC0gY2hlYXAgb3NjaWxsYXRvcnMgaGF2ZSB0ZXJyaWJsZSBvZmZzZXRzKS4NCg0KCQkiaWYg
dGVzdCAtbiAke2FkOTM2eF9leHRfcmVmY2xrfSAmJiB0ZXN0ICEgLW4gJHthZDkzNnhfc2tpcF9l
eHRfcmVmY2xrfTsgdGhlbiAiIFwNCgkJCSJmZHQgc2V0IC9jbG9ja3MvY2xvY2tAMCBjbG9jay1m
cmVxdWVuY3kgJHthZDkzNnhfZXh0X3JlZmNsa307ICIgXA0KCQkiZmk7ICIgXA0KDQo+VGhlIHNl
Y29uZCB0eXBlIG9mIGN1c3RvbWVycyBhcmUgdXNpbmcgYSBtb2R1bGFyIGRlc2lnbiAodGhlDQo+
ZXhjaGFuZ2VhYmxlIG1vZHVsZSB3aWxsIGNvbnRhaW4gYWxzbyB0aGUgUEFDIGNoaXApLiBUaGUg
bW9kdWxlIGRlc2lnbg0KPndhcyBtYWRlIHRvIHN1cHBvcnQgZGlmZmVyZW50IGN1cnJlbnRzIChk
aWZmZXJlbnQgb3JkZXIgb2YgbWFnbml0dWRlKQ0KPmxpa2UgYmF0dGVyeSBiYW5rcy4gQXQgcnVu
dGltZS9ib290IHRpbWUgeW91IG5lZWQgdG8gaWRlbnRpZnkgdGhlDQo+bW9kdWxlIHVzZWQvaW5z
ZXJ0ZWQgaW4gdGhlIGZpZWxkIGFuZCBzZXQgdGhlIHNodW50IHJlc2lzdG9yDQo+YWNjb3JkaW5n
bHkuDQoNCllvdSBjb3VsZCBhbHNvIHVzZSBkZXZpY2UgdHJlZSBvdmVybGF5cyBmb3IgdGhpcyBz
b3J0IG9mIHRoaW5nIGluIHVzZXJzcGFjZS4gDQpUaGF0IGlzIGhvdyBtb3N0IHBlb3BsZSB3b3Vs
ZCBoYW5kbGUgaG90IHBsdWcgKG9yIHJlcGxhY2VhYmxlKSBoYXJkd2FyZS4uLg0KDQo+VGhlICJp
bl9zaHVudF9yZXNpc3RvciIgcHJvcGVydHkgaXMgYWxzbyB1c2VkIGJ5Og0KPmRyaXZlcnMvaWlv
L2FkYy9pbmEyeHgtYWRjLmMNCj5kcml2ZXJzL2lpby9hZGMvcnRxNjA1Ni5jDQoNCklNSE8gLSBK
dXN0IGJlY2F1c2UgcGVvcGxlIGRpZCBpdCBiYWQgb25jZSwgZG9lc24ndCBtZWFuIHlvdSBzaG91
bGQgcmVwZWF0IGl0Li4uDQoNCi1Sb2Jpbg0K

