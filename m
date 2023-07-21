Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B664475CCBB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjGUPys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjGUPyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:54:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7172D79;
        Fri, 21 Jul 2023 08:54:19 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 23C5C66070EA;
        Fri, 21 Jul 2023 16:54:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689954854;
        bh=aGb2zEtDX/ptoxn3icdi3HfOY+CTAIz5o9rwC4aMEwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MQVlKjMn/v74MN9GY2ZGkCPUJVr98bbdcMoovGg7r/WpsKlBLzBpzFb00V4REfFfE
         wTODDLD9Y6p5TzatkqI8A0RKvkrV3lA5lialHLY3khrD3M6G5/9N8TrCHEu49EBAgW
         dZg45kBHTb13hZ51frSTBJ7zPhMEix3n8Ft+WJ+ky6CcWCIwbKBVsydTJhANLZUlq0
         Kg04ZoB8xMWTBbAjTQxG2uOhnLfs35JWiKjB2GoscmgcbVK+ZfrlTKYjPDdiEP/w4E
         WRg7FnRFCPn/D5g8wGCi3VW+JBUXV/xk/YsJrennqFF1uMOEfrutW1BQy9C6D2SLMx
         vOmQVbXzdB+VA==
Date:   Fri, 21 Jul 2023 11:54:08 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Set DSU PMU status to fail
Message-ID: <ce77d904-78a7-476c-9571-b1728016046f@notapiano>
References: <20230720200753.322133-1-nfraprado@collabora.com>
 <8bb1a42d-2809-04a9-dcdd-45fc91ea1bde@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bb1a42d-2809-04a9-dcdd-45fc91ea1bde@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 10:16:44AM +0200, AngeloGioacchino Del Regno wrote:
> Il 20/07/23 22:07, Nícolas F. R. A. Prado ha scritto:
> > The DSU PMU allows monitoring performance events in the DSU cluster,
> > which is done by configuring and reading back values from the DSU PMU
> > system registers. However, for write-access to be allowed by ELs lower
> > than EL3, the EL3 firmware needs to update the setting on the ACTLR3_EL3
> > register, as it is disallowed by default.
> 
> Typo: ACTLR_EL2, ACTLR_EL3 bit 12 must be set if SCR.NS is 1;
> ACTLR_EL3 bit 12 must be set if SCR.NS is 0.
> 
> On MT8195 Chromebooks, SCR.NS is 1 - hence ACTLR_EL2/EL3 must have BIT(12) set,
> but at least ACTLR_EL2 doesn't have it set.
> 
> I haven't verified EL3, but that doesn't matter, since both need to be set.

The kernel is running at EL2 (as I verified from CurrentEL), so only ACTLR_EL3
needs to be set. ACTLR_EL2 controls whether EL1 can write to the register (in
non-secure mode) [1], which doesn't matter in this case.

[1] https://developer.arm.com/documentation/101430/r1p2/Register-descriptions/AArch64-system-registers/ACTLR-EL2--Auxiliary-Control-Register--EL2

Thanks,
Nícolas
