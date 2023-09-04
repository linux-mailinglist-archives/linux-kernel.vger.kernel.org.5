Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A0D791257
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348433AbjIDHhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352439AbjIDHg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:36:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64931138
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:36:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEBD161231
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA17C433C8;
        Mon,  4 Sep 2023 07:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693813014;
        bh=1kEqDO+Le0/vd5hsx9Tq9iF6mUzLlU0yolPMHIZIPl0=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=Hyc+AdqHrJ762BvgfQcGmZcibW8ab+UpNM85RE5MY8vbO0DiUI7HN4es6MbLGK7Ba
         Jm3+jZmyQKeuaimVoGBkZgJz7dAQ3PjCIY3jgRcBFPtBPo3Ed3xXFCp1qnZsqkiJJh
         VL0gWbkmPOqPy0mW9QRUsyGG/shEM6P5neuu4VQOrETl1waqcbosGVB2Hlrdfff2TB
         PJSeSqOa9QyYwd0YOyU638/1M58nlCyaQcyLJ7XH4pyRGQLZ+T3XGJvNhbMEZF1SIs
         fh2meoyexKImRKBKQ1owzpSqFPzrUUpTxkco1sdijx754GP2uCwoF12J73P589eCi5
         tzkzU3H3r+nrA==
Message-ID: <d9de015051febb9e10760e7f94aef552.mripard@kernel.org>
Date:   Mon, 04 Sep 2023 07:36:51 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Douglas Anderson" <dianders@chromium.org>
Subject: Re: [RFT PATCH 02/15] drm/imx/dcss: Call
 drm_atomic_helper_shutdown() at shutdown time
In-Reply-To: <20230901164111.RFT.2.I134336fce7eac5a63bdac46d57b0888858fc8081@changeid>
References: <20230901164111.RFT.2.I134336fce7eac5a63bdac46d57b0888858fc8081@changeid>
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, festevam@gmail.com,
        kernel@pengutronix.de, l.stach@pengutronix.de,
        laurentiu.palcu@oss.nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, "Maxime Ripard" <mripard@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>
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

On Fri, 1 Sep 2023 16:41:13 -0700, Douglas Anderson wrote:
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
