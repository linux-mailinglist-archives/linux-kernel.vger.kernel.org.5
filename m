Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534527BBC7D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjJFQLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjJFQLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:11:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E129E
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 09:11:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A9BC433C7;
        Fri,  6 Oct 2023 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696608676;
        bh=2E1MNctTSxoG5VE50oJM9yMY/dfSLIM7MkC8uY5n6I8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ndf7M6I2Ha7XUsr7BbDTNhDj9gLpk/Iui5kN6/CI4DaL7NubEIq2KjsGCtRLhiBBw
         JCCJ+sJpzASxFIRjx1xBGpWYjcBxJEa8RxYiWPbzuN1jNQQJpLxmYwIj5b5lTWmY5m
         NYeU1AIPn0Fa8GZitrh4ihWmaaCagI0N9FjMcCf+JYqzjbN5X0kcmpGoewd9ppxw3F
         +9D+uOGyJeaZT4JKaU+LezQ/Mci/Yy99M0NC899FUn473ikndsKYOoG9Ow2WXSRzGJ
         +T1m1tm19vjw5DsACRmWo5GMxyDJWd0xidAsGiZfNT0bJWNUd4oX4CNB5xonhPgWJw
         WrkAcKEk28Hsw==
Received: (nullmailer pid 4016330 invoked by uid 1000);
        Fri, 06 Oct 2023 16:11:13 -0000
Date:   Fri, 6 Oct 2023 11:11:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <mwalle@kernel.org>
Cc:     Simon Glass <sjg@chromium.org>, miquel.raynal@bootlin.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, ptyadav@amazon.de, rafal@milecki.pl,
        richard@nod.at, trini@konsulko.com, u-boot@lists.denx.de,
        vigneshr@ti.com
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: fixed-partitions: Add binman
 compatible
Message-ID: <20231006161113.GA3983739-robh@kernel.org>
References: <20231004093620.2b1d6917@xps-13>
 <20231004113458.531124-1-mwalle@kernel.org>
 <CAPnjgZ2hWE6Sc=rg55W=-r-TnoWP7Y5gSpn41kwoyja-AMVw+w@mail.gmail.com>
 <9e588e3ec8c0c321a2861723d0d42b9a@kernel.org>
 <CAPnjgZ20ezipPWAj6bUM9_oCTcX1XzuLqQ7b7-nKjXf1t4p9-Q@mail.gmail.com>
 <a581ef73fa09c6ffeb83a1c1780053bd@kernel.org>
 <CAPnjgZ2PnKD5m0EgTdEAf-gcK3wuBZvWw_AO2iehb1dmfdoz3A@mail.gmail.com>
 <27d37d4c7cf353d99737a1e7a450f9f7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27d37d4c7cf353d99737a1e7a450f9f7@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 10:37:41AM +0200, Michael Walle wrote:
> Hi,
> 
> > > I'm still not sure why that compatible is needed. Also I'd need to
> > > change
> > > the label which might break user space apps looking for that specific
> > > name.
> > > 
> > > Also, our board might have u-boot/spl or u-boot/spl/bl31/bl32, right
> > > now
> > > that's something which depends on an u-boot configuration variable,
> > > which
> > > then enables or disables binman nodes in the -u-boot.dtsi. So in linux
> > > we only have that "bootloader" partition, but there might be either
> > > u-boot+spl or u-boot+spl+bl31+bl32.
> > > 
> > > Honestly, I'm really not sure this should go into a device tree.
> > 
> > I think we might be getting a bit ahead of ourselves here. I thought
> > that the decision was that the label should indicate the contents.
> > If you have multiple things in a partition then it would become a
> > 'section' in Binman's terminology. Either the label programmatically
> > describes what is inside or it doesn't. We can't have it both ways.
> > What do you suggest?
> 
> As Rob pointed out earlier, it's just a user-facing string. I'm a bit
> reluctant to use it programatically.

In general, yes, but the partition stuff has long (and still) uses 
label. As long as the values the tools understand are documented (which 
we don't normally do for label), I don't care so much. That's my 
opinion as long as this is shared with fixed-partitions. If it is not 
and there's little reason to use label, then absolutely, I think 
'compatible' makes more sense. 

> Taking my example again, the string "bootloader" is sufficient for a
> user. He doesn't care if it's u-boot with spl or u-boot with tfa, or
> even coreboot. It just says, "in this partition is the bootloader".
> If you have an "bootloader" image you can flash it there.

These days, there's generally not just 1 bootloader in the boot flow. 
Maybe there's 1 image, maybe not. Being more specific is hardly ever a 
bad thing. Only when the number of specific things becomes multiple 10s 
or 100s of them does it become a problem.


> If it has a label "u-boot" and I want to switch to coreboot, will
> it have to change to "coreboot"? I really don't think this is practical,
> you are really putting software configuration into the device tree.

On the input side (to binman), yes it is config, but on the output side 
(to the running system) we are saying what's there.


> > At present it seems you have the image described in two places - one
> > is the binman node and the other is the partitions node. I would like
> > to unify these.
> 
> And I'm not sure that will work for all the corner cases :/
> 
> If you keep the binman section seperate from the flash partition
> definition you don't have any of these problems, although there is
> some redundancy:
>  - you only have compatible = "binman", "fixed-partition", no further
>    compatibles are required
>  - you don't have any conflicts with the current partition descriptions
>  - you could even use the labels, because binman is the (only?) user
> 
> But of course you need to find a place where to put your node.

And remove it. We don't need 2 sources of truth in the DTB.

Rob
