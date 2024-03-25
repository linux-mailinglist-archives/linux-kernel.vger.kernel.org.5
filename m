Return-Path: <linux-kernel+bounces-116763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3021588AC66
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56F93BE5476
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CF414A0A7;
	Mon, 25 Mar 2024 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Rp2d2+eh"
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105B712836A;
	Mon, 25 Mar 2024 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711360285; cv=fail; b=VJ/RN9/1t1FXJobPUH3tQCQ5BTWZ4tS/gOJlj7vAtw6KzMQztf6zyy0KOF6wNUbCDP6f09tghtgqzuiY8/nYF2m0/8nWq7dcqKQAd6aeG+CYVJlLU98APIv3VTEg4W2v5/VA8yzyIw8RaMJKLNJPSEx9ANqvx/T88SGpX2T0vw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711360285; c=relaxed/simple;
	bh=SULhNQOmjCCViQaD2v8hFAv8gXCII1JbSkXRqShs7yE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cf1Gd4g7r0mU5gDM2YVafoimH6N3dLqwIM8TK7c0j04KJwtI8FxX2K8Iv9IFsF4DaVYGw0SX91kYUELbBf+h7hVHmHpGmVY09COWGE4/d+QJSPn8tSbyOR8mhcN2/VVH8uYBHLw978NLn33C7x9GeLz60rtSObTvSgb2fCMhwmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Rp2d2+eh; arc=fail smtp.client-ip=68.232.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1711360284; x=1742896284;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SULhNQOmjCCViQaD2v8hFAv8gXCII1JbSkXRqShs7yE=;
  b=Rp2d2+eh8uh6QeaQqWe83h+zYXdR7JRotPLYEoBQaotUFboqjSL4vQVA
   00E8IOeq2ohwQgZkm2lNiI85VcSXROqpKONu2CAqCOSQSW2/Wcx+DQLHa
   bMP/dNZ2xlOXpNWn8wW8i2khaWFBtkiPpmBslffduqEX9m2aMwTfIDHCs
   cvyHEAyaS7rpWnvfJaYAAbjaoa1m8536chJAV0JR/De9gMMoivD4PcdE3
   1qhq25y/jiA0tEofAldSo++uvowWaDlrtHGjUCvJfHqmfAUT9GCUNe1V8
   gWuyWVUeVurJ0sYkFcR5Z8Y7scfy554nrQYyKBy5ZINlzl4SpWqdj9M6K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="114478874"
X-IronPort-AV: E=Sophos;i="6.07,152,1708354800"; 
   d="scan'208";a="114478874"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 18:50:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baberCYG2wfDRLSZjqkZYUyI/cYwJLM2/9hk0qlmh/axFmKP2FjE7BBBDBaJ0/7F18Bj0yD4sX5co111jwexp/+GHIPg5PGVSV+k/ORl6dso+6A/7TJwmLomU/b4MxXdZ2wgE8QBv84Z19o7cCArKIWcrgqjdRx8nIl0IlTqaWzBFLiNS4APM9932zRpDqakqYHxu+ZORVcGv8ai0OX++dUR9FB977aAMF0LJuVwoEo3SK5H4mVkBIhllNS9t2ky75x9P7NhZtxgXpzD13CXrXfIijmb/i8ln1XqTPFsJFDuIklVC96wOR1h15XO65moVJ2zLCsPhF25KfJTuXSyrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SULhNQOmjCCViQaD2v8hFAv8gXCII1JbSkXRqShs7yE=;
 b=B1NnwEhsEry9dVuKC2wTpc1RKRd2Kt23w2JzyCZT88+23EOB6rQMz1FBqtNi3vmBn+W1uVD1qMAmqa0YP7J3wvDS6ar0Fp3RUWb98jn8J00HB84B5iAAj6Eq4AGx7GNfTHgHF0jsXmURYit6+lOwxe4xcisj623FQ2hGfHyARpiLlazIIVPoSmxjqLWrCRSVvC0eE4YiZX856yQKIS4A8LUUs7bEcPn9Fcd5gJ0pRzq6rnnLEZ/H2IvP/WmI9sPUswxLIpem18UL8f0lHVxMK9nY4/qgvOq/KyYIBTtIBpCqKKgbf/mUek7/tLpU0jjgAlfjQiUgNnrqXU4PaqRuhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 (2603:1096:404:8059::10) by OS3PR01MB8425.jpnprd01.prod.outlook.com
 (2603:1096:604:193::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 09:50:06 +0000
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::c52a:473a:a14f:7f0e]) by TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::c52a:473a:a14f:7f0e%3]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 09:50:05 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Kosina
	<jikos@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Benjamin Tissoires
	<benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 2/4] HID: hid-sensor-custom: Convert sprintf() family
 to sysfs_emit() family
