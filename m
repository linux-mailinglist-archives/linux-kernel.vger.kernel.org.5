Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16611779AC9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 00:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbjHKWnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 18:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjHKWnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 18:43:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D0292130;
        Fri, 11 Aug 2023 15:43:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A20F113E;
        Fri, 11 Aug 2023 15:44:20 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5C243F59C;
        Fri, 11 Aug 2023 15:43:35 -0700 (PDT)
Date:   Fri, 11 Aug 2023 23:42:37 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Martin Botka <martin.botka@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alan Ma <tech@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 2/3] nvmem: sunxi_sid: Add support for H616 SID
Message-ID: <20230811234212.2236c814@slackpad.lan>
In-Reply-To: <Y0A8ZR.WOK201QL3WRP1@somainline.org>
References: <20230811-sid-h616-v1-0-d1dfc9f47b19@somainline.org>
        <20230811-sid-h616-v1-2-d1dfc9f47b19@somainline.org>
        <20230811121754.3a4dc270@donnerap.manchester.arm.com>
        <Y0A8ZR.WOK201QL3WRP1@somainline.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 15:12:34 +0200
Martin Botka <martin.botka@somainline.org> wrote:

Hi,

Maxime, Srinivas, can you possibly shed some light on the exact scope of
this nvmem DT binding? See below for more details ...

> On Fri, Aug 11 2023 at 12:17:54 PM +01:00:00, Andre Przywara 
> <andre.przywara@arm.com> wrote:
> > On Fri, 11 Aug 2023 13:02:35 +0200
> > Martin Botka <martin.botka@somainline.org> wrote:
> > 
> > Hi Martin,
> >   
> >>  Add support for the H616 SID controller.  
> > 
> > thanks for upstreaming this!
> >   
> >> 
> >>  The config can be reused from A64.
> >> 
> >>  Signed-off-by: Martin Botka <martin.botka@somainline.org>
> >>  ---
> >>   drivers/nvmem/sunxi_sid.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >> 
> >>  diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
> >>  index a970f1741cc6..df6fb5e0b724 100644
> >>  --- a/drivers/nvmem/sunxi_sid.c
> >>  +++ b/drivers/nvmem/sunxi_sid.c
> >>  @@ -216,6 +216,7 @@ static const struct of_device_id 
> >> sunxi_sid_of_match[] = {
> >>   	{ .compatible = "allwinner,sun50i-a64-sid", .data = 
> >> &sun50i_a64_cfg },
> >>   	{ .compatible = "allwinner,sun50i-h5-sid", .data = 
> >> &sun50i_a64_cfg },
> >>   	{ .compatible = "allwinner,sun50i-h6-sid", .data = &sun50i_h6_cfg 
> >> },
> >>  +	{ .compatible = "allwinner,sun50i-h616-sid", .data = 
> >> &sun50i_a64_cfg },  
> > 
> > You don't need a new compatible string, then.
> > Just use
> >   compatible = "allwinner,sun50i-h616-sid", 
> > "allwinner,sun50i-a64-sid";
> > in the DT, and add that combo to the binding, then you don't need any
> > driver patches at all - with the added benefit of that already working
> > with existing kernels.  
> I added it cause H5 and A83T were added after their DT binding was in 
> and they also use A64 config.

Yeah, I saw this, and going back in the commit messages I found this:
"The H5 SoC have a SID controller that looks like the one in A64, the
cells are in the same offset but doesn't contain the same data (thermal
sensor calibration for example)."

So does the compatible string for the NVMEM *controller* really
encompass the location, encoding and meaning of all its NVMEM cells?
Isn't that described independently by the child nodes, that put names
to addresses, and that are referenced by other DT nodes?
Or was it originally not the case, and the scope changed over time?

It's certainly no biggie to use a single compatible string, and add a
single line to the driver (like in this patch), but it would be good to
know if this is really the intention.

Cheers,
Andre

> But I will drop this patch and use a64 compatible if that is the 
> prefered way :)
> > 
> > Though I wonder if that has really only 256 bytes of fuses? Do we 
> > have any
> > evidence of that?  
> Datasheet has 0 info regarding this. The way i got the size and offset 
> was to check the vendor code.
> The values matched A64.
> > 
> > Cheers,
> > Andre
> >   
> >>   	{/* sentinel */},
> >>   };
> >>   MODULE_DEVICE_TABLE(of, sunxi_sid_of_match);
> >>   
> >   
> 
> 
> 

