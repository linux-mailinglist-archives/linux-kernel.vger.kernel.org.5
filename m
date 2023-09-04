Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715BA79120E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242846AbjIDH0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjIDH0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:26:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216AFA7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:26:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEC8FB80D79
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B0FC433C9;
        Mon,  4 Sep 2023 07:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693812400;
        bh=TK/g9IrkzPkkAcV6FElhzmHbKGYaCADVqU9+CJcXZk4=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=pNsyZ71stYVLxfBQF9caE0HKtIdipki6yLoTXtXT7Mw66Om7axxGm5VjWI64q1ic0
         BL0WmraWAgTV/evN2xhFkHe0DT0ZMNxsEvVeKMPD9y20e4wGXY/hqHW2Xdvvdn7//Y
         Oa6Vw6iekiTR8FreOvwWyKUjrck5XMkUdjJDNv15v5iyE8n+2vRsIgD2k9heQlN7N1
         lqIBr33003+RTMR/Vzfr6jUCKTqzRFAFU4etB5MmaSugFSB2w5E/IR/Y2OeEt1Hfxp
         q5GztYLOVWeENy40wkhc9Q7176bQh4UxWjMqZmakUEUTAcQJJTbbcvoTfskX3fqtH3
         yBMi8VHBOn/rA==
Message-ID: <7d3f5701bc09acf2830395ad3b86cd0e.mripard@kernel.org>
Date:   Mon, 04 Sep 2023 07:26:36 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Douglas Anderson" <dianders@chromium.org>
Subject: Re: [RFT PATCH 04/15] drm/kmb: Call drm_atomic_helper_shutdown() at
 shutdown time
In-Reply-To: <20230901164111.RFT.4.I20cb02bafa7c2368e4bd579df0716eb62a3a21bf@changeid>
References: <20230901164111.RFT.4.I20cb02bafa7c2368e4bd579df0716eb62a3a21bf@changeid>
Cc:     airlied@gmail.com, anitha.chrisanthus@intel.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, edmund.j.dea@intel.com,
        linux-kernel@vger.kernel.org, "Maxime Ripard" <mripard@kernel.org>
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

On Fri, 1 Sep 2023 16:41:15 -0700, Douglas Anderson wrote:
> Based on grepping through the source code this driver appears to be
> missing a call to drm_atomic_helper_shutdown() at system shutdown
> time. Among other things, this means that if a panel is in use that it
> won't be cleanly powered off at system shutdown time.
> 
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
