Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5E27C497D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 07:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344178AbjJKF4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 01:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjJKFz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 01:55:59 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD638E;
        Tue, 10 Oct 2023 22:55:58 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66ceef95b89so10170236d6.3;
        Tue, 10 Oct 2023 22:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697003757; x=1697608557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTjpQvyMHkbUpLu3ihyopH9dpMDT8ryAdeqR+3nM3c0=;
        b=OLPtboIWHO20M6k/i2vUhscVgWm+Ft3DbTQ8YVmpUCPrddwgoGU6tPM0AzxNjU89Tc
         hIMXF61k/RvC4O0LaggYNkBPMP1nJHT0Uy+KFJp06ifjLZ8MTzaKjOKpM3v5Xk8wqcIZ
         TxwcnMxRT4GBxMDRZ1sRqGb+bzoaRFo20l96TTX6t08xZEdVXVFO9mwaNm/wdq8rnIYl
         kFFl37ki+eog1q5X99UdPJoeuRdGOFI/tnnDFyuJe9XH+hKhupkwtOzqO7euSHcvovP4
         mldgWmEtXywS06AX+g7PgbCObDBVK8F8K2QGBVQ+RDxAmfCRcLLri2nb18Yf/mzdFlMx
         bn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697003757; x=1697608557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTjpQvyMHkbUpLu3ihyopH9dpMDT8ryAdeqR+3nM3c0=;
        b=a7Fe6EfC0Qevo6Eaxg3nGTl9P4E4zTuKvpQ9Rs6LSJieV57DdywaQF5zL6Z8ksNCMo
         CnnGR23tvo5FFrsCByrKgwsZXHQ3hQjKveUNhK7TW6Gtd10uBuU4pFeysgoAYo1F7gXo
         0tlB56D8/+kmIwaOOEuZ8tUr0MfQR9RdaxI3IRYzaL2TEpY+eyNrcsZMPNP7NJ5dDTFE
         3VTp0PPmM3AUZb5j/qIfoP0i4yU/g+JIgq5ZBD3zvq8XWYFloQbLN6/IoOTBCB88fv3R
         CXrzvyNcjTwXfrjOBCiTu05J59G0KmaPeAKlBEp37dOOdY5mmgUYLf2GN8OVzEAIeRlF
         da4A==
X-Gm-Message-State: AOJu0YzQOoVMrUz14mh85LgUErODsta1dYqHARZtyG5bKXMneVHoxqjV
        R60TUoD4rAANBS2ZgrTGhVFm2qctSdNfLD4YxF0hLAMqS9Y=
X-Google-Smtp-Source: AGHT+IFIeFo8MDm4RDbVOvfQd2TQwRCkzHVhlunlbXpiCiir1RpoyTNxTr2ClGYp+hsDBzw9ZQx44MeKbyGLy1S7+ew=
X-Received: by 2002:a0c:f194:0:b0:66c:ff4f:a35f with SMTP id
 m20-20020a0cf194000000b0066cff4fa35fmr3144687qvl.51.1697003757216; Tue, 10
 Oct 2023 22:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231010151709.4104747-1-andriy.shevchenko@linux.intel.com>
 <20231010151709.4104747-5-andriy.shevchenko@linux.intel.com> <0db37cd0-9cb9-41bc-c2aa-0a01c0295ed0@nvidia.com>
In-Reply-To: <0db37cd0-9cb9-41bc-c2aa-0a01c0295ed0@nvidia.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 Oct 2023 08:55:21 +0300
Message-ID: <CAHp75VcRKnWRNxTafsG2f+tWrF-6yQjECLpyn_S-VK78SfL8VQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] hte: tegra194: Switch to LATE_SIMPLE_DEV_PM_OPS()
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        timestamp@lists.linux.dev, linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:36=E2=80=AFPM Dipen Patel <dipenp@nvidia.com> wr=
ote:
> On 10/10/23 8:17 AM, Andy Shevchenko wrote:

> > +             .pm =3D pm_slee_ptr(&tegra_hte_pm),
>
> typo, pm_sleep_ptr instead?

Indeed. On my x86_64 this code slipped from compilation. I will try
harder to compile-test it next time.

--=20
With Best Regards,
Andy Shevchenko
