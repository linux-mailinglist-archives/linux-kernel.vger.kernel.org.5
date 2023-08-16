Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA38F77EB46
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346325AbjHPVDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346383AbjHPVCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:02:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBA62711;
        Wed, 16 Aug 2023 14:02:51 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 481D566071BF;
        Wed, 16 Aug 2023 22:02:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692219770;
        bh=jcClwl4OGhC99pJpLTCKo2SBLKEEIwwWT4mkt12MUAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SlOO2yujal0smFFdkkDA4F1oLNQ4Iy07tmMC8ovoYd5hQ7lKGaQTnU/Ew8qgRcX+w
         6T2utv1AT9PcqeLlBsGwQ3MMiJiw5dsRewkMf48F0zCOClDzNimo1R5CMvN9YjUYgE
         pxH4krlF2s1jDplw1fKKC6zsJ9a8LdHMsrfJNTKWNdg9foiYgqj11r2bbTqhd/8bS/
         NWiHMPRF7i0XO5J1mG2/e2AiB8xtQqz4KP5PUyxB7rFVXGrOszjm7M2IldsnkpdJJ4
         1lEwd8XFg79mDfVTIdrQl0QZfZ2nIWo7u9f4xcmUgDgxjzy2lXEuLgxuddSH4z5D+5
         zYyi1cLoFWVRA==
Date:   Wed, 16 Aug 2023 17:02:43 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Bernhard =?utf-8?Q?Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com,
        amergnat@baylibre.com, khilman@baylibre.com
Subject: Re: [PATCH v4 0/5] Add LVTS support for mt8192
Message-ID: <6547843f-95e7-4bb8-a463-06989acee847@notapiano>
References: <20230530195132.2286163-1-bero@baylibre.com>
 <107678ff-c3d5-4c3a-ad0e-fa292a125daa@notapiano>
 <a97efd71-23e2-5ac9-8d3d-427a431353c6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a97efd71-23e2-5ac9-8d3d-427a431353c6@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 10:49:21PM +0200, Daniel Lezcano wrote:
> 
> Hi,
> 
> On 16/08/2023 21:57, Nícolas F. R. A. Prado wrote:
> 
> [ ... ]
> 
> > Hi Daniel,
> > 
> > just a gentle reminder. As you've just applied [1], there are no longer any
> > concerns with this series, and it'll provide both working interrupts and
> > reliable thermal readings on MT8192.
> 
> There are still concerns and questions in the series for patch2 and 3.

Indeed, I missed those, sorry for the noise.

Thanks,
Nícolas
