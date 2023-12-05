Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C78380567B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345597AbjLENuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345556AbjLENue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:50:34 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B490A8;
        Tue,  5 Dec 2023 05:50:39 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54c7744a93fso4240277a12.2;
        Tue, 05 Dec 2023 05:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701784238; x=1702389038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3CnnPrYJbZn+ydGuLss8Ol0k4CEJ0cAzskXkdkO+me0=;
        b=jCbI+sOYMcqvCfkaSvqiPRMEDIE9RYid9bXyurZiLwNWzp/eH+butlRkZkX+ixtzF/
         aaBeaumkWlcBie4ltwG1Uh9wcsLo/wQwU+e+yD587pgcSzSJDwLd2JSy+YyJ/lzupI4a
         JpS2CeX0OkwQP9JX4P+fRHRA4yMpoOklXCCksVsJKErjQFwCo547HPv/GxOCSF0uuyZQ
         oGdNF+iRkmyctcllSWbnkqDwDGjICekoDAf2Hcmw4CskmXazJsk2FmD8XbM+CPckNZiB
         sedONh/OB9NtDkRWCxPRYbBJyhEw6UTfahAYF1CoyeS7UtC8Xb3oQfb9gY2fBstypPak
         /giA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701784238; x=1702389038;
        h=content-transfer-encoding:in-reply-to:from:references:cc
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3CnnPrYJbZn+ydGuLss8Ol0k4CEJ0cAzskXkdkO+me0=;
        b=sVgV+Ux6+0rZtsYJNWfAGifWpJQwGREqp9cY5DdzKDGXuAww6sl5fkvxaa4vXcixkY
         qqRjJjZHaKvw0qHUcPZRRI6PRg0rg9O0NlwWYkgBS8Kg35+hH4y8Er6Q4BPSXgN8Vkmi
         UND3Rf1eo7i0qeheadHxYWhgPBKsLmM0nOM56YtEKTmGoQz5LntZnrGjFXoMEVkMbBXO
         Jlttf9L9h7d/F9jcD+JmjoF2fTyQmEpSPHAWnW32xnKPhnjjV9hRc6OP4tiwr7DHsUzG
         KU3S7Bj/JoWu5PAFIpzULDcSoMJ75k79QPZ0vD3JlTxsqlJb/2ubI7rbw6O4uCjXVP7U
         DYmA==
X-Gm-Message-State: AOJu0YxGfyrB8tO/k4cCy/MeuCYQyELjR4v764bQ5cXWvVR7qBn6xGOh
        ko12yYsa0hqXyfVeSzfgk/UeUqE47rTTNUYi8ug=
X-Google-Smtp-Source: AGHT+IFRaJTQe39dBZzAkMfzbK51eiz+syrbne0p2I0XfRFqE6HVR4Nw6vvZ01b7wOMFjjnYC/bSOw==
X-Received: by 2002:a17:906:10ce:b0:a1c:aa9e:17e4 with SMTP id v14-20020a17090610ce00b00a1caa9e17e4mr468382ejv.49.1701784238338;
        Tue, 05 Dec 2023 05:50:38 -0800 (PST)
Received: from [172.25.98.130] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id o9-20020a17090637c900b00a1cdf29af64sm424678ejc.45.2023.12.05.05.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 05:50:37 -0800 (PST)
Message-ID: <9717981d-2f41-4664-afd4-bf9a1544bb95@gmail.com>
Date:   Tue, 5 Dec 2023 15:50:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] dt-bindings: adc: add AD7173
Content-Language: en-US
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231205134223.17335-1-mitrutzceclan@gmail.com>
From:   Ceclan Dumitru <mitrutzceclan@gmail.com>
In-Reply-To: <20231205134223.17335-1-mitrutzceclan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        MALFORMED_FREEMAIL,MISSING_HEADERS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/23 15:42, Dumitru Ceclan wrote:
> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel applications
> or higher speed multiplexed applications. The Sigma-Delta ADC is intended
> primarily for measurement of signals close to DC but also delivers
> outstanding performance with input bandwidths out to ~10kHz.
> 

Bindings V6 -> V7
 - remove redundant bipolar attribute
 - add reference-select example
