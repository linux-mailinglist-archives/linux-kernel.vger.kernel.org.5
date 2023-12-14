Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144EA812DE5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443878AbjLNK4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444003AbjLNK4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:56:23 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E48D5A;
        Thu, 14 Dec 2023 02:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702551336;
        bh=nDwI9Pl6CCoEAnD+fTst64/YqkRvVVhKmZlxyty2nAw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=b7wF6oaus0TpnLvYOVI62QNuXci/Xd3tppTa1l12+jGW1Kj5elHnVNfXkkGE7eZ63
         pH2QiLUgHz3yAa1sph4DwjxkOEtItW9JA7tOiaeVPI3XJxZ+LUg9kpdXNCQ6CSyDtT
         Kz9WcagvFIPcdgmMs/cunw0MOn0c8Adx0y5aPLEdIogQgkHXSUVfBqqtwKerzyR9j+
         lDYUQlLMeMI8UvoRBIfpMSXhqh3aL+vgIsiZBPKSwHIOfom2G1h0InEGlmBfFH/LBg
         Tf6CqIsaJPMOtJZsY0m7yPZwKNHCOR1nuWbWG7xm4ew/Ckb6GhFDaKGwbY6juzH0ca
         OEORjJUAhZVbA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id F1D31378000B;
        Thu, 14 Dec 2023 10:55:34 +0000 (UTC)
Message-ID: <e5625051-e9e2-4a75-a11a-cf5b40606fa4@collabora.com>
Date:   Thu, 14 Dec 2023 11:55:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] arm: arm64: dts: Enable cros-ec-spi as wake source
Content-Language: en-US
To:     Mark Hasemeyer <markhas@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Raul Rangel <rrangel@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Andy Gross <agross@kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Bjorn Andersson <andersson@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@amd.com>,
        Paul Barker <paul.barker@sancloud.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20231213110009.v1.1.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid>
 <20231213110009.v1.2.I274b2d2255eb539cc9d251c9d65a385cc4014c79@changeid>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231213110009.v1.2.I274b2d2255eb539cc9d251c9d65a385cc4014c79@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/12/23 19:00, Mark Hasemeyer ha scritto:
> The cros_ec driver currently assumes that cros-ec-spi compatible device
> nodes are a wakeup-source even though the wakeup-source property is not
> defined.
> 
> Add the wakeup-source property to all cros-ec-spi compatible device
> nodes to match expected behavior.
> 
> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>

I received only patch [2/6] - please send the entire series to the relevant
maintainers, as otherwise it's difficult to understand what's going on.

As for this patch alone:
  1. arch/arm stuff goes to a different commit
  2. I would prefer if you split per-arch and per-SoC.

Regards,
Angelo


