Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A977DAA73
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 03:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjJ2CML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 22:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2CMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 22:12:09 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F070B8;
        Sat, 28 Oct 2023 19:12:07 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-581de3e691dso1975132eaf.3;
        Sat, 28 Oct 2023 19:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698545526; x=1699150326; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y2Y1d8nePAl7fO5QsXvyHc6h9sOCIWDjlfedyMENuIc=;
        b=AasFdDUhjTtIdQdNsM/Di95gRa99hBx2cQ013tD7XweSJH8gnAxu2rTndU3zyIpPj3
         mhBZ96UGMJa7L/MaOVqiy6LV1sVvhW/dDpIWtV426YBWBvZZTiOHHwiKfYfxASfQGtd0
         j0PfU1p4osS7Q3lpAwnRJaM/E/bYO76psPScyH4vR3ZiQ3xJQPQu4LE4FXASXB9Bl4eF
         btQKG6wnn2hBlhWTycYdArGcRXDXrHJcM+nXj6b0WW5MkJnK8TFDDqXpcg3QHdvTdAIy
         alP7ToIzgYyUB6vY3bhRFkYvptaDn9/WUwyGYBt9n6NR6NJ+wGzKEZRxYX4jMlKW6Amj
         ioCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698545526; x=1699150326;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y2Y1d8nePAl7fO5QsXvyHc6h9sOCIWDjlfedyMENuIc=;
        b=FjUb6c7sm707CSdYur7X/Kbyot1mgJzcTPyzK5Dkht/gDgaWXebhpja1N1J6kNBrwc
         AkspU7xgM34oozXYMllHAVxV4qZiONRn4BO8/pKtvjUBCwu+EB7qqw9Pk7yZVXT46tj+
         X1Q4upGpwUyYieS/jiZvLEpNmtgYO9UOWk6BqC99vBjnuADOj2Ge0n6gLsSwpCPxQ+aC
         g0wPzcNsXNiIj3da55iJ7gmTWidgAfCnoc7i7Auctl1zY+E3BlFpu5GZS48f1HeM4ELT
         Fx6C29+yk3ONo68xDTpdk9eQwPfwfHk+WLg+AK7KBfcyyKtvFPpV85IkEufzvAu3fa2O
         EJww==
X-Gm-Message-State: AOJu0Yw9buAQPLeznOoV8+z5xKTvenqrMobyXhMFX10pdxpGw8uCSqXK
        UKTK9/309MqMBxKS02+9cPEbg3mMB1U=
X-Google-Smtp-Source: AGHT+IHWdOwO5H9afje5/FUl0swZ2f8PT5tmE2MjYebsTpkRnn8EyT1taHcvEcWwtmauRid5Vk5zpA==
X-Received: by 2002:a05:6358:52c1:b0:168:d2b1:6f58 with SMTP id z1-20020a05635852c100b00168d2b16f58mr10176969rwz.22.1698545526346;
        Sat, 28 Oct 2023 19:12:06 -0700 (PDT)
Received: from google.com ([205.220.129.30])
        by smtp.gmail.com with ESMTPSA id 34-20020a17090a09a500b002804af3afb7sm200800pjo.49.2023.10.28.19.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 19:12:05 -0700 (PDT)
Date:   Sun, 29 Oct 2023 02:11:40 +0000
From:   "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
To:     Abhishek Kumar Singh <abhi1.singh@samsung.com>
Cc:     "robh@kernel.org" <robh@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SRI-N IT Security <sri-n.itsec@samsung.com>
Subject: Re: [PATCH] input: gpio-keys - optimize wakeup sequence.
Message-ID: <ZT2_XI-6D24gjbrO@google.com>
References: <CGME20231017103415epcms5p2f8f5b28a8f5d71055622b82f71b0fc93@epcms5p4>
 <899376598.3134980.1698299600677@mail-kr5-0.mail-kr5.knoxportal-kr-prod-blue.svc.cluster.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <899376598.3134980.1698299600677@mail-kr5-0.mail-kr5.knoxportal-kr-prod-blue.svc.cluster.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On Thu, Oct 26, 2023 at 11:23:20AM +0530, Abhishek Kumar Singh wrote:
> Dear Mr. Dmitry,
> Greetings!
> 
> 
> The patch removes unused many APIs call chain for every suspend/resume of the device 
> if no key press event triggered.
> 
> 
> There is a call back function gpio_keys_resume() called for
> every suspend/resume of the device. and whenever this function called, it is
> reading the status of the key. And gpio_keys_resume() API further calls the
> below chain of API irrespective of key press event
> 
> 
> APIs call chain:
> static void gpio_keys_report_state(struct gpio_keys_drvdata *ddata)
> static void gpio_keys_gpio_report_event(struct gpio_button_data *bdata)
> gpiod_get_value_cansleep(bdata->gpiod);
> input_event(input, type, *bdata->code, state);
> input_sync(input);
> 
> 
> The patch avoid the above APIs call chain if there is no key press event triggered.
> It will save the device computational resources, power resources and optimize the suspend/resume time

Unfortunately it also breaks the driver as button->value does not hold
the current state of the GPIO but rather set one via device tree so that
the driver can use that value when sending EV_ABS events. So with
typical GPIO-backed keys or buttons you change results in no events
reported on resume.

I also wonder what kind of measurements you did on improvements to
suspend/resume time with your change.

Thanks.

-- 
Dmitry
