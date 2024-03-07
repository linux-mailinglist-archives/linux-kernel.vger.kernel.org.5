Return-Path: <linux-kernel+bounces-94846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B1F8745DD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028991C223CB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9669611E;
	Thu,  7 Mar 2024 02:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zp5JLGc6"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2077.outbound.protection.outlook.com [40.107.104.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE2C5C82;
	Thu,  7 Mar 2024 02:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709776973; cv=fail; b=RYM1FEmYhPjGr84/n6zN6K9q96JDttQP2Gy8dmPNR2+ZTEocRlp/0+zzznMprV/bOzDX4PqNb2LDoFjze6CPcw3H9ofBv5ycvKxqVH3L9dPqo1dXQcsSmlOtfzYKeMbGDFE1Kkiadax4cLlfU8N3N2us9oe3e231Qc6/T5A7wmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709776973; c=relaxed/simple;
	bh=0Lv4cqVseb2agZQNK4RJ4/65NMrdqPLEkDMQoTgMokI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lec/zN9E3DHKpCYvzqz3j8Z3N8BCHXcpCsqh6YqU5tmVSVk3j7K2v4IF0+YHDoqdDNFlj5ZzB4VnsvYG18amfyeGeTmbgBspuSD8aN/TF4aaeFNLzD9d9dImeohLExF9MP/iGBaaOoLvZlJM+LVjSVeB9q3yuFEbvSYaYSMs+SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zp5JLGc6; arc=fail smtp.client-ip=40.107.104.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfPtyB99cyQsip59o+umPUv37XYKJBBH8b0zICs+5E/WBTKNe/o4dl4MzqNdms9Setb3xdPMTO4fHd8EQVWBkjHSF7BuwRXZJjabZHIoeFFFUFTTUPxqlM3U3AGcVBn/xgdmrEr5Z6tmDsviZl0xtOlTppACAsVdweWNYR6h7zZ386O2GGO2ztHElrum3MO0CteYisw7PvX53/A2+V5/VnT85Nsv8EE3vY+u6pBzwJHIimFVm0I2QLDhGDsBcEWaOel2cMmypAZuLrO9iaGQ0giUQhVZ9RU5kfjGt3XbtfEOqSKx02bcFEiY/G9Y6FWf1XxdAv9HuYwua7DCTh0Kig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpisvue3+k7oVIuJ95+QhuYegcvbFo3NGGeRNhHULh4=;
 b=iyvErlz7mwlFKhnFXOer9lnzSOY5Bf3S5pPdcU7EQ2J1O5ZX9ywxVUi+09KLB4nyNkCifC4xO7sopO7JMvUxQ49tChlWrSe+ZF8PFggnerOY9pKTCH1DSLUdOPmNzO6smO2ngptSi9mRNRyz3/ajrKdniAGIc6lThQqLCpIXElSqfDIMnMWNhfH89YakVp51q4X93BXrNfswtsv1agfO2TGtYZEpeuZvm9N7Vx4znYo3UH9ponvU/Ju/PUTxYM7FgTtzTLyNK+D4xzV9lXBRT+jyk1OnIV4ujL/W9K9BpPFso4ZWVEHc/+DcSZ13fTDvgAupULLzQsLSb3Nu9iUYTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpisvue3+k7oVIuJ95+QhuYegcvbFo3NGGeRNhHULh4=;
 b=Zp5JLGc6SCGkWPF2GNwQ25Fp0jFU/wLhFgbVNGkLrtxCMhjD6QVRDTOElkO5Kl1oqkosWv7/KfmUU0DPpLF0Co5SCyponibvWLaeXQvJRAG0zvjlEZut18cUlbvxfNvI7FdFpL5L2uy/68w5Bg/P0qEVZUsK/ccg1P5xwVM9kz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 02:02:48 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::b731:e23b:56b0:6a68]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::b731:e23b:56b0:6a68%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 02:02:48 +0000
Date: Wed, 6 Mar 2024 21:02:38 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Message-ID: <ZekgPg2nsLIQpvY/@lizhi-Precision-Tower-5810>
References: <20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com>
 <20240305-asrc_8qxp-v4-3-c61b98046591@nxp.com>
 <20240306-pebble-grope-88fdaa95a87c@spud>
 <ZejDQddMp17RD6Yk@lizhi-Precision-Tower-5810>
 <20240306205524.GB587561-robh@kernel.org>
 <Zejdz0BKwSlsio9S@lizhi-Precision-Tower-5810>
 <CAL_JsqJw5W7a9Pz9gRPuP717onHdSwRvwGJ=v+QDSe+4ORvTaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJw5W7a9Pz9gRPuP717onHdSwRvwGJ=v+QDSe+4ORvTaA@mail.gmail.com>
