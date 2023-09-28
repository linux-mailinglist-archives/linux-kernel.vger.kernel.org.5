Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAE57B17DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjI1JwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjI1JwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:52:05 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227B5196;
        Thu, 28 Sep 2023 02:52:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbnVnSxLL5LrJJcxsGinmj1GB3M2D9T5G/IL5qQAekjKZgHw+0ZjaT3CX54ultM98KabrFOSaub0aIV3JlfRRCB2R+6o2tahEnPmaYGx9xyS2lMw8O/3enuQoA2+KPRe3zpnNZjg9zjYQAlst/NwhquNzbndTsujIVzFFMnGdoMuZVNHilW+GQWCZ8148nvo7yI4usv9ErLYfZC7mK7KvAKoJMz9stALpz7pb1o0q8Bvc2tHhckkp2J9BPldlbxKNbUBd/oiq7wA2qGmikGZvZ4/tZ/cMQeszSWmrt2lBGdzkGK3yQgNoZTHCOz+QCKn/ku7AOOlvaW/o6M494OdvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtgqkGuco9HTJ0lLaHfbDAzYwBsI835/8fRZvdFG5WY=;
 b=MjgNzRQ7n/v7JMQcQ2MM/ntxVu2O7qKMtbYmC/Egz1+lToOkuG4QYZ1eXezpPPI12UGojMHjz30JFjip0jSm6gx/JfuFaeyUd4UCyKeUDA4MJi2KTEQ3X3kRMcEGWRm2kr4dOXTom6NTKPqWsfoHyvTCiBxuLJM0ELXs93a5xfrE/Odrw1AqocQ0P7BEh2+PkMqex3rfURjo2a+a0Gf51C3xsTTSFLHCL1NjcwoGpdEurvRMDUqfpw1m6aGXKRzfEUeryM7Tljp6Upp+ca3E4Z3e5AYMjiHN8b7YX8fqFc+Y3RKUd0EKsRAY8xqDPA4jtEu2yg8kHmQ70CCvhKvB5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtgqkGuco9HTJ0lLaHfbDAzYwBsI835/8fRZvdFG5WY=;
 b=Y2lkEME9U9XuvxOyBBw92Z8A3MfD/dlGQHQTVoOud4s3P+ytIwARpTRZN7O3qfjXScjMR838HXqVZbG0Wn1rKdhuwg8I9F0Ah2+3hnkqXv95NG6zWZ2J4+7ib1kBxxqGuX6NvIZMPr6Wrc9PJqCPYftAtxzigeoUM2meqhZrUjE=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DU0PR04MB9324.eurprd04.prod.outlook.com (2603:10a6:10:357::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 09:51:59 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f%4]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 09:51:59 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, Eagle Zhou <eagle.zhou@nxp.com>,
        Tao Jiang <tao.jiang_2@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v4 1/2] arm64: dts: imx8-ss-img: Assign slot for
 imx jpeg encoder/decoder
Thread-Topic: [EXT] Re: [PATCH v4 1/2] arm64: dts: imx8-ss-img: Assign slot
 for imx jpeg encoder/decoder
Thread-Index: AQHZ8GGov7h7KqfCpUS2rDO4Xr8Tt7AuU2wAgAARFzCAAUzTgIAATr1g
Date:   Thu, 28 Sep 2023 09:51:58 +0000
Message-ID: <AM6PR04MB6341F2AEB9380033E456B3B5E7C1A@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20230926101000.13392-1-ming.qian@nxp.com>
 <1144f7f3-ffdc-47ff-b90f-2d2dd86c8f15@linaro.org>
 <AM6PR04MB6341F15D9A932C3567103BF4E7C2A@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <2665f382-3df9-441e-bdb5-205a3466dd35@linaro.org>
