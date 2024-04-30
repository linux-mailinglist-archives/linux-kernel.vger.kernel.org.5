Return-Path: <linux-kernel+bounces-164811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 497A08B8335
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B7A1F215B1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7633A1C0DF2;
	Tue, 30 Apr 2024 23:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=surbannet.onmicrosoft.com header.i=@surbannet.onmicrosoft.com header.b="DDyqCkGx"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2122.outbound.protection.outlook.com [40.107.20.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558431C6606;
	Tue, 30 Apr 2024 23:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714521081; cv=fail; b=L8jCmCY/tJl6XEmHuU0/C3Io6kmSXRBQ4TvyhMUymdw/D0fjYal00/U31/OXgfzU5pGu76F2oZoE47+ViLfh2/vjkXKfDJ0gz9mnBQe86KkUL1ZvuptmaETQyqAnAztu5Q4MYVyeOGapuqzIsOU3DrzeA9d38CzNnW+ji3LaxPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714521081; c=relaxed/simple;
	bh=3ezyW08v2rgBGaXX1PGl6o0GeELoTDRyQAm8xGIie1E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aM02+xW0+e0hG6GsEhlUsUK87PJsHQ30V57K9KwM0lcW/0ILRbsvGQ3oJ644ksr8eOIgDS4L9e9QT7mlpXPcrlAC1gTHQyFCAFhsWdaRsHKaqbD01jdrs/FqhxxxqmkxUZn2Pz4dLi2pRbYfBl5VvqSoD0vc0gcFtqhAHtes2w4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surban.net; spf=pass smtp.mailfrom=surban.net; dkim=pass (1024-bit key) header.d=surbannet.onmicrosoft.com header.i=@surbannet.onmicrosoft.com header.b=DDyqCkGx; arc=fail smtp.client-ip=40.107.20.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surban.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surban.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0i3XJ+w8WFb4hPP58yYoA9+Hdc+S4RVSfaHXnbYZuWIr1zPfB+Kk+wipw24e0+3PQkkb47oAL0hau2L2SWLHODxmJOIwvCon9Hbd2uWD19OsN+brpKafIPNZ8wYgrZugNYkVwkaeZawgnVpiR2WkdXlbn0ptdMdJ85RRIF05HdMmC0nOQ0kSZidjIQy+as04lnOUdt+Q7ZdPxABp1CQ1p3iAPn/pXKP3pJiLYHXs8FSPD3y5qagmOQTdQYq6CawfgC0uuC26v9QrdW+LP1LueNgxGDl5GY9pwXO9Dvxcc5NilzxQQ9Cy/P1+QnPOwnjrDnmkh8Y5Z7iN3Wcf9J/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ezyW08v2rgBGaXX1PGl6o0GeELoTDRyQAm8xGIie1E=;
 b=h2P6t7lrDKDXH+ZIY1O1qMX0OGJSOB8D8nJq4R6EJjtMr+pGNWRp8qvtaLzLqoZE/LPDzmpHU5OMQyrl3BojaAsigJM1NIDiEm1/fPUDSafGDSjDcAdzn0YBtpJg0AUdqdDXAFN22ZtKigccqXyHxC27DJEglUXOWbjqiDMFoo/LKPAuD8ZCqOPQ8PctqUb5JStYBrw6vor4QDhb+k5VuM6vnu8qfp2QranMrPyBeHcgN3R0uGhJxAv/U38OQC/aAVyLvIR3OU5p884PfVexUbRL4JF0rpvlgwNh6y6qGNFUr/dJxaaG4bhPgQY11Rq8Cm8kTX0yjB6xCeLe+xqM0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=surban.net; dmarc=pass action=none header.from=surban.net;
 dkim=pass header.d=surban.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=surbannet.onmicrosoft.com; s=selector2-surbannet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ezyW08v2rgBGaXX1PGl6o0GeELoTDRyQAm8xGIie1E=;
 b=DDyqCkGxT3HWQIEgW51vWHZZ82kN9hy/2fZprxe0gQzAdP1Wn1I6druoadj8mBjxvGpl5ojhlFFFg2ib2LBBIQoCBOW6hi2a2lu5lkRmiVf3F0tQn1Rx+txsbC92NJbNkutg6RZIFd9amq/8GAJVvlute0LNh69O58cRwQRhHqc=
Received: from DB9P189MB1978.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:37d::18)
 by GV1P189MB2666.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 23:51:16 +0000
