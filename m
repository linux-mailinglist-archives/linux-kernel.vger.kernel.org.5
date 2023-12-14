Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E5C813675
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjLNQkM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Dec 2023 11:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLNQkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:40:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1446C114;
        Thu, 14 Dec 2023 08:40:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C741C15;
        Thu, 14 Dec 2023 08:41:01 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 866973F5A1;
        Thu, 14 Dec 2023 08:40:13 -0800 (PST)
Date:   Thu, 14 Dec 2023 16:40:10 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Brandon Cheo Fusi <fusibrandon13@gmail.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] cpufreq: sun50i: Add D1 support
Message-ID: <20231214164010.0be50a89@donnerap.manchester.arm.com>
In-Reply-To: <8351928.NyiUUSuA9g@archlinux>
References: <20231214103342.30775-1-fusibrandon13@gmail.com>
        <20231214103342.30775-3-fusibrandon13@gmail.com>
        <8351928.NyiUUSuA9g@archlinux>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2023 17:29:30 +0100
Jernej Škrabec <jernej.skrabec@gmail.com> wrote:

Hi,

> On Thursday, December 14, 2023 11:33:39 AM CET Brandon Cheo Fusi wrote:
> > Add support for D1 based devices to the Allwinner H6 cpufreq
> > driver
> > 
> > Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> > ---
> >  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > index 32a9c88f8..ccf83780f 100644
> > --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > @@ -160,6 +160,7 @@ static struct platform_driver sun50i_cpufreq_driver = {
> >  
> >  static const struct of_device_id sun50i_cpufreq_match_list[] = {
> >  	{ .compatible = "allwinner,sun50i-h6" },
> > +	{ .compatible = "allwinner,sun20i-d1" },  
> 
> This is not needed, as there is no functionality change.

That was my first reflex, too, but this is the *board* (fallback)
compatible, listed in the root node, so you have to list it here for each
SoC, together with the respective blocklist in the next patch.
We are doing the same for the H616, and actually also need that for the
H618. Weird, I know, but last time I check not easy to fix.

Cheers,
Andre
