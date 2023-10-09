Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5394B7BD2FE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345145AbjJIGDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345128AbjJIGC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:02:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7AFA4
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 23:02:57 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40675f06f1fso29793125e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 23:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696831376; x=1697436176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4N3ATREkXvK843TZ23OVVz5eoxmZn5m1pt06q8AVw8o=;
        b=r3bderavc+mbDo4NIckVzyPhccG8/iq6EfSdIZkLpgiaRDtiy27XASc9vOzLEf6E6I
         3dqRT0Y5MGFgjS+g6tXgvCQ3dHgzFHgNwoh+l5yFAPOkDo8iWYqQvKYh6dTYwHgWI/Ef
         gEsoBY8W4LZElxGVTlTj6m1+xrcvR99lf7p74SsjkGVX81XUuiCROppoVb90UDggBSRP
         OAynwYDyuLfW6lR/KRuLfDGGsKOintrFcpg9Ld0zurNLoDzwOos0mKyiBWeGpFgaVrfO
         c2QyiXd9GIb4sKzPmMxUFcFHmyL/zJHocW0Mmu9I3IgeDEn2oXdfZRYheEYi5MktCQu0
         h7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696831376; x=1697436176;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4N3ATREkXvK843TZ23OVVz5eoxmZn5m1pt06q8AVw8o=;
        b=wR7yCEvl7AcZmIyhBdwARYEzdexW13IblGcDaEeto5zjlcadU67skhQoDscIb9MVWl
         f/+0dR/tV75JdIrF434okzzk/fYw/zfkmly1aYh5OFPDjh5X1V2ZLgrMmQLnEVnb5Anm
         GTgxz1t+RUUYKcEVJVTRfaZZkJAWcBfPnWfHoh7R2SDsaDyMiBz9priB8aZjWefNbgeS
         4/SWdGzjxdJ0kD8dlnZ9/3kkvoLiHESG1fQKkZEz5MslHTBVaCY6vTUuF7f970t6Ijr7
         hZenI+n0KkhfwuyghF50JBJR9tAeRksA1XoxmOrHIH9jYzbk3Dz1IB8IiEj+VyuI1qQ6
         YUmw==
X-Gm-Message-State: AOJu0YzUj1Wcbl8nq/Qhy8QRhf0iyS0Xd627P2i9BxD0lfL+UThuTH9a
        jfZjZPXb9tVOfdNZAr0rV+PFkw==
X-Google-Smtp-Source: AGHT+IGdfiblx37cmyiMJPmbu5ee0oKAHqGuGtxnKYAOTurlL996uBf+3Sda8V3WezqZmlwMERGp1A==
X-Received: by 2002:adf:fece:0:b0:329:2306:91a7 with SMTP id q14-20020adffece000000b00329230691a7mr9184153wrs.2.1696831376119;
        Sun, 08 Oct 2023 23:02:56 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.123])
        by smtp.gmail.com with ESMTPSA id p4-20020a5d68c4000000b003232f167df5sm8518043wrw.108.2023.10.08.23.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Oct 2023 23:02:55 -0700 (PDT)
Message-ID: <3fe1db30-038c-4ff5-8344-5b824503bd7d@linaro.org>
Date:   Mon, 9 Oct 2023 07:02:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: samsung: usi: remove superfluous parameter
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter.griffin@linaro.org
References: <20231006090014.277448-1-tudor.ambarus@linaro.org>
 <CAPLW+4==D1OVB+rY92NVEmfv08=0FBF0LJ07xoHh4YZZPOneXQ@mail.gmail.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4==D1OVB+rY92NVEmfv08=0FBF0LJ07xoHh4YZZPOneXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/7/23 00:08, Sam Protsenko wrote:
> On Fri, Oct 6, 2023 at 4:00 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>> exynos_usi_set_sw_conf() has a single caller, exynos_usi_configure,
>> which called it with exynos_usi_set_sw_conf(usi, usi->mode). Since the
>> mode is already defined in struct exynos_usi, remove the superfluous
>> pass of the mode parameter. While in exynos_usi_set_sw_conf(), remove the
>> reinitialization of usi->mode with its same value.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
> 
> This driver was designed with the easiness of its further possible
> extension in mind. For example, passing the "mode" into
> exynos_usi_set_sw_conf() allows one to implement some sysfs nodes for
> switching USI configuration manually, just by passing the user's mode
> into exynos_usi_set_sw_conf(). Other things which might also appear as
> over-engineered, make it easy to add USI_V1 implementation, as we
> discussed that possibility at the time. So yeah, it was done for a
> reason, and I'd prefer to leave it as is.
> 

Fine by me, thanks for the explanation.
Cheers,
ta
