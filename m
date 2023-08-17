Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E72777F3EE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349839AbjHQJ4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343760AbjHQJzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:55:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064BB12C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:55:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DECE63944
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96352C433CD;
        Thu, 17 Aug 2023 09:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692266133;
        bh=g55SepoXLDrkk51p7rxR8hHGhpvN+y+XxCr1EgXQE50=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WVt2sdLPMPMqAvlPszVHFgZ31LEim75KL+bszsgTWc/PvN3CEHPLnP3Pflv6XLUaS
         6ScWiqmQnYwCdisESHLUCVEOUsX3TqwIIZch+GcT4+i+mZuf9kRS2lL/1DPr98eypB
         62SjT6c8PRTcVWySdH7f/apYC6aqSETnT4vf9lRWlmR7wQktz8+V0flgfi0qoBlC8L
         0tPSpFUdSqh583VPKDV1aa1AoHt8DEb1z8P9X3A9SFK+VZDNtU3Tb+mM4OjVae3bcO
         v/SIzHUGHzDf1GgdnQRksMaX+0O7HsxQwfp/fBM3JOSuNCClrPW1InwecMjl6/QhOJ
         s1G68nluZmOog==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andi Shyti <andi.shyti@kernel.org>
In-Reply-To: <20230810091310.70231-1-krzysztof.kozlowski@linaro.org>
References: <20230810091310.70231-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH net-next] phy: amlogic: meson-g12a-usb2: fix
 Wvoid-pointer-to-enum-cast warning
Message-Id: <169226612922.81413.13715336314388096096.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 15:25:29 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Aug 2023 11:13:10 +0200, Krzysztof Kozlowski wrote:
> 'soc_id' is an enum, thus cast of pointer on 64-bit compile test with
> W=1 causes:
> 
>   phy-meson-g12a-usb2.c:322:17: error: cast to smaller integer type 'enum meson_soc_id' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> 
> 

Applied, thanks!

[1/1] phy: amlogic: meson-g12a-usb2: fix Wvoid-pointer-to-enum-cast warning
      commit: b72d87b4cb67984419502eb7c16adfea48cc56aa

Best regards,
-- 
~Vinod


