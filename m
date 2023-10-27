Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6B27D9295
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345544AbjJ0Isi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjJ0Ish (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:48:37 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F3DC4;
        Fri, 27 Oct 2023 01:48:35 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bee11456baso1732929b3a.1;
        Fri, 27 Oct 2023 01:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698396514; x=1699001314; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nvOPHwGJQebkrMEWHUin3lPRoZdTkotFVHLS8/2H+/s=;
        b=fuvom1zTlz+Rvjuo3K0pg83kKLjTEwICewWV0nchTcM8gliC2IvFzEbMLlgdz981iC
         eOWFqctq+7iHYHFtBZ9A9WeVtaHQ/Fz+y73SpXgK8yiT3SFUI33aZvcILiSQsBlO/A8X
         3QSyYApjLR7QIH5xIG+VizDFhR5vnKXMY4BrOwqMEvVFt8YxeXSskq2jDLyrShSs7CGp
         0VsGD5OkAufcGc5Q/du0mKAGUMdZmUH8QzL2z2dTtLwUJeRQnTfcHI5263qR7rQY5KBd
         /7/bYguXMHeJKlPggge8pmIUO/rCCKrvIjLCmEhv3qsEreZ3vjounfF3ulcVgpvu/mnI
         RxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698396514; x=1699001314;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nvOPHwGJQebkrMEWHUin3lPRoZdTkotFVHLS8/2H+/s=;
        b=g1K7wzHh4yrPKxPeNZVXpUnn+S2D4f0dGZ6sXzriyhOYGR5IQZiy8VeilelA4vWSnf
         UUza/cOI8GT0RZx/yHeJcRn07kMVP+o9M+DPFsSM21afgwOGQxVOTivMaY4XZlteN5c1
         rWQMfexhXr4QYm3BBAj5sV3TffLIM8KWEYLjRYq8hmMMomQvprUzPqVRtwU+z4uIDhL3
         mmIjCkDzdu1vtrr5CPkdnRcvXWoxVoC4xJqXbBOeEmVu4TmMEIXDOBcwmCPHl1VrAVig
         5eXR1I9C0bg7LLdXS4jqVrptzZ0vzDynaNvKK3I6GFVq4aAUx1c7oyz331uEjqIL6PCZ
         f+/g==
X-Gm-Message-State: AOJu0YynXrtFN8488NuH83mHfJ/Mr00jtWNRLQzXTX1SkT7jl++3T83l
        DZXosmi1ZPHxFOa0ndkJ9zcJFgowhZPTEdARiTA=
X-Google-Smtp-Source: AGHT+IEPjsu0T5+FwEyTwM9n0U+omys2gq3u41JIwN/UvpWdbPS/4nRe4abawxvVWdlF+P6OxrHSTyQYByprePhJgZs=
X-Received: by 2002:a05:6a20:7489:b0:174:2286:81f4 with SMTP id
 p9-20020a056a20748900b00174228681f4mr2266082pzd.14.1698396514550; Fri, 27 Oct
 2023 01:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231025104457.628109-1-robimarko@gmail.com> <20231025104457.628109-2-robimarko@gmail.com>
 <77314fe2-2936-4f89-a347-4eb288507c47@linaro.org> <1b99abed-6572-4550-98cc-56667a507883@linaro.org>
In-Reply-To: <1b99abed-6572-4550-98cc-56667a507883@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Fri, 27 Oct 2023 10:48:22 +0200
Message-ID: <CAOX2RU7gXAJM8xYOc2G__2HSQCQKuy5sUcXoyr_a8WKndD1yLg@mail.gmail.com>
Subject: Re: [PATCH 2/3] clk: qcom: ipq6018: add USB GDSCs
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 at 20:45, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 10/26/23 20:42, Konrad Dybcio wrote:
> >
> >
> > On 10/25/23 12:44, Robert Marko wrote:
> >> IPQ6018 has GDSC-s for each of the USB ports, so lets define them as such
> >> and drop the curent code that is de-asserting the USB GDSC-s as part of
> >> the GCC probe.
> >>
> >> Signed-off-by: Robert Marko <robimarko@gmail.com>
> >> ---
> > Applying patches 1 and 3 without this one breaks usb, no?
> Sorry, my hands don't keep up with my brain - that's almost another
> speculative execution vulnerability!
>
> What I meant to say is:
>
> applying patches 1 and 2 breaks USB
>
> but
>
> the solution here would be to apply patch 1 and patch 3, followed
> by patch 2 (unless it will make the USB defer, IDK, it's probably
> easier to just test than to dive deep into the code)
>
> with Bjorn taking both subsystems, we can make that work I think

Hi,
Applying patches 1 and 3 without patch 2 will make USB fail with:
# [   11.351681] dwc3-qcom 8af8800.usb: deferred probe timeout,
ignoring dependency
[   11.351729] dwc3-qcom: probe of 8af8800.usb failed with error -110

And yes, applying patches 1 and 2 without patch 3 will also break USB.
That is why I sent this as a series.

Regards,
Robert

>
> Konrad
