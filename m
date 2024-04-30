Return-Path: <linux-kernel+bounces-163443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADD08B6AF9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E28361F226E2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806131C280;
	Tue, 30 Apr 2024 06:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j4wEcn2W"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C298F18EB8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 06:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714460396; cv=fail; b=R+VF8ZjWIoG5iQTfvSAXb8Gl7rdABQTFcEdwFv1Mxk2XyqphE6SP6i3j5r8X8MjKS+I4+kfKoQ0SETZ5fTye3JYv8YkE/40mS/lmmB1Ohlw1WBvxNPn0ACGnWRZ9zYPYJe45JXrbE0wIQWDVrigtCjrrQ1fRXO9frgxpkSKEJbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714460396; c=relaxed/simple;
	bh=gnKhU1dXXCx6xjwbyjc6nNrK5SFwVPDLO1SxrQyaKdM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WInw8EgE82sdHzFVaUR8FW8mN9U32AkEtJQX0AUH/A58t82OgaKiX50VcdWakwgYOBDP1I89m2SfESyYgUEWSm0bL4JjpTPbSvwW8ISH5HvgyKasjwZ9Wp3hEWeWJWsNLUzj/KTpTXjyd/SHcIspxs+lWDi7SkUpViZF0CbTl64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j4wEcn2W; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQ0+OIxs6zM6fTZHsLfy/NXx9LzSqeEVTZZ6hoqh6yX3+IqvI6goBKDKPr8IczXoVL2V47Wo9+uCOmACTlG+KrIgaWMwidFB/BvI8V1FAeTvLZB4Z6kdLTiLhinNUzLvJ82hJydVSKKMTVorOrgnBIFaMgwfMqSgN7fCV5oW5MGuzCCVySAO9vyppJHuhpXHn1dZZKh21hEmPsLLf03vqf+7yWeNBz6baD1Mw66X0ggRU+aJFky8E3T5bPZKIOCXnmvU+P9Atd7avizMS3k9Et0hOLmf41wKwlRNXCpjCb6ULdcJd9okPHjQF/a7TC2IitkLBr2tgTQJgVfhvs7LEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnKhU1dXXCx6xjwbyjc6nNrK5SFwVPDLO1SxrQyaKdM=;
 b=dM9AVSlL84xk79MM4YgzDqIY/fM39ajnu12OpGuik6lZsscvOjg+LJuqldiLjR7GzkuI74aZd0LiFpu+vt7tcySxY7TBEi4WvgVghsQqsXmeLSRgQ/YMdsNMA/kf6x1lwRg3idcFfbTdAMqZK8GzvoWzkw1Lg4b6tglWlhadf2DsvC8m9+IRAcFIiSHnNhRhZKD53fkMK1g4meqXDYa74m/BOgpc6ahxcfoRtJHotTW9MKOBeZIsgYf8jlzB1tY9hXcmY+1C6qs1ha0GIz3zbgYcwcsEByYRlFtJL984wkeU1+ocPV6z4y6lIqK+H2OUBp+e9LADPQVFAd7qgUCujg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnKhU1dXXCx6xjwbyjc6nNrK5SFwVPDLO1SxrQyaKdM=;
 b=j4wEcn2WHe3bBjGA1N741GoFXyMmKly4vsRyj9JXi9nrcw5D8ueJYdBbuYF/maZoRH6SakyCbr7kirRiQxX5Oxxt8HE3QDGnHul5Tc2D+uvUWNwWnpB3nLi1q66TP3NDE5ODe9xy2tj+s0NfnXaUtcaWT79aKxJO1RUmmV1RFwQ5VGVEZqULS0YCJgJ7FO8NOavuO42KgFjgxtQcH41+QrhaDqV21l/Z6F3fBn6Jenlw2UPArPEoI3YullT0n+T6WPsYfVD20HUmfwJta51RfsFovgJJxsAae+Jyk2TQa60OGJAngcZio4o2dJuBaFamfYSsJVNJeoAmwsK5dFQLBQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Tue, 30 Apr
 2024 06:59:52 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 06:59:51 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: =?utf-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-fabrics: use reserved tag for reg read/write command
