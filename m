Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D657CA3F5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjJPJWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJPJWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:22:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FADAB;
        Mon, 16 Oct 2023 02:22:00 -0700 (PDT)
Received: from [172.20.10.2] (unknown [185.53.196.201])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 53EC066072AF;
        Mon, 16 Oct 2023 10:21:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697448119;
        bh=/HyiQc3Pfw/ocS0/hyAvyF5PeWrpiR7koV+Tb8YIRYE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J0t4X0l+BraT0SLc66RgbRJ31VYEk95rSLsdr49kIY4Srk6sHiA7W7oQSlgSHhYkB
         +RS/HMUeE+toZ1RSR0oLKP01a/m1sY/49A+eP2/asudK6lK+eTGCRWN5w/Y9olFZvu
         SuZquLurSfwT9RM2Btxgj068QfKe6PD1BrJKLWeHKmO1/OZTZHDLNOe6A+z7RW2pLu
         tQjSLyfBwSqoTs35/nkp8F9sw25FYiIlihmOt21ADG8kYH9l3ZYJvTy6A8yyqsGM2i
         hfxx1EovXEiDA1kRZ5Ij5q1RhWlWN92eR2ftONV79CvtCtyHVxvb4z0s8WMuzyhAYH
         3MjDfHbjUIrhg==
Message-ID: <318016c7-8ceb-4c96-8784-597fac8d194b@collabora.com>
Date:   Mon, 16 Oct 2023 12:21:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] arm64: dts: mediatek: Add MT8186 Krabby platform
 based Tentacruel / Tentacool
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231012230237.2676469-1-wenst@chromium.org>
 <20231012230237.2676469-7-wenst@chromium.org>
From:   Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20231012230237.2676469-7-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/23 02:02, Chen-Yu Tsai wrote:
> Tentacruel and Tentacool are MT8186 based Chromebooks based on the
> Krabby design.
> 
> Tentacruel, also known as the ASUS Chromebook CM14 Flip CM1402F, is a
> convertible device with touchscreen and stylus.
> 
> Tentacool, also known as the ASUS Chromebook CM14 CM1402C, is a laptop
> device. It does not have a touchscreen or stylus.
> 

Hi Chen-Yu,

The Krabby design has the touchscreen ? if the touchscreen is for 
Tentacruel ,then the touchscreen should be described in the tentacruel 
dtsi, not in the Krabby and then deleted for tentacool.

Or is there any reason for describing the touchscreen for Krabby ?
One additional way to solve this is to have the touchsreen as separate 
dtsi and only include it for the boards that have it, e.g. tentacruel .

Eugen
> The two devices both have two variants. The difference is a second
> source touchpad controller that shares the same address as the original,
> but is incompatible.
> 
> The extra SKU IDs for the Tentacruel devices map to different sensor
> components attached to the Embedded Controller. These are not visible
> to the main processor.
> 
[...]

