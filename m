Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C6D78C1E8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbjH2KDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbjH2KCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:02:44 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1BCC9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:02:40 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so10576619a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693303359; x=1693908159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNfc1YCzECSmHdy+J5cr9YqVtcVteK3GsZt2ifwyGH4=;
        b=P3BpxzUodeNxtHNYzDbhTJ2hrQuMHlwGM139bxjDQIzc5ypgBk9Ib0ZL8ycwytf/sc
         IrqjeOq/HFUHt7yhB9SL1k08PTb9KV/8R00VZDqcvPnopiGG05RNIAgS2V2BpMcRQnwM
         XSEUlq5oh9yJa0U7qrgRFhHXx4TtBNm31g+54AXhVAV9vVt+M2WldfFzuCbjaz9Ogv9r
         WG65py12GrcP6Q8MgIZ3sRMdDZ/ypTFvRUjsXp7DYLsa6owZPacRzBpc4BqSjDHjPFdn
         6FMEx4RBgdpqN1ygIWtIiTz0Go63Z7W5Iv+aac9GvplK6lhVd1bUc6t2//3ucEl0/okq
         VUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693303359; x=1693908159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNfc1YCzECSmHdy+J5cr9YqVtcVteK3GsZt2ifwyGH4=;
        b=W/jJOKGpjTmsERTUQCwKHUHl2UiSAEysD7nj71NjzgQEXumoAwFHPCUzxcFSIgNzDC
         5vatIZjc/0hJibAFT10yhk/7kjEpjJs4yHzvbunrhC9MYKgNx5zMvQt9dBNAKs+Ober+
         JDQMQ86B1S11E5q/ObGneQXKjmn532NTROWaUPM2TJaKFNVwjE3VLqbA3SXZwybBvahX
         0X20mRJMd8QvRdWU/cemvnp5NhurZJ4W0QkiUZyQMjorT+4yND4wt/QGcsl8DwWpgt7u
         HqVQnLepEItOEjwkOM7pjQXuuwFQXo+4vmETUZRFrfwd5SK6ywtp0HjSN/xFzpDpvPWp
         CXCw==
X-Gm-Message-State: AOJu0YzKz0YNzNSLUZ9jHBMua4vna4tgX2mH48B+dEm9ukSygfjdwaDJ
        HmA1zRQfCx4+hgbhWehtbzx2qg==
X-Google-Smtp-Source: AGHT+IFHNtgUX1U+W+lEJ40ltziK5ZFMd1TqeGtv9haM9ughdurndzqlJlcIDfvWInNeikh9GiEWDw==
X-Received: by 2002:a05:6402:50ca:b0:522:405f:a7 with SMTP id h10-20020a05640250ca00b00522405f00a7mr2475248edb.16.1693303359021;
        Tue, 29 Aug 2023 03:02:39 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id y21-20020aa7c255000000b005257da6be23sm5460501edo.75.2023.08.29.03.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 03:02:38 -0700 (PDT)
Message-ID: <674ae250-8256-8ffb-01fd-eb2bd6026808@linaro.org>
Date:   Tue, 29 Aug 2023 12:02:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 08/11] thermal: exynos: stop using the threshold mechanism
 on Exynos 4210
Content-Language: en-US
To:     Mateusz Majewski <m.majewski2@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20230829091853.626011-1-m.majewski2@samsung.com>
 <CGME20230829092421eucas1p1970c3fb42ca622129bf92511893500b1@eucas1p1.samsung.com>
 <20230829091853.626011-9-m.majewski2@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230829091853.626011-9-m.majewski2@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 11:18, Mateusz Majewski wrote:
> Exynos 4210 supports setting a base threshold value, which is added to
> all trip points. This might be useful, but is not really necessary in
> our usecase, so we always set it to 0 to simplify the code a bit.
> 
> Additionally, this change makes it so that we convert the value to the
> calibrated one in a slightly different place. This is more correct
> morally, though it does not make any change when single-point

I don't think code placement is an aspect of morality, yet okay:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

