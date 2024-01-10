Return-Path: <linux-kernel+bounces-22807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B3E82A328
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711021F23561
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8984F5F1;
	Wed, 10 Jan 2024 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grpleg.onmicrosoft.com header.i=@grpleg.onmicrosoft.com header.b="eff0uebV"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2129.outbound.protection.outlook.com [40.107.8.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1CA4EB23;
	Wed, 10 Jan 2024 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raritan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raritan.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlirfTTcW0+Gm8wIGK8iWE+sSjexpRVnT+AwrJsiRlIak8sSpKEFh4vQ6FW4QWzEkcv+ihtSUreFSYkO9gzDwQX7B9xBrNdxtiKX46VSHkJ7ptM9FU/KYL18pNhA3rKGKfXFSXxcGg7Rgry03AFztw3X+7ZpzrBdII75ChJOtMtprpK/IQVw7KvwYT6Q5nuprEV7pvDrw1dCWy/b7anOeglHDCoSl6+HDFgrBqVS1SkT88PE/itlU92OSavfSi1SiFxIHfjObA0wqpjFk7m2Iwmoi/yKL8XT7wiAihaReh/0hvdjiT9nq/2wzAIn4qaxrZQE9Pb24OZpYl/ZwwOrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8K3Yl4g1sBvwSeI8EaB30qPhHc4bX2P9wxOR9OLAll4=;
 b=DP53n5ByRm9Eg0WOFLnbaqw6BXDnaitgfoj15j1Xf2NPKMEbUtMBsryxvnEX4HXPCJsd/NPt8+h2HmlEwVHuAPGQrqaqpdVFSxaxaoavispEmKt0X4uGq/3vlaBucY96HnFwcpDD9AKHfW8A+rQbJ9YTbjK2L8gJQB87iQz39lc7qdMHt+aFevnPvs+4X1sBboepMCuCss65qEXcZqLDhQwwV+QbN9Ks7K9HinqnH8PJgGLbVlLzgutvC+Z9sB2yWv/EfC9haaavrOPNNotMiVBM6ubQiLLPClXs7fghNOU8DOo5S0TZ7Jn0XxMDXrYo4dkHtWEJXJ1ZGMcw7YZ9ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=raritan.com; dmarc=pass action=none header.from=raritan.com;
 dkim=pass header.d=raritan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grpleg.onmicrosoft.com; s=selector1-grpleg-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8K3Yl4g1sBvwSeI8EaB30qPhHc4bX2P9wxOR9OLAll4=;
 b=eff0uebVz2rRbTMuYn/EntzUgu5z5VgfixmpuqS+3IJwlA2NC+5SU9WHi3JGgt9MEjQ982UTEvU3yQQO7Fx0ZZEGpJwQJ6vCBNtGzhmR8slr/MI8gEDXJ+bYfqHH9JpA6TayujNEA6RwNW8f95aZH2jcVtJT2LFbtStuAk+vEmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=raritan.com;
Received: from DB8PR06MB6539.eurprd06.prod.outlook.com (2603:10a6:10:12f::23)
 by PAXPR06MB8064.eurprd06.prod.outlook.com (2603:10a6:102:1a8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 21:16:34 +0000
Received: from DB8PR06MB6539.eurprd06.prod.outlook.com
 ([fe80::4fcd:156f:7416:29d6]) by DB8PR06MB6539.eurprd06.prod.outlook.com
 ([fe80::4fcd:156f:7416:29d6%6]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 21:16:34 +0000
Message-ID: <f32db542-e090-4d96-b44d-8cbef0d0d492@raritan.com>
Date: Wed, 10 Jan 2024 22:16:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] arm64: dts: ti: k3-am625: Add MIT license along
 with GPL-2.0
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Guillaume La Roque <glaroque@baylibre.com>,
 Julien Panis <jpanis@baylibre.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Pierre Gondois <pierre.gondois@arm.com>, Roger Quadros <rogerq@kernel.org>,
 Sarah Walker <sarah.walker@imgtec.com>, Tony Lindgren <tony@atomide.com>
References: <20240110140903.4090946-1-nm@ti.com>
 <20240110140903.4090946-4-nm@ti.com>
Content-Language: en-US
From: Ronald Wahl <ronald.wahl@raritan.com>
In-Reply-To: <20240110140903.4090946-4-nm@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::19) To DB8PR06MB6539.eurprd06.prod.outlook.com
 (2603:10a6:10:12f::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR06MB6539:EE_|PAXPR06MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c66357-b4bf-408e-004d-08dc12216c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y1q9Hc6G0qWHD71XWrfUsOp5VBH6AlOpDaywGSFjle+AtlsF2lb8Re9Lx6Bt1K3T07pVyXzJ/1DZuKU4vpnSbwLF11XZCuAagvmrBFRb9q2nNNehGRRnkxyYR7DDZkhWTmSnY0iD8Knf5M3IWavuI+Zji2IpzBzHLE05iHg+IgIwaO1LgDI0Od5TAz17JI/F/h8XV28j8jr6UGqQvnteyMbihWkrAwZ/kVSRUrDdxAZevuwBg8ywMvB2WVY3i3OtARtcT5Veo+XpiIFbNwLsy0IZyJ7wz/4Iw8p+QMULyyHoUdTxJA+33PISEMla4jXFqrCw4XC5NJ2eYRltYnIHIU4nr2dWpR/6Sk1b7/2Af9CQc7jE7g4b/s1+NobffXVkf/XFPO/8iXKefVLSrAgt4YSZwuW+3UxajNt8od0MLmuNogt6uG7CMSrtnF4RtCoitfrvdDhgM96XFzMk/CdZyJzyU+dkPv7T78ZcpsOMBPEK8364RB7ECKtvoolmiy0QOuWJXjM69mlo3yT2IOPi4tfMsvX1Ezm7scT+KzJx1Oue4fSHfITAj0YRM6MM7jswwQ0pIVIzeonUCph9ARMKfQl/eosmSDFwyqvzOW5DjCY5MKQLaZqocW6VHoBGxMj4itqMzKcVqoBwR57vy4tNOA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR06MB6539.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(26005)(66574015)(83380400001)(6512007)(53546011)(6506007)(2616005)(6666004)(4326008)(5660300002)(7416002)(44832011)(2906002)(41300700001)(478600001)(6486002)(54906003)(110136005)(316002)(8936002)(8676002)(66946007)(66476007)(66556008)(31696002)(36756003)(86362001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUNqeFpwbG10bnFnUlBtMUJrbXBVV3JnQmI0UnJ5ZUhWaHVMdHA1OThTRXlk?=
 =?utf-8?B?c2pTKzI1THhqVXF1VTU5aTVoWmg1ZGtMSVhCUzl1aDJ6NXpHVlM3UDlZQVZn?=
 =?utf-8?B?YzY4TFJSbmtRV0FwOG1lSTEvaW9wNjlWVGkxYTBPMmxNVVpRSzU3SUptMFJP?=
 =?utf-8?B?NEpZeWJIV0tqbDZoTnZrUU1ycVhlWXdzbFErOTk2Mmdhc0QrV25HTExzOHds?=
 =?utf-8?B?Vk9Oa3FTaU1sWWljY05mQUYxY3ZIbFhURGk1VzNmUk5nZGI0MmpHUCtCWmtI?=
 =?utf-8?B?VElSdEJ0OFlRV09ZMEcxVHd0bFM2L0s4WlVNeWk5aEFpbldqeGpBd0lMV016?=
 =?utf-8?B?TjliMUN1YXVyNURtMnpZUGdlejVNSDIyVlk1QzNlN1pTeDA4ckdzUnd4blBq?=
 =?utf-8?B?Si9leHpYUVZhNHlnVVZaZ2JBaHFNaS9HWVZCTlMveklETjhBMUtqcVhhTlVJ?=
 =?utf-8?B?bjVCNHJiQ1d5Yi9vUThhckN0TURLaDFUZ2ZPMWM0dzNJeWVuZXZEdjdLcmc5?=
 =?utf-8?B?V2ZUS3hUZTFab25vQ05ueGFGMWJJeE5TSStHajJ6cjlLbEZKbmJWUTgydzFu?=
 =?utf-8?B?VFV1OENBQmlsNzErd1dZcEZZNFZONE1oL1ZUK1hTWWRhSzhWaThQbGU2a0VZ?=
 =?utf-8?B?VXRjdHd4N0Rvbkxvbk9XTFpzN1RQb3lYRW1MdWsrc2UyYjltM01IUFVyWW9v?=
 =?utf-8?B?WHBNcThJRy9LT1IxSVdFRnNTVWRtbGR3ZmtjMmw0VlJoYmpuUWxqVnNCN2Mv?=
 =?utf-8?B?SWJPMFE3VkpxcTFBRHBkcVdYVGdLcXJ0dHFqNEo4dGtoL1hLYjQzQVFhMGNS?=
 =?utf-8?B?c0hvVllkMmZ3bjNyK1BhdGVVQjhUOVI1UDZ5aElYS3J3OGdSLzYxUExJM0x6?=
 =?utf-8?B?RTQ4R0kwWlhRVFdjQTFhOEl0WTJiSmdRNXVzYUlsdVoyOE1yOHFDWVZxMWF0?=
 =?utf-8?B?cnZDaXoyTVpiTi9nYnhlWVdHUHk3bWhkRG5MQmNrdU0zZyt0SEw0dmJTRHBz?=
 =?utf-8?B?Sm5qWUlnYkgxSmdRc0luWlRQeDJtSndYREs2eUlsOHN3VVZmSVNJK0dUWW12?=
 =?utf-8?B?Q3JzNHBPYm5lQWg0YWxpaVZNM2xxajZHakQwTGVGYjJMMzlLb1ZKWnB5Smtu?=
 =?utf-8?B?L0RRR3BKUHdDZVJrNVVmbUp5d2hkZDYvRjFBRnhOM3NSVmx1eUpSWWhndVlv?=
 =?utf-8?B?bERPRlJ3TDgyNzE1dEo1VHJHMW1wTHdCVkpwT05iTXozRS9COFhuZ2xqQ2t4?=
 =?utf-8?B?NGdoK3RySnFkVXpNNWhaK25GR0tnY2M1MG1QSVcrc1FEQUlmdHZRcWNwSm9n?=
 =?utf-8?B?QW9US1FVaForSGZjdHJiU0pnWldERTJKVWd3NUo3djU0akdWOEtYaUJEOWp4?=
 =?utf-8?B?c2NMR1RqaW1penVXc1BwMXErb1ZYL2RJT2wvWkpnSHd4d3Rpd2xieTZlRGll?=
 =?utf-8?B?WHhhUkd2M0FtRnI1ODVXVStzTHlkdUE4d1NKU3hRK0RXVkJBSjBvaTVXM1Y2?=
 =?utf-8?B?MFFVaU83dVIzaG5KSzNSc2FMN2dBbSt6aUlpbEhlcFowa0RMd3NnRkpveDIv?=
 =?utf-8?B?NnE3V0FpSWM2L2NiRGZSQ2VEc21mSUdCaXl5NjRaL241ejFrWDBsWmR3RWk2?=
 =?utf-8?B?OU9yTExVOUhENi9mNXdTSy9wTkFQWHRZSVlRb0dRam1qbEVoSlBRQVhPdzc3?=
 =?utf-8?B?YlM3TDlRUGttYldMSnV3OTY4T1BPQnJCbFI5SkJSY3cvbGwzamNhUkRkdllJ?=
 =?utf-8?B?QzFRK2hnaElLVGNvMFdlaS9nWDFiNnZXWmRpclpPOUw2MkFuU3dLR0xBK3Vu?=
 =?utf-8?B?ZVVZbitvVHhpL3pDcnlYY2R4VEpFdlJiNlc0UUhHRlhYV2RNSUw2SWNGendy?=
 =?utf-8?B?dUlRRlZaWHBFSmVUVnc0S29nUm1GWmZxczFoclhtQ1kwSGwrOUw1M0ZTeVFt?=
 =?utf-8?B?WjBhS09wTUprYlRpblZYTFdtY0pBVXp4ZGQ2bDRjQnhIS0d6Vk1WMHZHMVBX?=
 =?utf-8?B?M29HVW1ENm9WRW02WDdhcklTOGkwS0ZQNzJQcUd2eFgyUjhJUHZvV2RKQk5Q?=
 =?utf-8?B?Q2F3L2xaTnNkeU52dlhGd2pZeEdMWDFaV1I0MzRIYXRKc1prMU1UdmVvVWdV?=
 =?utf-8?B?Uk1HVGRUMEpPVnNLSnhuVXVFam5zY0dnN2RXbEJKSkZwZ1N3dlY3SFI3dWxB?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: raritan.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c66357-b4bf-408e-004d-08dc12216c4d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR06MB6539.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 21:16:34.1362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 199686b5-bef4-4960-8786-7a6b1888fee3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dtkQIx0Qj29uKLGZW6l4uDGN6M17ll4ZTvSbEpChe4L97HRQ3SLBhjFJpHsBHllrVlw0VwP3HMmUrt3Kj284A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB8064

On 10.01.24 15:08, Nishanth Menon wrote:
> Modify license to include dual licensing as GPL-2.0-only OR MIT
> license for SoC and TI evm device tree files. This allows for Linux
> kernel device tree to be used in other Operating System ecosystems
> such as Zephyr or FreeBSD.
>
> While at this, update the GPL-2.0 to be GPL-2.0-only to be in sync
> with latest SPDX conventions (GPL-2.0 is deprecated).
>
> While at this, update the TI copyright year to sync with current year
> to indicate license change (and add it at least for one file which was
> missing TI copyright).

Acked-by: Ronald Wahl <ronald.wahl@raritan.com>

- ron

________________________________

Ce message, ainsi que tous les fichiers joints =C3=A0 ce message, peuvent c=
ontenir des informations sensibles et/ ou confidentielles ne devant pas =C3=
=AAtre divulgu=C3=A9es. Si vous n'=C3=AAtes pas le destinataire de ce messa=
ge (ou que vous recevez ce message par erreur), nous vous remercions de le =
notifier imm=C3=A9diatement =C3=A0 son exp=C3=A9diteur, et de d=C3=A9truire=
 ce message. Toute copie, divulgation, modification, utilisation ou diffusi=
on, non autoris=C3=A9e, directe ou indirecte, de tout ou partie de ce messa=
ge, est strictement interdite.


This e-mail, and any document attached hereby, may contain confidential and=
/or privileged information. If you are not the intended recipient (or have =
received this e-mail in error) please notify the sender immediately and des=
troy this e-mail. Any unauthorized, direct or indirect, copying, disclosure=
, distribution or other use of the material or parts thereof is strictly fo=
rbidden.

