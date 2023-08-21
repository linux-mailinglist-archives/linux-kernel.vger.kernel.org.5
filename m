Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C3E7821AB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 04:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjHUCr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 22:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjHUCry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 22:47:54 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2086.outbound.protection.outlook.com [40.107.241.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C433B0;
        Sun, 20 Aug 2023 19:47:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gq/dELHGKwd1Zrjs/aBiP9igIH2obQ/irGohNtqWIU3wSZJ+ny8p38ALPC6ZkWjUg22mVtmbdcTHF2AuEIp9x1O8Rwi5i7Y+bChA1P8cTI6R7ia6GkXWVB2s6S+W4EJvCnMsJ7P6rtMKBcdRkJBCdxnVE0YBqgxLiYQSRmLB+2XlnMHek3Tg0XfJCX6am4TjoZt47FMnEX9qv0NHNMaV/W3fj/ZYtGppzhHxtfudkc1X6V2Wxhd4XGK1So3UTc37v3XAXj+rBchG3MwtsLxaGq22x6SJmWT7bpKPgdSi5Dmam1TO3KFSHo0xvwUMDcNi+G6kt7aHHrwD1zGzCU1H1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oX1dY7Ho7tL/dB9V4quzHYjbeGowCNeCVawsMYfjteU=;
 b=hEhkzvltChi/H9i5WHeYGmvrJzdbjraDF1hhUuqAUtnDhk9xqhsKsyu+OLqn/CTSLzsF5gN3RKb1BVjS6ySKStHe7VZphwVBpXh+esbuzuv9rLo+6Rmj3D4etneYmK2UhIPm5lSxvpHgXunp9DRcqkyZDxFiCIGeBZ4ty9bC5onngQBDO/uAsCxWHNb6Le+q4ZiucOnBGR4U+4UMChBZXSm6IFabXKjJTp+46pd540Iujmi/O9KUyn/7D80Z6BQSCeGPk6ieKJ0srfBymm8YydvFjVCxvruAYfr68q3qxGiE3yHxYWI773uWCk/x6kiQEAKFJ8l4ZJQjzRzfyPGyag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oX1dY7Ho7tL/dB9V4quzHYjbeGowCNeCVawsMYfjteU=;
 b=mIKudXQ1hb49djDL4nZtPneL2EExltyGJcfTaHs7q2cfKlxy7Dgt0vSwVGzmhLXFIMe9uXufmcOp9ea7wr/G7WAPvbSwf4Y3aCcvsRKQxaD+OwiUsg1MC88YoUhCGR1s4/viBxFRmWTdh+zQtrTAfwDvzSYM9OMvb+4xNqTcfAM=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PAXPR04MB9665.eurprd04.prod.outlook.com (2603:10a6:102:240::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 02:47:46 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc%5]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 02:47:46 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>
Subject: RE: [PATCH 1/2] gpio: vf610: switch to dynamic allocat GPIO base
Thread-Topic: [PATCH 1/2] gpio: vf610: switch to dynamic allocat GPIO base
Thread-Index: AQHZf/ivpLBow9M5vkCKUkwatcI8oq9NNsYAgKd877A=
Date:   Mon, 21 Aug 2023 02:47:46 +0000
Message-ID: <DB7PR04MB40104DABC8B1C5D9CC0CB0A4901EA@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20230506085928.933737-1-haibo.chen@nxp.com>
 <CACRpkdZDTxxNn2CDSBu5yKnw0qVuWH-a+dPYXdHndLZbxmyFAw@mail.gmail.com>
In-Reply-To: <CACRpkdZDTxxNn2CDSBu5yKnw0qVuWH-a+dPYXdHndLZbxmyFAw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|PAXPR04MB9665:EE_
x-ms-office365-filtering-correlation-id: 09d2577a-3437-4164-9c6b-08dba1f0ffe6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9XD1SbaQC9d9VNG8l6BWbhbERHbdZttRQi4Dm3F9eHg+TsBRmD+oi8C4E3e5L7SjgGpVvYOczxAAHgQupLxkS1fqRLs9kw6+K2TCXulUzzyyLJENK2KsNgPo2mZrzDm3VVFuGP9hIophbGIhkT78p6P9x3zpZ+aYgzhSyRuHuOe6PDim9paqMzSeOqRGKel78sUEGTxyaoe6pwhH7GUA5Iy+TSfOt0Yc/9x/r8wYw+AhAFX4HqTbSpWCJllw5Z1WQIKgWyrOUfP1DtFUD/9LknbsQqWMq1ADm3FmRLS9e5L4Id8SYVfH2rSC0a7MXwFhulq/mi8GHOdMAw1XO+d4Rz1m3wHSQmhWsIwiSgRVue4u6Hxg78e+5wwuNEQGxENRX3llP3Y0cmUJCpqLTVeXySRcra1HtryR/NOYSnUoAScXBFcgHlkzrYxJbSGGDG09Bd0ULmzkmrVX9Kdz6c055adGWO6M+qBYFSZF3V0g6xwq4J8pwxS/nHPv4raVdWyzYYLXpV1e37bNrjc5tf49bEwkwA0l+HRgvh9Sawj61cVdokLiq4DZKPH7bQ6OGg7VruU3WMySGbowyebdvL6b3o3JHsb2uqHgNShmmvKN/98DFzQKAI+G8Swhj83UHrpl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(84040400005)(186009)(1800799009)(451199024)(66446008)(66476007)(64756008)(6916009)(54906003)(76116006)(66556008)(66946007)(316002)(9686003)(8676002)(8936002)(4326008)(41300700001)(122000001)(478600001)(71200400001)(55016003)(38070700005)(7696005)(38100700002)(53546011)(6506007)(4744005)(2906002)(83380400001)(86362001)(5660300002)(33656002)(26005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0FoRTZ6R08wZDYxQTIwOUl6cFZGcE1KWHo0aVBGV0NuaVlpUlcxd3BpQUlP?=
 =?utf-8?B?Q2RXZjNSRWl1MzF1MUtKUW1STzRWY2l6OExpZEtrbkRISjVKYk5xdmhQNE1X?=
 =?utf-8?B?SzU0dldFeTRKNU1ya1h6TjRETk9IS0RCemlzWWNrS1dtd0VNT3IybzNyNUxl?=
 =?utf-8?B?YnFlOW1YeVgzR092L1RNN1FBRHo2NU9Kd2lTRDRHdmpsdXo2NEwxZ1hhci8y?=
 =?utf-8?B?cVZNeE9hVDJDOTlhL3NUWTdpUlZHY2MxVmVzbnVwc3Bud1dURVdyUWlTQ2VQ?=
 =?utf-8?B?RUZKSVYwR3VQdFpsZ1MreEpXUVgrODQvZmpiR3JFc0RTbjdqc3NyRFdhazdk?=
 =?utf-8?B?M2poVXIxY3d1d3R6cS9pZit0RmNiZUw5cU13UjVPQzFnZnpnMW82Y0ZCNDNj?=
 =?utf-8?B?U1dNYzV5eTJ0VnBkTG1wTDJsR1hUdXA2eEh0Q1RWQUxIK2dzY2pVdG5UdDZw?=
 =?utf-8?B?V1YxTUVnK2Y1WEpGMHVVZE5ueGNRS0x0SVh1NFdIYkdxUHQ5d2c4WUlLN0lp?=
 =?utf-8?B?N0lTNGVDU3FPekxSZ0ZmNzVhOEZjcGFRbDFaRXRqNFdLdms3bFJxK3JKbldy?=
 =?utf-8?B?bUNRSTNkMTRkRTl3aU5wVGgvSlhrSkNWUGY5c3pyVVdWcGN5SWRFeUdXbVRp?=
 =?utf-8?B?dU0vR0tKV2ZIR292cnRzZWNhTFhnMFVkVlhyWWNzTW5PMzM4TkxaRUQ3eXJT?=
 =?utf-8?B?cThGYk0vUjRwdGJvUFRDbDQxdW80SGlrMkhjTEIvTGprZVBRZ2swUTRVd3dX?=
 =?utf-8?B?bWNyYnBiZGgxTmVJMVNrUzl3WUtTOS83S0thUGNCSnJjMzIzRTlmOU5ITDFC?=
 =?utf-8?B?SzQ2KytaUGx4UjhqT2ZUV0E1YjBoemRtUXZMOENWYm1aRXlaMXZlU1hJWXBM?=
 =?utf-8?B?L3c4WEdwZFdaMVI5MThxUUE3S3c5UVA1WHRSWEwzclNYekNHM0JWczBRRU1v?=
 =?utf-8?B?VHJPbTVrcjByTGRRYnlwelpWNnFkZ1pucDhwYjh6TmhFdnF0VHRTYTlhQjl2?=
 =?utf-8?B?bHRscXhMcmdGaWZnbHlEa3hhcXFLWW5PSXlGOURhZ2o1TjBZMXJyVEk1R0hV?=
 =?utf-8?B?OHZ1Yldjb3RIa2FDdEgwQmlVVG1JYUF1TzhITGdQazlyNW5IMXBDbmJ4ZUll?=
 =?utf-8?B?UGN3UDFVbGYxZXNBNXZ0ODQ3K1I5K0hUeE5PM052UGJXZjMyVlM1MWQ1R0xq?=
 =?utf-8?B?anBlMkZjOUk1dVFGb2IrbUFFaWFiVUppcFFScGdZVVFlQm1EeEF6NHNtajNF?=
 =?utf-8?B?WWRMTW5jbEg5RXRsV1RxTEdiWXlTWFp5cDg4dXZUREJ2MnZidCtTTlRmYmR4?=
 =?utf-8?B?MEhsTlk4b28rSGNUVHhYSXMweTNON2pNdjNRS0toQUtKSUtYOFVOb0dYNDB2?=
 =?utf-8?B?OVFrMEx1eVYwbmNWN0RVS09tQnVCeFI4elpWbG9oNk5ja3ZFQUwxV0U4RUh6?=
 =?utf-8?B?QXJIelFiWEpHVDhDemQxdkxPSE9CM0I0dTQ4N0NXWCtINHVISm13K2hLb0xV?=
 =?utf-8?B?dmQvT2wySmZwY0lzdEkwNFVDeDNGRTJ1Nnk5a2JZalJuSUdHYmd0Tzh0Qzc0?=
 =?utf-8?B?cTJ4VWRpVDdzKzFlZWpLTy9kVXVRWGV6NWUzRUZDV2Y0eWZBVGlMa2FvRXkz?=
 =?utf-8?B?N3NPc3gvVWVjRHYvQmt6ZmRIT3k0NW1LN3NuMVIvWWkzaTNsNU1Lc3FORHlW?=
 =?utf-8?B?ZWtYQlV6TWdFWnk1bTEyOXg2bjFZZW9BQkpCYS9wV3NTNEQwbG1QQmVQME5N?=
 =?utf-8?B?NmNWL0JEdWRKaXF1QTBUNDBvVmRjNTMxQ0EwVUczUGtybk5aL2lBTHF4Nnhs?=
 =?utf-8?B?dWNjUnhHMStKQ29aQ296REI1V0JEYXVNSjFVU21Zd2Npd2tQcmNXUVZPYnFO?=
 =?utf-8?B?bVVtdWNneFRRanIxSlB1OFNSSEhITm4wZSttLzNuazZXcW9aUkJPQTZxVUFI?=
 =?utf-8?B?RExvcWxHWXpVOVVkckc0WGxZK0xLV2EvZzZITzE0V0JUbUMyQnBHWGNXQ0VQ?=
 =?utf-8?B?VzBRckN3N2ZIY2ljUy9lbmI4eEF5VWlaZ3J1aFk3SUQ3UjRXMnF0VXJURmJI?=
 =?utf-8?B?clhlOC8yVlZQaDRUSU9uS1UxKzd4a2Z6eC9ZcHVGL2QzQWtTZEtwK2FqSEIz?=
 =?utf-8?Q?jGKk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d2577a-3437-4164-9c6b-08dba1f0ffe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 02:47:46.0342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EBdVDcm795oNPMqEM73Lb8WRVDSPvv2dqpRw7De0dbvlIMlXXos6MsGNZJJhpgYm9MNZk5SXTgTNMCvOv2phYA==
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
cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjPlubQ15pyINuaXpSAyMTowNQ0KPiBU
bzogQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiBDYzogYnJnbEBiZ2Rldi5wbDsg
bGludXgtZ3Bpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBjaHJpc3RvcGhlLmxlcm95QGNz
Z3JvdXAuZXUNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGdwaW86IHZmNjEwOiBzd2l0Y2gg
dG8gZHluYW1pYyBhbGxvY2F0IEdQSU8gYmFzZQ0KPiANCj4gT24gU2F0LCBNYXkgNiwgMjAyMyBh
dCAxMDo1NuKAr0FNIDxoYWliby5jaGVuQG54cC5jb20+IHdyb3RlOg0KPiANCj4gPiBGcm9tOiBI
YWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+ID4NCj4gPiBncGlvbGliIHdhbnQgdG8g
Z2V0IGNvbXBsZXRlbHkgcmlkIG9mIHN0YXRpYyBncGlvYmFzZSBhbGxvY2F0aW9uLCBzbw0KPiA+
IHN3aXRjaCB0byBkeW5hbWljIGFsbG9jYXQgR1BJTyBiYXNlLCBhbHNvIGNhbiBhdm9pZCB3YXJu
aW5nDQo+ID4gbWVzc2FnZToNCj4gPg0KPiA+IFsgICAgMS41Mjk5NzRdIGdwaW8gZ3Bpb2NoaXAw
OiBTdGF0aWMgYWxsb2NhdGlvbiBvZiBHUElPIGJhc2UNCj4gPiBpcyBkZXByZWNhdGVkLCB1c2Ug
ZHluYW1pYyBhbGxvY2F0aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFpYm8gQ2hlbiA8
aGFpYm8uY2hlbkBueHAuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IExpbnVzIFdhbGxlaWogPGxp
bnVzLndhbGxlaWpAbGluYXJvLm9yZz4NCg0KSGkgTGludXMgYW5kIEJhcnRvc3osDQoNCkZvciB0
aGlzIHBhdGNoLCBzdGlsbCBub3QgaW4gdGhlIG1haW4gdHJ1bmsgKExpbnV4IDYuNS1yYzcpIGFu
ZCBsaW51eC1uZXh0KG5leHQtMjAyMzA4MTgpLg0KQ2FuIHlvdSBoZWxwIGFwcGx5IG9yIGFueSBj
b21tZW50Pw0KDQpCZXN0IFJlZ2FyZHMNCkhhaWJvIENoZW4NCg0KPiANCj4gWW91cnMsDQo+IExp
bnVzIFdhbGxlaWoNCg==
