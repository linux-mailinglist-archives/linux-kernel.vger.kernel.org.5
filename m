Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3D77C6F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343952AbjJLNc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347275AbjJLNcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:32:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BFBBE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:32:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C02BC433C9;
        Thu, 12 Oct 2023 13:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697117572;
        bh=ZZYhdnpgiENRM1+gW/Pd8plnr1hpMAWBo2o0iSfliZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GGOqHIgl+91RccrdW0Y93H+f5sYZ8tcCRAPCTsHHW9bgTNrGYg3T1er9zlL2i8IfF
         6/NARE2th7RDtUnbbhG1ZR2UvXeLiQDg4uN2arw79A5nGZIIiDz2r/3OrQRft2W1oC
         nU31cfkA0uqF4i1fYi91JPpE/5MA0DfT+nsS2JJf2d6LneifjHdFajva647tg50uyQ
         csFDl7evGenFjdYh+JlPxXMtxmOgRiiMhPywHi2AGj8RyN5jzz9u493MjkqrjXhJWO
         Y9iIUCYKF3+DL5hqoBWekq6jFNMiohkPyt2JpzHOwFjxGrLXI8L6e+H8ksuMpUSOk3
         gqO6IXUjH1NHw==
Date:   Thu, 12 Oct 2023 21:20:41 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Inochi Amaoto <inochiama@outlook.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/7] Add Huashan Pi board support
Message-ID: <ZSfyqaWsNh3mR26I@xhacker>
References: <IA1PR20MB49531C1C34C3E972DBBA4151BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49531C1C34C3E972DBBA4151BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 07:25:14PM +0800, Inochi Amaoto wrote:
> Huashan Pi board is an embedded development platform based on the
> CV1812H chip. Add minimal device tree files for this board.
> Currently, it can boot to a basic shell.
> 
> NOTE: this series is based on the Jisheng's Milk-V Duo patch.
> 
> Link: https://en.sophgo.com/product/introduce/huashan.html
> Link: https://en.sophgo.com/product/introduce/cv181xH.html
> 
> Changed from v1:
> 1. split the patch into several patch and refactor them.
> 
> Inochi Amaoto (7):
>   dt-bindings: interrupt-controller: Add SOPHGO CV1812H plic
>   dt-bindings: timer: Add SOPHGO CV1812H clint
>   dt-bindings: riscv: Add SOPHGO Huashan Pi board compatibles
>   riscv: dts: sophgo: Separate common devices from cv1800b soc
>   riscv: dts: sophgo: cv180x: Add gpio devices
>   riscv: dts: sophgo: add initial CV1812H SoC device tree
>   riscv: dts: sophgo: add Huashan Pi board device tree

For the patch series:
Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
> 
>  .../sifive,plic-1.0.0.yaml                    |  1 +
>  .../devicetree/bindings/riscv/sophgo.yaml     |  4 +
>  .../bindings/timer/sifive,clint.yaml          |  1 +
>  arch/riscv/boot/dts/sophgo/Makefile           |  1 +
>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi       | 95 +------------------
>  .../dts/sophgo/{cv1800b.dtsi => cv180x.dtsi}  | 91 ++++++++++++++----
>  .../boot/dts/sophgo/cv1812h-huashan-pi.dts    | 48 ++++++++++
>  arch/riscv/boot/dts/sophgo/cv1812h.dtsi       | 36 +++++++
>  8 files changed, 165 insertions(+), 112 deletions(-)
>  copy arch/riscv/boot/dts/sophgo/{cv1800b.dtsi => cv180x.dtsi} (58%)
>  create mode 100644 arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
>  create mode 100644 arch/riscv/boot/dts/sophgo/cv1812h.dtsi
> 
> --
> 2.42.0
> 
