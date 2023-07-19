Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A8775A075
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 23:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjGSVRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 17:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjGSVRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:17:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6EA1FE6;
        Wed, 19 Jul 2023 14:17:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0A6561831;
        Wed, 19 Jul 2023 21:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BAAC433C8;
        Wed, 19 Jul 2023 21:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689801427;
        bh=AHWnayYkjPbIUyAqedX2DKfC5RK8iRkSYADpwtoqOus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C3J4qTBdZhicQXbHclrOkNHlzo/gvv0LOzVQ/XJxHdRFa2HcP0i6h9YDYv86QIqVb
         l8So39bb/B8BY266b2SoAEn/LJqmYbaTlxT7pEnYIUs+RUGE0Zy8WFnDeSREdu9/AK
         mw0d17vJqQ3tse7fC4rsZdrQ8DS6DzsfkhTVA31AOblQ5v4eLf3XNQNXQhMQ8wiPoa
         DYdiBSL4BKvHVz2Lv9CeEddPFkK4fQebHzczPzHdZXPGSQuimI9qyG1yD9RdRtu7T5
         0wfrycAQXno8Jg6R97m3lABPKuxvfPy0TkDRlGv9kb1eaqBMqJUW6pselNxeC7878u
         Fzj53V5FVa70Q==
Received: (nullmailer pid 809255 invoked by uid 1000);
        Wed, 19 Jul 2023 21:17:05 -0000
Date:   Wed, 19 Jul 2023 15:17:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eugen Hristev <eugen.hristev@collabora.com>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        david.wu@rock-chips.com, heiko@sntech.de, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: net: rockchip-dwmac: add default 'input'
 for clock_in_out
Message-ID: <168980142508.809195.11041309654523921501.robh@kernel.org>
References: <20230718090914.282293-1-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718090914.282293-1-eugen.hristev@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Jul 2023 12:09:14 +0300, Eugen Hristev wrote:
> 'clock_in_out' property is optional, and it can be one of two enums.
> The binding does not specify what is the behavior when the property is
> missing altogether.
> Hence, add a default value that the driver can use.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

