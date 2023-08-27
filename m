Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C601778A277
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 00:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjH0WGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 18:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjH0WGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 18:06:08 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98507B6;
        Sun, 27 Aug 2023 15:06:05 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 72E97C0007;
        Sun, 27 Aug 2023 22:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693173963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AHKYri3hv8eu6YfX3yWoeXj1sHqbYW6uP+++3bLm3ZA=;
        b=HhWL0vIQJw6wB6jYNaQ6zE40Scd6TltGutxJs7biv2HcWFgc8njKJ/QndYYN4qZDEA9A5H
        Znljg0vB1/S1WDpg0XEQr5fLzRNHoZpWzp1pkwHeWqImh58zdUNqSwRlcM2VsD+ki0tSUj
        PehfWjXMUVSOmJCa8r01Bqc9gFUBb6At4ei0nIL9zrKVXrRlM2Ud0jaJ+yPz3sbQi4o2CM
        gsChhtaQdypPTUd9gRPColr8AAhb15pEm5W8U0P6AzhzqKM3QIMXVJcFhjJVyOmWThaD0V
        ljuxsD20x663Yq0gj11HicsJklLrzTFyGZyhhYiylKWw2jR0lS+2F0MXdE99sA==
Date:   Mon, 28 Aug 2023 00:06:03 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org, Mike Looijmans <mike.looijmans@topic.nl>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtc: pcf85363: Allow to wake up system without IRQ
Message-ID: <169317395197.539620.17567585510598323528.b4-ty@bootlin.com>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.ab3cda0d-1169-470b-8cf3-51ba15343c59@emailsignatures365.codetwo.com>
 <20230821072013.7072-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821072013.7072-1-mike.looijmans@topic.nl>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Aug 2023 09:20:13 +0200, Mike Looijmans wrote:
> When wakeup-source is set in the devicetree, set up the device for
> using the output as interrupt instead of clock. This is similar to
> how other RTC devices handle this.
> 
> This allows the clock chip to turn on the board when wired to do
> so in hardware.
> 
> [...]

Applied, thanks!

[1/1] rtc: pcf85363: Allow to wake up system without IRQ
      commit: 1e786b03705938870dafb629f2248f88d507a0ff

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
