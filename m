Return-Path: <linux-kernel+bounces-153290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B358ACC0C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01DA71F22C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79241465B7;
	Mon, 22 Apr 2024 11:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b="TeRQmm4I"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2135.outbound.protection.outlook.com [40.107.8.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616FF1465A8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713785460; cv=fail; b=CQYBcXlyiTOb9r20/UxIBv1aQxFFjGiPgSLEzrOWgLC9UFxC8r53P0269WLrr9qdJjDT+sQrOUqh00C0k2+8P4VvrxWUVqxoYiAZ/1ESbyh63pQB8bZlaZAfJ/+Ip1zv3Gwa04cg3Blqo25I9lpkD8iFCcDaSt5Pz9bqivFYTrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713785460; c=relaxed/simple;
	bh=d5idK2n4cRg4nxRkBmmD7LMnbrCZt4fIXOrd5rDb9MQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=svrmteGzT4DgFWUQt5+7n+rh+BCGMUbcqE/QRowwtMHkFA854rts4S0CR8wbG4eggcJ057PsR/BSc804aKSBDn64KsFd0DBrxu+VMmh+kHWbvJhpwLBIW9SbsbMmlbgnvOtDrRoDWcst4SyVH+TT+/IaG7ghekrSsdJZ4sJB1oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it; spf=pass smtp.mailfrom=santannapisa.it; dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b=TeRQmm4I; arc=fail smtp.client-ip=40.107.8.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=santannapisa.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2MaH5WWvtDHkz+QR6LPa+VM1CjQvVZWiY3egZ76PvT2aQfnKqxpDGxVE1LOk94xv96k4XsXyBHI+Xg5qsniCkrSWHXOb3MUsQ0XJZNQHvCXUNiogroT73RF0P71AVq0MZGtEi/XxEuTsWxXm5B2IJeDGkNIM4Fmj6sejBtdsg9L80Ags43612O6U8HuoyJ/EL1r9BuSUb11NZ6RhCwNiBY+kgWgr6ZimtcOtcLQ7J1d5GmUiXVReKnm/g+l8HDspUrhRmqmHCnL8VLNe32l/RqhW+0UjLCOw/h0mFC6+rQe66ryPhyABKtstRYOddkoGDR8P54ZWBLhwTW1PRPMXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5idK2n4cRg4nxRkBmmD7LMnbrCZt4fIXOrd5rDb9MQ=;
 b=QuKmoFnPBg9IUJMGyyh1yh6geDAki5RL5EfK9cOFpXjmlSLbAB2qH3eX+cvNr4286KoDpvdWtbqe1e9r2JTGb6yFhp0JHYv6PlB7SwaSZri68CZApGJIhdDaSP/WrcAL0ql8NRzBDvkXxrCULR6dqdn9XVog46rwHZRsdqXEX5u4+ABugGBXV+NPkZQfeKq7XX8E9XRHd/3PAP6xvSmqagC7RCQQ5aEbbmgk4vExp1HnpzHcisfTI1/7WEsHrw7pA6FwyTt+twkdm90A0J+zeKvIkkZu7wuF0liUlyCqYmXwa7GZ2mAi9oAfiwnz5jIKaEctQgtvleWIcQXFyWa5Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5idK2n4cRg4nxRkBmmD7LMnbrCZt4fIXOrd5rDb9MQ=;
 b=TeRQmm4IVvjmJd2bbbdd0/OgXeC21STeOu4bZ0Thc80Z4NydAqa4VklLWELJ2Or1m2jdvOCfQn36eEZHzrdybcb8NPu+i/VUIkdHDfXQUKAayMdrTob5AI59g53iYDGhBCjnNcdlmBHHVDwBzzbTngi4Y3iXElgAW3TUAfIw/N4=
Received: from DB6PR03MB3109.eurprd03.prod.outlook.com (2603:10a6:6:36::30) by
 AM9PR03MB7693.eurprd03.prod.outlook.com (2603:10a6:20b:41d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 11:30:54 +0000
Received: from DB6PR03MB3109.eurprd03.prod.outlook.com
 ([fe80::2f0e:5d1c:af40:b510]) by DB6PR03MB3109.eurprd03.prod.outlook.com
 ([fe80::2f0e:5d1c:af40:b510%2]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 11:30:54 +0000
From: Remo Andreoli <Remo.Andreoli@santannapisa.it>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [CALL FOR PAPER] RT-Cloud 2024 - The third International Workshop on
 Real-Time Cloud Systems
Thread-Topic: [CALL FOR PAPER] RT-Cloud 2024 - The third International
 Workshop on Real-Time Cloud Systems
Thread-Index:
 AQHalF3zea50OvMwGkay2PMKvpqzYLFzlAWqgACK7FCAAAJtlIAAAUJGgAABAqSAAACLZ4AAAu0JgAAA2NKAAABJ0g==
Date: Mon, 22 Apr 2024 11:30:54 +0000
Message-ID:
 <DB6PR03MB31096586192B53C20BA89482E7122@DB6PR03MB3109.eurprd03.prod.outlook.com>
References:
 <DB6PR03MB310941F3EE189785A9BC0517E7122@DB6PR03MB3109.eurprd03.prod.outlook.com>
 <DB6PR03MB3109103234B6635A558458CDE7122@DB6PR03MB3109.eurprd03.prod.outlook.com>
 <DB6PR03MB3109EC9A63FBF901A23B06FCE7122@DB6PR03MB3109.eurprd03.prod.outlook.com>
 <DB6PR03MB310957DE025B7DD020867F1EE7122@DB6PR03MB3109.eurprd03.prod.outlook.com>
 <DB6PR03MB310911FC7A35411281D1D125E7122@DB6PR03MB3109.eurprd03.prod.outlook.com>
 <DB6PR03MB3109EC184B10C50945E0A2BEE7122@DB6PR03MB3109.eurprd03.prod.outlook.com>
 <DB6PR03MB3109783E2B263935AB607A30E7122@DB6PR03MB3109.eurprd03.prod.outlook.com>
 <DB6PR03MB31096D7024DFD61675CE45EEE7122@DB6PR03MB3109.eurprd03.prod.outlook.com>
 <DB6PR03MB31090859399097E6BC3A4A8FE7122@DB6PR03MB3109.eurprd03.prod.outlook.com>
In-Reply-To:
 <DB6PR03MB31090859399097E6BC3A4A8FE7122@DB6PR03MB3109.eurprd03.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6PR03MB3109:EE_|AM9PR03MB7693:EE_
x-ms-office365-filtering-correlation-id: 17159308-dc68-4d93-1ffd-08dc62bfac27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?bzVFajhUNjZMcDhCRnJQVGs0aml2aFNIc0djYk1PSkc3ZzRsNG5QOG9MeTcz?=
 =?utf-8?B?TGRnb1ZZbXdBY2NDQkZ5Y2Jad3ZwdzYxWWFNOThmSy9iaWtrMk9WL2FqTjJI?=
 =?utf-8?B?Yy9vTVhmQWpGYUJLcEhlbWd0ZTZMMjc4V28xaHRuNitndkQ4RzMzWDlIKzVv?=
 =?utf-8?B?Y2tOVUNUdE4yTEdabmM2MFU0OGtiRWVSYVFYZnI0RkpvTUxnTll1MlR4UFVq?=
 =?utf-8?B?cVFPSllhb2dBV1M3d0VFNDdWVmtCQkRxQWpQVmtSQnhaV0dyQ3ZoTEhHNkEr?=
 =?utf-8?B?aUhZTkVXNWVLNitYV3c5MkNjTm5sZVA1TTN5Q2Zoc0IwQ094ZGFMRW95YmZY?=
 =?utf-8?B?UXZaeVhvb0N1aW1CZlhnTUhDYVNEem1GVEVzTmg2MnFxYitKRUcwdE93ZC9u?=
 =?utf-8?B?bG1mdWh3M2ZkOUp6cFRqc0lFR05rQnpKRUhLVmh3aHdlVjNBeWFGU01aZk9B?=
 =?utf-8?B?Nlh5RkMyelExNXQ3UHhsZy9xM0pGa1NxaElDV3VJUkhPeEc4cVN0Yi9NVS85?=
 =?utf-8?B?bENEaDRqTS9NakpDaGdxV0NBWlc1aEgyeFZZRXBUU2tWWHFKcEo0YldzcWE0?=
 =?utf-8?B?aUltZXBMd2NFS0Q0ZUFBbjkzdlhEQitUNTRwb3Y5aGp4Vk1YMk5VRzEwMXNs?=
 =?utf-8?B?MWg1SGxFYTRuMnBWVnRaMlVobjhBTmRJSjI2SS9sczdSdkgvbXdHc1d2Uno3?=
 =?utf-8?B?TlhDbGl0U3EzckVVUStZRmxBR3FWalRMQ0NUTDF6NDhXZmFaOWc4U3JUMUNG?=
 =?utf-8?B?T0pXSWozU3hGYnRqZkNjUXFvZWJVS01sUStxek52MXY0UXhnZzBuL0tNN2V2?=
 =?utf-8?B?dUk1bGpFVTlZVnRLSzJsd2lNVExhL2hEa3FqUmIyN256TFRvU0NWUUpTNmFZ?=
 =?utf-8?B?dXgvcXVYakF3SDVGbnI0V1pIdVBSQlMxZC9lNnNjM2YrZHQzSnc5UWxGSlND?=
 =?utf-8?B?RG43TlNFcnRwaTlTV2NQY0V1UEhNWGQ2c1JTR09JaTBQWHBlL211ZjA0Ym1l?=
 =?utf-8?B?akdVZVMrMzFDK3JTc1pHMDlwU1htUE5qWXdwZksvalI5a010S3NsMlNCZGRO?=
 =?utf-8?B?NHRFQklRTXdrSy90NkZ3T05sV1JGWFpIakxyMXlqWGVMY2tzUVF1a0o2OXlL?=
 =?utf-8?B?UGZHbndDOTFEemQ3RStDazlhRjg4dW1HZi91QUdhbVNZZ0ZkVUJuZThCTWdr?=
 =?utf-8?B?K0Zqd0d6V1JNRVRUZEllcUFZekQ4SEZlZktpeU56SDJxK3ZYeTR3QXNseDVo?=
 =?utf-8?B?dHpmZ0VnaVdTWEdiQVBCUE9oVnd3ZlQ5emVDdDdWWDNjTjdNdkNpemZZeU84?=
 =?utf-8?B?dEowOTRjcWdsNElqUCtTNGNPaUNMSkQzODBBT3g2RmM4THFGMnBDVjRsMjhu?=
 =?utf-8?B?dzFyTjU3bUM1SmZ3ajJQS3B1Wm0rYURISmRsOWpZRGFCaTFjcEl3RWJxdEd0?=
 =?utf-8?B?ZzAza0NzaHVwYmJqRW1KQWRyV0JDc3l6WWxDZDN4OENBdU1sMFFydTBXclM5?=
 =?utf-8?B?Vm4xNUp4TWJySkpOcXdCVkFOdjI1cnhYWUdROFNseHBXWW9qYUkweFdjRTNH?=
 =?utf-8?B?RUxzNnJPWXd2ZWhRZnFrQ0g3Yi9Fa2tIOVJ1UmxjYnZKNE5RUU5nR2pEU21u?=
 =?utf-8?B?K0t4ZGR3Yk5SUmJwOXF6QkRUNlpidFBVWjBFek95LzBLaHVZVzllelJ2VEF0?=
 =?utf-8?B?MmdjbWVWRmI2cTdHcDVWQXVsNFkyelhuTi9CQVFoRm40NFh2U0Q5MFJRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR03MB3109.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dHZobVl6cGFGeUpIdVYzblBRNkJVRE5rbEt2M2taRFRVeExQUk40U3ZFbnhH?=
 =?utf-8?B?emNKWlZOZDd0TG9WM3RJWGJFbVBvNVF1Y3F0V3hTNWhSbGxaRlgzYmcrQzg5?=
 =?utf-8?B?TTdIMnlKeWdDdy82dzJzbTBDb2xyWlFTY1Q0UEJqYlNpYXY3ejFTUUJjVlNH?=
 =?utf-8?B?WEtDYnEwTUZoMXJiV0lsWjVHNmVyLzVyd0NPRzZZWS96dTRlY3RIUlNWTGFW?=
 =?utf-8?B?aGxlNit5NHhLY0JqdFlBTGNDTjFTcllTaHZMSkhaQnR2eEhkQ1dlUEhwV3Zm?=
 =?utf-8?B?N2Q1MXZaTStRY2UvNFNRUkY2RGE1ZXlKNDZxNXNWb3MzS2ZsUVRDNVZBalV2?=
 =?utf-8?B?YjJyajhQMVZ0OURRck9DQkI0UzZUcXY1dGwwVXhVSFQvcmZlb2RlTzd2QzlF?=
 =?utf-8?B?K0p4cldTeWxwQ0xBZGw0OENrU3BlaXVaYU5Rbno1VHNEbG1ONUNtOFovckR6?=
 =?utf-8?B?dDdGc3Mvd29Bc1k5ZXhneTZsSWhXeUJzV3oxL1NtV0NJb1FhNG9nbjVlY0s2?=
 =?utf-8?B?cHRZT2YrbHIraFV0dmEybFRtWVkvcysvRFlVcWEyM0dFWjluRFdaVkhTb25l?=
 =?utf-8?B?NVF5aUVOa2xmb1AyWU14elFNZHgrTk1ZdmxUd2lQR05ONUJHMEVnREc0VVpE?=
 =?utf-8?B?MENjaE9DejJRZ1AydzlmcVBRSTQwcEw0MlUzSEhpR3RTSUc4akt6ZEZydWVE?=
 =?utf-8?B?REVRYVMvRFN1MnZpV2p1OUZuQyt6YnNmU1ZnU09jT09ST052K09HMVRwanI5?=
 =?utf-8?B?WnZOMEZsZVdONXZsSDJqMk8wc2JyY0ZycXZLaEhNYlV5RDlKVzkzeVdwbFk1?=
 =?utf-8?B?bDZ3MXlwTXpPakU3b3ZOMkhXZ2tuemx3a2VVODZxYWhybmk2Z0pwSXJDdFBG?=
 =?utf-8?B?Q3NhWjFlb3lTUEloMXZwazlVVlRTd1JEMGg2bnllOGkvSFVVdXZLdE04ZWts?=
 =?utf-8?B?N2RqOURUL1hyK3I5d29ReE5oS3U3dFNhRWFKd3ZrQU1tcU0vVXh6Sm1FR2pm?=
 =?utf-8?B?UkJFWUVQY0R3bEVXdHoyQi96U1ZKVFhiclNGVzIwZWpPc3ZqMHZTSWZodGhk?=
 =?utf-8?B?NEdBejRFM0lnM1VLMGFsN0duR3lDcDJLNWhJMmdkR3hsSVo0WDFYUHRRZE94?=
 =?utf-8?B?SVdJb3dYcjN5a1BqYXB6UHRqSDFNUFJncE5lMWVsN1kycVlkVTVIemJLdFI4?=
 =?utf-8?B?RmFOa3dwUjMwTUFQSjJEcUptY0VUM3NPQkVEcmdQKzZUWlpiaEErZUVDSkJE?=
 =?utf-8?B?TEpTZDhYSmxka0dYdHRacVplS2I4VW50bFgyaWMxYjg4Ym1ObzdST2pUR1Jp?=
 =?utf-8?B?SWVvWWRUVmVHS1VqbjRhWG1qQ1RtK01qdVBFc1Z4bXcxYXlnUnlxcDg0Mk8y?=
 =?utf-8?B?R3hsTjc5bDlYZnBlYVBWQXF1MFhVcmV1c3pvbU9yZG9xS2NUQU1pc3FQeisx?=
 =?utf-8?B?WFRZb3Vqd3hOa1hwclJ2dTBXK3J1NTYzd2NSUTJ5alFOVy9IaE9TL1QrdXpk?=
 =?utf-8?B?TE1BdUNiRGMxR29ZSEEwODdFaGdBTDB3Rjg0K0tGRm95TXRHMzcxNzNDalVz?=
 =?utf-8?B?K2JhbXZ3bmYyK3k1R0pjc01HcWhlVEJJenEwSUd1WjB1TExabFNIYUx1OUM4?=
 =?utf-8?B?Y1F6aTRUOWlkV0k5eGtNdWtuN1VpVlQvd1pHTzZNNjlxMVhIdEl4OUhkOWNv?=
 =?utf-8?B?ZDdTbmFHZE1MQVNYWVFVUXhYL1dyZWFqbnlIbUx0K2EvVFV3WXVJZnhvRzhx?=
 =?utf-8?B?UXJkNFNsUjAzT1lLTko2Snd0dW92MVZlRkRwc01ueVFzM1NVc0xiVUliRnEr?=
 =?utf-8?B?MEhCdnkrREgxa0xydW02NmlYclRWYmxQK09aSGoxWXRuKzRwUmtKSGdLYzlU?=
 =?utf-8?B?VjhOREtEcXIzbjREc2JZR0Z3d0ltZEZXRG1LVXRTOWhITks5VEtENEJIUFRL?=
 =?utf-8?B?RjEyQ1RIMk1mVnpuODkxMWdxY0dVc3JJeXBXOG1VRlUxNmo4dDJQSWljNHYr?=
 =?utf-8?B?TkxPU3E3Y0ZWa0FHZk9XS3RNWkVKa0s0SVJKcEdKbXJmUG1WeThFK3FESDNM?=
 =?utf-8?B?OWhqRDdyRnNLRENGNkl6T0hUWjZZTGZNYjlTb2huWlJuNWdYN2sxSnJwUFJJ?=
 =?utf-8?B?NXdURXlNb1RxckRoNHAycXpRQng1NldhWGYxR0VZSmFTTHhrLzJzdi9HdDEx?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR03MB3109.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17159308-dc68-4d93-1ffd-08dc62bfac27
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 11:30:54.5955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lPi2XGAPjzK8qPWig6kjySdybXudv+trFhuflZ7Da4hEHJOSxt5OPz3PWFiR7pOF287VJp1evQvDI539BJ4OW1UjZgru7dQTBm3i1obKV1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7693

wqDCoAotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBU
aGUgdGhpcmQgSW50ZXJuYXRpb25hbCBXb3Jrc2hvcCBvbgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoFJlYWwtVGltZSBDbG91ZCBTeXN0ZW1zCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKFJULUNsb3VkIDIwMjQpCgoKwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB3d3cuZWNydHMub3JnL3J0LWNsb3VkLTIwMjQvCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCgoKV2hpbGUgbW9zdCBjbG91ZCBzZXJ2aWNlcyBvcGVyYXRlIG9u
IGEgYmVzdC1lZmZvcnQgYmFzaXMgYW5kIHByb3ZpZGUgbm/CoAp0aW1pbmcgZ3VhcmFudGVlcywg
dGhlcmUgaXMgYSBncm93aW5nIGludGVyZXN0IGluIGNsb3VkIHRlY2hub2xvZ2llcyBmb3LCoApp
bmR1c3RyaWFsIGFuZCBjcml0aWNhbCBhcHBsaWNhdGlvbnMuIEVkZ2UgY29tcHV0aW5nIGlzIGEg
cmVjZW50IHBhcmFkaWdtwqAKdGhhdCBicmluZ3MgcHJvY2Vzc2luZyBhbmQgc3RvcmFnZSByZXNv
dXJjZXMgY2xvc2VyIHRvIHRoZSB1c2VyLiBBcyBhwqAKcmVzdWx0LCBpdCBwcm92aWRlcyBiZW5l
Zml0cyBzdWNoIGFzIGxvdyBsYXRlbmN5IGFuZCBoaWdoIGJhbmR3aWR0aCB3aGlsZcKgCnN0aWxs
IHByb3ZpZGluZyB0aGUgYmVuZWZpdHMgb2YgY2xvdWQgY29tcHV0aW5nLCBtYWtpbmcgaXQgbHVj
cmF0aXZlIGZvcsKgCmxvdy1sYXRlbmN5LCByZWFsLXRpbWUgLyBzYWZldHktY3JpdGljYWwgYXBw
bGljYXRpb25zLiBIb3dldmVyLCBhIGhpZ2hlcsKgCmRlZ3JlZSBvZiBkZXRlcm1pbmlzbSBpcyBk
ZXNpcmVkIGZvciBjbG91ZCBhbmQgZWRnZSB0ZWNobm9sb2dpZXMgdG8gYmXCoApmdWxseSBlbWJy
YWNlZCBieSB0aGUgcmVhbC10aW1lIC8gc2FmZXR5LWNyaXRpY2FsIGluZHVzdHJ5LiBUaGlzIGNh
bGxzwqAKZm9yIG5ldyB0ZWNobmlxdWVzIGFuZCBtZXRob2RvbG9naWVzIHRvIGRlc2lnbiBwcmVk
aWN0YWJsZSBhbmQgcmVsaWFibGXCoApjbG91ZC9lZGdlIHRlY2hub2xvZ2llcyBhbmQgYXBwbGlj
YXRpb25zLgoKClRoZSAzcmQgSW50ZXJuYXRpb25hbCBXb3Jrc2hvcCBvbiBSZWFsLVRpbWUgQ2xv
dWQgU3lzdGVtcyAoUlQtQ2xvdWQpIGFpbXPCoAp0byBicmluZyB0b2dldGhlciBpbmR1c3RyaWFs
IGFuZCBhY2FkZW1pYyByZXNlYXJjaGVycyBhbmQgYmVjb21lIGEgZm9ydW3CoApmb3IgZGlzY3Vz
c2luZyB0b3BpY3MgKGluY2x1ZGluZyBpZGVhcywgb3BlbiBhbmQgdXBjb21pbmcgY2hhbGxlbmdl
cywgdXNlwqAKY2FzZXMsIGluaXRpYXRpdmVzLCBjYWxscyB0byBhY3Rpb24sIGFuZCBwcm9qZWN0
cywgcmVndWxhdGlvbnMgYW5kwqAKc3RhbmRhcmRzLCBmdXR1cmUgcmVzZWFyY2ggZGlyZWN0aW9u
cywgZXRjLikgcmVsYXRlZCB0byByZWFsLXRpbWUgY2xvdWQvCmVkZ2UvZm9nIGNvbXB1dGluZyBh
bmQgdmlydHVhbGl6YXRpb24gdGVjaG5pcXVlcy4gVGhpcyB5ZWFyLCB0aGUgd29ya3Nob3DCoAp3
aWxsIGhhdmUgYSBmb2N1cyBvbiBpbmR1c3RyaWFsIGNsb3VkIHVzZSBjYXNlcy4gVGhlIHdvcmtz
aG9wIGFsc2/CoAp3ZWxjb21lcyBzaG9ydCBhbmQgZnVsbCBwYXBlcnMgdGhhdCBjb25zaWRlcjoK
CgotIE5ldyB0ZWNobm9sb2dpZXMsIGlubm92YXRpdmUgYXBwcm9hY2hlcy9pZGVhcywgaW5jbHVk
aW5nIHdvcmstaW4tcHJvZ3Jlc3MKLSBPcGVuIHByb2JsZW1zIGFuZCB1cGNvbWluZyBjaGFsbGVu
Z2VzCi0gUmVndWxhdGlvbnMgYW5kIHN0YW5kYXJkcwotIERlbW9zIGFuZCB0dXRvcmlhbHMsIGVz
cGVjaWFsbHksIGZvciBvcGVuLXNvdXJjZSBwcm9qZWN0cwotIENhbGwgdG8gYWN0aW9ucwotIEV4
cGVyaW1lbnRhbCByZXBvcnRzIG9uIGV4aXN0aW5nIHRlY2hub2xvZ2llcywgaW5jbHVkaW5nIG5l
Z2F0aXZlIG9uZXMKCgpPcmlnaW5hbCBmdWxsIGFuZCBzaG9ydCBwYXBlcnMgb24gYWxsIGFzcGVj
dHMgb2YgcmVhbC10aW1lL3NhZmV0eS1jcml0aWNhbMKgCmNsb3VkL2VkZ2UvZm9nIGFuZCB2aXJ0
dWFsaXphdGlvbiBhcmUgd2VsY29tZS4gUmVzZWFyY2hlcnMgYXJlIGVuY291cmFnZWTCoAooYnV0
IG5vdCBsaW1pdGVkKSB0byBzdWJtaXQgcGFwZXJzIHJlZ2FyZGluZyB0aGUgZm9sbG93aW5nOgoK
CjEuIFVzZSBjYXNlcyBhbmQgYXBwbGljYXRpb25zIGZvciBSVC1jbG91ZAotIFVzZSBvZiBjbG91
ZCBjb21wdXRpbmcgcHJpbmNpcGxlcyB0byBpbXByb3ZlIHBlcmZvcm1hbmNlL3NhZmV0eS8Kc2Vj
dXJpdHkgaW4gZXhpc3RpbmcgcmVhbC10aW1lIHN5c3RlbXMvdXNlIGNhc2VzCi0gUmVhbC10aW1l
IGNsb3VkIGFuZCBlZGdlIGFwcGxpY2F0aW9ucwotLSBJbmR1c3RyaWFsIHVzZSBjYXNlcyBhbmQg
cmVxdWlyZW1lbnRzCi0tIEV4cGVyaW1lbnRzIGFuZCBleHBlcmllbmNlcyB3aXRoIFJULWNsb3Vk
Ci0tIFJlYWwtdGltZSAvIHNhZmV0eS1jcml0aWNhbCBhcHBsaWNhdGlvbnMgYXMgYSBjbG91ZC1i
YXNlZCBzZXJ2aWNlCi0tIFJlYWwtdGltZSBleHRlbnNpb24gdG8gZXhpc3RpbmcgY2xvdWQtY29t
cHV0aW5nIHRlY2hub2xvZ2llcwotLSBEZWNvbXBvc2l0aW9uIGJldHdlZW4gdGhlIGVkZ2UsIGZv
ZywgYW5kIGNsb3VkCgoKMi4gVmlydHVhbGl6YXRpb24gYW5kIGNsb3VkIGNvbXB1dGluZyB0ZWNo
bm9sb2dpZXMvbW9kZWxzIGZvciBSVC1jbG91ZAotIERldmVsb3BtZW50IE9wZXJhdGlvbnMgKERl
dk9wcykgZm9yIFJULWNsb3VkCi0gRGV0ZXJtaW5pc3RpYyBoeXBlcnZpc29ycyBhbmQgY2xvdWQg
ZXhlY3V0aW9uIGVudmlyb25tZW50cywgaW5jbHVkaW5nwqAKY29udGFpbmVycyBhbmQgV0FTTQot
IFJlYWwtdGltZSBTYWFzLCBQYWFzLCBJYWFzLCBhbmQgWGFhUyAoYW55dGhpbmcgYXMgYSBzZXJ2
aWNlIG1vZGVsKQotIEV4ZWN1dGlvbiBhbmQgZGVwbG95bWVudCBtb2RlbHMgZm9yIFJULUNsb3Vk
LCBpbmNsdWRpbmfCoApzZXJ2ZXJsZXNzIGNvbXB1dGluZwotIE1pY3Jvc2VydmljZXMgQXJjaGl0
ZWN0dXJlcyBmb3IgcmVhbC10aW1lIHN5c3RlbQotIE1vZGVsaW5nIG9mIG5ldHdvcmsgYW5kIGNs
b3VkLCBleGVjdXRpb24gc3RhY2tzLCBhbmQgYXBwbGljYXRpb25zCi0gQWRhcHRpdmUgU0xBcyBm
b3IgUlQtY2xvdWQKCgoKCjMuIFJlc291cmNlIG1hbmFnZW1lbnQgKGluY2x1ZGluZyBtb25pdG9y
aW5nLCBzY2hlZHVsaW5nKSBhbmTCoApvcmNoZXN0cmF0aW9uIGZvciBSVC1jbG91ZAotLSBQcmVk
aWN0YWJsZSBvcmNoZXN0cmF0aW9uIGFuZCBjbG91ZCBvcGVyYXRpb24KLS0gVG9vbHMgYW5kIHRl
Y2huaXF1ZXMgZm9yIHJlc291cmNlIHNoYXJpbmcgYW5kIGlzb2xhdGlvbgotLSBFbmQtdG8tZW5k
IHJlc291cmNlIG1hbmFnZW1lbnQgYW5kIHNjaGVkdWxpbmcgaW4gZWRnZS1jbG91ZCBjb250aW51
dW0KLS0gQ28tc2NoZWR1bGluZyBvZiB2aXJ0dWFsIG5ldHdvcmsgYW5kIGNvbXB1dGUgcmVzb3Vy
Y2VzCi0tIEVkZ2UtY2xvdWQtSW9UIGNvbnRpbnV1bSBhbmQgaW50ZXJhY3Rpb24vaW50ZXJmYWNp
bmcKLS0gUW9TIG1lY2hhbmlzbXMgYW5kIGlzb2xhdGlvbiBndWFyYW50ZWVzCi0tIEF1dG9ub21v
dXMgbW9uaXRvcmluZyBzeXN0ZW1zCgoKNC4gU2FmZXR5IGFuZCBTZWN1cml0eSBmb3IgUlQtY2xv
dWQKLSBBc3N1cmFuY2UgaW4gUlQtY2xvdWQsIGRldGVybWluaXN0aWMgc2NhbGluZywgZmFpbC1v
dmVyLCBtaWdyYXRpb24sIGV0Yy4KLSBUcnVzdGVkIFJULUNsb3VkL2VkZ2UgZW52aXJvbm1lbnQK
LS0gQ29uc2lkZXJpbmcgc2VjdXJpdHkgYW5kIHByaXZhY3kgdG9nZXRoZXIgd2l0aCBzYWZldHkK
CgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKCklNUE9SVEFOVCBEQVRFUwoKCsKgIFN1Ym1pc3Np
b24gZGVhZGxpbmU64oCC4oCC4oCC4oCC4oCC4oCC4oCCTWF5IMKgOSwgMjAyNCAoQW9FKQrCoCBO
b3RpZmljYXRpb24gb2YgQWNjZXB0YW5jZTrigIIgSnVuZSA2LCAyMDI0CsKgIFJULUNsb3VkIFdv
cmtzaG9wOuKAguKAguKAguKAguKAguKAguKAgkp1bHkgOSwgMjAyNArCoCBFQ1JUUyAyMDI0OuKA
guKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgkp1bHkgOS0xMiwgMjAyNArC
oMKgCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgoKU1VCTUlTU0lPTiBJTlNUUlVDVElPTlMKCgpN
YW51c2NyaXB0cyBtdXN0IHByZXNlbnQgb3JpZ2luYWwgd29yay4gVGhleSBtdXN0IGJlIHdyaXR0
ZW4gaW4gRW5nbGlzaCzCoAp1c2luZyB0aGUgSUVFRSBmb3JtYXQsIGFuZCBzdWJtaXR0ZWQgdGhy
b3VnaCBlYXN5Y2hhaXIuIFRoZXJlIGFyZSBubyBzdHJpY3TCoApydWxlcyBhYm91dCB0aGUgbnVt
YmVyIG9mIHBhZ2VzLCBidXQgdGhlIHJlY29tbWVuZGVkIGxlbmd0aCBmb3IgZnVsbCBwYXBlcnPC
oAppcyA2IHRvIDggcGFnZXMsIGFuZCBmb3Igc2hvcnQgcGFwZXJzIGlzIDMtNCBwYWdlcy4KCgpT
dWJtaXNzaW9uIGxpbms6IGh0dHBzOi8vZWFzeWNoYWlyLm9yZy9jb25mZXJlbmNlcy8/Y29uZj1y
dGNsb3VkMjAyNAoKCkFsbCBzdWJtaXNzaW9ucyB3aWxsIGJlIHJldmlld2VkIGJ5IHRoZSB0ZWNo
bmljYWwgcHJvZ3JhbSBjb21taXR0ZWUgbWVtYmVycyzCoAphbmQgYWNjZXB0ZWQgcGFwZXJzIHdp
bGwgYmUgaW5jbHVkZWQgaW4gdGhlIHdvcmtzaG9wIHByb2NlZWRpbmdzLCB3aGljaCB3aWxswqAK
YmUgYXZhaWxhYmxlIG9ubGluZSBvbiB0aGUgd29ya3Nob3Agd2Vic2l0ZS4gUGFwZXJzIHdpbGwg
bm90IGJlIGFzc2lnbmVkIGHCoApET0kgdG8gZW5hYmxlIGF1dGhvcnMgdG8gc3VibWl0IGEgZnVs
bC9leHRlbmRlZCBwYXBlciBsYXRlciBvbiB0byBhwqAKY29uZmVyZW5jZSBvciBhIGpvdXJuYWwu
IEZvciBldmVyeSBhY2NlcHRlZCBwYXBlciwgYXQgbGVhc3Qgb25lIGF1dGhvciBpc8KgCmV4cGVj
dGVkIHRvIHJlZ2lzdGVyIGZvciB0aGUgd29ya3Nob3AgYW5kIHByZXNlbnQgdGhlIHBhcGVyLgoK
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgoKV09SS1NIT1AgQ0hBSVJTCgotIEpvaGFuIEVrZXIg
KEx1bmQgVW5pdmVyc2l0eS9Fcmljc3NvbikKLSBMdWNhIEFiZW5pIChTY3VvbGEgU3VwZXJpb3Jl
IFNhbnQnQW5uYSAtIGx1Y2EuYWJlbmlAc2FudGFubmFwaXNhLml0KQotIEdhdXRhbSBHYWxhIChV
bml2ZXJzaXR5IG9mIEthaXNlcnNsYXV0ZXJuLUxhbmRhdSAtIGdhbGFAZWl0LnVuaS1rbC5kZSkK
CgpQVUJMSUNJVFkgQ0hBSVLCoAoKLSBSZW1vIEFuZHJlb2xpIChTY3VvbGEgU3VwZXJpb3JlIFNh
bnQnQW5uYSAtIHJlbW8uYW5kcmVvbGlAc2FudGFubmFwaXNhLml0KQ==

