Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC1B75EE1C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjGXInq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjGXIn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:43:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37719CA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:43:16 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A58DF6607029;
        Mon, 24 Jul 2023 09:43:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690188195;
        bh=+Va/lv+kY8+mB74j/EALrVluhW0bxzE0CAwbF8R0KO8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OMSi/64LbAElUJL4T6UTLVQD7Il2GFk+KZ4ei/CZraSh2Wpkigf1azw5E96NQKroI
         e/DVJNeTJKwdAyd7iijx7YdT9EtJxHUjFejPF0ApdhaofDoCOQ0WXPWbuTX7mJJaAu
         u0oUpWySsMsScs5+NBFrOhnwo9ljcgTH8ed51Rk+jQBou13STRgZ1eiEDuo3mc03f/
         /br4FVRSZ7CknKjli+vyu6KIPQEb82PDCYpvzEnVepvbXlXrH7860++PjplWzkY2XR
         TK0PqYpsG2/Qm2Zh9etD6pCm2l7bhU75DvqDovULup3ASTYCycoxqle1JErDja/mjh
         7FRfTLVwS9yJA==
Message-ID: <c484069d-f41b-1abe-e17d-2a7624964724@collabora.com>
Date:   Mon, 24 Jul 2023 10:43:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] drm/panfrost: Sync IRQ by job's timeout handler
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230723000142.206908-1-dmitry.osipenko@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230723000142.206908-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/07/23 02:01, Dmitry Osipenko ha scritto:
> Panfrost IRQ handler may stuck for a long time, for example this happens
> when there is a bad HDMI connection and HDMI handler takes a long time to
> finish processing, holding Panfrost. Make Panfrost's job timeout handler
> to sync IRQ before checking fence signal status in order to prevent
> spurious job timeouts due to a slow IRQ processing.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Also, on MediaTek MT8192 and MT8195 Chromebooks:

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

