Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765B575B08B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjGTN6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGTN6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:58:12 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38782123
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:58:11 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbd33a57dcso7369915e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689861489; x=1690466289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6KjNhZCS5Ih96I9bAacZuqvFr9UPsBlbZ9B2cRl79QI=;
        b=MgUMJiXasfQ3Ozh+7C8FYKynZyNNkQhjpHoEx17vOyDhn+jnpTMXtAtKBBRDywoyJZ
         K3Ii8cUsGzBTrQUD4oIk5q9gJjKIPsaJ/iWytBSrIlp8/Zh4jtbAfwvyMgnNS68bLGtc
         4X+ttDW0mCnHCyIRWv9dGljI0vbLDoDcQaqn+kK78OKU0FiiMlv8Ry1IzMBZ1Zyd8EeF
         V0w5nW0n6xAKwdOgszxeHlnybYmfaTe322Xk8KMxNGq8Sk57sgfq0M8RnY/8ej2vfyE1
         a8oh6yYj6e2G+8eczinpn0SpJ97ywOD0N41C5L+KwYHxptNRzWvzc9miiOx/svlkAW/9
         /1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689861489; x=1690466289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6KjNhZCS5Ih96I9bAacZuqvFr9UPsBlbZ9B2cRl79QI=;
        b=b6lxNn4tdYtCMyH7wLliRtlCkPQAtQUVuQ7DJS4roOW6BmJvjvpIKXkX4TEgUczK25
         rMYQuPupmDqztVqfmbEpH3y5evUBbAd362wp9vJ9PnkmmgJCHN87gCa/ugaJaESncX8I
         +6VZVYN7Ag264WlkwBRyFNJ57stvu3cN7TVBb6Ie7QFrdt0jOUISSLQFtjADRWt0eiZm
         zTODVAAo8CLa8F2Nv7wrot0jupEykbA5a8IcCsYB1yTnuUB5043jPLDOi67MVFNcBz7i
         r8hEsgKY4w6ymxEZELL/reqr6eHisdD2Px93bL6A4d/xmb8nXJ5/3hkqltsnWhH/oPrZ
         xKJw==
X-Gm-Message-State: ABy/qLY/z6xrN1k3qX/rEAkXrhdoJs+8bBzsLV+1DPLKXCPmujnJl16I
        7dXiM9ir6NYkF0pUtvlM+PbmVQ==
X-Google-Smtp-Source: APBJJlFG9cyOubbOROpvzag6IpZ7+gawUh0kbE6UP3Vgh8NySRsEiGPb78RC8ywPhOF3DSTCEkpT3g==
X-Received: by 2002:a05:6000:194f:b0:315:8fc0:915e with SMTP id e15-20020a056000194f00b003158fc0915emr1945057wry.56.1689861489726;
        Thu, 20 Jul 2023 06:58:09 -0700 (PDT)
Received: from [10.1.3.131] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e10-20020adfe7ca000000b003143add4396sm1434471wrn.22.2023.07.20.06.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 06:58:09 -0700 (PDT)
Message-ID: <65a7fc52-5438-3c9d-cd1b-cf8a83986c88@baylibre.com>
Date:   Thu, 20 Jul 2023 15:58:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 08/11] drm/mediatek: dp: Move PHY registration to new
 function
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org, nfraprado@collabora.com
References: <20230717141438.274419-1-angelogioacchino.delregno@collabora.com>
 <20230717141438.274419-9-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230717141438.274419-9-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 17/07/2023 16:14, AngeloGioacchino Del Regno wrote:
> In preparation for adding support for eDP, move the PHY registration
> code to a new mtk_dp_register_phy() function for better readability.
> 
> This commit brings no functional changes.

-- 
Regards,
Alexandre
