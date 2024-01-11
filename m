Return-Path: <linux-kernel+bounces-22928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEEA82A590
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50701C23110
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AE21117;
	Thu, 11 Jan 2024 01:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="fgl+LFAN"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D9010E1;
	Thu, 11 Jan 2024 01:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40B1K3ET031934;
	Wed, 10 Jan 2024 17:32:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=4g17iuoVyV9kR4vJd2tk0/9/pkYvowvPt/T13p5sbyg=; b=
	fgl+LFAN1IdBVu35Od0k93zMOX+IjtaC4OGTCN6KGva3h0eu5hJb8A20GWFhF0ts
	klk5OWjAXM38LeBNrTHUSPNtwzaky76Bmx13R5LYlDgf61lHWVzoD/RsPkwFVkJH
	ZUBt2VWKoSLtcBI2as9HAstI/dMIsHFRdp6skCrmFDKsV1WfjmggSe97TSFJkgeg
	PiVyk+xMN1VIivjdYGbwDqa2Bk/eW2Ere1470qaSiUlLd7/FhJiUJID+hmNHbGxw
	6qA0OdX2z8wPYmJ8DEJJKGZ95NQvfZTV6+aC/fFB+WdIhoDerKApGrstPkO3UdRh
	6j7QP3X1m2tJxXXX/F+hbw==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vf78mcvy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 17:32:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxVgfD2ksgmxQWsZTu1U5g/N9lJK3lSSmMmP2YVgfXq7n0p7cmHIkH/78bkAIxSvJSKlJg9UHKD55U+fx2xOrBO8m+ip8BB5T2izB3gtnc71l2vPYxoI8Zx3Rq503uP58H7h9a3pYvpquAl7NSHPOS8IAd+ivrCwZC9sleSIDRb/WRFMQYe+FMKPThmEDvesKeca+IYd4xdj2NscFfwfqvr18KZsCaV+GsEVNZTVMWvd7H+nb2oMhYCT1x7eJLdK9ZxvCYrSoacfuo6wcCA8yKCgFM7jbDMQXHKDr9IVUydkrHmmeBB6QPuemxI5vXKjKfVFUvR2sTUJ4/GZOqDBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4g17iuoVyV9kR4vJd2tk0/9/pkYvowvPt/T13p5sbyg=;
 b=YaihPZ/E5fMQ/+YjFe+SllEADJ+PZIuVzF2n4UAmr8E0PCoLeZqj0gITYj0jVFTA9Uo/LteUXZrwMqVJ5++a7ZBV7I1sq9hdkNNrkQeOuoEaNWOwbAs/YBUXBWaIx1s9AueAoV7/cA0wWLCAESdHfq9Gdf6DxM1SfZHlYVYbrJm2RbMkxb9MrtBrmnex7qvI8PlhRNbzCD0h6C3e5HXeLPJ/3HzVZiVnsGAcARaQDcVGg8IU2H03UFpxMO6lTv1Ve5a/1NnR3rYLqGwRgLYPwMGG4crUnDSQQVrQ7Q5mm5ovtFiVeFuT6ism3XXmE1qHFvCL/Xuyg65YQmFxsNh+Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by PH7PR11MB7570.namprd11.prod.outlook.com (2603:10b6:510:27a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 01:32:40 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::928a:7606:e525:8b91]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::928a:7606:e525:8b91%6]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 01:32:39 +0000
From: "Song, Xiongwei" <Xiongwei.Song@windriver.com>
To: Vlastimil Babka <vbabka@suse.cz>, "sxwjean@me.com" <sxwjean@me.com>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC: "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com"
	<rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "corbet@lwn.net"
	<corbet@lwn.net>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>,
        "quic_jjohnson@quicinc.com"
	<quic_jjohnson@quicinc.com>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 0/4] supplement of slab allocator removal
