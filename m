Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DC17EC069
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbjKOK2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 05:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjKOK2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 05:28:40 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE31F5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 02:28:37 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a7c011e113so77330917b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 02:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700044116; x=1700648916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=do0Q0u29Tz44Y8UUBoHQ+KrW0i2gijbFLTrdRooPIFA=;
        b=TJ+G/lBinQ1c1M/SR8OXplq3APhkI3+qo9lz00fVkbhsPtLhqi8hUwIhESCBNXbhRi
         IFhU5d5Z3mX3t8x3RRmQ2nEIfI9TTr2BIY2HARVzHiKGPd8LsEsmIoTqfNAxa9mItOfI
         CUDcsWSPDR6tVsW0au7LMAwOXk8Tc1xCZWSpj86ZcVKh85xoYVnFfOrPhkH0fTWv0IBx
         pYESUFVFKKSWLIJH927FWsNp75msrf428fQtkkstns7BxkMeEqQRii8/mclwXKgsCWmq
         1tcDWxMwoqDVP+ZgKTkD0tPzlKGvT+ImJUXTkYydPXqIcIQC9xj7uPCV0fEK4/4UiSv/
         N7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700044116; x=1700648916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=do0Q0u29Tz44Y8UUBoHQ+KrW0i2gijbFLTrdRooPIFA=;
        b=LZ8JHrCUOFUQif1McjYDdA32RdPM02l6vrjoHn4AyyMuINOFW2/cuHlgpDeDK8UZj5
         ItivzLV5AiYefpI8SlrZf06/C77HZ0bjxgpjpgg1dA1c8eh8Xm97KU2Ib5pAqN279DTB
         3ghjfCtm0hlWW0pxsDDs+a+Z9v4s0KXAfT9h2hH67UU7dihSxjxAtMobFiyWLzPNbtHV
         u66z/ET8ahwn242NLbxWvz82G0Plq4pzJzG34Svds7GLF+48We3nCiB3UR92ZqeWvb0P
         QA0OSPaIxl0QKNq2fibRP3wBe5SvDJTId3je1VVIB2qMkk0MJm/Rx2KVoHnjmQmbLCGl
         8c6g==
X-Gm-Message-State: AOJu0YyYIOF7b/9JdeJjvZSAWPTQqX8LO/R5HhQQwsQjBV9Ng8v/p6Ym
        sFChfp17l3Ct7BDFHKcYqMOzTPaFIi8dLvJfJBo+9Q==
X-Google-Smtp-Source: AGHT+IF8n86745aK0mAoqCk8o8BEcrky8kE5DIJC+RtaVr5hq4EG/nfkYjQEASp55CZ9wVIawIo8P8fKkM+MZ6bgDto=
X-Received: by 2002:a81:48d8:0:b0:5bf:5741:517f with SMTP id
 v207-20020a8148d8000000b005bf5741517fmr12584129ywa.22.1700044116627; Wed, 15
 Nov 2023 02:28:36 -0800 (PST)
MIME-Version: 1.0
References: <202311071303.JJMAOjy4-lkp@intel.com> <CACRpkdb4d9pfstqDTZoBSqOSS4d4vLOUCnS6AKcMjLZ8TTQ2Wg@mail.gmail.com>
 <20231115093742.GA32655@ediswmail.ad.cirrus.com> <CACRpkdYHJcx8gDsa5P2eLBh6iaVQzZY+-4eMJPKtnQTq3uR6oQ@mail.gmail.com>
 <20231115102537.GB32655@ediswmail.ad.cirrus.com>
In-Reply-To: <20231115102537.GB32655@ediswmail.ad.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Nov 2023 11:28:24 +0100
Message-ID: <CACRpkda3yBJjuHRvuCyL-XqJiNO57wPyuHJzn6cBMpaBnR+RMw@mail.gmail.com>
Subject: Re: drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:53: error: pasting
 "LOCHNAGAR1_" and "(" does not give a valid preprocessing token
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     kernel test robot <lkp@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 11:25=E2=80=AFAM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Wed, Nov 15, 2023 at 10:57:29AM +0100, Linus Walleij wrote:
> > On Wed, Nov 15, 2023 at 10:37=E2=80=AFAM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:
> > > On Tue, Nov 14, 2023 at 02:40:38PM +0100, Linus Walleij wrote:
> > > > On Tue, Nov 7, 2023 at 6:19=E2=80=AFAM kernel test robot <lkp@intel=
.com> wrote:
> > > It has somewhat been on my radar to fix at some point, but I have
> > > in general been a little unsure how to proceed. RST feels like
> > > a mega over generic macro name to be exporting, so in some ways
> > > feels like fixing that would be nice. On the other side, renaming
> > > the register on the Lochnagar side would be very easy, although it
> > > would mean the register naming no longer matches all the hardware
> > > documentation which would be kinda lame.
> >
> > If MIPS breaks things like this because of weird defines I would say
> > it is actually fair to just quirk it in Kconfig with a comment:
> >
> >   # MIPS occupy very generic defines
> >   depends on !MIPS
>
> Hm... hadn't considered that. The driver is pretty unlikely to be
> needed on MIPS anytime soon, so might be a reasonable work around
> for now. Would you like me to fire in a patch, or you want to?

Send it and I'll merge it.

I don't see the value in MIPS compile coverage for this driver,
since it already builds fine with e.g. m68k big endian.

Yours,
Linus Walleij
