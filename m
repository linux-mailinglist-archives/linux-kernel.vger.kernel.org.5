Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE987AB804
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjIVRrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIVRrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:47:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D211494
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:46:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C83C433C7;
        Fri, 22 Sep 2023 17:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695404811;
        bh=fFQxg4Rz4GjFZugxozdndSgNXISpfnkbSpJ11bW+6OA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jRLqWf9mSuD59sCEiQszieC9KPYDD/iNV/2RGV4Xdqt0cnH/s/H9SYypt0yo2zgmO
         54MLtIg6ulX/hGC1S3Xv9FTFWVZghM3zlLb3pj2VrFUF973M24PScMfpZaZX8UwzD5
         9GSE7xii8ByH5bCW7cuXWGHHeFFj7AyeCtk58Wa2anrTS6sM87Qz9bOsleIEY79qB6
         0oOTRZORaulf4T/SSst+w+JOaqe7Gt6ikwlqVKwq6mAYs6qP6QSjsu/Bl2X8d1vSES
         MbbWluj4wLah3zEVzS5+WR7tDxrFrm1Y/achLiOkrdBYoDYtWkcqPJX0ZLZFHNFOvk
         9fBtxjPpFgIBg==
Received: (nullmailer pid 3342355 invoked by uid 1000);
        Fri, 22 Sep 2023 17:46:49 -0000
Date:   Fri, 22 Sep 2023 12:46:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Simon Glass <sjg@chromium.org>
Cc:     devicetree@vger.kernel.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Dhruva Gole <d-gole@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mtd: Add a schema for binman
Message-ID: <20230922174649.GA3320366-robh@kernel.org>
References: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
 <CAL_Jsq+WuYDU+yY98opTHr1PT-J9mFYJQBjVMnk+FSWLDUO33w@mail.gmail.com>
 <CAPnjgZ1pfxaMG1n5yOBhiOhsNrRjck1K92U7Ga=+VTY_jjjrVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPnjgZ1pfxaMG1n5yOBhiOhsNrRjck1K92U7Ga=+VTY_jjjrVg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 11:01:18AM -0600, Simon Glass wrote:
> Hi Rob,
> 
> On Fri, 22 Sept 2023 at 10:00, Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Sep 21, 2023 at 1:45 PM Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Binman[1] is a tool for creating firmware images. It allows you to
> > > combine various binaries and place them in an output file.
> > >
> > > Binman uses a DT schema to describe an image, in enough detail that
> > > it can be automatically built from component parts, disassembled,
> > > replaced, listed, etc.
> > >
> > > Images are typically stored in flash, which is why this binding is
> > > targeted at mtd. Previous discussion is at [2] [3].
> > >
> > > [1] https://u-boot.readthedocs.io/en/stable/develop/package/binman.html
> > > [2] https://lore.kernel.org/u-boot/20230821180220.2724080-3-sjg@chromium.org/
> > > [3] https://www.spinics.net/lists/devicetree/msg626149.html
> >
> > You missed:
> >
> > https://github.com/devicetree-org/dt-schema/pull/110
> >
> > where I said: We certainly shouldn't duplicate the existing partitions
> > bindings. What's missing from them (I assume we're mostly talking
> > about "fixed-partitions" which has been around forever I think (before
> > me))?
> >
> > To repeat, unless there is some reason binman partitions conflict with
> > fixed-partitions, you need to start there and extend it. From what's
> > posted here, it neither conflicts nor needs extending.
> 
> I think at this point I am just hopelessly confused. Have you taken a
> look at the binman schema? [1]

Why do I need to? That's used for some tool and has nothing to do with a 
device's DTB. However, I thought somewhere in this discussion you showed 
it under a flash device node. Then I care because then it overlaps with 
what we already have for partitions. If I misunderstood that, then just 
put your schema with your tool. Only users of the tool should care about 
the tool's schema.

> 
> I saw this file, which seems to extend a partition.
> 
> Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml

IIRC, that's a different type where partition locations are stored in 
the flash, so we don't need location and size in DT. 

> 
> I was assuming that I should create a top-level compatible = "binman"
> node, with subnodes like compatible = "binman,bl31-atf", for example.
> I should use the compatible string to indicate the contents, right?

Yes for subnodes, and we already have some somewhat standard ones for 
"u-boot" and "u-boot-env". Though historically, "label" was used. 

Top-level, meaning the root of the DT? That sound like just something 
for the tool, so I don't care, but it doesn't belong in the DTB.

> 
> Re extending, what is the minimum I can do? Are you looking for
> something like a "compress" property that indicates that the entry is
> compressed?
> 
> I'm really just a bit lost.

Me too.

Rob
