Return-Path: <linux-kernel+bounces-106081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D7B87E8C1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45AC3B20EB1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA61E374D3;
	Mon, 18 Mar 2024 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="uOcuNPBj"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5D4364BA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710762027; cv=none; b=V/vYsEMpFSeuafCHfGhvSL2O9y1LNmBSnxgNXTkTIiy+8awOOWbHuYoQhk40QHYplWXnUNO5t9G6B+g2TLWabpnZ0ZqB/FYDjA+9EGAne54vZRkDqDcJ56hDyLPJ7p5dbmytzWk8Vp81+8u1am2CTB4dXaUa34pvT8iK50Z20qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710762027; c=relaxed/simple;
	bh=J2xG7Q3HvmSDlfFlVQlsGlLVqzAd0T4PL9mUPB8ncWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyVS9tVA3QcclZm98Wj/MfL95PL11RwqKyqkyeS4LjnL4393kag95d3q5I+komXKc1BzNA5WbbU8y8afMzbu4l/op7rX31qYh8v0GoCNtkGvr5J6+8sXXRy5KNfeOXmwxhDCsiKR+HpPX+NiiOen1gdKe82D5DxLT1A4vjZVZR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=uOcuNPBj; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so9083439a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 04:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710762023; x=1711366823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJDLtpvqgBEW8S7AHDT5Z+T8PXxVcBMCtE+OhVHbR1c=;
        b=uOcuNPBjdCtcqHIesT2kF9otddKu9JRFXd8HLDc0tKNJGYUo05HILA9rkLDybmA1tN
         rD1L4U6bJ2DX7UcTSd2JchD5TtOY8gKRuYpckfd2BX74kjNAmmPwawjCVqQxJ2/WUoAo
         zBxhqnQcW4tY3TaYQm8VSPqtMLTzJUTQ6XP3GrwWa+3I1ripNIJXziNAwLyluk+ujUNQ
         kAoKR7dWAET0pL4FrKkKwrz25+rAqwss7FoLS+DO1vycUT1eiul1ghUv2ZP4rou3n+pV
         2eSZCAX4rs1aVYR7rEKA09Pk6AErCktnXJpHCcVASNrlpQpwR25H3YL4D++OxSJaY6y+
         M1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710762023; x=1711366823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJDLtpvqgBEW8S7AHDT5Z+T8PXxVcBMCtE+OhVHbR1c=;
        b=qFZI96PusiVpzS9wxO2kjYm2HrmutkC5gzYEVhRjwaH2/EsLdBWilgdlFT9iydShvz
         JqIDIhbJYTnfUwAdSXnQoFTL4pTLeIDYFXuLmhLGwNLAHGkZcSjeKSzRAJhfVh51No3p
         AcxpE/ONjR84j+d0/ePVh1qXxo825oFXptziQjyewTOBeFxZROY9P0SZTk+FrFE/Q2Xd
         vg6Yys8ZHJOVnbNYBUQ80w1754rHeUUYE/x384RKmcPyA3rCTArEb9RikipQTcF/VgZG
         z182TkchjgZhy4uiGnv2d8DnJS7anY6BsrbXso11KsZcmledB7hSRYu63pQtutXtMShr
         FkbA==
X-Forwarded-Encrypted: i=1; AJvYcCVBvwlUr183eePfllmzdraXAFfTo5OEcFHIpGTcJR3WMFw9A4wzNxrJLHLYQ9Wn2dtCY0P5+rISEg2q5ZmDIBdTHw0cp4x542MXC9xQ
X-Gm-Message-State: AOJu0YyJotvL3+W/r3dMBMEyrHWI6Jv5lOBUzBAB7ikY5g1dDvM0cmNo
	iP9Nc+T9ysT9a4xslI0NysF5D9PecgR2gdBlj+shiT/q0jtj3FhhS0lWKy0FqYU=
X-Google-Smtp-Source: AGHT+IFop7UQ0dwdtb/xnUo7wvk5ganfjoagF3KNtqJl/blz1D/Ks+eHWesBWT1WWW7dZuUDjIPpvg==
X-Received: by 2002:a17:906:d048:b0:a46:a17b:7a37 with SMTP id bo8-20020a170906d04800b00a46a17b7a37mr5472662ejb.0.1710762022768;
        Mon, 18 Mar 2024 04:40:22 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ht17-20020a170907609100b00a461b1e814asm4720907ejc.130.2024.03.18.04.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 04:40:21 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:40:16 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: David Thompson <davthompson@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, u.kleine-koenig@pengutronix.de, leon@kernel.org,
	asmaa@nvidia.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] mlxbf_gige: open() should call request_irq()
 after NAPI init
