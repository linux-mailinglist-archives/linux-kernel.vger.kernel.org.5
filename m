Return-Path: <linux-kernel+bounces-126741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F11893C2C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324C31F22018
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA30741744;
	Mon,  1 Apr 2024 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oRPgG4GR"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2096.outbound.protection.outlook.com [40.107.22.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9279720DDC;
	Mon,  1 Apr 2024 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711981326; cv=fail; b=eGr8WuHvePzzawMK8cik3IMBa+/dj8qHQ5BkaHoQxHntJh9dJWkaSh57/xIGvWMWZFepnAzvUBXprdUhHpJvoe7uLrJ/z5pcU0t0rvnoZmVfQKfQeqIqCZ1QUZh7Pyh6zZb0Mi2gwdCVrpSY0R5OMLdb3ao3/ptwPboPUONqVoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711981326; c=relaxed/simple;
	bh=Cy3cpRV1wzOpUxhbbFvYmdwUJm51sfIGecKAhKT/LUc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ww2QwLa64NwMsG79b1D9zHjcMqLrGE/EwsoG874GRFSIyPxEMNcXMnEKQOFh2hY/gcXSmSKLfQ5LR/u4OQ71d/IpPqc4S1l7R26BMS+ya0uEpRAR48anzELm3nOK0kXY6ccDxS3BlWL1FBCh3/R8Q8nvdqA4N+BSmwo/7gBL0MU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oRPgG4GR; arc=fail smtp.client-ip=40.107.22.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2w9T06w20Zp2Wky4FdbtABSQuWSJ5IL9HPDTDsvnW/s9oWrJef0D8l8ZGTeVKtVkuaiGp7AUOtaX9fPNmvBatR43EEWIhHpVsZW9HqnuePJK6rkVUDedoFODogwxtkZ0yHRczDWI2b59GTVOp7hOoEsRt+j5wXnWOpR7i9MIdR2qGuJxxY/J1HOrk9OZDEqSVzZ735AL8byLpyLWmNQYTgUQAwpz/YJduMWw92Npm4Y6CCPNvTkNvKp99Sb0XE0Vf7rBzQVrozqy/LKsSKMFJYHUW9yM/PfA9krWQpoiQ9RIK0cTSCXVj6kEYPdBTD/6ISqpaj3cdaKcOK6lq3kZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cy3cpRV1wzOpUxhbbFvYmdwUJm51sfIGecKAhKT/LUc=;
 b=RCD0MyhyNcArYODYPRPkFXU6uq56CB7ZwEm3Ef5egZ3evhvTZK6T4sL7Els4l2LgvWpjZedKkmIoAtoLpCCE+Jwk0imNowK4yF8mQB9rSeVgILruZPF5dqkoNwE5duzPWXVZ3BUwBlGuZPSGV+fexqUeMvYscsCa9b4W34W6qumo2kV75q4QICHqkCzhnwSpySMcu1oY4mS5pW5OhDq6H1DAcXjZ4EVK8TPLjxhCQzJMDxxVVa/848XWAV2EZ6v7PF+93Bgp9UTf7DmOGSK2kp0qYBqM7456+Ihd5MkgpRy2FPbrwDg89z3FYC6s6wBgTjoXAb1HLEuxyLsm4sN3kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cy3cpRV1wzOpUxhbbFvYmdwUJm51sfIGecKAhKT/LUc=;
 b=oRPgG4GRUJBGesgoXADbWSKIlhOaRgKhXflRUZ4TV2rTS4momFj3dMTPDc+dGH6sysufsFhYJUXU46TtVwKtRUitB77bGOIaOdN6nzXXGsPeIXcywnyHwriphV6NQ/1svkKlL0Gu7GJHqDCzFvc7Mo1DLDFP5mVv5X/9egrt6VU=
