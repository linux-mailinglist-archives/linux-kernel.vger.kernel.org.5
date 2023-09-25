Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0097ACED0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 05:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjIYDzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 23:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIYDzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:55:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647DAE8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 20:55:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E19AC433C7;
        Mon, 25 Sep 2023 03:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695614100;
        bh=sFDUVTld+wLrRGA8kSPjstZBYcXz1u/THaVhZN78kJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LDqqQthfBeA2tOZ/hhVddpYxYijZQx7fJLdwhIfnhDZbf10yM28ufwW/bx84cBGCw
         BlPwFOGH8IO8OU5CPAYOcTvIpPbb9UgaYdvoB5uojGHJmYK3T07JwKCoIISPRxAyIf
         J8dC1MTZs9ow966Zr45iJGLjpDOTK0kLdp1++J83uGOd5Asz/Y+UPqa19/++AnBFVz
         E6f/nndGqHyy3D9pwr47h7hW4VNPNjaE3i4KfzqEUIJRoVuBnhFrVSa4SbPMu3puA3
         1XNNVUnQJXcU3fe2IPsI5xMern8H3lvolp4lyfc9lyDaKM+D1/JZrXwWo73Ux/izeR
         HhNVLxwB8zUEg==
Date:   Mon, 25 Sep 2023 11:54:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 1/3] dt-bindings: arm: fsl: Add VAR-SOM-MX6 SoM with
 Custom Board
Message-ID: <20230925035445.GN7231@dragon>
References: <20230924044800.2199524-1-james.hilliard1@gmail.com>
 <20230925035036.GL7231@dragon>
 <CADvTj4oz6oJ_ifLO83JhaAnjmbLM=hTPmFG4S3h_TBnUeZrC=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4oz6oJ_ifLO83JhaAnjmbLM=hTPmFG4S3h_TBnUeZrC=Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 09:52:59PM -0600, James Hilliard wrote:
> On Sun, Sep 24, 2023 at 9:50 PM Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Sat, Sep 23, 2023 at 10:47:55PM -0600, James Hilliard wrote:
> > > Add support for Variscite i.MX6Q VAR-SOM-MX6 SoM with Custom Board.
> > >
> > > Cc: Pierluigi Passaro <pierluigi.p@variscite.com>
> > > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> >
> > So what's been changed between v9 and v10?
> 
> I had forgotten to add uart3/pinctrl_uart3 in this patch:
> https://lore.kernel.org/all/20230924044800.2199524-3-james.hilliard1@gmail.com/

Ok, applied v10 instead.
