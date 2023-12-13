Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E524E811612
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442502AbjLMPWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442501AbjLMPWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:22:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71437100
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:22:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C93C433C7;
        Wed, 13 Dec 2023 15:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702480955;
        bh=tf/O8dGetCNcpoy6MZUH2WfyxvXI3zJrSEHCm5FUzJ0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fNrPOmca6s3S/ZPvqGYwmmGm4U8Nux2est+54hkCERW/9/h6pAIACO4u6ENd52nTP
         EzwruVq8O270QaA6xO+4M1jqR7JOygVP/qryhESjvj3bZC0IsQkf/aOzVantjhURS1
         IC+VRRLEolr7n6scU0vjCCr1HaKCECn4b6yEwVexHKV8/BU1Q+T5FIlHvT3G3mK7WQ
         cPbb114J80/xlnGDBNqk9P/hPTkncp3zlbGBxVT7iIfDaYqChaTdnomlhP8DSzq56a
         682Ysi6huUkV6dFXXafuGxIwf4WFBw5G/b/3U78HTGnz3fJ4Aa5R0GvziJYQl4m6We
         8OcivlPMheioQ==
From:   Maxime Ripard <mripard@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Sandy Huang <hjc@rock-chips.com>,
        =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20231207-kms-hdmi-connector-state-v5-18-6538e19d634d@kernel.org>
References: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org>
 <20231207-kms-hdmi-connector-state-v5-18-6538e19d634d@kernel.org>
Subject: Re: (subset) [PATCH v5 18/44] drm/vc4: hdmi: Create destroy state
 implementation
Message-Id: <170248095242.191897.1505855856456253349.b4-ty@kernel.org>
Date:   Wed, 13 Dec 2023 16:22:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Dec 2023 16:49:41 +0100, Maxime Ripard wrote:
> Even though we were rolling our own custom state for the vc4 HDMI
> controller driver, we were still using the generic helper to destroy
> that state.
> 
> It was mostly working since the underlying state is the first member of
> our state so the pointers are probably equal in all relevant cases, but
> it's still fragile so let's fix this properly.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

