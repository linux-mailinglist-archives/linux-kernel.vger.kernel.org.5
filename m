Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BD3756727
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjGQPFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGQPFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:05:36 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2111.outbound.protection.outlook.com [40.107.113.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0842110C0;
        Mon, 17 Jul 2023 08:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amuf5/l9/jsdF/KD8MyKReL7NeoWFet0bmgaO4IGUDnWDpD2L2ElXdYYYtqO1c6mHwz3K3NCX7vnyhoj0UN0kQujpOzt/zmx1kOW2fl1iPWg/T7tIed3KThUqWC460TBWizh0Nwt18ibL7dP7WnZCfkeXHOEnmmsYS920/V9JwSLbkmv4cu1rLJ9Nrg5ikzV3cc+D4XX4aZCd2ZjzLpn7UH3ZxHvhrgizpNGR45XlBYmEziJelYiZAkmjEN8mCvzwUBOBuIIb+bnEdt7wIW4Q4Uz13EL2opmOfFBTkkM6uJ+ArG4bgJZ6IHAmfjqI8haCQRfSXOBKXNS/7FEgAefhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsLgVK2mO+j30HuLhcpLvw5bt08WE1g47WjaguKHGGc=;
 b=S4HKVjVXnoBtA/y5sMVqTaOMd2NezKDJh+WxSsOi9u205eBvQD48voTMyX07/PBWFn3zV4jAIlLlO89YOhjZpIV67sRg4g7AvBtH7YBjbKcK6c3FKA6WIJSPDQQghKtppWQHQVhpLfB4v56Te4nvxOnGzbh9+giZpT+VZ9XjEAGtkliz9ODzt8ozOS8bmDRIr5w8CbSi6JMG8I+kVo7RG/uQeXYxnWOMbYBoJdTJ9a3Qi15IoxyHoFUxkdu9nOEbXPeG7FTORyRY2hOpOycQd9pJn0z/kjlRAYUEaiXHIZxkATDsGhjiXma6eo+u3kZi0o8xqQk/vdllX3t1WbM5eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsLgVK2mO+j30HuLhcpLvw5bt08WE1g47WjaguKHGGc=;
 b=YJf9rT0urg4NebyPmEAFY5GO6usGtFDJAz6lZ+3u+V7BglftnhiHebnZOh9YCqkpolHG47PMoDgXZpO7dhZHSiRvmnWNu2xBVINX9s8LY+7suVjaRsF2Oi90Y+a5jpvRiruHxZEGbrEJRJ0LyKlx8V1HIkNWe9wthSfchLCNAQg=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by OS3PR01MB9832.jpnprd01.prod.outlook.com (2603:1096:604:1ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Mon, 17 Jul
 2023 15:05:32 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::231a:7573:1ada:5bc0]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::231a:7573:1ada:5bc0%7]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 15:05:31 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 10/10] spi: rzv2m-csi: Make use of device_set_node
Thread-Topic: [PATCH 10/10] spi: rzv2m-csi: Make use of device_set_node
Thread-Index: AQHZtrhcVuIxhp+4Z0OHQZL/jTaqKq+6duOAgAObqVA=
Date:   Mon, 17 Jul 2023 15:05:31 +0000
Message-ID: <TYWPR01MB8775AF94C79B3C107E442696C23BA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com>
 <20230715010407.1751715-11-fabrizio.castro.jz@renesas.com>
 <CAHp75Vc5UAec05TKF2A21YoNtvMz160v4SeOkDAsrU+i8b88YA@mail.gmail.com>
