Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F8278C7B5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbjH2Ogf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236938AbjH2OgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:36:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF8798;
        Tue, 29 Aug 2023 07:36:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEFF06332B;
        Tue, 29 Aug 2023 14:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5489C433C7;
        Tue, 29 Aug 2023 14:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693319761;
        bh=0l/TKkMM8cuZW7T9AiQkiMQpBOPt3D2MfDWScmErUpI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SxI4UVN6zd3vpqlraRiTv8SSelrtWFwZK1lWalU4lFc6HxtBTCz6/n/QfDBzs1zGD
         Htfn2hJ064dsdOq98TzXB54IYuQr6LJilpamQGNPXy6OEQpxDDzfNQl6f3Dju5Ne62
         yaRh5SnEWGqDGuuKmIzJYN8kwd6ccHfuUQ1s124ERiy+FUpf+rMOcmku3W31HceycK
         jk1jDiGshfrO9E3dDhdRLgrnJgvGhGnQLjrGyl19dYEHRahOio8DCSNZRY8qA9/VuF
         TrHJDS2h23X6u1se3YyfWcRXamsWkhzdVE7fhFCA8iYPClWlV2KN762Ecg29WX5QFg
         sjqY2TeC/ydag==
Received: (nullmailer pid 2142027 invoked by uid 1000);
        Tue, 29 Aug 2023 14:35:58 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     Dan Scally <dan.scally@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
In-Reply-To: <20230829132357.192535-2-alain.volmat@foss.st.com>
References: <20230829132357.192535-1-alain.volmat@foss.st.com>
 <20230829132357.192535-2-alain.volmat@foss.st.com>
Message-Id: <169331975827.2141970.16841461499129826658.robh@kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: media: add bindings for dcmipp
 driver
Date:   Tue, 29 Aug 2023 09:35:58 -0500
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Aug 2023 15:23:45 +0200, Alain Volmat wrote:
> Add the yaml binding for the DCMIPP driver.
> 
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> ---
>  .../bindings/media/st,stm32-dcmipp.yaml       | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/st,stm32-dcmipp.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/st,stm32-dcmipp.yaml: title: 'STMicroelectronics STM32 DCMIPP Digital Camera Memory Interface Pixel Processor binding' should not be valid under {'pattern': '([Bb]inding| [Ss]chema)'}
	hint: Everything is a binding/schema, no need to say it. Describe what hardware the binding is for.
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230829132357.192535-2-alain.volmat@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

