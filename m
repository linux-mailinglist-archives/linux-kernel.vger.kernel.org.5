Return-Path: <linux-kernel+bounces-14193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F818218F6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D987E282834
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01BECA66;
	Tue,  2 Jan 2024 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VIdf/fWi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC2DC8F5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8JMGy4GOh/jOkBoONJogf2vTsFrEuuMsmaDHhROyz3VVIeV1fcal9b01DGOfMXD9lCVYmvwjHp4nqL3xqZzaYfI/pmk5vNRM/6sOuKBHCepzMpNT6QCX2w0I8GcZabsU1dFJpkNCm903PJpg6uQMDej08CxKws/Nz1zt1tq+rFBTsQGlWBLHH8ii5hLY824z5AU2bXdNC78U876aA10H2Aq6Po8axFDjB1QSpkgHUjfa8yqw6r0gSW5RqnT8GJGpFn82fNFhNKwvyjsXvIzbILALoeCq5MkrrsX3QYUyVisNHMLBwVmlpZ7024Na9JrDYGdZkYkJ3rTCBk+aJUz/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QY2hoAZgp7IhZRlwId9QiCN3ySLpdFEvOYHWDg4w8gw=;
 b=HT0rF2tHCRIE0yAQRYmTEYDtVYFhiFOsVljl4ESdnNrO+VppXnj8oIXLLlzQ51+XwrAbtDiBiniIL32TlPqcDxcNYhgTWA6uiNMaz0fMYnes+VxlHtNylg+oNgOhGhi7Wli+XDPMjD1PH5wb+kGRJaoSOr6KfheOuPDXvKRvRp/stSwLZrL+mZqvYf78uMwJuu5ME7Wzyj7sBBZCtzKTDFAW0adaF6fMb1UPMtPsJHCuBb+6KcgGUMrWDn3/9Y1ZUoqmGP74vH9KgMR5a0+zSVd4zLM14QsaUMB35rA2f4OQ3/BWy3NT/ID1uFb5hB9G849vqV+mRTSWC2LlzC1ZfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QY2hoAZgp7IhZRlwId9QiCN3ySLpdFEvOYHWDg4w8gw=;
 b=VIdf/fWi2+8xbcNV+1Y/TwWb22EqYYTZpmVHQxUL+NeZI+pqdVwBlGHuN5UV2r2nj7rLVkejKQsRnj9uvqLdbOVQe48pW6urDoz2DPO/jVK7zgTFvXYsIMfFx3oLsNKzbJyZohKCeoJ/If3AE8mnuuCHY2GhviExk9WtA+f/9a4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by BN9PR12MB5321.namprd12.prod.outlook.com (2603:10b6:408:102::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 09:36:17 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 09:36:17 +0000
Message-ID: <5b7eb790-675d-414b-a41c-6e688534de08@amd.com>
Date: Tue, 2 Jan 2024 10:36:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] mailbox: zynqmp-ipi: Convert to platform remove
 callback returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de
References: <cover.1703710628.git.u.kleine-koenig@pengutronix.de>
 <d3343eec618fde99b47b12f792dc415d66b3d7a1.1703710628.git.u.kleine-koenig@pengutronix.de>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <d3343eec618fde99b47b12f792dc415d66b3d7a1.1703710628.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0134.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::32) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|BN9PR12MB5321:EE_
