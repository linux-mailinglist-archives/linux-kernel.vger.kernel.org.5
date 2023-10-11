Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2593F7C47CE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 04:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344816AbjJKCbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 22:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343759AbjJKCbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 22:31:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AAD92;
        Tue, 10 Oct 2023 19:31:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598FBC433C8;
        Wed, 11 Oct 2023 02:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696991467;
        bh=2kt6GpEYEc8TWPUIQauHW2cC+U9TC95GtdTD5AMuWXM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=sxdTmUcfddQMbjHtHzygFI7iHhQppaRc61TRTTgLg79FG3XdyZLUmkIhmx2sDGmrE
         bI6yKgT1rXtFEa1tH31L0zuSO6PN7iQDP7v3lwOuPXeJmQNycI4APPH69ReNufSXNq
         BhRyZeWo8EP11u4ndChfI0HpAsxzYtUevHR7wzzrg+hL7CrugQrSq9/UICShEK82W3
         kbPc4w5w5bG85yIXh4KZQ4x1hQMv1el5VFbuJA5FnSMZQXEitnoLcoZz7PTZ1cTtFf
         y0+WECKdKwL4wP/rJYK4sAi9AQOac2YvTFr6rKCNQkxWV0d/9J/6YLFv0fiEX5Qrie
         ptfsmbNPUWo6Q==
Received: (nullmailer pid 2560993 invoked by uid 1000);
        Wed, 11 Oct 2023 02:31:04 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     konrad.dybcio@linaro.org, agross@kernel.org,
        devicetree@vger.kernel.org, bgoswami@quicinc.com,
        broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com, gregkh@linuxfoundation.org,
        andersson@kernel.org, conor+dt@kernel.org,
        linux-usb@vger.kernel.org, mathias.nyman@intel.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, Thinh.Nguyen@synopsys.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org
In-Reply-To: <20231011002146.1821-15-quic_wcheng@quicinc.com>
References: <20231011002146.1821-1-quic_wcheng@quicinc.com>
 <20231011002146.1821-15-quic_wcheng@quicinc.com>
Message-Id: <169699146356.2560906.8654324582682669209.robh@kernel.org>
Subject: Re: [PATCH v8 14/34] dt-bindings: usb: dwc3: Limit
 num-hc-interrupters definition
Date:   Tue, 10 Oct 2023 21:31:04 -0500
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Oct 2023 17:21:26 -0700, Wesley Cheng wrote:
> Ensure that the number of XHCI secondary interrupters defined for a DWC3
> based implementation is limited to 8.  XHCI in general can potentially
> support up to 1024 interrupters.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/snps,dwc3.yaml: num-hc-interrupters: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231011002146.1821-15-quic_wcheng@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

