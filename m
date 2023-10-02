Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9BF7B594B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238541AbjJBQ6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238453AbjJBQ6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:58:35 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A75DD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:58:30 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-533e7d127d4so18346822a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 09:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696265908; x=1696870708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=facSmfJsGsAsq+rykZ/KF/cMYvD2lkq973HpFZImYKI=;
        b=xBQykIaesmrfPjlBsgXSVF6MSN6ItPcLI6GwrMiU1nDijo6x7QmGIscwbIYOW3s/+9
         JR3VU9KX7iq8onNGHvBh+071MX3vBgbCOGxNmLiUI3CYBu/zFWaCQ54squNcZehRy+52
         bV+99cjA6m52qJiGc8srkeN59Q9PnE4+N52YogqGHuD/CEszNdJjUf763uoXZeA0wzs3
         m6DY31BppsK6atYn++16SGuUuh6s8875ZMQaF9rn/bs/wa4W/uEngEB9XIc9mi6cY/DO
         clUa9D7/MU0t+AB8uW45eRWt9WbCX6VFBHnGaX5VU8598Bum/yQEbrnApQOp9pO0xqTy
         0IGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265908; x=1696870708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=facSmfJsGsAsq+rykZ/KF/cMYvD2lkq973HpFZImYKI=;
        b=vHiRUgSJeZaa/couaq9gxawFrx+epumrM0m/bxlAC/0rGAnlGNihUu0tY0TzIBcS34
         FlClUmzfsNhnZm0J5Q6S0+gLOmgMXsuehDgEUNAhTRKPalDlkiGI/6+gp+ZL5kRuDS/n
         lYTbGy+zahrOZ74kRWCTVfe26Nkxq/QE1jdQmlXmecUOGsNHVXfv5U8I0zx85LRyeFkp
         8JrcuvJEm6i1fyzg1cjoEmcTjz5tLaHTrK1JoXD6pgvF6XLp/zdbolQ2Astpo2z6Cjzt
         mIdTUl5EcS+eqbgMViis3iHL/OqECJqqSPz0QNbzTo/c093thbzIAfW7r/41dMA/UlrA
         VBkQ==
X-Gm-Message-State: AOJu0YzoZZ7T01Ceb4RgveL8z2caU54RW/coI7eQOII/0lGFAzZnEOl6
        POUlyAYXR6nNjdIRppA0Sf/hIsXxPOfq+t/85OnPaA==
X-Google-Smtp-Source: AGHT+IH4U4UmWWwFkhVQ7XVkg+noGoXE0O3GqEQDJBMnj8iiX0hl1ZLoZEEsrGijkmhrJ48540hsp97CzdT/OLdFAOY=
X-Received: by 2002:aa7:cf92:0:b0:533:795d:8c48 with SMTP id
 z18-20020aa7cf92000000b00533795d8c48mr10931884edx.10.1696265908624; Mon, 02
 Oct 2023 09:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
 <20230929-ad2s1210-mainline-v3-26-fa4364281745@baylibre.com> <20230930170046.36637e9c@jic23-huawei>
In-Reply-To: <20230930170046.36637e9c@jic23-huawei>
From:   David Lechner <dlechner@baylibre.com>
Date:   Mon, 2 Oct 2023 11:58:17 -0500
Message-ID: <CAMknhBH4+cUSX_j3-Y0xuTEiZHd3Ke4Zm8FdxLZJwn5gr_d-ug@mail.gmail.com>
Subject: Re: [PATCH v3 26/27] staging: iio: resolver: ad2s1210: implement
 fault events
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev,
        David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 11:00=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Fri, 29 Sep 2023 12:23:31 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
> > From: David Lechner <david@lechnology.com>
> >
> > From: David Lechner <dlechner@baylibre.com>
> >
> > When reading the position and velocity on the AD2S1210, there is also a
> > 3rd byte following the two data bytes that contains the fault flag bits=
.
> > This patch adds support for reading this byte and generating events whe=
n
> > faults occur.
> >
> > The faults are mapped to various channels and event types in order to
> > have a unique event for each fault.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> Use of x and y modifiers is a little odd.  What was your reasoning?
> Was it just that there was a X_OR_Y modifier?  If so, don't use that!
> It seemed like a good idea at the time, but it's not nice to deal with
> and requires a channel with that modifier to hang the controls off
> + make sure userspace expects that event code.


Regarding the point about "requires a channel with that modifier to
hang the controls off...". Although that comment was about modifiers,
does it also apply in general.

There are several fault events that don't have any configurable
parameters, namely _sine/cosine inputs clipping_ and _velocity exceeds
max tracking rate_. So there won't be any attributes that contain the
event specification for those (e.g. no `events/in_angl0_*`
attributes). It sounds like this would be a problem as well?

Should we consider a IIO_EV_INFO_LABEL so that we can have some sort
of attribute (namely `events/<dir>_<channel spec>_label`) so that
userspace can enumerate expected events for non-configurable events?
