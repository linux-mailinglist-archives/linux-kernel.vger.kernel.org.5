Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDC27536EC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbjGNJqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbjGNJqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:46:03 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B3930F9;
        Fri, 14 Jul 2023 02:45:54 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31438512cafso1715934f8f.2;
        Fri, 14 Jul 2023 02:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689327953; x=1691919953;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GhHyeq8MCFgNA8Hcp4N9hDnUifGjHf0k8KsJt5oJLss=;
        b=mq5YTBczOtAj2Fmv7zdTHZSP29BONdxt8WAXSWRe4WSaA8un71MGSiXj1d8jsN9J4H
         u+QNYHPbiEthBM3vRPnjM4ui6zN0+he5yM8eIJmkHjr0Pq2lXRgXrv1XD52KM0PqdCCx
         KasOIgpsgT30QQ6ZfsB1sR8AqyhNeNkZzazH9Gwtnr5c8MSLIkfnRm3e1VJPPJ+E6E/n
         KoJ7TFpq8TntBy4yuxD6/wam5cOAxd1hYTdm6f8toNJJq1GwlWFVhOkmzZLTZ+a6G232
         HVNXMaxAEfG8BteidGs6BOTMOpKL/mKwM3Ipwv26vahblGdKfq8guT0IEFzfCENVux9t
         26MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689327953; x=1691919953;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GhHyeq8MCFgNA8Hcp4N9hDnUifGjHf0k8KsJt5oJLss=;
        b=bVDGFkeJfn5gdx19VRYiUDZdaiIThbwFo7mj/na1KpGBrIovuLAza4VQRThsjoLlmB
         10BG5ylBkFi8hLiDPT2/Comjxb/8KP3eSo8f/kiqGhphaBc7fAHCW16XTNXs2do01Te6
         1U95OwF829TP1JCb2SZNH6Gm1rzps0I3BhtqFP/O/SmNzSiwfY0cKJdsEY1tjdwf1hYY
         BAg9fIHebuE0qwW4ulLHtyKRVLwVt+yVmcuSKDMdgkLWPyHR3n2rKvtTiR3301c/rDrI
         oBQwOCXvM4T25fmycMFR4ZPlE8W/rkxJD/zKja/jDZfr5eWWip3O+f5M0+87zWYqMiBL
         EcBw==
X-Gm-Message-State: ABy/qLaB7PV4V1JzPNZt2rzNTrEuIcZwVoRa3gCJwFkPETz/RMhFI9qc
        4deWxO9uD1zDo4T7Txecy/M=
X-Google-Smtp-Source: APBJJlEBxgS1V39uLRGz2VYRmg94Pffn5d7V+hpe2aBIFy1dvQRHq7BriGcxTq9dr9/L0POm0Z0oxg==
X-Received: by 2002:adf:fc4f:0:b0:314:2c7a:d100 with SMTP id e15-20020adffc4f000000b003142c7ad100mr4220676wrs.42.1689327952386;
        Fri, 14 Jul 2023 02:45:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b? ([2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d684e000000b003145559a691sm10340340wrw.41.2023.07.14.02.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 02:45:51 -0700 (PDT)
Message-ID: <e2ff9174-c282-8c19-27d3-4d6681e7df16@gmail.com>
Date:   Fri, 14 Jul 2023 11:45:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/10] serial: drivers: switch ch and flag to u8
Content-Language: fr-FR
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tobias Klauser <tklauser@distanz.ch>,
        Russell King <linux@armlinux.org.uk>,
        Vineet Gupta <vgupta@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Baruch Siach <baruch@tkos.co.il>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Hammer Hsieh <hammerh0314@gmail.com>
References: <20230712081811.29004-1-jirislaby@kernel.org>
 <20230712081811.29004-11-jirislaby@kernel.org>
From:   Richard Genoud <richard.genoud@gmail.com>
In-Reply-To: <20230712081811.29004-11-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 12/07/2023 à 10:18, Jiri Slaby (SUSE) a écrit :
>   drivers/tty/serial/atmel_serial.c    | 2 +-

Acked-by: Richard GENOUD <richard.genoud@gmail.com>

Thanks !
