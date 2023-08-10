Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C73C77712B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjHJHU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjHJHUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:20:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B2210C;
        Thu, 10 Aug 2023 00:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EE9C63F6E;
        Thu, 10 Aug 2023 07:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E681EC433C8;
        Thu, 10 Aug 2023 07:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691652023;
        bh=n+RX6ftJ1xXz3TaD+9P9HVBBRRHepIJu/Fp/c268OqQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VyUv/4WFL8b66yZFocMXW1PDyZdAFjncbBKe5GJWMz3nrqeE5lOjIVvqp9ruLGGry
         5Hh0hXIbO4FuJnP4fG8tn6+nwCNs/vc8w4p3hiUOgOtkMOoZ/nLdCdE190AbFIG+Ys
         hTXrboVSQOexnXL3zYv0JFvKeUF5FjxpcLg4FAUYxh+nv8lgel1B5Y40u4vOerTULo
         8GqYUGeDgbpeTEGkxt6aHiC6Wv1yh4lU/BGyThpuddc1uEo5uEjyKJQQNdhpnF7CJD
         HRvx9790azGbMZ/lscPkzZWg4ngBcYmmacPmn9gnMrBjbjwWijQC/jQIfc/Qvg7oiQ
         8NgIIoxQNkNhg==
Received: (nullmailer pid 3911824 invoked by uid 1000);
        Thu, 10 Aug 2023 07:20:21 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     agross@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@linaro.org, srinivas.kandagatla@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, andersson@kernel.org
In-Reply-To: <20230810061140.15608-2-quic_kbajaj@quicinc.com>
References: <20230810061140.15608-1-quic_kbajaj@quicinc.com>
 <20230810061140.15608-2-quic_kbajaj@quicinc.com>
Message-Id: <169165201539.3911513.11768504895031523847.robh@kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: cache: qcom,llcc: Add LLCC compatible
 for QDU1000/QRU1000
Date:   Thu, 10 Aug 2023 01:20:21 -0600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Aug 2023 11:41:35 +0530, Komal Bajaj wrote:
> Add LLCC compatible for QDU1000/QRU1000 SoCs and add optional
> nvmem-cells and nvmem-cell-names properties to support multiple
> configurations for multi channel DDR.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/cache/qcom,llcc.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230810061140.15608-2-quic_kbajaj@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

