Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9FF810E0E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbjLMKDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjLMKDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:03:45 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2588D0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:03:51 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-46486775ad7so1401700137.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702461831; x=1703066631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/qPaIfmghWpTcqxcVuuhDpPLoLBeCE+kTWvQmM/68A=;
        b=mB5aZ8hhw7+zC5YruVNA2JWNN/+81p4tppiYN04VmoiaOKPhbTP09KNO9KKEXxwbvg
         T0RFtsLYvn5Jy95so7ExV3Sk7DIKpKMT9k7vsTKQGCW693xqNDYMbuFcNfDtlAFIE+y0
         ukyxS2VN484hlFKwCIKgDvpvRPjsPIB4De8Vnn6tbxFVvOj+npr2OLN7OceRfxN0pJiV
         Md0bho/E7IRH79XTo4s08GG5EHJA9YTng6zA0nU0MCiP9qV7BcLpsmRveENws7uKXPUx
         GxwfIJszvMfK40uilqAUDIEzOPcdmZvg0tfeabXhTGvKOVvxB9B0I8W/26K9KCegsy23
         mAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702461831; x=1703066631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/qPaIfmghWpTcqxcVuuhDpPLoLBeCE+kTWvQmM/68A=;
        b=hvgHmIam9Tv1fJJlEv0pGnJADz2mIirwmD+MeWAh9IdB7IAFkUQmIrX8iNtvj+gpy3
         YFsM++mdRUBrDqYJUX9mzix5YdwIdor5oKq3STvCYQMix3DVDeekzrvSLDEZjQebB/6h
         CxvAKOZ5G6l7uxAauLuAh7u4TUeKQAIdIgpEqVCr89BDL/5MmXEynowF6hcFZOI/IhvL
         wQbnw7fzFBedYxkW0BEHhSBafUNap8bsZCfTLs+bGHiUcqnBHuldqf+nKsBJQSabg3Ti
         d2l19+cQzeJEzc2BtxsSxkfp6sMiCbp1JRTAKXFZkeR35sGFcACzJsK3xTZASnW3A8Ou
         VSjA==
X-Gm-Message-State: AOJu0YwaKlVf0IVw80Zgw9tMHUp3Nru/ExZA4mjHODxbns9W+wEmogxA
        HLFKgtKq617OZ5K6OiHp3iiviWuwEIz3HwDaMwjHpQ==
X-Google-Smtp-Source: AGHT+IG3ImtM5KXcZ7eTb8vW10Gvrumis+otVhTYGJe6eSKBhEy2rOOc9T3pTbOBsxNp/lr4gzSTWkji28AMoMKXwgc=
X-Received: by 2002:a05:6102:3a0c:b0:464:865e:6aaf with SMTP id
 b12-20020a0561023a0c00b00464865e6aafmr5265030vsu.1.1702461830883; Wed, 13 Dec
 2023 02:03:50 -0800 (PST)
MIME-Version: 1.0
References: <20231212054253.50094-1-warthog618@gmail.com> <CAMRc=Me90Lu7Duc8-4xSfDcHQd6M7+0t0O8FAa6jiizp-OO5=Q@mail.gmail.com>
 <ZXjzjOtKFoMRhKA-@rigel>
In-Reply-To: <ZXjzjOtKFoMRhKA-@rigel>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 13 Dec 2023 11:03:40 +0100
Message-ID: <CAMRc=Me1czOqnJUG3sth6kZh=G+iXAHp7HHL1u-Oy3=MwkCPug@mail.gmail.com>
Subject: Re: [PATCH 0/4] gpiolib: cdev: relocate debounce_period_us
To:     Kent Gibson <warthog618@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, andy@kernel.org
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

On Wed, Dec 13, 2023 at 12:58=E2=80=AFAM Kent Gibson <warthog618@gmail.com>=
 wrote:
>
> On Tue, Dec 12, 2023 at 06:09:00PM +0100, Bartosz Golaszewski wrote:

[snip]

> >
> > Patches 2-4 look fine, I was about to review patch 1 in detail but I
> > thought I'd just throw this one in here before we commit to a specific
> > solution.
> >
> > For some reason I thought this would not work but I'm now considering
> > it as an alternative approach: is there anything wrong with adding
> > struct kref to struct line, allocating it separately per-line when
> > gpio_chardev_data is created, referencing it from struct linereq when
> > the line is being requested, and dropping the reference from
> > gpio_chardev_data and linereq when either is being removed? Other than
> > the increased number of allocations?
> >
>
> The collection of struct line always has to be global, right, as both
> gpio_chardev_data and linereq are ephemeral.  e.g. if one process request=
s
> a line and another checks the lineinfo, those will have distinct
> gpio_chardev_data.
>

Strictly speaking at least the supplemental info has to be globally
accessible. But I get your point.

> But the key issue is that the linereq and struct line lifetimes are
> strictly tied - a struct line does not live beyond the containing linereq=
.

I was thinking about decoupling one from the other actually.

> Leaving the struct line alive after the linereq is released is just wrong=
.
> The line has been released back to gpiolib so there can be no
> supplemental info left.

Indeed.

> If you want any such info to persist beyond the line release then it
> should be located in gpiolib itself, not cdev.
>

Right, we even zero debounce_period_us anyway on line release - just
as if we released struct line.

Bart
