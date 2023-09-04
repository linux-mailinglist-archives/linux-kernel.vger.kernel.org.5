Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D527912DC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbjIDIAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241146AbjIDIAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:00:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58719106
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 01:00:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AD8B0CE0E3B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 08:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D61C433C8;
        Mon,  4 Sep 2023 08:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693814436;
        bh=msH+AlW1tcnzrzUkcVH/Gu9dCYW/mw+O6xT2pWlSs9M=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=ka9xt4kMgaXoKCttn3PTsy/pLUsanMSnIUZu5nMztBnSY0Wdzf6Dew7ALC7I+Rqdb
         ZtFVsXZ0oRdRFZ097j4GXusIpKe6qP1i8uQ060FdShTuPNNV7+Cf12ScsnQLXx2O6k
         hJsXvyjbbEc/2PmpFJcdizh2eKOeUXKmg+lxtLBmnQvq4kDO7fATE0ZI5V/EbxvIeo
         /hf0eGtgU7PesSck8b14tvH1M2iSyEmpidZw0ou54S9x+U+JsZO8IozatJNez+bGKq
         Q2T9/AIU9uHcBmHafOGNfIuDXOb1yZhv58vQFjLoAjQ9cBhnENTAk6MAlYEO4zn25J
         RTzUxL16SoUBA==
Message-ID: <1506b6324d05084097f1971520d76fa0.mripard@kernel.org>
Date:   Mon, 04 Sep 2023 08:00:34 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Douglas Anderson" <dianders@chromium.org>
Subject: Re: [RFT PATCH 5/6] drm: Call drm_atomic_helper_shutdown() at
 shutdown/remove time for misc drivers
In-Reply-To: <20230901163944.RFT.5.I771eb4bd03d8772b19e7dcfaef3e2c167bce5846@changeid>
References: <20230901163944.RFT.5.I771eb4bd03d8772b19e7dcfaef3e2c167bce5846@changeid>
Cc:     airlied@gmail.com, airlied@redhat.com,
        alexandre.torgue@foss.st.com, andrew@aj.id.au, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, emma@anholt.net,
        hdegoede@redhat.com, jfalempe@redhat.com, joel@jms.id.au,
        jyri.sarha@iki.fi, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, philippe.cornu@foss.st.com,
        raphael.gallais-pou@foss.st.com, tomi.valkeinen@ideasonboard.com,
        tzimmermann@suse.de, yannick.fertre@foss.st.com,
        "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2023 16:39:56 -0700, Douglas Anderson wrote:
> Based on grepping through the source code these drivers appear to be
> missing a call to drm_atomic_helper_shutdown() at system shutdown time
> and at driver remove (or unbind) time. Among other things, this means
> that if a panel is in use that it won't be cleanly powered off at
> system shutdown time.
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
