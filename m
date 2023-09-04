Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB04A791984
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241768AbjIDORt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjIDORs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:17:48 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67A1F9;
        Mon,  4 Sep 2023 07:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=3OPAo4lBCxUsvNDw8QF7A24B4wyRHfWzj5T4gNsEf4Y=; b=T7YeAaGyGBJisK0Hv3uqRExzvZ
        atvPskDrfdzBdaB//dmGUICTITqAdGSg8O/mxQm8qR1cqU3YyxWzvvEihNqdBHkmnIRr4UnBKvGSt
        J6pbQgbytED364vEClvZBSAsSx+zq0v+t8YGZwN53DINSV54wYGs+6GQCGzH5hketa4s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qdAOW-005kH2-HN; Mon, 04 Sep 2023 16:17:36 +0200
Date:   Mon, 4 Sep 2023 16:17:36 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon Horman <horms@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com
Subject: Re: [RFC PATCH net-next 2/2] net: ti: icssg-prueth: Add support for
 half duplex operation
Message-ID: <42e8a2d1-eb7b-4157-86b9-87a9dfb93e83@lunn.ch>
References: <20230830113134.1226970-1-danishanwar@ti.com>
 <20230830113134.1226970-3-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830113134.1226970-3-danishanwar@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 05:01:34PM +0530, MD Danish Anwar wrote:
> This patch adds support for half duplex operation at 10M and 100M link
> speeds for AM654x/AM64x devices.
> - Driver configures rand_seed, a random number, in DMEM HD_RAND_SEED_OFFSET
> field, which will be used by firmware for Back off time calculation.
> - Driver informs FW about half duplex link operation in DMEM
> PORT_LINK_SPEED_OFFSET field by setting bit 7 for 10/100M HD.
> 
> Hence, the half duplex operation depends on board design the
> "ti,half-duplex-capable" property has to be enabled for ICSS-G ports if HW
> is capable to perform half duplex.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
