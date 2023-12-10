Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4905680BE49
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 00:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjLJXjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 18:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLJXjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 18:39:45 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E23EB
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 15:39:51 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5c701bd98f3so298265a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 15:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702251590; x=1702856390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRlK8XSOgjLEALc1Z5hQNRyRQl5uMFZ8VhU8lledO9I=;
        b=rZDMmXth+QtQs5MiTf/Iupg1yKdttYePVq4u7N8MVavGkyTOxS5jxkhOmE/CMfoYXE
         4SKUbksEnScIqYGSBl7zsrUX8CSphCmBPM1Td14wlMToL8vsKMokfjiqiJcDWTruskrT
         iI8+s6Prg9jeTnFg6QWtSvVo9R3ZNSRSdDvkfXFcwf+G5luK7FdlEvnkgfBVt9KwG8ia
         6IpDl28rNur6wXFh79eJ3Tq+Rh18Sodz2RhDmw1de3RtKdcnMyio343YL6EIiuY24cUn
         TFq4uRikU7zFOXQKdW5DMRGgpPmF5q31dP5PKzbxb49xOJ3RjSMC4XK4y3FYmZ45JqVT
         WLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702251590; x=1702856390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRlK8XSOgjLEALc1Z5hQNRyRQl5uMFZ8VhU8lledO9I=;
        b=iidrMG1Bxhi+rDbJv6XqGkJHQOa3p653rR+oDFbOiyAw+dT9oOhjPUGhlsC/2iUbc9
         uwts8d0oYJad860fhaXHzXtGL7nZOH2yhlv37PL6a48kiHetE0J0MLlCZKnEyLwSZ5Kj
         K11SJaGNu+XPda1XyPhjavGgn4vomlDHw6izFrf9hDaLaPyMThbKHHKcopd80/6v4mkb
         tDjTcH4qMmR5wXfTaJthHD164ehUOA83/Q7BlrmKjbRY07veNsFvbk2tJhPBa9MXxh/T
         qoIqOLmGTS8HSO3zLRScjlNHifloJ1YnKaXven6EupSJKir+wlX0sor1cziNPYYtdRMI
         5m4w==
X-Gm-Message-State: AOJu0YxBJq+lqCmo5JmQIqxNr9OpuACMt1A/q8uKmPJeXrq+kw7CSdwC
        rAh+Ru65Svprt79pC94JNlvvgV3y4WfdevB3VYpQKQ==
X-Google-Smtp-Source: AGHT+IGsxFuYOhPbXcOyI8L4TnUro7MH402Xh7LjA1I7HZsXimGjb/gGb5R5X025i0dHUk0DjPb38yxObtyCuoxUp/s=
X-Received: by 2002:a05:6a21:998c:b0:190:228e:4c26 with SMTP id
 ve12-20020a056a21998c00b00190228e4c26mr1570718pzb.31.1702251590680; Sun, 10
 Dec 2023 15:39:50 -0800 (PST)
MIME-Version: 1.0
References: <20231210134834.43943-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231210134834.43943-1-krzysztof.kozlowski@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Sun, 10 Dec 2023 17:39:39 -0600
Message-ID: <CAPLW+4nKzYLTPpTAba9X3YmeGwY_avpZoPr=Lw8Uy7ktSkH4_w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: samsung: exynos-sysreg: combine
 exynosautov920 with other enum
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2023 at 7:48=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> No need to create a new enum every time we bring-up new SoC.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  .../bindings/soc/samsung/samsung,exynos-sysreg.yaml        | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos=
-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos=
-sysreg.yaml
> index 2de4301a467d..b00f25482fec 100644
> --- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg=
.yaml
> +++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg=
.yaml
> @@ -17,6 +17,8 @@ properties:
>                - samsung,exynos3-sysreg
>                - samsung,exynos4-sysreg
>                - samsung,exynos5-sysreg
> +              - samsung,exynosautov920-peric0-sysreg
> +              - samsung,exynosautov920-peric1-sysreg
>                - tesla,fsd-cam-sysreg
>                - tesla,fsd-fsys0-sysreg
>                - tesla,fsd-fsys1-sysreg
> @@ -50,11 +52,6 @@ properties:
>                - samsung,exynosautov9-peric1-sysreg
>            - const: samsung,exynosautov9-sysreg
>            - const: syscon
> -      - items:
> -          - enum:
> -              - samsung,exynosautov920-peric0-sysreg
> -              - samsung,exynosautov920-peric1-sysreg
> -          - const: syscon
>
>    reg:
>      maxItems: 1
> --
> 2.34.1
>
>
