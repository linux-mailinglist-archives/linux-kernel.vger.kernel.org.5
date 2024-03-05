Return-Path: <linux-kernel+bounces-92992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB1587292D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28752B27509
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F16168DD;
	Tue,  5 Mar 2024 21:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="RbLmHFg1";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="RbLmHFg1"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5401812CDB2;
	Tue,  5 Mar 2024 21:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709672884; cv=fail; b=WhsF0jHS9MmzlBBOc/lS3gPvuXXZxnjRroVUq11pwZh4+iTUcgg6cS+I7gVLPZv/lc9zaOrk6Oyh7SVGYGkbx1hxKvFTOZOqmcV4dhjjZ3T4k4Bi0VF2N1Kz1NMFUiUjkBoVgPD/EnanZapr0tAB2bfiK3BcgTxOhZDS+pOTVkQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709672884; c=relaxed/simple;
	bh=UD02bVeKade0qayHj2PAHwdAuzriIUgGFBzjwuJpb5g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gdKhnWYJFYOHE9SXgeFGLDS0eVWs9TtFKzjaoqXS75ViFYDsCwFcezJxXI1TiJoSB6Gj03aNDSeKw4UgkCwTUVpzy6GADCHdQuCC6M8ihf2AlIzMIdT5sIU45dfMwRzlhx7KEbmvs2NymuFrEGfXh6yfCKv3URreHtWV5FmRc8s=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=RbLmHFg1; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=RbLmHFg1; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=mTBy+a6SnEIOWwsSSTpOCYYoxWW0MiWe61yIOWLui1bXHlkML8FswL7LPfwxIUV4vMtKZtMYr6l8ft7PjCkN+UBBF/bXaXtp+Xa/aBVdVWPWxdTMiQri/1nZOwYEizmC3vrGXsvSAKmrNrQGwyUebj+auJPdRYmenIWt+GvG0uGO4h0WWOe09TiVZFoK8AnMzm3AUlI6KewV1Qay03j4l1WDmLuSx+sdGZfyK6lzy8NaeMZuDd44BjyEcg4rfFA4QZhIUyv0qV6VWPCGhrKxD/BGvbu74PXABWum6Dryii7kq7S4X5EtedUnYogErBMcEywH1OzfU16iFaFwSEGi0Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfYBIkiD6i8UMtbRMb050+aPGAF2mjwakWwDU1FZ0LU=;
 b=CaRh+AyaiRKTD/Bi545E7GkdBZuLS8Rov9yLQvDz6X4I+lxfIqLyFDotwS6DgIATs92KmBQB1gdYvpui5IaLLRMRez4UawpF4uq1vV1QacDKRKmT/Z9altw8R1hNTFympKBFcPdVzVY1OcZj3Zz3nWJUB3ph2Diqx/b7sV/CP2Y3uAhrdEUl1c3E9E1NJxi1jWrRHFNhN4I9ymEamoXFqoCq8J0Ejr3HRar/uGObik3bXnfKTzYJTIbHnWewDlrs88o7ROGB3wbmxP2jLy+bG75YmblG4Lg/JRQ9Jq6MpFb81gdc42+3ufrGcwPTYAwZ8DUQgzDThLfwtnStwfOe6w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfYBIkiD6i8UMtbRMb050+aPGAF2mjwakWwDU1FZ0LU=;
 b=RbLmHFg1Ql/NL3IFduVPNYny/xwkxIaOu7dedezKmxWqbhbRbxlvGw7+e/utLJCYOxyDA1JtpB5hvhiypb6gupQohrGplUJ32hoKZzK3NLKDcSaUcLZHJs5d38a7cUHvZGL/2sVvrdIgZiRpMG2afoSgxtjaenw90gck5Qt4Cj8=
