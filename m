Return-Path: <linux-kernel+bounces-22667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA0782A128
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD021F2355A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B564EB26;
	Wed, 10 Jan 2024 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="EY2kGZ94"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26814E1C7;
	Wed, 10 Jan 2024 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1q2Eh8CMA2yDk61IcYppj52tyusIVVpTzCqTmKJ9fC26QvAG8sqwuAtL6bPmBNLPigs45LdNt8JyCyE+bn9dYlWXAGnLr/J8Ox54tXETIpe1LmSNB73AZ0PTSHNCHhzi8ye885NWrCeYhTLe/DbkBasgBDiNJ2HHACRs0cyVATYzhB4uiEPfX4BQUQuJ01zFj2nyx0hzOC425JNKoMWra3CG7GtBiC2ic7bc9YN3FfYMuVG0mIWIaNYLDCM+n/AqI+g3C0AvghJ9XsRqnsLqLk1ljKTWqNbevw7i7VBgtssuONokD/sJPixIbhdEz9ZjemX4G7h6MMFMX14o7+E9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flWgu6+oqFTx+PvAqN0qhK8UeYft/uaWikQP5Gkl3mU=;
 b=Ls+0D5MWWzNRYiUoCV1t4yn8zlXI2lzG4B/EvhLzBICW3Ai3E9hHrq5fjsHKsUlNwG48qlhutrmgS16nrXAWvBqnCt1uv3HtngcEAoLN4gOh3bgWkv1NR2pKW4GMLPNCYZyZS4xDZ/PnpzRaG3smCSy4lmesMDzJpUk5OMcqf2fZkye90XKAnzp+vOT0FGmghwlI3dpbtEDnU710mkskWxkc67QyU2Ke7PV2Rur7pa5UtXG3Ybp4jXSfFUw67YEdoCReYSyraPUXb38YmNaETVd456k38w+qaqczs9b6XVPVSUUUJFUAB+VbNAYXGIHPyZGecQ+Hy1752/VogRmYZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flWgu6+oqFTx+PvAqN0qhK8UeYft/uaWikQP5Gkl3mU=;
 b=EY2kGZ94lfGbENCmztdcHoM92EeI19WllF/pi5KdtIHkBJrNg6GMPktRd2RBux/Furl+1Y4r6DIirEL7x2ctyE3YoJjEZQC3yfHUsLsc2omHGam8357Smh9OcjTtD68lUffmKeDzMv6fpCpbtNA9pWdgtaaPbnjqKBzgJH5tx4Khpo70qrDAJDjnn4IqSRqs9wmQuaeKveNC86afeb1LJ5XpVy4LKiMYzKh1iBk3OSdprRuqaceAcT1QArOTZbpPwtIDOhqvb0WvUiFUSftj8/Lc2KGN4kjNptu0zWtqsSnXpSXlbZaOl8bYT+shB1LIMTU6ubsoUxq6hfvTixNMXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4106.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 19:44:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.018; Wed, 10 Jan 2024
 19:44:56 +0000
Message-ID: <8a2b46b4-ff04-4370-8bf1-c92ffe59a6df@siemens.com>
Date: Wed, 10 Jan 2024 20:44:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] arm64: dts: ti: iot2050*: Clarify GPL-2.0 as
 GPL-2.0-only
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Chao Zeng <chao.zeng@siemens.com>,
 Le Jin <le.jin@siemens.com>
