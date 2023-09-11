Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124E379BBF3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353659AbjIKVsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240374AbjIKOms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:42:48 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244A012A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:42:44 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9ad749473baso49806866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694443362; x=1695048162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6D80ZZPlzZTYiu/9bQG8irFdtGvZCgvK+mghRHHLOSI=;
        b=rKdRUU+yqZbHkXY7SazbHWkcUqJr0uRUJeAH9JyXUnujnMo6e10jFtNI+Q33qnKkxf
         CS5pgu02fPxyKA0ykY/KN+dw85vIWyIp3Tna14seZNcUfStYwsFapgGr9bq9uATvyUR6
         6FLv9khgUothNH10EpZc8oX8BzXZdWsDW9ezu8fO6VpUrmlxZYZL9mjfiYXPHCk5nLQs
         yGzlThC70CfL4At0yuTK5/r/sRed4xxpQHC2VQFyAJBu4rpuFtsiDOell7VcXPbrzhbt
         wyQN85513R9BOzHfLfWODF8i6kS6rn1CYVInb+EqUHvO47BYNruaXef6nbJPDjP9jBkc
         DzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694443362; x=1695048162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6D80ZZPlzZTYiu/9bQG8irFdtGvZCgvK+mghRHHLOSI=;
        b=UVs/KGI3sb5Sy6euw0s9mK0MlXZnLp6HXOjDY/dvy1RpADfg7Pv62kSNhUj4y8lt+M
         whAQSqqpVnyMlzzkrk961SOvwhcrps7Zbjz4ltJOLUddwemDyna/Ye3dIZ4nOrAsQdQE
         6xQJlz9B5dpwBvdgAXYSmUmkq51ElRVremjSOjSK2z6HDN2TIRGMY3P20UhzrGxrKjW6
         abqt49OK8Hnn/36IBqcnV0LQc0B5aYl6pTVWhXyt0txxy2au9mRVs+I1Q5voGXKdhk7W
         amkH71sLJpF07uK+/uMYQEnqQJu3Fn4hxm6wOax9HZWAwQ0zL5Djvo58cyzzuaAUeJOw
         eRBw==
X-Gm-Message-State: AOJu0YxVcl67ljXjzoVAm+wjJ2a7pC5tnNc6nl0/QBwBuWCrfWrB/+7a
        QEPY7xpx3uoIrmawjmSyLFRj6Q==
X-Google-Smtp-Source: AGHT+IGZ6BAm+BNseM9dLIErk0Fd9vodlBsob22D6rHK/pzDdm5HODd0tU/6G4M7A+HhDA5Ec4sUJQ==
X-Received: by 2002:a17:907:762d:b0:9a1:ec3d:9004 with SMTP id jy13-20020a170907762d00b009a1ec3d9004mr9036507ejc.9.1694443362588;
        Mon, 11 Sep 2023 07:42:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id k12-20020a17090646cc00b0098669cc16b2sm5429610ejs.83.2023.09.11.07.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 07:42:42 -0700 (PDT)
Message-ID: <f4f0ed21-1e3b-a7c5-79f8-3469c4cfc471@linaro.org>
Date:   Mon, 11 Sep 2023 16:42:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] fixes the pin settings of two LEDs on board nanopi neo
 plus2
To:     longqi <longqi90@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Allwinner sunXi SoC support" 
        <linux-sunxi@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>
References: <20230911140959.2046340-1-longqi90@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230911140959.2046340-1-longqi90@gmail.com>
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

On 11/09/2023 16:09, longqi wrote:
> Signed-off-by: longqi <longqi90@gmail.com>

Thank you for your patch. There is something to discuss/improve.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

Your commit msg is missing. Please describe the bug or the problem thus
it will be obvious why this change is needed.


Best regards,
Krzysztof

