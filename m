Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED597AC4B4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 21:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjIWTOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 15:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIWTOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 15:14:00 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E586193
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 12:13:53 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59eb8ec5e20so48179487b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 12:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695496433; x=1696101233; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZmYNV3oT+zkVAf2ugnkULn4izub45DJoleWbLBZiLk=;
        b=BYmUWmHm1d+2YeSfA6FrjZLsVZIWFYDvO+oimM5AK1Ut1MfL9t6+qD0oiN7kaG94e0
         KKBLl867I3svVBLc4CWICmmboBjCFPY5D+IJtJSFiXUPcp/mw4jkteJuu7RdQfzBF1x/
         OZtYgkJrUE8ncCeNi3NQPI6wa0WmgYRuTJQekEzFg3ShGcFrWD2r/NR6DjijuiQrhlpr
         54vKvq52qjLHw5z/8fdmCfm8HFwR5hg2fU4PadZYdQhm6p2ZehRM0HQuz/xV0w/oP4TY
         2WuyrsWKKcRVcLsN5y7CH9gjiPAQNsVj8pneQf50dX2wk5lc8dp8to1vOQvpyv7OEw76
         bwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695496433; x=1696101233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZmYNV3oT+zkVAf2ugnkULn4izub45DJoleWbLBZiLk=;
        b=SUFo3UAzGROXibWpuNl+PD56Xqf3qWUdweUnMfrkZTxEkvs2XHAFG2mL+zYrWvzBvU
         ZDAOC91jfTrW9R83YBxzuQlye5YUzYu9TZAzhBuG8Wy9mXbZN8F9HAOp616fGKaahojD
         yaqEcAt8zFB0QYcQAK5puHqhi4bEyKbP96JNxXaSIh7WRQeFN78TB2aEgS+nU2Ui3gB+
         3Nff7SPe1u7Gvu1TsapddqyugifunODdIw6NDNUqdOdQpH3UiTRCTBq0Wk4ESX7dOAMi
         10T37/t0dpQYSATBaNPLmXtQVzYvoa5a+cguKom8LH7CTHlocFEao8WL5rRv2DI0UzGy
         dz8A==
X-Gm-Message-State: AOJu0Yyhvmiq4smoJphzgRToSwaRFMcJWJzgPRGfZhmuT/ciia/3XxCw
        sCEFUomJ7nLgkZ+HtvkQIorOH7nAi7WgBHq2GYZwyA==
X-Google-Smtp-Source: AGHT+IGXN+4C918nlV0X9cam2P53VSEtGaNCjhNVGXRfBhpYoducXAEJcOhhSM/a1gaDZ9hAbqMkiRbLfciiL/l5bZg=
X-Received: by 2002:a05:690c:4483:b0:59f:5361:d18c with SMTP id
 gr3-20020a05690c448300b0059f5361d18cmr2111515ywb.41.1695496432784; Sat, 23
 Sep 2023 12:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230922084303.4164046-1-quic_gokulsri@quicinc.com> <20230922084303.4164046-3-quic_gokulsri@quicinc.com>
In-Reply-To: <20230922084303.4164046-3-quic_gokulsri@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 23 Sep 2023 22:13:41 +0300
Message-ID: <CAA8EJpoyaM0_utG9oAwyqO3RPoNDNduuPc3u+tzrjYM6NXRnjg@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] clk: qcom: apss-ipq-pll: add support for IPQ5018
To:     Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_varada@quicinc.com, quic_srichara@quicinc.com
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

On Fri, 22 Sept 2023 at 11:44, Gokul Sriram Palanisamy
<quic_gokulsri@quicinc.com> wrote:
>
> IPQ5018 APSS PLL is of type Stromer. Reuse Stromer Plus PLL offsets,
> add configuration values and the compatible.
>
> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
> ---
>  drivers/clk/qcom/apss-ipq-pll.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
