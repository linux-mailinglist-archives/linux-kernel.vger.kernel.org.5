Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCFC7932D4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 02:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241396AbjIFAKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 20:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjIFAKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 20:10:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5371B4;
        Tue,  5 Sep 2023 17:10:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04780C433C7;
        Wed,  6 Sep 2023 00:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693959011;
        bh=AF81hHBKCg+qgjfLn7H5s7cUAHPMvdx2KTsN0F/1tUs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=o5KJvdZskfi55/JM5eL3GPQXEXxesRQqDMK2Gva3GP/pIti1EJE6LJ+5oUKVWuhoA
         G7EXutsi0JqSoe9PNpIYQFx5D9hld+L1VPBg8f803mnp0jdD7OOxdpp3zRUwAkZ6QG
         LCT/7ssoCIW1eO0hVHOQgnWOZ4gbt+eAQpsOMwtHH2vgnAcYOJh/+q18174EupIreG
         Ov2ykoDKU/GBImes2/O2oS22dst6weJsXcMjKlw2WpM5suLOjSVjhf3tvQd2IFAOlK
         wUHayuvo0KQZzQb/JjaJIx8YMuG2fHQ67SJRKD3y5/R2wvxPkjUH84EWGDS2VBZCLb
         pzQ4HDu7eJmQQ==
Received: (nullmailer pid 66288 invoked by uid 1000);
        Wed, 06 Sep 2023 00:10:08 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230905233118.183140-2-paul.elder@ideasonboard.com>
References: <20230905233118.183140-1-paul.elder@ideasonboard.com>
 <20230905233118.183140-2-paul.elder@ideasonboard.com>
Message-Id: <169395900872.66258.7184664579844889748.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: media: Add THine THP7312 ISP
Date:   Tue, 05 Sep 2023 19:10:08 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 06 Sep 2023 08:31:16 +0900, Paul Elder wrote:
> Add bindings for the THine THP7312 ISP.
> 
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> ---
> Since the THP7312 supports multiple sensors, thine,rx-data-lanes alone
> might not be enough. I was consdering using sensor nodes like what the
> AP1302 does [1]. This way we can also move the power supplies that only
> concern the sensor in there as well. I was wondering what to do about
> the model name, though, as the thp7312 completely isolates that from the
> rest of the system.
> 
> I'm planning to add sensor nodes in somehow in a v2.
> 
> [1] https://lore.kernel.org/linux-media/20211006113254.3470-2-anil.mamidala@xilinx.com/
> 
>  .../bindings/media/thine,thp7312.yaml         | 170 ++++++++++++++++++
>  1 file changed, 170 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/thine,thp7312.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/media/thine,thp7312.yaml:35:20: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/media/thine,thp7312.example.dts'
Documentation/devicetree/bindings/media/thine,thp7312.yaml:35:20: mapping values are not allowed here
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/media/thine,thp7312.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/media/thine,thp7312.yaml:35:20: mapping values are not allowed here
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/thine,thp7312.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1500: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230905233118.183140-2-paul.elder@ideasonboard.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

