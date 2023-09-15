Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDDE7A1D14
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbjIOLFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjIOLFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:05:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0121D1AD
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:05:03 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-403004a96eeso21555545e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694775902; x=1695380702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=58kT+ixqEpo1e9pgQf4xzSvzylFzMVXiyd/UoT8AMlM=;
        b=fUC/nP9xEB7xmdCNOx4F3tAcCqi3/b0tqF3Pnvtgi+RR+wtlUWLS0NGgJkl0lB/Ags
         SgOB6PVyKmbyjw1D2Dj1OrZmmZ81Av/h63qhYACtbSiIf+XxD6SjAKh03a37HzrASjib
         zCIbIWub1y1/mBWFH6JZjz31GmCUSgFfAQ6XSp2kEHl0nHoxpNH0drgRIqWQFyjW3q4u
         eEgjD0VJ5MGmtagrMpF2geU97Sygk5YT7Vvi8dmEc/eE8QEWRkA9YLS6tfw+TVUyIgOO
         dnHB5cvyfCWZHMIpMuLke7DoIdTDEg3HyeoNV8v1xnW5vA+0r85fTXUnafaofCH4J0wl
         aB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694775902; x=1695380702;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58kT+ixqEpo1e9pgQf4xzSvzylFzMVXiyd/UoT8AMlM=;
        b=c4W2H+aOtqMBaE4dPQQJa8SRwXdTJuE9ylryzYVeV8A8c4ElrhPyomC13Q86n9AUch
         XpGWfVGr6OJe2zDPAhruIN+uh4bBwTm5wzC0suP5+C9u9apRNHx263Vi0ObvybZqWK7+
         +YU82G41qI5Eh0liNB2e5cCK94/dLUMLhkGVqveNVbS5EN1Eoak9Df2V7cnfoyF7/UBO
         +y80eavKEVP6FUXSUNYgrl7eHrQU/FafeV0iwbxlATyWO3UNWHE0mBSA+BKtrpn5Su9O
         PHIZ2WwJGsG9zFbz5dFjb0DhHX75BvhejxAf6W/3ueoetJFqFhlL0EykHp0eHOAe60x9
         Y6+g==
X-Gm-Message-State: AOJu0Yy8IuFgDEkTdKDj/kMh8OkHEXTsuT2AjA6lwCFYgaYlkzngUt1l
        v34owU9z1+ieJsxjyrow/2ukng==
X-Google-Smtp-Source: AGHT+IHitpjDRzLZ4InU5Aq/I8d+ugu268RQYNa5z4cxiPs73BCvUvVbaLBYgL+/7Ed66/a1BbHLvQ==
X-Received: by 2002:a1c:790d:0:b0:3f8:fac0:ad40 with SMTP id l13-20020a1c790d000000b003f8fac0ad40mr1412848wme.29.1694775902344;
        Fri, 15 Sep 2023 04:05:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c025200b003fe1a092925sm4342093wmj.19.2023.09.15.04.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 04:05:01 -0700 (PDT)
Message-ID: <56e1efa4-7bd3-5775-b541-5c35e63da026@linaro.org>
Date:   Fri, 15 Sep 2023 13:05:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 29/42] dt-bindings: input: Add Cirrus EP93xx keypad
Content-Language: en-US
To:     nikita.shubin@maquefel.me,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
 <20230915-ep93xx-v4-29-a1d779dcec10@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915-ep93xx-v4-29-a1d779dcec10@maquefel.me>
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
> Add YAML bindings for ep93xx SoC keypad.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

