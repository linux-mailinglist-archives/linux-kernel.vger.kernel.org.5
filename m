Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95297A1D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjIOLSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjIOLSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:18:35 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424381B8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:18:25 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31ff2ce9d4cso485992f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694776703; x=1695381503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ziVc+rtn+8qCfab0pW6dHdwsWNPjZ4WKT9IYLhgHUbs=;
        b=Qr4PENK69EPGv/oguyeWKmN26fML2ukFJwolGFuTw8S0zD46EU+ANjPv1ZbXKWb43q
         B7PUIgeSxHj+fHNkvC/9yyaoGv6JyCPZ1mCKJ0JYCcCS7DW6ekqKA2BFkrPIt6QAFd4t
         2FY4oB/6bOJkKquva2Qr/wscao6g9yoJ27PgSMNoVd35lQcvBLTCRZMAn0qN6ZfMtr6C
         r5n8U14mE5gvlY5wzXLlAwpEpPFMeB87c7tckg5atxFdwHUQNV5iZ/4ZCxYvQb203+91
         hkDAha0kp8ZxAjbBKkKUvZPBBkczP2CEQHts5IhGig7gvkg/HiUvcNs8klNTH/xZrXXT
         5awA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694776703; x=1695381503;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ziVc+rtn+8qCfab0pW6dHdwsWNPjZ4WKT9IYLhgHUbs=;
        b=SBjB36ac4qhSrSYKfjd8fu3ZmJbihluyf9/aIdsokX8pR/C99AXVGwcej67nLKPZqX
         tye56STdLWOA49CRh9azFEGtvyMqCqwc0EhPFqoI5fonjPKGC7FbsZ2S07gzwwuo0d3X
         2PL6twOkJp1hV4Thpp56MyZdejLSwYlzodQCjci0Qea/2RkBRc1xfCip6VOhzkV12c0H
         TruuwC6RjuivOgm/4CWwijOOGyX+z066OaKwPK+qYyp8WUhBVHzlprJgUH1RwZhIRq7Q
         HZxbEo3ZyKmDZQDJR4pEWWkFo5S24zpvwYPOYj0JdDjIk9FVGeEz/aVMpFtp5gyu6H9N
         Yycg==
X-Gm-Message-State: AOJu0YweSYNPp7tOYgVPbu4pAekL1O4fBrvV+eRhXhqHJzJK7HFnXpW3
        XVDdyccr6uKXPyf2hp6LACSL5A==
X-Google-Smtp-Source: AGHT+IEKQn+nZjBWSB3TGQyOP/D1nrIbfCnlJO1lZ0KeXdDZvnXyjSj7LFWoSMjG2My6gei9PoYuCQ==
X-Received: by 2002:adf:f842:0:b0:31f:e19e:a2c with SMTP id d2-20020adff842000000b0031fe19e0a2cmr1180771wrq.32.1694776703692;
        Fri, 15 Sep 2023 04:18:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id e17-20020adffc51000000b0031435731dfasm4159793wrs.35.2023.09.15.04.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 04:18:23 -0700 (PDT)
Message-ID: <880d17f8-ee9b-fc7a-114f-542962022b2a@linaro.org>
Date:   Fri, 15 Sep 2023 13:18:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 31/42] dt-bindings: wdt: Add ts72xx
Content-Language: en-US
To:     nikita.shubin@maquefel.me,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
 <20230915-ep93xx-v4-31-a1d779dcec10@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915-ep93xx-v4-31-a1d779dcec10@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 10:11, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Add DT binding for Technologic Systems TS-72xx watchdog.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

