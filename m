Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0C6785B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbjHWOwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbjHWOwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:52:14 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D2CE6A;
        Wed, 23 Aug 2023 07:52:09 -0700 (PDT)
Received: from p5dcc3441.dip0.t-ipconnect.de ([93.204.52.65] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qYpDF-002xEG-Kp; Wed, 23 Aug 2023 16:52:01 +0200
Date:   Wed, 23 Aug 2023 16:51:59 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     bcousson@baylibre.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, mturquette@baylibre.com,
        robh+dt@kernel.org, tony@atomide.com
Subject: Re: [PATCH 2/3] clk: twl: add clock driver for TWL6032
Message-ID: <20230823165159.108875d0@aktux>
In-Reply-To: <a65a7d976be4212ef71fe32c4ed2dacb.sboyd@kernel.org>
References: <20230819134147.456060-1-andreas@kemnade.info>
        <20230819134147.456060-3-andreas@kemnade.info>
        <a65a7d976be4212ef71fe32c4ed2dacb.sboyd@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023 15:34:59 -0700
Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Andreas Kemnade (2023-08-19 06:41:46)
> > diff --git a/drivers/clk/clk-twl.c b/drivers/clk/clk-twl.c
> > new file mode 100644
> > index 0000000000000..deb5742393bac
> > --- /dev/null
> > +++ b/drivers/clk/clk-twl.c
[...]
> > +
> > +static struct platform_driver twl_clks_driver = {
> > +       .driver = {
> > +               .name = "twl-clk",
> > +               .of_match_table = twl_clks_of_match,
> > +       },
> > +       .probe = twl_clks_probe,
> > +       .remove_new = twl_clks_remove,
> > +};
> > +
> > +module_platform_driver(twl_clks_driver);
> > +
> > +MODULE_DESCRIPTION("Clock driver for TWL Series Devices");
> > +MODULE_ALIAS("platform:twl-clk");  
> 
> This alias is unnecessary?
> 
The question is whether this driver should have a separate dt
node (and if a separate node, then one per clock as the clk-palmas
driver) or not. See Rob's review of the binding document.
So we have basically #clock-cells = <1>; in the twl parent
and a call to mfd_add_device() there in the former case and I guess
that alias is needed then.

But if the overall structure stays as in this version,
then I doubt that we need that alias.

Regards,
Andreas


