Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0001E7782A7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjHJVU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHJVU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:20:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AE22112;
        Thu, 10 Aug 2023 14:20:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A466C62FDF;
        Thu, 10 Aug 2023 21:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64306C433C8;
        Thu, 10 Aug 2023 21:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691702457;
        bh=aTpruaCrN8EvcNDHyPLrwo7LwRpHf6ghS06t2onmua0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YQBd3jojma44HVwAccg4LRHTT/59zulJtym26IzwXS1wlOY//9ssSpzDcUfpyZ9lr
         ZuSQq56O7bKVoeXphfT6MWxcVQx//hCENtHI57ioJsOX52Bbswox6NSKwv23nzKri1
         qGQp7wRtMVDK+565w5ISpAs/P75YXUEr/47nuFN6Ftx3lrmYpYbnSFrdJROIyDfSP3
         LvqQDMli1mTrRgbde6+BpzecSMaFFG9CnjyV5yTojbNs2aDSDG+lNRIdMTABANTCaR
         PeXnmiwmFFprXvxR/oO3RWlxwxbNTIeZX9UkXdK5RMqwgLwFcsKwfRxAA7jHSM/mQo
         fX+FkfK3Kxfgg==
Received: (nullmailer pid 1209197 invoked by uid 1000);
        Thu, 10 Aug 2023 21:20:54 -0000
Date:   Thu, 10 Aug 2023 15:20:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aleksandr Shubin <privatesub2@gmail.com>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor+dt@kernel.org>,
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
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4 1/3] dt-bindings: pwm: Add binding for Allwinner
 D1/T113-S3/R329 PWM controller
Message-ID: <20230810212054.GA1207489-robh@kernel.org>
References: <20230810145443.1053387-1-privatesub2@gmail.com>
 <20230810145443.1053387-2-privatesub2@gmail.com>
 <169168449014.480213.11243622755862466051.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169168449014.480213.11243622755862466051.robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 10:21:30AM -0600, Rob Herring wrote:
> 
> On Thu, 10 Aug 2023 17:54:26 +0300, Aleksandr Shubin wrote:
> > Allwinner's D1, T113-S3 and R329 SoCs have a new pwm
> > controller witch is different from the previous pwm-sun4i.
> > 
> > The D1 and T113 are identical in terms of peripherals,
> > they differ only in the architecture of the CPU core, and
> > even share the majority of their DT. Because of that,
> > using the same compatible makes sense.
> > The R329 is a different SoC though, and should have
> > a different compatible string added, especially as there
> > is a difference in the number of channels.
> > 
> > D1 and T113s SoCs have one PWM controller with 8 channels.
> > R329 SoC has two PWM controllers in both power domains, one of
> > them has 9 channels (CPUX one) and the other has 6 (CPUS one).
> > 
> > Add a device tree binding for them.
> > 
> > Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> > ---
> >  .../bindings/pwm/allwinner,sun20i-pwm.yaml    | 86 +++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> 
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230810145443.1053387-2-privatesub2@gmail.com

The bot was having an issue. This can be ignored.

Rob
