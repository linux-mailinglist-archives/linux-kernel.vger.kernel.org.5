Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F1780DAA5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344458AbjLKTLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjLKTLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:11:34 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988D0DB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:11:39 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54c9116d05fso6745712a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702321898; x=1702926698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53+GQ9DSChkfFqfGSXLQ0QMyql+oTK4NA8OXD5BIsZM=;
        b=aZWfVsi0nhc27jgWVTLOn5u5JI7n/FejXbGaYxrlG9ZYP57iGMBuWw/3c+6ABQFN0t
         /IIap0t111JzD/rBOv574CoJefv9C4xr8851F9HnUkwWVjUmTAwmFx2GiYCtyqw01iPN
         1yaEqSA5Fr5cxOf0XOJ2QqlDYbutU+J2+IZkGocCN37wwRwB/bJQoXVf3bGixpPidEQz
         PugIscb+bt7JblMgLidAqvJ5QB3veg9Xui3L8wo51+zgEfdzKZtIw/m5OsMKUkDL0eRD
         ni3eOEFGGQnAnaN42P9hEodtgq+jPjnZXKH3yTewWCskzh8NPLed0HfDJP/AGD5UUNhm
         RBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702321898; x=1702926698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53+GQ9DSChkfFqfGSXLQ0QMyql+oTK4NA8OXD5BIsZM=;
        b=XDCVm2Q2zg3bpDIgOFfsED66V5PYPkoNCMvtQl3dWmW+s1tiw3Ga7ytxFhV6yVTDAv
         kxytxIFDiid9L16sMZraaS61gy2QxEZicqL+bZWt2aO3TjIw9Hu2IFeeDp7v/m8ckW3R
         xINAQra8wXkV8QJ4YBFqFlev19st3ooizBBD8eTd6xOwyPG2eD/4xSmcU6bumecaah28
         OP0NO9sZkFafUX+9J24gVA5HKM0D/phiD9WdNRK4pPxKsPvo+gQWRYuGtF2FFWdnEqOY
         KUpjiot9Ecvzhd6pYU1uFfEhIfFVBnOlhMG6Y+OQxe8fcPqBNZJ35BtkcIi/DjkLoU8h
         5WDg==
X-Gm-Message-State: AOJu0Yw8gmFEtGSueAJ/GabtZUoK/ERCt5/jPdkx5NY681EyLd5bbdjJ
        /m/Oc4YKnhVmMBGnBiYz3Khs55nLZyMJHCWrABYzfA==
X-Google-Smtp-Source: AGHT+IFvmTrqFmb3KMd/5xiFQbhGpELJ/arHQLgqbMwaN7GGJJxxJmDMIqQ2CDnleZexNcIu6ZMsfzm7/A6/dIyFIGQ=
X-Received: by 2002:a17:906:c141:b0:a12:7a14:5355 with SMTP id
 dp1-20020a170906c14100b00a127a145355mr1440878ejc.39.1702321897853; Mon, 11
 Dec 2023 11:11:37 -0800 (PST)
MIME-Version: 1.0
References: <20231207-strncpy-drivers-net-mdio-mdio-gpio-c-v2-1-c28d52dd3dfe@google.com>
 <ZXJNwrcSfgUFhaz6@shell.armlinux.org.uk>
In-Reply-To: <ZXJNwrcSfgUFhaz6@shell.armlinux.org.uk>
From:   Justin Stitt <justinstitt@google.com>
Date:   Mon, 11 Dec 2023 11:11:25 -0800
Message-ID: <CAFhGd8r1t8Gs5_idKiLqWL8Aicj1A_hTuqvO0075TP23rvjxJg@mail.gmail.com>
Subject: Re: [PATCH v2] net: mdio-gpio: replace deprecated strncpy with strscpy
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 2:57=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Dec 07, 2023 at 09:54:31PM +0000, Justin Stitt wrote:
> > We expect new_bus->id to be NUL-terminated but not NUL-padded based on
> > its prior assignment through snprintf:
> > |       snprintf(new_bus->id, MII_BUS_ID_SIZE, "gpio-%x", bus_id);
> >
> > We can also use sizeof() instead of a length macro as this more closely
> > ties the maximum buffer size to the destination buffer.
>
> Honestly, this looks machine generated and unreviewed by the submitter,
> because...
>

Not machine generated.

Was just trying to keep my change as small as possible towards the
goal of replacing strncpy.

However, you're right. It's literally the line right above it and now
it looks inconsistent .

> >       if (bus_id !=3D -1)
> >               snprintf(new_bus->id, MII_BUS_ID_SIZE, "gpio-%x", bus_id)=
;
> >       else
> > -             strncpy(new_bus->id, "gpio", MII_BUS_ID_SIZE);
> > +             strscpy(new_bus->id, "gpio", sizeof(new_bus->id));
>
> If there is an argument for not using MII_BUS_ID_SIZE in one place,
> then the very same argument applies to snprintf(). If one place
> changes the other also needs to be changed.
>

Gotcha, I've sent a [v3].

> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

[v3]: https://lore.kernel.org/all/20231211-strncpy-drivers-net-mdio-mdio-gp=
io-c-v3-1-76dea53a1a52@google.com/

Thanks
Justin
