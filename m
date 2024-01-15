Return-Path: <linux-kernel+bounces-25741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4293182D52D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B266FB2106F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC0F63C5;
	Mon, 15 Jan 2024 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iEvuTAD6"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2084.outbound.protection.outlook.com [40.107.15.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AE063AE;
	Mon, 15 Jan 2024 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWgzZdVfTfhwzAK5jnaKI/JOi7UIi7/f6isrw325v7kY2V47A3+BIEa5anDDZOxBrUcBy6zRe/e9U9RKIzJI8+U13M8mbXF0A9Q6Qtt7NY3oUxI+PBdjEdE1EW2XOqi9AlvIdN14S+i+bnw9p29R857wpAP8S++ngGj+I8jgmiUaC9lP6OZh2eQJJenRpSgWzH9Hq63etY5AD/gunWmRzubMmA8DNFyAH/zPCfOHZ4zh/BeAcD9G+CeCr9zMeGKy9LD9uBV3thR9h8ywYm5nS1ekYLHBWjaJ0nPCpRyUnyY0EiBOWoRjDLIc9F+2n1VpeE2/qoYm9IM3f7hBtKJDqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAXfxr3k8Hf/DM4OVov8i1XAbUV7/Qg5YaZ1Dr3ZgOs=;
 b=oZWTbAsDWvWK5U6zKVOgUBOv9RCo6UfSuCZYYytKnQdXBlWBds8OVoEGmSda2TWvwnRsYMBr+ttSwV5zPvkKWO6ZtgRezbD4mH76OrTJ+XitSqB5wc3qWwdVmmxwHaIVxlEh2DDQT2J586V6P6dtfPudQOzmQvEXa3sc9yBS8cE1WDNo3xGlro2OynCimmyRlf9fW+mqouW2q+pG5Q7eydQ1mQf0PK2KFj6FXg5lT7jORQU4wifWNgSUErE8s5slpiBSQor9C9WZM9+UtUH0DHaSQeHLtJ/Wm4bwsVF+mTj4+U/XrGZ6TYXjfJDdwN59Hvjhf76QJCD6ybrtmN71rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAXfxr3k8Hf/DM4OVov8i1XAbUV7/Qg5YaZ1Dr3ZgOs=;
 b=iEvuTAD6ZY4450O2UB5XK9DMZzIarH5gcEq91I9M8Lro3chbZ86ogn2aU37+64OWb03/j0mAzb2yl3RxdK610ckCf7OnCkXQIbdsl4IRekl9OcOXTU5iprPU+8Eq6leRy0b571CqrdKR3cIDgsXnUCSF8ybn2FMYZOy/zYG5UYA=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM7PR04MB6982.eurprd04.prod.outlook.com (2603:10a6:20b:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 08:42:52 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::efd8:23d4:18bf:630a]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::efd8:23d4:18bf:630a%4]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 08:42:52 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Frank Li
	<frank.li@nxp.com>, "will@kernel.org" <will@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"john.g.garry@oracle.com" <john.g.garry@oracle.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"irogers@google.com" <irogers@google.com>
CC: dl-linux-imx <linux-imx@nxp.com>, "mike.leach@linaro.org"
	<mike.leach@linaro.org>, "leo.yan@linaro.org" <leo.yan@linaro.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v2 1/4] dt-bindings: perf: fsl-imx-ddr: Add
 i.MX95 compatible
Thread-Topic: [EXT] Re: [PATCH v2 1/4] dt-bindings: perf: fsl-imx-ddr: Add
 i.MX95 compatible
Thread-Index: AQHaKbNLbV9si+3atU615KFz+VRTyrDanSGggAAXF4CAABUHsA==
Date: Mon, 15 Jan 2024 08:42:51 +0000
Message-ID:
 <DU2PR04MB8822F58E2F2623204DD49FA08C6C2@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20231208085402.2106904-1-xu.yang_2@nxp.com>
 <DU2PR04MB882292D4D284A000A9342EA58C6C2@DU2PR04MB8822.eurprd04.prod.outlook.com>
 <b7458f01-8022-4ed4-8404-9e7d6f567ff4@linaro.org>
