Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CA87FAEFB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbjK1AXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjK1AXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:23:48 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8CA1A2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:23:52 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso11096319a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701131029; x=1701735829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CITKlR0CufWKC9XKPtJeX5JTUygQCHjXuf0lX1a+I9k=;
        b=Ik0TCRiY9LfWGaDgK7eYFGs30bb6/1qi6VYOmKXFJMYTH1XGkiKUl5NSCBToJ0cAzW
         TQ0DvGNlxThGmY9VhdP1XzlRC+uXN11HDwBGQ/Lwqhr8p4o1LmAC1niOIXAVwFJWJYKr
         /MyDzPvAqGnDxzUPVrtJNwrewS5CAy2xX0wgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701131029; x=1701735829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CITKlR0CufWKC9XKPtJeX5JTUygQCHjXuf0lX1a+I9k=;
        b=fMbUldRJRj7k9LTfROsT+xgljifHubYHvbpF+N0Uu+95zW3ESgmXfDW0r4u6SpmBoT
         wIpuOttYLwGrt+DbmHiwQDVS34EBZcE4JorgZN4gNFJ4Wc+MP2+yJu4Sk9E1mU6UhxOk
         Sy7Haj5PCImsUaAeHkG4FEHR+vZqMJ7ie8jUq2yW2zuTVfnNsJ87MLEdRxPqA+FGydIQ
         Qjkee20PtzMjfr05+aNhG8mvKAPHSXv9x8xQZsAfixsly2nbH7CUaqP94DEG4dv74cfG
         YaVgnl5X4a5GDHiZQ+xcTEbTncqCbhqqMS1xKCKqoGwntDx06iQXKmqeX+CVukhPUkex
         nOzw==
X-Gm-Message-State: AOJu0Ywx/pXAT9eUeDjVfILfDguP7ivpY9uaTaTleOF/9hIlaxEkgYzK
        /EUBuMORsLNJZx0WHggV5Oai5aVFGj8w0H0AEk1XDQ==
X-Google-Smtp-Source: AGHT+IERh5KcYoYOa0RJ5qwm1I/0GTh+QFfvO7puwRv3af0GtAM/S+1OG40IEhnTXC+FQlUI5Nk9yw==
X-Received: by 2002:a17:907:2d88:b0:a00:76b1:7d9a with SMTP id gt8-20020a1709072d8800b00a0076b17d9amr15852302ejc.38.1701131029558;
        Mon, 27 Nov 2023 16:23:49 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id rv4-20020a17090710c400b00a047ef6f2c6sm6223777ejb.135.2023.11.27.16.23.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 16:23:49 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40b422a274dso12965e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:23:49 -0800 (PST)
X-Received: by 2002:a05:600c:3b13:b0:40a:483f:f828 with SMTP id
 m19-20020a05600c3b1300b0040a483ff828mr728526wms.4.1701131028845; Mon, 27 Nov
 2023 16:23:48 -0800 (PST)
MIME-Version: 1.0
References: <20231128002052.2520402-1-swboyd@chromium.org>
In-Reply-To: <20231128002052.2520402-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 27 Nov 2023 16:23:33 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xbd7q=SZqje+hW7jfH3Fk7k1ZN-FzE7VrqOZ+rP0a5EQ@mail.gmail.com>
Message-ID: <CAD=FV=Xbd7q=SZqje+hW7jfH3Fk7k1ZN-FzE7VrqOZ+rP0a5EQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: arm: qcom: Fix html link
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        devicetree@vger.kernel.org,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 27, 2023 at 4:20=E2=80=AFPM Stephen Boyd <swboyd@chromium.org> =
wrote:
>
> This link got broken by commit e790a4ce5290 ("arm: docs: Move Arm
> documentation to Documentation/arch/") when the doc moved from arm/ to
> arch/arm/. Fix the link so that it can continue to be followed.
>
> Fixes: e790a4ce5290 ("arm: docs: Move Arm documentation to Documentation/=
arch/")
> Cc: Alexandre TORGUE <alexandre.torgue@foss.st.com>
> Cc: Yanteng Si <siyanteng@loongson.cn>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
