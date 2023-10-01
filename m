Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880DA7B47C7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbjJANyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbjJANyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:54:03 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B941791;
        Sun,  1 Oct 2023 06:53:59 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9a64619d8fbso2195560566b.0;
        Sun, 01 Oct 2023 06:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696168438; x=1696773238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TdJ8puCnck5Qjx/oIgi0cgvE0Anaq9Q2XGGDoV+48xY=;
        b=Pv8s63G2r6M1aJYw+wtK4YpqJ8+G9W9cNrmBlfj2ogU064bXz8DR3377/JOvI/TW57
         qsT+vdJtiratH3jUkYkz8y0hUDcIiBKmdin0T7JoPZ4A7FkaXAm8txHFCVUDXra5n7TL
         RWy46LkbOHvkTRhJCHG6C8bS+egGJN62jMbK66cgUtHFDXgXvfs+aeX3yG2yXowiZy6r
         LEXzFTrd+YrdkNipfvdojE9dL7WcygZMcQSftnFuLG/V6v65oZiZ+ce9ducHLWqbyrrc
         8XhKbC5S+bgJSR/j0cG9hrsLlC7PBHWKlfht+PIu2hJvM7cbHqWQodJJYYZIAYsxHiLl
         hukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696168438; x=1696773238;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TdJ8puCnck5Qjx/oIgi0cgvE0Anaq9Q2XGGDoV+48xY=;
        b=GTwocAmFefStmVDxUWOiv6jmPWoN1qQ/FchLXGM4beFunVJiYFQNWjmRPV2PGXMNfd
         kR/kdFmI9te2X1dQf9i6NA/GhXS8xpdY5kJEEmzkJSKHlgdFWMSSVVEqB7MW0bTBvsFv
         sbazPnnQXx5CSNl8SahN5HNK25pYIQbwIITmrozRBFQ6p3d7b8BVG8HqEnZVToSwByXS
         mpF0Nc+NmkctEjCgk5vrKXzoyPNGXcS06qLjKZL51f393VvXjAmCZXonwp1TRcSWrSYc
         +dNIz8NIWusZ5nKfWhKMC1/iW5XEbhcDxyjymR+zPeau+EoUlT7+xW8uptJlyNvES0ZE
         RC2w==
X-Gm-Message-State: AOJu0YzcsJyXFJHssEl+5h7Ybw4JEFUsQGZV8tmTfpcnkDLh0+LQajs5
        N1kQTLj2PlTEzDe0oYJzdMk=
X-Google-Smtp-Source: AGHT+IEr6ZT/FRqIBF+eOoIFBpPXyz4h1VClRjtJrhFotkWjWchOvZQSbHB6CzeK3J2VQa6Jpkk1KA==
X-Received: by 2002:a17:907:75e1:b0:9b2:a769:8afc with SMTP id jz1-20020a17090775e100b009b2a7698afcmr7558571ejc.77.1696168437857;
        Sun, 01 Oct 2023 06:53:57 -0700 (PDT)
Received: from [192.168.1.99] ([151.95.145.183])
        by smtp.gmail.com with ESMTPSA id l5-20020a170906a40500b009ae4ead6c01sm15400407ejz.163.2023.10.01.06.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 06:53:57 -0700 (PDT)
Message-ID: <833fc809-b1d4-471e-afa3-68ded78b20f0@gmail.com>
Date:   Sun, 1 Oct 2023 15:53:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Denis Benato <benato.denis96@gmail.com>
Subject: Re: [RFC 2/2] iio: imu: Add driver for BMI323 IMU
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        andriy.shevchenko@linux.intel.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
 <20230918080314.11959-3-jagathjog1996@gmail.com>
 <20230924153055.0b3486f9@jic23-huawei>
 <CAM+2EuJBxj7P-ymu84u308g8LCemSEsYi_TSHYtaK9PyrhqrfA@mail.gmail.com>
 <5eb148b4-25eb-460d-9ec8-0a40bec1dc6f@gmail.com>
 <CAM+2EuJUGu4QUCdZ7d28RaLNipJRVuASP9wSzF14k=oBoC4e_Q@mail.gmail.com>
Content-Language: en-US, en-US-large
In-Reply-To: <CAM+2EuJUGu4QUCdZ7d28RaLNipJRVuASP9wSzF14k=oBoC4e_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jagath,

On 9/29/23 09:59, Jagath Jog J wrote:
> Hi Denis,
> 
> On Thu, Sep 28, 2023 at 2:55 AM Denis Benato <benato.denis96@gmail.com> wrote:
>>
>> Hello,
>>
>> Some devices (as my asus rog ally) have an ACPI node describing a BOSC0200 sensor. The IC being used in those devices is a  bmi323 but as a result of how the ACPI table reports that device, it is detected by the existing kernel module and we have no way of differentiating until after the chip ID probe.
>>
>> The module loaded is bmc150-accel-i2c.c which currently doesn't support the bmi323 and the loading of the module just fails at chip check.
> 
> bmc150 driver supports multiple accelerometer sensors such as
> bma222, bma280, bmi055 and all of them are having similar
> register map, but the bmi323 register map is completely different
> from bmc150.

I apologize for the confusion.

What I was trying to say is that to have the bmi323 working in those aforementioned devices bmc150 will need to be modified: that is the probe function that ends up being executed, fact that cannot be changed because it depends on the ACPI implementation shipped on those devices. 

Therefore I was asking about the best way of handing control to the new driver and how that should be organized: in my implementation the new bmi323 code was written inside the bmc150-accel-core.c and only shares sleep/suspend, probe and removal functions in addition to checking for the new chip presence before checking for any bmc150 chip as that issues an i2c write, while the check for the bmi323 only requires an i2c read.

We also have done duplicate work as I have written a driver for that chip myself, but it's not as good as yours because my hardware didn't come with the IRQ pin connected and so I couldn't develop triggers and I only got the i2c interface working.

> 
> 
>>
>> I have solved the problem by expanding the current bmc150-accel-i2c.c and bmc150-accel-core.c files to handle that IC in almost every part: gyroscope, accelerometer and temperature sensor.
>>
>> What is the best way of organizing code to have this module mainlined? Is it correct leaving files called bmc150-accel-* even if it is managing another IC and and not just the accelerometer part anymore?
>>
>> TIA for your time.
>>
>> Best regards,
>> Denis Benato
> 
> Regards
> 
> Jagath

TIA for your time.

Best regards,
Denis Benato
