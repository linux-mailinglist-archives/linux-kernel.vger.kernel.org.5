Return-Path: <linux-kernel+bounces-1275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B20E5814CBA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D612B223F5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC333DBAF;
	Fri, 15 Dec 2023 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yQHdU90j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8F13DB80
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfaSw4hQmajkKY1YfKMVr0ulLSovRhrpNZaqjISVLopL8X9BxKzPnbLFBybCX4SB7hgbZ+q735IU0wG2rZRsXN5KXWZtzI24lEbJvvgoH9dQeGJc/ZBGmplIBrjLLD8nAjECd1aX/0XI3PpT6h8BJFBZfxJiyRq7MGVWl+Q0cUYypcih1eiIryHd/L9I2TwuYipg3d8YMGMk9s3TBW0OJG18ZnxtOmk2RviiyTLB3nX/l+FeUim2F/Pws7YTQ6gmk8a6pQWy+8sZYIV4JPQrwH+RcRDVvPZAGTU76f7tgcJDC7GRtHjgGBU4EPpfK3FXWOs4LydbtsevnyFGGekXTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zql9GaEEjuprnFl2dpsw9mV6rDd63ReopgipSNtKsuk=;
 b=kyFFpDJt/YJHIPcMaZag/Pfg54A3Qy5JgkK52QtBdPsM8alW2+eyPqsrIuujVBAdzNxB5TcxcGejszINmFP2N5T/ZgpabTk9lO15L5CheP42/B9kJKFpVmodqH7BQtuHWV2B8/LFk6xdjoYbL4mKppl7Oj71L8jNmQD0zTBzG5dTB1hfgtK0rA8ChbBUHPY1TNrud/a/1kvqd0PIAhTJsrTI4JbjReUBxQZE9CJ7NBxv9fYPHusbV3zoWHjt7FyR5uwFNUHDom/bPHqZTVOod16//EIfnlGci+1J2dwSl9ZxKwlU9z3NKTpUW4c2anEIZhXoP8ELife2WS0aojMhtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zql9GaEEjuprnFl2dpsw9mV6rDd63ReopgipSNtKsuk=;
 b=yQHdU90j/OzJzGyUANQmsqEDftemfk5XxJh3gGbuFO7FuWROWMB2851XJ67i7vzKorhqF1//EuG4fVuIASpcrwZzqGot0M0RqC4fZxVA+L3k5wf0LMQQZOHIo+MPQpEHHhu/ceC0muTVAhk+uTRXBbYSUt9mzJForkbMt0lCE8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 PH7PR12MB8778.namprd12.prod.outlook.com (2603:10b6:510:26b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 16:14:19 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5358:4ba6:417e:c368]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5358:4ba6:417e:c368%6]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 16:14:19 +0000
