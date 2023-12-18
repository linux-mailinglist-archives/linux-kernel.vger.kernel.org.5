Return-Path: <linux-kernel+bounces-4128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 144C281782E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73D88B21C32
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F574FF94;
	Mon, 18 Dec 2023 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p+OtdHiI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB7C4FF66;
	Mon, 18 Dec 2023 17:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nU3B5jcVk67fUhoTuAnbxCKJCUlFN5kq5tHdN096grnB855wOjPGjPOxwQFfydS4LapqlSf9XU6R807/49H6uW3fsByq5iqWvTlLYM6sE8f6FrnxRuuVtOIjHWg1IdqjSCDdnFq7/68Tk8NCVGadtgUvQBcVNttFgBO7DRJibq8pHCesZg3lJxvawIkRvhQ8bETo7ZMZKEa9qttMfE8Ue00iry0UePdnSMilrHELcv/SuGajqC2pX+wxdXwVmzbqtvEQn24y4wTDHYDR3fH1n7ozGYbjGrIwlJllchsKtWQcKbR9ANWsyS6I04bqGy9SM88ajVUonRX+i1h2bFKSSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LM3PAMaGxkBW+mLPsTIaHopHjfTVucFTa5/lkV4Kd4s=;
 b=bFluEgFowFQ+SIWIKSvd43lnc4mpbkLljLYYqT9tPPxdMAGRNM7EGiBQgAzkCEX7ScxQ2XepF13gYwhBxzAyZhW6sR9SX+xrQqyVlg5TDl/vuftvXzCyL6b+5ljyH2OOwIqzbMTo1Pls4e6qqpoMr8+c1a1UIa4jefxDAFcnu6mfbXdbIW7PeGQ178lpUbYCSuo72PziKjU9MeUgX6P0Z/4ieKMUraLOGqW6yR9p1I2onIwfobP6LqAQExfnkr4QLxHmvpTIxs3GI7LWAi66uaH9hlIfl4PtjfXbCln2X+Rz9YHLDDXVWlzvHv6kS97ANBbhvXzIsSFhxgLdhDdUgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LM3PAMaGxkBW+mLPsTIaHopHjfTVucFTa5/lkV4Kd4s=;
 b=p+OtdHiIoXbfHwIzg139E0WeTkz8Shcg9nsH/EJMyR10Pe3Dp6w/ABtaHuATdSLJwpYyP78cp+2tI98ec7GIfI8fnIFUiz8H8x7AIrXJsKl3dWkac5fz/STsNJoLs9Ot7qhbhR+1AIFJCOUtrrTLVxOqGZSGEHFhTPfXAQtQtnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 17:08:46 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::e2:9f06:b82e:9a0f]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::e2:9f06:b82e:9a0f%3]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 17:08:45 +0000
Message-ID: <d1ae970f-a00d-4da6-839a-881807edfa39@amd.com>
Date: Mon, 18 Dec 2023 11:08:43 -0600
User-Agent: Mozilla Thunderbird
Subject: [PATCH] MAINTAINERS: add reviewer for Spanish translations
Content-Language: en-US
To: Carlos Bilbao <carlos.bilbao@amd.com>, corbet@lwn.net,
 avadhut.naik@amd.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231218154308.3314929-1-carlos.bilbao@amd.com>
