Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA954791232
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244714AbjIDHao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbjIDHan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:30:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7343F1708
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2309BB80DB4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881FAC433CB;
        Mon,  4 Sep 2023 07:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693812613;
        bh=9NOrAiqzUZ6+zYyOrUBxeZ6qQTkIQJkolBNmv9q78q8=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=NM2dJFERH4BRPJ+D3W4WuU1mRBGJo+8jJ1h4QG2Hjgyl489nFlTzJ4e2HCfUcEa/n
         KAyqWUpRkHO3ZsSSP5IjTim7QrGW8eaK9UgiGKHZsVaEKiIpsbvOnqZ80mfP04aXQz
         aCGOqSn/s/keIuxbqkLdG1wFsF4NnR9uLehGZykcMEjYXtC1IoocHjJXhIsiYmAmuv
         241ePTHSXASLzmTQ7DIfaueiGTMYVj0/oN/Leip4dP+KhvUei7LrBhCO+iB5HT+yk2
         YebkFjly1eKIXSFkpqRQAZHjs8cwJMfVMGleUmopqmJ2d79cdp8XoiWZ6WLmBjBt7d
         Mbrd2gb5STJhA==
Message-ID: <5a1537b6dc242347783dbe17b055a887.mripard@kernel.org>
Date:   Mon, 04 Sep 2023 07:30:11 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Douglas Anderson" <dianders@chromium.org>
Subject: Re: [RFT PATCH 14/15] drm/radeon: Call
 drm_helper_force_disable_all() at shutdown/remove time
In-Reply-To: <20230901164111.RFT.14.I022cfc2dcd30e77d4f7005a2d912dd7ab76c0338@changeid>
References: <20230901164111.RFT.14.I022cfc2dcd30e77d4f7005a2d912dd7ab76c0338@changeid>
Cc:     Xinhui.Pan@amd.com, airlied@gmail.com, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
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

On Fri, 1 Sep 2023 16:41:25 -0700, Douglas Anderson wrote:
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
