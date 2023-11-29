Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779957FD81A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjK2N2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbjK2N2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:28:32 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D770710C4;
        Wed, 29 Nov 2023 05:28:33 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A6DBB66072FC;
        Wed, 29 Nov 2023 13:28:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701264512;
        bh=zpfPELY7wglGVGim2aiQUgNevSQhwaMs8bxwBu3nImA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d2GCaSf0HHb/WcEFbaGeF+PowDdvtzLDIjiEJXD602hcWNS9wavx0yKtppPCwz75A
         sUKvF73EcfszuB34bUPOkeE+GhPYMhw5YolQpquersEUkYbMSMUfLGskKE+4uYGVxH
         D6gkXwYLwuqtC/jTAyfkjhJ+vtk7ubF+JZ++06Vu6lGR5VvoLrE3AmtjLMvC4eAOkT
         En9SaoStVVbNP1m6YHFsMwD5p6kpzDW/YiN+hQFHMVJswZ9T0CBfkO2SiWflvKFP8W
         MVnSo6Zz3lnD02EqXOOq/V8bQR9t1wk3ATCh/eaSG4m6xfLrlepvNQqx6R86+w8tUU
         33TfhEGhez0Ww==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     linux-mediatek@lists.infradead.org,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Frank Wunderlich <linux@fw-web.de>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com,
        kernel@collabora.com, Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Eric Woudstra <ericwouds@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/5] arm64: dts: mt7986: fix emmc hs400 mode without uboot initialization
Date:   Wed, 29 Nov 2023 14:27:38 +0100
Message-ID: <170126437823.153055.14524036820842918746.b4-ty@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025170832.78727-2-linux@fw-web.de>
References: <20231025170832.78727-1-linux@fw-web.de> <20231025170832.78727-2-linux@fw-web.de>
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


On Wed, 25 Oct 2023 19:08:28 +0200, Frank Wunderlich wrote:
> Eric reports errors on emmc with hs400 mode when booting linux on bpi-r3
> without uboot [1]. Booting with uboot does not show this because clocks
> seem to be initialized by uboot.
> 
> Fix this by adding assigned-clocks and assigned-clock-parents like it's
> done in uboot [2].
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: mt7986: fix emmc hs400 mode without uboot initialization
      (no commit info)

Best regards,
-- 
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
