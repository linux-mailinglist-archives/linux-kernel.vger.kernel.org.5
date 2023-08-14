Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DE577B8FD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjHNMrv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Aug 2023 08:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjHNMrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:47:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AFA2172C;
        Mon, 14 Aug 2023 05:47:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B39BB1063;
        Mon, 14 Aug 2023 05:48:15 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AAB93F64C;
        Mon, 14 Aug 2023 05:47:31 -0700 (PDT)
Date:   Mon, 14 Aug 2023 13:47:29 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Alan Ma <tech@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: nvmem: SID: Add binding for H616
 SID controller
Message-ID: <20230814134729.533f61b1@donnerap.manchester.arm.com>
In-Reply-To: <5856748.MhkbZ0Pkbq@jernej-laptop>
References: <20230814-sid-h616-v2-0-0267749b4471@somainline.org>
        <830e5e34-f6de-3233-4a12-06c8390169d1@linaro.org>
        <DKGDZR.4G4SZ781MVSV2@somainline.org>
        <5856748.MhkbZ0Pkbq@jernej-laptop>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 12:28:36 +0200
Jernej Škrabec <jernej.skrabec@gmail.com> wrote:

> Dne ponedeljek, 14. avgust 2023 ob 10:21:49 CEST je Martin Botka napisal(a):
> > On Mon, Aug 14 2023 at 10:08:38 AM +02:00:00, Krzysztof Kozlowski
> > 
> > <krzysztof.kozlowski@linaro.org> wrote:  
> > > On 14/08/2023 08:38, Martin Botka wrote:  
> > >>  Add binding for the SID controller found in H616 SoC
> > >>  
> > >>  Signed-off-by: Martin Botka <martin.botka@somainline.org>
> > >>  ---
> > >> 
> > >> Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
> > >> 
> > >> | 1 +
> > >> | 
> > >>   1 file changed, 1 insertion(+)
> > >>  
> > >>  diff --git
> > >> 
> > >> a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
> > >> b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
> > >> 
> > >>  index 296001e7f498..2ec0a1b8f803 100644
> > >>  ---
> > >> 
> > >> a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
> > >> 
> > >>  +++
> > >> 
> > >> b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
> > >> 
> > >>  @@ -27,6 +27,7 @@ properties:
> > >>             - const: allwinner,sun50i-a64-sid
> > >>         
> > >>         - const: allwinner,sun50i-h5-sid
> > >>         - const: allwinner,sun50i-h6-sid
> > >>  
> > >>  +      - const: allwinner,sun50i-h616-sid  
> > > 
> > > It does not look like you tested the DTS against bindings. Please run
> > > `make dtbs_check` (see
> > > Documentation/devicetree/bindings/writing-schema.rst or
> > > https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sour
> > > ces-with-the-devicetree-schema/ for instructions).
> > > 
> > > Best regards,
> > > Krzysztof  
> > 
> > Yea completely forgot. Sorry for that.
> > 
> > Will send v3 tomorrow with proper binding patch using items with enums  
> 
> Don't. You have cca. 1 month time now, since you missed at least window for DT 
> changes for 6.6.

Plus we need to figure out if my comment about using a fallback compatible
was actually correct, as asked here:
https://lore.kernel.org/linux-arm-kernel/20230811234212.2236c814@slackpad.lan/

Cheers,
Andre
