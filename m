Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D557F95CA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 23:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjKZW0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 17:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZW03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 17:26:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9620CED
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 14:26:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3C8C433C8;
        Sun, 26 Nov 2023 22:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701037596;
        bh=WYWHeUOvyvzljTzqy0dHZNjOtP4h9rbjEwP36PpU3qI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UFVwuBD+/k7MMP+f0hM6mEmyn9+uXqakr0oLim/czrNpsPLNUal1bRwVX2Mn/KB/L
         S/5DhaEjz3X7iZQ7T6AUaFFbjjkDQbHHnpqPp+bx7td/3ZiKhDxiMxJtvh1z7mG5FW
         q9SnfiTB0L5mk1pZDvufkehsnuQdmGsO2KpaQKJRCCPj4tVOP4WYxrEpMFeTTOCSJ5
         FtIQ1dwZHh/0uKJASBMEPW0GHK1whKjiHYSz3pt6GX11CUpD2I6xPECpu/p2Jr9bOJ
         +vv9oIZYguLSUQvBQ9sj1ylaQvC1mDNk/CtbXxXH3xek7ZhiWlT72I/fmPxiL7nMsm
         dastMCp0EamLQ==
Date:   Sun, 26 Nov 2023 14:26:34 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     cristian_ci <cristian_ci@protonmail.com>
Cc:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: [BUG] wireless: mt7601u: probe failed with error -110
Message-ID: <20231126142634.3a100e2c@kernel.org>
In-Reply-To: <Bnwq2et4CBU1_MS8X3rFeejMDmKf2dr_BNq60IzBcGKbjTxHG1CjJ0zB_wZjn8_iLJsi7fCx6_Eh01ozYBqPA-cEZXMZE_X98E0b7yotXCg=@protonmail.com>
References: <Bnwq2et4CBU1_MS8X3rFeejMDmKf2dr_BNq60IzBcGKbjTxHG1CjJ0zB_wZjn8_iLJsi7fCx6_Eh01ozYBqPA-cEZXMZE_X98E0b7yotXCg=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2023 13:03:45 +0000 cristian_ci wrote:
> I'm not the only one to have experienced this bug. I've been
> suggested to report that to kernel mailing list by linux support
> channels.
> 
> I've tested this bug against upstream 6.6.2 kernel tarball from the
> latest stable branch [1].
> 
> To solve this issue. I've also tried to patch mt7601u driver
> disabling mcu calibration. Which doesn't seem a wise idea because
> apparently it fixes probing but also hangs completely the machine
> after some seconds (so, it needs a hard/forced shutdown).

Does it work with the vendor driver? The upstream driver is just 
a rewrite of the vendor driver, I don't know much about the device
internals.

Maybe Lorenzo or Felix have some ideas.