Thread-Topic: [PATCH] nvme-fabrics: use reserved tag for reg read/write
 command
Thread-Index: AQHamqS0v0NsidyZk0GUPwZHGIlgabGALNMAgAAXPYCAAB6mAA==
Date: Tue, 30 Apr 2024 06:59:51 +0000
Message-ID: <c5495a06-1edb-4097-ab77-280955d14a56@nvidia.com>
References: <20240430021753.385089-1-brookxu.cn@gmail.com>
 <8379e4a9-3114-4d35-9d1f-81ca61351b85@nvidia.com>
 <CADtkEechcseDatdzoPDrYBapvQ5iTKo3E-tsdiwj2B7euLLwnQ@mail.gmail.com>
In-Reply-To:
 <CADtkEechcseDatdzoPDrYBapvQ5iTKo3E-tsdiwj2B7euLLwnQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB7995:EE_
x-ms-office365-filtering-correlation-id: 21575bc2-7fa4-4a6e-8300-08dc68e32223
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?cmVTQ3AzdlJDakpOd1pTWGF3K2JwSzlDSThtY3FURDVjMFpBaE1EbVhPOUJ2?=
 =?utf-8?B?NDdrYjVpL1lsN1dCeWVCaDZ1N1Nuc1ZWem50STlwazAvcUN3SGFscU40clhJ?=
 =?utf-8?B?TGVqL3NyZ0R5eXdCY0xQbjBLMGFlSjJwTThOSVg4TWNKMHJveTA0bXR2Vk51?=
 =?utf-8?B?WXZrN0lxU1BOVUQ4cFNOaUQ0TjRsYU00cFVoM0hJK0tPY0wxcmdsSkhXVVhk?=
 =?utf-8?B?WUQrRm9ibnBiVG5rKzExaHRheFBCVmlTRTRJb0owL2tDMTlxNDVmdDVSWmNB?=
 =?utf-8?B?OCtxcFRYcHRxRGVmRDhGcWVkeStvaEU2OXNaS2FhYnh0RzU5Mi85bVRiRDdB?=
 =?utf-8?B?dnNsTVhRYVZ6cFc5bTJNVk9UeDZzSnpxbm83anRCT3BWUjhNSnp1ZFhwRmRi?=
 =?utf-8?B?ZVlDWStoMURCdVFZSHk3MlNRTjBsaHNvUVBjMnBRNk55U3Zpd3UyN3N6b2NZ?=
 =?utf-8?B?d1JkMXl2SnNEaFNnNlJZV0pNS0hSSHY3bS9UbzBRN1NvSXdrcXg3aTc2R05x?=
 =?utf-8?B?SXV2Um0rcFRkcUpNMnE1VnNYcW4veGl1L2dpSlF5aVFUdWJ2T3h1UldMUkZr?=
 =?utf-8?B?UjVFSm9QT1Jod0JUS0t2RXVOcnRsVWY0R3pzM3R1NkZmMjE2QUl4enpmUWJZ?=
 =?utf-8?B?RGx5OEtZczdvTHk5c3BxVkZuSzJ2NGtPM01ibFdTa1VHdUpMT24xQzFpS2lz?=
 =?utf-8?B?MGdaa2NDR2ZKdkZ0ZHlmT2FxL05tRUIwVDY4TmFGOGxWNFVlcHBvVUNyVTcw?=
 =?utf-8?B?MkZTbGJGRUhhWVphQ3VQRi9UYnBRbHBoWjFLMG03dTBUMktZM0JVeUZRQUUz?=
 =?utf-8?B?a0RpKzEzQkpCaTdYOEhRdlkzVzgyR3J2VHZ4UUxucHlwY3liMnk5ekcySi9H?=
 =?utf-8?B?TmMrZ0VpMmxlaXYzRThmcUU3dW1VdlZWdGdkU3dQb2JzTTIzTmJaak5TU1ZX?=
 =?utf-8?B?M21Bd1lyMkY5eEcwYWdkKzF3NHRUblZMcVVHVVJjcVRwWWxKdWJXQVdoT1Rq?=
 =?utf-8?B?NWRaY2k2SmtXempMV2QrSjFRdVgxemxMb1U2QjZ2ZDdjSDdoeFE3OG5kNXE0?=
 =?utf-8?B?T3hSYXRTSldRR0hhTWh4VytkT2hwVFQrdHIzTmlTVjBrMG1kdlhHdWQwR24x?=
 =?utf-8?B?TkQyQS9KUUViTStuK040YzhtZmZyOWllQXBhVzNWMFZwVE9nUTJaeTVLWHlu?=
 =?utf-8?B?T2gyVmJGUWZVaG5LbTM0akU4a2ttS2h4eXhiekFENVdIK3hRbTllcVU0SGI5?=
 =?utf-8?B?QnVhSnNXWWZJd2NwdWpRR1BxUGwrWEt5RHhYM2d1eTA3TlFjdXhFUjRDa1Yy?=
 =?utf-8?B?aHVXYjJraTZNcTRUUDlBdFNCMFIvUExGR3hhNXk4MTJ0NXRteFdIWDNBcUJK?=
 =?utf-8?B?R1I1OG1BTUxSV2NKMlZ5bFFrTFprTlJQdzVWeVc4YUhaN25xZmNRdkNHS3lB?=
 =?utf-8?B?SzkyblY0Si9NbjNwcnNkQnpMc0pvaE5BdEw3MlZGdmpsY3dmWHNWcElMb1B6?=
 =?utf-8?B?YUlkUDNxbFVwU3dUQUs2ZWQxYllacHFsMXF3RkJHTUcrOUhZd25aNCs5ZTQ3?=
 =?utf-8?B?TjR3di96MDBPUEovTUtNa1g1UE9BRHJvdmE5TjJ2aWcrVndyMUQzeHdhS0c3?=
 =?utf-8?B?T3ZwUEs0c01FM2NhYWNvRUhYVnE2Y0hYZ2xsR3d2eU9DL3pJQnduZHA5Ym1h?=
 =?utf-8?B?aU5CeEtLM251M0dPRHVNazNURUdzTUl3TGZBTVpYMjdYU0dOY2swdFBINU5s?=
 =?utf-8?B?dllZaE8xOTkzRUZRNjMrR1VqZitZZmx1bWNIWUpMMHhxTlVNWGRwVEU1YUlY?=
 =?utf-8?B?cXlqK3NwOWFRUmRrTUxUdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZTduV3ljQjFFU01NYjlyZnZnQzl0QTJMb2VLWHJ4aCs5Mmk4TnE4RmRadGhX?=
 =?utf-8?B?R0daVUFlZ3BKOU95ZG10QkZnWVBkcVlyamhUdmRTeXV6VmtYeGFVcU9WWktu?=
 =?utf-8?B?V1ZEYmdTS2xMdS9jQVllZDlkSXlRcEVpM3VUQ3psaE9BTEx0RGkxSkNnVlcy?=
 =?utf-8?B?b0Rrei9WNktJOG5QUS9Mbkw1UjlOUi9ac3IwSUw1cjdNdHJPQmRLMWN3WTZO?=
 =?utf-8?B?ZFZ1REN0RHltQjJlM0JXN0oyV3BSTnNEanNBTnJzSTB1dXRUckhMODZPakxP?=
 =?utf-8?B?aW5OcDBLK2hDdVY5bnpsbmZpS3Fta3Fwblgyc24wR3VWb1VxK2hzU3NZZmZV?=
 =?utf-8?B?MkFSU2VweDNkRHFkS3Y4ZncxK2hiMEpnelVDdGNYUmNzSUtmU3B5WGQvT09L?=
 =?utf-8?B?ak9oQ3lmU3RGM2FidWJrVmx4MGVnajdka1hjcXpCWVJGTDFtUGFtcUVZYmE4?=
 =?utf-8?B?QURhOTJLVzBjeXNUcGFWd0dWK1VXeERIT0ZvS1gxd3ZiQ014YlFIWFl1WXE5?=
 =?utf-8?B?Y2JnanIvOWRYb3FIRWtsTG5Lb0kzSWFENnhBeUozNFRZMjhNYTg2SjFBc2ZP?=
 =?utf-8?B?RFZpWDBZV09GNXB0MmxoWStrTGltcURTUFI1YlZCSE42TWJkSUMvenBnMDVa?=
 =?utf-8?B?YWY4M0p2QTFvZXZ4ZHZGK0VULzYvb0VjUDJwMGJnbUtad0dFSDQwVmt5U0c5?=
 =?utf-8?B?MEdHV2ZtMGdEelpMZlRoRzZDSkh5R1ZGWEFDN1lhdzVhWGlrZTgwbkd6TzRJ?=
 =?utf-8?B?QkFobGhQUGNqQ0FIbEtDcWhpa0Yxb2h6U3puakU1WEFsY2F0YkpsL2V6S3Rk?=
 =?utf-8?B?TjlUS2IwSHZ6Ykx5QXltMnVocDJoN1luQjhwQkZ2M29PSUNBZ0FTdms5V2pT?=
 =?utf-8?B?eEVNK3ZleFhLM1dkQnVDTUZWeENPbVRXOGZNT1hxTWhaK1JQeVd0aS9Oc1lo?=
 =?utf-8?B?dDVtVkdDZkRZQmVSY0xOaG02WXNXbU9aVmZPZDY4MVVkeUl3M2VXM0U4NDlV?=
 =?utf-8?B?MDk2eVUrZVcvY1NVbUxvRkIzSXYzZHAyS0hUblJSMUdFMlZRWmZOc3FGWGtS?=
 =?utf-8?B?SFB1K1Nqa0YzcjlUZUNPbUY2Y2IweWNqSEtGZmR1enI1K0tnYzB4NjNFU3Rj?=
 =?utf-8?B?UzRRYm9NbDhIMnlRREtXTk15TDlCNGhNS3hCYTVnL1FuclNhRDBrV2NqRyt2?=
 =?utf-8?B?Ykp2blA5bVBNM3kza0RSRUhselNscWdOczNGNEdvUG9JWWx0MHpMcENmV0hs?=
 =?utf-8?B?L3l4OXFtQkxYREd0ZmM2QVlPWGJYKys4TFVNVTBkSG5BY3lhSm9hQ1FrKzBs?=
 =?utf-8?B?L0JUcUYxZlErdXhDVkRVYS9hSmR0NnNtTytYWXdKTHhMamhIb3FCVnJ1M2Zm?=
 =?utf-8?B?OFJoWGloeFhsZDFvRWhtTk5KU0M0ZEM3RWRJZGdsNjQ2M2Z2NzF0em55a1Yr?=
 =?utf-8?B?cEhMYVVyRE90UmRtZXV5WlQzdllDT2FPMmFybFlJbmxSUDZjaC8vZDRXbmFh?=
 =?utf-8?B?TUNDL3g0VW1jY2VZeGlCb0VTWUU3dy9mcjFXcjZRckN1NEVyR2NIZ2NmV2U5?=
 =?utf-8?B?MjI2MytEWnpNRitzZlViaGZKZmVEdmpzcTh5Uzc0SVJtMldtTmI1SnFXL2s4?=
 =?utf-8?B?MU4vZVU0VDdlTmE3dXdGUFppcnUvN2FzaG5UTkp2MTV6TzNOcEhTdUY3Q3Y4?=
 =?utf-8?B?UEhDNklkUnNXY1NCZVNrSzZFUlJlNmZ4RGZtMkNiVEZ5ZnpEYnFoVDEvYndF?=
 =?utf-8?B?MW9WcXBxMW5MSXBROG9JRkt3OWlyRUtFV3lKRTZBR0lnckd0RDNxUFpLdW1q?=
 =?utf-8?B?SFQ2MWNhSEFVdDMyeVBiaUxMVWhIT2lKNUJBWm10N3Rud1NOWWZtL2hEcVFs?=
 =?utf-8?B?WnBnb1RLZExhZ3QyY3p3WGFPMS9lOXZGUFZEV2RJSzRPbXlsVFIrc3JZK0xm?=
 =?utf-8?B?TEJ2ZnJDbXlpTmM1VXgwSHFMQkI1Q0ZxK1Mwd2cyeldvcmgzS1d2VXdSMkhw?=
 =?utf-8?B?V3VYZllEZzhWOUlJbWJ1RXc4alRFUFNHZHhQSWx0SXQycU9vUStsV0FWNVdF?=
 =?utf-8?B?VjV6STdKaEdQeWNxWm9tQ0t1aWtROG9ZZjVub25FMWg1dWJnTW1JbFBieVlG?=
 =?utf-8?B?R0pVYU1MTkc1L2lXSUZqRnpQaTRlZmJsK1B3WTZPdmk5UEJpenBOYnlUZWNQ?=
 =?utf-8?Q?TrZ1hhiVSDO8QMISPuYFVT2gzemz/msxsynER0ctGJMW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB77A78BF09D5F42BF59433B4907CFBD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21575bc2-7fa4-4a6e-8300-08dc68e32223
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 06:59:51.9352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vpipb0ar842E8VQpGbzoddDHXPN2VhRNnWuRCbOLm+Anaf1597dOgMEwt77gNYpi0qc1q1kcGMQ1fiWgRSM3Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995

