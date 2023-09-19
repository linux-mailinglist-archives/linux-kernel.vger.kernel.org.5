Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ACC7A6058
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjISK5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjISK5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:57:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB533CFE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 03:55:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B8EC433CB;
        Tue, 19 Sep 2023 10:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695120926;
        bh=IZ8QHJlzaFVxxzy8OGWmG+Rj9SpjIEfIWOgoiQgccBU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JBxY5iduN7o1cY2/4GRVtfKDsiE5Czm1sRnrsmpKbPXFLKag17D1QnWrAp9D6nwC7
         nhJX8SRi7cThfE0ydIw9yiQk6ibqbtA14P8RTON3iLJa9cmnWhWca1M76LMnHxR3SW
         EZRqEpT6fj/hGTOgSp5+Z7z41xovqfUIgecZ1q7ls4pIc4z0YtWGNIFdzvCKrN8z1H
         STN8vbE3QG4ksq62bVDLghmQaIRYaQdgxScC/gNRPhRXZ/1yNCMhuC7hFmbIAZm7gc
         GSjopSPNrG7MRCWvR53hU3/5fYFTyugoqQfF+GxUnaIaK50USE3zcGVzD5RLT/pW9d
         Fm3TVxk16BB7w==
Received: (nullmailer pid 3135077 invoked by uid 1000);
        Tue, 19 Sep 2023 10:55:23 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
Cc:     alsa-devel@alsa-project.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20230919090739.2448-1-bragathemanick0908@gmail.com>
References: <20230919090739.2448-1-bragathemanick0908@gmail.com>
Message-Id: <169512092376.3135048.3729589976906559665.robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: tfa9879: Convert to dtschema
Date:   Tue, 19 Sep 2023 05:55:23 -0500
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 19 Sep 2023 14:37:39 +0530, Bragatheswaran Manickavel wrote:
> Convert the tfa9879 audio CODEC bindings to DT schema
> 
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---
>  .../bindings/sound/nxp,tfa9879.yaml           | 45 +++++++++++++++++++
>  .../devicetree/bindings/sound/tfa9879.txt     | 23 ----------
>  2 files changed, 45 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/nxp,tfa9879.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/tfa9879.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/sound/nxp,tfa9879.example.dts:22.27-40 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/sound/nxp,tfa9879.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1427: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):
MAINTAINERS: Documentation/devicetree/bindings/sound/tfa9879.txt

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230919090739.2448-1-bragathemanick0908@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