X-ClientProxiedBy: BYAPR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::23) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB9PR04MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf1d107-cd61-4d41-b4b4-08dc3e4aafda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VH21vXeX/upFnZjtpaq/20vXUBaFs9cnn1f89YQzBF/AFAn8npRuWavUklVDXthJLjkjoxznKGNqjfho+ohsS7h4S7ahtuOxU7wkVZ6rCOre8r/NeS1dwl50Z9kRNiSAaZ8V/0AxSloHJQUCFzZSJ3J75diRlj+DcSQcDHKJyLPk3ZhFwSxA8jBVjbUxrBmNXOW/eKTc1oQPIEEfWM/rPAu3cuAUS4ELnZ5yPStrwH2LlJV5469XI50+T39j7eHJT9UilyMx4v6XWSulnrpn0otLYpaOH0BjviLTn3BV3X/zuHW9SynzbuT2ZQEyu0LtF2LvfIjtBldMrJZCfNUayKMA2eEOza97isBpfuhmQ9hdh3RP5Zr6XKx6osmKgePMgU54CfgaLlyrs0hNYvssQ2nEihU4wktXESgkKe5OZ1jeSPSFDz8Sw18UeBrpChyElZnF/0tixnQCjWaCTJLwEtZON13/YVeJ+zFMN38RIJuziv2gYGkT+PME5KyGDiPbCgtYTthtVki6871p57Ir4zc8Sc9kyrZ0zomhYiZuP77TYd0DnMWWER4qu0rLbgzgs8Lytq3euEUf02padkQ3gJ2v1jcxPUfQVMij2L/lw2EkJQCfBX4NGFRF3PaltH0NfLucFpc9P+IS4pL2BXZCu184nKPKO6zEi1rt7L7jREpPzDEq2VD8++rUfMCWD9d5HYfbngb0x55kT28XuoONuw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFVHYTEzYVZHbERDcEdKZ1NOT2pEVDRPbGpGS0dmc0V5SWVHRlNPcWlFY1Yv?=
 =?utf-8?B?MHNxU25rTVpPTnRBMjM5YWNIVWNEanhka1BWcXRIODhoVjMxbWV0RktCYzNR?=
 =?utf-8?B?U011bU4wWGxZeVhhbllaRzZLWVBPcTl2d2J5bUp5clN4UEhwUzFOR0xKQ3JO?=
 =?utf-8?B?V0RzQXRKY21xSEtqQUFOV3lQM0xLSi8vMzdnaVM2WlhUcWZsN216cWl1SnBL?=
 =?utf-8?B?RXBBVHVjbEc4L3d6MjJHMmtzWVZKbmxDSEhHSEc4TFNreVVmWmJYQ3hiV1Rq?=
 =?utf-8?B?MkpJQXRsWHUzK2piRXgyVXYvcUtQUFFpck50VUlaQVQ4OVIvMUVLY3c5a0R2?=
 =?utf-8?B?YjFGTnVtMVR1Vzc0OWZORjFBRFlPbmR3VDlzd255OTBwbC9WOVBRK2k4M2E4?=
 =?utf-8?B?OWJsdGNkclhTN1lNb1dLc29Qd0FrK0ZhbUcxVW96UFIxMjlsOERTdUxKNlBB?=
 =?utf-8?B?OXRPL2NwMGY4SUV2RzQ0RTEyU2w4YURtUndTNlh1ZlVyekx0WUxMNWZUZWt5?=
 =?utf-8?B?Nmd2anVlbEhMWVlBNXV2cTFwSUlHR3hXazlELytuT2cvY09XaWs4TU0rVzds?=
 =?utf-8?B?YzQ3WFBRWk1QWThEVXJ5bXZzR1BURUtobk1wcDBjL2ZaYnFmN3cxbFBPL0I2?=
 =?utf-8?B?QTVMbHErYnJNdzVXTHBCZDNzY3R2V3FWZ2RWNDFiaDhlcG9xR09BbE1NNEdi?=
 =?utf-8?B?U3hxbHpQQ3g1eHNjUnEyVmlTZ3pyaEJuWlcrOU9reUphTzJINmtZY0x0dGli?=
 =?utf-8?B?YTFNVVVNUndaUG9UVlJVSXBrYTJNZW8zZVJyL3I4KzNRLzFVSG9obUxONGNH?=
 =?utf-8?B?cS8xWUwrZVUrK25NRW83L2tJUmR5ZXozLzRqS25TTHQ5djVLZEgvWk9sOExj?=
 =?utf-8?B?elptbEM3eTVkcW15N1hkVjU3VVNaU3VXbFhQZDUzQTBOTHZnenRIbDFPRW5v?=
 =?utf-8?B?YlR4YXhZQ0ZNWkVTVWRGVVhwbXYyUmFrT1dkT1JrV1lYcVgwREtVbzhHM3JT?=
 =?utf-8?B?N3NJQlhFWmZPc0FtaE9mR2Fsekp1TXV0V0g3ODNFNW94Q0VkZVgzR2tVd2ti?=
 =?utf-8?B?aUVuekpMaVhORHFYNjdHRERVRWVDT0dGTnUvNXBBT1BEdEFnVmFpUHcyUWo1?=
 =?utf-8?B?RUxtVkVGd3l0Tk4zVlVHRjJTOTFaS1JsQjBqbzBseVgzckp2TitWb3lmRS94?=
 =?utf-8?B?WTIreW04NzVIR1pXamZWTWxROCtIeVhwNWxuYkZjRFVZVDlNdjhGMUFQNG92?=
 =?utf-8?B?bHgzekV3UEx0Vnd2Ni9KODV1THVFSUhNQTdnTUFSSFRGZWZmTjE2OUJYMTJS?=
 =?utf-8?B?cnV3ek8xd1lpczliSGpLT05aZ1VKdnJLdVY2anNlMiszZzdLNVh5ZklzZkRQ?=
 =?utf-8?B?Sm4vSVlhWGgzUXlNdGVaenNUMWJUdk83bXlQWWJuZVpzREdsWUllNzV0a1Q4?=
 =?utf-8?B?RnhaZFVINHYwWjM3bHhzcU9ITEhtN3czNG4waUNxT1VZSnNGNkJnSXE5a2NL?=
 =?utf-8?B?NnBFUTZSQTZiV0kxb1FIeG42ZkFiaFdyM3VTRjJVazRKYmFHeDZvWlhsYnJp?=
 =?utf-8?B?YzR1aXBIRkNwdXdHM0RONGR1M1dDOGQrUk4rT3RLdStDVkd1M2xjbUxuYWNS?=
 =?utf-8?B?UVo2YXNIVFgyQlRnSnJrY3p2VXp6NnBuZndwZ0I4aENDdHlGSWZyc3dHUFNT?=
 =?utf-8?B?R3M5Tkxzbmp6ZFl6QkMwOXQ0OHh1TGkwQjF4bHdZeE9GeFNUeE5lUVFrcDky?=
 =?utf-8?B?bUNuRktFbjE5ZVFSRXduaEN5TllyWGZ0VVJ6WlpqdWpDNlQ0VDJWUGxQdFZO?=
 =?utf-8?B?dnl6VEJaUU1IOU5uSXVZM0NZcFVUZ1RtenRaT0wrVnBSYzVDWUxQMFlRZytX?=
 =?utf-8?B?ZGpGUzVPTUhmV05SMXBOZmhGb0FKcGdOenNNcS8zcUVNeC9GcUMwVitZTTA5?=
 =?utf-8?B?SjA3QWF6bnJGN0VqSkVvK3hjdkVPNUlNNlEzNGVocGcxeXI1T3crK1FNQ001?=
 =?utf-8?B?dWtUaEt6QUpJQU9xcFpZRUpjM1Jlc2ZtSnFEMVpFL1VPOWFXMU84OEh1dWJ4?=
 =?utf-8?B?eGYrSUFOcEdwZHcvTUtuRzN6aE4wcWVuU2VDdjNaa0cwQklzZFJIeWUxeTdm?=
 =?utf-8?Q?m/2U=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf1d107-cd61-4d41-b4b4-08dc3e4aafda
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 02:02:48.0614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dc8GQgsETCXxKSAsIBe0m587x+DWg+o95o1KMNBzcEcNgSur0kAWhvqFGU7K9y8DiO10KF7ojYXZOOvwHn49A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8461

