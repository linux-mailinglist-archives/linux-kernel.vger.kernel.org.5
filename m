Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4AE75B187
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjGTOrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjGTOrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:47:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB68CC6;
        Thu, 20 Jul 2023 07:47:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5168B61864;
        Thu, 20 Jul 2023 14:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC089C433C8;
        Thu, 20 Jul 2023 14:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689864427;
        bh=OWSNdJ6+UGJVWhcZZSiyF3kHUOtArl1NIXk74sceGqI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YoOzAfYBCM9JRb0ii9wk1NL308dgPR4vXqffEy+S64E2B2wD+TKjqBJCZG+x85XHt
         0jfuD1hJ82NVMI1Zlt+SDRPA7T65rEe8ww+a6Pg6djAppTLBFP6V0GjK3h4apJiZn8
         sMHh2zuwAWKUB234AhlPqz0atBXPScPEoB/LF7CnDUehI7Vd+WzShziOZCUJ496+7e
         hP0R5KoLZPRVlcAFxc3dp5vMqqPkI9YiMGM7zFjBbLSIywYiGrU8zkUDOsi1r2zo0g
         A2ycJh4EPaklOfC6pf34ZQBUbmlQqGprEA1yjNwwyjgBjzey06mh7zLjL/q5nq2gQt
         9NuuRS+wpsLPw==
Received: (nullmailer pid 2635378 invoked by uid 1000);
        Thu, 20 Jul 2023 14:47:04 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Eric Lin <eric.lin@sifive.com>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tglx@linutronix.de, zong.li@sifive.com,
        linux-kernel@vger.kernel.org, Nick Hu <nick.hu@sifive.com>,
        vincent.chen@sifive.com, linux-riscv@lists.infradead.org,
        paul.walmsley@sifive.com, peterz@infradead.org,
        greentime.hu@sifive.com, will@kernel.org, palmer@dabbelt.com,
        conor+dt@kernel.org
In-Reply-To: <20230720135125.21240-2-eric.lin@sifive.com>
References: <20230720135125.21240-1-eric.lin@sifive.com>
 <20230720135125.21240-2-eric.lin@sifive.com>
Message-Id: <168986442455.2635362.6562546888592020035.robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: riscv: sifive: Add SiFive Private
 L2 cache controller
Date:   Thu, 20 Jul 2023 08:47:04 -0600
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Jul 2023 21:51:19 +0800, Eric Lin wrote:
> This add YAML DT binding documentation for SiFive Private L2
> cache controller
> 
> Signed-off-by: Eric Lin <eric.lin@sifive.com>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Reviewed-by: Nick Hu <nick.hu@sifive.com>
> ---
>  .../bindings/cache/sifive,pl2cache.yaml       | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cache/sifive,pl2cache.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cache/sifive,ccache0.example.dtb: cache-controller@2010000: compatible:0: 'sifive,pl2cache1' was expected
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cache/sifive,ccache0.example.dtb: cache-controller@2010000: 'interrupts', 'memory-region' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: l2-cache: compatible:0: 'sifive,pl2cache1' was expected
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: l2-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: l2-cache: 'cache-block-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: l2-cache: 'cache-sets' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: l2-cache: 'cache-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: l2-cache: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: l2-cache: compatible:0: 'sifive,pl2cache1' was expected
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: l2-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: l2-cache: 'cache-block-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: l2-cache: 'cache-sets' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: l2-cache: 'cache-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: l2-cache: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dtb: l2-cache: compatible:0: 'sifive,pl2cache1' was expected
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dtb: l2-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dtb: l2-cache: 'cache-block-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dtb: l2-cache: 'cache-sets' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dtb: l2-cache: 'cache-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dtb: l2-cache: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dtb: l2-cache: 'l3-cache' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dtb: l3-cache: compatible:0: 'sifive,pl2cache1' was expected
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dtb: l3-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dtb: l3-cache: 'cache-block-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dtb: l3-cache: 'cache-sets' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dtb: l3-cache: 'cache-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dtb: l3-cache: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible:0: 'sifive,pl2cache1' was expected
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-block-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-sets' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'l3-cache' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l3-cache: compatible:0: 'sifive,pl2cache1' was expected
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l3-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l3-cache: 'cache-block-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l3-cache: 'cache-sets' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l3-cache: 'cache-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l3-cache: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible:0: 'sifive,pl2cache1' was expected
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-block-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-sets' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible:0: 'sifive,pl2cache1' was expected
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-block-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-sets' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible:0: 'sifive,pl2cache1' was expected
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-block-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-sets' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible:0: 'sifive,pl2cache1' was expected
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-block-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-sets' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible:0: 'sifive,pl2cache1' was expected
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-block-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-sets' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible:0: 'sifive,pl2cache1' was expected
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-block-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-sets' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible:0: 'sifive,pl2cache1' was expected
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-block-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-sets' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'cache-size' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230720135125.21240-2-eric.lin@sifive.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

