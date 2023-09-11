Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1031A79A40B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbjIKHBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjIKHBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:01:37 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA1B9C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:01:33 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-44e8f9f3cceso1549914137.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694415692; x=1695020492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svb0mb8MQOruz1KOdHSc0iLmRHYISFRblFvwMP8MMCA=;
        b=wRHtnZt0inJsocKpMU14duWx5iYG7rgPaZJGlz9YCo7pW2FcWMwse42uMEmWDkwfZs
         26c0eza2fSnsG9QgMav/Wks6/WZVQDShCifv+PXdvvW23aB9NsPdGtjAyRq7RmQnymyk
         JD2cJ4Yuq2oN7pBJCWMjQzBt3PW7kS9JskTqexKgNY+QOnRoE8cucBGTrO/dBzLgSxFP
         gAgdUgrQgwpKMO9Q7rQ2GLkKMmzDYf4q4Zx0FIAArTLBmPgKuz2jW7ttecRyuqBW6GeU
         2CLDZ3Kw5m1jkfmqzPefy/MAIEDnOLf3TFerBK1iiNdA39fN+n27HkvPFRVOdGKDizY2
         yBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694415692; x=1695020492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svb0mb8MQOruz1KOdHSc0iLmRHYISFRblFvwMP8MMCA=;
        b=avZGfGWWkolZgbbmozqTbmSt1jgNiJVJ7cZNjYjh9daOJRXFEVL0FCmfyIdRsu3FYs
         TUjtgaaSUrkMXKIAMSlrnwkQF13Ggok2AN+oFuqo7s8MZ16d6lL3hYW8HH4Egg/JV+fY
         s2xZmljmG0j5km3iTycC8zdcxKUqlT+tWJ5y4kIoIZIDCI4o5hfH54W6EJStejj1FAUy
         a0M/cHyBJA40O1FR6VGI738Mbcmdo9hRemNCe655eGiCmUc3u6e5lfI/6h3ZvelWu+i5
         CFcHiIUlm6+MIuga8nfwLPQX1fOg6w7SQPMcYeyQJ8D9FCMQdH30F9/Ix8JVmugodJdU
         if5w==
X-Gm-Message-State: AOJu0YzYAbYziGOw2RCllHU+zEAW2oKdj1ZPc07dEbaFNruNDzsVHuou
        lxyJSxQJBDlzxGo+m65116zyHbIskVDgb+t5kX/E/aAFRdtfU5Rr
X-Google-Smtp-Source: AGHT+IGAuGXPWu2uJDUfPZR9Q2dfd2onkpkyN0TpeO3+eossuJ/00/HLDRw4Ufy4jwhHAQOzH0ej+lijzE3BbVA/cCk=
X-Received: by 2002:a67:ecd6:0:b0:44e:a79f:6844 with SMTP id
 i22-20020a67ecd6000000b0044ea79f6844mr7772357vsp.6.1694415692549; Mon, 11 Sep
 2023 00:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 11 Sep 2023 09:01:21 +0200
Message-ID: <CAMRc=Mev1-NyanVGrha8Gz+yWs_RCcANL1HcJq0dBmdWo9k42w@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] gpio: pca953x: Drop unused fields in struct pca953x_platform_data
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 1, 2023 at 3:40=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> New code should solely use firmware nodes for the specifics and
> not any callbacks.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Series applied, thanks!

Bart
