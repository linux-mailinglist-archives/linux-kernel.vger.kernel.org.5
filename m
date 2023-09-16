Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572B87A2D82
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 04:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238683AbjIPChb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 22:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbjIPChC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 22:37:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF64106;
        Fri, 15 Sep 2023 19:36:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FD3C433CB;
        Sat, 16 Sep 2023 02:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694831817;
        bh=DUIXYVvaiR1keYTg+miPivXtIvLrN04LFwPuanPw45o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MAJt6ld0NervcoMWRakm4IMmY4S9TiVuhxsX/g1way4XvP8b2eUtPLgPa0PhXXCmb
         s8mUtmMLKbpIcPqSyH5HXMT8CiTGZ32xvQXZyAY4ys8ravwyX6mg4dORPZfU7qmFRy
         vo+mQbCrWxa43bVwwY3iG13MOMqTyKXtZLpLU2iqNMPkDz5go/v6k2P7zwqUzWCS2M
         OSQ5Gvm+ibHFQOOJs1wtxM+o1CRWqo3A9XinbhcjKG4FXgWYzblzj2tcuWG7jJTPtG
         yC5vuoD4Pi/xf0YIALg8zuOWDbQPZSb8Zq7sUwvpNzo3k5bG/jReMkRWrNbzSI0xLn
         WaAaFR2HTbvRQ==
Received: (nullmailer pid 607832 invoked by uid 1000);
        Sat, 16 Sep 2023 02:36:49 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     broonie@kernel.org, andersson@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        conor+dt@kernel.org, agross@kernel.org, tiwai@suse.com,
        lgirdwood@gmail.com, bgoswami@quicinc.com,
        konrad.dybcio@linaro.org, perex@perex.cz,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com, srinivas.kandagatla@linaro.org,
        alsa-devel@alsa-project.org, krzysztof.kozlowski+dt@linaro.org,
        mathias.nyman@intel.com, robh+dt@kernel.org,
        linux-usb@vger.kernel.org
In-Reply-To: <20230916001026.315-25-quic_wcheng@quicinc.com>
References: <20230916001026.315-1-quic_wcheng@quicinc.com>
 <20230916001026.315-25-quic_wcheng@quicinc.com>
Message-Id: <169483180949.607796.6898944173811945795.robh@kernel.org>
Subject: Re: [PATCH v6 24/33] ASoC: dt-bindings: Update example for
 enabling USB offload on SM8250
Date:   Fri, 15 Sep 2023 21:36:49 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 15 Sep 2023 17:10:17 -0700, Wesley Cheng wrote:
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230916001026.315-25-quic_wcheng@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

