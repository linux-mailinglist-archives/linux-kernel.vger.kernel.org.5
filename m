Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085D77912A1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352441AbjIDHyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIDHyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:54:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5F2127
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:54:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA473B80D79
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C73C433C8;
        Mon,  4 Sep 2023 07:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693814077;
        bh=aoARwb475Xx0f36uSzi/PQ1iNPIFcNtj+pZCdpdTHQE=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=oeXdpOGAZ+tSpR3HMxTR43pxm6oJeRKEaYjHnAiUpKKUnXv8h0zhPDAp/MrAs63Cr
         cf+akUCDNS66dijjLR8jgKmwLBpDvA1Qc0qHICniQmlxs5K4kQ4P4dacMhCy6ZOTFH
         8+IaNMbPoR8iHdeG65Y9pzEsiEKgNbkYQ+IAfRHe4qwahERTnQmgqY+cCsYa0USZLi
         NgPRNM9StakARNHOeb6NOFb88stZv4+alRLfxr8hDdRiD+KQ53XHzzcLM2AuThwb7g
         m9mtfoZbMFEiRLNHr5eSQkPlS22qWr9kHR9LXrmbm7EkYwdtaz2RnE1Fr18fHWRPuZ
         FAGXGtWGZJtkA==
Message-ID: <95a50c7653a014d447072039f12144d5.mripard@kernel.org>
Date:   Mon, 04 Sep 2023 07:54:34 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Douglas Anderson" <dianders@chromium.org>
Subject: Re: [RFT PATCH 10/15] drm/sprd: Call drm_atomic_helper_shutdown()
 at remove time
In-Reply-To: <20230901164111.RFT.10.I7a2dd349cb52bae53280d0a49e22cc27b923274b@changeid>
References: <20230901164111.RFT.10.I7a2dd349cb52bae53280d0a49e22cc27b923274b@changeid>
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        liviu.dudau@arm.com, orsonzhai@gmail.com, rfoss@kernel.org,
        robh@kernel.org, sam@ravnborg.org, steven.price@arm.com,
        tzimmermann@suse.de, zhang.lyra@gmail.com,
        "Baolin Wang" <baolin.wang@linux.alibaba.com>,
        "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2023 16:41:21 -0700, Douglas Anderson wrote:
> Based on grepping through the source code, this driver appears to be
> missing a call to drm_atomic_helper_shutdown() at remove time. Let's
> add it.
> 
> The fact that we should call drm_atomic_helper_shutdown() in the case
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
