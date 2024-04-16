Return-Path: <linux-kernel+bounces-147460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373248A747B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598BB1C2228D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC196137C2E;
	Tue, 16 Apr 2024 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="PQmukRKW";
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="m3p6ChfC"
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5FA137921
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.180.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295144; cv=fail; b=l6weChNWkiGJdAhcKDoa0XI1bg3uf73k8HUuElKYfQnnmo+NG8Rzbr+IIY6PCShDxuNUkR4g62b16+8kAYleO8KV42cLCkc+IYdcO4OB74UWVxzxsVJ1Y0znNzbmIi0IZ7Scrj3ukrAVDfMjMura9sSdQkYciLV9iQbJ7j+w4hE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295144; c=relaxed/simple;
	bh=N0E0lQtUFNNKm072av2eVhRulUbueKuTmsgI/JO38ps=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HCgZDAay8qLVmix5/nYKSPB3Fa/6q9DeR58mN41b+IYGKVNKhGFz9Y8HkDqfniO70fzheLPQIfq+o5TP8I7++N4bft9xi0aw6vRolQlNQBLYjZYvGDjU/6QJDXdncGssaAwcCl/5nSPzr0AD7pbDvBk+pLeCSaiAK5QmtQZHo1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=PQmukRKW; dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b=m3p6ChfC; arc=fail smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43GJFrFm012288;
	Tue, 16 Apr 2024 20:15:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:mime-version; s=dk201812; bh=48bTKI+0yCVqCmD2wCAn6
	aLgpHP+tD663edQasgZBjk=; b=PQmukRKWS1+oPM/LVMkktX9bhCg9bed+nlhd1
	o5aIK06XyVlbbiaV20zon7CAS4kyuaZImp27qjRSzqnDiEUzTJzkvRPSziEpIBli
	uXQUcWAKDriM405ctaHJnoC9UB5VaQWKR8D7ZeVSF6+5PW9s3irWQdzLKsLFW31E
	/dmyNuyPgSQOYkKLSD9vlpRiWTnkmmDnHHP/Dn7r2+sjNrAIPBMbPR9kAQgyWvbG
	TLBRkD0Ijcpx1gEzXb2FDgD/5DvYZbfxPAGfVioo4sjJFRsMwdiTNKWqYuzT+qJd
	F9nMH0rzSasZWoO5tx/T5iUuWiQLpzkSLFEpJe8Je3u50Y62w==
