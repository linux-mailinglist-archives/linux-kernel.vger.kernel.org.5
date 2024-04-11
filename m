Return-Path: <linux-kernel+bounces-140218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 219288A0D7A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C460B282CF7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5AE14600E;
	Thu, 11 Apr 2024 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dektech.com.au header.i=@dektech.com.au header.b="DzKGzB2U"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2100.outbound.protection.outlook.com [40.107.8.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EC11422C4;
	Thu, 11 Apr 2024 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829859; cv=fail; b=cUP7dde9xtaXsayvuGoq8kHP/ysmZ6SxGgpNwur3hKx0/7V/t34m3krtB4Uc/SagYd2xknBtbtA1LP2yCr5YIN8RXSt5ou5D3fbUi6Apbkf2QvLaVSkK9nA/ntZwsMOD1TlHUnvH57DFgxHOM7vo/nVYgnbBvr1VZliFcG7bhPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829859; c=relaxed/simple;
	bh=knX8pqPEL66z2V9OI788MRgnRoKnRBUxBqN33cyY6/s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cTPYNc4ssjO5RHX21XaHo4QnF1SubK18Mprbe5tWIsYs0dJc8T8T9+PWstAn8WNKk059X1QZNX74BB159mEe7f/nDnEzlP8kkW72q401xeVCB4j5RpwthWtFYbT+ngE2sTxuBrAmSzpZPCX+/xZLIK9BRu6gJCN0UQrfN6BPrw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dektech.com.au; spf=pass smtp.mailfrom=dektech.com.au; dkim=pass (2048-bit key) header.d=dektech.com.au header.i=@dektech.com.au header.b=DzKGzB2U; arc=fail smtp.client-ip=40.107.8.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dektech.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dektech.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W04wEKTNSv3npXeLA7re+J4g4gFX5x+J/Be90l/qWNcEEgC0ERXVTM6ZzWCi0wxUH2EMUPssYBQzrM1HR+vvR37O8/uLdY4pHNC7st8c7c4G0x7QD+Vktjzj8VJKy/wIy7WZnLgRfu2O812TdTThehZOfqU5WbMYZvFEpVfNHewUYyswWSle5NMeRmgy514aVcXzLcUn5XSqWQiinXdmOSn5jzdXoAYD8AZLjNPLLllqfSYQ9Nvh+ii9vrIGCkEHhvwwD9GsicAfvH+TkmKd8Pc9ZTcwQM6JsUUZNgCxHSd4KUEEA+0hnmifTZt5/ZPCWB/dgzh4d0PK/exJ5HefPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knX8pqPEL66z2V9OI788MRgnRoKnRBUxBqN33cyY6/s=;
 b=Sx1l3AJB8NLqVisJuMR/9SriHj+fBvlzhUGZiV9mE1On4HdGhy90XIkOJa2pFFmpk1czkl9iVqTgb18s2AxOv4I2db2fe2kTBv8xXnn2qnvozz19Wo97Z6qpjjVD5Y7DST8zqQ/Mwp8TqEf1pYvm307coW2jGeaDwmFaWjoqm1MIY8rENeInDDnntswKvWUD0wVsk9nop0Vmbq7WGRoSjMJ615Dj5eve02MaW97E4F6auR1dXlc+0OFJL/Im/l4yOR/4MtPR92Psdn7OfplZv2pzauMoyDDmHk0M36S2tarZ1LLZUUvRLxeEJp7mCH/RqKZ3bl6OpTI6f39jlb0qxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dektech.com.au; dmarc=pass action=none
 header.from=dektech.com.au; dkim=pass header.d=dektech.com.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dektech.com.au;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knX8pqPEL66z2V9OI788MRgnRoKnRBUxBqN33cyY6/s=;
 b=DzKGzB2Ur9JcLgpzJxV458OQv29+9meryUTsbWO26ez1xmpxqDun6CFXnegNZ9dQONELSqGHo1h1dhgywUmH6EJEkm0GxfeuI40O0OxvnYKfLpYJSCwh04BXs1vcoBxYeF2dVH7DjcsNvQIyvNda4LOtxGM5lfevLv+lmVUlXiwi48Sa+lGUnrznSq22fZ6d3+zbB9Vxlpk4i9TaFMDb1XiSzqwevbmmvdWXQPQEZ9JbXUTc1rAwjYH5W0wsqTXI9WzqFNPirSWG9cUdDRKfsK9T3g68qaLpaiJcRvbjwmbRFqL3hKQMDHqu9P4oJn1tYqReGV7HScmjAPbvJWxLKg==
Received: from AS4PR05MB9647.eurprd05.prod.outlook.com (2603:10a6:20b:4ce::15)
 by AM8PR05MB7170.eurprd05.prod.outlook.com (2603:10a6:20b:1d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 10:04:11 +0000
Received: from AS4PR05MB9647.eurprd05.prod.outlook.com
 ([fe80::8e06:8f6c:4364:7266]) by AS4PR05MB9647.eurprd05.prod.outlook.com
 ([fe80::8e06:8f6c:4364:7266%6]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 10:04:10 +0000
From: Tung Quang Nguyen <tung.q.nguyen@dektech.com.au>
To: Colin Ian King <colin.i.king@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] tipc: remove redundant assignment to ret, simplify
 code
Thread-Topic: [PATCH][next] tipc: remove redundant assignment to ret, simplify
 code
Thread-Index: AQHai/ET8yH2w4BKm0CIExMIZvn7kbFi08+A
Date: Thu, 11 Apr 2024 10:04:10 +0000
Message-ID:
 <AS4PR05MB96479D9B6F9EC765371AA8A588052@AS4PR05MB9647.eurprd05.prod.outlook.com>
References: <20240411091704.306752-1-colin.i.king@gmail.com>
In-Reply-To: <20240411091704.306752-1-colin.i.king@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dektech.com.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR05MB9647:EE_|AM8PR05MB7170:EE_
x-ms-office365-filtering-correlation-id: 96220262-442d-4521-cb53-08dc5a0ebbf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RnbSjvNr95aTS1cl57JPWNDkdAXh4qdqNmyWtKZEMNcjJc/ZueTJwA02j7KbR83+UnMAmSAfgWcc7AcTfgsgPJZOWClL//gAjGOFmVeiDr4E7KkX+pGYZ+02i0V4Nh4mdecXMq+HcnvRos5kiBaRZGLndZx301iTwPaPPYeGYz6dZZ/+C4vQ4h0Mbl563Z9V7dhxHZeHrTGuwmHcbH1xdd51Op8/tNrya+ME1O2gxUHV+lUwwxRnfdd1Iw9jeMxrehAcaXJgcde4uH9TuFPg7PnbxONBLcVr62tYGTyD2VWqfXxSS0gaIwmzWynBCdj+eGW2BSJCHu4j/tcXpQdq9A3tLSgFtetaIWYjhfDfeOlIVT79B0L+sjzI2BaidFT48I7FDh5aBjs7H1bCjQ2BUhfA8f43VP9uPxVChp+jecdh63KludNZpP/q+Y/VrZBOFD8kANTNyXXwqt4QgRfSn08qH5hcheh1oVAn5XpXxUtZWQKjTPN70YIlut9LWxHTUGX/jGqhG9kTDEVehDxpW/cB+uqn6bfFTq9DVHj0XlgBATig+QAhzztvK2JIS/ihkv+L1qAElOd76dDVf060Jx3X2v9T6tqGs+C2+9gC8+ch8Y5XI4K9LJKDjBhcps+UVTk9YSg0iufBkEm1p+Rfmd9Djtp9EgWvtUYX0rxaJcZOV2yrRNHRjQ2Zx8cy4fn+astw7iQ/IKqQ8p76JJTqYg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR05MB9647.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aWN1MDArK0Qrbms5ZkE3NGJxL0dqelU2OFhIMDVTZXZCbVg1ZlRmaGxTVllK?=
 =?utf-8?B?UExvUjJMVTNUcHNPMzZTZnJORHNhd3VXR2dmK3pJSHY1Nkl1ZU5LVGcycitq?=
 =?utf-8?B?Zno5NjNZQTFGSXFhOVZvdFUxQ0NyNnA4cko4WGEyRm5tRlF6aEpSSTU3T01L?=
 =?utf-8?B?dWlGUzhKVFQvcGxIQ1NONXJrTEtMLy83MjE1SEVuT0xVQm1nU0pQL2dISHJ1?=
 =?utf-8?B?akJ3ZXEzdnVyY2Z6Y2E5Z0RxaUNmWUZaS1ptVkNFTkNIK0hiN1k1aGFaZkVv?=
 =?utf-8?B?TDhzWFk0NUpJOU81R2FkV2FrVndEQlgvbmtETjZxSEhvdDd5SzdxWlBkWlBX?=
 =?utf-8?B?SmIwV0pKZFh4TW44Z1BaUmRGNHQxTHVUTDRqUWhuNnBZY0IyYzJsUXIwWHBD?=
 =?utf-8?B?cW9YelVHZzNGUzFLYTc4azNIZU8zYUU5cEZoLytJQ0s0aE4wZjR2anBURDJ3?=
 =?utf-8?B?N3BLaGNtQk5MelQvS2NpUEsxN0xML3VTc3liV1psYWxPSWc0dkVyS1BRS0t4?=
 =?utf-8?B?NExPT1Avc1BKT2VTZDVUdWUyTXpNbVczK2FZTVhUM3dMSDNUUXZSd0ZGSmFq?=
 =?utf-8?B?ZDhSSkFEdGRONVVyNFY1ek1aU0VZVWduT0M5WTJPZmhkaURGN3JYWU9ITUhY?=
 =?utf-8?B?ajd4bGl0ODRiaWhNeVEvSWJUYlFVZFZDc0VKYmZodUQyNXpHMUg4SURKTmQ4?=
 =?utf-8?B?WFo3TU9NWU9DWFIvdlVmeVVzeWhpSmtrdHdHL0M5N2VMbjZNZERNT3A1Y29T?=
 =?utf-8?B?L09RdDhDZExGWTdxdjg1Q0krVFBHbDJ4dFdkRlNTZ0ZNQlZCMzBoaHdHOTZZ?=
 =?utf-8?B?SUpTZjNDaStLUUdmN3o0TFhXRDhINm00US9OVXZyNHR5M2lIaVJvQWNxc3R0?=
 =?utf-8?B?eXVkSmJaRnc0TnFlSnR0YkpZOGt3cTA3RUNieDhyWlMwcW1JUnNNVzJVV0cy?=
 =?utf-8?B?MTY0eC9kRVFMa1lGeHZnaFZ3S3U1Z2VJMG9vakN6Y1A4UXRSLy9TWUFBeGtI?=
 =?utf-8?B?ZURYc0o0YWtEek9NaEhqa2hDSDRGVFNHRFFxSHQrNS9WdlhNcUVjRUhVN0dx?=
 =?utf-8?B?QjJPSUhkK2R3U0NzVjR6QnJaS3lzOWJKaFVkZnZ1eGtZcWdReEhxbmFmVUox?=
 =?utf-8?B?S21vZW03ZUNBSTBsT1Q0Ykt6SEdnVnJMVU1HYzNzSU9oK2NweG1ZbXoxZ21M?=
 =?utf-8?B?REsvaU1HVzZ4d3RsaGJLZDVNT2RwZG53MCtMSTBoZUFxQ3Vsb01vMFRpVk1N?=
 =?utf-8?B?QWxSV1VFWlB0bjNqZkNybmlxamNLQUR0SW8xSjNtMFVkcVJTcDZ3SU9iaFU3?=
 =?utf-8?B?R0tUeWFpTzk3WWhBTjZMdzdBNHpYRG5kbU50QlNLajQ2KzI3ZVJxMFpxQWxw?=
 =?utf-8?B?ZG8zYm5xbW85c2w0VS9lNE5aTW9xc0E2OTVjNWtnSnBUS1N3a1ZZMUFIR0dQ?=
 =?utf-8?B?UjVkNE9JcXU3RjNGYVFtbk96cnJTb2I3dUZ4eE5QazJJc0FieExjNXFVRnBR?=
 =?utf-8?B?M1NNSHVZbWduS2xoRzhOM3htWWZlVWhKSGwxSDJuUWNRcGswVFRYMkt3ZGJB?=
 =?utf-8?B?SytpUVdON1JWL2V6eG1HTXlVY0xyeU8xb2p2TkEwdFRQQVVHdkJjRjFZSm5a?=
 =?utf-8?B?QUZIa2Jzd2RmQ0EwUHNPSUhBSEoxRWdmbG9mWmdQa2dkNXl3aWwxY0VMUkpN?=
 =?utf-8?B?VTVVRjV4OWtOODhkRzRNTS9pWEF4UkkxVi9tb3FBVStiUWI5V3VVTmRUcGUy?=
 =?utf-8?B?bGlhbzE3YmhTNFNVTDF1aE1ybG5WVEJJZlR4U0k3Zlhya01qckwwMjVGY09j?=
 =?utf-8?B?ZGs2QmtGVU1uOFhZNDczMmJWeWxmWkNYWnZMYjFEcXR0Z1QwS1BtYVJIM29N?=
 =?utf-8?B?b1FRRTZac0R5dmNLZWhTSmM1YWw5d1RTM0lzMkN1Z3crSUZ6bjNZZ01vb3Vk?=
 =?utf-8?B?VlFITEtlN0NDYnB3S1BpTlJwY2hzL3BzRWlyRjc4SXFuV3lPRFJaY0dOOURX?=
 =?utf-8?B?SHhlMTJTQ3QzQUNKaUtqZlhIdTFCSVMrOWdieHNVUjBUdWVNYm9RUjFZRXRW?=
 =?utf-8?B?TE9HL0RSbWFFWWdEOTVzY1Vkb2ZHMVdSRXhVY1I1cmNiWUh2RDE1Wjlld1R2?=
 =?utf-8?B?R3NNa0wvYTZrTHYrT012Nm1kajlWODUrem05clVycW1HcGpqcHNMdjUyNk5y?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: dektech.com.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR05MB9647.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96220262-442d-4521-cb53-08dc5a0ebbf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 10:04:10.8554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1957ea50-0dd8-4360-8db0-c9530df996b2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wibmUDasBMDPD25IAaUMAdX6OegZnca6VZ4dlvZs25BXHv5Sd28QJrYQ+fpowjxr12atAzrvvEoVCbgVtNbJQk1dSlHnTQ40epSt9Qcwngg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR05MB7170

Pi0tLSBhL25ldC90aXBjL3NvY2tldC5jDQo+KysrIGIvbmV0L3RpcGMvc29ja2V0LmMNCj5AQCAt
MzU2NSwxMSArMzU2NSw4IEBAIGludCB0aXBjX25sX3NrX3dhbGsoc3RydWN0IHNrX2J1ZmYgKnNr
Yiwgc3RydWN0IG5ldGxpbmtfY2FsbGJhY2sgKmNiLA0KPiAJcmhhc2h0YWJsZV93YWxrX3N0YXJ0
KGl0ZXIpOw0KPiAJd2hpbGUgKCh0c2sgPSByaGFzaHRhYmxlX3dhbGtfbmV4dChpdGVyKSkgIT0g
TlVMTCkgew0KPiAJCWlmIChJU19FUlIodHNrKSkgew0KPi0JCQllcnIgPSBQVFJfRVJSKHRzayk7
DQo+LQkJCWlmIChlcnIgPT0gLUVBR0FJTikgew0KPi0JCQkJZXJyID0gMDsNCj4rCQkJaWYgKFBU
Ul9FUlIodHNrKSA9PSAtRUFHQUlOKQ0KPiAJCQkJY29udGludWU7DQo+LQkJCX0NCj4gCQkJYnJl
YWs7DQo+IAkJfQ0KPg0KPi0tDQo+Mi4zOS4yDQo+DQpJIHN1Z2dlc3QgdGhhdCBlcnIgdmFyaWFi
bGUgc2hvdWxkIGJlIGNvbXBsZXRlbHkgcmVtb3ZlZC4gQ291bGQgeW91IHBsZWFzZSBhbHNvIGRv
IHRoZSBzYW1lIHRoaW5nIGZvciB0aGlzIGNvZGUgPw0KIg0KLi4uDQplcnIgPSBza2JfaGFuZGxl
cihza2IsIGNiLCB0c2spOw0KaWYgKGVycikgew0KLi4uDQp9DQouLi4NCiINCg==

