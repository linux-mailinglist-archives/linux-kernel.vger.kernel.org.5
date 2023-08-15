Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FEC77D4A6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbjHOUv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239996AbjHOUvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:51:09 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B393B2125
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:50:46 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso57197985e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692132645; x=1692737445;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AZ6ZeHyaZtvJmTEJX3TsFxQd2M+kqHWyNM2xafdcG2E=;
        b=tjH6DRn4h/q3i8JJcGJrHtTpzNA+Qc9hMf1o7SqEgdsr+/x1CPaazWNfutgheJiiBL
         xS/tM15AU8t8O+I/A0X+bDN+PNNaEOgsG9Cn7dIyo2kw6DtM+uj4uYcMFfUbIHv5wuD2
         OGsAe3ns711+LgNMvcmHqjMaGA1UnLbfGujMYdlxAqj+eHYCz1H2HMI0O4GUkFq+4tsg
         z0/xbobcqshzlSnMxy4TFJykXjgJa0rlvnm361I0notOwir5Vv8wUoy+THRcfy81r3oB
         QpYJ09YLPaQ3XjBz5DEB02SBcncL1xF4I8vXyJx5Y6J9kaTbvXKrY1apcdPvG4CplmBz
         TV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692132645; x=1692737445;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZ6ZeHyaZtvJmTEJX3TsFxQd2M+kqHWyNM2xafdcG2E=;
        b=dUXLbWvWfLKH8iX5taIDi+uEglVFUxzEZcquEKxLa+R+MtKLrdvb6Npy3BXKOgebyF
         6NZ36cDxpNZOtNesXYmb9iTRswsLjspXoDZpLkScxe1OQE7RSRtmiAOqUqKvdHJ3h1+h
         ZYAeLOaQC7DF52Oi712JY1JjXDbhsWTO/cBE0DjSqGQwmt6amjo6w5dBQLBUXSoqUV48
         g21DjCxcQx1S1P+5lHV8zejt/4GNM2gLRS9ue1Z3uY9quqcjjR60sHxaQrYG8UxlFZlO
         e9XM82jGbcUkS5/MMNKOa48QhpsS3NZJ+M8kVKRJTPsmspQ6nGhIrP7L88/6Qyao/Bbb
         P/8g==
X-Gm-Message-State: AOJu0YwiqPbOYwhz+oUyOoXg7WSs0xGNlfjfUIkLsPAndz6/PtOVwxm1
        HKB/6WwRO5qgaShwIGFk/8RaaA==
X-Google-Smtp-Source: AGHT+IF1Z6VUmpgEc/cEZnlJgb53L6uE812OSlM+M+7y9DJ/VdKg/5Ci/RgJ46RgUmyIyb24zoLUdg==
X-Received: by 2002:a05:600c:22ce:b0:3fc:d5:dc14 with SMTP id 14-20020a05600c22ce00b003fc00d5dc14mr10731314wmg.5.1692132645361;
        Tue, 15 Aug 2023 13:50:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id v22-20020a1cf716000000b003fe23b10fdfsm22123107wmh.36.2023.08.15.13.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 13:50:44 -0700 (PDT)
Message-ID: <0039da2c-d578-5b30-1982-7f4e4afafe32@linaro.org>
Date:   Tue, 15 Aug 2023 22:50:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4] dt-bindings: net: ftgmac100: convert to yaml version
 from txt
Content-Language: en-US
To:     Ivan Mikhaylov <fr0st61te@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Po-Yu Chuang <ratbert@faraday-tech.com>,
        Conor Dooley <conor@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230805135318.6102-1-fr0st61te@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230805135318.6102-1-fr0st61te@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2023 15:53, Ivan Mikhaylov wrote:
> Conversion from ftgmac100.txt to yaml format version.
> 
> Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> ---
>  .../bindings/net/faraday,ftgmac100.yaml       | 102 ++++++++++++++++++


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

