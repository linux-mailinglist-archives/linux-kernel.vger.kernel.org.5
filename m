Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36528136E5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443884AbjLNQvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444085AbjLNQum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:50:42 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16B01A7;
        Thu, 14 Dec 2023 08:50:33 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-dbcd7d63789so1174686276.3;
        Thu, 14 Dec 2023 08:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702572633; x=1703177433; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GCp7oH/gOJp7J9eGa5Fv3Vw5adjzdlx0cxRf567SUHs=;
        b=gQqUft8OxkQt7V/pOUO3nNujYVABSB+zXRDRQhgAt7hr82sD5ife0HehJJF9+uBv0H
         kGueEGeL3Pbv4uuct4dB13L13/Xii27IfoiV1GuZYct+HC+sy965xn/VZJbQsIoPjzTK
         yiPOdJmWFPbVMIHTgHq/dmJxwOFdi7yeFCkvH6Y1DBrmFglJZatgAqFQAUISG4ZTqZO1
         tHhHupsimyhAWoxodaHqa+P6+O+W8a8mhkGjshjZawscLDaDjBLSZNCHjWMn4eC0iACy
         NwQAvyL9tFn3vxnzbzzfDBpIrYbUc/2ia6cDgjUCTRRC0uu3F52HSoYy02bg0PvOxmOl
         kngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572633; x=1703177433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GCp7oH/gOJp7J9eGa5Fv3Vw5adjzdlx0cxRf567SUHs=;
        b=PRku5DYx5eePZ/D/WlqdCUIr8cBEY4pMBlgdgjLhVcd7alET7bciMlIrFyJoThGuP1
         5Bts1EXkD0NRsKYebW6fq0dNwjT6/vGKxMg5mWfrxi+6vcoy5r1BcMZJi4HauNlFt5hP
         2ZR3bPhNhp72d7pnBP6wXuFNa748OEvhQ041l/gitoQ71kbUb3R8bnOqy2iHEJmtLPkn
         aygfwmQfNROu8igPnMlmf0RBBtcPMUKBo1ehJ/Ta1HNMkPh2G+twNW3/NWI9kMtzDpk0
         ltRzZcMq2diYa4Il7ZmJG2pgh9N66Cl2Ghjwdsq9n5EmhZ1A9vFqVH2HA899r+s5CEpr
         JoKg==
X-Gm-Message-State: AOJu0YzglB9F/bUnaAUOt6iTy1o+oGqPI8geH2Q3NokWxB2HO5pKC3jD
        CWdpysl24nVs9xznAa9ChVUCNXwXHUaCuWISXTkMj58O
X-Google-Smtp-Source: AGHT+IHrQv/zGVf9OaFxbpocOPZzcUmOj8Ved/+MSnhM0SJDoI50jIVku44SJoWKiweBXvQlPaNG5U0SeghbqBkrEJ0=
X-Received: by 2002:a25:55c2:0:b0:dbc:b6e0:e302 with SMTP id
 j185-20020a2555c2000000b00dbcb6e0e302mr2171816ybb.83.1702572632960; Thu, 14
 Dec 2023 08:50:32 -0800 (PST)
MIME-Version: 1.0
References: <20231213190528.3751583-1-tmaimon77@gmail.com> <20231213190528.3751583-4-tmaimon77@gmail.com>
 <cf3ce945-2f1c-4dae-86b8-349dae3d962b@app.fastmail.com> <CAP6Zq1inLOMHORqO8=RbP6NfwJ63kLaH0G3+TKBhfn0p2CE53w@mail.gmail.com>
 <88040035-d971-4012-bb9f-9f2ae91fdc6e@app.fastmail.com>
In-Reply-To: <88040035-d971-4012-bb9f-9f2ae91fdc6e@app.fastmail.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Thu, 14 Dec 2023 18:50:21 +0200
Message-ID: <CAP6Zq1iZbNnPuVnJW0=HhnOryrdZOcnNMK420H3X0KcA1k3-Uw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] soc: nuvoton: add NPCM BPC driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     pmenzel@molgen.mpg.de, Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Conor Dooley <conor+dt@kernel.org>, avifishman70@gmail.com,
        tali.perry1@gmail.com, Joel Stanley <joel@jms.id.au>,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        openbmc@lists.ozlabs.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thanks for your suggestion.

Appreciate it if Joel, OpenBMC Linux kernel maintainer,  could share
his thoughts about it.


On Thu, 14 Dec 2023 at 17:49, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Dec 14, 2023, at 14:09, Tomer Maimon wrote:
> > On Thu, 14 Dec 2023 at 14:44, Arnd Bergmann <arnd@arndb.de> wrote:
> >> >
> >> > +config NPCM_BP
> >> > +     tristate "NPCM BIOS Post Code support"
> >> > +     depends on (ARCH_NPCM || COMPILE_TEST)
> >> > +     help
> >> > +       Provides NPCM driver to control the BIOS Post Code
> >> > +       interface which allows the BMC to monitor and save
> >> > +       the data written by the host to an arbitrary I/O port,
> >> > +       the BPC is connected to the host thourgh LPC or eSPI bus.
> >> > +
> >>
> >> This one in particular looks like this might be implemented
> >> by more than one BMC type, it's a fairly generic functionality.
> >>
> >> Have you talked to the other maintainers of SoCs used in
> >> OpenBMC about coming up with a common interface?
> > Yes, Both Nuvoton and Aspeed use the same user-facing code to manage
> > the host snooping.
> > https://github.com/openbmc/phosphor-host-postd
>
> Ok, that's good. I found the driver in drivers/soc/aspeed/aspeed-lpc-snoop.c
> now and see that the implementation looks very similar.
>
> I think we should do two things here:
>
>  - split out the common code into a shared module that exports the
>    symbols to be used by either one
>
>  - find a better place for both drivers outside of drivers/soc.
>    I would suggest drivers/misc/bmc/ but am open to other suggestions.
>
>       Arnd

Best regards,

Tomer
