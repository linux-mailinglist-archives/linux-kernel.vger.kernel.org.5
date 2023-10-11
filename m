Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799947C47CF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 04:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344839AbjJKCbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 22:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344739AbjJKCbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 22:31:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AA894;
        Tue, 10 Oct 2023 19:31:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48238C433CB;
        Wed, 11 Oct 2023 02:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696991470;
        bh=qtYTDtPUnp7DJJUirTj/ZCpKPdotItW9GEvz9OO8YTw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=l1GYsJYzzJrZ2IGjldrlVYtL+STlJJWL8SrHg0IKfBIYE1ObSK/pSNiexQ8lZHt0A
         R5teAJI0nXOD9z2KKDUCOxVb+9KYt0wu06YQFPi3H4BzOUtasR7YQuwzplJ6c/znx4
         iGj+BpJ/zxxkp9amwRlKKrIxPDYc9paLwp0x0QK+5tTF66XiAdHADBxIv1e3BucZtV
         VczLrJkDWKg6QEuCbJJryFlwoFpnGlfm+h89VrdJuM1kC/OPz04bIh47y6lwn6mtqj
         Y/WfNz/ivYZmeUDjs1uFRPMpjWVFc/smExUXbpLiyuzHq9zf74N5wInM9uVrIcJM31
         /gPwUITMLaCOw==
Received: (nullmailer pid 2560996 invoked by uid 1000);
        Wed, 11 Oct 2023 02:31:04 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     bgoswami@quicinc.com, lgirdwood@gmail.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, conor+dt@kernel.org,
        linux-usb@vger.kernel.org, andersson@kernel.org,
        Thinh.Nguyen@synopsys.com, srinivas.kandagatla@linaro.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        mathias.nyman@intel.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, perex@perex.cz, tiwai@suse.com,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <20231011002146.1821-26-quic_wcheng@quicinc.com>
References: <20231011002146.1821-1-quic_wcheng@quicinc.com>
 <20231011002146.1821-26-quic_wcheng@quicinc.com>
Message-Id: <169699146438.2560961.3220166947763848754.robh@kernel.org>
Subject: Re: [PATCH v8 25/34] ASoC: dt-bindings: Update example for
 enabling USB offload on SM8250
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


On Tue, 10 Oct 2023 17:21:37 -0700, Wesley Cheng wrote:
> Add an example on enabling of USB offload for the Q6DSP.  The routing can
> be done by the mixer, which can pass the multimedia stream to the USB
> backend.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  .../devicetree/bindings/sound/qcom,sm8250.yaml    | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/sound/qcom,sm8250.example.dts:97.44-45 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/sound/qcom,sm8250.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1427: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231011002146.1821-26-quic_wcheng@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

