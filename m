Return-Path: <linux-kernel+bounces-98501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DAE877AFF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 07:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6FE1F219F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069AAFC17;
	Mon, 11 Mar 2024 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="FhzeL4NM"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5E563AE;
	Mon, 11 Mar 2024 06:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710139291; cv=fail; b=cQeDuHBsr4ZbUMuoRskAwZia1qXoUcHpGytV7mzXcaOa7WHfytxmzkyUSPmIgfVT0A549c6aQMeJl5PVMTtatSbNeBJJEh32getI8hffUqzMt+LWggJxVl0Gkv3m9+M0hGGErpvHLCC1EXjv5JERJQtll/wby6CBKYgDTAb6myg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710139291; c=relaxed/simple;
	bh=/WOOmEyb9ynjiL/bY8fI5FVjl4DWKFkt+Z7C7RlXq+o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LHL0QE2fvQiegrrbuQO3QOykfGx2rzOJ4Fvt8GoYx9BgZlld2rIrdUkrW7o2EXZUgjdPjg9hRrilnorvJ33JXqeWIzEJronJ/WAZq27jDHUfAZphBv/0Ax1eUMqPAmCbqbdf/dZKFGq5g4zcd8jJ0TwlN6lNEXR77kMe4jOmCTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=FhzeL4NM; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B4CwAb025637;
	Sun, 10 Mar 2024 23:41:22 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wstqrraxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Mar 2024 23:41:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hw1CRmDPk8IeBs7eMZ5Ns63kOTnuBq7ea2NvMy3UpCQTOPmT7XSaA4dchdm3IV8XE63yFPvg1NAiT+kuihSZyX8bM78Hzoac599V0EnJ5p6HxUCK3tnguIG1AoNtN76kyluCpXf0ORs/w3LbZZJyC8xW8EecZjM5dRuH9AgJbXGWT9uKYu0qBcVw4mN0PJYKHS6Gik1xHXBjmnC2bMz68Diey4mYHD0+c4BVT5DnwHEJuaXSjV+Jyfzh7e8KaqE5vvfG6rw46G6yU9K2DPZ+GQLXgZQs+7JtAxkLGjydFI+EG0COnQxJ7gxzzXAUf2b7e098sqvB3AdGhQ3msMXt5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WOOmEyb9ynjiL/bY8fI5FVjl4DWKFkt+Z7C7RlXq+o=;
 b=arZaEqkArzQk01fpt/xwpJmPiOWAaugBrI7P52SYEHSdo9RRgAx31xZ+XiY9n3bfVbZ6bW9FkQJe/bXoZNANraWnystRykO0I4rVkoLnt/6PgInH1n8VfAQpSvV0RLEilAY/FnFpgcNgiuAvS46swDeVFlPlk0NQP2++/xMBrkybxyPQwLsnFm8lHflT8cu2SZ1skHodLPmPJXLdG7YYcnVo6bdXLJbM11cMOoOEMoELdcbweAUUPVw6YAR+MgD7h8RZ46gH7LK2B1bdGsvcXygBOzhp5wXadoesPTKjhVqL3mpMuwP30KfhQFf5xYvKF0p9pFTbU4+hwlLkhxAzqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WOOmEyb9ynjiL/bY8fI5FVjl4DWKFkt+Z7C7RlXq+o=;
 b=FhzeL4NMyUH2EPgL/2miSHpkNtowUUhxEPItH8m2k5C8avU311FNePPmW9LW1rH8rYopIX6k7Elo6BV49YfGgM6lznHISATWPOggL6PyqRgR3gXhdK1ZYe7eE+FGF1+dHskZRE7JVtPPXP7HfdSVYnk5RIVJI5MSd9hRzc+Hkjc=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by BY1PR18MB5894.namprd18.prod.outlook.com (2603:10b6:a03:4b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 06:41:20 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::63c7:9f21:b131:6a06]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::63c7:9f21:b131:6a06%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 06:41:19 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Eric Dumazet <edumazet@google.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net PATCH] octeontx2-pf: Do not use HW TSO when
 gso_size < 16bytes
