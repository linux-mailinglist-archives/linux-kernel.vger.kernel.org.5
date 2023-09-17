Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EC67A35C2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 16:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbjIQOEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 10:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjIQOEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 10:04:13 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2085.outbound.protection.outlook.com [40.107.15.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF65113;
        Sun, 17 Sep 2023 07:04:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAdoAwWKxyMq8tr6Ko8UKM0alUFcPkZPqGLZ7Yrd+8LbM3QhU5gsdSMGHIXo5lHVp5uFI+KEMBtlgLnDVVvq4iCCXEBitlsVk5k8SiVXQDRMFPXjPFQtiVFNcDLhtWEqQoJeAXoAWg4M4AyGoSBcs5ImtioWRU7/d0O+OxpZl290cl6V30wADqgrEQ04lPSjTLnM+Hjqp33tEldxLxHjJouABxn/+erMSa97rklOFns9p0VRTS19DrL4Bp5w09kcmimUm5CK+Gu8cUYdmLNHYqI+n2M/saH/8k/45YhZrn1JLGhCsLbBI4WbQeLOi7M+T8B0AbfpV9IKW+F7jfzPrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JRk+Pa2Cdurixq19TU0bqapdq9GY+DmYaHAKrZcHTU=;
 b=KBIql3Uw/LV2OTfXkMe3ZWOLgSQyyfKHwVmuSoQLkFuVQ6WjDO1yv6kPbOIE2ZywFggsbeHL7mOkZ0VEa+/JNiAOpDkbwS8U6SPmYA3Cfjtl8CFhW3RzKZzbypwGkg2NU1tZWCsv22k/eC/NdqpLLLaBaSmfJ87vX4kQT7qxubQYIkaRiZYBwQB0XfxpU4syo2D2J3ismAPbHH1XjSG6i3XLYvh/Oq6y023/iqiFiU4iI1HE8U0Rt0Q17sp2PB2cZWk5/xdSCeJAQZU6ujG5fD0QsIf9s7U3f6r58JmLjBCm61FVJ/9TpT+im72COqVo43xgQ9Rqs2VXusQch9rHLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JRk+Pa2Cdurixq19TU0bqapdq9GY+DmYaHAKrZcHTU=;
 b=q3kCLP/7Y2lqsUkydSvpb+/jECpO6DNtlCaaU3fjhL4x+zkJEjkOoYI8ZuDA/MUKr34478LSyvUzwpcDlBxh0C19WpGBj9WK+RxNljn/DnLG4qK5hkH7a7nP+BYigjzPqu9AL1sWKy+ajyMQzxeFDoMkA0YqJ6CQIWGCPmKFfXI=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9374.eurprd04.prod.outlook.com (2603:10a6:102:2b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Sun, 17 Sep
 2023 14:04:04 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::9b66:c45:32e0:6b1c]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::9b66:c45:32e0:6b1c%6]) with mapi id 15.20.6792.024; Sun, 17 Sep 2023
 14:04:04 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "amitkarwar@gmail.com" <amitkarwar@gmail.com>,
        "ganapathi017@gmail.com" <ganapathi017@gmail.com>,
        "huxinming820@gmail.com" <huxinming820@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Francesco Dolcini <francesco@dolcini.it>
Subject: RE: [EXT] Re: [PATCH v4 0/1] Patch History
Thread-Topic: [EXT] Re: [PATCH v4 0/1] Patch History
Thread-Index: AdnPR2z5RfEdmhOXQ3+2NbaQx2XQrwXju21AACdlNoAAGn0WwAAF3zcAAF5lr+A=
Date:   Sun, 17 Sep 2023 14:04:04 +0000
Message-ID: <PA4PR04MB96380F574686D258CDE76705D1F4A@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <PA4PR04MB9638B8753EFD81E174E55BC3D114A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB96381E2BC08BD1B636067413D1F7A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXP9rytcdS1Ao4RbfEULU2kwm4fRiu1MC1H59HABWGPdEg@mail.gmail.com>
 <PA4PR04MB96385D1A60A99C17E6140C67D1F6A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXO0aQz0Y+Z2=zMcgC2=xGBXB_BoKFYiT4mP9pcDS-YBxg@mail.gmail.com>
In-Reply-To: <CA+ASDXO0aQz0Y+Z2=zMcgC2=xGBXB_BoKFYiT4mP9pcDS-YBxg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PAXPR04MB9374:EE_
x-ms-office365-filtering-correlation-id: 45c6df14-e380-4934-322c-08dbb786f3bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: flcEML0PjGmyOEutk9SHEKgCbi9ZJHc6yRGzrINXOwINXsVJKaEuJcyVYvU9hdLIE+2I+3R9grjpW5acSIhidpZij5+PHuPCxAMXySK3y7+5bd62xock27BvCH2aNQ4bt01jwtAqmppk4xAO37g8s51TOSW7PxIiXuGfgVmc1bGjA5y9MlBruVyuHiC+maENY6Yrjm10xpELhy2eiZSrOIYHjRWxaprQZytvtdrnpWjo009xyWAxFd32zLfdfSj2GBUD2HDaF+OydyYnQ476kmlKQJXMbn4tyePHZMLXPKk9Rupx7rUKgGNFhtoqsRhpp/5r98LGTGPLIabJ94DHG0b14V9EDyjVXWypYUj0ftmP9Mb/tm604+sRdV4mlKJxAUbN6gBIGZG4mOe/bOyOfbH5lNoukQiI2vgWKW5AMFDnJk3pN7qWExfKqMYuNNMFCZdxOqsEcjqwIgZVTQoC0VFAWPLsxHXbFFDSvCBrFktlE+/R4+3GN70wMMWzzr55141A1UjRPvqq61nTYHlz/Sgd49SyCZaJGhJY28aaIn9x+lpPCvQmehHVFY8eqR1MzN3uFa9hfpEIMytLoSUzLzQs1boER75dUP4lAkOpJXxSeQQFP+ob8esPAF64BzXg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199024)(186009)(1800799009)(55016003)(86362001)(33656002)(83380400001)(122000001)(6506007)(53546011)(26005)(71200400001)(7696005)(9686003)(66556008)(6916009)(64756008)(66446008)(66476007)(478600001)(316002)(54906003)(66946007)(76116006)(2906002)(7416002)(5660300002)(38100700002)(38070700005)(4326008)(8676002)(8936002)(41300700001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aitJRmt3Y0RtaExsbHo2Nm5LanVhUkVseTJiSEMwTXhEOWhXRFlGZlpvR21z?=
 =?utf-8?B?ZHJRUlUrQUJvTHNaVWhXOG9uM0VIRnR5Z21LdThMTndzUmx0ZGUzbFNub0Na?=
 =?utf-8?B?L2hWbTF4RUpxcUF3VjI4UW1tQ3paSGpGRXNydStGUDhZaHJwT1FneTFFWTdp?=
 =?utf-8?B?RmpVdTcrRDB3QVJnaTdRbkQ0OXc2dVNSUGxOTThzdWVGU3EzQ1RGNU9YdnlH?=
 =?utf-8?B?M2FIUUxLcWRSejNhemk3bTk1bFc4bkRvM0V6YzBoa0dhOVNOanRpL0wrV3VQ?=
 =?utf-8?B?aUsxOVVLRDdQNzR4ZEhlbnJWOTl0ZGV2WEtFTmhxNUlDS3h0NjVHYmpnVVND?=
 =?utf-8?B?VlFwOUJPNGZwallQMDhZMzZyU0VScXNBVGpnZFlydnhjRFVjWVhSYmFJZlFt?=
 =?utf-8?B?a0IxMjdDWkI0b1pDdGtXbVp1S3JydlEvdUZmVzVKWDBSQVdwaVBYUVVlbHVR?=
 =?utf-8?B?L3ErOEgzVFFTY01UQXcxTUhhbUsyNXlvLzFmd0dtVjMxQkl6em9IUTZoQTJX?=
 =?utf-8?B?S2VEb1c3YWdUMFZoZXUxeEFTcDlXTEFlR0YrT0pSM2RXM0xnNFpJMXBrSy85?=
 =?utf-8?B?S2hFQ25pK2dGZ3c0SnRHVVBFS3dKb3cvSUoxWDloVUtjSkpqSlZERThyRU1H?=
 =?utf-8?B?MW16R3RQWElEc3krRjRSVVYvUy9KV1g2aU5RZlpKdklmZ1ZXb3lDZUdQU1Vo?=
 =?utf-8?B?T1pxL1FQelVFTS9LV1JKVlJvT0lXcGJWYlhSMXkvSVpMNDc1U1hLN2ozZlNU?=
 =?utf-8?B?UGtwZW9mMXRoNGkzam5nUHN4elU2bU42eW1VcWZLOVdiMVQ1Y09UWDZPalVx?=
 =?utf-8?B?ek9kNG1BR1RTVGlFNHdsSVYzd1R1S3JOTDhRWU1neUxhNGQxN2l3aE1iR1dQ?=
 =?utf-8?B?SkFvREdHMVRDOVNqazRWOHJ4ZWlEejQzMjRDaElGQ1pIaksxVmlmOGFlbEdH?=
 =?utf-8?B?bmFVRU9LVmF6QjNuQ2pVZDNxRFNXWEJIYTMvQkpTckJBNWxsb282QXdWMkht?=
 =?utf-8?B?YTlva2pDTTJGc205TXhMa28vY0NqbytQNXpaVWVkZGVYVzladURPTGxENkp1?=
 =?utf-8?B?ZEI3RzRHUTk3SFdqNCtDRFkvdm5OTmc1QVArcHRjbGNub1grcVo4TVF3bzhv?=
 =?utf-8?B?ZnZKZ1JnenhDQmNYcTh3V3dJZVZkZnVOS3RXNjBpOGI5a2R6cUhJRlFqWmJ5?=
 =?utf-8?B?NU9VbVNxS1ZCTElpOVZKTDEya1N3Y05wN3dlUERmYzVhSk0rZ01GQ2RNaWo4?=
 =?utf-8?B?Q1g5TkJTMnZDQkZYbWNXMkwvcWs3SklLSDVIMmprQ0g5WGg3Zjg2NlVFdVRr?=
 =?utf-8?B?eHYwUHFpWEoxUnhwbmord2VpY2thS1dEcW42TS90V2ZkYWhlb2lOamhEcERi?=
 =?utf-8?B?UHMva1pwdzVqVGd4Z1AxMFZkUGFvc2ttUUhvWWZaU1pYcWZVbHdlaUdmZkJh?=
 =?utf-8?B?WlFmdzRQV282ZDM0UUQ2Y05kUHdUalpiSWEvTDM3SmFVTk1ha2QwQ2R2RnR0?=
 =?utf-8?B?bXA3UUl6WFBJMVRON3JWK0lpQk5MeUZvQ1BOcG5OZCttbzJISDFIQmhTMkhH?=
 =?utf-8?B?YU1JWG5CK0NXTlgzbHdCZlgveHdzWEtMaFlySElJVWhWZnRvRjRudWpyRjh3?=
 =?utf-8?B?UDdhQnVkT2RHRXVMZzdRcE9Da0VSQmNuTms0N01jZmM2QjdTUjRtcTFocFJ6?=
 =?utf-8?B?QzA4cDZPRDEzdEg2RGc5MU9PRU1pVlVYS2ZMZ1dXRmNDcHdycDBOeHliU2k0?=
 =?utf-8?B?VFhrVkQ4azlxU1lEVTBnWUpzUzBQTHM0T0FGalBHR1FuRzQvS1YrOXQxRHFa?=
 =?utf-8?B?a0JrcmZIOWk4S3FuSHpYdGFSYmdtTTNqVWxpaWROZmJNSXJJTkFaeXZ2U0NC?=
 =?utf-8?B?dnRzOWtvcHZheldLaDFIZFdzSVhtQ2lSVEhROEUrUmFsMkZJaTh3aVdIK1JW?=
 =?utf-8?B?NWlaYitvN0VwVWhnOGZOYVlra1R3Q28yL3lmdEtiSnBMcDJuZ1Q4RXVYN1ZG?=
 =?utf-8?B?QVNyNFJFSkRhRzhnTnQ2cVBBTytNS1FKVmtKNFdTR24xQ3Jld0pkQ3NBTTI3?=
 =?utf-8?B?WURzKzZ3NHo4V0NCbVdoNk16K2hFMWNWK0llRFE5RzdUa0srNGlGUWVaSWdD?=
 =?utf-8?Q?ohuMPdmwr4McNZ/Ff/VYIWA0u?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c6df14-e380-4934-322c-08dbb786f3bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2023 14:04:04.5364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1lY4VycV7yxi9TIyDkC6C+aSAoPZYj21EOKwq90D6QzRe9BphonK8PvZPMtE9QX4wK1gSmXvXE4Uf/IE8YEEuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9374
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCcmlhbiBOb3JyaXMgPGJyaWFubm9ycmlzQGNocm9taXVtLm9yZz4NCj4gU2VudDog
U2F0dXJkYXksIFNlcHRlbWJlciAxNiwgMjAyMyAxMjo1NSBBTQ0KPiBUbzogRGF2aWQgTGluIDx5
dS1oYW8ubGluQG54cC5jb20+DQo+IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNoYXJ2YXJpDQo+IEhhcmlzYW5nYW0gPHNo
YXJ2YXJpLmhhcmlzYW5nYW1AbnhwLmNvbT47IFBldGUgSHNpZWgNCj4gPHRzdW5nLWhzaWVuLmhz
aWVoQG54cC5jb20+OyBrdmFsb0BrZXJuZWwub3JnOyBhbWl0a2Fyd2FyQGdtYWlsLmNvbTsNCj4g
Z2FuYXBhdGhpMDE3QGdtYWlsLmNvbTsgaHV4aW5taW5nODIwQGdtYWlsLmNvbTsNCj4gZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgcGFiZW5pQHJlZGhhdC5jb207DQo+
IEZyYW5jZXNjbyBEb2xjaW5pIDxmcmFuY2VzY29AZG9sY2luaS5pdD4NCj4gU3ViamVjdDogUmU6
IFtFWFRdIFJlOiBbUEFUQ0ggdjQgMC8xXSBQYXRjaCBIaXN0b3J5DQo+IA0KPiBDYXV0aW9uOiBU
aGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcg
bGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRo
ZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+IHRoaXMgZW1haWwnIGJ1dHRvbg0KPiANCj4g
DQo+IE9uIEZyaSwgU2VwIDE1LCAyMDIzIGF0IDc6MTnigK9BTSBEYXZpZCBMaW4gPHl1LWhhby5s
aW5AbnhwLmNvbT4gd3JvdGU6DQo+ID4gRm9sbG93aW5nIGlzIHRoZSBtYWlsaW5nIGxpc3QgSSBj
b2xsZWN0ZWQgdW50aWwgbm93LiBJZiBJIHN0aWxsIG1pc3Mgc29tZW9uZSwNCj4gcGxlYXNlIGxl
dCBtZSBrbm93Lg0KPiA+DQo+ID4gPDxtd2lmaWV4IG1haWxpbmcgbGlzdD4+DQo+ID4gbGludXgt
d2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZztzaGFydmFyaS5oYXJpc2FuZ2FtQG54cC5jb207eXUtaGFvLmxpbkBueA0KPiA+DQo+IHAuY29t
O3RzdW5nLWhzaWVuLmhzaWVoQG54cC5jb207a3ZhbG9Aa2VybmVsLm9yZzthbWl0a2Fyd2FyQGdt
YWlsLmNvDQo+IG07DQo+ID4NCj4gZ2FuYXBhdGhpMDE3QGdtYWlsLmNvbTtodXhpbm1pbmc4MjBA
Z21haWwuY29tO2RhdmVtQGRhdmVtbG9mdC5uZXQNCj4gO2VkdW0NCj4gPg0KPiBhemV0QGdvb2ds
ZS5jb207a3ViYUBrZXJuZWwub3JnO3BhYmVuaUByZWRoYXQuY29tO2ZyYW5jZXNjb0Bkb2xjaW5p
LmkNCj4gdA0KPiA+IDticmlhbm5vcnJpc0BjaHJvbWl1bS5vcmcNCj4gDQo+IEFGQUlDVCwgeW91
IGRpZG4ndCBhY3R1YWxseSBmaXggYW55dGhpbmcuIFRoYXQncyBhIG1vbnRocy1vbGQgbGlzdCAo
cGx1cw0KPiBtYW51YWxseSBhZGRpbmcgbWUpLiBEaWQgeW91IHJ1biBzY3JpcHRzL2dldF9tYWlu
dGFpbmVyLnBsIG9uIGEgcmVjZW50DQo+IHdpcmVsZXNzLW5leHQgdHJlZT8gTWluZSBsb29rcyBs
aWtlIHRoaXM6DQo+IA0KPiAkIHNjcmlwdHMvZ2V0X21haW50YWluZXIucGwgLWYgZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWFydmVsbC9td2lmaWV4L21haW4uYw0KPiBCcmlhbiBOb3JyaXMgPGJyaWFu
bm9ycmlzQGNocm9taXVtLm9yZz4gKG9kZCBmaXhlcjpNQVJWRUxMIE1XSUZJRVgNCj4gV0lSRUxF
U1MgRFJJVkVSKSBLYWxsZSBWYWxvIDxrdmFsb0BrZXJuZWwub3JnPiAobWFpbnRhaW5lcjpORVRX
T1JLSU5HDQo+IERSSVZFUlMgKFdJUkVMRVNTKSkgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwu
b3JnIChvcGVuIGxpc3Q6TUFSVkVMTA0KPiBNV0lGSUVYIFdJUkVMRVNTIERSSVZFUikgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZyAob3BlbiBsaXN0KQ0KDQpkbGluQGRsaW4tQXNwaXJlLUE1
MTQtNTRHOn4vcHJvamVjdHMvbnhwL0xpbnV4V2lyZWxlc3Mvd29ya2luZy93aXJlbGVzcy10ZXN0
aW5nJCAuL3NjcmlwdHMvZ2V0X21haW50YWluZXIucGwgLS1uby1naXQtZmFsbGJhY2sgLS1uby1y
b2xlcyAtLW5vLXJvbGVzdGF0cyBkcml2ZXJzL25ldC93aXJlbGVzcy9tYXJ2ZWxsL213aWZpZXgv
DQpCcmlhbiBOb3JyaXMgPGJyaWFubm9ycmlzQGNocm9taXVtLm9yZz4NCkthbGxlIFZhbG8gPGt2
YWxvQGtlcm5lbC5vcmc+DQpsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCmxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCg0KSSB1cGRhdGVkIG15IG1haWxpbmcgbGlzdCBhcyBmb2xs
b3dzIGFuZCBJIHdpbGwgdXNlIGl0IGZvciBmdXR1cmUgbXdpZmlleCBwYXRjaGVzOg0KDQo8PG13
aWZpZXggbWFpbGluZyBsaXN0Pj4NCmxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzticmlhbm5vcnJpc0BjaHJvbWl1bS5vcmc7a3ZhbG9A
a2VybmVsLm9yZztmcmFuY2VzY29AZG9sY2luaS5pdDtzaGFydmFyaS5oYXJpc2FuZ2FtQG54cC5j
b207eXUtaGFvLmxpbkBueHAuY29tO3RzdW5nLWhzaWVuLmhzaWVoQG54cC5jb20NCg0KVGhhbmtz
IGZvciB5b3VyIGhlbHAuDQo=
