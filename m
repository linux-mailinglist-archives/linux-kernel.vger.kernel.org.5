Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CD7760218
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 00:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjGXWRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 18:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjGXWRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 18:17:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355FE10CB;
        Mon, 24 Jul 2023 15:17:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABE8461455;
        Mon, 24 Jul 2023 22:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712FAC433C7;
        Mon, 24 Jul 2023 22:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690237040;
        bh=oGdT49PMKcFXsNyj44mx+Yx2XSjpJK4Q9Be2rHyZEmo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m4cHNhTjzfUqMOqTsecbMCF1qHTAGGPkpiuQZVRsFnRng/CBKyEixwTbjLmEoRyZD
         OKdUWiFoSVrz/qChBNUNa1MPwEkmIg5lgm+ipO1bbQre1yp0XyWY+vtt9WTIv511wB
         UiTpaCn6Mx/TMmDKlIYBpGgIUsgXLwhznkieUNuUfTJMz4qLGUkMs/VueJuyqQKpIV
         3K+Oz0t7jSxFrOeUA6k5HVToiH0KSkhiRHnfGapghpDV3GXe/sDbqtQRz6xNfSbETN
         1WQkpazBeQxhwpUesHZVu0JqhYvhs4RkXmOk6UQi6a45mWSYPdxkVod3moyZJaI8br
         u1A5EtbSyQRlw==
Date:   Mon, 24 Jul 2023 15:17:19 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 00/10] net: stmmac: add new features to xgmac
Message-ID: <20230724151719.145d16b9@kernel.org>
In-Reply-To: <20230723161029.1345-1-jszhang@kernel.org>
References: <20230723161029.1345-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2023 00:10:19 +0800 Jisheng Zhang wrote:
> This series add below new features to xgmac:
> 
> correct RX COE parsing
> add more feature parsing from hw cap
> enlarge C22 ADDR and rx/tx channels
> support parse safety ce/ue irq from DT
> support per channel irq

Giuseppe, please take a look (try 3/3).
