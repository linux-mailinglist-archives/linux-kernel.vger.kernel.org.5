Return-Path: <linux-kernel+bounces-7728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E80A81AC42
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E92FB2489D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A74A1FA0;
	Thu, 21 Dec 2023 01:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B1zuYYfy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AB323A5;
	Thu, 21 Dec 2023 01:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Op/dZ1/CY+sf+ngDR8U6lIsnUTyiqV05ja4thxhl8XOapCv0j+O1YOlePDcsjHZFLzT0Xl1SMHSU5f+JV+wmNT6ShFNI5wy9O6zxxBtuJkKKxPHmrea+rqeNsJSb79h42rkqoWlKso2WnVfJPefSxR/Rw5GbHeA3eNQAsc2rDmuag3iSVWBz7W6Lfem9svGJPrn6rsMhSL5S5EfGJbWrpdr0UzPu5fGjwVfQmIM/2PK/xTEFplL+vfbKRDRx87egC8x+jKKFrv3Gb0eGCTeSpq7XEZm/6UBTT4tYREyIxufV2uBaL0toz4d1m5M8+n50WOF+c52/KPNzYMLAZt1t1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bB9xouCOaJLzesUK1vRoFTb3UKZO8jw9S0hezwozfgw=;
 b=ATgiGzKxlHGwNVTNXpGo28eY5mhBYrK4XnQj+gIsbaxU60j1G/X51Pab4rX3mRIMO1C7aIsHdV5tZkIVyn5I4wI8wDWM2p77+ebPU4UVFk/Vb4U58NKjytrVLK7vBWBYdz9cuow4tTHMX6re/OIssS/vKUziyeHvF2c/i1fzZ1DmOmn4m1GY6+0zApvmfIEGWGUwW+JodzE7+3TdnPo26Ly0PRR+2YGwucWKNJHnSywnLQsNswCAOm9gR4073YSc4+TPUczVgoXfgN3IuqMDl9bOAwtfdKWaEEF/2dgaNeN9t8GF5GDcd4ebIo2tU9R/X1QnQFThyy4srXSz+nXjAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bB9xouCOaJLzesUK1vRoFTb3UKZO8jw9S0hezwozfgw=;
 b=B1zuYYfyx1lFt3smUMOQr1AtyvVn+LGTOlhXSg81AUCK26U3+NCQ73Bj4jruan+KK5670YZs95EpRlfQGqA7WgVDVVmoovVjzkVv5IeAvIeH4LVMjzUctFZqGC8/CLxuIZrO4Ior+3rb/1rjKjh/qTXTDYWdS6KMWK+YBLsdMpc=
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by AM9PR04MB8795.eurprd04.prod.outlook.com (2603:10a6:20b:40a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 01:34:55 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::1f29:340e:75ac:d14a]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::1f29:340e:75ac:d14a%7]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 01:34:55 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, kernel test robot <lkp@intel.com>, Dan Carpenter
	<error27@gmail.com>
Subject: RE: [EXT] Re: [PATCH] wifi: mwifiex: fix uninitialized firmware_stat
Thread-Topic: [EXT] Re: [PATCH] wifi: mwifiex: fix uninitialized firmware_stat
Thread-Index: AQHaMyNDm6C8sypSXkiQD8E90uHiOrCyyxCAgAAqPVA=
Date: Thu, 21 Dec 2023 01:34:54 +0000
Message-ID:
 <DU0PR04MB963668D2E2308B467EB188D5D195A@DU0PR04MB9636.eurprd04.prod.outlook.com>
References: <20231220090135.1028991-1-yu-hao.lin@nxp.com>
 <452a71aa-1e66-479c-bd68-f5ef7b409ade@quicinc.com>
