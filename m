Return-Path: <linux-kernel+bounces-108905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A828811B1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FEC0B22722
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E433FE2C;
	Wed, 20 Mar 2024 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NP3e7r7h"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90A62E821
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 12:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710937910; cv=none; b=KW7IodycjO1xphuPmge/qGjDa9jy99OjcaltQvF1V1DI0Wp+xmGQ06sqxvzcGh/nAC04TXzxY9hfwzUCMtZXa3/qySHddwGAjnpup866Pkv5jJGmaTl2+i/pYkNJKGhPmsPOyKvL3B9lI9wfzsszD4szbYQTHQtnU4rW8YJx4T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710937910; c=relaxed/simple;
	bh=LPRFSAFMkrPtTolffowhZY0AsKBxDyQ2IKLuUXgvDFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uc0SzE3e1OJigYtAuNSVA4+IwaSx3gLjdRUI/AbNW/SLGZmocnjw5aV8YYqWtnukCBKCBHH+MkIALlFIgxgkADRZN5qJ3Z7Qr1rv386eFFc7qOkS7gy7YO6MvZjxRo5h7bWgKIpnwg4Qvsk/k70SGq2daq9KuPJzRbAvw1bi/oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NP3e7r7h; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d46dd5f222so76534021fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 05:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710937907; x=1711542707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eSqYwDSzQNKyRgs3+B2Ahk74iN3y0wq5QC5UvC6Hc48=;
        b=NP3e7r7hq8Zf4BVR9Sg0e8Vf7gie3fJrxc2AiQdyzZkodXI+6tkVhE3DakUYD0xXhg
         mpHSDMUaomEaJx2jIIAD1umDjVa5OesuJFGMDIcwFWnaXrAUfHbS3E6kRMjcvxIuF1Ui
         IAwlB+ZeobPEH49MLibqxLRo9zVT9Rdp+bUhznZdL5Py3DusjhCsCmlt57a0e9Jk8vJT
         N4SgkN5rumldwr1kVzoS7TnZc+nw1eQERGn59whcZMmdWtvz6/fmGqE2raGgmv9YU8cF
         xDPrHNbGJEIYe7HRlQ5c6BQMPhSh1OMywQZvZMj80Z0BAQGlMXar9NvYX759l42UeVx5
         KO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710937907; x=1711542707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSqYwDSzQNKyRgs3+B2Ahk74iN3y0wq5QC5UvC6Hc48=;
        b=tjnWR9SnVqwCLjkF/LsrbH9F5Fj1l20LaQQq3WEuPaKdF32g5nvSWLSBwxBtBdWurq
         NSwdSTV+Un0TB5dnWtJHa3vtlYupSsJlUWJe3UrMR2EyQ2tnS9UakKTfCy57ow8Nub7+
         G3k8Q5so6F8cX41PavO8p1ojqLcdXqJF2bsxBWzNiyfgXu/wDmm9hFafyV3erUUoplRw
         WYlHK55dHL1E+TIJ3+s0OiJmvs38Nn9p+j5RS3gVOJXDN2PNmp4a7eOTCOVyNTGbwoQH
         HBaKotBzOIY+tq/uHddp1LZVJj5+3Gh30M2BOuufDjUIcQD6cJAYgbZJm/Hrb01UWVN1
         SrIg==
X-Forwarded-Encrypted: i=1; AJvYcCUUqJcP73R+4gVtEXMMZ+b7efl2aSwqks78efo4OzqzhlKQ/8AAH2YgUS7q/lecXZ7yl74ozX5SnJgDzVerrs9ECX5jLbRLyODawAbP
X-Gm-Message-State: AOJu0Yw07TR7YU3eg5lGX4jC0FugFKMcTJyaPLnRGHz1BOFDkQPOpyqZ
	+EOIqacWRJDhcG+AWcZYd0oj3CGsb7wJhkcHU/aB1CrX49O32HVZ2jQ+c2E8TeE=
X-Google-Smtp-Source: AGHT+IHos06Q8nqoNaamkachV5XcpAi8oC8hgLEq/TrS6NBOaMzKTpU77upJ0NbpAyJvfSMQALu5Cg==
X-Received: by 2002:a2e:9209:0:b0:2d4:74c4:9f64 with SMTP id k9-20020a2e9209000000b002d474c49f64mr10853418ljg.3.1710937906761;
        Wed, 20 Mar 2024 05:31:46 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id he9-20020a05600c540900b00413eb5aa694sm2088649wmb.38.2024.03.20.05.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 05:31:46 -0700 (PDT)
Date: Wed, 20 Mar 2024 13:31:43 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: David Thompson <davthompson@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, u.kleine-koenig@pengutronix.de, leon@kernel.org,
	asmaa@nvidia.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] mlxbf_gige: call request_irq() after NAPI
 initialized
Message-ID: <ZfrXL8yKhxduWm9D@nanopsycho>
References: <20240319181732.12878-1-davthompson@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319181732.12878-1-davthompson@nvidia.com>

Tue, Mar 19, 2024 at 07:17:32PM CET, davthompson@nvidia.com wrote:
>The mlxbf_gige driver encounters a NULL pointer exception in
>mlxbf_gige_open() when kdump is enabled.  The sequence to reproduce
>the exception is as follows:
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
>The logic in mlxbf_gige_open() has been re-ordered so that the
>request_irq() calls execute after NAPI is fully initialized.

This should be in imperative mood so the reader know right away that you
are not talking about existing code and it's history, but you rather
command the codebase what to change/do/fix/etc.

>
>Also, the logic in mlxbf_gige_open() was missing a call to phy_stop()
>in the error path, so that has been added.

Same here.

Also, could you please have the missing phy_stop() as a separate patch
as Paolo suggested? It's a different bug.

pw-bot: cr


>
>Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
>Signed-off-by: David Thompson <davthompson@nvidia.com>
>Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>
>---
>v2
>- re-worded commit message and subject for clarity
>- updated commit message to mention that phy_stop() was added
>  to the error path in mlxbf_gige_open()
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

