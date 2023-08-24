Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6743786FB5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241371AbjHXMx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241412AbjHXMxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:53:48 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B9C1BF1;
        Thu, 24 Aug 2023 05:53:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ter3AeHdI1mBXrC0GS0To+mIzWbevJl31angx+20jOO1lde+3ZBjl+1TA2Lvg2WOO9Km5d8EVv0m0sTDSR6hG8g+zHtq1qgLHamt1H+hqiIwTWQKa1TlPRPxoSrfHowdzZfFP1TvM8fXg8+OTIAC3xWMjMLNzlmI7MZ2ET/GzFgV4YbPcB5QX6hYDofVZRS8ounPHaqjq5/fGifJCDhYyIYWT1gD3mWE1QHgeUaIq2Yii3GNrkSYTyuKNVGjftdNhsh22PzKyKbGwIuYDUU1AB6/LHU4bByCZs6tUF6hhqxlfcZlspV90qVZfuyRuIHfDh/siOZ17MKOT7A5GC80AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMgJj6eqIR3r0cOqoRjS/EHL96qpzPZ8yKsZ7D2bDco=;
 b=mcFLvW5jPRc/IL60tIogCYuQ+7LU3RgukqW1PUnpd8oIBGy30JiZPPkULBV7ZBsD3XUS4N8oFI9CwCTjtNshCccZ1hfDsTyRE/DZLmpDnlDQrxy8Z7GYOEVD4/EI9mntRfakgw3Ba+BfDAVvtckY5dL+tIBSg0WXR15Qq7FJlw/tv9Icnfm7g29DtejWSpg0khzWhwVS0panYwmioRX7ROkoQaZM+VtHQQ2ip0+EFVGJGlxPLfAMsksh41WW2Tq4v7lnV7fGncvAPIvEua6UPiSXDZPKvmcX5CesHnEiSj5IcgsHZFRKWIpeNMDfd/pWpWeo/gYI9TyiJiv+ojhcWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMgJj6eqIR3r0cOqoRjS/EHL96qpzPZ8yKsZ7D2bDco=;
 b=K7OhW7BMym8GxSvUswYoV5CIXuAs/gXG1rs+xCn5mrVmHOF3ZYoMRZqH0967WM+hUMkjAedEZeuBjNwQZbkB8SUIwwC3tkKOoQ/4EzDx5mrcqKNS0eSurJicxtbzA3K3nj4xEU94IkESCxqf6O6rYjq3TBmYiLvYAEK9UCKn0/Y=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8785.eurprd04.prod.outlook.com (2603:10a6:20b:42c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 24 Aug
 2023 12:52:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 12:52:58 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "oleksii_moisieiev@epam.com" <oleksii_moisieiev@epam.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: RE: [RFC] scmi: pinctrl: support i.MX9
Thread-Topic: [RFC] scmi: pinctrl: support i.MX9
Thread-Index: AQHZ1ljQGymVJC/R70ObhTQ99JrC7K/5IV8AgAAj2ICAACCTYA==
Date:   Thu, 24 Aug 2023 12:52:58 +0000
Message-ID: <DU0PR04MB9417FF49B077756B1F9C91AC881DA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230824070611.3335107-1-peng.fan@oss.nxp.com>
 <CACRpkdYU7MRXRV3Uw1w300sdxv=9XT=P1vFFarHfpSM6BT20Hg@mail.gmail.com>
 <20230824105137.xqkwi4xvmjoidexh@bogus>
In-Reply-To: <20230824105137.xqkwi4xvmjoidexh@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8785:EE_
x-ms-office365-filtering-correlation-id: 7a6e14eb-6d05-40c6-75bf-08dba4a10b36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zvI3dNw4RbA7lwpXounGg4bNDvUrwZ0ElZq0TSo8/ugx8XdHDQk/YYf+1R5EgLnNRNYoWAAf4eOXKL7mosfgRhP/NFkqv0Xjpmt3gpUFb57S+bi0LAfyrF60YrdHyX68fIlT08XhnLEpC6UvgKuplkBsNRQPwcKVJdTx/rKP2w0ciiN1GvB1ty4J+a7n5+mp01WVDHBz6e5Mc2b9o4lKhjdOwRUBpaYmvMm37Z5S/g9CUd+gZg4yTaljPcAQDMu7bHkSNomHgdCJHOydlqEpsYt8yvSR4A7+FmyHP+7eZBLXAx6FiEqRDsYxImiyLgCBwfjyYbblXzGa5PBIVf1UI7qblKucVZVAAIjQfmBAtEmbmidNaiw4w01o8pNibeKDk6+PWV0XQC9sZN9h0DNcTMuyiXhkYDO6o76WWYnI7R5J+e2xKwfao3hxx+4FgSElxc6Drr7xJu0Vj3RLVw6zTbTDpwN3jyjdPNy55arj1VjM+N9Ceq1xkSKaRMe4m8ARQFEjimT7ydW8FnzZb16DTawXRI/X2OVF6FzIfxyx9s+/HF72vLY0XQlaHpMN+qP7r3Ql7N7ZkVRH1UFVKNllDyDiBxmPLusU5yvtVwLfECGbG9YEZdxlfBuBygN/1WppEHRUCvqyRqu0kSJKIAAbnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199024)(186009)(1800799009)(71200400001)(6506007)(7696005)(53546011)(83380400001)(2906002)(478600001)(26005)(7416002)(41300700001)(316002)(64756008)(54906003)(66946007)(8676002)(66556008)(66446008)(76116006)(66476007)(110136005)(5660300002)(52536014)(8936002)(4326008)(44832011)(9686003)(33656002)(86362001)(55016003)(38100700002)(38070700005)(122000001)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZU8vN2owaytFU3dWcDBUbHpFVGRtVkoxVnRjenB2MlFWZlREa0JwK1ErRFdj?=
 =?utf-8?B?OGZFd1JwV3dMZE1lQnVQSSt6MjNZbUsxcFJGVzFCZ1JmTk1wbUJkSmxGb3hk?=
 =?utf-8?B?cGtwRjAySk9STERLWmN5R1lJbW0vYldJUW9Gby8yL1pJTmh3cmhhUStoblg2?=
 =?utf-8?B?TzZ4c2hSWDl5TWJndkxqdzR0NjJ3L1pJaFc0RjBnd2VZZFpJYlNabHNpQWYy?=
 =?utf-8?B?NXEveEpYdmZCZ003M1dVazNMS05Yeko1MnZYaHhWV3JnTUVHZDFXTktiR0dN?=
 =?utf-8?B?d2FzVHgxZ2N5d2l6ZUNIanFRSFllcmNmT01TVHVpamlrVUduMjFPRFhmbHJT?=
 =?utf-8?B?aTJwOTVEMmNXcGNnanpIRFp1TDI0Tk9nRVFLT01Qa21KbDJ5Unl2T2tzbGRx?=
 =?utf-8?B?ejhVaE5UR3pjRjA4bzVGdjV3SmRQVjZCSGJuU0tMazZ2OVZWUHVBcUNmVXlt?=
 =?utf-8?B?ZXhmRERpdDF1SjlwOW1XNkFkRGd5YzdTUnhBV2xxZWNoVG5UU25wSVV1RVZM?=
 =?utf-8?B?SkpVMlMyYmFqTGswVzE2aGxpaXNYNVptcmY1OVk2aGxydDFkdE1YMWI0aHFW?=
 =?utf-8?B?M3ZkeG1Da2dOMmw5WGFiSEdBVUZUNDRoNmZJNXJOblE2M1ByVkIyQUJ4ZmxU?=
 =?utf-8?B?TlZiWWNPdE5mWU04TUdBVFc0OE5sWHlFajhCemkyRUtRbFdQZkxnWGw2UVRs?=
 =?utf-8?B?SUp1TmFOaFk2ckYvOVFLOE42MVoyUVVqSStNNExWd1FlTDJabzROWG9zdjQ5?=
 =?utf-8?B?Y202RHFhT3VNS2E5Qld6SHZrckdQZjlIOFhOaXBqTm5Xa2JnQmExTzgzVDJW?=
 =?utf-8?B?Rk45US9zSFVPR2NBTS9CTnc0K21ZMEZrdGRCSFc4NXlFMW9KbWREY1dTVGpT?=
 =?utf-8?B?anJveTVxbmYzNW0wUFluS081TEdIWm1qd2dDUDV3dkdhL3pEMUxWUFlsMStk?=
 =?utf-8?B?ajFobU9PNUNhWFhQWVhzbERldHhRajZ2V3lvRnBHaktqMkdmY0ZDT1hJYU9t?=
 =?utf-8?B?WCtBSVNZNHlPUDNoNm9MS1ZGSEszQ0RwU1ZkVW9EVW84eEJVU25qTFptSy9v?=
 =?utf-8?B?T1p3b1BmQXFNemkzUVo3WDZrNjBFbmdPaURiRFBsdHlPcG56UC9ZOVRSbHZE?=
 =?utf-8?B?dnlrSktQRUh0QjlkR2RuNmJYT2FpL1lrREhZSnVPK1h6d1N4TkNIQXZlUnRi?=
 =?utf-8?B?TWFGb01JTWpVcnAxZ0FSL0ozVFRiMzdlRWRMb2ErekRRaWMyd001UVIxZFpH?=
 =?utf-8?B?eGg4em1rY0RWcDRBYm1UeFhVMnl5SG12T1M2aGU1eENzRU9FcE8zb3B0TjJa?=
 =?utf-8?B?YXBZUHJWc2VqTkw1aHFsYkFCeHIwQzUyQWpIbmU4MEtlKzhweFZpdnJvOEQ1?=
 =?utf-8?B?WDdONVBtalVZMjBaVDA4Qmc3WjZ6ckFzUURaV3BqVmc1ZnpTRlNNaDhQRmZH?=
 =?utf-8?B?YXBTZkJ2NDM4UFVyUDdFekNRMjR5SzZpejlibS9QYjBXQWxxbUxjanc5ZUND?=
 =?utf-8?B?cXdTak10b25LWTduUDNkNTlRbWN0UVhGMzVvRjhrVU5kd2tVeVY4c1UwNHhR?=
 =?utf-8?B?S05zaktENEwzemVNK3h5ZWZlVDhHWWsrM1U0RlhZQkZUTHM0WnI1endJNmZ1?=
 =?utf-8?B?aURPK2QxQjR3SDlObE9YT0s4ZjNzRzJwWlpWNGlIejFnVU1IWkZMbGFVRDYy?=
 =?utf-8?B?U0FlaW9nNDhCZEJFVlBNSkhGNUNtTFIxNTZmbW1WQ0YxbUl4Y3I4N3l6bmpr?=
 =?utf-8?B?MXBLYm83U2NCZ0RBaHZ1b0xCaFRVMEcyYjJzUVp6ajlHN3ZmT3ZsWDBseDls?=
 =?utf-8?B?VHpZL2hlVFFFMlpQU2Z3MjJjU3NwN28rOW9UWHJaSUFYUzlvbmVST1VzUTZD?=
 =?utf-8?B?MTBqTjUyaGdLa2kwMUREQW9NY2Qzb3RBMXcwaUxaQXhpWTFiTDJXaWNqSE9D?=
 =?utf-8?B?ZzdKeFh4Slc2ZlFwS0NRWUZuNEVIR1RLM2dtSVVYWk04MXlqVmdZQzEzSlBZ?=
 =?utf-8?B?UGJuamdudXpHeExTYmVaNlpBeGw3T1k0RE1FMmhZUm9yWmp0aVl5cnJOSTlV?=
 =?utf-8?B?VzlnaFEweElwcUxHRXhTZ0JJU1ZSSzFFVm1YV3RFOXZxOE0zUGJtdXdvOHNt?=
 =?utf-8?Q?2yK0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6e14eb-6d05-40c6-75bf-08dba4a10b36
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 12:52:58.7582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sBwJnoPzqc7PLlje6HS0dMbQd5fMJj7yIkbGG+EvEuQt6SDLb/CvzpBo7S3ctfbk/yn4LDGY5lwZSG+JU9sKlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8785
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3VkZWVwLA0KDQo+IFN1YmplY3Q6IFJlOiBbUkZDXSBzY21pOiBwaW5jdHJsOiBzdXBwb3J0
IGkuTVg5DQo+IA0KPiBIaSBMaW51cywNCj4gDQo+IFRoYW5rcyBhIGxvdCBmb3IgdGhlIHF1aWNr
IHJlc3BvbnNlLg0KPiANCj4gT24gVGh1LCBBdWcgMjQsIDIwMjMgYXQgMTA6NDM6MjBBTSArMDIw
MCwgTGludXMgV2FsbGVpaiB3cm90ZToNCj4gPiBPbiBUaHUsIEF1ZyAyNCwgMjAyMyBhdCA5OjAx
4oCvQU0gUGVuZyBGYW4gKE9TUykgPHBlbmcuZmFuQG9zcy5ueHAuY29tPg0KPiB3cm90ZToNCj4g
Pg0KPiA+ID4gVGhpcyBwYXRjaCBpcyBqdXN0IHRvIGludHJvZHVjZSBpLk1YIHN1cHBvcnQgdG8g
c2VlIHdoZXRoZXIgcGVvcGxlDQo+ID4gPiBoYXZlIGNvbW1lbnRzIGZvciB0aGUgZGVzaWduLg0K
PiA+DQo+ID4gVmVyeSBpbnRlcmVzdGluZyENCj4gPg0KPiA+ID4gVGhlIGJpbmRpbmcgZm9ybWF0
Og0KPiA+ID4gPG11eF9yZWcgY29uZl9yZWcgaW5wdXRfcmVnIG11eF9tb2RlIGlucHV0X3ZhbD4N
Cj4gPiA+IGR0czoNCj4gPiA+ICAgICAgICAgcGluY3RybF91YXJ0MTogdWFydDFncnAgew0KPiA+
ID4gICAgICAgICAgICAgICAgIGZzbCxwaW5zID0gPA0KPiA+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgTVg5M19QQURfVUFSVDFfUlhEX19MUFVBUlQxX1JYICAgICAgICAgICAgICAgICAgMHgz
MWUNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIE1YOTNfUEFEX1VBUlQxX1RYRF9fTFBV
QVJUMV9UWCAgICAgICAgICAgICAgICAgIDB4MzFlDQo+ID4gPiAgICAgICAgICAgICAgICAgPjsN
Cj4gPiA+ICAgICAgICAgfTsNCj4gPiA+DQo+ID4gPiBpLk1YIHBpbmN0cmwgbm90IHVzZSBnZW5l
cmljIHBpbmNvbmYsIHRoaXMgaGFzIGJlZW4gYWdyZWVlZCBieQ0KPiA+ID4gbWFpbnRhaW5lcnMg
YmVmb3JlLg0KPiA+DQo+ID4gWWVzLCBpdCBoYXMgaGlzdG9yaWNhbCByZWFzb25zLg0KPiA+DQo+
IA0KPiBHb29kIHRvIGtub3cuDQo+IA0KPiA+ID4gU28gYWZ0ZXIgbW92aW5nIHRvIFNDTUksIHdl
IHdpbGwgc3RpbGwga2VlcCB0aGUgc2FtZSBiaW5kaW5nIGZvcm1hdCwNCj4gPiA+IGFuZCBpLk1Y
IFNDTUkgZmlybXdhcmUgYWxzbyB1c2Ugc2FtZSBmb3JtYXQgd2hlbiBjb25maWd1cmUNCj4gPiA+
IHJlZ2lzdGVycy4gU28gd2UgbmVlZCB0byB1c2UgaS5NWCBzcGVjaWZpYyBkdF9ub2RlX3RvX21h
cCBmdW5jdGlvbi4NCj4gPg0KPiA+IEkgdGhvdWdodCB0aGUgaWRlYSB3aXRoIFNDTUkgd2FzIHRv
IGFic3RyYWN0IGFuZCBoaWRlIHRoZQ0KPiA+IGNoYXJhY3RlcmlzdGljcyBvZiB0aGUgdW5kZXJs
eWluZyBoYXJkd2FyZS4gSS5lLiB0aGUgZmlybXdhcmUgaXMgdG8NCj4gPiBwcmVzZW50IGdyb3Vw
cyBhbmQgZnVuY3Rpb25zIGFuZCBnZW5lcmljIGNvbmZpZyBvcHRpb25zIGFuZCB0aGVuIHRoZQ0K
PiBkcml2ZXIgd2lsbCB1c2UgdGhlc2UuDQo+ID4NCj4gDQo+IENvcnJlY3QuDQo+IA0KPiA+IFRo
aXMgcGF0Y2gsIGl0IHNlZW1zLCBjcmVhdGVzIGEgaHlicmlkIGJldHdlZW4gdGhlIG9sZCBmcmVl
c2NhbGUNCj4gPiBkcml2ZXIgYW5kIHRoZSBTQ01JIGZpcm13YXJlIGNvbW11bmljYXRpb24gbGlu
ayB3aGVyZSB0aGUgU0NNSSBpcyBqdXN0DQo+ID4gYSB0cmFuc3BvcnQgbWVjaGFuaXNtIHRvIHNv
bWV0aGluZyBpbnNpZGUgU0NNSSB0aGF0IHBva2UgdGhlIHNhbWUNCj4gPiByZWdpc3RlcnMgdGhh
dCB1c2Vyc3BhY2UgY291bGQgcG9rZSwgaWYgaXQgY291bGQgb25seSBhY2Nlc3MgdGhlc2UNCj4g
PiByZWdpc3RlcnMuDQo+ID4NCj4gPiBJLmUgdXNpbmcgU0NNSSBvbiB0aGlzIHBsYXRmb3JtIGlz
bid0IGNyZWF0aW5nIGFueSBhYnN0cmFjdGlvbiBvZiB0aGUNCj4gPiBwaW4gY29udHJvbCBoYXJk
d2FyZSwgaXQgaXMgbWVyZWx5IG1ha2luZyB0aGluZ3MgbW9yZSBjb21wbGV4IGFuZCBhbHNvDQo+
ID4gc2xvd2VyIGJ5bWFraW5nIHRoZSByZWdpc3RlcnMgb25seSBhY2Nlc3NpYmxlIGZyb20gdGhp
cyBTQ01JIGxpbmsuDQo+ID4NCj4gDQo+IEFncmVlZC4NCj4gDQo+IEkgZG9uJ3QgaGF2ZSBtdWNo
IGtub3dsZWRnZSBvbiBnZW5lcmljIHBpbm11eCBjb25mIGFuZCBzdWdnZXN0ZWQgUGVuZyB0bw0K
PiBwb3N0IHRoZSBSRkMgdG8gc3RhcnQgdGhlIGRpc2N1c3Npb24gaW5zdGVhZCBvZiBnZXR0aW5n
IGJsb2NrZWQgYnkgbWUgZHVyaW5nDQo+IHNvbWUgaW50ZXJuYWwvcHJpdmF0ZSBkaXNjdXNzaW9u
cyBhcyB0aGUgbWFpbiBpbnRlbnRpb24gZm9yIGhpbSB3YXMNCj4gdXBzdHJlYW1pbmcgdGhlIGNo
YW5nZXMuIEkgYW0gYWdhaW5zdCB0aGUgaWRlYSBvZiBtaXhpbmcgcGxhdGZvcm0gc3BlY2lmaWMN
Cj4gY2hhbmdlcyB0aGUgd2F5IGl0IGlzIGRvbmUgaGVyZSBidXQgc2luY2UgSSBkaWRuJ3QgaGF2
ZSBtdWNoIGtub3dsZWRnZSBvbg0KPiBwaW5tdXggY29uZiB0byBzdWdnZXN0L3Byb3ZpZGUgYW55
IHVzZWZ1bCBmZWVkYmFjayBJIHN1Z2dlc3RlZCB0byB0cmlnZ2VyDQo+IHRoaXMgZGlzY3Vzc2lv
bi4NCg0KVG8gdXNlIGdlbmVyaWMgcGluY29uZiwgd2Ugc3RpbGwgbmVlZCB0byBleHRlbmQgdG8g
dXNlIE9FTSB0eXBlLCBvdXIgc2NtaSBmaXJtd2FyZQ0Kd2lsbCBub3Qgc3VwcG9ydCBzYXlpbmcg
Ymlhcy9wdWxsLXVwIGFuZCBldGMgY29uZmlnIHR5cGUsIHNvIGp1c3QgYXMgYmVsb3csIHdlIGFk
ZDoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BpbmN0cmwvcGluY29uZi1nZW5lcmljLmMgYi9kcml2
ZXJzL3BpbmN0cmwvcGluY29uZi1nZW5lcmljLmMNCmluZGV4IDM2NWM0YjBjYTQ2NS4uYTcxNzIx
Y2QzMjFkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9waW5jdHJsL3BpbmNvbmYtZ2VuZXJpYy5jDQor
KysgYi9kcml2ZXJzL3BpbmN0cmwvcGluY29uZi1nZW5lcmljLmMNCkBAIC0xODYsNiArMTg2LDE2
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGluY29uZl9nZW5lcmljX3BhcmFtcyBkdF9wYXJhbXNb
XSA9IHsNCiAgICAgICAgeyAic2xlZXAtaGFyZHdhcmUtc3RhdGUiLCBQSU5fQ09ORklHX1NMRUVQ
X0hBUkRXQVJFX1NUQVRFLCAwIH0sDQogICAgICAgIHsgInNsZXctcmF0ZSIsIFBJTl9DT05GSUdf
U0xFV19SQVRFLCAwIH0sDQogICAgICAgIHsgInNrZXctZGVsYXkiLCBQSU5fQ09ORklHX1NLRVdf
REVMQVksIDAgfSwNCisgICAgICAgeyAibnhwLW11eCIsIFBJTl9DT05GSUdfTlhQX01VWCwgMCB9
LA0KKyAgICAgICB7ICJueHAtY29uZiIsIFBJTl9DT05GSUdfTlhQX0NPTkYsIDAgfSwNCisgICAg
ICAgeyAibnhwLWRhaXN5LWlkIiwgUElOX0NPTkZJR19OWFBfREFJU1lfSUQsIDAgfSwNCisgICAg
ICAgeyAibnhwLWRhaXN5LXZhbCIsIFBJTl9DT05GSUdfTlhQX0RBSVNZX1ZBTCwgMCB9LA0KfTsN
Cg0KQW5kIGluIGR0czoNCisgICAgICAgcGluY3RybF91YXJ0MTogdWFydDFncnAgew0KKyAgICAg
ICAgICAgICAgIHR4ZCB7DQorICAgICAgICAgICAgICAgICAgICAgICBwaW5zID0gInVhcnQxdHhk
IjsNCisgICAgICAgICAgICAgICAgICAgICAgIG54cC1tdXggPSA8MHgwPjsNCisgICAgICAgICAg
ICAgICAgICAgICAgIG54cC1jb25mID0gPDB4MzFlPjsNCisgICAgICAgICAgICAgICB9Ow0KKw0K
KyAgICAgICAgICAgICAgIHJ4ZCB7DQorICAgICAgICAgICAgICAgICAgICAgICBwaW5zID0gInVh
cnQxcnhkIjsNCisgICAgICAgICAgICAgICAgICAgICAgIG54cC1tdXggPSA8MHgwPjsNCisgICAg
ICAgICAgICAgICAgICAgICAgIG54cC1jb25mID0gPDB4MzFlPjsNCisgICAgICAgICAgICAgICB9
Ow0KKyAgICAgICB9Ow0KDQpCdXQgdGhlIHVwcGVyIHdpbGwgbWFrZSBkZXZpY2UgdHJlZSBkaXZl
cmdlIHcvbyBzY21pLCBiZWNhdXNlDQp3ZSBuZWVkIHN1cHBvcnQgYm90aCBmb3IgaS5NWDk1Lg0K
SSBzdGlsbCBwcmVmZXIgdG8gdXNlIGZyZWVzY2FsZSBjdXJyZW50IGJpbmRpbmcgZm9ybWF0IHdo
aWNoDQp3b3VsZCBtYWtlIGR0cyByZXVzYWJsZSB3L28gc2NtaS4NCg0KVGhhbmtzLA0KUGVuZy4N
Cg0KPiANCj4gPiBCdXQgSSBjb3VsZCBoYXZlIG1pc3VuZGVyc3Rvb2QgaXQsIHNvIHBsZWFzZSBj
b3JyZWN0IG1lIQ0KPiANCj4gKzENCj4gDQo+IC0tDQo+IFJlZ2FyZHMsDQo+IFN1ZGVlcA0K
