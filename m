Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568BC78199D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 14:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjHSM65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 08:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjHSM6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 08:58:55 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2660D4C30
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 05:58:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso2672293e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 05:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692449881; x=1693054681;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0883NRcCCKexhwRmxde3MLpdkmxRH7uy2OPJomVHVjI=;
        b=bTr80jcI8JhImFmfVBHqOBPuokD6WYH6Bk6HkAPe5lh7nVV9TdijBZRSBzwZ1o6wQW
         sUMZ7v0pjXY2ZBih/aJWdZI7D+PEbHPTeDXJtsbs1DO9B31/hLIucWoCI89Od1Dkvhvc
         KsUrLzpGt9PcBd12n97IG9Co8Ufzw0UMHSsgG3NQKjwlQNz1isrowYbu1FncumQM2FPV
         LUFReGrdfGBE4b4SG0oZ5UHkZaPzrp5THVV/Fd3lesctC1qslfACRBk4nUXXt/M2IWrn
         fQ5+wxVzpgIcq6w7x06QJdxDwowNN7og/NbZzvHQ2WcjaAa8iZJcHNrix1z2UnEO+YYN
         ARxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692449881; x=1693054681;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0883NRcCCKexhwRmxde3MLpdkmxRH7uy2OPJomVHVjI=;
        b=cBv90xzpIKsBjoovsEVVXugxZY6g09iZDn5hx81yR2vVecjOa6SWIJ3CAjn+N+44bT
         kIfLGyFwPBgSz57GgvRl0/HaxjycjH3ZUhEhAvqxNPgmqm0zR+UkdlRZABpWl07J6ydX
         zXioFXAjFjPzFguSwLjqrJUyTOoNDwhE11WgHBJvGlpALePP7l/PoYJmJWda//qxOE6U
         PjEaBBL4XR7Tc/TyXb7U1i1r1BnlibgSRELMHnpRpgGI1+Nzaq14maUwOV5ZfihqEDD8
         /IiHVUuUgtV6dieXYQewDn0dPG1fzn3WAj0DrvKGnIVjiTXp4INB2l6/QSqxuDasp3fq
         17HQ==
X-Gm-Message-State: AOJu0Yy5JEQi4h5RvpIz/DBgSeC3tBau3yCezqgiGzCZB0xlPRntDxNS
        tVymy32ClzIxhLWTWBRdq3yKNQ==
X-Google-Smtp-Source: AGHT+IEfxVtqHYjR/3kmzxaHPugRDyg/pQWHcu0erc5asJNqUrmkSk7jYnDb6Ze39ETaNoHwrLXf3Q==
X-Received: by 2002:a05:6512:3a88:b0:4fe:7dcb:4150 with SMTP id q8-20020a0565123a8800b004fe7dcb4150mr1454176lfu.67.1692449880647;
        Sat, 19 Aug 2023 05:58:00 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id y9-20020a170906524900b0099bc0daf3d7sm2703480ejm.182.2023.08.19.05.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 05:58:00 -0700 (PDT)
Message-ID: <73e515b4-a8fc-35a8-7f34-720e4daf8e81@linaro.org>
Date:   Sat, 19 Aug 2023 14:57:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V5 2/2] dt-bindings: cpufreq: Convert ti-cpufreq to json
 schema
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>
References: <20230818124504.3718266-1-nm@ti.com>
 <20230818124504.3718266-3-nm@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230818124504.3718266-3-nm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2023 14:45, Nishanth Menon wrote:
> Move the ti-cpufreq binding over to opp and convert the free text
> binding to json-schema.
> 
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