Thread-Topic: [PATCH v4 2/4] HID: hid-sensor-custom: Convert sprintf() family
 to sysfs_emit() family
Thread-Index: AQHaecCtCb+y7GlfMk+OJ8DkSX1WObFG1pgAgAFphQA=
Date: Mon, 25 Mar 2024 09:50:05 +0000
Message-ID: <10b0740a-c3dd-491a-a904-835e86de2f45@fujitsu.com>
References: <20240319054527.1581299-1-lizhijian@fujitsu.com>
 <20240319054527.1581299-2-lizhijian@fujitsu.com>
 <20240324121608.30b2217b@jic23-huawei>
In-Reply-To: <20240324121608.30b2217b@jic23-huawei>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB5818:EE_|OS3PR01MB8425:EE_
x-ms-office365-filtering-correlation-id: a622ab28-255c-4514-5fce-08dc4cb0f348
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 esXuGYki/TOnMWOsqPHCq+Jo22wCnomlJfNiJ8VDQ387lLZbm/4y5eKGMF+FCjamy1XQ2b4o9LcwFrFMJc+ibzHWxqhMJzTyQWVupJ3Dv1ksHqXaDMj9/Dm+wH3cD2qDUQjlGuoTIytxq1UrbaN8aKkhI9huV0YPz1fFSq6IWcp/IhBIS4SeKDAAywoYTox0fG1Zp15pM94W/R2fzuZF8uKwqhRU4J9Z8FKS/Vd2TA3/sr/0ag3Ms2M4wPFFqG0kHAvbRf1amJdbHJ7gqzJYE5DDwPu+HcuTgEjoTC1dFE+GuY1rOmExEfEZMBMw7BGG7qvUERkGIPjQJIQ4OZj1osP8JapJShDPKnEGAcF2W/hRHQs8fAOdwZaI/vH/EtCJCRkcVaWBjiolUKk5w0PKyB6YmLew85ZRqMDG74LXmjbwuidfSNXeVCxD5yHk7XECRizHsKeGs8cDpZPENh2WhSqHT9ngBcTjVK2JnW190TOb+n+n25mksp9gWixzbR7DL1t6BIDfouCpqc4OVX0wukdsRjVzL3UKpb5vfLxidtb7OtQAT6EyPk0NGQAufDjwEsfFJQdjvHIjU2fcEEAF6L6rbrz2U8ectzZpvRc+GdnahO93OurRr/pUhvEuoGcu791dWi3lJzjWVcHM1ZGeRzWDpp7IS8Ba7BUOM8xojBLwIw2t+tG9ndSj7zVrNzON
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB5818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009)(1580799018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzUveE1SS3ZqSkU2Ym5RQWNxRlRSYXVNYWRiK2xDTzhDNnRVWllmZGNhTjl4?=
 =?utf-8?B?dy9yVGliZThGUVJUM1ZkMjBOaEsvL01Xb1FZU050dW56bFBSV1BCRkc4QjRW?=
 =?utf-8?B?U0gvaklVVHB3SU13U1FmVS8rSEZ0L3ZISkdrMGdZQ1U4OHVXQUQzUmFmOVVy?=
 =?utf-8?B?eDU5U3JxQS9CZGZ4L1N3VFJsMFhvVy80UVFFeENlQzB5OXRlZ1dFU0tscDgx?=
 =?utf-8?B?TG5McTg4VlNIU3pVY3RMenBEUU9FeWpUditQYURVM0hnak5rWDlBbDhJaFQ0?=
 =?utf-8?B?aTd1NTFPTUtsd0U2dFE5MWVWVnhsOXJhWk5OeHQxWUdwdDVSMDZGSTd0MHNn?=
 =?utf-8?B?LzdEZHFZTDV6M0JhZmlXZUVWS3k0cGxQUlZmd1Q4cFFDZE96Yi9RL3hXTUpG?=
 =?utf-8?B?ZTJReVBQRGx5LzRYYWloSUREOGJHdE1HRncwcWxJQzhyMGF4ekg1ZUQxZUlV?=
 =?utf-8?B?dHNmaHc4SXJXcHNpeHN6OW4vSUwwZkZmRFZ6eFFEQ3ZNL0JVOENkckEvQXQ2?=
 =?utf-8?B?UVB5cTZCUHZ1MWV0dzVCQXJaR3UrbFcyblV2NzZRVDRiZTdOOFZKa0FZVHY0?=
 =?utf-8?B?U0JybzA2M2FkeXlmdGRRSXZxbWF6VmhVc2wzeitFZ09mbUhiQ3NWZUQ4NWRo?=
 =?utf-8?B?THBNTUJoUVppZEN4Ni9JSkpnL1BoaytrTnM0MCtIZkhqK2NvWTBvZW92Z1J1?=
 =?utf-8?B?N1M0em9RYzE5NU9WUVFUTmt3cFRrSGdpQVdHVDluQ0YrNElkZmIxNUgyQll1?=
 =?utf-8?B?NXRURThxdFh6ZWhmWi84QXI1bTJWK1RsRHVDeE04clhWSkJINHROZ2hoZVNC?=
 =?utf-8?B?ZklTWkhaRURIeTR6bkJwd0N6ekVOTG9sbTJUalY0NEV4NC9zQmhRU2tMREhW?=
 =?utf-8?B?YmtwOTEyeWIrNG5IUFI5R3BUYytMZEYvcmpXeG44TTAyb1hpS2Y5ZS9veG5r?=
 =?utf-8?B?U1hDcVd4aFNvZnljSjFaUllodU03dVFoSWZIRm1GODZBekJrZmxwbTRpUzFw?=
 =?utf-8?B?ckY1RmkvSzlQVW9TNEJ0RGpFNzh4bG53VmRkZXFWOGpKclE4d3pFekxPcEJ6?=
 =?utf-8?B?Uy9iSEN3WTE3Y2UyQTVkMGRzeXdDclZValJ6OWNyRE1zQ0swK0plSS9SVUhO?=
 =?utf-8?B?YWcxSUE5YnBNZlFPUmZ1OFZFVEZBQ1VBZXQ3VmRyZTcwTkV4Y0szelcxRWRZ?=
 =?utf-8?B?U28vNzd2cGdRSGhvTDdXVEViQXVIUEYwR0NwZ3JlYy96TXpVYnNGZFViTnZ4?=
 =?utf-8?B?Q2JZdmZqb1RtUTNCSUVuOC85UGQzd0xkaG1TeFlyczBMekl0N2pZdW9uSWZs?=
 =?utf-8?B?TUZTYUhmWTkrUFhCeVdPTnlDWXZrRUVpYmltaE9oNmxmK1l6WDB6NkswZGYz?=
 =?utf-8?B?aERKQzVtQnhWWG8xaVZzY3pmdUpWT1Q1ZVBscDJraHV1RkRiWVdyRjdlaWpX?=
 =?utf-8?B?WmtTSHJjMW1DcTJ5Z1hnbFpJQ0FBNTVVTXlBN2N4YVpGeTJHMlhwSWg3RWtJ?=
 =?utf-8?B?eXAvdXY0OUpLY1VXOENMa3J5UWdZRE5DYTZJMytGV3pFalZiZDNtc3hodWNM?=
 =?utf-8?B?S0ZvRVVMOVJ1eGRhb09nNFRkenI4QldqbXJUb25vZ291a1QzTlV0eVNUZzNC?=
 =?utf-8?B?bW4zMU5sL1NCU1p6N1FMWDFSa21tYjlTYTFZT2kxZDhuUGpvc3ppUkdQMUps?=
 =?utf-8?B?ai9NU2RhcXVsdWVzN205eVhaNVhzOENhbEdJbHNxVE80dVN6M2loWmpUa0dW?=
 =?utf-8?B?eGZRZkdCT1dRZEFneDlRN1lyTy9UdXBEWmM0OWF5Z3dXeW9qdWlMOEJaeFpz?=
 =?utf-8?B?MFUxV2hPa2loRU1KalRNUnVxUTVZK0ViM2oydnd1UTl3dEFtWGVmMVY4eGwy?=
 =?utf-8?B?U2FoQ0hScDcxeTRlOXN5clBXR0REQzIzSG1VKzJqbXowTER1NXFnRzRnOWVV?=
 =?utf-8?B?OWdVY3U3VWwycVJMZUo1OGdsMjR4OE8wS1NyMHJYMktpUWgyaGRQREdQcEh1?=
 =?utf-8?B?UmE2UGRwa04zSG9RS0ZjbGMyaHlEYTY2S21OeVdhUnNQM0V5MExZWllreUll?=
 =?utf-8?B?QkltbDdkam81MGNUL1FWSTdmdkdzS3hqeThQa1pyMG1tY2swU1BTRGZsVmt4?=
 =?utf-8?B?ejVaa1V5aGwyeGVZdUtRcGFFK3dQQVNIWUNLMy9UYk1vWVEyUW81UG9EbzBB?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3F4B25814B8F9438DBA10BA4CC9EA9A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kixQz3H89beZYGuJkf3UlgaGB9g276KPrP1x8DXg6jK5eOHk8s2HCaiBcS2eKcJ/IltmyZ9jSDfuVA1DXtM3HIPNyzAwKqHqdqawjZdQjsqflMeiFmR9BKYjuPTncFETo1WpYkRq0QP5iB5ujeXYTPEL6oyY5WnjkD/3fQz5G++f9TGcNLoSJ/PpBeZCQuRBGN4iyn2+yeymE9ceHZ0gk+bGH8cbZKf2EGGvExaUlREnE9htizfX9kYbwBmJCZgOdiC9fIItn/lF4iqirZ+Ynjb3s/oTUdoMfCwETv0oEA1S1EVhmRS0P+M2qbwwkhlPFJp2HWS76c2YJO4OIvayC7QoaWMwW5oRxMQU+I9otOEonFbSfjgWljr2ScPPd6LXgn30UlLqM+8L5ChFCY/I5fwUy+ORf8SEF123BtM9Vih6eFVgzaOJA6Z3nq3DslfMWta3Efl4do5rkkSm1ooDPydTpRm0lYm7xphpvd6gpzn6T2wmRPg+/0OC563QvdKcjNvlqYfmAIOoEEa+vHtFYMsGix6tvTYPpSCHrcXECzPnpdCqNvSxQ8zHkHQQzY3m9AW4ME/T30Vr7bTqBg2/uWPqs/Qeo3WWFY8GjJXM4HU7XOwgKHSV2EZY5fxfJswM
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a622ab28-255c-4514-5fce-08dc4cb0f348
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 09:50:05.9257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zh+1Afd8xZv7gy63JJ+TKHGQjbkJfoMCHI+Utwc/rre37S8+4WcDuQr7V/hoisKmc+ZDioDTYbZMlDfscd/vHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8425

DQoNCk9uIDI0LzAzLzIwMjQgMjA6MTYsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+IE9uIFR1
ZSwgMTkgTWFyIDIwMjQgMTM6NDU6MjUgKzA4MDANCj4gTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1
aml0c3UuY29tPiB3cm90ZToNCj4gDQo+PiBQZXIgZmlsZXN5c3RlbXMvc3lzZnMucnN0LCBzaG93
KCkgc2hvdWxkIG9ubHkgdXNlIHN5c2ZzX2VtaXQoKQ0KPj4gb3Igc3lzZnNfZW1pdF9hdCgpIHdo
ZW4gZm9ybWF0dGluZyB0aGUgdmFsdWUgdG8gYmUgcmV0dXJuZWQgdG8gdXNlciBzcGFjZS4NCj4+
DQo+PiBjb2NjaW5lbGxlIGNvbXBsYWlucyB0aGF0IHRoZXJlIGFyZSBzdGlsbCBhIGNvdXBsZSBv
ZiBmdW5jdGlvbnMgdGhhdCB1c2UNCj4+IHNucHJpbnRmKCkuIENvbnZlcnQgdGhlbSB0byBzeXNm
c19lbWl0KCkuDQo+Pg0KPj4gc3ByaW50ZigpIGFuZCBzY25wcmludGYoKSB3aWxsIGJlIGNvbnZl
cnRlZCBhcyB3ZWxsIGlmIHRoZXkgaGF2ZS4NCj4+DQo+PiBHZW5lcmFsbHksIHRoaXMgcGF0Y2gg
aXMgZ2VuZXJhdGVkIGJ5DQo+PiBtYWtlIGNvY2NpY2hlY2sgTT08cGF0aC90by9maWxlPiBNT0RF
PXBhdGNoIFwNCj4+IENPQ0NJPXNjcmlwdHMvY29jY2luZWxsZS9hcGkvZGV2aWNlX2F0dHJfc2hv
dy5jb2NjaQ0KPj4NCj4+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlIGludGVuZGVkDQo+Pg0KPj4gQ0M6
IEppcmkgS29zaW5hIDxqaWtvc0BrZXJuZWwub3JnPg0KPj4gQ0M6IEpvbmF0aGFuIENhbWVyb24g
PGppYzIzQGtlcm5lbC5vcmc+DQo+PiBDQzogU3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMu
cGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+DQo+PiBDQzogQmVuamFtaW4gVGlzc29pcmVzIDxi
ZW5qYW1pbi50aXNzb2lyZXNAcmVkaGF0LmNvbT4NCj4+IENDOiBsaW51eC1pbnB1dEB2Z2VyLmtl
cm5lbC5vcmcNCj4+IENDOiBsaW51eC1paW9Admdlci5rZXJuZWwub3JnDQo+IA0KPiBBcyBhIGdl
bmVyYWwgcnVsZSwgZG9uJ3QgaGF2ZSBjYydzIG9mIGxpc3RzIHVwIGhlcmUuIEl0IG1ha2VzDQo+
IGEgbWVzcyBvZiB0aGUgbG9ncy4gQWxzbyBvbmNlIHlvdSBoYXZlIGFub3RoZXIgdGFnIGRyb3Ag
Q0Mgb2YNCj4gc2FtZSBwZXJzb24gKGV2ZW4gaWYgaXQncyBhIGRpZmZlcmVudCBlbWFpbCBhZGRy
ZXNzKS4NCj4gDQoNClRoYW5rIHlvdSBKb25hdGhhbi4NCg0KVW5kZXJzdG9vZCENCg0KPiBXZSBk
b24ndCB3YW50IHRvIGZpbGwgdGhlIGdpdCBsb2cgd2l0aCB1c2VsZXNzIGluZm9ybWF0aW9uLg0K
PiANCj4gSSB0aGluayBnaXQgaXMgZmluZSBwaWNraW5nIHVwIENDJ3MgZnJvbSBiZWxvdyB0aGUg
LS0tIHNvIHlvdQ0KPiBjYW4gYWRkIHRoZW0gdGhlcmUgaWYgaXQgc2ltcGxpZmllcyBob3cgeW91
IHNlbmQgeW91ciBwYXRjaA0KPiBzZXRzIG91dC4NCg0KR3JlYXQsIGl0IHNvdW5kcyBnb29kIHRv
IG1lLg0KDQoNClRoYW5rcw0KWmhpamlhbg0KDQoNCj4gDQo+IA0KPj4gUmV2aWV3ZWQtYnk6IEpv
bmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4+IFNpZ25lZC1v
ZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCj4+IC0tLQ0KPj4gVjM6
DQo+PiAgICAgcmV3cmFwIHRoZSBsaW5lIGFzIHdpbGwgYmUgdW5kZXIgODAgY2hhcnMgYW5kIGFk
ZCBSZXZpZXdlZC1ieSAjIEpvbmF0aGFuDQo+PiBUaGlzIGlzIGEgcGFydCBvZiB0aGUgd29yayAi
Rml4IGNvY2NpY2hlY2sgZGV2aWNlX2F0dHJfc2hvdyB3YXJuaW5ncyJbMV0NCj4+IFNwbGl0IHRo
ZW0gcGVyIHN1YnN5c3RlbSBzbyB0aGF0IHRoZSBtYWludGFpbmVyIGNhbiByZXZpZXcgaXQgZWFz
aWx5DQo+PiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI0MDExNjA0MTEyOS4z
OTM3ODAwLTEtbGl6aGlqaWFuQGZ1aml0c3UuY29tLw0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvaGlk
L2hpZC1zZW5zb3ItY3VzdG9tLmMgfCA5ICsrKystLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2hpZC9oaWQtc2Vuc29yLWN1c3RvbS5jIGIvZHJpdmVycy9oaWQvaGlkLXNlbnNvci1jdXN0
b20uYw0KPj4gaW5kZXggZDg1Mzk4NzIxNjU5Li5hYzIxNDc3N2Q3ZDkgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL2hpZC9oaWQtc2Vuc29yLWN1c3RvbS5jDQo+PiArKysgYi9kcml2ZXJzL2hpZC9o
aWQtc2Vuc29yLWN1c3RvbS5jDQo+PiBAQCAtMTU1LDcgKzE1NSw3IEBAIHN0YXRpYyBzc2l6ZV90
IGVuYWJsZV9zZW5zb3Jfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+PiAgIHsNCj4+ICAgCXN0
cnVjdCBoaWRfc2Vuc29yX2N1c3RvbSAqc2Vuc29yX2luc3QgPSBkZXZfZ2V0X2RydmRhdGEoZGV2
KTsNCj4+ICAgDQo+PiAtCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiVkXG4iLCBzZW5zb3JfaW5zdC0+
ZW5hYmxlKTsNCj4+ICsJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiJWRcbiIsIHNlbnNvcl9pbnN0
LT5lbmFibGUpOw0KPj4gICB9DQo+PiAgIA0KPj4gICBzdGF0aWMgaW50IHNldF9wb3dlcl9yZXBv
cnRfc3RhdGUoc3RydWN0IGhpZF9zZW5zb3JfY3VzdG9tICpzZW5zb3JfaW5zdCwNCj4+IEBAIC0z
NzIsMTQgKzM3MiwxMyBAQCBzdGF0aWMgc3NpemVfdCBzaG93X3ZhbHVlKHN0cnVjdCBkZXZpY2Ug
KmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQo+PiAgIAkJCQkgICAgIHNpemVv
ZihzdHJ1Y3QgaGlkX2N1c3RvbV91c2FnZV9kZXNjKSwNCj4+ICAgCQkJCSAgICAgdXNhZ2VfaWRf
Y21wKTsNCj4+ICAgCQlpZiAodXNhZ2VfZGVzYykNCj4+IC0JCQlyZXR1cm4gc25wcmludGYoYnVm
LCBQQUdFX1NJWkUsICIlc1xuIiwNCj4+IC0JCQkJCXVzYWdlX2Rlc2MtPmRlc2MpOw0KPj4gKwkJ
CXJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIiVzXG4iLCB1c2FnZV9kZXNjLT5kZXNjKTsNCj4+ICAg
CQllbHNlDQo+PiAtCQkJcmV0dXJuIHNwcmludGYoYnVmLCAibm90LXNwZWNpZmllZFxuIik7DQo+
PiArCQkJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAibm90LXNwZWNpZmllZFxuIik7DQo+PiAgIAkg
fSBlbHNlDQo+PiAgIAkJcmV0dXJuIC1FSU5WQUw7DQo+PiAgIA0KPj4gLQlyZXR1cm4gc3ByaW50
ZihidWYsICIlZFxuIiwgdmFsdWUpOw0KPj4gKwlyZXR1cm4gc3lzZnNfZW1pdChidWYsICIlZFxu
IiwgdmFsdWUpOw0KPj4gICB9DQo+PiAgIA0KPj4gICBzdGF0aWMgc3NpemVfdCBzdG9yZV92YWx1
ZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLA0KPiA=

