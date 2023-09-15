Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1B77A2A54
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237867AbjIOWQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237883AbjIOWQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:16:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192F32130;
        Fri, 15 Sep 2023 15:16:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99B4C433C8;
        Fri, 15 Sep 2023 22:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694816183;
        bh=8/9Iwnwza/TRWfwL1yVUqZ9VoJBLxQOEU/LTTMOH1uo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=sEMK1s3t9tnA/d0DfxKpj4ILKrM4XkbQpVBMAw33Jt1RZGdCNa/EHdg1iBRvGan3V
         HTsU86alti/DlHVApX9rvysY+LpH8P6bYK31QEm6Bj6qEveqkQ+/yct/QDSjy04glz
         ysJrQdQdr/OxRCwjDZZ6aaYbtWrTnZySVmcYcb/ANH7vah0o2QCE4kmjvSFWwIbUNP
         yIHaDS5+bNJ/0rEGJxt5rptWAZDtpRLIoY1YKpqhm8pTc28/7sMqFn25ww7l8+1Nkd
         FJ+yxWRKN6t0DuymdM2a21EWLyHrt2kn6X+WPuwrJ66Ve32o+phQTa3vjB7euHVMvA
         JkUaoFKHSRqsw==
Received: (nullmailer pid 236414 invoked by uid 1000);
        Fri, 15 Sep 2023 22:16:20 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Beckett <bob.beckett@collabora.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org
In-Reply-To: <20230915-wave5_v12_on_media_master-v12-6-92fc66cd685d@collabora.com>
References: <20230915-wave5_v12_on_media_master-v12-0-92fc66cd685d@collabora.com>
 <20230915-wave5_v12_on_media_master-v12-6-92fc66cd685d@collabora.com>
Message-Id: <169481618060.236398.6210891129311691076.robh@kernel.org>
Subject: Re: [PATCH v12 6/7] dt-bindings: media: wave5: add yaml devicetree
 bindings
Date:   Fri, 15 Sep 2023 17:16:20 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 15 Sep 2023 23:11:35 +0200, Sebastian Fricke wrote:
> From: Robert Beckett <bob.beckett@collabora.com>
> 
> Add bindings for the wave5 chips&media codec driver
> 
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> ---
>  .../devicetree/bindings/media/cnm,wave5.yaml       | 66 ++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/media/cnm,wave5.yaml:19:9: [warning] wrong indentation: expected 6 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230915-wave5_v12_on_media_master-v12-6-92fc66cd685d@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