Received: from hhmail04.hh.imgtec.org ([217.156.249.195])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 3xfj4sx3f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 16 Apr 2024 20:15:52 +0100 (BST)
Received: from HHMAIL05.hh.imgtec.org (10.100.10.120) by
 HHMAIL04.hh.imgtec.org (10.100.10.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Tue, 16 Apr 2024 20:15:51 +0100
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (104.47.85.40) by
 email.imgtec.com (10.100.10.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37 via Frontend
 Transport; Tue, 16 Apr 2024 20:15:51 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDWCQ8lEtPHS9wb8ThqmvOy3EAuBlrpmuADWVWj7d29/hSZDlO1qztI0rK1JA5Myz4xSrrzLD9fzPLsV/U7SDGNfD5pspUVAvu6dtJKAcFBjlH+3jQiDmH63SaxOsej+3custb76VfU4C0FGF56AUTav9E6gfGwd22LuoDnzOVUpHspwpHSOvZnCAN4LyzVTUQIIdxgtvKEqGK4yk3tI02Zc9hotBg0umAbmpqD/lYFOyo8nCKxfOM+zAzIZY0Fyyf5rvCu/1juDehRXXgVohyCh9KYlcEVZyInwY75imPcXlaNb8f+UYCguXrLkg4WYIc3I4YnNlg0VV8xnG3QqPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48bTKI+0yCVqCmD2wCAn6aLgpHP+tD663edQasgZBjk=;
 b=eACuolRo0uUTwea9U1qLvTpEn2yNxC1lzxsZAZmZHERWF67JKl3pNnkBYWcpgVsOjv0vbASo1LZ1wSEq+gukEmpB0iSOa39DPVwYzkemhoLQ07g8ZazbdCwCYlg6qtJnKvFEovbh6hmZnynqmON+OsQd4ztpwz1kuntxn5N57oEfBwKVSND//aca4B75LZ71Sk0tSVxGmEcDbyBkHvo08wPQp/QepXhdGxQOUpqsUsbAWwaBsK+4tCoBCZVwOHXl66f5dJCW4HQ9OEfWt6Ar6lVUzonDDagW1qxGR3BA6y+RcQ0SHILcpVj9YJsS+H02cqOf0p0Xv9bq606cR9SmbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48bTKI+0yCVqCmD2wCAn6aLgpHP+tD663edQasgZBjk=;
 b=m3p6ChfCMDfZ4D2aCs7UHZxHKSgpOiWyumUpVyRpHg04fPj9wqOCjG8kAMJI67WOjgdOJyGkQJ84ptDES7MdTO+1bwOx5mjxJoAKf6tHYYI7sAKjJrJIXirfsl5Hjrk4oo13r0+XAa6JeOZzxcSRGKG0HAn3rHONm/sH4yFsqBc=
Received: from CWXP265MB3397.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:e7::8) by
 LO7P265MB7741.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:398::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Tue, 16 Apr 2024 19:15:49 +0000
Received: from CWXP265MB3397.GBRP265.PROD.OUTLOOK.COM
 ([fe80::8e9d:6b2f:9881:1e15]) by CWXP265MB3397.GBRP265.PROD.OUTLOOK.COM
 ([fe80::8e9d:6b2f:9881:1e15%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 19:15:49 +0000
From: Matt Coster <Matt.Coster@imgtec.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
CC: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "Frank
 Binns" <Frank.Binns@imgtec.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] drm/imagination: Convert to platform remove callback
 returning void
Thread-Topic: [PATCH 1/4] drm/imagination: Convert to platform remove callback
 returning void
Thread-Index: AQHakDJ9yo4LfsIb3E6OOjpLiszwOQ==
Date: Tue, 16 Apr 2024 19:15:49 +0000
Message-ID: <c88c6a76-694a-42c6-a5d2-64be28606b22@imgtec.com>
References: <cover.1712681770.git.u.kleine-koenig@pengutronix.de>
 <4cf10e420863f40a268f26b9bdb0c4b53dbf3406.1712681770.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <4cf10e420863f40a268f26b9bdb0c4b53dbf3406.1712681770.git.u.kleine-koenig@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWXP265MB3397:EE_|LO7P265MB7741:EE_
x-ms-office365-filtering-correlation-id: b4409330-2e2b-4e42-fbfc-08dc5e49a07f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4dN1u9PaoEk5Q2abQjKpegTuSiclc7Ns52TCxzDKdyRm71S7i9JzXcJ9/juIeLDfG3ffk0uE8oPtUS++kcCuekphUFIeTFdHXiWpQ+2lgUsZdTl6QhOvMAJHOaCXGkyLVL8KxyPLGNmxYDbt3kekKI97O4MYt6fXaTLbJtdTHrvwGKSGR51CM2Gowq0nA55uMwxs8JkwOtvPT8fx/zfpmwTJdexcZkbERKk+6UG6L4+S245n8dmPiJtf3dfRt1BA0V3T8Tw3wNEjhq4nwc4FxxhQSL4cmaVi8Dli1773c20FvaKjhgoYwM9OGPO8pK3QGJEqCiL6tRPuJXLQK0/iUCTLT25MuSXdP8MYHTM3J2sVSj7iTC35FA23Gp4qaMbFZ8B5m2NZlXq6IwGkro7vQ+HuWpYjU00iNa4u2Us/vWHVX+7pVlTT/pJhuJd65TIAp4pWTjCO7TQmzlo6zZsfrU/J31OElFwI6l2l2mygEorHJ5QasMWcARyKKiHUPJYXxyd6zW55A4wPBCzyZRMjTtRGDoylS2Tea5hS38znuLfowCaZ/MuMk+as1GSnqPQJRhWQcuMBmQtMmWFO6VFsNQbp12ocmh5WwIpb5sgGA0mX3bI9X2AovrjITzQmkyLSAWOsZ92bc3Xb2u5UDhbrn1KYYIP9ayUDT0XSPMV8PpRXwlaA1070nygThBr4oFHQe33YdpaDnpOXlN/vLIWk8c5WEhzGgmZfQYi/KdoYb8M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB3397.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2Iwa1k3bC92azg5bUpicThScTZJcEc1d2pFUlFhbFZDQStENTFYdVBteE85?=
 =?utf-8?B?dnhUS0hRZmR5WHRXbDMrb3k5bGRYUXBwYnA1dTJEZytjeUJHaDN4cFdSeXVK?=
 =?utf-8?B?V0dXd3FDOG5MczRGT0VLU3d2Z21TZCtsOGRLZ3loNjdCRCthNXJtSlhQQXdr?=
 =?utf-8?B?ZDQvYnJYLzhWaEZGZUVXUENXeW1uUUF5SExESFYzejFVRFFyQW9pQ1VVclFT?=
 =?utf-8?B?WUFJNzJDbkdYbU9PRUprN3Q5MHZiby9RWlAwSlVjMWhrRkZsTWs2YnE4MHNi?=
 =?utf-8?B?ZG01bGYvQWxDeWxwU3ZtdlMyMkVCM25uMUJ3NG1oUGsrMHk0NFlVS2VpS1gy?=
 =?utf-8?B?SEdhS0twVGY0aUdPR3BEVDRMY0YydVZETzNERzVubyswNnVwWlZ0WHpsLzVx?=
 =?utf-8?B?eGgvWWRLejZaam0wSjZHS0o4OHJlcm8xNVZDWDVDWncvZEREdHl2VHdIZXhX?=
 =?utf-8?B?cTlhYmNCbnNDeXArNzEwSnljOGc1SWxlMlQzZm5TWG1sVUV2bGVLMVUzcURS?=
 =?utf-8?B?UXo4dmVvZXMySjZlYXNUSm5aTnlGRklNL0xkUWIzdkVEK1hlak9STTVUZXdy?=
 =?utf-8?B?VnZsRnFjeDFFN3NZdjJkdk9NREIwMXFNTHFteTdVWVBNR0YzTm9CUmh0NkFK?=
 =?utf-8?B?Q0p0a2R1eEVKWTFoZWJ6QXJMY2g5OU1mZHV4SHpUY1BXanlNUzJLRzVZWmd2?=
 =?utf-8?B?NmFUUFVCU2taY0RCZm1tS3c0Mlo2K2EwL2ZuczlWUURYaXlWR05FM0ovUndw?=
 =?utf-8?B?YnljWUJKbklvdEEwMVBjWFF2ek15dmpjRHhmbE9sbmdsS0hHb0orR3dvSU5s?=
 =?utf-8?B?Um5kVWFFc2duVko2MVJ4Ly9zZ1gzRHA5NmJtaFBaekZzeUNMc1lnREJVck1k?=
 =?utf-8?B?eEJSTGdxVDFDWlpQQWh1RkNRWWtrN1J2V252N1g4Z081bE51c3p2U3VIdUpz?=
 =?utf-8?B?SUpHMFRZVU8wdGRzQyt0emlBWXNnT3RNa25GMHhqanNXY1ZtYjYzQXAvcm92?=
 =?utf-8?B?d21qcjBncG5vZWkvTWVQbW9IeU5yZ2hrMmE1cWtxNklOTE1kMkZpVVVyQXNy?=
 =?utf-8?B?OUZ6Szd0R3hjdWZscTErWWJBcGhRbFRiV1dEVXpYN3NjbjZBSEhVcHdhTndn?=
 =?utf-8?B?RWJVWTJMVFJ3V2FQNHZSeHRWUjRmMmVYVk5KQzdCeDZVcGpmNVRCR3plcHhs?=
 =?utf-8?B?dGNrRTR5QUZFOGJwamt1SFhaT294RVZuakdBa2xOaTNHTUVabW1DTm1FZ0dW?=
 =?utf-8?B?a0RyNmYxMVVCU096bWtkN1NQbjdreUpyZXN4Z3RwV3VpOU9oNHQwUGMvWHYy?=
 =?utf-8?B?OWNpcUlIZU5Qc2FTeGN3dzI3azFWWjl0ck5RNDZzT09ST1R5MFlKUFU5aU12?=
 =?utf-8?B?ZnFId0FyckJkalRMc25MMk5LWFNCbFA0bHJkS3dZQmZSZ29VWUp2OXJRRmNt?=
 =?utf-8?B?UkY4U0hmSi9DUFhjaUxrVU1XcWVMSGd5Qm5jR2s3MG96Ryswc0dkSTlzeS83?=
 =?utf-8?B?VHRNWFVITFJWTVl6S2VldS9uOXNIMnlxaG0yNVlWYXhXR1BvWXVwVUVKR1Rq?=
 =?utf-8?B?L0Y1RmZ5d2JUcnRJbHhUVEt1Y0tmc0JGTDFrNlFNcTNCajVxaGFpeERCcWhm?=
 =?utf-8?B?U3NEUzdwQXJxTEwybEZRU0xqaFhPengwdlJqWDNUZXFvN0s1bVNENWxlaUZY?=
 =?utf-8?B?NElmY3V3ekgxeXhMbFlFVXVzb3FGYlRoL2RoWkpDLzM3eXpMRFZQUFd1cDJn?=
 =?utf-8?B?VGFvSU9QbjY3VzhnMWFUSTNMeXZ2dmRIQ3EvdzlJWlNJRGVoSzdnWVJEazh0?=
 =?utf-8?B?TEdYK09jWkpSdjQvWVJSWFI3VHZWZ2daa0FvOFc3OHBPYVhINGhwS0JBd3Ax?=
 =?utf-8?B?ZFozaTM2QkE5VEMrbS82bzV2WVZCa3BWa2Rrbk13b1NNSndFWGtYT0dub3N5?=
 =?utf-8?B?cHlRM2RKTjY3NkdubU1HZStTVlRRa3RUdVZDdktZRnh4SXpNck5odjY5amha?=
 =?utf-8?B?VzYvQTJ0cTY3bXRvcEdpZjBFYTZZbXUrZ1NjV2RxQjVtb1hoSjQyalVIek43?=
 =?utf-8?B?SXY4UW1xVVVzTE5FZXRyckJEUGFva3V6S0FEb01zVjlNN0NjRW5aM1pOek9N?=
 =?utf-8?B?eTNiTmhXVktEWEpDRk5mYlp2Nlczcm0wdHlFT2Vab2JjajBOVjI2QzlyWDZk?=
 =?utf-8?B?ZWc9PQ==?=
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------YZGxNLB9lZdnuH1BT9Fwbe6n"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB3397.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b4409330-2e2b-4e42-fbfc-08dc5e49a07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 19:15:49.7641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZOF7xyPVVA+QCHDvV0yqeDYJToQf3jrF1HBsri5oXoSXGlcAbUG9BVcfxFIzwjxWKL6dH1YYO3wVBi0TTmmzqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7741
X-OriginatorOrg: imgtec.com
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-ORIG-GUID: PqZ70_3epHt7WUVB8jZ_-mxOcIrkCWmq
X-Proofpoint-GUID: PqZ70_3epHt7WUVB8jZ_-mxOcIrkCWmq

--------------YZGxNLB9lZdnuH1BT9Fwbe6n
Content-Type: multipart/mixed; boundary="------------mwKXWOrD501s90mh1bGcGnJh";
 protected-headers="v1"
From: Matt Coster <matt.coster@imgtec.com>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Frank Binns <frank.binns@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <c88c6a76-694a-42c6-a5d2-64be28606b22@imgtec.com>
Subject: Re: [PATCH 1/4] drm/imagination: Convert to platform remove callback
 returning void
References: <cover.1712681770.git.u.kleine-koenig@pengutronix.de>
 <4cf10e420863f40a268f26b9bdb0c4b53dbf3406.1712681770.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <4cf10e420863f40a268f26b9bdb0c4b53dbf3406.1712681770.git.u.kleine-koenig@pengutronix.de>

--------------mwKXWOrD501s90mh1bGcGnJh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/04/2024 10:02, Uwe Kleine-K=C3=B6nig wrote:
> The .remove() callback for a platform driver returns an int which makes=

> many driver authors wrongly assume it's possible to do error handling b=
y
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>=20
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers=

> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Matt Coster <matt.coster@imgtec.com>

> ---
>  drivers/gpu/drm/imagination/pvr_drv.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/im=
agination/pvr_drv.c
> index 5c3b2d58d766..1a0cb7aa9cea 100644
> --- a/drivers/gpu/drm/imagination/pvr_drv.c
> +++ b/drivers/gpu/drm/imagination/pvr_drv.c
> @@ -1451,8 +1451,7 @@ pvr_probe(struct platform_device *plat_dev)
>  	return err;
>  }
> =20
> -static int
> -pvr_remove(struct platform_device *plat_dev)
> +static void pvr_remove(struct platform_device *plat_dev)
>  {
>  	struct drm_device *drm_dev =3D platform_get_drvdata(plat_dev);
>  	struct pvr_device *pvr_dev =3D to_pvr_device(drm_dev);
> @@ -1469,8 +1468,6 @@ pvr_remove(struct platform_device *plat_dev)
>  	pvr_watchdog_fini(pvr_dev);
>  	pvr_queue_device_fini(pvr_dev);
>  	pvr_context_device_fini(pvr_dev);
> -
> -	return 0;
>  }
> =20
>  static const struct of_device_id dt_match[] =3D {
> @@ -1485,7 +1482,7 @@ static const struct dev_pm_ops pvr_pm_ops =3D {
> =20
>  static struct platform_driver pvr_driver =3D {
>  	.probe =3D pvr_probe,
> -	.remove =3D pvr_remove,
> +	.remove_new =3D pvr_remove,
>  	.driver =3D {
>  		.name =3D PVR_DRIVER_NAME,
>  		.pm =3D &pvr_pm_ops,

--------------mwKXWOrD501s90mh1bGcGnJh--

--------------YZGxNLB9lZdnuH1BT9Fwbe6n
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQS4qDmoJvwmKhjY+nN5vBnz2d5qsAUCZh7OZQUDAAAAAAAKCRB5vBnz2d5qsDVj
AQDsJSOmgzbM+nxT03FcLAM4iCVp1cJW3j/lRXcx87LOSgEAg0bDwa7bhSesYIY4EmWQeLGYnwpN
2IvOKdcQe7n2tQI=
=lF/C
-----END PGP SIGNATURE-----

--------------YZGxNLB9lZdnuH1BT9Fwbe6n--

