Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F467BEBFC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378005AbjJIUxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377082AbjJIUxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:53:31 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6BA92
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:53:28 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-405459d9a96so143425e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 13:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696884807; x=1697489607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59tO/iIlQ73UqQX7Kk8ekqFEIp7s2Jv+HxK9i4t6u3Q=;
        b=4PAbeZeQOmiEMgjmxfj2C2RZ90qgO4DgR1wDrauJS5k77bR0M9C1Ua7XcDtRTbisUB
         u8CJndvzycWIGDaMHOdfP/rUVshbnFBETF4Vv553OCQhqrkvPdzjQwZtng/WB7UA/Nbc
         MWyhOcXiYQoRWnHzfuVfri2hoiNzWDbB5ryCdqzsdn/loTXVa3jhcxazP9vO+LKkF1oN
         4BTAvlRYRkEYTSTBA7oi5o9xaTeqKmqxMC2tkMrK8RH7HaBX8Tj/bM61DatMOye/jl2M
         tC3HE0+qNDApHDR5bQDVlzb8IfdV+cFvLeq/RjOQYRJ5RE1Z5wvO9yuCGnJ/OMPjDAyt
         PPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696884807; x=1697489607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59tO/iIlQ73UqQX7Kk8ekqFEIp7s2Jv+HxK9i4t6u3Q=;
        b=cnQmCNSb8KiIjjcJr0IFxbxRvsUlnh4h7RJ/m106X9x/wVB5UySqnjOB6XS9sUhNZU
         gpmNsYFxO3AQy1g8Dm3w18QiQXhA1vBtMwVgiwhlVznjkh7X6q2AUpzudCwhQuXxFRku
         yhroEIOe8FsA/cHmWph9tQKryQN35n1F09UKGXaHKDq9y8nfoRIoagUaqJffoLncxdLV
         G/XYPzv5Z16N8rEqFTc7odF1oTRpD0kPBFR8nLZPmBq+q6Mka8LUU3Lm3xbcOeJ7LbJ1
         HMj6ZXWYDVib4dQfUM3y8O97fVWQiXt/lJifaA+XAbdc8K5QBxY40xbPReq824R7Wbmz
         1Ywg==
X-Gm-Message-State: AOJu0YwCUWbhVOTcTJRuHNmh3ib+4sUJLGkPgSZdKxOKgf4TmO+SWhjc
        IlzuvwTqXpUvjYYhSOBjG1X2xvmvlf8Gu2fU3GiIJQ==
X-Google-Smtp-Source: AGHT+IHq7N3/6OsWTZHhFPYxj2swHPTNEn7XPdgUv+UA1bljGHW5UFtKZwxam1OQNUu0b+Wrsm4hBPVG6ZOVmvI2H/o=
X-Received: by 2002:a7b:c3d8:0:b0:400:c6de:6a20 with SMTP id
 t24-20020a7bc3d8000000b00400c6de6a20mr385036wmj.3.1696884806574; Mon, 09 Oct
 2023 13:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231007060639.725350-1-yangcong5@huaqin.corp-partner.google.com> <CACRpkdbek0-Vhk4_34qY+0=EGrQxJS_CfLuF_5fRozMMyc+=Kw@mail.gmail.com>
In-Reply-To: <CACRpkdbek0-Vhk4_34qY+0=EGrQxJS_CfLuF_5fRozMMyc+=Kw@mail.gmail.com>
From:   Doug Anderson <dianders@google.com>
Date:   Mon, 9 Oct 2023 13:53:14 -0700
Message-ID: <CAD=FV=UFa_AoJQvUT3BTiRs19WCA2xLVeQOU=+nYu_HaE0_c6Q@mail.gmail.com>
Subject: Re: [v1 0/2] Break out as separate driver from boe-tv101wum-nl6 panel driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        hsinyi@google.com, swboyd@chromium.org, airlied@gmail.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Oct 8, 2023 at 12:33=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Sat, Oct 7, 2023 at 8:06=E2=80=AFAM Cong Yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
>
> > Linus series proposed to break out ili9882t as separate driver,
> > but he didn't have time for that extensive rework of the driver.
> > As discussed by Linus and Doug [1], keep macro using the "struct panel_=
init_cmd"
> > until we get some resolution about the binary size issue.
>
> OK works for me:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Dough, if it looks OK to you too, can you apply the patches?

Thanks for the review. I had a few small comments so I'd expect a v2.

I suspect it would look a little weird to add your Reviewed-by to
patch #1 since the way Cong has it you're the direct patch author. :-P
Cong, I suspect you may want to change the tagging on patch #1. I'd
suggest setting yourself as the patch author (git commit --amend
--reset-author), then tag the first patch like this (I put "x-" first
to make it obvious to any bots reading this that these are not tags to
actually apply--remove that when you tag your patch):

x-Co-developed-by: Linus Walleij <linus.walleij@linaro.org>
x-Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
x-Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
x-Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>

Also: just as a heads up, Hsin-Yi measured the impact of removing the
"command table" for init and replacing it with a whole pile of direct
function calls. She found that it added over 100K to the driver (!!!).
I believe it went from a 45K driver to a 152K driver. Something to
keep in mind. ;-)

-Doug
