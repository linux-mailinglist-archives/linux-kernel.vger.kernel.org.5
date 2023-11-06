Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4397E2F27
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjKFVuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbjKFVuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:50:12 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24195D79
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:50:09 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507a55302e0so6749968e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 13:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699307407; x=1699912207; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FKrTrwP4+tNK0dHvoIJCUcpztONhMhTcxvDfTSeUSA=;
        b=NyYmh9KBWPrUyJJy5B7oVqvrv/RhIGrfNSqkkaUbuaUEs+LhreAsKdqfj/4Zv9tjL9
         iUdIYIvmG+p04HOHqDqQvyKPcSgZM4y0XKIhCe54Dkrm1RXTQTfcTCdNgufd1SfG8mCy
         JDcbJYiU4ZLuecAKC46LymgjH0QMK8NFl/nyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699307407; x=1699912207;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FKrTrwP4+tNK0dHvoIJCUcpztONhMhTcxvDfTSeUSA=;
        b=popwR/0RtdgXT4aV/85a92QBMwawdDbCct0BtPbINytfSGPJpFQhD1Zlv5eq1+D4bV
         YFzqb2s/ysOOlORUhs2XFLMZmp8N4uOm1mxAAQeUTvRfqptp4QCjsdoKo3JmWgkg8XHx
         kws9jKlq2sTX/EIX5FWqhSaUvAvLPNZjy85V43BWos32hw+mPzy5EOlTSdDPgXH05zb6
         7UNnIGJVEo4VxqxeZg8kahDkc3WQTwIeduNVjWiBnj7ZCYg4JSXBrHnG0NthEA6u/rRX
         VuHVLYIetirvpTPAuxkwhNodjFcsos6gtJmZGlTLoLNaxAU/0FT9SUVpjcXG03nlzaeW
         D/7Q==
X-Gm-Message-State: AOJu0YzhbPsdZUfZmQAXWix+mGXzFyTx8M6OBrwQPIrSLY02BCSw6wU1
        O1bBvHyAajUrbeMBx/Yp4uEMbpnNxtH22WTR2xC4bw==
X-Google-Smtp-Source: AGHT+IHv6vIlytKhsnU8L1VEjmhDuYCF3jfxe9Z4QUKc7xCfSxbD2ztyEuKPczvDwkGV5DRvJfJ56BjDFjVcJxgHeEc=
X-Received: by 2002:a2e:8681:0:b0:2b6:cff1:cd1c with SMTP id
 l1-20020a2e8681000000b002b6cff1cd1cmr22694665lji.34.1699307406548; Mon, 06
 Nov 2023 13:50:06 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Nov 2023 13:50:06 -0800
MIME-Version: 1.0
In-Reply-To: <20231103163434.3.I16675ebe5517c68453a1bd7f4334ff885f806c03@changeid>
References: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
 <20231103163434.3.I16675ebe5517c68453a1bd7f4334ff885f806c03@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 6 Nov 2023 13:50:06 -0800
Message-ID: <CAE-0n52Ze4rPz2Dd4iQee_jw+3gGBLUyQ=nHQiQxgAt3V3-EdA@mail.gmail.com>
Subject: Re: [PATCH 3/9] arm64: dts: qcom: sdm845: Make watchdog bark
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
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2023-11-03 16:34:29)
> As described in the patch ("arm64: dts: qcom: sc7180: Make watchdog
> bark interrupt edge triggered"), the Qualcomm watchdog timer's bark
> interrupt should be configured as edge triggered. Make the change.
>
> Fixes: 36c436b03c58 ("arm64: dts: qcom: sdm845: Add watchdog bark interrupt")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
