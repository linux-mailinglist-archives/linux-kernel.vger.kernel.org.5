Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09DF7FC431
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346560AbjK1TVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346555AbjK1TVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:21:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE1819AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:21:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59392C433C7;
        Tue, 28 Nov 2023 19:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701199316;
        bh=dqrIyDGjRE0cy2kui/mwwdo0TB8vMyo0PwbLt9DYQUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=apcQMQvKcvpQiO9Kl8uqaLIJ7uGEMWIvqzADtzYUnwpUJviEGVL3zckQlPyJv2Djb
         Vy4P8ptpNyWbaacJtiMPQHAVFNY9DAK/k6jQ2I7y74yVTFEmS6wc9+LU3How9q0nJL
         HUZPaAAM250jBNH3CjTCGmTyWFpG7Qgz0d56xXOA=
Date:   Tue, 28 Nov 2023 19:21:54 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v5 4/5] tty: Add SBI debug console support to HVC SBI
 driver
Message-ID: <2023112849-reputable-outbreak-bb96@gregkh>
References: <20231124070905.1043092-1-apatel@ventanamicro.com>
 <20231124070905.1043092-5-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124070905.1043092-5-apatel@ventanamicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 12:39:04PM +0530, Anup Patel wrote:
> From: Atish Patra <atishp@rivosinc.com>
> 
> RISC-V SBI specification supports advanced debug console
> support via SBI DBCN extension.
> 
> Extend the HVC SBI driver to support it.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/tty/hvc/Kconfig         |  2 +-
>  drivers/tty/hvc/hvc_riscv_sbi.c | 37 ++++++++++++++++++++++++++-------
>  2 files changed, 31 insertions(+), 8 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