In-Reply-To: <2665f382-3df9-441e-bdb5-205a3466dd35@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|DU0PR04MB9324:EE_
x-ms-office365-filtering-correlation-id: 899a1278-b7e3-4c38-ab1e-08dbc0088ec3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uPCjMuWA4SGy/YlCQnXZWuTjCY8dZG7gwPzQvWv+jr5JwOAgX85u4YfaBufxq/R8jZSmGLauu8B9CtmoyTg9GH4qBP6aSCnP8X7YRDcDLMuIzWtqX/x27Ylos0T2h82fBPA0ivIKllpjsYJ/OSZhNE/SABXLhgXU4KSYHzhMhC4MWROPPWV+c0tv3ZPEfuoPI07niuBTUq5Ig0iKrqkS0RwlF/JqbisR9rByI2Zn6o5khZDKMXasTL3B60sxXOhp2GYUkFH3dfzM6YN9gFuDNIS795XwJEHzutsHm6p7xEKmuEtPkiryXmQO1AQlna2rNxeqThzJ96uI2hN9/0Vn1GnEXsw+WOmGIh64fmARdGssKP2zUiS9/Avzn3YFgmSOnBqCjNZ/FLkxmltBn0yatKhm3STOnHEH301UpU0dQzD5qS+ml7iWOv+KyIH9kwEq1A/ERg5CtInUyIYzCxU39sAXUk7Gkiqh44KtDGb5hsIWurl6+vHPxCxbO4yVCjyAofCVGg4NaIutbXaf0xt40E1sHyPPjJaOL8KETrI2G/Qys69+dq9aIscU5g3IMdjXDv7EKVdtZhRrEGyl2Luo2+EMPiL0rETd7P1FEuqtzt1YFlqwprM1Yjb2MR6gqbm6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(136003)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(55016003)(2906002)(38070700005)(7416002)(83380400001)(38100700002)(66476007)(9686003)(66446008)(110136005)(64756008)(53546011)(76116006)(6506007)(5660300002)(66946007)(26005)(52536014)(7696005)(71200400001)(66556008)(41300700001)(4326008)(44832011)(122000001)(478600001)(8676002)(54906003)(8936002)(316002)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWZhVG1xY1FMTmRLZmlWb2lybVhuR2JjMlQyZzRESzFiOHRNVkMyZ2VsOXBz?=
 =?utf-8?B?cnhBR3JlUFFQd3BENDVSRmRTeThOc2g5RTFaczhDS3oxYnhkSDMxdzkweEh5?=
 =?utf-8?B?QnkwSGN1c04xdGQwTlBkZkF0YklaUWFHdTlob2UzZndhZFcvRkQ4OUZSSHFN?=
 =?utf-8?B?R1JNRzNNMUNxT3o5OEdmaTVMSzZWZjAvOEs4OFhQazljVnhjVUJ2anFIeCtR?=
 =?utf-8?B?czFSSXdsblc5T0tIamVsSGJGeS9mNlM3bktwWW5Sbi9mdENxNThMNmF3OWJi?=
 =?utf-8?B?KzE3U1VHYkw0SEVNREF6MDV3LzMzZHBQNTBOWW9FajV3ZjFDMWZMczFHWk1X?=
 =?utf-8?B?anpVQUxpY0RuWVBsNnJZVlVJNGQwcDRDT0xBeDZWVGlwN1RLOWFUODJLNTd4?=
 =?utf-8?B?SjZkL0Fnc1haZHpZUEU5MG9FQkFsOFVSRCtYRVp4UG8xY3dqQUtzeXkyUW9w?=
 =?utf-8?B?WGRJTDZPMDJ0cERRZmZDQm1aTXoxcGc2SUR1bEVkbndYOTVzNVlZRm40Rkor?=
 =?utf-8?B?bTZjVXAzSGpyQUZQZlBreUU2YTQwTG8yV2xhRkNBUWhWcUZFTExXTDRudmZx?=
 =?utf-8?B?Q0c5OEhyWU9HY3RXSjgxS1VsQ2hRMWFQTkkzY3FDUzZHcW93Mi9qbm1LZml3?=
 =?utf-8?B?aE1TSGR1R0tDd3BCWW16VlZJWVR6OGNRWTZ3TWNhSDFtWlZUUnprU3hWNTZT?=
 =?utf-8?B?MVljS3pZY1l4L0d3MTdvYmhUTFJYZlVpalVlMUxUaVFnRGVzUXpRRGNQT3RF?=
 =?utf-8?B?WC9ISVc5MGUzWUJ6UUVvcWp0cjdmUVpVWEZHRTNJRFNMYmFVVmh5Q3VFb2hF?=
 =?utf-8?B?OGVlR2tDL3ZuUkR5V2s5TnFTaHk3TWlhckFRMkV2MUtyMG82V2ZPVENHR2Zm?=
 =?utf-8?B?K1VQSDFRN3Jka3NrYUJnSFpvTmlvTGNvUE1UZ1ZEYkdDVjRaNnYzcm9xcUZD?=
 =?utf-8?B?dHNVbDNFaCsrdEdCM0hpMzVneEVjcStsazQrZnhaS2xyTFp3bzByMU56YTRE?=
 =?utf-8?B?dkZLUXEwbkJXSWVkYms1aktzSjVpYTlQQm50QzBVRGdBL1A3L3RFZ1JFNkN6?=
 =?utf-8?B?ZGpxcVE3KzV0ZmErN3VKMDkvVkx3SGc5a3QrRmpHY3g4RW1vMG1Xc1htSS9K?=
 =?utf-8?B?Q3MwSUR4NlNvZFVqOW1CVlFDNWk3YUxFVEdBYmVCY283UHdNZURITDJ1WXkr?=
 =?utf-8?B?dEF3Y1Z3QTBqWXpBb2xxbmlGL1ZYMlZtVWtQVTRQdkk5SDRRZi9EOUtsanhJ?=
 =?utf-8?B?RTM1Rk52K0tVL0QwWG9lTkpvdWVNbVA0Z0tCYkNabERsQVZoQ0U4S1dub1ZK?=
 =?utf-8?B?ZmhzQlcweUdDemNsbHhtSjg1cEhjaU54UlV6NHNhMlVsNjhnWit5VHRaNVRv?=
 =?utf-8?B?V25iTFMxTnhRTldOdFBSUnhQYlYvSWs2NHFxWThnNEk5TGdQSDRpZjRQeG9P?=
 =?utf-8?B?dGNpMDBLbjlLM3RINU9ZR0swcEQwdEFqcUlZcHN4S2V0TFVMS0pmVUtQOTNQ?=
 =?utf-8?B?T2ZRUDZVWWhrRi9ZdXk5QUJ0cE9NRU1tNElkKzROTnhzY1JLR0pBL1hDdEl1?=
 =?utf-8?B?RHhLREhzSW1wYkFxV0tPNTBITkVuT21pNE5mQXd5b1FwMWxvak9JNGt0ZkJ5?=
 =?utf-8?B?R2dGQWtZc0xVbThKTzNyVXJNeGRXMDZPUHVEOFJxemhIWk9SZ1hsVlpTR1Jw?=
 =?utf-8?B?TzdVc0V1Q25ETmxjZzc0dkVKNlBqQVlKWEJzT1JhbkpycnAzZGZwdUs0Nzh3?=
 =?utf-8?B?QXpVbzI3cnp1d2hoSW12cXRlSXJzeFZBR0QxYURnbTVrbFZXbkl0bUxzTFJO?=
 =?utf-8?B?MUlpOERnbXdtanZvbGYyd2MwRUtFZXJLSUg3Zm5uUy9GbWxuRGI4NTZ3anVG?=
 =?utf-8?B?TmEzbGxwNjI5UlRIWk5tU3ZiZUdVU3FOSitUMlBEZ3dGWmZTRU9wcWtocS9E?=
 =?utf-8?B?M0NEWmhsZWpENEUwSy9TNFpHZHl5UVI3QVhwYVcweFc4SVkwVlRMWGd1WnRX?=
 =?utf-8?B?T1NsZVppeTU4Z09MS1JwenpVaEFIV1Q2djRzQkdWNjhXZ2tNOU9xWXFPWUtK?=
 =?utf-8?B?dTNTRUJYWVhLYXB5WDByU0IrMzJCNTlpOXdNKzRqTHJjbjZaVmNRcjcySUtS?=
 =?utf-8?Q?uxb4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899a1278-b7e3-4c38-ab1e-08dbc0088ec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 09:51:59.0357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5U63YD7COExJAo5G01iJV75cmjtLAsiDvYwH1I7mE+oUoMZF/r34bezRedFk0GRogo1oFkM+vGtqwoA9ceRrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9324
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9y
Zz4NCj5TZW50OiAyMDIz5bm0OeaciDI45pelIDEzOjAzDQo+VG86IE1pbmcgUWlhbiA8bWluZy5x
aWFuQG54cC5jb20+OyBNaXJlbGEgUmFidWxlYSAoT1NTKQ0KPjxtaXJlbGEucmFidWxlYUBvc3Mu
bnhwLmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZw0KPkNjOiBr
cnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+
bWNoZWhhYkBrZXJuZWwub3JnOyBodmVya3VpbC1jaXNjb0B4czRhbGwubmw7IHMuaGF1ZXJAcGVu
Z3V0cm9uaXguZGU7DQo+a2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207
IFguSC4gQmFvDQo+PHhpYWhvbmcuYmFvQG54cC5jb20+OyBFYWdsZSBaaG91IDxlYWdsZS56aG91
QG54cC5jb20+OyBUYW8gSmlhbmcNCj48dGFvLmppYW5nXzJAbnhwLmNvbT47IGRsLWxpbnV4LWlt
eCA8bGludXgtaW14QG54cC5jb20+Ow0KPmRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPmtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPlN1YmplY3Q6IFJlOiBbRVhU
XSBSZTogW1BBVENIIHY0IDEvMl0gYXJtNjQ6IGR0czogaW14OC1zcy1pbWc6IEFzc2lnbiBzbG90
IGZvcg0KPmlteCBqcGVnIGVuY29kZXIvZGVjb2Rlcg0KPg0KPkNhdXRpb246IFRoaXMgaXMgYW4g
ZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0K
Pm9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1
c2luZyB0aGUgJ1JlcG9ydA0KPnRoaXMgZW1haWwnIGJ1dHRvbg0KPg0KPg0KPk9uIDI3LzA5LzIw
MjMgMTE6MTksIE1pbmcgUWlhbiB3cm90ZToNCj4+PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+Pj4gU2VudDogMjAyM+W5tDnmnIgy
N+aXpSAxNjoxMQ0KPj4+IFRvOiBNaW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29tPjsgTWlyZWxh
IFJhYnVsZWEgKE9TUykNCj4+PiA8bWlyZWxhLnJhYnVsZWFAb3NzLm54cC5jb20+OyByb2JoK2R0
QGtlcm5lbC5vcmc7DQo+c2hhd25ndW9Aa2VybmVsLm9yZw0KPj4+IENjOiBrcnp5c3p0b2Yua296
bG93c2tpK2R0QGxpbmFyby5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+Pj4gbWNoZWhhYkBr
ZXJuZWwub3JnOyBodmVya3VpbC1jaXNjb0B4czRhbGwubmw7IHMuaGF1ZXJAcGVuZ3V0cm9uaXgu
ZGU7DQo+Pj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IFguSC4g
QmFvDQo+Pj4gPHhpYWhvbmcuYmFvQG54cC5jb20+OyBFYWdsZSBaaG91IDxlYWdsZS56aG91QG54
cC5jb20+OyBUYW8gSmlhbmcNCj4+PiA8dGFvLmppYW5nXzJAbnhwLmNvbT47IGRsLWxpbnV4LWlt
eCA8bGludXgtaW14QG54cC5jb20+Ow0KPj4+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPj4+IGtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPj4+IFN1YmplY3Q6
IFtFWFRdIFJlOiBbUEFUQ0ggdjQgMS8yXSBhcm02NDogZHRzOiBpbXg4LXNzLWltZzogQXNzaWdu
DQo+Pj4gc2xvdCBmb3IgaW14IGpwZWcgZW5jb2Rlci9kZWNvZGVyDQo+Pj4NCj4+PiBDYXV0aW9u
OiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tp
bmcNCj4+PiBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBv
cnQgdGhlIG1lc3NhZ2UgdXNpbmcNCj4+PiB0aGUgJ1JlcG9ydCB0aGlzIGVtYWlsJyBidXR0b24N
Cj4+Pg0KPj4+DQo+Pj4gT24gMjYvMDkvMjAyMyAxMjowOSwgTWluZyBRaWFuIHdyb3RlOg0KPj4+
PiBUaGVyZSBhcmUgdG90YWwgNCBzbG90cyBhdmFpbGFibGUgaW4gdGhlIElQLCBhbmQgd2Ugb25s
eSBuZWVkIHRvIHVzZQ0KPj4+PiBvbmUgc2xvdCBpbiBvbmUgb3MsIGFzc2lnbiBhIHNpbmdsZSBz
bG90IGZvciBpbXgganBlZyBkZXZpY2Ugbm9kZSwNCj4+Pj4gY29uZmlndXJlIGludGVycnVwdCBh
bmQgcG93ZXIgZG9tYWluIG9ubHkgZm9yIDEgc2xvdCwgbm90IGZvciB0aGUgYWxsIDQNCj5zbG90
cy4NCj4+Pg0KPj4+IERUUyBpcyBpbmRlcGVuZGVudCBvZiBPUywgc28gc2FtZSBEVFMgd2lsbCBi
ZSB1c2VkIGJ5IHR3byBPU2VzLiBUaGlzDQo+Pj4gcGF0Y2ggaXMgbm90IGNvcnJlY3QgaW4gdGhh
dCBtYXR0ZXIuIEV4cGxhbmF0aW9uIGlzIG5vdCBwcm9wZXIganVzdGlmaWNhdGlvbi4NCj4+Pg0K
Pj4NCj4+IEhpIEtyenlzenRvZiwNCj4+DQo+PiBJIGFncmVlIHRoYXQgRFRTIGlzIGluZGVwZW5k
ZW50IG9mIE9TLCBvdGhlcndpc2Ugd2UgbmVlZCB0byBjaG9vc2UgdGhlIHNsb3QNCj5pbmRleCBi
eSBoYXJkIGNvZGUgaW4gZHJpdmVyLg0KPj4gSSB0aGluayBpdCdzIGp1c3QgdGhlIHJlYXNvbiB3
aHkgd2UgbmVlZCB0aGlzIHBhdGNoLg0KPj4gV2UgaGF2ZSBkaWZmZXJlbnQgcGxhdGZvcm1zIHRo
YXQgdXNlIHRoaXMgSVAsIHdlIG5lZWQgdG8gY29uZmlndXJlIHRoZSBzbG90IGluDQo+ZHRzLg0K
Pg0KPkkgc3RpbGwgZG8gbm90IGtub3cgd2hhdCBpcyB0aGUgInNsb3QiLiBWTSBwYXJ0aXRpb25p
bmc/IFNvbWUgcGlubXV4DQo+Y29uZmlndXJhdGlvbj8NCj4NCj5PdGhlciBwbGF0Zm9ybXMgd2ls
bCB1c2UgdGhlIHNhbWUgRFRTLCBzbyB0aGUgc2FtZSBzbG90IGFuZCB5b3UgYXJlIGJhY2sgYXQN
Cj50aGUgc2FtZSBwcm9ibGVtLi4uIERUUyBzaG91bGQgYmUgdGhlIGZ1bGwgZGVzY3JpcHRpb24g
b2YgdGhlIGhhcmR3YXJlLCB0aHVzDQo+cmVtb3ZpbmcgaW50ZXJydXB0cyBpcyBub3QgImZ1bGwg
ZGVzY3JpcHRpb24iIGFueW1vcmUuDQo+DQoNCkhpIEtyenlzenRvZiwNCiAgICBJIGhhdmUgdHJp
ZWQgdG8gZXhwbGFpbiB0aGUgc2xvdCBpbiB0aGUgcHJldmlvdXMgbWFpbCwgYWx0aG91Z2ggSSdt
IG5vdCBzdXJlIEkgbWFkZSB0aGF0IGNsZWFyLiBJIHRoaW5rIEkgbmVlZCBhbiBleGFtcGxlIGhl
cmUuIEluIG91ciBpbXg4cSBwbGF0Zm9ybSwgd2UganVzdCB3YW50IHRvIGFzc2lnbiBzbG90IDAg
dG8gbGludXgsIGJ1dCBpbiBpbXg5IHBsYXRmb3JtLCB3ZSBtYXkgd2FudCB0byBhc3NpZ24gc2xv
dCAwIHRvIGxpbnV4LCBidXQgc2xvdCAxIHRvIGEgdm0uIFNvIHdlIGRvbid0IHdhbnQgdG8gZW5h
YmxlIHBvd2VyIG9mIHNsb3QgMSBpbiBsaW51eC4NCg0KQmVzdCByZWdhcmRzLA0KTWluZw0KDQoN
Cj4+DQo+PiBXb3VsZCB5b3UgcGxlYXNlIGdpdmUgc29tZSBndWlkZSBhYm91dCBwcm9wZXIganVz
dGlmaWNhdGlvbj8NCj5EZXNjcmliZSBhcmNoaXRlY3R1cmUgYW5kIHRoZW4gcHJvcG9zZSBnZW5l
cmljIHNvbHV0aW9uIG1hdGNoaW5nIG11bHRpcGxlDQo+dmVuZG9ycyBhbmQgSVAgYmxvY2tzLCBu
b3Qgc29tZXRoaW5nIHNvbHZpbmcgb25seSB0aGlzIG9uZSBwcm9ibGVtLg0KPg0KPkJlc3QgcmVn
YXJkcywNCj5Lcnp5c3p0b2YNCg0K