On Wed, Mar 06, 2024 at 04:58:22PM -0600, Rob Herring wrote:
> On Wed, Mar 6, 2024 at 3:19 PM Frank Li <Frank.li@nxp.com> wrote:
> >
> > On Wed, Mar 06, 2024 at 02:55:24PM -0600, Rob Herring wrote:
> > > On Wed, Mar 06, 2024 at 02:25:53PM -0500, Frank Li wrote:
> > > > On Wed, Mar 06, 2024 at 06:45:13PM +0000, Conor Dooley wrote:
> > > > > On Tue, Mar 05, 2024 at 12:33:04PM -0500, Frank Li wrote:
> > > > > > Some sai only connect one direction dma (rx/tx) in SOC. For example:
> > > > > > imx8qxp sai5 only connect tx dma channel. So allow only one "rx" or "tx"
> > > > > > for dma-names.
> > > > > >
> > > > > > Remove description under dmas because no user use index to get dma channel.
> > > > > > All user use 'dma-names' to get correct dma channel. dma-names already in
> > > > > > 'required' list.
> > > > >
> > > > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > > >
> > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > ---
> > > > > >  Documentation/devicetree/bindings/sound/fsl,sai.yaml | 13 ++++++-------
> > > > > >  1 file changed, 6 insertions(+), 7 deletions(-)
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > > > > > index 2456d958adeef..6f551c68d33db 100644
> > > > > > --- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > > > > > @@ -81,15 +81,14 @@ properties:
> > > > > >
> > > > > >    dmas:
> > > > > >      minItems: 1
> > > > > > -    items:
> > > > > > -      - description: DMA controller phandle and request line for RX
> > > > > > -      - description: DMA controller phandle and request line for TX
> > > > > > +    maxItems: 2
> > > > > >
> > > > > >    dma-names:
> > > > > > -    minItems: 1
> > > > > > -    items:
> > > > > > -      - const: rx
> > > > > > -      - const: tx
> > > > > > +    oneOf:
> > > > > > +      - items:
> > > > > > +          - const: rx
> > > > > > +          - const: tx
> > > > > > +      - enum: [ rx, tx ]
> > > > >
> > > > > I'm not entirely sure if this was Rob's suggestion, I got the impression
> > > > > he was suggesting that in the two items case we'd not care about the
> > > > > order. But while I think this is different to that suggestion it's also
> > > > > not wrong.
> > > >
> > > > I log this at cover-letter. b4 can't support write change log at every
> > > > patch yet.
> > >
> > > It never will (probably). That's because it doesn't need to. You can
> > > just do it with git. When you edit the commit message, then after the
> > > tags, Add '---' and put whatever you want after. That works as long as
> > > the commit is applied from a patch as 'git am' will drop it.
> >
> > The key problem is that I don't want to lost notes when respin patches. It
> > is easy to make mistake when I copy old serise change logs.
> 
> You don't. It is all saved in the commit. When you rebase for the next
> version, you just add to the changes history.
> 
> > Previously I use git notes + git-rebase, it work fine. Notes can be kept
> > when I do rebase and git commit --amend. But one thing is not good.
> > git send-email --to-cmd=./script/get_maintainer.sh *.patch. It can't
> > combine all patches's maitainer to a list. It looks like difference patch
> > will be difference --to list.
> >
> > b4 can help some case. But can't keep git-notes information when rebase.
> > It should be git bugs or feature missed.
> 
> git-notes always seemed clunky and to be extra work to me. Just having
> the changelog in the commit msg is a lot easier.
> 
> > > > Rob's suggest was not work. dt-binding check complain too long
> > > > if there are two dma-names = "rx", "tx".
> > >
> > > So I'm wrong or you didn't have it correct? No way to tell with your
> > > explanation. Let me give you the exact schema:
> > >
> > > dma-names:
> > >   minItems: 1
> > >   items:
> > >     - enum: [ rx, tx ]
> > >     - const: tx
> > >
> > > This says we can have 1 or 2 entries. The first entry can be either rx
> > > or tx. The 2nd entry must be tx. That's what you want. However, '"tx",
> > > "tx"' is allowed with the above, but we enforce items to be unique
> > > elsewhere. Or I thought we did, but we relaxed '.*-names$' at some
> > > point. I'm going to fix that now.
> >
> > Conor find out my problem. The below code works. I missed maxItems.
> >
> >   dma-names:
> >      minItems: 1
> >      maxItems: 2
> >      items
> 
> Missing ':'
> 
> >        enum: [ rx, tx ]
> 
> That is not my suggestion. This would be my 3rd choice after what I
> proposed or what you had already. Please plug in exactly what I told
> you and report back what doesn't work.

It also works. look likes conor's method is a little bit easy to be
understood.

Frank
> 
> Rob

