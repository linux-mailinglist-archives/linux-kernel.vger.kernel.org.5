Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0233794510
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244779AbjIFVY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjIFVY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:24:58 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BCC173B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 14:24:55 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6befdb1f545so241073a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 14:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694035494; x=1694640294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWC0scYfUcpjGiaSYDl8OTHYYNTx4MVTsQ/udlg5YMc=;
        b=t9FFcO4/Bi1wOZlcuwaJP82na8lU8yruTMEx4uoWdhz/e4JJKo2VNQf3rhtO40BqKd
         IA0g1unHNwQYiCEQYVhEASyWms1wn2iYM6reC98e+115PDQAU0okcCaAjwMnqWZ0jLlk
         UX+b6UD6CGTXcdhpz5+mqP7M0hn4OLa4udU0kyN1st29JwN+NcaNCRtN2Yw0OJYQAWBP
         zjmKFRK5UA26m+04fAbGjjJHzYXlMLLoTIKFMHgQKSkreq3tYlfvxcwV0x7S/YwBXCav
         E5HA3yy1srtgPebfiuSRcXjS/fiGLQRiEn7oCl6xjKjEyNVPGCVuDirYWtYOzemGaxKa
         luxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694035494; x=1694640294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWC0scYfUcpjGiaSYDl8OTHYYNTx4MVTsQ/udlg5YMc=;
        b=ZUkIURo8f4FukgWqwWUdAceofRZQYAuoNbFdxCaPkdiwaVw+XVadkigZlZcGQL1p2J
         jtYv+MrFXG7osx21stA79Fad/1V1pYVXLZinS+ssadBQ8hl2C1pVT3Bm0U5qA4Y9REdL
         wHcr3MFfvKLH0pcHoFxFLcDKDBmQ3z6CUHxEUPeYw7gRgO/julBA0aO2S8w7vU8JrIXd
         R5tm6CFL5zLMGxp9Acn5k4VbEx1dTeqmkzhLhIs6mdZ+DVmu6REYsI/FiFjsZqi+ayLw
         E/Y+jjCae8+lSDyq/J41nBtrjbI6jodPCppPq8d3OhryRNZViMP1xUJCf4sKy1PJYp9f
         1DXQ==
X-Gm-Message-State: AOJu0YzivszuGUS67PLvwG1C2yTXZ+4cjoUsPZ98U7lzb1mwERI6fdpX
        Y0acQfxqrO2JbF6SkJU+YeLXkgKM31UoVwzDCw6JZg==
X-Google-Smtp-Source: AGHT+IFPsVndCeBo40u3rX9JIqhESaxWN53EdxLX74lsEc8fthP0isEFqBZ6PGo9Hmx69vN8M2MdelnkfIsuURtvkAg=
X-Received: by 2002:a9d:5c83:0:b0:6b9:b096:2617 with SMTP id
 a3-20020a9d5c83000000b006b9b0962617mr2966540oti.14.1694035494341; Wed, 06 Sep
 2023 14:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230906142357.138846-1-brgl@bgdev.pl>
In-Reply-To: <20230906142357.138846-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 6 Sep 2023 23:24:43 +0200
Message-ID: <CACRpkdZ86dery1k2Wh-Kxy8L3Tc=W+G=RGY5kAirDFXVrkML=g@mail.gmail.com>
Subject: Re: [PATCH] gpio: xgene-sb: don't include gpiolib.h
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 6, 2023 at 4:24=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The gpiolib.h is unnecessarily included in the driver. None of its
> symbols are used so drop it.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
