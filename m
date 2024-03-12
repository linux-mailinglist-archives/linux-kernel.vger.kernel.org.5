Return-Path: <linux-kernel+bounces-100856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F14C1879E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6872CB223F3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1802143C60;
	Tue, 12 Mar 2024 22:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="ympdziFI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="oNAVG5bc"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2133.outbound.protection.outlook.com [40.107.20.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B6E7A730;
	Tue, 12 Mar 2024 22:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.133
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710281597; cv=fail; b=H9OUC3G4T8ilDIgXPPjGdDbh35k47cbblKOwFodqtgRV95vCswUmvrj/ALM5HORPhak7b3Uo+a607FtICq9tLhxbJURxnMAiyio1e5RK5Hph+M0obw4DIDnfhEy2LE35BVjl12I3px9MENU2o5thUic+2zPbfmMKFK0qVVgbFao=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710281597; c=relaxed/simple;
	bh=kfil70xBlmvfw/3BuyEE4Ey8nT/hA5c6ginjvmDu/xY=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kl7yOvqC96/tsPgmLhXVv76HzM3mT6AD7Yvn9hPQit9CmSZY94CPwGsarBorJyEf51UxrdmCM/p2sXzweWoVxjjtj1IUg0/gE5hqgYDnsnna7qGJV3zBm9tUNW+2bXL9PV9RH4Vnjc6b16FMdmD5mYG1JJs2EFxTWSD2axQt1Po=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=ympdziFI; dkim=fail (2048-bit key) header.d=seco.com header.i=@seco.com header.b=oNAVG5bc reason="signature verification failed"; arc=fail smtp.client-ip=40.107.20.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=M1pja1qdvgN0mMbj1mIIBtrCW7XysZVe2/3my/f8ROcKxO1BC6mcWa0hXWMR2AT8mpQI8+pcdEQeUC/G81FMdELIGCPKoMJOlBN1Unl6jJwXaythhkg8vs8qpfMLX7n/hgahZCyw1AGbYvRiOsGOxn1Acz+T3omPcRAbogjpc9646Y+zYYYZJ4xItD4tX/lav193F4TgYabFQGDp2a//kFAN+OyWrFH3/B3G0+AICl6n6ZjM0is9Fd7Mw1R+a2Q7F9cUVSJcP125tA/mBgQMCPYomZSmV3XrSLbPhJc0yCRl67Z83hMNU2/0Z21ZxtbKDzo9BiapUfqQM4E5IECbuw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfil70xBlmvfw/3BuyEE4Ey8nT/hA5c6ginjvmDu/xY=;
 b=RDXRvJQ482oIU7q2Kosdr5RC42QmsvhDONKfk65zppvu3/gOvHxjVby4jtI3J2VZGDDYwuvRBvBTxyhyU711yprKRg6v0nS6KVaeK94EEvVP5DzRwBJ0DWgYqu3tzXFUiy4vuDkxBdQZYjWocXYcmsKCXjuT4ANAFDZrrYj3sK+E/uc3aN4KEPzxGm46Ka5+hy8XCBFujoc9ds5b8W1RoUjRMcN9q4J0KjPC1HhZxF889XzO+vbqDB1ww0v7FY37O3MbleBwc0cwdl+EtvPYJHiHjlDOpRS8nWyR5zIlM06liKhMct1zsGPY9+RmdMRuhUkxVV0R9Q5Z/wzM3Tbmpg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.85) smtp.rcpttodomain=bit42.se smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfil70xBlmvfw/3BuyEE4Ey8nT/hA5c6ginjvmDu/xY=;
 b=ympdziFIKALj7dpTuoh4eY13KWdtW64uscac4yVPrWuML5s6oxX5xeb6B9gHg0ztFwMteznI65VgZttyBXlWZbWHqD54MDcbeBwI/bdbolYPIQjMerTJwKULplUd1w8+VkgHVTd9zTpVlxvtdmSmySlGtuhxy6D7t5Gm5upMYJaTSg11BqI7JPdL+pGSwx6mQEpWWhGcHXM7hbwWAxIDZxB6rud8E2B91k9KnCs6b09MvAweaShexvXqYNxOIsY3ppfIMe0Ke+t796d3G7/UxEBsSFtgEKbmMBLaC56Bcwvd2HlUSHIPCxgvY8ArOAkUvGC8USxhzmMlzqb52Sm1yQ==
