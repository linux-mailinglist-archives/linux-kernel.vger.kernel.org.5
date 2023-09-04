Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28C5791A2B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351536AbjIDO5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjIDO5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:57:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4345BA9;
        Mon,  4 Sep 2023 07:57:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBB266181E;
        Mon,  4 Sep 2023 14:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9100C433C8;
        Mon,  4 Sep 2023 14:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693839460;
        bh=LzT88cWedePN3nB5J2c47sYH8nUB4YIGJS2wdUEWZYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zi3r8Ynel24Dp6pgSwbOvVKbbbfUNxLqMGQnpLVnWhRhiLD6b3brJ29S7rUAMQ1Qp
         InPp54qna5ff2I0nE1PfF17hPSM3DMbgejqKjXwMaZGWKMB+kwByXoxom3q2+0isK1
         XpF0tKQPVNsJWB4PXy8if25eUwjMOoE7uHKv0HJycIzVstvFBxCGDAgndwgZFcGDqf
         Tf/SgdafCTBRlEHBumfF0n4POTiwKtdV6NtOG4kupikBE3YLqYNIolPlZ/oa3FeBI2
         cW+goPDSSgH8ExT0G9pA8h8uY3TsNRf3l1b+NU8qRVw40SDahJIB35PAjEElpK4fLS
         0by1eZ7i9OyvA==
Date:   Mon, 4 Sep 2023 22:45:43 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        inux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: thead: set dma-noncoherent to soc bus
Message-ID: <ZPXtl1iWlsYwmixc@xhacker>
References: <20230820115353.1962-1-jszhang@kernel.org>
 <ZPUXhe7ogxvaB6Eg@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZPUXhe7ogxvaB6Eg@x1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 04:32:21PM -0700, Drew Fustini wrote:
> On Sun, Aug 20, 2023 at 07:53:53PM +0800, Jisheng Zhang wrote:
> > riscv select ARCH_DMA_DEFAULT_COHERENT by default, and th1520 isn't
> > dma coherent, so set dma-noncoherent to reflect this fact.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/riscv/boot/dts/thead/th1520.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> > index 56a73134b49e..58108f0eb3fd 100644
> > --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> > +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> > @@ -139,6 +139,7 @@ soc {
> >  		interrupt-parent = <&plic>;
> >  		#address-cells = <2>;
> >  		#size-cells = <2>;
> > +		dma-noncoherent;
> >  		ranges;
> >  
> >  		plic: interrupt-controller@ffd8000000 {
> > -- 
> > 2.40.1
> > 
> 
> Tested-by: Drew Fustini <dfustini@baylibre.com>
> 
> I tried this on the BeagleV Ahead. They system booted as expected and I
> did not notice any problems in the boot log.
> 
> Are there other patches such as the dwmac series that I should test this
> with?

Hmm, this patch is necessary to test dwmac, emmc ;)

> 
> Also, I think this might have missed patchwork since the original email
> had a typo for the list, so it might be good to resend it?

This patch was sent after sending PR to soc people, so it was late for
linux-6.6-rc1, but this patch is a fix, I may send it as a fix once
linux-6.6-rc1 is out.
