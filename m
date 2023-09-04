Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E86791227
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350962AbjIDH3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjIDH3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:29:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D425191
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:29:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFC4661171
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09165C433C7;
        Mon,  4 Sep 2023 07:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693812563;
        bh=PRA3H82ybDOf9DJLT4rwNUddGU4EaNl/YQ8Qq5VMpas=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=LTIT8YFdMGqbayYgPki4zmtkGRqZfl2hemY6u9ohRbB8l5I59aHayatsFaFR0A+x/
         llXeb9AWUghAJ0FNIYU1+xGtyZpjItnTyrJQ/mNXg3qGfATOJxT5jiG/xb9VRpnfQo
         /s8CNea5W5+l1hIIUzwiGRP/LW6dDy+YYMlM004tFnKCbBPTaDwoNlrgYIYCWDz6k2
         elcRL8wafAU3rg61Bhao58rC39X9ShVLGrbPNafOzdJwynhWqrxTmPQCs8IC3+nD61
         VLkh3u/7lvFFfVfJHKU8CxCKr8GZgkg+IV7jouvBpLK2ZYuHZEvxcLe2QN0t+za1Vo
         evdPY+82UgGWg==
Message-ID: <5e96e33bae187493e5f765bd7be4f2e2.mripard@kernel.org>
Date:   Mon, 04 Sep 2023 07:29:20 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Douglas Anderson" <dianders@chromium.org>
Subject: Re: [RFT PATCH 12/15] drm/gma500: Call
 drm_helper_force_disable_all() at shutdown/remove time
In-Reply-To: <20230901164111.RFT.12.I1be622999c3b23f28f077fc75bb0319396a216e9@changeid>
References: <20230901164111.RFT.12.I1be622999c3b23f28f077fc75bb0319396a216e9@changeid>
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        patrik.r.jakobsson@gmail.com, "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2023 16:41:23 -0700, Douglas Anderson wrote:
> Based on grepping through the source code, this driver appears to be
> missing a call to drm_atomic_helper_shutdown(), or in this case the
> non-atomic equivalent drm_helper_force_disable_all(), at system
> shutdown time and at driver remove time. This is important because
> drm_helper_force_disable_all() will cause panels to get disabled
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
