Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765ED7819B2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 15:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjHSN3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 09:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjHSN3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 09:29:39 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C348C65A8
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 06:28:16 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so2264159a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 06:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692451695; x=1693056495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g2/eTmeGLIHBF7FLb+vCfZlq5lr8O3DMbn1/hvnwEr0=;
        b=IPP4vVumV3eDszkG6RRimK7qs2DHKWHs0SYQ/Txw9bpUM69YewaXB+K+ON0WZhlKHi
         /QaRSWaQPo/Q9BFzBsxvX1O4hzyKIAkvkQVMUn9nJcb0gZ3ZNlQDMi+xvl6y/xMvJye1
         s4Qm1dnccDe35absNagrltggKFvTDuoBLzHcNz04CMDNGPTxJZmq3utzsFBabOzEO2Qy
         q8A2QYMzmfPmsDwWZAEBMe023eV4jlOyinzFkYH7+0cCaCBjhOPe0vNnKYFbE9/y3CZ3
         eKX19dgYEQSJ/CNa0M/WJgwUN1etceK7lJme8LgKn/jmMVU012xyyCcgZNlYM1yT7lyV
         LARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692451695; x=1693056495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2/eTmeGLIHBF7FLb+vCfZlq5lr8O3DMbn1/hvnwEr0=;
        b=aGzlniMCWMk+dxnY9gVyvKNaNVVob9EXZFpfwQ4A5wq+xrUmgSjj1qjhm11bTg571B
         Dgi4uPYHy/jxXb9XQyR5uQi6uUjkNri8/aRjAnLT6KTHYXG+uKIhG6T45rj928kA/GRe
         0HMEWyBnoPf1SrAcUWWQV1zTe7PJKw2ctCH7WuGKeRa6kPkMox79Nc742KCLGuczmqG4
         S2vJTnqucF3JnpNYDTr3exgtmQ7fIER9yFClXNzekPE90UuC5GVplL0dMseHFSJ8JUa2
         OdE70XTrV8VcXoc8voFWCnaUNj07lmha2TWAwk2vK6iJFCdpYn5SFVgDC5in17lrOazn
         V7sQ==
X-Gm-Message-State: AOJu0YwklM5ajuBWZ1Gb/bi1mJf6dQOQXPQSbdJLT8vZdqHzeIEj0biE
        ybfEUn0YMMBH8dIS+uRY9Tw0Sg==
X-Google-Smtp-Source: AGHT+IEY+//SQa8zNcZTsTQw8ncQ3H3DK6JEfU+cLSw3MgnGMw7CEFSFaX3ge9tNUR78sO6+c880Uw==
X-Received: by 2002:a17:906:3287:b0:991:fef4:bb9 with SMTP id 7-20020a170906328700b00991fef40bb9mr1393127ejw.58.1692451695295;
        Sat, 19 Aug 2023 06:28:15 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id sd20-20020a170906ce3400b0096f6a131b9fsm2710140ejb.23.2023.08.19.06.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 06:28:14 -0700 (PDT)
Message-ID: <18f41262-97fc-9346-7d77-32d914cf3b24@linaro.org>
Date:   Sat, 19 Aug 2023 15:28:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v8 3/7] dt-bindings: display: bridge: Add Cadence MHDP850
Content-Language: en-US
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
 <20230808083243.3113192-4-Sandor.yu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230808083243.3113192-4-Sandor.yu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 10:32, Sandor Yu wrote:
> Add bindings for Cadence MHDP8501 DisplayPort/HDMI bridge.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
>  .../display/bridge/cdns,mhdp8501.yaml         | 104 ++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

