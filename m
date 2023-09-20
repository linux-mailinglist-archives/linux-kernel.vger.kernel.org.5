Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050CA7A7310
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjITGrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjITGra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:47:30 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBDF83
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:47:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9a21b6d105cso817225166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695192443; x=1695797243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ItM+TknBaVUePyzd+K9zDA8JpLcEfRL0RuIuQPWPMDo=;
        b=tAVtGjWuSa9lNQKLbODyu9wLIICBl4fncvJ08jFuJRQ1Bg9O105Pl0Ag1rpEiq/zw4
         RhSKrNYcg7pSS/56sDq40/y+jvNG1F0I1BAUftydBgz4koFcOl1A7BTaSZ9cBvRoM0DD
         1/M7gySxFQuzgqyhdnM6nXxAjqbBAnMVT0O2gE6kupdE+4dE+BtAF0zEfezT2/yQeGg9
         q6eLO334cDZe4jOsYz3WQ8+tu1SyofRLmtBnzkN3qIyuxlHkOfkjlS8Ya91fEPFJzb0v
         oQuXU7NluDICj+cOvIiVCCPhI1uu5A8J7ow7eQmMD5B4HkSR8PyxMK4YyuspvI6kiEdU
         pHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695192443; x=1695797243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ItM+TknBaVUePyzd+K9zDA8JpLcEfRL0RuIuQPWPMDo=;
        b=Uk+KRvNgnP9xfhg1rYWnjmQT2k5CDiNYO7MQAbjDI/InUMNOc/VQduYYSZE/a0mwL8
         b5lv36WTUt0YlHaq8gyhG0YJWhR9L64XBEFkdz10ZuVM+ZbcNdWAIhdeN961zd38kZvG
         T9zHwnNiZvqLQfe0/J+DAD46n/7bGVwHGgZu1eAf7JGFQByG3gaR+ctIa8vbtWL3Vmni
         FFtk4lX7kf779rmGxmZqCICk8r/0C5Qg95laUKG4JzwbdotqD48GcU9hKHiq+C1FLYwH
         PaToYaaWmD9yChWSdBWSDVy58/pElsmWoKWrwsJngOZ3vthJ7EALwm92GQiVDgxbQHzG
         tdfA==
X-Gm-Message-State: AOJu0YzaEmmnLSdubpS/Mq6HKmV4nUdazgvPyY/uTJuX9TiNIMPuYw+Z
        gGIAlx2kHPcyTjjW96alhzk6GQ==
X-Google-Smtp-Source: AGHT+IH/O0PptEtTtAOR5cdeRSNUd/ta1ny/TMJspKe9DtyuAwN6r1PUUDbhIwgJ3hBlmrb4o+6xpA==
X-Received: by 2002:a17:906:220f:b0:9a9:f09d:7c10 with SMTP id s15-20020a170906220f00b009a9f09d7c10mr1220085ejs.11.1695192443199;
        Tue, 19 Sep 2023 23:47:23 -0700 (PDT)
Received: from [172.20.24.238] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id oq8-20020a170906cc8800b0099bc08862b6sm9067327ejb.171.2023.09.19.23.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 23:47:22 -0700 (PDT)
Message-ID: <9b0a9782-05fc-fad6-5abb-ba9c940e6d10@linaro.org>
Date:   Wed, 20 Sep 2023 08:47:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/2] dt-bindings: hwmon: add INA233 binding documents
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230920054739.1561080-1-Delphine_CC_Chiu@wiwynn.com>
 <20230920054739.1561080-2-Delphine_CC_Chiu@wiwynn.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230920054739.1561080-2-Delphine_CC_Chiu@wiwynn.com>
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

On 20/09/2023 07:47, Delphine CC Chiu wrote:
> Add INA233 binding documents for Yosemite V4 config.
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../devicetree/bindings/hwmon/ina233.txt      | 27 +++++++++++++++++++

No bindings in the TXT format.

Anyway, this looks like could be merged with existing ina bindings.

Best regards,
Krzysztof

