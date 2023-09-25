Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED8C7ACEC5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 05:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjIYDsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 23:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIYDsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:48:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A12C4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 20:48:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5967C433C7;
        Mon, 25 Sep 2023 03:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695613690;
        bh=N9YN8yvWUu5bJE449R+s7OWZGf1tjMvTC1VKVEF1vxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bWdBYL4Gb+HynMG9dcAzIuguWZbw0DFNPnEn86GHAxUjC9GAJdJ+zVE6Ghc26R24k
         3tCq/Eecw1zt52xsRtgjOUSjOY7t3JBnvF1BRSzjpcVgmAlWUp+/DCdIiEjsdN1hAp
         TA85c6sGouCEViVIMVEZWXKiovnW50EnQ/206MIQn+R3E0WnqmZhTlLLZzVClud7E9
         /rSoIXDlpQDZeBFNWCvrOEllwBpCA/aMslZI9HMaSodUgS+oSD8pYzKhswMzq5nbfb
         6sPF4OyUVzmC1k5YghJYB2sZfxHdm8FqxpqZEVO1SAJ6rDaOuMZbixqeLmO89pZ8fi
         BFMjmvfjnu7CA==
Date:   Mon, 25 Sep 2023 11:47:55 +0800
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
        Marco Felsch <m.felsch@pengutronix.de>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 1/3] dt-bindings: arm: fsl: Add VAR-SOM-MX6 SoM with
 Custom Board
Message-ID: <20230925034755.GK7231@dragon>
References: <20230921055611.1459374-1-james.hilliard1@gmail.com>
 <20230925033344.GH7231@dragon>
 <CADvTj4qWHzjvp6BYarHWF2R=gRqD6WdLt4EhbEx93nu3up6=kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4qWHzjvp6BYarHWF2R=gRqD6WdLt4EhbEx93nu3up6=kA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 09:40:55PM -0600, James Hilliard wrote:
> On Sun, Sep 24, 2023 at 9:34 PM Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Wed, Sep 20, 2023 at 11:56:06PM -0600, James Hilliard wrote:
> > > Add support for Variscite i.MX6Q VAR-SOM-MX6 SoM with Custom Board.
> > >
> > > Cc: Pierluigi Passaro <pierluigi.p@variscite.com>
> > > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> >
> > Applied all, thanks!
> 
> Just verifying, you applied my v10 and not my v9 right?
> https://lore.kernel.org/all/20230924044800.2199524-1-james.hilliard1@gmail.com/

Oh, I will replace with v10.  Two suggestions for the future posting:

- For version that has no further review comments and just gets
  deprecated by yourself, please reply to let maintainer know.

- Have a change log telling what's been changed for each new version.

Shawn
