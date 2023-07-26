Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61E8762B80
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjGZGd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjGZGdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:33:54 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEA81FF2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:33:52 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52227142a27so4555417a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690353230; x=1690958030;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MZgSHgs+DaEu5YKeJ7xYroSTsKzuw+qbovR9q1BksYk=;
        b=NaBZnXsxeuQzuczGqtwCBX1JMo5/AIwWPrRzlQV8QJaimiIAHSQsOIuaYcJjRxy1Z5
         Q1UWMcH8xX5l22eNgWA/GbI+x3joki79DVJBtDuNur0X8xfbhlhbqeIgWxI0grb/JA2M
         C24RvYntdb5GQliZBLWZDreB5mFr0eJtLAr0+YUIxnroqi9XLSOrmgh/JX2kGFtgkiRw
         VxWo5BbGMVGiPFxS6O3eFR7+ZMESRuUDjOlJOCc4z2Co2cqR0UQLB+eMlw3cqEZZSMfX
         TSK5V+jxjrsLvD1tVaRfO5oxGhLWk03ll+e1lulIhT8+GiPpwGKLv8pTRptqC81fck/7
         1Lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690353230; x=1690958030;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZgSHgs+DaEu5YKeJ7xYroSTsKzuw+qbovR9q1BksYk=;
        b=WpM84RSCLjKUvEuwKcscdxUd+lyps7J++/wiM+TtziZIl1G7hq9HlQWScvZhMrm/QT
         c9nFbYEBjQyyz3r60jSG5gy+WA0mGkhy6ubolB9K8owl4+Ls9qYLRf4x6cw4XuoKNyOl
         TYGR1CxPboUO12kfgcyZiAHld0huLWQZUZ3g1jD3FDJX5BM2KWUnZB0WUfmeaCD49oMg
         tO7dsrTP0UeMzrPViIbHuQ33H6A4pzXUe+gQdltk3t8spf3T7ULJbwQYpE+ipIV1IHJl
         fnAh2ICl40/Nwiw+1TIUpv83Zt5UOtDbX/MH4Tq6+AyMKiLNeGsMcmlFvB+p6rfMOVrY
         N8TQ==
X-Gm-Message-State: ABy/qLa7wU+abe0biY6oCfxtXDWO13G7ZyIczO4qkb+qn1SlFDpILEOl
        m4Y8BaYWvfNn9MMk6USXcmhHow==
X-Google-Smtp-Source: APBJJlEqrM14tJfMA+TcQHw7fvQjjF0gb0G1lKIEdzmcSA/W2bZSmpfQbJgqHftRJIIo5i2M02/PaQ==
X-Received: by 2002:aa7:d958:0:b0:522:3ebc:84b9 with SMTP id l24-20020aa7d958000000b005223ebc84b9mr776848eds.24.1690353230229;
        Tue, 25 Jul 2023 23:33:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id q2-20020a056402032200b0051d9de03516sm8450368edw.52.2023.07.25.23.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 23:33:49 -0700 (PDT)
Message-ID: <30d0689f-5a6a-c593-2a30-1ef2dc37f1af@linaro.org>
Date:   Wed, 26 Jul 2023 08:33:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] media: dt-bindings: drop unneeded status from examples
Content-Language: en-US
To:     Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230725101625.75162-1-krzysztof.kozlowski@linaro.org>
 <e8138fd1-5d1f-8fc3-e29a-547902c2ab18@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e8138fd1-5d1f-8fc3-e29a-547902c2ab18@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 12:55, Benjamin Mugnier wrote:
> Hi Krzysztof,
> 
> Thank you for your patch.
> 
> For the st-mipid02 :
> Reviewed-By: Benjamin Mugnier <benjamin.mugnier@foss.st.com>

I don't think we have half-reviews. There are half-acks, but not reviews.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L542

Best regards,
Krzysztof

