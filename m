Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559A97FD80E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbjK2N2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbjK2N2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:28:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5D2B0;
        Wed, 29 Nov 2023 05:28:29 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3833866072FC;
        Wed, 29 Nov 2023 13:28:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701264508;
        bh=6LCAIT4P/nvAhPgTDUDx07TqLshXCpjOmlXXLCHI4To=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NEF6gWlf2ddCV9DPiXYopma9Lf7I5mUfAmKhSeoibvHwRiZ7USgDx//Y+EHFBwQoK
         rYgx4Q7t2ngsR2ts4MssQy/JpV9eiLTRFLVTZERrq7+iXeAH9Ok9JjRvQDv8EDlMJv
         AkK7ECAk0tLrA6j3hOcUY88def0Hya1iZY+/sDYEhds983G6y2pgjz99v6UaR6NtAA
         0H98L/57riKpOwZlaxESwok8IjyRsMy8D6ZuAvk+2KE3sV26WC1FqT7BRvZlx5G4We
         jFgf+An2yRtk1r6PzcH60B+/7IuS09J/fS2X+A3J2M/Vl67db3MXNd8phRHLaxFiQq
         I7G25aP7mkE1g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     linux-mediatek@lists.infradead.org,
        Eugen Hristev <eugen.hristev@collabora.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com,
        kernel@collabora.com, hsinyi@chromium.org
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183-kukui-jacuzzi: fix dsi unnecessary cells properties
Date:   Wed, 29 Nov 2023 14:27:34 +0100
Message-ID: <170126437824.153055.10626099314938040381.b4-ty@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230814071053.5459-1-eugen.hristev@collabora.com>
References: <20230814071053.5459-1-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Aug 2023 10:10:53 +0300, Eugen Hristev wrote:
> dtbs_check throws a warning at the dsi node:
> Warning (avoid_unnecessary_addr_size): /soc/dsi@14014000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> 
> Other DTS have a panel child node with a reg, so the parent dtsi
> must have the address-cells and size-cells, however this specific DT
> has the panel removed, but not the cells, hence the warning above.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: mediatek: mt8183-kukui-jacuzzi: fix dsi unnecessary cells properties
      commit: 4b66a34afe29d991155081b2f1e10482bd00cbaa

Best regards,
-- 
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