Received: from AM5PR1001CA0037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::14) by PA4PR03MB7168.eurprd03.prod.outlook.com
 (2603:10a6:102:109::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 22:13:11 +0000
Received: from AMS0EPF000001A1.eurprd05.prod.outlook.com
 (2603:10a6:206:15:cafe::83) by AM5PR1001CA0037.outlook.office365.com
 (2603:10a6:206:15::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 22:13:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.85)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.85; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.85) by
 AMS0EPF000001A1.mail.protection.outlook.com (10.167.16.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 22:13:11 +0000
Received: from outmta (unknown [192.168.82.133])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 012622009538A;
	Tue, 12 Mar 2024 22:13:11 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (unknown [104.47.51.233])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id CA9472008006E;
	Tue, 12 Mar 2024 22:13:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzkYxw+YNy6VWBai0XZv0WTyg0Wc6pBxcSzqdr4BkYkrSoJnDUtYStWCuhdypQ1S4yqE4cNciCVXIgAQ0sSn7hfHp0ezMc+Hweg9jVhGt7XN3mJt1pp84UE9c1v6C8yPiTonhvvtz3tcjgS4T4DX8uibCCpBW3DSBe8YU5oQdHUUjRMVarTIaVy+y4vj3qoTDDm2TeGZp/78bOh4KKNmc2nC8Ax20BYhBJX1mIPWQw9hYD5/3LbrC7qQ90Klo2U7IgeIgYFf5dyl9aKmEkqqUJ5k4kKPps8FInSH+5GaJCInqp/Pd47L/rlH6NA22cl7Oq+Ktogpg2nLXX59Cmfg/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcZAKM5JZrDETdpafKi/Z69oPj7yVFddkDggeAeBZl8=;
 b=CdBBGM8D4wKxcNHFPdfe5B4rMefSqwvL4Fyx5FY+LjA26GNBX+IlsaPm4QE+SlGO8JQWYphWu1NiZpko9jIQnxhdsxDwm9wBEEi8uyjFScPFgWpB2DGrstMWw77rpbhroAtQv5Q2qq37IqQgl3jahkr9WEzoDGsdunWkzrb6F0Y8+ku7KonF6Y1v+LYZO0UqcafEgz3cOAV/IKRDJRPWhbsMQgik45h5C6AjH1BTh+j4MbrlI83Gc/9cmNPjIT3nWabU5ZnUJUedcxICjQV8p1+TuMNcHgAlAkKQiBQIdlwjv2xe6K6XgNcTtf30ABm09tSIBg8PH7qIEEk8F+Q1Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcZAKM5JZrDETdpafKi/Z69oPj7yVFddkDggeAeBZl8=;
 b=oNAVG5bcfTyRUBq37raHvPX9O3xBIE+Yd47g+yZQlWgL3E0O46LTYptKpAtMIgPl2nua5dY3fibhsdoAvyL16qgL6kU6pNrnPIxGthfpfKtvfR1Py0L8r/VX7/nivq1Dl8Hx68veAUAX/D1tOFWF4F4UJYivkxm4n8xiB8NrqLa/v+oWm95U62xoBNREo4rI0Qm+W/ohGegWWTHDCa8VxXNQ3VIlh98BxeAL1q+ckZxAT0D+Parxj5zWBhdh+oMOjIzA0Fug4XVaTck27DoxfKOVRaFhZMk0SsGvd956KnNQl1ApMEB04CnTylLh6CrACS5zaW/FZxZ2I2LI5QpVvA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DB9PR03MB8145.eurprd03.prod.outlook.com (2603:10a6:10:373::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 22:13:08 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::84d0:c817:1e20:5554]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::84d0:c817:1e20:5554%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 22:13:08 +0000
Message-ID: <3bfc0393-70bb-4120-abfb-530eaaa88b25@seco.com>
Date: Tue, 12 Mar 2024 18:13:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] nvmem: add new NXP QorIQ eFuse driver
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
To: Richard Alpe <richard@bit42.se>, srinivas.kandagatla@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 niklas.soderlund+renesas@ragnatech.se, Michael Walle <michael@walle.cc>
References: <20230410082051.2948510-1-richard@bit42.se>
 <20230410082051.2948510-2-richard@bit42.se>
 <7fc69bf7-4f89-41c0-a800-6e7d450d8b20@seco.com>
