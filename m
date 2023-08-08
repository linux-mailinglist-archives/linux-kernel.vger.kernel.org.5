Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4282E773E74
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjHHQaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjHHQ2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:28:54 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on20612.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e19::612])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF6812537;
        Tue,  8 Aug 2023 08:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QViBunTtLvzjfHSW3+jcs6eE7wXAdWTwfUjU9K8o269pKkfYNlb0IF+iU8U4W2HP4g08ope0XBMuXLNIda48iwu3tV6rb2wAL9rqjTbfR5FOR22lBsIU8wcMtKEijV/iyM8Gl03yN0/r1JUJusIr3nhkMyQfhp8eJtv5oVO2IeZodIs0lWKOADIbe1I1sEoasMq9WPCQ8J2LXPRv4F1CenT/jwub+149+A6qbT35wwy/BTd5JXqei/RzXC20KPBWaY5xBIwn0OlmLS9nQW/LvM9h/9VjrG8aBvJL/HyDHYEaXCcEGMmNbaMXdZzKljdaUnumX9L/8RZpmZV1qiD7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8QU9O6SG3adUndbU3VpV/pR8h2xtGP2eVsCHhKnb24=;
 b=dxlIMx7f8t8xkVXBswAETRFK3I4B5enxXqlivQyqov7gXax4KrRdobcXfvrWnSSjQzp3RIYzVTEwlspRFbtB+g+x4DfDw93zfMbL96l90LZus4VRkWbaIYDsgDiULzRXV13u2Ek9Z1qSYCrBZRbIemcT0ZbVOsgI7qOIBlmE1yRqrIa0wXYtmt/eWjvXluy1NM4ABE6jWofOkFr37dEuDcypIFm9IZNcLwJsuL0XBrqX9oLc2QccJFz+qpmbKSRLKQg886yRPoScRYDuKoSsguLZHfUKaWx+5ZPkh7g8qLAN6viXKgyyhzEHXPSfgYMVuH25CLeyYbVhJuniR+2QAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8QU9O6SG3adUndbU3VpV/pR8h2xtGP2eVsCHhKnb24=;
 b=mflJOd1in2QT6Ta9XxMK5iS6IVEDc9puPf2qyAOFQt3gr6cE0ko35YgrCkQeWkyBB22szR7afuol5Uex1EWQY8PyOaKUzHT1NG5+zNu6vw/TESf3XJdn1Es1Zk18zdsfqJtp6PxV+98HxLX75YaVsCYv3EZNXH86rZxzJeGyUZ4NN52ME+AqoA4EGR06yZ+EiNNhdPzJz1qsJZBEv0Gt3pOeIuNcBiGWysoNdqsCv6zPJBpjl+J/7i12aAHdfNV7NsY4KbPWMP9NkuBxgg3HoJvVO23wp837E4RD+i3J+7uiE81O2rWgpKxm1Fd9FzwLsMnuN0RyDaNmF1kCQt+KaA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB3279.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:187::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 08:04:41 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 08:04:41 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 09/28] soc: fsl: cpm1: qmc: Rename qmc_setup_tsa* to
 qmc_init_tsa*
Thread-Topic: [PATCH v2 09/28] soc: fsl: cpm1: qmc: Rename qmc_setup_tsa* to
 qmc_init_tsa*
Thread-Index: AQHZv9JLqZU5p999KEeqpoWqz7Qsbq/gHlOA
Date:   Tue, 8 Aug 2023 08:04:41 +0000
Message-ID: <f65743dc-3506-3543-69ee-701e30cee542@csgroup.eu>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
 <20230726150225.483464-10-herve.codina@bootlin.com>
