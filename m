Return-Path: <linux-kernel+bounces-24801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BDC82C2C0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93201C21B55
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20266EB5F;
	Fri, 12 Jan 2024 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qsrBPTyr"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2071.outbound.protection.outlook.com [40.107.15.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AE96E2D4;
	Fri, 12 Jan 2024 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhytvMYvjpWKwH0TBq2V0NxyRuOmyjTJJtRQFdeFjty6djT4PweHMFTCjU4rctm62u6N9N6f7n9tIupVtCbGCH+GfUG4ih/qjF/M6Xgq3jhxMg8BaqcicKXoTwH/VFpcZs8sSlpHzDZRojaBdnSGO6NG9osLrrlEBkSgU3wZBbqMoO8t5wg/1Vdcr9EqHfc7WKuP1/1nfo6tx/MQdr0cLrAFdcjRtMxGwILdPSQhFxCr0QO0v7uj3AsY3YpF5g/+iGzxqGgE43bJlKfFLA4wznkCMEzlhwgWxwwlMm76VMkdJl+Cxu3ccVKhSn8mYZxC1gp+JT9yTdBciGOBD2qqcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wATM4zZCZ7tCk2lVZCkwvvfE9iYI9FEXKTsokR23NcQ=;
 b=TI6NaAO0NSThzm9pSax3BfznTIcCsIPxWhyZ24zdWeBAJMbfwvnqZy5o2TYMZDyfVXnt24YLpcoqF/KRU5n2dJpBLUlUKJ1U09xKijuvw3cmd92YOVAcoY3VOiShwy1TrJiE2WdwmeqWTchWN0I5fU3iegHCTiUN/NECvyayRz/RCaTA2m7o0aM39CzxHYRxRV066cF6Zc9nYpu2jKN9MiyH5fsr18Aq3Deat2KbDQWdsZVLlLx7zfML8Ej4MvmV83UkZbfgixN4lMUvH37kQXF3TtwEYtSzKGoFj0Q+VJGxf3k1GCoRAvYo+ij30QsmoSDXD6C2xHU0NeN8d+Ps4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wATM4zZCZ7tCk2lVZCkwvvfE9iYI9FEXKTsokR23NcQ=;
 b=qsrBPTyrgml137ZW6xfHhGxtLCXnF/rLULeN2mSKGo0P387XERbvoZmUIDTybXh8UaWg678MvIN9DTSfH4xrF+Qyy/oW2eES4mTgvgAYeVO8e7Dw8ib3L83rtlr55jih0bImBBIfdnxmnEMuCwYDs+uVr71TXJfDeZw5k6VuBmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by AM9PR04MB8587.eurprd04.prod.outlook.com (2603:10a6:20b:43a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 15:32:06 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 15:32:06 +0000
Date: Fri, 12 Jan 2024 10:31:57 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: robh@kernel.org, alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com, gregkh@linuxfoundation.org,
	imx@lists.linux.dev, jirislaby@kernel.org, joe@perches.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, miquel.raynal@bootlin.com,
	zbigniew.lukwinski@linux.intel.com, devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 2/7] dt-bindings: i3c: svc: add compatible string i3c:
 silvaco,i3c-target-v1
Message-ID: <ZaFbbeQrC7o2dchO@lizhi-Precision-Tower-5810>
References: <20240110175221.2335480-1-Frank.Li@nxp.com>
 <20240110175221.2335480-3-Frank.Li@nxp.com>
 <3c0be658-e7a6-4231-b206-86ffb47e0cb2@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c0be658-e7a6-4231-b206-86ffb47e0cb2@linaro.org>
