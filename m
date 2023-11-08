Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D90C7E5CFC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 19:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjKHSOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 13:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHSOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 13:14:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455BD1FEB;
        Wed,  8 Nov 2023 10:14:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F30C433C8;
        Wed,  8 Nov 2023 18:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699467277;
        bh=ng0Z0yiL5wDi2uFlhLAY0J4hyvt9OhQw1d42t8ttAIM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=mfXx0uJChaP9WbHIgNnkoNWcFuH6IlG9+39FwzOdhnm7bArMI/DfzwwplSP+kSHD1
         3O9RahgKbb5IDpqEEfIiL7Wxgw6Z+BoQmANCLU6qPu4wZe6oabW7+6bhZv4KuzpT2U
         3ppGSor6oUCfilTkzmhymz+uElmHuG93B8X28ohm+IudChlLmnHNtnZz6yMNEL7U0U
         IfYf24gSjnc0IbEQOj3YxeKA7ZrJgBYGqYE9oD3PzDfHzHU0dhhkyLgmKCNfVIqhpa
         TkJjujS2D1JoIw9XULUDrIWTBMqd2DHE/oP9o9Qa39v82Kb8qsffy2R6QKs0p6XJub
         euDBnmZhXdtpw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/3] wifi: rt2x00: introduce DMA busy check watchdog
 for
 rt2800
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <TYAP286MB0315D7462CE08A119A99DE34BCA4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
References: <TYAP286MB0315D7462CE08A119A99DE34BCA4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        linux-kernel@vger.kernel.org, Shiji Yang <yangshiji66@outlook.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169946727483.2821494.16214714839411519635.kvalo@kernel.org>
Date:   Wed,  8 Nov 2023 18:14:36 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shiji Yang <yangshiji66@outlook.com> wrote:

> When I tried to fix the watchdog of rt2800, I found that sometimes
> the watchdog can not reset the hung device. This is because the
> queue is not completely stuck, it just becomes very slow. The MTK
> vendor driver for the new chip MT7603/MT7612 has a DMA busy watchdog
> to detect device hangs by checking DMA busy status. This watchdog
> implementation is something similar to it. To reduce unnecessary
> reset, we can check the INT_SOURCE_CSR register together as I found
> that when the radio hung, the RX/TX coherent interrupt will always
> stuck at triggered state.
> 
> The 'watchdog' module parameter has been extended to control all
> watchdogs(0=disabled, 1=hang watchdog, 2=DMA watchdog, 3=both). This
> new watchdog function is a slight schedule and it won't affect the
> transmission speed. So we can turn on it by default. Due to the
> INT_SOURCE_CSR register is invalid on rt2800 USB NICs, the DMA busy
> watchdog will be automatically disabled for them.
> 
> Tested on MT7620 and RT5350.
> 
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

3 patches applied to wireless-next.git, thanks.

b1275cdd7456 wifi: rt2x00: introduce DMA busy check watchdog for rt2800
570beb6285fd wifi: rt2x00: disable RTS threshold for rt2800 by default
a11d965a218f wifi: rt2x00: restart beacon queue when hardware reset

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/TYAP286MB0315D7462CE08A119A99DE34BCA4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

