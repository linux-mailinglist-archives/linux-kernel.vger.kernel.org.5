Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66F37F448A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343875AbjKVLBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbjKVLBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:01:05 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFE11A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:01:02 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5cc86fcea4fso3451477b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700650861; x=1701255661; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E1ksGzAKOZZ19DHQumvLnarTHkKv0swz0fHk1UYxyII=;
        b=z84e2FyWhNgTzDFIwHCcGOSgmOFkjUC9uS1C83rtpnOdxmuAzmcrOaLIfv28wQpxFj
         wacpD4tTPohPEwdgKzhmy3lFnE4US+LbFGvSTKkVq5jY+biYNBgd6ZuMTv8Jbj2SUt0d
         1poLahu00c4JQPvze7HDrQf2PWG8izA+OS8kPsZTWE2byVEKJlZUokjgyddeJ5oBgL8S
         LDh5gYjJv7ICyY4O/KnXS6fzB5T64e3A182r3NZzYoM0wa+9GMWObJTAQTRFxkGwQmn3
         DXu+V18l3ECEO2M5XwIBuB2mIEmd6x0C7zF69Yg2dbCKU0VvL2cUCsEt4+f4WnoIFBPx
         KjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700650861; x=1701255661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E1ksGzAKOZZ19DHQumvLnarTHkKv0swz0fHk1UYxyII=;
        b=gA5XvShA2YB5kJCeMHiccYgw9BYZXOtVU9OHIZopJPffBbyx/NlE8ie8xVD6nBMUl+
         zq+ykBuD4oL3zJK/l6T5HH3F5DEvtcfbzTxmDnpHBi9heUCCfwjsCjSjMnP6A8DElcC5
         Jo/sQ3tqo/bkVfahJ1ekCDLOyl228ekpxtSXQ2/xZGQoZyMupOXjk99WYkytpzO1OJ1j
         yaB4ycJSpOucS+AHUxiKh107uSE8bN3NGaeAfvvSAWONxajhSYa4S9D9RwsVCiAkYG4e
         IRdQ1hsMwLEbJ07tUnWMN/4FB6nOyU+gR0XIjQEKNMwY0wmPobhERPra647swC95lJrE
         Gclg==
X-Gm-Message-State: AOJu0YxiyLTGhflp0BjfhERhMhIwvwn7A7+tCNMs4fyivi3KjKiytAqH
        bw7zQJ+PPkucZGZsyJ1TVGObSXqvaLW7QSSHWRxSLA==
X-Google-Smtp-Source: AGHT+IHoRdzbQlu0J8Ssj0glEYZDjALA6nej4rxbVshhp+npDmWQzumr5ZaFvsNUewuRReubm7cet2KDcTxS3Tt9Xfw=
X-Received: by 2002:a0d:d045:0:b0:592:1bab:52bd with SMTP id
 s66-20020a0dd045000000b005921bab52bdmr1639347ywd.39.1700650855657; Wed, 22
 Nov 2023 03:00:55 -0800 (PST)
MIME-Version: 1.0
References: <20231122-phy-qualcomm-edp-x1e80100-v1-0-a9938990edb3@linaro.org> <20231122-phy-qualcomm-edp-x1e80100-v1-1-a9938990edb3@linaro.org>
In-Reply-To: <20231122-phy-qualcomm-edp-x1e80100-v1-1-a9938990edb3@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 22 Nov 2023 13:00:44 +0200
Message-ID: <CAA8EJpp=dpN+v7pxPMAzbH9xSHgydk+39GkjmuFA5yfPcCzqow@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: qcom-edp: Add X1E80100 PHY compatibles
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 at 12:56, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> The Qualcomm X1E80100 platform has both eDP and DP PHYs, add compatibles
> for these.

Are those two distinct PHYs or is it a same PHY working in either of the modes?

>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> index 6566353f1a02..190f61c1d0f9 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> @@ -21,6 +21,8 @@ properties:
>        - qcom,sc8180x-edp-phy
>        - qcom,sc8280xp-dp-phy
>        - qcom,sc8280xp-edp-phy
> +      - qcom,x1e80100-dp-phy
> +      - qcom,x1e80100-edp-phy
>
>    reg:
>      items:
>
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry
