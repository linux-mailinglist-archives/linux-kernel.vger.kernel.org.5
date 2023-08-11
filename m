Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27BC77918F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbjHKOP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbjHKOPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:15:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E821994
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 07:15:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A12760F8F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB79C433C7;
        Fri, 11 Aug 2023 14:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691763320;
        bh=u5eV7JryKwJWZQCkHh97YNOqKKX39Z+e14jnnXZ/tcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rsqs3iQjG1fe1YlXPldZn89KDXqx2zBkLQfcoKdT5QNTWOuAz5mf7J0TKZ9ETR4BN
         Iye/PZpuTmPLROuRpEHhfvqzxCsCh+1Sz0pgU2B0CzX9phd7Bk3ehUGXgEVMQhoeG9
         bxuBzC7b3F+Klp/TYHq8eLznu5uGov4K0rvr7+nyLLvZlFhmHIuCoQ9vDjdLNfhybA
         7HpF7a7l1hoO+7gRDmx50uH/S311Q7nOiG4LKpFb7t/ahgjzAJxgKMhUpLmgM5DzmE
         H47+DZ5aXfaHTan+8aoA0adyZDsXiHJnrqDglN8L2bkdozmvXRzvFJMznp0MaGSNTz
         gJfSbwQcRRYxA==
Date:   Fri, 11 Aug 2023 22:15:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V6 0/8] firmware: imx: scu/scu-irq: misc update
Message-ID: <20230811141510.GX151430@dragon>
References: <20230807121432.3970610-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807121432.3970610-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 08:14:24PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V6:
>  Typo fix
>  Update commit message
>  Drop Patch v5 3/9
>  code style and error path check in patch 8
> 
> V5:
>  Address sparse checking in patch 9
>  Add a new patch 5
> 
> V4:
>  Add static inline for irq get status when SCU not defined
>  Drop two patches wrongly included
> 
> V3:
>  Fix build error reported by kernel robot
>  Add patch subject-prefix
> 
> V2:
>  Fix build warning
> 
> Dong Aisheng (2):
>   firmware: imx: scu: change init level to subsys_initcall_sync
>   firmware: imx: scu: increase RPC timeout
> 
> Peng Fan (4):
>   firmware: imx: scu: use soc name for soc_id
>   firmware: imx: scu: use EOPNOTSUPP
>   firmware: imx: scu-irq: add imx_scu_irq_get_status
>   firmware: imx: scu-irq: enlarge the IMX_SC_IRQ_NUM_GROUP
> 
> Ranjani Vaidyanathan (1):
>   firmware: imx: scu-irq: support identifying SCU wakeup source from
>     sysfs
> 
> Robin Gong (1):
>   firmware: imx: scu-irq: fix RCU complaint after M4 partition reset

Applied all, thanks!