Received: from DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 ([fe80::7185:1ee3:7e5f:f9b1]) by DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 ([fe80::7185:1ee3:7e5f:f9b1%3]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 23:51:16 +0000
From: Sebastian Urban <surban@surban.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] Bluetooth: compute LE flow credits based on recvbuf
 space
Thread-Topic: [PATCH v5] Bluetooth: compute LE flow credits based on recvbuf
 space
Thread-Index: AQHaibRuZ6CwUv3lN0aJf6tMnctgOrFhlfeAgCAJM4A=
Date: Tue, 30 Apr 2024 23:51:16 +0000
Message-ID: <ca4bb4bf-fe80-46ba-bb4e-4b9cb6b5b570@surban.net>
References: <20240408125806.12682-1-surban@surban.net>
 <CABBYNZL06-WHSArwMqkRYx190x_i+Fzp4OYd=uY0bnOGKyTnKA@mail.gmail.com>
In-Reply-To:
 <CABBYNZL06-WHSArwMqkRYx190x_i+Fzp4OYd=uY0bnOGKyTnKA@mail.gmail.com>
Accept-Language: en-US, en-DE, de-DE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=surban.net;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P189MB1978:EE_|GV1P189MB2666:EE_
x-ms-office365-filtering-correlation-id: 104d95e8-8210-4636-7b5e-08dc69706cba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|376005|366007|7416005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?T1lRcHQrSmZGaUQzSXNCRnE1RlNkMzQxSHRTZG8yWENWWHpNUDFPRW1JUE5l?=
 =?utf-8?B?TldVQ0JtY2FCMVplZHV5cEtUZDQ2ZDhrbnFONDFKMlZNY0RnM1JuTk5Nd2tB?=
 =?utf-8?B?aC9oWENxaHNUV2sxWkkvVjBWcGJZSDc3T0F0Ylp3ZjFjSFhFMldFRmFsT2cv?=
 =?utf-8?B?Slp6ODdGanJTUUJUMmgxVlBYL3BjdGo0ak1jZTR2UDFPdXhLeXF2MHRaSk5s?=
 =?utf-8?B?YTN3dGdITTJGblkzNXNybndMTDhObSt4K1ZCRDBXQTFnbmd1ZGFOL2ZhcDJU?=
 =?utf-8?B?em05M2F5bGZSN0t0OWxyb3NTeVhQd0lzd0VUZVpJUTVmanpkY0F3ZGJtQWRE?=
 =?utf-8?B?b0NMSU4rL2VEdXYvRGZiNis1Vnc1blc3ZXVUVHplOXc1NjNnNnBLNTdMYUE4?=
 =?utf-8?B?V29jSWVjQjczenNnSmZRUFNCNUZOU1hEaFc3SmNoZjdyUUNDUkV5OXA0NUpV?=
 =?utf-8?B?QjVVRzZIeUhmSzBPUkhjUGdWdkNDdENwdGdJSzF6RmdiQ3BmTnVHYzBhOGFm?=
 =?utf-8?B?T1JFcmMwYUVRVnlMZ09aSzVSekFaeDBUMzVuRTlZQUtVVG9jY3hwalptajg5?=
 =?utf-8?B?aWxGREVkSGlqdEJXQ0Fka2ZiOHBOcjZXN0h6QTNkbE9rVnlQSUROdTRUNkVr?=
 =?utf-8?B?eTdwSElkem01OUd4Qkd5dUtJNWw1Q2Z0SGx4Wmw1OVFvdnVxd2kwa2JXb0NE?=
 =?utf-8?B?eUp6d0xuVU9jQ2dUZ1lMZHEySzQ0K004OUtlOHFRS21uMFg3Q09FK3Y0aWRQ?=
 =?utf-8?B?UFZURGpOVXRnUCtoOGlXMXFPYiszZDBvZTFwZzZvRm1wU1ZpZ0xOWGVmUVQw?=
 =?utf-8?B?SmVSQWNsOFkvbXVxcXoxS2RFNTY3Sm82WjVnbWszdDNpYmRMbk1VOXFwQmVB?=
 =?utf-8?B?N1k1eVRxU09Xcm5saUJ5em0zOXg3ckV4YnRWK3hhcHJuTk5SUk9nVHc1R3h1?=
 =?utf-8?B?NzZsNlpsQm5ndzRRd2xtMFpjbFVjbXEvQXJFUVdnRUt2YVBVdC92RXM0S25r?=
 =?utf-8?B?ZDhPeTh1enBNWGxNZzM3QW9nT3VWRlc5WFBTT1dyVTdWM0FOOFFCd1g4aHVm?=
 =?utf-8?B?cUZqMStiZXNYcjdBUnJOeUhXb2d0QkFUS3NoMTVUS1F2ZlpXbXRtVWcyVGRD?=
 =?utf-8?B?UlhhMG02cC9wcmwxUFVyZGFCcHEyQk5oazhpeUI3dTlObHdFWUY3R2FEdGsw?=
 =?utf-8?B?ZStJOUhYT055cENpZFRSRzFtbnk0RjdveEdKRkIxOUlXcWxtZzBsSVhYaTQ3?=
 =?utf-8?B?Ukt6V1R3ZnVITUVpUWF6ak1yZzB0QkNzbVpWczhneEF3ZXREb0c0b2hYcy9H?=
 =?utf-8?B?dTlld2lpU29uOGFwUHp6NlFnclk0TE9rNEkrWGhIeUNtMk5LcHl2S1REWVJP?=
 =?utf-8?B?ZXpXcFNLa25CNTlhbUJ5TkJndlNlSEc2N2JzcS94Sk1sZFBMM3d4Tm1LejlD?=
 =?utf-8?B?Tzl6bGJuUEJaajZmRFRhcEM4N3V1S2JFN3ZNeGoxY01GeWFsUSt4M3k2MkRk?=
 =?utf-8?B?Q3ppQVFGYVZWSWZGaHJJUlJNb0NLZVBxMUt4Nmg4d3F2Tm1qUEtxL3IybVFM?=
 =?utf-8?B?MkpmU1ZyRkZXWTdmcks3aEZVYXRYelJ0bGMwZkN0bGxZUFE2Zlo2ZVhKWlpv?=
 =?utf-8?B?OWczbFdzT0xPbEZjNWRVd2dpbG5VUFNzZm9OdjZ5a3g2dFFyaUc3Uys1SGZj?=
 =?utf-8?B?SzJuejN2YVJHRkpobzQ3NVRwdElQZ0EyV2R3bVBsRjBieXRnNGpwSjVCN2VI?=
 =?utf-8?B?dGZwcTFQQ3hWY3NhMStLVEk2NXlzeWF0YklDWVhNQXIwSlJ6NXQ3Z0tvTk16?=
 =?utf-8?B?RTNURHUreWdDZW1ZUC9PQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1978.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WjkzdkRNWk1oMDlYZHVMQnQzempHdDg0ejNVY2pObFhOV2V3YzNFYjdnWVV2?=
 =?utf-8?B?eHB6OTFZcG1zTm9JaFVtbmZDZDZOdTNWWWYvZ0xFeTlzeWVTSWgzWkVZWHli?=
 =?utf-8?B?S3BxMUpWajlkV0tBeDA2cXRCTW5kV0pVb3Y5M0s5TktzWE41dEFRV2JOZnZ6?=
 =?utf-8?B?aWFFSnNUNFlpeS9OZXVVTnpsa2Q0aDlqWEdDTWJrK3dDOUtIUjZvRHppWGpr?=
 =?utf-8?B?US9nWXh2QmczVzk5WXJqZUdDZEpUVERURVpJc0sxT3FlRFQwR05YVEVJZDRR?=
 =?utf-8?B?czZiS3BJU0FHend6ODkycnk5azB5NHRVMlRSMkFjczk4VGJWc29XWU1nWlQ2?=
 =?utf-8?B?elFON2Noemx0bnZMQXB2ZHh3WmxlTk8wYVk5b0wwS0x5MUVodWFqTGQwcGdR?=
 =?utf-8?B?SGhVTzlKNlB4amdPUzZBU2E0djBCOWV6dnBBcHIwNWUzMmp6dm1zbkpPUElR?=
 =?utf-8?B?dE9YbUExRnZzc3h0SnNxcVk4SnVTQUFBNnpWMFUwNU1BVUZ5RUxhMWwyMm5S?=
 =?utf-8?B?V0p1RUsvTi9KUHNvNkNjbFB5cTZJUkh2ZGZINXNrSzg0aTI4bmJRMk4raEU4?=
 =?utf-8?B?bGtaM1ZCQTVyMG1yN2YyN1RkblJQOWgzemk1TjVRa00rSFRjZmg1eUV1WEw3?=
 =?utf-8?B?YitvUDc0QWs0VWJWL3ZIR3J4TFh6U1ZmNFphM1BESitTQ2huMXpSS05kQUth?=
 =?utf-8?B?NmptYVNiaFdES2toWWd0QWxQMTNqaE0raGJPSGJ6SVZ2SGxHa1V6OGp2R21w?=
 =?utf-8?B?NkRTSFRCT1hyVDN6SWZTNTRoVElpU2JUSlBnV3dUWEpkd3BWTmJOL25PeTk4?=
 =?utf-8?B?T0FZTHBTNVhNSFVmYk80eEdkYmJKcWZCTWlHRUJ3ZWNTRWRoeHlUdFFaSWd6?=
 =?utf-8?B?VTJHNnBjTnpSc3IwZ09FMlU3N3cvdmhmNGlNaVlPNWd0TVVORmhlREovczc1?=
 =?utf-8?B?R0RnNzNiM1ViVlEwejJoMUtLakR4S0JxTVBNRWxjM3ZUdVNyK3V3KzFZSzBu?=
 =?utf-8?B?QnVMVDFaZE03Vkd3MnBOOWY3Q1kyNzVvN0tYUDV2UlNWVFo0TFZITTV1ZDZX?=
 =?utf-8?B?NHA5dlJyMUxSc1VEV29kaERCYjRCemt5MXNONzlWVWNNbXlTT1RHSkthbXcy?=
 =?utf-8?B?eUtReTNZYUphSE5wTDlUTGM4U3VTQUl5Y0NhN3RyNktybW5WVTJqQldJOGow?=
 =?utf-8?B?ME9NV2toNnVXR3JuZVpxV0d4amo2ZzdNQXdkRGkvSldtM05yTWFIbXh0Y2Mw?=
 =?utf-8?B?cTg5Z25laXlKTURrK3R4eUwxUWorVy9SNFk5SllwQ3JiTUpsZWt4a3B5WTRP?=
 =?utf-8?B?SWt0cmFvR1YvY0JHeUZyQ2xRMEc2QVlvMVBFaEJGWm02ejJyMURNMnlPSGdB?=
 =?utf-8?B?QjE2Yk1WbU5IMkgyUEVvUmRLQzBOZ0xCaFE1L2k1cmcvUW5RTGpJUHhBK2Fu?=
 =?utf-8?B?QTlRL0tBN0dWMmZoUWRZVjZjTXVkZ0ZwL28yYTlZU3ZydC95TW5lSlhScjg4?=
 =?utf-8?B?UVNmQ0dISU1IL3hrckNoSy9qWSthRmtHM0JYMnJib2kvSitGc0l0S3lyQ3lP?=
 =?utf-8?B?SXpKK3Q0TEJwWW14a0E4RWtOSFBmd1VRTFIvNHlwWVJzVzY4RFdVM2JNcFNL?=
 =?utf-8?B?cUgyWTFrTG9xaTR4dlpPenhTY0Y0TlUzY0pKZ0hVenFiU0VoeXozUXhROWJN?=
 =?utf-8?B?RmExR2pmbFlSWlUrKzJ1T0VqU29mVjRFQUlKcnZTWW16amhlYmVJS0MxZFFO?=
 =?utf-8?B?bVpSUHRqOXE4eW9Ybk5WTE9KL3RMY1RTb2k4bU1hQzlzbjYyT1JrUGwzRGJY?=
 =?utf-8?B?alBsTTh3aGNFbDZCeExUbUdYUmNsZ2FzL2crMU1VRkZDQmZOUmJZUldQdHdV?=
 =?utf-8?B?Q1hQbDdnOTJ0ZEpoK0VXdGs3bTQwLzRRNHk1bmlQWFdzb2oybUZvQkU1Lzl1?=
 =?utf-8?B?QnhCdVI5aFZ3ZC9ZTGFHc1FVcHE3czBXOTB5TU1mL1dFU3dRRzJrL0hOYjhN?=
 =?utf-8?B?WkkxbDNuc2dXbFJBemR2ckJTaVI2eFpXOVRhaGgrMEEyQ0xNK3k0TjlBQkN3?=
 =?utf-8?B?VjRDR0lFNmJ3MG1SRWRaM3d0dkxlR2J2YTByRyswK0crekh0SWt1N1Q0UXlC?=
 =?utf-8?B?ZVlZdkJobnd6MDM4Yms1eVNncXhsMWI1TkFGeW9JSHRJWkZkdWcyNlhYZy9Z?=
 =?utf-8?Q?lm89O4H8QEhVUNGq+PHqaYE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B58159621245874C912DB9105D9E298D@EURP189.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: surban.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 104d95e8-8210-4636-7b5e-08dc69706cba
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 23:51:16.0984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a27af4ff-c4b3-4dec-be8d-845345d2ab67
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bYWmyK8rFp6iAG3V/WHbChel67g3CMBDsK2mwggnRsKXw63aJhoy8kNvuW+Wa9oe3QgkhbCB+Z8vaHLZ41mUmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P189MB2666

