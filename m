Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFF577FCE1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353937AbjHQRTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242937AbjHQRTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:19:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53815358E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:19:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE45B66EA5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 17:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B800C433C7;
        Thu, 17 Aug 2023 17:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692292762;
        bh=iHIfK/mk9Pz261VmV7TPqv4tXFXcg5nMmuiazYWbCBw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GC8cIiXAKmlBhvVE+7A2h95aT3jTrFYY9OtCYVzfJAh/vVzRiGloDobPjfNznvzGz
         lW2Lz+Mpb/xo6CVEfRG0ug1XjJk+X+cr7oLZi4/68oweQXyENRc8cC8TRWDfrI4sct
         7YUvgEk+m4hRmqPLvV231h7GE6twilAhwDuMIvoUYsSCvzcyrNiUYKRGQ4Sqa4U+D6
         T3BrpK2TbzGYA0TykvjOY68APfBPgBOw1MYnvYkIoucU/43WfH2w6RGFlPmDpQ2zDT
         JHXP3PL1wNqRAW7t/Q2PhhLJLOYAGljsF+m70p/RO1qexobTaz3uwyv32JAKuEWVYq
         kxLR81oLB+Bhg==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        patches@opensource.cirrus.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andi Shyti <andi.shyti@kernel.org>
In-Reply-To: <20230810095849.123321-1-krzysztof.kozlowski@linaro.org>
References: <20230810095849.123321-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/9] mfd: stmpe: Fix Wvoid-pointer-to-enum-cast warning
Message-Id: <169229275920.1072243.16297304606056880279.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 18:19:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 11:58:41 +0200, Krzysztof Kozlowski wrote:
> 'partnum' is an enum, thus cast of pointer on 64-bit compile test with W=1
> causes:
> 
> stmpe-i2c.c:90:13: error: cast to smaller integer type 'enum stmpe_partnum' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> 
> 

Applied, thanks!

[1/9] mfd: stmpe: Fix Wvoid-pointer-to-enum-cast warning
      commit: ee1a91ee7729b56535bce753c5a8146ec58aa0c6
[2/9] mfd: max14577: Fix Wvoid-pointer-to-enum-cast warning
      commit: e3569bd687ebbb35339aa8699311c28770d3a3b6
[3/9] mfd: max77541: Fix Wvoid-pointer-to-enum-cast warning
      commit: d964ac59516ca77c0761d73681d7975e33ddfeae
[4/9] mfd: hi6421-pmic: Fix Wvoid-pointer-to-enum-cast warning
      commit: bbf26b17476c8528a3dc903f5550e89bdca7aa72
[5/9] mfd: lp87565: Fix Wvoid-pointer-to-enum-cast warning
      commit: d3cf4d705563d26e02e8997cc2cf297542abdadf
[6/9] mfd: tc3589: Fix Wvoid-pointer-to-enum-cast warning
      commit: 499e6c7904a5d1860651ec2437a9873e2b9aa1f0
[7/9] mfd: wm8994: Fix Wvoid-pointer-to-enum-cast warning
      commit: b53cd2fb2769dd8c082adaaa8f1746265a9ca732
[8/9] mfd: wm31x: Fix Wvoid-pointer-to-enum-cast warning
      commit: a79c1c76d726c5af9cf925ee0a5b934bd17c1496
[9/9] mfd: mxs-lradc: Fix Wvoid-pointer-to-enum-cast warning
      commit: 243cd47f753d57e1d6d11449056a437052560b84

--
Lee Jones [李琼斯]

