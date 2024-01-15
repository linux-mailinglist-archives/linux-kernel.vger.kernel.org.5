Return-Path: <linux-kernel+bounces-25785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B523B82D5BD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE21E1C21407
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950D0C2D3;
	Mon, 15 Jan 2024 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ojvyRIWU"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CAD8839;
	Mon, 15 Jan 2024 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWzodjyd4Z4ZUkUAFdpMhhSI/bDSVBS62cuq1ATtyUFcJTQTC0+gHkUIgX8bhbjy3XdUoBNy8OvVD+q1nqXNz11OBa4GiA08yAy88PZ725eH4CS9UzAc6aGDKa8QV3qFzRDxfqf8POAeWqb93XXpXI9GNuUJxVr024/o8vDx41gV7o+zlcq9K40LLp2LSCJ75LySEec1SL4WVYD2Vd3Rp2Jf8MtrSQH3mfZVybSjEetezYF7UMwPpeb5k8mYAjiYcyJCOx3rEbIbH/b8wjEHD6wcQqIKHla8DwrySPrbKX6PsJObIlVJAzD94gIriXLQb/snMlaQ+gL5vMN+s1GUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QeAYZJgLd7F2nC9GULlDNaE0gtsmjtpzQ6mqOxeTiI=;
 b=UA3Y4FxN0UFRMRwmQFjhAPvNn5TpD1MqST2WfQP0F3PYLQOXIye4pDTgRrQeXY6pHTMeWG/ltPDJgqoAOFkEhrDLQQmlZTK1XJoph8JW8R97q6zaRNxsqbroTe9FCMAglgzNu4vQojz5+FHmB2xDvtSfr29XRa1uBBqo8o8iZvsvSMSvxTM1dGesql2UM51e3qD0ItmDx+n+Yv5cERBsmwgqN/Geeb2FXI4EcJJa1CyVZylFYiry0meIudZpAWmU8QPWSM7FScdhb772PYKVt1xuJMc+ziVeVw9InGeqR4kJJUwK46nZNAzf/+G+fAqPW9mm119SReADY+pY6+ntCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QeAYZJgLd7F2nC9GULlDNaE0gtsmjtpzQ6mqOxeTiI=;
 b=ojvyRIWUeVB/6HMldw7rWIrgoE9ZmuSCZKy/3aUzWOE2UqsMqBAA5NPnRF9E+OgxftfFMYG/fFuilJrUnitMwqvuXzGThlj1QujA0eQnMOlhr12AWKhHkgNgPkeAYQAimBH8Wv1twjOEq4bCvtkCqOmV5abgBrECuQ6q2q0x3aU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by BL0PR12MB4882.namprd12.prod.outlook.com (2603:10b6:208:1c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Mon, 15 Jan
 2024 09:20:48 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Mon, 15 Jan 2024
 09:20:48 +0000
Message-ID: <827695c3-bb33-4a86-8586-2c7323530398@amd.com>
Date: Mon, 15 Jan 2024 10:20:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: ignore paths outside kernel for
 DT_SCHEMA_FILES
Content-Language: en-US
To: Rob Herring <robh@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20231220145537.2163811-1-andre.draszik@linaro.org>
 <170432630603.2042234.10993333941885772911.robh@kernel.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <170432630603.2042234.10993333941885772911.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0029.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::42) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|BL0PR12MB4882:EE_