Thread-Topic: [PATCH v4 0/4] supplement of slab allocator removal
Thread-Index: AQHaLwi9e8O8YY8yKkSiZJaoz6cfj7DTUMUAgACtQ2A=
Date: Thu, 11 Jan 2024 01:32:39 +0000
Message-ID: 
 <PH0PR11MB51924436D82F9F2F8D878461EC682@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20231215034150.108783-1-sxwjean@me.com>
 <3f9e3cfa-c86d-4770-b531-87138803156f@suse.cz>
In-Reply-To: <3f9e3cfa-c86d-4770-b531-87138803156f@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|PH7PR11MB7570:EE_
x-ms-office365-filtering-correlation-id: 0296a196-fe85-49a5-9328-08dc124532e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 4Kiu7V07vSr8Hle0RjbTjd+4OxISCdpDNKuobCdu292tTXQT6srWo4FQqLpuINv+uip22ahXd/t4mvZqaajXoupZj7sZrpxlH8Vq9LXWt8tEcZ2NBHxVtWwOogzlqcOJ7lvyS/tKxiNn9H7/ZFBwfMvMWKbepkjFq74pzhP22BIdDrjWrn5o4ZAPT7/DCJtzXSavxjQ4Xi+F2uNDrpk/3SnfRL50KL6YBHeSRs4t8kOE0G5JSQItkuX3VTB6cGrjHwQo3AwnL8dCSQ5AwkLaVB4RxlccwUhJ0e0fh0eYjZr6RlM/BXFKTiiCgYYAiE57xtXbWcbz79Pr1xq6oDWQP2ny6pM0+dtEZnP1GfjmSqqDg6y2YYzLXhHJzmiU1tV24AiatnxkFo46GftmseGB7tYl8AKcWPu9ab6SMFv2GtltU1CfGcP6YN36A7vVuRgvSdf7M4K7L93nFongMizo7/rbxZZoaUWYUTzEyDebaUCYtTTMCMcNVJE1I/5+Q8QRdO7tZgQlEKw1CbIOSno2ph7vs22Bi7RgJYf02PlLRXY3SjhCj6E2G7b/OMGO4TN3Qv7MjgTyaNvLpOgAMBTRvK+j1PidS3JXQ7Fxb3NEpweO2cUZO3/QL487uWpQSRkgBb/7UfqaMNvopeLdvLbZ+AsiVvHlrpDQ1ZifzGy24sc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(39850400004)(396003)(230273577357003)(230922051799003)(230173577357003)(64100799003)(186009)(1800799012)(451199024)(53546011)(7696005)(6506007)(9686003)(122000001)(7416002)(5660300002)(8936002)(8676002)(52536014)(4326008)(55016003)(2906002)(38100700002)(110136005)(26005)(64756008)(54906003)(76116006)(66556008)(66946007)(66476007)(66446008)(316002)(71200400001)(83380400001)(41300700001)(33656002)(478600001)(38070700009)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TDFId2FBblZkUzVlY1NZK29XbTRURmtmREhYVnk2Vnk1M1ZoZE04RTEwaWlY?=
 =?utf-8?B?SGJ0SHdDRmZxd3BacXJKY2lmd3pBd000a29kRkdCdUpaOCtFN1N0eE9RZTJ4?=
 =?utf-8?B?amtPMWxpTU9LaFVWbkRDWmRZODFWVGN6cnhIamVxSVJRQkwzYUI0RExIN3l1?=
 =?utf-8?B?ZzJLQ2d6bUxLODhTZkI4ZUR2aG9LTXkrLzIwdnZldFphUlB5c3NCUjBPQU5V?=
 =?utf-8?B?Z0g1Z2pWNll5QlBITi9nMTBWZWtCdnJhNi9WU05FU1Q4aC9uQkpEb0dacFhS?=
 =?utf-8?B?bGlTNFhRSlc3bG9tSkUydDJtVWhTNlRVN05wR21EWVBSaWpnakJuVEhLVGpN?=
 =?utf-8?B?SE55RWZWZ1cyekZ3bThlWUlKMFJ4Q3drZWFVSGJyTHF5Uk5zM1RaakprMGdU?=
 =?utf-8?B?aHdOVG9jOVA4cHpycDNuL3FwYzZ2VFljSzVzbVNwZXpGcjROSzZ0VnFOcnVx?=
 =?utf-8?B?Mk80cEt5V0s3aDRPSm5wcXF5RUZuaTZ3c0owR1FrVWxLRUc2VUJmVkxzN3hZ?=
 =?utf-8?B?UTVneUhIUXUwaThaWEgyR1FSb0Y1MkxKUVRISHFhL0hHaVZkUmtwMURkYjZV?=
 =?utf-8?B?ZWd3azUzdmF1WVU1eTcvVm91ME1rcTYzcWI4MFZqbHFpOWNrSlRZMWtNNlIw?=
 =?utf-8?B?NmV6YUJkeFZLL05lN0hqdTYvYnFBVHo3ZFNmMTl4QVZuNGl6QlA1Z3BEUVhO?=
 =?utf-8?B?b0h2L1pQNVcxck5XNXJZME90ejVMTG16cUJFWUlUM2NNYTJXTFlSQnBIaVBM?=
 =?utf-8?B?NEdqbTY1TTF2djFhR1d5QWpPaml6eE5WUytnd3lqZG9hb1RvSmtqL0lYaklU?=
 =?utf-8?B?Mk94YzBwY2JJMldZdStBbWZOckpaUW1raldacSs1ckYyMzZ1NU0xSGxFOXpX?=
 =?utf-8?B?NmJBSWM3UEhiRHdvcUlQK0trS0l5ZjgwU2JZUXhvUVBFUDdqOTIxaGZXODln?=
 =?utf-8?B?MC9YT2QvaG9kbDdocVBXQjZlMTJnckNmaVdtVDF4STFZakRHQXBqOENlQlNz?=
 =?utf-8?B?ZXdLd2NXUjZWbzZCbDNLaUY2UWxFdDJLVHV1OW5LMjl2ZUwxWklRMit3U3d2?=
 =?utf-8?B?cDQraTVhMGJBQ0FSV3FDRkp6bTh1ejM5Nll2WUN1WXRBcGE2ZjBNSmhoQWtq?=
 =?utf-8?B?NitzN2RaZ3ZnZW9vMVdTaUxoM2wxdmU1Z3hwTERFSGJBVlVGYXk3UmNIM2tO?=
 =?utf-8?B?M3o4MHBzQy9PTlRKdS9hMllCalJETmt2MjZBZlFLM0NMUU5aSVUxSXBXdGJJ?=
 =?utf-8?B?WkZkQmlpbXh1cm8ydC80bVFwN0h5RjVlVlB0TGZKRHE2VjZ5Yi9vTVg0NE16?=
 =?utf-8?B?ODhsZ3cxbUpzZlhyblZnZmU1Nm1xZmxyRlFRSStQUmNMcDRQN1BnT1N0dkUz?=
 =?utf-8?B?bjFqc3RtUkNVcVVnbjdDT0FwSXM4TndnUmgwdTlZRGxlSUZTUXZxNmNqSitF?=
 =?utf-8?B?SUFGT3V6ekdoVkJGWmt0MXZIYW1ORmVrdSszcXFITW5DVTFlS2tDaXJ3TGMw?=
 =?utf-8?B?d0JZQXpLYUVaR1A1WUJiL3hITzdlM2h5SkNQTWVZNFREYnlDRUpuUTZlK2Q3?=
 =?utf-8?B?NGp4NVVjS05uZ0hjN2NydXNwTTNJeXowSUMrSjNzTEVkVSszOVdMNUVUcm0x?=
 =?utf-8?B?YnFpd3dmSWxSdUdsL1ZERjJqN2pvbFZHd3J4S1NRMEZWRklwVjZrN0R0Rm55?=
 =?utf-8?B?Qy9wVEZiWERZM3lSSkQ5RUgySVRVcGExQ0Q3dFEreXRnWTFVdDBHbnBRSk5u?=
 =?utf-8?B?a2NFSHRkT3lleVB2ajJiMDJyOHI4TVA1Q1l6aEU4REdDQXJhVFc1YnVXbi93?=
 =?utf-8?B?dFhBTnA2SFczSEtBT1BEY2k3ZElFblRsZDB2M2hNNmg5VDFKZGQ1dGM1cjFy?=
 =?utf-8?B?elZYdzBjb3NHT2RYazFWa0hGOVhyNTY3d0QzS1JkVTM1dHNhNk85ZnBxR0di?=
 =?utf-8?B?RXJKSk1qaXFXb0ZiQmFGRWdqZTJwTVBVY05lbU9wc2p0aXJveEJNV2ppR24x?=
 =?utf-8?B?MllBUDlpeTlaUkxzMzQyYTNyRDhnOU56Nkl4dXZUVXgwMjhzR0Y2cncvclNZ?=
 =?utf-8?B?RlhYYnNvVWxaYWViSzMzVVBHU0V1bkxwN3NKekNKOS9teWJ0L1g4ZDVZRUpW?=
 =?utf-8?B?a2lvTnZxamk3azJFenFnb1VLL3dZT3hyYkJBbWtNdkozSVg4aVVBM0pGeWZi?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0296a196-fe85-49a5-9328-08dc124532e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 01:32:39.4856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d3TU98SfxOVrXJPkFREWDGQVk9WP2Q6wJ2IGJq4nBkjyJGLesMRSV25n9tEhkRc07gaUFetDRWF5xBBtVH6KXUwdTqbwx/81Buti8M/JRJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7570
