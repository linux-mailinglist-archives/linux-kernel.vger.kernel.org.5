Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD51766B8F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbjG1LSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbjG1LSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:18:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F1610FA;
        Fri, 28 Jul 2023 04:17:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FF6A620FD;
        Fri, 28 Jul 2023 11:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7BFC433C7;
        Fri, 28 Jul 2023 11:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690543078;
        bh=ZUriJP/2mhHsCbHeCSEUDVtBOQUoKZKKsrO8cJM75ps=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Wnl+Iof6OVRdjqTfFhfuqH8RIvgLScD6oLb0V0gxg/1klGjA4ii9jf7O+18MaDaPK
         MLN+p8RbPUav8zSoLyhVxbfNNDbBeWmAH7uClIa/YgJIsIKnsfL/b70WHfWU7rFRhP
         /uuERh1mQxMjbQs7oeFEA7nXNaB+cV+OQoISebits/vH4WqnrRaZ7tuIXHal/hZk3V
         Am0vZl6SPFTo6LL3WgUUYEsF3wR9O7zXFE4487/2WVFRpu74sXhWbRzSIp3lCykKBn
         VThl6l6yiUdwOl0BshP1e7urAXsnJEX8jMgmIjsLzvXXTx2hFR0SSxsIWi66FTCZ1X
         8c6ThGrwW3G2g==
From:   Lee Jones <lee@kernel.org>
To:     linux-arm-msm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230725-leds-qcom-flash-driver-tiny-fixes-v2-0-0f5cbce5fed0@quicinc.com>
References: <20230725-leds-qcom-flash-driver-tiny-fixes-v2-0-0f5cbce5fed0@quicinc.com>
Subject: Re: [PATCH v2 0/3] leds-qcom-flash: several tiny fixes
Message-Id: <169054307689.348539.15606142753444329054.b4-ty@kernel.org>
Date:   Fri, 28 Jul 2023 12:17:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 17:57:18 +0800, Fenglin Wu wrote:
> Add small changes to address the review comments from Paval which were
> posted after the driver was applied:
>   https://lore.kernel.org/linux-arm-msm/20230325170957.GA2904@bug/#t
>   https://lore.kernel.org/linux-arm-msm/ZB8wbv93+Vmx3trt@duo.ucw.cz/
> 
> 1) Add a sentence in Kconfig to explain the driver can be compiled as a
>   module
> 2) Strobe off the LED channel before setting flash current
> 3) Put the child node while register flash LED device failed.
> 
> [...]

Applied, thanks!

[1/3] leds: flash: leds-qcom-flash: declare the driver as a module
      commit: 05a576059ac23355a86e4be058cb43997d83c7fd
[2/3] leds: flash: leds-qcom-flash: turn off LED before setting flash current
      commit: 7c47381c8664d55861036d1d858daf5e9d5d67b8
[3/3] leds: flash: leds-qcom-flash: put child node if registration failed
      commit: 546924102de8327a5b2095d2134faed6de971476

--
Lee Jones [李琼斯]

