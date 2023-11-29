Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239A47FCD55
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 04:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjK2DQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 22:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjK2DQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 22:16:50 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A7919A4;
        Tue, 28 Nov 2023 19:16:52 -0800 (PST)
X-UUID: bbe99b088e6511eea33bb35ae8d461a2-20231129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=DnAX4mlr8/0+Op4OjKmPjQpfJdLMBPI0PO6XcaVElpA=;
        b=j28+jKWC0qMcX0JG9ultelGFd7Bt3KbCSMDVPEUzP7pc0JrdD3vrjR6qXTjcGjq2u/tni8tw5lwUsr2TL9tSNHn/Zy+9c3Md7RZkHjX7ej1ZvO/2iAnOb+QTwhSFgGQyL2lorRBTQfLK8LUqfh1p7V1j3+gQRtT/7/Gf/+VFZWk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:963ce719-41eb-43c2-ba9e-9967fed4ef28,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:abefa75,CLOUDID:36369960-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bbe99b088e6511eea33bb35ae8d461a2-20231129
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2009521372; Wed, 29 Nov 2023 11:16:49 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 29 Nov 2023 11:16:47 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 29 Nov 2023 11:16:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M059o1er/ymh9AGQ+SxBDQn2m6emkk4NyhZvKrnu/CieRaYSttonNIM0iuFi0iX9mdUjwo5GfzZ+c9JIILnilp3KIzISRr2YpxDzi4VGURtqoDtb3Ym0at536Ym3G+4cjqhBOHq3EHaHnhINzubKHSN9c4zxgFHpOoOYW7Bu7p19W8jHZwwD6pJKSft/a0Z/oIA0K67iWsf1Kj9DISizO/Pun6p7+Z4+q2k+oAG6yrZCv9379Wz6NwFWIRT31boUsCT9Ty8w2/lxqpvnK1F3bY+w/J+b8cpaRelh9lnChGPe1XE90Ae6YeB+53gp/LLBMwPr59sDQrZVXXSfeSEV5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnAX4mlr8/0+Op4OjKmPjQpfJdLMBPI0PO6XcaVElpA=;
 b=aIVN+eLpja5BnLo2Zj1ZFpktJd/pQGiPMVSWlanreJvzJeDOwvXkbnVxSspRz5JMaxSjf4v3FLzEsgOk0j+1+C48YhYHgl5n+anAJ5CaBZ6t7EHT28nktpMIl8x9HjxN0sB6yB2YRiIQrfn53cSzv+vy4G/LxfBg+DxB2OrAEjZq4kU9DnaJPLyE9BBwihxPIpZXluFXX5EqGOwzaWbFNSTs6UhfPat8E65y1iV8hrdSZFSlcObkwdzGhXT+nvUNZEY8Nq7ghOu2MtEt1MHqRUKTMWwiuQkt4tQHmsWE6lSn65/ge2dA1tGrAW0j9fAvDe8+FWApjHLpHOBOG5sEcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnAX4mlr8/0+Op4OjKmPjQpfJdLMBPI0PO6XcaVElpA=;
 b=TOYL18kH5XixGVCsd4WC20EIsG/NZN1AulG0MC6q/MT1eccW3tDFSiu6WOU9fiinEPVjep+cw+8moOm8eMhFHUMeqgBfzeDUjJ/i++gNcQ1ejZjs+6ryQ/z6EvdaWdYH1isZqBQSFz+OCOvI9zpp3S7glVQ7So3Su9uL/L1EoCs=
