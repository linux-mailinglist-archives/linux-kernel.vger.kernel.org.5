Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679658073F7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379423AbjLFPtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379121AbjLFPtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:49:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE459C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 07:49:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50267C433C8;
        Wed,  6 Dec 2023 15:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701877763;
        bh=+J1QdopcvWpX9zfxJIE8u/JzSE7fFRVzBYM2a7CKdXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B2d41aRpP78BtGO5A+ZqppqUNq24L9RxjSDmHvlgFX2vgeXyTyAZHVXUESWvLQiGj
         7NyrI9V4FwSH2s14/MJWFedHMoU8y8K+2UZB3v6aRlgMcwfRlvtzd0cY3UkU9J4Fzj
         uCES3fjJnxyMNRLgFXZG78O42SFZXr2MK49uzZrLlbxd0XxRbLu/ZFIuN5QhAWqP8I
         3j+JmeZddkPH4Yp1VMn6eRvw+7hZa0AiB9HqEEXD3z3sguH1jPKaVH1GWkRMSszpMV
         zWStW2xd8YsZtKHuQIzE3SaoN2PrUzDX3pnXVmFtEZdSUhBVYp3mzoqvgHaB7FbFoU
         AKkwkO5aIka0w==
From:   Robert Foss <rfoss@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Robert Foss <rfoss@kernel.org>, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        kernel-janitors@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Subject: Re: [PATCH] drm/bridge: nxp-ptn3460: simplify some error checking
Date:   Wed,  6 Dec 2023 16:49:16 +0100
Message-ID: <170187770273.918857.2541227849014994026.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <04242630-42d8-4920-8c67-24ac9db6b3c9@moroto.mountain>
References: <04242630-42d8-4920-8c67-24ac9db6b3c9@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2023 18:05:15 +0300, Dan Carpenter wrote:
> The i2c_master_send/recv() functions return negative error codes or
> they return "len" on success.  So the error handling here can be written
> as just normal checks for "if (ret < 0) return ret;".  No need to
> complicate things.
> 
> Btw, in this code the "len" parameter can never be zero, but even if
> it were, then I feel like this would still be the best way to write it.
> 
> [...]

Added suggested by tag, to reflect Neils feedback.

Applied, thanks!

[1/1] drm/bridge: nxp-ptn3460: simplify some error checking
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=28d3d0696688



Rob

