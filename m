Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2137C447C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343792AbjJJWpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjJJWpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:45:41 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C397B99
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:45:36 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d862533ea85so7281125276.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696977936; x=1697582736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4BcNjIN5yyvXH7jNvnKhk6MkOtMW2fYf7l89Mz36KW0=;
        b=zH9lOrziZ8l5ovPyjy2lQKhNTGfGBJDParcbeqoiDREihMfNAdKKLtfoUMb4bSVDpp
         6AHH1jahGa8Oy1KsHssAR2Fh5lNiWjrd8qXCssSdfTct0oHxPmCS0cAaIOst5FHGA1LK
         4KUFn/whwrsi89vEewQccohsQ7UneoE3mFi5pO5TfURVRx4qga0F5Fr88bf8tS98qy1k
         65C1lSO1MFU0/t6jLiM6h8GDpv0zt1vVSKqks+Y1ZMZIioCjYEK+YDj/9TpBVpw0TZCv
         426MExNewwFfxOyVmFQcvCKXLFB07gQRBf3hqu65CswzVVk2QGx/fzTghAAy/vI/YHEW
         qLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696977936; x=1697582736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4BcNjIN5yyvXH7jNvnKhk6MkOtMW2fYf7l89Mz36KW0=;
        b=pjAy8ql7/UGfY/ZL9UIcJwhFjdWF1vV0ZE86A9WZdxY0zfjRMKJoVf0cDiquqfUI1d
         0KI3WjR6eezytpZtE2DYVXyEkHmoYD3ylwjOhJyzijAHy9yu1zpBe2ouGZkfSL/sOhjI
         XWf+6drla83nbRnY42nmh2bw8lGposvOwubsr6KixirLxe1+nz/58druFGGOZExj5/xf
         zhuDZBdZcnZ3rVuo7PbdOYn0p3VDGdTHq7X/k9Z2oksbTH3aPptwQvraq321wt28y/Hs
         KVE49p2wq0NTLeHT84ML5VO1dEMAV7G1rIlDBFfOkddhwMvthsoMMqnkWcM5G8WqoGCK
         m08g==
X-Gm-Message-State: AOJu0YyDU81mb5IoITOxtEIIORPrflFgkZBXuRM9X9D4edRnqPxpGSHr
        vn0R++GSk3UN3SF6HW42XvVNo6VpBFC+oa7woQ4EhQ==
X-Google-Smtp-Source: AGHT+IE5kL5P5u+6fKchLXqkW+KwVtqyl81vixb70xS3IzE/CbXHiUtyr2tWiR9tiCfCkSW7qWH2PtCXGy2w4zoVe5s=
X-Received: by 2002:a25:6086:0:b0:d81:41b1:448c with SMTP id
 u128-20020a256086000000b00d8141b1448cmr17195067ybb.43.1696977935928; Tue, 10
 Oct 2023 15:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230908-topic-sm8550-upstream-pdcharge-ulog-v1-1-d1b16b02ced2@linaro.org>
In-Reply-To: <20230908-topic-sm8550-upstream-pdcharge-ulog-v1-1-d1b16b02ced2@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 11 Oct 2023 01:45:24 +0300
Message-ID: <CAA8EJppLD56DCfij=BdeqEiYqaw+9hzN9r5qCKRU8utCdaiRiw@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: add ADSP PDCharger ULOG driver
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sept 2023 at 13:53, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> The Qualcomm PMIC PDCharger ULOG driver provides access to logs of
> the ADSP firmware PDCharger module in charge of Battery and Power
> Delivery on modern systems.
>
> Implement trace events as a simple rpmsg driver with an 1s interval
> to retrieve the messages.
>
> The interface allows filtering the messages by subsystem and priority
> level, this could be implemented later on.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/soc/qcom/Kconfig               |  12 +++
>  drivers/soc/qcom/Makefile              |   1 +
>  drivers/soc/qcom/pmic_pdcharger_ulog.c | 166 +++++++++++++++++++++++++++++++++
>  drivers/soc/qcom/pmic_pdcharger_ulog.h |  36 +++++++
>  4 files changed, 215 insertions(+)

-- 
With best wishes
Dmitry
