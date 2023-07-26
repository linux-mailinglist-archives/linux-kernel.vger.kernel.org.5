Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9C6763F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjGZTM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGZTM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:12:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6839A1FF0;
        Wed, 26 Jul 2023 12:12:25 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 352A56606EEE;
        Wed, 26 Jul 2023 20:12:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690398743;
        bh=G4FpupW9DEtNaFD9OegV101Badg4Woe69O1Mqu29tLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FyHgYP+LMWGPpR15ecxcluCrj2UnBtlDXh8fp8ZMNDaNCBAp0In6uhGIcCn7Aezzj
         PRc4u0m9VvHNAVIy9dWSwgyitMV0Q5icqDBwutExWf+dZrY5+wIyMXjAVTCVx5XGZL
         yeS5ECBd/e9RNY/4e/igKjEr0qnOd1IMidJ2K9pB7jPBlXM8t6lFNBI5gDZAA3PGLM
         2UE3RbG5fYmKQyJCuWVNjxKxLcfVaK29FcrnbJRDbAV/YuQ804rOxY3PAHPttu8NRf
         vP0FGCSBLFCb2GcnDkRHEyV3GJA9kiZ8vCgEh1o9wV4ArtcTupNkP4JjgLUc2loO12
         BQ1Tlt8U5x7Xw==
Date:   Wed, 26 Jul 2023 15:12:17 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH v5 6/7] arm64: dts: mediatek: mt8173: Drop VDEC_SYS reg
 from decoder
Message-ID: <8b9bd1ba-5d0b-4eaf-8284-d9f0c523d358@notapiano>
References: <20230630151436.155586-1-nfraprado@collabora.com>
 <20230630151436.155586-7-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230630151436.155586-7-nfraprado@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 11:14:12AM -0400, Nícolas F. R. A. Prado wrote:
> Remove the VDEC_SYS register space from the decoder, so that the node
> address becomes that of VDEC_MISC, solving the long-standing conflicting
> addresses between this node and the vdecsys clock-controller node:
> 
> arch/arm64/boot/dts/mediatek/mt8173.dtsi:1365.38-1369.5: Warning (unique_unit_address_if_enabled): /soc/clock-controller@16000000: duplicate unit-address (also used in node /soc/vcodec@16000000)
> 
> The driver makes use of this register space, however, so also add a
> phandle to the VDEC_SYS syscon to maintain functionality.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Hi Matthias,

just to let you know that Hans has already picked up patches 1-5, and they're on
their way to the media tree:
https://lore.kernel.org/all/af0772c6-7052-ce13-dbf3-d403b06aad02@xs4all.nl

So feel free to pick patches 6 and 7. Though note that these DT changes depend
on those driver patches (commits 1-5) to work.

Thanks,
Nícolas
