Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6E57E2F45
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjKFVxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjKFVxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:53:11 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCEDD77
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:53:08 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c6b30aca06so66223761fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 13:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699307587; x=1699912387; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HkpT9CEuO4oeNZA+gSVgeEf0FhGOZvNqxNd+YET8As=;
        b=Y4LFiymOWRC2pu3q2VSajhW0uMEzKAIBDRJ2iDwBT/HkuZtKfOZs0r4RiaaldqQCNu
         o38LrxcMxL4w54KJ70mFQCgq71IZLpYHRShs0RbYEYlmrA8d9ybUHKUBgk1eMhBssPpW
         zaxEW6ijxLPNjFAIEHesjqSXq6WKSsa+TsnpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699307587; x=1699912387;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HkpT9CEuO4oeNZA+gSVgeEf0FhGOZvNqxNd+YET8As=;
        b=g7516p9ZmzuF1J5VZHXJQ+rUnb5tuQhnh9k/WzYRLSkmg+6PckiVwXcCf9JoZoqjey
         rDaCnu5D2lGIcwNa9EA5j2jZQwTQbHmHWIZ+j1YAucsQdzx4X58+McqTPJINspoYcA0u
         RejZvrw76kIZywKxD0Yr0R5AQzFg3+dx43QoTyAOCDJY09PzO8EZP87Xc2ApTBcQTF/B
         Ihngy0ltl1wZlI9AupsaEy+m4O587ef0//Jlzm7TNp8HIL0nRIFETSY5FuqIRcwEMo9H
         h3phoK2E62LbcW3WfYpli1FfOwYs611g9rE1/JM6MSqv3Pf0MgNf8BiVsF2JnOrbtZfX
         XjhA==
X-Gm-Message-State: AOJu0Yw9ET0OIDvBvctKdvvzbRLGDoqUebNLf9Qjbwrb1MxQTokEhqYb
        Lz77lu3xHzpAF2I2WWTO79X/Yz5NkjNMrTwzZp1qPw==
X-Google-Smtp-Source: AGHT+IGEYZHpN00c0KgUsD5iQRhHvicn/ICGk0KN/ggpV7HrCoK86ByDRWhJrLAgBNTSz+IcwgxmJBHJeL02KHkN+M8=
X-Received: by 2002:a2e:9bd8:0:b0:2c0:1bf9:3c94 with SMTP id
 w24-20020a2e9bd8000000b002c01bf93c94mr22279646ljj.50.1699307587215; Mon, 06
 Nov 2023 13:53:07 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Nov 2023 13:53:06 -0800
MIME-Version: 1.0
In-Reply-To: <20231103163434.9.Ie30c1d3f780666f6906fd2fd7c437632c229d987@changeid>
References: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
 <20231103163434.9.Ie30c1d3f780666f6906fd2fd7c437632c229d987@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 6 Nov 2023 13:53:06 -0800
Message-ID: <CAE-0n50cJZO3945tuLg+KrraBdp6zSzfnhSNpjju-ZPsBrooKQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] dt-bindings: watchdog: qcom-wdt: Make the interrupt
 example edge triggered
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
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

Quoting Douglas Anderson (2023-11-03 16:34:35)
> As described in the patch ("arm64: dts: qcom: sc7180: Make watchdog
> bark interrupt edge triggered"), the Qualcomm watchdog timer's bark
> interrupt should be configured as edge triggered.
>
> Update the example in the bindings.
>
> Fixes: 7c631cdff391 ("dt-bindings: watchdog: qcom-wdt: allow interrupts")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
