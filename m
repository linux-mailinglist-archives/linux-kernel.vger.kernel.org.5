Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44C87CB357
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 21:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjJPTct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 15:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPTcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 15:32:47 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA22683;
        Mon, 16 Oct 2023 12:32:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbpvP0eYCYIZaLstZ8X/9lS322IksjUD96p9Ehm0nyWctizIm7E95WTNnttKIFBey08M6VlAJ1EvAQPecdqBRWSwVkeZb9DGZ80ZOTUYtcF6bba49lLAUxo1DcjZTuorzeGdJRI5fi3iY2TzsXUvvNphcUHUzz9oQck8mCSG40l3VDyWcA8lVotNua9Pkoww0BmJNuGqd6CCvLMXv+U4HRucEbbTmhWFDgT4bYrHpTFkcwzfdEGgoYs01pzIxvSweYrYLC/LQnWoDUQ97VBqDVHvIbcv0ypgIV5oHsRRf/gsqjiDoOA8nFrrEW4sVodCQ9DK7oAlENsJoKfPPy7d2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mijsMKcfhXPFnWko39VMIMEcGQwhR2Om3+oaW9ZALWM=;
 b=IGgU59Df//xNsYoky7hpzeZTuipx3/56z5h/kZ6zxynQPI0xOHSCxNp91dvU4RlSMYfvenZCXV3vmZyPwG8VT6cklXbYAehax4lg97lkASfZGlodMLX7Y13nRbsIpkgMbPhU383RV/yB9ME/J9LqBLN0TXbpprnRRtMj4Ll0MGuiDNXRtizGE0uzTYLpCyTnX4XIY2moFXJ/Vba1wvUa1EiYTR2W+dS9DyV66fTTcxBRXQnBLIx0iUb8f2xu359DD/AOBopz2Yeu6df9Tgth+TqupJCLxEgmgnwXXUH3fUC12uO2vwDBbz3DisyXr7B30jZnBJBk16+XhAm0F5zq/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mijsMKcfhXPFnWko39VMIMEcGQwhR2Om3+oaW9ZALWM=;
 b=U0LAOxCZUSJmKp9AVRbC/OMTvqPiZFzkScvvPzX9tkMkh1N6oljKs9WQGPFwIPt2CMgaiwmxN1Png072Ig+l+qbPi5Vb4seWk0pynUVdfX3GjZB7fFbEmg5oodFKABl148xBndscrDAsAY3eg5oEURbTQEyDsxHeYOGa10JvqhQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8739.eurprd04.prod.outlook.com (2603:10a6:20b:42c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 19:32:42 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 19:32:41 +0000
Date:   Mon, 16 Oct 2023 15:32:31 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, joe@perches.com,
        peng.fan@nxp.com, alexander.stein@ew.tq-group.com,
        haibo.chen@nxp.com, ping.bai@nxp.com, xiaoning.wang@nxp.com,
        sherry.sun@nxp.com, linux-i3c@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH 1/2] dt-bindings: i3c: Fix silvaco,i3c-master compatible
 string
Message-ID: <ZS2Pz1HxUgrx4+0R@lizhi-Precision-Tower-5810>
References: <20231016152450.2850498-1-Frank.Li@nxp.com>
 <20231016-chatroom-regulator-a75f1d8be809@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-chatroom-regulator-a75f1d8be809@spud>
