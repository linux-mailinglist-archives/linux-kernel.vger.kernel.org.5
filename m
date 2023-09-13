Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C0979E33F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239348AbjIMJMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239258AbjIMJLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:11:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C001BD2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:11:37 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5CFEB660732C;
        Wed, 13 Sep 2023 10:11:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694596296;
        bh=B6Y8DaRQqeLKIKOViOvNom5o3bLaF//t/+GNjx7AWCo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BmODv/ta18Dnr09CMswJHScEKyNaDjaM9LefshuvznBQK+MFEAPTt8ORlv111/SFh
         wpyOYtJofxhLG8zQLm1kCGWACu2RKIMTV+S6CL3QFTjJJN3H3QR3mSOWa9hxjseeHT
         v+TSmZZp9UZgruZBinI9HohOPOVJ+Bp3hDEayuW5jNSS28NmGbybqWhm6IUSD+Qyn8
         FRcpynPxfwSD7e+xokJPFFbUxhYLadvOGTMtzRkBn5lI+lpNeQzYa/Rh7fqtDXfeoj
         vqH8X7XOUYSr4G5bqeEfug7GUqYMzKZhluD0cryeHPHxFio1fe7m/x+dhk5k1YBNJx
         PxvBsAxYmUusA==
Message-ID: <8b5c1d8d-7575-17b4-5935-993ac7a60626@collabora.com>
Date:   Wed, 13 Sep 2023 11:11:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/5] spmi: Introduce device-managed functions
Content-Language: en-US
To:     Fei Shao <fshao@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230824104101.4083400-1-fshao@chromium.org>
 <20230824104101.4083400-2-fshao@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230824104101.4083400-2-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/08/23 12:40, Fei Shao ha scritto:
> Utilize the managed resource (devres) framework and add the following
> devm_* helpers for the SPMI driver:
> 
> - devm_spmi_controller_alloc()
> - devm_spmi_controller_add()
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


