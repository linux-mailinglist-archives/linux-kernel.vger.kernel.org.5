Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5527378B551
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjH1QYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjH1QYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:24:21 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6999CE3;
        Mon, 28 Aug 2023 09:24:16 -0700 (PDT)
Received: from p5dcc30c7.dip0.t-ipconnect.de ([93.204.48.199] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qaf2D-0036xV-Vr; Mon, 28 Aug 2023 18:24:14 +0200
Date:   Mon, 28 Aug 2023 18:24:12 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, bcousson@baylibre.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, tony@atomide.com
Subject: Re: [PATCH 2/3] clk: twl: add clock driver for TWL6032
Message-ID: <20230828182412.16d4aea6@aktux>
In-Reply-To: <9edcfc47-ed89-8074-6bde-d747ae73de25@linaro.org>
References: <20230819134147.456060-1-andreas@kemnade.info>
        <20230819134147.456060-3-andreas@kemnade.info>
        <a65a7d976be4212ef71fe32c4ed2dacb.sboyd@kernel.org>
        <20230823165159.108875d0@aktux>
        <9edcfc47-ed89-8074-6bde-d747ae73de25@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 24 Aug 2023 09:04:28 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> >>> +
> >>> +MODULE_DESCRIPTION("Clock driver for TWL Series Devices");
> >>> +MODULE_ALIAS("platform:twl-clk");    
> >>
> >> This alias is unnecessary?
> >>  
> > The question is whether this driver should have a separate dt
> > node (and if a separate node, then one per clock as the clk-palmas
> > driver) or not. See Rob's review of the binding document.
> > So we have basically #clock-cells = <1>; in the twl parent
> > and a call to mfd_add_device() there in the former case and I guess
> > that alias is needed then.
> >   
> 
> You should not need the alias in any of these cases. platform alias for
> platform driver means you have incomplete tables and use alias instead
> of tables. Preference is to use tables.

Is there a general consensus that MODULE_ALIAS("platform:.*") should be
exorcised? Of course for this new driver I will avoid it now anyways.

Regards,
Andreas
