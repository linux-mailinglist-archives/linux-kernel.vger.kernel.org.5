Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54157ACCCA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 00:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjIXWwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 18:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjIXWwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 18:52:49 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB08710A
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 15:52:42 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-59f6763767dso16402437b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 15:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695595962; x=1696200762; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=auyqnC2od1D1E6PNuRLFn85+jnnL3wyAnZ8O7zNakLM=;
        b=T4XnOvo/zEBfnDlfKDUEotIa4EeUZ0PoqHYYEkuw9P9Jfa31bwEfonNG0Z5ouicPLe
         hOl29kn30x8N5t0GObTs7oxTtLtJGuQjO7KE5+wMrrjWRBHTO1SuYKHAUi9bbH3jJlvH
         G2F1zJaz2xt60QTrWyUS1QFAhdQ5SAu7rqCsRZyRRfJ+tQqACwjNOW78lP/vBZHEs6MS
         +3Q8gb/IIl4s4DJz49T8b/z6Z6d27POqch4HFnAEP0VmtHnBecW5GrmspDFjlunqcUWc
         f+5r8sgAyj2Qq5JBlkfo14vrUAEewgKln96wr4VLjEEEEMlIb6kOj6f/0lDqwRSxNS6+
         t/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695595962; x=1696200762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=auyqnC2od1D1E6PNuRLFn85+jnnL3wyAnZ8O7zNakLM=;
        b=w2ozhBlGz7SWM9URQVEsU58zdX2lMCPjcAjOgenwpyoq3dDCnniuph3LrzOM+eXX+F
         nWZNrGV6yHBYMuSs9CcbyZmtIYWlTGWMjNcY7XR/yi/VLdcke8kHx9msgTZLIZAoBzcU
         fNN2SQ+fY3V/sfr9x0WMryOh+YezYoU1InVokna5N+BR4w0qoB3nJXfy9Ii2C5HL7Ya8
         lRi5guIVCBnJpToUH3d+5loc2cxX988W4B0WRFhEfyNRto21PyFH+Glh8wxDJpUDZ+rY
         EWfNR6rhtoGVTTx9QHzp6be7r5cUXEXCDaHFZnJpBYrZHLFl3q5C4Kzoa3aCGmCWyRSw
         fwUw==
X-Gm-Message-State: AOJu0YzjBcpmY9Na6QLMYFj+dd5XgJn+QUteVGN4BwjT7G1iaSE+TU1/
        x0HaKOVyFZXqdk898oyOHhhI+Ande3856UHmtT75qQ==
X-Google-Smtp-Source: AGHT+IEf/xYhIiOIqZMykdecpoI0YeQjJIGoahaAMKx6VZ6eeH9LAMmD9EAFBb2rL/KQnqGYfMv336+BVVn5GBeu+So=
X-Received: by 2002:a81:9191:0:b0:59c:786:f58f with SMTP id
 i139-20020a819191000000b0059c0786f58fmr4913540ywg.6.1695595962104; Sun, 24
 Sep 2023 15:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230924183914.51414-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230924183914.51414-1-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 25 Sep 2023 01:52:30 +0300
Message-ID: <CAA8EJpoQJUSS=tKNbKLy1AFm5w1FdOkVacDw0wzGOBTdsEfyLA@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/4] ARM: dts: qcom: apq8064: drop incorrect regulator-type
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sept 2023 at 21:39, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> regulator-fixed does not have a "regulator-type" property:
>
>   qcom-apq8064-ifc6410.dtb: regulator-ext-3p3v: Unevaluated properties are not allowed ('regulator-type' was unexpected)
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts | 1 -
>  arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts         | 1 -
>  2 files changed, 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
