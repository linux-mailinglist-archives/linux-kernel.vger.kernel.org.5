Return-Path: <linux-kernel+bounces-29302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3C1830C6A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10CFE285F97
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843EC22EE4;
	Wed, 17 Jan 2024 18:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cuhwSpt7"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2059.outbound.protection.outlook.com [40.107.7.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F241B956;
	Wed, 17 Jan 2024 18:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705514789; cv=fail; b=fcARPuUxH+9HWn6yTOUKaDZY4yIGEoYv3kEnQ4Me9/QWJ9NC3xgTePBW8RqXUsF8NW2HfP5RYkkbiFkETZYgG1cKt0hCJnSWZasOx7IiGALrO+YFpCQ/3ENSRnFK55BlIwNP+5b2/Fq7tUTJvrQv+pSzkyXBSDQBcZCXk8I20aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705514789; c=relaxed/simple;
	bh=i8n34s2WQwcNftYiiWqT6lIOFthFitPKtWc+GUQfWkE=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=XQ/McKDneQc/qTOamya3ZBO1wS0ODei7A25KymAeZFWKnqRgTvFL/0yjBkAur07LaylXfos09wyTTgyqP4oq/lreUrukgJN3jKz3Z5MQk9sBdjMw6VoYIwi8LUkp0hZdDaUiXs7H+IfEJE4daPGAZzCTFi/4QM4hEz7idt0Q79A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cuhwSpt7; arc=fail smtp.client-ip=40.107.7.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFx8bV5Qe5USl+Iwt3jPDix21Izb2cAd4mSLKHY1BYRNV2HXjEXEuNIffneA4z3Vb0b0z8nnSIqSw01LLISHILzcZ9hazac3+/s8j/No++oCwVBNSJSGrSEdmm9j5nVBCVqmhez6Q5CMVCDq1BsbRROb0qEZI6NvP+B3Q3SjX0j++BXMYiKeBKvQ9hK6BjAH2Xo8jb+vX580WoCqyjK1yQooVQSZL/BytQyCj5zzymVBXC4aJv7AbRxe05qf7Syv8nY2wle7Fn6U7DXaG0gBijEIdnjGAlCGTBA+5lS8syinbcfkUzpejwmj7mQr0jjoDph++g/S9J6KoFSV4yy0Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYrPdPAbUnM1/oZoRYeg8LwQRiVNYQUQDml4Uo6Xig4=;
 b=oDvOMGxKZ5i0YlGyrLnos5zLOf+ZdnlCqcTg6tAf/jwoiRt2+QsSg/K+T2qRZSV7QvzvlYvacgSmh1nlfuBLVF/xZ3vgZdXwDCXQ8yWm9fx/oh6yid8C/V3DZMchWvyJfHD0c9hwQjgrTqauQQqoUizicNQ4I94VAs7R7jiHaZk63UmcTr6i1m42nXUR3QPQ3ksJnjQLSauUxCW+kfPL0ZZREnlIxdbnVwb4mQTUhrDzVIYuAdcoUrLTqXy+LzYnqxkn/qy2GMPnKEVcKATJErPtxmKJ+oPyQP9ukwZDfqFscTYHym5jJ3k9jtC9EPyGrelwbWBawwqW06w+dfKhwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYrPdPAbUnM1/oZoRYeg8LwQRiVNYQUQDml4Uo6Xig4=;
 b=cuhwSpt734wCOdcstZyoA9hx2iPJEVZ2hUd3xO6O2W+mAQ5IHVzSgeVtknkVNXan4rHa7OkIFCWiH54uaABdKxjwkKd6zemub+QqtHpnpm2LqyTSGHEJY/CrpxRzR5swWNqjFU0AvzjsVRASVvN+iwwgsNkB+qUk8c2ZT9662IE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB10027.eurprd04.prod.outlook.com (2603:10a6:800:1e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Wed, 17 Jan
 2024 18:06:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 18:06:23 +0000
Date: Wed, 17 Jan 2024 13:06:15 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>, robh@kernel.org,
	alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
	gregkh@linuxfoundation.org, imx@lists.linux.dev,
	jirislaby@kernel.org, joe@perches.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, miquel.raynal@bootlin.com,
	zbigniew.lukwinski@linux.intel.com, devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 2/7] dt-bindings: i3c: svc: add compatible string i3c:
 silvaco,i3c-target-v1
