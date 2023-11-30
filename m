Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897A27FF134
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345828AbjK3OHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345768AbjK3OHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:07:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0858DB9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:07:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D328AC433C8;
        Thu, 30 Nov 2023 14:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701353244;
        bh=bP9gIF1qF4Nngoergf+YlwyvyidP2LRuh9f3flnifSY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eY+/hjb80pvffUfR18Y/9t5vQLaXI8OQZYlKum3cDsd78XY3r5g5GWpgWZ4gvGDdl
         HITSTSNCFUBxnmh4Opngyi37KaxBariH7lFbnN2/Zw3kex6UE0zgCsKl+A+b9QAOIC
         I3NMNIyf5aaAPNE8KgbWijORy4tMKxxKgkIFiFjPe3VecTS7eWfDf+CZL2W9W2YrBP
         hp6nYbbKFHeF16SX1whX1bXKYZQ9rGmGTw27gYUdTmaAO/tCTPEzicQib8KhMaMUHb
         dnaGNan328aAKNs17uGN9Fe758NR2xXIEEDI5YuWvyuS9qmWMz+1iLSkvc9ZvRTyT5
         w39p+DfIhASog==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        miquel.raynal@bootlin.com, Santhosh Kumar K <s-k6@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20231124045019.21003-1-s-k6@ti.com>
References: <20231124045019.21003-1-s-k6@ti.com>
Subject: Re: (subset) [PATCH v2] dt-bindings: mfd: ti,am3359-tscadc: Allow
 dmas property to be optional
Message-Id: <170135324258.3259675.3935588909848820.b4-ty@kernel.org>
Date:   Thu, 30 Nov 2023 14:07:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2023 10:20:19 +0530, Santhosh Kumar K wrote:
> ADC module can function without DMA, so there may not be dma channel
> always associated with device. Hence, remove "dmas", "dma-names" from list
> of required properties.
> 
> 

Applied, thanks!

[1/1] dt-bindings: mfd: ti,am3359-tscadc: Allow dmas property to be optional
      commit: 968baa6a0c18a3bd0f5bb7c4b50ba3081e2a64cf

--
Lee Jones [李琼斯]

