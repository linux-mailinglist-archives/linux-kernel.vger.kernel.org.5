Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492F5791214
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244714AbjIDH2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjIDH1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:27:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8793ABA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:27:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DFD1DCE0E24
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6242C433C8;
        Mon,  4 Sep 2023 07:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693812468;
        bh=piU91Jcbu/nw4mkWE2ebzf6Prd/hbd/WAB0XaDvFVKs=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=Zvb1r76GhELMisX9kegFx6hYvKO9a95ROEtrBeUGlMbCGe6dLBS306Urr9gQ7Y4/O
         RjfMKdnLGbxCogy0Sw7M71edlT+aFPxH+Z52ERTui2cf/2MCtDIQTpRsuO8KUAZ+gj
         UhPAJAp8xsJEuCC1OEYmDrSYMakSkrxSuqnNWimZfR8AAgUePniokMZ9WDo+KhQPGZ
         1UeKp+Y4eulL+A+VxVQ09/eumfPM+kiPlkxnI4wac8PKcm+PMHlHBGwaZScVNLeurG
         9bZhX6EBfgW0mneEv6bUiP5l3w/Hi8gz6AGocWmZMqxky1J0imwWFMJ58DF4cHvLj+
         0ZH5AS8zmDoeg==
Message-ID: <8a90bc6f4bf16d5aa545e5215f2a5112.mripard@kernel.org>
Date:   Mon, 04 Sep 2023 07:27:45 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Douglas Anderson" <dianders@chromium.org>
Subject: Re: [RFT PATCH 06/15] drm/nouveau: Call
 drm_atomic_helper_shutdown() or equiv at shutdown time
In-Reply-To: <20230901164111.RFT.6.Ie7588ec6e0f93e8bc700e76b265ad1a7ad6b15ad@changeid>
References: <20230901164111.RFT.6.Ie7588ec6e0f93e8bc700e76b265ad1a7ad6b15ad@changeid>
Cc:     airlied@gmail.com, bskeggs@redhat.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, kherbst@redhat.com,
        linux-kernel@vger.kernel.org, lyude@redhat.com,
        nouveau@lists.freedesktop.org, "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2023 16:41:17 -0700, Douglas Anderson wrote:
> Based on grepping through the source code this driver appears to be
> missing a call to drm_atomic_helper_shutdown() (or
> drm_helper_force_disable_all() if not using atomic) at system shutdown
> time. Among other things, this means that if a panel is in use that it
> won't be cleanly powered off at system shutdown time.
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
