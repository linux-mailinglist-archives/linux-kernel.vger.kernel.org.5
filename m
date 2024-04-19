Return-Path: <linux-kernel+bounces-151584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F898AB0BC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E54E1F23402
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBB212E1D4;
	Fri, 19 Apr 2024 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qYjuyTiX"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2572AE90;
	Fri, 19 Apr 2024 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536856; cv=fail; b=Js83qRHUVD6pUdsnydxGkl9H+fy/5Xgz3ltBxSQACN5SELJ3OdzCk7guqzXK6uKJ5UE7vX8Kps6sCQDM/JsJ1JKdomMX3JiSER/y2cG8YEL2UDmM6dEIt9z4gxrscTs05y1Shud8aqpn67fS/0x6FhYP2kIAGz84//YRYM2A+Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536856; c=relaxed/simple;
	bh=5diY7DjflfiMVvBNESgqzmOQiZWRH9tLYbqiRS4yDiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AK4XFf3EMn6QKiEpB2DOEFdHkCekTSpi1mTRnV2McJ4PSI07yqrL+iht4DapIGKDAx0UxQrDPqUNDUjfk0xgqC7ltsWnrGWdzPyZDXkJdSxgu7edcrOhO972BVDF+zP6HbgHvQIsG+LygZzQ7rr7BQ+YeWk4y1cBoLgxLPBPEZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qYjuyTiX; arc=fail smtp.client-ip=40.107.22.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJ3Y2iMshX34pjrIggE2mMZe6WpR0NA5iHgVSO/nqAMzH2YiYrqW2XgAM6DMoqVuH5gM7Vo+JIjNTeDay1tOUzFxPvWYyrqJ9vTHgFF0EFDw3XyyHgd30qi0xdXUcIS+pu1qcJ7pXjaRXPuIWDmBxCf55VnUSD1gzN+ktca+yoYe3sxsKaWsYGIYEPjjKWuhsPFopuI3z4tQTywuUNTJebXRUPnyU76+knfXMn0wUzr2TNIvtInqELm/tDPr1THMxNZ0WcTZFbWi6LNMxhnCBRNaVrX2kVLNJ9o8O4BQtPkxCVLfl0aD8grOcu85KF5SOX2AyGgp1Bdj3KQ3+hAEMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiifGUS7p1uaXrsUN/LF2nwcu7O0r8xGHuye3mEahow=;
 b=Jw5Urr1KweJkMY+axuoLzcZiLRYVjRKVLqfLAKZEWdxpGvAX0m5Mjjb10ZOoaGJ+WsQkMo5f/h2DCTDTZYgm6G8ZfI9VD2f8hMi9TuXO9mp0y4oDOLpxfyhiQ3fkazGbySbutVvFBqFa8rPkkajfDA9f4Y4EX9YBI78rKF7GrnX8QtyYu2QLiwQhMILObYPjhohsEnHk/AHQYOv9Y7nc9IXcGlcCv9U3YzH1oUVOFxmeNre43TxMobyMZZQ/f7gvIOlD1yq7Ih/GhAY1DWbnoGLYAR3AwRdfFfMvzrZrJgQw7dej+37eeYhxU5gZhcy0TVE3+VopTVeXw2wTnQmSOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiifGUS7p1uaXrsUN/LF2nwcu7O0r8xGHuye3mEahow=;
 b=qYjuyTiXcmX4NTgGmUzwxjckos2/wd4pNOiOBAt7Mndg4JNODRF0O254Qu3Y1UwmToRiQFsJ92TaK7zmvPdZW7ZNKJrVQNCsxybxXzXKe6bfoxG/1knZ+38F24hEwSXw2J+SMfhfPIxFP+BZntucuZcyFDZb7/QqCouAuodQQxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8611.eurprd04.prod.outlook.com (2603:10a6:20b:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 14:27:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 14:27:32 +0000
Date: Fri, 19 Apr 2024 10:27:24 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 02/12] arm64: dts: imx93: add dma support for
 lpi2c[1..8]
