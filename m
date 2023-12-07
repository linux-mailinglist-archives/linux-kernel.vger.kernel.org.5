Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAC2808A6F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443386AbjLGOZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443330AbjLGOYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:24:49 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC254387E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:23:45 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5cd81e76164so8040467b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 06:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701959025; x=1702563825; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5PB4SuKTXi3vWYEdpE3Wie0ciKcRwFmeYXUm8A8+YSs=;
        b=ufIpyYe9GDd8dEyr8zpspxsaSSvdm6Sy4L8Kj9Ep/ED62/5X5OJIqfxtE3ykFfrOZn
         jigiBFCZt47BbnW2iaz50jbfjdSOymPM1Nrjin+gFuHZcJjLurpnUf4gv8JzwRLX1vgB
         DkYY1nj8mSU+sLsb2bYeaejVhU+ppHb81ExNRvvmvFebmh9u9RTutU8YjPxtz5t0zRVy
         eQUKbDXeIwkAa3Q2td9Baau4VbwePPY9rTyPonIn+NHtaLUUV/005f977N7GAiwG/uCh
         mf6fLV4BBgtu28T77v0Qbzq4dgZx1JG/Cg85ZxRNrw3368D6HyLhsZ7Ng7g/uAHb4dWQ
         BoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701959025; x=1702563825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5PB4SuKTXi3vWYEdpE3Wie0ciKcRwFmeYXUm8A8+YSs=;
        b=GzoFcjDYoHcvT8RKYzIFxdx1LMrePURj1NadXnDa5A345YfTfotmpyG7pTBy7AA0Y+
         QoH/tpAtuHDN3crafxTqaopB8oKk0rZ+vQzdYgILZH59LyzO+9WhOu0b3kCz+Iszje0c
         x7tlE3ocZtNdHuT96b0J0QJ3dq8SRzfkaqnIVH4dfT+TLxpI4Aev5PxCTOgOyveJTAD2
         E4chCVcj0aFAsRpJTHOnnlgh4wPMpfg3lGfbXm1nw1DIGnRDNZ53+PZIy95MZUsaiXMn
         6w227HA3cc1Mmzb4dNKrsY7vSpijJQNq1gXkgdVA5+lVoT19kYW6QpJ1lvKery1DeDCJ
         YIfQ==
X-Gm-Message-State: AOJu0YyXWC5Nic62fpc/id5X+NbEZOdaoM+7Q4pdob8yY4xd2mvgyCJB
        B9M8/AxoVHu0VBnyJQT5zh9D2UjIsaYA0eRsHe9WXA==
X-Google-Smtp-Source: AGHT+IGfiFTM8GZxS753jZ+JwDwTvVydQKxJP11NtmOlQUFXtGLpBPuy36JI1NK10sQOiZkr4p3dfd2RnJT+bkeuq8Y=
X-Received: by 2002:a81:b643:0:b0:5d7:1940:dd7a with SMTP id
 h3-20020a81b643000000b005d71940dd7amr2399911ywk.80.1701959024962; Thu, 07 Dec
 2023 06:23:44 -0800 (PST)
MIME-Version: 1.0
References: <20231201-x1e80100-phy-combo-v1-0-6938ec41f3ac@linaro.org> <20231201-x1e80100-phy-combo-v1-2-6938ec41f3ac@linaro.org>
In-Reply-To: <20231201-x1e80100-phy-combo-v1-2-6938ec41f3ac@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 7 Dec 2023 16:23:33 +0200
Message-ID: <CAA8EJprAX3d03t2K1aj-ATW-+pcQH+WuwUNcXZDZj3A1wfRw4A@mail.gmail.com>
Subject: Re: [PATCH 2/2] phy: qcom-qmp-combo: Add x1e80100 USB/DP combo phys
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023 at 15:16, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> The X1E80100 has three copies of an USB/DP compbo PHY, add support for this
> to the Qualcomm QMP PHY driver.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 170 ++++++++++++++++++++++++++++++
>  1 file changed, 170 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
