Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBCE81244B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 02:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442932AbjLNBGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 20:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbjLNBGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 20:06:32 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDB7E8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:06:38 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c9f84533beso87083851fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702515996; x=1703120796; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=peKqQhahD9JRG6w67FwL0sZR7IqqMN+7cEJCPbXgpS8=;
        b=cw/Wz/qBmUDgWvZLY+mt8wuaD0gqN0/KuzCVbuYonRQULoYb6y6stZG5p5X1pukETH
         x8kD44ObrdpdQSS9gbw5DRGSheuDkfm++CnyjVR6KhDfeKIP4/k17QZlWEiw07eArlRX
         hwfHEvF3jnUWAb8NozrTA5cUbzZl1SxRupyJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702515996; x=1703120796;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peKqQhahD9JRG6w67FwL0sZR7IqqMN+7cEJCPbXgpS8=;
        b=n8ouClHhiTz4Mk91GhR6aLBOxnAoJuSGcy09CRuhErUJoENCVU0i6plCLRQEPLtD0B
         kMGrGxuvJt18QuN3hWaVcp0JH9YaYD1ae3Wv3bH+6taz0XefH3cDfnKwlbbN3GtlGkej
         eVyMjE1CjO2QO8joiLz8vOjVlcd8cCQUYe9s3BzRjkzHz/Iar5uFqN/41+f4hh+rTrWa
         o37WQMZbS41hBIazo0jSRA5dtFsdR6l3AM9WzNfO5dDznD6xfynsNywvKOLwN8IqnMJe
         ga53FP1iU+4hGlPiWkDbZDDLbrgcF07GR8eZD4HqVcvfsn8B5js7tdzGs5Ca61OHpBzW
         X7Ng==
X-Gm-Message-State: AOJu0YzjwoFFlUeR21255BXGVVAseoWS8GvPuVxE6kLyYyS62HpNy5Ed
        9DeqfjnQxv70CpsDxhWz/xWncYgMVdjHNAr/vjoJxA==
X-Google-Smtp-Source: AGHT+IHvs8FX8jR+oHMtbXK5cvMpQXiJFEHExpih0ehnbtikW0K8fvGV2686+EyTLWM3fZDJz3SeNMCcCHHM7UeoTbg=
X-Received: by 2002:a2e:a373:0:b0:2cc:2591:bcd3 with SMTP id
 i19-20020a2ea373000000b002cc2591bcd3mr2000691ljn.106.1702515996638; Wed, 13
 Dec 2023 17:06:36 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 17:06:36 -0800
MIME-Version: 1.0
In-Reply-To: <20231213163501.1.I8c20f926d15c9ddc12e423e07df1e89db1105d93@changeid>
References: <20231213163501.1.I8c20f926d15c9ddc12e423e07df1e89db1105d93@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 13 Dec 2023 17:06:36 -0800
Message-ID: <CAE-0n52vfejT7a9Dh177dvD7G3cCx3paB7i_xgSCi=1Z4aE9nw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Switch pompom to the generic edp-panel
To:     Bjorn Andersson <andersson@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2023-12-13 16:35:02)
> Pompom has several sources for its panel. Let's switch it to the
> generic edp-panel compatible string to account for this.
>
> This fixes a problem where the panel wouldn't come up on some pompon
> devices after commit fb3f43d50d9b ("drm/panel-edp: Avoid adding
> multiple preferred modes"). Specifically, some models of pompom have a
> 1920x1080 panel which is _very_ different than the 1366x768 panel
> specified in the dts. Before the recent panel-edp fix on Linux things
> kinda/sorta worked because the panel-edp driver would include both the
> hardcoded and probed mode, AKA:
>
> * #0 1920x1080
>   60.00 1920 1944 1960 2000 1080 1083 1088 1111 133320
>   flags: nhsync, nvsync; type: preferred, driver
> * #1 1366x768
>   60.00 1366 1406 1438 1500 768 773 778 900 81000
>   flags: nhsync, nvsync; type: preferred, driver
>
> ...and, at least on ChromeOS, the userspace was consistently picking
> the first mode even though both were marked as "preferred". Now that
> the Linux driver is fixed we only get the hardcoded mode. That means
> we end up trying to drive a 1920x1080 panel at 1366x768 and it doesn't
> work so well.
>
> Let's switch over to the generic panel-edp.
>
> Fixes: fb3f43d50d9b ("drm/panel-edp: Avoid adding multiple preferred modes")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
