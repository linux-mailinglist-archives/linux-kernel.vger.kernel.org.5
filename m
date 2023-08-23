Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96F77857EF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjHWMcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjHWMcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:32:52 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDA81A5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:32:49 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d73c595b558so5473394276.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692793969; x=1693398769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRSbIumIVyFQkg0diWCyawrsRoPJk8+z2O3TSnqCb2U=;
        b=AGWjRcQm0x3IxZMlEk6xalXzphtnCaJT0mqn23RSti/hJnT3okeDjL32zQP5e0RPTm
         56VqKbC7d5J3isYruH+IVO29+A8KGjiaJ2mcSdMzbg5YUdH/Pyy+baUY0WPv+icCP0Yn
         GDXy1kXbHui6WPhwmNXRGDESkiwxBFk5JySiqTo4BoGWoXDCsTyLNbF9PeikGpkyfAhi
         ixfNU6lnX94EuZwdNmfejVRTHVewRBOn3ktulkBkFzrLu7hD+w2xeK9f+bY4zjlYTPTk
         I3p7/Ym173bBrLRsg4Xy34nXPLHlpwWLSxW2/oDNQdxXycgspMSZtxv7FRtJTuYWYsPQ
         kBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692793969; x=1693398769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRSbIumIVyFQkg0diWCyawrsRoPJk8+z2O3TSnqCb2U=;
        b=Y+rB6CE8/6/7lpOwaJ8ygF9oBcBin4YnBxJnK766Wxgb5cg/gnDQhBQ7t1VbNRFbIR
         huCUO11gLEW1wMg1ayuIAG3ZA9DOkyXdEV+z1ACOuM8L75nHcin1+cbRGT2s54kGaZoJ
         ybp2Gttt83q9TVB1fYzgTWvNx9mK4m0cJl5LHXtDUV8H5ZZlAqvIRj2NtP8nyxNPyUl9
         EW2FTimDdWn2DundJf7v/cbTnQgxDxYQxfYcGneca55y8HJvTD28px5dXAog316ltHoN
         m/xuh/Z8MCNnqafGdlYyZa+3Y8Kb2/FQQMSImh+/QV2JYrp5sibu9jYfba8uw9wadPYw
         95ZQ==
X-Gm-Message-State: AOJu0Yyy6PutBoOeXFI5ExnY5Ox16Mp6FhqyHNgW54chkr6a4oS6FVcD
        3zsgy7TBHc36NFlP37HnWSJ1haKWJIlve8kWcbORZfZjNt5R4khp
X-Google-Smtp-Source: AGHT+IF0EL2CJ3/gfudLsQq6LqoM8zX8eYj3Mmo1Ay9E8vhJrJLisKFjPSYJHobDXVopQ0kW7dKtcl4/L0rgXUboI1o=
X-Received: by 2002:a25:3622:0:b0:d12:d6e4:a08b with SMTP id
 d34-20020a253622000000b00d12d6e4a08bmr12334570yba.22.1692793969166; Wed, 23
 Aug 2023 05:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230823085546.116494-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230823085546.116494-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 23 Aug 2023 14:32:37 +0200
Message-ID: <CACRpkdYp4Gviev7ccUFeK-Gmx_ZYKsMrm4KxWcy5_-q+DJ-Zeg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: use capital "OR" for multiple licenses in SPDX
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 10:55=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Documentation/process/license-rules.rst and checkpatch expect the SPDX
> identifier syntax for multiple licenses to use capital "OR".  Correct it
> to keep consistent format and avoid copy-paste issues.
>
> Correct also the placement of SPDX identifier in pinctrl-meson-axg
> files:
>
>   WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Yeah... they are designed to be machine readable so patch applied.

Yours,
Linus Walleij