In-Reply-To: <452a71aa-1e66-479c-bd68-f5ef7b409ade@quicinc.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9636:EE_|AM9PR04MB8795:EE_
x-ms-office365-filtering-correlation-id: 41d7a883-d916-42e0-71d4-08dc01c508f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Z5+Ji1tAvPcLTdEdfXmHlBVUFookeU3kQzMlctvKyx5r3w2NeEZLtSFHoDEBpxkmHfe0HVbrBEFqgqQxa7PknS6YI036rVl20NwjirEoCbbjEIpv9VdJXAsf1a1Pinv23PEN4dyYcgPlZPFFdua9kXtIeD6K/XAfIZUp8Qm4I7qm0ydzBo1YDqgxpc08xF02EVSbp+Omk8ATvCjHQkpXrD8yZKbgv+GA7RboP/Kr8VXYyVSjjBcgRPZvWoLk9oOndlEP+m9NEfcQG49FdgAVkjwFyJb3sdH568droXeOSpZV7lwv3s4wQBy2LEvY26j+JFwgBFL0VjAoz7lW7YGy/bsFG2h61y2u2wsAKF0MZAv6U1UORNtBARabWVKUILA2bGeg07Q7cb2khfLa6j5iHnyq6UfFb0w1jlgQVggmBlRJyvZNEcRGw2xvqTAHQzrZHWVlvDtMhKWyspte+knpM/Ghwsrb4v4ESAuA6ZdAZz8qU75tV0XSjbjBCiBYdqZwQ0a8ceWxzAZkV5Xx0MxW3w9aA3VjKFTDCwPssatXM3BeM75FDYg3zkylAGcyT68eCiKilJWGXD7taxV1dOvipU/ofbqoM1ilgDEdB5L8WGM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9636.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(38070700009)(8676002)(5660300002)(71200400001)(4326008)(8936002)(26005)(4744005)(2906002)(52536014)(53546011)(54906003)(64756008)(316002)(66556008)(66446008)(110136005)(66476007)(66946007)(9686003)(76116006)(7696005)(6506007)(122000001)(478600001)(41300700001)(55016003)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T29uaEhGbWRvK3BrWC9ld3kvUFM0NmMzNVh6T0JHVC8zYXJ1SDZxK09OTldM?=
 =?utf-8?B?S2MwdzlBdlJ0ekREblNGdmUxK2lQZnZudVRFOHBoRVh1R1hBMDh2SDNuZE9p?=
 =?utf-8?B?Y1NkNDRVL3VjaGJlRFpEcGxXKy9hVjQzcklOVUhRazJJQ3ZxMHRtV3BsaG9N?=
 =?utf-8?B?TlpzVEhnR0lhdDFJODZNUkVXVnlnY1Q5RCtrREdYZ2tpbHNoOTh3TTVmUTF3?=
 =?utf-8?B?MUNleXV0RlR5b25wTmRSOWtaV0xla3pVbUNNRHE3WXlNUGpaWFFQdXJtbVpQ?=
 =?utf-8?B?T2FwWjAyTjJBR1U0OCtYa3dmVVR3OXVPenNQcFdDMEsyNjAzS0ZjdDBmSmU5?=
 =?utf-8?B?L2RxWHN3VEJxYnhYMHM1UmpMUWtRVmwwVHVZaUF4MDhTSGFxRVROOTdvbGlB?=
 =?utf-8?B?WUVlS2VIUy9wOEtrRkRqYjZEQmFveW9Ka0Y2K3E4d0htYzdkdHUxbk9WQTFP?=
 =?utf-8?B?RkMzRU1vKzNBMFZ5QlJFc2xIU096QVRIN3pxU2g1Rmdsb1ByRXNzbDdkK1BG?=
 =?utf-8?B?bXFrMlpaemRxYlVtelljTHNYY1BZKzNnVDVtYXR1OVdmdVF0eTVXVzVyYmhw?=
 =?utf-8?B?SWdDcVdwUW4veUJ5V3Q4WHNzVkdRckRMb1FzR2gvdmZ5RzhPOVAraGQreHZC?=
 =?utf-8?B?eHBnUHBLRnR6QUVaM1plRlA4SVBvL0diZld0NE84dUtWNTFsM0Q3N01JRFNq?=
 =?utf-8?B?aGE5R1VYY01QMjJlNmlwc2xqK21laFNtTG51SFdhVnF2SmQxaUdvNWVzcFRW?=
 =?utf-8?B?aFNadEpVZC9vZGp4SktmZW9vOXlrWHlpOUJGN1NVVHp6VE4rbGFReC95OU5t?=
 =?utf-8?B?bGFwZkZ3bXZVcVRQMlVXVndTaHlKa2ZST1pSVGM4VzIrNVdVMzVrbWJsNGR2?=
 =?utf-8?B?Q0wxZVM1S0NjMStzMEpzZ3pNNmRvYTVzMXpoMWNlV1k4Um1idU80QUVTcW5R?=
 =?utf-8?B?QnV3M0NNUjZUdVVRb3MwSmY1L1RZbkh0NUlrSGNiemNIdmpqTUtYaHhsNWlt?=
 =?utf-8?B?ZjErSFU2eDhZWHBIbzlUSmtHY3NndGZTKzN0eXd5THdIYWtJbndBdFlCc2g2?=
 =?utf-8?B?RGJqQXl0c3ROOE0yaWxMSC9Lc1N6TktkbDdEbW0zaU1EbENOM3FmeStDN2VR?=
 =?utf-8?B?VHcxUTkzeWdjaThnSDMwTGdsanJUK3hPZlpFVy9ZUDFSTktvY3NNUTNBY2lz?=
 =?utf-8?B?SGlHWFE1Yit2Q2RxTU5XMktFRGgzdk9aRnA4VmlPTWt2UDQ5Mm92RTY4ZFE5?=
 =?utf-8?B?RWg1cUxFeG8vMEFuMVFkNUNGUnNKSTlsMGJ3L2w3WUoyK1ZUL2NyNDBDZzVV?=
 =?utf-8?B?RmJEb0FzQi9YeVYrdE9WYTVOVTRHUjRQV1ZNLzJtclkxYjZ2MEthaW5OUFhi?=
 =?utf-8?B?WDNHeXZCWWtEVHk3YmRlakwwRnNnZXJXUkNuMWZQNXFqQUNJanM5MVdOYytl?=
 =?utf-8?B?T3JlS2lOeExicEtIZHBTN1FtN3RuNUhyTVNHT3ZZVWMrKzdTa3hwMXI2a2Fl?=
 =?utf-8?B?dXM3SDJzQkoxancwazM4eGEyblZ1d1g2UUxldWxDQTdRM3Njek5xVEdvOE1C?=
 =?utf-8?B?OHVheDlMZTR1SW9JME4xb1VNL0kvaW9kaXBTeTYrM0FEYXdlcWRYUUx6REZz?=
 =?utf-8?B?SkdPeUxHOVBMYTI2aHdaTzlUS3pvbHNCZWVUendOcW9xNHBsM0QvZjZaRGJR?=
 =?utf-8?B?ZEpxdjkxaER6SFl2ZnBOUGd0a1RRN1dONWZjbm1mWXNPdk5TczMzSjMyTFEw?=
 =?utf-8?B?NXdtU3RvUG9pRlN0SWw3Wlo4TXpMNkpJa2IrQjhaU3VCWk9XZHhjNEpCTSsw?=
 =?utf-8?B?TVFNRDhNYnBEZzBpWlBXV0dsMW5VMFlmN3dwM25KRTRuQWM2eE4vZTV3ZzNn?=
 =?utf-8?B?eDRZb1ZMd3U0cHNFTUVZbHVtSzJhdlR5UHFpZWNsckFvRHN2TDVyOEpZNUJL?=
 =?utf-8?B?bzVwbFJObjRqNVBkZWZybDZRRDVCOVpWanBmNXdaNE12SlBxN3JheFVHdmt6?=
 =?utf-8?B?RlpFUHVXTDR0T2xhbWFxcWpyd2U4dVdFd3JNSTRIb2pMVHVRNjhqQmw5QVRP?=
 =?utf-8?B?RU1Xam1mZ0J4Rlhsc0xRYmdRRFU1b09PamM2aUVYc2RjS0JQOTNqV1NZK1Mv?=
 =?utf-8?Q?apvhPfCNpcfn9H/QHhD6/siSx?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d7a883-d916-42e0-71d4-08dc01c508f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 01:34:54.9767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TDEiL/3pJKFkb+usuu+I/A8GSsyPF1eRPkJDISavHi1qfmpgimTYmhPXffjc8C/h787MP3j3xklUUJmeERVZ9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8795

