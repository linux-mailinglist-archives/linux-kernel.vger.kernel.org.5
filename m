Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A727FC42F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376302AbjK1TVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344921AbjK1TVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:21:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E93DD66
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:21:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC03C433C7;
        Tue, 28 Nov 2023 19:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701199309;
        bh=8htSTgHJFHOtKB9pxw5uowuakEUSv1IwnvcjP3ifGKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OpkOieHlB8xbewmhWyPCtoFHzKuqW1Z9eevrRCNwsIhVdeI7vxe4Uq53LQmhNqrhg
         UdcYfFCNXq/ryRaie1RLR3iqwKvvlIWo/zdGy71i30oTgoMPnAzkiAW0D2+rHjP0dE
         xZ1q668XuZmNW0kEG6rzSgWQm0Rrr2Ai8RIpJpQg=
Date:   Tue, 28 Nov 2023 19:21:47 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] tty/serial: Add RISC-V SBI debug console based
 earlycon
Message-ID: <2023112839-antitrust-coherence-98d8@gregkh>
References: <20231124070905.1043092-1-apatel@ventanamicro.com>
 <20231124070905.1043092-4-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124070905.1043092-4-apatel@ventanamicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 12:39:03PM +0530, Anup Patel wrote:
> We extend the existing RISC-V SBI earlycon support to use the new
> RISC-V SBI debug console extension.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  drivers/tty/serial/Kconfig              |  2 +-
>  drivers/tty/serial/earlycon-riscv-sbi.c | 27 ++++++++++++++++++++++---
>  2 files changed, 25 insertions(+), 4 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
