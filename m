Return-Path: <linux-kernel+bounces-24599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3874582BECA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6DD2847F6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AD05FEF2;
	Fri, 12 Jan 2024 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="qC0noOKS"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2136.outbound.protection.outlook.com [40.107.22.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE5B5FF00;
	Fri, 12 Jan 2024 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgdx7Tdh7nf6oEQNo9SaBNTWLo7cpopRz2piIXevq+u7tEhVNhKX5kzJEmvStHJJnFr3ICf5ZzEpATP4svnyA+goUDLni7LwaJKK9GTDzGYOsfxtGy0/THwpiE6xQn1n8pHXYaUOlzbAyYPzHxPMvTDpbWwC9q9SHZmwSFEbwp/BYX2jhbEtsoJvjmcYG+A5ZrKXhUkjti1f2JQ2JSABKlo+sLkA2zgDjgilQ+ZvM7fNQphMdYiDiSgATRkyYCNkIrV4efJTIyjtRl1t6uZNhQpB95quAMUYsroqhhgPrJgVwWbWgImVgDNoXsgJ4BuxBaTt7mvNtFfmVEPlERFgdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WHLwwjMI1xun89eALQ0BI+JBuqAs6wh5H4dszBIJmY=;
 b=mtsOucJ1FEmxZge4vs3RgrswVnCSbcUhHacXaao2CXYZgvAUllMTaB67t7/Qk9D/FvqGzfgwPT0J/uLf8VlalNcFz0cKyZIyWdW2np98xIxRlw9VjaIsaC5O/bqz1h4RjXupq8JgqVnxFF7MbB6Gig7hfU7JqK1GbscH1vge1l0NP2ApjlBEb0FdlDu9Y92jB1VeGkEUr/ghtfVa+7QzVxM/Ilv0jXcYiXBakWJJMSX2CfNTnufkLSW6pau3kr4/kLur3+r9rxDUivToectN2My43DZl68PjyY1CnPKmFlgiw0FWzfs1Bxs46QgBp064lk3CRdKv2l6nJmNHq+JTZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WHLwwjMI1xun89eALQ0BI+JBuqAs6wh5H4dszBIJmY=;
 b=qC0noOKSVMa5JtFQqdNk7DcxT2Q7Ll+2LEO+O9ql6lDGtVVN59t8YDIuDKIwjiWT9MeFndcSPkS4SvGSkvgNrSPtvzp09JrUuxIItjj7Z2sOSj/a9OojBPTv8eQ1VZOZZDSjR7gxLPIDkmmFojoLSXh3WcrCCJs7OSAFO1wYWoE=
Received: from DB8PR06MB6332.eurprd06.prod.outlook.com (2603:10a6:10:103::23)
 by DB9PR06MB8910.eurprd06.prod.outlook.com (2603:10a6:10:4c6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 10:56:59 +0000
Received: from DB8PR06MB6332.eurprd06.prod.outlook.com
 ([fe80::2ef6:99ac:4fcc:7039]) by DB8PR06MB6332.eurprd06.prod.outlook.com
 ([fe80::2ef6:99ac:4fcc:7039%5]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 10:56:59 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "afd@ti.com" <afd@ti.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: net: dp83826: add ti,cfg-dac-plus
 binding
Thread-Topic: [PATCH 2/3] dt-bindings: net: dp83826: add ti,cfg-dac-plus
 binding
Thread-Index: AQHaRKoXF4N7IPsFp0OxQEd+BLc1/7DU3AEAgAEmzIA=
Date: Fri, 12 Jan 2024 10:56:59 +0000
Message-ID: <5931489e-5367-4fb0-81cf-77cb3beb69e6@leica-geosystems.com>
References: <20240111161927.3689084-1-catalin.popescu@leica-geosystems.com>
 <20240111161927.3689084-2-catalin.popescu@leica-geosystems.com>
 <85e7e66e-2703-4dcd-8dbd-dd9b5f0c8228@linaro.org>
In-Reply-To: <85e7e66e-2703-4dcd-8dbd-dd9b5f0c8228@linaro.org>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR06MB6332:EE_|DB9PR06MB8910:EE_
x-ms-office365-filtering-correlation-id: 70fa7bb5-bc23-478e-6a41-08dc135d3397
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8aE4uQBLe1IqBDOMbbzLtYJ9TityXWWE62S55eF/nW5BoDUdgmTrx/obsy1OiYFycY1EVcchj2gB+mXdFCUqRDk6qNChvPh5Aq/ZyMRcW9zzo9B3uwgDw8sMnAztcnZ0DzKopD6yTmRD9ihrG3oKvAIr46ZMDosuTwt7s7FvtvYxyEF9Ty5Uop6YbPA7IHs+oWRjeEEDzEqnJ8/Z4WIWWdPHKRlUnFgyPYddc0JXrXQ34VOvw9ffUXhPF40DU8hYnRCeTVKN83WTgyl5rWl0h6whBZroz0bhE6egLBuNABtdGtoMhIO0jILoFPFY55wQOgR8G6MTKyjdUwBmfW1hPsxYTJBVHDXyT2oEIWyziaTiuWu4nZcU/y5ROYmLYpD4eUsO04MwztL/dTh0SmzPyuYx2a7GKNCHn3G73uUxGBJUviCNuKBIuWq0ke9GCdm8YZcPpGGdkPNv/zhjwObuaFlu+fEw2xpDEBC8P64AleCp2xSTwx5mmKA/8HyCtsnDb4m3TBYL55s0YqoJV1H5PNLfXevWzcp8fk2ckgWukY/t8aZsawe4y1HL4LkhR1JcqsaZZSthGtdYdB+q/09pn8TyhsB7KYyKbFEmycS33HZXApWcbki1jU8oldmkAk6VCZMVE3WhazOA9aWJbD4+fWxASk550dCerQNRANDzF/90nPghcXLip9oXHy0YWx3lcIyHVZYoru/CjQbRNCfTocInCmrjt0PDkkjG8zFQSenfwljwUmW4hqL5D1E3qr1b
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR06MB6332.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(346002)(396003)(230473577357003)(230922051799003)(230373577357003)(230173577357003)(230273577357003)(186009)(64100799003)(451199024)(1800799012)(966005)(6486002)(6512007)(6506007)(26005)(53546011)(2616005)(71200400001)(36756003)(38100700002)(86362001)(122000001)(31696002)(38070700009)(41300700001)(478600001)(921011)(4326008)(8676002)(8936002)(5660300002)(31686004)(4744005)(7416002)(2906002)(45080400002)(91956017)(110136005)(316002)(64756008)(54906003)(66446008)(66556008)(66476007)(76116006)(66946007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q09kTEZZNXAxR2Rha1doMHlra1RMWERWSnRHOTRKOWlLMnJuUFN0THZQcSsw?=
 =?utf-8?B?RlNwUGQ0cmVOSExteHpXM1pqU1FRU2d1eHhlbkdOZUpobVQ3SjZQakJpTExD?=
 =?utf-8?B?bm15dE52STJCdkN5MUY0QWF6Y2dWQmxweHJZcU13RVYrbndBZGl0bC9KUDlC?=
 =?utf-8?B?NkdRazZObXhaempJMXAxRHdPV1JjQUc2YU1PY2lxM3UzZE5XQUVSdE5BalBw?=
 =?utf-8?B?QW9qYkt2MUNJUFBTcXl4RUJvVndLK0REZHU0blVDakhJSy9sTG5Wd1RRWENB?=
 =?utf-8?B?KzhaNkp2QWo5cUJkajBrdGM5Q0FoYTN0NFZsam1LdHZQV3FVem1udlg4NEdV?=
 =?utf-8?B?YTgyK041dTV6TWRTc2FPZnpBTUY5TmNmZUk2R09PdWJtZDcrdXRSdU05ci9S?=
 =?utf-8?B?WVlLV1hiSFBRclVsYU1XSURER2VnWVNIMXRWVHk3MmJHQ1lOdjk2WFY0NjdX?=
 =?utf-8?B?aEJLd3Y1czY1aFZDZUNXVDh1MThrMDJuT3ZBcC9uN1JLSFZIRWk2bDQrN0p0?=
 =?utf-8?B?alV2NnM3VmsrYkFRY1l4aFMreWFneTBTTnlnaWxOUGVBcTRxemlhUkNLQkJN?=
 =?utf-8?B?TTJKcGMrbnRMOGpBUW1vMUJIbnZYY1hsODh6M09qbTlhREJpV3BNaEZKbnJJ?=
 =?utf-8?B?bFREQ1VrVGhjQkhjaTdaOWpvOU9BbUdWQ0JqR3RBem80N2lnKy84WVIxOUZu?=
 =?utf-8?B?d1NMNHQ3TjFkaHJteDJTYlNab09RK2tpVTI3RlI4NkpLazdlcEJvbGR3YTAr?=
 =?utf-8?B?MzV4Z2E0SURwdVE5YTJtT0RYK2VieWMrZWxhSWRYNUxnV2NsaFpuNVpCOVRL?=
 =?utf-8?B?VHBWaWxOSTdyemV1OHljbVAyZGVBSGRwUGxTUk0vV3h5YlRodG9EY2xGd0dT?=
 =?utf-8?B?SE9wVGlKM2ZqS2YwaFVLV1krampsNEFpQTFISkJoYktDWnZUK3l5dmhWSUgx?=
 =?utf-8?B?SWN1RmFqemJnQXhiY2p5T1FOeXJQUGN3NzBjOWVBSGt5dFBNcTNWd1A5VXNR?=
 =?utf-8?B?SUhvZ2xlN2JvRW1RelRsVjBSQ3NKa1ErQ3ZOcGw1Wkk1V2twNzkzN0xNc3Yr?=
 =?utf-8?B?eG42b3lJeFRZSlU1NjZkTHV0bnhVNlFaTkZVYTRKYkd4VWxtbXFoUlNnVjUr?=
 =?utf-8?B?Q2wwT2hOVStRbGYybXVoSUpNMlJrdlBkeHh1dThLbFJpeGMzaVY5QWRVNFRJ?=
 =?utf-8?B?RmJMTE9xTjNWSXFuV1RnVEJReEsvdXJDT1BUdjMxc2tvSjl6M3VwMW1WWnJP?=
 =?utf-8?B?bWx6dXJLNURtMXlxZ3VRQko1ZXRKaWJURWl3U3VmbG9NSTNRdzIwNGRaWUNm?=
 =?utf-8?B?bGFnRDloN0RRNENrRTg0TmsyN2R2V1NPaXNzanJGOUxNMGc4MDkyK1hSbXd2?=
 =?utf-8?B?WkFxRWZsNFZiK2JRdXozemRjTjR0OC80bm5hNlF1WEVMNkFlbEJKWFpyTmtM?=
 =?utf-8?B?ZmJvZFRacGNJTGZEUDVSTkFVcUQ5QkE5MEJHNDBpM2hRcHJJeFJTUGFCODJB?=
 =?utf-8?B?OFRxZC9acU0zZnFRRnNTNlNmeTIxd1VqTWZGMk8wYzlwQzNsNTQvZjhyRHdm?=
 =?utf-8?B?MW9FTm85dCt6YmVjWXJzUmVYSnl5Q21NNkt6SHg5TFZ5RStzMUZQUUJKY3lL?=
 =?utf-8?B?UG51UitwUWJUQ1dFb0Q1S3V2djcyMEgxYlFZSEJPT1NnRXRpazk0RFJEUGlx?=
 =?utf-8?B?bVhwcFRSay9TcXpXSnRoOVpPamFNQkprWTlTT1RoR0x2OVlmdXIwZUUrYlBh?=
 =?utf-8?B?U1pPV0JxMlNRS1hrMW5oaWErRzlFTUppNFduNURQdFFLZFNhK0VyM1I3THBD?=
 =?utf-8?B?Y2pzL3h4M3lkTjJaRGE2WkRtMHZqZXJsRzZXeUZuS0t1Wmk2enh1VW5hRk5J?=
 =?utf-8?B?WlBLVkhkVlI4UGh4WWpBeHdFUlV3T2tCa2h5MHZ3V2FrQ0hmY20weWtzbzQz?=
 =?utf-8?B?d25oYlBuSUp1eDRpQjRFWG95eXpQTTFvQjhROWpROW9TSGRHRTRMODMyaDNr?=
 =?utf-8?B?dzVSakwrRHJQK2Yyd1dmT2h0OWpUbjJkRjlZYnMyVHB5RU8vZ2tPWEJuYksr?=
 =?utf-8?B?bzRoMVlNd2F3OVg3eHhYV01OUUhzL2lyS3ovSm93RFRZWFFhSklTVEs5V21v?=
 =?utf-8?B?MnlraElCMUFsTFpvaDdOTmNhbXZodVRUeFpqZllkRVIyMnRhSTV6YzhGOEl1?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8729EC620BBDC24AA54C716F831959B8@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR06MB6332.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fa7bb5-bc23-478e-6a41-08dc135d3397
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 10:56:59.7946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7rPjzTKXuygp6yT5E25g/QPifA7/MzV4m20eQ6SSF2pbNbZ3+A3XmiY6sU0QmfZpbmejydNuqKxK13bGFyBN4yRL5OUHQWsYrztSL3XEFuz587kW1ndoJxTHUB22ggvr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB8910

T24gMTEuMDEuMjQgMTg6MjEsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IFtZb3UgZG9u
J3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20ga3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnLiBM
ZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNl
bmRlcklkZW50aWZpY2F0aW9uIF0NCj4NCj4gVGhpcyBlbWFpbCBpcyBub3QgZnJvbSBIZXhhZ29u
4oCZcyBPZmZpY2UgMzY1IGluc3RhbmNlLiBQbGVhc2UgYmUgY2FyZWZ1bCB3aGlsZSBjbGlja2lu
ZyBsaW5rcywgb3BlbmluZyBhdHRhY2htZW50cywgb3IgcmVwbHlpbmcgdG8gdGhpcyBlbWFpbC4N
Cj4NCj4NCj4gT24gMTEvMDEvMjAyNCAxNzoxOSwgQ2F0YWxpbiBQb3Blc2N1IHdyb3RlOg0KPj4g
QWRkIHByb3BlcnR5IHRpLGNmZy1kYWMtcGx1cyB0byBhbGxvdyBmb3Igdm9sdGFnZSB0dW5pbmcN
Cj4+IG9mIGxvZ2ljYWwgbGV2ZWwgKzEgb2YgdGhlIE1MVC0zIGVuY29kZWQgZGF0YS4NCj4+DQo+
IFBsZWFzZSBzcXVhc2ggaXQgd2l0aCBwcmV2aW91cyBwYXRjaC4NCk9LDQo+DQo+IEJlc3QgcmVn
YXJkcywNCj4gS3J6eXN6dG9mDQo+DQoNCg==