X-ClientProxiedBy: BY3PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:a03:255::29) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|AM9PR04MB8587:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c22be5-4b97-4ad0-468a-08dc1383a21b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3puNpD9nWkTp3RD0hGwRKbdY7tmRIKj/GoGt7l48/mAQvl2sMwLi3bLnEjG7Ggp7HduUzh1qW77WsjCinlx6z9e3k/TmaZSd4xc03urbOtMMtjW2E4ryxAyEDdlAfs2N6dUfom5z0EXAeyvoX9DtKtfTEeWPO6+4UGmuGmZLqhoneJDElWOItu46HYznFso3DlPdhu3+dgwjfi2MmYlhP3SVx8pT7LdbwQeeu5YCtBdwYgnn7mgKYFq63dKyTdb8rIoYty/i8EtdiGvY2NOKMnW7cFDQ7u4BeIK0fdXnruMDGCp/7NdWX+gbnkN2ZyRXHVSUVZYgD4EjOSO/CA2D5MFVm3FuLcI8aCRilFyzPBzm4hCo5Nt2+yl+GtwBdgPfOYMyva5DggxYR/E0LtuylXiZiEYJRBl59cj0ypr4KrDBiCK7K6GZhZD9F++L7DPgdtCMW0NYKjpQ1DOePwUaGcJdTQF1YQ9GCeAgSBYTX8h5ZbxBRkIxIa8w6NoIQM9kYo8dKGvpMntXGiynAmXDNCoA+5tTVsC41Gw0m34PnSmiveSDx9XfRJg0RFThXnc+AMfIfD0NSwtsmo6R7SLr5qVwVDBagbrvnOTWkxRXm8Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(396003)(39860400002)(376002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(38350700005)(966005)(9686003)(6486002)(52116002)(53546011)(478600001)(86362001)(26005)(83380400001)(5660300002)(7416002)(316002)(2906002)(8676002)(6916009)(4326008)(6512007)(6506007)(6666004)(8936002)(38100700002)(41300700001)(33716001)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/S+t7vNsct13en7nznmauhkMSvzQ14QClsqxIEShBaJ8yn2qPtJk3LrCNmt/?=
 =?us-ascii?Q?r0VBgxPcRpXGWXxQmttj1bG0vnwKKl4+eQ06geKVfwWSlSp+6wPpZEq0LrUf?=
 =?us-ascii?Q?D0vCYSWd2S+Iyv1ukeaO4QbQzvlLnW2nRjzWBpa22cBkKb9RUZQ0CmuKlR1C?=
 =?us-ascii?Q?Y81ZMH08Eqx/QOGdlUHGpDRjZfH+cLzVfydROuhQA2n0IGhuuSJ8cyV76uGi?=
 =?us-ascii?Q?7nMAylYDwrCR1MTRo8ztKG8RMp0Th41UoyCogrEzrLxdFrd4a6SVVUKopSKn?=
 =?us-ascii?Q?N0DXnToLJ5zKJg2ZxiVlsh4mromAi0/9Qsc8bbVW1wwX4fTyCi5FNLGqMGBw?=
 =?us-ascii?Q?I6jQWMEiJWvUrL10aN6b1SFIdbE8PhHv0edm2gkkCGugeOEjI3wG6LttXOtY?=
 =?us-ascii?Q?7bvWWmHNm3ZmCoO/h5wWoo4vRI9DvTrcqOP21Ynim4VTjDKqhEiR5WIy4YMh?=
 =?us-ascii?Q?VrY92dOTo3fSYJpH6wAEN4DwId1DQtBVT42E+Ag/13RqeEUBvU3ISbUg8o2N?=
 =?us-ascii?Q?WDyO9vmHh6VcPDdAYcfoc1dAkCTWeYlffgePQOCTocOgJ3WsWXCtpWHQ4X3R?=
 =?us-ascii?Q?Gp2bygNWDoExhh4fsXZ9chN9VVdsaojoDo+Uts++U9YEnmhuCFIVoUf7cviX?=
 =?us-ascii?Q?V+IV5LqmwcvmtJ74cbmAVkIZG4GHk+013AeIr3jjom+qOf3UGK/J45X53gVi?=
 =?us-ascii?Q?jBzmjybCkkuPmfTgBe7d/73jOiSHNc7as4CtJAmWTYKXIPuL1whJa+sgE/+Z?=
 =?us-ascii?Q?S1NNaLg/fwRoxFlQryWdp6r6/zwZHYD9aMjJhW7ht5cgxaQ7T4eXbGOcpbNz?=
 =?us-ascii?Q?mOsgh/ph3q2x1rnVFs9SzAQvmgZnHAMqzeoe4biZODCy/j/pF6xch0tVySu0?=
 =?us-ascii?Q?hZN96HjWeK13gsDU8rDEkM0JWSJos5Zvb5OeI2F+uqn5vFUj+wQ+uvIY5yvt?=
 =?us-ascii?Q?OJZbLloONOc9DalsX5C8BcRqvInYGhzVDVaMaoDQ0RdTdmPWVQ9Rj+20fQHP?=
 =?us-ascii?Q?Z7H1Qzs9Ac1mWbcYrm6wpcQM6inisy9wxFShFcHYCqdClwxuSqbCTEL4R7rh?=
 =?us-ascii?Q?XPwUxYiugtZ1ExU6onfLhNsAjEotZ0JYlxSsqHLhZVFPHRmzpghsYpi9Dapu?=
 =?us-ascii?Q?PElvjBuIKnRAYCgAr6dsy926pX33VeF55HU7WnMVkkhGbeqtMvlu6dcPneYt?=
 =?us-ascii?Q?6KrIXl+iA6ZxBYn/eWUApRuaWCxPo5Qugimh7kq1UNV7PNHBbGRopiea4vF+?=
 =?us-ascii?Q?CPiC5frNsP5hUJ6EA4SHfoQ3N/b42wgZkK1bvBs4TwFpQMfq7fPhjzZP2sG7?=
 =?us-ascii?Q?rsDEJL5S1zpJs/M5lzdUek1fB75IdorKdBOZsAZvIY5Z2x4Gn0VC9zQFC3dS?=
 =?us-ascii?Q?s+tuvaBGEYJQzoKtCD40dURDIaPkgi3NuP0lcao1v/i7jhHl2zHviWUKQ8a8?=
 =?us-ascii?Q?AcVwC1a8r3YlmXUJG8mU7c0s1E+JLOOtyKMwESAqwUEgjKS3KNRFbA+LK9na?=
 =?us-ascii?Q?lbQrwDpnXIfQWKmR9AKD6PP9w2DC6O6BTrJW1YMLBy5vfWDiGJnIKSGJ6i8n?=
 =?us-ascii?Q?LCnEW3tQUYiIFvlOqMAVOSZDUCPGFHD+UO4r5c2B?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c22be5-4b97-4ad0-468a-08dc1383a21b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 15:32:06.4140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Zx/m9Vrv8CFCgCZifQkqUpGOZWbETSjORNB+AU87n4OYFkEdcWwT/FeSo5ETzufFnOazMzv+gcICmx6RxbwXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8587

On Fri, Jan 12, 2024 at 08:38:39AM +0100, Krzysztof Kozlowski wrote:
> On 10/01/2024 18:52, Frank Li wrote:
> > Add compatible string 'silvaco,i3c-target-v1' for target mode.
> 
> Your subject has some multiple prefixes? Why there is one more ":"?
> Just: add XYZ device
>
> 
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../devicetree/bindings/i3c/silvaco,i3c-master.yaml        | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> > index 133855f11b4f5..17849c91d4d2b 100644
> > --- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> > +++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> > @@ -4,7 +4,7 @@
> >  $id: http://devicetree.org/schemas/i3c/silvaco,i3c-master.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  
> > -title: Silvaco I3C master
> > +title: Silvaco I3C master/target
> >  
> >  maintainers:
> >    - Conor Culhane <conor.culhane@silvaco.com>
> > @@ -14,8 +14,9 @@ allOf:
> >  
> >  properties:
> >    compatible:
> > -    const: silvaco,i3c-master-v1
> 
> NAK, you got comment, didn't you? Why did you ignore it? It's like third
> time you try to push it ignoring what we keep asking. Pushing the same
> without resolving anything in previous discussion is not acceptable and
> it feels like waste of my time.

I review previous comments. The previous RFC patches and I just want I3C
expert review to check if there are comments about whole software
architecture. Of course, thank you for your comments about "slave".

Go back this binding doc problem. 

  "No, it's the same device.

   Anyway, this was not tested.

   Please use scripts/get_maintainers.pl to get a list of necessary people
   and lists to CC. It might happen, that command when run on an older
   kernel, gives you outdated entries. Therefore please be sure you base
   your patches on recent Linux kernel.

   You missed at least devicetree list (maybe more), so this won't be
   tested by automated tooling. Performing review on untested code might be
   a waste of time, thus I will skip this patch entirely till you follow
   the process allowing the patch to be tested.

   Please kindly resend and include all necessary To/Cc entries.
   "

It is the same devices, work at difference mode (master  and target).
what's do you want to change to?

Copy to new file like pci/pci-ep? all context is the same, except for
compatible string. 

Frank
> 
> 
> > -
> 
> Why are you removing the blank line?
> 
> 
> Best regards,
> Krzysztof
> 

