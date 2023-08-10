Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAD17776C8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjHJLVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjHJLVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:21:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752C110D;
        Thu, 10 Aug 2023 04:21:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4CC365931;
        Thu, 10 Aug 2023 11:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230AFC433C7;
        Thu, 10 Aug 2023 11:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691666494;
        bh=7oqbOFzXbh/vqK1FPdNCgosNW6N8CQUMa/xCbP8Mwpc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BFbpuNXAHyl3NEzENNYsswEB2SmoN+KgODBWHLn9jvjgKexkq92M4bz8XFyqxAyWO
         dNW3upmsdARUZEriqD6zlzQMTWzGL3t+j+5TyTrxhCwtDV+Lj8l6vIiJERbgNNVr0I
         /Lqd/3C5nnq3xu6PS8hW28kFywncaQevY+H/NLCFqBDUG3wwMXdSJajV23bc0AscE1
         qT4cvdUm1j0mmUpPV35VkovZlXWMwXlX5XNYaeAWLZrmlz6Y1uxGINotF8kOzU+E2T
         zpG/9ApkVbBqfzo0uIUXL4mik8TIZPPYqxnCetXhixrr1HdRognSoR6jsCh/khy2Hk
         NFQSaRYnwL3xw==
Received: (nullmailer pid 64579 invoked by uid 1000);
        Thu, 10 Aug 2023 11:21:32 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     pabeni@redhat.com, netdev@vger.kernel.org, andrew@lunn.ch,
        davem@davemloft.net, edumazet@google.com, conor+dt@kernel.org,
        linux@armlinux.org.uk, devicetree@vger.kernel.org,
        luka.perkov@sartura.hr, hkallweit1@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kuba@kernel.org
In-Reply-To: <20230810102309.223183-1-robert.marko@sartura.hr>
References: <20230810102309.223183-1-robert.marko@sartura.hr>
Message-Id: <169166649202.64563.6248344012653953343.robh@kernel.org>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: ethernet-controller:
 add PSGMII mode
Date:   Thu, 10 Aug 2023 05:21:32 -0600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Aug 2023 12:22:54 +0200, Robert Marko wrote:
> Add a new PSGMII mode which is similar to QSGMII with the difference being
> that it combines 5 SGMII lines into a single link compared to 4 on QSGMII.
> 
> It is commonly used by Qualcomm on their QCA807x PHY series.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230810102309.223183-1-robert.marko@sartura.hr

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

