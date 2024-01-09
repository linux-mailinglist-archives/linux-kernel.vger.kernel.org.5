Return-Path: <linux-kernel+bounces-20424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E288827EA8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9071C23641
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B956FD2;
	Tue,  9 Jan 2024 06:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mjVAodNV"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321756126;
	Tue,  9 Jan 2024 06:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQVAxcqgAJcoAX5iJzpOaSyw9Z2bE5TJ6nWBrVIGVhyDbJUbUiu4MMTaHikoZcx6cRAi7ccZWXILuq0UtQHYO1y7bMell9WCUD/GJtqdjTKOZXvQiCwB7nGnVG8luZa0Rd8/C8Z9OQWodF28jxLE1CUbvl6sRKnGyCfgry7g6oK6YOTVKA+YzEs97k5KDjXmUSGmtU/LAbi/397kulkcp7D5VjkyhF5HpIMLAbj3n9kan8oMWoIzSm6Biu6LbsUq7MJWD8LY80PLWevVT9qHuvDwX6RuVRwu3kp2Rr2+VF0v0C/ARbZ5VIrHBQem0BbqmOc/lOrrDalFZdoLSaY6Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Obtk34kFPuoQ8ynzYFLzPCem5OGCXDG6PdAm4L/ckhY=;
 b=H21eiYBx3Ix2LdJs7HpOo5YGryjBYMyqMWPcHGlcqRVlgvKjQoEpbjrOpfB+332c4OHO+jN9n4yzanvBSKM4zOOQbva3WtV59CclvR6hMHBn0WuI9q/njWGkti3J24ucaqlmxhVnJUK9aGrvLStIX5hWotROcrQQ5q8YWdcPyFK5JxhhrkVd288TC2D9u02XL7L9SQPHW5CvZaG89W1P9agmX4oC/bI2APj42gjRc80omXxHnELIQe7M6934cXfb0rvpHfyCU0u8P3sMjpSKr9UX/sgWdc57vOnnx5OuvZXRTUs3WeTufkQQ9i2LiAio2hvkKM1Fohh7Hq6llZnpvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Obtk34kFPuoQ8ynzYFLzPCem5OGCXDG6PdAm4L/ckhY=;
 b=mjVAodNVqysnd5GpBaDxATwHZuigxOPTzRNKlWCunZve9hQzkDcMau+li5BXxJeOxgcoiumPkRWSKUVcD/hcdcRCEZu1zOwh2D0vlcw0IrXUQS/GnUXpIXOLrdCNLNqlpBftnP0vdIYe5kE0sJPTOMrspNhs1/ZHRYTRetN84+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB9783.eurprd04.prod.outlook.com (2603:10a6:10:4b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 06:06:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 06:06:40 +0000
Message-ID: <66c91724-3e43-50f2-32f9-fc3d7062f40e@oss.nxp.com>
Date: Tue, 9 Jan 2024 14:06:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] clk: imx: scu: Use common error handling code in
 imx_clk_scu_alloc_dev()
To: Markus Elfring <Markus.Elfring@web.de>, Abel Vesa <abelvesa@kernel.org>,
 Fabio Estevam <festevam@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, kernel@pengutronix.de, linux-imx@nxp.com,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Kuan-Wei Chiu <visitorckw@gmail.com>
