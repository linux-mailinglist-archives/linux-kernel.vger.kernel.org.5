Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639BC792A88
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242125AbjIEQi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354796AbjIEO1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:27:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07E3189
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 07:27:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82156609E9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1BEC433C7;
        Tue,  5 Sep 2023 14:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693924019;
        bh=JTMR51obR6EYPhug45RQ+7RA0Wf7YLMTHtRR/RYHKjU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dnhRRS9HLnrSB1DBbYSCM/h2W/y9CJvmevRjFGDHezagB7rgP7Ett4E8ioEkwHHqq
         5gv3kahK0t21oVAyXErnvKD5vltpUgLTYAoxpRk0eG2RykpLoYY1JibzXyp6OyiMnv
         Psmj64WxAyLmtjmcR7D2Hlvy9Kha40ougiGgghEfPrGVIPE56k6+ipdiMfuq8o08A7
         sWeWg5LwMKMCNER8EfIdlU1JHQ77aTxYtHJJ5AUFN4SRVchM/tOKlIPrvmYJDz5BKd
         +NgtrJx6tOS4b5aItz7yl5UfQebX18kMx3WGDzgBGcvRny8TVVwZSOuseOPFVqLWTP
         lgigJb3mEAbqQ==
From:   Robert Foss <rfoss@kernel.org>
To:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Nicolas Belin <nbelin@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jai Luthra <j-luthra@ti.com>,
        "Andy.Hsieh" <Andy.Hsieh@mediatek.com>,
        Phong LE <ple@baylibre.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     nm@ti.com, Helen Koike <helen.koike@collabora.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devarsht@ti.com, Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20230901-it66121_edid-v2-1-aa59605336b9@ti.com>
References: <20230901-it66121_edid-v2-1-aa59605336b9@ti.com>
Subject: Re: [PATCH v2] drm: bridge: it66121: Fix invalid connector dereference
Message-Id: <169392401621.1005565.3123120180972167667.b4-ty@kernel.org>
Date:   Tue, 05 Sep 2023 16:26:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2023 15:01:23 +0530, Jai Luthra wrote:
> Fix the NULL pointer dereference when no monitor is connected, and the
> sound card is opened from userspace.
> 
> Instead return an empty buffer (of zeroes) as the EDID information to
> the sound framework if there is no connector attached.
> 
> 
> [...]

Applied, thanks!

[1/1] drm: bridge: it66121: Fix invalid connector dereference
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=d0375f6858c4



Rob

