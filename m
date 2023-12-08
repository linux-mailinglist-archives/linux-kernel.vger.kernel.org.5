Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383CF80A4BF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573859AbjLHNuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573849AbjLHNuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:50:23 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C953F198C;
        Fri,  8 Dec 2023 05:50:29 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6cec976b197so887986b3a.0;
        Fri, 08 Dec 2023 05:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702043429; x=1702648229; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w05jcvJbftuz+V4PIwlumxl68ycFODGUFJ//SIJMXoc=;
        b=akAduOxGieGm14GFaa/A4ucqm7QvDyaQULiMFmh4yFOPUP3brtqVBuz27VcCSYXDF8
         bI6ZGC6czjXfWCjnpGLgwqpqoJX3noUrkQLLHM8zq3yFbA2WJVADm06I40WDiXHEqWfl
         S8eU/HGZePZSlgim66gvHu9cyIdViVB5JSEnCSXTSxC1rv4PYMc0PdyAAaLucmuzocUt
         1ct4fp3HDh9WyxyIlXb4GpKkFerXZAVx2KbGLfAU6mCiGbeezPxU2Zz28CCNkh9BNbrE
         Uj5s/JeNz8z0cmwm8p6btRYz5FaIAVKg2BL8MZoEU0Vz6tMKXK0LlwONvZPmUtRAgUoJ
         7m6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702043429; x=1702648229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w05jcvJbftuz+V4PIwlumxl68ycFODGUFJ//SIJMXoc=;
        b=p2ZFSbBggPI9uAafEWJpBOEuNgzGCP8dZHwvwZyeE8dTFVJTWM7fWUZpj6mk8axlTz
         tE3IR7TJ0Rgvooqj3LTLNv1MIIa85tfJkj+Cm2bHuB8qRJKW6SqJD3bYIBZMDP4nW7Fq
         ECq1cQqvCpYDYX64hOBJ3OziqzU06fm3JoEBVi6yz+FM1NkgsUs8NagggFvn+zwdBroe
         VECMWSABK/Vx/xo7sfTrZiSAm/JOHw8Rf4a5wIaOjd6FvUnFpytALOf+4YPJyM63EX44
         g7EFVAM53jrHmlC1uHekAzTiyhphN9U3s2rUNlceXpZ0M0AHWzT4N4UPZ39v3bVY7nGf
         EXoQ==
X-Gm-Message-State: AOJu0YxJBw7Z92CQjIhGe90H3zOfFFy/bR9SO+UsF2nWQJWEXbwO0EDq
        2kX7RLGaD/d7ZzcvSB6uVas=
X-Google-Smtp-Source: AGHT+IG6p9qYniWsOOxCuS7btrPvaasfWo06OhsJ23v6Z7ooK2KImNZUSYg6Z+ZXjnX1zG5bicXbEw==
X-Received: by 2002:a05:6a20:3ca1:b0:190:55ed:c42 with SMTP id b33-20020a056a203ca100b0019055ed0c42mr39843pzj.63.1702043429043;
        Fri, 08 Dec 2023 05:50:29 -0800 (PST)
Received: from localhost ([2804:30c:95c:8600:5b2d:e35b:5f45:dc84])
        by smtp.gmail.com with ESMTPSA id d3-20020a056a0010c300b006c0316485f9sm1583704pfu.64.2023.12.08.05.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 05:50:28 -0800 (PST)
Date:   Fri, 8 Dec 2023 10:50:15 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     David Lechner <dlechner@baylibre.com>
Cc:     Marcelo Schmitt <marcelo.schmitt@analog.com>, apw@canonical.com,
        joe@perches.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        paul.cercueil@analog.com, Michael.Hennerich@analog.com,
        lars@metafoo.de, jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dan.carpenter@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/13] Add support for AD7091R-2/-4/-8
Message-ID: <ZXMfFxEckIm_cFPJ@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
 <CAMknhBFPbAqp4-AQdmbp+VRW-Ksk1PxaLCG+3n=Zk4gyStqhgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMknhBFPbAqp4-AQdmbp+VRW-Ksk1PxaLCG+3n=Zk4gyStqhgw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07, David Lechner wrote:
> On Thu, Dec 7, 2023 at 12:36 PM Marcelo Schmitt
> <marcelo.schmitt@analog.com> wrote:
> >
> > From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> >
[...]
> >
> > I see regmap's interface for reading device registers under /sys/kernel/debug/regmap/.
> > I can read all registers but can't write to any of them unless I force define
> > REGMAP_ALLOW_WRITE_DEBUGFS.
> >
> > When testing events for this driver I often write to device registers
> > to set different rising/falling thresholds. I do something like this:
> > # echo 0x17 0x100 > /sys/kernel/debug/iio/iio:device0/direct_reg_access
> >
> > I tried read/writing to files under iio:device events directory but always
> > get segmentation fault. I must be forgetting to implement something.
> > What am I missing?
> >
> 
> It looks like event callbacks (.read_event_value and friends) are
> missing from `static const struct iio_info ad7091r_info = { ... }`.
> These callbacks aren't checked for NULL, e.g. in iio_ev_value_show(),
> so that is likely where the segfault is happening.

Hi David, thank you for pointing that out.
Will implement those calls in v4.
