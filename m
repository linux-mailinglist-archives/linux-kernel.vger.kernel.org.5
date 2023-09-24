Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69007AC824
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 14:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjIXMwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 08:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIXMv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 08:51:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D651CFC
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 05:51:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504D8C433C7;
        Sun, 24 Sep 2023 12:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695559912;
        bh=Ec0Vn7quyagdyOco4KV9JC+vyZ+v9g289IRTEXvFvKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t8Crc2L8lOIU5IHTTuinuS9vpV5eMuU2V17OQ34N8n87SNukriYY8bp6V50D/H9Rr
         3/6gVlQewDazwH0Jr4n29i1WXlZhzlBGWWJK8+VdITT7WrqQHDr1103mHUS+VFYyr2
         h/XOgsXGr4oBup8wdijgNpfUMOEzUC3BfCBjss5ePFOLH52kajtjWYayZz9MjzomkW
         vyfYOIFJjR0FmujpbtPVO9qNfPJ0JaVQl0KI6pLhD5xMetzV0TuGVupPHKu6Ljb03V
         6ieAjr7e1NZDk4e/UTIjOrkVDwa0JAyPCEoE2c5LdeWazhuWekgwpId7etxROcyEc4
         fF6Yvv3A0Wcow==
Date:   Sun, 24 Sep 2023 20:51:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Nathan Rossi <nathan@nathanrossi.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Rossi <nathan.rossi@digi.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] soc: imx8m: Enable OCOTP clock for imx8mm before reading
 registers
Message-ID: <20230924125142.GE7231@dragon>
References: <20230814015700.70156-1-nathan@nathanrossi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814015700.70156-1-nathan@nathanrossi.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 01:57:00AM +0000, Nathan Rossi wrote:
> From: Nathan Rossi <nathan.rossi@digi.com>
> 
> Commit 836fb30949d9 ("soc: imx8m: Enable OCOTP clock before reading the
> register") added configuration to enable the OCOTP clock before
> attempting to read from the associated registers.
> 
> This same kexec issue is present with the imx8m SoCs that use the
> imx8mm_soc_uid function (e.g. imx8mp). This requires the imx8mm_soc_uid
> function to configure the OCOTP clock before accessing the associated
> registers. This change implements the same clock enable functionality
> that is present in the imx8mq_soc_revision function for the
> imx8mm_soc_uid function.
> 
> Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>

Applied, thanks!
