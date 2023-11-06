Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF027E2F5E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjKFWAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjKFWAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:00:03 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9F811F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 14:00:00 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so70519041fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 14:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699307998; x=1699912798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNAdiaf7CFJFGR+XgzzaLNcE9ebdwuse14Opfb1nM5c=;
        b=kcAAVMP10DTDI2ae70aEJp0Gd55mBciOjpjv+jBt1LqnCXGssXHFPj9tl0rG2yEP9K
         Tt2LBd+nXhPfo6aFCxYNHDmWBw9i6fyNEdKJNM+kFUsrYWJy+GFVjxqMgtZFdvwQeZ+l
         x1GlLVogdxV3J1kkE7NZ3klePV2SLioSXKhSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699307998; x=1699912798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNAdiaf7CFJFGR+XgzzaLNcE9ebdwuse14Opfb1nM5c=;
        b=psrjpdvt1web1JblOem/0RijLQt6EczGk5/KeK0T3a/5d4ZNn/mdbXOPqxodoH85kA
         flBp2ct+c0flAMVtoRR1tuUFugoNoLeN68JoIp3JM1ccsCTAhgF5p6dH8lJPCSDYobPA
         PfSsSXb/wBJ+hQsr6tXywk5+u+eVq1fJ6EjubDe3kTFtW13iuP10SAFdNTnaB63PEnwc
         cVluUBT9h3BuX9Lq7CSpSgxPs0kXrbqx4i3FZuYuc6s3+S9uxFMJHiLwU2XxtupV47D8
         HSjhVC0bf1J9BMWI3U1vfDldEdTq76UGAwqASbAqB8tNpeTwv8XMupHkbvOjZ5aHFlxf
         0hCQ==
X-Gm-Message-State: AOJu0YzkuG1IDO1+oC9gtD1XLWezJc6iLrqzKcF4oEfmiKC6pOy3BUEN
        Mv1WxeLrnC1ElS7T25m2hiYH8zOmLChM+qCXMfUUIUVb
X-Google-Smtp-Source: AGHT+IFlWKrrZqaZ63jhXg+XryqO5vJAtq6AMh1DIb2lXdUfImgRobQThi+TJEt/wJO9nUa/zcqdhg==
X-Received: by 2002:a05:6512:31d0:b0:508:1332:558a with SMTP id j16-20020a05651231d000b005081332558amr28782819lfe.2.1699307998470;
        Mon, 06 Nov 2023 13:59:58 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id i6-20020a196d06000000b00509495d8a3csm102963lfc.255.2023.11.06.13.59.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 13:59:58 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-507a5edc2ebso370e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 13:59:58 -0800 (PST)
X-Received: by 2002:a05:600c:a005:b0:408:3727:92c5 with SMTP id
 jg5-20020a05600ca00500b00408372792c5mr40609wmb.2.1699307595154; Mon, 06 Nov
 2023 13:53:15 -0800 (PST)
MIME-Version: 1.0
References: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
 <CAE-0n50vtad5hkkAuV-hvsnm+tTevd_4OSr3iGofBa5L8A0RQw@mail.gmail.com>
In-Reply-To: <CAE-0n50vtad5hkkAuV-hvsnm+tTevd_4OSr3iGofBa5L8A0RQw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Nov 2023 13:52:58 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UJE6VKrjFJ2g=4qRHLdnqymossWSAFeKyUykxm1sTCtQ@mail.gmail.com>
Message-ID: <CAD=FV=UJE6VKrjFJ2g=4qRHLdnqymossWSAFeKyUykxm1sTCtQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] arm64: dts: qcom: sc7180: Make watchdog bark
 interrupt edge triggered
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-watchdog@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Andy Gross <agross@kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Kees Cook <keescook@chromium.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Tony Luck <tony.luck@intel.com>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 6, 2023 at 1:49=E2=80=AFPM Stephen Boyd <swboyd@chromium.org> w=
rote:
>
> Quoting Douglas Anderson (2023-11-03 16:34:27)
> > On sc7180 when the watchdog timer fires your logs get filled with:
> >   watchdog0: pretimeout event
> >   watchdog0: pretimeout event
> >   watchdog0: pretimeout event
> >   ...
> >   watchdog0: pretimeout event
> >
> > If you're using console-ramoops to debug crashes the above gets quite
> > annoying since it blows away any other log messages that might have
> > been there.
> >
> > The issue is that the "bark" interrupt (AKA the "pretimeout"
> > interrupt) remains high until the watchdog is pet. Since we've got
> > things configured as "level" triggered we'll keep getting interrupted
> > over and over.
> >
> > Let's switch to edge triggered. Now we'll get one interrupt when the
> > "bark" interrupt goes off we'll get one interrupt and won't get
>
> "We'll get one" twice?

I like to make like to make typos. If you hadn't hadn't noticed.

I'll wait another few days and send a version with the typo fixed
unless Bjorn tells me not to (because he didn't care and applied it
anyway or because he fixed it himself while applying).


> > another one until the "bark" interrupt is cleared and asserts again.
> >
> > This matches how many older Qualcomm SoCs have things configured.
> >
> > Fixes: 28cc13e4060c ("arm64: dts: qcom: sc7180: Add watchdog bark inter=
rupt")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Thanks!

-Doug
