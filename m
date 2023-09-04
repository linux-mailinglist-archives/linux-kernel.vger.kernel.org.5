Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928977910D5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 07:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbjIDFXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 01:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjIDFXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 01:23:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4658A110;
        Sun,  3 Sep 2023 22:23:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF76260EDD;
        Mon,  4 Sep 2023 05:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BDBC433C7;
        Mon,  4 Sep 2023 05:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693804982;
        bh=AhObSTGqSQAU1+PsPv0SmiERR6jbys0w6afeTa4xQTk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kRg80CrC66UlN9oKSqcaXcPbNrq3DHre4b8l553VdCc4tPNE8oe3JEoOuK7iKLg6a
         BLM88Sfe2vaM84rfZAEu26lBsgNo4J9C11XS/b8euqkknPl2dtMfiTbbvnUdZ2gkMd
         oZmvL54PFU0+PaTaztERBmvec6nDAOFPEez0PFA5iDLjU12hwz0+oI+OqcdJcf/Cik
         bNWtCa5f0yDkMoirKsmSn5yLjKyRvnQdMUzZntVqjoV7u026VSeIJ6qCKidcGqu95i
         lpE7vDPGpP4FRPmInz70r/l59GHNiSZAOXfBUWKtT82vk2STSpqU6ycyOE83ixO51/
         S3NIuMpkTnoWw==
Received: (nullmailer pid 731699 invoked by uid 1000);
        Mon, 04 Sep 2023 05:22:59 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Kwanghoon Son <k.son@samsung.com>
Cc:     jszhang@kernel.org, wefu@redhat.com, palmer@dabbelt.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        conor+dt@kernel.org, linux-riscv@lists.infradead.org,
        guoren@kernel.org, p.zabel@pengutronix.de, inki.dae@samsung.com
In-Reply-To: <20230904042559.2322997-2-k.son@samsung.com>
References: <20230904042559.2322997-1-k.son@samsung.com>
 <CGME20230904042603epcas1p11db03427cc5f434578d29dd51bc3ae85@epcas1p1.samsung.com>
 <20230904042559.2322997-2-k.son@samsung.com>
Message-Id: <169380497961.731683.17111917640316615720.robh@kernel.org>
Subject: Re: [RFC PATCH 1/3] dt-bindings: reset: Document th1520 reset
 control
Date:   Mon, 04 Sep 2023 00:22:59 -0500
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 04 Sep 2023 04:25:57 +0000, Kwanghoon Son wrote:
> Add documentation to describe th1520 reset driver
> 
> Signed-off-by: Kwanghoon Son <k.son@samsung.com>
> ---
>  .../bindings/reset/thead,th1520-reset.yaml    | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 64, in <module>
    ret |= check_doc(f)
           ^^^^^^^^^^^^
  File "/usr/local/bin/dt-doc-validate", line 32, in check_doc
    for error in sorted(dtsch.iter_errors(), key=lambda e: e.linecol):
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/dist-packages/dtschema/schema.py", line 135, in iter_errors
    self.annotate_error(scherr, meta_schema, scherr.schema_path)
  File "/usr/local/lib/python3.11/dist-packages/dtschema/schema.py", line 114, in annotate_error
    schema = schema[p]
             ~~~~~~^^^
KeyError: 'type'
Documentation/devicetree/bindings/reset/thead,th1520-reset.example.dts:18:18: fatal error: dt-bindings/reset/th1520-reset.h: No such file or directory
   18 |         #include <dt-bindings/reset/th1520-reset.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/reset/thead,th1520-reset.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1500: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230904042559.2322997-2-k.son@samsung.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