Received: from DU7P195CA0014.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::25)
 by VE1PR08MB5693.eurprd08.prod.outlook.com (2603:10a6:800:1a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 21:07:56 +0000
Received: from DB5PEPF00014B90.eurprd02.prod.outlook.com
 (2603:10a6:10:54d:cafe::2d) by DU7P195CA0014.outlook.office365.com
 (2603:10a6:10:54d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.40 via Frontend
 Transport; Tue, 5 Mar 2024 21:07:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B90.mail.protection.outlook.com (10.167.8.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 21:07:56 +0000
Received: ("Tessian outbound 5180408f3322:v276"); Tue, 05 Mar 2024 21:07:56 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0e6c3815e9386819
X-CR-MTA-TID: 64aa7808
Received: from 4d8cb9f73ddc.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id FAA26103-FB13-4C44-AE1D-CBD4D0C91385.1;
	Tue, 05 Mar 2024 21:07:49 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4d8cb9f73ddc.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 05 Mar 2024 21:07:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLE77oABkEWmD2ez7GPx96Tapg/TevTVV4RaqvDtbfywgrlYNWTNyC2cva049JYIvCbnnr7y3FOGuuyYKUHbfi14PjqkVfPsZzaQ6OLJY5pSTtVfQbi86Y+2vH2EkSIuhiq6S6Nxqp0NIO6wBEImuFhb+qdMswdrvL/g3fIWy0RStAsJIW6xZUAAOCsyvi/2JkB9RGDnzd6PxVj3x09mX4f9fx0LvLK7ZkNDPNVaU1zoJZsajSWaFaXppJ0ej+lK2A+QyVqlHfIutbbpqkuaqyJApiCg2rGskNpa6XIfLukgqO/LFAmOLaCg3fCu39+AciCrmOMsPwi1QyAanQLM0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfYBIkiD6i8UMtbRMb050+aPGAF2mjwakWwDU1FZ0LU=;
 b=KpZOzJx+7RY18u4VH1w8F+3A2I8RjyT6GCDVV7kGHd3LzaRFHf79fB8Aku6fZ5upoWsigcVsbOZ7JzCrWRvZVhokN4VeIriUK+DGstZ+wiLeoJoYs58kLF98ZEqgvlVKkjKoWudLzoiQXDxUINhwaH3OmgdBt/RQwbPNTKMzdZw07AjRF7Lu4ObNyY1SVzaYSHH4NUFnWItUpnb7ebygKdrMWVG0cWjayqWsGwSEoiiWVQUXzO+Y6bJ2fa4IyzNMWbxsB8EwEsB73JzvxRfbz4SnoDjpiREY1bMI7FpP33ChuuvUpPLsGUJVk1fBRXGV5gixk+XSkndiXUftTXBWnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfYBIkiD6i8UMtbRMb050+aPGAF2mjwakWwDU1FZ0LU=;
 b=RbLmHFg1Ql/NL3IFduVPNYny/xwkxIaOu7dedezKmxWqbhbRbxlvGw7+e/utLJCYOxyDA1JtpB5hvhiypb6gupQohrGplUJ32hoKZzK3NLKDcSaUcLZHJs5d38a7cUHvZGL/2sVvrdIgZiRpMG2afoSgxtjaenw90gck5Qt4Cj8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB4289.eurprd08.prod.outlook.com (2603:10a6:208:148::12)
 by AM9PR08MB6178.eurprd08.prod.outlook.com (2603:10a6:20b:2db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 21:07:47 +0000
Received: from AM0PR08MB4289.eurprd08.prod.outlook.com
 ([fe80::4a5d:48:bf49:a524]) by AM0PR08MB4289.eurprd08.prod.outlook.com
 ([fe80::4a5d:48:bf49:a524%6]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 21:07:47 +0000
Message-ID: <efd2475c-3748-48cc-9918-1cb305f3f581@arm.com>
Date: Tue, 5 Mar 2024 21:07:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Add memory barrier for mm_cid
Content-Language: en-US
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
 peterz@infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 nd@arm.com, stable@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>
References: <20240305145335.2696125-1-yeoreum.yun@arm.com>
 <b0a3e152-22bb-4502-a0a0-4b2513bfbec8@efficios.com>
From: "levi.yun" <yeoreum.yun@arm.com>
In-Reply-To: <b0a3e152-22bb-4502-a0a0-4b2513bfbec8@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::14) To AM0PR08MB4289.eurprd08.prod.outlook.com
 (2603:10a6:208:148::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM0PR08MB4289:EE_|AM9PR08MB6178:EE_|DB5PEPF00014B90:EE_|VE1PR08MB5693:EE_
X-MS-Office365-Filtering-Correlation-Id: 957e4012-4f8a-413e-0bcf-08dc3d58548d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 fS7fuojPhZU7V/+uc/1w/Ae7IVC+vdAl/WGmtEWRjLRU79+9mXGrOY4VGDX2eMZCHYd8BLxUp7mWIEsrFQr7rKNvJwa9PdmUgEVEcMRvbKy3gY13Mq6OlDeHGsdJhoGzQeMCXHJXcjka+eeVcLFb5cy9MrfFbUbCm+YWXS7aohZuTeCmMafcnLMw/H4Q2Hrna2Lt5KaWa5iznWBuF8uWdbexRYiJWnRspay8n44yC9qseurme1BwHZaCYi1UZTQape4edn3g4dLy9KMHlv2KsTlQ139gQxJm4jeWnYmYP5c8f+AKVm/la3QS04Z0AICrDbxMqJqNb01d0bSlJxODf35K+PUtHNq72Hu/3cqZLhkyrOkkI+N1ib9mbvyMRMt3WJ04PdyAimOIGw5dEIxHsSCuESkfPikcQ5AB+BXWVQiA6iLKu8WaXDoZOFV0giwf5WroalTMAJg09hGxYRMCH/jZ705C33z7Qn2VbJ+qMWJ5zkUPXvkhJS68J51EEyhHmdqdBtIvonLr+1H0LQEJXBtWAWRkmKd/KwCnFnEAJpkjvP5Jp0itTiJ7TMFgwy1ng3+9JtqdyTrMJB3BeXQ+NrzokeZQfCQJYO0LaSvF8ebRczuEoU869WFKsnBWEoI7kqagghdT1xiN/rSOVOciO4Z0f92Pkcyno820wRilg9Y=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB4289.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6178
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B90.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d1d8fd2b-1f2d-4982-fec7-08dc3d584f3d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dgXtbNV+tQZoDm2MV8czXBWFHHzHRzQYSOBAdllsWlyqfUy2N2yG6hgLcx2N+IBYRLrzhWRBwqCi9+keM6nfPqUbRuO3stiovjtG15aPoBc3CbNH2K4cj43NaiMGNet3D7aqhPoVcAJX/h4hL9JecNFdbydfmoiukGK/o50Yk7pk3q5Jb2bZwUu9Z0A6e56nE9llkiajPUscEyMSWBoz08xJRWAzRyqCB388CtkC84hqXTiz12RY+4020YEPLiWSpo/PBbLUShL8KtRQ/Xfa6JiWYE/7JgYfevEiocwWbIPerpTmSXvt2wRk0qINf5KuH1wJeo23SOnfHYuwphxa2QRcedJyBPYtLo/Cjx8GRcDXGDg16A3dYmqnXvSo6PkyeLS8n9JLzLNX2XUp0isHAjM9TAxdYZIeCse07PeFdNA/spB0NP887JtXtVDh2Nwvg5Do84QB2XZeTLRBb7yvh4bdViq4GMgMiKSqgPHTPtrYOoe7UOgBcV+APtQBga/jTsqT1SNPt5CheY7fhfCOuxJrkZlLkEUm9c6jjWYaLnzkZWnOYJkU4THql7sTTavxQ984HTRnyN3plHG82x0kUpNKH18DlhGVxSo24jY7QCk3V7R7Pq+0se08orC1jceRAEAh/cuBiHP8FR3s8/f25itJ+ww2wqvAuYIlh8YEyBWJDXBfHVhwyr+oz6tvUvpGDhcN04on4sdENINdMYx015wFIqG0VZw0ZyvgNuR+ouu6dvwpvru+/yCv/70e0uRR
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 21:07:56.4245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 957e4012-4f8a-413e-0bcf-08dc3d58548d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B90.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5693

Hi Mathieu!

On 05/03/2024 20:01, Mathieu Desnoyers wrote:
> On 2024-03-05 09:53, levi.yun wrote:
>> Currently arm64's switch_mm() doesn't always have an smp_mb()
>> which the core scheduler code has depended upon since commit:
>>
>>      commit 223baf9d17f25 ("sched: Fix performance regression 
>> introduced by mm_cid")
>>
>> If switch_mm() doesn't call smp_mb(), sched_mm_cid_remote_clear()
>> can unset the activly used cid when it fails to observe active task 
>> after it
>> sets lazy_put.
>>
>> By adding an smp_mb() in arm64's check_and_switch_context(),
>> Guarantee to observe active task after sched_mm_cid_remote_clear()
>> success to set lazy_put.
>
> This comment from the original implementation of membarrier
> MEMBARRIER_CMD_PRIVATE_EXPEDITED states that the original need from
> membarrier was to have a full barrier between storing to rq->curr and
> return to userspace:
>
> commit 22e4ebb9758 ("membarrier: Provide expedited private command")
>
> commit message:
>
>     * Our TSO archs can do RELEASE without being a full barrier. Look at
>       x86 spin_unlock() being a regular STORE for example.  But for those
>       archs, all atomics imply smp_mb and all of them have atomic ops in
>       switch_mm() for mm_cpumask(), and on x86 the CR3 load acts as a 
> full
>       barrier.
>         * From all weakly ordered machines, only ARM64 and PPC can do 
> RELEASE,
>       the rest does indeed do smp_mb(), so there the spin_unlock() is 
> a full
>       barrier and we're good.
>         * ARM64 has a very heavy barrier in switch_to(), which suffices.
>         * PPC just removed its barrier from switch_to(), but appears 
> to be
>       talking about adding something to switch_mm(). So add a
>       smp_mb__after_unlock_lock() for now, until this is settled on 
> the PPC
>       side.
>
> associated code:
>
> +               /*
> +                * The membarrier system call requires each architecture
> +                * to have a full memory barrier after updating
> +                * rq->curr, before returning to user-space. For TSO
> +                * (e.g. x86), the architecture must provide its own
> +                * barrier in switch_mm(). For weakly ordered machines
> +                * for which spin_unlock() acts as a full memory
> +                * barrier, finish_lock_switch() in common code takes
> +                * care of this barrier. For weakly ordered machines for
> +                * which spin_unlock() acts as a RELEASE barrier (only
> +                * arm64 and PowerPC), arm64 has a full barrier in
> +                * switch_to(), and PowerPC has
> +                * smp_mb__after_unlock_lock() before
> +                * finish_lock_switch().
> +                */
>
> Which got updated to this by
>
> commit 306e060435d ("membarrier: Document scheduler barrier 
> requirements")
>
>                 /*
>                  * The membarrier system call requires each architecture
>                  * to have a full memory barrier after updating
> +                * rq->curr, before returning to user-space.
> +                *
> +                * Here are the schemes providing that barrier on the
> +                * various architectures:
> +                * - mm ? switch_mm() : mmdrop() for x86, s390, sparc, 
> PowerPC.
> +                *   switch_mm() rely on membarrier_arch_switch_mm() 
> on PowerPC.
> +                * - finish_lock_switch() for weakly-ordered
> +                *   architectures where spin_unlock is a full barrier,
> +                * - switch_to() for arm64 (weakly-ordered, spin_unlock
> +                *   is a RELEASE barrier),
>                  */
>
> However, rseq mm_cid has stricter requirements: the barrier needs to be
> issued between store to rq->curr and switch_mm_cid(), which happens
> earlier than:
>
> - spin_unlock(),
> - switch_to().
>
> So it's fine when the architecture switch_mm happens to have that barrier
> already, but less so when the architecture only provides the full barrier
> in switch_to() or spin_unlock().
>
> The issue is therefore not specific to arm64, it's actually a bug in the
> rseq switch_mm_cid() implementation. All architectures that don't have
> memory barriers in switch_mm(), but rather have the full barrier 
> either in
> finish_lock_switch() or switch_to() have them too late for the needs of
> switch_mm_cid().

Thanks for the great detail explain!


>
> I would recommend one of three approaches here:
>
> A) Add smp_mb() in switch_mm_cid() for all architectures that lack that
>    barrier in switch_mm().
>
> B) Figure out if we can move switch_mm_cid() further down in the 
> scheduler
>    without breaking anything (within switch_to(), at the very end of
>    finish_lock_switch() for instance). I'm not sure we can do that though
>    because switch_mm_cid() touches the "prev" which is tricky after
>    switch_to().
>
> C) Add barriers in switch_mm() within all architectures that are 
> missing it.
>
> Thoughts ?
IMHO, A) is look good to me.

Because, In case of B), If you assume spin_unlock() for rq->lock has 
full memory barrier,
I'm not sure about the architecture which using queued_spin_unlock().

When I see the queued_spin_unlock()'s implementation, It implements 
using smp_store_relasse().
But, when we see the memory_barrier.txt describing MULTICOPY ATOMICITY,
If smp_mb__after_atomic() is implemented with smp_mb(), There might fail 
to observe.

Am I wrong?

Many thanks!


