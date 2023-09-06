Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BD3793681
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjIFHnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjIFHnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:43:21 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E44197
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:43:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c1d03e124so471688166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 00:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693986196; x=1694590996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7c2BDsoYBazb4ISVLs01WogwNBRf2oRcEB6Brsaem24=;
        b=h1tmgloKAMdyVRVIr82hGY9dJQvdKzeMzhjqww4BSF4HatvICy0ks10nVoItOBY2mb
         ItioOiKz9Q/umTJGLKW+7RUJpM5CRYu4O2qfu8v4XcnOimsu8jZZ7NtuYJRYpXNd1s1V
         k2RZFUCJSuYvqJyMwcMUrTaOE4g862NM2gEW2yAhgddlR/8jpnRF31bRgGfT/OpUm/GF
         dJEv4C7bn53wa6yccDR/0VoTHInvEy+Dzh8m/b4UXfIDYCaPgehABYicnM3eHlDyYUAn
         fjMPvJE4RqhQ+kq0ugBn02PE4s961080rLSxioH6lQAOsKlaKxg1ECvA9TE0DSRd72Pt
         dWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693986196; x=1694590996;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7c2BDsoYBazb4ISVLs01WogwNBRf2oRcEB6Brsaem24=;
        b=Gy57AAYAlVBQW4mP7Z2hgify5xTv00dHkz75GSJ4zXBhhgCjusaqS3Z8Bu+fTqamyI
         TVXNpkAJrMff1Gmj4CSgAIst8VAtWhuO5CiQ86hoK9DjeU4GkemBWiteeSZv3Np5Iima
         9QovmJkUt8zorXIeefczEoiHa+4Z6z7A56Qk4nEZDERbJyLbk1JLjWeXsxfNXiWAazOR
         uWWGRR053sToU0JljiPoaCcthT0gbygUJq2lhtCSm+Fed/hJKTa1dxdriKpXLVP+QoKb
         kThNWxF28tgTA0YXaJe6gGEANKcwOf6f4W4tvxXwGdthGpuW7MIsFAeM5M+xPdCuMQod
         wRJg==
X-Gm-Message-State: AOJu0Yx18eC3QdiX/kbFxlBLt3ULUmVgYV3qjjsiDHluOxBScWv28QeV
        H0t4PCBH+hGjOAUjOWKjPphwkA==
X-Google-Smtp-Source: AGHT+IEkG1mCGUFejPHYpjZoGgZXtpiwV95wQ7nB10DJ2L1nsBt50yGnVRZ/jfFG8Doa0xYf9mmgcA==
X-Received: by 2002:a17:907:d1c:b0:9a1:e58d:73b8 with SMTP id gn28-20020a1709070d1c00b009a1e58d73b8mr1895924ejc.72.1693986195951;
        Wed, 06 Sep 2023 00:43:15 -0700 (PDT)
Received: from [192.168.0.173] ([79.115.63.137])
        by smtp.gmail.com with ESMTPSA id x18-20020a170906805200b0099cf9bf4c98sm8600667ejw.8.2023.09.06.00.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 00:43:15 -0700 (PDT)
Message-ID: <0df0be29-8ad7-c319-475f-c22ce57efa3e@linaro.org>
Date:   Wed, 6 Sep 2023 10:43:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 00/41] mtd: spi-nor: clean the flash_info database up
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
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

That's wonderful work, Michael, thanks!

Please specify in the cover letter the flashes with which you tested the
series, we need some sanity checks.

Apart of that, please address the small comments and resend, I'd like to
have this integrated at -rc1 so that we give time to users to spot bugs
and to still have reasonable amount of time to fix them, if any.

Cheers,
ta
