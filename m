Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF52575C60F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjGULsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGULs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:48:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B480312F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 04:48:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43E2D61A1D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 11:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5639EC433C8;
        Fri, 21 Jul 2023 11:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689940106;
        bh=H+sKgxyNGnvM5K489kh0RE4m6WTc+wgydknPQcu1qTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mOm1AF7eX9P/YEDy0MqLLVkFeG3N1+96TdvY10pma8DF/j5O7DNehz33yaBvOqoLs
         1hBtiBJ3H1ET8DZSV2O7/pqVueCMaLp33BVNdrr6LNX8eVz0nL8mp0/0wOibS00/nr
         JPnWLJEtRb1tPPRXKbXvgcM8TPL2dWBxOoHCjJFnPc5VLNtY+ZyBqV8U+KvuJke9sS
         EXYr0wpMUvvuj1UcKRWIRLZKaO88XyfJ58qsmaeGoRdA1ApoTLr0bNEh8uCfzlC55f
         zu+lsd09fIANynnEhUOFfK+X1r4OuLVQ/+U7lUrFpISCc4z67QA1HA40VAkV44/eHn
         iB65MJuNLZgww==
From:   Robert Foss <rfoss@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alex@shruggie.ro>,
        dri-devel@lists.freedesktop.org
Cc:     Robert Foss <rfoss@kernel.org>, festevam@gmail.com,
        andrzej.hajda@intel.com, daniel@ffwll.ch,
        bogdan.togorean@analog.com, airlied@gmail.com, nuno.sa@analog.com,
        Laurent.pinchart@ideasonboard.com, neil.armstrong@linaro.org,
        jonas@kwiboo.se
Subject: Re: [PATCH v4] drm: adv7511: Fix low refresh rate register for ADV7533/5
Date:   Fri, 21 Jul 2023 13:48:15 +0200
Message-ID: <168994007362.139428.5966908041649234142.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719060143.63649-1-alex@shruggie.ro>
References: <20190716131005.761-1-bogdan.togorean@analog.com> <20230719060143.63649-1-alex@shruggie.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 09:01:43 +0300, Alexandru Ardelean wrote:
> From: Bogdan Togorean <bogdan.togorean@analog.com>
> 
> For ADV7533 and ADV7535 low refresh rate is selected using
> bits [3:2] of 0x4a main register.
> So depending on ADV model write 0xfb or 0x4a register.
> 
> 
> [...]

Applied, thanks!

[1/1] drm: adv7511: Fix low refresh rate register for ADV7533/5
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=d281eeaa4de2



Rob

