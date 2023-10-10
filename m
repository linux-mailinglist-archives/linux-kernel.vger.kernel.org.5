Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C0C7C0199
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjJJQ1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjJJQ1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:27:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69FA99;
        Tue, 10 Oct 2023 09:27:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B793C433C7;
        Tue, 10 Oct 2023 16:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696955264;
        bh=uWXn+ySubgsLikSzKdVOCQoQctLYGPs6WUFA/M9wNbo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ChpBcrZz6NosHeHHlQuDmUftzhWGCTXcX/+RJ1wUGSZ0jy6Lnos9nwoRZ3XpyoVQ4
         DJScejQpFrbGdanfXgrcMWBZeH9pVwgoS4sMGcCYD1OKI3JpakLHtTrRlxGmIUtP+I
         yThkpXhXPZ+zXmVqVU4Nlc2b/FAD3IduCzFmwU2Ga1K0iJQZ5CrNlQnHf2/AZrYPT0
         fRgK0YAiDmMAJ7HUEujdE0ZMJ4g+PI2P/N6BG2LnMw7mp21EWop7HjURp9/HJOIIJm
         JAcr36VtaypWggAN3Aufrc75svyinUT7QO/G3HbZvL8OatWoN6/iVTb19eVT5PjgAH
         Aoi+lRBx65nZw==
Received: (nullmailer pid 1012903 invoked by uid 1000);
        Tue, 10 Oct 2023 16:27:41 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Maramaina Naresh <quic_mnaresh@quicinc.com>
Cc:     linux-scsi@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        quic_nguyenb@quicinc.com, Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        quic_cang@quicinc.com
In-Reply-To: <1696952947-18062-2-git-send-email-quic_mnaresh@quicinc.com>
References: <1696952947-18062-1-git-send-email-quic_mnaresh@quicinc.com>
 <1696952947-18062-2-git-send-email-quic_mnaresh@quicinc.com>
Message-Id: <169695526157.1012881.14879634429567807944.robh@kernel.org>
Subject: Re: [PATCH V1 1/4] dt-bindings: ufs: qcom: Add qos property
Date:   Tue, 10 Oct 2023 11:27:41 -0500
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Oct 2023 21:19:04 +0530, Maramaina Naresh wrote:
> Add bindings for per-cpu QoS for QCOM UFS. This improves random io
> performance by 20% for QCOM UFS.
> 
> Signed-off-by: Maramaina Naresh <quic_mnaresh@quicinc.com>
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/ufs/qcom,ufs.yaml:83:6: [warning] wrong indentation: expected 6 but found 5 (indentation)
./Documentation/devicetree/bindings/ufs/qcom,ufs.yaml:85:6: [warning] wrong indentation: expected 6 but found 5 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml: properties:qos: 'anyOf' conditional failed, one must be fixed:
	'cpumask' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml: properties:qos: 'anyOf' conditional failed, one must be fixed:
	'vote' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml: qos: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ufs/qcom,ufs.example.dtb: ufs@1d84000: Unevaluated properties are not allowed ('qos0', 'qos1' were unexpected)
	from schema $id: http://devicetree.org/schemas/ufs/qcom,ufs.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1696952947-18062-2-git-send-email-quic_mnaresh@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

