Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3407E4623
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbjKGQgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbjKGQfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:35:53 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0367F1BCF;
        Tue,  7 Nov 2023 08:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=QR8eNGZtZ5/4gDAfH5F8xdJ5v45aXKC3TOBwTCF9ej8=; b=ajgl1Gz6XOyG4dhnPFkvUlQBx1
        M7E8WvCd7CqEbNY6qVXRXFdh3EUHT3GUSQTqUOvHtdNYPDu8iSaro4oddNA9caXjPU7otOvdZiv85
        pFLtkNCqgyLLF+Ys/fThfiTX4SDgNzznSx9dx0mmViWNm/nqXhAdiFNbBlaqf3/8OwoQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:60652 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1r0Ovt-0007qL-5P; Tue, 07 Nov 2023 11:28:05 -0500
Date:   Tue, 7 Nov 2023 11:28:04 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-Id: <20231107112804.e854521b47caeafdc642a2f3@hugovil.com>
In-Reply-To: <8534fc67-83b3-4f41-a1e3-635866e1dd9c@linaro.org>
References: <20231107160122.1648093-1-hugo@hugovil.com>
        <8534fc67-83b3-4f41-a1e3-635866e1dd9c@linaro.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.hugovil.com
X-Spam-Level: 
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        * -2.3 NICE_REPLY_A Looks like a legit reply (A)
X-Spam-Status: No, score=-3.4 required=5.0 tests=ALL_TRUSTED,NICE_REPLY_A,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH] arm64: dts: imx8mn-var-som: reorder reg properties
 after compatible strings
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023 17:19:20 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 07/11/2023 17:01, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Move reg nodes after the compatible string, to follow DT conventions.
> 
> This is a bit of churn... like patches for checkpatch. But unlike
> checkpatch, it's not even documented.

Hi,
I do not really understand your point or if I must change
something...

But looking at a lot of dts, the reg property is always following the
compatible string, so I assumed it was an undocumented convention or
best practice...

Hugo.
