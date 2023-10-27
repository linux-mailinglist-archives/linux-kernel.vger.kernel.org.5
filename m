Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56007D966D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345745AbjJ0LVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjJ0LVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:21:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5DB9C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:21:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED017C433C7;
        Fri, 27 Oct 2023 11:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698405695;
        bh=O3+98i6Qehz5V/whtfKsxgGTIVPdpkvjDfNY7d71FEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xbnhr18rvCnOQ72NPcTn0TdfHoKPWMYsJmojn6+tKMXaQh0Dz2hyOufqk/qt7iDuT
         XjnLnWtgQxx8Wm4Vak4jtpOru7fA2LH9FO99mntEAFEx7UCdNa5Fw64A5iVIRP3e5y
         yHuajDtJA3EggouiVqVwqFMqe28YFthoxmI3NMZc=
Date:   Fri, 27 Oct 2023 13:21:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ayush Singh <ayushdevel1325@gmail.com>
Cc:     greybus-dev@lists.linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vaishnav@beagleboard.org,
        jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v9 0/3] greybus: Add BeaglePlay Greybus Driver
Message-ID: <2023102701-safely-limping-0c26@gregkh>
References: <20231017101116.178041-1-ayushdevel1325@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017101116.178041-1-ayushdevel1325@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 03:41:11PM +0530, Ayush Singh wrote:
> BeagleConnect is both a technology concept and a line of board designs
> that implement the technology. Born from Greybus, a mechanism for
> dynamically extending a Linux system with embedded peripherals,
> BeagleConnect adds two key elements: a 6LoWPAN transport and mikroBUS
> manifests. The 6LoWPAN transport provides for arbitrary connections,
> including the IEEE802.15.4g long-range wireless transport supported
> between BeaglePlay and BeagleConnect Freedom (the first BeagleConnect
> board design). The mikroBUS manifests provide for rapid prototyping
> and low-node-count production with sensor boards following the
> mikroBUS freely-licensable embedded bus standard such that existing
> Linux drivers can be loaded upon Greybus discovery of the nodes.
> This patch set provides the Linux-side hooks required for the 6LoWPAN
> transport for BeagleConnect on BeaglePlay. Also adds required devicetree
> additions.
> 
> Tested over `next-20230825`.
> 
> Link: https://programmershideaway.xyz/tags/gsoc23/ GSoC23 Blog
> Link: https://git.beagleboard.org/gsoc/greybus/cc1352-firmware Zephyr App
> Link: https://github.com/Ayush1325/linux/tree/gb-beagleplay GitHub Branch
> Link: https://docs.beagleboard.org/latest/boards/beagleconnect/index.html BeagleConnect
> Link: https://docs.beagleboard.org/latest/boards/beagleplay/index.html BeaglePlay
> Link: https://github.com/Ayush1325/linux/tree/gb-beagleplay Github Repo
> Link: https://lists.linaro.org/archives/list/greybus-dev@lists.linaro.org/thread/5RQV7OG5KI4BQWRN5ZCGZIFRMM6ERKPP/ Patch v8
> 
> Changes in Patch v9
> v8 -> v9:
> - Some capitalization in dt-bindings
> - add reset-gpios and vdds-supply to beagleplay device tree

Given a lack of objections, and nothing I could find wrong with this,
I've now applied this to my tree, thanks for sticking with this.

Now the real work begins!  :)

thanks,

greg k-h
