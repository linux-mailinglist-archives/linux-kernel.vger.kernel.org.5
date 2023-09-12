Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFCA79D82A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237063AbjILRz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbjILRzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:55:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E511706;
        Tue, 12 Sep 2023 10:55:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44B9C433C7;
        Tue, 12 Sep 2023 17:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694541350;
        bh=NeiCnNPo3KOW64wUUmXZOw3OrKGWSoH40pjr74D8cEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ez4kU3Bb4kgBzNrxnsI6uBF3Wbe6qBzHTer7W/rvAOtyCbZZXAqCjiNwu4vIcrtHP
         NVWrkNFGSxlxU4tMObk8yF8Up3APTrZkI0M4U/H0EYSkGrSkp5Y1E6GSaLIZog7qs8
         i6/o1o4NGc3k5lIE0OTZcQ9HrYnvM5L3goYs3vhAPpM27X9vkCDI0QEu1UkJLp9LQ7
         VZ/wNuoGJznbyiQXOF2/JzFEvtyPhwPm2LPpRQ8vUyVDSSU8YEl8hrwwwwrw7s/Th2
         5Xhu6Lxn4Mq9ancHyaWbXTENfHCIkDkjjLHT5MUygJ9ZhFDEjArTscpYMxSm9zeEY1
         RyQ5Gm/d05jWA==
Received: (nullmailer pid 995268 invoked by uid 1000);
        Tue, 12 Sep 2023 17:55:47 -0000
Date:   Tue, 12 Sep 2023 12:55:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mmc@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v2 0/3] Change tuning implementation
Message-ID: <20230912175547.GA993874-robh@kernel.org>
References: <20230912081402.51477-1-william.qiu@starfivetech.com>
 <20230912081402.51477-4-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912081402.51477-4-william.qiu@starfivetech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 04:13:59PM +0800, William Qiu wrote:
> Hi,
> 
> This series of patches changes the tuning implementation, from the
> previous way of reading and writing system controller registers to
> reading and writing UHS_REG_EXT register, thus optimizing the tuning
> of obtaining delay-chain.
> 
> Changes v1->v2:

Please don't send new versions as a reply to the prior version.

> - Rebased to v6.6rc1.
> - Keeped "starfive,sysreg" in dt-bindings but removed from required.
> - Changed the function interface name.
> - Maked the code implementation more concise.
> 
> The patch series is based on v6.6rc1.
> 
> William Qiu (3):
>   dt-bindings: mmc: Remove properties from required
>   mmc: starfive: Change tuning implementation
>   riscv: dts: starfive: Drop unused properties and limit frquency
> 
>  .../bindings/mmc/starfive,jh7110-mmc.yaml     |   2 -
>  .../jh7110-starfive-visionfive-2.dtsi         |   4 +
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |   2 -
>  drivers/mmc/host/dw_mmc-starfive.c            | 137 +++++-------------
>  4 files changed, 44 insertions(+), 101 deletions(-)
> 
> --
> 2.34.1
> 
