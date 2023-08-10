Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC787775A2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbjHJKVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHJKV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:21:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E699F;
        Thu, 10 Aug 2023 03:21:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4434360C7C;
        Thu, 10 Aug 2023 10:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1741FC433C7;
        Thu, 10 Aug 2023 10:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691662885;
        bh=/oo6Cti5X2PkHJVhs0kFuUVMAQ5VK2S+ldpqgHl8wrU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qDk2oabu2xbNFZJsSC6pjuDJ025V+GfGk9RWZPz3fM+069ZH+yTJOc4maoAfbY/QQ
         9XDt680gmylpV/XPbhFiapn5dSuxqwdKLv2XhvHGkYgHgE58khHDGO/LXPGwT1Rg4b
         cX3V+9tt+n3LmHoVSszZ6bqE+nKQ4xlEkyB5Yam2YsZuQmgt+wTakBUBPL4JhP+TOs
         dd3YBtcC9O85Zk83aXx6vRqBtb09jOxypJ+Klc3lU6Ddx00v1TOJ1cIX/K59k+AiKa
         ufDg/cjbCtPdZfDKsuSjySiXB2JEqag8tGOCctF1GNKAn9jjcc9ACse1x5Uh0/HcPp
         P2TzMvh69yxew==
Received: (nullmailer pid 4166371 invoked by uid 1000);
        Thu, 10 Aug 2023 10:21:23 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc:     =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org, ChiaEn Wu <chiaen_wu@richtek.com>,
        linux-iio@vger.kernel.org, ChiYuan Huang <cy_huang@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20230810093322.593259-1-mitrutzceclan@gmail.com>
References: <20230810093322.593259-1-mitrutzceclan@gmail.com>
Message-Id: <169166288203.4166285.8158781296690048623.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: adc: add AD717X
Date:   Thu, 10 Aug 2023 04:21:23 -0600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Aug 2023 12:33:16 +0300, Dumitru Ceclan wrote:
> The AD717x family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel
> applications or higher speed multiplexed applications. The Sigma-Delta
> ADC is intended primarily for measurement of signals close to DC but also
> delivers outstanding performance with input bandwidths out to ~10kHz.
> 
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> ---
>  .../bindings/iio/adc/adi,ad717x.yaml          | 158 ++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad717x.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230810093322.593259-1-mitrutzceclan@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

