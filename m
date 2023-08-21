Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D677821A9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 04:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjHUCrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 22:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjHUCrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 22:47:31 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FEF9C;
        Sun, 20 Aug 2023 19:47:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uj9KAHUb1zZiEuSR3XlHRnG+sLQAmxnqihFRinQFXz9UHwMWrGCQN9WIFZ8lSeYIDKPEfjlS45c2rdTISsO9HrEM+mtWtG9h/2hAFFDQwaK0XRm5Ya44puFnkHdnacX0GQQBqZ96+J6J70ymlEtpTcGfbl06MsvyxclYHkqJySCR9VM1DIhx+D6DJL83uJPhBPirumuD1cPCkoAgwt66UDoo2Kqu2w8I8O41LYRZALBNQGMcLst0sTx4B2DVEZqtAhWSipRFNOIVF1g5Jhpmblue4+2jWKU2z2Vhd7r8uZmYfKlguP9V1ay9LBAvYqPGBVV8LwXA9z2izxP+JHiE0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPhonJSRy/gTEDgCM2CfAb/Zw+yEnK5vMZ0roUXbDtk=;
 b=dCZfqtHNAflDNlwutuIOzn2r5R5W0exbtRm7o6wB4DbSgpdRLQAcEWpmZZuazkXa3ddzBLEbgKkP2EeHaghWkuYVQkdyXI3rys0fgaoC8UikEcL98RI4HrmhGzcMteF9Iz5KS6sLdmAPTZqgmmiZ0momRCBE2CFl5ztSobIeRxtDDffB9BKBSJwALeV2LFXLvtw2Gvs6a950a3GGCpM9nImpbB4bmSms3UQNwzXz77bhqIXIwh99VURmriIW6qbMnAE71lnJwsYVsb5gsxTeAlPE3QJfJInt0C+n3KTJhJwWNmkr0/2U2t+AzFy6iJv5tGo/Ns3uu1sL5Vs9u0eHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPhonJSRy/gTEDgCM2CfAb/Zw+yEnK5vMZ0roUXbDtk=;
 b=YeOysmhwrbZJLFs67r99P6WfisOywCI4joFKQJXt0LJmUTH41gk0Jqu18NR12l0vbuzNPXNZJ5q9hYdc1gUP2UPNPIUEAbzXv2Uwy8bi7FhkryiqxtR+ElYb1FUMuLzrgsjNgfC2bOGEHPR+db7QC62Q4+nkUvDXwQwdUKKhiw8=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PAXPR04MB9665.eurprd04.prod.outlook.com (2603:10a6:102:240::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 02:47:27 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc%5]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 02:47:27 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>
Subject: RE: [PATCH 2/2] gpio: mxc: switch to dynamic allocat GPIO base
Thread-Topic: [PATCH 2/2] gpio: mxc: switch to dynamic allocat GPIO base
Thread-Index: AQHZf/ixhsRn2C69wE6fqCaO7uCOK69NNxAAgKd7FzA=
Date:   Mon, 21 Aug 2023 02:47:26 +0000
Message-ID: <DB7PR04MB40102AA686099ED666C93EF5901EA@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20230506085928.933737-1-haibo.chen@nxp.com>
 <20230506085928.933737-2-haibo.chen@nxp.com>
 <CACRpkdYUGwEn-4T+Ay-KckO3ChFNqOrdVuP93u=gs5uc9fY0yw@mail.gmail.com>
