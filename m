Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F9A7B68D3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239976AbjJCMQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjJCMQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:16:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B64AF;
        Tue,  3 Oct 2023 05:16:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63D5C433C7;
        Tue,  3 Oct 2023 12:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696335400;
        bh=HOMiDWufZS8RdGpxw7PziOf8wnBkhbZbrB+flX6wANQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FXcS12JQDypAcLO2+RuZJymMiJLGw4aAALOhEi0MZt+Ft2rZWejpbEshkDj3Gp1nH
         hu45WqKRqFhK7B2l2e51FzopfWdKbLDGuJyUSYp0tcAaf8IudgMStT/xymuBGMzvwm
         jAv2hczSB68xiTnsnfzFNn2PoOu4rmLxvBjy4tNLh4cv4hYMMyu8EPGnsjEgYg1sDe
         99VMzye2SB+bf6GDfpUsx2jx9aoMy+mL+xruZVTvd2rb0kwFKmu3UmA209CB1iRzZR
         UPCJkvxI1xgMfdJ1LTI18ov9qbUEYyMfA21F7tozPBotila4H3dE8K/JZqlMFBIkgR
         PX0PH+SDv2dfQ==
Received: (nullmailer pid 282697 invoked by uid 1000);
        Tue, 03 Oct 2023 12:16:35 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     quic_narepall@quicinc.com, bmasney@redhat.com,
        krzysztof.kozlowski+dt@linaro.org, quic_nitirawa@quicinc.com,
        vireshk@kernel.org, quic_asutoshd@quicinc.com,
        quic_bhaskarv@quicinc.com, avri.altman@wdc.com,
        krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        robh+dt@kernel.org, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        jejb@linux.ibm.com, cw00.choi@samsung.com, andersson@kernel.org,
        bvanassche@acm.org, conor+dt@kernel.org, kyungmin.park@samsung.com,
        martin.petersen@oracle.com, nm@ti.com,
        linux-kernel@vger.kernel.org, quic_richardp@quicinc.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-scsi@vger.kernel.org, myungjoo.ham@samsung.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        sboyd@kernel.org
In-Reply-To: <20231003111232.42663-2-manivannan.sadhasivam@linaro.org>
References: <20231003111232.42663-1-manivannan.sadhasivam@linaro.org>
 <20231003111232.42663-2-manivannan.sadhasivam@linaro.org>
Message-Id: <169633539510.282606.1450427416869008072.robh@kernel.org>
Subject: Re: [PATCH v4 1/6] dt-bindings: ufs: common: add OPP table
Date:   Tue, 03 Oct 2023 07:16:35 -0500
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 03 Oct 2023 16:42:27 +0530, Manivannan Sadhasivam wrote:
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Except scaling UFS and bus clocks, it's necessary to scale also the
> voltages of regulators or power domain performance state levels.  Adding
> Operating Performance Points table allows to adjust power domain
> performance state, depending on the UFS clock speed.
> 
> OPPv2 deprecates previous property limited to clock scaling:
> freq-table-hz.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/ufs/ufs-common.yaml   | 36 ++++++++++++++++---
>  1 file changed, 32 insertions(+), 4 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/ufs/ufs-common.yaml:90:20: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/ufs/ufs-common.yaml:91:26: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/ufs/ufs-common.yaml:91:36: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231003111232.42663-2-manivannan.sadhasivam@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

