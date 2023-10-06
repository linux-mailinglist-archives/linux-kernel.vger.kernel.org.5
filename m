Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C8A7BBD70
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjJFRC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjJFRCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:02:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14E3C6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 10:02:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF00C433C9;
        Fri,  6 Oct 2023 17:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696611774;
        bh=gqKCiivSvc4M2FUEN1bwdMxW4QNOPB1TkbkNtl4IfQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OVazLVcYM1y2XPTQ6AXvfcD5x7FIhrGufpgZ9FD8s+i6qul3WSMl+PCa2WCfiIK+u
         kKSKo5kkMyGGgjNB37i9s2yuAAHknC7x6mz99qeCP2eGCp9tnZyGzM4PQ1SgAMB9g2
         Ajxxf5Lxhk3pum4aqYW1MM8cDK0QZ/S/hllSp/C+QBwN8KEH8c8rdUL6MLGMvX65KG
         3aZOJoLhBTBmhQARUWPXrg8AuMLDf2jdjpAoEXDcEx1QM0TSO9MZjvGkEAEZxP2AxK
         b2211JvUQuUCeQOrSOcn61IubFwatuRcdn6lI35fp2EZs9gp/grHmeUA0mTwIVM44p
         ag42coMNSsq4Q==
Received: (nullmailer pid 4076734 invoked by uid 1000);
        Fri, 06 Oct 2023 17:02:51 -0000
Date:   Fri, 6 Oct 2023 12:02:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v12 1/7] of: device: Export of_device_make_bus_id()
Message-ID: <169661177118.4076678.10919719119108663799.robh@kernel.org>
References: <20231005155907.2701706-1-miquel.raynal@bootlin.com>
 <20231005155907.2701706-2-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005155907.2701706-2-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 05 Oct 2023 17:59:01 +0200, Miquel Raynal wrote:
> This helper is really handy to create unique device names based on their
> device tree path, we may need it outside of the OF core (in the NVMEM
> subsystem) so let's export it. As this helper has nothing patform
> specific, let's move it to of/device.c instead of of/platform.c so we
> can add its prototype to of_device.h.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/of/device.c       | 41 +++++++++++++++++++++++++++++++++++++++
>  drivers/of/platform.c     | 40 --------------------------------------
>  include/linux/of_device.h |  6 ++++++
>  3 files changed, 47 insertions(+), 40 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

