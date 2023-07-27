Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460A476588E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbjG0QXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjG0QX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:23:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21540272C;
        Thu, 27 Jul 2023 09:23:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB73061ED9;
        Thu, 27 Jul 2023 16:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2339BC433C7;
        Thu, 27 Jul 2023 16:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690475004;
        bh=TD7vS16IIuUgR5cYQWuElvIIyOIASC8KrZH5mzivc8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NRAPajPHZHEkFEPS1peqox5tcJ7gM95Aa0aCNJgFLnZh76ZjtnFkuBVcnz2VozH3h
         qZDfeOyYsA4/tOhwZThD1Yql5NWDQyNp3Pj1ax0nmxIR4WnyLuATCbodU9ujfYW53u
         MCszD3oMGFT7emm3YOylZbPm+wk5j2slsAyhcAOJ65sBLz7/OOsnRbCh4xJ/DUq0Ky
         1tUlP9y7qi5KYE8aTkRm3LfNM0NvGsiHz4fenNnLWpEz+bnaYoolNpKOn9yy/Jt44z
         KwzX063DR7Y6SVY/+O7/Thx5Q5WG3hSSTpNkAXQLqX3mQEFEWksyReUFvFNGZxE/06
         Kp2Bh1KU3ydlA==
Date:   Fri, 28 Jul 2023 00:11:46 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Xi Ruoyao <xry111@linuxfromscratch.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/8] Add Sipeed Lichee Pi 4A RISC-V board support
Message-ID: <ZMKXQpreSr47MFj6@xhacker>
References: <20230617161529.2092-1-jszhang@kernel.org>
 <c9a44f534071a6d67f1e21bafdb713793c559124.camel@linuxfromscratch.org>
 <20230725-unheard-dingy-42f0fafe7216@wendy>
 <ZL/jMYL3akl78ZZN@xhacker>
 <3e0994dab495920ac590dc28d6b9d9765abe0c7e.camel@linuxfromscratch.org>
 <ZME1J4mpVf5yth32@xhacker>
 <866eab3e30a18c50742a75d62aee223fdc7e3cee.camel@linuxfromscratch.org>
 <4986b92f1a5aa303a529c6004aaedd2184c3ccf7.camel@linuxfromscratch.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4986b92f1a5aa303a529c6004aaedd2184c3ccf7.camel@linuxfromscratch.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 08:54:59AM +0800, Xi Ruoyao wrote:
> On Thu, 2023-07-27 at 08:14 +0800, Xi Ruoyao wrote:
> > On Wed, 2023-07-26 at 23:00 +0800, Jisheng Zhang wrote:
> > > which dts r u using? see below.
> > > 
> > > > 
> > > > Or maybe my toolchain (GCC 13.1.0, Binutils-2.40, with no patches) can
> > > > miscompile the kernel?
> > 
> > /* snip */
> > 
> > > > Boot HART ID              : 0
> > > > Boot HART Domain          : root
> > > > Boot HART Priv Version    : v1.11
> > > > Boot HART Base ISA        : rv64imafdcvx
> > > 
> > > what? I don't think the mainline dts provide v and x. 
> > 
> > I copied the compiled arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dtb
> > into /boot and loaded it with u-boot "load" command onto 0x46000000, and
> > passed this address to the booti command.
> > 
> > But maybe I've copied the wrong file or made some other mistake... I'll
> > recheck.
> 
> Hmm, and if I read OpenSBI code correctly, this line reflects the
> content of the misa CSR, not the DT riscv,isa value.
> 

Aha indeed the "vx" isa extensions are not from the DT riscv,isa
property. I will try your opensbi/linux/uboot combinations on my
lpi4a board tomorrow.

> The log of successful boot provided by Drew also contains
> "rv64imafdcvx":
> 
> https://gist.github.com/pdp7/23259595a7570f1f11086d286e16dfb6
> 
