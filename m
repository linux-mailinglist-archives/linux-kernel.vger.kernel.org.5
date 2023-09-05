Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA52D792BB6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbjIEQ6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354827AbjIEOpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:45:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962AB197
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 07:45:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37907B8120F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC4BC433C8;
        Tue,  5 Sep 2023 14:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693925139;
        bh=u5an2J/LxUD2OI55rxZZehNpr5yCUsPpbC08EcVzH54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gyTFF/ylLhrdlt41XanKC7fHVhJ/u8mz8U9ZGeLDO3FaNWWGXKP2YscbsZw4Idwgl
         rdL5DYbVvJByrna7KHIYjGo49YRmYpctpcdPLSYZod+u6jHI9ilat58HAqGNecoGE9
         SNTdQG6XMLdiS7oQA4ryNJaSgGWu8p//HTgBPTWDTT5yMupgqpWnd7TUcfHwRWBgSS
         oYlyPvDJfC4OwlekjHQrq8jY7oHDIma7FicGNRa4lap/V4BMiAG/A+0hR3kzqGGyPq
         HCdehC9ixYpG1DN+YjKBPxcdqLJaP193Rcd3bW01bQZsSoCyTwTqAV/S/5F7wO/mSc
         aw1rWJOEdBH1Q==
From:   Robert Foss <rfoss@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Adrien Grassein <adrien.grassein@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc:     Robert Foss <rfoss@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/4] drm/bridge: lt8912b: Init & remove related fixes
Date:   Tue,  5 Sep 2023 16:45:31 +0200
Message-ID: <169392507968.1016167.9152438724091665305.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804-lt8912b-v1-0-c542692c6a2f@ideasonboard.com>
References: <20230804-lt8912b-v1-0-c542692c6a2f@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Aug 2023 13:48:09 +0300, Tomi Valkeinen wrote:
> Fix various issues in lt8912b driver.
> 
>  Tomi
> 
> 

Fixed the mentioned commit message typos, and an incorrect has
for a "Fixes" tag.

Applied, thanks!

[1/4] drm/bridge: lt8912b: Fix bridge_detach
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=941882a0e96d
[2/4] drm/bridge: lt8912b: Fix crash on bridge detach
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=44283993144a
[3/4] drm/bridge: lt8912b: Manually disable HPD only if it was enabled
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=6985c5efc405
[4/4] drm/bridge: lt8912b: Add missing drm_bridge_attach call
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=f45acf7acf75



Rob

