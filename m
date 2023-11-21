Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959317F29F5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjKUKRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjKUKRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:17:23 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B6E10E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:17:18 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:6bd9:a79:1d00:5285])
        by baptiste.telenet-ops.be with bizsmtp
        id CyHB2B00Z0Wid3g01yHB4U; Tue, 21 Nov 2023 11:17:16 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1r5Nod-009vBm-RS;
        Tue, 21 Nov 2023 11:17:11 +0100
Date:   Tue, 21 Nov 2023 11:17:11 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Claudiu <claudiu.beznea@tuxon.dev>
cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v3 5/9] irqchip/renesas-rzg2l: Implement restriction when
 writing ISCR register
In-Reply-To: <20231120111820.87398-6-claudiu.beznea.uj@bp.renesas.com>
Message-ID: <86e165a-fcce-4877-c59a-afaeefd9a42d@linux-m68k.org>
References: <20231120111820.87398-1-claudiu.beznea.uj@bp.renesas.com> <20231120111820.87398-6-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1279773061-1700561831=:2361084"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1279773061-1700561831=:2361084
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 20 Nov 2023, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The RZ/G2L manual (chapter "IRQ Status Control Register (ISCR)") describes
> the operation to clear interrupts through the ISCR register as follows:
>
> [Write operation]
> When "Falling-edge detection", "Rising-edge detection" or
> "Falling/Rising-edge detection" is set in IITSR:
> - In case ISTAT is 1
> 	0: IRQn interrupt detection status is cleared.
> 	1: Invalid to write.
> - In case ISTAT is 0
> 	Invalid to write.
>
> When “Low-level detection” is set in IITSR.:
> 	Invalid to write.
>
> Take the interrupt type into account when clearing interrupts through
> the ISCR register to avoid writing the ISCR when interrupt type is
> level.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
--8323329-1279773061-1700561831=:2361084--