X-MS-Office365-Filtering-Correlation-Id: c683e418-4781-49b6-9828-08dc15ab42a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sCF5s652e/QQJC0QMnT4OgjzwAZbrxLqQxgO/gBI76Tm3kZZscUkl0d5KGsTOTi80Puz4eUuZPUfQsBrGTOfdD/EZERI9jzDRew1OQXh0ZErUkFZoldMFutWCtqh89nmNfqr4vGB4cQ6irepUN+pfuDjEEF0D6yQia7u3g+QZmc9K2WYW9q3I/RvENGeuB+W1nPCrdP1CbDe1crQcXN6HZZZrto9phenrDORudGl2+r1I5ka+qI15kuXVGi5TwtWRyp4MfvQm0/TP+vsvBb0W7VJv4o7trm9Pf0k6LR2lBdVBOsa3OUg71b/xaFYOFC31W7HhiED24HlheuRwBqA8dZPU0lKwxhalAp5t75eCDitfUQuHlq3nVY6alxdmejyfj86kMCIaN/3/DGe8VHL3z0WawCfcJm5nErzXbJUy6dtMM0Za2iuFoOghcOMJqMdZ2SniMSJ3tY2xXVqPwfKJ+0igt6dN/Xxe4xUcnVLsVqU3/FiuEZxemU1ZwuUEH2JOkhXO50KNGpNHS1c9vUs89dncXo6UZJihRudNiBMYwJyDv1OFIb44maTyAfOjlG19wMc0t1cxqXoctpRgmzzrOkNdXcl6pBnTLtYYt1dzRAzZG6liV6KM7z3U/TJ9nPsSsu224GriUhUM4sd18o1OZa3W10eUsputkBkgxYqY9aaVrxK9RpQTPAmTqmg0+kv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(230173577357003)(230273577357003)(186009)(64100799003)(1800799012)(451199024)(8676002)(5660300002)(4326008)(8936002)(2906002)(83380400001)(26005)(2616005)(38100700002)(31696002)(86362001)(31686004)(53546011)(6506007)(6512007)(316002)(36756003)(6666004)(478600001)(44832011)(110136005)(66476007)(54906003)(66946007)(66899024)(66556008)(6486002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVJhVTVwcjdJNkRZU1kxT1Y1RitML0pyd3pBUS9tSGZHd3BPOWlWZlVNSC9a?=
 =?utf-8?B?SjNrU2NKazVGeXNlVDhORnJZUTcvWUdocmN0cWlBYU9FSFhsK3pNWUdZeFQ0?=
 =?utf-8?B?UmduSHQ4bW1EMkJ0TWVBbE0xdW1NMmQ4UDlaUTI5QUNGaTg2T2syajVaL3NP?=
 =?utf-8?B?cy9kNnhuT3lCeEJvMUoxaDlrMGlxOVFlOGh3Y2U1UEduWURlK0M1K3dFTlY1?=
 =?utf-8?B?UUI2MGNXclIrakRtWUZ3aFhQMWFDVWlPVlAwbmxJaGdVSjNEcDYrclNPbitj?=
 =?utf-8?B?N05NMEdUOHBxNTdKWXB5Tld0cUVJREExb21yblR1a2NCYmxybGJpRVpzeGNF?=
 =?utf-8?B?QUNPS1JBYjNjWUZROEtCQW1TNXV1UDd2MWZoczdlK3ZHQ3RNNm9IQnBpWksw?=
 =?utf-8?B?dW5ha0lXaUdEdVdBenZrSEMzZjF1c01ibkFDZ1dza0dxMFJCZWEvWEtwRDR6?=
 =?utf-8?B?ZGJLLzNyREtLdVYrR1N6ZVAyM0NSbmszR2VsZjU3NEFzYnpneWFhZCtnNEhr?=
 =?utf-8?B?ZGUyV2E2K2h5T1pJRjZENmJBbUdtNFZlUHJDWE92SUVGRENJZlhRTWRwYXh2?=
 =?utf-8?B?NkZ6T3h0TElVREJrSysyWVBwdTlBVlY4VlRUMWZYVkpGcXF6Z0h4UURVVkFU?=
 =?utf-8?B?S1p3SnlGRUltZzZSNTBlRFRqcW9uY3NrMkNTL2Z0TzVaclp1SEVFQjdnNTNR?=
 =?utf-8?B?KzhRYmJSTFNRcTNuY2Jaa2hQZi9sbHQ5WFlTRng2VHVUMDdoVWI1SHorOXdD?=
 =?utf-8?B?VENSNHRDL1BhZ3RIRUpkSkdQWjE1enNPdlN2YmtxVGRmZFpudHFnejRzelFo?=
 =?utf-8?B?em5LWFVSRTVEN3hNbTNnSlh0TWx5Wjc4ckZLZ1F0Nmg0ZlB3Y2RlZ2hPbVp2?=
 =?utf-8?B?bkZkRjlxenBoSWNyRCtvamxwMDEyWmxVT091NXRSZ3NVQXA0M2ZDM0UzMjlm?=
 =?utf-8?B?dW1YNER4OG40Q2NiUGNrVmN2Q295V282M1lzVTZ4NGVnUVdPeEh5ak1USVhl?=
 =?utf-8?B?Z0NnNWx2VkExS2dNc0xZRXZ1bGIwM2hmQ3NPajlYdFAvcU8xellsWlRJMWpW?=
 =?utf-8?B?TzZqNDhHYWJXM2k2SVFrU0FUU3pkT0RpRjFMQjc2VTZ3QnZqYVBqNDE0bnJ2?=
 =?utf-8?B?SSszR3ZPRE14TWIxUlVxMndiY3BNRGZRTWRqY2hRcmIwbFFPOTl0cVpJN1dZ?=
 =?utf-8?B?dmRhaWNtSGg0aCtpRnFhbmE2M1FjOTFUd05wMllUTEdNNzdOblJoK0NNaTNQ?=
 =?utf-8?B?eU5XSnp0L1d0NkZtM0daQmt2WVJrczQzRjVmRUIyaTJISFVnbDA4WVlEZCtJ?=
 =?utf-8?B?RngxZjBOZzNBdFRwOGcyYVdhMjBMclNBWlBSREFmSHMybW04OE12MERQWTFM?=
 =?utf-8?B?NjhFQ2F5bHRZa0RwWmNoczVLbjFQVFdaMnVkNCtaWkxhdndjU09MUjZjSjhE?=
 =?utf-8?B?WUV1UWlEWTJuWDBMd3YxVGtDRzdGVXBLWWo4VTVSMlMzZ0gzOVRhWHdIRGhQ?=
 =?utf-8?B?c0NnWTArS0lFTGlWNkVBSTBYQS9mODBUd2RVUmtJd3hnVTAzN0lucE9ta1Ft?=
 =?utf-8?B?UjdoZnc3R0I0VnIzM3ZLQlFoa2c1cHg0VHhZNExnK2NneWkzbzNFaDVXWkNB?=
 =?utf-8?B?eS8rUzlXaFRmSU9Jb0JZZmhneVc4MlJYMzdpTjkrWlhyUUhJWEJuNHR5TlY5?=
 =?utf-8?B?VVcxT2U0bm02WTcwMFlPb0VVZnpBTFJ2bUI1YXhyWmRJMml4VWdtd1kwbXkw?=
 =?utf-8?B?TmRBYWZuUytzRytRbFB0U3MzZnVMdnRQdEw4OGFjN3pOSFY0UVdMN0U0dGtN?=
 =?utf-8?B?S2tWWCs3SUtmUE8vdmxmWGUyVENoT2V1S0kvQk45aEJpUXBqQ0gveGFEZURw?=
 =?utf-8?B?QW9EVGMzVjF0UWVCMjJPMlc0Lzg0ays0TG1XaGQ5TmJwdHZwOVNLTE1tMHB4?=
 =?utf-8?B?WW1pYXBwTE9kYWRyQUg3c20zeUtTeEZZbFBON1JtS0gvY2RQSWJpU2pINm9H?=
 =?utf-8?B?NEpYWmZVV3FRT3FXUHZCQWZoRHpXVHJ6cjFubmp0Y3JFcXZraGNwZkY1OXc1?=
 =?utf-8?B?NHdFUXhxZDc3WjhGckZMbGZ2WG1vdmc5cDdOU0FDeWVlNGNMenkrS3phN1Ft?=
 =?utf-8?Q?Qfx4bvV51CZekZ5Ox9KFEtTHs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c683e418-4781-49b6-9828-08dc15ab42a6
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 09:20:48.3974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 795Cv7D4gLHq18iQ/L4sooActzbyKoHNb2sOd9XAqdnZ1MO+ZCU4B4YipMM93sbb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4882



On 1/4/24 00:58, Rob Herring wrote:
> 
> On Wed, 20 Dec 2023 14:55:37 +0000, André Draszik wrote:
>> If the location of the kernel sources contains the string that we're
>> filtering for using DT_SCHEMA_FILES, then all schemas will currently be
>> matched, returned and checked, not just the ones we actually expected.
>> As an example, if the kernel sources happen to be below a directory
>> 'google', and DT_SCHEMA_FILES=google, everything is checked. More
>> common examples might be having the sources below people's home
>> directories that contain the string st or arm and then searching for
>> those. The list is endless.
>>
>> Fix this by only matching for schemas below the kernel source's
>> bindings directory.
>>
>> Note that I opted for the implementation here so as to not having to
>> deal with escaping DT_SCHEMA_FILES, which would have been the
>> alternative if the grep match itself had been updated.
>>
>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>> Signed-off-by: André Draszik <andre.draszik@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
> 
> Applied, thanks!

This patch is causing issue for me. Look at log below.
I am running it directly on the latest linux-next/master.

Thanks,
Michal

$ make DT_SCHEMA_FILES="Documentation/devicetree/bindings/arm/arm,cci-400.yaml" 
dt_binding_check
   HOSTCC  scripts/basic/fixdep
   HOSTCC  scripts/dtc/dtc.o
   HOSTCC  scripts/dtc/flattree.o
   HOSTCC  scripts/dtc/fstree.o
   HOSTCC  scripts/dtc/data.o
   HOSTCC  scripts/dtc/livetree.o
   HOSTCC  scripts/dtc/treesource.o
   HOSTCC  scripts/dtc/srcpos.o
   HOSTCC  scripts/dtc/checks.o
   HOSTCC  scripts/dtc/util.o
   LEX     scripts/dtc/dtc-lexer.lex.c
   YACC    scripts/dtc/dtc-parser.tab.[ch]
   HOSTCC  scripts/dtc/dtc-lexer.lex.o
   HOSTCC  scripts/dtc/dtc-parser.tab.o
   HOSTLD  scripts/dtc/dtc
   HOSTCC  scripts/dtc/libfdt/fdt.o
   HOSTCC  scripts/dtc/libfdt/fdt_ro.o
   HOSTCC  scripts/dtc/libfdt/fdt_wip.o
   HOSTCC  scripts/dtc/libfdt/fdt_sw.o
   HOSTCC  scripts/dtc/libfdt/fdt_rw.o
   HOSTCC  scripts/dtc/libfdt/fdt_strerror.o
   HOSTCC  scripts/dtc/libfdt/fdt_empty_tree.o
   HOSTCC  scripts/dtc/libfdt/fdt_addresses.o
   HOSTCC  scripts/dtc/libfdt/fdt_overlay.o
   HOSTCC  scripts/dtc/fdtoverlay.o
   HOSTLD  scripts/dtc/fdtoverlay
   LINT    Documentation/devicetree/bindings
usage: yamllint [-h] [-] [-c CONFIG_FILE | -d CONFIG_DATA] [--list-files] [-f 
{parsable,standard,colored,github,auto}] [-s] [--no-warnings] [-v] [FILE_OR_DIR ...]
yamllint: error: one of the arguments FILE_OR_DIR - is required
   CHKDT   Documentation/devicetree/bindings/processed-schema.json
   SCHEMA  Documentation/devicetree/bindings/processed-schema.json


