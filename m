Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D13D79B67C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354119AbjIKVwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbjIKJFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:05:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA3FCCC;
        Mon, 11 Sep 2023 02:05:03 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6979A6607083;
        Mon, 11 Sep 2023 10:05:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694423101;
        bh=jo+lZBQFX99dvsGk7KaxmmTzA/MbOTJVrWbivOzXhRs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mtbHD9qpBwnAOBT1Pf31tPa8e9/mfxJdawdT3LzaggZOVj+Q/9ZsDK+j9T7vgPg1v
         0QF3yxm7I/3uMSaQTZRMno7orv74HXfIgajTkAMwer/tSo0iizWjtv6JROGXyIs9jC
         kNlRnJxDA33hBYDTunhybVndN9vhcQMJMRqLs5TLJF3IIFM7dYh27QKsAqfAVEShsS
         7l9+nrqOq46Mo+H+nE+6uNUVzi/R3h0KQCa0iybQJSo3K6DC/3w3YXqCHGk5rXha5I
         4DyIE6Z56+o2dgGaNicFofHW4X4zNVtwlhrzcfesJPBf1i6cSs6cvwNZEoILKNf4Zm
         uvECARebonWfA==
Message-ID: <3cc94def-04b7-fdf7-622d-96db0fdd95c7@collabora.com>
Date:   Mon, 11 Sep 2023 11:04:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 6/9] arm64: defconfig: Enable DA9211 regulator
To:     Vignesh Raman <vignesh.raman@collabora.com>,
        dri-devel@lists.freedesktop.org
Cc:     helen.koike@collabora.com, guilherme.gallo@collabora.com,
        sergi.blanch.torne@collabora.com, david.heidelberg@collabora.com,
        daniels@collabora.com, gustavo.padovan@collabora.com,
        emma@anholt.net, robclark@freedesktop.org, robdclark@google.com,
        anholt@google.com, robdclark@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, jani.nikula@linux.intel.com, mripard@kernel.org,
        dmitry.baryshkov@linaro.org, matthias.bgg@gmail.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org
References: <20230908152225.432139-1-vignesh.raman@collabora.com>
 <20230908152225.432139-7-vignesh.raman@collabora.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230908152225.432139-7-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/09/23 17:22, Vignesh Raman ha scritto:
> Mediatek mt8173 board fails to boot with DA9211 regulator disabled.
> Enabling CONFIG_REGULATOR_DA9211=y in drm-ci fixes the issue.
> 
> So enable it in the defconfig since kernel-ci also requires it.
> 
> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> 
> v3:
>    - New patch in the series to enable CONFIG_REGULATOR_DA9211 in defconfig
> 
> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index a25d783dfb95..ef22b532b63a 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -711,6 +711,7 @@ CONFIG_REGULATOR_AXP20X=y
>   CONFIG_REGULATOR_BD718XX=y
>   CONFIG_REGULATOR_BD9571MWV=y
>   CONFIG_REGULATOR_CROS_EC=y
> +CONFIG_REGULATOR_DA9211=m
>   CONFIG_REGULATOR_FAN53555=y
>   CONFIG_REGULATOR_GPIO=y
>   CONFIG_REGULATOR_HI6421V530=y