T24gNC8yOS8yMDI0IDEwOjEwIFBNLCDorrjmmKXlhYkgd3JvdGU6DQo+IENoYWl0YW55YSBLdWxr
YXJuaSA8Y2hhaXRhbnlha0BudmlkaWEuY29tPiDkuo4yMDI05bm0NOaciDMw5pel5ZGo5LqMIDEx
OjQ35YaZ6YGT77yaDQo+Pg0KPj4gT24gNC8yOS8yMDI0IDc6MTcgUE0sIGJyb29reHUuY24gd3Jv
dGU6DQo+Pj4gRnJvbTogQ2h1bmd1YW5nIFh1IDxjaHVuZ3VhbmcueHVAc2hvcGVlLmNvbT4NCj4+
Pg0KPj4+IEluIHNvbWUgc2NlbmFyaW9zLCBpZiB0b28gbWFueSBjb21tYW5kcyBhcmUgaXNzdWVk
IGJ5IG52bWUgY29tbWFuZCBpbg0KPj4+IHRoZSBzYW1lIHRpbWUgYnkgdXNlciB0YXNrcywgdGhp
cyBtYXkgZXhoYXVzdCBhbGwgdGFncyBvZiBhZG1pbl9xLiBJZg0KPj4+IGEgcmVzZXQgKG52bWUg
cmVzZXQgb3IgSU8gdGltZW91dCkgb2NjdXJzIGJlZm9yZSB0aGVzZSBjb21tYW5kcyBmaW5pc2gs
DQo+Pj4gcmVjb25uZWN0IHJvdXRpbmUgbWF5IGZhaWwgdG8gdXBkYXRlIG52bWUgcmVncyBkdWUg
dG8gaW5zdWZmaWNpZW50IHRhZ3MsDQo+Pj4gd2hpY2ggd2lsbCBjYXVzZSBrZXJuZWwgaGFuZyBm
b3JldmVyLiBJbiBvcmRlciB0byB3b3JrYXJvdW5kIHRoaXMgaXNzdWUsDQo+Pj4gbWF5YmUgd2Ug
Y2FuIGxldCByZWdfcmVhZDMyKCkvcmVnX3JlYWQ2NCgpL3JlZ193cml0ZTMyKCkgdXNlIHJlc2Vy
dmVkDQo+Pj4gdGFncy4gVGhpcyBtYXliZSBzYWZlIGZvciBudm1mOg0KPj4+DQo+Pj4gMS4gRm9y
IHRoZSBkaXNhYmxlIGN0cmwgcGF0aCwgIHdlIHdpbGwgbm90IGlzc3VlIGNvbm5lY3QgY29tbWFu
ZA0KPj4+IDIuIEZvciB0aGUgZW5hYmxlIGN0cmwgLyBmdyBhY3RpdmF0ZSBwYXRoLCBzaW5jZSBj
b25uZWN0IGFuZCByZWdfeHgoKQ0KPj4+ICAgICAgYXJlIGNhbGxlZCBzZXJpYWxseS4NCj4+Pg0K
Pj4NCj4+IEdpdmVuIHRoZSBjb21wbGV4aXR5IG9mIHRoZSBzY2VuYXJpbyBkZXNjcmliZWQgYWJv
dmUsIGlzIGl0IHBvc3NpYmxlIHRvDQo+PiB3cml0ZSBhIHNjcmlwdCBmb3IgdGhpcyBzY2VuYXJp
byB0aGF0IHdpbGwgdHJpZ2dlciB0aGlzIGFuZCBzdWJtaXQgdG8NCj4+IGJsa3Rlc3QgPyBub3Qg
dGhhdCB0aGlzIGlzIGEgYmxvY2tlciB0byBnZXQgdGhpcyBwYXRjaCByZXZpZXdlZCwgYnV0DQo+
PiBiZWxpZXZlIGl0IGlzIG5lZWRlZCBpbiBsb25nIHJ1biwgV0RZVCA/DQo+IA0KPiBUaGFua3Mg
Zm9yIHlvdSByZXBseSwgSSBjYW4gZWFzaWx5IHJlcHJvZHVjZSBpdCBpbiBteSBWTXMgYnkgZm9s
bG93aW5nIHN0ZXBzOg0KPiBTVEVQIDEuIEluIG9yZGVyIHRvIHJlZHVjZSB0aGUgY29tcGxleGl0
eSBvZiByZXByb2R1Y3Rpb24sIEkgcmVkdWNlDQo+IE5WTUVfQVFfTVFfVEFHX0RFUFRIIGZyb20g
MzEgdG8gOA0KPiANCj4gU1RFUCAyLiBDcmVhdGUgYSBudm1lIGRldmljZSBieSBOVk1lIG92ZXIg
dGNwLCBzdWNoIGFzIGZvbGxvd2luZyBjb21tYW5kOg0KPiBudm1lIGNvbm5lY3QgLXQgdGNwIC1h
IDE5Mi4xNjguMTIyLjIwIC1zIDQ0MjAgLW4NCj4gbnFuLjIwMTQtMDgub3JnLm52bWV4cHJlc3Mu
bXl0ZXN0DQo+IA0KPiBTVEVQIDMuIEJ1aW5kIGFuZCBydW4gdGhlIGMrKyBwcm9ncmFtIGlzc3Vl
cyBudm1lIGNvbW1hbmRzIGFzIGZvbGxvd2VkOg0KPiAjaW5jbHVkZSA8c3lzL3R5cGVzLmg+DQo+
ICNpbmNsdWRlIDxzaWduYWwuaD4NCj4gI2luY2x1ZGUgPHVuaXN0ZC5oPg0KPiAjaW5jbHVkZSA8
dmVjdG9yPg0KPiAjaW5jbHVkZSA8c2V0Pg0KPiAjaW5jbHVkZSA8c3RkbGliLmg+DQo+ICNpbmNs
dWRlIDxzeXMvdHlwZXMuaD4NCj4gI2luY2x1ZGUgPHN5cy93YWl0Lmg+DQo+IA0KPiBjb25zdCBp
bnQgY29uY3VycmVuY3kgPSA2NDsNCj4gc3RkOjpzZXQ8cGlkX3Q+IGNobGRzOw0KPiANCj4gaW50
IF9fZXhpdCA9IDA7DQo+IHZvaWQgIHNpZ2ludF9wcm9jKGludCBzaWdubykNCj4gew0KPiAgICAg
ICAgICBfX2V4aXQgPSAxOw0KPiB9DQo+IA0KPiBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFy
Z3YpDQo+IHsNCj4gICAgICAgICAgc2lnbmFsKFNJR0lOVCwgc2lnaW50X3Byb2MpOw0KPiANCj4g
ICAgICAgICAgZm9yIChhdXRvIGkgID0gMDsgaSA8IGNvbmN1cnJlbmN5OyBpKyspIHsNCj4gICAg
ICAgICAgICAgICAgICBhdXRvIHBpZCA9IGZvcmsoKTsNCj4gICAgICAgICAgICAgICAgICBpZiAo
IXBpZCkgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgd2hpbGUgKHRydWUpIHsNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3lzdGVtKCJudm1lIGxpc3QgLW8ganNvbiAy
PiYxID4gL2Rldi9udWxsIik7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+ICAgICAg
ICAgICAgICAgICAgfQ0KPiANCj4gICAgICAgICAgICAgICAgICBjaGxkcy5pbnNlcnQocGlkKTsN
Cj4gICAgICAgICAgfQ0KPiANCj4gICAgICAgICAgd2hpbGUgKCFfX2V4aXQpIHsNCj4gICAgICAg
ICAgICAgICAgICBpZiAoY2hsZHMuZW1wdHkoKSkNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
IGJyZWFrOw0KPiANCj4gICAgICAgICAgICAgICAgICBmb3IgKGF1dG8gcGlkIDogY2hsZHMpIHsN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgIGludCB3c3RhdHVzLCByZXQ7DQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICByZXQgPSB3YWl0cGlkKHBpZCwgJndzdGF0dXMsIFdOT1dBSVQpOw0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJldCA+IDApIHsNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgY2hsZHMuZXJhc2UocGlkKTsNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+
ICAgICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgICAgICAgICAgIHVzbGVlcCgxMDAwKTsNCj4g
ICAgICAgICAgfQ0KPiANCj4gICAgICAgICAgLy8gZXhpdA0KPiAgICAgICAgICBmb3IgKGF1dG8g
cGlkIDogY2hsZHMpDQo+ICAgICAgICAgICAgICAgICAga2lsbChwaWQsIFNJR0tJTEwpOw0KPiAN
Cj4gICAgICAgICAgcmV0dXJuIDA7DQo+IH0NCj4gDQo+IFNURVAgNC4gT3BlbiBhIG5ldyBjb25z
b2xlLCBydW5uaW5nIHRoZSBmb2xsb3dlZCBjb21tYW5kOg0KPiB3aGlsZSBbIHRydWUgXTsgZG8g
bnZtZSByZXNldCAvZGV2L252bWUwOyBzbGVlcCBgZWNobyAiJFJBTkRPTSUxIiB8IGJjYDsgZG9u
ZQ0KPiANCj4gV2Ugd2lsbCByZXByb2R1Y2UgdGhpcyBpc3N1ZSBzb29uLg0KPj4NCg0KY29vbCwg
Y2FuIHlvdSBwbGVhc2Ugc3VibWl0IGEgYmxrdGVzdCBbMV0gZm9yIHRoaXMgPyBJJ20gbm90IHN1
cmUgaWYgd2UgDQpoYXZlIGFueSBjb3ZlcmFnZSBmb3IgdGhpcyBzY2VuYXJpbyAuLi4NCg0KLWNr
DQoNClsxXSBodHRwczovL2dpdGh1Yi5jb20vb3NhbmRvdi9ibGt0ZXN0cw0KDQo=

