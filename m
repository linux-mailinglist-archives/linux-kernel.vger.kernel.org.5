Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFBF7B4A26
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 00:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbjJAWP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 18:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjJAWPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 18:15:54 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA86EC9;
        Sun,  1 Oct 2023 15:15:49 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4741240004;
        Sun,  1 Oct 2023 22:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696198548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/SsZi+iVDpEfcW2Rw2EygbcoFHxEabWIyFXdYHj6oF4=;
        b=c+BtiD60zMSUpKV9bxPgzB58OqGrYtkeYrlfRKEZbHRzODyrjc/RYYuFwVduYGebIDu8GK
        VmEeMYoofAjcxOe1l678KDwSvbnBG9eEHuNzf5tekQWsvqsups9l6KSUj+kTI80pdYct9f
        rOPAwrOkW6jaDF2r+DZvH2ChLCMjz9ys5rYMvOd/jqvstOI6yawf+QEHnebzBjEl870KgZ
        HMY2ja8fhbiPlAcZ7oAK5QBAPiU2FR71S+00InRYnsw8UHKJvYIhPL8MWytkUKk9CW5UnG
        WGIO0cyH7IteTUMf00tP6OzNNNZ+wfJn9vCRgj/VvyZKNlF5s/cndH+X2yMqXQ==
Date:   Mon, 2 Oct 2023 00:15:46 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Doug Berger <opendmb@gmail.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: brcmstb-waketimer: support level alarm_irq
Message-ID: <169619847484.983861.17385329877988122410.b4-ty@bootlin.com>
References: <20230830224747.1663044-1-opendmb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830224747.1663044-1-opendmb@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Aug 2023 15:47:47 -0700, Doug Berger wrote:
> Some devices (e.g. BCM72112) use an alarm_irq interrupt that is
> connected to a level interrupt controller rather than an edge
> interrupt controller. In this case, the interrupt cannot be left
> enabled by the irq handler while preserving the hardware wake-up
> signal on wake capable devices or an interrupt storm will occur.
> 
> The alarm_expired flag is introduced to allow the disabling of
> the interrupt when an alarm expires and to support balancing the
> calls to disable_irq() and enable_irq() in accordance with the
> existing design.
> 
> [...]

Applied, thanks!

[1/1] rtc: brcmstb-waketimer: support level alarm_irq
      commit: e005a9b35b464be5b2e0194f717e90e7e496785d

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
