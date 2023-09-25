Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921F87ACDAD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 03:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjIYBol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 21:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjIYBok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 21:44:40 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8C8BD
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 18:44:33 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4053c6f0db8so44436675e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 18:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695606272; x=1696211072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/CGTipvVjSZ3BP+G1gXdYpyR8CRzYcGoUaEJ1H1ROo=;
        b=cH1nibGsEno7h53G+HUXEX5DY7YxWwe8icKDDNkvLsmIHNHnSCgf83RsN2ovsBNdp1
         jCQ5TKOWTgC5TbwESp06TSMaS0dcY3gS/RJNc+RITyNDfJLb+syN5xXT0X3nROTZfV2A
         waN8NNhtxQ6rWvkk+qPna2/+l2RMpqrcu+kgKF26UdOUnBCjezvopykY3wvS3Jn2m5eH
         90JZnKpKYFwCp57pnbnHVxDx16cFxK1v5wT0hkaBAUbVzjiBKxsrjihNscfS7sYj6yMZ
         Tc4MGs+WkVDNwMx+Iqp/7cbz1NQKgbEYl7Vf0dv9i1QtwEDpZNMh/OCdtnh5nx2d6XGA
         mcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695606272; x=1696211072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/CGTipvVjSZ3BP+G1gXdYpyR8CRzYcGoUaEJ1H1ROo=;
        b=ejwl98ZVqI9qVYO1NrPoE/webx9IrBXAz+gFky7T6ifhtbCfgffDeXAcAeAG/MUODi
         YgCnrDc52RYo8j/mjy0x7h6ls9+BpqhuNfdB9arUhNx5ckbQAmPDCp6p03GzN4Dj1G/x
         yP78yZF7V75WZ4pJiBdsqzNFkCqfPbuaEkQPTI4suG8Psk+NgdctcUJBgqfzMVC5u0K6
         MXabHuVWkYurfe1FD7mKyCgouGaxSziN0JRtenmPvClvqd6+PPHFMW35OxFbhPiRIKpN
         wqwUq/xIhMKtdV6IYUQlG+g+PUKkS0y3RuTNEDoKqK+0zpQ2rpIC3osxHHXM0DlBxDnD
         pbTg==
X-Gm-Message-State: AOJu0YzwXgVfsIKvBQNz0cBzLrVBbZg/qLiSq97257J2oBElpCq+0CS8
        ZrtlDzhLuy2oZSl/WU+WQA5OXHsuR/gEDVwA1uLjJw==
X-Google-Smtp-Source: AGHT+IEto/nIwajWxdPEL+t63YAllqUl92DqGJqCOKkzzSeGUIbaehdRQ2XaCYWirPmYDwHDzZuTwM3EKoch6oDtrY4=
X-Received: by 2002:adf:ec4b:0:b0:313:f4e2:901d with SMTP id
 w11-20020adfec4b000000b00313f4e2901dmr5880997wrn.22.1695606271729; Sun, 24
 Sep 2023 18:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230919024943.3088916-1-tylor_yang@himax.corp-partner.google.com>
 <20230919024943.3088916-2-tylor_yang@himax.corp-partner.google.com>
 <20230919-70b2f1e368a8face73468dfa@fedora> <CAGD2q_anfBP78jck6AbMNtgAggjOgaB3P6dkmq9tONHP45adFA@mail.gmail.com>
 <20230919-cc4646dbfb953bd34e05658c@fedora> <CAGD2q_bkTpvXiomWb_yerNjQfMVKOctYgBqF_RBSo_jYqyyyxw@mail.gmail.com>
 <20230922-unclothed-bottom-5531329f9724@spud> <CAGD2q_YsFdDVhE4JCmQSGMWOdpe_yzG8-CdWYPXtjeZsManvgQ@mail.gmail.com>
 <20230922-removable-footwork-f1d4d96d38dd@spud>
In-Reply-To: <20230922-removable-footwork-f1d4d96d38dd@spud>
From:   yang tylor <tylor_yang@himax.corp-partner.google.com>
Date:   Mon, 25 Sep 2023 09:44:21 +0800
Message-ID: <CAGD2q_Y467jJJnwCVH+3F-hh6a-1-OYRugcy0DdjPnTCC77Z8A@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: input: Introduce Himax HID-over-SPI device
To:     Conor Dooley <conor@kernel.org>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        poyuan_chang@himax.corp-partner.google.com, hbarnor@chromium.org,
        "jingyliang@chromium.org" <jingyliang@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 11:31=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Fri, Sep 22, 2023 at 05:43:54PM +0800, yang tylor wrote:
> > On Fri, Sep 22, 2023 at 5:22=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Fri, Sep 22, 2023 at 03:56:25PM +0800, yang tylor wrote:
> > > > On Tue, Sep 19, 2023 at 7:09=E2=80=AFPM Conor Dooley <conor@kernel.=
org> wrote:
> > > > > On Tue, Sep 19, 2023 at 05:31:29PM +0800, yang tylor wrote:
> > >
> > > > > > The behavior of "himax,boot_time_fw_upgrade" seems not stable a=
nd
> > > > > > should be removed. "himax,fw_in_flash", I use the kernel config=
 for
> > > > > > user to select.
> > > > >
> > > > > That seems like a bad idea, we want to be able to build one kerne=
l that
> > > > > works for all hardware at the same time.
> > > > >
> > > > I see, so I should take that back?
> > > > I'll explain more about it.
> > >
> > > Are there particular ICs where the firmware would always be in flash =
and
> > > others where it would never be? Or is this a choice made by the board=
 or
> > > system designer?
> > >
> > Most cases it's about the system designer's decision. But some ICs may =
be forced
> > to use flash because of its architecture(multiple IC inside, need to
> > load firmware to
> > multiple IC's sram by master IC). But if there is no limitation on
> > this part, most system
> > designers will prefer flashless.
>
> Forgive me if I am not understanding correctly, there are some ICs that
> will need to load the firmware from flash and there are some where it
> will be a decision made by the designer of the board. Is the flash part
> of the IC or is it an external flash chip?
>

Both are possible, it depends on the IC type. For TDDI, the IC is long
and thin, placed on panel PCB, flash will be located at the external
flash chip. For the OLED TP, IC is usually placed at FPC and its flash
is embedded, thus the IC size is large compared to TDDI. But from the
driver's perspective either external flash or embedded flash, the IC
itself will load firmware from flash automatically when reset pin is
released. Only if firmware is loading from the host storage system,
the driver needs to operate the IC in detail.

> Cheers,
> Conor.


Thanks,
Tylor
