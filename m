Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E238E7912A9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352467AbjIDHzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352476AbjIDHzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:55:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F7BF4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:55:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC0F860BA3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B78C433C7;
        Mon,  4 Sep 2023 07:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693814140;
        bh=r99VUSvLYNfxVQAyOBt/A1/Dqy46dDKhqil9QP9bhIQ=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=JMmNVPSfJnujgERMh7PJj6OISDlgJjTrqFGqR+Is4V5R0sYCgPpUX/YeujAy21UTK
         wV7ywSrSRqJAPXbBZnTvL9EQnbZKfEMxEopCVt8byaOx4NdlORG156/lbZok/x67X8
         MQJbyaxAFKrt5QRwUKfVP/qbf6yQiO91nwbems5SvOUQTOmvcP56xfBAcQj+JzEmzW
         CNoZ6q9ZRJ34KaRRGXMFUuTjQjsbKFuGwmJ+goa2moc8Rjs07ydIbaOxB5eJlFRg4O
         I4uxTpWIcfZ9VXeuUdePN1tL/4xuXvixQHhlWNLUgJg6iwj9ixMY1DmAEEoQoTowLg
         TDz4klk967Y1A==
Message-ID: <4b3a93c9ab2432f8ae0e9282d9e00d2a.mripard@kernel.org>
Date:   Mon, 04 Sep 2023 07:55:37 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Douglas Anderson" <dianders@chromium.org>
Subject: Re: [RFT PATCH 1/6] drm/atomic-helper:
 drm_atomic_helper_shutdown(NULL) should be a noop
In-Reply-To: <20230901163944.RFT.1.I906acd535bece03b6671d97c2826c6f0444f4728@changeid>
References: <20230901163944.RFT.1.I906acd535bece03b6671d97c2826c6f0444f4728@changeid>
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2023 16:39:52 -0700, Douglas Anderson wrote:
> As with other places in the Linux kernel--kfree(NULL) being the most
> famous example--it's convenient to treat being passed a NULL argument
> as a noop in cleanup functions. Let's make
> drm_atomic_helper_shutdown() work like this.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
