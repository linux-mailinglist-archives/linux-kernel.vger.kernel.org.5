Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC677A2D81
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 04:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238203AbjIPCh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 22:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjIPCg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 22:36:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A11FA;
        Fri, 15 Sep 2023 19:36:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12ADC433C8;
        Sat, 16 Sep 2023 02:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694831813;
        bh=s/9j8ncCW1j9ftHgl8PJ5uWrhqOWZyMg0gJKtCzpw44=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=V3lgnTnpoxVTXk+zFc3Y7Ufd5mtyYnREpoZ2P9jnoqQaACKVYQpbAfV8kHW0s3eUJ
         9I0W6CahYt1w7JyUXuEw4pyxyJBK2DsDUI3vOKooneyFtla8ulzgNuv77M2GfiBraR
         6WPZ0HjYeql1jwrHMVhQC8CFWGCEBarQ8mh5kzDnn2KLRomuSG6pmAQ1hAbxeC7Uhw
         rvVEg+2MlHSvrKHXeC4i4i2Pc2pNv2zjnvG9psnVX0ehl/m2vT7uEPRbtdcQmZ+kF1
         xF1ofd4K9rxFn9WLABWCL7j/hGast9tOi0XSxZyb2pGTxMLu1Z0soKe0PexRs4Qxse
         eAuAxL6rVQsbw==
Received: (nullmailer pid 607829 invoked by uid 1000);
        Sat, 16 Sep 2023 02:36:49 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     mathias.nyman@intel.com, robh+dt@kernel.org, tiwai@suse.com,
        lgirdwood@gmail.com, srinivas.kandagatla@linaro.org,
        bgoswami@quicinc.com, gregkh@linuxfoundation.org,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, Thinh.Nguyen@synopsys.com,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, agross@kernel.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, konrad.dybcio@linaro.org
In-Reply-To: <20230916001026.315-24-quic_wcheng@quicinc.com>
References: <20230916001026.315-1-quic_wcheng@quicinc.com>
 <20230916001026.315-24-quic_wcheng@quicinc.com>
Message-Id: <169483180888.607767.1542710881062922444.robh@kernel.org>
Subject: Re: [PATCH v6 23/33] ASoC: dt-bindings: Add Q6USB backend
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


On Fri, 15 Sep 2023 17:10:16 -0700, Wesley Cheng wrote:
> Add a dt-binding to describe the definition of enabling the Q6 USB backend
> device for audio offloading.  The node carries information, which is passed
> along to the QC USB SND class driver counterpart.  These parameters will be
> utilized during QMI stream enable requests.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  .../devicetree/bindings/sound/qcom,q6usb.yaml | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6usb.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/qcom,q6usb.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/sound/qcom,q6usb-dais.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/qcom,q6usb.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/qcom,q6usb.example.dtb: dais: qcom,usb-audio-intr-num:0: [0, 2] is too long
	from schema $id: http://devicetree.org/schemas/sound/qcom,q6usb-dais.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/qcom,q6usb.example.dtb: dais: qcom,usb-audio-intr-num:0: [0, 2] is too long
	from schema $id: http://devicetree.org/schemas/sound/qcom,q6usb-dais.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230916001026.315-24-quic_wcheng@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

