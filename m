Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C6779D553
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236351AbjILPwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbjILPwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:52:43 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B2D10DE;
        Tue, 12 Sep 2023 08:52:38 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-502b0d23f28so4873504e87.2;
        Tue, 12 Sep 2023 08:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694533957; x=1695138757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQtE0noGpi8t4F+aYH7KnUIfvefZ2UQLdZn5htKQJvI=;
        b=P8Va6E1qQeSUBPX1tWZChQLY9xC7jXyhRFv5HnXDke0dRbHvr53tJHbABCSWAgzsxZ
         9bI+kCJhFXIdPrA6ypYGRGEfinxDDaEFj6DO+nCjgSr0bO4f2Jl85QWh4qaatdDw5Swp
         7W9tFkTIxc9ZpktNnm67gSx8OtE1u9xgyRKi1KotGAyYHbivO2qsxaQHqEHg/Z17O83h
         2s4Iaas6SAuGkCdPyU9xOZBkTeNj0EeWwZNsNDUIByBSACt8uNXK7Uo1C9JrDiQG9e9T
         xCYvKOgU87Ev/x7M30z2U6suDMgOw6zd+PZdP1cDeUxhCLvxJ6y5vfu+VddTc2xuCt+T
         Y03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694533957; x=1695138757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQtE0noGpi8t4F+aYH7KnUIfvefZ2UQLdZn5htKQJvI=;
        b=FzOeGAuVpKot8oei9d6M6wayI2Aa9CBJonUNVvSZ80Mr2ua3Eo+BuccuZhRAi0J0eM
         ExTSa1AWOJcNIpTO64N0kFdMAHbNBo1yIYnxaRYEBbjBCoahT4GyfVHVvc3eOXCQZY3w
         B4YS9xhT2naF+/7vy/EjCvqRD4AKFMzmi/MOlBgsGEtUt45Dsp7JLUCr8yBWx3IHNtRh
         sJoHEHdBQLunhH2fFv2pw1C8pgcKDTAre6Pcq3kog9sOg/PPaeBqKEuczGwe3z+RgPq5
         w1ZNb3ZgCI7rOMW7hZFu/Yq2NYfNEcbBpVjaPHSwh/el48/3bSzSgWIQwhQzf4nyxgOP
         WzNQ==
X-Gm-Message-State: AOJu0Yxc4KSaF03FsqDE7Bl6VOOFgG1LlU7vKOad6IsidTCe67wl1BBh
        dhlrm9BzqKIcu2YCM98Cbco=
X-Google-Smtp-Source: AGHT+IEGRX31wVxuK44UuB2IYh8MFNKcGd1rqWZcS7+tZahddr1EeYKop8jcYO1TlfatEuvx9Ep6Sw==
X-Received: by 2002:ac2:4c94:0:b0:500:94c5:6e06 with SMTP id d20-20020ac24c94000000b0050094c56e06mr9173435lfl.56.1694533956701;
        Tue, 12 Sep 2023 08:52:36 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id n3-20020a1709061d0300b0099bd046170fsm7046720ejh.104.2023.09.12.08.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 08:52:36 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pinctrl: pinmux: Use dev_err_probe() in pin_request()
Date:   Tue, 12 Sep 2023 17:52:35 +0200
Message-ID: <7566964.EvYhyI6sBW@jernej-laptop>
In-Reply-To: <CACRpkdbTZYnehWiWFgY3KJLFdS47RpxOp-Cct4BDqgYCYtd2vw@mail.gmail.com>
References: <20230909063613.2867-1-jernej.skrabec@gmail.com>
 <20230909063613.2867-3-jernej.skrabec@gmail.com>
 <CACRpkdbTZYnehWiWFgY3KJLFdS47RpxOp-Cct4BDqgYCYtd2vw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 12. september 2023 ob 10:15:31 CEST je Linus Walleij napisal(a):
> Hi Jenej,
>=20
> thanks for your patch!
>=20
> On Sat, Sep 9, 2023 at 8:36=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gma=
il.com>=20
wrote:
> > Use dev_err_probe() when printing error message in pin_request() since
> > it may fail with -EPROBE_DEFER.
> >=20
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>=20
> (...)
>=20
> >         if (status)
> >=20
> > -               dev_err(pctldev->dev, "pin-%d (%s) status %d\n",
> > -                       pin, owner, status);
> > +               dev_err_probe(pctldev->dev, "pin-%d (%s) status %d\n",
> > +                             pin, owner, status);
> >=20
> >         return status;
>=20
> That's not how you use dev_err_probe()
>=20
> Just replace all of the lines above with return dev_err_probe(...)

I already send v2 of this patch soon after I got report from kernel test=20
robot.

Best regards,
Jernej

>=20
> Yours,
> Linus Walleij




