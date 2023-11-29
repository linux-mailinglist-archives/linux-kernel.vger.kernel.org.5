Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B477FD3B4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjK2KMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjK2KMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:12:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343411AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:13:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B439C433C8;
        Wed, 29 Nov 2023 10:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701252779;
        bh=q2xGuBe/5ZtaWEz1wA9oSCyNuPYE42N2DoH03gk6/gY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YqtqYUD/JfGojXzIQTyJ9lhWdfjyhz/SJhgTJtf5/iozoBXPaaQPr6POy6Glgm1Hu
         5Z80l54woH7ByXaEvj6HeaMjpVOXsY4Hk2ckq7iRJrLEAeMkl3cDoz3T9j8uCBTx17
         1wnQh0pX9ncdfY9Fk1PSZvdMExv9w7YnivwHOaDJUecZJBpEr935Qi4NVPHOzG66Xm
         LhHVPqP5iqOO3R47smHvySOT/GhxsgfWP0RJeRJAhHUg5a5UNk0se/iLdVBHmcCI5g
         jCqS6yxF655mutzF6FkVl+lpxlV+t168rIeyYTsoipdGCUN6tUDclND9yGuZ5SLLns
         Dyw5HN3+CRwpg==
From:   Robert Foss <rfoss@kernel.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Xin Ji <xji@analogixsemi.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     qwen@analogixsemi.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, hsinyi@chromium.org,
        bliang@analogixsemi.com
In-Reply-To: <20231120091038.284825-1-xji@analogixsemi.com>
References: <20231120091038.284825-1-xji@analogixsemi.com>
Subject: Re: [PATCH 1/2] Revert "drm/bridge: Add 200ms delay to wait FW HPD status stable"
Message-Id: <170125277615.1206640.720870356698186996.b4-ty@kernel.org>
Date:   Wed, 29 Nov 2023 11:12:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 17:10:36 +0800, Xin Ji wrote:
> This reverts commit 330140d7319fcc4ec68bd924ea212e476bf12275
> 
> 200ms delay will cause panel display image later than backlight
> turn on, revert this patch.
> 
> 

Applied, thanks!

[1/2] Revert "drm/bridge: Add 200ms delay to wait FW HPD status stable"
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=af3145aa142c
[2/2] drm/bridge: anx7625: Fix Set HPD irq detect window to 2ms
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=e3af7053de3f



Rob