SGkgTHVpeiwNCg0KdGhhbmtzIGZvciB0aGUgcmV2aWV3IQ0KDQpPbiA0LzEwLzI0IDE2OjM4LCBM
dWl6IEF1Z3VzdG8gdm9uIERlbnR6IHdyb3RlOg0KPj4gLS0tDQo+PiAgIGluY2x1ZGUvbmV0L2Js
dWV0b290aC9sMmNhcC5oIHwgMTAgKysrKystDQo+PiAgIG5ldC9ibHVldG9vdGgvbDJjYXBfY29y
ZS5jICAgIHwgNTEgKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4+ICAgbmV0L2JsdWV0b290
aC9sMmNhcF9zb2NrLmMgICAgfCA2NyArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LQ0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDEwMyBpbnNlcnRpb25zKCspLCAyNSBkZWxldGlvbnMo
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2wyY2FwLmggYi9p
bmNsdWRlL25ldC9ibHVldG9vdGgvbDJjYXAuaA0KPj4gaW5kZXggM2Y0MDU3Y2VkOTcxLi5iYzZm
ZjQwZWJjOWYgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL25ldC9ibHVldG9vdGgvbDJjYXAuaA0K
Pj4gKysrIGIvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2wyY2FwLmgNCj4+IEBAIC01NDcsNiArNTQ3
LDggQEAgc3RydWN0IGwyY2FwX2NoYW4gew0KPj4NCj4+ICAgICAgICAgIF9fdTE2ICAgICAgICAg
ICB0eF9jcmVkaXRzOw0KPj4gICAgICAgICAgX191MTYgICAgICAgICAgIHJ4X2NyZWRpdHM7DQo+
PiArICAgICAgIGludCAgICAgICAgICAgICByeF9hdmFpbDsNCj4+ICsgICAgICAgaW50ICAgICAg
ICAgICAgIHJ4X3N0YWdlZDsNCj4gDQo+IEknZCBwcm9iYWJseSB1c2Ugc2l6ZV90IGZvciB0aGVz
ZSBhYm92ZSwgYW5kIHB1dCBzb21lIGNvbW1lbnRzIG9mIHdoYXQNCj4gdGhleSByZWZlciB0byBl
LmcuIHJ4X3N0YWdlZCBpcyB3aGF0IGhhcyBiZWVuIHJlY2VpdmVkIGFscmVhZHksIHJpZ2h0Pw0K
PiBDb3VsZG4ndCB3ZSB1c2UgY2hhbi0+c2R1LT5sZW4gaW5zdGVhZD8NCg0KQ2hhbmdlZCBhbmQg
cmVwbGFjZWQgYnkgY2hhbi0+c2R1LT5sZW4uDQoNCj4+IEBAIC01MzUsNiArNTM4LDI2IEBAIHZv
aWQgbDJjYXBfY2hhbl9zZXRfZGVmYXVsdHMoc3RydWN0IGwyY2FwX2NoYW4gKmNoYW4pDQo+PiAg
IH0NCj4+ICAgRVhQT1JUX1NZTUJPTF9HUEwobDJjYXBfY2hhbl9zZXRfZGVmYXVsdHMpOw0KPj4N
Cj4+ICtzdGF0aWMgX191MTYgbDJjYXBfbGVfcnhfY3JlZGl0cyhzdHJ1Y3QgbDJjYXBfY2hhbiAq
Y2hhbikNCj4+ICt7DQo+PiArICAgICAgIGlmIChjaGFuLT5tcHMgPT0gMCkNCj4+ICsgICAgICAg
ICAgICAgICByZXR1cm4gMDsNCj4+ICsNCj4+ICsgICAgICAgLyogSWYgd2UgZG9uJ3Qga25vdyB0
aGUgYXZhaWxhYmxlIHNwYWNlIGluIHRoZSByZWNlaXZlciBidWZmZXIsIGdpdmUNCj4+ICsgICAg
ICAgICogZW5vdWdoIGNyZWRpdHMgZm9yIGEgZnVsbCBwYWNrZXQuDQo+PiArICAgICAgICAqLw0K
Pj4gKyAgICAgICBpZiAoY2hhbi0+cnhfYXZhaWwgPT0gLTEpDQo+PiArICAgICAgICAgICAgICAg
cmV0dXJuIChjaGFuLT5pbXR1IC8gY2hhbi0+bXBzKSArIDE7DQo+PiArDQo+PiArICAgICAgIC8q
IElmIHdlIGtub3cgaG93IG11Y2ggc3BhY2UgaXMgYXZhaWxhYmxlIGluIHRoZSByZWNlaXZlIGJ1
ZmZlciwgZ2l2ZQ0KPj4gKyAgICAgICAgKiBvdXQgYXMgbWFueSBjcmVkaXRzIGFzIHdvdWxkIGZp
bGwgdGhlIGJ1ZmZlci4NCj4+ICsgICAgICAgICovDQo+PiArICAgICAgIGlmIChjaGFuLT5yeF9h
dmFpbCA8PSBjaGFuLT5yeF9zdGFnZWQpDQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+
IA0KPiBNaXNzaW5nIHNwYWNlLg0KDQpEb25lLg0KDQo+IA0KPj4gKyAgICAgICByZXR1cm4gbWlu
X3QoaW50LCBVMTZfTUFYLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgKGNoYW4tPnJ4X2F2YWls
IC0gY2hhbi0+cnhfc3RhZ2VkKSAvIGNoYW4tPm1wcyk7DQo+IA0KPiBXZSBwcm9iYWJseSBuZWVk
IHRvIHVzZSBESVZfUk9VTkRfVVAgc2luY2UgdGhlIGRpdmlzaW9uIGNhbiByZXR1cm4gMA0KPiBv
ciBpcyB0aGF0IGludGVudGlvbmFsIHNpbmNlIHRoYXQgbWVhbnMgd2UgY2Fubm90IHN0b3JlIGFu
b3RoZXIgZnVsbA0KPiBtcHM/IEkgdGhpbmsgSSdkIGdpdmUgaXQgYSBjcmVkaXQgc2luY2UgdGhp
cyBtYXkgaW1wYWN0IHRoZSB0aHJvdWdocHV0DQo+IGlmIHdlIGFyZSBub3QgZ2l2ZW4gY3JlZGl0
cyB3aGVuIGp1c3QgYSBmZXcgYnl0ZXMgd291bGQgYmUgbmVjZXNzYXJ5DQo+IGFuZCBpbiBhbnkg
Y2FzZSB3ZSB3b3VsZCBzdG9yZSB0aGUgZXh0cmEgYnl0ZXMgaW4gdGhlIHJ4X2J1c3kgbGlzdCBp
Zg0KPiB0aGF0IGlzIG92ZXIgdGhlIHJ4X2F2YWlsLg0KDQpJIGFncmVlLiBDaGFuZ2VkLg0KDQo+
PiBAQCAtNjU0MSw2ICs2NTYxLDE2IEBAIHN0YXRpYyB2b2lkIGwyY2FwX2NoYW5fbGVfc2VuZF9j
cmVkaXRzKHN0cnVjdCBsMmNhcF9jaGFuICpjaGFuKQ0KPj4gICAgICAgICAgbDJjYXBfc2VuZF9j
bWQoY29ubiwgY2hhbi0+aWRlbnQsIEwyQ0FQX0xFX0NSRURJVFMsIHNpemVvZihwa3QpLCAmcGt0
KTsNCj4+ICAgfQ0KPj4NCj4+ICt2b2lkIGwyY2FwX2NoYW5fcnhfYXZhaWwoc3RydWN0IGwyY2Fw
X2NoYW4gKmNoYW4sIGludCByeF9hdmFpbCkNCj4+ICt7DQo+PiArICAgICAgIEJUX0RCRygiY2hh
biAlcCBoYXMgJWQgYnl0ZXMgYXZhaWwgZm9yIHJ4IiwgY2hhbiwgcnhfYXZhaWwpOw0KPiANCj4g
V2Ugc2hvdWxkIHByb2JhYmx5IGNoZWNrIGlmIHRoZSB2YWx1ZSBoYXMgY2hhbmdlZCB0aG91Z2gs
IG9yIHRoaXMNCj4gc2hhbGwgb25seSBiZSBjYWxsZWQgd2hlbiB0aGUgYnVmZmVyIGNoYW5nZXM/
DQoNCkZ1bmN0aW9uIHJldHVybnMgbm93IGltbWVkaWF0ZWx5IGlmIHJ4X2F2YWlsIGlzIHVuY2hh
bmdlZC4NCg0KQWRkaXRpb25hbGx5IEkgaW1wcm92ZWQgdGhlIGF2YWlsYWJsZSByZWNlaXZlIHNw
YWNlIGVzdGltYXRpb24gYnkgdGFraW5nIA0KdGhlIG92ZXJoZWFkIG9mIHN0cnVjdCBza19idWZm
IGludG8gYWNjb3VudC4NCg0KSSB3aWxsIHN1Ym1pdCBhIG5ldyB2ZXJzaW9uIG9mIHRoZSBwYXRj
aCBzb29uLg0KDQoNCg==

