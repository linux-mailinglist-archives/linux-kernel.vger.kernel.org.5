Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71EF78BF3E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjH2Hak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbjH2Hae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:30:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635DCB5;
        Tue, 29 Aug 2023 00:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693294228; x=1724830228;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Szg+2p6WPh3WlRDvRDbqkevd/jUgIjOoVKZ1n1A4vuU=;
  b=itm2j8eMadDA8bTelUBCtQAS7Vtii+Opc333ntIEsO3YWrtr7j7d5UJ7
   F+dJ8FUVJ00NpsOubSKA/di/69/PKRWWpt6KTScKk8mz05RjK7G/KR+h5
   fqcl3HXVIFay94K3dTMdq9iQnHd5JRq/SiBkYX1yY5BmzJer4ghTFUiWC
   qPWCTBUW6YmsHXu98GgVP1CoEDqMkQ+u3DfZ6bjH/YlXOH/OOduzu5dxD
   GB7daxA9iy88A8T9Md3FSrGV1E21w+mDt31a1Qll8ZiQxcQq9mYEdCnVu
   Lc+BnrBsIavW5lG/Wh5oYUIJLI4ubaKQXciCpcGqQQrT+0x5PXxknmzt1
   w==;
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="168806442"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Aug 2023 00:30:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 29 Aug 2023 00:29:59 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 29 Aug 2023 00:29:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDIhdW+35KGi77XXllx6te4xTOT96TAbEOxyKc0gDc1LQ97A2Oo4mGvLQ8kAwkjhJdHp2x91IPRq+HeVUNMPXwN4MW2LoRUnL7zZyukmly7FfQ0IP9IXHWcytzHpLHj0LiLhn6QgwLQ+/Ls53sRQO81PU0UiykQ193GLOG8SJ65pfDsCxdZJjNzwaviqW9zP6CFKaiqHLcEXDD9roldCpHXTyhH3QqUTIzBbdegMQb/nSl+dbZzOnkrn0PnPaRhpjlPzQV3S8pgxUUHPFLIwAbl2Zi7udskqgHFSrEtFflb57rLKodG7Yeh+lzLapio1mZ8/bV20pLUMjtB1rwtSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Szg+2p6WPh3WlRDvRDbqkevd/jUgIjOoVKZ1n1A4vuU=;
 b=PFnRgvExBmZI5zQW6f7/B64JFJW/cb1vPGlvaufW1+o9ACF3sD3pJ5WZde7rzOMzoZ5DiQU/qHnGgt4jfSQ68W7YgxcT/lN1pfaWBxJ4NuzqkxofiqNxrPRJQsXAzY8I571rsVwMK5MqXNofEv/W+nqiyy3FuCzTlk2BY/An2V+5bDOiN49pohXThnxPyczJZQedE2MwOoswgFPPiFa9OzzRZVeWjZv6ixSJuOady79cDwp7hAa5rkBoX1UyA+FSkydph6LzIHibMyA0qVLC+L57OSxO95YU7UjsZWQC684xxzEgBsVKo94ljZAKmxY/A8hc0WyeKRL/xQ5Go8aK/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Szg+2p6WPh3WlRDvRDbqkevd/jUgIjOoVKZ1n1A4vuU=;
 b=k7aZcjlcmZinECm6nSl1pMx9tcDreQhvxjpNLjsXyZRYpnrnikgw0LcFRjUd+jKcBoQUmxNumA1/V1qQLKvG/qpvY+Lm4uHWaSok9K6Ib529wLocAMt/z+bjUFlQvPnVPwLX9oAUiRnHa8ebDEYYM9xfBHl1sZkzCMsfU/LrSOA=
Received: from IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14)
 by SA2PR11MB4939.namprd11.prod.outlook.com (2603:10b6:806:115::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 07:29:58 +0000
Received: from IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::6ca0:521:dd8e:b296]) by IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::6ca0:521:dd8e:b296%7]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 07:29:57 +0000
From:   <Marius.Cristea@microchip.com>
To:     <jic23@kernel.org>
CC:     <devicetree@vger.kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] iio: adc: adding support for MCP3564 ADC
Thread-Topic: [PATCH v4 2/2] iio: adc: adding support for MCP3564 ADC
Thread-Index: AQHZ0fUtS2GyhDbLdE6x3sxNs+CUNq//0JGAgAEgvAA=
Date:   Tue, 29 Aug 2023 07:29:57 +0000
Message-ID: <ae3562ee30e6d8aecae2a447cffc4ad6e8e44578.camel@microchip.com>
References: <20230818165750.55406-1-marius.cristea@microchip.com>
         <20230818165750.55406-3-marius.cristea@microchip.com>
         <20230828151631.6a60282b@jic23-huawei>
In-Reply-To: <20230828151631.6a60282b@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6395:EE_|SA2PR11MB4939:EE_
x-ms-office365-filtering-correlation-id: 750b8119-fb6d-473a-a59b-08dba861bf4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SEAJxUWR+khdMU7F5mt4K426m7tz+aSoaGkYU40tG4waIhE8ZbZLs4cpJWj1Ff+8FUyjV6e74Bl0gAmyTz2i+2C9zbW4YG5rpSFiC9PyADDNJOJf+X7artCayB24reWVV9AyZOhvR5Q6LZWILCdHKCWUa0fwr3S6eDeB66nANrRQWc0USPI5QfVhnbRo9ZLdRfcL7VkLb+szJ7uFMaAmEiJagqWqdoe882+/vttSBmcxxKgBlIid3M7tBPCT9bduY5Nowyzfsz5LpyngKnSStCZOAvf/bSMibKfkPs/Qp9citB9zGpuxlByBMjfFY6qc9H+USz78afHiZJwcWQ189UcwcmMN9d4zFsRil6FlK/CLeVhXZ+OBRDs6SuaNJK0HeUJaRzEesiElLEQeFvBRSzBOcxgOOkW6lFjDqn56NtCr6AsHduOMM2PDUcfTGo08x2jbwgyCBdPxICnd/YHQBMdsPXhDCGRFCq32DqFmSm7RmSqBNysVn7I2MtVsBh09ARcSpPgKTrE5hc4NOX626eNHeQY2wAjC+/yNDHokYVpGRbY3k7VE1NcqAzoXlQfujVzaoWD2PysxAyLZtsgtL83SLs+YAKnzDNG7kIMzP/hTFa2GB+x9yCVvc9S/qeYi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6395.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(376002)(136003)(1800799009)(451199024)(186009)(6512007)(38100700002)(38070700005)(316002)(6916009)(41300700001)(4326008)(2906002)(86362001)(4744005)(2616005)(36756003)(26005)(5660300002)(8676002)(8936002)(71200400001)(6506007)(6486002)(64756008)(66556008)(66476007)(66446008)(54906003)(91956017)(76116006)(122000001)(66946007)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHNLUFJUQ2sxYlNIYmczZDNOeDNrMi9scFp6dUdqbVVyU3FoRElJcWMwNThl?=
 =?utf-8?B?R3lqNGtIMUdJV3Q4YWtmeGZoVGVCWFJMTnhFK1JFZjBiOGswSzkzRjhySldB?=
 =?utf-8?B?ZTl6SU9OSHFoUmZXUUVEYkNZOUwxVStMdEZkenJNZ1FDOFBtczlpd1p0NGxn?=
 =?utf-8?B?eFFSL3R6cGNZWjkvSTB0em5DNnlpU3h6WG9UM2hRVjBrVnVpN1k3UlNMUG5U?=
 =?utf-8?B?U3QzNzFwMmc5UkdLSWdhbEpYczRUTDIzeElxUW5IZ2tZbHhiaEZCdjZRbHdM?=
 =?utf-8?B?cmZCcXJNNU1veUFIcHJXaXQ3aVRmY0prcWp4cnI3S2RTSXRMa0xYS2VjTVVu?=
 =?utf-8?B?L1JGcmQ5djRMNVVidzVmdjFuV1pKTmlMMjZsTEVmU1hIZmpjaXhiUlB1V3o0?=
 =?utf-8?B?NTNtWGxxVnE5dFVYSmdEZ295WW1KYlJmR1VnRHNkRlB4a05WNkFOV0gvNldO?=
 =?utf-8?B?WnlialFVSlpRam92T0pIQlFPWUxHaVVqMFBYRW56OGNoV09ic2FKRUVvRXNT?=
 =?utf-8?B?ODFlVVdyMktlWEhqZ3dqdmExS1JmeXNoUzdKWjJjaTNUNEQ4TmZieUYxZmxM?=
 =?utf-8?B?L2UwNUQrMkpSVjN6L3VGMU5jQVRaNDlacWU4ak0wanZ0Q1JROGhjamZzOXdq?=
 =?utf-8?B?bXBXQnV1Ukw2TGR4RjF0Nm9YQWNHQVRUSkhJa0ZSZ2JJMnlsdUFET3Rpcm94?=
 =?utf-8?B?dUdsRWxmOHVNenRCWnJsTGhDalRYQ0Y3RXF4RzE3ZCs5S1IvNFdsSE5yQWEv?=
 =?utf-8?B?dUZUWWkzdzZ2elozQmY3N0xDUndTekJtWW9TZDNKM1dhOHRTbUNBempmYTMv?=
 =?utf-8?B?Vkp6UFVVUXdLb2FYWkMwekpiY1dGYTVWVnpWTWFmb2JnYTU0eFdQcUFJbmh1?=
 =?utf-8?B?SEdNTGhkOG5CYWFDakk5OUZPOUFuUmxSbkhlZHFpcjF3QXMvNFZ0aGpkRXMy?=
 =?utf-8?B?MHk1SnRaMVI2ZW9NbUwyeGZCYnpOV0NuUzFOaFlBUVE2WFhBQ1pJcEE4bXBF?=
 =?utf-8?B?cXB2b29namxLeEI5MmlLbFJVbmgwdURKTHFMb2JneEF6ZlV0b0JxNlJrL2V1?=
 =?utf-8?B?VXdCM01qdkZ2L1g5VlV3d1N1UTROcHpRQUJCbkJOQndyc1ZjYStPTVVNK0hK?=
 =?utf-8?B?YjV1WStJblVyWmRtQnNaOTRZQWRLdzkrd3hVN0NSNms4a3VCWUw3K2ZzRnRa?=
 =?utf-8?B?UXhGc1FPaFVTZjlrMTh2ZW9IS0lsQkJ3QXdQN0lINlROU29BWHFrczF3MW1N?=
 =?utf-8?B?NDh5cW5qWk1aWWNEbFlLVnhoME5ER2M0RTZIR0ZoRC84Skd1ZzRtT1ZCVFZQ?=
 =?utf-8?B?SXd1R3czc3c5RXY3WWw4UTZjLzdWTFgrd2JzWUhJSjllTWNKZWlMU1RkK2tm?=
 =?utf-8?B?eHJkZFkrc2VHRmxmTVRBbGtPcE5QTzE5bmhVNFlvcmlTRUtqS3U3QjlqcThx?=
 =?utf-8?B?K1VnbkRYV1RUS1RHU3VRcGVNbVl5MkdoVEhKdkFoWFR1amlqREx1RWgwbGZT?=
 =?utf-8?B?SVp0amZtVzFhQTgyYmErWU5VT29lVVI1R0V0M1RlQ2ZKNlR0ekc4Y05BRFU2?=
 =?utf-8?B?azcxaklXWGx3Tjg2Zm9sUjIwYTJ3b2M3bVdlSDY1U1E0bUpZR0F1M1Y3dEpx?=
 =?utf-8?B?WUFDRkkvUXZtU0N5djlVL2tDUnNFUWlsSUxkWXVnRWhTSlBLWEJQbE9kdmla?=
 =?utf-8?B?bVVoK3NpQnZSYzBsV3FsTkxXWlhmOGFXN0Fid0tZczMxZ2NhMWszU201WTlm?=
 =?utf-8?B?eDJNa25wMjNBSG5DV2hIL1Fmb2NTd1dGNFFHZno0bldWREFXYXUwYnZvbnJx?=
 =?utf-8?B?dS9WdkJCNS9DSk15bjJFOHRzVzhtZWNYMTRoRkNDekdUNnZpMzNvUEtRUVVJ?=
 =?utf-8?B?SlBhRWp3RjdqM3BQb2JEdzFMemg3UXhzRU1pZXpPcDNiWEdSaHBoV3dKN1Yv?=
 =?utf-8?B?b3NvQVh0WkRSN0tSUzVlb1krWDVGR2tsZVV1eXczU2lGM09ibG5ia1RpSjlD?=
 =?utf-8?B?NmV3M0lxeHNmS1JoNE9PQS9QSTE2MHc0WXcxazBXZytkZTBsTlNOdGluaTd6?=
 =?utf-8?B?WFI0alVUNVNGZmg1dFJDMWFPT3hMM1psbDFaUDdGMEhmMXd0Q1VsWFJvbW1O?=
 =?utf-8?B?YUgvY1piYXRTZHNicTlVWHNOR2JqK0pyZ2NITzBLajcraTA5U1dUZThtVUVS?=
 =?utf-8?Q?wbwse2QRA4RB1o9cFUTeY6s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <075778C01B801547A79E03244CA07006@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6395.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750b8119-fb6d-473a-a59b-08dba861bf4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 07:29:57.7263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZS2g555N1ZxTK6PwXTNlD4I8cVBOU6wepKAQcurtqUePvMLYDFxJXCFz81H3XbDDh2ltfDlkzy1CBAvxHLsE3Ieaoblp3OTNsdZ9LORik0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4939
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9uYXRoYW4sDQoNCiAgIFRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCg0KDQo+IA0KPiAN
Cj4gPiArDQo+ID4gKy8qDQo+ID4gKyAqIEN1cnJlbnQgU291cmNlL1NpbmsgU2VsZWN0aW9uIEJp
dHMgZm9yIFNlbnNvciBCaWFzIChzb3VyY2Ugb24NCj4gPiBWSU4rL3Npbmsgb24gVklOLSkNCj4g
PiArICovDQo+ID4gK3N0YXRpYyBjb25zdCBpbnQgbWNwMzU2NF9idXJub3V0X2F2YWlsW11bMl0g
PSB7DQo+ID4gK8KgwqDCoMKgIFtNQ1AzNTY0X0NPTkZJRzBfQ1NfU0VMXzBfMF91QV0gPSB7MCwg
MH0sDQo+ID4gK8KgwqDCoMKgIFtNQ1AzNTY0X0NPTkZJRzBfQ1NfU0VMXzBfOV91QV0gPSB7MCwg
OTAwfSwNCj4gPiArwqDCoMKgwqAgW01DUDM1NjRfQ09ORklHMF9DU19TRUxfM183X3VBXSA9IHsw
LCAzNzAwfSwNCj4gPiArwqDCoMKgwqAgW01DUDM1NjRfQ09ORklHMF9DU19TRUxfMTVfdUFdID0g
ezAsIDE1MDAwfQ0KPiA+ICt9Ow0KPiANCj4gVHJpdmlhbCwgYnV0IEknZCBsaWtlIGJyYWNrZXRz
IGFmdGVyIHRoZSB7IGFuZCBiZWZvcmUgdGhlIH0gYXMgbWFrZXMNCj4gdGhpbmdzIGEgdGlueSBi
aXQNCj4gbW9yZSByZWFkYWJsZSB0byBteSBleWUuDQo+IA0KPiANCg0KSSdtIG5vdCBzdXJlIHRo
YXQgSSB1bmRlcnN0b29kIHdoYXQvaG93IHRvIGNoYW5nZSBoZXJlLiBDYW4geW91LA0KcGxlYXNl
LCBnaXZlIG1lIGFuIGV4YW1wbGU/DQoNCg0KDQpUaGFua3MsDQpNYXJpdXMNCg==
