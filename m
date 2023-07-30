Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF9A768572
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 15:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjG3NQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 09:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjG3NQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 09:16:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B0510B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 06:16:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7C5860C4A
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 13:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF179C433C7;
        Sun, 30 Jul 2023 13:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690722988;
        bh=MojjiocGi0lrMWsj7IUMB7H4RJJ58rdDckxSGt4vJxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IU3SnUca5CQvSbD+NfOl+TMlEg//oXmhNYIbD/TA3vbghbeViMlPcKhTZvePEjSl3
         kQw8Gpeo2GIaA9JDmxgr2Clj4l0O7YhBBMtCIhkR1w4HeKykprKefg1dLgfBXB3NuQ
         ml3Gy3iZV8RLskSEgEpgaMCpTi9vcppj/Y64dlI8UgGbPr2OdyUmRDepg7+90FIzHb
         xYRKiZRkbRs2euaXkzgjnqPJ25MsiBCG3Qkkq6FsXj2IVP08UWxuL/8MsAaPhR6Js9
         3QPgi0TlUwzV5cewSIYVxlO/gj72Yb0ipSonqUw/WgjEkI+E/p7+tdKWfCEs5Todgv
         AcfmBW17aRZ/A==
Date:   Sun, 30 Jul 2023 21:16:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sherry Sun <sherry.sun@nxp.com>,
        Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
        linux-imx@nxp.com, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        John Garry <john.garry@huawei.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>, Peng Fan <peng.fan@nxp.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] arm64: defconfig: enable driver for bluetooth nxp uart
Message-ID: <20230730131614.GM151430@dragon>
References: <20230725085630.16179-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725085630.16179-1-marcel@ziswiler.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 10:56:30AM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Enable driver for Bluetooth NXP UART applicable amongst others for NXP
> 88W8997 and IW416 as found on multiple Toradex SoMs.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!