Message-ID: <ZiJ/TPhNspL4Qi6Z@lizhi-Precision-Tower-5810>
References: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
 <20240419-imx93-dts-4-13-v2-2-9076e1d7d399@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419-imx93-dts-4-13-v2-2-9076e1d7d399@nxp.com>
X-ClientProxiedBy: BY5PR17CA0016.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae375d6-04c4-43ff-4a80-08dc607cd98f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7ZBJAJMzEkHN3o42DQhUBQbogFuiSEFPiOT0r6UhA/PlBDmvaHuVC/EGi/53?=
 =?us-ascii?Q?U8iu5O/ZxwRzDIFu6wtNrs3TmcO3j9JBpFszA6FmwhvcGa5B2xVaezduRx89?=
 =?us-ascii?Q?lm+SnuwwpYYqLA71jTdvqVkUtsI35Wf17HKaSuUUqPaMo4F7mf3yLQ9os/fu?=
 =?us-ascii?Q?VwCdbo9QPajWfWeuxr7oFJpq8q5oZGt9TL6vzDqxpZollLTgzifL8L0i+TBn?=
 =?us-ascii?Q?+4p0yktEGELfuhwyKkK+VvgSEQOPwMmzOxWOzkLJzIxJ/PIVwNQ1hKIhq1gU?=
 =?us-ascii?Q?PCuByCKfE5me5CriwmUlv23sGGSLiB0xUZgJ4Vr8L52gbcfZLUDU6MRKQFWv?=
 =?us-ascii?Q?0cE1WQNwYI5oxGAyMMS3b6PqHaZkSiA+Ey6w9R5ER4ALuGudqE5NTkJTo3+J?=
 =?us-ascii?Q?77W7FvH+n3IBu0etkYpR60/RmvjKFUu7o7wiuu1/vIgAMB1fp6/id9D4O6yd?=
 =?us-ascii?Q?2mPhKPhxKzPdnuIn2rD90mPE+1W7+U870JwQqW53cGeEMaXiN6fvrDvw+pcL?=
 =?us-ascii?Q?XKovKvhI0Ajg+n/hKOhT5KJOxPstxrZVWxGWXyXO6qyIt90mpbCcbpfaShKa?=
 =?us-ascii?Q?Kqx2iEsKRnz76aLiD0B25fW1k50keVYEi5pxv4umjQgjqvSvZELXha+pVxpb?=
 =?us-ascii?Q?xwEiLNLz4jfwiMRPznq40OrC4KUZs5tJ7LtW3vt0FT23K4iR3L02GXWS1sXM?=
 =?us-ascii?Q?0SUbtA7dD4ifqmtv9YXak5vcSS/jtysltuDZlq330GOk9LsXwqUZx+sAht/S?=
 =?us-ascii?Q?lPRly4nXwQ2lIamLuF1uOGP12MLO5l8Wdnq0QwbbZR+q4Nj/5YaS4hUdaAIY?=
 =?us-ascii?Q?dvHCglnpDP8WkewBMPiQIv1pyeyVshu45UNMcst2V8v4c2xi1mRFnjXAwFP9?=
 =?us-ascii?Q?wyqbYxc5jJyotn/2dmx/XLMB0gTdXMiORjBJ0WZc6r0jzJNIqwK82rsQ3aHf?=
 =?us-ascii?Q?0KR6QP7GFHc/BOF3zeHu+V1ua1Y/PRlNt0jMIotdghsFWRgbwfrv2XXT0DXc?=
 =?us-ascii?Q?oEqCgEnqezUdeO2ZvkXiphox56ntyOMNfbe4FxWEOuDsVras9VpaMaocr1Q4?=
 =?us-ascii?Q?KBc5KVmWQQQa0CS8gvtCfdmJs7HwI/KIGbyEjclPgKnVaXSRa0WBNKt/WrY5?=
 =?us-ascii?Q?mmUxjVb0ELUkJjmViQZmLL4WtAbrC7SQL48/aGJsAB3Qsi/ER132JjyolGip?=
 =?us-ascii?Q?1XarJzUcwSDktPGrfdgk5Pj6hStUa6p8enTF3SEkb5dEbVIL6OAH35P1uC+l?=
 =?us-ascii?Q?vYRGsCd1WrqsIwaE9FeU1+ik0/ANoVg3jv4bzfkyYt5P79ufKDbgwF8fGR1c?=
 =?us-ascii?Q?4WSIGgq3zsLdw7l7wS0s3K5aSQL00TMeKJ/Wkjcr+iv5Ag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aX/3WMWfBfxaNIUEwVjBc6RBNHn1DG70+SqYC9ASAHw2mNLmZ7PToWw6edUI?=
 =?us-ascii?Q?ovxsqQIhEPhbIfmpBQ5wGWfDSMIrnWMXuuJPwMkK8c2dibsfbgYp7hd1JhlT?=
 =?us-ascii?Q?gel7ogIn3EJ47p+SkIodDJqBg9yVz7p4qPaAF8qlKZBXbhlJnJ4t+KnpYHjh?=
 =?us-ascii?Q?IOdzpTaTFESXMD2beLfggaPpq32ViTCtynF8vl3v3e5pfuOsmY/Z4PwpuPWW?=
 =?us-ascii?Q?ob1iI7guZNM43M7uY6D64d8wNfmdu0Yaca+h7xBpsGAlFMNZWqVEBBR2uYIq?=
 =?us-ascii?Q?kNp/6LhWOXZoPZaK0uaDaK1rqarhv7jK7RvLz77jwpQRbkURSLEaI3ExXYgH?=
 =?us-ascii?Q?jTcecNI5lThGMo7T2ebamiYeWBX7G6QpwvBqvj5z04YLj0O0VqQApnzEC3IY?=
 =?us-ascii?Q?8DgxoXV5xO9KCjhIe0F9VCuoYphOeTLSFCgYZ5zau0w0pIQ1xKVnG5ffsFwT?=
 =?us-ascii?Q?Yg2Bb1zhdwQC3O10GGi8oruognrkl7EvPqhBaPNGerle9e0viDnPhbfs2/Ds?=
 =?us-ascii?Q?Qu8xFFMhuR+3fsEynIteAjmRbJuorEwzamVxc5HUjvS9XxSHlO5smh90yfmy?=
 =?us-ascii?Q?KEXPUd/Ree8F+gC0OaVJv9UYAbziWw+oILca3YbpDYmbtzKufKSTWyYtgviV?=
 =?us-ascii?Q?EUbLb8rMUsx6JbdOX9gGib20WiJYYSwFMcEejshquTKQ+ehKKQqCuaUWnM5V?=
 =?us-ascii?Q?zCE4VbeMOaqc1JbMchCgDd/f6Y8i9tl9e05zD7lPCIx23+Lr6SK6jshUyZpq?=
 =?us-ascii?Q?+zrWfy315gHNVqOMc5zRgoVIKwARJz1ardmtuFyFwvHq3v4d4MtpwW7qjLrt?=
 =?us-ascii?Q?+4Kjg6T3A/3PPFuCE+PZeQnjgjIfnWz+h7LF5+yQB+AMIbUUUracJi4y9Q2H?=
 =?us-ascii?Q?qLOOPXB537NcrA6ZeTTUZaLjvFsK5ERy+ynQnTf137QK2TO1SCF9A8B4+tKO?=
 =?us-ascii?Q?I0+kWIK+90RB3Y05wwCu3K+jakJd0lwR+qDPDA9aTLv2lSnh8rnQe0JLB/Xv?=
 =?us-ascii?Q?/Un6T9BTZ+DNzWgSPWYhQSVfHsIfFC6WHtPyUjcD747yzgz8/mlyWvO1cwTV?=
 =?us-ascii?Q?Isz3A4f9fIFgxuphilQ7gQJwMb0N8Fe4qXy+CrxV4r+qmexBThaf/E91ALFi?=
 =?us-ascii?Q?yqYuNQ3+U+NE+qoZjVoVUKw0FCcZV2HzyGDUhbYJGjKCyj/hEl2EyQNSorhg?=
 =?us-ascii?Q?pbTJLFQt5ZM972ffFCzk8eDIJDm/CQWGtI78nsqpeaBUXAtIt9Ar2/1ytkrq?=
 =?us-ascii?Q?up16ce6Tvc9gFIAooPM7NJzLfnDxpV3OSNgfq6g+9zMEsDadA2Z7FojR4QY2?=
 =?us-ascii?Q?Z0H3ZHNh7qvkZH+CYX1iniMIRmlj5iTkP2Pr7ycNjskI1VScgkJktBhwP19j?=
 =?us-ascii?Q?rQmGgvOLZ7FYDoNBsTLNVrZKq8xWj5EHGR0tUmcwLDTHMQlddcoryvbYARuK?=
 =?us-ascii?Q?oZXaQXyO9P3Rwb0xbgOIYafSnje0ZwGMlLsNwIvbKBXvwWABWqZ0XoLS5Fhk?=
 =?us-ascii?Q?4SZ0vYDCq3+hlq4REFitiq8ZM3Ltqr9E5A5DGgNpdKjRiv225Nm8qaq57QCZ?=
 =?us-ascii?Q?5Tzi7vAcKvRS6R8abSEElRGdU5pP7DsJg0tEu57e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae375d6-04c4-43ff-4a80-08dc607cd98f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 14:27:32.3050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rM8X6QNxHhbyZgZx9Xy5zDMQaPRzjKnpbVOaIuOiA4DcrwmWHvCayMOKantSOQZRm3T/R0t1teI0NGlNSax5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8611

