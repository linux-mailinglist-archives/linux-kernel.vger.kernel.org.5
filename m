Return-Path: <linux-kernel+bounces-22666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7C082A126
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDC21C22340
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303234E1D3;
	Wed, 10 Jan 2024 19:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="htwNfUtb"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB5E4D58E;
	Wed, 10 Jan 2024 19:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCI0OTaBBd4GfJtw6+aJa/xxGsc2UzfB6kg07XfHrD4OV+jIChHe38xbQAHB++c7kwm78tc3O9VrW58A6lKqgTLKHzNYCraAeGaJ9DXvoSufM+CRGa0npNJGzM6k+KTSUhV9baVaL1/CHGwTQTYbyWVM+OfHrF04mb8u5qJBEnEYVhotXuB1A9Phiar3MnrcRIwrV43RvvE8MVa+tB83RvxdZM/DxEu0PeWRPL85+FYa8otRDzYQLo1hory8MnceEfCASLB6bGgfEicyjYc3vphov98adn0FDKanr6+OYsklJqjAgAp/ugDeYNkZ78ZxEDUReZYdIazr2JPCuNPBgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngShzAj9XO1Lg6NZ5LNluQQpr+cc6on2DRYKfcZVIPU=;
 b=ApZgtT+wO06EaYgkxp2MkpARoaJhZOXz2HPpvn2qL20l9E193Vl+e55QgPtwZbWA/7CNVxQiR4Ju9UHStvwY9EB3QFnnBnUACUymlMM0BKqd2TYtndnRPJDsHcnyQcfpRF9gsVpsqpvLaeGwcluhnPZZ2DY8U7YJXw0sXRduYkuZqBhVIKVvdFRiIzY7jfBwBn3gAXygar55fAGdRx4cU3hIez0CfTMOASQCHzNZkMUh+ytvFKBfa/uDcuB2KBikGyf4pj/mdLcChxVBKW6+sDEZvkHuPLAy2ysrxul6jsgBdFfnQeIngKjzYOzCSmxdSG97NHOH7cyGo3yZP8DNoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngShzAj9XO1Lg6NZ5LNluQQpr+cc6on2DRYKfcZVIPU=;
 b=htwNfUtbHCrFORunM6VCdjeG4of4lyQQi8fS9OSwPKTUds0XASY9aVaUXJy3/M965m7mqaN5JkEVA0jAGnuVfAuP8bJ16oNeX7tNPWK0UyO+rqBxWefqIBANPjgkFmjalMOoaOyIc4tNlLSx8Vl53jcBj52xEYOuZKS/+SIhj9KTT1Hi+8pOV/lPFQENGZ1pdgSCiEblsRMq/WjEzQA3qFZDkqD9jG5M19JJEbtclG1HIP7+C4ZRAuJswixukVJJQvnHo3KJY1iAsyVZfx/EYFPaoNgolml4PDiseq3lvwttiI84syCSuKhluVW5zD9kFLxieEoBU5FPZe5ntedsrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4106.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 19:44:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.018; Wed, 10 Jan 2024
 19:44:53 +0000
