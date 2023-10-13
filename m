Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2799D7C8972
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjJMQAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjJMQAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:00:35 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85263B7;
        Fri, 13 Oct 2023 09:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=YJ2WmwaOdUeneIw/Q5PT7IiBFVxA19ldRBu/8pCiZi8=; b=LeitdU9uKWU/vjLbeLWfeyUChM
        UszrF5X7zGTSXEN5Txtu9dHjLRvvODPJqFRG+lWOqa5SXQzUamGNgZGspOCQV6N5uXiL2ekAnGD0P
        3WUGhLFOO0LqABXgBKeEIJ6p4V6KiDGJI+0M+Ea9WCnnidSXwNeKCC8tqitoRvPm6pL8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qrKaQ-0026mP-EM; Fri, 13 Oct 2023 18:00:26 +0200
Date:   Fri, 13 Oct 2023 18:00:26 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <horms@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
        Vignesh Raghavendra <vigneshr@ti.com>, r-gunasekaran@ti.com
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix r30 CMDs bitmasks
Message-ID: <8b11140d-6d91-48aa-be66-9c4a117366af@lunn.ch>
References: <20231013111758.213769-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013111758.213769-1-danishanwar@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 04:47:58PM +0530, MD Danish Anwar wrote:
> The bitmask for EMAC_PORT_DISABLE and EMAC_PORT_FORWARD has been changed
> in the latest ICSSG firmware.
> 
> The current bitmasks are wrong and as a result EMAC_PORT_DISABLE and
> EMAC_PORT_FORWARD commands do not work.
> Update r30 commands to use the same bitmask as used by the latest ICSSG
> firmware.

Please indicate in the commit message this is backwards compatible
with old firmware. I assume it is actually backwards compatible.

    Andrew

---
pw-bot: cr
