Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4127A1D09
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbjIOLCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjIOLCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:02:06 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0EF2134
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:00:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31ff1f3cde5so505317f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694775643; x=1695380443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tn60yuwsayKteemX+yt8gQbT1B0GE4xqlU7FtFJOVyI=;
        b=pHjVyAdlE/UnfKmeakTcOQK5uisN2JPLdKyTTYA7+LEQUOKHl/VahJNxLVrjqbJ80G
         SlerwynD9v53IvMggO91FcvzsD4LoYQe/e9kOeBfGzjB8Jct7BBiZojv0xyKUuwhw8Ks
         JKTN7mFMYa3NcQoS3O7LsWp7/XLCeb8U+tq+ubtZZP+46PrYyE6doZlxRkJ6eokBHT4c
         pZpf/Glar2MdxndByT8aG0p5HV6dNvDBBosYom+7GlsScHOzW5+sI41STWCinKSo/lXd
         2HNUbDO334rf6B3+006cYh1rCbxGn4RIcCOM+ic4aXY6JDt7TpLqz7ALg+e7EMjsW5TM
         HkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694775643; x=1695380443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tn60yuwsayKteemX+yt8gQbT1B0GE4xqlU7FtFJOVyI=;
        b=WeTCbBIHUBUFFeVROZyU03q/99wRhV62b17VR25t6gDXAJGWIC47fjp30u5CkL4ev+
         g1DBeCRU5LdmZdXAgcQofhhEjJmQ/7TEUg6jLVbLH6rzukL3/r3kKcHfvWVohKdQpvhD
         3WQ8Av3UMtnw1Q1pulj2od8b+Cn1Yn0hvAMQkAP1KqBS8rcaKogpt9Ja8LPiJNmB4Z9E
         SGb0Vk1uNCA+zY8ugSyvvD/ZZdedRImmk/JerPTQUyLh7LHGoPTaKdd1LfWLtLTAukY+
         imZtG9oovXbiz/AxdHsOwQRAlmHUGRkawi2jHGE6nDc5zaAr2JntpRm4NuUaGcqp3obC
         IxwA==
X-Gm-Message-State: AOJu0Yyr0mGVgqQa9yITG1DM5srEbCJexLTnCmbYxzfjVzt0YX1qLHN8
        rN6zWtVz1M8CrJa8b6OeGsd7Gw==
X-Google-Smtp-Source: AGHT+IF2SgxJ6JGOtiwKnxlhWSHGpIPuG1WwYWykJZPi/uWFBQSqGjYzCnn6sFTt4SrDQ0mUPVvqCw==
X-Received: by 2002:a5d:4dc4:0:b0:31f:a256:4bbb with SMTP id f4-20020a5d4dc4000000b0031fa2564bbbmr1093708wru.71.1694775642865;
        Fri, 15 Sep 2023 04:00:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id i11-20020a0560001acb00b0031fa870d4b3sm3358133wry.60.2023.09.15.04.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 04:00:42 -0700 (PDT)
Message-ID: <82261cdd-3db9-c79f-9286-d49a81338b22@linaro.org>
Date:   Fri, 15 Sep 2023 13:00:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 27/42] dt-bindings: ata: Add Cirrus EP93xx
Content-Language: en-US
To:     nikita.shubin@maquefel.me, Damien Le Moal <dlemoal@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
 <20230915-ep93xx-v4-27-a1d779dcec10@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915-ep93xx-v4-27-a1d779dcec10@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 10:11, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Add YAML bindings for ep93xx SoC PATA.
> 
> Acked-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

