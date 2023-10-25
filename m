Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4410B7D65DA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbjJYIyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjJYIyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:54:06 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E95129
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:54:04 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d9abc069c8bso4263795276.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698224044; x=1698828844; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=05z2jDJBCkJUaY0qwN312UAtjh1v85RzfJBH/QDD2yE=;
        b=BKALmRLaCzGKeC4a7L+jqoO7BDxm9QUkh6fj79ZFvVKTbJEn3Z38+PgABQlR5rYuX+
         qH13EuCsp6o7gbHRqCAMK9zDBc1le96NV2nLBrKRWpD8ffPcU5YfW2nJBNS/b380G8ue
         eyhT6ss5I7zDiD5ALHfB5bmc1/aOIJk9wvgUHSMC9hV8lHObEsrhTA5YwJQj9+lnbwEY
         uhVwiB0Ne9nEdUEM0fuBIK+OyaYLxEDxNf3keFMlknm1nnApAtmx+NVji06bwibDPqut
         II1aPHCZ9pmfV1gD92biLEs4pakR3ajBZFCMk1bm1jltOJileiXVjJ9/UQGrNWEvY3qo
         HPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698224044; x=1698828844;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05z2jDJBCkJUaY0qwN312UAtjh1v85RzfJBH/QDD2yE=;
        b=mVFNpxMfh0o/vl8gkBYNK7elw80a7gwbeoNf7HuRip8+DdV5j5R4BIjyUNzrHriGrg
         ACOPlG7ozWcXefSph8F3mt7Mh0KGe0ErdzJ4Zg0M7AB+LFKwsI1P21gZNzf49QDok/Y8
         92I88iJNwXQLQF35X9ManJ0aIUZAYL5Y5gozOWIlF5loKhVU/TsWwEWL3DGH4t4hXLhE
         iN8vsA77HGgJIrJXWMyuVZfDZnK/uzQbYZdrZV9WDfU7I8shDbR/vPw1Knm/qUSSHHs6
         DswLPStoXO9AhZO60a46eIx0sxIRFzv6O7rn4CHv/BPdvdnwLIwW8Afav55NQJogBETy
         tpSg==
X-Gm-Message-State: AOJu0Yz/vzGspa2Bl78pnnq1I8FN1JuiiCX7kVKECLLWc6QtLyjRe4iC
        P4QmoK/VMHbzOafOt+U5aJ05ZHlDSbnRNA7HjBedeQ==
X-Google-Smtp-Source: AGHT+IEv8Y1RRki8dQdUkHfMqNiOSNJD2LSTon4K+5zL/p6SyF33Vqj3k2iU08uur8/zm9Esfw/JJA3puyUMAXz9YYQ=
X-Received: by 2002:a5b:74a:0:b0:da0:4dfc:57d5 with SMTP id
 s10-20020a5b074a000000b00da04dfc57d5mr3141457ybq.9.1698224043799; Wed, 25 Oct
 2023 01:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231025-topic-sm8650-upstream-phy-v1-0-6137101520c4@linaro.org> <20231025-topic-sm8650-upstream-phy-v1-6-6137101520c4@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-phy-v1-6-6137101520c4@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 25 Oct 2023 11:53:52 +0300
Message-ID: <CAA8EJpotBF5xP2UC307nQpXUfvmiH8iK729KBXsPUrf5b8rQBw@mail.gmail.com>
Subject: Re: [PATCH 6/7] phy: qcom: qmp-pcie: add QMP PCIe PHY tables for SM8650
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 at 10:45, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Add QMP PCIe PHY support for the SM8650 platform.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 65 ++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
