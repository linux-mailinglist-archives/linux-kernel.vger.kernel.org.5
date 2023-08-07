Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7641F772685
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbjHGNuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbjHGNuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:50:07 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D52D172B;
        Mon,  7 Aug 2023 06:49:53 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-56c7eb17945so2652628eaf.2;
        Mon, 07 Aug 2023 06:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691416192; x=1692020992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ws1fvLkPKnknDP1Bwp+5q1Up2hMICKJmNCu93ys8myM=;
        b=UHwfRM0flSVeIIcUepWB3cOUHwe6nkh1PWgZTFtWOGD4ONRs3BhrKDLkx7T0aFWqXh
         bcvkMM0PPB0q9EH83fMg/pay1/Um2DvcTumnxGvTjbW6J1q/xQ1BMG3HGw5OJBuluSZ6
         ++oPmoTeIQB3FeIAOUpvRDLUjTzSIxeDV65kSa1ak6YV4A84S5e4WPAtmw+tv6YvIi2x
         Bm0drO4KXkvMpawdIGF1K0PD0bxZ/3satjJtVrU4poTQ+mEfraH9JdBlrEQTomZmxMWk
         vNSyGciRAysjbyU0vxxuf79oTyEwhLfw1XqH7P7uF3bZu1h181jPm6DWLbFWdkPABm5l
         rHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691416192; x=1692020992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ws1fvLkPKnknDP1Bwp+5q1Up2hMICKJmNCu93ys8myM=;
        b=i3lSf7EsljObNTOeEtAaEeovTYbI46KeX+gXscJwiD4RJJeu2uI33DqV0qG1eyqtVS
         kLjImXmgt9IkXNDwN2xfTZ1T9rz3e59jU8hhttsec8LfrS7tNPoy6oss95p/QZKo9WaR
         PwY39nHDHQE3DxDISRGycMXVbWtbI/oCx2AI2iL5mrhrhlVjiHoiUifey7er7Z2X7VBf
         DT5MnHMD725kxkb0kobni/xdl7lR6QBWVyghpYyGXgVgdO18QXBmDe99orPC5d4voeVW
         8FaawMo/+FnW+GXXPpJT/8KPXuhJtQLFeDu/w43pjtfKSe0mwaOj6QIxpbirHd69TR18
         jotQ==
X-Gm-Message-State: AOJu0Yymmh90s2M3xkdsg9K9D2bhLXWYXq2qfR+wkLAMozre/JuAXGDa
        46RWxEDXihr8UG8427I0hXu8p0+zFvSQJS2aKmE=
X-Google-Smtp-Source: AGHT+IE4r0+iuAynzoUIlfeq89D7yczt7LMmvuawleig9x1fedQK2Iy48o76+74FFStlIdnn8il5fIJDWJV/AvlQNJM=
X-Received: by 2002:a4a:2750:0:b0:56c:cefc:55d with SMTP id
 w16-20020a4a2750000000b0056ccefc055dmr8678776oow.4.1691416192247; Mon, 07 Aug
 2023 06:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230727162909.6031-1-duje.mihanovic@skole.hr>
 <20230727162909.6031-3-duje.mihanovic@skole.hr> <ZMKd+CoWu7QjOxHo@smile.fi.intel.com>
 <13320053.uLZWGnKmhe@radijator> <CACRpkdZdpHjh_CCmuT2ORpuZ=CbUECW7dBXsL+P+aNvfMYmEuA@mail.gmail.com>
In-Reply-To: <CACRpkdZdpHjh_CCmuT2ORpuZ=CbUECW7dBXsL+P+aNvfMYmEuA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 7 Aug 2023 16:49:16 +0300
Message-ID: <CAHp75Vfkchxzxq=1cMbof0gOj90cs6ntTOefRNk1w+DYVeJLag@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] gpio: pxa: use dynamic allocation of base
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Andy Shevchenko <andy@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 4:31=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
> On Sun, Jul 30, 2023 at 11:18=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihano=
vic@skole.hr> wrote:

...

> And maybe some more. Yeah it's tough, but it can be done!

And I will add "earlier started less effort it requires".

--=20
With Best Regards,
Andy Shevchenko
