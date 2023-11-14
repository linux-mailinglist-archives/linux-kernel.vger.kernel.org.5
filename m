Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FA97EB437
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbjKNPxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjKNPxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:53:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E23AFE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:53:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9618AC433C7;
        Tue, 14 Nov 2023 15:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699977225;
        bh=oj0ar3S9udglwAQhzABf2I/Z6VFbHZNzjUYZXB8926k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g+SQHlm6FcPeJKPKFDN+rTIKpfCzlgc4mkxwh5PMhYXOd6gk+Aw68aT2OOUsy5Nca
         RHEqj/a92QcipyRhgY186Ltcmj357ieFbeLL4EgKWtQ6UFfst9HP3MKt0sWOsy43cz
         VUAP9KZD/taENTQbeWQyjaflF8kYYDa/KQTAIc8la5Z8/YFUZ55HLIHgt2S764AnI0
         OKBaz2+Xu/22KbmLFzRILnBzthEGBTG59sMyUG7FrD7IDepvsEePLvkX3yAgBVtv/0
         r273m7wSrbwIuag3Lo+LCD0yURSCsxUt6C80E5CiTPB7h+DpMWJOq2gUudzI9+YnXD
         RZHjbl8tFLYZg==
MIME-Version: 1.0
Date:   Tue, 14 Nov 2023 16:53:40 +0100
From:   Michael Walle <mwalle@kernel.org>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tim Harvey <tharvey@gateworks.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: bridge: samsung-dsim: Don't use FORCE_STOP_STATE
In-Reply-To: <11fe6f0e-49e7-44d4-a31a-3b739f77489f@kontron.de>
References: <20231113164344.1612602-1-mwalle@kernel.org>
 <11fe6f0e-49e7-44d4-a31a-3b739f77489f@kontron.de>
Message-ID: <a180549d4fe67492cd2080f807ea3c66@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> My current guess would be that the issue I was seeing was already fixed
> with dd9e329af723 ("drm/bridge: ti-sn65dsi83: Fix enable/disable flow 
> to
> meet spec") and I didn't properly test both changes separately.

I had the exact same thought, as I've found your second patch.

> My cheap scope is not able to capture the DSI signals and I admit that
> we didn't use our more expensive equipment to verify the changes back 
> then.
> 
> Instead, we had an automated test setup to do cyclic on/off switching
> for the display and check for a black screen using a sensor. It is 
> quite
> a hassle to set up and I'm currently not planning to spend that much
> effort to verify this change again.

That is actually, what we are also doing right now and how the issue was
found in the first place.

> Anyway, I currently don't see any reasons to not revert my changes. 
> Your
> revert looks correct and seems to work fine as far as I can tell.
> 
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Thanks!

-michael
