Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152FE7910F9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 07:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345283AbjIDFmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 01:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjIDFml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 01:42:41 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480B9B6;
        Sun,  3 Sep 2023 22:42:37 -0700 (PDT)
X-QQ-mid: bizesmtp69t1693806064t61ncw53
Received: from wangjiexun-virtual-machine.loca ( [120.225.34.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 04 Sep 2023 13:41:02 +0800 (CST)
X-QQ-SSF: 01200000000000001000000A0000000
X-QQ-FEAT: rZJGTgY0+YOS3vKl0NMirRR1pAhmed70/gLFuj/Gr660BtUWLKoHQ7PnNRXSp
        X4pSLbZOdfAkBI4khh9tRvTDbOaTQlmcKegcyzoPBsaxHw25F18pQGBZDtYpE5OJ3kdPkqE
        zwijwvHa/JIzv4ytcLinIVlEorFNeSv09106k4IKEpljgzyNnhgo+tah2zJJLYl1k8XWr4+
        eOKAT4b8ezpPcdUycki4Vdq+okzxerMB29oA6vgy7xa29tA7V8mwxuxL8Y5LtlGjkwYIyH6
        UYM2lN8Xy7WdmPIEXzR+HvsbvAOP+0YgUBM8CSyYsM4HgldighDFRgGbHJ6uj0goaRS1z8o
        L2CcmKGSJ7jAzVqa4fUbg/AWACFeCZJeUqWmjDi
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4421248991332191876
From:   Jiexun Wang <wangjiexun@tinylab.org>
To:     jszhang@kernel.org
Cc:     alexandre.torgue@foss.st.com, conor+dt@kernel.org,
        davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, joabreu@synopsys.com,
        krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        pabeni@redhat.com, peppe.cavallaro@st.com, robh+dt@kernel.org,
        simon.horman@corigine.com
Subject: Re: [PATCH net-next v2 0/3] add the dwmac driver for T-HEAD TH1520 SoC
Date:   Mon,  4 Sep 2023 13:41:00 +0800
Message-Id: <20230904054100.142575-1-wangjiexun@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230827091710.1483-1-jszhang@kernel.org>
References: <20230827091710.1483-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 05:17:09PM +0800, Jisheng Zhang wrote:
>Add the dwmac driver support for T-HEAD TH1520 SoC.
>
>Since the clk part isn't mainlined, so SoC dts(i) changes are not
>included in this series. However, it can be tested by using fixed-clock.
>
>Since v1:
>  - rebase on the lastest net-next
>  - collect Reviewed-by tag
>  - address Krzysztof's comment of the dt binding
>  - fix "div is not initialised" issue pointed out by Simon
>
>Jisheng Zhang (3):
>  dt-bindings: net: snps,dwmac: allow dwmac-3.70a to set pbl properties
>  dt-bindings: net: add T-HEAD dwmac support
>  net: stmmac: add glue layer for T-HEAD TH1520 SoC
>
> .../devicetree/bindings/net/snps,dwmac.yaml   |   2 +
> .../devicetree/bindings/net/thead,dwmac.yaml  |  77 +++++
> drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
> drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
> .../net/ethernet/stmicro/stmmac/dwmac-thead.c | 302 ++++++++++++++++++
> 5 files changed, 393 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/net/thead,dwmac.yaml

I would like to try this patch on my LicheePi 4A board, 
but I don't know how to modify the dts file.
Could you please share your modifications to the dts file?
Thank you very much.

Best regards,
Jiexun Wang
