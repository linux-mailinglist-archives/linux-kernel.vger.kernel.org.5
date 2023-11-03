Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D837F7E00C3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344768AbjKCIwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbjKCIwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:52:13 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB9CCE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 01:52:10 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so2996643a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 01:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699001528; x=1699606328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J2vCG5mHhOCaw9ST5kIUq13V4AdXc1/qhYREyTIsghw=;
        b=YdblTpJtqCK6o3tAzVzWoxCQsn/TP8aGEgPu6ZVzR0f5TzoPZMnOkgRZKlIqKoQhRt
         GY1D+ey/XGUQG2tEUjz/x1tcenLrjMA1COwhZ6QL5nkDirJJJDvY2M4FHJxt1HEhHIwF
         VfQDoL6/xUGnYdCFTLqhpHqE+BMAJat0K6MhOIrSYEqksw+yZcxohYsvN/kP6+c8guxU
         KaRgcXp/EgsJuA9PKoaKSaBZAdp8IKGePHylEQcMOdlDNYIVoQFc3DF77U+nxTYC1Kg5
         PwqJhG7TYQchuA+KI/KAwo/Lx2Yjz6BEOAzYQMc+IZUWAogAR6o75vgRknTwGMV19C0Q
         T2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699001528; x=1699606328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2vCG5mHhOCaw9ST5kIUq13V4AdXc1/qhYREyTIsghw=;
        b=Wi0r75Tno2UytRPIH1C/l17VAp7xVxPQ026iTjwvk+N3oKAviqJUS5+w5XK9C8tbll
         56Io/FIZQtdy+vv6/DYxP8TRhQL46KCcEqYLqyAUN7ELi8Mx4DFdGR7/pDzIg7+iF8s5
         WVPk9SaKi1tVEde+8ez3/+4g1TwAz0jBCeQtpxSHPnjZrcXic+K7x5Vb3q3THqgvgd4G
         V+xcVQ/26wuuqO9xEzthDFmkJCv3TO9DZHA5nz+usaYad8SJ5CPn8NNpf7Rt0X0atZUL
         AEU6HmMIjkYSNyff25E8/R+8j+Is9u2aougyGpJ/m7bvlY8eeZuXXzdlz9fIAJMGAKoT
         EiAg==
X-Gm-Message-State: AOJu0YzKd+z9gkN2MVoYJFchSBdOaC0Vuosm6v17Fdn8bMwLZdwo5P0+
        fFG7O2da5A9tp8kipZ9pyfL/+5eN5mPxPsR487I=
X-Google-Smtp-Source: AGHT+IEeRAxiHfw+yZjhXMED0UySk0L9vBsSfAwxtfBJLEciIW+iAJIktS04xY2prk4fdOitHE6xww==
X-Received: by 2002:a17:907:1ca7:b0:9c4:344e:b496 with SMTP id nb39-20020a1709071ca700b009c4344eb496mr6390049ejc.11.1699001528497;
        Fri, 03 Nov 2023 01:52:08 -0700 (PDT)
Received: from [192.168.1.70] ([86.71.62.58])
        by smtp.gmail.com with ESMTPSA id go8-20020a1709070d8800b009dd4b2d412fsm214837ejc.36.2023.11.03.01.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 01:52:08 -0700 (PDT)
Message-ID: <b9449689-73da-41a8-a94e-f82686ab0bb0@baylibre.com>
Date:   Fri, 3 Nov 2023 09:52:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] TPS65224 PMIC driver
Content-Language: en-US
To:     Gairuboina Sirisha <sirisha.gairuboina@Ltts.com>,
        linux-kernel@vger.kernel.org
Cc:     lee@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20231026133226.290040-1-sirisha.gairuboina@Ltts.com>
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20231026133226.290040-1-sirisha.gairuboina@Ltts.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/23 15:32, Gairuboina Sirisha wrote:
> Added support for TPS65224 PMIC in linux.
> This patch set includes driver for core, i2c and pfsm.
> The driver was tested on TI's custom AM62A EVM.
>
> Gairuboina Sirisha (3):
>    drivers: mfd: Add support for TPS65224
>    drivers: mfd: Add support for TPS65224 i2c driver
>    drivers: misc: Add support for TPS65224 pfsm driver
>
>   drivers/mfd/Kconfig                |  19 +
>   drivers/mfd/Makefile               |   2 +
>   drivers/mfd/tps65224-core.c        | 291 ++++++++++++
>   drivers/mfd/tps65224-i2c.c         | 245 ++++++++++
>   drivers/misc/Kconfig               |  12 +
>   drivers/misc/Makefile              |   1 +
>   drivers/misc/tps65224-pfsm.c       | 290 ++++++++++++
>   include/linux/mfd/tps65224.h       | 735 +++++++++++++++++++++++++++++
>   include/uapi/linux/tps65224_pfsm.h |  36 ++
>   9 files changed, 1631 insertions(+)
>   create mode 100644 drivers/mfd/tps65224-core.c
>   create mode 100644 drivers/mfd/tps65224-i2c.c
>   create mode 100644 drivers/misc/tps65224-pfsm.c
>   create mode 100644 include/linux/mfd/tps65224.h
>   create mode 100644 include/uapi/linux/tps65224_pfsm.h

Hi Sirisha,

These drivers strongly look like TPS6594 drivers.

Instead of submitting new drivers, you should consider reusing and
modifying the existing ones for TPS6594. You might add your new 'compatible'
entry ("ti,tps65224-q1") in TPS6594 dt-bindings (see 'ti,tps6594.yaml' file)
to identify your TPS65224 PMIC. This new 'compatible' would also be added
in the existing 'tps6594_i2c_of_match_table'. You can have a look at
'tps->chip_id' in 'tps6594-core.c' and see how we use it to deal with slight
differences between different PMIC IDs.

Julien
