Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987F67F4490
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343836AbjKVLCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjKVLCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:02:00 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A81112
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:01:55 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1ea98ad294cso3100172fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700650915; x=1701255715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PFE8V0akmDhV9uHSFYH1mN8FnS2rSR9n1F1LBeYJA20=;
        b=VppQyigMPmmgIoYBSMyQSC6at4GaNvd3aLegkEeLdEcpHlarqTqS2vvsEd2R9szDMZ
         BCqm4tEhgloIuj30LC7kXSuDR5sUCRHsSKRe8OPEoDd7OPYcEDdGqZbE/T+hnQ4SYmoT
         QsjfPKvEzbMpipx0esTqlh7Sxagcn9wd04PPSQbF3qUHcuQ06EJUOvAuz/P7qOdtpZ/G
         EuSh24fqxsXpzxaDz5mSq24foUE+vm1tpVDzpMIYczRrVPkFaaH4U5YXzALxdablWIxu
         yHOizt4F2grISZrxt7XRgCDWQIIxKuqmA2jjBs9nkbbhaNE1uEnHPy8+Fifeo5ZX+8Bn
         yCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700650915; x=1701255715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PFE8V0akmDhV9uHSFYH1mN8FnS2rSR9n1F1LBeYJA20=;
        b=fV9n6KBfUy1L0YDieDXVk0nNg5Y6gqx2qEq0cefed9QvHEm5lD6KOl1KdrfuBaH+10
         YeF7hseFhgVg/DkIjJyTRGe4KwhA3+7qjEfdALFKIDdxafFlwVgpxauP3d0LyrnoDdmf
         FDmz8090T40GwKiNPCiXHyBSPMA0Ty4pZg09yr1RBBO46rYRwD8MooItFx1+j4126+Ef
         Z5wE+OY6G227dYGBn1W3W0sR8GffkQ/4IHBn6rBP0Gf9OB50nyOduyPrNv2NrFrs7sb/
         DWqE0xJZTI1igf56grHCLwcLG2V54iKrGX/Ozuxg+/GXlj27pMfbx+zAYlbh5/rdn+Lt
         mc2w==
X-Gm-Message-State: AOJu0Yw786w8yMb2v3SYLMhNJ4Z6o3WjYtJYMvVOuAUidHi2ONnv5Uzi
        p22MqOSEtaWiOq/VoLw/4/ExYjIwntjigF3hGgBOLQ==
X-Google-Smtp-Source: AGHT+IFxH7sdOzJBY6zKxWc8FlDU8QSdgfsWOQ/oCSLnXUeoKO4tIZGuybTYw8pZH0Y0CYMbDI2kbVOkLaxffa86JNU=
X-Received: by 2002:a05:6870:7e13:b0:1f4:ecdb:fb2 with SMTP id
 wx19-20020a0568707e1300b001f4ecdb0fb2mr2651247oab.54.1700650914865; Wed, 22
 Nov 2023 03:01:54 -0800 (PST)
MIME-Version: 1.0
References: <20231122-phy-qualcomm-eusb2-x1e80100-v1-0-ce0991161847@linaro.org>
 <20231122-phy-qualcomm-eusb2-x1e80100-v1-2-ce0991161847@linaro.org>
In-Reply-To: <20231122-phy-qualcomm-eusb2-x1e80100-v1-2-ce0991161847@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 22 Nov 2023 13:01:44 +0200
Message-ID: <CAA8EJpoKEd8B7KTwVb0TEk+Yk3kRXfhvtcdk0QUirOOV4wnUYA@mail.gmail.com>
Subject: Re: [PATCH 2/2] phy: qcom: snps-eusb2: Add X1E80100 Compatible
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, 22 Nov 2023 at 12:28, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> Add the X1E80100 to the list of supported PHYs for eUSB2
> SNPS driver.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-snps-eusb2.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c b/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
> index 1484691a41d5..6420f342dc85 100644
> --- a/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
> +++ b/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
> @@ -425,6 +425,7 @@ static int qcom_snps_eusb2_hsphy_probe(struct platform_device *pdev)
>
>  static const struct of_device_id qcom_snps_eusb2_hsphy_of_match_table[] = {
>         { .compatible = "qcom,sm8550-snps-eusb2-phy", },
> +       { .compatible = "qcom,x1e80100-snps-eusb2-phy", },

Do we need a separate compatible string or is it fully compatible with
sm8550? If it is the same IP block, maybe you can use a fallback
compatible instead?

>         { },
>  };
>  MODULE_DEVICE_TABLE(of, qcom_snps_eusb2_hsphy_of_match_table);
>
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry
