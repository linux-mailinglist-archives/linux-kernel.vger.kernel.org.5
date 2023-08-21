Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2390A782363
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 08:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjHUGFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 02:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbjHUGFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 02:05:05 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D5DC9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 23:04:43 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso4335094e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 23:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692597881; x=1693202681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UkyyzSV+XS4Fcvz6kDNT0pcf9/RGN8LZvkJfm7a+wvo=;
        b=jGcsoF+bI8svbLVXo9pkJH9xKgPGwGp/Gv90l/nTmAaByauxiNOk94PBDzjxChjj27
         ufseDZEMG8TShfU2m4bTDzkZQ5DfHU4CKVsHYz02vZ9ZiVJcfxa5VsWPqPncHIZyv3MD
         HIm8i0yuNFoiqf2E19cXBrHfoGyIfEV22JV2//jvhZ/9tLXiwgAqGvtb7tXs3CJK2sZO
         DlpJyK7OzJiGeVRUNyIdKR0rtt39ZPSJYdXmaksMYmVH9m6CqPeXNsc9lXbU1/qQUw54
         cRtehR73twgQOIl/Qy+npNfzOND1SjAmANjX/ENPMglxoQdjFTa3H7ERGsfKzCyrWrIw
         5XPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692597881; x=1693202681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UkyyzSV+XS4Fcvz6kDNT0pcf9/RGN8LZvkJfm7a+wvo=;
        b=P9DA6psTSz5kPAoZk77/X1gCzPtylMkLg6gGYDt2YxwwLz2orDc26qj2H2ZHXRQNfh
         cACGIYQ6oX2bIXhqhlQuO7hab7bXVl1spC9SiuYZ7meSXUYCj4KtikwfMblVYPzT7MS0
         KqoWpHUeiwZp5OuF3g2pVDVuE0OxXFPkKUCy06TN5O/JjbvshbceLbfs/5bN/9/Sd2IV
         3mpq7pk4PTFgBsuxY+LJHFycz3RgHnRi6FABYjTW7/hNTfHYpFphn4rSeYKK1VNjC5/s
         jQxnRXc33VpY7iaH+sDEXH3dDuDchHnIRfUgfJYjGqk0fQdGQNeRhzXl8c+6f+lzq77s
         YbTA==
X-Gm-Message-State: AOJu0YzDqHswt0jkYq8ESGltmdaXscoZPfbdnWy6Kl105mACW+UoyT+X
        Z5+8QgnLj48p9PzQCKFe+1EetA==
X-Google-Smtp-Source: AGHT+IFhVrONCO6tzW7x/x5XJmQTLFMIzKiLwAyOYV+7uFIpr7qadM8ItQXbwqFBMQyFwBMKOU/uGw==
X-Received: by 2002:a05:6512:e93:b0:4fb:7c40:9f95 with SMTP id bi19-20020a0565120e9300b004fb7c409f95mr4642255lfb.47.1692597881571;
        Sun, 20 Aug 2023 23:04:41 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id y13-20020a170906470d00b00993928e4d1bsm5955876ejq.24.2023.08.20.23.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 23:04:41 -0700 (PDT)
Message-ID: <cb37ea4a-91db-adf4-5272-36a9851d3a2f@linaro.org>
Date:   Mon, 21 Aug 2023 08:04:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 2/2] regulator: dt-bindings: Add Awinic AW37503
To:     like@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        liweilei@awinic.com, liangdong@awinic.com, wangweidong.a@awinic.com
References: <20230821035355.1269976-1-like@awinic.com>
 <20230821035355.1269976-3-like@awinic.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230821035355.1269976-3-like@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2023 05:53, like@awinic.com wrote:
> From: Alec Li <like@awinic.com>
> 
> Add aw37503 regulator device-tree binding documentation.
> 
> Signed-off-by: Alec Li <like@awinic.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

