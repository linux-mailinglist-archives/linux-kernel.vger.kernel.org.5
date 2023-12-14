Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E479C812D43
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443721AbjLNKo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443699AbjLNKo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:44:56 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2921098;
        Thu, 14 Dec 2023 02:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702550702;
        bh=8MCgKlYjlQs8HPb4sZJqU1bsku1l/knsZYkBzx7U5Fg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dPlxhpBaW7ElU672KHJklTLQuGm3qI83NTgMS1/f5JeIt6eKtjVFvaFZ7P0w8yKGw
         hRcHVnReHUclWo6Us016CB1TDKda3FVpql45MI8dMyul30+jlkFDXa8+BU6mNE9I/E
         +O9eFOVAUC+ii9qp7Hx/wglOhGvN2PouJ6AbLpmmKCew2aBdor2mVAk61u64XiNFnY
         ZbURT4XsbWC+LaIIKaKEuD0xqGyOYecryagUhj45gEAUyWCRDNES/iP9/oJOHq9Bp4
         255la1tUig8oltvahsF3ahpNESGJikk21kjk0xtsE/ZEYeRR8vsM4BhHNq5TXHvhvX
         ihS00YZvxAQwA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id 64B5537814A4;
        Thu, 14 Dec 2023 10:45:01 +0000 (UTC)
Message-ID: <23255060-5a75-4cbe-9fde-f185fa958a6a@collabora.com>
Date:   Thu, 14 Dec 2023 11:45:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] media: mediatek: vcodec: fix possible unbalanced PM
 counter
Content-Language: en-US
To:     Eugen Hristev <eugen.hristev@collabora.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com, tiffany.lin@mediatek.com,
        andrew-ct.chen@mediatek.com, matthias.bgg@gmail.com
References: <20231213122017.102100-1-eugen.hristev@collabora.com>
 <20231213122017.102100-2-eugen.hristev@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231213122017.102100-2-eugen.hristev@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/12/23 13:20, Eugen Hristev ha scritto:
> It is possible that mtk_vcodec_enc_pw_on fails, and in that scenario
> the PM counter is not incremented, and subsequent call to
> mtk_vcodec_enc_pw_off decrements the counter, leading to a PM imbalance.
> Fix by bailing out of venc_if_encode in the case when mtk_vcodec_enc_pw_on
> fails.
> 
> Fixes: 4e855a6efa54 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video Encoder Driver")
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregnoòcollabora.com>