X-Proofpoint-GUID: _GZ71BSeJiH6uSrixs9zTrwbCyxEa0sZ
X-Proofpoint-ORIG-GUID: _GZ71BSeJiH6uSrixs9zTrwbCyxEa0sZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110011

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmxhc3RpbWlsIEJhYmth
IDx2YmFia2FAc3VzZS5jej4NCj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDEwLCAyMDI0IDEx
OjEyIFBNDQo+IFRvOiBzeHdqZWFuQG1lLmNvbTsgNDIuaHlleW9vQGdtYWlsLmNvbTsgY2xAbGlu
dXguY29tOyBsaW51eC1tbUBrdmFjay5vcmcNCj4gQ2M6IHBlbmJlcmdAa2VybmVsLm9yZzsgcmll
bnRqZXNAZ29vZ2xlLmNvbTsgaWFtam9vbnNvby5raW1AbGdlLmNvbTsNCj4gcm9tYW4uZ3VzaGNo
aW5AbGludXguZGV2OyBjb3JiZXRAbHduLm5ldDsga2Vlc2Nvb2tAY2hyb21pdW0ub3JnOyBhcm5k
QGFybmRiLmRlOw0KPiBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZzsgcXVpY19qam9obnNvbkBxdWljaW5jLmNvbTsNCj4gbGludXgtZG9jQHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgU29uZywgWGlvbmd3ZWkN
Cj4gPFhpb25nd2VpLlNvbmdAd2luZHJpdmVyLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
NCAwLzRdIHN1cHBsZW1lbnQgb2Ygc2xhYiBhbGxvY2F0b3IgcmVtb3ZhbA0KPiANCj4gQ0FVVElP
TjogVGhpcyBlbWFpbCBjb21lcyBmcm9tIGEgbm9uIFdpbmQgUml2ZXIgZW1haWwgYWNjb3VudCEN
Cj4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNv
Z25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudA0KPiBpcyBzYWZlLg0KPiANCj4g
T24gMTIvMTUvMjMgMDQ6NDEsIHN4d2plYW5AbWUuY29tIHdyb3RlOg0KPiA+IEZyb206IFhpb25n
d2VpIFNvbmcgPHhpb25nd2VpLnNvbmdAd2luZHJpdmVyLmNvbT4NCj4gPg0KPiA+IEhpLA0KPiA+
DQo+ID4gUGF0Y2ggMSBpcyB0byByZW1vdmUgYW4gdW51c2VkIHBhcmFtZXRlci4gSXQgaGFzIGEg
bG9uZ2VyIGhpc3RvcnksIHBsZWFzZQ0KPiA+IHNlZSB0aGUgY2hhbmdlIGhpc3RvcnkgaW5zaWRl
IHRoZSBwYXRjaC4NCj4gPg0KPiA+IC0tLQ0KPiA+IFBhdGNoIDIgaXMgdG8gcmVwbGFjZSBzbHVi
XyRwYXJhbXMgd2l0aCBzbGFiXyRwYXJhbXMuDQo+ID4gVmxhc3RpbWlsIEJhYmthIHBvaW50ZWQg
b3V0IHdlIHNob3VsZCB1c2UgInNsYWJfJHBhcmFtIiBhcyB0aGUgcHJpbWFyeQ0KPiA+IHByZWZp
eCBmb3IgbG9uZy10ZXJtIHBsYW4uIFBsZWFzZSBzZWUgWzFdIGZvciBtb3JlIGluZm9ybWF0aW9u
Lg0KPiA+DQo+ID4gSSBkaWQgdGhlIGJhc2ljIHRlc3RzIHdpdGggcWVtdSwgd2hpY2ggcGFzc2Vk
IHZhbHVlcyBieSBzbFthdV1iX21heF9vcmRlciwNCj4gPiBzbFthdV1iX21pbl9vcmRlciwgc2xb
YXVdYl9taW5fb2JqZWN0cyBhbmQgc2xbYXVdYl9kZWJ1ZyBpbiBjb21tYW5kIGxpbmUuDQo+ID4g
VGhlIHZhbHVlcyBsb29rcyBjb3JyZWN0IGJ5IHByaW50aW5nIHRoZW0gb3V0IGJlZm9yZSBjYWxj
dWxhdGluZyBvcmRlcnMuDQo+ID4NCj4gPiAtLS0NCj4gPiBQYXRjaCAzIGlzIHRvIHJlcGxhY2Ug
c2x1Yl8kcGFyYW1zIGluIERvY3VtZW50YXRpb24vbW0vc2x1Yi5yc3QgYmFzZWQgb24NCj4gPiB0
aGUgY2hhbmdlcyBvZiBwYXRjaCAyLg0KPiA+DQo+ID4gLS0tDQo+ID4gUGF0Y2ggNCBpcyBvcmln
aW5hbCBwYXRjaCAzLiBJdCBpcyBub3QgcmVsYXRlZCB0byBzbGFiIGFsbG9jYXRvciByZW1vdmFs
Lg0KPiA+IEl0J3MgdG8gY29ycmVjdCB0aGUgZGVzY3JpcHRpb24gb2YgZGVmYXVsdCB2YWx1ZSBv
ZiBzbGFiX21pbl9vYmplY3RzIGluDQo+ID4gRG9jdW1lbnRhdGlvbi9tbS9zbHViLnJzdC4NCj4g
Pg0KPiA+IC0tLQ0KPiA+IFRoaXMgc2VyaWVzIGlzIGJhc2VkIG9uIFsyXS4NCj4gDQo+IEkgd2ls
bCBxdWV1ZSB0aGlzIGZvciA2LjkgYWZ0ZXIgdGhlIG1lcmdlIHdpbmRvdy4gQnV0IHNpbmNlIHRo
ZSBjaGFuZ2VzIGFyZQ0KPiBtb3N0bHkgaW4gRG9jdW1lbnRhdGlvbiwgbWF5YmUgSm9uIHdvdWxk
IHByZWZlciBoaXMgdHJlZSwgdGhlbiB3ZSB3b3VsZA0KPiBzcGxpdCBhd2F5IHRoZSBjb2RlIGNv
bW1lbnRzIGNoYW5nZXMgaW4gcGF0Y2ggMiB0byBnbyB0aHJvdWdoIHNsYWIgdHJlZS4NCg0KT2ss
IGdvdCBpdC4gDQoNClRoYW5rcywNClhpb25nd2VpDQoNCg==

