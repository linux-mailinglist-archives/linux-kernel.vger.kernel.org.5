Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179B078A274
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 00:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjH0WDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 18:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjH0WCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 18:02:48 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF90122;
        Sun, 27 Aug 2023 15:02:45 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 05F0E20002;
        Sun, 27 Aug 2023 22:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693173764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AMtPInGUsfczSnB1TI2Et6oH9omhoMU8QOgRekdB0bY=;
        b=ScRlKBmDLloYSZdl6dsTrcFQ9BRTGiM8nq2bMzcfFqFPNjoXemSibGTCeX8vkVCzIvESn6
        70gmhgiLOh6UG7lw5q32rfp0nG4+vleRG1xj4ByqQPfTeWEbwC6vO8NyPLZFqIWkw1EpDQ
        JASUuqV+FtLelEZiz9n0C0ulJtJWm0bpmbLIYaa0nWK+LGNzxmj6OnBskMlHoFYmL2yUSO
        eHkQIyESpX6d5qrH6sdz50sT1AtPb6kHxWdd/ghZIJQNhqPXz8Lhrd3XxhxFD6Gu2vwZv4
        JODmvemrYo3/lmB4H82WVtsdGFiV+ijISWSbmMW4aewTq204V+qR9S7Un+2wFA==
Date:   Mon, 28 Aug 2023 00:02:42 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 0/2] device tree support for ST M48T86
Message-ID: <169317374591.539206.3523750932599468073.b4-ty@bootlin.com>
References: <20230823-m48t86_device_tree-v2-0-21ff275f949d@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823-m48t86_device_tree-v2-0-21ff275f949d@maquefel.me>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 25 Aug 2023 11:43:24 +0300, Nikita Shubin wrote:
> Add device tree support for ST M48T86.
> 
> The reason it can't go to trivial-rtc.yaml, is that it has 2 registers
> instead of a single one. The registers are 1 byte wide.
> 
> 

Applied, thanks!

[1/2] dt-bindings: rtc: Add ST M48T86
      commit: a5aeccabb53673331f78a97ce492ce6d01f1e036
[2/2] rtc: m48t86: add DT support for m48t86
      commit: 6ec3f5ec2eecabab065a39f5e04562c8c3c81ece

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