Received: from SG2PR03MB4534.apcprd03.prod.outlook.com (2603:1096:4:8a::19) by
 SI2PR03MB6168.apcprd03.prod.outlook.com (2603:1096:4:16c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.27; Wed, 29 Nov 2023 03:16:45 +0000
Received: from SG2PR03MB4534.apcprd03.prod.outlook.com
 ([fe80::d4a3:4ed0:73de:f07a]) by SG2PR03MB4534.apcprd03.prod.outlook.com
 ([fe80::d4a3:4ed0:73de:f07a%3]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 03:16:44 +0000
From:   =?utf-8?B?QXhlIFlhbmcgKOadqOejiik=?= <Axe.Yang@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v2 2/2] mmc: mediatek: extend number of tuning steps
Thread-Topic: [PATCH v2 2/2] mmc: mediatek: extend number of tuning steps
Thread-Index: AQHaIcjmSydXs8QZ/EKu17lpxk+LjrCPbTOAgAAMpwCAAAu4gIABGbEA
Date:   Wed, 29 Nov 2023 03:16:44 +0000
Message-ID: <61afefc47b073d63f39972031be6a4dfbd3d45af.camel@mediatek.com>
References: <20231128070127.27442-1-axe.yang@mediatek.com>
         <20231128070127.27442-3-axe.yang@mediatek.com>
         <207c2f89-b1e7-448d-966f-0c403a9f9e8b@collabora.com>
         <ea1a82b07e98fa682140c460048901a9f962be2b.camel@mediatek.com>
         <36ba3f89-2bd0-45f0-8b61-59f5c6691427@collabora.com>
In-Reply-To: <36ba3f89-2bd0-45f0-8b61-59f5c6691427@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB4534:EE_|SI2PR03MB6168:EE_
x-ms-office365-filtering-correlation-id: d6dd691d-606b-40db-4f4d-08dbf0899d78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8l51oAY3SxmIf9gIhjoQVemVELLh9veqisgEqEVj5v+smdORiCz/b45Wg/DplmbcrYCckrfpn2DbTbYyOuTKVGTQ43eM4wys0rd0ny8bZK/KkeKXr4h2uyIGv4KeBiAAPUthoQ17HybguC4INsNxiczXwSg0wTqnOsaugOnJVmQyW6HeLQTfrVmH89D31MT/TU3qYw8TFgDQ8siGbrd2Gco2+jYwHdg6l9+6fPGtEkogJHxFEEot+UosXf4v6lhFR/tzBXpILUwUfwyxVK6FIObyoixcGunDFJSj+sgv9tmyOwxW+VmcP7W1oqOQCEUTUgxL9YE3blJwKCkBDY11uWXDucXlLHqgGFVkW0k/gWOVqxbG2cFHdB2aRF/zaQdRK2PnsIBIR4fBHh6kflCG11MyD87l3gXeFGuCkCsZ0tPRlTs4Z0lDL4JjVE9p/2CmbndFgN363HmaLFZgaI/Kojjj13wxoXC2nujHg9CRoi03CpXGyRFUlpNPnSVjhLb7PqVa1rR4LCWHxycKpWRbpAQf0fBi5IXPPeSIROWLpxDYyqMV+ee6rd1FjSdkR7coP1foRO/MpEfGj4lpgs7rZqoAoPoUhNGO9hcXsQc/LGzCg1QhFS5dJXggca5JjlsRlviQOqzSkj22SeE+oztptQGFurxr23SwaFYan1kwOXXhlteG5WGRfRWDXGAMrPCK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB4534.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(346002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(7416002)(4326008)(41300700001)(4001150100001)(2906002)(8936002)(8676002)(5660300002)(54906003)(66946007)(316002)(26005)(66446008)(76116006)(110136005)(6512007)(71200400001)(64756008)(6506007)(107886003)(2616005)(83380400001)(66556008)(66476007)(122000001)(86362001)(38100700002)(6486002)(478600001)(38070700009)(85182001)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmtYeC95UDFQRzdndlN1aDdIQVZIeXJSMy9xSkE0N3daWHN6VUZ2d0xObTNs?=
 =?utf-8?B?S2xWRHZaT0xieTl0b0RGMXl2UlJDazhBNDJSRlRPeE1hRXVYTm52dFhON2Ji?=
 =?utf-8?B?KzdMT0F1YmphdDhDcFNVSUZnM1BmdHJuWlp5TkNvVUx1WkRqeWdpdHYyVDMz?=
 =?utf-8?B?TktaVHlTeDUvMUF4NG44UzJlaExPVnFZMkpXcVhXMFdDeVpCeTFsKzlHZzk0?=
 =?utf-8?B?bEhvU2NxZVlyY0M3RTE3TlcvMW5VT2xielprdm5TMk5zU1NYTW9rWHdlOFJm?=
 =?utf-8?B?cEZIQU90em9TcjdUSEtHVU9IY0huOVlqMXFvaStReWNsK05rVStyZ1FPeFpm?=
 =?utf-8?B?d1E0a2lJV3RUTUFLS1dqbW91ekNYaXZWeE9DNEVGTlhuaDlLNVBtMmNYQUVD?=
 =?utf-8?B?MDBOMnlhckpjVlpyWUU0TGZUV2FsUzFJaWh0Y0MyYkZqWjZ1eVhoblNMeUZR?=
 =?utf-8?B?L1A3dFdSQzRKTkZ5MlpuNlRVMXFHRnUvenR4NGFJeE1XWjJYWkR0RzBWN3pn?=
 =?utf-8?B?eXZVdWNPbjRjM0pxL0VOWDFLTkJ5Y1JwZnVyVlVtRVA3Tm1PWFZaekhpS1dC?=
 =?utf-8?B?TkIwVVlIUEQ3TXBERk1yYi9ibkZHSyt5TWpFSi9vRXZXUjZQdzlEcDdZWHdS?=
 =?utf-8?B?N0QxUXp3eTU3UUZNdGhacmNieHI5UW9PbzVZVWRzYVNscFAvRzRaeUE0aXcy?=
 =?utf-8?B?WUVYb25YeXVTMStoVDd2dkxPSDFDTDlnTzlMM3huVUZPeGduSE1Xc2NzTTVN?=
 =?utf-8?B?T3JzaUJGbzY5L0xUM09vRjJJNFlLWjJkWTBxOCtuNjM2QnVTVnNKcVV3T1NO?=
 =?utf-8?B?cFRFOVJ0ZHc1TTF4MU5aU3lhM0prWlMzbERidlV2d252N0pJdGJRL0VyTm5E?=
 =?utf-8?B?L1JpYVk0Z2xzdlBBZk9VanZ1b056MUF3U2k4K1VEaE9rb2t3K2d1dnA1b1ha?=
 =?utf-8?B?MUZqZy9FSklSZ3JRWUZtWHgxRmN6UXZRc1d5VVBGeHRsc3UyVUdHNTBzMTNT?=
 =?utf-8?B?aGFMMDNKS2lNQTZqSlB5dnhMK0ZVbmkzd2RqbU91Sm9yN3lISGtYeXc5T1Av?=
 =?utf-8?B?VVFDR3ViVmh1NE1RMUpKbDdlZHU1VVVWTlBzbkc3bEVYVXFWTGtvWENjazds?=
 =?utf-8?B?ckNTRkF6aHc4QXJseXUwY2krUXh3VW9aenVPcG9DVWYvSUJ2RXA1Mi82bTN6?=
 =?utf-8?B?MFJwU0ZJSHd1L1ovcWZQekV1N1FnWldtUU1uNy9QTytlOXhGQ3F3ellMT3pa?=
 =?utf-8?B?Q3ZhT1V6aktidHhzVUxNa3VuSVhIK05FMVdNenlMdVlBSDBqMnVidWZ2N2Qv?=
 =?utf-8?B?N01Ya09Cb0ZrbWVQRzkzZ2tGRDcwYU9ObGFPNDJUekFWbGp0ZHhUKy9XWFZu?=
 =?utf-8?B?ZVBhV0tpc1MzVTNrNVhYNktjczdTYWlpY2RjVk01MHU5K2dkSmZtSWI0WUFp?=
 =?utf-8?B?OXBBR292NGVKek9XMXFBcEt5K3dVUjd6bjI2Q0ZVUkhGSTV3TWxqZk1lUlRQ?=
 =?utf-8?B?QTR4dVV5aTA0MjJDMXdJcUs2SUV2dnhoNm1EQUVtQndaalkrR0NpRVZPWTZD?=
 =?utf-8?B?cVB3b1FQcXdCUU40M1lhc2YzQ1dLbHVKMzN5TENweE5aM3VtQnlyRFAxMmhk?=
 =?utf-8?B?bFZwK3NVdFZaMTBvNGlSNUFCSXc1Qjh5a2hFS3V2SEYwZkRBZ1hKOGd2b052?=
 =?utf-8?B?dnhZUVJzVDNMcmYrUjdPbTBRcUo4d05xdVhWa0NjN1hndjg0STNRUjN3Mi9i?=
 =?utf-8?B?L2ZOVHJtWm9zUkZ6ZGFxMTk5WDFObk4vMC8zRVRmZUdRc3BCK2tFaFlpOHk3?=
 =?utf-8?B?b2pCczlZcVkveGNXaldKUkNZUldSbTQwVi84N2JZVkxxN3plcnRPazBHcWFP?=
 =?utf-8?B?aHliM0Q5NmtFa0NQUzZjK3ZqTjN2S2hYaE43QWVmOUVtVWhhSnBrOEY4Z0tX?=
 =?utf-8?B?ZkhRcGlmT3pkRkNpeU9MajVJSUYvbnVNK1h0Z1JMeDUwelhlZDJ2WDZ0emV1?=
 =?utf-8?B?NHdpQi9nYnpOZll4anJhV2k2Mm1RMzFSelJWZGhUMnU2SUdQNmcvWUsrWU5W?=
 =?utf-8?B?QThNcFd1bm9SNGlxVndpQmh6bVhtK2F0N1FvLzUzc1QzVHBVRFVPWGhUUXJM?=
 =?utf-8?B?TGErd3RHdW9tYlAzcngxRGFWZDlROWpKVm5kL2FWQlVGSzRYSnl6QmpKblpX?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95A9C54744B3B34DAE1733A719A779D6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB4534.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6dd691d-606b-40db-4f4d-08dbf0899d78
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 03:16:44.5624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+z9iW48Wi7ZfD6zWVvB19LCNMjmt+i011fcldYDNhg1h9w7WnpDuwjPdAi7lsnnxJJ3/3V3FQiAPPAiP1v82w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6168
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTExLTI4IGF0IDExOjIwICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjgvMTEvMjMgMTA6MzgsIEF4ZSBZYW5nICjmnajno4opIGhhIHNj
cml0dG86DQo+ID4gPiBPbiBUdWUsIDIwMjMtMTEtMjggYXQgMDk6NTMgKzAxMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vDQo+ID4gPiB3cm90ZToNCj4gPiA+IElsIDI4LzExLzIzIDA4OjAx
LCBBeGUgWWFuZyBoYSBzY3JpdHRvOg0KPiA+ID4gPiBQcmV2aW91c2x5LCBkdXJpbmcgdGhlIE1T
REMgY2FsaWJyYXRpb24gcHJvY2VzcywgYSBmdWxsIGNsb2NrDQo+ID4gPiA+IGN5Y2xlDQo+ID4g
PiA+IGFjdHVhbGx5IG5vdCBiZSBjb3ZlcmVkLCB3aGljaCBpbiBzb21lIGNhc2VzIGRpZG4ndCB5
aWVsZCB0aGUNCj4gPiA+ID4gYmVzdA0KPiA+ID4gPiByZXN1bHRzIGFuZCBjb3VsZCBjYXVzZSBD
UkMgZXJyb3JzLiBUaGlzIHByb2JsZW0gaXMNCj4gPiA+ID4gcGFydGljdWxhcmx5DQo+ID4gPiA+
IGV2aWRlbnQgd2hlbiBNU0RDIGlzIHVzZWQgYXMgYW4gU0RJTyBob3N0LiBJbiBmYWN0LCBNU0RD
DQo+ID4gPiA+IHN1cHBvcnQNCj4gPiA+ID4gdHVuaW5nIHVwIHRvIGEgbWF4aW11bSBvZiA2NCBz
dGVwcywgYnV0IGJ5IGRlZmF1bHQsIHRoZSBzdGVwDQo+ID4gPiA+IG51bWJlcg0KPiA+ID4gPiBp
cyAzMi4gQnkgaW5jcmVhc2UgdGhlIHR1bmluZyBzdGVwLCB3ZSBhcmUgbW9yZSBsaWtlbHkgdG8g
Y292ZXINCj4gPiA+ID4gbW9yZQ0KPiA+ID4gPiBwYXJ0cyBvZiBhIGNsb2NrIGN5Y2xlLCBhbmQg
Z2V0IGJldHRlciBjYWxpYnJhdGlvbiByZXN1bHQuDQo+ID4gPiA+IA0KPiA+ID4gPiBUbyBpbGx1
c3RyYXRlLCB3aGVuIHR1bmluZyAzMiBzdGVwcywgaWYgdGhlIG9idGFpbmVkIHdpbmRvdyBoYXMN
Cj4gPiA+ID4gYQ0KPiA+ID4gPiBob2xlDQo+ID4gPiA+IG5lYXIgdGhlIG1pZGRsZSwgbGlrZSB0
aGlzOiAweGZmYzA3ZmYgKGhleCksIHRoZW4gdGhlIHNlbGVjdGVkDQo+ID4gPiA+IGRlbGF5DQo+
ID4gPiA+IHdpbGwgYmUgdGhlIDYgKGNvdW50aW5nIGZyb20gcmlnaHQgdG8gbGVmdCkuDQo+ID4g
PiA+IA0KPiA+ID4gPiAoMzIgPC0gMSkNCj4gPiA+ID4gMTExMSAxMTExIDExMDAgMDAwMCAwMDAw
IDAxMTEgMTEoMSkxIDExMTENCj4gPiA+ID4gDQo+ID4gPiA+IEhvd2V2ZXIsIGlmIHdlIHR1bmUg
NjQgc3RlcHMsIHRoZSB3aW5kb3cgb2J0YWluZWQgbWF5IGxvb2sgbGlrZQ0KPiA+ID4gPiB0aGlz
Og0KPiA+ID4gPiAweGZmZmZmZmZmZmZmYzA3ZmYuIFRoZSBmaW5hbCBzZWxlY3RlZCBkZWxheSB3
aWxsIGJlIDQ0LCB3aGljaA0KPiA+ID4gPiBpcw0KPiA+ID4gPiBzYWZlciBhcyBpdCBpcyBmdXJ0
aGVyIGF3YXkgZnJvbSB0aGUgaG9sZToNCj4gPiA+ID4gDQo+ID4gPiA+ICg2NCA8LSAxKQ0KPiA+
ID4gPiAxMTExIC4uLiAoMSkxMTEgMTExMSAxMTExIDExMTEgMTExMSAxMTAwIDAwMDAgMDAwMCAw
MTExIDExMTENCj4gPiA+ID4gMTExMQ0KPiA+ID4gPiANCj4gPiA+ID4gSW4gdGhpcyBjYXNlLCBk
ZWxheSA2IHNlbGVjdGVkIHRocm91Z2ggMzIgc3RlcHMgdHVuaW5nIGlzDQo+ID4gPiA+IG9idmlv
dXNseQ0KPiA+ID4gPiBub3Qgb3B0aW1hbCwgYW5kIHRoaXMgZGVsYXkgaXMgY2xvc2VyIHRvIHRo
ZSBob2xlLCB1c2luZyBpdA0KPiA+ID4gPiB3b3VsZA0KPiA+ID4gPiBlYXNpbHkgY2F1c2UgQ1JD
IHByb2JsZW1zLg0KPiA+ID4gPiANCj4gPiA+ID4gWW91IHdpbGwgbmVlZCB0byBjb25maWd1cmUg
cHJvcGVydHkgIm1lZGlhdGVrLHR1bmluZy1zdGVwIiBpbg0KPiA+ID4gPiBNU0RDDQo+ID4gPiA+
IGR0cyBub2RlIHRvIDY0IHRvIGV4dGVuZCB0aGUgc3RlcHMuDQo+ID4gPiA+IA0KPiA+ID4gDQo+
ID4gPiBJZiB3ZSBjYW4gcnVuIDY0IHR1bmluZyBzdGVwcywgd2h5IHNob3VsZCB3ZSBydW4gMzI/
DQo+ID4gPiANCj4gPiA+IFdoeSBpc24ndCBpdCBqdXN0IGJldHRlciB0byAqYWx3YXlzKiBydW4g
NjQgdHVuaW5nIHN0ZXBzLCBvbiBTb0NzDQo+ID4gPiBzdXBwb3J0aW5nIHRoYXQ/DQo+ID4gPiAN
Cj4gPiA+IFRoYW5rcywNCj4gPiA+IEFuZ2Vsbw0KPiA+IA0KPiA+IEhpIEFuZ2VsbywNCj4gPiAN
Cj4gPiBUaGF0IGlzIGEgZ29vZCBxdWVzdGlvbi4gVGhlIGJlbmVmaXQgb2YgcHJlc2VydmluZyAz
MiBzdGVwcyB0dW5pbmcNCj4gPiBpcw0KPiA+IHRoYXQgaXQgY2FuIHNhdmUgdGltZSBpbiBjZXJ0
YWluIHNjZW5hcmlvcy4NCj4gPiANCj4gPiBPbiBzb21lIHBsYXRmb3Jtcywgd2hlbiB0aGUgZGVs
YXkgc2VsZWN0ZWQgdGhyb3VnaCA2NCBzdGVwcyB0dW5pbmcNCj4gPiBpcw0KPiA+IHZlcnkgY2xv
c2UgdG8gdGhhdCBjaG9zZW4gdGhyb3VnaCAzMiBzdGVwcywgd2UgY2FuIHJlZHVjZSB0aGUNCj4g
PiB0dW5pbmcNCj4gPiBzdGVwIGZyb20gNjQgdG8gMzIuIFRoaXMgY2FuIHNhdmUgdGltZSBzZW5k
aW5nIHRoZSB0dW5pbmcgYmxvY2sNCj4gPiBjb21tYW5kcy4NCj4gPiANCj4gPiBUaHVzIHVzaW5n
IDMyIHN0ZXBzIHR1bmluZyBjYW4gc2F2ZSBrZXJuZWwgYm9vdCB1cCB0aW1lLg0KPiA+IA0KPiA+
IEFub3RoZXIgY2FzZSB3aGVyZSB0aW1lIGNhbiBiZSBzYXZlZCBpcyB3aGVuIGFjY2Vzc2luZyB0
aGUgUlBNQg0KPiA+IHBhcnRpdGlvbiBvZiBlTU1DLiBFYWNoIHRpbWUgc3dpdGNoIHRvIFJQTUIg
cGFydGl0aW9uLCB0aGVyZSBpcyBhDQo+ID4gcmV0dW5lIGFjdGlvbiwgY2F1c2luZyBhIGNlcnRh
aW4gZHJvcCBpbiBwZXJmb3JtYW5jZS4gSWYgd2UgYXJlDQo+ID4gY2VydGFpbg0KPiA+IHRoYXQg
dGhlIHJlc3VsdHMgb2YgMzIgc3RlcHMgdHVuaW5nIGFyZSB1c2FibGUgYW5kIHdlIHVzZSBpdCwg
dGhpcw0KPiA+IGNhbg0KPiA+IGluIGEgc2Vuc2UgYWxzbyBndWFyYW50ZWUgcGVyZm9ybWFuY2Ug
d2hlbiBhY2Nlc3NpbmcgdGhlIFJQTUINCj4gPiBwYXJ0aXRpb24uDQo+ID4gDQo+IA0KPiBUaGFu
a3MgZm9yIHRoaXMgZXhwbGFuYXRpb24hIFRob3VnaCwgSSBoYXZlIHNvbWUgbW9yZSBxdWVzdGlv
bnMuLi4NCj4gDQo+IC4uLnJlZ2FyZGluZyBib290IHVwIHRpbWUsIGhvdyBtdWNoIHRpbWUgYXJl
IHdlIHRhbGtpbmcgYWJvdXQ/DQoNCkx1Y2tpbHksIEkgaGF2ZSBhIHBsYXRmb3JtIGF0IGhhbmQg
dGhhdCBjYW4gYmUgdXNlZCBmb3IgZXhwZXJpbWVudHMvDQpCZWxvdyBhcmUgdGhlIHJlc3VsdHMg
ZnJvbSB0ZXN0aW5nIG9uIHRoaXMgcGxhdGZvcm06DQoNClsgICAgMi40MzE5OTNdW1QxMjAwMTgw
XSBrd29ya2VyLzI6MjE6IG10ay1tc2RjIGJvb3RkZXZpY2U6DQpbbmFtZTptdGtfc2QmXVN0YXJ0
IHR1bmluZw0KWyAgICAyLjQzNDk1MF1bVDEyMDAxODBdIGt3b3JrZXIvMjoyMTogbXRrLW1zZGMg
Ym9vdGRldmljZToNCltuYW1lOm10a19zZCZdVHVuaW5nIGZpbmlzaGVkDQpbICAgIDIuNDM1OTU3
XVtUMTIwMDE4MF0ga3dvcmtlci8yOjIxOiBtdGstbXNkYyBib290ZGV2aWNlOg0KW25hbWU6bXRr
X3NkJl1waGFzZTogW21hcDowMDAwMDAwMGZmZmZmZmMwXSBbbWF4bGVuOjI2XSBbZmluYWw6MTld
DQpbICAgIDIuNDYyMzc1XVtUMTIwMDE4MF0ga3dvcmtlci8yOjIxOiBbbmFtZTptbWNfY29yZSZd
bW1jMDogbmV3IEhTNDAwDQpNTUMgY2FyZCBhdCBhZGRyZXNzIDAwMDENCi4uLg0KWyAgICAyLjUx
OTg2M11bVDEzMDAwNjldIGt3b3JrZXIvMzoxOiBtdGstbXNkYyAxMTI1MDAwMC5tbWM6DQpbbmFt
ZTptdGtfc2QmXVN0YXJ0IHR1bmluZw0KWyAgICAyLjUyNjI3MV1bVDEzMDAwNjldIGt3b3JrZXIv
MzoxOiBtdGstbXNkYyAxMTI1MDAwMC5tbWM6DQpbbmFtZTptdGtfc2QmXVR1bmluZyBmaW5pc2hl
ZA0KWyAgICAyLjUyNzI4OF1bVDEzMDAwNjldIGt3b3JrZXIvMzoxOiBtdGstbXNkYyAxMTI1MDAw
MC5tbWM6DQpbbmFtZTptdGtfc2QmXXBoYXNlOiBbbWFwOmZmZmZmZmZmZmZmZjAwM2ZdIFttYXhs
ZW46NDhdIFtmaW5hbDo0MF0NClsgICAgMi41MzIyNjldW1QxMzAwMDY5XSBrd29ya2VyLzM6MTog
W25hbWU6bW1jX2NvcmUmXW1tYzI6IG5ldyB1bHRyYQ0KaGlnaCBzcGVlZCBTRFIxMDQgU0RJTyBj
YXJkIGF0IGFkZHJlc3MgMDAwMQ0KDQpBcyB0aGUga2VybmVsIGxvZyBpbmRpY2F0ZXMsIGl0IHRv
b2sgMyBtcyBmb3IgZU1NQyB0byB0dW5lIDMyIHN0ZXBzLA0Kd2hpbGUgaXQgdG9vayBhYm91dCA3
IG1zIGZvciBTRElPIHRvIHR1bmUgNjQgc3RlcHMuIEkgaGF2ZSB0byBhZG1pdCwNCndoZW4gaXQg
Y29tZXMgdG8gc2F2aW5nIGJvb3QgdXAgdGltZSwgdGhlIGJlbmVmaXRzIG9mIHJlZHVjaW5nIHN0
ZXANCmZvcm0gNjQgdG8gMzIgYXJlIHF1aXRlIG1pbmltYWwuIEp1c3QgYXMgeW91IHNhaWQsIGVz
cGVjaWFsbHkgd2hlbg0KYXN5bmMgcHJvYmUgaXMgZW5hYmxlZC4NCg0KPiANCj4gSSdtIGFza2lu
ZyBiZWNhdXNlIHdoaWxlIG5vdyBJIHNlZSAtIGFuZCBhZ3JlZSAtIG9uIHVzaW5nIDMyLXN0ZXBz
DQo+IHR1bmluZw0KPiBvbiBlTU1DIHRvIGd1YXJhbnRlZSBwZXJmb3JtYW5jZSBkdXJpbmcgUlBN
QiBhY2Nlc3MsIGFzIGZhciBhcyBJDQo+IGtub3csDQo+IHRoZXJlIGlzIG5vIFJQTUIgcGFydGl0
aW9uIG9uIFNEL01pY3JvU0QgY2FyZHMgKGFuZCwgb2YgY291cnNlLCBTRElPDQo+IGRldmljZXMp
Lg0KPiANCj4gSWYgdGhlIGJvb3QgcGVyZm9ybWFuY2UgaW1wYWN0IGlzbid0IGJpZywgYXMgaW4s
IHVwIHRvIH4xMDANCj4gbWlsbGlzZWNvbmRzIGlzDQo+IG5vdCBiaWcgYXQgYWxsIChlc3BlY2lh
bGx5IHdpdGggYXN5bmMgcHJvYmUhKSwgd2UgY2FuIGRlZmluaXRlbHkNCj4gYXZvaWQgdGhlDQo+
IGFkZGl0aW9uIG9mIGEgZGV2aWNldHJlZSBwcm9wZXJ0eSBmb3IgMzItc3RlcHMgdHVuaW5nLCBo
ZW5jZSB1c2UgYQ0KPiBkeW5hbWljDQo+IHNlbGVjdGlvbiBzdHJhdGVneSBzdWNoIHRoYXQ6DQo+
ICAgLSBPbiBlTU1DIGRldmljZXMsIGFsd2F5cyBwZXJmb3JtIDMyLXN0ZXBzIHR1bmluZyAoaGVu
Y2Ugbm8gYm9vdA0KPiBkZWxheSkNCj4gICAtIE9uIFNEIGNhcmRzIGFuZCBTRElPLCBhbHdheXMg
cGVyZm9ybSA2NC1zdGVwcyB0dW5pbmcNCg0KZU1NQyBjb3VsZCBhbHNvIHBvdGVudGlhbGx5IGhh
dmUgQ1JDIGlzc3VlIGlmIG9ubHkgdHVuZSAzMi1zdGVwcywNCmFsYmVpdCB3aXRoIGEgbG93ZXIg
bGlrZWxpaG9vZC4gVGhlIHByZWNvbmRpdGlvbiBmb3IgdXNpbmcgMzItc3RlcHMNCnR1bmluZyBp
cyB0aGF0IGl0IGNvdWxkIHByb3ZpZGUgcm91Z2hseSB0aGUgc2FtZSB2YWxpZCByZXN1bHRzIGFz
IHVzaW5nDQo2NC1zdGVwcyB0dW5pbmcuIFNvIHRha2luZyBldmVyeXRoaW5nIGludG8gYWNjb3Vu
dCwgY29udHJvbGxpbmcgdGhlDQp0dW5pbmcgc3RlcCBhcyBuZWVkZWQgdGhyb3VnaCB0aGUgdXNl
IG9mIGR0cyBwcm9wZXJ0eSBzZWVtcyB0byBiZSBhDQptb3JlIGZsaXhpYmxlIGFwcHJvYWNoLg0K
DQpSZWdhcmRzLA0KQXhlDQoNCj4gDQo=