X-MS-Office365-Filtering-Correlation-Id: f11bdb68-392e-4d72-96ea-08dc0b76453d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/y97csotfz8NvnELtK0cNd5psrJQvPFNyOvTnqWvShIiLOPoXg233/V+/7ROhe5DpoEBUIkVoBQiEMKMKS5RBOVPK2ZvvCfRn3KV+hO+hMY7eVRnfKD7hQNmGJX+/p9ijhZhpGWxjciCNdvTM9442rsoJy0kYM7ZmJG+H0A4Bwd4IkqQb2cwqNYZQXL/66ddAgwXXGSJOjaBdf1DqcrPEYk4EvRuS9SwMel8heYmNvd1Oen5F8M4vHnjuoE+ZrVsAvGwqnGkyVHak4g1mDvyM6F8RSC9tE9ge6heSABCEqZ3jNKcNErzzGfZMuiTcQpdWxosdzlst5wJl3JnZoaO8moRm+7uS9C2ho2UTWhfWCTXU/LkVPdJzIzUi9sT2DpRAvxNuJLlVMyg72ke+/0XkrhbD0fspHgAdiMn/AyqxgOplQEUHBEHQA35z7m/67vRk/i3FLwyC8VO7HH5RQNywjbXlRHkAvIiNZWLVVI/5DPe5uG0ycrAT+1t29NXLQ0gi3SNwbRpGeZ2jLna0mtWJVHjcLjfZWUpAlpgec0Wx3kg7sDUJusWt2/ub+2QP9G2OPp4SwloMFxI3dvQoH6UIVLgjBIM0yO51oz/CRHSEuJsMXercAUNj0GbUxVKm+61ElNab/a5RJ1Ei8ku/MSRuP2YSy4DDS6sclniX6A1DWilL0TQXHqiAbyMeYmBZxB6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(38100700002)(36756003)(31686004)(31696002)(86362001)(2616005)(26005)(6512007)(6506007)(66574015)(53546011)(6666004)(4326008)(6486002)(478600001)(316002)(8936002)(8676002)(83380400001)(66556008)(110136005)(66476007)(66946007)(41300700001)(5660300002)(15650500001)(44832011)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1hWbWluZTI3Q3pBNTc5dlBnV0xab1F5azJ4SERpaTBaVEpCM2lLK1Z3NHJm?=
 =?utf-8?B?V003OVBzaWhOZjdEeFNiWVVrQnBXT1pmRVIrcTBLVTF1allpOFR6VzhkOUQ4?=
 =?utf-8?B?SFg3R043UzlYYW1FRnBiaVpVRVpFYm5kVU5zS1VMMGZqY3ozZjBHVGJTd1FG?=
 =?utf-8?B?Yk5HY0JhcERFTkE0d2tMK1lvMTZFQk41YmhieGEwc2xmclhyY0dDNXBnTnR5?=
 =?utf-8?B?VWFxZkgxUThjelo4NXV1U3lYdWVvSldoY2d2SlMwT2FuWnRRdU15MWRBOUJp?=
 =?utf-8?B?YTIydm1OZCswcDVkSEd3dVhJUFBQU21acGtUOThYL2NHWnloYUhxOWZQeGEr?=
 =?utf-8?B?Q0xiTGk2WnhjMGtOeXBqK0I0eE1JUkpubUVTWWFxZDQ5ZEdqUUV5RzlCM1Nn?=
 =?utf-8?B?MW5BYlFVMURyaUYvYmNHWWNobVlkdWRCb216eFU1bDE4eXE0dmplVjAyY2Ni?=
 =?utf-8?B?U3hNTE03ajl1aGFqSGFoWFV1QVQ4c3BRTXh0NEF1anB1RHUrQ29lOWhKb0pv?=
 =?utf-8?B?Y3EvOGV4R2c0T3EyZEZKdFBlTTc1SHg1aDN5b2NSOWVsZHBGZ1NWa3BBcGhB?=
 =?utf-8?B?ckhuaHF3OVZRM3Nad2MydGh3YXJHL1N1c3lTNWNxT2NacGZuNVpPdHhmcHBK?=
 =?utf-8?B?c0dSRXU2Kzl0YmZWUTlYRkNHQytkcjF1WFBxTlloODk0a1REaFJjbk1KUWlP?=
 =?utf-8?B?Mkw4UEtoYkpDTkVFeTN5Vkh3eFdFYU4rUzRNQ2QrZUZjTkRmVTd3bnQrcENh?=
 =?utf-8?B?RnhkVmEwNGVHQklhTGVPbE5wZXhNREVkZlhURUM4alF2MlA3MUVaL3AyZzJp?=
 =?utf-8?B?aXpFcE1BZlhiVVUrMVUrVXQrM1FPeUJpMEdzNWMxWGRnS3JBeWc4QVB2djls?=
 =?utf-8?B?WTV4OE5pUUtIbHRqOGhQRnNtb0l4Snc2R1BadGZTYkdCcVpWaVNMRTY1WjdM?=
 =?utf-8?B?bGtmNzhucEVyamVPWS9pcXlmTXlVSmgvMVcxVktYQVlrZGQyQU5keWR4U3hC?=
 =?utf-8?B?Q3JpMVYwdXpEMHVpWWI1V2hDb1lmc2xtTmFEN3RKWkx0Ynp2b1FpUnJ4SkNO?=
 =?utf-8?B?bTNXV3dBTTAxK2s0K3RCaGd6V1l1WG5GSFhBTWY4ZHVRWVVORDIwbEM3d0ZQ?=
 =?utf-8?B?cDRWbmlvc0pxaVlPODRwWHZzd0E4Zmp0czduekpYVVVzU2taa290ZzZxYlgy?=
 =?utf-8?B?OHJSL1UybVppS2N0SW9QMEFzRy9Nc3pMM1ViVXZqRjdXQ2dnWGxLUStzRHB1?=
 =?utf-8?B?NmhtSUhFbVhoQXgrVGNucHRzZDFpaStSSDVJbUU2UUdDMXFROFVETmFVcWVI?=
 =?utf-8?B?K3NqdlZxajRsL1hYMFZjczhPRFhzb1NnTVNTKzE5cGtSazF5MEtUWHE1S3Ix?=
 =?utf-8?B?TWtVeVV1Wk1RbmVjZGlNemd0QkFpcXlkcnV1NE91US8yYlAzVmNZTENHZ2Zq?=
 =?utf-8?B?bWNYbFFJTXRsVnFiNjVzLzN2NmNGS1ZBVE1hcEFNZHhyZllxdWM2anBPdWNB?=
 =?utf-8?B?NC9sRG1mUEs3N0lYWkwwSS9pQW9UK1p0UFBOMFpNM0RkUk0xRVFMZkhkMTY3?=
 =?utf-8?B?Tkh2bi83YzNHb1FnY2JPQUJNN2JBeHN6aC9la0hGNkkwOUMyeGJOSXVWUEhj?=
 =?utf-8?B?UGZ3YXM1QjVJVk9weWpiS0ZBSnQ0VnVhVWpwOFNKdmhJaWEyVXM5VFhScXVY?=
 =?utf-8?B?MWVuSmt2OFlGeFJvV2VZVEJvaURkcElsV3ZLVk1XazYvRjVFcEpNTWZLUWZ1?=
 =?utf-8?B?OG9CT2MwbFJRUEtlNUswaWswbWJFK1dpSit4OTRVYW8zUnhzL0h0WEx6Z3lZ?=
 =?utf-8?B?QjdJZi9yVGJLR3pLVmpIL2Y1a2lweHU5TTJzbWZyb085SkZXTjhjQnoxOWpp?=
 =?utf-8?B?TGd3WEdqMGI3ejBTcXdtNGVaMzArQVR1cnN3dDVqRzBYb0hkQXNBSUk3Yjcy?=
 =?utf-8?B?VklKTnFTdDlXM1pBZ283MXFvN0NaeWJseUxsS3p3c1AwZm42eGlyTVYvM2ta?=
 =?utf-8?B?Q2V0cjlETmJETUpMMjVrTXQ4UU9HTHRPVFA0SmMxV0pNKzNVbmdYRDBpUHo4?=
 =?utf-8?B?Rk83blEwMlhYSDYvRHA2aEx4elRDK2JTMCtHN1JLY0xnbXIvOHZBbTlnZnda?=
 =?utf-8?Q?nZwe1krbTYbY/pX4ISj+uYdhK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11bdb68-392e-4d72-96ea-08dc0b76453d
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 09:36:17.8003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /V+oa96DuiA91t3ZfFbpw3Pf8DaeKxvp/VsCxhzXWvaCLRcR0W2apeAaYF2Zku0j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5321



On 12/27/23 22:02, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/mailbox/zynqmp-ipi-mailbox.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
> index 7fa533e80dd9..610a92f9c0b2 100644
> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -688,19 +688,17 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
>   	return ret;
>   }
>   
> -static int zynqmp_ipi_remove(struct platform_device *pdev)
> +static void zynqmp_ipi_remove(struct platform_device *pdev)
>   {
>   	struct zynqmp_ipi_pdata *pdata;
>   
>   	pdata = platform_get_drvdata(pdev);
>   	zynqmp_ipi_free_mboxes(pdata);
> -
> -	return 0;
>   }
>   
>   static struct platform_driver zynqmp_ipi_driver = {
>   	.probe = zynqmp_ipi_probe,
> -	.remove = zynqmp_ipi_remove,
> +	.remove_new = zynqmp_ipi_remove,
>   	.driver = {
>   		   .name = "zynqmp-ipi",
>   		   .of_match_table = of_match_ptr(zynqmp_ipi_of_match),

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

