Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B0A75E5E1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 02:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjGXAfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 20:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGXAfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 20:35:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96B4AD;
        Sun, 23 Jul 2023 17:34:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74BF760E17;
        Mon, 24 Jul 2023 00:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE299C433C7;
        Mon, 24 Jul 2023 00:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690158898;
        bh=gNbXnPpBgxiMLCQuNJ6rOoa/K4zGpmwvusnAIl/7MSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZYKx2OImxZFo4lkaeunx7/EG7kTr784+++JA/r9PeQx7HWhGJf8M/vPLIemqBjWZX
         v8K9Q53GL4Id2bgkEv0xC6cOsr8iQd1eiCVXrTNgHqUbBNver/56/pJ1OkTVnU9rZr
         RB/8y+NTv3qNxfl08rYb4G9E0s4I/fsFBo1rEJcUwJiIMCelfajiqtPR6fVX04p5xk
         HGZ+DT7X37dessczfkDfgep2OlYR3zgM8EEYww8HF6VZ0IHAwCSVyeStmbydPaAGSs
         TJIah1vVTZsIcol27zQniXRfkOfnuSRsxuhpSazcRjE73lvtrpNc+QRpaUwdv4qZMw
         QBf36FXl7Krrg==
Date:   Mon, 24 Jul 2023 08:23:22 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Conor Dooley <conor@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>
Subject: Re: [PATCH 1/3] riscv: dts: thead: add BeagleV Ahead board device
 tree
Message-ID: <ZL3Eenj4lGZDhZTM@xhacker>
References: <20230722-upstream-beaglev-ahead-dts-v1-0-ccda511357f4@baylibre.com>
 <20230722-upstream-beaglev-ahead-dts-v1-1-ccda511357f4@baylibre.com>
 <20230723-savor-trolling-e35ed4a7a751@spud>
 <ZL1jlacHj7sgNg8M@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZL1jlacHj7sgNg8M@x1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 10:29:57AM -0700, Drew Fustini wrote:
> On Sun, Jul 23, 2023 at 11:32:17AM +0100, Conor Dooley wrote:
> > On Sat, Jul 22, 2023 at 02:55:39PM -0700, Drew Fustini wrote:
> > 
> > > +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > > @@ -0,0 +1,61 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > 
> > Hmm, should this not be dual licensed?
> > I notice the other th1520 stuff isn't either..
> 
> Good point, I'll resubmit with a dual license.
> 
> Jisheng: are you okay with the other arch/riscv/boot/dts/thead files
> changing to a dual license?

When cooking the initial patch, I wrote the lpi4a dts files from
scratch based on sipeed opened sch file, and currently only I made
contributions to them, so it's easy to make the lpi4a dts files
dual license.

However, when constructing the th1520.dtsi, I refered the T-HEAD's
opensourced yocto repo(in fact, that's the only sourcecode/doc I have
at that time), and the license there is GPL-2.0. That's
also the reason why copyright of Alibaba Group Holding Limited is
added to th1520.dtsi. I'm not sure how to make th1520.dtsi dual
license. At least, this needs help from Guo Ren. Any suggestion is
appreciated.

> 
> > 
> > 
> > > +	memory@0 {
> > > +		device_type = "memory";
> > > +		reg = <0x0  0x00000000  0x1 0x00000000>;
> > 
> > There's some extra spaces in here for some reason.
> 
> Thanks for spotting that. I'll fix when I resubmit with dual licnese.
> 
> Drew