Received: from PA4PR04MB9709.eurprd04.prod.outlook.com (2603:10a6:102:26b::10)
 by DUZPR04MB9947.eurprd04.prod.outlook.com (2603:10a6:10:4d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 14:22:01 +0000
Received: from PA4PR04MB9709.eurprd04.prod.outlook.com
 ([fe80::ead1:809:aa83:c1e2]) by PA4PR04MB9709.eurprd04.prod.outlook.com
 ([fe80::ead1:809:aa83:c1e2%7]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 14:22:01 +0000
From: Horia Geanta <horia.geanta@nxp.com>
To: Aleksandr Aprelkov <aaprelkov@usergate.com>
CC: Pankaj Gupta <pankaj.gupta@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: Re: [PATCH] crypto: caam/qi2 - check for 0 rx/tx queues on setup
Thread-Topic: [PATCH] crypto: caam/qi2 - check for 0 rx/tx queues on setup
Thread-Index: AQHahD/2iA2nFszn70qpsF3n7Q63dQ==
Date: Mon, 1 Apr 2024 14:22:01 +0000
Message-ID: <d75ba54c-5854-4e6c-b59b-57b576e8c083@nxp.com>
References: <20240401082620.608675-1-aaprelkov@usergate.com>
In-Reply-To: <20240401082620.608675-1-aaprelkov@usergate.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9709:EE_|DUZPR04MB9947:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YtHcuH0LsbkYlZW9jUPyH2wt4KZ1M1tsKUYKzmFx5oGsqFbrQdVyycDfOjzES/6adpdzdIR8g/N7R92JyFXDfAwL73RxSjxpTst7g25t6FTHqM7xZZ60R1TwAhl7Pl2sKcxGM7A21hhYp2IrzCwEgIdhFMHxHbMtsmS7m72TAoF49PBdSudh2KmkGRJTH6IDu26CZu9eO8UXAPprXXbdz9yXKiyI0VbNRPgkGraLSFSfYDArdt+vuga1Zku0uPH03zz/OClWrTui2iUf92t/W1VvFRqxJmyj2JcTCfONebFy65wdmK+sH6nM14q/KYwyJUk6RUiJioAkih+G87+mZ9NbviTQVJYIIVPvuUGbvDPmA9N9w2tdKQXE8kZxTh7h35dX9dVginsFcnTArFA+SBbT5VB6cAZ131qS76NZZydTwOqdJE92Bati4Q/ywPkuTK8yBN+O88Mtf94YDhbN/GatAt1Y1tKkQv2Zx5DekcI8951Lt/O2rmJWgX/IHFJ7qVBjVS+u7ZUdJIL9eLN3N7DAblphuDPUxMW0sx90FntWIj1QjIMOpxLsuQip9FGOPoNhdj/IoEOxbyB8GCvBpQH9L7dgRBurd3TqUmMOQuc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9709.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWhpejlISE9ScW40YVB0OGV5bm5heHF3dGVnRzRiL0l0OXF2bkl4U25YbGNh?=
 =?utf-8?B?U3ZUWDBNeUhJcmFjZGFwYnh0YllKa0NTNnVDOVoyakFsUDRaTjQ5Mk1SZ05L?=
 =?utf-8?B?RThrcWhTSUozS2lETjQwazIxaXVPbFhnZ0R0cWZMZlBYeTg1Q0VGdFoxTFJ0?=
 =?utf-8?B?elAzbmRER3I4VHUwWUJ3WFl6eDlyVmErWjd4V1lSU3pqU2txQkhXR2U3c1hs?=
 =?utf-8?B?ZXBScVN1NEMvZGFrK1BON0FCb1h1aFBxeGZCZ3l0UURiQVB6b2VaMnFNRW5V?=
 =?utf-8?B?Z09taklMZ0VLRkkwY0tJMkgzMjlwM0R2eFZ2OE4zMVYxZ2pTbVg5YUhYODNJ?=
 =?utf-8?B?VlFiV0I3OFJsT1pueVUydjVVQmdxQUVHcUFuSXNuUC9ZbmRRNHFRZzk5eXBr?=
 =?utf-8?B?SzhCMmRNYmFhUlpEdzZPdy91WWZxMW5ndlJtTFpSU25aSEk3UVUxeXIwY0lM?=
 =?utf-8?B?K1NXYUE4eXB4L1c5QUQrTjIwMUVKYjFiakIwdjcvajE1K0tacDFiSkNINzEz?=
 =?utf-8?B?TWtodFk0eVdjREd5UFRUYU5lVWRMMUkvdkNycXlxMSt4b0FmRWU3dE1pR0J4?=
 =?utf-8?B?VjMzSjBFZ0lOeEZkcEd0Q1FBOEtFNXd6T1BWWTcxVThKRERhTlE2K04wSjZC?=
 =?utf-8?B?aTRNNDBUaUp3MTJCMjVaNkRnK1BGUFZZYlR6LzBMYkU0OWxjeHhwRGFqNml3?=
 =?utf-8?B?WVU0WGlCRGVCVVNNQ3lFS2o0NmxSbXhkbkZFUU80TmZHMmREKzI0aFU2aTUy?=
 =?utf-8?B?MllOU0hUWDNneWIzWldiREJWUEl4NlpZOUNobW4rWnpsU2NPTmJUVFBvL0hI?=
 =?utf-8?B?aXArTHFwMXozb2V6WGloUkZZek9Nd0hOeTJ2Y1ZnZHFvRFhKSG9xZTA2bjlQ?=
 =?utf-8?B?Vkk4cDE2R2wzQmRTWmQwTUJXZmk3UUNRSUJNM2lmL2RESWxNY3BDRkx2UjRX?=
 =?utf-8?B?T0kzQzFjTTBmZDBlQmoxOUd0anB6UnhYWE04RWc0dkc0dEdENm95WjJBWmRP?=
 =?utf-8?B?NUhHTlV2QjdvVFVaWkJUZEdnMlp2QnR0ZnRRNkgzSjlrdVZTREEwbDNoVGNk?=
 =?utf-8?B?OFVob3dhL29xbVhTalFucnIvT3NiOWp2U0I1ZzdrYWYzdk0zVWdzN3o3NHha?=
 =?utf-8?B?Vkp6WnpxVHdlWjhxOEZUWjBYVVNhNzRTSmtLOW9uSFBEVEtSQW1qUEZNK2ln?=
 =?utf-8?B?M0xqVmgydmc5QU5McStCM2svV0NLSEs5RzNoYlE0Y3RRdVFBY2FYOFhCZmxI?=
 =?utf-8?B?UUs3b0tXYWpXNDljb0N2T05yOWJLK05ZTWp4dVNxdFNnbGNsdjAwU3VXUVJk?=
 =?utf-8?B?YmowTndqck56SDZwNkx2dENGN2N6cW50NzNMYUVQcDhEbjdzSGhvU3h1RGJk?=
 =?utf-8?B?cFNOWEptWVRSUTB3cEdjSkNRbFhaczJscXBSVTZxVENydDFHV1l0Snp1N1p6?=
 =?utf-8?B?WXE0RWdLSWgyREhUTFZtQTN3bGFpTXRVUEk3M0xrS2h0WkJERHBsYWdqR0Ri?=
 =?utf-8?B?OU1qdkdKT0FxbWpld3FxVlQ4WTFiaTNyTENWZXRmNjh4ZEJRVmV4emtLbDcr?=
 =?utf-8?B?RmZJNDZVRWxESU8vWThrRlUrU0ZQZkRIYXI1QUxlUS9RZ216c2hCaW1zb09M?=
 =?utf-8?B?OXVBZUg3aXZFWWM3UzRHeitSTDM5MmR6Ri9IT0Zidk1xVEExMndjdndOd0sz?=
 =?utf-8?B?VkN2UVVGTksyYkhmdHJLNXpVMTN1QnB0N0NnREtqWm0yUDFIMjdVQ2k3MjNB?=
 =?utf-8?B?NmhSeENVT1J6K2h6MVc0NkYzeDkvMXZvSU1yUHJzWTFMRnUwQ3ROUzg2UlZR?=
 =?utf-8?B?Y0t6Y2FZUUNyWk5nUmRNRjBzNUU1a0N2OWNsdlVBaEtnZ0J3NG1vVk1rZU1y?=
 =?utf-8?B?cUVValZWUlI0MzJyRjZVK3hOS0FiZ3hFWHFaUDJlakphbWJidnN6VVE5eEhy?=
 =?utf-8?B?RXdnNHFuWFFEMDFzMWd6L0d5T2pYZ2hOblZtZVBsakQ1YnYvZEtiL1pKcnp0?=
 =?utf-8?B?Y3UwVzlQaGd2UWRHcFFRajFXOUV0eGVhWXo1eE5kaDJ0MThmZ2d6cWtvM2FF?=
 =?utf-8?B?anlETWx5U1QyaENzQVNPcG51dzlsaUYyY1lWYWx3NFVzR2FkV1ViQVJjaTJ0?=
 =?utf-8?B?ZGpubDFOVkxoUWZlY21RS0xTS2VZZ3M4NEdrVDluS0hKeFJZMWJvOHUyNGk4?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60E43A8F70AC2E4EACFBB163121D4CAB@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9709.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c41e13f-e8de-4fb3-70fc-08dc525718c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 14:22:01.0756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FOgsGaaGNTLTV4iNb1h/ZL4gEYfYH0OS95qjFgaIsCtHxexc2lisfHnSn8RmVPC7Xy4xAysqAq2+NbrS4ZIacg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9947

T24gNC8xLzIwMjQgMTE6MjYgQU0sIEFsZWtzYW5kciBBcHJlbGtvdiB3cm90ZToNCj4gSWYgbnVt
X3J4X3F1ZXVlcyBvciBudW1fdHhfcXVldWVzIGlzIDAsIHRoZW4gZGl2aXNpb24gYnkgemVybyBv
Y2N1cnMNCj4gb24gaiBjYWxjdWxhdGlvbi4NCj4gQWxzbyBnb3RvIG1hcmsgImVycl9nZXRfcnhf
cXVldWUiIHVzZWQgZm9yIHR4IHF1ZXVlcyB0b28uDQo+IA0KPiBGb3VuZCBieSBMaW51eCBWZXJp
ZmljYXRpb24gQ2VudGVyIChsaW51eHRlc3Rpbmcub3JnKSB3aXRoIFNWQUNFLg0KPiANCj4gRml4
ZXM6IDhkODE4YzEwNTUwMSAoImNyeXB0bzogY2FhbS9xaTIgLSBhZGQgRFBBQTItQ0FBTSBkcml2
ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBBbGVrc2FuZHIgQXByZWxrb3YgPGFhcHJlbGtvdkB1c2Vy
Z2F0ZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9jcnlwdG8vY2FhbS9jYWFtYWxnX3FpMi5jIHwg
MTEgKysrKysrKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcnlwdG8vY2FhbS9jYWFtYWxn
X3FpMi5jIGIvZHJpdmVycy9jcnlwdG8vY2FhbS9jYWFtYWxnX3FpMi5jDQo+IGluZGV4IGE0ZjY4
ODQ0MTZhMC4uMDdjYjFhYWQ3NThmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2NyeXB0by9jYWFt
L2NhYW1hbGdfcWkyLmMNCj4gKysrIGIvZHJpdmVycy9jcnlwdG8vY2FhbS9jYWFtYWxnX3FpMi5j
DQo+IEBAIC01MDQ5LDYgKzUwNDksMTEgQEAgc3RhdGljIGludCBfX2NvbGQgZHBhYTJfZHBzZWNp
X3NldHVwKHN0cnVjdCBmc2xfbWNfZGV2aWNlICpsc19kZXYpDQo+ICANCj4gIAlwcml2LT5udW1f
cGFpcnMgPSBtaW4ocHJpdi0+ZHBzZWNpX2F0dHIubnVtX3J4X3F1ZXVlcywNCj4gIAkJCSAgICAg
IHByaXYtPmRwc2VjaV9hdHRyLm51bV90eF9xdWV1ZXMpOw0KPiArCWlmICghcHJpdi0+bnVtX3Bh
aXJzKSB7DQo+ICsJCWVyciA9IC1FSU5WQUw7DQo+ICsJCWRldl9lcnIoZGV2LCAib25lIG9mIHF1
ZXVlcyBudW1iZXIgaXMgMFxuIik7DQo+ICsJCWdvdG8gZXJyX2dldF9xdWV1ZXM7DQo+ICsJfQ0K
ZHBzZWNpIG9iamVjdHMgYXJlIGNyZWF0ZWQgaW4gTUMgZi93IHVzaW5nIHJlc3Rvb2w6IGh0dHBz
Oi8vZ2l0aHViLmNvbS9ueHAtcW9yaXEvcmVzdG9vbA0KcmVzdG9vbCB2YWxpZGF0ZXMgdGhlIHVz
ZXItcHJvdmlkZWQgYXR0cmlidXRlcyBvZiB0aGVzZSBvYmplY3RzLA0KaW5jbHVkaW5nIG51bV97
cngsdHh9X3F1ZXVlcyAtIHdoaWNoIGNhbid0IGJlIHplcm8sIHRoZXkgbXVzdCBiZSBhdCBsZWFz
dCAxLg0KDQpNb3JlIGRldGFpbHMgaW4gc291cmNlIGNvZGU6DQpodHRwczovL2dpdGh1Yi5jb20v
bnhwLXFvcmlxL3Jlc3Rvb2wvYmxvYi9tYXN0ZXIvZHBzZWNpX2NvbW1hbmRzLmMjTDcxMw0KaHR0
cHM6Ly9naXRodWIuY29tL254cC1xb3JpcS9yZXN0b29sL2Jsb2IvbWFzdGVyL2Rwc2VjaV9jb21t
YW5kcy5jI0w2MzMNCg0KU28gdGhhbmtzLCBidXQgSSBkb24ndCB0aGluayB0aGlzIGNoZWNrIGlz
IHJlcXVpcmVkLg0KDQpIb3JpYQ0KDQo=

