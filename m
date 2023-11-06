Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB737E2F41
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjKFVwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjKFVwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:52:31 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0690B134
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:52:28 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c5210a1515so68704291fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 13:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699307546; x=1699912346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pcLpYQwHOJBs1+bgx/XyMohSbAkHSHoZFZS+/mc6OhY=;
        b=XtMWDFxT2X2LyBM2vs1jV9nlKOgjtd2jyewQwPe04aYkMuJkygwJaIUzZ1X48YTKV9
         j9VPZbB0Y9REGxL8AJgkjoDbc3AvLy3ZJ1ii8rsRdrUN/cCR8Rg618bh950smNYHsk1S
         jWVSolYCW9eDRjUwsUu8gNZL0aLmCNDsQuobc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699307546; x=1699912346;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcLpYQwHOJBs1+bgx/XyMohSbAkHSHoZFZS+/mc6OhY=;
        b=wNGWUvW7x0nn6oxJ0czcL5Chl66Qpsz7iR0Lt86MKCsR1Xc2cXTTUwoxziVmDCo6Q+
         MqNBFJKgkq+hyWuf6tNp7HDS2FE4KD5mTA91wZ6TMctZg0FaD44mi/ip6BsmbGF37KAr
         6yo7hrzSy2r7u+M/EtuDIWRw6tKKBEEa2kTvwH5tMZQ56BE+ogmN/sRMOR2DxikYlA1x
         P94iq8DiYDpiiD5zdDd7rVZLageRI0RU5QHYd73CwM7qoKYzPMneEIO/i7F7oYL1f9Gp
         XKH/KOlFTzJJr8U9MIg7tdXLZFJiA2roO8HnuK/mm5N3Q+GWhPlvaoz88kjTG9lOJSjZ
         iTkQ==
X-Gm-Message-State: AOJu0YzafH1ejjQ7M9RpmmWsVHTvD96ApJ9+c4eDV1cipy+A2u1wZB6t
        uzFReXyJgyO4+NXJWVPZJnlLYDG2Mjnx1k7xuW7Q7A==
X-Google-Smtp-Source: AGHT+IHwaWHjOprXL57hNf2rFZSX55S5GAUN1q/qHfDTTNIOltSUt0SKeimJVCNC7yGPADzZ4lTXV9ddU9TVuiCpVKE=
X-Received: by 2002:a2e:a98c:0:b0:2c5:4a5:9560 with SMTP id
 x12-20020a2ea98c000000b002c504a59560mr32234027ljq.41.1699307546288; Mon, 06
 Nov 2023 13:52:26 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Nov 2023 13:52:25 -0800
MIME-Version: 1.0
In-Reply-To: <20231103163434.8.Ic1d4402e99c70354d501ccd98105e908a902f671@changeid>
References: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
 <20231103163434.8.Ic1d4402e99c70354d501ccd98105e908a902f671@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 6 Nov 2023 13:52:25 -0800
Message-ID: <CAE-0n5152eMZ_muL3rBOc6gyRQOXA0U8=vXp6GkkuvOo3Mp+mw@mail.gmail.com>
Subject: Re: [PATCH 8/9] arm64: dts: qcom: sm6350: Make watchdog bark
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
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Quoting Douglas Anderson (2023-11-03 16:34:34)
> As described in the patch ("arm64: dts: qcom: sc7180: Make watchdog
> bark interrupt edge triggered"), the Qualcomm watchdog timer's bark
> interrupt should be configured as edge triggered. Make the change.
>
> Fixes: 5f82b9cda61e ("arm64: dts: qcom: Add SM6350 device tree")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
