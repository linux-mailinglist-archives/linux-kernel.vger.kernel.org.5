Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4207D823A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344852AbjJZMFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZMFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:05:36 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B67991
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:05:30 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6ce2988d62eso482857a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698321930; x=1698926730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOM36eG6x55qm5hFHiPcwx8zvGUUpSK0/o99XjcsvCc=;
        b=cjR4vBpE6iysT32K/U0mxIiXSFGJNSDvCj00liuN/SC5nlmF8E/z2BEvz/A1mp0jPL
         cym+S1MDe2hf0M6MkyCMGfoTYTF7Kmi3xacB0gTofkk6/9mmYjA0lhSP2aXhbHKnqq5L
         Y/v2Z2O3NySdnCQnD10ipO63NrL4sl4x5LdU1gouK0cm/e3ZxUvDtc2sahOt1GeMclqH
         aYfElKnZ6KZD0s3m62cfNVMCyv+q4ZOcHMaNv9xDeW3zf5QgF5OvMcs01UrZrXA0Cr5W
         4LyfFQDRX5nlZTVz0EmXJS453Vlz1rP2wHCjyKRjnyP5j/0pCRqoDwYLoiMxn53Iv0wT
         c0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698321930; x=1698926730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOM36eG6x55qm5hFHiPcwx8zvGUUpSK0/o99XjcsvCc=;
        b=mpAc/LCv2/IudkHxpv300L6+mxHOqigfmac0ssRqPHpNkHwwSUoWAkvCFcWPzeOl3l
         SKKoEIg3OTSi/2Mj5HgWzqSjUi27TnGsJqDKa507e2G0Qz+l199ghxFaEE8beziFOg0+
         5TF8jJs6vncU8UappJnF5oJBrTnCxQIen2fvVxm/pQSiwJ7Jyz8peKep7b1wvYUYDFWF
         Wwoeu2YA1oSNXDZnZLMMu+AhXKTU3IG1wxiCdRkTrDsY47PEroipnYUck9rDcc0m1S4x
         3F8U+oMi3S6tOnlD6K+xxAIuVYq/VdCR1uEv9X6btdHzU5Gf73aILDw3pEvofvtDDbbl
         mu6w==
X-Gm-Message-State: AOJu0YxgfyW3hKLd/MBiy2oTEmGgvnMjBZpZFs5z8MVBEPQNAOZbXxWh
        iG8KOLROYen6OZlhm2pFrbekqAkFbhIfjDJEMc4AdyWY7hcW5EQ7
X-Google-Smtp-Source: AGHT+IHp7bO2FdByca9u/F+zGBfnvtRjJaEuzVSihY2H7X5qenrgr+SbRPtZDA0+9PYxr6YEPjR52xAFVK9l4nEKhl4=
X-Received: by 2002:a05:6830:4117:b0:6c0:e5c3:40b5 with SMTP id
 w23-20020a056830411700b006c0e5c340b5mr22589652ott.6.1698321929778; Thu, 26
 Oct 2023 05:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com> <20231026-mbly-uart-v1-1-9258eea297d3@bootlin.com>
In-Reply-To: <20231026-mbly-uart-v1-1-9258eea297d3@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Oct 2023 14:05:18 +0200
Message-ID: <CACRpkdZgxjJMKgp+r3MZwEnYX2C3hvidaGYvdxV5rbQDCXfAPA@mail.gmail.com>
Subject: Re: [PATCH 1/6] tty: serial: amba: cleanup whitespace
To:     =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 12:41=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boot=
lin.com> wrote:

> Fix whitespace in include/linux/amba/serial.h to match current kernel
> coding standards. Fixes about:
>
>  - CHECK: spaces preferred around that '|' (ctx:VxV)
>  - ERROR: code indent should use tabs where possible
>  - WARNING: Unnecessary space before function pointer arguments
>  - WARNING: please, no spaces at the start of a line
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
