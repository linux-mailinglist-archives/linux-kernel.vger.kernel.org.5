Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A1A7FC2A6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjK1QlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjK1QlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:41:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0FED6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:41:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7944C433C7;
        Tue, 28 Nov 2023 16:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701189666;
        bh=yu+6XTz4QxpoSP6NjN9BwOG/iZ4IqK6Zn2csX9sKZDw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=frCVKSbLokR0E/yWEjHthOQ5UlvHZYQShO71hpojY5zY019SQpSXQlD1Lknc/m/S+
         dP1EBRA5gM1uYfWBnJgX7A1pNAR0E3TIZqVZWO/DNehoniEtE8lP3wnA5FTCWXtUgk
         fVdFFk+KCGOlJ4biDWc5DKGifK/UV/SMuOF5ioarN0gML+EWOQLIVDfkIvVvYGONzc
         GSvno96lFxxAe4+CfWtf6/rfmlmDI6jbGWHz7FcIP8nQvH8vkO2u7WF9PBcZkQd223
         dqgODnyUF21b+yAdZkuqVxqGYxDgj5mjJKZBYeGvBecqq9Mx/seT4hpsTnWySQFmV3
         Hsk8PSZ1h61JQ==
From:   Robert Foss <rfoss@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     jonas@kwiboo.se, andrzej.hajda@intel.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, linux-imx@nxp.com,
        s.hauer@pengutronix.de, airlied@gmail.com,
        Laurent.pinchart@ideasonboard.com, festevam@gmail.com,
        kernel test robot <lkp@intel.com>, jernej.skrabec@gmail.com,
        neil.armstrong@linaro.org, mripard@kernel.org, shawnguo@kernel.org,
        tzimmermann@suse.de, kernel@pengutronix.de
In-Reply-To: <20231123051807.3818342-1-victor.liu@nxp.com>
References: <20231123051807.3818342-1-victor.liu@nxp.com>
Subject: Re: [PATCH v2] drm/bridge: imx93-mipi-dsi: Fix a couple of building warnings
Message-Id: <170118966251.1111655.18429253979554815398.b4-ty@kernel.org>
Date:   Tue, 28 Nov 2023 17:41:02 +0100
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

On Thu, 23 Nov 2023 13:18:07 +0800, Liu Ying wrote:
> Fix a couple of building warnings on used uninitialized 'best_m' and
> 'best_n' local variables by initializing 'best_m' to zero and 'best_n'
> to UINT_MAX.  This makes compiler happy only.  No functional change.
> 
> 

Applied, thanks!

[1/1] drm/bridge: imx93-mipi-dsi: Fix a couple of building warnings
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=9f83f37ca76d



Rob

