Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2907558CE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 02:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjGQAUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 20:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjGQAUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 20:20:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C911BC;
        Sun, 16 Jul 2023 17:20:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBFE060ED3;
        Mon, 17 Jul 2023 00:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B18C433C8;
        Mon, 17 Jul 2023 00:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689553210;
        bh=TG40sEdH9+UBrOjG4Wkm9lsb5XRF/wWSojuAJ/QH9Pc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HMNKOaNxIR++6HK3uB4zI3JgNU/lm2IlfKjU9BqAKf1cohiCpTqmyDoY98hC7ODsu
         AUxWYX1v4VWHQl3u+YrViY205SrENKaxSu7798b7C/9Ls0G45QXmIp7QtoI3bjLCxq
         8j5wgvV23RNgelhu8trPqRFyH8aAkFg/UHHVSD5MBEfFWXYMqQhGkAY6/WqZ9sj2On
         es2nyDuTe30SAAy16DpRTBNhe9xKSV6wmW/mJcojsiR3uw7D2/cuywQKXiiSzNnfeL
         lVu1b3CxFbdkMVe0Ifi6ZsygUikNfwGFAc7twvE++0HrwcuKCX9iO8lQuywrlznWEo
         7fLJ7Lp2IDc1g==
Date:   Mon, 17 Jul 2023 08:19:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm-venice-gw7904: disable disp_blk_ctrl
Message-ID: <20230717001959.GH9559@dragon>
References: <20230606154030.1449558-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606154030.1449558-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 08:40:30AM -0700, Tim Harvey wrote:
> The GW7904 does not connect the VDD_MIPI power rails thus MIPI is
> disabled. However we must also disable disp_blk_ctrl as it uses the
> pgc_mipi power domain and without it being disabled imx8m-blk-ctrl will
> fail to probe:
> imx8m-blk-ctrl 32e28000.blk-ctrl: error -ETIMEDOUT: failed to attach
> power domain "mipi-dsi"
> imx8m-blk-ctrl: probe of 32e28000.blk-ctrl failed with error -110
> 
> Fixes: b999bdaf0597 ("arm64: dts: imx: Add i.mx8mm Gateworks gw7904 dts support")
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
