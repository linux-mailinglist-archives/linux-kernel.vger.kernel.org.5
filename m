Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D93077EDB8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 01:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347122AbjHPXNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 19:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbjHPXMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 19:12:42 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302261FD0;
        Wed, 16 Aug 2023 16:12:38 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EFFFB60002;
        Wed, 16 Aug 2023 23:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692227556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+cNIQCtmsqP2mtuK62V1ZfPe0/9W8rHxAtBOoi7izRo=;
        b=g35VAb2teaZt3XGB5ItvtwUfMGdp8zwhrPHa9Gm4ZhTf/ebm95UF3l9duG4LpCGib5KFGs
        n8j/XifY54gCjeAsLScvbB5KUiHhEBmbnPxtzKbqqrbB2WH0xAz6s99cV+9MNdGVKQ5Df4
        vFNjIPoSIklfb0ses+okl3UWyymWJF7wOkebJzWEoAL1DHuG0JudYHOKaKw9cmEeMx2Jny
        K1PR0qY9oxSbcwSCPU112aXtmciBTs0Iok/xCMxdQb98OPODCOZdf6lecQw3SCVeThDbPF
        EJnx+lVF+ZtiY1VzrcWNEzlqA+28A2ZT3wOFjVIHmkdBLrT0VqtGN9ez6S7nyw==
Date:   Thu, 17 Aug 2023 01:12:34 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Support Opensource <support.opensource@diasemi.com>,
        Samuel Holland <samuel.holland@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: da9063: Mark the alarm IRQ as a wake IRQ
Message-ID: <169222751518.122747.12422973753007463248.b4-ty@bootlin.com>
References: <20230717190937.1301509-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717190937.1301509-1-samuel.holland@sifive.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Jul 2023 12:09:37 -0700, Samuel Holland wrote:
> This keeps the IRQ enabled during system suspend, if the RTC's wakeup
> source is enabled. Since the IRQ is not required to wake from shutdown,
> continue to add the wakeup source even if registering the wakeirq fails.
> See commit 029d3a6f2f3c ("rtc: da9063: add as wakeup source").
> 
> 

Applied, thanks!

[1/1] rtc: da9063: Mark the alarm IRQ as a wake IRQ
      commit: ed17a2bcbb75505bb979e3e8ecb6c5fb2518bf3b

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
