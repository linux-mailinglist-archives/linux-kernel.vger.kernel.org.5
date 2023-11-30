Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB907FFB19
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376348AbjK3TVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376346AbjK3TU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:20:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27118D48
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:21:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A20C433C7;
        Thu, 30 Nov 2023 19:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701372062;
        bh=/nNbmxvYk4PeLj0IKIcflNHFfHDHygDe5UG7/BtZX4I=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=evZYHgvKxtZnJ6tt6nMpok91Q3GDWFWPRI9wFkU6HApfzdy/66JaQUjWZeqJfa8ak
         qA6ariFYlPv/LzTjFU7LXv9liNM31hJmSYDZqmi5O6uXUa/le4IHlJFv5nFWS3MZcU
         x3okcbNxvsSjX+cA9FlYfsfnbRcADNPj6Lf9uKta6BIE4JHnGTBZOu90t4l4xlYFT0
         Nulb8Bzil/jIuUEKcT3HGyXVmh8Eq9s+mrYbrGUDIPjZO4Bf/A7Uhzvw+JntIbqD4h
         pMu7r6Xf+J1UehZeJ6JiAX7rGy5VEAWcUU3q+gHJhbgg05ChHM9lcUUvbB1/t4tXFr
         6RHCyJmwDwV/g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: libertas: fix config name in dependency for SDIO
 support
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231122083047.12774-1-lukas.bulwahn@gmail.com>
References: <20231122083047.12774-1-lukas.bulwahn@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, libertas-dev@lists.infradead.org,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170137205913.1963309.7623759233878146525.kvalo@kernel.org>
Date:   Thu, 30 Nov 2023 19:21:01 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit 4b478bf6bdd8 ("wifi: libertas: drop 16-bit PCMCIA support") reworks
> the dependencies for config LIBERTAS, and adds alternative dependencies for
> USB, SDIO and SPI.
> 
> The config option SDIO however does not exist in the kernel tree. It was
> probably intended to refer to the config option MMC, which represents
> "MMC/SD/SDIO card support" and is used as dependency by various other
> drivers that use SDIO.
> 
> Fix the dependency to the config option MMC for declaring the requirement
> on provision of SDIO support.
> 
> Fixes: 4b478bf6bdd8 ("wifi: libertas: drop 16-bit PCMCIA support")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Patch applied to wireless-next.git, thanks.

18814f723f92 wifi: libertas: fix config name in dependency for SDIO support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231122083047.12774-1-lukas.bulwahn@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

