Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA7A760DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjGYJAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjGYI76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:59:58 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29B0EBD;
        Tue, 25 Jul 2023 01:59:53 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qODtS-0008Gv-00; Tue, 25 Jul 2023 10:59:46 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 1D79DC01F0; Tue, 25 Jul 2023 10:48:40 +0200 (CEST)
Date:   Tue, 25 Jul 2023 10:48:40 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        John Crispin <john@phrozen.org>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Explicitly include correct DT includes
Message-ID: <ZL+MaK820fzdfw+5@alpha.franken.de>
References: <20230714174028.4040093-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714174028.4040093-1-robh@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 11:40:27AM -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/mips/bmips/setup.c               | 1 -
>  arch/mips/cavium-octeon/flash_setup.c | 3 ++-
>  arch/mips/lantiq/irq.c                | 2 +-
>  arch/mips/lantiq/xway/dcdc.c          | 3 ++-
>  arch/mips/lantiq/xway/gptu.c          | 4 ++--
>  arch/mips/lantiq/xway/sysctrl.c       | 1 -
>  arch/mips/lantiq/xway/vmmc.c          | 3 ++-
>  arch/mips/pci/pci-lantiq.c            | 4 ++--
>  arch/mips/pci/pci-rt2880.c            | 5 ++---
>  arch/mips/pic32/pic32mzda/config.c    | 1 -
>  arch/mips/ralink/irq.c                | 2 +-
>  arch/mips/ralink/of.c                 | 2 +-
>  arch/mips/ralink/prom.c               | 2 --
>  13 files changed, 15 insertions(+), 18 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