Thread-Topic: [EXTERNAL] Re: [net PATCH] octeontx2-pf: Do not use HW TSO when
 gso_size < 16bytes
Thread-Index: AQHacU/MW2tE8ie+6EmoX3HxMLA8irEt3siAgAQ68vA=
Date: Mon, 11 Mar 2024 06:41:19 +0000
Message-ID: 
 <CH0PR18MB4339B68DAA633514792C701DCD242@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240308115722.14671-1-gakula@marvell.com>
 <CANn89iJ2euG8SgmTpifRK2DV1N+PSPAgiSoZP-W+7YWE3Ygv6w@mail.gmail.com>
In-Reply-To: 
 <CANn89iJ2euG8SgmTpifRK2DV1N+PSPAgiSoZP-W+7YWE3Ygv6w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|BY1PR18MB5894:EE_
x-ms-office365-filtering-correlation-id: b8b64713-de40-424c-ba1f-08dc41964281
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 jGCe1Sy8eaOL7VyY2l5AOkP41MqSXWev5tPPX9j3LOMZCfuTAhcr9P8N31HGmtV96wC4nAfQHlvVThJyXkjs+jmrDR5d57klYaPicVJX6Cg2mkkZLq1KqtwpYp+KU65dsCZBfbJP4scKi6TmWJLDLhKq5xbWQ11FrOR8BX7q6vIDTzvSP8Qk0sycNRCeBYewAbl/GuS4nnT9Z+G8zb6rlrnk3eb6NF+hHcq7ISY1Vc/x0BlTHOwyOR3dx3N9T+H456dLtW9QAG6Yn57a24WLcgJBbsxgCHtRxt9K3UD/G7F5qWHhwvbRJyk1oGi72fRWuo7tMM0OSkhVyzvfAbMUCwQX3dqIy/jrWsuN4rZw8Ouch1EEribBr0d3MJCtXQQ8uvN3g7tKh0w4GhEpJADfy5sKC2DMATss4F2nwJmGgl0aabjK9RITBBznErrxMEiKkT75HbloUiuww63pLNm8KH6RBzFFDNAXZQGVVElKmi+cMTp0MSQxCkHFWijKfSXY+onpMHSTiIEn5amWQUD1JZQueFd7JsNQSUmEqs08xlx/eWhPUaOmorUH8/Iw0jgpFgU/tYo4JCTz/PCVR2JAXiNDDUiHiX8NW3VePgRwQbLdJzQJf/zs3Ng1qxqhL6gtpk5Y/dP3NMl/lZngiPR97pdKtk6/POmGpEQtBIVReb37oT2ibV8+j4eYV0LQmJuYuPCb56B2GdO5Jnoz1xDkHA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?M0xmZ0xGZlMxdXBsbFkvSDd2dVJBcUszUjNEaUYrOTJxbGNRM0x1WmRDaC83?=
 =?utf-8?B?NXB6MDZVNWhuVnFzWmlQNFZWdEw1elNtN0ZkQ1pJamhKWEZPVjVubFJ4SUNY?=
 =?utf-8?B?RzFtSTB3ajBKVHJUaDR6aUZPWXQ3VVNVZjZrREozMlpMWEF5ZDM2QU1SRmkx?=
 =?utf-8?B?bFQ0bVdHOGZodFIzbmdRV1BPZGZVZ2ZudjNHMEE0TjR6eEtZNVFtNGp1Vzcv?=
 =?utf-8?B?RGNlQ3FnZjBBVnZkUVdNamF3NmhhWWMyYUhGVTBZQ09oVVBtYXVXYlorZHVi?=
 =?utf-8?B?c3hqTCtEeGNZTS9GaHFSOE1xMDRkRzhoSG5kdnpwd1VwNGVMR0dRR0Nvbyts?=
 =?utf-8?B?SDEzZFo2Z2Y0Ym9oWTB1c2hPMkhqVGJ1Vkp2M1B4RnF0K05Dc1ZNR1o5b1ZR?=
 =?utf-8?B?M1V2YjZ2OE9YZ3YxQzZvRWdIYzRvQXQvYXJWc1lsSllyREQ4Kzh1RWo3ZFNF?=
 =?utf-8?B?a2hjeUppUzF6bmNMek1DZGhXWmY5OWxIUlkwbTFGOE5peW9QMU81aHRPbXpK?=
 =?utf-8?B?ejFWeC9xS0tSVTVCUkdQd0ZHMnNvY1gxUmtqTjI4M3BndVFTWWIzK2VuRlBJ?=
 =?utf-8?B?c1p0STh6bjkxZU9kM2VlQWRJdmsvbGRhYWRFeUVCNkxGWkVCYkRrbkFqSlBt?=
 =?utf-8?B?bjBsMWplWXpWQmduNGN2OVBGY0ZUY0FGQXdjbDRjaGpSV0ZmTXVBckIzRzU4?=
 =?utf-8?B?bVRCWDAxaUZ6Rmt3QSswTmVJbVZuWlR4UzlmcHI3aFZGemVGODN5eEE3VXY2?=
 =?utf-8?B?VzQxUUVMZHVuM0pNM013T082TlRGejlWSGZPcTI1TUd6THRCNkRHZDllM2Z0?=
 =?utf-8?B?aHBpM3duVkd2dEZxTHl6MDNqd1lSbUtkVTdJZ2RobnpBNVpZSTBiK2dtdlZL?=
 =?utf-8?B?WXVJd2tPclE2NmIrNFlCQzViYWxpTERpenl2ekphM2RMeUUwYW9RRVNsdW80?=
 =?utf-8?B?NzJNNUFabitrRGMrMzhJNkVvK0xMOWdjQWxPR0FlZTlFNzNseE1nNHlXY2JF?=
 =?utf-8?B?RmlsY1RPTW9xVnI1b2FTeXVqTEpvMzI5ZnY4Rm9RQ0NMU1hkeXpuc0xiTHkx?=
 =?utf-8?B?aDRyRVZ4cEprZDdGZDRtQWNmVkxSTUFzc3hNOHV2cUhQK3lreUp6QmRMeGpY?=
 =?utf-8?B?MHpINTNpSUJFT3JGaS9IdCs5VWhVSG5CbCtaRlYxNU5obDNkdk5BWHZvZkI3?=
 =?utf-8?B?aXpiaHdaRVord2RIQStwaEJFV080NHY4WjExeWRaT1p1RmVaN1JzYUpLREVx?=
 =?utf-8?B?VmF5NHpXS2JTTDZyVU0rd2JMbEtDbWFMbVhKeTk3VEdsckw0TFdxZ1MvTm92?=
 =?utf-8?B?Z3h5UGNOZ0hMb1ZpVDRHNlNkVjhPTC9tZlJOK3hNR0VUd1hPN3dVblV1VkpF?=
 =?utf-8?B?ODBNQjIwUjYvbzFQY2U1TGhPNkEzMU9kU3Q5M1h0YzhUelJYUXpWUzRjWXJu?=
 =?utf-8?B?Vy85cTVyaDRzN2ZITDlvWUMxY0xXNElGYUNNN1MrVDMzRzJaR2pvNVQ0MmlH?=
 =?utf-8?B?aHJYWGV0UkpSU2NwaDFVWUlwenRsM1ZBeGdscXJUMkJOVlBJOHd5QVMwamg4?=
 =?utf-8?B?MEhYb3ZIR25XOUh0N1RjRWd2MGJpai90a1NMNDkyVGZRMnhPNjUwOGZDUC92?=
 =?utf-8?B?dkt5NjFFOERBTTdLRVlOTmMreFpuM2IzRFQ4cE83SlV1VExPOHhNWjVRVzVv?=
 =?utf-8?B?bGpTNkRVTEEwN3RKOTA5ZWRucElqMDJweU9Uc3hUUi9malhBQmUxNXc5eTlI?=
 =?utf-8?B?ckxjbFRTZHdodmprRmdvVEZXcmwvWnU1TFFMc0M0a1YydEp2WkRkS1F0SGtZ?=
 =?utf-8?B?L0o0Y2NKOWdHcGFhbFlnTm9TRkxjTHhuTEVPMFc2bEM1UDRJR3g2KzM2SFo0?=
 =?utf-8?B?clE3ZjNkNXhjOUZRTUVzdFNIYkprbUtqVUJsVllxdysyUFpjSHJHQU51aUY0?=
 =?utf-8?B?MTViTllJTnZDdVVUTFF2UHdLRkdlSzBibkZtNXpZcHc0N2FzeEpMOUUxM2VL?=
 =?utf-8?B?eWtMQmdkeDZyL3ZqV2tpZktSMmhDYzNhQmh5d0xtd1lmZmhNQVBWZ1YxWTA5?=
 =?utf-8?B?aUZLMndPL09wajE3Zm9kSG1jRC9nM0dGeHZFOTBySzFvOUhseGJWL3JVWlR2?=
 =?utf-8?Q?kVcc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b64713-de40-424c-ba1f-08dc41964281
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 06:41:19.5868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oDqiRZCmLCE+2CP9xCg9eZncEpp6DoczwJ0c7pcC0EtLFri4Xn4OZRwWyCXra2DKkijy3y7+Ywbq/qIagkkRBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB5894
X-Proofpoint-ORIG-GUID: Ev33ErXZGZ0VtuERGTcVPW23yDOL0TrU
X-Proofpoint-GUID: Ev33ErXZGZ0VtuERGTcVPW23yDOL0TrU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_03,2024-03-06_01,2023-05-22_02

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBEdW1hemV0IDxl
ZHVtYXpldEBnb29nbGUuY29tPg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDgsIDIwMjQgNzoyOSBQ
TQ0KPiBUbzogR2VldGhhc293amFueWEgQWt1bGEgPGdha3VsYUBtYXJ2ZWxsLmNvbT4NCj4gQ2M6
IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGt1
YmFAa2VybmVsLm9yZzsNCj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgcGFiZW5pQHJlZGhhdC5jb207
IFN1bmlsIEtvdnZ1cmkgR291dGhhbQ0KPiA8c2dvdXRoYW1AbWFydmVsbC5jb20+OyBTdWJiYXJh
eWEgU3VuZGVlcCBCaGF0dGENCj4gPHNiaGF0dGFAbWFydmVsbC5jb20+OyBIYXJpcHJhc2FkIEtl
bGFtIDxoa2VsYW1AbWFydmVsbC5jb20+DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtuZXQg
UEFUQ0hdIG9jdGVvbnR4Mi1wZjogRG8gbm90IHVzZSBIVyBUU08gd2hlbg0KPiBnc29fc2l6ZSA8
IDE2Ynl0ZXMNCj4gT24gRnJpLCBNYXIgOCwgMjAyNCBhdCAxMjo1N+KAr1BNIEdlZXRoYSBzb3dq
YW55YSA8Z2FrdWxhQG1hcnZlbGwuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IEhhcmR3YXJlIGRv
ZXNuJ3Qgc3VwcG9ydCBwYWNrZXQgc2VnbWVudGF0aW9uIHdoZW4gc2VnbWVudCBzaXplIGlzIDwg
MTYNCj4gPiBieXRlcy4gSGVuY2UgYWRkIGFuIGFkZGl0aW9uYWwgY2hlY2sgYW5kIHVzZSBTVyBz
ZWdtZW50YXRpb24gaW4gc3VjaA0KPiA+IGNhc2UuDQo+ID4NCj4gPiBGaXhlczogODZkNzQ3NjA3
OGI4ICgib2N0ZW9udHgyLXBmOiBUQ1Agc2VnbWVudGF0aW9uIG9mZmxvYWQgc3VwcG9ydCIpLg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEdlZXRoYSBzb3dqYW55YSA8Z2FrdWxhQG1hcnZlbGwuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMv
b3R4Ml90eHJ4LmMgfCA3ICsrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwv
b2N0ZW9udHgyL25pYy9vdHgyX3R4cnguYw0KPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFy
dmVsbC9vY3Rlb250eDIvbmljL290eDJfdHhyeC5jDQo+ID4gaW5kZXggZjgyOGQzMjczN2FmLi4y
YWM1NmFiYjNhMGUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVs
bC9vY3Rlb250eDIvbmljL290eDJfdHhyeC5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfdHhyeC5jDQo+ID4gQEAgLTk2Nyw2ICs5Njcs
MTMgQEAgc3RhdGljIGJvb2wgaXNfaHdfdHNvX3N1cHBvcnRlZChzdHJ1Y3Qgb3R4Ml9uaWMNCj4g
PiAqcGZ2ZiwgIHsNCj4gPiAgICAgICAgIGludCBwYXlsb2FkX2xlbiwgbGFzdF9zZWdfc2l6ZTsN
Cj4gPg0KPiA+ICsgICAgICAgLyogRHVlIHRvIGh3IGlzc3VlIHNlZ21lbnQgc2l6ZSBsZXNzIHRo
YW4gMTYgYnl0ZXMNCj4gPiArICAgICAgICAqIGFyZSBub3Qgc3VwcG9ydGVkLiBIZW5jZSBkbyBu
b3Qgb2ZmbG9hZCBzdWNoIFRTTw0KPiA+ICsgICAgICAgICogc2VnbWVudHMuDQo+ID4gKyAgICAg
ICAgKi8NCj4gPiArICAgICAgIGlmIChza2Jfc2hpbmZvKHNrYiktPmdzb19zaXplIDwgMTYpDQo+
ID4gKyAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiArDQo+ID4gICAgICAgICBpZiAo
dGVzdF9iaXQoSFdfVFNPLCAmcGZ2Zi0+aHcuY2FwX2ZsYWcpKQ0KPiA+ICAgICAgICAgICAgICAg
ICByZXR1cm4gdHJ1ZTsNCj4gDQo+IEhvdyBpcyB0aGlzIGRyaXZlciBkb2luZyBTVyBzZWdtZW50
YXRpb24gYXQgdGhpcyBzdGFnZSA/DQo+IA0KPiBZb3UgbWlnaHQgcGVyZm9ybSB0aGlzIGNoZWNr
IGluIG5kb19mZWF0dXJlc19jaGVjaygpIGluc3RlYWQgPw0KPiANCj4gb3R4Ml9zcV9hcHBlbmRf
c2tiKCkgaXMgYWxzbyBmb3JjaW5nIGEgbGluZWFyaXphdGlvbiBpZiBza2Jfc2hpbmZvKHNrYikt
DQo+ID5ucl9mcmFncyA+PSBPVFgyX01BWF9GUkFHU19JTl9TUUUNCj4gDQo+IFRoaXMgaXMgcXVp
dGUgYmFkLCB0aGlzIG9uZSBkZWZpbml0ZWx5IHNob3VsZCB1c2UgbmRvX2ZlYXR1cmVzX2NoZWNr
KCkgdG8gbWFzaw0KPiBORVRJRl9GX0dTT19NQVNLIGZvciBHU08gcGFja2V0cy4NCj4gDQo+IExv
b2sgYXQgdHlwaG9vbl9mZWF0dXJlc19jaGVjaygpIGZvciBhbiBleGFtcGxlLg0KDQpUaGFua3Mg
Zm9yIHRoZSBzdWdnZXN0aW9ucy4gV2lsbCBzdWJtaXQgdjIgd2l0aCBzdWdnZXN0ZWQgY2hhbmdl
cy4NCg==

