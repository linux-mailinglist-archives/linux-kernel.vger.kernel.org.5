Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B78B781DC7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 14:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjHTMSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 08:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjHTMSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 08:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A156C19AE;
        Sun, 20 Aug 2023 05:16:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35C0B618C5;
        Sun, 20 Aug 2023 12:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB45C433C8;
        Sun, 20 Aug 2023 12:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692533765;
        bh=Q2Gb7Zw4uMgI1awBfHQLxQO4w229GHAJOp+Sw2N0vS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q5PShadJGkC4dSLdtBvX8zU1e+bcpwrx0dXYnWlhjqbqlbPZetHs0UozEWi4CiovB
         qcPX2JSnSyte4oVd40vrGeFv01yfn+zbkbVWarzz3OxTk46cHtHb3OL7LYNzYwMa49
         +G0kBWQMZMUFm3UJwIT4aD70NifYi9uFksn3hTdf3if/iQgsg9BynJ2Dps2fUXrpKK
         FdFf3UcxD+XKu/f2ocizUOi6WKKfanZ4UaGKnC16nvEWLTek8flEhbqNBSuYVVSmlI
         gnuPVMcMuqc3cHHgl7mcVqkTxGuo41Z2tkYZaVOB/IKBg8s0l5WZAfuLI4nrKlIe3l
         amO9rnEiFrvKA==
Date:   Sun, 20 Aug 2023 20:04:16 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: thead: set dma-noncoherent to soc bus
Message-ID: <ZOIBQI3L4kP7c/T1@xhacker>
References: <20230820115353.1962-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230820115353.1962-1-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 07:53:53PM +0800, Jisheng Zhang wrote:
> riscv select ARCH_DMA_DEFAULT_COHERENT by default, and th1520 isn't
> dma coherent, so set dma-noncoherent to reflect this fact.

correct typo in linux-riscv maillist addr
Add linux-riscv, sorry.

> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> index 56a73134b49e..58108f0eb3fd 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -139,6 +139,7 @@ soc {
>  		interrupt-parent = <&plic>;
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> +		dma-noncoherent;
>  		ranges;
>  
>  		plic: interrupt-controller@ffd8000000 {
> -- 
> 2.40.1
> 
