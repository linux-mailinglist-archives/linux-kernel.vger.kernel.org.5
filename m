Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5867B1F19
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjI1N7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjI1N7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:59:39 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B7911F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:59:37 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-405497850dbso110269425e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695909576; x=1696514376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zhhlYA35JIyrxQlMTea1XefnagrA3i1o9FxEDIuqteo=;
        b=SE+6chA3AHCW/trGM4JC54JNvq9TVx8jxZV4wlpjj9xLP8jjDRfqjldWEdKKRi5sdp
         pChHVewNwkwUok5an0MxyywEB8EvSOG0yWS5tMVDD/+sBaSAv+/TyYetgzj7MEAv1wt9
         Rf0MD+RwSkuFKKaigTp6/JCdF/6utsM282TDNRJ6YF9X01ZmqWMGW2Cf4Xt28Wx1Y7hK
         1TB2FcTScqX6pXAoUmDKb8ZjZDhUBX8tnMv4SAtRY81irXZtP5pzFp60w+5RMNr0RuSX
         Z3QKNlVMhJppIl3TxW/vgloT09UQvYCK3XLzYtSd/64FXueTiptIsKY/igAvZU9wwSXH
         rzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695909576; x=1696514376;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhhlYA35JIyrxQlMTea1XefnagrA3i1o9FxEDIuqteo=;
        b=nEmGgbGFzBGqxBK8VJTgFhvW5Xy2rXVhGJwJlU0tUnVn/pCffTXFGHRal/3FzAYfPp
         cF1eGkKkPAHvX6xfyqZB9a5kQUxEAHdADdHOVDEWz9pypE35S7qCa4SAC4/lOQ7S8Mro
         wH6d/3YzAAG2OwhgXqAeIO9ukh4kaaQ0rRxXYsC20jM26w+MzmpiwLkv3Ti6QnF0W/gi
         7xdsQAVCh3IxuuVwUYBLjkoEJfK0C529ekdzDPnKWVK0D4kPKmNaCr7boKw5t93oI95L
         cx6EOC+DydVkGMZWn2XMmPE8wjUHn3QTXFtJGQpjY7ZurTndg8KBRrfV5veZMMY3xP/v
         ixOw==
X-Gm-Message-State: AOJu0YwA0b55PJXsdSzYUhp9VkTR7od8fhF2gRqzc+s/DCj+ZrDecV3e
        dyuqqki79lAIM8uSg1FsswSuzw==
X-Google-Smtp-Source: AGHT+IFf0WMdJFrrwFCWhFWD8gg8bNzNZO+0q58x8serItqk+y/a0NXsekyGiLITmtbOMbiJWC1y4Q==
X-Received: by 2002:a7b:c7d2:0:b0:405:1dbd:f77 with SMTP id z18-20020a7bc7d2000000b004051dbd0f77mr1258665wmk.31.1695909575629;
        Thu, 28 Sep 2023 06:59:35 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id 14-20020a05600c230e00b00402f7b50517sm20323236wmo.40.2023.09.28.06.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 06:59:34 -0700 (PDT)
Message-ID: <419fda62-224b-cb20-ee78-7e0627c4ee9d@linaro.org>
Date:   Thu, 28 Sep 2023 15:59:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] thermal/drivers/mediatek/lvts_thermal: fix error check
 in lvts_debugfs_init()
Content-Language: en-US
To:     Minjie Du <duminjie@vivo.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Cc:     opensource.kernel@vivo.com
References: <20230921091057.3812-1-duminjie@vivo.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230921091057.3812-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2023 11:10, Minjie Du wrote:
> debugfs_create_dir() function returns an error value embedded in
> the pointer (PTR_ERR). Evaluate the return value using IS_ERR
> rather than checking for NULL.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

