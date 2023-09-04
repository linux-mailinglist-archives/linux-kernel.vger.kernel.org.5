Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D069F7912A6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244518AbjIDHzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350939AbjIDHzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:55:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF66FF0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:55:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64BEC61314
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780EFC433C8;
        Mon,  4 Sep 2023 07:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693814108;
        bh=hrumtQoV1/ACtGoSsBTZdx/2I2D/Z7gcCZhcW0zrn04=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=fedbdDOEevGhM4eFrSwwvCxC+lMbRQCn/Kk45uAI61D5+yf9T61g7cdwMKzNMgKwE
         5CxaHynR/tzzj963O7X/bR7SbWRsbT/Ge7eNRNT9ntR1B0DbuDzQJhpyChN1Bf9W9/
         dGbcLCsVpPIHrGA1aQd+s6/Dj7iCsOuYOxVufmwqLidf0ognf3hh0SH+Dd9L1q3DV7
         UmSg+CxCxfRyLAJKtGdWxw3ddKJYc+T5BMD/2xSBL1BHM3H87SdbyFnN+UfmDf3bcS
         +ex24+ORJzpZ7QUCF/35NcWTCmU52S/ZPCcG2tUCCWEkV6Xf0vO0jGMN2rTtF2UbW2
         cfPn18KN+rvfQ==
Message-ID: <daec0568ae87cf84bd0e57ce40cf9162.mripard@kernel.org>
Date:   Mon, 04 Sep 2023 07:55:06 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Douglas Anderson" <dianders@chromium.org>
Subject: Re: [RFT PATCH 13/15] drm/imx/ipuv3: Call
 drm_atomic_helper_shutdown() at shutdown/unbind time
In-Reply-To: <20230901164111.RFT.13.I0a9940ff6f387d6acf4e71d8c7dbaff8c42e3aaa@changeid>
References: <20230901164111.RFT.13.I0a9940ff6f387d6acf4e71d8c7dbaff8c42e3aaa@changeid>
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, shawnguo@kernel.org,
        "Maxime Ripard" <mripard@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2023 16:41:24 -0700, Douglas Anderson wrote:
> Based on grepping through the source code this driver appears to be
> missing a call to drm_atomic_helper_shutdown() at system shutdown time
> and at driver unbind time. Among other things, this means that if a
> panel is in use that it won't be cleanly powered off at system
> shutdown time.
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
