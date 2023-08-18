Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DA078121A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379133AbjHRRhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379185AbjHRRhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:37:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882433C2F;
        Fri, 18 Aug 2023 10:37:31 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B9D7A6607258;
        Fri, 18 Aug 2023 18:37:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692380250;
        bh=zn9oR99CAXJJI6TttM03GCqH+pqWZJKU1SVZwemu3yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lwwBy4A/RdqwsiL/aVstRnbEbJG0J67iiUd3ZtOE+2bOQYU34iOrIhQnyHN+OGlWt
         XzdfIpGz4sw8GZxB8rwck6kkz+xgevU3z8xXzAw3gM/LLXxwqypjVAP/eKGOq1gW0f
         j0LSyLoK+3kAdVCBTLUV0te4mgYJLWyeIl4+W7iYQNdxfn2bXAgOHkd+mIXY4pE2Jn
         OQUosFAUW1yXiD8D47aufHGNfdnYb9Ew8tXZTC1i+4nf4BSLizdY0tcFkNopmjHcca
         qLlUJEBRQWJXFPiIb2Ilk2GlaxdFWDR82d0yPsTdz2+PqMQL/GDOoZdxO9EUaHQls9
         e1qg99odBunPA==
Date:   Fri, 18 Aug 2023 13:37:24 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3] arm64: dts: mediatek: cherry: Configure eDP and
 internal display
Message-ID: <8e7ce141-9c7b-4bf8-8929-deeebdbb9ac8@notapiano>
References: <20230816190427.2137768-1-nfraprado@collabora.com>
 <CAGXv+5EnbovYSfw=_wSKyKTSbDQYu6UW8u8L5bm9PKjN1dVGyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5EnbovYSfw=_wSKyKTSbDQYu6UW8u8L5bm9PKjN1dVGyQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 05:19:22PM +0800, Chen-Yu Tsai wrote:
> On Thu, Aug 17, 2023 at 3:04 AM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >
> > Add the required nodes to enable the DisplayPort interface, connected
> > to the Embedded DisplayPort port, where we have an internal display.
> >
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > [nfraprado: removed always-on, added vin-supply and enable delay]
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> 
> > ---
> > The MediaTek DRM changes needed for MT8195 have already been queued for
> > v6.6 [1], so this DT patch is the last missing piece needed to get
> > a working display on MT8195 Tomato.
> >
> > [1] https://lore.kernel.org/all/20230813152726.14802-1-chunkuang.hu@kernel.org/
> >
> > Changes in v3:
> > - Split from "MT8195 Acer Tomato - devicetrees Part 3" series
> 
> The platform thermal patch from that series hasn't been merged either?

Yes, indeed. But given that the DRM series was just merged and this became the
last missing piece to make MT8195-Tomato an actually usable chromebook upstream,
I thought it made sense to split this patch so it can be prioritized for the
v6.6 merge window.

But I'll also send a new version for the thermal patch.

Thanks,
Nícolas
