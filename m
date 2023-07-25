Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AADD760F28
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjGYJaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjGYJ35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:29:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9B730F4;
        Tue, 25 Jul 2023 02:27:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 492C9615D8;
        Tue, 25 Jul 2023 09:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2764C433C7;
        Tue, 25 Jul 2023 09:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690277252;
        bh=fLWQDFhIKT84Ujf3zUkd1gtFORNi2jEH6g6iRHoIukM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SPA4NxHCfOnKRqGGO/VufO9L3Iw/LwEvSA5BmCXGW/6kAgBuRg45/v9hJKinclXqM
         +3+2+9QqObGhirFLugHDjrcEGdZFNph1SJTpE6ljs6TJFZCSuNIXko5+m9h4Lp47vY
         LlECHbyPBeDzbH8CKyd8v/88ZQ3/j/I/81j6jOR6UmIDQjjRbaye10zXAY0e5aJDAP
         brQKIp/bqnG20V+PVQbQ0ggTagReg+jOm6MBu9lUAAfLjACHwUp4u5pIf9G1yY87Wd
         fPkm9/hB3iUjIacYB6xfqi1ucmbySQAYSA04S557kTyTODytCa29FY/5kyeTDm68ef
         B+63soEnTGlmA==
Received: (nullmailer pid 2473010 invoked by uid 1000);
        Tue, 25 Jul 2023 09:27:30 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
In-Reply-To: <20230725-topic-6375_rproc-v4-1-d55e8a6d0f5f@linaro.org>
References: <20230725-topic-6375_rproc-v4-0-d55e8a6d0f5f@linaro.org>
 <20230725-topic-6375_rproc-v4-1-d55e8a6d0f5f@linaro.org>
Message-Id: <169027725059.2472994.10579462158675554822.robh@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: remoteproc: qcom,sm6375-pas:
 Document remoteprocs
Date:   Tue, 25 Jul 2023 03:27:30 -0600
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Jul 2023 11:00:28 +0200, Konrad Dybcio wrote:
> SM6375 hosts an ADSP, CDSP and modem as remote processors. Create
> related bindings.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/remoteproc/qcom,sm6375-pas.yaml       | 137 +++++++++++++++++++++
>  1 file changed, 137 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.example.dtb: remoteproc@a400000: Unevaluated properties are not allowed ('memory-region' was unexpected)
	from schema $id: http://devicetree.org/schemas/remoteproc/qcom,sm6375-pas.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230725-topic-6375_rproc-v4-1-d55e8a6d0f5f@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

