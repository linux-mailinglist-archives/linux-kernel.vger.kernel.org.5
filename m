Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F5177F40C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 12:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349889AbjHQKGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 06:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349943AbjHQKF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:05:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9967B2D7D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 03:05:56 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe2de785e7so12117764e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 03:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692266755; x=1692871555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tU1OBnu/6KxECDpM0IzJ/SgAaQcKe+fJT4+4ZHxLk2k=;
        b=o7F1Q+VWc8vFZ8O6jibK3igZE8P/juYrKZZGxZfHPCtZBv/VveZyfn2blr+KinpS0o
         BYsM5RQa9Vekp/1Of4n3WHI72P6R+VBCXIzL5Yi3nCjm2jApUfXOmZlRYSd+ZatQl74B
         zwx2QQ/0hyQmoRvj+dizVxULpy3Jv0KL2KKN2sLlRLZAsUPN5rZSEKR/fa45rOL3eITm
         DdbedVuyXLZRQRRpKs0GVKJnwxH6dwrvNmYoBZxTDgmUCbGryeK2AEgtL2GXtv2VOHlt
         NUudH9bgGBCVBbASmSZtGH/P42s5t2qkTN2BZPq3kWaEIv2CV3PIq6FkbGqknTCjIc6G
         +xyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692266755; x=1692871555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tU1OBnu/6KxECDpM0IzJ/SgAaQcKe+fJT4+4ZHxLk2k=;
        b=d64376P0DjQf0ug+gJgiiJe581hRt7OXuGDkkEd3suvpDW+TsCVfobkAYSnxIQffqd
         yF590MOe/lfJ6vHGWI+b8oyf6PmIbsVJDFKzPsWzMrAqio6Vaa/dKrAd1TunusXTcwFz
         pkS2ZkHGh9r0yU09J8kHAIhY2xSG8XyXaCna0LDhgzPkrKHpzSTJ1A6LmaIyy8TunZZr
         v/LVosEOya5u0aEETnEMMTTJ+CEfBzf6x5uuA3zn022DzjPewfK7ub1cwpqHDQvFgOXf
         k3LCYPj7/+MM0f4Bbmynp1NBdy7ion+Go3h81N3VzhfhdGK2KTnwH2zZrLPdy1lBbVbC
         zcNA==
X-Gm-Message-State: AOJu0YyDMCfiaAca6N8eomI/HuHBB3la83UA9BQA70LVLKGzECKa0LoG
        bagUU5uykR9onLFJ8S1xyvIctQ==
X-Google-Smtp-Source: AGHT+IFCG5Al/QsWgxP4N4ZeswwQ4NoxpW9761uM5QnL5lXermAgUtYjDUWYz2a42K4cgDwfPj70ow==
X-Received: by 2002:a19:915b:0:b0:4f8:8be4:8a82 with SMTP id y27-20020a19915b000000b004f88be48a82mr3310881lfj.22.1692266754892;
        Thu, 17 Aug 2023 03:05:54 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id h24-20020a197018000000b004ff9ab6463fsm276653lfc.87.2023.08.17.03.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 03:05:54 -0700 (PDT)
Message-ID: <c485b64e-3c83-4616-b8d8-76c2c7d56b0e@linaro.org>
Date:   Thu, 17 Aug 2023 13:05:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/7] phy: Add HDMI configuration options
To:     Sandor Yu <Sandor.yu@nxp.com>, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, vkoul@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, oliver.brown@nxp.com,
        alexander.stein@ew.tq-group.com, sam@ravnborg.org
References: <20230808083243.3113192-1-Sandor.yu@nxp.com>
 <20230808083243.3113192-3-Sandor.yu@nxp.com>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230808083243.3113192-3-Sandor.yu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 11:32, Sandor Yu wrote:
> Allow HDMI PHYs to be configured through the generic
> functions through a custom structure added to the generic union.
> 
> The parameters added here are based on HDMI PHY
> implementation practices.  The current set of parameters
> should cover the potential users.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
>   include/linux/phy/phy-hdmi.h | 24 ++++++++++++++++++++++++
>   include/linux/phy/phy.h      |  7 ++++++-
>   2 files changed, 30 insertions(+), 1 deletion(-)
>   create mode 100644 include/linux/phy/phy-hdmi.h

I think this looks good now, thank you!

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

