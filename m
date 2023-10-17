Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CB17CCDAC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjJQUOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjJQUOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:14:08 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2556FAF;
        Tue, 17 Oct 2023 13:14:07 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1e98e97c824so3607066fac.1;
        Tue, 17 Oct 2023 13:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697573646; x=1698178446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjtM0th7Ga0wqAkmHHke7zShNUXUXypfVS93GqDMmaU=;
        b=XS7SkYSiwMnENG4ROGp/EAoYKnN3dL0g2PAAFQa5r9SbbJfF3+807Zvd7zL/IEkAic
         J2P/LP+KtOD1Ep6Y/wogTD3O/NdB4movC86U2ZA2vUBnNBmPn5KTyENRIXFwYM22Tr+a
         SIi42vyloJhghteZJgJDiKtiUCINI0NDj2jS1wzwumEjYK92Qg8xZ19d5Q13LhQGCa21
         CqSEJinac+Y/dexm4UKu9vCU6lU+pPLdo8ymL+a1PEgm4aTynhxpPnQGhg7XOE4GLR8c
         +tB90hREkb4DE13/+mum8Npvz5yLzstRI/QSOkYkbbQUV0pK91g4K4R6n+7aPop9xRvP
         0jnQ==
X-Gm-Message-State: AOJu0YxmYGIYlcaWdAyWpKeLi/f9eFXXmmwWGAK/DaWHaEUqRDhXRpgG
        2OrLSNT+KBj863ZGyqSwDw==
X-Google-Smtp-Source: AGHT+IEsn7NyYyz1Bs7OZ8OxYl4q66dyjxMFogx3095CSeMhQzjqBlURuKu92JrCzVigMEE82ibKSw==
X-Received: by 2002:a05:6871:c17:b0:1e9:d481:52e9 with SMTP id ve23-20020a0568710c1700b001e9d48152e9mr1820295oab.28.1697573646610;
        Tue, 17 Oct 2023 13:14:06 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id lb5-20020a05687c330500b001cc9bc7b569sm394499oac.27.2023.10.17.13.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:14:05 -0700 (PDT)
Received: (nullmailer pid 2675575 invoked by uid 1000);
        Tue, 17 Oct 2023 20:14:04 -0000
Date:   Tue, 17 Oct 2023 15:14:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        joe@perches.com, peng.fan@nxp.com, alexander.stein@ew.tq-group.com,
        haibo.chen@nxp.com, ping.bai@nxp.com, xiaoning.wang@nxp.com,
        sherry.sun@nxp.com, linux-i3c@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH 2/2] arm64: dts: freescale: imx93: add i3c1 and i3c2
Message-ID: <20231017201404.GA2570433-robh@kernel.org>
References: <20231016152450.2850498-1-Frank.Li@nxp.com>
 <20231016152450.2850498-2-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016152450.2850498-2-Frank.Li@nxp.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 11:24:50AM -0400, Frank Li wrote:
> Add I3C1 and I3C2.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 26 ++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index 6f85a05ee7e1..4d9ed0b32853 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -242,6 +242,19 @@ tpm2: pwm@44320000 {
>  				status = "disabled";
>  			};
>  
> +			i3c1: i3c-master@44330000 {
> +				compatible = "silvaco,i3c-master";

The real problem here is not whether we have "v1" or not, but you need 
an SoC specific compatible. Unless there's a public spec where we can 
know exactly how many resets, clocks, interrupts, etc.

Rob
