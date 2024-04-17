Return-Path: <linux-kernel+bounces-149054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD77C8A8B1D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABB61C23C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A88174ED7;
	Wed, 17 Apr 2024 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TPAZq2rK"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BD0172BAF;
	Wed, 17 Apr 2024 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713378604; cv=fail; b=fvEjXONN/ohjxZUfG+rStMAx0EYeYHSjQdnZ75bOQ0MF1c6LimXZFA0oUcHRUzDL5DXvnTEuEru8jY3Lk5DQxrvKBxFP/YwStx0SS8tMKte9bTvC6XRX0DCnR3peNE5F2WR4yJafLyK8ClOFBwFi1D23f5QgEq5BepM3r+VogLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713378604; c=relaxed/simple;
	bh=yr8/Gp0njRnE8SOcVkB4zXQLJq1KjKF5ZJozxR5l6NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GfwcWWCBCXZ4qJzlvvpA/E09G2IzainEOMdVol1axKfKDPz2plgb9fqGRcaSYNruQAX8+EwJG35NSteVFG4Tiav3N7ejhUv6M/ShKBsRzZ7V1AU8OK3WtrtaZNlG2lHq6olEmMRlrb8r5ydR1cnCzh+C9EE2mrM2e8cmXnrx1Fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TPAZq2rK; arc=fail smtp.client-ip=40.107.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rx4E4XA1kXnAwfeOgFC6pB5AI5n7LrTOkCb5fmZGapwf/oZm8IxSURGrxzFFNhkHFWwk8UtmTv7pYLSAUMbNIjAo6bIs2Jbn+3nBzxoxla1P7e9VUpwNQXmBFKpNSMqiehoeWLeGLcTyQDpL+267Ms4msorjR6mZpQGMI3RDhqwyBLI9p1DbMrBQrfieBtrsPvoLiH3P/ghOp+afMp9MN4yGnnQpEPI8zwok19qx37maR18huNK8KVxo2RgHjvuKHm5bWeBLxzu8zp7+ixKPC8Wm6BeRdvqOzw2Jlux3fgN3nBAE0VRNvwM8c0vto6b2ZKGMkAdeF2PuWfF11LU6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qn7uyOLXa8StyIXtCreJ7MdU3q/BiZbhXJyGFGzYdXc=;
 b=eup7dP6ezQrbEEw+Z7vuUwPqWBob8jaBnXdhjQhr0PUqlCiGQ1JUOHqhLoiBk1xdij2+k8IcE9sDe7ddcV9FwEja+coOMIY1i2ItT6FWdsMtBLrHkGa1ScgjRXQDy8ZocLc9+pM9xAOL1KwvOdCH9JHh30yiqlpefkb+MwU2CiY8GYUGXYRfilaOB+lV7iuQfoKiyr+Lxlv8VjFKnbo+5FRGSA5wpxTp+VTi2cNb53nJ/UYn+htp7rqU9abL8+cGFIQwgXnCOAFAJx0xCJFwYl3ttKnrc9CCKSP2Fb7xM1129deQVKpfEhGTKExdXb90fQwJbfOgGBQypVmoR4QY2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qn7uyOLXa8StyIXtCreJ7MdU3q/BiZbhXJyGFGzYdXc=;
 b=TPAZq2rK0rJ9do3s+h+9+iO9v3T7yT+Gyy+xLjtHRPwJXxAJC/gt1krVV2FrnqdQf4cSPbPl3YtJo7SlyMxL7/DodNW2wv5ulUC2q4ZohCP3tqnfp10gFvz3rWVcYYeBdAO0HekV/1/VSRBFQPpPEvlJYwPMDrJMDkqdcS4Aj0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6805.eurprd04.prod.outlook.com (2603:10a6:20b:dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 18:29:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 18:29:57 +0000
Date: Wed, 17 Apr 2024 14:29:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] arm64: dts: imx8qm-ss-audio: add audio nodes
Message-ID: <ZiAVHosJAtrK6LRf@lizhi-Precision-Tower-5810>
References: <20240415-dts_8qm_audio-v1-0-2976c35a0c52@nxp.com>
 <20240415-dts_8qm_audio-v1-2-2976c35a0c52@nxp.com>
 <20240416065026.GA4165@francesco-nb>
 <Zh/yZ2HyF+G8bty7@lizhi-Precision-Tower-5810>
 <20240417172031.GA4100@francesco-nb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417172031.GA4100@francesco-nb>
X-ClientProxiedBy: BYAPR06CA0034.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::47) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a5a5328-e7a5-4c5c-b985-08dc5f0c6287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W697/apJ/hiiQtE80yn0Wn51b+dAPkutcw8++9vcTRMMEfhaDNiI7X+hs9BCNejJfdzwkB23MWKyitDTxmootSM4oTmh3uLdZ3Zv2IJmVlxYukJ8Ga70+4GHsqL0GVD9N7hKvuT1tZA12I2T8BI8bkJ5hvXPfeF4y4mMqm2eZTyY1KAc7wHym2+zAOELm3jgaD+2ZWlgGkc9YfPx/BUOjI/OHBB46ep3tK8Gy3jzRgIoYVMZ8bDSzC4rc76mLqhzrTiPtNzMioiF0VRjmAPrPPeMo4AguU8oYvgjicqcFLZRoPZb4mZ57UvDbSB4pOgbuJGDSkt+Je6KHOXQ6+2QCw1a0FPKNcBhv9R9r/TgW4Cuutgq5EHmJUI3frp/2wKnH+4YeeD/E1uRtDllxuih8sFAb43BDhp4oV8tK3f9H7rxPXdfGNE/Los7rusF/vUA4UrIq2Y5hFl4MIma/jOnLqTHIgMTYmjVluOGaQov7kzbg8FdbhApqv/nDKEKEf4D3piJiGx33ze2myhYYbYOzwqDptNVh9TBI0/TJ/bLb68HeDt6Qdd4z1inh3T94xwll4+2DDFDCS/gw67kxypuq2vaH8A2OfYfWlDsn3qatwKVMZMxYRw2rcyOWXvL/1puUUvUMiDwu6EwE5VQ/CyYV1ql78QtZusHS8/n0GaWR7tbUC1vnLI1l/8YOZmixBpatvTFMZhN9f9KVYjlPE2MAg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xFmQvex55OiUdnpgmI6nUCJdb+dzgY6g1U75JC4ny0xUH5bJECwEDFZfTpGX?=
 =?us-ascii?Q?cXfpe0prLPiExYpIGvh8mle5IjkP1icZlwHYnfUu+srh527zDmw8u+6VnHHJ?=
 =?us-ascii?Q?srUkT+WxxmtyItlTzxbPZj/0oosboXEqOOpzoetMa2cPwIfvTnLUNE8pEaiI?=
 =?us-ascii?Q?DQkv1F0dvP6JSZwtWYo7mtNPzzhdoTfKRj7tMvsOpAwPN3UJrIl3fFuVMSJN?=
 =?us-ascii?Q?VkjxjJjlt1Pae8YGx46pLXgav6RaOuSu38cmKUkll/MlfjUNDGJadYBlLIK/?=
 =?us-ascii?Q?MzvZzGi2Zw945GGuTL7U9IkqdBJx0qg5aiFev5+pnC7Qg++kevJbZN/Hxhxu?=
 =?us-ascii?Q?3LSWjIWZH4EuCLRpiKrkfttw+z+1VKKpUozM1Wo3DDuKowaF1Hz3PYbTFBYi?=
 =?us-ascii?Q?4ncS2Esubjee/TYQbiTBLMcht2SSwi0CmhrpT/hbg4ZRf7IolsY4wcB0GwEC?=
 =?us-ascii?Q?yNBzeckb7V32MHezKQwsKeBaA/0BS8bzAUPCHqU66BQ15m8QQlR40RUE/WZK?=
 =?us-ascii?Q?NZilvxC9sbJ4puM0CEJgzrMzz8n7RvVwabuja/r5WRcmVj8ojFczPZB2Q/vj?=
 =?us-ascii?Q?T/85BdOSOge5kaJouOTuHln8Uiura94bq7I2moZgAoWiAVgyA3cU6wEk42So?=
 =?us-ascii?Q?1/jZewCPdcQGWoDI+8RR4LCxj3GGlwns85bw7GG/ENT37GnTFsnQjnLNO/nN?=
 =?us-ascii?Q?suTUddcsxX19r4rWTCl+AMVgfYdprjPJWOZ6xMKB4POIX9Ctqt5i/bJiDLzw?=
 =?us-ascii?Q?dPepDJcDhB7VbwsONWCb7/+JgNNjxqITeanljnJ3G8ZJHvhwcq6v6Vfyj1Ox?=
 =?us-ascii?Q?cTIyqEMw6qwfx8kDbYXtI+KaWfzOdJ45pjNsKuXW7owWUQzSY0G1ZPlwgXRm?=
 =?us-ascii?Q?ScrQkQcLo9gyWiO/pd2z/OIApSK2ARNcS2ovK3VKY5Fo4Fomjt0+fPKKwxgr?=
 =?us-ascii?Q?XoraObxQUJMdD+Pvdhs1ePOYCszvQwMnNETOHDf3AlBiWIlKh+EYKbu+ckYz?=
 =?us-ascii?Q?5sOTUnOk07o5UNSjegKa7kVUnQ8MGF0MLeoNq2j52B3g6/IDZ+NULs8RTKHh?=
 =?us-ascii?Q?sO5ZSMFgfy3aEZtfQu+ITf8U2Oda3n5aXG+BTyzYDkevheaW26Y+7JjDO0Ck?=
 =?us-ascii?Q?Zl2dylfyefgpp0ogzdtJA3FM9B+dD60McGPloChzk40phQy+zISrT+lpRAuZ?=
 =?us-ascii?Q?dnvFJIatBuUJWISiX3Cs+Ic2VfjWqU/s6GEtoNBAPwy29+8EUHxFtUhsNCds?=
 =?us-ascii?Q?GY4gx6KKSkEPSOW5VeLz4UOYEKU5sVy/z2MiUMW1vp93/dUJUfBEI3fwglmb?=
 =?us-ascii?Q?Bg6/N5WVPrLOBIjPWjYKgVyokTPrLNySupAr+GY08APhTl94mP8Jvv+QSvuC?=
 =?us-ascii?Q?58QOzJNTWw/SMCxBWTJgwacm4gGh+A+jcGSLaL9FYjystDHQtwGQ4uEQFnMW?=
 =?us-ascii?Q?ObLlgnNGZzMtEEiTfs8iiUBVqp8f1hEHOSc/RwriytG04+B5S3NXuZcU1iPO?=
 =?us-ascii?Q?fynnebVmRY/RmslmN+BFydqdNqcPqV/e9W9eUULrSh8St5gjApohoKMwmJuE?=
 =?us-ascii?Q?a0INvOLEeVQrAiHGXG/2XLA4FBIuPwMdMM7VJwKB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5a5328-e7a5-4c5c-b985-08dc5f0c6287
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 18:29:57.9399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4oBnx7xc47IFp0oen0T1Xb8l/0qBXXlK0Pq97S465vkLErHlKM+U8ek5LUZz7irNzSV4vTZnqpwR/Ix91FtFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6805

