Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5397CFC17
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346010AbjJSOIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbjJSOIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:08:23 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A2E13D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:08:20 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a7a80a96dbso7130677b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697724500; x=1698329300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tn/F8o/e5g+CaRAdyAq1gtw+JfJqdGScBADInd6iQVI=;
        b=iQCuOnLdHUvX/uGzWoRrrpS5R+3szQJRR7Og9ReypjB5+d3Fxhi8JAR/kuptzT9gvR
         bSmO5SKB8VP1lYEAEYj19/JqwZKvEy9imYVOok1z181c+hu6cgd6gKCb7iw3GweKmiqA
         HercoOvM+HqBHxJ8PxAcCqUxV7qcSu9LsDX8aYTzImF+V6jp2j/ygySDHQ1aaIRLtxIF
         FjE9FBg+7xzjIFGFqw3Yd/6XHXxsRhWUttD73HTfurz0WzMYrH0kS3BxhafoV0EyBiv2
         uMLDvI+A1ORyoJZjehtc0zldF/oVQRGr8HUv1iP6veUa9TtUeQRJGXGgiUoJ8BeRMd2c
         NTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697724500; x=1698329300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tn/F8o/e5g+CaRAdyAq1gtw+JfJqdGScBADInd6iQVI=;
        b=ZHR6TvR/FbsdwghzTamqqP2nuWPn4nFpodqqohzVs3rBBAgB3jqlYHlp0bZZ/e4s5C
         6LQq+r1ti9ZPHYnCOxDZ2T2Kj0wjpb+v5hLXgXl2WcjWqyzf92UPyHIxebCDIEtwnOze
         umgjTWC+mGnZT+US22tslNWVPg73cbEXZ8BMYiDRTj2nleCpdz3ISfY0hQ1UJD7IeO3q
         Eia362tZF60qSwy9lcQ44J34rZJX69I+Qh8vO0h30jQ4ltawK780kMvvpo4rUGoZn4r7
         1vjfxUDlFoVPNhho6OB4uG6A1froXjHrBpfYlGYhRGh6S2dAVUL1wDHSmoX5Cdnt2y3A
         STlw==
X-Gm-Message-State: AOJu0Yzmj00q7ZRVzljTefQfJxmJiXEa8FdPqIk5poIajmORzFt0cHMd
        B3fSbTTtJ0IyrqCVw3bA27a6Wv9JLQC6YwQdAjsUzQ==
X-Google-Smtp-Source: AGHT+IG/mrmUX35BBmoQAp5bc48eTYOn5e1DBnNGvJopYm45PRsEmhY1lpboqPwPq9YQ44ZSsybWD7ZZPsAeM+tOXY0=
X-Received: by 2002:a5b:b0e:0:b0:d9a:d9dd:bef with SMTP id z14-20020a5b0b0e000000b00d9ad9dd0befmr1581625ybp.3.1697724500149;
 Thu, 19 Oct 2023 07:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697694811.git.quic_varada@quicinc.com> <c7bfa2233ce4bbdc326e8aa1967cc5efd1f89932.1697694811.git.quic_varada@quicinc.com>
In-Reply-To: <c7bfa2233ce4bbdc326e8aa1967cc5efd1f89932.1697694811.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 19 Oct 2023 17:08:08 +0300
Message-ID: <CAA8EJpqfOjGp+FYCxfkFukvZ+bRFytvSFO+nvmMBn6heNpRraA@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] cpufreq: qti: Enable cpufreq for ipq53xx
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, ilia.lin@kernel.org,
        sivaprak@codeaurora.org, quic_kathirav@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 at 11:43, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> IPQ53xx have different OPPs available for the CPU based on
> SoC variant. This can be determined through use of an eFuse
> register present in the silicon.
>
> Added support for ipq53xx on nvmem driver which helps to
> determine OPPs at runtime based on the eFuse register which
> has the CPU frequency limits. opp-supported-hw dt binding
> can be used to indicate the available OPPs for each limit.
>
> nvmem driver also creates the "cpufreq-dt" platform_device after
> passing the version matching data to the OPP framework so that the
> cpufreq-dt handles the actual cpufreq implementation.
>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
