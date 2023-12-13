Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C6880AE70
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjLHU4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbjLHUzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:55:42 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCCA1720;
        Fri,  8 Dec 2023 12:55:47 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1faf46f96ebso1419806fac.1;
        Fri, 08 Dec 2023 12:55:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702068947; x=1702673747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMCsypl2ZT72XEQ1sjBx4SYxL9BLD+/SCpdSyBKF+9U=;
        b=xHpmDCtA9tRQ5lJQ1sEx/7MVTlTNPovbqqw5WAEoLNszUE+3IRc71TweNmo4XYWW/a
         3xTxxyXojVvADFQ2Y2WEAeWQhuATH+mcjBkvm/QUtwp+z1qbsxE68sA5qnwBPsVWM1gl
         42N33MsiP5JrDMg1DGYSaY45Hc7R7bpFl9/Alej8amThq7qyKTb4SosMdicKpMXmCpXU
         6fD1T6+9Pw7Zhuj7sL6VxluspUNJzTM5/E1ghEFEhzCiUrHfifcbscmyUMANflzITes6
         BqEvsBwO4gj7q8AXLyiMJm2c0oyBjW3rsA0i5j60KBzhIkOWSFldSuREV1ZcSC/wNR+U
         m4gg==
X-Gm-Message-State: AOJu0YyfSqWENmTMFobPO7jnurixXfi052VfzOFgpHhf2wJYLf7oam8w
        6f7VF+yQSSs6V1hKbb+T1w==
X-Google-Smtp-Source: AGHT+IEM3W8bj6pCSZdoh31Dhf5GcoLTyMBgsjsntSWQNdWLjtVS0QQY0sWp8TeQp0Rvl9Geo4c9xg==
X-Received: by 2002:a05:6871:a687:b0:1fb:75b:99b6 with SMTP id wh7-20020a056871a68700b001fb075b99b6mr800153oab.101.1702068946995;
        Fri, 08 Dec 2023 12:55:46 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r6-20020a9d7506000000b006ce2fce83cbsm445837otk.25.2023.12.08.12.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 12:55:46 -0800 (PST)
Received: (nullmailer pid 2687032 invoked by uid 1000);
        Fri, 08 Dec 2023 20:55:45 -0000
Date:   Fri, 8 Dec 2023 14:55:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Sherry Sun <sherry.sun@nxp.com>, hongxing.zhu@nxp.com,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: imx6q-pcie: Add host-wake-gpio property
Message-ID: <20231208205545.GA2675840-robh@kernel.org>
References: <20231208091355.1417292-1-sherry.sun@nxp.com>
 <20231208091355.1417292-3-sherry.sun@nxp.com>
 <83ca3d88cdaa7bc6e6bd3c4e88518b155a6b0f05.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83ca3d88cdaa7bc6e6bd3c4e88518b155a6b0f05.camel@pengutronix.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 11:00:19AM +0100, Lucas Stach wrote:
> Hi Sherry,
> 
> Am Freitag, dem 08.12.2023 um 17:13 +0800 schrieb Sherry Sun:
> > Add host-wake-gpio property that can be used to wakeup the host
> > processor.
> > 
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > index 81bbb8728f0f..944f0f961809 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > @@ -72,6 +72,10 @@ properties:
> >        L=operation state) (optional required).
> >      type: boolean
> >  
> > +  host-wake-gpio:
> 
> There is only one wake signal in PCIe and it has a defined direction,
> so there is no point in specifying that it is a host wakeup. Also GPIO
> handles without a traling 's' are deprecated. So this should be
> 
> wake-gpios

Any standard PCI slot signals need to be documented in common PCI 
schema. And they should start going into root port nodes rather than the 
host bridge node because it's the root ports that correspond to slots 
rather than the host bridge. We've just taken shortcuts because many 
host bridges only have 1 root port.

Note that I'm in the middle of splitting pci-bus.yaml into host bridge, 
PCI-PCI bridge (and RP), and common device schemas.

Rob
