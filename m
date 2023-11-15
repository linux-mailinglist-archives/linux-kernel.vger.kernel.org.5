Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5267EC67E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344272AbjKOO7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjKOO7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:59:09 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C9C8E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:59:06 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7b6cd2afaf2so2738551241.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700060345; x=1700665145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3OrBniBax6aBFZKFMUfvMbREKJHYn5D4TcXhxSLl7M=;
        b=DdTd3LI+Yn65C+0h4rKSKCDaFeW8m7PPrmz1QPKfI3PEAZUKENGq+zi3oQJhGboMnd
         q2Auljshyc8h1RxhcDkSdFPxfFDB9hoN+GKTKrULuNnxjQ8qG9vHRFiglK+rklRjUa/k
         YvbARqaWQfNYxJKP3mOqcap/C1a22F6j6wehIMAAh1J209JMG1aOIrhtUx8d+26VDW1I
         9GYkNYWqTA3Er+bTOjYXGf86eIN6sWjycZFf7mbQI+x657s+phhzzwDMmVa/YTgNxd3d
         Wy5V3S6GEqu2vMIA5iaTxtnEw78ZE8Ni2AIrlcPO36Zec1SBLp6feJRAzlUpd9N2gzWM
         4esg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700060345; x=1700665145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3OrBniBax6aBFZKFMUfvMbREKJHYn5D4TcXhxSLl7M=;
        b=VUCCvxAU8e9SwnpJ/jXaKV1ofxmDo1Go+HCQJEwlXKqMsfjHXOellCT7/EZlLC0pWG
         Y2lBkOHFTSQMfzWs3fvXrQCid8QeFZc1ZEM59g0L6FwHzNCmBMCizsAh2N4xScyQ8mcN
         Pyr8kFFx4jf4MA1vRLocA0gv8fzzNp+2E8QTf0AIVBp0PswCy44hBaJiSgKW44v6f+qf
         Yx41HjmqGwUEOezVDt8i0AyGds9EFZTq/aialzUBST/kzB1BvtWgTKt37ZsDSChyPwPP
         ZBkS1g/e+DTK3AN/nXfvBYCg965UlHU+hMxEY4KJFJX4bBarKYGIqgPzvnl9IRC1rE5r
         HVLw==
X-Gm-Message-State: AOJu0Yxo5JlmkK/S4nbWFnIhVemF8uJ1yUOwT0C7y5a8p7kZB0qnD9bv
        MJIbkFLLJawqRppXp9VSBD8+LTBsXq3aJvfrV+ZRrw==
X-Google-Smtp-Source: AGHT+IHtSbrAOce7kh6Al+4OKo3Q8n54AV6TLGvDzbUXO/PGYI9Ce7LXQovvwPec+z3aHpZOCddDdLn/i88HYPXTykc=
X-Received: by 2002:ac5:c978:0:b0:4ab:fbff:a811 with SMTP id
 t24-20020ac5c978000000b004abfbffa811mr11781567vkm.14.1700060345256; Wed, 15
 Nov 2023 06:59:05 -0800 (PST)
MIME-Version: 1.0
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
 <20231025184259.250588-2-andriy.shevchenko@linux.intel.com>
 <2023102624-moonshine-duller-3043@gregkh> <ZTpbMVSdKlOgLbwv@smile.fi.intel.com>
 <ZUPBVMdi3hcTyW2n@smile.fi.intel.com> <CAMRc=MeV9ZyOzuQFEE_duPTHYgfmr6UZU6bpjDPhrczZX4PHpg@mail.gmail.com>
In-Reply-To: <CAMRc=MeV9ZyOzuQFEE_duPTHYgfmr6UZU6bpjDPhrczZX4PHpg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 15 Nov 2023 15:58:54 +0100
Message-ID: <CAMRc=MdSpk_OszeDCyA5_Sp-w=sL9DHB2gGCOFP+FCiobm2cbA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] device property: Implement device_is_big_endian()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 10:08=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Thu, Nov 2, 2023 at 4:33=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Thu, Oct 26, 2023 at 03:27:30PM +0300, Andy Shevchenko wrote:
> > > On Thu, Oct 26, 2023 at 07:25:35AM +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, Oct 25, 2023 at 09:42:57PM +0300, Andy Shevchenko wrote:
> > > > > Some users want to use the struct device pointer to see if the
> > > > > device is big endian in terms of Open Firmware specifications,
> > > > > i.e. if it has a "big-endian" property, or if the kernel was
> > > > > compiled for BE *and* the device has a "native-endian" property.
> > > > >
> > > > > Provide inline helper for the users.
> > > >
> > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >
> > > Thank you, Greg.
> > >
> > > Bart, would it be still possible to take this into next?
> > > I would like to have at least this patch applied (with the first user=
)
> > > to allow conversion of others (I have some more users of new API).
> >
> > Okay, seems we missed v6.7 with this, can you then prepare an immutable
> > branch / tag with this, so other maintainers can pull in case it's need=
ed?
> > (I have something against tty already and perhaps something else, let's
> >  see.)
> >
>
> It arrived too late in the cycle, I needed to send my PR earlier this
> time as I was OoO this week.
>
> Bart

Greg, will you take this patch through your tree and provide me with
an immutable tag for this cycle?

Bart
