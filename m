Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D227F3AE2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 01:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbjKVAz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 19:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbjKVAzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 19:55:25 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5724CD5C;
        Tue, 21 Nov 2023 16:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=dj79vzUBkAUSzb4ejlUxr7fcnIOCKB5na2L/pzvm/gs=; b=B5EFjDuyOslbTC8LMn8YNqv7FW
        c1bIVKjJJVawfS3r25tjMY2JPu1x1vBxmlFbvZOJHbVJuhOiSO0YW/VNTD8Q1+woAMfTtuCLEnO5R
        nfeJpwJDAC/e4YaK0H+v95siwwDnWLe5hYfub8KAHEOBjyeA1FcPA3JguyC+RVx6Yd9U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r5bWB-000oPf-6c; Wed, 22 Nov 2023 01:55:03 +0100
Date:   Wed, 22 Nov 2023 01:55:03 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Ariane Keller <ariane.keller@tik.ee.ethz.ch>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net] net: axienet: Fix check for partial TX checksum
Message-ID: <9893df1a-9c9d-4107-84ea-cb757b06c709@lunn.ch>
References: <20231122004219.3504219-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122004219.3504219-1-samuel.holland@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 04:42:17PM -0800, Samuel Holland wrote:
> Due to a typo, the code checked the RX checksum feature in the TX path.
> 
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
