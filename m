Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF527812F89
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572879AbjLNL6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444112AbjLNL6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:58:02 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0858F5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:58:07 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2cc48cf8e70so316171fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702555086; x=1703159886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1U+x76bsJvKZYYk/aZHwgcx3jETmKUK1eOM6Ci4k3g0=;
        b=IMp040Hn3k4XVzoDt4arx3zfnKkOroV8uD4yDS0N0RgzrOM54e8rpH0xhp7DL9wMRZ
         sggu1S0/MzO6q8CkSNtaG5+4jAHBv2a6O6i8RUy1OeUjXBkwKlq4tD0TDVvdj3WEe39r
         M0Kq35AcIL6tDbOYq58BXeZTnroUxpAt3ME2ZV1YAzdNyXXK7uvrT8Jh/i2KOV2RWyUC
         f+k3F/LO8Gdlc/AzavK1MI/X6bCadSBcfitIRvUir8+ld82HVOz1oGOKq/UobjxjrnYp
         LoshgX2YCY1CYLsC8vujKcxwoMphyt6LcUcIMbyhrjW2W2VABGzhj2/mUrE0RiMg/bA6
         8pUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702555086; x=1703159886;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1U+x76bsJvKZYYk/aZHwgcx3jETmKUK1eOM6Ci4k3g0=;
        b=ieTuzFWku3zkl46XEMOTy64LA7xn/6PlZVVaSJEPes1SofaUBSLr5JhbFzVoQxWmBJ
         lv1JmwRQaRZYwVu2Yk52q83WgZFsJ9s1VQ3SV1m0do6KduWRcQB4Uk25I4ENvRYwvxyv
         vrFEtKfAE3t6dZLxDnXSP0CzJeefGWuyxLlvN0swwJg2VR4hBQzkR2+CKAj5YktGS5ow
         kZl8XePrYkl9scal/ZG+bkIX9KiCmnSX8a5Y5eIBPbu2Q+K3d/b09WndVHe1wZL/F7IR
         0kFdJMk1U5EJflzoiG6uQvCwnCJZl4Mk3ma/LUJ6fZhjq+pjni1NqZ6RN3l+KmCjVjgf
         1WBg==
X-Gm-Message-State: AOJu0Yz2HHdVQKCaN0RfRq5ai+6VNJNFnhh3jUWrh6Q5traqgcb0Hxoa
        Phxa0J1CH/76QdVDaf1KMhHbSA==
X-Google-Smtp-Source: AGHT+IFUaZgBx9xAcNdJ1qicIQ3i7Yr/GjR/h3Q0aCoeomMp+qKnlU7ATjJSTRoKt8jGVMutXnryMA==
X-Received: by 2002:a2e:711:0:b0:2cc:1cc5:de6f with SMTP id 17-20020a2e0711000000b002cc1cc5de6fmr3090346ljh.106.1702555085972;
        Thu, 14 Dec 2023 03:58:05 -0800 (PST)
Received: from [172.30.204.158] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id y2-20020a05651c106200b002ca0cb6f476sm2037042ljm.60.2023.12.14.03.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 03:58:05 -0800 (PST)
Message-ID: <f30ba74d-62c9-4f91-929e-a3c6d074deeb@linaro.org>
Date:   Thu, 14 Dec 2023 12:58:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Switch pompom to the generic
 edp-panel
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213163501.1.I8c20f926d15c9ddc12e423e07df1e89db1105d93@changeid>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231213163501.1.I8c20f926d15c9ddc12e423e07df1e89db1105d93@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/23 01:35, Douglas Anderson wrote:
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
>    60.00 1920 1944 1960 2000 1080 1083 1088 1111 133320
>    flags: nhsync, nvsync; type: preferred, driver
> * #1 1366x768
>    60.00 1366 1406 1438 1500 768 773 778 900 81000
>    flags: nhsync, nvsync; type: preferred, driver
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
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
