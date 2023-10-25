Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562747D65E0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjJYIy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJYIy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:54:26 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09D012D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:54:24 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d8a000f6a51so4870635276.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698224064; x=1698828864; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QecDQjqHLVvpHg006tlf1j+vCUfglYL3ZKJX8YIByeY=;
        b=Ix5VLswD/abFH+lep9L719cV7UV9OoAoT1p9bZrB1DIHXk0s2Rpy/72gcvc9kMV4uO
         SQR80C1IWTckMJkKHoQKdLskU1+Vqvbb5mREww4Eu/iVoGQZpDTf78T7hKkUG8ggsYfi
         af1VfqJWOGzEVK7PGmGTs6HaQ95qct3Ur8bGkrysuZcPwNnFUx35jeetHwcSs2kS2RZi
         yKopOacAkb7zptvcjd+chcr+3NmTq6m6JjmYQAH/55abcllOV/rlgcVPojDf4A+hGBMF
         eCU5Cl0DIpuTiwfsXRob/FwJAgPpCp1zBNdumqEWaGrVZCZ3Rs2Ydyo2xOIgGptPCmHp
         1VEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698224064; x=1698828864;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QecDQjqHLVvpHg006tlf1j+vCUfglYL3ZKJX8YIByeY=;
        b=lQoIHIfkuCgElb8kGADPYN+ib5dnIJsJVAKhKENIZNA8p3CcCkBXRBmtAu8Vwvn5Xw
         urI558rQ42YTj8AqQELgxJwAeA9wSoemWSE4UK+i2goifS1IZ5bL+VGSr7BgeIbbiWMK
         YqOJTPiQyPqUvlayLPP4t2qYNpQsgpJBL+QFZCE/KpgRRdFV25eGmasFFa37ZNyLePc4
         oZQCSqn70UFuGb6RnPw6qznH5KtWKfwDBGBu3CUx+VT2pITH3zfjpClHTSqTvQUuoZrl
         vWcys/8H+91tFM4owU2bD1kHnLtbS6NxqtygwmHL3DrbQeMPv+f77ppAji5PDXQCdlQa
         aoYw==
X-Gm-Message-State: AOJu0Yz+mrC+6BXyPjOwETZI+gTfy78BWe1YYhpWZFvIwtSW/J1C1ysm
        f2/KcbowqgCSbrw1w7SRGJRQAv/g7ldHhQhdh5WTHw==
X-Google-Smtp-Source: AGHT+IH3K4Q7pknM1I5B7pKsXdsaVUiTIYG6c6iSatv1EUWsCGs8m2b6Zpy65Pq+Q7ybNggFu3TV5l/LRdXBlTF0Kh8=
X-Received: by 2002:a25:cecd:0:b0:da0:4201:6365 with SMTP id
 x196-20020a25cecd000000b00da042016365mr4494885ybe.3.1698224064152; Wed, 25
 Oct 2023 01:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231025-topic-sm8650-upstream-phy-v1-0-6137101520c4@linaro.org> <20231025-topic-sm8650-upstream-phy-v1-7-6137101520c4@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-phy-v1-7-6137101520c4@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 25 Oct 2023 11:54:13 +0300
Message-ID: <CAA8EJpr4zLPZrTbtPEuTTtRZy2NuCS-=vMeC7K8TLTJnKEf4ZQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] phy: qcom: qmp-combo: add QMP USB3/DP PHY tables for SM8650
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 at 10:46, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Add QMP USB3/DP Combo PHY support for the SM8650 platform.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
