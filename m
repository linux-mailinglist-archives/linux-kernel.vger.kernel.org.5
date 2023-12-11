Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B3C80CE1F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344095AbjLKORw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343943AbjLKORj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:17:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22143A91;
        Mon, 11 Dec 2023 06:12:00 -0800 (PST)
Date:   Mon, 11 Dec 2023 15:11:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702303919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jZKIjBd21OWnGaJBiVOBN57bXhYz4xgeT/z9NbvImzs=;
        b=aqKeB+FIuovH58QJwNpR5zEZ0nfq4BxRJJZshJDFEW0lUoHNSJldnXl9gKcnvD0JwMsJa2
        rDVpKgsRA5FVdfg4ZsTmio8exgchy8EYcwzPCP4ByoOx/FYS0Vii2srPxmgtrxYjB8V2HN
        I9sC12MS3M1nKn2tTUjvbm9dQItpu4eooJexmkPl1uHGkq0pnQOuQC+vZUrKuIO9rDs5KJ
        kcAGcT6Z1huhwy4ZtMUswxlwPED7omMkTJ2gL9Ri6JVDozKGQkvlushfz5BPU4fgq9GqMe
        EV4m0AlK0m6tzC3dP8Z+OvuVxl4Yl4cJm5s78cK0Exp0v+2mVBd4zaABpC8EXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702303919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jZKIjBd21OWnGaJBiVOBN57bXhYz4xgeT/z9NbvImzs=;
        b=EYzIPVN3fD74DLanAmeKpYTZ7fMEQ22FjkrGo2fy9E24npcGG53tahRZlmShZJ51DbTTlW
        Elh5LyELGlEAWRAA==
From:   Nam Cao <namcao@linutronix.de>
To:     Andreas Schwab <schwab@suse.de>
Cc:     stable@vger.kernel.org, jiajie.ho@starfivetech.com,
        palmer@rivosinc.com, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Backport riscv kconfig for v6.6
Message-ID: <20231211151158.18de6a99@namcao>
In-Reply-To: <mvmwmtkq18l.fsf@suse.de>
References: <20231211145750.7bc2d378@namcao>
        <mvmwmtkq18l.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 15:10:02 +0100 Andreas Schwab <schwab@suse.de> wrote:

> On Dez 11 2023, Nam Cao wrote:
> 
> > Without this, it is not possible to configure the kernel with SPI drivers
> > for the Visionfive 2 board.  
> 
> Is it?  There is nothing that stops you from just enabling it.

config SPI_PL022
	tristate "ARM AMBA PL022 SSP controller"
	depends on ARM_AMBA

The "depends on" stops me.

Best regards,
Nam

