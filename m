Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BEF7A8F73
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 00:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjITWdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 18:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjITWdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 18:33:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633D5AC;
        Wed, 20 Sep 2023 15:33:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37B8C433C8;
        Wed, 20 Sep 2023 22:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695249187;
        bh=fD0+k5jlOk1+esg3/yex9x7rq8+uB1F3iOO9pGrNP/s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RA5ATx83odooP+9SP/UgBA1oYQcTYqVM4GNzxLoXO1G3fs5He+/F+GAMcCWiNU17+
         xbzN20OmmydQR57UyPUQGY7Gb4jgVLSsV0Z5ogh/glvb3zVPIxKYA4lFW1/VodWX7h
         CkP6FsgfGqEOqxszM4+IZi5XrUUSJ8diOzeqdmKppXUC7xdc4lcuLG5DoUoTgIi/YO
         qxKs5BukW3rRyeFIARX4zgWj9BtipWBo/ARex/Ja72UipSfFtC9Q1oNvslXahyNqNd
         6+82TL4XL7nutjHDfJLOc18120/E/g4T0JwLL8Fp5bjI1IyagwNBrWXq1kKBYPYU4R
         e33l1IE/OW7Dw==
Received: (nullmailer pid 3103970 invoked by uid 1000);
        Wed, 20 Sep 2023 22:33:04 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Philip Molloy <pmolloy@baylibre.com>,
        Apelete Seketeli <aseketeli@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>
In-Reply-To: <20230920170253.203395-2-dlechner@baylibre.com>
References: <20230920170253.203395-1-dlechner@baylibre.com>
 <20230920170253.203395-2-dlechner@baylibre.com>
Message-Id: <169524918396.3103912.5071083113284747603.robh@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: iio: resolver: add devicetree
 bindings for ad2s1210
Date:   Wed, 20 Sep 2023 17:33:04 -0500
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 20 Sep 2023 12:02:50 -0500, David Lechner wrote:
> This adds new DeviceTree bindings for the Analog Devices, Inc. AD2S1210
> resolver-to-digital converter.
> 
> Signed-off-by: Apelete Seketeli <aseketeli@baylibre.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  .../bindings/iio/resolver/adi,ad2s1210.yaml   | 150 ++++++++++++++++++
>  1 file changed, 150 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml:102:12: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml:102:22: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml:102:34: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230920170253.203395-2-dlechner@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

