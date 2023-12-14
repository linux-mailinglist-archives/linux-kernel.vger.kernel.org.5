Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D39F812539
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443035AbjLNCYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLNCYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:24:49 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E10FB7;
        Wed, 13 Dec 2023 18:24:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAvCklEDdIJKHjtsNZOyRo8qzdsc5Z2FIlLiJ8rmR83Vuih+uYDjoZc4GJu5fPgSoTXNGWZIDwNj7IAGSAsLkf9dfqFAExQ+nfZPsICwpVIWdIWIQGaanvio4DnmlXI+tl+4OeLGbxDpCa2w4BbYda6WhK+5yKecL5JFTGHwkBoxRimJ8e7VIYbsCb3xMuKUG1v/JEVvjfCHnh79y8zLX6z8OkSNTYpiLAqsWfmCnX0XLNBGQJXTOOhSwfCIfsDBCP1CxeJqXdwkgE/eI6N/plJ3jHBhumKX3Wk5rmK7FkHemzWuyVEBkCUIOpuo4S2l0JTshIrKMqGb8JV84lEIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYY8jUcaZGyQVRO3EW9u4/m/uqBq/MYTjYB3lWuS/4I=;
 b=lSaAFcRJea9djUI5bd48xGqULJKtK9CztMeS8mpjW0ayv8vj7VZrWE6pl3zCkbTgTpYmD/ZaDz2Ofo7nUDzI24w/jYPM1L8r0dGGyVNDzfSGmYTJELa11QZgKd7KlQkGD3aNchy2K0bPgkMi9pk2r8/ShPvomfrGEIUMyfurjsjXouuQnqOu9LXGJ5N7gMTviN+cCWCmHzffk+IAbiznPG/K8/OezNAf8/RFPmkbjdMG55i5kKL8LnIy3yI924wh5iJWGFjZvOiWwvNfPGcdfs4GiXYn/Ot73KXl1NuckOovoynEsnXsGkod+CnJIwO2RRCeLfSmb5bfJ+ORMxhTFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYY8jUcaZGyQVRO3EW9u4/m/uqBq/MYTjYB3lWuS/4I=;
 b=C3n91VwqQsuJa4cNdNfpeA4BYVBUAyZ8I2LeBIFq5Q4IRP9fl5jaDK08Ke7c/dc1hesu7TBghdpIiJAk5CHu0ywNjT4SeoV2K6+It7+UvXTE80A6A2mcC2yGyem7YTlDv2ex3adSGx2QRBAS/GblJvVfeaHBlDMX2wthEOrobsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SJ0PR08MB7836.namprd08.prod.outlook.com
 (2603:10b6:a03:403::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 02:24:51 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 02:24:51 +0000
Date:   Wed, 13 Dec 2023 20:24:46 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     Tomas Mudrunka <tomas.mudrunka@gmail.com>
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] Fix freeze in lm8333 i2c keyboard driver
Message-ID: <ZXpnbifDOQ/eF5jb@nixie71>
References: <ZF53JVcb8UJQFmfP@nixie71>
 <20231114123023.95570-1-tomas.mudrunka@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114123023.95570-1-tomas.mudrunka@gmail.com>