In-Reply-To: <7fc69bf7-4f89-41c0-a800-6e7d450d8b20@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::23) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|DB9PR03MB8145:EE_|AMS0EPF000001A1:EE_|PA4PR03MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: c44f5d77-f66b-42b0-a20d-08dc42e19ae2
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 s1/sRoKZMCFjcB19WOo6DXNALh4ztyPWiNXrAsXjMS3JOQXlXGDYXflWBNzcBsHgwDvkc/JsfV2pgGcbbZ1Qp8fnwdF8Pp2m/o7JAUoLrSRAIcBhbfA9lHAh7bs+bhqxcj5j1QwhuxhhN4xQQyQOk1G1JKdRBev9Z7xHjeklp7TEpZPhZ7hjRmg4drLD1yW4YYeuZFi0tuePtUAIewYBjKvixm/QGUFr5dor8S8hwXoueGDxwDFkK3EpfT7xAkuM9jRs+2Qe+U91qbsOsEJJwAlfHeTxwGBSPI/Ou+tW4Ddwe/aHOn3oCtWpC3Kh4k0Hua29NUvYOxHaNofuMjHfa99WiDL7Ipb6RmDWnEC8KeOjqTpphUcKw/S9xun1TXUS3NzwTa9CMVQ0gCsdeyWswGeR2MF1d1Itq9UQ93/yAuO75k6xG5v/6gPj6df4g+OmTlWDEk/EWFm3ZXabm+Q40tCA9KG755ax+WYE7QacHvsX5PDRiDp3qRRqPg3j/IBEYsTn4reEXLGUVGNNPwg9/0d0oWy7qoWssaq/XWOBC/tXaq/0NQj4ZfOupceY7nQGeg0JYMHmRSGxsmm8BWKPIFgB12x0tUeMqZ0v1D94RvmlLmR+0x/p3rimfEouPQiAwOvytIR8YvekI+jkrsY8fH0jniMoVLIKuTBxWW04Km+CLXCHUMUB6h2OuaNmIstSdX2DaWVUpn/UWwqHOCq0T93sEOCLjgkdxwOQMaYmsrA=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8145
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A1.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2a2119c2-3c2c-435a-7e02-08dc42e198ce
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BA9NC+5jGLbldb/KcCDTnVF/wzfJwtD74kQdUFZZBGwkyLzi5nAwfj6v/fEnA3LJMyszSFBrCIKAWK1Fbff7iyT7V8P1gvwz5eq9HsV1eNH8c6/YrFxrszpD9Yun6oYl1WloWA/FKQDiPSqYimaqQOeGEDypNkT3FjVCitDpBWE0/Gj4QnRqP/3H/oevoj6Cwt1lmfjfzEL0Dc6zlNTaG1XrC39Jiu9fBGEqbo9T8k6aLhcj38F3kj3ilBSPRskp7WdN+Czi2L9ZBFJQLBtxhVt5NmJSRCFKwSwZp8A0yeByyQmllW9bO7AXnC01uIPj3lsENc2WRdgaEqTAnPQjZRJ2NjbRAqduvLWr/YXxFWaSFn8xgyeoTELCRNfYMs/OxN1JuQXC55UikvJ6rT87ltw4fEwUljhAktkV+tzf+RXkMv8U2Iq5yS/JVxroPGy9ww5S2bz2qZblXt2Ndw87OFn32kSK4WQ/hgeywsO4FUTMSO/Fc8yQM9S3I0PVv8yf/fC1guVdgVJoG9PQoxlp/Fflhh99O9MadU3pxuwDjJUVgt9nj9xC7Z7oWOS7Luo+R9VOkDxpxxl3EQtkbvbrNsgUNF66RJ5T/+ctZ1HfSpT4Mogn/uHshPPHZkUDJUblE0aeaL++sMNccU1cClfW9bNvCbbdCCb3x8kISY1th+vzj4ocj7ooIOzrWokEeJEvqCIR+Z3ffGUeBzVurtFC1dIk3yVEZKPOuLEHR+8l7JndDKVydJKQ9pB1yUB+SBEw
X-Forefront-Antispam-Report:
	CIP:20.160.56.85;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 22:13:11.2917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c44f5d77-f66b-42b0-a20d-08dc42e19ae2
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.85];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7168

On 3/12/24 18:09, Sean Anderson wrote:
> On 4/10/23 04:20, Richard Alpe wrote:
>> Add SFP (Security Fuse Processor) read support for NXP (Freescale)
>> QorIQ series SOC's.
>>
>> This patch adds support for the T1023 SOC using the SFP offset from
>> the existing T1023 device tree. In theory this should also work for
>> T1024, T1014 and T1013 which uses the same SFP base offset.
>>
>> Signed-off-by: Richard Alpe <richard@bit42.se>
>
> This seems like a duplicate of layerscape-sfp.c. The hardware is
> (presumably) quite similar, with the T1024RM referencing the QorIQ Trust
> Architecture User Guide version 2.0, and the L1046 (e.g.) referencing
> version 2.1.
>
> I think this driver should be removed in favor of the older driver.
> There are some problematic bits: most notably no offset is applied by
> this driver, so all fuses have an offset of 0x200. So we will need to
> implement/document this only for the "fsl,t1023-sfp" compatible, which
> has already made its way into the T1023 devicetree...

Actually, it seems like the driver was added long after the compatible
was added to t1023si-post.dtsi, so maybe we can just change the semantics
of the nvmem cell offset.

--Sean

> This really should have been caught during review; a quick grep for
> "SFP" would have revealed the duplication.
>
> --Sean


[Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/embed=
dedworld2024/Register/ew24517689>

