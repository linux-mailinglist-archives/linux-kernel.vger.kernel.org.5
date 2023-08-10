Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A41776FD4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjHJFvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjHJFvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:51:47 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C78DC;
        Wed,  9 Aug 2023 22:51:47 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9bee2d320so8093401fa.1;
        Wed, 09 Aug 2023 22:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691646705; x=1692251505;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TpwH6CCckkwKB4b82sShzAZy8oiId1XJvF4iz7xS6YQ=;
        b=SgsUhD5BAYpS7ZdPJE+9MT33EDDfwEw/ipKRwCywtAwkj8evHMBhVjYA8XnqZrZCkv
         WoR/Ti6vJF9TjcH7CeMH6sb+vRKM99fMFIf3hFKA1kDrK8UmErC5HYZ7mdPzP873AjDf
         4VeB5aMR6XSBvqhvz+Ae12qvXqVueYdapDFWGFyDwmAVjp+wrWW4FzpqbKbeShcdCP8l
         appcYo5ixB6cxFTHCQ7jFkXb7q4vzWmWjCtYUOgIWYw2zlyybfZXSEtXjRWBYD/x5yaG
         OQK2ZwJcrVxAaCAIXJwtQGyJQNzqLBD9KLe+3r5fDRZNX20i8PbC+EnUlYjvIlxRkxwY
         jWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691646705; x=1692251505;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TpwH6CCckkwKB4b82sShzAZy8oiId1XJvF4iz7xS6YQ=;
        b=Qi+OSADsq/0enZUxhhigsMKa1UpBqhUsBWJKOHtj9kyNuNihcZSBF8NHJ9JlrzW36Y
         m9voMG2aIUAEeQpSmgG6UQ32KbDObS2P67tNzfRPy91MsMUWiPApHgR6S/Vc+r3/WRGd
         QUjIu202GtrM0PHccXcvZ+IZyRNB25Emj25XNMXAagi5h83BbZMrAS8Rkjdu+6G4CM9b
         Idfckee0BvQ/tBykUtdfVJ1rhHFpFOCWvjikNzXPbj9rwrRSR4X/CD+yxZgEd0+MT1iD
         Aa6Djlp8Y5bqe8dgo+gDDuGg2aZ8BJpfMOOI0/lanjmPos04SqsS5lnhiJHKDyZ3JQE2
         n0TQ==
X-Gm-Message-State: AOJu0Yy8ovmml5bG5tBaarPgawJOibdmyje5mUsXTd9GrZCqYYLi4M3p
        6XFdJywz9DgGj7JhW5NqrOadkdHSizo=
X-Google-Smtp-Source: AGHT+IEoe0G3lfZ+S6iJ/h89zB0Ua7L9cZarWrRph2vnXHeRE/CtRQ66qXF2XkGtfLaMAht2qHgVtA==
X-Received: by 2002:a2e:8484:0:b0:2ba:6599:b433 with SMTP id b4-20020a2e8484000000b002ba6599b433mr643420ljh.25.1691646704943;
        Wed, 09 Aug 2023 22:51:44 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::5? (dc78bmyyyyyyyyyyyyyct-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::5])
        by smtp.gmail.com with ESMTPSA id r16-20020a2e80d0000000b002b6ffa50896sm188806ljg.128.2023.08.09.22.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 22:51:44 -0700 (PDT)
Message-ID: <cd99bd43-9876-9c07-217e-6547e2d8b5cb@gmail.com>
Date:   Thu, 10 Aug 2023 08:51:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 7/7] iio: accel: Add support for Kionix/ROHM KX132-1211
 accelerometer
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1691607526.git.mehdi.djait.k@gmail.com>
 <a430f5f387991e11079393eba6544e4635c7c091.1691607526.git.mehdi.djait.k@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <a430f5f387991e11079393eba6544e4635c7c091.1691607526.git.mehdi.djait.k@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 22:11, Mehdi Djait wrote:
> Kionix KX132-1211 is a tri-axis 16-bit accelerometer that can support
> ranges from ±2G to ±16G, digital output through I²C/SPI.
> Add support for basic accelerometer features such as reading acceleration
> via IIO using raw reads, triggered buffer (data-ready), or the WMI IRQ.
> 
> Datasheet: https://kionixfs.azureedge.net/en/document/KX132-1211-Technical-Reference-Manual-Rev-5.0.pdf
> Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> ---
> v7:
> - added a min_t in kx132_get_fifo_bytes to ensure that we don't that the
>    fifo_bytes is never bigger than the
>    fifo_length * KX022A_FIFO_SAMPLES_SIZE_BYTES - no matter what we read from I2C
>    as suggested by Matti

Thanks a lot Mehdi! Looks good to me :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

