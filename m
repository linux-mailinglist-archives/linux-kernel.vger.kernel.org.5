Return-Path: <linux-kernel+bounces-164352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 513208B7CA8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3251F24CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF7217799F;
	Tue, 30 Apr 2024 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="akqXwXz4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tvMhtL1n"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DD11F5FA;
	Tue, 30 Apr 2024 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494026; cv=fail; b=ObuB2C49Nzm4MpRlodsqbgDCpPeX38P9OA5cqaA6N981BCIqIh12jaEnpnMv1r76gl0K3VBABw0C6r3PP1o3EZ8WPpxGnK0MPy5LA5rdbHBbARUVa8mBako3DmJfGQTU6I5OtHliTs3MmnqjiA91oaeZvTBnVv7nu8inBZdinUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494026; c=relaxed/simple;
	bh=JojFtxSL80FF2qeSKbwXDC7cgAY/dnf+3IFiUnqMJMc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ehz0ulvKglcssPl+tQeJ0tKtvNrjfAaFsy+mCXWgULTvKMhz7pyLZMYPEbCUhlGELSe+xPZwRDWDh7zLK8mIfHGbHxaOeyjefeGfncdpCqnXxCZ1waOe+/AeEzD2UXVdZBVRjaf8GNy6pH+zR39/G88EWQ58k3x0hxDEOTP40Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=akqXwXz4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tvMhtL1n; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43UCXc8A011904;
	Tue, 30 Apr 2024 16:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=IM3+m3wRPZckeRifgB8k+ZSJpi8A8vt9MJDWWyxNG1o=;
 b=akqXwXz4ZcWbdrGQsHE1QYhSb1Sm3ezA3V32I+P0U9RP5QMQqQ/yF/8umhcSSYWm+LPx
 Ioyk3+WsmRhrCamvLj6w0NXMZ509xaqe+GlHtTVACAZjnnDSC2K/bet8b8eArxiHWoAV
 yjtQ6L5qXPFs9+NoFsvCGN/bykxJR9f4aTQqkj29QqLdj3k/Lqf+2dVuj8/2HWYFrj5f
 +U8wofx5V5yvKvOvVM9cweWlqqlwGrcMvgny+LO41FF6kd0dx7/tt/GKmaAXI8Nq9u1r
 vL6hmVexio4pfX+AjuupQskZbJNUFNbs/y3mkyp3MqvN2sihB3omh7S1sxwW9gcOM/9k sg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrswvnj0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 16:19:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43UGIFCG033276;
	Tue, 30 Apr 2024 16:19:46 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt7xk5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 16:19:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gb4jVgOk2M969+JG0mkdZwdFP0M9tmH8MBFyjHXMzfHeFsd4WIDE4+na+M4T0hmWexOEBWpsdemRJrBCmTfeVq55yuSChWNtzOrGUkzShHPMVXCatxyaesKvhYtOheRyumdNE+NK2FswGjLJHpVZoZkB3s9ZPEsqu0uGEHQQZgeNoQrCM9Nkp3qy2hx9EqWDugdbTmbOGFIZdeYiw1Lpr5B09hztl0gy3D7QryX4p5YIwDTaMhA4dTAqpJltAECLnatxwXx4oXq+PAfS7+K88UqS+9OL3dkXFns0SE8j+e+/2uXod4rhv+C1cPUr8SA9/5XurqCbek6wSxAiYbJwpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IM3+m3wRPZckeRifgB8k+ZSJpi8A8vt9MJDWWyxNG1o=;
 b=QWtme05JP9j1yBh6pWSEPiAXH5NPM2INADZzwhUeIOiecVVLfgvHfl4p6pT5TY9gHC64DtoQQCwFO1IIryzQSoMv3N8H9GjQ9Ge1Pys6oL7lJhvwNhalbUI9ZXlFf+g7uc43cnUiCAY7y8HcjDyn6ShKoGjeICMkS2zapxP+3nsS8xgd0S5V/J9s73SObaERTQyTYdXr3VySFMgX7n6CR57v5JcfBOSrVn+bsNGAXQp4nPpkbO6gDxpLO0la3ekf1RC6rE1TJrVr4l0igBFUqIDjM0qzRw+hvEOcHf9SLqLXmi1OLZywxIxN5SHIJ7KhJVh0ijDqbodbsPwar5aXEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IM3+m3wRPZckeRifgB8k+ZSJpi8A8vt9MJDWWyxNG1o=;
 b=tvMhtL1nQqOT5MsrEkRA6QDT/wo9/7vvlwYHDhjskFvjLnt9bT8dCP/729hsSGjvRo4C3vWN1TNwtBRHJUi4tGuWiRtYvFidY7VpCVZEl2jAp4PoLDgk7C6rkKag7EypKRXk304S8shqB5aeC3rHbT5e61cLDFzG49mcB82bB94=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DS7PR10MB5037.namprd10.prod.outlook.com (2603:10b6:5:3a9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 16:19:43 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76%7]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 16:19:43 +0000