Message-ID: <e423cf1d-42c0-44ce-b6b6-4a88ce46d7ab@siemens.com>
Date: Wed, 10 Jan 2024 20:44:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] arm64: dts: ti: k3-am65: Add MIT license along with
 GPL-2.0
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "Alexander A. Klimov" <grandmaster@al2klimov.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Rob Herring <robh@kernel.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Tony Lindgren <tony@atomide.com>
References: <20240110140903.4090946-1-nm@ti.com>
 <20240110140903.4090946-7-nm@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240110140903.4090946-7-nm@ti.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2f0503f5-9694-4d6e-6a68-08dc12149ded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TXQCj7Qg1CEZCyeMDH/RoAx00Z3qWfXFU8lmvPhLZjoDS3/y5IkA2U4vQaY6meuzGhKW5GsSu2gDx/Tg5FxhPSt9OvgMBRO+LqKE/9gATVX7zgQf/0DMDK7ysmMP19C6MWTglxvfH+wiqBW2/EWQ8OWylwp6/Br44XG/IrGDLmCePxWdI7jRZObheQhrM2OwR9SSu+NOtE4NTpBAoWIASserm21BIh3d1gf0trUypox7EIHAFP4T/PhvxfKsjjDwNkptjI/3Xv+Sd7MVDrX14frishPyt7CnNWRWyRXMbEZ2znBeszRamE5xUbQL3DiSUPbr6Rq6v7Li0o4MAD3eEZX/vn1rlsam9ewpDpgNjZa0TkjLhSHUDvXku/8nlojIV6SQnORvU4+YhSvSx9aLA8FGkBh9dJpSq6xWT6r6Aat+4IRBBVZlJM62hSxy1wfmdpbK0jrnFOskjtm3ftJdkEiSoZUMhp5K0N2tRzO4myhy2suupkZyDI+J8/VfxeyUnJhfyEqNwls+JZumFmrHYWZRYXe1n6C/4eC/of5evjwZVn1g5mHHjDJnrfzIM8vrcInV7llJNqh9eYwRpVyAlEqr0GJNgl8Wrm0rHXn7ntqHZk8AAbymzf06gCmhU9MoLSOobpxJSChw+saVcKRjLQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(36756003)(31686004)(6486002)(66476007)(478600001)(53546011)(86362001)(31696002)(66556008)(66946007)(2616005)(82960400001)(26005)(2906002)(8676002)(7416002)(6506007)(44832011)(6512007)(966005)(83380400001)(38100700002)(8936002)(41300700001)(316002)(54906003)(4326008)(5660300002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qk8vdS9KY2FCT2lqNm5QL3d1WlliOWhyTUc1M3E3VUlXeldRdWg1QWtqcjhx?=
 =?utf-8?B?WURMc3Y4UVV1YVVZQU1LdnpGYjQ0WE54bUNaTUk3b3N2SmJKbHN1RHBudG1C?=
 =?utf-8?B?T20vbldsOWRLT3dWMDdhb205cjJXMHl5M2NnTTNBeTU2amdmNnhMRGpqd0Zr?=
 =?utf-8?B?dGpyWXBUQ2htSmxzY0oxRElQak1PY1lwcEYzMmJyMm56K3l2VmEwL1J1QU9a?=
 =?utf-8?B?WkJGcEMrWTVSNFNlTDhicmdXbGM5RTRXWG1JU1N3TVY2SHZvbkNoMWNRUHBi?=
 =?utf-8?B?dHJpM3lsVkJqYmo4ZVE5aDU0eTNIUGFoZHRnZ2lTVlZvOHUralkzUjI0cS9I?=
 =?utf-8?B?b1FUdFRmaTZ6VE5xSDZjaXl2ZXFLazg5Zm1xS2xhNzJqUWd6clZDK293KzVZ?=
 =?utf-8?B?NGE1S3RNbDB3K3IvdlFUM2NWa2FBOTIrcTdOa3ROZGJlQUY3S1FmVEw3Z0pZ?=
 =?utf-8?B?SHU2K0VRbnRTcEhNSDJSV2MyQUZqUW1QS0NzKzY0bXdBa0tIakI0dndCUnFl?=
 =?utf-8?B?KzFSV2czU0ptVEluTXNEUXMvc1IrSDNRbWNXQVdLbHdCT2lhVDRCQ0VzYnZU?=
 =?utf-8?B?eC9rN0NrVnlqSlYrSFFITnJFbTdaNTFSVXluM2p6Y1VjRjh5UzMrNWx4bmpF?=
 =?utf-8?B?N05qdXBlU2RLekNCNlBKUGp6NDJjd2grMFFtdVNrODV4eDhOSnU0a2pVMkRU?=
 =?utf-8?B?NDlBdDI4YnR6d3E3NUZ3a05mS2hYK0dkNEJ2dStXQU5MdE0rSTdFQmtEQlFX?=
 =?utf-8?B?MlRuUVdraGFRdEthQTZhRWtkWUN4eGdTV2lGQUdldzFkczYzZGttVWR3ckho?=
 =?utf-8?B?dGZyT2JaU0xlU1dvWnpIRm5WOWJQdStlOENyZVhmYll5NGE0eEw3MGlNTWFZ?=
 =?utf-8?B?SElaeVpJdWZHVDkyWGVJZ050ZGJ0SklOa0lEeDZIVE5VbW5aaWlpQUEwUVNm?=
 =?utf-8?B?Q2c0TUVxQlVVVzBmb1ordzM5YVFZMEZOMC9Rb3lPcGxENXQwV2QyTWR4b0Z1?=
 =?utf-8?B?VHVnZHVaUW9BWTFRWDdqYWJ2UmlOU1ZuUGhwTTVQckJCQWwyNVhQc1NrU3Mv?=
 =?utf-8?B?YVJ1dllCRDdLNTNGTGZzRGxTalpRT3VsSUJ0eGZUTW5JMVZIeWVsdG1OZUdw?=
 =?utf-8?B?b2w3M0ZSY1NiYTBLdnBjS0RaZ0hTODlXbldZVjJPTmUrZmI0NnN4dmR2a0FK?=
 =?utf-8?B?NnN1am5HRlFqVTN3M013dHJiYlgzbXM5dXMvckVIREZ4SUcvYkh1VXEwYXpw?=
 =?utf-8?B?bFpiZTRuV0EzcWhNMGd0N1VBUFJzckJhbEVnUXhtUlQzWUk2UTlocmhnc0xY?=
 =?utf-8?B?Y0lJd1BOcVhwT29lcjlleTdjTWJxeEkzYW13aUlqd0xHQVp5ZFQyaDIxYnY5?=
 =?utf-8?B?bkFlOTlqbzlpNE45RjZaci9lQjYrQUE5QkQ3SXdRR3p0TXU2d3M2T3JYVHMv?=
 =?utf-8?B?cnd0b09SbVN2VFdkZWRMTDdEUE9pYWdvUHhyTGNyZ1BneDdrZVoxVnU5d1Ay?=
 =?utf-8?B?bkJFbFJPdUcrZXQ5OHg2cmxycFBSOGN1cFdoSDA4aTA3Y2ZNWDFZUDFseEp4?=
 =?utf-8?B?UzN1b25QR3AreFZhYXdWcnNFSDVQVnhlNjhJME10ejl1RG81SmZMSTJJODZl?=
 =?utf-8?B?VHF6eXJwUDM4RU43eW1UNzczNldyWldmbkJmWFFEWFdodVpuUkJRRDhQb2c2?=
 =?utf-8?B?OUh1NkhuVVlIbGUyWmFPd1JVMDRsN0J4NWFoeFd1YkZTcUU1V1haa0VlaEIx?=
 =?utf-8?B?eTlvOVc5MXM5eFBHcklhMTJUM2svcmhxcGM1dGVnWUY5VzZVRGR1VHMrdi9w?=
 =?utf-8?B?TTBOdEZqR1JPOUpaTjZzanNlbGNwT21CSlNYUVNicWZvMHRXakpwWmFWM1E2?=
 =?utf-8?B?Yjd1Y3JBWDlqQ3pvR2dmcjE3MDJlZ0dqaGNoeTUxbUVnbkhiSy9rU2tKL01s?=
 =?utf-8?B?MzdHUmdIdmlpUVhKNTNNbVQ0aXNZcUFKb09zTTZXZzZkZ1VLdmRvejB4Uitq?=
 =?utf-8?B?R2hpcnU0UisrMzRxczRKR0oraHpsenhMSHFyNktTcW1EZ0l6c0ZzMThKZ3No?=
 =?utf-8?B?SHRjZ25qdVJMU0kxVlNZYnczNVJUWkV0NjVieXJCUGpraHpzQkFJWHZvd0xR?=
 =?utf-8?B?MzB1Vm1peFBkKzQ3V1REazYvU1BJMDZad0FTMWFPbVYrMWhBRmtzNXdUOFRZ?=
 =?utf-8?B?QWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0503f5-9694-4d6e-6a68-08dc12149ded
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 19:44:53.9121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdJtMj2dSA/hrz4P94o8IYm4/kGSTuBNjSl+GNqVhre62EqLmXLoVfo+b4a0uKvY8vI9N9N+6rDLeBGXWRxBrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4106

On 10.01.24 15:08, Nishanth Menon wrote:
> Modify license to include dual licensing as GPL-2.0-only OR MIT
> license for SoC and TI evm device tree files. This allows for Linux
> kernel device tree to be used in other Operating System ecosystems
> such as Zephyr or FreeBSD.
> 
> While at this, update the GPL-2.0 to be GPL-2.0-only to be in sync
> with latest SPDX conventions (GPL-2.0 is deprecated).
> 
> While at this, update the TI copyright year to sync with current year
> to indicate license change (and add it at least for one file which was
> missing TI copyright).
> 
> Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Cc: Pierre Gondois <pierre.gondois@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Cc: Tony Lindgren <tony@atomide.com>
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi                     | 4 ++--
>  arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi                      | 4 ++--
>  arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi                   | 4 ++--
>  arch/arm64/boot/dts/ti/k3-am65.dtsi                          | 4 ++--
>  arch/arm64/boot/dts/ti/k3-am652.dtsi                         | 4 ++--
>  .../dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso     | 4 ++--
>  arch/arm64/boot/dts/ti/k3-am654-base-board.dts               | 4 ++--
>  arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso                  | 4 ++--
>  arch/arm64/boot/dts/ti/k3-am654-idk.dtso                     | 4 ++--
>  arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi      | 5 ++++-
>  arch/arm64/boot/dts/ti/k3-am654.dtsi                         | 4 ++--
>  11 files changed, 24 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index fcea54465636..e55a8c891bc9 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -1,8 +1,8 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>  /*
>   * Device Tree Source for AM6 SoC Family Main Domain peripherals
>   *
> - * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2016-2024 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  #include <dt-bindings/phy/phy-am654-serdes.h>
>  
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> index ecd7356f3315..6ff3ccc39fb4 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> @@ -1,8 +1,8 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>  /*
>   * Device Tree Source for AM6 SoC Family MCU Domain peripherals
>   *
> - * Copyright (C) 2016-2020 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2016-2024 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  
>  &cbass_mcu {
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> index f037b36243ce..37527890ddea 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> @@ -1,8 +1,8 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>  /*
>   * Device Tree Source for AM6 SoC Family Wakeup Domain peripherals
>   *
> - * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2016-2024 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  
>  &cbass_wakeup {
> diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> index 4d7b6155a76b..c59baebc5a25 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> @@ -1,8 +1,8 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>  /*
>   * Device Tree Source for AM6 SoC Family
>   *
> - * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2016-2024 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  
>  #include <dt-bindings/gpio/gpio.h>
> diff --git a/arch/arm64/boot/dts/ti/k3-am652.dtsi b/arch/arm64/boot/dts/ti/k3-am652.dtsi
> index 0f22e00faa90..cbb3caaf82c3 100644
> --- a/arch/arm64/boot/dts/ti/k3-am652.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am652.dtsi
> @@ -1,8 +1,8 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>  /*
>   * Device Tree Source for AM65 SoC family in Dual core configuration
>   *
> - * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  
>  #include "k3-am65.dtsi"
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso b/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
> index 4209d991eb6b..364c57b3b3a0 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
> @@ -1,10 +1,10 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>  /**
>   * OLDI-LCD1EVM Rocktech integrated panel and touch DT overlay for AM654-EVM.
>   * Panel Link: https://www.digimax.it/en/tft-lcd/20881-RK101II01D-CT
>   * AM654 LCD EVM: https://www.ti.com/tool/TMDSLCD1EVM
>   *
> - * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> index 822c288d2797..5109e1bf68d0 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> @@ -1,6 +1,6 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>  /*
> - * Copyright (C) 2016-2020 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2016-2024 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso b/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
> index ec8cf20ca3ac..0a6e75265ba9 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
> +++ b/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
> @@ -1,8 +1,8 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>  /**
>   * DT overlay for IDK application board on AM654 EVM
>   *
> - * Copyright (C) 2018-2023 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2018-2024 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-idk.dtso b/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
> index 150428dfce6f..8bdb87fcbde0 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
> +++ b/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
> @@ -1,8 +1,8 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>  /**
>   * DT overlay for IDK application board on AM654 EVM
>   *
> - * Copyright (C) 2018-2023 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2018-2024 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi
> index 9021c738056b..de5a2ed907a7 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi
> @@ -1,4 +1,7 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
> + */
>  
>  #include <dt-bindings/thermal/thermal.h>
>  
> diff --git a/arch/arm64/boot/dts/ti/k3-am654.dtsi b/arch/arm64/boot/dts/ti/k3-am654.dtsi
> index 888567b921f0..bb77c8454734 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am654.dtsi
> @@ -1,8 +1,8 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>  /*
>   * Device Tree Source for AM6 SoC family in Quad core configuration
>   *
> - * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2016-2024 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  
>  #include "k3-am65.dtsi"

For the bits contributed by us:

Acked-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan

-- 
Siemens AG, Technology
Linux Expert Center


