Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090597B5723
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbjJBQKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238416AbjJBQKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:10:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB75B4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:10:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7353DC433CA;
        Mon,  2 Oct 2023 16:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696263026;
        bh=CfIUOjCxqP4k4PEwlJ3KWN+LSN/aN14INr8PFuBU1gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KmUE24gWThX+EImHY5hV0v2pHMvLxkeVCnJHZ00Ae79HwxE+sH2xf6rO2icIcHLhQ
         kuA8UeyUFpfQ/Rrv+WrhFR6u7+HlluCNkxLc4ZGuJMo6ouClZnoRU0/L+Ut0StCG1e
         5n4Ol+PmGUNzV6aqmJVwDPZALnTtEvbd+avoD6v6N4vnmHmz5N+IBuujSzUmrpCZDw
         l8m09QHqaE7NDsWQ1m3Bs0PjPWniEVLWZCZC4jYP1wsgovVnDW1IDYO+nbEOFjt43z
         OafuSZjskWKxClwam76QWAaOnQfrNih7e5z+BOBN71TRiC/9F2lZry67Vc+t11BfAW
         RxMXo9xuRonwQ==
Received: (nullmailer pid 1867798 invoked by uid 1000);
        Mon, 02 Oct 2023 16:10:24 -0000
Date:   Mon, 2 Oct 2023 11:10:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 02/12] regulator: dt-bindings: mt6358: Convert to DT
 schema
Message-ID: <169626302358.1867415.15357334455488086427.robh@kernel.org>
References: <20230928085537.3246669-1-wenst@chromium.org>
 <20230928085537.3246669-3-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928085537.3246669-3-wenst@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Sep 2023 16:55:25 +0800, Chen-Yu Tsai wrote:
> Convert this from the old style text based binding to the new DT schema
> style. This will make adding the MT6366 portion easier.
> 
> The examples have been trimmed down considerably, and the remaining
> entries now match what is seen in actual device trees, minus some
> properties that aren't covered by the bindings yet, or don't make
> sense on their own.
> 
> The original submitter seems to have left MediaTek, so instead the
> submitter and maintainer for the MT6366 binding is listed as the
> maintainer here.
> 
> Cc: Zhiyong Tao <zhiyong.tao@mediatek.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v3:
> - ldo_vxo22 and ldo_vusb moved to properties
> 
> Changes since v2:
> - Added missing end-of-string match to regulator names
> - regulator-coupled-* properties in example dropped
> - #include and regulator-allowed-modes moved to new patch
> 
>  .../regulator/mediatek,mt6358-regulator.yaml  |  98 +++++
>  .../bindings/regulator/mt6358-regulator.txt   | 350 ------------------
>  2 files changed, 98 insertions(+), 350 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
>  delete mode 100644 Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