From: Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <20231218154308.3314929-1-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0104.namprd04.prod.outlook.com
 (2603:10b6:805:f2::45) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|SA0PR12MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: a844cd23-665d-4ff9-1d42-08dbffebfe85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+eZZYEK5rnAEA29sYaQt+MW/7M3mwSAiRmvHbBLnr4ZhRxPCWQQciZmTCqTGle0Zcw8zVGU1P9uv2y5pm6+8t9926byTx4hS2yhlO3RPORR/Ju7MeRh2o49PlbumhAziz8QL7LCUFfGWobcFowBVBGvHZmygCr0TLDnTrDHBBIPV4wAXtLVLEaoph2MO199qhXjpDoDtxz1lQtPZYaQUz1zMBzrIwTZkT2lgfzRfZyMgA9BSR1tpF0IpcwdM6BkIH4xRx9cy5Ja5nrFpPYC+XXyRPGk8jKT8wvDgyt9xp4gGI/SWzW31/4zp2o5bpPtYPXH5DMJsefyh4rjyUv8WSAErYlVD4eFZ8aSLkqU3a3IfKG0aLW4nrncnXmsJiF+sY+x/zfN6MhAW/g2XPUx30qGupsqVlLnW4+mrbKcBtQKsXz/+CKAohaPhbLH9+SS2Cp0XibaZEe6X/bLG+k7Ae3Qwtex1Cmngmk4FwaLSMwPcLTHYjhbHbFWBtNh9pZt/5T87A8ipsu3JOPavaSDDGIXwk5Vu8W9mvq4q5mUm5WcS5MAb6wu5toBMVX+nPhuXwsuIeasLjZZWXQdjHhl+NMcWMOkevHEvPFCAuZus5zrr4c2F3VU9tgUQtEQxea9BK544wCRYTVi68HiW9dyU2A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2616005)(26005)(6512007)(53546011)(6506007)(5660300002)(2906002)(4744005)(41300700001)(478600001)(6486002)(4326008)(8676002)(8936002)(316002)(66946007)(66556008)(66476007)(6636002)(36756003)(31696002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWR3YTR1VHBoa2pOTUsyVXE2NHpCcENBREE4SnF4RWZuekU1bzc0eFlqWEVY?=
 =?utf-8?B?bzdJSFhOeTBNc0I0RXEva0tqenArRjNvYjNUeW9DNFJZQVN1TkZsVWl3c3hU?=
 =?utf-8?B?YnFPZDBaMmZYRmUrczI0QVh0UlVIMWdsTTZPVFFTVjNTRGtaZ3UyYVFPWGJh?=
 =?utf-8?B?UG5hY2FIbHp6TVdhY1JGTnU4cTR0blZiUllXUGg4dW9HNHVJU3cxSWlJd3Ex?=
 =?utf-8?B?bi9CR3ZQdlNPUHFuVnFSakZTTlRSVVRWUE5iL3ZpNlEwSUc5SkR1QUh3NFBa?=
 =?utf-8?B?NzR2aUNqZGNOQlZ6ei9QeDYrRXBneFlaNmNGRStJZE42bG1zTktpK3Z2dGlZ?=
 =?utf-8?B?RE1qWklHM25OV002TE5JMlJMalBHaEY1eGI2cGUwZWQvd2FtV0xYN2xxMmFr?=
 =?utf-8?B?V3cybnNIVDJRSWxCUmwwVnlDOXJyUWlVdHduSGFYOWwvTjBGcnNDZWhiY1k1?=
 =?utf-8?B?WVJFUE15bjBiN2RoQlR5TmdWdFN4MEs5Wm1Hd2RGTUNIQVJzTWZaN0w1cE12?=
 =?utf-8?B?dWd0dFdjUUFaS2czckJJZFh2OERGVnVrNHl4TjNFdUF3cGhMRjhYRzcxcG85?=
 =?utf-8?B?MGdZTGlmaW1yWG94SEVGS1VCTDFSanp4Y2RUVHB6UDh0dGpRdm52eHE2SHA3?=
 =?utf-8?B?NUxiVHhiMDcybDFudXB3NXdoZHVJcHlJZ243WDhwaWJqem5xQWdXODYyT2RO?=
 =?utf-8?B?SExXLzNFcStmbjIwYVQ4dTgzSjNheVhzL2FCUFEzdDNPRko4RTFONTdST29L?=
 =?utf-8?B?ejNudWdaeHNRWTNqa1Y3Q29pV2VEZlNRV08xQ2FKZmg2KzFnZ2U2cEFWSjd3?=
 =?utf-8?B?ZVFnRkEyMjE0TlFMcG9GdUdIZ1o4dFowOE9yeDBld2Q5cStBQ1ZaTEFJU2cv?=
 =?utf-8?B?elFBYm5mZ1FjWlcwdlBwcFJOdnNnck1RK1Azc3UzQTI4enk1UGF2clpRYWly?=
 =?utf-8?B?aU1BNlYvVkxmMkgxb2FsUk9nSlJmK0I1eFZEYmRXYXB2QXd4czdqbWlkRWgw?=
 =?utf-8?B?RWJweUE2dXdPbkw4Q2JDZ2JUSWNHYTFhNWpvQ0RNRnlLYmJlVGN6aFR2Q2Zr?=
 =?utf-8?B?T3p1YVJQTXNSUDhUbkdJUnlod2lRZEFzOXRyZlZVOWgxU1kvUGdoWC9Na2s0?=
 =?utf-8?B?alJBQzNUeWE5U2sxQ2ZaeCswUnZQbTIvUXdoTEhaSGxNVURXbXhWNTBlZ0Vz?=
 =?utf-8?B?ZkVObGpPaUErL2o5cklGSi9Cbmk4VzRsY3B1d1Q2NFF1Z3dVMW1HWHlxZW1I?=
 =?utf-8?B?M3JjV0IwVm0zQlFzcjFqUjZBRTdLcUtIczRLZ1hIWXcwaGhKWFNOYW55cSsv?=
 =?utf-8?B?dXluMzRabDEvekxFWEJPL0FMcGFvaXc5YXl6WFoxODJyWFZ4a0xKSVI4SjdJ?=
 =?utf-8?B?N3Z1d0pPVzRoRTdFKzB5NHlmVC85d2FMUEVOK1VvWlhabmtFUFRJUE52MUZ5?=
 =?utf-8?B?emdzVlBMUGo3OHpDaS9kUXM4M0kydUJUZlhaYlJqLzYvODRQY09HQThPWWxq?=
 =?utf-8?B?Ti9mU2NzS0loYWZSU21YM0FObmdQRDlkc0JxMDdMdXVDZmJPemlCT2dGNVRu?=
 =?utf-8?B?L0kyZUZtS3h4ODJLQnRmMXAvV2QwcnVyQUJNK3poUkVUbSt5Ti9PaWJnZWha?=
 =?utf-8?B?a00zdGJ5WmlOaU5SLzd2SS9TWSt4NjdkdEhhcDBOL0d1YXBndGx4dWhQYVZU?=
 =?utf-8?B?dmswWUdUUVkzWkJMaE1vWHk3cSs1dkVOQk85YXB0aXNxUGg4L1dnVHFoTmh3?=
 =?utf-8?B?bktMWG9OV3VKR3g4c01lMzZ5czFIb0xoMzQwdXR5YlZvcGFuNjhnTGU1elJn?=
 =?utf-8?B?Z2ljN2V2OFJVK3FzVm45Tnk0LzJBeDYzb2NxY2hYOVp3L082TmQ5M2Vmd2hC?=
 =?utf-8?B?R3hKMjViY0RBcWQ3R3JWOWw2NHVlb2ZGWU83RXRUVThwb1JGVnZBOW9RZnl0?=
 =?utf-8?B?REhIYkkzN0I5TlVjL0FKQlJUWkE4czFOZVdpSmZJMnlYbVRnVDZPdjJkV2dp?=
 =?utf-8?B?NzhlQjU1V2k3aUFKQWRBUGtFcVJCTkwzVjhLaW5UdS9HVGluc2xrZklJSWtU?=
 =?utf-8?B?ayswYW9acUVDbFVOTkUzOXBqU1JWM3B0S20ydEJQU1k0c0FMSHUxMGIvQ25Y?=
 =?utf-8?Q?IIXAlleeBRwnXynG/Ff8h+fqE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a844cd23-665d-4ff9-1d42-08dbffebfe85
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 17:08:45.7712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZezND/gx1qaQhSC8Mtc68bgpos4Rnc+whDP01nOqOv/agZdDHJzhRRUyOxLVx2UolVl1l0ly7n7uMTj+0cnlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382



On 12/18/2023 09:43, Carlos Bilbao wrote:
> Add Avadhut Naik as reviewer of the Spanish translations of the
> documentation.
> 
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6024d1d5ebf8..0506d14340f7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20360,6 +20360,7 @@ F:	drivers/media/dvb-frontends/sp2*
>  
>  SPANISH DOCUMENTATION
>  M:	Carlos Bilbao <carlos.bilbao@amd.com>
> +R:	Avadhut Naik <avadhut.naik@amd.com>
>  S:	Maintained
>  F:	Documentation/translations/sp_SP/
>  

Acked-by: Avadhut Naik <avadhut.naik@amd.com>

-- 
Thanks,
Avadhut Naik

