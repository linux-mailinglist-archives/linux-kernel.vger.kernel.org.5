Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960A27E2F20
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjKFVtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjKFVtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:49:10 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB57134
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:49:07 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c595f5dc84so63475271fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 13:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699307345; x=1699912145; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMUtXedtMfHyVhpNXb+9y7B6UprnYxiJrIY/x/1tAbY=;
        b=fEtKcaBijM5yRdeB72nVnob3ImfXVWOdIGpNtRTrqZsEirDoanhYDVaXUCUli/qLZx
         Dz5ki8EzfTMSNP5pXZlRVr+yC1bSk/ysNq1B7iHexm0fl6+6c9f4j00TuQkqOxrpXNgL
         NoaT8eWUbxoGnFDZvtqkOIESybUndGAcPWGzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699307345; x=1699912145;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMUtXedtMfHyVhpNXb+9y7B6UprnYxiJrIY/x/1tAbY=;
        b=oqjmvaAaQF4OL49ph3dKLvdsIkiHiMbRJHebZLPuqZdv6GVZbWfZSiLDG+PERA0/pj
         4RHWgHUtFmRjWxweedClHVxqbHLjj/NCJYunIOoZrugGOTV8HnvuXkJJXH7CgH06ic+A
         O9XMVBzECjxNatjKaA1aQaixfh0wCbUTH1X45dKc8uq5qapVw3AgDe6Bx2mhyt+hVqGn
         ena86hw74Egj4VD+ifPzmuEkPGXXRlnxgZ6RVRGx78pJCfclNWzXXZrpPQm7LEhGHCFf
         HfQh4mPwHPZFXw6kDCBDQGIx6F/KzWxQTZiMOVUS5CSg2sQSSwrNvJsMDff94kAOGGlL
         TaGw==
X-Gm-Message-State: AOJu0Yyr7PjbrjTZU7+poxlW9a5/fDuc4pIPbfksUfGDjtEYVQIqDZzr
        m3pHTSmYduz9VKwk9Mh9KzyPvbzz5PPrM2kRTBY3QA==
X-Google-Smtp-Source: AGHT+IHCr0f4oobPmpg4io2bupLLG0IzNyyolPOrELq/1yG34ld0ri2ZpgidIQCoT1Gj/+EHt+le3Xj3RzSVW9Xl5Dc=
X-Received: by 2002:a2e:978d:0:b0:2c5:2357:c6a7 with SMTP id
 y13-20020a2e978d000000b002c52357c6a7mr253471lji.17.1699307345582; Mon, 06 Nov
 2023 13:49:05 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Nov 2023 13:49:04 -0800
MIME-Version: 1.0
In-Reply-To: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
References: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 6 Nov 2023 13:49:04 -0800
Message-ID: <CAE-0n50vtad5hkkAuV-hvsnm+tTevd_4OSr3iGofBa5L8A0RQw@mail.gmail.com>
Subject: Re: [PATCH 1/9] arm64: dts: qcom: sc7180: Make watchdog bark
 interrupt edge triggered
To:     Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-watchdog@vger.kernel.org, linux-arm-msm@vger.kernel.org,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2023-11-03 16:34:27)
> On sc7180 when the watchdog timer fires your logs get filled with:
>   watchdog0: pretimeout event
>   watchdog0: pretimeout event
>   watchdog0: pretimeout event
>   ...
>   watchdog0: pretimeout event
>
> If you're using console-ramoops to debug crashes the above gets quite
> annoying since it blows away any other log messages that might have
> been there.
>
> The issue is that the "bark" interrupt (AKA the "pretimeout"
> interrupt) remains high until the watchdog is pet. Since we've got
> things configured as "level" triggered we'll keep getting interrupted
> over and over.
>
> Let's switch to edge triggered. Now we'll get one interrupt when the
> "bark" interrupt goes off we'll get one interrupt and won't get

"We'll get one" twice?

> another one until the "bark" interrupt is cleared and asserts again.
>
> This matches how many older Qualcomm SoCs have things configured.
>
> Fixes: 28cc13e4060c ("arm64: dts: qcom: sc7180: Add watchdog bark interrupt")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
