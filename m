Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1168F7D7E24
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344465AbjJZINl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjJZINk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:13:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D290B8;
        Thu, 26 Oct 2023 01:13:38 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0CCB06607331;
        Thu, 26 Oct 2023 09:13:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698308016;
        bh=b4sv+Fx9di5WoipS7karC4btrWmed47jb0eGgVLSPHE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Nv1dpivhq9t0r8s27I1+mf0LG047q5JakBxxDuYEGbpJY0xlOVusLF3pMoU7xvZkl
         8V2RbRKwXdve1jUYvq1AzNDr14d+5IV7IbjTyVFyKRE3yxE4vOxq9xiGGLuQBffjZE
         0Zo/cWs+114VOfhIVrIHCsCz5T0VybZuCRza3fz0Vkg7MlHCfVI4o3XXGFLFguKhCb
         jbdhSaBEvPOLMyonGaDRQUzJhyh8mhRNnACTA/ygELPzJltPuAb+G8BX3rQFGGYASE
         01WG/GZKXMVlOQPHT1RYShYDkULFkQZwLhdorvqgd5gpZs8jRK2QOOqJ03S/pYmDu1
         BCJd3Ox0193pA==
Message-ID: <5f2f0bad-5a9f-4ae7-86ae-45bbe12ca9b4@collabora.com>
Date:   Thu, 26 Oct 2023 10:13:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] arm64: dts: mt8183: kukui: Fix underscores in node
 names
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= 
        <nfraprado@collabora.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231025215517.1388735-1-hsinyi@chromium.org>
 <20231025215517.1388735-2-hsinyi@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231025215517.1388735-2-hsinyi@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/10/23 23:48, Hsin-Yi Wang ha scritto:
> Replace underscores with hyphens in pinctrl node names both for consistency
> and to adhere to the bindings.
> 
> Fixes: cd894e274b74 ("arm64: dts: mt8183: Add krane-sku176 board")
> Fixes: 1652dbf7363a ("arm64: dts: mt8183: add scp node")
> Fixes: 27eaf34df364 ("arm64: dts: mt8183: config dsi node")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


