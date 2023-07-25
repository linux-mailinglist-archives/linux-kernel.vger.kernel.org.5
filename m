Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797347623ED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjGYUuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjGYUuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:50:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C78B10F6;
        Tue, 25 Jul 2023 13:50:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A17436190B;
        Tue, 25 Jul 2023 20:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2942EC433C8;
        Tue, 25 Jul 2023 20:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690318202;
        bh=OxHy1M+w3k5feey0r7EI3cqLr0BlVNtReBhSOwd11qk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cgnLAJk3fYihilvzDBpn4mTbVuTl8dlTjQFjLuVU6jHODXYR1vuKl4dDRTLQvHa6l
         mQh8a0kZOJJl26BMt3nN7Hr+whILmI3NyN59lEa0Ap/9enm7IJvI5qdKXeaULvcSfx
         ueRfE5oDiHmXRdAmWVupels1Qw/Vf3q2CsqMTM/hLymvrjwyi8D2rGTCG/2UmHaI3I
         AtqynrXwfRUgezbUCIhFiHei4j07zRojGzbkGXQ1vRzkwkPk7jPcbOBIMff9ZUYblz
         PQ4T2bRHjkOz18HmGO7mK0eP0AgsEAgN0lyFXXOqBPLnxeqnfuwO9RY6aQZK34LcA1
         yiORDThMi5umQ==
Received: (nullmailer pid 3767420 invoked by uid 1000);
        Tue, 25 Jul 2023 20:49:59 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     linux-pwm@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, luca.weiss@fairphone.com,
        konrad.dybcio@linaro.org, agross@kernel.org,
        thierry.reding@gmail.com, pavel@ucw.cz, conor+dt@kernel.org,
        andersson@kernel.org, u.kleine-koenig@pengutronix.de,
        quic_subbaram@quicinc.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        lee@kernel.org, krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20230725193423.25047-2-quic_amelende@quicinc.com>
References: <20230725193423.25047-1-quic_amelende@quicinc.com>
 <20230725193423.25047-2-quic_amelende@quicinc.com>
Message-Id: <169031819898.3767391.330263271365632827.robh@kernel.org>
Subject: Re: [PATCH v2 1/7] dt-bindings: soc: qcom: Add qcom-pbs bindings
Date:   Tue, 25 Jul 2023 14:49:59 -0600
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Jul 2023 12:34:17 -0700, Anjelique Melendez wrote:
> Add binding for the Qualcomm Programmable Boot Sequencer device.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  .../bindings/soc/qcom/qcom-pbs.yaml           | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/soc/qcom/qcom-pbs.example.dts:18.16-26.11: Warning (unit_address_vs_reg): /example-0/pmic@0: node has a unit name, but no reg or ranges property

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230725193423.25047-2-quic_amelende@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

