Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9987C54EF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjJKNJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbjJKNJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:09:32 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2836193
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:09:30 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-59f6492b415so8472537b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697029769; x=1697634569; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PfPqdxr3xTk/B3lsOeG+GMaOaJ7iVKD4Sx4SQuaCBgM=;
        b=I5YSYZ4qO3uCQgEmMo0XJ6rtG3qFWzYQcT+hCNNjEqE+cn23u8d1kEQMI2TmzV3mEm
         W/TBvTQsDfa0Q6zpM6FiMkPm8CbHzp0Shkc7am5iwlE06UfBw13rHZYMQKXPwIECXfk/
         RE8upz9zflT6piqzhLKENG9xp7VFO6b7Ri6NwkPoQroeUTbrobJfXaCw6A8spd8VPJjb
         NOSXTdDXsyIGd8zbqbP9ujSkt2Pqj2k8CnvpvPBKXsZBawRJif2+yXjfZQvCjFDRrlxc
         h7zddrVbxMPPNxBn5yzk154LQha7yjo/1Q0/dboQTvkpvvqF1vTHDbG6eB7qesQkMQ8c
         a1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697029769; x=1697634569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PfPqdxr3xTk/B3lsOeG+GMaOaJ7iVKD4Sx4SQuaCBgM=;
        b=f4IxclcRqgwtZn8xoLjWd/EF7oByyF7r+hbNGS3fMy0jH+G1KxLKX39sjeKt8mcTHq
         QuxxDPgzPYlgOiVhr/DNeio0dWvQuQP5dAvCIEKAXOoX9j1rqW6N+fYp1czxoo+vH4hW
         oJvgBfkdXqXviqrDBfohOAP3eKdFR0VeRIcwUMfwvQXBYP4+9RCqM8vfEblNSSjUGRLA
         xdtNJGccX/j2Qx2m7bciMK+ZPFYTQ+KNo6AtoJWECKFosjasACeEQDg8WEOMHAO3+m1a
         vtZbnrvVbx7OqKimjm0Opv6wRL6klWCFiCSa1Ne//R1FhW32UFaWWkhNlfKLsvLORmpF
         n1iQ==
X-Gm-Message-State: AOJu0YyosmkcObbePV7iPg1ApZv5hxPmI6aIem6LZhbECjt5MQksQrEJ
        YoGafqPowTfIBkvmGEqw4m/QVjmXiFYKq1nzc5gecQ==
X-Google-Smtp-Source: AGHT+IFswPBlcYNQL1CYPz5KfOjXULTHd35mYz4MleTy/lNTPkJMrGknvU2d1TxHVQUHvUKz9z2FzCKG+mqt/P0zb+0=
X-Received: by 2002:a81:6c92:0:b0:5a7:ba3e:d1d1 with SMTP id
 h140-20020a816c92000000b005a7ba3ed1d1mr3190162ywc.25.1697029769307; Wed, 11
 Oct 2023 06:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231011122543.11922-1-manivannan.sadhasivam@linaro.org> <20231011122543.11922-5-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20231011122543.11922-5-manivannan.sadhasivam@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 11 Oct 2023 16:09:18 +0300
Message-ID: <CAA8EJprQvw3B_jyHLgB0GyJi_DKrhyq8gVGfcXraShD4tVCO5w@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] arm64: dts: qcom: sdm845: Add OPP table support to UFSHC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 at 15:27, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> UFS host controller, when scaling gears, should choose appropriate
> performance state of RPMh power domain controller along with clock
> frequency. So let's add the OPP table support to specify both clock
> frequency and RPMh performance states replacing the old "freq-table-hz"
> property.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> [mani: Splitted pd change and used rpmhpd_opp_low_svs]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 42 +++++++++++++++++++++-------
>  1 file changed, 32 insertions(+), 10 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
