Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BBB79129B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343651AbjIDHyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjIDHyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:54:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0769FDF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:53:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 712DA6124F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4CDC433C8;
        Mon,  4 Sep 2023 07:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693814036;
        bh=dmzqGBUff9Yr13wXotSze7kw3hfPIZnUlWO8Z7MFVDM=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=sTpFZGD31/ErzSQUGdXIniQKZ7n8p3JabQI3T6vZztfL0eo8PaOJ9lDBdlFvCSTe3
         TKFodxyxa53YGHnwW/ukm0E45tcKRsO7KMSeWuQ37pLMjnk0LxjgqnjfapNJXABrFV
         /hYRfyISO3fAoZzGHZdmqfmhZ+8b5fde8rYTYKSnmpTr0O0xiofuNHnAf+Pu9zlxDe
         BrSoKAMOFg68XWRn89XDbNbqczpwyFX3C0IumQxRpT780HWaWNFWog3CLinGBdX4NQ
         ztrZ+ngF852fUrgUozz31f4mfzYVAtHDUvCv9ji9Noer+T4fDmtXiCg/Fc6wuD/jx0
         ynu/Y296+EfSw==
Message-ID: <98537f0b4fb383f5f41f4d3819481df5.mripard@kernel.org>
Date:   Mon, 04 Sep 2023 07:53:54 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Douglas Anderson" <dianders@chromium.org>
Subject: Re: [RFT PATCH 01/15] drm/armada: Call drm_atomic_helper_shutdown()
 at shutdown time
In-Reply-To: <20230901164111.RFT.1.I3d5598bd73a59b5ded71430736c93f67dc5dea61@changeid>
References: <20230901164111.RFT.1.I3d5598bd73a59b5ded71430736c93f67dc5dea61@changeid>
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2023 16:41:12 -0700, Douglas Anderson wrote:
> Based on grepping through the source code this driver appears to be
> missing a call to drm_atomic_helper_shutdown() at system shutdown
> time. Among other things, this means that if a panel is in use that it
> won't be cleanly powered off at system shutdown time.
> 
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
