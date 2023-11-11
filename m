Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C827E86E4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 01:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344843AbjKKAW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 19:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjKKAWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 19:22:55 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA25420B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:22:52 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50797cf5b69so3518038e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699662170; x=1700266970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7To0W+4U1gHtnYyGtgD0VBuArtwhrF2fE4verOw+Uo=;
        b=X/78mtgiI7sMRqciX71UbbNKihGxr/x5QFCnCMLtAvRtDTZxX/AhiTQPysymkMk82u
         e8yAtS6ILkBBT+DHnXA6HFtXZJ8JN5s0jld+VfdxjDdjXhaOJ0ol6jyUKNbzLgOnWiud
         fBZrES31xOHI940dxqDBptW+jVEmT/P4Mvrj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699662170; x=1700266970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7To0W+4U1gHtnYyGtgD0VBuArtwhrF2fE4verOw+Uo=;
        b=m9UP5iiLmh5HnvAWlNmqIRERWzRSF/e9lswNPZqd8GBSmLLY0RU4R15ni0CwmcZCjz
         2goyxXvOk4h/Bn+N/9EQPqD19ObMleRCxUtCzHctjkpXuaaAEaFyahqJ37POTxytuEHZ
         teYeAHepVRW7Pt6yp9n7DUTB7lK4ocg8UuyHl6tk3dzMBiMlIPymmFPWWbilFnxPn5TR
         tKNm/xOrZYnCHoPTFPF/y3SxHdbo7Zk/Bnb/AUe2BLrgiapZ6cKwCFjtuvxJvM4BDSMt
         91dGN2H6qrI8UHSYYqU94nJkfVRtq4Lwa3g0GTrLGjKN++WAp7MGvYJuFYXEtvSJNTmb
         Lcdw==
X-Gm-Message-State: AOJu0YwaQycNl/1E3G0IvAQ38HGz3i9VRBti9uvF42g7nN0OsPG1ptJN
        6X01gzEqYBXHUQVBaR7h7JrEaVqNcqrmujPYhttIZH5r
X-Google-Smtp-Source: AGHT+IEFp2Oxp1VrRfcFq9AMQNlPKiqsniyn03fD98ogJUTrCCwyuXnWh6jDI5kC4dakXpdpFAqdlw==
X-Received: by 2002:a05:6512:312d:b0:507:a6e9:fbba with SMTP id p13-20020a056512312d00b00507a6e9fbbamr349339lfd.63.1699662169702;
        Fri, 10 Nov 2023 16:22:49 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id d11-20020a0565123d0b00b00502ae8db086sm100232lfv.19.2023.11.10.16.22.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 16:22:49 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50931d0bb04so1068e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:22:49 -0800 (PST)
X-Received: by 2002:a05:600c:1d07:b0:408:3727:92c5 with SMTP id
 l7-20020a05600c1d0700b00408372792c5mr32280wms.2.1699662148320; Fri, 10 Nov
 2023 16:22:28 -0800 (PST)
MIME-Version: 1.0
References: <20231109100606.1245545-1-wenst@chromium.org>
In-Reply-To: <20231109100606.1245545-1-wenst@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 10 Nov 2023 16:22:16 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WZCyp1aaSmpF-_TQ0CTWG1ZuvPZVw4mR=wJH=NTkKqqg@mail.gmail.com>
Message-ID: <CAD=FV=WZCyp1aaSmpF-_TQ0CTWG1ZuvPZVw4mR=wJH=NTkKqqg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] of: Introduce hardware prober driver
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        andriy.shevchenko@linux.intel.com, Jiri Kosina <jikos@kernel.org>,
        linus.walleij@linaro.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        james.clark@arm.com, james@equiv.tech, keescook@chromium.org,
        petr.tesarik.ext@huawei.com, rafael@kernel.org, tglx@linutronix.de,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 9, 2023 at 2:06=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> wr=
ote:
>
> The driver as
> implemented currently doesn't deal with regulators or GPIO pins,
> since in the existing device trees they are either always on for
> regulators, or have GPIO hogs or pinmux and pinconfig directly
> tied to the pin controller.

I guess I won't object too much about this limitation for v1, but IMO
it would be good to get this sorted out since I think part of the
power of having the HW Prober is specifically that it can handle this
type of use case. You have a little bit of board-specific code that
knows how to turn on the regulators / GPIOs and can then probe the
devices.

Note: even if this is "board specific", it doesn't mean you couldn't
share code between boards. For instance, you could have a helper
function that would turn on regulators/GPIOs based on some type of
table and that helper function could be used across a whole pile of
Chromebooks. If a Chromebook is sufficiently different that it
couldn't use the helper function then it could call its own function,
but presumably it wouldn't be hard to support a bunch of boards
without much code.

As part of this, I think that your main "HW Prober" for Chromebooks
should be in "drivers/platform/chrome/". I think that the only things
that should be in the "drivers/of" directory should be helper
functions used by the Chromebook HW Probers.


-Doug
