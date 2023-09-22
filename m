Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B62C7AAAEC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjIVHz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjIVHzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:55:17 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FEACC2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:55:10 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9ae75ece209so41485966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695369308; x=1695974108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xo0lap6Lgs4aUClULX8HNoJkpzCnX/7Jsbfgdxnl/pY=;
        b=U40KPtjDZ5oaO5BjIETV5ge09nMGO25IctNP7IsHQ1RRdgr+d5AWtS/eOxi9zPPo9P
         pSaNJFh4AXorjtnS6ssNF8FgMJisx0AD5s/ZgRdBXjgsDAa2rQ4zUmM73IRTnk8e05v9
         QoZFjnHJGlsfI2+Sg8EU/WiDfJ7znOgNPgg4msTJV2SUU99KxQEl3EtVMnJqfDzQ1sn4
         SEdQYPehpYYUpnWyxBZSsYAUaXp5W7flb+1GDokdD84vpx+t2/1IhI1WOCuhFZ1z2rTm
         u4EMBp1npo35emO8jl2kkmb6X/H1FiXtRNcH1obDEPaU0S9lmPQf2anXE6fI5+nfXc9V
         w9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695369308; x=1695974108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xo0lap6Lgs4aUClULX8HNoJkpzCnX/7Jsbfgdxnl/pY=;
        b=KUYwgDTsiQy8ci/Igxs68AE6W3qda7LxvIAbsGkS9fi57rsuCriJsLBWeN28PySOr6
         1b4v2zbn8HoOEGK4m7YblS3utjIZOSH2Us5tMrKgjHJ5jlKeugxqhl2H1Pyuu8fQlUP5
         FM8Wcu8f6faRQ9pQnVpk/T1pXDQoMKlFAcSfC6e3vtK9yIcPDfo2Mv+liOFTTy0oYJ92
         7EHMeAuuRBg7MNPwsPYFv9pfftC8pIrDlVUsz9VKZMyCtfTcSq5tvVnyd5pOPBF37jxu
         bpKLnXHvVB+AXm6HXsamTAmQvY1JLnwo7uLIJTfL5YPI1QDjUKRSWxdHuUVApVTaAiS6
         OZiw==
X-Gm-Message-State: AOJu0YxTwgHjjx4C9pn4qw4VgBMt6spGyBcmSTC+exyKV0ekNrX4Lx0P
        JQLzhz2S89d/0UaH69J7KIoN9sbPCcjh4DPC+Ji1gQ==
X-Google-Smtp-Source: AGHT+IHSS1vKwEC9knLhqPNk1Y0RB0kqAke1ZsK8aoLkzIhsG+WewxcfwopOZUPCJajquFT5HL9JcQU2cuAIG7Q6jvU=
X-Received: by 2002:a17:906:2009:b0:9a5:c49e:7145 with SMTP id
 9-20020a170906200900b009a5c49e7145mr6718209ejo.69.1695369308485; Fri, 22 Sep
 2023 00:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230920170253.203395-1-dlechner@baylibre.com>
 <20230920170253.203395-5-dlechner@baylibre.com> <20230921154514.GA383967-robh@kernel.org>
In-Reply-To: <20230921154514.GA383967-robh@kernel.org>
From:   David Lechner <dlechner@baylibre.com>
Date:   Fri, 22 Sep 2023 09:54:57 +0200
Message-ID: <CAMknhBEVLZYQieKPCCf8QHp7H06Vsdobg_7qGm+MsbL8Kg-VCQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] iio: resolver: add new driver for AD2S1210
To:     Rob Herring <robh@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 5:45=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Wed, Sep 20, 2023 at 12:02:53PM -0500, David Lechner wrote:
> > This adds a new driver for Analog Devices, Inc. AD2S1210 resolver to
> > digital converter. The driver is based on the staging driver with the
> > following improvements:
> >

...

> > - Use devicetree to specify resolution instead of sysfs attribute.
>
> Why? sysfs allows a user to change at run-time. DT is a firmware
> change. What/who determines the resolution? Unless it's the hardware
> design/designer, it probably doesn't belong in DT.
>

This one is a bit of a gray area since it could be either way. The chip
has two input pins for selecting the resolution. If the hardware
designer decides to connect these to gpios, then they could be changed
at runtime. But if the hardware designer decides to hard-wire these pins
then we need to supply this information via the devicetree.

The choice of the resolution is determined by the physical requirements
of the full system. This device measures rotational position and velocity.
So the main reason to pick something less than the full 16-bit resolution i=
s
if the max rotational speed of whatever is connected is going to be greater
than 125 revolutions per second (assuming 8.192 MHz clock).
