Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60AE7E1419
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 16:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjKEPdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 10:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKEPdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 10:33:46 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1449A7;
        Sun,  5 Nov 2023 07:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=eqfTkuz+klDPkuPgYNloOteJWBEwKWLuB1ZigC0ZFsI=; b=gt9R+XQhR7uywY8dT2NEYMPSXt
        X2m51KK66ty4Srb+fouQpQWOarfSL+oZyZ3/3wqNN+OEHQCAi83xulUQc4OhM6YzaY6C6tHacJGmr
        o3UUq1EuMVC6ND2T7YAiFw5+lU5cYMpr8d/yeDALgArbVn/GBAGzRSzwHv8wegnl3+3s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qzf7x-000wCa-Rc; Sun, 05 Nov 2023 16:33:29 +0100
Date:   Sun, 5 Nov 2023 16:33:29 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        nic_swsd@realtek.com
Subject: Re: [PATCH net-next v6 0/5] Coalesce mac ocp write/modify calls to
 reduce spinlock contention
Message-ID: <344fc5c2-4447-4481-843f-9d7720e55a77@lunn.ch>
References: <20231104221514.45821-1-mirsad.todorovac@alu.unizg.hr>
 <da4409f3-d509-413b-8433-f222acbbb1be@gmail.com>
 <edee64f4-442d-4670-a91b-e5b83117dd40@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edee64f4-442d-4670-a91b-e5b83117dd40@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > With about 130 of these sequential calls to r8168_mac_ocp_write() this looks like
> > > a lock storm that will stall all of the cores and CPUs on the same memory controller
> > > for certain time I/O takes to finish.

Please provide benchmark data to show this is a real issue, and the
patch fixes it.

> Additionally, I would like to "inline" many functions, as I think that call/return
> sequences with stack frame generation /destruction are more expensive than inlining the
> small one liners.

Please provide benchmarks to show the compiler is getting this wrong,
and inline really is needed.

Until there are benchmarks: NACK.

    Andrew
