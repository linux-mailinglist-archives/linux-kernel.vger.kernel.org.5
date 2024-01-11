Return-Path: <linux-kernel+bounces-24055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0558A82B626
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953BE286B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C7358113;
	Thu, 11 Jan 2024 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jSGWDjr1"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F225810A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 20:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRaZZu4IZFwTPFfs8lGNtlIiDBjXGHIWh+SHlVW/FTXE39anqwFJqScFTxXT7LktIuWsoVxBBCrPjDVN0+tlCP/jRssUsUDC3JWAvcieQDJrcQH0YkvaMD2pXreDBZ5e9LTLqwinQn41NZdJY5zNPzpClnbE65EBb6TKHJwpxYvOMRHeusGD5+FHK6J5/8fQLAJnaOUsZJk4Blwu87nGhVThuys3dvlVXBKgzH5mj2mDDX/gMz28vKsiw+MhbhJJ3KXo6dhjLfny1UcLP/fVZh0yuUy+/cKvwBOvsxzV6DjYhzljO9S0U1v/qTlF3HFJ+XAhyAi7fmQJ7GLRPE5kng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyP3TvnFIm798nCZ0lCM5dlT6R/Ny4UMVe5Mbos/nAA=;
 b=dzeuWi4TFgwINYYKHBjEcme1xwb4PfRy8Yh4MObVQ1vflvqTbpjx1ed1f2nK402btmcnAyaqsdRPzVupo/ML9pbeIEt/mPb3cxcTdZ4qX0T6L158caYKEe8d9expUMjFlrZPB9WnT0YQDA3+TFNIc6cN7URWNmQi+76YwiUcFz23gzrVVLOsG7DuiG1vyMVx3LtrjHAXuRFj4J+8tlPT3xrwG3vASGi0kXACNsCH9coJXa7q17JjyM3gjJ0TYLF88kSMlhB7i7Tv0wSewq8jNRguJPEulyMK9TwwjI8B4V5SAvChhyg8Cv3JMOPIB3myGiDpCmLSaPWovgpyHB/DbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyP3TvnFIm798nCZ0lCM5dlT6R/Ny4UMVe5Mbos/nAA=;
 b=jSGWDjr1D6ozhMlnVT+ftbDWjydt+Cm79dCxjGdvIL5vgHHmJXj4G1jw7wTpIcfs6dAtcG/L4xzmaKKpEGKuEVW16CJ4OFMS+tw4QVZyMBg0MGvA/4nphG5sStNHI4OvPNgmF9Ru0hZFw/PaVdiSg933ZVcdD+67qveW1Oi01lM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CH3PR12MB8458.namprd12.prod.outlook.com (2603:10b6:610:155::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 20:41:55 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c%3]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 20:41:55 +0000
Message-ID: <d6bc1751-a9f1-43b3-aac3-e423911ce605@amd.com>
Date: Thu, 11 Jan 2024 14:41:52 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] x86/mm: Fix memory encryption features advertisement
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Dexuan Cui <decui@microsoft.com>,
 Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
