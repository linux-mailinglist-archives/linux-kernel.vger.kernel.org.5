Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5466E7C9BCC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 23:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjJOVQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 17:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJOVQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 17:16:24 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E75AA1;
        Sun, 15 Oct 2023 14:16:22 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 06986240002;
        Sun, 15 Oct 2023 21:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697404577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EGywzKZdFtwdrYNhyH7b3glgSwfEO4bz01ZWwcPNTSI=;
        b=ZfoVRvjVMvDJEIFHPs9WErdaBSS/tk0OyweMZ5MZpFR/7ZOlJ2zVhYnlbqliCwr7JlKbiw
        IaIj5FbcRLNIjY3Vn4zicJTpEPfcP6geJpca3axw+ZRFqB5Xi199ZD8xRQ1Mxf9+Xyjmcf
        pSmTCkUUCMqN4K2gSa8OrpDYXCu9WVc15ggZLmml3QWbZg1R23TVzoRUYTxl6k1xg9DOIf
        3/baRnUb4iCanG0P6NCSJzZzGeR+yDt+7zOroCRSDLBlI0PQ5lHTUx8kkHLHHxaeqVs1LJ
        tFcBXUrTRAaCuEVul5gqWX4GxSVJMXqYy7th0+l9KTR84OrpsXoRtvBlu4fd7Q==
Date:   Sun, 15 Oct 2023 23:16:16 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: rtc: pcf2123: convert to YAML
Message-ID: <169740456168.178194.5589245634078724588.b4-ty@bootlin.com>
References: <20230907-topic-pcf2123_yaml-v2-1-ea87a8e12190@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907-topic-pcf2123_yaml-v2-1-ea87a8e12190@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 14 Sep 2023 11:07:59 +0200, Javier Carrasco wrote:
> Convert the existing txt binding to the preferred YAML format.
> 
> The pcf2123 node may contain SPI settings such as spi-cs-high and
> spi-max-frequency, which keeps it from being added to the trivial-rtc
> binding with its current definition. Add a reference to
> spi-peripheral-props.yaml to account for that.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: rtc: pcf2123: convert to YAML
      commit: fdaf4c5acf268bfcc455d8c2ab775cd54317c788

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
