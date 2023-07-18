Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C16C758360
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjGRRV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjGRRVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:21:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B679C199;
        Tue, 18 Jul 2023 10:21:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 334EC614CC;
        Tue, 18 Jul 2023 17:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FB2C433C7;
        Tue, 18 Jul 2023 17:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689700863;
        bh=y74BJup/kSru/IUlq3/SqORVbncCOStuvNbNUy0w0p4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jxHlP7MJEcCQjDqQ6uuC2LoOuFCY8lt2NvFu1Ya8nDJYsG+u0PiZrGKTdQREkm44k
         Y8Hhj+eIVkKyjcRoH/liW9Of2PX6ywFq9rSma5TidPGXcQdeLfNXc7riFktmfQHrL9
         btECcWg18DDEMC2DvtfjbAM0wuEStc6G4IZJ8PDjYjusuoRTjkbS1ZuhcZzozcrz80
         ySKOGi8ODtI9GFmyXVM2fnVWOABxBdLL+A4M0gJWycAw3Xkor0cp7wTYKaBfP2koda
         EIhT6YBGbakqI8K7q9aoBBPcXx4rpEQG1N1HghuUqrWkYwNkJjnPPK9h9ro1JnRM/z
         yu4vcB/gzFFpQ==
Received: (nullmailer pid 1409636 invoked by uid 1000);
        Tue, 18 Jul 2023 17:21:01 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Nikunj Kela <quic_nkela@quicinc.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, sudeep.holla@arm.com,
        devicetree@vger.kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andersson@kernel.org, linux-arm-msm@vger.kernel.org,
        conor+dt@kernel.org, cristian.marussi@arm.com
In-Reply-To: <20230718160833.36397-2-quic_nkela@quicinc.com>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230718160833.36397-2-quic_nkela@quicinc.com>
Message-Id: <168970086141.1409620.455574714947000571.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: Add qcom specific hvc transport
 for SCMI
Date:   Tue, 18 Jul 2023 11:21:01 -0600
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Jul 2023 09:08:32 -0700, Nikunj Kela wrote:
> Introduce compatible "qcom,scmi-hvc-shmem" for SCMI
> transport channel for Qualcomm virtual platforms.
> The compatible mandates a shared memory channel.
> 
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> ---
>  .../bindings/firmware/arm,scmi.yaml           | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/firmware/arm,scmi.example.dts:194.31-32 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/firmware/arm,scmi.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1500: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230718160833.36397-2-quic_nkela@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