References: <20240111111224.25289-1-kirill.shutemov@linux.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <20240111111224.25289-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::11) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CH3PR12MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd6cc28-dbc0-4da4-cd4c-08dc12e5bf87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0rKPhhuTRUuIm/7D95fiIjjYieC2Lz6xaA2TAPD1AVbtMRIsZ7Nx2605g9W0nTn2jy7ibws9GHnBWtSYiKIg4+ePG6TBATJ7vnIz0Nigb2Tf+xKQRPQA/FyxFL665BUJiIg6WfJ78bxTtFMfS4e+n0TzACvD0Nv8vod0WASez3lbZUtj2FK9G7fCy74Ed3bfW8fIb7TEZWOwTmpbBZychLfFTZTJ8vQVFfuyExPIolatQAsog8qtwbLEd/mh8qyf1uxIAxhKix7Cl2VoN8t0sRPsKOf5X4ocAnD/rtuoKdOx0/q4oLNjF+m18pSqHYwNX/PeJVobTYmERDKkMTAzImWSzKFhsmHnU7yeplgiU5LRmwkR/zREIRDy/FWbwFDKKbYHIs+lOHbcVdxpPziQQSAE/QpzDdajRpbz7fyRcP5DF1au0h7IxQadx7eAlnh0ecqOF7mhwADO4Dj6Sfq7y+1vvEIpg4pUlVwQv6z3POd1ioW0gQzjzvVSt98qdTxzbsslP2jT/xldtJAvxwdWJ7V8gp9sAjuvvCIJELKoLHmwHtjXQsuBj7+eH0mKlL6gcDVgkUyzwT4nOuCrHhLmiIwng8zrsyTZaTmfFjN+AOhm/ewNmdf0zI2rwm0vPSIldFACy4I1a+uFOyK1jtTQpQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(83380400001)(86362001)(66946007)(41300700001)(31696002)(36756003)(38100700002)(478600001)(316002)(26005)(6512007)(6506007)(53546011)(2616005)(66476007)(6486002)(45080400002)(2906002)(5660300002)(110136005)(6666004)(66556008)(8676002)(7416002)(4326008)(8936002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWNnUGZyWDNyVEsxT25xQ0hBZ3NwSmZsanhjQ0xvbUhLVVRLbktlZS9VU3N1?=
 =?utf-8?B?WGtkVU1tdVFzQ0pYV0JRWXBrUGNXeUhMdllrQXVURkF2OUt2T2p5dXlzWWFP?=
 =?utf-8?B?ZXNRZU15Z3Y3RnFIOXB2RXdLMUthRms1ZFBTSlN5QXJHWXVFTXdsMWZNV01j?=
 =?utf-8?B?cENqYXYyc2puclIxWmhIaTRuaUtCcXBKL2IxVkRkUG41OXJ3b3lnWEh1Ry9F?=
 =?utf-8?B?UWdUWEdKejZPL2ZmdCtNWmRVZjZ4RVJJNXVnemwwNXRwSVZ2WjJCQnlNMjFi?=
 =?utf-8?B?T3V0a1lBYjlkc05BNkkyc3dheGlVZkVHcTByckwyZWRNeWNScWM0N0ZFL2RJ?=
 =?utf-8?B?TVBnVWpVRllGU3JHbktmMEJoZ2hYYnM0OU04WlgxSGl6NG9jdzREdUdqbkVM?=
 =?utf-8?B?cU5GZW9tUDBpNENVOC91dUdFNzNVVXNNRFhsTGpqbURqSVB5RThraU1EZ2Rz?=
 =?utf-8?B?NStWTndaM3MrbUtiSmRQNjFrL2NVeFpKZHY5TC9pNHM0VEcwT3FQU1V3WHJ5?=
 =?utf-8?B?aGZGVDdCcG9Mc3ZyYzVNR0FpaDgrNCtrOFVGNFh5QXBPUjFzdFkwemdnNGdV?=
 =?utf-8?B?RHVLN3VEc2lyc0ZMSW1ONk1TTUhlWnpzeVR1ZVJ1Q0FtVkxrSkJTL0hhN2kx?=
 =?utf-8?B?THgrcXhudGxHeDNoQlpzaFV6MlhsNm5QbFN4NDM1VlZKQ1J3SWFkczg2Tk9T?=
 =?utf-8?B?dWx4bjZpRjNQcXJubi9GaGhCK08vQ0Z1azBFOVFkWi9Ka3FJTHFjVkk0MlM4?=
 =?utf-8?B?N2g2WU92SWV4S1hvQk52QzNtSkpwaEdsc1EyMHlZOHhKQ0hGOEhmbk10VDAx?=
 =?utf-8?B?OUY2aVJ1SzlpNGNGVExyTDNnQkxxUXRCaHV5cjFUMXZWUDA5alVXclU3SGJt?=
 =?utf-8?B?QnpxbzZXcmdxdnh2MDdBcjl6ajMwbDd6dHA5eFNhTXNycDdMUmNoWUMvZ2lJ?=
 =?utf-8?B?anJCZXJxZjBiU09vMy8yQ3NGNTN4YW1XSnNwa0xyNVFoSmNZaGNIZXVmM1o1?=
 =?utf-8?B?WWpPZG95TSt1bk9Va05sTG1aT2xZbHZXamdNbXRoWFVPTTNhU3FoMFBkRXZ1?=
 =?utf-8?B?SDRraFVIdzdvVS93K3ZsSSt5eEtYVmt6YjloazVRbWw3YUIycmlnWXc0Z3Zw?=
 =?utf-8?B?VlpWZDlhN3ZOeHh0STVySVhybDkvNTNGSGlRSDhsdG4yTXU4Vm5yL3dIU0I2?=
 =?utf-8?B?VDRCREVTUEY2ZHFWOVpsN1BNaVJEbHVQTHVaK3d3UGQyZDYyai9LOGdlb1lO?=
 =?utf-8?B?enRidmFjTHBWSnRqVGxGNlV2blZ6MERTTEFOV1ovRlM5QVllbkRjcHJtYWhk?=
 =?utf-8?B?d25taDRLUktrVnJtN0dwK0RscTJ3Z25FTitUZ3ZsUU5DR3EyVzVVNm5xSyta?=
 =?utf-8?B?TW9kRlRSRURhSU4xWm5icXI1ZjdmNEpxTEMvSDY1ZnEzRnNUcTJCVU9CZEpD?=
 =?utf-8?B?OW01RzZMQWtQMk1DTmxjNU5sNDFTQ2MxdHhBQUMraFBiRGNRZEFyVVVzVjg4?=
 =?utf-8?B?QmJVdWpzaWdEVmE3cVE5cFhiWXFnYzlMVXBaM3EvUFNudmlvZUV3U2w5ZHpW?=
 =?utf-8?B?R3JHd0VhNUJqSkV0UElDZk1DczA1T296NGJVenkzTU1tdUdrWkxoU04xejRw?=
 =?utf-8?B?Y2s3N0FlbkFnaDR0L3pqenVySEgraitIelROeVdNS2Vra2pUTWhucWl3UXNI?=
 =?utf-8?B?bVpTOStwbmJWWEZJY0Z5RVVRSms5SjZLUlRJdjhuZ044a0tGY081eW95dDNx?=
 =?utf-8?B?eXFrc1FReWpVY3pmK01TWTlNTUFUVnpOZ2NoczcrUVpUTElvdkFDbVorSlVn?=
 =?utf-8?B?c2xsVDlLbGhPdnJzMW1tS1F0aCtML0lLQ3pVd1k1RnBoQXFXTldJSjFrVzhJ?=
 =?utf-8?B?K1dheVJsZ3FyVTRFWW5kNm1IbHdMVE9GZm5aaXVnTzlzZXBwcHVCNUZ2b0Nu?=
 =?utf-8?B?N0RIdXFUNXhiR2w1cDNiYWxEcUpKaHRudTZSWnhyZTJQMXlYTXZtWlVCcHFW?=
 =?utf-8?B?MTlMemlrMHZqRG1mMHRiOWl4UzZhMTlBL3NuTHEyc3AwMlkwT2JBTllSVmFO?=
 =?utf-8?B?TUtxcXVhZnRIM0lpSE9LM0hXUTFXeFZyTFpCd1NtQVVxSldPL0dyVXpRaGVZ?=
 =?utf-8?Q?g772A8EFTO1vqjqwhvsETa4p3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd6cc28-dbc0-4da4-cd4c-08dc12e5bf87
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 20:41:55.1317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sleXlFOE10yVuUbE+FnQuvPYa0yqyRBSQYm7+xqzQTQJCsgpigivb7Pc0jezR70ASY4AAWAIXtNm9xP6D5EMFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8458

On 1/11/24 05:12, Kirill A. Shutemov wrote:
> When memory encryption is enabled, the kernel prints the encryption
> flavor that the system supports.
> 
> The check assumes that everything is AMD SME/SEV if it doesn't have
> the TDX CPU feature set.
> 
> Hyper-V vTOM sets cc_vendor to CC_VENDOR_INTEL when it runs as L2 guest
> on top of TDX, but not X86_FEATURE_TDX_GUEST. Hyper-V only needs memory
> encryption enabled for I/O without the rest of CoCo enabling.
> 
> To avoid confusion, check the cc_vendor directly.
> 
> Possible alternative is to completely removing the print statement.
> For a regular TDX guest, the kernel already prints a message indicating
> that it is booting on TDX. Similarly, AMD and Hyper-V can also display
> a message during their enumeration process.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   arch/x86/mm/mem_encrypt.c | 56 +++++++++++++++++++++------------------
>   1 file changed, 30 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c

