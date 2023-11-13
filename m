Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E787E93EF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 02:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjKMBM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 20:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjKMBMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 20:12:25 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1625FD1;
        Sun, 12 Nov 2023 17:12:22 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1e9c9d181d6so2522722fac.0;
        Sun, 12 Nov 2023 17:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699837941; x=1700442741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BykRQa61TmxkQ2aJIQrB52hdaOo4yv0JvlCUuaXQp4E=;
        b=iwgIocclF+dstaKlsU3LsVFbiC45zoaAO8rZ6Zf/biBZthkZ9H55c00e3DLYebFiy7
         lzKFGWLq0JFKU/F+meljKWJvLJ40AOeblgVLva93eCIwUZCMuYg+18ybpYmDVy5fJYHX
         bJ+bP3ae5w4uNhlYRwTPMBp6Q5zv6pTE+oNZ3YyaE9Zo2miSLj85qs3AgrITiKVVgROO
         sb2b4iEsUNeouNH0ZpTwoMPcHNbU9OplmodH5j5tN0T86++Mt/uoY+G7S+UYs/4hD6RH
         beis23l+/2Kin5CRbkiaLEJVeHFdAiLYtgz6b6gDn+hBXMASkT3lmm5nLx/Srs63pz7p
         jQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699837941; x=1700442741;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BykRQa61TmxkQ2aJIQrB52hdaOo4yv0JvlCUuaXQp4E=;
        b=B3NBr+tctt+Ef2u8SUFAq23f41VQ8HyI3xUdg+12g3yTomq6063LZcRbZlmQEQyu51
         ibLDpbybsTbMVUrMY7k2E+EgPbJtlQoV+PpoUW6Uz68I6Qdk2eAu8SNnC7pHb6Ge+2Yg
         AQT2pEtJEazb8DIH0FEehb3xgba7nSG5gCNrGC8dXez8RFZ46TCWO3DA2f6zcB5nYZdg
         p50wnPFm1m5pXjADvdRsd1ZWUE7KtmT+XWzwkLENHc/ID6jqhD9E9Nisp52pD5Aovr+G
         sioA/LluVP7hIt/R1F4vVQycaRUcHb+S4jz3WE98f5A4FvCQdAZkTl2GXlp9JGHhM7W4
         jJEg==
X-Gm-Message-State: AOJu0YwtAoNLWzXprqhcV/lI1g4SpLKciJ9IG1sa0oLscu5VbPgTqNfi
        sxIToakBkQugcQVbG//Dws8=
X-Google-Smtp-Source: AGHT+IEfdsKyflENvLWfBGllYfegw42Agn4IZSoOohVpE21eLGGFklIzel+5lXB5EbERfl2tC5vLvA==
X-Received: by 2002:a05:6870:d3cc:b0:1ef:abaa:cae0 with SMTP id l12-20020a056870d3cc00b001efabaacae0mr7153000oag.29.1699837941098;
        Sun, 12 Nov 2023 17:12:21 -0800 (PST)
Received: from neuromancer. ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id pu27-20020a0568709e9b00b001f49285a366sm849666oab.45.2023.11.12.17.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 17:12:20 -0800 (PST)
Message-ID: <655177f4.050a0220.d85c9.3ba0@mx.google.com>
X-Google-Original-Message-ID: <ZVF38Btn9FmFGK7l@neuromancer.>
Date:   Sun, 12 Nov 2023 19:12:16 -0600
From:   Chris Morgan <macroalpha82@gmail.com>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Wolfram Sang <wsa@kernel.org>, Lee Jones <lee@kernel.org>,
        rafael.j.wysocki@intel.com,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        dmitry.osipenko@collabora.com, peterz@infradead.org,
        jonathanh@nvidia.com, richard.leitner@linux.dev,
        treding@nvidia.com, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>,
        stable@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        heiko@sntech.de, max.schwarz@online.de
Subject: Re: [PATCH v7 2/5] i2c: core: run atomic i2c xfer when !preemptible
References: <20230327-tegra-pmic-reboot-v7-0-18699d5dcd76@skidata.com>
 <20230327-tegra-pmic-reboot-v7-2-18699d5dcd76@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327-tegra-pmic-reboot-v7-2-18699d5dcd76@skidata.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2023 at 09:53:24AM +0200, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> Since bae1d3a05a8b, i2c transfers are non-atomic if preemption is
> disabled. However, non-atomic i2c transfers require preemption (e.g. in
> wait_for_completion() while waiting for the DMA).
> 
> panic() calls preempt_disable_notrace() before calling
> emergency_restart(). Therefore, if an i2c device is used for the
> restart, the xfer should be atomic. This avoids warnings like:
> 
> [   12.667612] WARNING: CPU: 1 PID: 1 at kernel/rcu/tree_plugin.h:318 rcu_note_context_switch+0x33c/0x6b0
> [   12.676926] Voluntary context switch within RCU read-side critical section!
> ...
> [   12.742376]  schedule_timeout from wait_for_completion_timeout+0x90/0x114
> [   12.749179]  wait_for_completion_timeout from tegra_i2c_wait_completion+0x40/0x70
> ...
> [   12.994527]  atomic_notifier_call_chain from machine_restart+0x34/0x58
> [   13.001050]  machine_restart from panic+0x2a8/0x32c
> 
> Use !preemptible() instead, which is basically the same check as
> pre-v5.2.
> 
> Fixes: bae1d3a05a8b ("i2c: core: remove use of in_atomic()")
> Cc: stable@vger.kernel.org # v5.2+
> Suggested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Acked-by: Wolfram Sang <wsa@kernel.org>
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Tested-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>

For kernel 6.7 I'm having an issue when I shutdown or reboot my
Rockchip RK3326 or Rockchip RK3566 based devices, and I've bisected
the issue down to this specific commit.

When I shutdown or restart the device, I receive messages in the kernel
log like the following:

[   37.121148] rk3x-i2c fdd40000.i2c: irq in STATE_IDLE, ipd = 0x3
[   37.122178] rk3x-i2c fdd40000.i2c: irq in STATE_IDLE, ipd = 0x3
[   37.123212] rk3x-i2c fdd40000.i2c: irq in STATE_IDLE, ipd = 0x3
[   37.124226] rk3x-i2c fdd40000.i2c: irq in STATE_IDLE, ipd = 0x3
[   37.125242] rk3x-i2c fdd40000.i2c: irq in STATE_IDLE, ipd = 0x3
[   37.126133] rk3x-i2c fdd40000.i2c: irq in STATE_IDLE, ipd = 0x1

The device will also occasionally freeze instead of rebooting or
shutting down. The i2c errors are consistent, but the freezing
behavior is not.

Thank you.

> ---
>  drivers/i2c/i2c-core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
> index 1247e6e6e975..05b8b8dfa9bd 100644
> --- a/drivers/i2c/i2c-core.h
> +++ b/drivers/i2c/i2c-core.h
> @@ -29,7 +29,7 @@ int i2c_dev_irq_from_resources(const struct resource *resources,
>   */
>  static inline bool i2c_in_atomic_xfer_mode(void)
>  {
> -	return system_state > SYSTEM_RUNNING && irqs_disabled();
> +	return system_state > SYSTEM_RUNNING && !preemptible();
>  }
>  
>  static inline int __i2c_lock_bus_helper(struct i2c_adapter *adap)
> 
> -- 
> 2.34.1
> 