On Wed, Apr 17, 2024 at 07:20:31PM +0200, Francesco Dolcini wrote:
> Hello Frank,
> 
> On Wed, Apr 17, 2024 at 12:01:43PM -0400, Frank Li wrote:
> > On Tue, Apr 16, 2024 at 08:50:26AM +0200, Francesco Dolcini wrote:
> > > On Mon, Apr 15, 2024 at 03:46:38PM -0400, Frank Li wrote:
> > > > Add i.MX8QM audio related nodes and update eDMA[0,1]'s information.
> > > > 
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi | 473 +++++++++++++++++++++
> > > >  arch/arm64/boot/dts/freescale/imx8qm.dtsi          |  86 ++++
> > > >  2 files changed, 559 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi
> > > > new file mode 100644
> > > > index 0000000000000..ed5a1b4af1d76
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi
> 
> ...
> 
> > > > +/delete-node/ &acm;
> > > > +/delete-node/ &sai4;
> > > > +/delete-node/ &sai5;
> > > > +/delete-node/ &sai4_lpcg;
> > > > +/delete-node/ &sai5_lpcg;
> > > 
> > > Can you explain these delete-node ? This is something that I would
> > > expect when a dtsi is previously included, not in this case.
> > 
> > We want to avoid some property inherent from parent dtsi file because it is
> > big difference with common one.
> > 
> > This node will be rewrite totally in this files.
> 
> imx8qm-ss-audio.dtsi does not include any file. From where these
> inherited properties are coming from? Which file is the "parent dtsi" ?

imx8qm-ss-audio.dtsi are not supposed to be included directly. imx8qm.dtsi
is supposed to be included by other board dts file.

in imx8qm.dtsi

 	/* sorted in register address */
+	#include "imx8-ss-audio.dtsi"
 	#include "imx8-ss-vpu.dtsi"
 	#include "imx8-ss-img.dtsi"
 	#include "imx8-ss-dma.dtsi"
@@ -473,3 +558,4 @@ drc_crit0: trip1 {
 #include "imx8qm-ss-dma.dtsi"
 #include "imx8qm-ss-conn.dtsi"
 #include "imx8qm-ss-lsio.dtsi"
+#include "imx8qm-ss-audio.dtsi"

"imx8qm-ss-audio" will overwrite some common audio node in
"imx8-ss-audio.dtsi"

acm, and sai4/5 are defined in imx8-ss-audio.dtsi for common part for all
imx8qm\imx8qxp\imx8dxl.

Frank

> 
> Thanks,
> Francesco
> 

