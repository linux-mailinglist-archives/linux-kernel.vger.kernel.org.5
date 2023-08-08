Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948BB773D11
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjHHQNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjHHQLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:11:30 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20609.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::609])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0F07D92;
        Tue,  8 Aug 2023 08:46:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTRpavrtIioZgdMJk6NXqRsg0JDrzxaX549N/jG6GKofUQENpwHCyWFqJpyb58vV/Igy95jM50PWswjNtbdgj5L9C8TVj5+ca+KBjmkv4y3vmtzlgk0+21m63dC5ULKZie2G1+QNHb4DeTZW4m2/pnV3aRhfvi7kXIvIeO8YGAoBIXj1fv9JZTTXeG+fkP1xBBbmvK8Dwnt9C4QeNkvb91KTvCbm6ptvh6rDHn2U1vNnsQXuqNed5YvxBPvs+TKzW524gK8wPIdFSw5qT1dsaaxPmtb8bC9gzqgAfkXJR9l7o1vB/6GBHbflqLgNj8/8JCDDEeXWmb2EnYhvsnno9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsWJCi+OnwfwYnaQH/f/k2r8I2NjLr4veDDyfxY0h6s=;
 b=jJmEGdaanQ2vq6FXkAKwnv8yVejPcH3/R04X+azYQoI30r+MrhhOEaFqw7e05yBZ/gO0lwVjBDYilr4YCkJL/bwvRuxtBpQ2jyt+oep/Z25idQorCbnEhX9U1+qtnPvu4cPLucBh0DuoeCgEaB8ppLb536mfD8qtVqq8VOuBQsHqj4RtDDwKYqUXOx/3HCIy72oa7pat7X7Kpwdai/XMO7cwvzzG7sk9WGC0ZzIBk7ItBYYf1EoqUAujB2lq9HT259SQoZH5biFAkffuehSPfWYkXXzgw6LOBk9rZvDjf3rNTLHATYif/XyZm+RtNcOsh1fda0KPnC7wYnlzwBR/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsWJCi+OnwfwYnaQH/f/k2r8I2NjLr4veDDyfxY0h6s=;
 b=OZkG1oeftXf4Yrrv/OlMrQfu6LNb2roZhbXI8JUm4z4i0sWymMhU5uRt2peH23fnGWSYuhCVIBLKegbCBlbHKq6vU/NXWDB+cpmxlzAst7fHbj7mRWjuFAbJpNLHYxTHlpby0+DVgecKlYwXbSzL5pY9casjQ7h8/klBmAiiSfY=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PAWPR04MB10031.eurprd04.prod.outlook.com (2603:10a6:102:38b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 11:49:34 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 11:49:34 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "clin@suse.com" <clin@suse.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Wei Fang <wei.fang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Bough Chen <haibo.chen@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [EXT] Re: [PATCH v4 4/7] arm64: dts: imx93-11x11-evk: added nxp
 secure enclave fw
Thread-Topic: [EXT] Re: [PATCH v4 4/7] arm64: dts: imx93-11x11-evk: added nxp
 secure enclave fw
Thread-Index: AQHZtLpCt80XNe94BE2xAgWYFY4Zrq+2fsMAgCnvgrCAAAJHYA==
Date:   Tue, 8 Aug 2023 11:49:34 +0000
Message-ID: <DU2PR04MB8630F001B107D331F9F5DE1E950DA@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
 <20230712121219.2654234-5-pankaj.gupta@nxp.com>
 <29cb4426-a15e-7186-1713-427f749bc187@linaro.org>
 <DU2PR04MB863043CFB54E4CF2C5F34B65950DA@DU2PR04MB8630.eurprd04.prod.outlook.com>
In-Reply-To: <DU2PR04MB863043CFB54E4CF2C5F34B65950DA@DU2PR04MB8630.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|PAWPR04MB10031:EE_
x-ms-office365-filtering-correlation-id: 24f264b3-4935-4fc2-1635-08db980588de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4nXJtC6zP065aAnX1hhRm/ToBfVBeZG8p7kASdgRyqOYsXStq6I5Sy1a/Obv9WNWCA4i+tFDZKJNNt7NsTLfVlIgLDRG5jekR+RK8qO0CyULWmAxYfL30AR1pSS0lOmnVRzpTdpjzqAqOU64AmC4fB5jnxutMwGTcjBgy+rUlfhCOxxyqLqcdl2BgpvYzLS1d1rk1Q8RkgN3847uU+omH2aP0aMr3CAXlMr0VIVFi3Fx6OHDJgFB4pJbzIGRaIFxotNXGrwZsFYTov8t/42Cu6VBuX/YulXvd1nhA0mgCXTDoKQ4yERtbvToB7FGbKfYmmvI5JllXgFNiw1RSYDFt4FmFn8PbfZalVgD290kvKYRakieJ2aheuC0DPKzkMCeSYeWMSGjRSS0K2F/gCc2rW3i0zpRgZ6pGwdvT0KeKjkiGCLC7wfXJt9CJEH33GhJgmkj2Yd2oG4lnBf4oIg5Gsd5GKdcfiwsRkhGJATb4PkKVh0Xz9Vx+ZyrChnE+VylE2Z6hEdgdStc0xXwofj1L34NgSReNhPAiWz799Xp3n/zFoftWeaD4EAbZGAKMhdd3Z54ADa1nDkBhUaIoV64c3wvVxqfYvmJFs8/IwcZ6XTI5ukonoh1lIFSF/ZME6IgExkhtNztm5JsPjjUUJ19dw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(1800799003)(186006)(451199021)(83380400001)(2940100002)(55016003)(921005)(2906002)(110136005)(6636002)(8936002)(316002)(5660300002)(38070700005)(44832011)(8676002)(52536014)(7416002)(64756008)(66946007)(66556008)(66446008)(66476007)(76116006)(38100700002)(86362001)(33656002)(478600001)(122000001)(9686003)(71200400001)(7696005)(41300700001)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3UrbkxxelpzVEwwMmxZamg5RDVRMHNnNVNqV0hoMU12TzQxN09kOTJMaTFh?=
 =?utf-8?B?UmdhSVBHdVJ5emtKN210d2laUk10LzdpRm5vWVZsMXN1ZzgwN2ZrWktNeDBD?=
 =?utf-8?B?bHExZTRhejVqbTJhZmxaY3Z4M2xIU245d1JnOVRPWGlaQWlZUS8rZ3dGSGpn?=
 =?utf-8?B?NzVGdFA3ZmdtMTB6bWdoeDM1Mk10TU5EZkMySGw0dWlUS2s4Sk8xbjNIY1cv?=
 =?utf-8?B?M3l1V3FJeC9OeTFWM0h4WE1kWmI2bWxvTnRXV1FZSjY3VHNuVkpxdkdvc3Nx?=
 =?utf-8?B?bUJqTVo5TnF1SFduQU1RR2c0V1BkV2gxUXF5SFB0MWp2SXhIS08xS3I1TSs3?=
 =?utf-8?B?VnYyZWl5dnJ3TDMyMUFZbTk0eld0WHZrc0hoMmhENHV3bXZjalduRlZMREpL?=
 =?utf-8?B?ZmNUVHVycnBnRGs2bzFFQnZIbkhwUHYyL0p4MXVNUGZjbVdWNWFKaXIzUksx?=
 =?utf-8?B?SyswVVFNMjlUSFBKWWxTVmU4TS9CR05LdnQ2aGs4ckdPVVUyUDd0MmkvaVY3?=
 =?utf-8?B?dEVtQVZ6WW1Gc0xtUE1FTTA0Y1J2QmY0bFRMZHlZb1ZSYk14K2dCYnlPNHdk?=
 =?utf-8?B?QjdLejVxb1BOOG5hVkN4OWF1QmxxWHJVcGJTWG16bFdPNStuSU9QdXZRTFZm?=
 =?utf-8?B?V0FKeFBLdVdHTDhEUm52a1lzQjNsSERpT0NUM1k4ZWgzVjVSVFFJNVZTU0hS?=
 =?utf-8?B?RjRqdEY2WldiRytDWk5DOEtpVVJCN1p4aFc0MWttZXdGbHg3b1R6bXhJNkRk?=
 =?utf-8?B?Unlha3lRd2NhSDNYS05UZi9BZ2hsSElUd05rTFNidkhZNlE2MUR4elRxMHRD?=
 =?utf-8?B?aXdzSXdzbHRpYnhoY2NOL051N1lNK1YzYkdNYThmUDNZWlNHRVZNdGg0ZlZW?=
 =?utf-8?B?QStFMS9lMkFxYVNPMmpOSmtZbzJyd3hZazV4eFNZdDA0blp0WENwS2VyVTQy?=
 =?utf-8?B?TkRkcmk2NlhSak8xcFU1bm5lRENFYVF1dzk5blZadHdkSFUyRmRtT3FsTFBr?=
 =?utf-8?B?RnhqbGttV1JWekxHRlZrLy9IdlVyU2FsT0dsRUlyVVFFUHVJM05vYlNLTW1Z?=
 =?utf-8?B?YWxKdk5JUGdiSjhYSkwyMWpoYzZHS3gwYldHZkhUbVp2a3g5ZmFCdVlQdEtW?=
 =?utf-8?B?bHdwN21uaHhQTG9IV2p4MVA4cE81K0xTc1psT1RScHVnZzlLVlp3RlJxSytT?=
 =?utf-8?B?TnloVWRua3VsbWQvZGtpNzJwRytvNzZJTUN0RGswZG1PSmRuSjl1YU9OS1RN?=
 =?utf-8?B?ampzOEdUWmpzaTdyL0dOTXVmNVRPU1AxMGNXbzRVbys3dEtVWW10SjVseHZW?=
 =?utf-8?B?SW01dDJnZXpDUUlaMEhBQkFiMkRlSXJjMnF0ZzEwaGt2cnE0NXZjVm5nNjZy?=
 =?utf-8?B?UmdDSlBwSmVMKzFmVS9ydGl2TGNyQXF5Nnh4cDZCWG4yM29SRS9VNWRhL2du?=
 =?utf-8?B?R2FueGZGN2o5YkpmenBVS25QVHpJSUlrTkxhbjhvZ25pcmxDRmxEK0d2N01a?=
 =?utf-8?B?YnQzSzlCemVLQlc5b3AwY1VqS3NqVmlMaWZMbnR1WVA0M3g1TXkvbkk0M0NQ?=
 =?utf-8?B?VlNQdXNweHRQQmpkSENZWnFVeTFYSm80ZUdVa2JyYTNOZ01lRWFSaDdIRlJH?=
 =?utf-8?B?dWh0V3F3QU1NcVlRWjZXOUYzNWJMOXNNdkdreXVYRTZUVXJlNDh5c1hrQWhC?=
 =?utf-8?B?Tnp2ZTBBUnppcTU0eFVOYnlBbmc0NzRPMllsdUNQK1lKa3J2ak1RNkIrUlVF?=
 =?utf-8?B?TkJHSlY3bUVQcE04ZDhuTGkzOXh1emtkRUZ6a3VLVk53QStiUzg5N0lBaTlk?=
 =?utf-8?B?cUtiQUtuTnJZYS9mSE53Z3RxY0tDMFpFR0RlSzZldXpDdmNiMC93MjMzdW52?=
 =?utf-8?B?aFB4RDJxYmNzRDI5T2RSNm55RlQ1aG5CNzUwZ1VIUkFxdXZDc2VvL1dkUHIr?=
 =?utf-8?B?TytCTEZFYmZGSVhoeGpiSEhJcU1Wc1NuUS9NUHVZOHRTS1pOeXIzOFZjQnFo?=
 =?utf-8?B?LzM2ejRBRnV0QXJoTzZ3ZnVRNkVuNkZWek1JeTMxNTlMRkl1TTVoODVaRUx1?=
 =?utf-8?B?eCtUOHdIMTFhSFdLdG5GcS9JU2ZFM1NLMHY1dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f264b3-4935-4fc2-1635-08db980588de
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 11:49:34.1389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IAY2rsIOr4yZsesS56QMihlHCxkqE8c2KAkY+G78PI6SRbZl3UU5HgOuSH1eXaKxRUV9S79oAugtqBXn8oWv5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10031
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFua2FqIEd1cHRhDQo+
IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCA4LCAyMDIzIDU6MDQgUE0NCj4gVG86IEtyenlzenRvZiBL
b3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz47DQo+IHNoYXduZ3VvQGtl
cm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsN
Cj4gY2xpbkBzdXNlLmNvbTsgY29ub3IrZHRAa2VybmVsLm9yZzsgcGllcnJlLmdvbmRvaXNAYXJt
LmNvbTsgSmFja3kgQmFpDQo+IDxwaW5nLmJhaUBueHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlhb25p
bmcud2FuZ0BueHAuY29tPjsgV2VpIEZhbmcNCj4gPHdlaS5mYW5nQG54cC5jb20+OyBQZW5nIEZh
biA8cGVuZy5mYW5AbnhwLmNvbT47IEJvdWdoIENoZW4NCj4gPGhhaWJvLmNoZW5AbnhwLmNvbT47
IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14IDxsaW51eC0NCj4gaW14QG54cC5jb20+
OyBkYXZlbUBkYXZlbWxvZnQubmV0OyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IGtyenlzenRvZi5r
b3psb3dza2krZHRAbGluYXJvLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgR2F1cmF2IEphaW4NCj4gPGdhdXJhdi5qYWluQG54cC5jb20+OyBhbGV4YW5kZXIu
c3RlaW5AZXcudHEtZ3JvdXAuY29tOyBTYWhpbCBNYWxob3RyYQ0KPiA8c2FoaWwubWFsaG90cmFA
bnhwLmNvbT47IEFpc2hlbmcgRG9uZyA8YWlzaGVuZy5kb25nQG54cC5jb20+OyBWYXJ1bg0KPiBT
ZXRoaSA8Vi5TZXRoaUBueHAuY29tPg0KPiBTdWJqZWN0OiBSRTogW0VYVF0gUmU6IFtQQVRDSCB2
NCA0LzddIGFybTY0OiBkdHM6IGlteDkzLTExeDExLWV2azogYWRkZWQNCj4gbnhwIHNlY3VyZSBl
bmNsYXZlIGZ3DQo+IA0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5v
cmc+DQo+ID4gU2VudDogVGh1cnNkYXksIEp1bHkgMTMsIDIwMjMgMTI6MzggQU0NCj4gPiBUbzog
UGFua2FqIEd1cHRhIDxwYW5rYWouZ3VwdGFAbnhwLmNvbT47IHNoYXduZ3VvQGtlcm5lbC5vcmc7
DQo+ID4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBjbGlu
QHN1c2UuY29tOw0KPiA+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IHBpZXJyZS5nb25kb2lzQGFybS5j
b207IEphY2t5IEJhaQ0KPiA+IDxwaW5nLmJhaUBueHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlhb25p
bmcud2FuZ0BueHAuY29tPjsgV2VpIEZhbmcNCj4gPiA8d2VpLmZhbmdAbnhwLmNvbT47IFBlbmcg
RmFuIDxwZW5nLmZhbkBueHAuY29tPjsgQm91Z2ggQ2hlbg0KPiA+IDxoYWliby5jaGVuQG54cC5j
b20+OyBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlteCA8bGludXgtDQo+ID4gaW14QG54
cC5jb20+OyBkYXZlbUBkYXZlbWxvZnQubmV0OyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+ID4ga3J6
eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOw0KPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsNCj4gPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgR2F1cmF2IEphaW4NCj4gPiA8Z2F1cmF2LmphaW5Abnhw
LmNvbT47IGFsZXhhbmRlci5zdGVpbkBldy50cS1ncm91cC5jb207IFNhaGlsIE1hbGhvdHJhDQo+
ID4gPHNhaGlsLm1hbGhvdHJhQG54cC5jb20+OyBBaXNoZW5nIERvbmcgPGFpc2hlbmcuZG9uZ0Bu
eHAuY29tPjsNCj4gVmFydW4NCj4gPiBTZXRoaSA8Vi5TZXRoaUBueHAuY29tPg0KPiA+IFN1Ympl
Y3Q6IFtFWFRdIFJlOiBbUEFUQ0ggdjQgNC83XSBhcm02NDogZHRzOiBpbXg5My0xMXgxMS1ldms6
IGFkZGVkDQo+ID4gbnhwIHNlY3VyZSBlbmNsYXZlIGZ3DQo+ID4NCj4gPiBDYXV0aW9uOiBUaGlz
IGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcNCj4g
PiBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhl
IG1lc3NhZ2UgdXNpbmcNCj4gPiB0aGUgJ1JlcG9ydCB0aGlzIGVtYWlsJyBidXR0b24NCj4gPg0K
PiA+DQo+ID4gT24gMTIvMDcvMjAyMyAxNDoxMiwgUGFua2FqIEd1cHRhIHdyb3RlOg0KPiA+ID4g
QWRkZWQgc3VwcG9ydCBmb3IgTlhQIHNlY3VyZSBlbmNsYXZlIGNhbGxlZCBFZGdlTG9jayBFbmNs
YXZlDQo+ID4gPiBmaXJtd2FyZQ0KPiA+ID4gKHNlLWZ3KSBmb3IgaW14OTMtMTF4MTEtZXZrLg0K
PiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFBhbmthaiBHdXB0YSA8cGFua2FqLmd1cHRhQG54
cC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg5My5kdHNpIHwgMTEgKysrKysrKysrKy0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5My5kdHNpDQo+ID4gPiBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDkzLmR0c2kNCj4gPiA+IGluZGV4IDg2NDM2MTJhY2U4Yy4u
MmIwZjkwMWQyNzA5IDEwMDY0NA0KPiA+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OTMuZHRzaQ0KPiA+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OTMuZHRzaQ0KPiA+ID4gQEAgLTEsNiArMSw2IEBADQo+ID4gPiAgLy8gU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IChHUEwtMi4wKyBPUiBNSVQpDQo+ID4gPiAgLyoNCj4gPiA+IC0gKiBD
b3B5cmlnaHQgMjAyMiBOWFANCj4gPiA+ICsgKiBDb3B5cmlnaHQgMjAyMi0yMDIzIE5YUA0KPiA+
ID4gICAqLw0KPiA+ID4NCj4gPiA+ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svaW14OTMt
Y2xvY2suaD4gQEAgLTg2Myw1ICs4NjMsMTQgQEANCj4gPiA+IGRkci1wbXVANGUzMDBkYzAgew0K
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDRlMzAwZGMwIDB4MjAwPjsNCj4g
PiA+ICAgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgOTAgSVJRX1RZ
UEVfTEVWRUxfSElHSD47DQo+ID4gPiAgICAgICAgICAgICAgIH07DQo+ID4gPiArDQo+ID4gPiAr
ICAgICAgICAgICAgIGVsZV9mdzogc2UtZncgew0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
IGNvbXBhdGlibGUgPSAiZnNsLGlteDkzLWVsZSI7DQo+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgbWJveGVzID0gPCZzNG11YXAgMCAwICZzNG11YXAgMSAwPjsNCj4gPg0KPiA+IFRoaXMgc2hv
dWxkIGJlIHR3byBlbnRyaWVzLg0KPiA+DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgbWJv
eC1uYW1lcyA9ICJ0eCIsICJyeCI7DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgZnNsLG11
LWRpZCA9IDwzPjsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBmc2wsbXUtaWQgPSA8Mj47
DQo+ID4NCj4gPiBEcm9wIGJvdGguIFNpbmNlIHlvdSBwdXQgaXQgaW50byB0aGUgRFRTSSwgaXQg
bWVhbnMgaXQgaXMgY29tcGF0aWJsZSBzcGVjaWZpYy4NCj4gW1Bhbmthal0gUmVtb3ZlZCB0aGUg
YWJvdmUgdGhyZWUgZW50cmllcy4NCg0KDQpbUGFua2FqXSBDb3JyZWN0aW9uOiANCkkgbWlzc2Vk
IHRvIG5vdGUgdGhhdCBpbiBvdXIgdXAtY29taW5nIFNvQyhzKSwgdGhlcmUgd2lsbCBiZSBtdWx0
aXBsZSBNVShzKToNClRob3NlIGNhbiBvbmx5IGJlIGlkZW50aWZpZWQgdXNpbmcgbXVfaWQuIEhl
bmNlLCBmb2xsb3dpbmcgdHdvIG9ubHksIHdpbGwgYmUgcmVtb3ZlZDoNCisgICAgICAgICAgICAg
ICAgICAgICBtYm94LW5hbWVzID0gInR4IiwgInJ4IjsNCisgICAgICAgICAgICAgICAgICAgICBm
c2wsbXUtZGlkID0gPDM+Ow0KDQoNCj4gDQo+ID4NCj4gPiA+ICsgICAgICAgICAgICAgICAgICAg
ICBzdGF0dXMgPSAib2theSI7DQo+ID4NCj4gPiBEcm9wLg0KPiBbUGFua2FqXSBBY2NlcHRlZC4N
Cj4gPg0KPiA+DQo+ID4NCj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gS3J6eXN6dG9mDQoNCg==
