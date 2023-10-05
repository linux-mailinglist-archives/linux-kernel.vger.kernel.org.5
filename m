Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E1C7BA276
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjJEPh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjJEPhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:37:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC08535C13
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:53:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370E2C116B3;
        Thu,  5 Oct 2023 08:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696496072;
        bh=hQbtd31t4QHbvyBGz5T+T1ipc8YUCa20YCG3jNUgn0c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CExoHALnmYDPpztn+tOoDI54e7b4nvxQxISJzG5OqWHLd0gsi6a0Drk5kTNnI40iy
         nso9DnGe2lxkB9BOWy3+zUMGIFVtYxzG3BFO4QjIGRnOgmvybs+bRvBXQl/Sv5lSq6
         vKEEVsI8KLidhbQEwp7vZ/0lmZam/mvfwM5PIDlBET8YoOTyP5s6klwPG4hKcAVmzH
         RJ5L30MxsD4CvIZoR/yRB25Omn8y7/ajCbAkt88P2sbUdiucsOenfGdyIJNDhS1iI4
         vN1rBQ207mO+3L2j3djzMrT//Ft3Alin+SpQ+E5aHTGuGWXwkUsgMwejvBCAprZ7Io
         zvMV8FdFExiGA==
MIME-Version: 1.0
Date:   Thu, 05 Oct 2023 10:54:26 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     Simon Glass <sjg@chromium.org>
Cc:     miquel.raynal@bootlin.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        ptyadav@amazon.de, rafal@milecki.pl, richard@nod.at,
        robh+dt@kernel.org, robh@kernel.org, trini@konsulko.com,
        u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: fixed-partitions: Add binman
 compatible
In-Reply-To: <CAPnjgZ20ezipPWAj6bUM9_oCTcX1XzuLqQ7b7-nKjXf1t4p9-Q@mail.gmail.com>
References: <20231004093620.2b1d6917@xps-13>
 <20231004113458.531124-1-mwalle@kernel.org>
 <CAPnjgZ2hWE6Sc=rg55W=-r-TnoWP7Y5gSpn41kwoyja-AMVw+w@mail.gmail.com>
 <9e588e3ec8c0c321a2861723d0d42b9a@kernel.org>
 <CAPnjgZ20ezipPWAj6bUM9_oCTcX1XzuLqQ7b7-nKjXf1t4p9-Q@mail.gmail.com>
