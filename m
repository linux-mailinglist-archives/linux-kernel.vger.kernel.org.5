Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54A87668CB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjG1J1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbjG1J0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:26:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4057D3A93;
        Fri, 28 Jul 2023 02:22:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C559862093;
        Fri, 28 Jul 2023 09:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FD8C433C9;
        Fri, 28 Jul 2023 09:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690536174;
        bh=AL6UUgG3FZVUbTmbZ9j5ob/iwxMoLlBtI6VOTuk7L3Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kV/4SwJSDxGPIFO9SqzBTr/WKfLl3fbG9+JtdkQ5g68+3qG+FbBQhGQhgyXFRxeuF
         x2TzzXv2KahqFkWG4DpisftoqyieCHUe/aScTwjmOLzH4trlPzjWGjVOgIAdBXCLZz
         cv3q4MTA/ZbxPvumqXarQGAB3+GV9C8T1M2xgDCgX7JWQy31xH5NGc7VSRUpHBgIBU
         FoALgxCfhFHAQcDe1SiRqZGt9BI2mvzCopjpifgAWFDuwOSwn2VPcyFBZS/bBt9s4B
         Y1xidOeK7t6p+21I5G+vW8zX7mbUs9WyPYsD8qBg/kESFYAs8FWgKC+o8NKWV77XUR
         KCMIjwEZZrYcw==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, Artur Weber <aweber.kernel@gmail.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <20230714121440.7717-1-aweber.kernel@gmail.com>
References: <20230714121440.7717-1-aweber.kernel@gmail.com>
Subject: Re: [PATCH 0/2] backlight: lp855x: Fixes after c1ff7da03e16
Message-Id: <169053617109.301530.1109574128133922072.b4-ty@kernel.org>
Date:   Fri, 28 Jul 2023 10:22:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 14:14:38 +0200, Artur Weber wrote:
> Two small fixes after commit c1ff7da03e16 ("video: backlight: lp855x:
> Get PWM for PWM mode during probe"), stemming from a review[1] by
> Uwe Kleine-König.
> 
> [1] https://lore.kernel.org/all/20230614083953.e4kkweddjz7wztby@pengutronix.de/
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> 
> [...]

Applied, thanks!

[1/2] backlight: lp855x: Initialize PWM state on first brightness change
      commit: 4c09e20b3c85f60353ace21092e34f35f5e3ab00
[2/2] backlight: lp855x: Catch errors when changing brightness
      commit: 5145531be5fbad0e914d1dc1cbd392d7b756abaa

--
Lee Jones [李琼斯]

