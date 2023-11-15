Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1EF7EC764
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjKOPeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKOPeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:34:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09A5C2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:34:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31F7C433C7;
        Wed, 15 Nov 2023 15:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700062460;
        bh=liyVVxI+t71I+vY5uI83Hmd86EuxG1knRDKO8hE8oe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uk5xbh1Ykg0ULD8pxMCIhGDb1yfEo17ac6HO50HCdD6Ll+DweurC8oXNMTMk8tCLw
         fUMvNqVvTWKLVb3pHAxPFS9xGMepJRsElQLDUszpSv4mEp48DB9HCNv1dJuMnnEDNO
         uf2gbOIdN/2EWLGv9TZNZ+0VQW4VQMPpkVqpEghylPJNN1ac/wkjayiSoQaYdGGR3y
         XmzZxCgHLlIt0t0vl7Gs1vdj/9av4wR/qmTsxTnkudn632rXv+6SLSejnpB+UO4aFy
         eq2Kc8wWRpbfcL0sjBF/sP0VA1wZM5T8aRB2HtOyfqKsQ9qIPhk2P6ECUhVKoNiB2L
         BBBSLMZRacqWA==
Date:   Wed, 15 Nov 2023 23:21:57 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 5/7] riscv: dts: thead: Add TH1520 mmc controllers and
 sdhci clock
Message-ID: <ZVTiFVHSsBxk3pLH@xhacker>
References: <20231114-th1520-mmc-v6-0-3273c661a571@baylibre.com>
 <20231114-th1520-mmc-v6-5-3273c661a571@baylibre.com>
 <20231114-starring-swarm-0e1b641f888c@squawk>
 <ZVP1AoosripWj3gs@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZVP1AoosripWj3gs@x1>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 05:30:26PM -0500, Drew Fustini wrote:
> On Tue, Nov 14, 2023 at 09:27:44PM +0000, Conor Dooley wrote:
> > On Tue, Nov 14, 2023 at 04:07:59PM -0500, Drew Fustini wrote:
> > 
> > > +	sdhci_clk: sdhci-clock {
> > > +		compatible = "fixed-clock";
> > > +		clock-frequency = <198000000>;
> > > +		clock-output-names = "sdhci_clk";
> > > +		#clock-cells = <0>;
> > > +	};
> > 
> > If only you had a clock driver to provide these...
> > 
> > Is someone working on a resubmission of the clock driver?
> 
> Yangtao Li posted an initial revision back [1] in May but I don't think
> there has been any follow up. It is for sure something we need to have
> in mainline so I'll take a look at getting that effort going again.

Hi Drew,

Based on Yangtao's version, I cooked an updated version in last
development window but still can't complete it and met some issues
which need the clk/pll register document.
IIRC, the document was released a few days ago before soc tree frozen.

It's nice if you can continue the effort! I'll read the sdhci driver
soon.

Thanks
> 
> Drew
> 
> [1] https://lore.kernel.org/linux-riscv/20230515054402.27633-1-frank.li@vivo.com/