Message-ID: <ZagXF6vMHVxvZX+6@lizhi-Precision-Tower-5810>
References: <20240116-retract-conclude-c47a7fc8cb21@spud>
 <ZabVSYgq1Mz3LPpC@lizhi-Precision-Tower-5810>
 <4a9ed1ca-cd13-4b61-af06-a3d7935aeeee@linaro.org>
 <ZabqxHD4wtiPn6ep@lizhi-Precision-Tower-5810>
 <c760b89c-efec-489e-8333-c60b38fb5a47@linaro.org>
 <e54e2b30-03e7-40e3-bb33-dc71de8511a4@linaro.org>
 <ZacCQ1Eysqq5FnA4@lizhi-Precision-Tower-5810>
 <ad44d51a-ba64-4a4b-bba9-205faa760c78@linaro.org>
 <Zaf+Gn6rYstttnrA@lizhi-Precision-Tower-5810>
 <e57d7f34-3abe-4860-8986-0cb7070819a4@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e57d7f34-3abe-4860-8986-0cb7070819a4@linaro.org>
X-ClientProxiedBy: BYAPR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:a03:100::37) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB10027:EE_
X-MS-Office365-Filtering-Correlation-Id: e125a726-5146-436a-9f7b-08dc178703df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2+Y/EG0zl+aTI/qtwv35PLY76buMNSBVFKbFi3/EUcSF4wbdKYDRQl1mSJWOa7w+bZwXnUFB3omFXgzqB3C1FVVxbs/t/4RoyDEjs9n8y6t5rV0s6smv3NybuBh7GX9wTDSGwq5bVrcB9gRMWpzsFXHktvnF+cAZ0G09Ds/GTzaD27msKDuTJyNh81ctUt3ZDlzAgtBbsHWmi29K7Yi+0pavd3F4eCM7VBO4aIOuNs9vSFNhCKo2oxRBDNVmL/KyT+7T+ye4Vyux+fs/fFhU0v5ZZ8zKUQFaS79CFqeRVcPqNkvcbNJ6iZJxeZAoBXIlrwJJR+/3RyAhh9WYREdM1i7RkNXR+3WJqqOCdkeJYfsr6rBh3YW6mSCGuNYnB/NNloDK6miVE4dPqA5R8ZW9BKnqembGW7kLS/rGnXAUMG1bdRY1nRg4KqNLJeT73+wP+H2eZEPkpGmMipqGnqIiKFpaurYzvyCNv/bH8la4d6O7V3vJtL48imrR/Lgg4e4V6Uu6pYeWq4Q7qJrdM1XYBd1IYpp0KAQx0FjNzHBOsEnoiSQaghwydSpCTxs1a46nA5yM3MJ/BgJmRP1iFPrKOwBpafHOwL967S6tH8BCkhUzY4CFjC+FVA5MzrUYzA3wRHn0pKB3BWL/qO1Zhs2ltQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(26005)(6666004)(53546011)(6512007)(52116002)(83380400001)(54906003)(7416002)(41300700001)(5660300002)(4326008)(478600001)(33716001)(6486002)(6916009)(66476007)(316002)(8676002)(66946007)(8936002)(2906002)(66556008)(86362001)(6506007)(38350700005)(38100700002)(9686003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JopKBLt8tRYeNAc52epQzKk50kvtO948wrNGpjmH73zmvsGcr6214fva6Goe?=
 =?us-ascii?Q?EvO8F6JC8mdflky9d9DM32wKGoidl4ILxbNz7RP2rbfHDhwT7+qvfV/Udi1x?=
 =?us-ascii?Q?5JaEp2HLUBcLeDSUJubdmsI2GfJGDB28TRHunbGTTHMroPLLdLoRZifIK/xW?=
 =?us-ascii?Q?iX/zr3NRW1VK0I/RUhsiStXg8qnUJzLnvX8cNe/65j4058qYGK4lo2j6ZBlg?=
 =?us-ascii?Q?my2Q5UTvdYgO4wxtpaqpExgOdCzaHc687WVImpaXDMPUblpsbHBaGSv1VWgH?=
 =?us-ascii?Q?eNFL9FFOxCd3y5CzS15JcyeJu03Cm8F/TafpCCzYP+ckpeln75jzngyi6H9v?=
 =?us-ascii?Q?3ri4zOxOFvKCJsZkfZ0O4cxjV4tbSC+4P3de4+3n+tLUWX6nW204K0/rUQwS?=
 =?us-ascii?Q?c0Bw5gHPcbRF4MePmdVUB376gXItdW3DGna+u9TthMmGpvAOd+wkA57p3KeL?=
 =?us-ascii?Q?pf43wUIqvhb5XiI0jIomZNzja1lJnfubdQIkmatMU5Q15Ie6iRi4UKbATiLX?=
 =?us-ascii?Q?PaTu9pa0rvOkL1xHrcG0hapyZy8mAyRqUfLYqfeBSNYdMI3FlTYqA2sg8e/x?=
 =?us-ascii?Q?B0gh0pgnGCJM2yLKPY/cDFNxU2G9Z3lskv0CM3KMKnFDfB6FoGNpaFYJ9za1?=
 =?us-ascii?Q?HUfyF0bbL8wdAP4UwQBETw9gHhzk8TFDBILagvVpl3a2apoVvRyat12MZcxf?=
 =?us-ascii?Q?JQgo4FZkMCqPMKAeB1fARmG5IHt7tQJDLMM5PHdCZ91EdPdXs8f6ws1kJbDh?=
 =?us-ascii?Q?pMYxmA/F1sZjcQs9H+SXem8wADSkU9wM9DwIttB9LKzA1nJQymQclxTjgPtz?=
 =?us-ascii?Q?MKUTfjX1Sshyb5WKkuSRbP5D6IysqDhrLqAjA/m3eHyO/Ug+lXSU1K1qB2Lx?=
 =?us-ascii?Q?QbXqHw8Zo0E3iqKsFiE36gXn2Z+MQsBbS/sHdzNaI2rgs66QVWIX8RkVp2jm?=
 =?us-ascii?Q?ou2NKdKJWxngltBWCA5EC7FWr3+/MfvmxJJ+9sLyYTLel0SIPQhMxQU0DKHe?=
 =?us-ascii?Q?SeH2biN4v45EKe4ZDdcwHwtsle6mDzIgclI1Og3AisJxp/AESZEPsPlAadwF?=
 =?us-ascii?Q?cEqgS9edy72UvUVc3bMYs+RhgjzrbUM9XiuSDqBR8epxmAnmmHeDFioTovhU?=
 =?us-ascii?Q?mA/dkK96yr+M5aHCr/0tpQrE4xSfWf4L+R+xrgqH+uUmAI0eJ5RyC6ySq0//?=
 =?us-ascii?Q?nN4ozpFq5thchtc2i7gIuNFA+HDrvwXz3XaHilRdlX9t4Ne1NoH8nCZi/IrF?=
 =?us-ascii?Q?QsVDM7UIltuAjy+NhjAlat9Ef97LTt57S+UdSICjOF3zidYan4NTrsWrzWcH?=
 =?us-ascii?Q?mZaHfpDpF2/22VVPzV69Cfs4SLIZO0yNhprucsNPLQMB8g+lTE1t6agXFYid?=
 =?us-ascii?Q?AbglzEeFJry/ta+wmwEY32WU+cDyKRyBZg2s0UQfW9KQ2vMmIc1+QMDwuusB?=
 =?us-ascii?Q?12AA6PnmSEPvY+j6soEwhOiIPddKb7aYygYrjn0ypOil2WZij59u4AOtKt0R?=
 =?us-ascii?Q?V5A293hSBlWYkJvYD7Q4m0pY6d0TmVOKXVN8ijAuBoVqgGQ/JjmcI0foDrxK?=
 =?us-ascii?Q?+6+0zF9v0cPHdp4O4PSPSGABDq+MBN1Fyk0GRhps?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e125a726-5146-436a-9f7b-08dc178703df
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 18:06:23.4576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4e+xKmLoxRSq/n35VOBEZwAhJ+HumtLvQGFkwKB+xQuvtFg/+LWBQE5tsBs39TwVtuD0CizeHP2QnPu5J70UMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10027

On Wed, Jan 17, 2024 at 06:15:51PM +0100, Krzysztof Kozlowski wrote:
> On 17/01/2024 17:19, Frank Li wrote:
> >>
> >> Not really, because compatible describes hardware and it is the same
> >> hardware here. We do not have two different compatibles for GPIOs being
> >> input or output.  Or two different compatibles for serial engines (ones
> >> providing UART, SPI or I2C).
> > 
> > GPIO and UART is simple. Actuall SPI and I2C have two mode, slave and
> 
> I talked about serial engines which can be multiple: UART, SPI and I2C.
> 
> > master. Many SPI/I2C is dual mode controller. Just seldom use slave mode
> > at linux side. So you just see master mode SPI/I2C controller in dt-binding
> > and dts file. So few people upstream slave part to linux kernel community.
> > They have the exact same problems if support slave mode.
> > 
> > PCI is typical example: 
> > EP mode:  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> > RC mode:  Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > 
> > Which is the same hardware for two difference compatible string.
> 
> That's the only case, I recall.

As my knowledge, yes. 

> 
> >>
> >>>
> >>> I can write git commit message like:
> >>>
> >>> dt-bindings: i3c: svc: add compatible string nxp,imx93-svc-i3c-target
> >>>
> >>> silvaco i3c controller is dual mode controller, which can work as master
> >>> and target mode. All clock, reg, irq are the same for both mode. Add
> >>> compatible string "nxp,imx93-svc-i3c-target" to let silivaco i3c
> >>> controller work as target mode.
> >>>
> >>> Of course, alternate method to added a property "mode" to distingiush
> >>> master and target mode. but old "silvaco,i3c-master-v1" will actually work
> >>> as dual mode support. Driver structure will become complex.
> >>
> >> Please send full DTS of user for this, which works for 100%, so we can
> >> see how it differs from controller mode. If your code snippet from other
> >> thread is correct, then it would suggest "mode" property or lack of
> >> children. Maybe lack of children is not enough, if user-space could
> >> control I3C bus.
> > 
> > According to current implment, only need change imx93.dtsi's @i3c1's 
> > compatible string to "silvaco,i3c-target-v1". I attached imx93 dts node for
> > your reference.
> > 
> > 	i3c1: i3c-master@44330000 {                        
> >                                 compatible = "silvaco,i3c-master-v1"; 
> > 					     ^^^^ only need change here!
> 
> Nope, don't change compatibles of existing nodes. Unreadable and
> unmanageable code.

It is just show minimize difference.

Normally, it should be.

	i3c1: i3c-master@44330000 {
		...
		compatible = "silvaco,i3c-master-v1";
		...
		status = disabled;
	}
	
	i3c1-target: i3c-target@44330000 {
		...
		compatible = "silvaco,i3c-target-v1";
		...
		status = disabled;
	}

in board dts

@i3c1{
	status = "okay";
}

Or
@i3c1-target{
	status = "okay";
}
> 
> >    
> >                                 reg = <0x44330000 0x10000>;                
> >                                 interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> >                                 #address-cells = <3>;                      
> >                                 #size-cells = <0>;                         
> >                                 clocks = <&clk IMX93_CLK_BUS_AON>,         
> >                                          <&clk IMX93_CLK_I3C1_GATE>,       
> >                                          <&clk IMX93_CLK_I3C1_SLOW>;       
> >                                 clock-names = "pclk", "fast_clk", "slow_clk";
> >                                 dmas = <&edma1 6 0 1>, <&edma1 5 0 0>;     
> >                                 dma-names = "rx", "tx";                    
> >                                 status = "disabled";                       
> >                         }; 
> 
> That's not a patch for existing file. I did not claim you cannot write
> such DTS. I claimed you don't have such DTS for upstream...

Yes, it need finialize this topic before handle dts upstream.

> 
> > 
> > For master mode:
> > Unlike i2c. Genenally I3C can auto probe children node like USB can auto
> > detect attached devices. So I3C master can work without children nodes.
> > Such as auto load i3c sensor driver according to i3c standard vendor id and
> > production id.
> 
> Then presence of children cannot be used.
> 
> > 
> > For target mode: using configfs to controller I3C.
> > 
> > mkdir /sys/kernel/config/i3c_target/functions/tty/t
> > echo 0x011b > /sys/kernel/config/i3c_target/functions/tty/t/vendor_id
> > echo 0x1000 > /sys/kernel/config/i3c_target/functions/tty/t/part_id
> > echo 0x6 > /sys/kernel/config/i3c_target/functions/tty/t/bcr
> > 
> > ln -s /sys/kernel/config/i3c_target/functions/tty/t /sys/kernel/config/i3c_target/controllers/44330000.i3c-master/
> > 
> > Then you echo test >/dev/ttySI3C0.
> > 
> > Unlike USB, user can switch host and gadget mode dymatically. Suppose I3C
> > only work on one of master or slave mode only, which is static.
> 
> I don't understand this. So it can switch dynamically or not?

I3C Protocal allow do that. But no one really do that. 

> 
> > 
> > Although it is one hardware, I think it is exculsive multi function device.
> 
> Just like serial engines. Do you see there replacing compatibles? No.
> 
> > 
> > Summary: basice two option to distingiush controller and target mode.
> > 1. by "compatible" string
> > 2. by "mode"
> > 
> > I think 1 is relatively simple and easy to understand.
> 
> Eh, if you only saw my comments on people replacing compatibles...
> Anyway, I stated my reasons, so to reiterate: NAK.

I know it.  Needn't emphase it every time.

Is using "mode" ('controller' and 'target') proptery okay?

Frank

> 
> Best regards,
> Krzysztof
> 

