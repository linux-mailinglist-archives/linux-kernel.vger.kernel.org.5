Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FCB765A4E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjG0Rbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjG0Rbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:31:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A8C2728;
        Thu, 27 Jul 2023 10:31:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8A8F61EEE;
        Thu, 27 Jul 2023 17:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0037BC433C9;
        Thu, 27 Jul 2023 17:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690479107;
        bh=Ajlt8COfnYfig1GjhZUz3uN08k51rfXoSC611m7YbuU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Xo8zC/S07jN+as1GcbjnY5sJ9JvXWL1l8uIa0tcxHcFiwpRwhDAq2q7xXeSBO/G4N
         tW/YvfpLYes8Gv6gN4FdByfbIItZ4kwZC05cYVPt8wSiwHx1cborNLzzsPq5MeynSw
         0/5EObXNDl7G53L5Yvic5YS8jC0a7qHfRifefzIqbxxUziHUP3Zbs/dJSDSM+hVGHh
         VgdhqgCuP0ydWOFmCA0bnxbjYX4quwJSJFotF25wYLFJSgqNA+OVJIR/sq9VUj1cWi
         MpB3+tHLEJwr+TwA1zaEjfTg8vMTfkRGW8no6pZmVvfB0lJxwnYvSTwQPS7gZOS85I
         w91aROtnZodtg==
Received: (nullmailer pid 2846 invoked by uid 1000);
        Thu, 27 Jul 2023 17:31:45 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     Shawn Tu <shawnx.tu@intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        kieran.bingham@ideasonboard.com,
        Lee Jackson <lee.jackson@arducam.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        jacopo.mondi@ideasonboard.com,
        Marco Felsch <m.felsch@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230727154108.308320-2-umang.jain@ideasonboard.com>
References: <20230727154108.308320-1-umang.jain@ideasonboard.com>
 <20230727154108.308320-2-umang.jain@ideasonboard.com>
Message-Id: <169047910522.2828.10861979635958643627.robh@kernel.org>
Subject: Re: [PATCH 1/2] media: dt-bindings: imx519: Add IMX519 DT bindings
Date:   Thu, 27 Jul 2023 11:31:45 -0600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Jul 2023 21:11:07 +0530, Umang Jain wrote:
> From: Lee Jackson <lee.jackson@arducam.com>
> 
> Add YAML device tree binding documentation for IMX519 CMOS
> image sensor.
> 
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  .../bindings/media/i2c/sony,imx519.yaml       | 113 ++++++++++++++++++
>  1 file changed, 113 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx519.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/sony,imx519.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/media/i2c/imx519.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/sony,imx519.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230727154108.308320-2-umang.jain@ideasonboard.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

