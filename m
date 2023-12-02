Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEB7801E79
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 21:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjLBU1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 15:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjLBU1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 15:27:50 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B693118
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 12:27:56 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5d747dbf81eso4990817b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 12:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701548875; x=1702153675; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uvT4z76Po6/5Y4/ji/3Hekn4vEQQ+QLQOwThlnNRg+s=;
        b=vLrCoNhe+1S0XvXo1nUrtCyOaPBRCZBwWcIyvUZRmJVTIXL8WwYrwrR7iGKGCDvBag
         JYAy9WdA+ALqs7WLN9QWrz4n4zLtztt+njb6dzbU2/roF+3EKRBic9syQtPs5Ob+1Bzs
         b0j21k3TCpYg07b2BRJsiTAkqjFijEU+DGkUHWWItNRH4o3tDuRnz+FPXXMRrmSb4Gw9
         DI61khc4pcAJ+eItTz5FxuEzMWmFLsSszpk9LbL1Y0OvQWXohXSx8JC09QJtnJDbv6oa
         031Oy1vMJ4MOXLwQ88JcCKEWAmZoA3DGPluYXTzv2Cx4Xiw2BdtKPEkhBPVIV3WpQ7tr
         GeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701548875; x=1702153675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvT4z76Po6/5Y4/ji/3Hekn4vEQQ+QLQOwThlnNRg+s=;
        b=ShajSbjk/shkDKZLTPWoirrsG+xNwUxTOVR9DI9YxKFNJ2vBmNtm9843FR/kW+uwMC
         9vTfUcDExKHVW3iZQIUpjlKZLTCy1/AMf++Zf/DhcZyJfXE57TXeNm6J+Rp0HkXjYYDo
         sZTxrJ1cUTCFIerlQygowzkMLfPlAFCMU7F1Sf9JHB3nLG1nxLdC1kspHJA6mqQNEz1z
         Wb4ZRRTIxPy0L8n5o4XEliWopIqi9exj1gjklP3VhOn7pC25IkFYL0A6OqhHjELX5O2M
         xLOHvIvK/K7dVfmmuGUqyxyIEf0ROZPwQsFpWdmzbGzmYgH9D/I4PnayPXZ8gsXplcik
         yFJA==
X-Gm-Message-State: AOJu0YyBjUKq3u5wGUR+5RbgrLsCS6PivsEyyd4p3hxUPC8HJgNIGrHP
        A4hY355iVdJTl2vcSMvLgmIHuIOhBfRxFCSMuZXOAg==
X-Google-Smtp-Source: AGHT+IH1Bi46zI+abA7XowSzg7eAQSNdMduiBzR2eJj0NkSKqxmlcaCcQ8HWp9J2PVu1uH7bwYUGeeRqo5iERm/gCtk=
X-Received: by 2002:a81:7904:0:b0:5d7:1941:ac0 with SMTP id
 u4-20020a817904000000b005d719410ac0mr1384290ywc.91.1701548875589; Sat, 02 Dec
 2023 12:27:55 -0800 (PST)
MIME-Version: 1.0
References: <1701520577-31163-1-git-send-email-quic_cang@quicinc.com> <1701520577-31163-11-git-send-email-quic_cang@quicinc.com>
In-Reply-To: <1701520577-31163-11-git-send-email-quic_cang@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 2 Dec 2023 22:27:44 +0200
Message-ID: <CAA8EJpqp3=wnShnjnLgeWt+TuVjEVOWW7QcACjZq2JD3AcoYGQ@mail.gmail.com>
Subject: Re: [PATCH v8 10/10] phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed
 Gear 5 support for SM8550
To:     Can Guo <quic_cang@quicinc.com>
Cc:     bvanassche@acm.org, mani@kernel.org, adrian.hunter@intel.com,
        vkoul@kernel.org, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Sat, 2 Dec 2023 at 14:37, Can Guo <quic_cang@quicinc.com> wrote:
>
> On SM8550, two sets of UFS PHY settings are provided, one set is to support
> HS-G5, another set is to support HS-G4 and lower gears. The two sets of PHY
> settings are programming different values to different registers, mixing
> the two sets and/or overwriting one set with another set is definitely not
> blessed by UFS PHY designers.
>
> To add HS-G5 support for SM8550, split the two sets of PHY settings into
> their dedicated overlay tables, only the common parts of the two sets of
> PHY settings are left in the .tbls.
>
> Consider we are going to add even higher gear support in future, to avoid
> adding more tables with different names, rename the .tbls_hs_g4 and make it
> an array, a size of 2 is enough as of now.
>
> In this case, .tbls alone is not a complete set of PHY settings, so either
> tbls_hs_overlay[0] or tbls_hs_overlay[1] must be applied on top of the
> .tbls to become a complete set of PHY settings.
>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h     |   2 +
>  drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h |   2 +
>  .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |   8 +
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 169 ++++++++++++++++++---
>  4 files changed, 159 insertions(+), 22 deletions(-)

-- 
With best wishes
Dmitry
