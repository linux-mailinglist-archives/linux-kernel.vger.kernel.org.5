Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629D37A9FA8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjIUU0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjIUUZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:25:47 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29618683F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:53:56 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9adb9fa7200so273071666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695318822; x=1695923622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/uxubhSOYRKOBgFVb2nJokjnsajJqcWLd3vDjsGmIJY=;
        b=AggLcpe60qwXmgi7v6jokyUg9KfJD+xn7Z75ysYEJbr1iPajAoTNElwbUhrDsUsNe7
         vCSoW3Oisv3MgeVpZP/FmST5c72KnwoTRxW0NZJtFA70OOFYBcjj1byJKyPZiHJH4f3w
         f7x0xYwE4KAW62IiIYuyfOA1DMU3iChLKGExYbj9WynWZJLFtyXB6Bxt8yDdVs4+TNSC
         zO8VEd55YsK6hPu/hZnUI/d+JwOdGbrITav4ZzpZxVnFoKgmWZ2ANJCRDpcpnkQ9WPbP
         CilSO5cNwD6obdSEThM5jppkJkOipgh9A9kDFt3EmllfWdSwZMwufQq+bwwmkMpygg/V
         u4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318822; x=1695923622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/uxubhSOYRKOBgFVb2nJokjnsajJqcWLd3vDjsGmIJY=;
        b=QUygNX08DB1Nqo67QpCOmFO2q5GWb21bA7DePbgiYDqyFZhBBS3lM9thh7B8EYBiU7
         QpR6C9vpe8vSuzoHqhhGXEZJfuPAGLf19l2bgw0/Jn6zj1xCV6ZG1+Djjeau4N1ON6S8
         a/cPXk70+XqcSVH7YvfRQm/BqGLVf+abiTrUcILIC3jWoY4QTBorrglqYOv3I5y0B433
         m5bnvK3BwzAHN8eKDjeI9HpJU5Y8MJilYVq3vPwWxIBWpRCtstCBv9rDuRtIj0i+2yub
         Hu18jQKS2urgKHaPtTzDumPzibRe+Xj2B0nD8HIZBIko5dp3Y1K0P5Wx1PsBb7NfCEYq
         I6TA==
X-Gm-Message-State: AOJu0YyOqD953jBUuPYMaaaSu0EJL0K57G8F73pV7bhxS700ge6TJEk4
        RrWqqG5T+rLCBN+gkH+cUjvKu5zrzwB0xj7bvyVHIA==
X-Google-Smtp-Source: AGHT+IGPVfoflUP3NlCWwDzwylQtmI+2m3tAC7GFYclWCJd5Ehn+hZ+GXl/jM794pw9McnRpGwN/BQ==
X-Received: by 2002:a17:906:31da:b0:9ad:f60c:7287 with SMTP id f26-20020a17090631da00b009adf60c7287mr7118902ejf.28.1695290788801;
        Thu, 21 Sep 2023 03:06:28 -0700 (PDT)
Received: from [172.20.24.238] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id cb25-20020a170906a45900b009ad778a68c5sm812501ejb.60.2023.09.21.03.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 03:06:28 -0700 (PDT)
Message-ID: <4ac45fc9-1583-a71f-7c75-76ae6c882e67@linaro.org>
Date:   Thu, 21 Sep 2023 12:06:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/4] dt-bindings: thermal: mediatek: add mt7988 lvts
 compatible
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230920175001.47563-1-linux@fw-web.de>
 <20230920175001.47563-2-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230920175001.47563-2-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2023 19:49, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add compatible string for mt7988 lvts application processor.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

