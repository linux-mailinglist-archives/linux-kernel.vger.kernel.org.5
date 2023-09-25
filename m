Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813CE7AD212
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjIYHoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjIYHoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:44:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA64E3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:44:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56685C433CA;
        Mon, 25 Sep 2023 07:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695627857;
        bh=HGbj+fObT8u6gTICGsTkRzwnurezQLIHLfZnqiBm5js=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=GGSj1y/GZBESvrJwHEtIwCeJboCOT+s3GpBV7F/TNSTPOGssUZew5WtCI9hcGY5cl
         SjRTDUZqAANJZcy1iLpI714Y61sc83YcmpxJWTMxEfJxIyeJmn6/c8+hJq26q/RxF0
         RhEaHt7Oq8m5z3tESrmS1AubR6iYJmL3yDEG+I91W3PYCyMPeVYASln5pFRWkSvL8H
         stXmjH278Xof+DRrjbgIgj4XylNG4rzO9ZpOLbMcbgHIzz3yXMbz6TwMyKKrPreK/d
         42H3CHU06G6Fbj6bu1Z9vIbOeX/9AFeFYoNJocJlRVNSTdkCugEpu02cYYo9u9awYg
         soPW50dMpGf/g==
Message-ID: <b96d809490814cce95ec13ef8e21d3d1.mripard@kernel.org>
Date:   Mon, 25 Sep 2023 07:44:15 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Jernej Skrabec" <jernej.skrabec@gmail.com>
Subject: Re: [PATCH 2/7] drm/sun4i: dw-hdmi: Remove double encoder cleanup
In-Reply-To: <20230924192604.3262187-3-jernej.skrabec@gmail.com>
References: <20230924192604.3262187-3-jernej.skrabec@gmail.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, mripard@kernel.org,
        samuel@sholland.org, wens@csie.org,
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

On Sun, 24 Sep 2023 21:25:59 +0200, Jernej Skrabec wrote:
> It turns out that comment is wrong - dw hdmi driver never does any
> encoder cleanup. In fact, cleanup is done automatically, in destroy
> callback of encoder. Even more, encoder memory will be freed when hdmi
> device is destroyed. However, encoder will be cleaned up after that, in
> drm_mode_config_cleanup(), which is called later. This will cause use
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
