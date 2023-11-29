Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8AD7FD817
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbjK2N2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbjK2N2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:28:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989ADBE;
        Wed, 29 Nov 2023 05:28:32 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5466E6607325;
        Wed, 29 Nov 2023 13:28:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701264511;
        bh=taWCxuRcwxm8rYv2PX4GhURTN6aoCQYrpxoloswDaCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GtQynVlBevD0nYYI0urBlThQoY6mX12b1dtF8Syee4Ufwb8/Ne9Zp7SZBfdLBR97y
         RF/mGkSw5ElxmNJfuCX2uk5yYqWMW8SiQDcb28R69rnGoBuOLRLug7Y0O8hDUzegO5
         0yuo4AsvfMz+OOwqIazJpPs4ALn7YxDjpOsdorkRO0xjtG+2+dwtbruM5DC+3duAnT
         HBBjCaELkrfeI5jmPjQMPNw2Xghyn0eO1/Q9LHqSUJhju8AKI5oMq8UXYGM8V9+O4v
         7FKFkRKvkrXEXUfK0nkiPB2OG9EaH2Pm+03aGmN5uCj33Oj2LGTiJHz9gzKqFP8/mg
         WvBhBy/JgXLYQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     linux-mediatek@lists.infradead.org,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jason-ch chen <Jason-ch.Chen@mediatek.com>
Subject: Re: [PATCH v6 0/4] Add basic node support for MediaTek MT8188 SoC
Date:   Wed, 29 Nov 2023 14:27:37 +0100
Message-ID: <170126437825.153055.7543169831519671464.b4-ty@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023083839.24453-1-jason-ch.chen@mediatek.com>
References: <20231023083839.24453-1-jason-ch.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Oct 2023 16:38:35 +0800, Jason-ch Chen wrote:
> From: jason-ch chen <Jason-ch.Chen@mediatek.com>
> 
> MT8188 is a SoC based on 64bit ARMv8 architecture.
> It contains 6 CA55 and 2 CA78 cores.
> MT8188 share many HW IP with MT65xx series.
> 
> This patchset was tested on MT8188 evaluation board to shell.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: arm: Add compatible for MediaTek MT8188
      commit: 17bc1b4cc2709c05494d17356a6263f3f253a129
[2/4] dt-bindings: arm: mediatek: Add mt8188 pericfg compatible
      commit: 1407001eabf44b3ae002abee4fc4d9f8a4090005
[3/4] dt-bindings: soc: mediatek: pwrap: Modify compatible for MT8188
      commit: 07d03d9b5df233d3e47112df898f00958f4e763f
[4/4] arm64: dts: Add MediaTek MT8188 dts and evaluation board and Makefile
      commit: ff71e99d9d1c8943c62397e06df6507765b2d771

Best regards,
-- 
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
