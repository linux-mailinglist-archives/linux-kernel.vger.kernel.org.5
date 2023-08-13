Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABF577A762
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjHMPY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjHMPY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:24:57 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF97E0;
        Sun, 13 Aug 2023 08:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=D6GK4r3g2pMNaj1/iMHxZq3AeQCZgFzlhT3OyuIGXJg=; b=uRaBb/AjtZ/XDK/WInjRB3JU3o
        6m1Wl7WsYf6RGEtONjYbrd/7QyYu6c5BD4/xibXyQvgO7IhbBfjPnsfsQZcS6PI3yCfuYtqEjCSDc
        ila7+dAYUp4jG02OEh/FfPskHSsqoYuKlBRhuu983PnIRovYNRIDZ+tSL4tRFKt2iPc8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qVCxZ-003yRr-Jv; Sun, 13 Aug 2023 17:24:53 +0200
Date:   Sun, 13 Aug 2023 17:24:53 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>
Subject: Re: [PATCH 0/5] Move Loongson1 MAC arch-code to the driver dir
Message-ID: <2ed268fd-113a-4da0-8f33-04d618053dca@lunn.ch>
References: <20230812151135.1028780-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812151135.1028780-1-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 11:11:30PM +0800, Keguang Zhang wrote:
> From: Kelvin Zhang <kelvin.zhang@amlogic.com>
> 
> In order to convert Loongson1 MAC platform devices to the devicetree
> nodes, Loongson1 MAC arch-code should be moved to the driver dir.
>     
> In other words, this patchset is a preparation for converting
> Loongson1 platform devices to devicetree.

It is a long time since i converted an ARM system from platform data
to DT. But what we tended to do was to allow both for a period of
time.

Does a system using platform data still work after this change? The
first patch seems to delete a lot of code, not just move it around.

Can you restructure this patchset to add the glue layer and DT binding
in parallel with platform data. Then have a patchset which convert all
in tree machines to using DT. And then a patchset, submitted in maybe
6 months time, to remove support for platform data.

	Andrew
