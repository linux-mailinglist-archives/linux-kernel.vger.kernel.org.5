Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D77790B83
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 13:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbjICLAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 07:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbjICLAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 07:00:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAAADC;
        Sun,  3 Sep 2023 04:00:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2C74ACE0959;
        Sun,  3 Sep 2023 11:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27EBC433C8;
        Sun,  3 Sep 2023 10:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693738798;
        bh=wVketto36Nxx/Uhx0mBINXNgcZs2dt65qgJnk9mferM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RJFp43KmxU22SzkInY+AONEEJm8eJhflD/2KzGPoKbJVEPWCWdL9kbBpYfKPnqcbF
         tmO0MKVp6ZKanpqo/9TBlt6VkNz/UsBQonJBFWHduE7OuPIq5n04eNKEiT8VfNu5mN
         tYxtdyuWTT7m/Y5BXV/i3h9cGSDNl0XHNMSiJ644Ql8mddWXP7zlJzbBEgW4B/92dN
         t7LF72KNaAoaPQON4PQVnGbB5FqNiI04pihl7ok8Lk18PN0uFXlLU6TInOcGjPFWEq
         fbWcx87cw+0DUfTQ8w7Av/bSxX0qj/N3GxVwX0UsFPwZV+X+kFcLJQn1a+b0S5xJSm
         SQxPZIHSy3Vcg==
Date:   Sun, 3 Sep 2023 12:00:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: rohm,bu27010: add missing vdd-supply
 to example
Message-ID: <20230903120024.44054aa7@jic23-huawei>
In-Reply-To: <20230811151755.GA3484524-robh@kernel.org>
References: <20230808063223.80431-1-krzysztof.kozlowski@linaro.org>
        <20230811151755.GA3484524-robh@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 09:17:55 -0600
Rob Herring <robh@kernel.org> wrote:

> On Tue, Aug 08, 2023 at 08:32:23AM +0200, Krzysztof Kozlowski wrote:
> > Bindings require vdd-supply but the example DTS was missing one.  This
> > fixes dt_binding_check error:
> > 
> >   Documentation/devicetree/bindings/iio/light/rohm,bu27010.example.dtb: light-sensor@38: 'vdd-supply' is a required property
> > 
> > Fixes: ae8c47c51e5c ("dt-bindings: iio: ROHM BU27010 RGBC + flickering sensor")
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml | 1 +
> >  1 file changed, 1 insertion(+)  
> 
> Acked-by: Rob Herring <robh@kernel.org>
Applied to the fixes-togreg branch of iio.git.
Note I want to rebase that on rc1 before sending next pull request so it will be a week or two.

Thanks,

Jonathan