PiBGcm9tOiBKZWZmIEpvaG5zb24gPHF1aWNfampvaG5zb25AcXVpY2luYy5jb20+DQo+IFNlbnQ6
IFRodXJzZGF5LCBEZWNlbWJlciAyMSwgMjAyMyA3OjAzIEFNDQo+IFRvOiBEYXZpZCBMaW4gPHl1
LWhhby5saW5AbnhwLmNvbT47IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzog
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgYnJpYW5ub3JyaXNAY2hyb21pdW0ub3JnOw0K
PiBrdmFsb0BrZXJuZWwub3JnOyBmcmFuY2VzY29AZG9sY2luaS5pdDsgUGV0ZSBIc2llaA0KPiA8
dHN1bmctaHNpZW4uaHNpZWhAbnhwLmNvbT47IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5l
bCB0ZXN0IHJvYm90DQo+IDxsa3BAaW50ZWwuY29tPjsgRGFuIENhcnBlbnRlciA8ZXJyb3IyN0Bn
bWFpbC5jb20+DQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0hdIHdpZmk6IG13aWZpZXg6IGZp
eCB1bmluaXRpYWxpemVkIGZpcm13YXJlX3N0YXQNCj4gDQo+IE9uIDEyLzIwLzIwMjMgMTowMSBB
TSwgRGF2aWQgTGluIHdyb3RlOg0KPiA+IFZhcmlhYmxlIGZpcm13YXJlX3N0YXQgaXMgcG9zc2ls
YmUgdG8gYmUgdXNlZCB3aXRob3V0IGluaXRpYWxpemF0aW9uLg0KPiANCj4gcy9wb3NzaWxiZSAv
cG9zc2libGUgLw0KPiANCj4gS2FsbGUgY2FuIHByb2JhYmx5IGZpeCB3aGVuIGhlIHBpY2tzIGl0
IHVwDQoNCg0KU29ycnkuIFRoYW5rcyBmb3IgeW91ciBjb3JyZWN0aW9uLg0K

