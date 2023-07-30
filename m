Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5CD76840D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 08:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjG3GmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 02:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG3GmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 02:42:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0642E71;
        Sat, 29 Jul 2023 23:42:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64A0060B79;
        Sun, 30 Jul 2023 06:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C104C433C7;
        Sun, 30 Jul 2023 06:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690699326;
        bh=O+E+2ARL2V9y7XBBiMa/UoDNJH5WTjq1HDJAPCZMYXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LdkRiLGOIzU4I5ZyiNgv+spYO/35dzuTLaBaXCdvXcS1VbxsbmYYV8hBPzvGZzfnE
         5ZWtADt2yAyVRD+Ul4zF1wZI/jkjCZzzhslqrCIC6nOFA4fb/LZgxPvj+61dpcBUPh
         9507BcTRgOYPOKvfDPytSUquCOlQT9wiczCGuE3PMi54pIIEjyY4I1om2g5+p+Xp8d
         DLY8GNpp5aFuq5/wJflmebZvhxs/SpqbJ7QF0a+/Fy6mkqWqeA19Qbs7h/3aXI00Ep
         eo2PJI+5+7WpFayl6BvzHDA1JVdiMmjvdev6ZZ5rp+KlwbTywsQWnb9oALv5g9Tq8n
         7FbxUYIgWceUQ==
Date:   Sun, 30 Jul 2023 14:41:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        S.Riedmueller@phytec.de, S.Mueller-Klieser@phytec.de,
        upstream@phytec.de
Subject: Re: [PATCH v2 2/3] ARM: dts: imx6: pfla02: Rely on PMIC reboot/reset
 handler
Message-ID: <20230730064153.GZ151430@dragon>
References: <20230719114328.2239818-1-andrej.picej@norik.com>
 <20230719114328.2239818-2-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719114328.2239818-2-andrej.picej@norik.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 01:43:27PM +0200, Andrej Picej wrote:
> Due to the missing signal connection between i.MX6 WDOG_B pin and the
> PMICs external reset, the internal i.MX6 watchdog is not able to reset
> the phyFLEX SoM properly. Thus disable the internal i.MX6 watchdog to
> prevent unexpected PMIC settings after reset.
> 
> NOTE: This patch should not be backported as it might break existing
> uses and fixes in bootloaders.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>

Applied, thanks!
