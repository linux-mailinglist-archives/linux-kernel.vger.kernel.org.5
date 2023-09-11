Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91FA79A258
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 06:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjIKELJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 00:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbjIKEKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 00:10:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B236EE7F;
        Sun, 10 Sep 2023 21:10:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39338C433C9;
        Mon, 11 Sep 2023 04:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694405431;
        bh=S41KxFRM7F/NmmMk//E+BluTJ5Y6UZiLpvFzn731U5A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eh0r4fiKVmf9rUYQaIZPdBHfJ0u363MVuSpO6iNV4jS+5kiBzDyZvWcYcJ5xBNs29
         D1QpHGQUGO/XNuE1dz6ta789d4UaxQz8LS4qkuTyvjQ+OJx0TbYEfSKlwS3QM7KYHi
         Rw5Ql5tWT8JVJhDnU7BdNi+FcyVl+6HhhFwMQUQTCVokI7cRhoMAH0e6yROLRZDnGw
         4hk8x1ALxF3OFe5M7Nwvb1QqAswtFTkoTPQo9iO5XFzQn+FrtE7gmN/MUjwQnOXWdB
         Dalz0As4ITxK0cvzFxl6oxpfLj0BUKqg+pCgG6dA1+HKF7U/lFMQSHV7eA0ipNvFNb
         oHT7lFe6/VsGA==
Received: (nullmailer pid 380490 invoked by uid 1000);
        Mon, 11 Sep 2023 04:10:29 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Saravanan Sekar <saravanan@linumiz.com>
Cc:     sravanhome@gmail.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux@roeck-us.net, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, jdelvare@suse.com, conor+dt@kernel.org
In-Reply-To: <20230911034150.181880-3-saravanan@linumiz.com>
References: <20230911034150.181880-1-saravanan@linumiz.com>
 <20230911034150.181880-3-saravanan@linumiz.com>
Message-Id: <169440542910.380472.16578898431474841864.robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: regulator: Add mps,mpq2286
 power-management IC
Date:   Sun, 10 Sep 2023 23:10:29 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Sep 2023 09:11:49 +0530, Saravanan Sekar wrote:
> Document mpq2286 power-management IC
> 
> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
> ---
>  .../bindings/regulator/mps,mpq2286.yaml       | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/mps,mpq2286.example.dtb: pmic@3: regulators: 'buck' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/regulator/mps,mpq2286.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230911034150.181880-3-saravanan@linumiz.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