References: <20240110140903.4090946-1-nm@ti.com>
 <20240110140903.4090946-15-nm@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240110140903.4090946-15-nm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf638e7-fa43-413c-6e8a-08dc12149f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FzHTVdgsv2dW7kzPPmOCd9+aRJKtdp+pnwbksFaLV/5t29Swv5YjFZLgL9pndhm5Brq7LWBqdwkGmxvBazrowyBxDd/2r8P8t/UZXgLs0ZVcw2yBgA8GS4N9SpOiZKZ8bp+zfgTRe/Dob36FBB5CKY8KikVDgs9NuCCYzR0iniaMiXzOZenDcG3xmmcb5LLW650H7CgnmYLbPDOxxv7ULAeIv8lNf8I2kp0Iva71wBuqS6gtJloWGDt2HB89v1sqKJAN9+FYfKB2cE2ZHPRW6oIegRE3u9metk/Yd1xwb+jj+HIt5U+i27nt3AIpTZPJJFklie8/AeflLBjM5YeQdoARUzeE6i6M6bdLSSYX7BAueuc+z61skGwBn7ZF5Fd5wVKyyyR8E4rZKWTP3oBf6jqWHITNy15Aa2nnD4ijJoqSJCbymSb1QF04i3tcM8Y+1i5WVIO9aXN2IYwuTd13i9Q2/J6ZWPwNNaSHipTcSXH6kv3JUa+u9HCDQLcZn6sT+U+AAVdOIdkcttl7bUhUlmk+p+oPAClu3dQk+ux1E+CHF2ALecaZhjjR2oD3n24XymnzQx6MmZ4tm8q06ZC5LbPdJ+4BXADSiwoH1wN3pr7wbj28tTzWu/SYFPXE6O//D+g+Eqfrmn3xvkQdTas5tA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(36756003)(31686004)(6486002)(66476007)(478600001)(53546011)(86362001)(31696002)(66556008)(66946007)(2616005)(82960400001)(26005)(107886003)(2906002)(8676002)(6506007)(44832011)(6512007)(83380400001)(38100700002)(8936002)(41300700001)(316002)(54906003)(4326008)(5660300002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE95djhnMVlzWXZmK0dxU28yaUV3TEtrVERYOUpWS0VaUzlKaitPbmNVVnRE?=
 =?utf-8?B?UEtDSjRlLzJCZXBVckZmaDl1K2JWa0VkMGs0bFpWLy8yUlhua093QTNlcDFU?=
 =?utf-8?B?VStrVUUyZVRuYUMvMUQ5TVdXRlpXNUpzNVFVSzJhNHFmekpNa0VESW80Skhq?=
 =?utf-8?B?K3RyOXFIWkNaTE1xOGhlR2dZOTZHYmxNbVFjSGpocTh5ODhyVFZyamM0eVZO?=
 =?utf-8?B?SWdvK0wwZEFkQ0ZweldwU3dpM0dZVXBySDB6ZURVNzJwOHFJeDUvL2Y0NHZt?=
 =?utf-8?B?TDhGblR2elJKZEVyRnUyVlRGcjJ5dGNWRXAyZjE1dU00K3Mxb2RpRDBlK0FN?=
 =?utf-8?B?Z0FLQmx5SG1wZWRYMTZNMnlBS3JKTVY5SnQ4bUVxL21wekhESEM4Y3FwYU52?=
 =?utf-8?B?NVBySGk2dXJCV3F6SXhzOVE2N0paR3Ntblk5SEVpbUFjVkpyTEZ2bXdBMkEr?=
 =?utf-8?B?bkM1V00ya1JHY2ZhNFFSYXluNm0xdXdlUXNERjFybnBSWitsaklwYS9CaEJE?=
 =?utf-8?B?SkFub3hvdlZnV2RUNG9FMVFZMFh3SkZiYlorSnF3KzBWQ1BHN3U5V0ZaWWFN?=
 =?utf-8?B?emEwMklUeTluMnJjMEhmN2x4TTBHYllWbDZrekpaaUlHTmNaczJ3WCs5R3R2?=
 =?utf-8?B?dkxoRkFucjRCSU5hR2RjMlNxelRBVmY3bGlRNDQvTXNBRzlaSUR3eTFuS0hk?=
 =?utf-8?B?bWhhdUxteWh0b3RvdUF2blNGOVp6RW9aSFp2NzJORWF1SEJsd0pkWHhQc0RZ?=
 =?utf-8?B?eENTekhPeTJKRHRPWHBvcm1INUFENk5wbWlFSmI2NzNJckFQS1dvNVpVRnRz?=
 =?utf-8?B?M3dVTXNkWnpqYkZvdk0vN0orY2JYb21KR2dBKys1YnIySTFib0JWcy9JRTBi?=
 =?utf-8?B?dEQ1eGtaalA2MDdjVlNraGhFeUsrRm9EOHpVeUlheUw2YWNEZW43NnhxNDBJ?=
 =?utf-8?B?WGczMVJXU29JbU44bHJLWkhDbzRMY0kreWdrZTNiZllJK2h5MWo4aVNZQjNj?=
 =?utf-8?B?K1VOcXdaZWlLV3lyRUtsVldtdDJBMHZqZlByODhtK2dtVHljVWlMYWRXdDJn?=
 =?utf-8?B?eW1FUlRmek5wVFdHaXZXcis4bXJ5cDAzdUtMeGE5K0YyNXo5Ty9zeDZDOUxs?=
 =?utf-8?B?bHMyNWdKSUI5RlEwRlFUeHFQbVpOTkdZODM0eTZYZ0ZlQTZXYS9uM3gvSnox?=
 =?utf-8?B?bWtmcGRvN3FxdWFPeWxmOS9oTVBTbHJPWStDNmkxSldBVmw0YVlMM281aURv?=
 =?utf-8?B?aUhKeitZMW1Fd1RsaFBXMGdrMW1uVWRkZlpYVzF0eGJpL0Q2OFVBbU1keDRI?=
 =?utf-8?B?ejNHMkxUUWNJRGhaTkZ3YUVQTmlYRldia0VGb2NTTUdSN255Sy81WU02YVpL?=
 =?utf-8?B?RzF5Mkl1M3ROS2o3MklreDlkeGJzVzk5ekVRUkU0RHVKNlYzNnEwM3hiVjBy?=
 =?utf-8?B?Uzd0NzFwK201VHI0RkVOUHJabHNsV05vN2NRQytGUG1UM3M2eG5zOWlBdFlw?=
 =?utf-8?B?WXM3bThSQW9PS1V3UnhXMisyWnJxZ0dCam1FcUtQRTBDY2N2RzJ5Nkw1LzRZ?=
 =?utf-8?B?VTg5SldvUlJ1cGs0OGtRbVJtWDhhQmxWMmtHN2w1d0J4NGw5UEdDTUJEYWRX?=
 =?utf-8?B?R3B3WTBPYmdqOWxLNUtPbnBpZU5GWUZyeXlzSXpJeFYvbk9jVk5laStXdGZ2?=
 =?utf-8?B?ejNsR2VmMk5QTlMxNEhxcDRNVW0zQjhnOTBXVzFsNVFDbGpsdGJCQ0hXY2lk?=
 =?utf-8?B?dHQzZ3hhN0lyNnk5Y0w3Q1REd1FtSEtJSzU3ZDFtVHdxeUNPbVk3MWhOVGk0?=
 =?utf-8?B?dUcralMwYmdma1UrQkNpN3pTVVVFanFBb1VERSt5c1ZKRUVpV2t2Vmx5Vm41?=
 =?utf-8?B?SXZYeEdHc1h5K1UvRFdtNll0eTJ2RFNxT3ptTWlROVJ0WjBPa004b2dVTGJM?=
 =?utf-8?B?aUxteWYrenJDL0FDcm0zTmlYUXlhR3F3R3FmSk12RWZUSUxoUDNxeVVFRkc0?=
 =?utf-8?B?azR1ZElRSXRRcVk3S0pCS1VSQjhPVTVEekJqSSs3VFd3V0xBNGlpQUlQM3ZH?=
 =?utf-8?B?QzFhRWUrdWNQZkN0aEdSNGlFVFJGWCtJR3phcnU5c21qcFJ2d2JiNXFzZ1RU?=
 =?utf-8?B?WURqNmVuYUZKeEliSmtnbk15WFZOOEp4ZWZkeEpScGFFZkh4VUZrSFN6UUJp?=
 =?utf-8?B?Wnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf638e7-fa43-413c-6e8a-08dc12149f74
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 19:44:56.4485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVSxH1G0zyCXKob5iLThlFIDX5oCyM4UUbjKo/eycBfoovWr3j/UsiHodPW1hRrkXn7V/EJ4RiEli/hxHmjmmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4106