X-ClientProxiedBy: DM6PR12CA0003.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::16) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SJ0PR08MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8c102b-339c-4699-4dfe-08dbfc4bda00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LsginHNWle95bViK7Y9lBAP+eUWYyNMwO3hQMb+xnNVaUQqAZ2FbO2LOufZE0AGYWpTrrRwa0WKAbziB/1TSv4KSzduFkKTzWl4/4Jkw14KPjNdAe+CK/FyKa+oWNFCquxZ/T46XxuCT3a5O29u9zGlSQHX8PNjzbUOWyI/OhzmZn7RkMDcXKzELCeJk3uVgecDjqyr9M99AOacwn95Z/vsKA39qxHDA+hw9ZQvFbedT4fp04km8ZX8Q+LREKW68H3aOFs1uqBl5EYJqPq2j84H+4nAHXGqMD4QEJs6oiPMEezzWRqyLGka9MVY/msG0EFRMywan6Bn5Y1OoUI9yDfzkKTjfmbB6grWTN5djgcIJ0y7YtkS3OYmamLQeUk919it7QZs407gR+t0OYoEJ1+huAWMRJNMRv5Ry/eMVKYGkHERzA5XNtjbHzI+LbW3Uaj8bPtJeNXO9GJhFLFXnvAn40kFGNjtyOQk+TGh+a1JPd70U0bTciI86wshquVJBtpwqgOOyGkPFF0bqfYN6hYdJ5wT3FRrimb8RN97h3wAHCUq+vvGdc+50ywwrKtRm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(136003)(346002)(39830400003)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(316002)(8936002)(83380400001)(4326008)(6506007)(8676002)(6666004)(66946007)(6916009)(66476007)(66556008)(26005)(5660300002)(6486002)(9686003)(6512007)(478600001)(2906002)(38100700002)(86362001)(41300700001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7ZyDrTgTV6hiSabbr00726mz4dMXhTFzJxYThL4oj0mCP51G7RJg2eIvY4yT?=
 =?us-ascii?Q?x+Q/VIPrAa8/EkF3bHgwDf8ySfQpyRfXA7Jy+7HRFrmbX5/bHAxv2u49AQq/?=
 =?us-ascii?Q?6hTK6Z9xLMLrKHLonptooDEt+3trADSZreccpuwo5gaPqBDTqpnC0sp9TraV?=
 =?us-ascii?Q?AAU+5kgMUKmyUPoxF/p0H0ck6j7Uz/tw/iAJ+S4qJFjscSMjF7vc/rGRC2SM?=
 =?us-ascii?Q?aKspvlmG1s4D6LO6nbGZWU9FTZPMwEEdlIUQ1iGAwLrV/bh2uGzYVXo1LCkc?=
 =?us-ascii?Q?/pf/5EoAha37CCy1FO04pWMcVVMY3LDyuSuvy1PpN6D2E//G+p/5+zlnKDWL?=
 =?us-ascii?Q?Iv6r4MLf9Wvzy6rrBTa79RpD2kViyH0LZ9EDJY2lqKyW5Qj3/lq+t5pwVr/t?=
 =?us-ascii?Q?lwHxHS1kyg0ITznq+R0iGlK3Bhb+TaBDx2CxFTwnxDxdGNoldtXWFec6LkbL?=
 =?us-ascii?Q?2ssQnCm+4JjUiBQONUDOspuhNXvCENXgKCpC4/4h1QToZYRzNAz2T6a+oaLO?=
 =?us-ascii?Q?J5FvU2svI7FDvjQLykDFYEx+6PGZ4llflK+B9T09ucyS7ku9urpHaArv090x?=
 =?us-ascii?Q?T3BpHTHWa/jc/dI87APRcvZ1Nbw5qSP7O1vjlCkCUZBEIv8lkHny+LBoqTIZ?=
 =?us-ascii?Q?QMedk2Cck9+SFU6WKx07pGAlVimqr1wh43BVqg3p+PXCKRHP/RGrsfmuxoVi?=
 =?us-ascii?Q?ln4S5u059dpd6CeQZNWSVdrtA3UOCnoa5M30BmhlOgK3Vf0R+IovKcgv/UwA?=
 =?us-ascii?Q?WpNs25YpQRWPCT9YmI6bmEeNkJNtXM03OP2efMarA4nh80ybLwMLPzoJGJu7?=
 =?us-ascii?Q?X/TC/9QVPZHMnP4PpEWx7TxyTSjuiUbtvnjButPYOiJU3w4wsHD8SUWX1etv?=
 =?us-ascii?Q?bKNw+lh1voTDqB+iyU33GAkmdTxLH/CMm2UGuDATwbEvm5Dzcaah3qAxo7HA?=
 =?us-ascii?Q?ejv3ZvZgctKRyskywDkdOhbLS31Cwyhud+ZgCsHi2aRkMR7EdjpCkF1x4UKt?=
 =?us-ascii?Q?E3U8cdm7GO75+8tLIdhuHfQVkCgfCSTuboiZCcTwXy4yGfuiyNDM8nvXZg2h?=
 =?us-ascii?Q?mfyAFWwO4lMdegmayUEboryY23Ei2RaWxjrlbHffntU/HsNCdmVBUanjNOpy?=
 =?us-ascii?Q?o/9R1esrQgYWkFS0gtIZILJ1o+wGGenbsUzCpvHzFKPoQcEElUrN01qwFawf?=
 =?us-ascii?Q?5TInN5S8X4Jzg4Mw5ZvJhlLnJM2gInFrAcVXiRaCZbfEJbU0wD7rG9yo8AG3?=
 =?us-ascii?Q?ViVE46WhyeL/7D6LnRMbzRmzVArNkJoBTIHWC6gorMFVy0CTEL2UFVHj5RmO?=
 =?us-ascii?Q?4DA3MyokqnxpK0Y9oRR77IJaRy2Mraet4bgt82C7W9+U0TNihiMGBYFidavm?=
 =?us-ascii?Q?hTlFMzB9UEtN1bgDLxUE3Xum5IQDNqBMmEKRgbX8K7+LMrZV38Pjco720VQF?=
 =?us-ascii?Q?oRKLoOA2f7Ts5XKV1hGN7ilhOk9mk3MmDOHwHwBAqP1GuvkLotFG7+EdsBTc?=
 =?us-ascii?Q?5rqM/SGedpBmJeR8R8EMIQaopEr6baKK9NFQSVyXtTksFJnIrv41NtMnwevG?=
 =?us-ascii?Q?O4JhtExW5LMe0Q1BkVK85UKxr01mpewqrPHyGUqM?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8c102b-339c-4699-4dfe-08dbfc4bda00
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 02:24:51.4457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5NhFJcIqdIBlgkul8qVxEFeEPcZuHzG9QXftH8PN53KvTSyFNBsXsyZdK1CtYXm8TFalkCftvIspx/vXzPotw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB7836
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomas,

On Tue, Nov 14, 2023 at 01:30:23PM +0100, Tomas Mudrunka wrote:
> LM8333 uses gpio interrupt line which is active-low.
> When interrupt is set to FALLING edge and button is pressed
> before driver loads, driver will miss the edge and never respond.
> To fix this we should handle ONESHOT LOW interrupt rather than edge.
> 
> Rather than hardcoding this, we simply remove the override from
> driver by calling request_threaded_irq() with IRQF_TRIGGER_NONE flag.
> This will keep interrupt trigger configuration as per devicetree. eg.:
> 
> 	lm8333@51 {
> 		compatible = "ti,lm8333";
> 		interrupt-parent = <&gpio1>;
> 		interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
> 		...
> 	}
> 
> Signed-off-by: Tomas Mudrunka <tomas.mudrunka@gmail.com>
> ---
>  drivers/input/keyboard/lm8333.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
> index 7457c3220..c5770ebb2 100644
> --- a/drivers/input/keyboard/lm8333.c
> +++ b/drivers/input/keyboard/lm8333.c
> @@ -179,7 +179,7 @@ static int lm8333_probe(struct i2c_client *client)
>  	}
>  
>  	err = request_threaded_irq(client->irq, NULL, lm8333_irq_thread,
> -				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +				   IRQF_TRIGGER_NONE | IRQF_ONESHOT,

This seems like the best approach; it solves the original problem, and
adopts the correct design pattern of allowing the dts to specify details
about the interrupt polarity and sensitivity.

My only feedback is that I think you can simply drop IRQF_TRIGGER_FALLING
altogether instead of replacing it with IRQF_TRIGGER_NONE; it is pointless
to bitwise OR against zero, and almost no drivers do this. It really should
only be used unless there are quite literally no flags to use. Passing only
IRQF_ONESHOT is sufficient here.

Assuming you agree with this change, please feel free to add the following
for v7:

Reviewed-by: Jeff LaBundy <jeff@labundy.com>

>  				   "lm8333", lm8333);
>  	if (err)
>  		goto free_mem;
> -- 
> 2.40.0

Kind regards,
Jeff LaBundy
