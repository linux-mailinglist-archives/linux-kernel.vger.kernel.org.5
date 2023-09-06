Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A307793B5D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbjIFLdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238572AbjIFLdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:33:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6CD1734;
        Wed,  6 Sep 2023 04:32:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28719C433C7;
        Wed,  6 Sep 2023 11:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693999921;
        bh=gY6yuQsGYBUPwDr9MeYAHXj+FeYbykc4igmyd6IpcLY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HlNMzfMGP9osgqtfU0VLYL9Y6cPbRqTLxOwgxOME6sMezlh86l/MwdG79pKSRQFgp
         FeJpkzel1s7QrQMcT4p2ca2PQLFgcWas7qD58hCS5McJWyLggd+d8hdnhWJD2bbDB1
         oFkU198xfVT5XcLkXatYNkgf5DOkHxr+7mgPmprp6bkjCTgYi+F/FDFNssF03bc9Om
         4Jh0DOiM+5wB01U58Uk0FnsfDlOKIIICCiyGU4EYfZ/Dphi4LbfEG9DapycXQJQpDy
         cHcN5Aw+w0TPgwuHgQKZotdVVuyD+Qb5J1r6k8Ce2+wHEVQVp54s9Guoapq4gk9MXH
         ZtutRz0CSNVOQ==
Received: (nullmailer pid 1001423 invoked by uid 1000);
        Wed, 06 Sep 2023 11:31:59 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     Emil Bartczak <emilbart@gmail.com>, linux-rtc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Josef Gajdusek <atx@atx.name>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        devicetree@vger.kernel.org
In-Reply-To: <20230906-topic-rtc_mcp795_yaml-v1-1-de75c377b5b0@gmail.com>
References: <20230906-topic-rtc_mcp795_yaml-v1-1-de75c377b5b0@gmail.com>
Message-Id: <169399991900.1001400.3348200070313324495.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: rtc: mcp795: convert to YAML
Date:   Wed, 06 Sep 2023 06:31:59 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 06 Sep 2023 12:23:10 +0200, Javier Carrasco wrote:
> Convert the MCP795 bindings from text to YAML format to support bindings
> validation.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> YAML is the preferred format for dt-bindings, which allows validation.
> ---
>  .../devicetree/bindings/rtc/maxim,mcp795.txt       | 11 -------
>  .../devicetree/bindings/rtc/maxim,mcp795.yaml      | 35 ++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 11 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/rtc/maxim,mcp795.example.dts:20.13-23: Warning (reg_format): /example-0/rtc@0:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/rtc/maxim,mcp795.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/rtc/maxim,mcp795.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/rtc/maxim,mcp795.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/rtc/maxim,mcp795.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/rtc/maxim,mcp795.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230906-topic-rtc_mcp795_yaml-v1-1-de75c377b5b0@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

