Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7617C7DDC2E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 06:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376523AbjKAFBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 01:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346907AbjKAFBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 01:01:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CACF4;
        Tue, 31 Oct 2023 22:01:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF60C433C8;
        Wed,  1 Nov 2023 05:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698814896;
        bh=XGnCho/WGyMRfp4cQpFyBldzXv2oODVRS9OoFwEpSlk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D0FMlpxGrIAc0jGl0ETFQ1uumpZhEZvEAl47B0/QOohrkFiourQbVflAh2kmU2OR8
         Ak3r5iESSQSjkvLDoAcQYDpqFd2AX6ST58tWOSRjLyHMTHc7HzNyRQ0B0gpo3nNnd3
         GxEei54OjT5fVbJ+bDh9xn7qWMVHWdR185q747IohRlbivNPLej7ETrZSStB92ywcz
         fY4+VlkwdFMAPh5ZNr5EmHA9OA8FEX9Tmuf4JA2tNVpTMF5I6sB2ldXRZf6bJHTKND
         oEO31OAQXZ9Mltskjlcy/hRcPP1UakdJuUkHRywtKgGPbI3Kc9ysN2Cngv/xp98hLE
         a8vGsNA1if+TA==
Date:   Wed, 1 Nov 2023 10:31:16 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Ziqi Chen <quic_ziqichen@quicinc.com>
Cc:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com,
        quic_nguyenb@quicinc.com, quic_nitirawa@quicinc.com,
        quic_rampraka@quicinc.com, linux-scsi@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: ufs: qcom: Add msi-parent for UFS MCQ
Message-ID: <20231101050116.GB2897@thinkpad>
References: <1698811270-76312-1-git-send-email-quic_ziqichen@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1698811270-76312-1-git-send-email-quic_ziqichen@quicinc.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 12:01:09PM +0800, Ziqi Chen wrote:
> The Message Signaled Interrupt (MSI) has been used
> by UFS driver since the MCQ be enabled. Hence in UFS
> DT node, we need to give the msi-parent property that
> point to the hardware entity that serves as the MSI
> controller for this UFS controller.
> 
> Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> index 462ead5..d2f505a 100644
> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> @@ -103,6 +103,8 @@ properties:
>      description:
>        GPIO connected to the RESET pin of the UFS memory device.
>  
> +  msi-parent: true
> +

This property is not Qcom specific. So this should be part of ufs-common.yaml.

- Mani

>  required:
>    - compatible
>    - reg
> @@ -318,5 +320,6 @@ examples:
>                              <0 0>,
>                              <0 0>;
>              qcom,ice = <&ice>;
> +            msi-parent = <&gic_its 0x60>;
>          };
>      };
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