In-Reply-To: <CACRpkdYUGwEn-4T+Ay-KckO3ChFNqOrdVuP93u=gs5uc9fY0yw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|PAXPR04MB9665:EE_
x-ms-office365-filtering-correlation-id: 6de7dd2d-cf09-490d-4798-08dba1f0f491
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SQPIrrNz00cZ5pVJzES1IsInDeGCat6Sy1PbB7NxmXCclcvcTeZZtAnhgZdsTsJGnJfoUOKTAU47QGhDDEVT6rp/b4dF/SE4Uba1T4HS/9bxifyawHQriLyWJ5WLybOCoW7cC83doQME9Rh54dt3jTJdwgn5D/41eWjUqR/uibBFDGVcjlAiJHe+Kl5+fLENsi/FHO9JyxLSSMU+fqqf5wjhMS5FVg4zUf5aIfK1r5hKm+KiA3pb1kArJQ7zr10yATeNK+j6M4xTV+hbC47vtM3HB5ZYNxGRouff4VV3JiY1WpWR/+tztALEPWHVAQQTCnDhD+qA4q6LmDNuIIjt42pIulx69ZyuW7rWOiKSFXPf0qr7lzcaorRI72J0gJ0Syx4eRYYubBWOwIzKlE3uX6v9hpSYP5BmB6jX6LWi7WSF8Xh7CJ3hFTLRbO0XZXYumqGMG6CIi+2XQyMCZ6D8qRhZns2rccVqbCmgQOpad2QYnGoRoCpSzy+UiFvCIe1jllZHP0tmoXVpKlPjPKFVynU8g7PU/hIYmeZfz78YVbxo7zTH/6Hx+xLXh9VFXZO5U8a1I4/sE6/GJ2GGUslWBBQE1yqXGdlzX4BRDk6oE3CtD69ukoCpyvSTve+CmZrc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(84040400005)(186009)(1800799009)(451199024)(66446008)(66476007)(64756008)(6916009)(54906003)(76116006)(66556008)(66946007)(316002)(9686003)(8676002)(8936002)(4326008)(41300700001)(122000001)(478600001)(71200400001)(55016003)(38070700005)(7696005)(38100700002)(53546011)(6506007)(4744005)(2906002)(83380400001)(86362001)(5660300002)(33656002)(26005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2ZyamRmS0lpVURGd1FIbEdsdzlVb0xtOXpKby9yY2JjMmxLdGhWaCtVYWtS?=
 =?utf-8?B?bHJydmhqcGdhRnBWNDdGdjZKOWNpdTdKR0hZbzBBU2FmeHFaSjZlZTVZNlRZ?=
 =?utf-8?B?UkhaRllyYmZsVUU4OHdaUWxjRjBIVTd4T29oc3VoOTlMWjJmQkxxRU42VHIr?=
 =?utf-8?B?aVNwQUNZNlBmYjMwVmo5ZFFYN0F2c1VRZW1McWJQOTRkQ1Q0THg5WWl2UDE3?=
 =?utf-8?B?cWx5YTMxTkdiRFJ6bVB4YmFzRlJrRDhpODdEZCtJQyszdVVPbGhvcUZ5L2E0?=
 =?utf-8?B?bkEyNlowRjdqTlVLTEtsQmJrYTZpaElLMnIyUFF2aHhodnRRcFpjdUlTSC9n?=
 =?utf-8?B?VDZ5VHRhVVhKS1dYNjk0cWhPNVppRUZYdjN4OVpKSm9hS2xyZ2gzeHpNSmV0?=
 =?utf-8?B?dnRnSmlPbDk3Nk4wYXBPR1dDZmtGamkwc0phSFQ3R2YxV1NrRElNL281NzBz?=
 =?utf-8?B?c01zZnRnblZmVHFPTVZ6Nks5Ynd0bVVwYkVLK09waU05d3hwTk1NZVVGcGtp?=
 =?utf-8?B?M1ZjckRjbmFsVnVhdVhtTkhtSndDUGo3TWwwK2wxNm04TllGQjd1V2k3cm43?=
 =?utf-8?B?RW9zZ0VvcytCNWFjcXVUS0hPTDlySEJNdnhiNDZpTDBYWnBESUJEc1NoK24z?=
 =?utf-8?B?Tjd0b3FLNGdmdWFLNmE0S2pFR3lqNisvWHQ5cDBZSVpDTGZBNi9rZ09DeE5r?=
 =?utf-8?B?ZDkzZCtEL0RGbnFTamV2ekZxa1IrMWUvSjhoWnZwcXdkUk11dEs5VEVyZ1FM?=
 =?utf-8?B?TytCVlM2cUVHSWNOMHc3TW1zWGdockZacDNHYnIyVEtRdGdZS1kvRjlrSHh2?=
 =?utf-8?B?eVdBc0swNmZjT3dVTkJmUlBHR1g5aGRTS3lRL05LM044U1h4alBwL0RvMXd5?=
 =?utf-8?B?ZDREMllVTzNWOTJQemsvelg1SFZ6MU0ySVV4NFNoV3dWbVQ3ZFBQcFJ3NTJM?=
 =?utf-8?B?cjFtSDQ4R2dpZkRJWHMrMlE1WWtRckdMSlo2cDNYNWpCelZEdFkvdmE5aUhO?=
 =?utf-8?B?N0NTeVNIM0ZKOVNuMmRiRlIvUDJpdVNoYlMzanFETk5IK1pWc2ZTdFlBN3E5?=
 =?utf-8?B?c0I0aG84SUdjZVA3QzV2ckRNYUowQXdmQzdocjE5SDdieXJWK0VjUXpnM3Vx?=
 =?utf-8?B?ejZSWkY5cTV1NVlhTXFBTUVmK1pwbDdVTDlUTGJFblRmRkptWDVMMTNYTThn?=
 =?utf-8?B?cU5FTk5BT0k4eTJBNVNqU21Hci9RaG1SUlNCK0UxMUt3QVNMSERjMWU4dlVq?=
 =?utf-8?B?NmlUNDJXODdjT010ZFFvR01qWUtwQ3ZleC85QnB5RGErd2xoQ1pzY1BoTndF?=
 =?utf-8?B?T3htOCtIcmNhNlAwQXU2ejJCQ2ZhajFsQ3BqTXUwTGlVVGI0dlNSbWgrN2gy?=
 =?utf-8?B?dm9BSjFONUlIRUV5RUkzcndGV3lUaHdWY0wzWE5MU1JIQ0NINFhENGRCcDhX?=
 =?utf-8?B?K0YrTWVjWlQ5WWU5RXpCNmI0NUkyVXZkdUR4U01ScUl0U0p4TXNld3hoY2Zi?=
 =?utf-8?B?UjBxUlhlSzR4S1VBRnl5WHhKT05FQVg3cXIzdVF0ZDVJOU5YcUJrVFQyWEt2?=
 =?utf-8?B?UVExWjRzRDIxV3B0b3RFeUVRcy9LM0s1ZWdIeVVXVDVHTm1WR1UzSkJlbjB3?=
 =?utf-8?B?bXpnZlZKdi9oL2xLM2VwRWI3eFczdUhBSVNNMzRBUEFrZGxCTjlxWTRONXJ2?=
 =?utf-8?B?LzdWNTUySXNlMVkyUHZlRmdCeTBZeFhGU1BmT2hnVi82Z28rRjFxVnptRjNH?=
 =?utf-8?B?UnpTWWZwMlRDN3RBZGZvMjhRY3JoRm05dUVtZGxxNVBlZGl2NHBacEpzYmts?=
 =?utf-8?B?SGwzdm9yeXFxL1FyckFYMXJsZTlaUXFPWjdzdnhoNU1uYWlBeEFaei9Na2Fj?=
 =?utf-8?B?MmFYLzl2SzVOZnRtWkFmWjJMbi8rbWwwYmZGSVl1T2JwUEI4REdEQWJRNEwx?=
 =?utf-8?B?UDFNM1BvNVgrdlNYbE5OL2xGYktsbFpmdW0wendhRWJxUytlYkRqTkU2Zzdo?=
 =?utf-8?B?S2liTjA1OWoxN095ZjVwS05UTVJMOU9xVmp3aTZEdGFzSTFLM1NMUkVGWmVO?=
 =?utf-8?B?MWZza2hyaVF3dWx6TWRhMG9jK3lhQzM2eWZIdGw3QnFkREpqRDhxTGhCS2Ev?=
 =?utf-8?Q?miH0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de7dd2d-cf09-490d-4798-08dba1f0f491
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 02:47:27.0116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3nB7UWM/vjzcI5xiljCYcUvusViLe21e1GU3cDQy9VbrxkUFU6cEVVdKJ1cv440AEVYRtih6m5sBp5cJXv84kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9665
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW51cyBXYWxsZWlqIDxsaW51
cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjPlubQ15pyINuaXpSAyMTowNg0KPiBU
bzogQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiBDYzogYnJnbEBiZ2Rldi5wbDsg
bGludXgtZ3Bpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBjaHJpc3RvcGhlLmxlcm95QGNz
Z3JvdXAuZXUNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGdwaW86IG14Yzogc3dpdGNoIHRv
IGR5bmFtaWMgYWxsb2NhdCBHUElPIGJhc2UNCj4gDQo+IE9uIFNhdCwgTWF5IDYsIDIwMjMgYXQg
MTA6NTbigK9BTSA8aGFpYm8uY2hlbkBueHAuY29tPiB3cm90ZToNCj4gDQo+ID4gRnJvbTogSGFp
Ym8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiA+DQo+ID4gZ3Bpb2xpYiB3YW50IHRvIGdl
dCBjb21wbGV0ZWx5IHJpZCBvZiBzdGF0aWMgZ3Bpb2Jhc2UgYWxsb2NhdGlvbiwgc28NCj4gPiBz
d2l0Y2ggdG8gZHluYW1pYyBhbGxvY2F0IEdQSU8gYmFzZSwgYWxzbyBjYW4gYXZvaWQgd2Fybmlu
Zw0KPiA+IG1lc3NhZ2U6DQo+ID4NCj4gPiBbICAgIDEuNTI5OTc0XSBncGlvIGdwaW9jaGlwMDog
U3RhdGljIGFsbG9jYXRpb24gb2YgR1BJTyBiYXNlDQo+ID4gaXMgZGVwcmVjYXRlZCwgdXNlIGR5
bmFtaWMgYWxsb2NhdGlvbi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhhaWJvIENoZW4gPGhh
aWJvLmNoZW5AbnhwLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBMaW51cyBXYWxsZWlqIDxsaW51
cy53YWxsZWlqQGxpbmFyby5vcmc+DQoNCkhpIExpbnVzIGFuZCBCYXJ0b3N6LA0KDQpGb3IgdGhp
cyBwYXRjaCwgc3RpbGwgbm90IGluIHRoZSBtYWluIHRydW5rIChMaW51eCA2LjUtcmM3KSBhbmQg
bGludXgtbmV4dChuZXh0LTIwMjMwODE4KS4NCkNhbiB5b3UgaGVscCBhcHBseSBvciBhbnkgY29t
bWVudD8NCg0KQmVzdCBSZWdhcmRzDQpIYWlibyBDaGVuDQoNCj4gDQo+IFlvdXJzLA0KPiBMaW51
cyBXYWxsZWlqDQo=