On 10.01.24 15:09, Nishanth Menon wrote:
> SPDX identifier GPL-2.0 has been deprecated since license list version
> 3.0. Use GPL-2.0-only to be specific.
> 
> Cc: Chao Zeng <chao.zeng@siemens.com>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Le Jin <le.jin@siemens.com>
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi        | 2 +-
>  arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi        | 2 +-
>  arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi            | 2 +-
>  arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi    | 2 +-
>  arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts        | 2 +-
>  arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts            | 2 +-
>  arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi | 2 +-
>  arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts      | 2 +-
>  arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts     | 2 +-
>  arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts         | 2 +-
>  10 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
> index 1d1979859583..c424fef19d5f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) Siemens AG, 2021-2023
>   *
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
> index e9b57b87e42e..5eeeca27dee6 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) Siemens AG, 2021
>   *
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> index 61a634afaa4f..00520c75e0f5 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) Siemens AG, 2018-2021
>   *
> diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
> index 1d6cddb11991..c927c8679017 100644
> --- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) Siemens AG, 2018-2021
>   *
> diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
> index c62549a4b436..ec62dd7921d6 100644
> --- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) Siemens AG, 2018-2021
>   *
> diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
> index 87928ff28214..4968a47f31ea 100644
> --- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) Siemens AG, 2018-2021
>   *
> diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
> index 3864ec54e371..ae842b85b70d 100644
> --- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) Siemens AG, 2018-2021
>   *
> diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
> index bd6f2e696e94..8f559f4e7dda 100644
> --- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) Siemens AG, 2018-2023
>   *
> diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
> index f00dc86d01b9..173c941b1c4b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) Siemens AG, 2018-2021
>   *
> diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
> index 077f165bdc68..48b908c19ef7 100644
> --- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) Siemens AG, 2018-2021
>   *

Acked-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan

-- 
Siemens AG, Technology
Linux Expert Center