In-Reply-To: <CAHp75Vc5UAec05TKF2A21YoNtvMz160v4SeOkDAsrU+i8b88YA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|OS3PR01MB9832:EE_
x-ms-office365-filtering-correlation-id: a542d019-4df3-4e62-7ad6-08db86d743ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oTZ2E+k4fvIz/e98ILWWphB2JYSdcAxjrkB8LvstuW6vEkL4ZjpWJ9lmsKhI7VwWTJHiUWUuOkRYeJWtYq9SuNd6f/VaKQ+/qZGhGvfc6abygsrv8MeO8fPpUdQwkRwEf5kDfinnMqutBWGdYltDBhDXvVX98BhlNWNMJoYNiQ5ybpoLIm5sw4yP+NlkO5YDa5VIgOLzeI8eDb816twWcmbDc4wO2G+YSdbMA6AmtmLW7Hfioaae16uyMzuSg38oDibLgXBtlyQcDe4OvGzbXSRc10hHyKA573BESyV5WYTtgfj6P5oK0l53yqUYJ8AomIdW311RSQNrgMZaiFHC75cxkXaF6cOXCuXTuz8EyIldOeao5mbMF0wGaR4392oiuwz5M/4d9HhYTc+A6EjuGUj2AnjjubqxC4t+i7zPFcRr4q35Lg6DLtd7Ah6AK3rdrIjAxbJANtREsLSPgcRkDE9f5aoctypn6lqM009/mJ4FeRoThbKj9TfBcQHa50WXTCHRn2XfdKdbrjg9/CeK/mqlJtBMKxcTz/GciIjlbt1BzFSLtLV5/rsS0KpLl13oXKadaQLllZh/8v7z9osLXhAa6Ir//D7jvo3zBpQMybBId8As9LvI9s6otfW2Jqmw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199021)(478600001)(71200400001)(7696005)(54906003)(186003)(53546011)(6506007)(9686003)(2906002)(76116006)(4744005)(26005)(316002)(41300700001)(66556008)(66946007)(4326008)(66476007)(6916009)(64756008)(5660300002)(52536014)(8676002)(8936002)(66446008)(38100700002)(122000001)(86362001)(33656002)(38070700005)(83380400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1UyS0xPUWIvQUtIZS9TdDdQUlU0cmdxZHc1WE9zbFZYOGxiZ2ZsQW05Sy9v?=
 =?utf-8?B?SVJqVktZOVJ5TkpDLzc5NFFrVFdMamJiQWx2TDZPS01yeTNsRURrWHgxdUN1?=
 =?utf-8?B?T1hoQnZ5NU1GOFBtckI1SnBRdDZjb3o1Z3Q5OUpibmE3cjhGVi9pSU9aREN0?=
 =?utf-8?B?NGRXV1ZySEJ2ZGJzeStyNk9XdlNDMlAxV1FDVi83UThEZy9DbkpXbXJudjFE?=
 =?utf-8?B?blNuSE94UERRVW1BVk5lMHI1aWVxV3ZERW5BWEFvRDlMemNxcDZnM2ZiNkdG?=
 =?utf-8?B?enc2Nlh2eHEvK2o3UWNzYkRscUthTDNpUUpwdFRuYVB5MVJKMHFqcCszVGR3?=
 =?utf-8?B?K3NEMmJQbTBGUEN3R0Ezc3Q1VVBmQ2FxU1JLYVFJMUNoZUZxa0tFMU0raHk4?=
 =?utf-8?B?cHpJTE9zZ3JrbjcrS1RDb2RxSTdXSzBpYzFWRitRN3ZZd2VyWGp2NjNleldR?=
 =?utf-8?B?c0Q4Y0pkcmNiQUUvS0FUMlJYM05kamRpNFpRTDFjdzM0YlFTU0ZaZ3c0dFd3?=
 =?utf-8?B?N2YwSUhwaWk2cFgyd0haZFQzR3FMYVpyc3cyVHhka3N3T1B0TFl5bFlWc1BU?=
 =?utf-8?B?ZzJXU1JTRDYvVU0zbWFGektnMEV5NzNKaW1RbVhJekpCVTFyK3gxdE4xMlc0?=
 =?utf-8?B?NVNSVnNObExaSTVYdmJtaU5DWU1nNUNtMWUwdG9ZOXJ1R1d0T21wZnVaQys5?=
 =?utf-8?B?bkFMMk14MG5HTnN6SmJzN3AxeFp6ZXNPb2RXUldmV2xobWxrRWdXam9NVmc5?=
 =?utf-8?B?YnRMeUM4UzlodmVUTkovcDFDQmlNTVJTME9EazVaSUZBVWtZbEx4aUpqZk1X?=
 =?utf-8?B?bG1POGZFUy9jakZlU2VtWjV0ZGxCZUJoSFdCU0duTUladTNUL25ValNPVC9W?=
 =?utf-8?B?Yk9wNkJ0WTFKckJUMDd3azJrNnNqc0lUUDJwTG51QzhNUTUyaUJsUVUwUFZM?=
 =?utf-8?B?OXpGaS8xYkc1OVRNZlV0bGU5VmpNemZ6V0gzWWhXWkl2aVRNL0JmUUtSK3FN?=
 =?utf-8?B?endaMDR0ZVJQcjg1c1FqbkMrZFphdkJJdWdIRkM5QU5kaG5jTW1mQ1pZbmxJ?=
 =?utf-8?B?dXZGQU50cHBOOHRjM3BxaHdDS2M0TWNTWitDaGxjYjBvbG1QMjhkbjc0UjVE?=
 =?utf-8?B?THJLaHRBa1RQb3Q0SmZLOW9DRzgzcnRES0VoVUZtNW5zcWpUR3RjeEZYWlFq?=
 =?utf-8?B?ZXIxMHkzMnRtQW92elhaYjJLYXBKRHNBbTNBcmpIblFYNXc2T2lJaGhCamtt?=
 =?utf-8?B?c2gxRWlSZFlydm5PQnNzN1FGNTl2WTdwNDZUcExTMFh2dldHN1NxcmMyZWRW?=
 =?utf-8?B?NzNLbWc3dlRIcVZQTzA4dzZEUEJhb2F2WXRJYnIvY2lVb1RRWE9ZTEpxNExU?=
 =?utf-8?B?YXBLMStYS2hKVTZ0a1N3UlFYZksvdldLWEVPUDdkQU5YbGNiemVHeTFITE9U?=
 =?utf-8?B?bnAxaXlaOUJyMVM3N0hUTTZhTnJ3ZUJLODFTL0YwSEFGa3pDcjdhaHhFZXI5?=
 =?utf-8?B?MFJBL3JNS0dvU25pOGpjNDFWVEJ4NFlLenBvSXVPQnFZdTdZUWpONDJIZ3Iz?=
 =?utf-8?B?cjBjb2w2Y2FxVnFpZXpRaVdTc044eC9jQWhma01tMzZVelRTb1VRakRGNzFC?=
 =?utf-8?B?Q3VQNTRHR0VSSGZWYWs0NHJpbmdQMWl4N0tpUW9PUUhnQURZa0NXRkpKVWVC?=
 =?utf-8?B?ZjZmYm5NeGEySEY5VU9QbWNySU5VV0RMalZMS2o2a2p0VFRIYnBTZmhvZGcx?=
 =?utf-8?B?bDBrTjJpdGI2MnVtcS9uQTJMVnVwYlFFcHFQa1B5TkV6WEZMMGZOR05WQ3cz?=
 =?utf-8?B?cDFZQkhQcVNLdEZRd1l4MW41REQ3ZUNrRnd5WExYZlY2S21JK1ZONGhlNzlD?=
 =?utf-8?B?U29NdG9kcXI0ZEtJWlJZM3o5a3kwbytvY2xKMVZPZkF5elluT093SSt5Wnht?=
 =?utf-8?B?Y2JLYUJSa2IvcEVXMmhGbkZJRTNTRit5TVRINkRFeTdIRU8vRjJtc3JKZHRv?=
 =?utf-8?B?b3FVWC9WZUppOXNXMko2NDBSbDAwME5YYkVyZFl1SXRCR3FXQ1VvbDdSc3g0?=
 =?utf-8?B?bFRHYTFINFR6dVRpMGlMNDdsUVBJc2VNbTJ4L3Jsb0UycnhJdDRKK1p4Tmpt?=
 =?utf-8?B?RUxvaFdzS2pxRTRsd3JGNTJmVTZpRjVBL01LNXM4UXg1NHIzQXNGZ09kQUVR?=
 =?utf-8?B?VlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a542d019-4df3-4e62-7ad6-08db86d743ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 15:05:31.8399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n0xY3upIVMUEH5pFu8bSRw3lE3WYNEJswpJWyLpZKTPZ0Bly1OWsDxE5tuhdvvUeGrj/WYKEED22S4zzJ8AEAMvTxiXHQ+uXbKWsy+XhTaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9832
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSwNCg0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFp
bC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMTAvMTBdIHNwaTogcnp2Mm0tY3NpOiBNYWtl
IHVzZSBvZiBkZXZpY2Vfc2V0X25vZGUNCj4gDQo+IE9uIFNhdCwgSnVsIDE1LCAyMDIzIGF0IDQ6
MDTigK9BTSBGYWJyaXppbyBDYXN0cm8NCj4gPGZhYnJpemlvLmNhc3Ryby5qekByZW5lc2FzLmNv
bT4gd3JvdGU6DQo+ID4NCj4gPiBVc2UgZGV2aWNlX3NldF9ub2RlIGluc3RlYWQgb2YgYXNzaWdu
aW5nIGNvbnRyb2xsZXItPmRldi5vZl9ub2RlDQo+ID4gZGlyZWN0bHkuDQo+IA0KPiAiLi4uYmVj
YXVzZSBpdCBhbHNvIHNldHMgdGhlIGZpcm13YXJlIG5vZGUuIg0KPiANCj4gWW91IHByb2JhYmx5
IG5lZWQgdG8gYWRkIHByb3BlcnR5LmgsIGlmIG5vdCBhZGRlZCB5ZXQuDQoNCllvdSBhcmUgcmln
aHQsIEknbGwgc2VuZCBhIHYyIGZvciB0aGlzLg0KSSdsbCBhbHNvIGFkZCB0aGUgcmVsYXRlZCBT
dWdnZXN0ZWQtYnkgYW5kIFJldmlld2VkLWJ5IHRhZ3MgaW4gdjIuDQoNCkNoZWVycywNCkZhYg0K
DQo+IA0KPiAtLQ0KPiBXaXRoIEJlc3QgUmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo=
