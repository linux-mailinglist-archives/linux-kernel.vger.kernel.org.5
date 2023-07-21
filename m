Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2506275C692
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjGUMIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjGUMIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:08:35 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BA130C3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 05:08:31 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51e48e1f6d1so2490121a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 05:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689941310; x=1690546110;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IcpGROhJEwtR61U14d6fyUJcgMnzf8ivmeJyLaTOSlI=;
        b=JBiuNToQ61zUNMKd02YNI78L3y5Z/AnUE7wZj7fvtaK3+fT3o/6Xb2IbL2vYZUyYbK
         SknIlxE6JsQ790MtAxnQv/vGci7pFPM9zDwoO+axtS5vDjLE14imYfADx49gn+u6VbAI
         Cw7RNMW8ULVaHwyx5w23+p++3TEvrWIvB3XtxOhzvds+VYoNvXyHng0LSM/3BpAgWLyh
         OZyb2HvynPZu9bzefqfk89VJp/vkwncx6cy29ESckeL1B0a9uFr6DRP9AdUVpq3fbQ3G
         2VndJ9Mjim3Ce9QvA9L9mvAQ47DZGQy1DIzqQFvtbtYr2LgNfWkpDrWmXr8RR2zWoexe
         LGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689941310; x=1690546110;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IcpGROhJEwtR61U14d6fyUJcgMnzf8ivmeJyLaTOSlI=;
        b=fWM/X5BAKlex1bgFUk1t3wrl2rpEle8uoja5lP6w8VXgueaw10XYH/SpNORqGtKv8s
         fPSWDIUW5VVZtQ7GlYUqDj+fXdnxu047btdhIqBociEn3kX1rOXiiW5O6INq3SJmIG/z
         +OIaDG6+VF8WJ+M2q73uiL7yPNwEKx1IqNX0v/3bewMXyt4w/8rBOIYMiB6Afn+V9rzL
         9GRw/khSAsCw8X6j7OmNRxVMg1TcxNQklZ4P+WNw8k1A02ymQX2B5Q08SmrXEdHc8d2p
         m8SIZFtnf4YgXej/Pf/4SJZuHL1H70rYuyrPmcLHutc1XcTI7WnYuxKhebvqG8eXE1T9
         VI8g==
X-Gm-Message-State: ABy/qLYa8CeDWmZQRfIWJjPvTdFFcu3YKRWrW0kf2Wiiah0KrT9DzWdz
        N9LFkgeESGpBqhZUpCKoS5sHWg==
X-Google-Smtp-Source: APBJJlF//sQzLQkI0+A0IydDa7QrWBHF7UziQd+Pe+WaYGcBo07fAYo8QdR6MHGfWF7KbWrSu4fU7A==
X-Received: by 2002:a17:906:31d8:b0:994:2fa9:7446 with SMTP id f24-20020a17090631d800b009942fa97446mr1332912ejf.46.1689941310423;
        Fri, 21 Jul 2023 05:08:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id bn5-20020a170906c0c500b0098f33157e7dsm2089479ejb.82.2023.07.21.05.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 05:08:29 -0700 (PDT)
Message-ID: <b0318b33-a314-d744-6aad-7e22715de032@linaro.org>
Date:   Fri, 21 Jul 2023 14:08:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 2/3] dt-bindings: clock: imx8-clock: Add audio clock
 mux related clock
Content-Language: en-US
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
        peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        shengjiu.wang@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1689934137-21430-1-git-send-email-shengjiu.wang@nxp.com>
 <1689934137-21430-3-git-send-email-shengjiu.wang@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1689934137-21430-3-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2023 12:08, Shengjiu Wang wrote:
> Audio Clock Mux is the IP for i.MX8QXP, i.MX8QM, and
> i.MX8XL platform, Add the clockid for them.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

No, headers are not separate patches. Squash it.

Best regards,
Krzysztof

