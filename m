Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF54D7E2F35
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjKFVvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjKFVvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:51:45 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F28D57
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:51:42 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so71660361fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 13:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699307500; x=1699912300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tAMDqknfv0vEM+WD/A4RK8RK4wIL/waFYE/2+elq7Y=;
        b=CE9lsqMnbS9j8expWLy88BPYLbPTDibwuChjNs/sKzFgqzFtdP10gyUMQYjLZlugRI
         BUSE5zpEuD4RRLCPaviHWVg1bxye4em3FtY5tOLrP9WJHnxNeHJbTU9SWr0b3PrALnYS
         a6rx7W/KXUj1m1hxh7pOStELrw3E2vJyAxdGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699307500; x=1699912300;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tAMDqknfv0vEM+WD/A4RK8RK4wIL/waFYE/2+elq7Y=;
        b=tFLhbmb3WORKuFnAtOUhacmP8EwXuD1Illv55YHGZ4VrkfgeVsDLhmBm6TU/VWyvBB
         BkbLb4O7ozKZBj9LECOq97K9Wq97VtgxWPNGy+QZoAG6CiVfxEtJVt6e8nc58MURSDR7
         5g6JMXHe6t9w/V8KUEndpnyDJOa6K6Ch+f3W1EDPLIsZanKI7FQATyO1d/EfWY56JhkY
         1xpO9wpyufNp6KgjGCySMw6KOGPCuZOh4ik+08w4YJE4ZM95vdDF/GUQ0/uuPE/ADFef
         EaY3tk8Wpl87SVmyJwWEUM3VN04rM4tYwTBB+EwN0o/V7E3QR/0nyYY8ZRO9Z2dSTuKR
         ChYQ==
X-Gm-Message-State: AOJu0YxBPQNVswd56Rel60ZTkrgghnMQuc7P4oUP6KTy/xVZu4c+ykaI
        8AynFAK06x37Z6NoMHZUHZa5pj2Ba2NdfuwgbUrQWg==
X-Google-Smtp-Source: AGHT+IEzZiYip1rnWEk6cQSXdXsIWKsogiosY05SaYbtbuG48mMM14HfsqLI/yBfxMn4MyQlZLutwBenOUDMZkOHSN8=
X-Received: by 2002:a05:651c:617:b0:2c5:2184:c53d with SMTP id
 k23-20020a05651c061700b002c52184c53dmr20234523lje.25.1699307500372; Mon, 06
 Nov 2023 13:51:40 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Nov 2023 13:51:40 -0800
MIME-Version: 1.0
In-Reply-To: <20231103163434.6.I909b7c4453d7b7fb0db4b6e49aa21666279d827d@changeid>
References: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
 <20231103163434.6.I909b7c4453d7b7fb0db4b6e49aa21666279d827d@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 6 Nov 2023 13:51:39 -0800
Message-ID: <CAE-0n51rvrwVBTurVj5HqZKd0v9mgKE=FLitzEuapzokn-UBSA@mail.gmail.com>
Subject: Re: [PATCH 6/9] arm64: dts: qcom: sa8775p: Make watchdog bark
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
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
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

Quoting Douglas Anderson (2023-11-03 16:34:32)
> As described in the patch ("arm64: dts: qcom: sc7180: Make watchdog
> bark interrupt edge triggered"), the Qualcomm watchdog timer's bark
> interrupt should be configured as edge triggered. Make the change.
>
> Fixes: 09b701b89a76 ("arm64: dts: qcom: sa8775p: add the watchdog node")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
