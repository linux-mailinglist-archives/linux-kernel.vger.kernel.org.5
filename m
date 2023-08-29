Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FFB78C9AD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbjH2QBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbjH2QAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:00:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1664C1B7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:00:37 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5F4A56607236;
        Tue, 29 Aug 2023 17:00:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693324835;
        bh=JCfP29V3g/z06V7q+2qRQmI7uI0SGWM3SW0Z6ZJgNl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XMDriXCzwSEEe30YsG8nKNO4L66h3QBquvxvUS7YQbKvfTaF/v4utnOUazsTmr3WI
         lOuX4955i/ct+lSgyN8T28c+Uksuu7ZLqwdpKl1bddyet1Hd2ngafJSKOHfBs/Qzsz
         TjxkJd6B9rgqrVTItQ5VNlQT/pf67jTAw8pQt6SWSUUHnQgIWiptYtwDgayqVZFPb6
         lqf8AeL8rg7Bh5V3jiYG8JUBb0YRZslko9/bJ0H7G+m/686w+vB3vrHdx+otVlcdU6
         Dzis5e0zZSOPJQeM4KQrLXCSjMdbuP0p15LAsnNgpy4u36X9HWzboVHrqxbMhOiX4h
         FKQ5M19VLxWaw==
Date:   Tue, 29 Aug 2023 12:00:29 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Michael Walle <mwalle@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Nancy . Lin" <nancy.lin@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] drm/mediathek: fix kernel oops if no crtc is found
Message-ID: <16f85ad3-57f4-4cde-88fc-b9d0b763f9e2@notapiano>
References: <20230829131941.3353439-1-mwalle@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230829131941.3353439-1-mwalle@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 03:19:40PM +0200, Michael Walle wrote:
> drm_crtc_from_index(0) might return NULL if there are not CRTCs

Typo: not -> no

> registered at all which will lead to a kernel oops in
> mtk_drm_crtc_dma_dev_get(). Add the missing return value check.
> 
> Fixes: 0d9eee9118b7 ("drm/mediatek: Add drm ovl_adaptor sub driver for MT8195")
> Signed-off-by: Michael Walle <mwalle@kernel.org>

There's also a typo in the commit subject: mediathek -> mediatek. But
regardless,

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

(tested that the patch fixes the oops on mt8195-cherry-tomato when no display
pipeline is available)

Thanks,
Nícolas
