Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0637CB2A4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjJPSji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPSjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:39:36 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB162E8;
        Mon, 16 Oct 2023 11:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=smJc+KZWUrYU3Au90yBTeYhcH3JmbRU7h9sw0eBa5ks=; b=LVOSe85LBQ5b1+axsRZNdpi8H/
        CuiIrsbrhNuYmH4fh2PR7sBzwKcbxEwRumAwxKOxAXfEWQ7knuEUEVtWL2+whGszulIW71r/pGBCg
        wyz8JU1/DwZ9AcOFG+qZ6kVXV5yplbkt3+U3TCM/psMJhq4QXm/Z3g3kh0LLMIiUV7wI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qsSUp-002Nl1-Sd; Mon, 16 Oct 2023 20:39:19 +0200
Date:   Mon, 16 Oct 2023 20:39:19 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Anwar, Md Danish" <a0501179@ti.com>
Cc:     MD Danish Anwar <danishanwar@ti.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
        Vignesh Raghavendra <vigneshr@ti.com>, r-gunasekaran@ti.com,
        Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix r30 CMDs bitmasks
Message-ID: <a322d1c2-d79a-4b55-92f6-2b98c1f2266e@lunn.ch>
References: <20231016161525.1695795-1-danishanwar@ti.com>
 <11109e7d-139b-4c8c-beaa-e1e89e355b1b@lunn.ch>
 <d7e56794-8061-bf18-bb6f-7525588546fc@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7e56794-8061-bf18-bb6f-7525588546fc@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > How many different versions of REL.PRU-ICSS-ETHERNET-SWITCH have been
> > released? They don't appear to be part of linux-firmware.git :-(
> > 
> 
> The firmwares are currently not posted to linux-firmware.git. They are
> maintained internally as of now. Different version of firmware is
> released for every SDK release (3-4 times a year)

Clearly, mainline works differently. Ideally you do want to get the
firmware in linux-firmware.git. The kernel and firmware are then more
likely to by upgraded at the same time. However, you should not assume
so. Maybe in mainline you can then support the last 4 firmware
versions, and issue an error if a version older than that is found.

However, until the firmware is easily available via linux-firmware,
you probably should be backwards compatible for a longer period.

	Andrew
