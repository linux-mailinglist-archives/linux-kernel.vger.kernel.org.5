Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227E97ADD6D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjIYQvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjIYQvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:51:02 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D648A3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:50:55 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-530bc7c5bc3so8282365a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695660654; x=1696265454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZK0Wa94mxZD4Pin962qT1kXm8aCjboYY+1emX2oQt8o=;
        b=sTX3oWz7/sQOFw4grHxlbdyTDvsZMHWij1UGf48nQAVRPhQsdHP8nQ4edf9NWjEHoR
         uu0TORJ6fRzVRtZJPdm7CTUYkHrTYERWHrAc1C3zp/fIta3JYzKoV9sywMF0bdGPnZZ6
         2dqtFY8vmDUckTWAY6pW9yc4SDIXFkC0ESQ3vfWEJd0xSpo0wJ6QTVIoODxlv+2dyfOG
         YZm86B900PjKKIk0tCs5PJNBnDsnP2/Mb5DLbvkli2/xLUY/44iP7UexiRN1328RahIx
         DhHJCJc9Aw7prSAKGGZa/KLKBoTvIDMuMFrZlq4Z+AkMi7YWJpO0XLa/8TB1R/tItVjf
         bIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695660654; x=1696265454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZK0Wa94mxZD4Pin962qT1kXm8aCjboYY+1emX2oQt8o=;
        b=lRVEY/pPbus2FB/dxzcIRL0XtcMBWYzQC6BTMNhJGzle76AXQ6pal3AKmqrivPncun
         nx8GyjkZfkSnSndtF8e6DGm079G6NwfYtLr7VTxY5UEyQSJ9CHy9ZLrtQ64n5ZWbEx3A
         LSxP7aBIvxoF23Iy2EGY2SG5m60lvekPPhCBcYTRTYD4ILbRm+ZN8rwmBwTwWN/ac69I
         HENBE080dPjuyR/w4TW/cgVAc/IPywzNdDoOliQSgNZ8TkQIwKk6yVgdf2A/IL08OmAW
         gROVGXzLfUCFvI1sip9CbhL/cpvpszFPfI+unbAtcm8WIVHKmVOci4cjYDnnG52knXTq
         yjFA==
X-Gm-Message-State: AOJu0YxIbCbsbTBzquS1uxvk7tuI0Mg5PqXsmpRiiOz5Xw4sk5KogxNx
        cNjyFbsg+c9sYQJeHe30dGgFQLj6Xceu+DWIOSEy0kMWyPNilbRHlqU=
X-Google-Smtp-Source: AGHT+IGsoV4g2+LteE9K/8LeYzh2EooZgBJOexrqD04mHD3rKyBP8T2APAtV0W+DIdvP1cPsq3xQo6gHIvL+/9I2E1o=
X-Received: by 2002:a17:906:51c9:b0:9ae:82b4:e309 with SMTP id
 v9-20020a17090651c900b009ae82b4e309mr6645063ejk.0.1695660653836; Mon, 25 Sep
 2023 09:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230921144400.62380-1-dlechner@baylibre.com> <20230921144400.62380-20-dlechner@baylibre.com>
 <20230924191711.244ec842@jic23-huawei>
In-Reply-To: <20230924191711.244ec842@jic23-huawei>
From:   David Lechner <dlechner@baylibre.com>
Date:   Mon, 25 Sep 2023 11:50:42 -0500
Message-ID: <CAMknhBFE49iGkZyP4rdqAmJwY5KnJ0X9UAPC54=BdQFfNuA+kg@mail.gmail.com>
Subject: Re: [PATCH v2 19/19] staging: iio: resolver: ad2s1210: add triggered
 buffer support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 1:17=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Thu, 21 Sep 2023 09:44:00 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
...
> > +             /* REVIST: we can read 3 bytes here and also get fault fl=
ags */
>
> Given we have fault detection outputs, does it make sense to do so?
> Or should we just rely on those triggering an interrupt?
>
> > +             ret =3D spi_read(st->sdev, st->rx, 2);
>

I'm thinking the former would be better, but I have a pending inquiry with =
ADI
to get more info on this since the fault pins and/or fault registers
don't seem to
be working quite like the datasheet says they should (I am seeing fault bit=
s set
in the register without the fault pins being asserted).