In-Reply-To: <20230726150225.483464-10-herve.codina@bootlin.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB3279:EE_
x-ms-office365-filtering-correlation-id: 4d6f9cb1-ebab-4d16-8723-08db97e61e7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G1GW20QXKmbVEl+aGMXz39RcdwVXsqENI2NY9XWuJlaXezn0pBi5ZJpHzOIyPvx3qlhEI79vJNb7z7uvjFz22LZqEGHhMB99mzOB7GMCbmxp379t/g7i2/Zrx/idCpX+ag48AQr9FuDoTtvfkBdqMiGifHV/XcSoLoOqUvtJrxyDnlmfd5ALXFcMMIBNZWfun9MQP7ZUGWjpXIfI71+DBWIC7srDZ1NdsehFhog/tXs7XbZgt7oYmXRV3GdXAWyzFBaMc5DJ7tqb1Nd3eLBpftuGSAwcmnDrzpGqjbUnzNZEZ72LgkNZtkXs3SdnY/r9JYjw1Xa8BYA6tvF1tL9ogfyHKbGjxo8dzdvvdJ+gT/v6p37ui0r5JlgodHUKw0VyFj/EX0PWdCa+gc21TdGlR/WcAxYSA4Ng5IFhLnG5N+eQGCbJwCLIiFLs17uL2bPAtfM8ofWUMTk/ooLzka1VpJ6mxlcnqt+7IfKa6isYeYxzeFcgD4TeTcujIbBJLlYl3yqe4I1YQmONMpCG8fu0pubhfUPsHmyp3HXuAbQjRa2ECjNr/0/qcAw/ecr4DLaAJrA2FbZM75hLoMFIOZ5uRiOxRhz7offShcLILNgYLO/3pOwaeFexMpI3ifS8+lAu/ASfTtjpEljqpulUhCkYIaD602aAT58hcfkisA0U0HzJj4SukFgarMFzkhBhAt0PK4KZvQalgOX3cmpq187y4oX+xrA+6nwMzr4OwWMoZm9H3i7Pzj9P61U5ZWl6iEV2onOOV5aUCRiT5caga5IeJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39850400004)(396003)(136003)(376002)(90011799007)(186006)(1800799003)(90021799007)(451199021)(2616005)(36756003)(6506007)(26005)(6486002)(71200400001)(6512007)(122000001)(31686004)(478600001)(921005)(54906003)(38100700002)(110136005)(91956017)(66476007)(66556008)(66946007)(76116006)(66446008)(64756008)(4326008)(316002)(41300700001)(66574015)(8936002)(8676002)(5660300002)(38070700005)(7406005)(7416002)(44832011)(2906002)(83380400001)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3AzbFNIaTE4UjhDeFNESjF0UW8wTnY5d0RNTzlJVlJQcWFRazJoTzNTOWR0?=
 =?utf-8?B?blFyUWtzMWxqTzNCQm4vb1Z0UXRCcDBXK2JuMkhZZUY3N1pnWkRHQ0FRbElB?=
 =?utf-8?B?UGE0Y2VockRQbWswOVJGam41QUpHMlNUd3drNnNXY1pIQzd6NlNWVzVkVTZp?=
 =?utf-8?B?b0dqYXAyU1lwNStoWE0vb2l0eWw5Smg4bGVZRVhOMS9GM1NJZWZselVsU1Nu?=
 =?utf-8?B?dERoOWNsYmFBNFhHb3BhM1dQcDBFejhxbjlBOFc2cFhtTm5UVTB2a0pFRDZE?=
 =?utf-8?B?RVpFWFFKSFNSdnVKMlZCaVc2d0IxOVV3ZXprUk1sLzdraWFucGlWK3FRWXE2?=
 =?utf-8?B?LzBoTUFIMlhTaldVT0NVN1pIR2FtUU0vMDJDcWk3emp2U0oyRUxJRTBnUmc3?=
 =?utf-8?B?UmJOUi95M0MwT214SzhLS0FZS1A4QXhqbHdRcFphNUZka1ZLY293aEVxMk5V?=
 =?utf-8?B?WW1RSUtaUnFSbm1oSDk5cFhpRTBkWGdBbjJMckF2NWZZMUtwMDV2U2p1Vm9X?=
 =?utf-8?B?S3NBWjhFZlJJZWFLVXkrVEFWOENXUzRvU1BLS0p4UEM2TmxDNGJETGhZVG9U?=
 =?utf-8?B?YStyMjQvSTBING5SQWcrTmFTUG54NXFrVjIvNHIxcHYzOFRvaDFJWStrU1Rl?=
 =?utf-8?B?MlhuQXJ2WWpWN0pnTENwWTQwWGtTS3VkSjdMMHhuS3ZsNjd6RVhJTEY0NjNs?=
 =?utf-8?B?S3JISm83dllwU3ZKbHZFZ21HNjcvcy9xN0lJQk1XeEJNdW4yUkEreGtKUEg3?=
 =?utf-8?B?WXRGYlBSOHpCSVFFcDJJNy80R2xQazNJZEdkU2hVRnp2N3VJbS9mNnNkZDh3?=
 =?utf-8?B?L29rQ2grT1lYQk5IQ0VqZk80VkMyUGNWWmRrNXB6NHcvTHpuRm9QenVHVzlW?=
 =?utf-8?B?b2JwNk0vNzl4Zy96OXcxOERzQ0daUlZpM2UrTWQ0UmJQOE1VNDZkc2M2VmR1?=
 =?utf-8?B?cXd5emFtUE0zY2dic3lDYVljOWpFL3FRV1dWTE1QNW0wc3puMTRLRHRyZEps?=
 =?utf-8?B?WUJjWjl2a0lUNmxrWEQ1d3VMalpKUW9nenowalg5cWNiakxROWxYUlV4SVlT?=
 =?utf-8?B?YlB3dGhuQmlZQjM4WXErM2crRm1QalgrRWlvTURQWndzeDBWMDNGT3JDYUU3?=
 =?utf-8?B?SHdYNlFNSUZ2VGd3UHlJMHpDRG16ZmpPcko2cStkbjliQmRKMlg0VnlIVzQ3?=
 =?utf-8?B?dkpmTzREeVA5SWwzQ2g2S0NhK1pQTDRhNU5ZNGhObmN4UUg4QUVIeENvRi94?=
 =?utf-8?B?MjFOQ3N5N1FJMXNJMWVJYTBSUTRnb1FQeDlyZlEyS1RpL3JvSUdSeFF3VDBo?=
 =?utf-8?B?TjVvMzRRWlVSNllkajluNXZ1VGZHMnp1MEg5V3gyN1B0MVkwTFlRV2xreGJR?=
 =?utf-8?B?U2pHR2duT3VEL2JxZEY1WFJrU21IWFNLYVF1ZExCazVVdUJ3STRtMWFKbDNO?=
 =?utf-8?B?OEk5NHA0VHlqcmd5L0VudjdKUGpVdEcrNjhmZm1EQjYwVURDV2NYb0VDQnpm?=
 =?utf-8?B?aFRkSnhQVzZuc2hHTUlYd1E3VzYrQVZHWndNVnVnSG8rWkErOUpLUmFWM2pL?=
 =?utf-8?B?cjl3cmxNcGd0TGo5YnBGMjl1QlBrekJLY25aNDUxajJMSjl4blBweExKS2I1?=
 =?utf-8?B?N2JGd3lUNWFvNENoMGVocms2cG4rR0o3Z2dwem1FUmNJOWR3WGZUbjJsZFpJ?=
 =?utf-8?B?alR4SkE4Z2RDcWpRNEVaMFBIeE16UTNwdGpaMzRHMWJtcFJZMEJrVDJ4TGpn?=
 =?utf-8?B?SWZQOXk2MXcrOVhOV0JXVkRuKzVPSEQvMHBHejB1amJuMXVCcTNRNlZodyth?=
 =?utf-8?B?WU1zTUFOSW1XbnBWZC84QjVXMzNveVZFb253cnNsVkJrY1ZPb1h4VWlRNFVC?=
 =?utf-8?B?d2JmNVVJZ0tFaTNXZkQ4QW8xdFR5OUpDbVFWUmhPOEhEbUd2SC9uRTF0YUdl?=
 =?utf-8?B?aWMrbG1XbDRzUSs1QkVPUlZqOWhPSmU5NlZTN3psemU1TTNHRG1rY1p6OTBp?=
 =?utf-8?B?QlB6YmlSOTJjZ2tEcTMvenlPb3RzTTJKV1NTbm9kNEpVWDA1NmJMK2xiS1B2?=
 =?utf-8?B?VTJhUklnbEcvRjdtVnZwK2svVlJSUzBoYnAzRnE1Y3JCakhTNW8yeEhVMmNx?=
 =?utf-8?Q?cHU5vJ24jd/ARsaDRpKDkEQ+u?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E3DD3A00593DB40AF8033367DDA5FD2@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6f9cb1-ebab-4d16-8723-08db97e61e7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 08:04:41.2400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4JPyLRnyUnRvY1qDkVVMZ1qL9IejDtngP6Nw8wquiwcyKsMpBIP7g76Y7y4jSs15MTjBKXNAOIPznhAKRRrVtHQCwpfvPA3ElrnXztaG+nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3279
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDI2LzA3LzIwMjMgw6AgMTc6MDIsIEhlcnZlIENvZGluYSBhIMOpY3JpdMKgOg0KPiBx
bWNfc2V0dXBfdHNhKiBhcmUgY2FsbGVkIG9uY2UgYXQgaW5pdGlhbGlzYXRpb24uDQo+IFRoZXkg
aW5pdGlhbGl6ZSB0aGUgUU1DIFRTQSB0YWJsZS4NCj4gSW4gb3JkZXIgdG8gaW50cm9kdWNlIHNl
dHVwIGZ1bmN0aW9uIGxhdGVyIG9uIGZvciBkeW5hbWljIHRpbWVzbG90cw0KPiBtYW5hZ2VtZW50
LCByZW5hbWUgdGhlIGZ1bmN0aW9uIHRvIGF2b2lkIGxhdGVyIGNvbmZ1c2lvbi4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEhlcnZlIENvZGluYSA8aGVydmUuY29kaW5hQGJvb3RsaW4uY29tPg0KDQpS
ZXZpZXdlZC1ieTogQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1
Pg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvc29jL2ZzbC9xZS9xbWMuYyB8IDE2ICsrKysrKysrLS0t
LS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2ZzbC9xZS9xbWMuYyBiL2RyaXZlcnMv
c29jL2ZzbC9xZS9xbWMuYw0KPiBpbmRleCAyMWFkN2U3OWU3YmQuLjY0YTExZjVjNmY4NSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9zb2MvZnNsL3FlL3FtYy5jDQo+ICsrKyBiL2RyaXZlcnMvc29j
L2ZzbC9xZS9xbWMuYw0KPiBAQCAtOTE5LDcgKzkxOSw3IEBAIHN0YXRpYyBpbnQgcW1jX29mX3Bh
cnNlX2NoYW5zKHN0cnVjdCBxbWMgKnFtYywgc3RydWN0IGRldmljZV9ub2RlICpucCkNCj4gICAJ
cmV0dXJuIHFtY19jaGVja19jaGFucyhxbWMpOw0KPiAgIH0NCj4gICANCj4gLXN0YXRpYyBpbnQg
cW1jX3NldHVwX3RzYV82NHJ4dHgoc3RydWN0IHFtYyAqcW1jLCBjb25zdCBzdHJ1Y3QgdHNhX3Nl
cmlhbF9pbmZvICppbmZvKQ0KPiArc3RhdGljIGludCBxbWNfaW5pdF90c2FfNjRyeHR4KHN0cnVj
dCBxbWMgKnFtYywgY29uc3Qgc3RydWN0IHRzYV9zZXJpYWxfaW5mbyAqaW5mbykNCj4gICB7DQo+
ICAgCXN0cnVjdCBxbWNfY2hhbiAqY2hhbjsNCj4gICAJdW5zaWduZWQgaW50IGk7DQo+IEBAIC05
NjEsNyArOTYxLDcgQEAgc3RhdGljIGludCBxbWNfc2V0dXBfdHNhXzY0cnh0eChzdHJ1Y3QgcW1j
ICpxbWMsIGNvbnN0IHN0cnVjdCB0c2Ffc2VyaWFsX2luZm8gKmkNCj4gICAJcmV0dXJuIDA7DQo+
ICAgfQ0KPiAgIA0KPiAtc3RhdGljIGludCBxbWNfc2V0dXBfdHNhXzMycnhfMzJ0eChzdHJ1Y3Qg
cW1jICpxbWMsIGNvbnN0IHN0cnVjdCB0c2Ffc2VyaWFsX2luZm8gKmluZm8pDQo+ICtzdGF0aWMg
aW50IHFtY19pbml0X3RzYV8zMnJ4XzMydHgoc3RydWN0IHFtYyAqcW1jLCBjb25zdCBzdHJ1Y3Qg
dHNhX3NlcmlhbF9pbmZvICppbmZvKQ0KPiAgIHsNCj4gICAJc3RydWN0IHFtY19jaGFuICpjaGFu
Ow0KPiAgIAl1bnNpZ25lZCBpbnQgaTsNCj4gQEAgLTEwMTksNyArMTAxOSw3IEBAIHN0YXRpYyBp
bnQgcW1jX3NldHVwX3RzYV8zMnJ4XzMydHgoc3RydWN0IHFtYyAqcW1jLCBjb25zdCBzdHJ1Y3Qg
dHNhX3NlcmlhbF9pbmZvDQo+ICAgCXJldHVybiAwOw0KPiAgIH0NCj4gICANCj4gLXN0YXRpYyBp
bnQgcW1jX3NldHVwX3RzYShzdHJ1Y3QgcW1jICpxbWMpDQo+ICtzdGF0aWMgaW50IHFtY19pbml0
X3RzYShzdHJ1Y3QgcW1jICpxbWMpDQo+ICAgew0KPiAgIAlzdHJ1Y3QgdHNhX3NlcmlhbF9pbmZv
IGluZm87DQo+ICAgCWludCByZXQ7DQo+IEBAIC0xMDMwLDEyICsxMDMwLDEyIEBAIHN0YXRpYyBp
bnQgcW1jX3NldHVwX3RzYShzdHJ1Y3QgcW1jICpxbWMpDQo+ICAgCQlyZXR1cm4gcmV0Ow0KPiAg
IA0KPiAgIAkvKg0KPiAtCSAqIFNldHVwIG9uZSBjb21tb24gNjQgZW50cmllcyB0YWJsZSBvciB0
d28gMzIgZW50cmllcyAob25lIGZvciBUeCBhbmQNCj4gLQkgKiBvbmUgZm9yIFR4KSBhY2NvcmRp
bmcgdG8gYXNzaWduZWQgVFMgbnVtYmVycy4NCj4gKwkgKiBJbml0aWFsaXplIG9uZSBjb21tb24g
NjQgZW50cmllcyB0YWJsZSBvciB0d28gMzIgZW50cmllcyAob25lIGZvciBUeA0KPiArCSAqIGFu
ZCBvbmUgZm9yIFR4KSBhY2NvcmRpbmcgdG8gYXNzaWduZWQgVFMgbnVtYmVycy4NCj4gICAJICov
DQo+ICAgCXJldHVybiAoKGluZm8ubmJfdHhfdHMgPiAzMikgfHwgKGluZm8ubmJfcnhfdHMgPiAz
MikpID8NCj4gLQkJcW1jX3NldHVwX3RzYV82NHJ4dHgocW1jLCAmaW5mbykgOg0KPiAtCQlxbWNf
c2V0dXBfdHNhXzMycnhfMzJ0eChxbWMsICZpbmZvKTsNCj4gKwkJcW1jX2luaXRfdHNhXzY0cnh0
eChxbWMsICZpbmZvKSA6DQo+ICsJCXFtY19pbml0X3RzYV8zMnJ4XzMydHgocW1jLCAmaW5mbyk7
DQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyBpbnQgcW1jX3NldHVwX2NoYW5fdHJuc3luYyhzdHJ1
Y3QgcW1jICpxbWMsIHN0cnVjdCBxbWNfY2hhbiAqY2hhbikNCj4gQEAgLTEzOTEsNyArMTM5MSw3
IEBAIHN0YXRpYyBpbnQgcW1jX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ICAgCXFtY193cml0ZTMyKHFtYy0+c2NjX3ByYW0gKyBRTUNfR0JMX0NfTUFTSzMyLCAweERFQkIy
MEUzKTsNCj4gICAJcW1jX3dyaXRlMTYocW1jLT5zY2NfcHJhbSArIFFNQ19HQkxfQ19NQVNLMTYs
IDB4RjBCOCk7DQo+ICAgDQo+IC0JcmV0ID0gcW1jX3NldHVwX3RzYShxbWMpOw0KPiArCXJldCA9
IHFtY19pbml0X3RzYShxbWMpOw0KPiAgIAlpZiAocmV0KQ0KPiAgIAkJZ290byBlcnJfdHNhX3Nl
cmlhbF9kaXNjb25uZWN0Ow0KPiAgIA0K
