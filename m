Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD28879121C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352392AbjIDH2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbjIDH2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:28:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E610136
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:28:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7B76FCE0E12
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71653C433C8;
        Mon,  4 Sep 2023 07:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693812502;
        bh=2jeuNIWsN5F7oxkSoe26j7sx09fm8BoytW8BbawJMew=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=mLVj+2eOex7XCmOwOcEZCZAu8CSjOEhAmeuKB3pfp4l56rHKl6xRz7LasbkfKODkT
         E8fiOQZ1dvcMjqz/O3B0DWhT5VBEVHnjEmfEGkSrbO+07lG5j+3gwPQAQukrTIynkx
         sTdotMBEU+o9KuU1xgQy7J+UEUOXIizdZoL4BGG9JmsM05VlM1K9CsRGvbfsWdSidj
         h2qlJDSNUhM9suhO08LtiuQFR9pRGtqFfMS7VTE0ffYlckAZjl//XUjIjio+Yg1gSW
         RogOYDKzGuxs9sqTh3gn3BFbX1zs3RXf7mxcM6MwS7h6SGAQkZGSXH6spw5HQjQ2wN
         kFCbndpiNERUw==
Message-ID: <04f988ff0694824089a46d60444e89ac.mripard@kernel.org>
Date:   Mon, 04 Sep 2023 07:28:20 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Douglas Anderson" <dianders@chromium.org>
Subject: Re: [RFT PATCH 08/15] drm/arcpgu: Call drm_atomic_helper_shutdown()
 at shutdown time
In-Reply-To: <20230901164111.RFT.8.I8a0a246fea222059881d01a8fff2adcf7ef3d7a4@changeid>
References: <20230901164111.RFT.8.I8a0a246fea222059881d01a8fff2adcf7ef3d7a4@changeid>
Cc:     abrodkin@synopsys.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2023 16:41:19 -0700, Douglas Anderson wrote:
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
