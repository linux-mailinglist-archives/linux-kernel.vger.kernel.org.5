Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DD77D647C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbjJYIFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbjJYIFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:05:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F96A128;
        Wed, 25 Oct 2023 01:05:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B3EC433C7;
        Wed, 25 Oct 2023 08:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698221130;
        bh=roeLa5qj7aPFDrKeHEe1DXZrXXZ8cR1PxbHoRqCXgCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R4t5GB9OKL4sFNxpDHM21I5dGGvZpIO4PNcn5rRxhLFo1Mtfi3oeX4UkhjXXARdzh
         5r8zb504Zl4QT5l5lVKECQThi6557fc3L4u9vtoPEBjRArb2BGkzDYe7RyDMZjoNAj
         80b/isuYR5A0VccLt3Out1CxxNbdwl8vJFH9oWwuQXUcx+154tC6BfcZMCarbNBZmi
         zLgrqNlYCvgL7Urrr3eBJNhYfGo7T92V7UTOQzu0Y3lWB34QF0B9YmqgnxZ5jPKSQk
         4UJmWWrAdCfTpHuZuAXilUMq717LfH43BSt+t42v2W5TQXQCuCQfaOK93xBQhZetJW
         xYKMVOjosZhcw==
Date:   Wed, 25 Oct 2023 13:35:22 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ufs: qcom-ufs: document the SM8560 UFS
 Controller
Message-ID: <20231025080522.GF3648@thinkpad>
References: <20231025-topic-sm8650-upstream-bindings-ufs-v1-1-a355e3556531@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231025-topic-sm8650-upstream-bindings-ufs-v1-1-a355e3556531@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 09:30:48AM +0200, Neil Armstrong wrote:
> Document the UFS Controller on the SM8650 Platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> For convenience, a regularly refreshed linux-next based git tree containing
> all the SM8650 related work is available at:
> https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> index 462ead5a1cec..0d136c047b8b 100644
> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> @@ -36,6 +36,7 @@ properties:
>            - qcom,sm8350-ufshc
>            - qcom,sm8450-ufshc
>            - qcom,sm8550-ufshc
> +          - qcom,sm8650-ufshc
>        - const: qcom,ufshc
>        - const: jedec,ufs-2.0
>  
> 
> ---
> base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
> change-id: 20231016-topic-sm8650-upstream-bindings-ufs-d03cf52d57d5
> 
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>
> 

-- 
மணிவண்ணன் சதாசிவம்
