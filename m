Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4830D7C8371
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjJMKnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjJMKnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:43:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066B9C9;
        Fri, 13 Oct 2023 03:43:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2ECCC433C7;
        Fri, 13 Oct 2023 10:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697193823;
        bh=VWAGS5bqi44dAk1bOrEDdGkpcvk+RhQ/wntAJMfz8+I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RE3JjP1/8H9sDG9/u6gs7yMJDy0tQPrWtPf/YiAAUbOktrbBKm+UHzTAwSHq3vbna
         GvvxvV4rRv/xMVoW1M5wqRX/8NMC40gKbJy2Nh7hVD84D9/h+lTD6DYwXZXJzy5oIv
         xTnFd32rr+ZmCKfAatVxH61tIs9QOq3F24xf2pdO+Yod64DC5SMNip5qirMBW+XCln
         BFw1U28P1ahuYvwD0bsSt3DnJrtN7ThUb06eOq5SdLJc4zlG27BH+Z638Dt40J7/FD
         DpFka2Vs8UQf/RVOs8YqisjsvakFREBDiN1M8TO/cphCVrUKoKZ4uqCbAUh6hZVxn9
         x7al7/jnVk0Jg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
In-Reply-To: <0bc81612171baaa6d5dff58c8e009debc03e1ba8.1693735840.git.christophe.jaillet@wanadoo.fr>
References: <0bc81612171baaa6d5dff58c8e009debc03e1ba8.1693735840.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] phy: sun4i-usb: Fix a W=1 compilation failure
Message-Id: <169719382030.165658.16055633686751767855.b4-ty@kernel.org>
Date:   Fri, 13 Oct 2023 16:13:40 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 03 Sep 2023 12:11:06 +0200, Christophe JAILLET wrote:
> With gcc 12.3.0, when this file is built, we get errors such as:
> 
> drivers/phy/allwinner/phy-sun4i-usb.c: In function ‘sun4i_usb_phy_probe’:
> drivers/phy/allwinner/phy-sun4i-usb.c:790:52: error: ‘_vbus’ directive output may be truncated writing 5 bytes into a region of size between 2 and 12 [-Werror=format-truncation=]
>   790 |                 snprintf(name, sizeof(name), "usb%d_vbus", i);
>       |                                                    ^~~~~
> drivers/phy/allwinner/phy-sun4i-usb.c:790:17: note: ‘snprintf’ output between 10 and 20 bytes into a destination of size 16
>   790 |                 snprintf(name, sizeof(name), "usb%d_vbus", i);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] phy: sun4i-usb: Fix a W=1 compilation failure
      commit: 9e34abc7abfac781df909891c8d53781f607105d

Best regards,
-- 
~Vinod


