Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFA3801919
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441967AbjLBAoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBAoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:44:14 -0500
Received: from mail.rnplus.nl (mail.rnplus.nl [178.251.25.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05051103
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:44:20 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.rnplus.nl (Postfix) with ESMTP id 334CA37943B
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 00:45:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at rnplus.nl
Received: from mail.rnplus.nl ([127.0.0.1])
        by localhost (mail.rnplus.nl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fWSDXnqFio7T for <linux-kernel@vger.kernel.org>;
        Sat,  2 Dec 2023 01:45:57 +0100 (CET)
Received: from werkpc.localnet (87-101-2-254.dsl.cambrium.nl [87.101.2.254])
        by mail.rnplus.nl (Postfix) with ESMTPSA id B90863793AD;
        Sat,  2 Dec 2023 01:45:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rnplus.nl; s=dkim;
        t=1701477956; bh=yRBPEQxU6QTn7AumN8CC7LcN7WuQwY78yyLiGx2740g=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=0W7GSsCGwYC8FMG7Ils5SuWyAqyZJGF8bDINj62Wqb53kV2eBh6mstVrI+f4phf/I
         6FdLKR168fsp2mZBV1EVnedjh6vFwfmvY2DxrSpFNCbAI8h0q9V3+9AREQe7M4IlYx
         BYCR+gz0WJ2UOmyxJgVaMMPUQBUSTZuGEyDbk2Xg=
From:   Renze Nicolai <renze@rnplus.nl>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        renze@rnplus.nl
Subject: Re: [PATCH v3 0/2] ARM: dts: aspeed: asrock: Add ASRock X570D4U BMC
Date:   Sat, 02 Dec 2023 01:44:17 +0100
Message-ID: <12332130.O9o76ZdvQC@werkpc>
In-Reply-To: <20231202003908.3635695-1-renze@rnplus.nl>
References: <20231202003908.3635695-1-renze@rnplus.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

A small addition to my cover letter for v3 of the patch:

I forgot to mention in the changelog from v2 to v3 that I also modified the 
tachometer configuration to correctly map the tachometer inputs to the fan 
headers on the board.

Greetings,
Renze Nicolai

On Saturday, December 2, 2023 1:38:43 AM CET you wrote:
> Hello,
> 
> These patches add a device-tree (and a bindings update) for the
> Aspeed BMC on the ASRock X570D4U, so that it can be added as a
> supported OpenBMC platform.
> 
> Changes since v2:
>   - Renamed leds to led-0 and led-1 to match
> Documentation/devicetree/bindings/leds/leds-gpio.yaml - Added aliasses and
> labels for the i2c-mux on i2c bus 4
>   - Added the missing blank line between the ehci1 and uhci nodes
> 
> Greetings,
> Renze Nicolai
> 
> Renze Nicolai (2):
>   dt-bindings: arm: aspeed: add Asrock X570D4U board
>   ARM: dts: aspeed: asrock: Add ASRock X570D4U BMC
> 
>  .../bindings/arm/aspeed/aspeed.yaml           |   1 +
>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../dts/aspeed/aspeed-bmc-asrock-x570d4u.dts  | 377 ++++++++++++++++++
>  3 files changed, 379 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts




