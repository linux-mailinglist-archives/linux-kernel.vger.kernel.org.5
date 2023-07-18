Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9985A75715F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 03:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjGRB2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 21:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGRB2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 21:28:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92521198;
        Mon, 17 Jul 2023 18:28:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C96761373;
        Tue, 18 Jul 2023 01:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D901CC433C7;
        Tue, 18 Jul 2023 01:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689643681;
        bh=sqYh4R2WoE7adMQ6NJsRwlB3E3Ss+oe+ToA8Xn/pUTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DWxE6mVsOS5gH3dE/pAmpV+bgA5TrKa8E3A+7eKoA/UiNp6T8UKrcnkpKaluADuxu
         R3lL1YtpZY9n75N/v+kKuOyT4X0M+YKey0M2qgIxQYI5BFRilHgh+OqopVppxHbIwj
         UoFik41eGOFrKtpGZsnbSnjCaWeQYlqnFSS9+zB2H+BrTGle5varDdId/Iar9FZujE
         DkAzuZ+2lqM8z24371EWL69g7Re9L43RYO9/z3OtThJMz2bhD2vSGyazUoboih9Bcj
         UOYY5d4VNGQG56bhT3z33itpzEQXosRPtSncpF1H9ZtRVhjqwLMerq9ewMa5NUQy81
         F9wOyG83cX9vw==
Date:   Tue, 18 Jul 2023 09:27:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 0/3] arm64: dts: imx8mn/imx8mm-beacon:  Add HDMI
Message-ID: <20230718012749.GR9559@dragon>
References: <20230615215314.5402-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615215314.5402-1-aford173@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 04:53:10PM -0500, Adam Ford wrote:
> The DSI updates are in the DRM tree and Linux next with some updates
> that now allow the DSI to connect to an HDMI bridge and successfully
> sync displays at various resolutions and refresh rates.
> 
> 
> V3:  Alphabetize regulator names.
>      Add register names for EDID and Packet
>      Add I2C address change for the camera since it
>      conflicted with the I2C address of the HDMI bridge.
> 
> V2:  Make 'compatible' the first thing in the new nodes.
> 
> Adam Ford (3):
>   arm64: dts: imx8mn-beacon: Add HDMI video with sound
>   arm64: dts: imx8mm-beacon: Change camera I2C address
>   arm64: dts: imx8mm-beacon: Add HDMI video with sound

Applied all, thanks!