Message-ID: <8f0db8d6-288e-4db1-b89e-2e5e6c1c52ed@oracle.com>
Date: Tue, 30 Apr 2024 21:49:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/186] 6.6.30-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        broonie@kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240430103058.010791820@linuxfoundation.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240430103058.010791820@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0086.apcprd03.prod.outlook.com
 (2603:1096:4:7c::14) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DS7PR10MB5037:EE_
X-MS-Office365-Filtering-Correlation-Id: 518b9de5-efee-44a0-1d79-08dc69315838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WHROZTEvMGU1RyswYzErR3liQVJCYVNHZFRyTUZCVzNpNEpaYkYrV3Bvc2lY?=
 =?utf-8?B?WHhObkliWmEyUE1JNkZEZ1FHRDBXUXVOTHZ5bFl1RE5sU0dlNmRSM3hOV0ww?=
 =?utf-8?B?cVlHeUtKVGxGNWtuVlBWVGNRMmNqT1VLQ1QrQ05RaXJuTXhaTXEyZ1BXQXZG?=
 =?utf-8?B?djgyOUhJTGpxbmp2enczZmxCWjFscVhnK0ZDdHBiR0dJSEtVblUyRTY5cmwv?=
 =?utf-8?B?MXhJVnpjNG81dWFNYVJhUjFrbWVTZ1plZkFuS2pEZFdyRVUwYWx2ZVlCTDJH?=
 =?utf-8?B?d3ZwVnVkdWF0VVpMYm5jM29rUHNRYXpOMXAxM0s0cDRNcHFVOE1KYjJNbXd4?=
 =?utf-8?B?dFFrS2UxNEhBREpDN29hMFliSDRHajZOSHhQa1IwUytIM3FObHZjOGdaSGtx?=
 =?utf-8?B?eVl6ZU93ZUlsRUplckRPNEdCN0FLQzUvUWEwNVFPdTg3Ti9LeHhjVVZOaXZk?=
 =?utf-8?B?ei82dm44eFRkOHZDcUZIUHlWR1VBOWcremc1YW9CbTRXV0xxTkZHQUF6bC9E?=
 =?utf-8?B?R0xkUSt3ak9nQS85dUFLU09kMjdiSTRqYXd2S1hqOFBWVEI0NWpyOGpTQlBQ?=
 =?utf-8?B?dUxRZWFXUDQySitDRUw1MFBxUHYvY0ZKdGJVaXpya2xtTExRVUh1ZHdDamJP?=
 =?utf-8?B?eEJJcmRmRWdaVTVmNTNpRVpDdWRCNGVnelZ6SnhrRUFCMUZCREZ5OVVIMmJx?=
 =?utf-8?B?N0pFTWt6RUNlb0lsRWtLbWUvcUE2Y2dOYkVNcHdXTklza1gyOEYyRW9SSnZ3?=
 =?utf-8?B?ekhzSHlUbFBQVFpEZUNBdGF2M3hTQThEeDBnRTVXL3NRRTJheWJXYmZwakN1?=
 =?utf-8?B?L0EvNXI4dldPbFlvRTdqV1Byc04rcWY4a2Y0SEhLWEtwS0hOT0J5cVQ0d1NJ?=
 =?utf-8?B?Rmc4bndpSG53VVhSaEFxR0VGQTlEcVZkZjJ3aE5sSW9McFVTdTg4MGdRNTN0?=
 =?utf-8?B?WHFLNEVzL2dvWUN0MVlCMWpIN3BranVwb2xjSmhOdTdmTEZyQ2wyTVplQW14?=
 =?utf-8?B?ZlVZc1NEMm96R2tJUVgxZ1QrQnBLcEdTU3FOZ2xOczJMVWNGSVh6c242OTN6?=
 =?utf-8?B?cS84UGpPSWZBZzVlajlic05rTldDYTd1c1p6T2FYL2JXV1hZaXVuVDZ3cS9E?=
 =?utf-8?B?Y3JNVE5NMTV2cUFsOW1jN3pTbXNyUFlZc2h3VHIrSjNYeHc5dUxFbTZtTC9h?=
 =?utf-8?B?TGxON044ODdrTWRiS21JWjA0dTFIcWpGMWcwUjdvb2kxQTRUV2ZvWHo0MkFL?=
 =?utf-8?B?d2xEMFJ3RVFsL0lzRG5VaXpBbGJJTVBEQUpuaHFNZlJnb1Z4Q0h3bFBLS1NJ?=
 =?utf-8?B?MGw1dHBvcjdLRElPZzNnRFcrUWZLK2tONThlY1YvaW4vajNVT2Q0eG40bFlv?=
 =?utf-8?B?VElSMEwvS3RJZkJVanV2VzBhUGtXcUR0ZEFMcytVZzI1TmYvNXpuSWx2ZmZB?=
 =?utf-8?B?c1haSXptcjZNeFNvSkxldGdVdEJqbGhYVkdyeDNuK2lBZ3FUOVc0UTVvUncx?=
 =?utf-8?B?MEY0RUJNeWswRWFJa2h5R1hoWTlOUmhVV2ZJT1BzN1IxOVNOb0xhNkNIeFF3?=
 =?utf-8?B?OWNuRG5rZVR0azgvRnduVWliYkxzbkZKMmNxejlLemx1VEd4MEMzTG55VG05?=
 =?utf-8?B?VVJsRS90UFV4dTF5d0llTjFvRWJYbEQ3TnhFenkwSzJGSW83dzhYTyttNHdk?=
 =?utf-8?B?dXgvRVlTUmd2UTNnanNpUnQ3blkvSTZOSktLK3BKTlFxa1RtMldoTzZnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WkcxUGpSVFROeE9zc0RWa2t4a3Q5OGU3NVQwTUFqNGp5ekJVdjNsVlJCTFRr?=
 =?utf-8?B?akp6VU5yTUFYWXlFaCtMNVYvcFZyTDdIRkZ2SW9HeUYvMUxXUkc3dTNsV0Jp?=
 =?utf-8?B?MGNVQVNBbDIwOTI4WDNWZU15Rjc3ZUtxV3E0djVLbThwYlNXcU5jQVZJQ0d0?=
 =?utf-8?B?OXo1VnpVUjBzRnRmVkxJVWwxaUVVaWJncmpNSUxXa2ZtRmMwTSt6NkI0OFhy?=
 =?utf-8?B?NFozamNlZk4waUs3bDhyQmdsOEc1RkU5cFNpcGhBdkFiZlRSTGJKSEx3cUUv?=
 =?utf-8?B?R0cwWWh6ZHY0aHpaM2REK0sweXhKUTZnSHYxMWxFT3MxRy9jSjYrVEpTZUV1?=
 =?utf-8?B?ekpMa3JhNjBRWmVndWV2U1dIN0k2T3pFaDFCcGpSNzVveHFtNER4Qm9yTnRJ?=
 =?utf-8?B?QWd1Q2M2aTRtUVlmaHpKYmpKbStqZ2JxQjBTMVRCbVVsRkxCQU5oY015Vi9R?=
 =?utf-8?B?dzNWVDYrR2JSR0lUKzZCQkVBTEp5UkRLMXp0ZDZkNXp5eWtDM0NtTzVDd1dm?=
 =?utf-8?B?bE1hVUpuUkVzUksvUWdQOTlGaHQ0b2JtZ1pqM0dObWVUNDYrcWJKSmR0ZzJK?=
 =?utf-8?B?WUtXTllHbm5UQ0JhSXlXMHZ0ZFZ4aW1PRHdLRlpwd1krS2FsTVlkcGpmQ2tj?=
 =?utf-8?B?UUFyeVZxbkdPRE9LelMyTXJoV3VXS3J1YXd4Z0lrTndpTmxiMWNlZTJKMlda?=
 =?utf-8?B?Znh3ZzBGSWlPM0VzMkd4RElOZzkrSVRJNk1nVmFHU2pJN0lnUlFqUTUxQnpG?=
 =?utf-8?B?SmFtci9uS2xJZ1BPbUtocm1nd1UzcXE3YklPajBDR3dUa2FCTTQ3ekh5SkZY?=
 =?utf-8?B?eTRiWk9lRUNqVC93R0ViVW85ampkUUxsZkVEcFlrcDlqM2U0Tm51YUJQNElv?=
 =?utf-8?B?WkMzMnBhVHZQOHlZK0xJWWlOUHUwakpHZHZ2SmZjSWJqclo2dWxVb3lFdC9i?=
 =?utf-8?B?WWd1RjN4Wk9lRWkxdUlKT2t3RnJsN0l1TzZkZkVEVTA1dXJUT09SZ0xvcHVO?=
 =?utf-8?B?YXdDSkpiM0tMSGp1SFdNNjhDN2NsRUFoVDVvS1IwcmxqdWxLTWxUMzNEMFpS?=
 =?utf-8?B?aG9VY0YrLytLbnJ2bU5Ta014K0RnTm4zRjZuMUh6Z0FKK1phTWh1ZEdQdjNR?=
 =?utf-8?B?OGtWL1N4dUFraGkyczBBL0UzVXpKbm9WSFVyNUxlb1lDMDA4TnVGeTBEQ2Q2?=
 =?utf-8?B?UlFyTnQrUGtTZSt6cWVZUlN6Vm1XcHdCYzdBK3pINmpNUGJKVi9FcVhlVGNM?=
 =?utf-8?B?dTYrSnJYcFREVTFnNU5qNE9id05USVY2UUtHYmpyTEJqdlZLL0NRUkF5cUJY?=
 =?utf-8?B?YkZVbTYyQUJIZXQrRUdmd0xwQ1FBM0JEZjlVYnQ0NWJ0d0JKMG50QTZkZ3kv?=
 =?utf-8?B?WlJmdnZJSjVxeFJVUkw4RUFsek1PYTREZ0V6RGZDa29SbDR1eXVMNWpKbUZh?=
 =?utf-8?B?ZXJrVU9DNVJBVU5md1RUak9zVmZBam01WTlhMEpNY0VYSXJnZ2EyN2JZYzl6?=
 =?utf-8?B?NFh4ZEN4ZlhKZ1BGMUs0Ukd5WEFkdlFDTk1jdkJIODUzQXhYZEtNb0VRSWNz?=
 =?utf-8?B?dWNpS3hQcytXVCt4Q0xpclVvOTFNMFNWZ055OCsxS2Vmdlp2OHlHem5kdXFz?=
 =?utf-8?B?UWZwOWo1QWJQK3hPQUpvYWp0VlpqQjRGM1UwU0Q5bjI3RGQ0bDZnMEc1OUYw?=
 =?utf-8?B?Rk1UaFcxMC9rSGtLR240d04rL1pUL3RWeXJtcklpUFZKMmhSUXFRVDlpaDF6?=
 =?utf-8?B?cVI4Ynh5bDJkOXBtWmhHSnBJc05WNHdHYnlqOEJkNzY1NkFrWWVLTTFJQkoz?=
 =?utf-8?B?eldGQ1FCZzJuZVF5TUFCTjFvU2NKL2w3Z3F3ZktkMXBzVDJXMHBWTk1rV2xo?=
 =?utf-8?B?SUpWUmZrTmdTVHJZRGViZ1J6ZlRVbFY4cjJENm51MklJQThsdkZMRGM4TWpt?=
 =?utf-8?B?NCt6RGc2R0xRUDZ5NkJqQUU3UkwrZnA0a2hHdkxjZkl1RHFSRnJHSGI3by84?=
 =?utf-8?B?RXU4SnUyWFFSaXlmNmg4L2dEVG9TRHg0UE91SFBYbW9oZVVEaURjRlJpTVV0?=
 =?utf-8?B?UTNtcjdaRjREMjZESTk2dG5JU09NbmR1d3VTVjJhaSs1blEzYnJMb09BNWlG?=
 =?utf-8?B?aFNMYWc4SE5EcTFkYk1pT0Uxc3RwMGx6L0p5Rms0U0JyL3kzR2h4N0VRcHBm?=
 =?utf-8?Q?Z/7Yk4ougLQTnjYs8Xww1as=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gTb8TbsVcv3FCrVyOZQqPiFHdi4witMHLzy/gepxWn38qyNKAi9VZ35DwAthyTkhAjcTaJ5CAa2vGz21rP17gjQcrUBwdhx28INvIChoRCCUhNomcEMMCav3b7Lb4bjQ8jhmW+rn4pQaDP4OAM/yngtqztmaw/rfjgyKCrEu+e4tqDKM5rT9rMEDxV3h/I46x8OUYvWis9KkZJktuk4+Aonv6SPUAUl5tY4/QJiQ6/nzVirnKevtlV/2NR5a4yeG5a8k8VQGDDUJrc4v7W6fwpjUVhmrmovr6PGlarv8h+P+KWiwM4Qxq4zjzjwNkGbIHKoHG9kMyh5VvimtaI0ZwUOHFZdNB8LFgRVR4+TprKN+v+soeI8uszP+H3KPlOhMROT3tMeYOD3mX2LBx0a+9Dn+0eqU9o9s3OVyJJlJ3HwupfQtx6XQyj7auQvrr3bHc4HZGKLq6bXOoVXuQJWushTUTYerd/cct5JUIa1M044wcfBVVyiPekIIQt5MSu54IgbNYrXfNIW7nk9JSmyjnC7Sjnlx+2EBd9JbY2fnZTlJjWAEklF3+JpQXE5iwcisB7WCchd/8Aic8TqKcYD74HTY3SQ7VnJbm0EJHWnGmdA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518b9de5-efee-44a0-1d79-08dc69315838
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 16:19:43.7624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJ2cdPsOezXTr584ZpLf0+Zu/RUTzyM80aPc6Hm3SC3AnpBUaE1nbE0QFgwo9u7f9x7tCi2asO7qCMax0TyF3Es9MutzCF9LAwfG8CPsirTw38JTKHsYeE7ZWS1H0qwi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5037
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_09,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404300116
X-Proofpoint-GUID: b1W7JilWJL5MLnuGJGcDy8Mcltj55xl6
X-Proofpoint-ORIG-GUID: b1W7JilWJL5MLnuGJGcDy8Mcltj55xl6

Hi Greg,

On 30/04/24 16:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.30 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit


> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.30-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

