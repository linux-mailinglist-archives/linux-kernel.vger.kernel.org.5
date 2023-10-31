Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8767DC3D4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 02:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjJaBVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 21:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJaBVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 21:21:21 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FDEA2;
        Mon, 30 Oct 2023 18:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=oESTZcoLLAHe053TLIxPqPD3M44OFFLZuqr/siWwWzE=; b=uj4A1M9G3+KnfKS5KDCCtYtGix
        en09AaoCqhvqx2q97tW8Ey/SAbcbgrrEes4tYZ6HPETS920mZRR2BDqm6H299Ppb7DRABGbGiFB3X
        ZCf0yyVO2wVfHBSaE1aEBdN4FG/1lwoXZo2L3+hYqjaCDAsUbJOIyPJcpBg0rc/Iwse0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qxdRT-000Ztn-0v; Tue, 31 Oct 2023 02:21:15 +0100
Date:   Tue, 31 Oct 2023 02:21:15 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, nic_swsd@realtek.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Marco Elver <elver@google.com>
Subject: Re: [PATCH v3 1/1] r8169: Coalesce RTL8411b PHY power-down recovery
 programming instructions to reduce spinlock stalls
Message-ID: <bd4a59be-c393-4302-9d32-759e7cbfe255@lunn.ch>
References: <20231028110459.2644926-1-mirsad.todorovac@alu.unizg.hr>
 <376db5ae-1bb0-4682-b132-b9852be3c7aa@gmail.com>
 <23428695-fcff-495b-ac43-07639b4f5d08@alu.unizg.hr>
 <30e15e9a-d82e-4d24-be37-1b9d1534c082@gmail.com>
 <9f99c3a4-2752-464b-b37d-58a4f8041804@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f99c3a4-2752-464b-b37d-58a4f8041804@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I will not contradict, but the cummulative amount of memory barriers on each MMIO read/write
> in each single one of the drivers could amount to some degrading of overall performance and
> latency in a multicore system.

For optimisations, we like to see benchmark results which show some
improvements. Do you have any numbers?

	Andrew
