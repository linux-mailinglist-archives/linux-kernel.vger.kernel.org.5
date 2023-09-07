Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5EC7975B1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbjIGPxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244277AbjIGPuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:50:39 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CFE5FCB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:41:16 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d80089712e5so515841276.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694101221; x=1694706021; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RbK6fKvS9Fgoje98ZfydB5ImVNxTq9WKZiMHsHIMJYc=;
        b=uZdL8yONlBQuUqdmYLRXkFDABA9W3YQaPZqV8r/1Z4L18Kazq6eoL3BJWMxX8LBAK1
         UTNGiijaSV5FTDYv1gqpbvrQ8iVtLn2uEDtTCtLuuegcn4tPU/P8cJtYHqB6Kf8PcO0E
         YRG2Su1+m4dTRNqIkaYv/MxUPGUIVJ6AmWdalZmSXMEzrktTDTyqTrW3Utnjc9sSPSju
         kbOicPhQGRZqZjb3yvvn/F2RU0B/hEvulvENAGTmGnauXrfnvWQYpyQA1w2vh3MVpcNq
         OpORfJ76ba7NISgOVyoX1cOw76NSrV3F4dHZaWJrMHNY41ACXKYv9If8fLjPywVm0VxN
         be4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101221; x=1694706021;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RbK6fKvS9Fgoje98ZfydB5ImVNxTq9WKZiMHsHIMJYc=;
        b=GCBPn5HY59BkGcd5UP7wrCYeB0UdZtdw/8bbp20e+ZVduylST0OHUaYFtnUi+nXmzm
         m5SiihrXNQcrTnbFKfKLS6vQdKh0r0+tm6h4Xy0eyAr9Z4q1endOO2CeFqt5gSpwGPN5
         Q8T8sWB0ovQtngNTNH2RmyiY1Q49Pt5WpIlqNVcD3FgUGDXcOj2cy+1kBxaViU2k50ob
         4q/dZCDzmUBCbZZ4yENbCPSQp/qtvajmyqyWgjVsDV4yVb2KcxnCa1hQrbdlT29vBytO
         QBhdy9uZDvaNFvc7jvBevAr58hAvjSim4B/3paPHmTTZLRPnV93OHbpMHqZhGqP6e4RL
         S3GQ==
X-Gm-Message-State: AOJu0Yxw67ejwP/oNVb5dwC9t5PHn7PQEkLJOVjUgZQJdTa8DgGZakbq
        72wxPgawiLMBpATmqQDiAGVKf8Dp70FuXx/y+MinTyC2yM7a0tcw
X-Google-Smtp-Source: AGHT+IHu6D0PjyoNN/3icMZDTJRryJCp5e4gDUZ/wy83CohE7b2nsJzK7Ge1NIZAUgYV6LutVWZGRWBUmBFmeDVHGrc=
X-Received: by 2002:a05:6902:154d:b0:d72:8a65:394f with SMTP id
 r13-20020a056902154d00b00d728a65394fmr3971430ybu.18.1694094049986; Thu, 07
 Sep 2023 06:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693996662.git.quic_varada@quicinc.com> <543183ecfba929683c1b8d7ff24d75df489ef0cf.1693996662.git.quic_varada@quicinc.com>
In-Reply-To: <543183ecfba929683c1b8d7ff24d75df489ef0cf.1693996662.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 7 Sep 2023 16:40:39 +0300
Message-ID: <CAA8EJprSHCx6TQ=-iEV6L55b69yYKANCJmGSqN+YVSv1dSCAqg@mail.gmail.com>
Subject: Re: [PATCH v1 03/10] clk: qcom: apss-ipq-pll: Fix 'l' value for ipq5332_pll_config
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        quic_kathirav@quicinc.com, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
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

On Thu, 7 Sept 2023 at 08:22, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> The earlier 'l' value of 0x3e is for 1.5GHz. Not all SKUs support
> this frequency. Hence set it to 0x2d to get 1.1GHz which is
> supported in all SKUs.
>
> Fixes: c7ef7fbb1ccf ("clk: qcom: apss-ipq-pll: add support for IPQ5332")
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
