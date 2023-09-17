Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8C67A3423
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 09:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjIQHsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 03:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjIQHsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 03:48:33 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906C5191
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 00:48:26 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-530e721f077so559501a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 00:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694936905; x=1695541705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GVPsYlLWrWkecJahmm8glLPlUmggcjlQlykoHTahPBs=;
        b=RN/bt+EsomRqiB9xWzz3SMs04X366PgKHRMTPVD3H0ZpHn4IUO2RP4d7muKgjhAsex
         VSKwLZELXwMsaIaG9LTVA/dxJ8Ap2byowHViWkenqaBhpIckL39/jOyxplFflfU4aNd2
         D3uQm4duDJKlJNaPp6wLntqVmAhQcFIS6NLd2N07ONbHzJ1Qc95FJ/QJAB8AiZxVtOVs
         h7M9W65VGPs88vnUs5kIguZNTPSrX5/rtkOB3Y/oPeWwiH5d7WbqqqkA7rjE66KWA4Cj
         74yczqv5bqql1xKUpZA0jka10LkW7qklbiIlNESgOGYPsp/HuP+8RtIwSzxM7CqR80i1
         jk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694936905; x=1695541705;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVPsYlLWrWkecJahmm8glLPlUmggcjlQlykoHTahPBs=;
        b=CxRN7+CAF3r7xl1q7/liE65CPrUAHrxaOay+2dYyt5dpuqLLAHK4V8eey9S+s1GMFp
         a5YrWqnI4GfxG8K0sKbX+KIz/r8oefsq6Kcor0Lm3K+ZsOTJUW8CwSEQScpKXa3U5ymE
         MWjleiLJZ1OeLChZWtUQtnyF766kGJQKx4nUC+4VDKBE8dQH+vuDS6IFyhSbQdAxLR3a
         a8hYumMmdnThi8nafzxgOkzsnM+mqacv+w17Cd3z5KNW5NkB7DQJtw9znvXmzGRFMg58
         DewYY76DklHRXYD7CeenA0Pw/qQ5WAJX8eTinyZdGpn+ipPyjQrakKIS/ZXeT6ivGHO5
         Gf3A==
X-Gm-Message-State: AOJu0YyfKVVsyTFKu845nrdnkxKm1pKRUL7GLxLsGZEDmpDzvppYNxB9
        aflVJPXGefTp5mVRHGRgOS7nfg==
X-Google-Smtp-Source: AGHT+IEmjAsO4U5DH1/SUqLBxFViS6gZtzW/Gz0PYU4pDtjJ+T01gRVgwYJdAGxdBcBSE/ulzwTU1w==
X-Received: by 2002:aa7:cfd9:0:b0:523:38f5:c5ad with SMTP id r25-20020aa7cfd9000000b0052338f5c5admr5300840edy.20.1694936905043;
        Sun, 17 Sep 2023 00:48:25 -0700 (PDT)
Received: from [192.168.1.77] (150-140-187-31.ftth.glasoperator.nl. [31.187.140.150])
        by smtp.gmail.com with ESMTPSA id i8-20020a0564020f0800b005309eb7544fsm2636443eda.45.2023.09.17.00.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 00:48:24 -0700 (PDT)
Message-ID: <4ff26ffd-2574-af16-d950-7f1b544528ef@linaro.org>
Date:   Sun, 17 Sep 2023 09:48:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 5/6] arm64: dts: imx8ulp: update gpio node
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
References: <20230916-vf610-gpio-v2-0-40823da788d7@nxp.com>
 <20230916-vf610-gpio-v2-5-40823da788d7@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230916-vf610-gpio-v2-5-40823da788d7@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2023 04:04, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The i.MX8ULP GPIO supports two interrupts and one register base, and not
> compatible with i.MX7ULP. Update the node following dt-binding doc.
> 
I think last email thread concluded they are compatible. Otherwise, how
did it work so far? You break users, which might be ok, but commit does
no say that anything was broken here.

Best regards,
Krzysztof

