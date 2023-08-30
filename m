Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88E778DBE7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239115AbjH3Sj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245186AbjH3OoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:44:02 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429351A3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:43:57 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe15bfb1adso8872632e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1693406635; x=1694011435; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7y1PTlMIpI19ndr06GdGR/gezHXVIuarLmJLhteMMeY=;
        b=LYzzjbHgvGqKeGAc0j1Jmdyyz6FO1+DODQ4KJ9WUt6w2aRG++2plKYtoEyWxDiX8en
         lHIkhRnCXgg9AJdb2BHPr5i1HXPeYojczAsnVzbWKiQgsSqlkT6VcV6QoT3xyGm92WGP
         n5LhkCdaqb9m5AK9vgcTV1mWYC1HQy9F1DxjIkiF3zrEE8d5yy1jNscF8ER54RpbOkRb
         hqD0Hsu/kkelpidCNm5Zpe4GU/tK9JrNiInNtl16JLxRkvwcU2PSzwkn7bE/57iOKCWA
         J4Js6VPp5/baHjwIzrLzIsNWRTdMhRSG/CMSeVqmUfApjrXFRNKqQzx+TZcwj9qEUWec
         N5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693406635; x=1694011435;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7y1PTlMIpI19ndr06GdGR/gezHXVIuarLmJLhteMMeY=;
        b=OOGyHMmN7rdwBgLXOc4DCuFsud0nJljjQsVrQnliBZdhBr88mzoS89rBFtch2kv1kk
         4c6V8kyS8W+BBjX7/iy2BHLjtsz67zyESl3gk4hAJH+4rwKBOXIjvP2j4UFNZuxGVbD1
         c6Bcc/duRKlXoHpWkdrJKQDS6MTTH1S4zx3TL1WaD499gS/PqQ0QJEXTX/2ZakEQQOfJ
         uDnoCgYrvBt1bE83vDfKYyqMXTbir1IlLwLJ8oYZ0J4yiP4TcMf9BIS0KUQyhlyKklGH
         JjAO3hgWntT4QNgvUHNlnEAj5CpN21yLYgllwQt27jDHq74Se9wktFFRrTwMHi7D3oLI
         nE0A==
X-Gm-Message-State: AOJu0YxxuaDG0QSJAn/5H+hXgOJDFAMJcP63EJF5ll4ey8YtyspAsJAt
        Z51I7EjF9iaybrWLJy3lHUa24A==
X-Google-Smtp-Source: AGHT+IHeygykVFMcBkeCr9Jim8Aiw37Bu4dqw61S/Zwn8g9GABuB2bPsegjI40haOVmM0BZ3MWr+/Q==
X-Received: by 2002:a19:5e18:0:b0:500:95f7:c416 with SMTP id s24-20020a195e18000000b0050095f7c416mr1823828lfb.7.1693406634763;
        Wed, 30 Aug 2023 07:43:54 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id l15-20020aa7d94f000000b0052568bf9411sm6787493eds.68.2023.08.30.07.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 07:43:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 30 Aug 2023 16:43:53 +0200
Message-Id: <CV5YJVXIL8OT.1ZWW3KVCHPTA5@otso>
Cc:     <cros-qcom-dts-watchers@chromium.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 02/11] nvmem: qfprom: Mark core clk as optional
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Doug Anderson" <dianders@chromium.org>
X-Mailer: aerc 0.15.2
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
 <20230830-fp5-initial-v1-2-5a954519bbad@fairphone.com>
 <CAD=FV=WS2hgY=bQjLOs3Fdp8pbZyMsaS-0BpoxPq90Etfi+Xuw@mail.gmail.com>
In-Reply-To: <CAD=FV=WS2hgY=bQjLOs3Fdp8pbZyMsaS-0BpoxPq90Etfi+Xuw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 30, 2023 at 4:30 PM CEST, Doug Anderson wrote:
> Hi,
>
> On Wed, Aug 30, 2023 at 2:58=E2=80=AFAM Luca Weiss <luca.weiss@fairphone.=
com> wrote:
> >
> > On some platforms like sc7280 on non-ChromeOS devices the core clock
> > cannot be touched by Linux so we cannot provide it. Mark it as optional
> > as accessing qfprom works without it.
> >
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> >  drivers/nvmem/qfprom.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Are you actually testing burning fuses from the OS, or are you just
> using the nvmem in "read-only" mode? From comments in the bindings, if
> you're trying to burn the fuses then the clock is required. If things
> are in read-only mode then the clock isn't required.

Hi Doug,

I definitely don't plan on burning any fuses on this phone. Not even
sure that's allowed by the TZ / boot stack.

>
> When I compare to the driver, it seems like the driver assumes that if
> more than one memory region is provided then you must be supporting
> burning fuses. The bindings agree that having 4 memory regions
> specified means that the nvmem supports burning and 1 memory region
> specified means read-only. The extra 3 memory regions in the nvmem are
> all about fuse burning, I believe.
>
> So maybe the right fix here is to just change your dts to specify one
> memory region?

I got feedback from Konrad that this here would be the preferred
approach compared to having a different dts for ChromeOS vs non-ChromeOS
devices. I don't feel strongly to either, for me it's also okay to
remove the extra memory regions and only have the main one used on
regular qcom devices.

Let me know what you think.

Regards
Luca

>
> -Doug

