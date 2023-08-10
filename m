Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295E1777E11
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbjHJQVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjHJQVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:21:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6281F26A0;
        Thu, 10 Aug 2023 09:21:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2608662F0;
        Thu, 10 Aug 2023 16:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE51C433C7;
        Thu, 10 Aug 2023 16:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691684495;
        bh=hCwAGNIRbmhd9GFgLU8q0nWUYmzdIjXNkRYpjhTQKhc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cd/j3BW98vgcZo/RJxhBP6SFvlhvk23q4ABBH79QyLK2gpggMzpq5RdUqrg8pofq8
         57t24mZY7DT5fy88eJCl9TcJUO3o+CLPuRac5myfWkZ0rguItvIz2QGdCzjIDJApZ0
         XBoaLFzgl1ZJZkZ+QqF1//ekMRVs4OcRBzsQGNk7abLZSl2cFh57N2T6TVNOOQ55BM
         DeVcznijWwEZ7nPBFEzRYmp7b+8+UnMO2NPNTZaSby6FM6JLpRgNx15zH322qKJJ4a
         JdTTkrhdHVCGMhBFMtJeUfPRQTN8pVqKwQaqqMOC0iuRiSYrN+dpBhRuAuL6DC81wL
         8axN1JLJ3Wu+w==
Received: (nullmailer pid 480251 invoked by uid 1000);
        Thu, 10 Aug 2023 16:21:30 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Aleksandr Shubin <privatesub2@gmail.com>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-arm-kernel@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>, linux-sunxi@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230810145443.1053387-2-privatesub2@gmail.com>
References: <20230810145443.1053387-1-privatesub2@gmail.com>
 <20230810145443.1053387-2-privatesub2@gmail.com>
Message-Id: <169168449014.480213.11243622755862466051.robh@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: pwm: Add binding for Allwinner
 D1/T113-S3/R329 PWM controller
Date:   Thu, 10 Aug 2023 10:21:30 -0600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Aug 2023 17:54:26 +0300, Aleksandr Shubin wrote:
> Allwinner's D1, T113-S3 and R329 SoCs have a new pwm
> controller witch is different from the previous pwm-sun4i.
> 
> The D1 and T113 are identical in terms of peripherals,
> they differ only in the architecture of the CPU core, and
> even share the majority of their DT. Because of that,
> using the same compatible makes sense.
> The R329 is a different SoC though, and should have
> a different compatible string added, especially as there
> is a difference in the number of channels.
> 
> D1 and T113s SoCs have one PWM controller with 8 channels.
> R329 SoC has two PWM controllers in both power domains, one of
> them has 9 channels (CPUX one) and the other has 6 (CPUS one).
> 
> Add a device tree binding for them.
> 
> Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> ---
>  .../bindings/pwm/allwinner,sun20i-pwm.yaml    | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230810145443.1053387-2-privatesub2@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

