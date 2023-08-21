Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD11782D77
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbjHUPrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjHUPro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:47:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E498FA1;
        Mon, 21 Aug 2023 08:47:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A6DB63713;
        Mon, 21 Aug 2023 15:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232DEC433C7;
        Mon, 21 Aug 2023 15:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692632861;
        bh=OdLn/5VwnPYcOVsCm+SxsCuQhbrbLAaRF11wH0pSOb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s8fNMQA1Zn7WVe+BgPARVdchTxIZUalr5+U+um1aPXWS+g2QJrjG/cSgcnKkH6nad
         Ao1kq5R5JP3ezKEMdOXe26B+4Mc3xUPExkE43BUDSPa0KlY4mGJDjdwiJ4MypcCQqe
         pVel4Pm45bgEf+jrZy+zlJklXuvseyMMR6nthiYRiQZRcVZFXf3zEAmFHH592Z4b/3
         YSlpmd8X9eM57Bn93I7P6j8rzwKt287aP8GJ96LZp9IM8s75CXQtN2kIemw+K5m5eB
         SVLNvWi7r4Y6JpJjj+O4u2d6cIFfhyuorRdJWxDxzy3iM3Gyq7EnNrDQzeuN1gqygi
         HTXykkslXktjA==
Received: (nullmailer pid 1722819 invoked by uid 1000);
        Mon, 21 Aug 2023 15:47:39 -0000
Date:   Mon, 21 Aug 2023 10:47:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Maksim Kiselev <bigunclemax@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 2/5] ASoC: dt-bindings: Add schema for
 "allwinner,sun20i-d1-codec-analog"
Message-ID: <20230821154739.GA1720453-robh@kernel.org>
References: <20230805180506.718364-1-bigunclemax@gmail.com>
 <20230805180506.718364-3-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805180506.718364-3-bigunclemax@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2023 at 09:05:02PM +0300, Maksim Kiselev wrote:
> Add a DT schema to describe the analog part of the Allwinner D1/T113s
> internal audio codec.
> 
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> ---
>  .../allwinner,sun20i-d1-codec-analog.yaml     | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/allwinner,sun20i-d1-codec-analog.yaml

Looks the same as allwinner,sun8i-a23-codec-analog.yaml. Why can't you 
use that?

Rob
