Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3727F42CC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343712AbjKVJuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343692AbjKVJuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:50:00 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C7C1BFC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:48:41 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-daf2eda7efaso6404063276.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700646520; x=1701251320; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OgOu9OX/gdDlTcObaS5UnH2tHRUs1zEOv8i4Nf8OEww=;
        b=ZWgqgljSDZpiqAPRGgtQAGps5T2tAKFw1j7wikGqmpfBRLUIn4JcaVga8ysDzmVsHu
         HCpXHykHcVyd0pz0rb1sLZXN2iBYVVLa7nDY6L9y7HVMV6uCAzKppxp5k9VsRkHWhj+9
         6/i17+7go7L6/JM9vKXRtgVDIjKmNTi083XZExL2F1eC0JmTQtjNOMqDJI2g4g601njd
         a84Flh3K+G3/ocHiO5vDSN0RcbD146Bl7ptn5EmCD+2r3O0rjhGUrWPgY2clmxCx7t+h
         6oo3l5edJcINFVE6OZqAAGvSsMdhg5Do+Kx0AbvVLzxwkyhro9pxvyIK726u00JqRb8/
         8UYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700646520; x=1701251320;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OgOu9OX/gdDlTcObaS5UnH2tHRUs1zEOv8i4Nf8OEww=;
        b=daF7vxbB4ZSWFDaaxa7CyG9ETmhJyEfXNiU/Hafn7n1f3XKZue95lmaSuu5H76qB24
         ma+TiLhcVbFUIAb8k+dhEfKWC5SoINcLvXhYkO1LFwKhqw2+J/l59LilknAAQnqP4EGy
         DBFTVVEW1mkpdHUKu6s39mMyJTCGQus7W2i2eefK16kkaT1MJCLWy4mFcgYOBjzUp9X4
         CWQI0PFb1LvwTnkdhqtCMKHSOvkvrN38NVrQGVg/KfO3tRLBxB6/dZjFUzUIy1WeYR5R
         1k1tyXCF5MaUwNEiUXakSlovMnp+BwDZ+AgLRGxfd4nuw3WGMNx0rBeIr7k88QjAU7b6
         kJHA==
X-Gm-Message-State: AOJu0YxStyZXv4wf74ZldaPCTY8ZAM03RPEUKFahu9C1mGTAz37QkKTx
        4RsUq4Bw1s6NExyEji59N6Jl9Ckrmc2/Db0iHBvddB7J3GU1kPqo
X-Google-Smtp-Source: AGHT+IGEx2UFEWBYXKoM1hxVrMkNovyA5JKzYrMvxDK90RIoFbZvnci5tNlT3RfwuPABorNkQoKIuBP1BwH2xgMp040=
X-Received: by 2002:a25:e812:0:b0:daf:81e5:d2fa with SMTP id
 k18-20020a25e812000000b00daf81e5d2famr1697557ybd.33.1700646520191; Wed, 22
 Nov 2023 01:48:40 -0800 (PST)
MIME-Version: 1.0
References: <20231114-msm8909-cpufreq-v3-0-926097a6e5c1@kernkonzept.com> <20231114-msm8909-cpufreq-v3-3-926097a6e5c1@kernkonzept.com>
In-Reply-To: <20231114-msm8909-cpufreq-v3-3-926097a6e5c1@kernkonzept.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 22 Nov 2023 10:48:04 +0100
Message-ID: <CAPDyKFqQoq0DdsxdrKUW9awL1HOn3NCEgqpnzD+=S5fb0aJLEA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] pmdomain: qcom: rpmpd: Set GENPD_FLAG_ACTIVE_WAKEUP
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 at 11:08, Stephan Gerhold
<stephan.gerhold@kernkonzept.com> wrote:
>
> Set GENPD_FLAG_ACTIVE_WAKEUP for all RPM power domains so that power
> domains necessary for wakeup/"awake path" devices are kept on across
> suspend.
>
> This is needed for example for the *_AO ("active-only") variants of the
> RPMPDs used by the CPU. Those should maintain their votes also across
> system suspend to ensure the CPU can keep running for the whole suspend
> process (ending in a firmware call). When the RPM firmware detects that
> the CPUs are in a deep idle state it will drop those votes automatically.
>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/pmdomain/qcom/rpmpd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
> index 07590a3ef19c..7796d65f96e8 100644
> --- a/drivers/pmdomain/qcom/rpmpd.c
> +++ b/drivers/pmdomain/qcom/rpmpd.c
> @@ -1044,6 +1044,7 @@ static int rpmpd_probe(struct platform_device *pdev)
>                 rpmpds[i]->pd.power_off = rpmpd_power_off;
>                 rpmpds[i]->pd.power_on = rpmpd_power_on;
>                 rpmpds[i]->pd.set_performance_state = rpmpd_set_performance;
> +               rpmpds[i]->pd.flags = GENPD_FLAG_ACTIVE_WAKEUP;
>                 pm_genpd_init(&rpmpds[i]->pd, NULL, true);
>
>                 data->domains[i] = &rpmpds[i]->pd;
>
> --
> 2.39.2
>