References: <01446ce9-c0e8-4467-8b2d-fd736bc5b8e4@web.de>
From: Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <01446ce9-c0e8-4467-8b2d-fd736bc5b8e4@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0162.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB9783:EE_
X-MS-Office365-Filtering-Correlation-Id: 97716369-6257-4a86-91b5-08dc10d92520
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lVbRh1BidPZlBl0gCZTO+cy2XXYCyNUzqpLVByPcIYFdpXnpcmQ+QQ6ef+8BFdbPE1l+ecibcc7ssRCDR/zLqXVZo+qJ8zGYsbLRd7sszf8RW/geAlORrUUWWNlx6ngp5pd0kZ4+ZkiVZJrkfZS4noR3MkovCjBhQMHHrv6G9favQpRhNAfSWQXv5RwOKjf88ZcZUQMMicyeqo8b4I0SRNomfRPO1QvbKltjA8OPCaVWyETdUZY13Nfs+Ep3crH/xxC6Z6F4QG+bTt9tGnvS0sFhWoh2GdKrELy9RUkT7cvZ41zevERXUC2T33qKo8UEnI0E++HHWzLhH9rF1xI2x69ECwNbRqJPnQkqDNfwjTQeRgOU8R/HKARFJQPSCfZLqxJAU+3aljBnbMQI6pzEBPFDBT/WeO576xFCIs4bK7oqgUIdAwq8gKkgN/BYNg2SVb53X5lt9qE86trwZeRz7ojRUyROUmvAD0QkkJLIcIgAziJafT4D+HWS9kgeFZbF4r8y9zXitx4Fwfu/3ljmM7IefQCxEzh5se5Tgb7IZeEy5mILuGAzlXtyaYMlyDfB5ihgCO8D4z/j6KWgw1x8at4GFy3UuaKYBx/pZnSspkIxxdaGWFOe2IN99N+0225tGLs4Ym1BowcSZmW5iKYrnJaNE4xPFF13Wal42OR7078=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(6512007)(26005)(86362001)(31696002)(921011)(38100700002)(4326008)(4744005)(7416002)(44832011)(5660300002)(6666004)(6506007)(53546011)(2616005)(8936002)(8676002)(316002)(110136005)(54906003)(66476007)(66556008)(66946007)(2906002)(41300700001)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emowSTZlaksrQ1pTNm1oRFVneHBucURSTHAzSkV3S25yeHNuSlExVFVRYWRa?=
 =?utf-8?B?Rks5enVDT3BhTmFwT0lCU0N5ZHRNOE56TkMydVNselBNY2d0dHc0WkMwQ0la?=
 =?utf-8?B?N1NNT3R0cUtLdVRjRE9pLzN2STJub2RnZjlhR1hOQ2htOFhrNWdzZzJrNG9E?=
 =?utf-8?B?QlhQdFQ0MjR4QkVDU1R1aE16NmpaY2tZbXoreEFZNHpoK2M3bUx2K0lJK1Az?=
 =?utf-8?B?Y0lxRmRtb0tSN1hxTU9MRGxMRUpJSlBCTVlnUkNCajNQUUhsYXV5MWFhS0ND?=
 =?utf-8?B?eU9jK0Vsa1pNcEVHQXVjL0o4ME52MG9VWjVXMTBpZndiMGZGZGNvVmlETG9P?=
 =?utf-8?B?dGFhOFlWN3hVemNpUTlxQ2cyTnUvK0tkOXZQRWFnY0krbkltcTk5L0VFVXhS?=
 =?utf-8?B?TU16d0thb0U3RGpJRDNTbmZROE54bS94OTdoSytvVmZySXJuZVFrYXFNL1VS?=
 =?utf-8?B?WnN1OGxuMWIybVp2VnF1cVM0NVh4WmcrME5iSnViN1FycmxGWHF3Mis3MDdG?=
 =?utf-8?B?MElGS0dpblZYR1NrU3MyN2dITkFObE56Wkt1dWk3U3FRRzVlRjEybUp0UHNP?=
 =?utf-8?B?bUt4Y0loSjlYazMxVTdLT0FEREJYUVljeEFRSDd3UG8rL3dEeDZnelk2SjNS?=
 =?utf-8?B?bHdiVzh6dXBGUVdaazByWk5LNGRBdkIvdWtzUlVxZjFkeStFTXVWR0x0cjg4?=
 =?utf-8?B?ZW4reGJ5TW94V2VWcjBYclRGRUNUUUJidnhWVVlWR0Y4RjJXN3U3L3JaOFhn?=
 =?utf-8?B?OUtVT3JFL1FFcjlyU1dKUVViUU9sWmNlaWFwMTQxTmcvVjFFSjRHZlRkaHRl?=
 =?utf-8?B?cVdSQm91UEZJcU1lZzJIK1I1VzVIbEVTVEFySHFQbmRFTUNPMjNCcjFVL2VJ?=
 =?utf-8?B?cURudXFuMElTcHVDbkRSWWtFVFNKSW9qaWpwRGpiZWY5UnRkYzg2MjRDN1BZ?=
 =?utf-8?B?YXUweG9wN0JoV2lFQ1VZVWU4Y0pmYk5PRjFQNWwvQ0hJdTdEWDVtNnZGZVN0?=
 =?utf-8?B?bk9ZblFzQ0hDRktkbGRBV2M5UkhVYStPeW8vM3JWSlA2ZFBRY0syOXJEWjQ0?=
 =?utf-8?B?eDRHc0NGSmJZRUxrbERoL0R5NVAxY3BkUkxrYk1YYkR1L2x4NkVlQ0FRRkw5?=
 =?utf-8?B?ZGxscGJ3bkJQbkM1Umdsby9lSm1HUWQ3R0VGOU1WWW5FTUtJR2NCWG54aG5x?=
 =?utf-8?B?QkZNb1F1cW5RY1I2QStMZ2dQbm9NMWZEQnVraXA1dHFSV2VPd1NCUVlrbmpJ?=
 =?utf-8?B?TStUZUpqQ0s4RFNBNEtDTTZGR0tMSDF4S3pyTWpNdW55TVQvZThuQnNNTHh1?=
 =?utf-8?B?OVdwT0M5TGFHblBVbXIvR1A4T1R3RzhwVXk5eWNaa003LzlSbWhreUpKTGNB?=
 =?utf-8?B?QXR0aDNOOWxReGpMSEtIZnQvRHZZMEY5SmUwNmFYeGxMOTNpNE5zeHFJbkVk?=
 =?utf-8?B?R3FRY1d4VFF5SWlCL3pkU3MvaFVoUHdndG5yZmppZ2Q3aldOMkhoU0x0TEpj?=
 =?utf-8?B?bEFRcnFoaklQV24rV2lDWXAxV2JPS2R6UHE3ODMveXBtZkE5U25PTThTTjJK?=
 =?utf-8?B?MFdwZ2ExZERNWUIyMGt1L3RmMGlSY1lWdWlSV2JzZ0g5aFNBRk9WL0IrUWhu?=
 =?utf-8?B?UWIzVE9mS3FvRXNMZ25FSlF5SmV2RmpCYlJaa0k5ZWloWnk0YmR4RTRvSlVO?=
 =?utf-8?B?WWRKRENESy9aMnk4UXliWGFoN3E1NHJYWFp3UkNDRFhmV1ErYzlra0l6OE1y?=
 =?utf-8?B?cEE5aVJ0cWNQMjByeURHbEc0eEROYWtNK28raTZZY2xuQUlvQzMvbnk4TWwr?=
 =?utf-8?B?dWY5Umc5TGhUa0pNSENaSHR6RFJvS1dxTUZmRHg0d2xLc21LSnFpb25GRmxr?=
 =?utf-8?B?SDkzeUp6NkgxYmpBd2oyb2liZXUvR0VKSFhSdEw5N2RZMTgvbHJBWlRQbE5C?=
 =?utf-8?B?THZzdVZuZ0pjbDdRb2FnelNMamVteHFSbktUdjVWZFVtZWFoeDhmR1ZQVnNj?=
 =?utf-8?B?Zi9xZUo2SXNhcit0QVBIcDVCYXcyOW9vTC91cnZqNEtXQXl2Wm9jYXFQMjgr?=
 =?utf-8?B?UFEvdlRhc1QzVGdFYW1UZXFRWUhlMTZDUUJ1YzF2MkpOK3J3bTJkNGVaUEdv?=
 =?utf-8?Q?+BfGiZ6U6ns6SntEJIXi+sVm+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97716369-6257-4a86-91b5-08dc10d92520
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 06:06:40.0308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fy+mNw07uJi0tyM2jnWa6i0rIBO799DCRdpeUOR9QFyFtR7bDF960gCJ1SUI2wmzRDpXXOpuLaioWIddhwvW4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9783



On 12/22/2023 8:03 PM, Markus Elfring wrote:
> From: Markus Elfring<elfring@users.sourceforge.net>
> Date: Fri, 22 Dec 2023 12:56:48 +0100
> 
> Add a jump target so that a bit of exception handling can be better reused
> at the end of this function.
> 
> Signed-off-by: Markus Elfring<elfring@users.sourceforge.net>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

