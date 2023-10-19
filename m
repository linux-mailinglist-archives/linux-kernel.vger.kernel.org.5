Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55027CF0F0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344844AbjJSHSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjJSHSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:18:43 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7839F;
        Thu, 19 Oct 2023 00:18:41 -0700 (PDT)
Received: from p200300ccff1c8300db3b230b99381d47.dip0.t-ipconnect.de ([2003:cc:ff1c:8300:db3b:230b:9938:1d47] helo=akair)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qtNIj-005BiP-OC; Thu, 19 Oct 2023 09:18:37 +0200
Date:   Thu, 19 Oct 2023 09:18:35 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     bcousson@baylibre.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, tony@atomide.com
Subject: Re: [PATCH v4 4/5] clk: twl: add clock driver for TWL6032
Message-ID: <20231019091835.6d8df469@akair>
In-Reply-To: <8c63372175266d42efbfca0104e19a14.sboyd@kernel.org>
References: <20230916100515.1650336-1-andreas@kemnade.info>
        <20230916100515.1650336-5-andreas@kemnade.info>
        <8c63372175266d42efbfca0104e19a14.sboyd@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 18 Oct 2023 18:20:22 -0700
schrieb Stephen Boyd <sboyd@kernel.org>:

> Quoting Andreas Kemnade (2023-09-16 03:05:14)
> > The TWL6032 has some clock outputs which are controlled like
> > fixed-voltage regulators, in some drivers for these chips
> > found in the wild, just the regulator api is abused for controlling
> > them, so simply use something similar to the regulator functions.
> > Due to a lack of hardware available for testing, leave out the
> > TWL6030-specific part of those functions.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---  
> 
> Did you want me to pick this up in clk tree?
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> 
Well, Lee has picked up 1-3 of this series, so I think it is a good idea
if you take it. I do not think it will make things any easier if it goes
through Tony's tree because part 5 is a bit tricky.
If picked up independently (of the whole set and not only part 4), there
will be a range of commits were WLAN will not work at all instead of
basically working randomly by the clock is enabled for some reason (can
happen if warm-booted from the vendor kernel).

So IMHO for part 5 we have to decide wether to decide if above is
considered to break bisectability and take the patch for 6.8 or
ignore that and take it for 6.7.

But no matter how we decide, that should not affect the route for this
part 4. So it is a good idea to have it through the clk tree.

Regrads,
Andreas
