Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C5E7930D5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243883AbjIEVP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbjIEVP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:15:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75423B8;
        Tue,  5 Sep 2023 14:15:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06260C433C7;
        Tue,  5 Sep 2023 21:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693948523;
        bh=1pdQsTvxS6GAHzbsLvraJ8XaQMyxfYiRxjVALwTCHOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ippbUdejxKQ1jDq3bWA2SrVcrfPNp/UFkH8M37LZS2l3+QClFBWy9ja9nQTxYsWGf
         /nXc7OGo1Yv5JFJ5THJQam+kHuqJH3CPKVYYDJcNklhOHcm+4QYzdt/7bWmmIpZ4gG
         iYehm+LFFNQWuMbNhU3Z5AQrHZO41gQDmavifArbXTQGc1INcdN3qXG69QLVgKnNV0
         /Os5OpjGqraWYeNjuAMDRwGEU8Co3h1SRgNu53G0w+VXAAVQ6IIFC/U+i/mXN+mknX
         5mgRZx5vIX1dNJOlsI/e+lRFFnFymDsfyr0Z4ofE+C968pKSNW+yj5W3Dq094Z0Wyq
         KQ1/j/h5YJyKw==
Received: (nullmailer pid 4030509 invoked by uid 1000);
        Tue, 05 Sep 2023 21:15:15 -0000
Date:   Tue, 5 Sep 2023 16:15:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4] dt-bindings: irqchip: convert st,stih407-irq-syscfg
 to DT schema
Message-ID: <169394850991.4030364.7708098240384382428.robh@kernel.org>
References: <20230905072740.23859-1-rgallaispou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905072740.23859-1-rgallaispou@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 05 Sep 2023 09:27:40 +0200, Raphael Gallais-Pou wrote:
> Convert deprecated format to DT schema format.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes in v2:
> 	- Added Conor's r-by
> 	- Removed quotes surrounding $refs
> 	- Hardcoded 'st,invert-ext' possible values
> 
> Changes in v3:
> 	- Fixed enum syntax warnings
> 	- Removed reference to driver in favor of device
> 
> Changes in v4:
> 	- Make clearer description for "st,invert-ext" property
> 	- Handle better bitwise logic
> ---
>  .../st,sti-irq-syscfg.txt                     | 30 ---------
>  .../st,stih407-irq-syscfg.yaml                | 65 +++++++++++++++++++
>  2 files changed, 65 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml
> 

Applied, thanks!

