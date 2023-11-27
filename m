Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0A27FAE48
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 00:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbjK0XZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 18:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjK0XZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 18:25:33 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005601A5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 15:25:38 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 62AF5BEB;
        Tue, 28 Nov 2023 00:25:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701127501;
        bh=eYzEt54XedbWvcie9HCtLUP/JQBIRk0S3APgSRa99MI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wA1FCCLvY53qwglw0AogEo8cFStGYy2XqjIMPJjoNY5nIZgm4qqXkYTXVkNuuaUQ+
         xi/qAlTBGS8kkboLk+GqDAs5gHPOLHxAknZ98Ppk26hrVm2itx6XhP9X2kAVdXlR/8
         6G/wdvSX/2jYUAraO65BY5GvT+b+duHofaWiGWEg=
Date:   Tue, 28 Nov 2023 01:25:42 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liu Ying <victor.liu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/3] Revert panel fixes and original buggy patch
Message-ID: <20231127232542.GB25590@pendragon.ideasonboard.com>
References: <20231128-revert-panel-fix-v1-0-69bb05048dae@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231128-revert-panel-fix-v1-0-69bb05048dae@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, Nov 28, 2023 at 12:10:18AM +0100, Linus Walleij wrote:
> This series reverts the attempts to fix the bug that went
> into v6.7-rc1 in commit 199cf07ebd2b
> "drm/bridge: panel: Add a device link between drm device and panel device"
> and then it reverts that patch as well.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Linus Walleij (3):
>       Revert "driver core: Export device_is_dependent() to modules"
>       Revert "drm/bridge: panel: Check device dependency before managing device link"
>       Revert "drm/bridge: panel: Add a device link between drm device and panel device"

To preserve bisectability, you should revert in the opposite order.

> 
>  drivers/base/core.c            |  1 -
>  drivers/gpu/drm/bridge/panel.c | 26 --------------------------
>  2 files changed, 27 deletions(-)
> ---
> base-commit: 95ba893c9f4feb836ddce627efd0bb6af6667031
> change-id: 20231127-revert-panel-fix-e4da3e11e7a4

-- 
Regards,

Laurent Pinchart