In-Reply-To: <b7458f01-8022-4ed4-8404-9e7d6f567ff4@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|AM7PR04MB6982:EE_
x-ms-office365-filtering-correlation-id: a54bdd02-0981-49e9-e9ad-08dc15a5f5f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +NmhcrJdAfJeIjzDaxRJiSg2K0ncSjwU/nbNgtoqtw3aNNeL/WFM5fI9NZ9SfwcVSVX4p1/+YRPu4Qqo8uMlGGQ9y+LQ3GMv1p5uPOtxMW/bOiLrjrb2vF3lhIBVvGGhB5WShK8MB7HBn7lNYukoTPNMY2koUMaxBp7INA2G8020xfn8N/h/UIRF9ovCdnuVnGs5lq9pYTEMR4T27+nFfICKB2yxdLh4Xol5yDrK2Ce30TNCsi5x45v6bdvQf1mei2EGTJONAsk4cjeWXaTY4OsA3bRy8HXYHih7uohprIvGB3P0MXB3iMljv0zGbpAx76g5ipKhsQtyQozwVyn5fXxX5zaZwkDA6VE3wM6DbimwS6QbbaXt5PNEKifxGF8hRqCILSSVxND4GewhzVfu4qfePDdvuZCpF+3d/GJ6pD9i1u6CGxp0eE3sfK9Fj7ukg13WFm7Ig+CNd1EZSg3p6cDGG6Q8SrqqEfRHW8Bv3Hg4/A55LcoDzyBz7YAXj8shKkldJiVMflvP73yoDer3bvhMFRn/4KnFy05HoJYxj57FM9BgfoXLorFHGKlIlStBvOc2BO54YW4LzC3F1YZf3Q5UZ1Giy8NXeI2Rt8JjiJkhtpn4N1+2E7IjGSAnn2G2z1PvUvRf4IqBIsKfjGP9qg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(122000001)(921011)(55016003)(86362001)(66556008)(66446008)(26005)(52536014)(66946007)(66476007)(54906003)(64756008)(76116006)(9686003)(316002)(478600001)(71200400001)(8936002)(8676002)(6506007)(7696005)(53546011)(110136005)(33656002)(38070700009)(2906002)(41300700001)(4326008)(5660300002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dnQwY3JyT1QzTmtqMnZRZGpGbEZyWEpXcm44UUlqeW05TlpXcm5LbktXTjNP?=
 =?utf-8?B?Q3pjOHJkcWJCNi9LdG42VEJ4dWltN1FGRTF6WHM2SG5TUTc5M0gwKzNlcGw3?=
 =?utf-8?B?bjZEVWRVbUl2SFBGTDZSVXVqYWtwbE1qQS8xSVVyakVUVEU4d1VqQXFXVXZZ?=
 =?utf-8?B?aXluY1pJalVvNEdsZFBVZUxSZThJM0tXb0JIM3YzY2MvaGp6ekUzZzc5WnNL?=
 =?utf-8?B?REk0djU5V2xIMXRGdnZ1UmlNVUErWnAxa2dndFZLS2pxSjFUanpxTUZrcTg4?=
 =?utf-8?B?aDBwM2lSMGZoRlF4eUt5QVhCYmRoL09RbFN3ZWFUU2MxQ200bi9qSjY5d0pD?=
 =?utf-8?B?YktHR2l0RE4weTdIMXJmclNhRFBLTVB1WFlRU201QkMvTGRTM1BWS2czU1lG?=
 =?utf-8?B?dURIR29XcUZGSnpwOXgrcjNDdmtpM2JkL3hIekVFNTZ0Z1hhbEhUUVEzMTBs?=
 =?utf-8?B?NkxqdmVNV3NhSkhXa1hSMFlEaWg4bHgrSFNNSWJXbUhNZm0xRHZsempBc2VH?=
 =?utf-8?B?MVc1WXFZMGg2REE0SW9uZUNGdVlPaTFOMXloNFUwM3FpTEtVcFRob1dLeTVH?=
 =?utf-8?B?MEFMTGFWd3F0ZU9yWDVuTXpBSnZzNERzaElqeXUzM25MRkZ6RkJTNU9CSXBr?=
 =?utf-8?B?d21Cc21qVHJ0d2ZQSUZqMHY3d3NBUmM2TUQwYTVpWThVQWpkZ0Fhc3Q1SjZU?=
 =?utf-8?B?ZzhZYW1IeUdrOHI1UXAxbXQ2VnZsZzVKRS9XeDJ6WWVyWm1Rand3SmNWNE53?=
 =?utf-8?B?aVNib3B1dHY3aG9NRFg0VjQ1SjB1am9NQkovemdHbzNqa3h0ZGhpWlRHT1gz?=
 =?utf-8?B?by80OEQzUmRySjVyV3dHaERXcnhBZCs1YVUybEVFMmN2NlI5aFI2Yk5rMEdF?=
 =?utf-8?B?ZnQydzc1U2VMZUJ6NkpFZDNVR3FwazQyYmpGNEVvVEhlUFBrdy9adnhxNlR2?=
 =?utf-8?B?TEpWRlk2UXFHS0JUWVpKUE52V3JSZ1o1WG1SZ0JrUUE5akdYVDlLTTFFUVZD?=
 =?utf-8?B?bUVNb2lTR3dHejdIdDJpUjF0MXM4ZVFNM00wT2doTGpZa1RBYWdQM1lMMm1y?=
 =?utf-8?B?eWdBNUdjVjZrYi9xMlpqVE5vU1FYclhzTGRnbXBiN0VGZXZVLzRNaWU4T21P?=
 =?utf-8?B?QjI1eVNML2k2cE50ZHJoT3JaS1JPTTBUL3lOZzZBalV0aFFtZ0hxbWNPd1d1?=
 =?utf-8?B?UWkxQTVydHUzQTk2UTNqK0Rud1JjY05Wc2g3RUF6Zm56SlE1V0tNR3JScjVp?=
 =?utf-8?B?SDE3Y1pqK3RseEhlZUdwblhvSmlXQ0lpbXFSdHVodVh1TTJOdkwrNzhYS1Nn?=
 =?utf-8?B?TE5Ca0JiUkZZYUZxK2JvVEJZc25aaWN4SlNLbEQ5cWxuQ0Fxbmg3M2UxNnVp?=
 =?utf-8?B?Z0VjZURFMTlUdm5mME8zT0FTUlJXSEdRZld4MFRkYlZZekhaTnh5R0JLenlx?=
 =?utf-8?B?QTFBaUNwNGErbXJ3cHZNWDRYckh0NEJpODc3RnBUOG1iOFZ4WWtja3lvb1Bh?=
 =?utf-8?B?WkFFdW94bVRLSXdnM2pTT3J5QThDcWRPTjJqcmlVRGV2TkdtZmhLRURndTI2?=
 =?utf-8?B?UzN2Z25WMktXR2JyZ09OV2J3bmVUcC9tUlhFQ0thbE0razd5ZUhQWnhHRkpn?=
 =?utf-8?B?NVhRTEVhb2RLYzBKeDZXVnVRSGdadmQ1SWM4ak1DcTBXTU9aNXdoSS9Oc1lj?=
 =?utf-8?B?OERlY1laSTFzZHBlWjBCRWUwVzNUcjV5UUZaUUdUVUFkUHBJSCt2N1lKeG96?=
 =?utf-8?B?ZzZFMVlyOFNYdSsva3NRcGFtdlBkbEdUK0pmaVVDREpIUDB2Nk9RV2RmKzhs?=
 =?utf-8?B?QVFhUDA0UWF1cTRkT2xyTmVvT0ltbUVlamdNb1BDMG9SeGdBMUV3ZENQajdr?=
 =?utf-8?B?UzZ2N1paK2g1K1dEdHJ4QzZ4Tjc0MnZHeVBjRTA5dUMxOVlHQU92RldZK3Fr?=
 =?utf-8?B?TDd3RXVUWEtwb2VFMENPZGFIQkwvK0JFTmlJTVF5WVBnNExWS3o4dEwvREJq?=
 =?utf-8?B?WFFJRDZabUNkcFFMQTFTYWI0TUI1YnV2NXJYem5hNUFMTkNENFhVRGNlUFhx?=
 =?utf-8?B?cW5pcitiRXJuWS9UNjZUSG1CU1BOL2sydHB5WVR3N3ptR0Rvc2h5WFB0RHpx?=
 =?utf-8?Q?qyXo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a54bdd02-0981-49e9-e9ad-08dc15a5f5f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 08:42:51.9898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ykn8Z/e/39AnxbiVRBQGTqre8HGXCZ16Nx6IMlVmo7A/aPaXGdCHYqBLtE8i3i6I1fxdgFD+xvEljPL1sr3IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6982

DQo+IA0KPiBPbiAxNS8wMS8yMDI0IDA3OjAzLCBYdSBZYW5nIHdyb3RlOg0KPiA+DQo+ID4+IFN1
YmplY3Q6IFtQQVRDSCB2MiAxLzRdIGR0LWJpbmRpbmdzOiBwZXJmOiBmc2wtaW14LWRkcjogQWRk
IGkuTVg5NSBjb21wYXRpYmxlDQo+ID4+DQo+ID4+IGkuTVg5NSBoYXMgYSBERFIgcG11LiBUaGlz
IHdpbGwgYWRkIGEgY29tcGF0aWJsZSBmb3IgaXQuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6
IFh1IFlhbmcgPHh1LnlhbmdfMkBueHAuY29tPg0KPiA+Pg0KPiA+PiAtLS0NCj4gPj4gQ2hhbmdl
cyBpbiB2MjoNCj4gPj4gIC0gbm8gY2hhbmdlcw0KPiA+PiAtLS0NCj4gPj4gIERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9wZXJmL2ZzbC1pbXgtZGRyLnlhbWwgfCAxICsNCj4gPj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BlcmYvZnNsLWlteC1kZHIueWFtbCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wZXJmL2ZzbC0NCj4gPj4gaW14LWRk
ci55YW1sDQo+ID4+IGluZGV4IGU5ZmFkNGIzZGU2OC4uMWJjN2JmMWM4MzY4IDEwMDY0NA0KPiA+
PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGVyZi9mc2wtaW14LWRk
ci55YW1sDQo+ID4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wZXJm
L2ZzbC1pbXgtZGRyLnlhbWwNCj4gPj4gQEAgLTIwLDYgKzIwLDcgQEAgcHJvcGVydGllczoNCj4g
Pj4gICAgICAgICAgICAtIGZzbCxpbXg4bW4tZGRyLXBtdQ0KPiA+PiAgICAgICAgICAgIC0gZnNs
LGlteDhtcC1kZHItcG11DQo+ID4+ICAgICAgICAgICAgLSBmc2wsaW14OTMtZGRyLXBtdQ0KPiA+
PiArICAgICAgICAgIC0gZnNsLGlteDk1LWRkci1wbXUNCj4gPj4gICAgICAgIC0gaXRlbXM6DQo+
ID4+ICAgICAgICAgICAgLSBlbnVtOg0KPiA+PiAgICAgICAgICAgICAgICAtIGZzbCxpbXg4bW0t
ZGRyLXBtdQ0KPiA+PiAtLQ0KPiA+PiAyLjM0LjENCj4gPg0KPiA+IEEgZ2VudGxlIHBpbmcuDQo+
IA0KPiBXaGF0IGRvIHlvdSBtZWFuPyBXZXJlbid0IHlvdSBhc2tlZCB0byBmaXggdGhpbmdzLCB3
ZXJlIHlvdT8gV2h5IGRvIHlvdQ0KPiBwaW5nIHRoZW4/DQoNClNvcnJ5IGZvciBpbmNvbnZlbmll
bmNlLiBJdOKAmXMgbXkgbWlzdGFrZSB0byBwaW5nIHRoaXMgb25lLg0KDQo+IA0KPiBCZXN0IHJl
Z2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

