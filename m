Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842F980565F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345512AbjLENs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345418AbjLENsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:48:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE253B2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:48:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1779DC433C9;
        Tue,  5 Dec 2023 13:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701784110;
        bh=jn888q/UcAkBrUFljQzymmIT9/ky6nNuCImiG8NUxw4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GQvVSKLjKBczB0uOh0OW9Ho7OYyhpyloy3cVfG8zhaolDFmLX7LptpKD1mG7K6jl9
         i2V1rzh5xoX+kaFCN+OxTWpir/A74TGXRBxW2e3sEOYh2h0zScP4CUJqtEOUkIzUq5
         2HyxmDb1BZj2HOsNmh59Uv506WC0rS2QuSVWtdn3g2UUZqr4zNVSaSV6PLQV/OXVOd
         Y06UqvN4UTjlFumukuqOt/irhEWxu6+AqSQEOl01ifo1oaPWmbj8Z/43jV9NUxzmTh
         SNskKpdNHuk3Lpkv45hVE413iKmakzcVKQFL+NrmhK9slFaxxe7Z6FEd+oHnuzw/0u
         T8htWUK03Qgfg==
From:   Robert Foss <rfoss@kernel.org>
To:     Sean Paul <seanpaul@chromium.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>,
        Inki Dae <inki.dae@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        kernel-janitors@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <0cdc2dce-ca89-451a-9774-1482ab2f4762@moroto.mountain>
References: <0cdc2dce-ca89-451a-9774-1482ab2f4762@moroto.mountain>
Subject: Re: [PATCH] drm/bridge: nxp-ptn3460: fix i2c_master_send() error checking
Message-Id: <170178410677.683894.16036596185582079991.b4-ty@kernel.org>
Date:   Tue, 05 Dec 2023 14:48:26 +0100
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

On Mon, 4 Dec 2023 15:29:00 +0300, Dan Carpenter wrote:
> The i2c_master_send/recv() functions return negative error codes or the
> number of bytes that were able to be sent/received.  This code has
> two problems.  1)  Instead of checking if all the bytes were sent or
> received, it checks that at least one byte was sent or received.
> 2) If there was a partial send/receive then we should return a negative
> error code but this code returns success.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: nxp-ptn3460: fix i2c_master_send() error checking
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=914437992876



Rob