On Fri, Apr 19, 2024 at 11:36:57AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add dma support for lpi2c[1..8].
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index 42bbe491a29b..93c1d0fae291 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -317,6 +317,8 @@ lpi2c1: i2c@44340000 {
>  				clocks = <&clk IMX93_CLK_LPI2C1_GATE>,
>  					 <&clk IMX93_CLK_BUS_AON>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma1 7 0 0>, <&edma1 8 0 FSL_EDMA_RX>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -329,6 +331,8 @@ lpi2c2: i2c@44350000 {
>  				clocks = <&clk IMX93_CLK_LPI2C2_GATE>,
>  					 <&clk IMX93_CLK_BUS_AON>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma1 9 0 0>, <&edma1 10 0 FSL_EDMA_RX>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -693,6 +697,8 @@ lpi2c3: i2c@42530000 {
>  				clocks = <&clk IMX93_CLK_LPI2C3_GATE>,
>  					 <&clk IMX93_CLK_BUS_WAKEUP>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma2 8 0 0>, <&edma2 9 0 FSL_EDMA_RX>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -705,6 +711,8 @@ lpi2c4: i2c@42540000 {
>  				clocks = <&clk IMX93_CLK_LPI2C4_GATE>,
>  					 <&clk IMX93_CLK_BUS_WAKEUP>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma2 10 0 0>, <&edma2 11 0 FSL_EDMA_RX>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -882,6 +890,8 @@ lpi2c5: i2c@426b0000 {
>  				clocks = <&clk IMX93_CLK_LPI2C5_GATE>,
>  					 <&clk IMX93_CLK_BUS_WAKEUP>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma2 71 0 0>, <&edma2 72 0 FSL_EDMA_RX>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -894,6 +904,8 @@ lpi2c6: i2c@426c0000 {
>  				clocks = <&clk IMX93_CLK_LPI2C6_GATE>,
>  					 <&clk IMX93_CLK_BUS_WAKEUP>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma2 73 0 0>, <&edma2 74 0 FSL_EDMA_RX>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -906,6 +918,8 @@ lpi2c7: i2c@426d0000 {
>  				clocks = <&clk IMX93_CLK_LPI2C7_GATE>,
>  					 <&clk IMX93_CLK_BUS_WAKEUP>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma2 75 0 0>, <&edma2 76 0 FSL_EDMA_RX>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -918,6 +932,8 @@ lpi2c8: i2c@426e0000 {
>  				clocks = <&clk IMX93_CLK_LPI2C8_GATE>,
>  					 <&clk IMX93_CLK_BUS_WAKEUP>;
>  				clock-names = "per", "ipg";
> +				dmas = <&edma2 77 0 0>, <&edma2 78 0 FSL_EDMA_RX>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> 
> -- 
> 2.37.1
> 