Message-ID: <ZfgoIPAMIHyGFF9s@nanopsycho>
References: <20240315145609.23950-1-davthompson@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315145609.23950-1-davthompson@nvidia.com>

Fri, Mar 15, 2024 at 03:56:09PM CET, davthompson@nvidia.com wrote:
>This patch fixes an exception that occurs during open()

Don't talk about "this patch" in the patch description. Be imperative to
the codebase, tell it what to do. In both patch description and subject.
Much easier to follow then.


>when kdump is enabled.  The sequence to reproduce the
>exception is as follows:
>a) enable kdump
>b) trigger kdump via "echo c > /proc/sysrq-trigger"
>c) kdump kernel executes
>d) kdump kernel loads mlxbf_gige module
>e) the mlxbf_gige module runs its open() as the
>   the "oob_net0" interface is brought up
>f) mlxbf_gige module will experience an exception
>   during its open(), something like:
>
>     Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>     Mem abort info:
>       ESR = 0x0000000086000004
>       EC = 0x21: IABT (current EL), IL = 32 bits
>       SET = 0, FnV = 0
>       EA = 0, S1PTW = 0
>       FSC = 0x04: level 0 translation fault
>     user pgtable: 4k pages, 48-bit VAs, pgdp=00000000e29a4000
>     [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
>     Internal error: Oops: 0000000086000004 [#1] SMP
>     CPU: 0 PID: 812 Comm: NetworkManager Tainted: G           OE     5.15.0-1035-bluefield #37-Ubuntu
>     Hardware name: https://www.mellanox.com BlueField-3 SmartNIC Main Card/BlueField-3 SmartNIC Main Card, BIOS 4.6.0.13024 Jan 19 2024
>     pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>     pc : 0x0
>     lr : __napi_poll+0x40/0x230
>     sp : ffff800008003e00
>     x29: ffff800008003e00 x28: 0000000000000000 x27: 00000000ffffffff
>     x26: ffff000066027238 x25: ffff00007cedec00 x24: ffff800008003ec8
>     x23: 000000000000012c x22: ffff800008003eb7 x21: 0000000000000000
>     x20: 0000000000000001 x19: ffff000066027238 x18: 0000000000000000
>     x17: ffff578fcb450000 x16: ffffa870b083c7c0 x15: 0000aaab010441d0
>     x14: 0000000000000001 x13: 00726f7272655f65 x12: 6769675f6662786c
>     x11: 0000000000000000 x10: 0000000000000000 x9 : ffffa870b0842398
>     x8 : 0000000000000004 x7 : fe5a48b9069706ea x6 : 17fdb11fc84ae0d2
>     x5 : d94a82549d594f35 x4 : 0000000000000000 x3 : 0000000000400100
>     x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000066027238
>     Call trace:
>      0x0
>      net_rx_action+0x178/0x360
>      __do_softirq+0x15c/0x428
>      __irq_exit_rcu+0xac/0xec
>      irq_exit+0x18/0x2c
>      handle_domain_irq+0x6c/0xa0
>      gic_handle_irq+0xec/0x1b0
>      call_on_irq_stack+0x20/0x2c
>      do_interrupt_handler+0x5c/0x70
>      el1_interrupt+0x30/0x50
>      el1h_64_irq_handler+0x18/0x2c
>      el1h_64_irq+0x7c/0x80
>      __setup_irq+0x4c0/0x950
>      request_threaded_irq+0xf4/0x1bc
>      mlxbf_gige_request_irqs+0x68/0x110 [mlxbf_gige]
>      mlxbf_gige_open+0x5c/0x170 [mlxbf_gige]
>      __dev_open+0x100/0x220
>      __dev_change_flags+0x16c/0x1f0
>      dev_change_flags+0x2c/0x70
>      do_setlink+0x220/0xa40
>      __rtnl_newlink+0x56c/0x8a0
>      rtnl_newlink+0x58/0x84
>      rtnetlink_rcv_msg+0x138/0x3c4
>      netlink_rcv_skb+0x64/0x130
>      rtnetlink_rcv+0x20/0x30
>      netlink_unicast+0x2ec/0x360
>      netlink_sendmsg+0x278/0x490
>      __sock_sendmsg+0x5c/0x6c
>      ____sys_sendmsg+0x290/0x2d4
>      ___sys_sendmsg+0x84/0xd0
>      __sys_sendmsg+0x70/0xd0
>      __arm64_sys_sendmsg+0x2c/0x40
>      invoke_syscall+0x78/0x100
>      el0_svc_common.constprop.0+0x54/0x184
>      do_el0_svc+0x30/0xac
>      el0_svc+0x48/0x160
>      el0t_64_sync_handler+0xa4/0x12c
>      el0t_64_sync+0x1a4/0x1a8
>     Code: bad PC value
>     ---[ end trace 7d1c3f3bf9d81885 ]---
>     Kernel panic - not syncing: Oops: Fatal exception in interrupt
>     Kernel Offset: 0x2870a7a00000 from 0xffff800008000000
>     PHYS_OFFSET: 0x80000000
>     CPU features: 0x0,000005c1,a3332a5a
>     Memory Limit: none
>     ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---
>
>The exception happens because there is a pending RX interrupt before the
>call to request_irq(RX IRQ) executes.  Then, the RX IRQ handler fires
>immediately after this request_irq() completes. The RX IRQ handler runs
>"napi_schedule()" before NAPI is fully initialized via "netif_napi_add()"
>and "napi_enable()", both which happen later in the open() logic.
>
>This patch fixes the issue by re-ordering the logic in mlxbf_gige open()
>so that the request_irq() calls execute after NAPI is fully initialized.

Same here.

>
>Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
>Signed-off-by: David Thompson <davthompson@nvidia.com>
>Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>


The patch itself looks okay.


pw-bot: cr

>---
> .../mellanox/mlxbf_gige/mlxbf_gige_main.c     | 21 ++++++++++++-------
> 1 file changed, 14 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
>index 3d09fa54598f..77134ca92938 100644
>--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
>+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
>@@ -139,13 +139,10 @@ static int mlxbf_gige_open(struct net_device *netdev)
> 	control |= MLXBF_GIGE_CONTROL_PORT_EN;
> 	writeq(control, priv->base + MLXBF_GIGE_CONTROL);
> 
>-	err = mlxbf_gige_request_irqs(priv);
>-	if (err)
>-		return err;
> 	mlxbf_gige_cache_stats(priv);
> 	err = mlxbf_gige_clean_port(priv);
> 	if (err)
>-		goto free_irqs;
>+		return err;
> 
> 	/* Clear driver's valid_polarity to match hardware,
> 	 * since the above call to clean_port() resets the
>@@ -157,7 +154,7 @@ static int mlxbf_gige_open(struct net_device *netdev)
> 
> 	err = mlxbf_gige_tx_init(priv);
> 	if (err)
>-		goto free_irqs;
>+		goto phy_deinit;
> 	err = mlxbf_gige_rx_init(priv);
> 	if (err)
> 		goto tx_deinit;
>@@ -166,6 +163,10 @@ static int mlxbf_gige_open(struct net_device *netdev)
> 	napi_enable(&priv->napi);
> 	netif_start_queue(netdev);
> 
>+	err = mlxbf_gige_request_irqs(priv);
>+	if (err)
>+		goto napi_deinit;
>+
> 	/* Set bits in INT_EN that we care about */
> 	int_en = MLXBF_GIGE_INT_EN_HW_ACCESS_ERROR |
> 		 MLXBF_GIGE_INT_EN_TX_CHECKSUM_INPUTS |
>@@ -182,11 +183,17 @@ static int mlxbf_gige_open(struct net_device *netdev)
> 
> 	return 0;
> 
>+napi_deinit:
>+	netif_stop_queue(netdev);
>+	napi_disable(&priv->napi);
>+	netif_napi_del(&priv->napi);
>+	mlxbf_gige_rx_deinit(priv);
>+
> tx_deinit:
> 	mlxbf_gige_tx_deinit(priv);
> 
>-free_irqs:
>-	mlxbf_gige_free_irqs(priv);
>+phy_deinit:
>+	phy_stop(phydev);
> 	return err;
> }
> 
>-- 
>2.30.1
>
>

