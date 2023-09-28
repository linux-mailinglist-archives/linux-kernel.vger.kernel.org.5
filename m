Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049F67B2000
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjI1OrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjI1OrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:47:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ED419E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 07:47:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E3CC433C8;
        Thu, 28 Sep 2023 14:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695912433;
        bh=DAhYMVG3nEzAFn/EI+pyjEUCUyXo8CLi3ZCOtHs/arQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mCgSUN8BLRBjiIjTvtgM4sByKgXNxwGgVACsctHPBYgPR+J2tr64sI/av6TRNwRID
         Sxpn8EtCKqLGWGkJfqA9lzSasMm32pAlX3fk96W+pNc/Z8t7zWt4lC1lJGyhvJjTk3
         KbQbRykpAUQgmcMwdYlm7LxXjVrzITokeNS1iiL9FEjABOlk+ay3qcO+KyIsM/M1si
         YzWniGsMD8aMrpaqQuqzdGXL4I9jgcUjssGoiN1moF8vjmRqZ1qZxM/8jMQt85LeEx
         Qo/pzFld00MzXxlDSJchdTVb+rUd2j2Dz05u6es26vKor49zKn5/xfCyisM7GjHH4+
         sqAdTLKWtX6pg==
Received: (nullmailer pid 408729 invoked by uid 1000);
        Thu, 28 Sep 2023 14:47:11 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fu Wei <wefu@redhat.com>, Guo Ren <guoren@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20230927164222.3505-2-jszhang@kernel.org>
References: <20230927164222.3505-1-jszhang@kernel.org>
 <20230927164222.3505-2-jszhang@kernel.org>
Message-Id: <169591240666.408168.6432337250715117687.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: usb: Add T-HEAD TH1520 USB controller
Date:   Thu, 28 Sep 2023 09:47:11 -0500
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Sep 2023 00:42:21 +0800, Jisheng Zhang wrote:
> T-HEAD TH1520 platform's USB has a wrapper module around
> the DesignWare USB3 DRD controller. Add binding information doc for
> it.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../bindings/usb/thead,th1520-usb.yaml        | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/thead,th1520-usb.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/usb/thead,th1520-usb.example.dts:25.13-43.11: Warning (unit_address_vs_reg): /example-0/usb: node has a reg or ranges property, but no unit name

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230927164222.3505-2-jszhang@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

