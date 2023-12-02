Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D137801A6B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 05:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjLBELm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 23:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBELl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 23:11:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC479126
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 20:11:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E470C433C9;
        Sat,  2 Dec 2023 04:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701490307;
        bh=1+nNWFO5K984/3PjlBg4MbMZtLgdAePl/arFcHZyCBA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=antRZhyW9OJFc8PJ7MCSBpl6Dv69m+q310z41f5BZ/8TllOiIJ62hf3xpm+XMpn+h
         47BwXTTORiE9/QXFF8aCeCV6KhfJ6Xy0bh9mj4zVjh8kqeKEODT94iwqph+tuX9zyq
         6/O4dDG/hVM4Y06aH4THs12QwoToJGi3fnOI2kkTuDZM7asYag+tr0TZdt+oDn0M/A
         TPl0W+piJh+vojH5+VC+MFBWZCuDBQjg3X4oVYp8qlgr5PevF7YMB5xel3ZLvF23Rq
         INA9XYXS5/kS+CXxkUjC2L1jNojvnAJ6XoRcpQ6i6Y8Ms52bPyvbyC/Pj68upurhtD
         9uV4BuIuqvocg==
Date:   Fri, 1 Dec 2023 20:11:46 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Haoran Liu <liuhaoran14@163.com>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        heiko@sntech.de, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net/ethernet] arc_emac: Add error handling in
 emac_rockchip_probe
Message-ID: <20231201201146.12aa16df@kernel.org>
In-Reply-To: <20231130031318.35850-1-liuhaoran14@163.com>
References: <20231130031318.35850-1-liuhaoran14@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 19:13:18 -0800 Haoran Liu wrote:
> Although the error addressed by this patch may not occur in the current
> environment, I still suggest implementing these error handling routines
> if the function is not highly time-sensitive. As the environment evolves
> or the code gets reused in different contexts, there's a possibility that
> these errors might occur. Addressing them now can prevent potential
> debugging efforts in the future, which could be quite resource-intensive.

Please skip this pointless boilerplate.

>  	match = of_match_node(emac_rockchip_dt_ids, dev->of_node);
> +	if (!match) {
> +		dev_err(dev, "No matching device found\n");
> +		return -ENODEV;

"device" and ENODEV are not right here.
-- 
pw-bot: cr
