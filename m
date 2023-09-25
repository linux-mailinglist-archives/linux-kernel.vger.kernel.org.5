Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825077ACEC7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 05:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjIYDu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 23:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIYDu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:50:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2CFDF
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 20:50:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B34BC433C8;
        Mon, 25 Sep 2023 03:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695613851;
        bh=J/H0pLYhyv22dSDz3MeuygaLpn1BS27NWVxMjjew6ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c4bXhVwMKmV5V7cfWmNzM5V9xuDJCkXl0jqK+7FUH4zv+Maq9DbrcjOH0L7uzgB1M
         F8oBku4cgtUltxXM84MikcwJ0+ZOXjcAIYAQWSiJ2uO6biAn5oIZ9H9m6ET+Hjd84j
         Gc4sscyFDfP8vTcaYPuzRq3G23JoBDay2+130/LDNV+mUTwq3F7k2YmWchF+d7dwrP
         kO1M8IdxD5VlWm8wE1ymvV/VJ2CqKswFwg4TSd+uSZZMc8OGGYJIFlnhQoQpVDQxyw
         uFrBhCVBg6/nlzavXbyyYLlENzkS5HaAkm5+/PDmsQ7ZkDDJ5jUZjkf1xZp3znFZ9k
         jQcllAU1BSobQ==
Date:   Mon, 25 Sep 2023 11:50:36 +0800
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
Message-ID: <20230925035036.GL7231@dragon>
References: <20230924044800.2199524-1-james.hilliard1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230924044800.2199524-1-james.hilliard1@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 10:47:55PM -0600, James Hilliard wrote:
> Add support for Variscite i.MX6Q VAR-SOM-MX6 SoM with Custom Board.
> 
> Cc: Pierluigi Passaro <pierluigi.p@variscite.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

So what's been changed between v9 and v10?

Shawn
