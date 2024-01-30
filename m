Return-Path: <linux-kernel+bounces-45335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69E4842EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B774B222A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8B978B6B;
	Tue, 30 Jan 2024 21:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="j7/Y4KvP"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F75378B4C;
	Tue, 30 Jan 2024 21:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706650473; cv=fail; b=pT59ARYaq00rVlkzpK0NZ1OaUZPUpAOewsvYHYuPjjZDZ9YL84tsbdKT/c4gnYKcGtzcVVPx3N0pytwFv9yfWvR0wQiV2Y0xx7keSPKVflBeCmvDRnPzfVJ+KtHvqRpCfqHtb7j2mtavNXbt2X/pGBSJptsEvZQno2D+EKBLBWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706650473; c=relaxed/simple;
	bh=VqTFMuxx+48lJhCAANAq3x/qWXFl4qiJSLLjhGKgHHA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o6qyzDI2P3TJrLlM+1tLVGjyNBnUkg3NABjuyNp3Gx/gg5v5MFOBwL7P5vTN4OvH/4GbxaZeq7egUWUbIvUKSfHXHHSKmt2L8rc+4R6rI1Y+hqprw7s9VEck+KI0TYMngNi1dBbestF0IcdwoTDV3/9b7RffCjfuNi50tJ7YbZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=j7/Y4KvP; arc=fail smtp.client-ip=40.107.21.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4lIIYuQJSu3aDZeK3gXRughIClTesJ1E19RVjdXderPPVsrKYIxfYeK5OJZMu3qHaRfw+tL4WhOJUNvL/WjO+dk/NAbcbWOQJSqLpp+ysilSrLf2CgBvSakGJMmXyZeDTNLXcTilWHz7e+rvUOl81WBhy+DmMgJFK3rbfVobeSELZujAr2b0jYcobHtRyOQxUD5SmdXfan1SgjseH738iFvFpEC8De1rL/MO3IfmEUKXoRTCN3YxWePO8XnVFflBTZblSy2iFALu91JRKDz9fkp1enhFQSa9UzTCgFLJEmZksCXbfVnxou/8E4y+WpxEAsoguCAJWpUeCj8gca1XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdgnAGCzk5a9b7QqNBmhDxmua/a/d2V3YVoj232SuYg=;
 b=lRQSwG2NVFM0ZEH9rALBpv+OSukiwbuOCcdGq8Rvflr29IkQfQD+61Bydc1lRvC0nNSiC37uJ0I4lS5m0mwZbM3ifUFOi+P86y1HHox4ErunYnM8Ib0yOh5KbL4YfrmR1i5vwpJmdPiScZVRytcE8wV2PyGieVFmOifsmQLIPuafVurMEuwxWtUrX3mUaiRvjdLRN4ViuAmVPUzQMeeV76qh6msqs5zTSle38gfCJjV+YWFdGMH9Ioe5iBzyzDTnlDyGJ2pWhnLnl0LIztsdn1pCOjB1bXL5ihj8EnSG6TNHNeiJDdoHOQwUVWP+rieVzgm7LRPDreSe5cF9TSu+xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdgnAGCzk5a9b7QqNBmhDxmua/a/d2V3YVoj232SuYg=;
 b=j7/Y4KvPxyp6ftE8i2sBD6/mY+htiSwz6HkJecKNxm1c+axpFpKhFI/tQ33rP1MTA6fmWN1+5D1MOjfncaGcSIx3XDIYloadqN5FYE4fi7OftUMlX+34x8ZZZa78Z7lKUqEQr+VGKySoBhOor/ZoSkcMeM3qVGPB2SE4b0TSFDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU0PR08MB8812.eurprd08.prod.outlook.com (2603:10a6:10:47b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.33; Tue, 30 Jan
 2024 21:34:27 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 21:34:27 +0000
Message-ID: <e8ae1f05-fe57-4fec-9e7e-1fccaed171e6@wolfvision.net>
Date: Tue, 30 Jan 2024 22:34:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: rtc: nxp,pcf8563: add hiz-output
 property
Content-Language: en-US
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20231024-topic-pcf85363_hiz_output-v1-0-50908aff0e52@wolfvision.net>
 <20231024-topic-pcf85363_hiz_output-v1-2-50908aff0e52@wolfvision.net>
 <20231025222327c0b5d460@mail.local>
 <2f17c031-30f6-4242-b2a1-1628402b3091@wolfvision.net>
 <1c4a6185-fe09-45d1-900a-10abf48e3fc9@wolfvision.net>
 <20231026005008b8255799@mail.local>
 <8fec6c89-548b-43b5-8361-869663a58573@wolfvision.net>
 <202310260956166bdcb845@mail.local>
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <202310260956166bdcb845@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::22) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU0PR08MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c9e86f0-8049-4461-89ba-08dc21db3bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+Tk+Dpx3WiIbc2BKgW80Mew2dDsFiiCX92K2n148O7xZGOc1e9KZBvAIamOPjPAiZ64rDeZHRR4mZ7uLfzPg9T97+UBdq8jLoEpdok87A2C24B3M/CozdvBmoAsPamcNUMp2nyObX5P5YyVP0TOndUYt2dgk/dCz1wUBOVdpPHr7c/mw6yASLNJ4scxoRmzc7DWdUC9eeR6SYNhjkGsnNHtrFvMsv6gIJTZkYFIoy/QZZbEiib+xfqehAVaXXsVR+bCQ0Ty82KmgOom6khEj1mxGXTwT3KcfQxsk2ESL4fykyITDTpPzGdEJKqAPJzS0UYMzQwv66/w9RZ3Pv90hsOSkd/I2QB61q8+UoNYBsWTIV6EZ5DR8zvxtQ6XN5C95DJ04U3ukuO8sxA7JFHJgvPijrhW3lkixWErb+NmzN06iXRuZxyQViQOrCndfKlpzZ8DnEQvCiqqHCtCzzsceMMpUctAKasY1k5XSXEv7AAaB+EshLdUbh5plFERz5VLEXxpZ3OnMZ+zmeEIiF4ZNHEeBuAcS6hzoFimKDiokYx6SJ6fE8z4iooFE0b4iPzdEbLDznDf3X0w+5TbQZVSxRbzlOmEFVcVjj4dBXMpqK4Ymk6Jih2RoCBZdkzj/wRNVVtCfKMv84nmzkvX8+r+Z0w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(39850400004)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66946007)(36756003)(31696002)(478600001)(41300700001)(38100700002)(6486002)(86362001)(83380400001)(44832011)(8676002)(8936002)(66556008)(54906003)(316002)(66476007)(2616005)(4744005)(6666004)(2906002)(6512007)(6506007)(53546011)(5660300002)(6916009)(4326008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1VLMGJNWXBQS01RN2p4Njg1WlBmcDhhdXhiVnBsbnAxZEk4ckxEUTFmWWkw?=
 =?utf-8?B?Q09MWnhsdzVBd0k5UlU4RU1jL2h2dDZpVW9WajEyRlZadlVEM3JVOGxabkxn?=
 =?utf-8?B?K0J6Y2tMQzBzUlZGcUpYazFTY3RMRVBKZHU5WWZpZmp6V2dZN3lIby9LL3FZ?=
 =?utf-8?B?QVdBRnNqSkoxRk5YbWJpb2RVYURhbmVGNG9pWGIxMm5EanJySEFNbFo0ajRt?=
 =?utf-8?B?VkJLTDhqYk1GbVd0bVk4M0RhYllBTkVnZUljb053dU5PNzFFSXB5K3hEUnBh?=
 =?utf-8?B?cjJ2R29yTXRsYXFuRkx6VWRaZXJhbExMQlc3QWlLTmtMeFhkdFhXeHI0Yld5?=
 =?utf-8?B?Ri9tdm5GZHZpdTM2Z09XSXlicHl4Z0l2a0crSTRNTFNVbE1lRHU2OStWNENK?=
 =?utf-8?B?dkVwUHVpZlJTR2ZkMi9CemV2NEdaZTFPaDBFOEp2M3NuUXA4dlFaQ2FiMXpB?=
 =?utf-8?B?N1U0QnNPWnpwQ1pydEZmWGhDMDlxSjFtempjeXRETHQxWUFDWjV5UWpwSEcv?=
 =?utf-8?B?bFphZHhlWDdHVzNQemtad3RHVFBOa3FHOFFZY0Q1S3NNNlBPbmw1U0syZklV?=
 =?utf-8?B?VHV2WWZKUFEwdXBvYzhhQyt2a2lFU1krWmVGMUVJTytJNDdhM1AxZ0xaNzd5?=
 =?utf-8?B?VWk0WXRQRVhVYmtYd0VtckFHaEh2MkxLM2F5THJTa1Y1L1FkL2kzZTRBK2ZH?=
 =?utf-8?B?ckg0bFJ4MGthV1ozdWRoK25EN25mbDF5Rmp3Z3Q2enlrdjR0WjdCVGxzdFZE?=
 =?utf-8?B?a09seE1tTjdZLzU4MWZhVTVhUWRPMEJiWGR1dlFNSGlIenhnZmlDMjYwbDR4?=
 =?utf-8?B?M0xrNENmWStFdnlXdnhtY2NMWXZjRmx4bmU4djVCZXF5QVdMRmNPQU1CMm9G?=
 =?utf-8?B?WGlON3NPZ0JzczBNUUlJZ3NXQzBNd0VSWFgvY0hIUnkyR0ljaHdQWEJVMWVI?=
 =?utf-8?B?Z0sycFBSdC82bis0d0wyb1pYR2JwSC83c29Ca3lZVTdrRXZjYlhvcS9VdXVm?=
 =?utf-8?B?NUYrK3FBb2hmK29yM0dEaGFiYi85WE9pNmxWc00wUWVFK2Z3TzYvMm10VzVK?=
 =?utf-8?B?QXA1UWtEb1NaOVpaNnZJc1VrYTdZU0libHUzZjNWUlNlVTFQS21ETERvTGYx?=
 =?utf-8?B?dXMxSGV3WDQzWDcwS0x5eURmQ1JiSlQzaHpSVG9zNnREcWFiSTB5VFhLNEl4?=
 =?utf-8?B?WnUrZm1LQW9weGU5b01pRUtwMkRQbjI0VXFJa3c0eTZnOG1wM2VEQWJZejZQ?=
 =?utf-8?B?OXZiYm00TkZhY1hkTDdnZVN0K2hMWVg2RmJ5ZU9TYVdRMnQ0YnhMOGhPQWc0?=
 =?utf-8?B?dHBFdnVpU05rVEphK2hDWjY1TXUvWHZsN2QrS2VORzhVSmNyYmhONWwzV0lN?=
 =?utf-8?B?UHhFOHE4bis4Si8rSEpDaU9oU2V5Zm1BckNMNzZscm9McmxZdFhoRWtNR2sx?=
 =?utf-8?B?TngvUXlYb1FoM2VsZjBiNlQ0eWRUWTlJYVdCcHpvdHQ0UlRZelNpTE5wVjJu?=
 =?utf-8?B?MVFlcVZVRXJjSU9pWkUvbkhad3hhb0FpSXlhTm9WSzNKWDJkd0N5TmUwOU5L?=
 =?utf-8?B?d2FsNSt6T0Q3bFFHTHZxL0ZDb1pjVi9VOHFRRzhGVkhpNjdEUTJHOXNKSlZ4?=
 =?utf-8?B?bWlFdDBUbUMrS0lCRTJjMm5uSHpmbTBHelBiTUdER2JqQks3RWUrNzhsVVkw?=
 =?utf-8?B?ZExjY2VKejVYQ29KajEyZ3NETVJSbTg3WlgrRmpxdnRxMzA0Y2lwbzRvSmpZ?=
 =?utf-8?B?M1haL2MycG8wSFZkR2N4LzNTVnlYNlpoMzdFcjlsUHltdklWYTJUOWdsL3lw?=
 =?utf-8?B?a0tNaFhydWliek4yVjZLczM1WWxuV2Q2Z3VpNWszVjJSZytFSG5BQnhQUTVq?=
 =?utf-8?B?RW9odGltWlEzWkdZNTJiZjFLb01JRU53NFJFMUNGb0VUQ2xwWlZ2eEJ4RHFE?=
 =?utf-8?B?SWhaS205QitIS3B4bEhSOURrTVRvVzBFazhtUnBidGRZZVd0MUVzYVFYeFBk?=
 =?utf-8?B?aTJJRm1sUnAybU90ZUJ3Sy9aSXQ2UzRtMXBhYlVDOEVEd3lYLzNpL2NmMHpa?=
 =?utf-8?B?MVkzKzZySlF2M1JuYzF5Q3FTd3o5ZVlyb1E2K25GNlkzUkpXWnBhQVZtNm9R?=
 =?utf-8?B?a0ZDWURPUHYzcjdMd1piMDRMc0h1UVV1NzdXb1F5UHJldDk1eEh4MW54TVg2?=
 =?utf-8?B?Z3NqbXBQTmVQTzFpaHd5V3hnR3IzMjl5Zmo0MDU4WjNIV3pMdVFtVndsQTJC?=
 =?utf-8?Q?iuQr9JQ8Ki8HxfKy89/5o3bgh86fcaMv+9St39lSDs=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9e86f0-8049-4461-89ba-08dc21db3bff
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 21:34:26.9619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dS6xNOL87lJzlARc3JHXvkZXS+cS2bGwsmq9kZAEj4Q44FvQEaCZXmwf8DcabFZ32r0NT5bUcbtGa0NN2Nu891xMj+25j1wZ+Ki2kD1mpZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8812

Hello Alexandre,

On 26.10.23 11:56, Alexandre Belloni wrote:

> There is a pin named INTA, it can mux 4 different functions:
> 
>  - clock output
>  - battery mode indication
>  - interrupt
>  - HiZ
> 
> with pinmuxing, you can select which function you want for the pin. I'm
> not sure what is misused there.
> 
> Can you explain what is your actual use case? I'm starting to understand
> that what you want is simply disable clock out because you are not using
> the interrupt.
> 
> If we assume we are never going to use battery mode, then we could
> simply used the CCF for this like the other RTC drivers.
> 

Could you please point me to an RTC driver that uses the CCF for a
similar application? I am not sure what you mean with the battery mode
to make use of the HiZ, and I would like to push forward with this
functionality.

Thank you.

Best regards,
Javier Carrasco

