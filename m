Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0050A7E6CF7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbjKIPMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjKIPMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:12:13 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2081735
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:12:11 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6c320a821c4so907657b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 07:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1699542731; x=1700147531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9EQ/3uynt3hQPZvP5J6LtKRk4MUPps4VFOyx+7JFU0=;
        b=crU3O6guLPXOqOp7LqJ/+sgWk+r4sBmWCOMt6Fbhci4E14pk/i2ZROvM8RPWOl0PcD
         3f8n1AIHOcbOT7Davzy8wWuqfo+Kr4Q04oGhMLpx0p5zDhgwWWGyi8HlVhJZUVUFzcPn
         /t+Xxt7ZjSN3iuy3MP5rz0irDQrWmdXu88lYl+gakMNsWp0eSZqQXCA/d2eYoV2I2Ag8
         WZc4ctr8loxzr5eUM1XcSkC6dSBuNxLm9O5PwUPRenJtBVdSza00zVnI8ezAImVe+YLP
         f2l9UB2UwdEjWbPYe7R7Myezdgnch5Um/HYdGvad575dayb6XN81eSiNUx0TaKudXIuS
         Qlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699542731; x=1700147531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9EQ/3uynt3hQPZvP5J6LtKRk4MUPps4VFOyx+7JFU0=;
        b=praj7LCQqAE4PLBj9vwxoIjszlTWQZ1J62SsdBQe/DxnisThASW/etQCLPsr6nDoG9
         K1jJBLug6oEAprVSBRepmVq/wPD2uf8O+rrNKqBtsCL2kO7rZ61nrKsZU2xEAbd7F3Ub
         ybM97lxGHgFOP7hvhm1zd2M8793Y/mJSYYYgj9UkLT3ePdCQDJrHKbjs/cxEMzT2ufLb
         sOHYO5EPCRA1t38HTL8jzfjfmBMYCO7JavBfY8+73qrbv5JKr1fP3ngvUzQHlmbyYdM8
         4gL5Ln3osHzFcYUDUS7+gStQ8BxHo5nhWViHyueL8hIGD5ghfWpj8c/blcURc7hSsd1K
         AONA==
X-Gm-Message-State: AOJu0YzBegTSCrigq96eQz0+8Qrlvp9r6iw3ELp03dTmaFy1KNiliJeB
        99iRVZ03oWvjqLTQdaUQE2qLUYD6sbbPGKQk/kwodg==
X-Google-Smtp-Source: AGHT+IHOOLBbkbzPm8gGREhCPqQ8oNM3NzFr4uZyUvE8yTy1xKc8RenLWSpzcT5jwfw72MTK9GtxETFWGps9OsY+uQs=
X-Received: by 2002:a17:90b:3a8d:b0:280:6b5b:3f40 with SMTP id
 om13-20020a17090b3a8d00b002806b5b3f40mr1891120pjb.8.1699542730865; Thu, 09
 Nov 2023 07:12:10 -0800 (PST)
MIME-Version: 1.0
References: <20231005133059.917577-1-naresh.solanki@9elements.com>
 <f8dd6d53-7c0b-4a89-9ec4-400aa242c020@sirena.org.uk> <CABqG17iufSniSLZ2vU5fFduFwV2FL8jNzMcsveOgFUME1jXmgg@mail.gmail.com>
 <aa3f5615-dddf-4c94-88c7-494cf7cd80ab@sirena.org.uk> <CABqG17h949R+3NFgA1MvPLZFc6zkBi+WRPSE9qP4fCBv5gdXHw@mail.gmail.com>
 <c2dd0533-3a60-4481-8621-86578e62aab6@sirena.org.uk> <CABqG17h0OnMD-L1vYkJobji+Z=QPuYrd=ra1d7DncAN0_TO23A@mail.gmail.com>
 <f5829ebc-b3ab-409b-9271-e066c08aec6e@sirena.org.uk> <CABqG17iBsEO-NnRvgFJ9e5PvT7q+HgLyiDDfO5GcvXh4ueySsA@mail.gmail.com>
 <ZUzDBCaqR9Ui4j71@finisterre.sirena.org.uk>
In-Reply-To: <ZUzDBCaqR9Ui4j71@finisterre.sirena.org.uk>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Thu, 9 Nov 2023 20:41:58 +0530
Message-ID: <CABqG17gc40_z4FWSwnqUwnXGKZzGAHs6zD7br03chcT_+bGWLw@mail.gmail.com>
Subject: Re: [PATCH] drivers/regulator: Notify sysfs about status changes
To:     Mark Brown <broonie@kernel.org>
Cc:     zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,


On Thu, 9 Nov 2023 at 17:01, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Nov 09, 2023 at 04:08:06PM +0530, Naresh Solanki wrote:
> > On Thu, 2 Nov 2023 at 22:20, Mark Brown <broonie@kernel.org> wrote:
>
> > > Ah, right.  Everything except for the enable and disable there looks
> > > like it should be OK since they should normally just not happen but t=
he
> > > enables and disables might get a bit frequent with runtime PM - not
> > > *super* frequent like voltage scaling but enough that people could ha=
ve
> > > an issue with it.
>
> > I aim for a straightforward implementation.
> > Using attributes such as status or state seems ideal for receiving
> > notifications.
> > In my case, the application focuses on status changes=E2=80=94whether i=
t's on, off,
> > or encountering an error.
> > These changes are driven by events originating from the regulator.
> > So below change is what I see fit well.
> >
> >         status_events =3D REGULATOR_EVENT_DISABLE;
> >         status_events |=3D REGULATOR_EVENT_ENABLE;
> >         status_events |=3D REGULATOR_EVENT_FAIL;
> >         status_events |=3D REGULATOR_EVENT_FORCE_DISABLE;
> >         status_events |=3D REGULATOR_EVENT_ABORT_DISABLE;
>
> In terms of the implementation for delivering uevents this looks fine,
> my concern here is that for some systems the enable and disable events
> might happen more often than is really a good fir for delivering via
> uevents, if a device like say a SD card is getting powered up and down
> via runtime PM that might happen relatively often and then the system
> would get a lot of uevents which it would most likely end up ignoring.
> That could have a noticable impact on power or performance.

May be in that case should we consider adding a kernel parameter or
some property in sysfs attribute to allow getting events ?

Regards,
Naresh
