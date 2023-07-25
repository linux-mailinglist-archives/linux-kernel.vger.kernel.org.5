Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D71761859
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjGYM23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGYM20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:28:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B06172E;
        Tue, 25 Jul 2023 05:28:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38D0B616CC;
        Tue, 25 Jul 2023 12:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7825C433C8;
        Tue, 25 Jul 2023 12:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690288104;
        bh=p8pNTACbV+ueNS7caYlCSJAt3q/4mJV+EISnLrkoukg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lE7Bo4Mq1A4jWO5aPkHmIREVTgUR+4ZJHMKt+cMpftaGGzoIqnzKM0nmEWvdWCe4G
         pFdnnJtIAlG7kOGDruCtuct2diFGGo8D2ObmH9V+KGpD1f4MeJYQSD77dwaOJzRgEa
         N6p19RRAg01F8DAhkPRk8y/OIw1HCICOfeSI4t0uPA+3ibFNfzVqBMEWdTm5H3cjdk
         21PYWvU4XxVbBWhj3/f3PyUBehK1Q5Ti02KjXx4AkOnXCn6LlajAmmzu+IWIvZUu7z
         srps6H7gih7z0NHwcpuFsLDtjkTfsRYT1bSfsJs/W+0VZSHFRWussdNOqEQWf73Vog
         DaQwcQ7ElARig==
Received: (nullmailer pid 2822754 invoked by uid 1000);
        Tue, 25 Jul 2023 12:28:22 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Rob Herring <robh+dt@kernel.org>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20230725114030.1860571-1-Naresh.Solanki@9elements.com>
References: <20230725114030.1860571-1-Naresh.Solanki@9elements.com>
Message-Id: <169028810279.2822737.12983836362308976147.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: hwmon: Add Infineon TDA38640
Date:   Tue, 25 Jul 2023 06:28:22 -0600
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Jul 2023 13:40:26 +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> The TDA38640 has a bug in SVID mode and to enable a workaround
> remove the TDA38640 from trivial-devices and add a complete schema.
> 
> The schema adds the custom property 'infineon,en-pin-fixed-level' to
> signal a fixed level on the ENABLE pin and to enable the workaround.
> When the ENABLE pin is left floating it's internally pulled low.
> 
> If not specified the driver will continue to use the PMBUS_OPERATION
> register to enable the regulator. When specified the driver will use
> the PMBUS_ON_OFF_CONFIG register to enable the regulator.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../hwmon/pmbus/infineon,tda38640.yaml        | 50 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  2 files changed, 50 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230725114030.1860571-1-Naresh.Solanki@9elements.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

