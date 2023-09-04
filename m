Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08447912A4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351867AbjIDHzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIDHzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:55:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47887138;
        Mon,  4 Sep 2023 00:54:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5E46B80D77;
        Mon,  4 Sep 2023 07:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DACFC433CA;
        Mon,  4 Sep 2023 07:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693814092;
        bh=xc2YozwhEL1/YHfZS9+Y6217G0tcKGwiBjaWl0K5Cyk=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=jKFwPbfSBENdrDNjfQ8bpT1Dix0QCVFSi5ovbrgJS0uEVftPoNyXoUuP6gVc9JunW
         FHGntM8knG/xiqDkWNCs2cyl3eqPYwm0MqApy2EWxZqYFItZ231AtG+GYiTzaus5Z9
         CL3JV0sbNTvw+oytnh6OtoqVZjB+qbhDnZmKex3uq9ym3hakXR1HyL1trh0iOBgYG0
         BL8IBJUYCFPS//OQ+OgdVDkCD35Hd9RNIuiXg0VRqqaz6GXuQ5esDAUBCuUSmyJqSO
         gv7QrMhn6gM/bUDaK/+6PF9HJGdh6qqK1W3og5GwMglhsxPp9q/bWUrSUE0cL4a8eD
         39zB18X/OK3yQ==
Message-ID: <22638b6d731fdcb29367c90461cf0154.mripard@kernel.org>
Date:   Mon, 04 Sep 2023 07:54:50 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Douglas Anderson" <dianders@chromium.org>
Subject: Re: [RFT PATCH 11/15] drm/exynos: Call drm_atomic_helper_shutdown()
 at shutdown/unbind time
In-Reply-To: <20230901164111.RFT.11.Iea33274908b6b258955f45a8aaf6f5bba24ad6cd@changeid>
References: <20230901164111.RFT.11.Iea33274908b6b258955f45a8aaf6f5bba24ad6cd@changeid>
Cc:     airlied@gmail.com, alim.akhtar@samsung.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, inki.dae@samsung.com,
        krzysztof.kozlowski@linaro.org, kyungmin.park@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, sw0312.kim@samsung.com,
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

On Fri, 1 Sep 2023 16:41:22 -0700, Douglas Anderson wrote:
> Based on grepping through the source code this driver appears to be
> missing a call to drm_atomic_helper_shutdown() at system shutdown time
> and at driver unbind time. Among other things, this means that if a
> panel is in use that it won't be cleanly powered off at system
> shutdown time.
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
