Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49B07542B8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbjGNSnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbjGNSnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:43:06 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40ED81BEB;
        Fri, 14 Jul 2023 11:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=JZx+EsagLFfzXkniJTLpW4tHLMZwxvgnsHOs68GtYNs=; b=U6MBuf2GSlpWW7QoCReRmNCqhs
        s0+ZgIoosJ2jhZ58X0H+Bk0Jye1TgTPcTupvfdvPDHbj0G2Y+ObmW7OwlMiPKUWgArPZXEx+DyUVw
        VjU/riDh/u7Ik2LuTI1Xld5UBtXfNxMHVl/etZATRcP5K84g4+JM6nHkqVUCmCIsUT1I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qKNkX-001NiP-GD; Fri, 14 Jul 2023 20:42:41 +0200
Date:   Fri, 14 Jul 2023 20:42:41 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     netdev@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6xxx: Add erratum 3.14 for
 88E6390X and 88E6190X
Message-ID: <fb82f66f-35dc-4e50-81d7-b5a08cfe75e0@lunn.ch>
References: <20230714160612.11701-1-ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714160612.11701-1-ante.knezic@helmholz.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 06:06:12PM +0200, Ante Knezic wrote:
> Fixes XAUI/RXAUI lane alignment errors.
> Issue causes dropped packets when trying to communicate over
> fiber via SERDES lanes of port 9 and 10.
> Errata document applies only to 88E6190X and 88E6390X devices.
> Requires poking in undocumented registers.
> 
> Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