X-ClientProxiedBy: SJ0PR03CA0238.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::33) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a00b65-07fc-403b-5b84-08dbce7ea9cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: svEbuRqpza2Jqj6jeifs1xwRONQ1hfH1PcaebppwCMvxDfN3IR206dSyb8h6h0OB60n/TFd5D/4JLrFYMZPkRb7VhXalJrVNKw8qd0VW2K1vS1AgZLTgUtSrXPTeFBJ2uJGnghoLZBdAjb4GSr2DbPvMHEUn421Buuz8+Iqi+eBeQwlngOEQiFwXNpxC3r/jsOEYztn6scXFfB7MIMH46fVkIH6o/ZfssTmQ/if2umOTYjbME9DEcRcGbjwSQOvhjQGdaidvNpLYvTCXwebaMaHooEVqJ1vTv/YVzw/t4XUU+X9jr4g7HPSmjzH7xVV2ISNrZN+RpgEXZoZxUHgGxh51v1pFE7zH1w1L3LcsAeAmIXjx399XGetuLGaVJREDoZMnXDvhw1UhiWVf9OvL1jYHcRBTjieW3wMrg7uogG8ijnlJM9DweGUxw5biv2QXPI6ZSfjeNVMV4Hi61vgrPu5wCYiAvCKhRJesNj/y0TBDd03M2XHh2K0Mmf8Whdx+3ucqms9YRHmZYDGrspTDL0s+wFMqqSyPKGVGo89If0ehnQgkbPCfeTD0cfqhAwWrKiQVQoE7Cmo3HGePfPLSDPjbzvSUxFAY3QYCTPu/JvlkBIE7IB6Is/MQ9tZG8ahp3fKBkT2sxEFrYxpfjEka0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(33716001)(478600001)(6486002)(52116002)(6666004)(6506007)(9686003)(26005)(41300700001)(6512007)(316002)(5660300002)(66476007)(6916009)(66946007)(66556008)(38100700002)(86362001)(83380400001)(38350700005)(4326008)(8676002)(8936002)(2906002)(7416002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QufDXmQ4u6vnhyLodTmma4hIK5gTZYUK47dB93mu8boFh8T0It1eMOjaQrli?=
 =?us-ascii?Q?W2MLp5XSzQEoB3zczQ37OysfwZd6soeAJJlJxlVbwb9F/yUvrZQsSYIv52Jt?=
 =?us-ascii?Q?vJXWihM81rcJX++AFDrsvcFpqvHfLKpYlHCVWNE51mzXDvliRRsaFGkX7EB+?=
 =?us-ascii?Q?Ta1/k7q7feODJ794GIghPEp7xDUXfzuFaYHBYX5bFuQv8WVGlOjTFMuxC0On?=
 =?us-ascii?Q?TeDWkL6jlHtfwLgVBktP7FhNM50VvMy9e/fGJjbafYL3oiQMX5juwjSvLTAi?=
 =?us-ascii?Q?v3WJt1xkRDaJve0FAc+qkJfN79hnaDROJg9omJefwshtfiO70QzsX4XMcZ7z?=
 =?us-ascii?Q?8G5VkY774H+eyVZsS6EEldQ6QJ5OCGEz6cUjuhmVgO9C2RIaT4d7eZ4W01D7?=
 =?us-ascii?Q?weGOaNQWUIQE5l+FZGUj7C1i67oN5EZab6Pi50dFMu0kJTuJBnDXP1+Fvwak?=
 =?us-ascii?Q?GK0FS+Z1RG92YEwdQunpkHZv2HCewfFinrohEsX3PGdUoW8T+radyOUTaFcR?=
 =?us-ascii?Q?ggt2X245hvmJpqav/gyaDRc6biPt2WYr4OdGPTjR0aaqie/L/UFUN6Hi+OXu?=
 =?us-ascii?Q?40mzrZkMrkY1EbnB5JLEULXEXbc0ufCFfKET7ic/XPMNi7KcHv4WKROaCclW?=
 =?us-ascii?Q?kn74M4oFdqowgzPEpnC8iU3mbfJW1xYcJvaFwOc9Qr8KZ6lIysVWerY7ePUv?=
 =?us-ascii?Q?qHFbS5aZteX0kcoSknmFq/ts46SYB0/Jaq4F9XTt6cr3Pz28ZSMBZkoR5zeS?=
 =?us-ascii?Q?H1bb+Ck3FinDItBEMxswuGD6sl4c3/7Jbm8mzunasX8yE+Wx+OjDQ8p6RLdi?=
 =?us-ascii?Q?bh47C8T/YPSOZHEnzLABEGdS/nXUUJTYOimbMxrbYUcLpPD6sEv2JPXdU3pY?=
 =?us-ascii?Q?YvnvTQrOZs1R2NUjRUmscjdU60BdwT9T8Cck0kIn+/SxoN6mr0NlH1KmJmpL?=
 =?us-ascii?Q?dQW5NVkILUpBAQV/FXCoRCyPV0kQQQ4C/UV/U5YU0nm9u2sJaxy531Jmss5q?=
 =?us-ascii?Q?JgICANZyYrLuCGX+Vvv7DQhHLewouucN6hkHr0eksQ1P+r/5CYJyDVTh/x/8?=
 =?us-ascii?Q?5tjdXP/U0Wu2DxytzeRDvM9xRPGYkaq06jFkswAu5LAi6legYHjwjX11ESEz?=
 =?us-ascii?Q?VNbn5h90ucLVToayrBhKymL6UWqbny8dd/OoB7Xrd5BQm6DoGDwGWWBQK+yW?=
 =?us-ascii?Q?35CgcVa0UuzrPQRnMeJJH2rLGpQgho50DFrTJT6NCrCdOvZepQhX6vgqyCAT?=
 =?us-ascii?Q?w8hX0Xl6Y0hFW2+aEXNe4ScBgTebmBKmZ0s6t5M8uhCAi4pvwl37UlWTg5VP?=
 =?us-ascii?Q?GudSolQZaUqD5zBgXbPHFrIylx5H158tG7nRQQoHRDrDUo5ZIiHY+kuxjS8R?=
 =?us-ascii?Q?RJRbp3b38SCyjvoOofEQPIPhCpRcQow5YsTFet4IYxykMApz4EQgaXKciJfd?=
 =?us-ascii?Q?BWEW2cwQUNPovAj/HGw3LHxQB8SywzGz1jzrvo0p48t5ovuGY07WH4p68Kl8?=
 =?us-ascii?Q?bPJZODu4qzR5ZbJIbN7Ou+s461qJFG5ppcW/Nln5pNTOs9K1X/qsXuFQdyxr?=
 =?us-ascii?Q?g/qbdCqRFl3ghBZ9NwndYZQCw4FwvR0PiJv+Mi7z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a00b65-07fc-403b-5b84-08dbce7ea9cf
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 19:32:41.4686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYDtZh2iG98KiZ3Upc+M1JkVdjB1lK0cg1P+4QZ+2/pixqzMnBVwFtwMQwAuwHZmkZ/rXJL4TCNAT+3uVKTcIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8739
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 06:30:11PM +0100, Conor Dooley wrote:
> On Mon, Oct 16, 2023 at 11:24:49AM -0400, Frank Li wrote:
> > In driver, compatible string is silvaco,i3c-master instead of
> > silvaco,i3c-master-v1.
> 
> And what makes the driver right & the binding wrong? AFAICT, this is an
> IP sold by silvaco & the -v1 suffix was explicitly requested during
> review of the binding.

The driver existed for the long time. DTS files already use
silvaco,i3c-master.

There are two options, one change doc, the other change dts and drivers.
I think change doc is easiest ways.

If there are v2 in future, we can added silvaco,i3c-master-v2 in future.

If everyone prefer change drivers and dts, I can work on new patch. Just
break back compatiblity.

Frank

> 
> Thanks,
> Conor.
> 
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> > index 133855f11b4f..19e3f75eb45c 100644
> > --- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> > +++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> > @@ -14,7 +14,7 @@ allOf:
> >  
> >  properties:
> >    compatible:
> > -    const: silvaco,i3c-master-v1
> > +    const: silvaco,i3c-master
> >  
> >    reg:
> >      maxItems: 1
> > @@ -49,7 +49,7 @@ unevaluatedProperties: false
> >  examples:
> >    - |
> >      i3c-master@a0000000 {
> > -        compatible = "silvaco,i3c-master-v1";
> > +        compatible = "silvaco,i3c-master";
> >          clocks = <&zynqmp_clk 71>, <&fclk>, <&sclk>;
> >          clock-names = "pclk", "fast_clk", "slow_clk";
> >          interrupt-parent = <&gic>;
> > -- 
> > 2.34.1
> > 


