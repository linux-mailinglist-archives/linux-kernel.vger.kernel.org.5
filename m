Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22A576840F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 08:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjG3Gmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 02:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjG3Gmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 02:42:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC4E10CB;
        Sat, 29 Jul 2023 23:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4796960B3F;
        Sun, 30 Jul 2023 06:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4C4C433C9;
        Sun, 30 Jul 2023 06:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690699351;
        bh=WN7Qt+nbl0/4iHAEWJM+rZFL0e1kn7laryW2NscqO+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vFuyycwTRfRDllXlaF43uwvad1SPeVzs6mgE8o8YcFHZQWLs+PEU7jYNuZa+SmPlp
         Kjf1yX+pv/n3bjhJfwd+706Vyk9himvjFo6Y+Ua9mu1x+RcT85ja/OZYJp+mSJpKgZ
         eDmmxwlf7n5LPwT+keowhxr25M1sZEMlKwaRiuoppiS3lvJMSJlRZKzDRRxDVMrNoI
         tyRY8NTPmRw87zYdwcL34dPfXvRFAdXlx7P+urIZFdD10UrDC3JqN9YKdwu9tmQbM6
         XRjMQdMRZ4OeLjzRnXxLAlVQwFTZU0aGbNTKdGyVrWKTVoourTYQWdaZVqDAZ3tz6M
         rcT5Gymqcl8rQ==
Date:   Sun, 30 Jul 2023 14:42:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        S.Riedmueller@phytec.de, S.Mueller-Klieser@phytec.de,
        upstream@phytec.de
Subject: Re: [PATCH v2 3/3] ARM: dts: imx6: phycore: Rely on PMIC
 reboot/reset handler
Message-ID: <20230730064220.GA151430@dragon>
References: <20230719114328.2239818-1-andrej.picej@norik.com>
 <20230719114328.2239818-3-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719114328.2239818-3-andrej.picej@norik.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 01:43:28PM +0200, Andrej Picej wrote:
> Due to the missing signal connection between i.MX6 WDOG_B pin and the
> PMICs external reset, the internal i.MX6 watchdog is not able to reset
> the phyCORE i.MX6 SoM properly. Thus disable the internal i.MX6 watchdog
> to prevent unexpected PMIC settings after reset.
> 
> NOTE: This patch should not be backported as it might break existing
> uses and fixes in bootloaders.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>

Applied, thanks!
