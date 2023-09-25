Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0867AE0D6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 23:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbjIYVgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 17:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjIYVgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 17:36:36 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BC6CE;
        Mon, 25 Sep 2023 14:36:28 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D0D4E1BF204;
        Mon, 25 Sep 2023 21:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695677787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f2wGeLXAhYMiEQV6PFmquWY/Y7ZW7oHoV6lKqrItjsc=;
        b=hUusch+GfAF5Yy9LLsV7BGQUOgUfBF8BuHtGScU1AZvzg+MZj+T7RiT3XkqLdYWec4QIvq
        4PuJMapE5sP6X181rIbQcFfcF6H4g8hZi6WaBE7icYJ8DUCic9Msno6wgUQkg9sRcmo6on
        pJqYDSYCzzCOkMiwiLfLCBgKRMHHZXZwc3g+jybZHtVBBMiZTsL4bJnWl0GSLMQA31YnnO
        2VkRvsWMgwqBvzXgf4fvy0Psvi4NjlR1SUvEdZ0To6BjMKHAi0gxIv9cUWCJEZdm4YKTvt
        kLnRib8IMWgjOUlHq8XyTP6lUm9ZCi8c4tJ5LPkQqTcAmh/Eey8HqY64KNM4qA==
Date:   Mon, 25 Sep 2023 23:36:26 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     pgaj@cadence.com, miquel.raynal@bootlin.com,
        Joshua Yeong <joshua.yeong@starfivetech.com>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 0/1] Cadence I3C Status Register Bit Mask Error
Message-ID: <169567773732.243402.3105216980564759261.b4-ty@bootlin.com>
References: <20230913031743.11439-1-joshua.yeong@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913031743.11439-1-joshua.yeong@starfivetech.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Sep 2023 11:17:43 +0800, Joshua Yeong wrote:
> I3C ibirfifodepth and cmdrfifodepth field should read from status0 instead of
> status1. Update I3C slave macro.
> 
> Joshua Yeong (1):
>   i3c: master: cdns: Fix reading status register
> 
>  drivers/i3c/master/i3c-master-cdns.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> [...]

Applied, thanks!

[1/1] i3c: master: cdns: Fix reading status register
      commit: 4bd8405257da717cd556f99e5fb68693d12c9766

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
