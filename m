Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8071793643
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbjIFH2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbjIFH2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:28:42 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAF410D2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:28:30 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bc63e0d8cdso51173591fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 00:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693985308; x=1694590108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lpOnEcgIa5nuEQvLfKq6Gh+te3zxL4BtHONORSne8Jo=;
        b=cwugJq7qeZsXmTRfYJHEm5J7MSfE0qti8Mu2eBHHZxGqQmqr/I0ypFV4Tj6VTC6DGC
         5NECk9qM3fs+kzldVhiR6xO2E59cWMaT1nd42BsWZcj5VscnMYj7yTPnCzg1v0uNiq1M
         JWOxWil7dGb2cjAWCUkVo1J8LKGDCv3I5tOVNPJCiEsQEivlVh6mdbDvkzCLYsuE2kxZ
         2qQ2e8TkFahI3eeVC09MX/c+ZV+li8c3YA4vG3o6MycuaINxEXJfFBtijH7F7qusgjqt
         Us6fYVpqfgLN2nRuVYm0kGkmSOYHZU7/l/abWokzsW5WfXGS7YdKAKlI/H8Lck2/cpnw
         5Y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693985308; x=1694590108;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lpOnEcgIa5nuEQvLfKq6Gh+te3zxL4BtHONORSne8Jo=;
        b=k8+Y/1e+VnUixyHX/XyEwiJ9p5scDelqQ/cP8LZByvpIGJcjI4wJ77uxJkaMM3g8Ut
         82wgrBntscq2yxd3EPTxq7zxvpsGOLFAI72LuwhR5sxHngF5A1MPFY9UNA8dZnujDaj1
         WB+1nw0mwLKXTgDRw1/C08BHw3nXxO3/1YQHWrFXiUy3jNkJ6Pvp7EOqWmOlA1mPpsML
         /YC79YPRcOu5/vyYWqvdriO55le/AndUA021Th+RxFjZx5mThkSLHFUZvCvkZk1WQ5oM
         GWtHF0gjk37wRcc1Zw36y1vemah07gSS7i5M1lILVXQPIlsArS2YhKaEKz0Z3SJI1/F6
         6PvA==
X-Gm-Message-State: AOJu0Yw+lDXexA1cGaUqAfg9quNCIZzlFhdhU4xitN0gjDQIQRQcZ9Dx
        vyEiGt5EfddqKaMAcryYbRNZGQ==
X-Google-Smtp-Source: AGHT+IFMvObyrLS11RBnolW7dn5O1idhHoFRWaBc9EWb0Q0QKPn3aKZkpkWUOoAu8BosGj3LsHIbZQ==
X-Received: by 2002:ac2:5f5a:0:b0:500:920d:2add with SMTP id 26-20020ac25f5a000000b00500920d2addmr1452660lfz.34.1693985308634;
        Wed, 06 Sep 2023 00:28:28 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id s8-20020aa7d788000000b00527e7087d5dsm7919511edq.15.2023.09.06.00.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 00:28:28 -0700 (PDT)
Message-ID: <8df2931e-a100-45e9-2987-d2d4a989f6b5@linaro.org>
Date:   Wed, 6 Sep 2023 09:28:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3] dt-bindings: rtc: pcf8523: Convert to YAML
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>, alexandre.belloni@bootlin.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, sam@ravnborg.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier.carrasco@wolfvision.net, Fabio Estevam <festevam@denx.de>
References: <20230905220826.79901-1-festevam@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230905220826.79901-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 00:08, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Convert the PCF8523 bindings from text format to YAML.
> 
> The YAML format is preferred as it allows validation.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v2:
> - Fix the default quartz-load-femtofarads value. (Javier)
> 

For the future, please keep also previous changelogs. Otherwise I would
assume that my feedback from v1 was not implemented.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

