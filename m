Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5373C7CFD82
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346196AbjJSPCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345809AbjJSPCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:02:23 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7C1121;
        Thu, 19 Oct 2023 08:02:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7qGWAUI+lfJZdD3oNKW0r8H6iA0VIZJm474oQqKcZa7vArDCKygwLBkNCMB+0gbc+4eeoM0guZLFsq8aT/e4KMuzSHTysmkefR4QCc2Z7oXmhOrW0DNWMPXFLv6A1HyYOpLPHne+NmYmKMq7ceyVRZ+C6r2my9DbBd7GMuOpRjwDu0dAr5Y/khB+gBZmg2YlKyrfbpDva9NTg4vKT5SWIDxTSn+Mh1KdcUbsWNNcdZtNT+4y0yuySUqiXO+aVjw1o6iOF1hi+OMuoSxT9uB9AshCYrvvaT1sqmBQzojj/mmdDOWpIVcitbaIGonhCRLmdEO9PELziGJzK+7h0nW9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DA3KGuG1Ua7nsKr0/VaYunVZWD4EruJrugpSsA3JckE=;
 b=akI6vpXTVGK9pai2RJ2VU3hSvrg9/MI8I8zEoHBPe2k+Zg6sICv/h1STbG5L8GOjDc11vQ3d0JOAvmnLHlmrq1ospPjaUuhLRv/EXZRT8AXSP/sRvj/p3VwILDC8iyhasZ4VO8FG7bdpFdp3mb71Udu7PneBOxSogw6yyJbf8P277upXQ3Ay0yDRqXtTVwo8mjo/iwbjI21293q15V2xzzPjBnaFyXuJm3dfIpf6XJotWOl+2QOf7lZZ7g7vD18IpeYX2fxZHYsff1vB9oox3QmpJ9Cv+UZ7vus+nXlcKjp/lu92/Uy+I0RjfBBxllTfCR3sV64Zv7euzhTS28RUIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DA3KGuG1Ua7nsKr0/VaYunVZWD4EruJrugpSsA3JckE=;
 b=RFJBYoMLanb4QzQs18tTFWo0YJQt3ECJCBG9zX/PwoXHJf5ZtidC6J2Rgq9lxVlYeFqe2/o5wFYiN5+TAdnSmZ9Y+u6+LCqVqsZydLJ487bMuSZDsZovEg0zrvk+8Ul24UBbG5KLB19smv2j0Z/mRsdmv/AQc/OQDt1002Tl5Js=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8374.eurprd04.prod.outlook.com (2603:10a6:102:1bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Thu, 19 Oct
 2023 15:02:19 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 15:02:18 +0000
Date:   Thu, 19 Oct 2023 11:02:10 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, joe@perches.com, linux-i3c@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        imx@lists.linux.dev, jirislaby@kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/5] i3c: add slave mode support
Message-ID: <ZTFE8hrRgPBrb7e3@lizhi-Precision-Tower-5810>
References: <20231018215809.3477437-1-Frank.Li@nxp.com>
 <20231018215809.3477437-2-Frank.Li@nxp.com>
 <dd06c2d3-e273-4356-835b-42619543dfab@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd06c2d3-e273-4356-835b-42619543dfab@linaro.org>