Message-ID: <886c29fc-0b0c-4f7c-a2fa-f015a2b51fa3@amd.com>
Date: Fri, 15 Dec 2023 11:14:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: regression/bisected/6.7rc1: Instead of desktop I see a horizontal
 flashing bar with a picture of the desktop background on white screen
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, alvin.lee2@amd.com,
 hersenxs.wu@amd.com, daniel.wheeler@amd.com,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0245.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::17) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|PH7PR12MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ae4f42-0437-4637-8499-08dbfd88e44f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pr7fDgyQHkzcWxBdKCWcBf1FfCnuLRF2/A6P9HgalVaV/y0/tXKDuhWl5mBcI7VkkU9diCalknmqMyJv0w0lUzttqCPUdOd32UWYZ64KFlyswExntlfqxKk8Nw5UVhcIgoBC8AnT5mgxf93ixViPxZYd/4BDfBEMYMzLa1YIej0Yz+dpMUEoC/MWVwfcUCNJ2qN7Fy31vDXbzAfZCD4zfplvVcFhBYZEgDhTSIV1Dm1foy+QVkxVbi1O94xObKUOOAX3TorhBrrxethCU6G0W9C7YJFT2J0f/7PenMUYBOnKYGd/0KrXC80yHiT64CIQjiI2hwlHDc9I4B4YmJDaIAIEGE57VBqagVwehAuvrtmf+1Y/MkSsVmA6a0JANS6UFwTdgqdahTLoIHOG5FuWkg5a0ebvcrjWbAw6Ij1hHx+WQ7Za890aMUMsRbYbhMOMUu48QP2VRObHf+5Ef2y20+Bm2X/Iwxw5gSp+8ZfltsBh7RFCLctINWDybsCI8eU2XCFBZHgQATKNMl9GouO0oDWFuowVQgNDNXIbKdjKA1Db9vQrOphg6G+DVKsCIJM5QBdo6ZGM4yyYrM+twZUyutFawtgknD3a4uvIn2Cw3BscFXkq4kaS4xY1KfFs5MPp02V4LtiBxWYMZH63ej3DTfeQT+K7+F3OXecgeuUpWmI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6280.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(346002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(66476007)(66556008)(66946007)(110136005)(8936002)(8676002)(316002)(478600001)(966005)(6486002)(41300700001)(5660300002)(2906002)(86362001)(36756003)(31686004)(2616005)(38100700002)(31696002)(83380400001)(44832011)(26005)(53546011)(6512007)(6666004)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0ZicTI2dnJES21iWGlpR29JUmcwSlZZWEMyWHBwcnVOTFU0TnhxbmJBOTN2?=
 =?utf-8?B?L2dEaDZLb3VuckJaOWMwejhQbTZHSjZlUVQrNnVxWkdDdEVYU014NDFiMC9Y?=
 =?utf-8?B?RnRGeC9ZSnhIMjlobVR6cDkwTldpWHpPNmo4QmMwditqVXN3d1BPUVhGNEw5?=
 =?utf-8?B?YmhocncxMllab0lEcHJvb2xXRjBHZXhOeWovSVRDV0NGaVBIWkgrTVBwOGdU?=
 =?utf-8?B?YW1KazVYOHpRNllGbS83MFVFVzM2c0d1eHdPeUxxV1Z2SkJ1ZVNVc3ljdkJH?=
 =?utf-8?B?dEw2amJpZXFWKzFEeDRUczl3YW1hdkNPaGpsZFZhZ3VPQXFyRGVBRDIyeWFx?=
 =?utf-8?B?MzkrMWNIUTJNc2E3d0poVWJzWjZrUDV2cEVmSDAwRGc4QW5KRTk3UjJzY0x6?=
 =?utf-8?B?anU2eGQyVWhKMWVyTzYyNVhHZkM5UXFIbFQ0aHJMdTlpWUg5a0pPVjk2TXVs?=
 =?utf-8?B?ZnZJSXFxQnZNTjFaMC9yTyttazRJcEpacGQ3L1lLZDBjM014QXY2K1gxaGpN?=
 =?utf-8?B?d1pSS2l6VTJNNzA3cm1xa2c2SVpjYklLcGNnUHRBT0VxT1RtWlV4QVZLUmVX?=
 =?utf-8?B?SXY4RitIdnhtZmlSZU8rNW1KV21zYXV1Vit3SGpOVndWOVBhZHliQ2N2MUNK?=
 =?utf-8?B?THlvc1JMM1doWUpCVkF6V040Z1k3UWtFRjV3VmREOHlWTkFkVktCcUp2NzJU?=
 =?utf-8?B?SlFqQ1U4TXlQeStPU2V4TTdSbTUwMFpOU3ZLK1M5NkIyZWlWU2MrM2lUZHFW?=
 =?utf-8?B?R3pIa3NiTlhDelVNWnR2YWczZnpYMEhnL0VDdzA5NjlCTFNuVFF1SEE4d1RI?=
 =?utf-8?B?UjJGNG5McE1rS0xXN0l5RFc0U0pmSldjbThBNE5vRHUwUlVTR0RCUFdjVFUx?=
 =?utf-8?B?djlXMlhnV2VpV2tOZlY0SFhHeStVN21QUjFlbW9yN29TTmRLdnQ2eENYaXpD?=
 =?utf-8?B?SnZ2bVZ2dFFqamF5TEZFYnhxMWU2OUd5Qk11U0p3Ly9VOWhzalFjb0JiYWhs?=
 =?utf-8?B?WTZTdk9QcSt4Y3ZmT0tTTmYvSE1RWlU4Sm1Pb1lISWZRbncyVFB6MmRFVEdS?=
 =?utf-8?B?a0NlMEt5dGdTUXlFb3pVTGg0Q3ZqQWlHSW94R1FBK2o5akhZa0JzV0pmMXpp?=
 =?utf-8?B?Ym16VmF6MGVXZU9lamd1YmpIclRFWTVYSjJzcXQ1U2lXYStsbGhPZ25LN1dY?=
 =?utf-8?B?Q0xrTHFBcFR3bVZ0NklqK3FwVHFqNjhTY0l4RUNmMmhMcDJJSzNpOTJIaXo3?=
 =?utf-8?B?V3dzY1plTXJCMGp0SW5wUXVRc01iNldHLzRSTy83ZzZUeHk5cklibmd1eHZh?=
 =?utf-8?B?WXREZ3F3Tzk4dlpER2FHS1hpQkx5MVg5SmJNaGg1M2NnekdPR05mWXB2bnRC?=
 =?utf-8?B?a3lMN2dDNTRwVFJLZWhYeXZHZVltZWdKNTdYN25zaDNkTkxubmZPNzl6ai9O?=
 =?utf-8?B?RWdZdUZvcnpDNmcvZTQ2SCtHTmJ4enl1L0pESDJ3M0drMjEvd2l6d2xEZEpK?=
 =?utf-8?B?aHp2NVdvd09CVXh2TnYwMzNySGtJK1FhOUZNRkhKeUNPTjJ2Nm5GZlJocnRG?=
 =?utf-8?B?YUFFQTRUNHUxemJNaDRYUStnb3hid0tTK3ZOYVZzYnIzVm5uV21JTk5heDFk?=
 =?utf-8?B?MHpOQ3UyRTJRdGZBUkFIbjd3eFE2ZWVrTHh5bGdydGZ2ei9tNjV2Sk1UVDBW?=
 =?utf-8?B?aWNmakc3UFBZTUhMK2hwSjJhMkdxTmxYTmdBOGVtR1F2Vmh2M2Z0Z2RGOVhU?=
 =?utf-8?B?WC9Zenc2SlpwNDRYNmtZTTNoaExLVzFLOTJSUkVBdHR1Rm81MFFrMVl4VVJ6?=
 =?utf-8?B?eHVBUzhLbm0zR0ppZkRDNkIzY0NkZW94TVJQZGxuYXRtZ01mQVZVRE5NWVk4?=
 =?utf-8?B?d01EM0MrUUZBUVBwTWRHUkpaNVhWYzdoMUs0djNKbzFNNUQ1TWZISGdxM1dX?=
 =?utf-8?B?YU9vc0tvWTRyakkrZ2ZFajRFUHppb2ZiZXFVNFJHTFVPSmlMTWdGNjJ1WjIr?=
 =?utf-8?B?bi9Db1RFTkdoSFIxQUFVSUlEdTIvUFNKc2Q4V2xReDhBQjZYdWk5Wkw4WjI0?=
 =?utf-8?B?endWTkg0TWtwNFdIU0dhTlNzT2VaVno0aWEyRzVUdGR5TUJHSjlpK0Q5SEx3?=
 =?utf-8?Q?k3cAX7wrzLDfJgo1nXYTPKBJn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ae4f42-0437-4637-8499-08dbfd88e44f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:14:19.3622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCZYFCek5UCu0IlZmMmfVE2Hpq9+o63r18lT2clL0WKpCuPs/DH+g/4/4Q2LzHlVOq+9I2Jf94qDKXq9rGPtMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8778

On 11/14/23 05:55, Mikhail Gavrilov wrote:
> Hi,
> Yesterday came the 6.7-rc1 kernel.
> And surprisingly it turned out it is not working with my LG C3.
> I use this OLED TV as my primary monitor.
> After login to GNOME I see a horizontal flashing bar with a picture of
> the desktop background on white screen.
> Demonstration: https://youtu.be/7F76VfRkrVo
> 
> I made a bisection.
> And bisect said that the first bad commit is:
> commit ed6e2782e9747508888f671e1101250bb19045be
> Author: Alvin Lee <alvin.lee2@amd.com>
> Date:   Mon Oct 23 14:33:16 2023 -0400
> 
>      drm/amd/display: For cursor P-State allow for SubVP
> 
>      [Description]
>      - Similar to FPO, SubVP should also force cursor P-State
>        allow instead of relying on natural assertion
>      - Implement code path to force and unforce cursor P-State
>        allow for SubVP
> 
>      Reviewed-by: Samson Tam <samson.tam@amd.com>
>      Acked-by: Hersen Wu <hersenxs.wu@amd.com>
>      Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
>      Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> 
>   drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 17 ++---------------
>   1 file changed, 2 insertions(+), 15 deletions(-)
> 
> My hardware specs: https://linux-hardware.org/?probe=1c989dab38

Can you try the following patch with old fw (version 0x07002100 should
be fine)?: https://patchwork.freedesktop.org/patch/572298/

> 
-- 
Hamza


