Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4C27CC3B2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343611AbjJQMzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbjJQMzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:55:22 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26511F1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:55:20 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7b6b4c2f1a0so530117241.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697547319; x=1698152119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLLvSBwIjtShz33SHc8amiPKaUDBrwQERh0Pk//Em8s=;
        b=cjUZixZJJdTGNpuhC+V1f7YJzNqeMgIGBYDXj/i7Y0PU9vqLydHO4h5nzExCt4EcBm
         3J9lZJANuuIM5Sl4EOkbG5D/YpPZBgfB+eyLj/UtODRO6M0/slMce/YikEfm3f3o2e40
         M06b1NuY3btmDm2A+359SjIXSevDn8Rk/sZsdaCvDCSNJ/E55mf8Wto3/slX6ZGl6O/y
         VkOHL9E4NpUJ9k3iFCroXrR7ZnFG4iQ9g1CT47HrCkfPqOSBFE01hcKos+U4HU/0M4VA
         ecec6boPdYia8Ay2AziHfGXjlgOrSNSxxG6Pcj/4PRkL5jxmShPT4O0JaGPPv3uzc2Gx
         zeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697547319; x=1698152119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLLvSBwIjtShz33SHc8amiPKaUDBrwQERh0Pk//Em8s=;
        b=Bs1BvFhhBwjF+dOfk6lqYMWV4bXc3oMchcXSltG9XzFaO3cf0cVwb50LBTOZ7JQmSH
         bwRFVAQQFLwW+FdXFdsQn5ho5345tmvUMN1zaa5xu9HvD/mReRoxxkYrDiT5WvgsMRiy
         TkIMHVWOfy6ulcWh9WCKUAaYEqIvcwWLfYHYiVLNtP2dmRLm3gOUNVk4Ot/M3rTfZ4f8
         f8Kx5SuZRsG2cYTdJq/LartBQcj3KVA1jMbFnhXeudfIC72Spyn3n08581mFfCBUwcoB
         FUGX2a3ohYgLMcLUfqcdzkD+ASz0VdB3yIiRcIDGuWpd2T4GfNWMEFuIPN0Vof2JF82H
         mIdw==
X-Gm-Message-State: AOJu0YxEMpXqkz4bFYEhNArO6B4hjI7YIox/TucuLhtBUf5nkXFsSTX5
        /0RwtFIKcfU6HSukepq3ZRzyqDPIJyFUq9cMrFoiag==
X-Google-Smtp-Source: AGHT+IFwm86JGxSpXxk31gjh5RlEFjhjv6kBGFZEUZisgq1Yr31OsUDkHao7TTCPM2I8PxPWIlOouCLECr9agZirkQc=
X-Received: by 2002:a67:e195:0:b0:457:6858:af77 with SMTP id
 e21-20020a67e195000000b004576858af77mr2089439vsl.26.1697547319115; Tue, 17
 Oct 2023 05:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231017120431.68847-1-brgl@bgdev.pl> <20231017120431.68847-55-brgl@bgdev.pl>
 <ZS6BAkfFeA+6GYfz@smile.fi.intel.com> <CACMJSesgT-a8krB8gvf0gJ-C+p6s1TdRcE6W_42CxR9bDvrGHg@mail.gmail.com>
 <ZS6CGcRPNzkCdnoD@smile.fi.intel.com>
In-Reply-To: <ZS6CGcRPNzkCdnoD@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 17 Oct 2023 14:55:07 +0200
Message-ID: <CAMRc=MdbYN+ropwecPbTptV7KEt-0NdWOHn1Uq_2dgWcPv-D=A@mail.gmail.com>
Subject: Re: [PATCH v3 54/73] pinctrl: intel: drop the wrappers around pinctrl_gpio_direction_input()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
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

On Tue, Oct 17, 2023 at 2:46=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Oct 17, 2023 at 02:44:25PM +0200, Bartosz Golaszewski wrote:
> > On Tue, 17 Oct 2023 at 14:41, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Tue, Oct 17, 2023 at 02:04:12PM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > pinctrl_gpio_direction_input() now has the same signature as the
> > > > wrappers around it so we can drop them.
> > >
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > Now, for the sake of symmetry can you add (at least to the all
> > > Intel drivers you modified in this series) the following:
> >
> > Good idea but this is v6.8 material, I don't want to extend this
> > series anymore at this point.
>
> Then let's postpone at least Intel and Cypress patches after v6.8-rc1 is =
out.
>

But then we'd have to postpone the renaming and we'd be stuck with
both variants in the tree. This is suboptimal. We'd also have this
huge series spanning two subsystems for 3 months during the v6.8
release cycle in the tree causing conflicts and other issues.

I'd prefer to merge this during the v6.7 merge window and then we can
keep on improving it without affecting both trees. Linus will be
taking those subsequent patches as usual.

Linus, what do you think?

Bart
