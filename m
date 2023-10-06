Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354267BB8E7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjJFNSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjJFNSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:18:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652AA83;
        Fri,  6 Oct 2023 06:18:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE96CC433C8;
        Fri,  6 Oct 2023 13:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696598329;
        bh=u2GIT0lse2wS60plD52rNEhfKu8JINFb0VqbN2wQLa4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=krjLWP6Xj7pgflul8+Fhu5Pv/P4FQ1+zhfx2pLjkOnylFNtLTiRZKY2hbTXrrQceO
         9/Pv5uQGIxuUmjNDxEPwyGwsGEcoCuK6qiGWTleQg3o0a/Y1/prREpD5x7ILg874uL
         MMPcr5OPzTuyBPMrcL2/8Pro4NGAI/VW0RDHqn79af47JrJKBO9ABHb2FYBAm7t0PU
         sS1w3IYIgYzQsXxM618aJhdBad+D87DXCqkvBcOQBigcK04cIPTzGQAPvKD7NSQ0u2
         cG4nx6oEjdCqR9aSJ1JFoisKiwYQvbLpWjSKadYDtmX4+YpEFoTcmfrJn+soVIXudJ
         Kyu2ajSJSXcfA==
Received: (nullmailer pid 3410063 invoked by uid 1000);
        Fri, 06 Oct 2023 13:18:43 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, devicetree@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <5716404.DvuYhMxLoT@kreacher>
References: <5716404.DvuYhMxLoT@kreacher>
Message-Id: <169659832348.3409986.16820307308672715034.robh@kernel.org>
Subject: Re: [PATCH v1] thermal: Remove Amit Kucheria from MAINTAINERS
Date:   Fri, 06 Oct 2023 08:18:43 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 06 Oct 2023 13:21:14 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Amit Kucheria has not been participating in kernel development in any
> way or form for quite some time, so it is not useful to list him as a
> designated reviewer for the thermal subsystem or as the maintainer of
> the thermal zone device bindings.
> 
> Remove him from those two places accordingly.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  Documentation/devicetree/bindings/thermal/thermal-zones.yaml |    3 ---
>  MAINTAINERS                                                  |    1 -
>  2 files changed, 4 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-zones.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/5716404.DvuYhMxLoT@kreacher

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

