Return-Path: <linux-kernel+bounces-165981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 331FC8B9431
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2D21F21C6B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41F7200A0;
	Thu,  2 May 2024 05:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="iymC1vLU"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2138.outbound.protection.outlook.com [40.107.117.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2D61CA81
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 05:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714627486; cv=fail; b=dNIJmzd7CYMIlfZdXzqgv6bSh6Kd7GvSiX2WVGYSbT+Ua5U5r4nPID8TXXxnDaKqxq6JVTCerdac+t1cZ4cCMjBWM1Qp9LJCnde+s0q55glT89BUdF5AgSQ1GMfGHmn41HIGW8HY1rfYgExWQFPlg3uwSo37sMKFZkhbDX54iWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714627486; c=relaxed/simple;
	bh=a+Opkz6wojflzdvCXJ0Nv0plYR15pLbBVkldKy/oftM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DDkUeHClhGk1js8skyfja3UO6zmL++M1AvK7a3PA3DR7ydlvm21xPUUlAUlr3fqm6Gf6j0bWtjtv66qs6gux1h46eHPQeaPYeg0EjAImHavEFHAgbU4nDR9W+qsfuuTsWfP+rWNaiygzytujjK2PA70IndsM5JUw3dpc3Y1uyKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=iymC1vLU; arc=fail smtp.client-ip=40.107.117.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+/u6oGkOdIbHAXeQzAZ1b0vuCzfbv4AHf2nP2I13O27jVSyijt9UiMixYYsmF0oc0fznPQMErsruRRIrXhwEQqVa1Tiktp+amttOnNoBU1wRS1YnU7X9KynYMAy+DEcubSXlzDmdm+PAlxzRtk25ABnYVtZaPfMG4ej6Smpq1ji53KPCMYrJI5VznNeXMsEWAMI7NCvoF+m3e/s+Az9ZWy2ErB3aO6iDLYVF4M3jOyDqGX8zXe1sgfYPo9eYLw6MqySFrbWwA4rgBewAOupjyGUa7zlayhZiUYILw3suD92RAwma2Cw0N4ziXan7/Z8HyTOVIGQY1h4UDOqOVTdvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+Opkz6wojflzdvCXJ0Nv0plYR15pLbBVkldKy/oftM=;
 b=P/cKhcERGvA/bdtd9NwTedTx1GKPIYhs45e2Cx7IwCd/JGBBltYMNLUN3hVCVBvfBV8CKnjDsPHTM4eTDCSOV1xMs//8zsxg9ZRBaYXkkJTY9aWHyYOzy10SVCKYAv7MANMlQYqtagpGj4UgS/H6dit1cYbrcELflVG8jqFJsXrPhHf3JPBFsu3pNcq9dO6D9bKe6hhVOT9lN8WHRxHbRH8+BAUtrrKGom5kCvtJ31HcAacePOzTNCcTVrj6aIK3eoJVhFUwtbyxO4eEHTt6TeTzgg2kPR0T+6oZhThAEZKzuju9TGCTG5cflXyigFdqmHb6ThIOOePAVkij96Xmpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+Opkz6wojflzdvCXJ0Nv0plYR15pLbBVkldKy/oftM=;
 b=iymC1vLUr2iLrr3+OC9wIbWgNQKopUqXV2CnGY2u9sEGbUlc0LanvrMTc+sCe4JW7x3XZbgeJr84FEwdqCjYR6a+IBOeqhYbIuJ8Fa0LpB1rdrRyfextKX0YZoa1BDzn6OY0L+m3qpG9hk9cOwhTIDjz6edbw0bAZyHkCLdlPr8njuk7zmIXSsqeWS5YKG7cebBLDO3/a6uc/hAIYSIzaqSAT0N3jHnCH//YUzyMMEM0wH9M+ywcg0BnmXNwQZRDaWRQNcxeDsl6SLqXbI4fXrvOlS/AUjzkILjO1CBk27juL3uh1kl+vLGODtYdYSVPhN35T60WB7SBpUhNzxd4KQ==
Received: from TYZPR06MB6567.apcprd06.prod.outlook.com (2603:1096:400:465::12)
 by SG2PR06MB4988.apcprd06.prod.outlook.com (2603:1096:4:1c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Thu, 2 May
 2024 05:24:39 +0000
Received: from TYZPR06MB6567.apcprd06.prod.outlook.com
 ([fe80::6753:f65a:df17:ca72]) by TYZPR06MB6567.apcprd06.prod.outlook.com
 ([fe80::6753:f65a:df17:ca72%3]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 05:24:38 +0000
From: Dylan Hung <dylan_hung@aspeedtech.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>, "joel@jms.id.au" <joel@jms.id.au>,
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"zenghuchen@google.com" <zenghuchen@google.com>, "matt@codeconstruct.com.au"
	<matt@codeconstruct.com.au>, "linux-i3c@lists.infradead.org"
	<linux-i3c@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH] i3c: dw: Disable IBI IRQ depends on hot-join and SIR
 enabling
Thread-Topic: [PATCH] i3c: dw: Disable IBI IRQ depends on hot-join and SIR
 enabling
Thread-Index: AQHaSprFD5IIKTS6AEypynuES/HNLbGCio2AgAFFYZA=
Date: Thu, 2 May 2024 05:24:38 +0000
Message-ID:
 <TYZPR06MB65675E5D43EE265DD702E5689C182@TYZPR06MB6567.apcprd06.prod.outlook.com>
References: <20240119054547.983693-1-dylan_hung@aspeedtech.com>
 <563ad5613e9c5f0671e1f49f2d9ba71d8735799b.camel@codeconstruct.com.au>
In-Reply-To:
 <563ad5613e9c5f0671e1f49f2d9ba71d8735799b.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6567:EE_|SG2PR06MB4988:EE_
x-ms-office365-filtering-correlation-id: 9f93d95f-8d24-4cd1-100e-08dc6a6829a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|921011|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?N1pLLzNaaUkxRFl5K1FjVlB3ZFg4ZXVlN2JQR0U1NjMyQk9IL3RPVW4zT293?=
 =?utf-8?B?cHBncVpZOUp3bmNBMUIwYTF5b3htUXNrQ0x0b0MvQ1N5RzVmK2F4TG1KUFo1?=
 =?utf-8?B?VGlKNEJHSG93RGlXTi9lWmVjdXNRSVpSSXU3VnA1Z3RYQS8za3p0U2M1Q21n?=
 =?utf-8?B?MWtzNnZPampvMTJBbEM5MlBtR2ViTDZmR3pQSmJVZEdxZUhVMVFjQkw0Y1VT?=
 =?utf-8?B?V1E5TGNQbkJXVmR1SWFzbGhub3A3eWJ5RTl5dERGcVJaakpCN1dFNXN1VUt1?=
 =?utf-8?B?RjcrR0JJMHhEV1BzSU9yM0NadmNEYUNKR3hhTFhxZDd2Yy9RRzdCQUhHVHZ6?=
 =?utf-8?B?WlFvb05neGxKVXBXOVhyejRrOC9ZdnVhemwzNmpmeVllMWNyMzF0S3Mvczg0?=
 =?utf-8?B?VUU5TkIxYTh0UU9SYjd2d3JUQnBNVG0xdG5zOFk3VnNJYm8xekptNWI4QTh6?=
 =?utf-8?B?cm1MRFN3N3hGWCtUZEszVDdZVHdTMmZHNXNydmU1MytuU0V4M0prZXEzQWxN?=
 =?utf-8?B?UDNmdytRWkpQU29QRTltK2t2MitGeUZtdnNqZXhMTFM4VEx3WXBzUjRXL1NX?=
 =?utf-8?B?SmRDUWpWT3NaT0hIeFl2R3VCcFhEWGtWYjJrVHg2MC8wWm5NdWI0bURqeFlN?=
 =?utf-8?B?MWFBOTNhSmloa1gvRU1QQ09ablhmeXBPYm95YkF5QXhQamNqSmE3TlNaRk9l?=
 =?utf-8?B?VzlWUWhtdUNZRVhlb2EwNjl1SU93UThwQS9tZzg4Y1dwb290VWlHK2FWakdE?=
 =?utf-8?B?Qzh3U0pyY0NpRExWTXZ5QTMwNUdhazhNbmNYRjRvZkdOY3lxd1p1cTMySlh1?=
 =?utf-8?B?QkhzSTEwMEJOa1RIK2FCVjBHWUZ6c1Q1VlZZa1ZoSkp6YVI5MW45a2ZGN3F0?=
 =?utf-8?B?Z3dqNjNuRmZZdkVQUmxIMVFjZVFPMXU2bGpVbmFDYnBtNkR6NkUxWHRZaG5p?=
 =?utf-8?B?clhnM2dCQW5MWWdsM0RWYnMyU2RzckJkcVAvcXJRUjR3Qzh1MFpkUzJiQ2do?=
 =?utf-8?B?Zk5BM2E3OC83RGE4Znd2TkdwMC9IM3dRNjFKVWZsdU1GQ0t6MityZUVLcWZp?=
 =?utf-8?B?T2ppVW45STZYTUY4K3Q0bmtwWDRFVm1lbW1iV0NqY0s1bHJJMnUvNFZQZ0Fh?=
 =?utf-8?B?a3NFRWFKL0pzRDluSjVPemJUcVJLZHpMMU9rQVVac3ZEMFZXblRpWkFHRHlh?=
 =?utf-8?B?UVRiZDg0UGszOEI4OUdqZWtiWkFaSk5GQVloMjBYeklZOS9BRzRiWjAvTE9a?=
 =?utf-8?B?eldKUS9DQ0kwdUsxWW5ZejRGb3A2aFdBZjdacWlNUGxvSXNjYzRaZ2tmUDFW?=
 =?utf-8?B?Q1BibFhEWnMyaUxXQ3U2WjQ4cG56Nm1QNmd3akFhb2pHV28yOU80dFVwV3Rn?=
 =?utf-8?B?anpHY3JPQmdTUmo2QitlcUpEOHNNeUFSNUV4R1N1Y2FvOFZxRU0wZzFVS0px?=
 =?utf-8?B?TnZLMEhsaHBiaU5ZNVRBQkxhV1NlSzFuV0l5VXJYSnVPaUV5akMwNzE2Rlc0?=
 =?utf-8?B?WEhrem95YVdWQ09GQlp4NXZEaTNWS2NrSEZYSVJLMk1PWTVIak56WWhLbHA1?=
 =?utf-8?B?Nk5wUiswK2p2bHRtZTBZMzM2QzFzUDcwTUx3UWZuMjladUUrVEJWVmJGVWoz?=
 =?utf-8?B?NEdyTnpGMDJsdHN6LzBkd1ZFMkk4dG9sdTJJSzZPQVZ0OTd0amhFYkVVTms1?=
 =?utf-8?B?UUZtQk1kMXJCMXQ2Y0g1UlA1S0RCVDc3TFd1OUVBZVMzL1VLbWdCTTl6Q1VQ?=
 =?utf-8?Q?Ba01C00aIz39BoeFo8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6567.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZnhuL1o0Z0xpelpHYmJTb1ZaTkYyNS9pb0dIS3RvZW1lNkJ0TW1XMklCZWp0?=
 =?utf-8?B?Zi91UDhwbFVKMFdjNlJZWlExSngwVnZhV0tIdlN1c09HenY2VGR1UU1LazhD?=
 =?utf-8?B?WjRDRkl1VGNVdjd3VGQrajYvM0d2bXB3OW5MUGNCVDdUNEY0TE1VSXhqR2xS?=
 =?utf-8?B?RS9VZUZpbEY0NmI2bjRJc1h6RC9EMlZ0WE4zanBFVk1JcCtWTFhMM0RBSklV?=
 =?utf-8?B?ZG05aThyYnpXK3cyTVZhR0tIcTArRWFRNmJpRzIrL0xQWGlnSnJ2Z240NXNR?=
 =?utf-8?B?cUlhR2xSMmtNVkVoR1RzaGhxNDFKc1lhUWNuQkROS05nS3Y2eVBRQmdvTFVM?=
 =?utf-8?B?MU9Fc2lYZkd1a2VGRVh0TWlLODVhellHZEtTdlhmd25iK3N4b09iM3NPWGNT?=
 =?utf-8?B?WjYxdWpxN2ZqZGUwV0xFQXRwSjhHSFVoenlqdW40Q1lqeXRScytVQVB3dU1N?=
 =?utf-8?B?VHdhcnc4cDZmUmh1ZG5jZjdhS1J3aThFY3dEOFRKT0xGblI2bUdPTkV5OFpG?=
 =?utf-8?B?YUYyTS83TnVBOWtJR2VEUDM0dHVrZUJJcVM0WG9UampqdGpqYTQ5ajRzZ05K?=
 =?utf-8?B?MFRwbWVTN3gzV2c0cFMvaVpRWEtvakc3VEdza1kwU3pYOVRISVJxQjl6Mm1k?=
 =?utf-8?B?a01OYkVuUXVkakNXckZyT2hwSUJSbzNoTC9EK05obkFRVVVaa2NHMndnSzgw?=
 =?utf-8?B?Q2ZXOC91UU5GUGlhYkdYYmN4Q2hLS29DWGRicEZMcHAyNzF3dW1KaUpPY01t?=
 =?utf-8?B?MzU4WU05eGcxeHFRZGpPUW1oVHk0cndrMS9LbDhhRkJTVkM5NlhlcnZjbGlW?=
 =?utf-8?B?eSt1OS9jM1BzN0NWRUZNRy9GN1B2UU5xdnBUMTJ0c0o4SlFvMXliOTQrZ2dq?=
 =?utf-8?B?OUtmTVJQSWlmU2R2NngvVGVVNkFSejdqUEdsUng1ZE5ON2hFaDAzM1FnWEFk?=
 =?utf-8?B?c2F2U2ZDZUxNY2piSm12WTR0YUNQOTBaVVdrdExqNFc0TEc0TmNWRGFLbUth?=
 =?utf-8?B?YkVJN0o5UCtEcEc2TGY4b3IwZzRrZVRMQ0VETzdIRjZaUDk4cWdjaURXa0RC?=
 =?utf-8?B?R1hHS0szNlg3M2orN0dDNmNLU0xId1lweXp5S3htenZOaXlLUnJrUkVUaDQx?=
 =?utf-8?B?TTVBa291NEE4V21tRTVUeVN4TWJtclhVaGRUMXF2VE56VUpGZlgwMTVmd1o4?=
 =?utf-8?B?MzRpc2pjM3I0NE53ck5UUDN4akRUS0RXdWd4QkY3b3VicUp0dDJxRjZGVzZ2?=
 =?utf-8?B?ZlhUditnWGY2WEwrT3RWVDhCbEU0TU5teWs0T0sxY0NGWHlqd0lkd0RJd0RF?=
 =?utf-8?B?aVk2ODlxNXFXQmRSOU4yMUQyQ283dmpRcnVPZkQ2Nm1VZTVRUXlkSy82Z2Ni?=
 =?utf-8?B?QXBiMlU1MjNvZ0JiZ0hqSE9qUG1vejlFTmtxQWM0UkdoMEdmWHIwdW0xZGtu?=
 =?utf-8?B?V20yYWlDWnRHemJnU1FzRkxEWlNGV0JGTzJjUU93NmFMOG14SW5zTlkrODRR?=
 =?utf-8?B?bVg0Q0dHcXlBWW53ZlZrOGV4M1ZIN0RJd0xvRHZ6aHFPdTNrY05CV0l4bGdO?=
 =?utf-8?B?M2lIVUVmLy9JYkV3OU5YTk5UaHZYR3FoZGJOUG0rUklOVW1yZjIvSDkvNVMx?=
 =?utf-8?B?dVR6ckZqMFlDNkJqV21FMFh3N0xTcHN0VWtWdnAvSE9KQWVYZTV1Wkc5dXZP?=
 =?utf-8?B?M2d3V1JqQWRockdiL1RPRDJtRllrTXN3NndDdmlQWlBGWVZYbFhJZGVKZVIx?=
 =?utf-8?B?T1dFc2ZvY3NJMUROSWhOWFYwZloxZW90NmVxVm15cDZ4SjZKMjhvbytRQXBq?=
 =?utf-8?B?OThOWlJyTTVMUFh6eUdCN041NzVDdG44Q3NjTXNDMW0yRnZSd0IvVk1UNGpE?=
 =?utf-8?B?a0srUnJpSm5xSHM3WXRhQ3A1TGxrcXBPSExqL0NZcWN4ZGV2NU4vU2d6QkJQ?=
 =?utf-8?B?Sk4wWTFiSEdzank1alBENHpRdFZMd2RwRmRKWE1kdHk2MnBhQzFXMDY4M0R3?=
 =?utf-8?B?STlpNmtmRk5vdC8rRGt5RW5RdUQ0aVJTSnlrM09ON01ybUU2MWthM2RwdFJp?=
 =?utf-8?B?RmwzMUpYdHYwT2N1ZTRCSWFsclJCeVlNMTJSZHYvaEtoMklwQXM4YS8zQ1Yw?=
 =?utf-8?Q?1C8+IS3I8nEght/WGc4WZCxXA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6567.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f93d95f-8d24-4cd1-100e-08dc6a6829a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 05:24:38.7052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +YFvTzr847NJdILe9o3+1xMsitsgiZpxm8rN4OvHHLVcaaSoFMf3irjAOQk7dTYH0B/q04YW4ofH6HdVZXF07N7imL43BO6gVZcC1qwuOMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB4988

SGkgSmVyZW15LA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEplcmVt
eSBLZXJyIDxqa0Bjb2RlY29uc3RydWN0LmNvbS5hdT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkg
MSwgMjAyNCAyOjIyIFBNDQo+IFRvOiBEeWxhbiBIdW5nIDxkeWxhbl9odW5nQGFzcGVlZHRlY2gu
Y29tPjsNCj4gYWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb207IGpvZWxAam1zLmlkLmF1OyB1
LmtsZWluZS0NCj4ga29lbmlnQHBlbmd1dHJvbml4LmRlOyBndXN0YXZvYXJzQGtlcm5lbC5vcmc7
DQo+IGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZzsgemVuZ2h1Y2hlbkBnb29nbGUuY29t
Ow0KPiBtYXR0QGNvZGVjb25zdHJ1Y3QuY29tLmF1OyBsaW51eC1pM2NAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEJNQy1TVyA8Qk1D
LVNXQGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBpM2M6IGR3OiBEaXNh
YmxlIElCSSBJUlEgZGVwZW5kcyBvbiBob3Qtam9pbiBhbmQgU0lSDQo+IGVuYWJsaW5nDQo+IA0K
PiBIaSBEeWxhbiwNCj4gDQo+IEp1c3QgYSBxdWVzdGlvbiBvbiBhIHByaW9yIHBhdGNoIHlvdSBz
ZW50Og0KPiANCj4gPiBEaXNhYmxlIElCSSBJUlEgc2lnbmFsIGFuZCBzdGF0dXMgb25seSB3aGVu
IGhvdC1qb2luIGFuZCBTSVIgZW5hYmxpbmcNCj4gPiBvZiBhbGwgdGFyZ2V0IGRldmljZXMgYXR0
YWNoZWQgdG8gdGhlIGJ1cyBhcmUgZGlzYWJsZWQuDQo+ID4NCj4gPiBGaXhlczogZTM4OWIxZDcy
YTYyICgiaTNjOiBkdzogQWRkIHN1cHBvcnQgZm9yIGluLWJhbmQgaW50ZXJydXB0cyIpDQo+IA0K
PiBbLi4uXQ0KPiANCj4gPiAtLS0gYS9kcml2ZXJzL2kzYy9tYXN0ZXIvZHctaTNjLW1hc3Rlci5j
DQo+ID4gKysrIGIvZHJpdmVycy9pM2MvbWFzdGVyL2R3LWkzYy1tYXN0ZXIuYw0KPiA+IEBAIC0x
MTYzLDggKzExNjMsMTAgQEAgc3RhdGljIHZvaWQNCj4gPiBkd19pM2NfbWFzdGVyX3NldF9zaXJf
ZW5hYmxlZChzdHJ1Y3QgZHdfaTNjX21hc3RlciAqbWFzdGVyLA0KPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZ2xvYmFsID0gcmVnID09IDB4ZmZmZmZmZmY7DQo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWcgJj0gfkJJVChpZHgpOw0KPiA+IMKgwqDCoMKg
wqDCoMKgwqB9IGVsc2Ugew0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnbG9i
YWwgPSByZWcgPT0gMDsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYm9vbCBo
al9yZWplY3RlZCA9ICEhKHJlYWRsKG1hc3Rlci0+cmVncyArDQo+ID4gK0RFVklDRV9DVFJMKSAm
IERFVl9DVFJMX0hPVF9KT0lOX05BQ0spOw0KPiA+ICsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJlZyB8PSBCSVQoaWR4KTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgZ2xvYmFsID0gKHJlZyA9PSAweGZmZmZmZmZmKSAmJiBoal9yZWplY3RlZDsNCj4g
PiDCoMKgwqDCoMKgwqDCoMKgfQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqB3cml0ZWwocmVnLCBtYXN0
ZXItPnJlZ3MgKyBJQklfU0lSX1JFUV9SRUpFQ1QpOw0KPiA+DQo+DQoNCmBgYA0KCWlmIChnbG9i
YWwpDQoJCWR3X2kzY19tYXN0ZXJfZW5hYmxlX3Npcl9zaWduYWwobWFzdGVyLCBlbmFibGUpOw0K
YGBgDQoNCj4gTXkgaW50ZXJwcmV0YXRpb24gb2YgdGhpcyBjaGFuZ2UgaXMgdGhhdCB3ZSBrZWVw
IHRoZSAiZ2xvYmFsIiBJQkkgaXJxIGVuYWJsZWQgaWYNCj4gaG90LWpvaW4tbmFjayBpcyBzZXQg
KGllLCBhbHdheXMsIGJlY2F1c2Ugd2UgZG9uJ3Qgc3VwcG9ydCBob3Qgam9pbiwgYW5kDQo+IGNv
bmZpZ3VyZSB0aGUgaGFyZHdhcmUgdG8gbmFjayBhbGwgaG90IGpvaW4gcmVxdWVzdHMpLg0KPiAN
Ckkgd291bGQgbGlrZSB0byBjbGFyaWZ5IHRoZSBjb250cm9sIGxvZ2ljLCBpbmNvcnBvcmF0aW5n
IHRoZSBwcmluY2lwbGUgb2YgZGlzYWJsaW5nIHRoZSBTSVIgaW50ZXJydXB0IHNpZ25hbDoNCg0K
Q2FzZSAxOg0KV2hlbiBgREVWX0NUUkxfSE9UX0pPSU5fTkFDS2AgaXMgc2V0LCBpbmRpY2F0aW5n
IGBoal9yZWplY3RlZGAgaXMgdHJ1ZSwgaXQgc2lnbmlmaWVzIHRoZSBjb250cm9sbGVyJ3Mgbm9u
LXJlY2VwdGl2ZW5lc3MgdG8gdGhlIGhvdC1qb2luIGV2ZW50LiBDb25zZXF1ZW50bHksIHdlIGNh
biBzYWZlbHkgZGlzYWJsZSB0aGUgU0lSIGludGVycnVwdCBzaWduYWwgaWYgbm9uZSBvZiB0aGUg
dGFyZ2V0IGRldmljZXMgcmVxdWVzdCBTSVIgKHJlZyA9PSAweGZmZmZmZmZmKS4NCg0KQ2FzZSAy
Og0KV2hlbiBgREVWX0NUUkxfSE9UX0pPSU5fTkFDS2AgaXMgdW5zZXQsIGluZGljYXRpbmcgYGhq
X3JlamVjdGVkYCBpcyBmYWxzZSwgdGhpcyBpbmRpY2F0ZXMgdGhlIGNvbnRyb2xsZXIncyByZWFk
aW5lc3MgdG8gZW5nYWdlIHdpdGggdGhlIGhvdC1qb2luIGV2ZW50LiBUaGVyZWZvcmUsIGl0J3Mg
aW1wZXJhdGl2ZSB0byBrZWVwIHRoZSBTSVIgaW50ZXJydXB0IHNpZ25hbCBlbmFibGVkLCBldmVu
IGlmIG5vdCBhbGwgdGFyZ2V0IGRldmljZXMgcmVxdWVzdCBTSVIuIEluIHRoaXMgY2FzZSwgYGds
b2JhbGAgaXMgZmFsc2UgYW5kIGBlbmFibGVgIGlzIGZhbHNlLg0KDQpIZXJlJ3MgYSBzdW1tYXJ5
IHRhYmxlIHRvIGlsbHVzdHJhdGUgdGhlIGxvZ2ljOg0KDQp8IGVuYWJsZSB8IHJlZz09MHhmZmZm
ZmZmZj8gfCBoal9yZWplY3RlZD8gfCBnbG9iYWwgfCByZXN1bHQgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfA0KfC0tLSAgICAgICAgIHwtLS0gICAgICAgICAgICAgICAgICAgICAgICAgIHwt
LS0gICAgICAgICAgICAgICAgICAgfC0tLSAgICAgICAgIHwtLS0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfA0KfCBmYWxzZSAgICAgfCB0cnVlICAgICAgICAgICAgICAgICAgICAg
IHwgdHJ1ZSAgICAgICAgICAgICAgICB8IHRydWUgICAgIHwgZGlzYWJsZSBTSVIgaW50ZXJydXB0
IHwNCnwgZmFsc2UgICAgIHwgZmFsc2UgICAgICAgICAgICAgICAgICAgICB8IHRydWUgICAgICAg
ICAgICAgICAgfCBmYWxzZSAgICAgfCBrZWVwIFNJUiBpbnRlcnJ1cHQgICAgfA0KfCBmYWxzZSAg
ICAgfCB0cnVlICAgICAgICAgICAgICAgICAgICAgIHwgZmFsc2UgICAgICAgICAgICAgICB8IGZh
bHNlICAgICB8IGtlZXAgU0lSIGludGVycnVwdCAgICB8DQp8IGZhbHNlICAgICB8IGZhbHNlICAg
ICAgICAgICAgICAgICAgICAgfCBmYWxzZSAgICAgICAgICAgICAgIHwgZmFsc2UgICAgIHwga2Vl
cCBTSVIgaW50ZXJydXB0ICAgIHwNCg0KPiBIb3dldmVyLCB3ZSBuZXZlciBlbmFibGUgdGhlIGhv
dC1qb2luIE5BQ0sgaW50ZXJydXB0IC0gSUJJX1FVRVVFX0NUUkwgYml0DQo+IDAgaXMgbmV2ZXIg
c2V0LiBTbyBJIGNhbid0IHNlZSBob3cgd2Ugd291bGQgZXZlciBnZXQgYW4gaW50ZXJydXB0IGZv
ciB0aGUgaG90DQo+IGpvaW4gTkFDSyBjYXNlIGFueXdheS4gQmVjYXVzZSBvZiB0aGF0LCB0aGlz
IHBhdGNoIGlzIGp1c3Qga2VlcGluZyB0aGUgSUJJDQo+IHRocmVzaG9sZCBpbnRlcnJ1cHQgYWx3
YXlzIGVuYWJsZWQgZm9yIG5vIHJlYXNvbi4NCj4gDQoNCkJpbGx5IHJlY2VudGx5IHN1Ym1pdHRl
ZCBhIGNoYW5nZSB0byBpbXBsZW1lbnQgdGhlIGhvdC1qb2luIGVuYWJsaW5nL2Rpc2FibGluZy4g
VGhlcmVmb3JlLCBpdCBpcyB0aW1lbHkgdG8gY29uc2lkZXIgdGhlIGhvdC1qb2luIGZ1bmN0aW9u
YWxpdHkuDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtaTNjL3Bh
dGNoLzIwMjQwNDI5MDczNjI0LjI1NjgzMC0xLWJpbGx5X3RzYWlAYXNwZWVkdGVjaC5jb20vDQoN
Cj4gT3IgaXMgc29tZXRoaW5nIGVsc2UgaGFwcGVuaW5nIGhlcmU/IElzIHRoZXJlIGFub3RoZXIg
Y2F1c2UgZm9yIHRoZSBJQkkNCj4gdGhyZXNob2xkIElSUXM/DQo+IA0KPiBDaGVlcnMsDQo+IA0K
PiANCj4gSmVyZW15DQo=

