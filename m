Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12704791211
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345387AbjIDH1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjIDH1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:27:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A73BA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:27:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E880D610A3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0359CC433C8;
        Mon,  4 Sep 2023 07:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693812436;
        bh=zS+k6SmfaPf7quDUXWLnC5FUAjLDdauLMkbmb5Ev2aY=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=pxeD5oCW/zTniYTuovwvrai8EtpSH9fm8CngPOFps19j4rVRk/8pV+pOeSww/BLtf
         whX4b6l0cDNTwsrEjX8Hh+g5OgrYpGLPZmJ9xr7cXcKPFDwNEw4wY79hd8Y+3LkQid
         urVrQuN8XqfphF5u1o5v8UK+gPJIvY7cZaTrg6O+f1Tg44C9RLhfMrOk/SXkO7kvvT
         mHEbuI35H2yT7tnFy6P/MRaTrr1/3gcSkGG10zACp2sFbVFSgMJ3ZK72tsDT9acu8L
         6UlV9N/Q0cqQ19zTqpSfgBu/4pT6DFYXP6P4Z3a05eSQrueKJjurLWOliC7ajwokLl
         UrTBMNdG7O3LQ==
Message-ID: <060226e5823e782a87c50b68d356e27b.mripard@kernel.org>
Date:   Mon, 04 Sep 2023 07:27:13 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Douglas Anderson" <dianders@chromium.org>
Subject: Re: [RFT PATCH 05/15] drm/mediatek: Call
 drm_atomic_helper_shutdown() at shutdown time
In-Reply-To: <20230901164111.RFT.5.I2b014f90afc4729b6ecc7b5ddd1f6dedcea4625b@changeid>
References: <20230901164111.RFT.5.I2b014f90afc4729b6ecc7b5ddd1f6dedcea4625b@changeid>
Cc:     airlied@gmail.com, angelogioacchino.delregno@collabora.com,
        chunkuang.hu@kernel.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2023 16:41:16 -0700, Douglas Anderson wrote:
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