Message-ID: <a581ef73fa09c6ffeb83a1c1780053bd@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> >> >> Add a compatible string for binman, so we can extend fixed-partitions
>> >> >> in various ways.
>> >> >
>> >> > I've been thinking at the proper way to describe the binman partitions.
>> >> > I am wondering if we should really extend the fixed-partitions
>> >> > schema. This description is really basic and kind of supposed to remain
>> >> > like that. Instead, I wonder if we should not just keep the binman
>> >> > compatible alone, like many others already. This way it would be very clear
>> >> > what is expected and allowed in both cases. I am thinking about
>> >> > something like that:
>> >> >
>> >> >       Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
>> >> >
>> >> > this file is also referenced there (but this patch does the same, which
>> >> > is what I'd expect):
>> >> >
>> >> >       Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
>> >> >
>> >> > I'll let the binding maintainers judge whether they think it's
>> >> > relevant, it's not a strong opposition.
>> >>
>> >> What is the overall goal here? To replace the current binman node
>> >> which is
>> >> usually contained in the -u-boot.dtsi files? If one is using binman to
>> >> create an image, is it expected that one needs to adapt the DT in
>> >> linux?
>> >> Or will it still be a seperate -u-boot.dtsi? > Because in the latter
>> >> case
>> >> I see that there will be conflicts because you have to overwrite the
>> >> flash node. Or will it be a seperate node with all the information
>> >> duplicated?
>> >
>> > The goal is simply to have a full binding for firmware layout, such
>> > that firmware images can be created, examined and updated. The
>> > -u-boot.dtsi files are a stopgap while we sort out a real binding.
>> > They should eventually go away.
>> 
>> You haven't answered whether this node should be a seperate binman
>> node - or if you'll reuse the existing flash (partitions) node(s) and
>> add any missing property there. If it's the latter, I don't think
>> compatible = "binman", "fixed-partitions"; is correct.
> 
> My intent is to make it compatible, so wouldn't it make sense to have
> binman as the first compatible, then falling back to fixed-partitions
> as the second?

As far as I know, the compatibles should get more specific with each
string. But "binman" seems to be used as a kind of tag which could be
added to any compatible under the flash node. What if one wants to build
an image which isn't compatible = "fixed-partitions"? E.g.
"linksys,ns-partitions", will it then have
compatible = "binman", "linksys,ns-partitions"?


>> >> Maybe (a more complete) example would be helpful.
>> >
>> > Can you please be a bit more specific? What is missing from the
>> > example?
>> 
>> Like a complete (stripped) DTS. Right now I just see how the 
>> individual
>> node looks like. But with a complete example DTS, my question from 
>> above
>> would have been answered.

So to give an example myself, please correct it if it's wrong. From
our board (kontron-sl28):

&fspi {
         status = "okay";

         flash@0 {
                 compatible = "jedec,spi-nor";
                 m25p,fast-read;
                 spi-max-frequency = <133000000>;
                 reg = <0>;
                 /* The following setting enables 1-1-2 (CMD-ADDR-DATA) 
mode */
                 spi-rx-bus-width = <2>; /* 2 SPI Rx lines */
                 spi-tx-bus-width = <1>; /* 1 SPI Tx line */

                 partitions {
                         compatible = "fixed-partitions";
                         #address-cells = <1>;
                         #size-cells = <1>;

                         partition@0 {
                                 reg = <0x000000 0x010000>;
                                 label = "rcw";
                                 read-only;
                         };

                         partition@10000 {
                                 reg = <0x010000 0x1d0000>;
                                 label = "failsafe bootloader";
                                 read-only;
                         };

                         partition@200000 {
                                 reg = <0x200000 0x010000>;
                                 label = "configuration store";
                         };

                         partition@210000 {
                                 reg = <0x210000 0x1d0000>;
                                 label = "bootloader";
                         };

                         partition@3e0000 {
                                 reg = <0x3e0000 0x020000>;
                                 label = "bootloader environment";
                         };
                 };
         };
};

In u-boot we use binman, see 
arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi
in the u-boot repository.

Now to use the new method, am I expected to adapt the dts in the
linux kernel? As far as I understand that is the case. So that node
from above would look something like the following:

&fspi {
         status = "okay";

         flash@0 {
                 compatible = "jedec,spi-nor";
                 m25p,fast-read;
                 spi-max-frequency = <133000000>;
                 reg = <0>;
                 /* The following setting enables 1-1-2 (CMD-ADDR-DATA) 
mode */
                 spi-rx-bus-width = <2>; /* 2 SPI Rx lines */
                 spi-tx-bus-width = <1>; /* 1 SPI Tx line */

                 partitions {
                         compatible = "binman", "fixed-partitions";
                         #address-cells = <1>;
                         #size-cells = <1>;
[..]
                         partition@210000 {
                                 reg = <0x210000 0x1d0000>;
                                 label = "u-boot"; /* or "u-boot+atf" ? 
*/
                         };

                         partition@3e0000 {
                                 reg = <0x3e0000 0x020000>;
                                 label = "bootloader environment";
                         };
                 };
         };
};

I'm still not sure why that compatible is needed. Also I'd need to 
change
the label which might break user space apps looking for that specific 
name.

Also, our board might have u-boot/spl or u-boot/spl/bl31/bl32, right now
that's something which depends on an u-boot configuration variable, 
which
then enables or disables binman nodes in the -u-boot.dtsi. So in linux
we only have that "bootloader" partition, but there might be either
u-boot+spl or u-boot+spl+bl31+bl32.

Honestly, I'm really not sure this should go into a device tree.

>> What if a board uses eMMC to store the firmware binaries? Will that 
>> then
>> be a subnode to the eMMC device?
> 
> I thought there was a way to link the partition nodes and the device
> using a property, without having the partition info as a subnode of
> the device. But I may have imagined it as I cannot find it now. So
> yes, it will be a subnode of the eMMC device.

Not sure if that will fly.

-michael