X-ClientProxiedBy: BYAPR11CA0094.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::35) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: ca83ba9f-c26a-4c53-aba7-08dbd0b463a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JqDJVxr77eDij4wIzFZlnHIqgn7zPsOi+UsHzwOOcV1W9QsaGcme2GCupN4hY2Br15yCATaBb8/7dSBvmV6H27v7f3eSD8W7nkOiqM0+e3rakSla9v4Fyj/wMKUv6tzXK+T/eOgNQfsk0oJ1tDGXespHB3AGN2lUQZHWWJ/YZw8IbE6d1qw2rzxwNlqJT/RApOvvBvpyYHWTPrPjrq00jMsb0Oc73Wea5CpL/90hZoBHq4OaqMR5uX3H/dPqzrUyE1BthVAx/8YHE797V9tpgFsJ9eufcTO8/tacgR7lR30mrV0xnLop4lCvbQo1WB6x4t306IUgtE4B2WuG9SNWi+QGCs8uD33jpFgpXCar2VRjEWZ53U+b1Hu/M/tIknELuwFxhTLe/DyZipqrZu1SbZbzuZGhzAGgI10abjZCWCOkAeH/AetlG6jie7ImvyCLEuI/2p/6awyc4jvCITD159E9Z6CngnC7Ty0Ti0VcthIglvSCwvClkJmRd4vmKttda05ABXXb71+n+AxVqi6yZuTp3gYgs0DDOV6KxzF6smQoXy/BF9uSJ8Ytn2R7Jw+yGyXyv7mZwxa2VHjLtZMWytXzZMXsOFwBpOq4u41VI2mF2P8WrWsypTWpNWW2O3Vr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(316002)(38350700005)(6486002)(6916009)(478600001)(52116002)(2906002)(66476007)(66556008)(66946007)(8676002)(5660300002)(4326008)(41300700001)(26005)(6512007)(7416002)(9686003)(8936002)(33716001)(6506007)(86362001)(38100700002)(83380400001)(6666004)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y1uzen23AC68fy4M3SEOegkSnOs6VkSTF8R2/kM+CqkTjC1hCjXXQjq7k6Kk?=
 =?us-ascii?Q?zav6tlWxqO2DWtBaVH8/A3DADup5I6L8exowLXhBdRQs+5EtsGN+hc+QLKbw?=
 =?us-ascii?Q?G8IfqTToqEodokibRjOM4M0fZy3+iD3jfgdC/obSXQEsq2Q5dXjB6nOZpel4?=
 =?us-ascii?Q?f4fs+VERp3nGuk1VcWND8ALnNij+9S3umPpq3s6Ao5YAewIYa44JRvotqyf3?=
 =?us-ascii?Q?d/wdGkzySetNUJrH97NlmMC3sseZd63djsGOAlCp3vrnbdvfI8XgJTi2HDWm?=
 =?us-ascii?Q?kn39gZjCKmWi7nfGb0uEVH4wEDNe2wL4dcp6rVggBBUydLMNvjoT5CNRni5S?=
 =?us-ascii?Q?Yd9OpyxBprLE94LTi6TfsgvrKcxKfk9n6PkcGnD1zon5Kr0py6MnWpY49qSK?=
 =?us-ascii?Q?bx9ne+gZCYBlfVx3J7NdsJBgUFhCLSXfRuww8QdZcbQAhC9G5OnUFYM20R5u?=
 =?us-ascii?Q?3DDWIL3exM7fSSBfCUD23UOj+kiAa8iw6nh6XCqPlVNOrTJHU9HZQg7ug/UJ?=
 =?us-ascii?Q?Fv+ZKlPmjbLVJMAQSpvp3KGOfCriNgyMzFvSVcKBXaWmZw6muYxe3WCeYVtW?=
 =?us-ascii?Q?xMz7kc0BhU+VZbY1NQWZRw3j8EAjumhxpMEgC0kTWI/gWLc5QOrYiR7gMJz0?=
 =?us-ascii?Q?uhoHq5APSNlcCzD7Fp33ZezEGZ6wmrV4oBgpTHKhbfsk8Hqn2bXEgJioVMy5?=
 =?us-ascii?Q?rk/WMeeoTtRz6DDaqovSgBVKsbalrcSLw7BgDJJM99Tx6/CQwtVJ8cs/7anc?=
 =?us-ascii?Q?t4xafduIrqLzOquQiyg3SThdOuRYFEITYxCKTBAly0I2IqgrbOfrcV8oknXo?=
 =?us-ascii?Q?W5km1UZxp/rgNZeul6aNmpTHeE4BwKT0AqoDISHmW3JZU4PoSPVp1EgtioHO?=
 =?us-ascii?Q?Fn5ayv/7M+PL3HfZiyE9UYj2X6IwPF50NoPtzZY2DrbTWJ/+iSabgDFIgLvL?=
 =?us-ascii?Q?6wXx3PO1u+dDrBYL/WOtb4NAsny8ZDRgtmRjPLQKwZCQ+zL1EPT7qGChTZEO?=
 =?us-ascii?Q?qVEEv++feVdrxma8HcjDIe8j2AAAIiXQF1+EyZThx2kcszrY59zkXfKNQRiS?=
 =?us-ascii?Q?5kFPHUcxuq37azP3iC5wo7/blFUTe7ETtA8WISPsOrpAd+SFYk4eHD4RhlpJ?=
 =?us-ascii?Q?nTclptrZeQVjzw6BEOVFcTNf0KMBmIm3kGNs9+gdEKM057pyWruTQv912VlG?=
 =?us-ascii?Q?tkITRqxJ4fVq2zbHOjiy0fIkOW5Jtqj0zT/hZP8b+HJ17VnKWaUmPn9Ss2Pc?=
 =?us-ascii?Q?KmgussQDnkwENjuWUzTyOWFWG59ELrIEoPlHojd4Hg73XYUI2/vWkmNDPPAo?=
 =?us-ascii?Q?Y9JAoAJiD5gp4UUDyydmNEwV1Lu8+LOvud1ojJWRMSL+QcYXw+OOGdzH5+Am?=
 =?us-ascii?Q?92x7eICqVE+2E0SlK1TH6yc5RYB9FVUNLCnSPoN3soKOpyHsKK41z4/nw7VX?=
 =?us-ascii?Q?71IV8o8FHEEcyL6lV82mK9knaWEbTkU4WJVQp6mHvxcitxiH21nBBOYZpOsi?=
 =?us-ascii?Q?jzIAhTWNMdJ1Yfz7yCw+OeUqy17B6TZB9E2yyMfSoNOE+Rf/s8a2dmWFs+bU?=
 =?us-ascii?Q?XBUzIQhd4OnYucK6kriDfzGg9gsSYKKysJC4PQBf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca83ba9f-c26a-4c53-aba7-08dbd0b463a1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 15:02:18.8986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXICP/9WotQ3LOcKdW+EXuKigcII7J8u7PVCQrzHlyh0h5bpvxXfi0Lpbtl4diuz6mi+dEsJU+/0+XAXFnYRuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8374
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 09:00:05AM +0200, Krzysztof Kozlowski wrote:
> On 18/10/2023 23:58, Frank Li wrote:
> > Introduce a new slave core layer in order to support slave functions in
> > linux kernel. This comprises the controller library and function library.
> > Controller library implements functions specific to an slave controller
> > and function library implements functions specific to an slave function.
> > 
> > Introduce a new configfs entry to configure the slave function configuring
> > and bind the slave function with slave controller.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/i3c/Kconfig       |  26 ++
> >  drivers/i3c/Makefile      |   2 +
> >  drivers/i3c/i3c-cfs.c     | 389 +++++++++++++++++++++++++++++
> >  drivers/i3c/slave.c       | 453 ++++++++++++++++++++++++++++++++++
> >  include/linux/i3c/slave.h | 503 ++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 1373 insertions(+)
> >  create mode 100644 drivers/i3c/i3c-cfs.c
> >  create mode 100644 drivers/i3c/slave.c
> >  create mode 100644 include/linux/i3c/slave.h
> > 
> > diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
> > index 30a441506f61c..d5f5ca7cd6a56 100644
> > --- a/drivers/i3c/Kconfig
> > +++ b/drivers/i3c/Kconfig
> > @@ -22,3 +22,29 @@ menuconfig I3C
> >  if I3C
> >  source "drivers/i3c/master/Kconfig"
> >  endif # I3C
> > +
> > +config I3C_SLAVE
> 
> It doesn't look like you follow Kernel naming convention (see coding style).

I checked I3C spec. It use words 'target'.
Is it okay using I3C_TARGET?

> 
> > +	bool "I3C Slave Support"
> > +	help
> > +	  Support I3C Slave Mode.
> > +
> 
> 
> 
> Best regards,
> Krzysztof
> 
