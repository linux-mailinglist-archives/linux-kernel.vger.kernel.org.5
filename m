Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9638D811696
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442231AbjLMP1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442722AbjLMPZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:25:40 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02A2170E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:25:19 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a22f59c6ae6so136638266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702481118; x=1703085918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFRmR5aw7jYs0R06huL/PXrkIxEyHWBggBrJG8pw4QE=;
        b=hrs33ROrSc2sU0QNmvaTu3fQxzgR5VWMx4F7VqhIRdA9e6ReJylEgkcCWd12CTzqyr
         LRyOP0OqbM8U/MOIa1eP0ih0xarwGsFQGSwLxBa9kGDTS2eHg8rXWm6GW8a0hBOhm2QA
         Mdy0RzI97dJGZTRLaDgZJrQ8qvTKQpd9ULYdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702481118; x=1703085918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFRmR5aw7jYs0R06huL/PXrkIxEyHWBggBrJG8pw4QE=;
        b=MZ541cOt7SB9DT3oBuSKoaVIB13LpqTYXdyBCpJCSSl5G6W3T5rQtV3PPgTp2Kg37t
         TTUjnNEpK56sDzpbqaeZmlvJ0mrAmKAZHdgSEmpZRHFm1XYajRvyvyYhwwzmkOGMSDJP
         D60HUeCEijgkvORFbmQWUeJmf1GhxZ4M8P41pEPhCQH+aSdK3RpjN1PalGRVX9MImtRW
         yELYbZDLtkntke3YFlbjwud9C4jCuXijpE0xb1gXNIidurnfQ+2oqWRBgnCm2TD6WGGj
         Ycujonei7qzv8ue771NagEIVpITm5ZGBJOXgvXF7KEIeOPlK4CGbHhcUA28EQ4RH6j/v
         Jx+g==
X-Gm-Message-State: AOJu0YyX/NEIALVipbHzErcGr3dgH1/a6K5ah8T15TfkxkhIDx4izQlu
        U8YqtRk9pHtLCafGfa7Taz3I9BD4/mmQ05SLKcCYcW7J
X-Google-Smtp-Source: AGHT+IHc/oP5kbuMqKfKY99ABm4qPljJtHWj1AUBeDWr803YBdY22ZOJS2MmsltQL6rsJY2+kDgPxA==
X-Received: by 2002:a17:907:72d1:b0:a19:d40a:d214 with SMTP id du17-20020a17090772d100b00a19d40ad214mr2715650ejc.224.1702481117908;
        Wed, 13 Dec 2023 07:25:17 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id cx7-20020a170907168700b009fc576e26e6sm7842301ejd.80.2023.12.13.07.25.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 07:25:17 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso11185a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:25:17 -0800 (PST)
X-Received: by 2002:a05:600c:3648:b0:3f7:3e85:36a with SMTP id
 y8-20020a05600c364800b003f73e85036amr401838wmq.7.1702480624929; Wed, 13 Dec
 2023 07:17:04 -0800 (PST)
MIME-Version: 1.0
References: <20231211182036.606660304@linuxfoundation.org> <ZXi9wyS7vjGyUWU8@duo.ucw.cz>
 <a6af01bf-7785-4531-8514-8e5eb09e207e@roeck-us.net> <ZXliuTqyO_IjlIz7@amd.ucw.cz>
 <2023121342-wanted-overarch-84a7@gregkh>
In-Reply-To: <2023121342-wanted-overarch-84a7@gregkh>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 Dec 2023 07:16:52 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WK52EjYh0nn8e0PEvY5ovUOn9rymnY09B7SQNgUXymPw@mail.gmail.com>
Message-ID: <CAD=FV=WK52EjYh0nn8e0PEvY5ovUOn9rymnY09B7SQNgUXymPw@mail.gmail.com>
Subject: Re: RTL8152_INACCESSIBLE was Re: [PATCH 6.1 000/194] 6.1.68-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Pavel Machek <pavel@denx.de>, Guenter Roeck <linux@roeck-us.net>,
        grundler@chromium.org, davem@davemloft.net, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 13, 2023 at 12:50=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 13, 2023 at 08:52:25AM +0100, Pavel Machek wrote:
> > Hi!
> >
> > > > > This is the start of the stable review cycle for the 6.1.68 relea=
se.
> > > > > There are 194 patches in this series, all will be posted as a res=
ponse
> > > > > to this one.  If anyone has any issues with these being applied, =
please
> > > > > let me know.
> > > >
> > > >
> > > > > Douglas Anderson <dianders@chromium.org>
> > > > >      r8152: Add RTL8152_INACCESSIBLE to r8153_aldps_en()
> > > > >
> > > > > Douglas Anderson <dianders@chromium.org>
> > > > >      r8152: Add RTL8152_INACCESSIBLE to r8153_pre_firmware_1()
> > > > >
> > > > > Douglas Anderson <dianders@chromium.org>
> > > > >      r8152: Add RTL8152_INACCESSIBLE to r8156b_wait_loading_flash=
()
> > > > >
> > > > > Douglas Anderson <dianders@chromium.org>
> > > > >      r8152: Add RTL8152_INACCESSIBLE checks to more loops
> > > > >
> > > > > Douglas Anderson <dianders@chromium.org>
> > > > >      r8152: Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE
> > > >
> > > > Central patch that actually fixes something is:
> > > >
> > > > commit d9962b0d42029bcb40fe3c38bce06d1870fa4df4
> > > > Author: Douglas Anderson <dianders@chromium.org>
> > > > Date:   Fri Oct 20 14:06:59 2023 -0700
> > > >
> > > >      r8152: Block future register access if register access fails
> > > >
> > > > ...but we don't have that in 6.1. So we should not need the rest,
> > > > either.
> > > >
> > >
> > > Also, the missing patch is fixed subsequently by another patch, so it=
 can not
> > > be added on its own.
> >
> > For the record I'm trying to advocate "drop all patches listed as they
> > don't fix the bug", not "add more", as this does not meet stable
> > criteria.
>
> But the original commit here does say it fixes a bug, see the text of
> the commits listed above.  So perhaps someone got this all wrong when
> they wrote the original commits that got merged into 6.7-rc?  Otherwise
> this seems like they are sane to keep for now, unless the original
> author says they should be dropped, or someone who can test this driver
> says something went wrong.

Right. The patches that "add RTL8152_INACCESSIBLE" to more loops are
bugfixes, but they're not terribly important ones to backport. While
they technically make sense even on older kernels and could
conceivably make the older kernels unload the r8152 driver a little
faster when a device is unplugged, it's not a big deal. On the first
version of the recent patches I didn't even add a "Fixes" tag for them
but I was asked to during the review process.

The "add RTL8152_INACCESSIBLE" patches become more important with
commit d9962b0d4202 ("r8152: Block future register access if register
access fails"). Once you have that it's possible to end up in the
"INACCESSIBLE" situation in response to normal (ish) error handling
and thus you want it to be faster.

Based on our experience in ChromeOS, commit d9962b0d4202 ("r8152:
Block future register access if register access fails") is a pretty
important fix and I would say it should be backported to stable.
Certainly we've backported it to our kernels in ChromeOS. In our case
we made things easier on ourselves by backporting pretty much all
patches to the r8152 driver.

-Doug
