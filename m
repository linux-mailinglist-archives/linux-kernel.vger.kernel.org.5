Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B046E7F5D06
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344954AbjKWKzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344883AbjKWKzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:55:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BB310C4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:55:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9429DC433C8;
        Thu, 23 Nov 2023 10:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700736910;
        bh=NGJuny/T+fyg0bzZg8rPSHmJVa/rpExZEmSSYXneMOg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DQDoVQ795iRe1AeJ0JE0DdQLKCHM4AMUcZd6QEjh2vi6f+YXd2u3WvyvdLBl0Oi0P
         huPpFsn58tBf+keKnxM0QvYeQXJDLg1+bnXHmslVns0T5uATrg/W5BeMXPacUQksxj
         TRX/HuQccMzyCcCuUbVBb88ETEpQCnFMJiDRMIOuwoLgjUCAmzBjr68DW2m60YNLp0
         SO+n86vKNJ40PV39QkNDdKAoiv+iNoSgf5IBk+YP95bZL2k6SWKIK3IxGnIvxBTV8p
         t50AMXEu4iRdmzdvehN7QV4rvKlI6Kry/UO1BFpc4qIaQJ60NQi/30PJI8dvsIMKij
         ptAf+w0t6mdsg==
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        John Watts <contact@jookia.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Trevor Woerner <twoerner@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev
In-Reply-To: <20231029212738.7871-1-samuel@sholland.org>
References: <20231029212738.7871-1-samuel@sholland.org>
Subject: Re: (subset) [PATCH v8 0/5] leds: Allwinner A100 LED controller
 support
Message-Id: <170073690632.1239913.13249026950783494795.b4-ty@kernel.org>
Date:   Thu, 23 Nov 2023 10:55:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2023 16:26:54 -0500, Samuel Holland wrote:
> This series adds bindings and a driver for the RGB LED controller found
> in some Allwinner SoCs, starting with A100. The hardware in the R329 and
> D1 SoCs appears to be identical.
> 
> This series was tested on the Nezha board (one onboard LED) and the
> Dongshan Nezha STU board (with an external strip of 16/32/48 LEDs, also
> with gaps in the LED addresses).
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: leds: Add Allwinner A100 LED controller
      commit: 57ef666e1586823adc1b7909ed3472dec117df1f
[2/5] leds: sun50i-a100: New driver for the A100 LED controller
      commit: 090a25ad97983720f52b11d9c5a8d1a446217c1d

--
Lee Jones [李琼斯]

