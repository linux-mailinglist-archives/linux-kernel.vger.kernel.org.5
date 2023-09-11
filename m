Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C423479B456
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376799AbjIKWUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242586AbjIKPww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:52:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C7F198
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:52:46 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31c6d17aec4so4540304f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694447564; x=1695052364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vprVq4/fIAbFZ3+Z+xgdIo0JUeYirqwRwX7pZL6u4fA=;
        b=wDJKy9L0I+SKSWtQy/K81xgMjKmEduFNKp1rwtMKZXJQAzxW7EIKTn59XXyHSrDMBM
         RqfQbYv/bmjicySq+c8g9bmWlgNeXZ5AOdg1UYk/dnE0QryEJo2odUoXS4j3DzeDYjaH
         EslS7rDMuQ1tF2fxZO6q3r9L6gvVlpUfQchjMuxPQYYv+tJiFXqdGmrylrNe9DUGr/Up
         DBh+g97ojzWEVObNDsqsniWR8SmpZl6wn7MzxAkVzo3ln4/KM8Vfhpt49KrOyvMfJhV7
         lBUrMV2dsGqmD1SjH0L0/Sibgx6HPYw126NUkdXLJ2Gbvf/yW3WvZxzPDZYKqRWASIgC
         SIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694447564; x=1695052364;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vprVq4/fIAbFZ3+Z+xgdIo0JUeYirqwRwX7pZL6u4fA=;
        b=tejF1KZ1NfrYSNj5YOKJ2JRRPfBsVmetVZydF8vlNYOn4E4EvZcYalar9Gvtn1rQCh
         xPpp+BzzUyvb07627q63WOo7Z+QLvuKQJMsoDqa4AwRCeB03D7betFcAlictAmqY3T74
         ybsbuE7V2ihWnIDeBrQdPLjhvA1zVSRM8UeiRNuFR90NymzyildCy/YDE8gVXnFt4gQQ
         tLLzftsRR7t/pAimXrBELS9e8vDFC0nppnDRdIFtHewrBwGrrVi8IS2Gg7HxosBLUVXb
         gCk+PtZ2c7S5JB46QTVjE9/ala62xuud4NdZaP0NES2BNem9Qu5B6eldrKgfwqT/QyB2
         0How==
X-Gm-Message-State: AOJu0YxagjROuqu8e5EEv1t2cz+Z2XSEGTie1N281YsYHQ9cQIjhxPdz
        HYpIJaNHEb7XQvJqrK1W+w8Gbw==
X-Google-Smtp-Source: AGHT+IGUlTJ1BW2ei9S+2zEfUFxpzm/NdK01VQBtmj64Biovz3gEfjbEA6RA919h5wHqlMsvf0BgDg==
X-Received: by 2002:a5d:55cf:0:b0:313:ef24:6fe6 with SMTP id i15-20020a5d55cf000000b00313ef246fe6mr8680107wrw.1.1694447564646;
        Mon, 11 Sep 2023 08:52:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id c6-20020adfed86000000b0031de43fe9bfsm10474792wro.0.2023.09.11.08.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 08:52:44 -0700 (PDT)
Message-ID: <8b1fdd46-8ebd-f992-68df-389683ef5368@linaro.org>
Date:   Mon, 11 Sep 2023 17:52:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] MAINTAINERS: mmc: take over as maintainer of MCI & SDHCI
 MICROCHIP DRIVERS
Content-Language: en-US
To:     Aubin Constans <aubin.constans@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Hari Prasath Gujulan Elango <hari.prasathge@microchip.com>,
        linux-arm-kernel@lists.infradead.org
References: <20230911153246.137148-1-aubin.constans@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230911153246.137148-1-aubin.constans@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2023 17:32, Aubin Constans wrote:
> On the one hand Eugen has taken responsibilities outside Microchip,

That's not a reason to drop Eugen or change his status to a reviewer...
Unless of course this is what Eugen wants?
Normally you should just update the email address, although if it is
still not updated, then indeed change might be needed here.

> on the other hand I have some experience with the Microchip SDMMC
> SDHCI controller.
> Change Eugen as reviewer and take over maintainership of the SDHCI
> MICROCHIP DRIVER.


Best regards,
Krzysztof

