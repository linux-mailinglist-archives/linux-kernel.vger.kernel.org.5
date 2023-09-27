Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931407B0E01
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 23:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjI0VZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 17:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0VZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:25:09 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3A3D6;
        Wed, 27 Sep 2023 14:25:07 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c1c66876aso1548069966b.2;
        Wed, 27 Sep 2023 14:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695849906; x=1696454706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lLt2EWwiAamue+aQFCf1ccw7xlWtw/NamUWzlxPh9vg=;
        b=SxvozSPNQ369+5Iw4tK2Uvlqo4FkvntgqiM5b1mODe4EzB4+s6rrBFRwuydrNd/Ga1
         4zQ7Zwexu8KxB6AcfUyqhUAnAkc8lzGLnlZsbXJHDOXyzFw10UCL395hRGxPRiMRotnd
         o9ZxJqXLiwqf8jwnlhiJjrIqKBu7g3tnHJ1kR13BDJVEtJueirWixKPrA2Y5lUCZnKwX
         bL0IttBVX2w/ozN8X/qglkgh/eYva5C1Y9zN0j9444PKFXZfpNvuAn+om8wWYFn9jKm8
         sZQZNpMXHxKvcD/Hij5BsEslg7KmMFunUGS0EZGotYeQCQ28vK8/zxV18IMrVZ95HoOy
         m1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695849906; x=1696454706;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lLt2EWwiAamue+aQFCf1ccw7xlWtw/NamUWzlxPh9vg=;
        b=YNLIdH0flwrAxDLiF4FW88BJBWxTdf9vFst/59ROoBuRpmE9rCELth9coO/vT5voBJ
         vlF8BKNE5jOJUpRKg+9lJNtF+siSK7akMcPITblmF3XxmhJXIODWtFETsic0GBUBa5X1
         pa+2HuSqDYAScbETfgDtS8P0BO/T4wEkhFQC+Et3kFHIIOgibQgBKRzepls+4gnGC2c4
         kTvUPM4LFgZLHCpl9QSBqZF3g9qfaVNhlfTjHq8UfFwVGq73ZPjJKmFqfewuOVLap2MM
         vCZFpK+cvpvb59ipSc+Pn2pODjVJb+IN9u96/NURxffkRnRsvHeygeWALxaH9mhGnbUW
         9EpA==
X-Gm-Message-State: AOJu0YxfAh5ZHUIaRFDPmvAh7UW2eJrs5j9Y2wO0aaTCxO4xCEW88r+c
        yctUK/2Ag1DEaXy29zV5bnI=
X-Google-Smtp-Source: AGHT+IERdbconsI7Dm22p0pAU1PPLVIbctTBnBxcCPOg/9FqmujbKEGkmv5aDTBQECYmoQmXzl8WTg==
X-Received: by 2002:a17:907:77da:b0:9b2:b43e:4fcf with SMTP id kz26-20020a17090777da00b009b2b43e4fcfmr2352742ejc.64.1695849905945;
        Wed, 27 Sep 2023 14:25:05 -0700 (PDT)
Received: from [192.168.1.99] ([151.95.123.113])
        by smtp.gmail.com with ESMTPSA id bg1-20020a170906a04100b009adce1c97ccsm9886969ejb.53.2023.09.27.14.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 14:25:05 -0700 (PDT)
Message-ID: <5eb148b4-25eb-460d-9ec8-0a40bec1dc6f@gmail.com>
Date:   Wed, 27 Sep 2023 23:25:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] iio: imu: Add driver for BMI323 IMU
Content-Language: en-US, en-US-large
To:     Jagath Jog J <jagathjog1996@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     andriy.shevchenko@linux.intel.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
 <20230918080314.11959-3-jagathjog1996@gmail.com>
 <20230924153055.0b3486f9@jic23-huawei>
 <CAM+2EuJBxj7P-ymu84u308g8LCemSEsYi_TSHYtaK9PyrhqrfA@mail.gmail.com>
From:   Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <CAM+2EuJBxj7P-ymu84u308g8LCemSEsYi_TSHYtaK9PyrhqrfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Some devices (as my asus rog ally) have an ACPI node describing a BOSC0200 sensor. The IC being used in those devices is a  bmi323 but as a result of how the ACPI table reports that device, it is detected by the existing kernel module and we have no way of differentiating until after the chip ID probe.

The module loaded is bmc150-accel-i2c.c which currently doesn't support the bmi323 and the loading of the module just fails at chip check.

I have solved the problem by expanding the current bmc150-accel-i2c.c and bmc150-accel-core.c files to handle that IC in almost every part: gyroscope, accelerometer and temperature sensor.

What is the best way of organizing code to have this module mainlined? Is it correct leaving files called bmc150-accel-* even if it is managing another IC and and not just the accelerometer part anymore?

TIA for your time.

Best regards,
Denis Benato
