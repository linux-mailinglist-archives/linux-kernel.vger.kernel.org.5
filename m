Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCF7753DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbjGNOoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236119AbjGNOoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:44:17 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A51510FA;
        Fri, 14 Jul 2023 07:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=MkhC/ndNHwMBGL3IpCk8DrD4ouCBr3YRHuq0s+rIhPw=; b=Dd1LX1bv4ykZZ1jEqmrSgntGFZ
        WfakM4wO+lvRxqbJBGTNAiFKFrSEBOwitjMzyQyWORG0/GrxxVFNuJKOPzhcThD5fud7bGYoEul/D
        TxAzzZzEsdLXoUwGlGuAWyXPwQqCPTjBom4OWtczJf1L0vK5KjdGSTUGxGWTmeJY17Ec=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qKK1g-001MQN-AY; Fri, 14 Jul 2023 16:44:08 +0200
Date:   Fri, 14 Jul 2023 16:44:08 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     davem@davemloft.net, edumazet@google.com, f.fainelli@gmail.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, olteanv@gmail.com, pabeni@redhat.com
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: Add erratum 3.14 for
 88E6390X and 88E6190X
Message-ID: <22008be3-3706-45c9-b370-7df94662fea4@lunn.ch>
References: <570d32ad-e475-4a0b-a6ee-a2bdf5f67b69@lunn.ch>
 <20230714143650.25818-1-ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714143650.25818-1-ante.knezic@helmholz.de>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >Does Marvell give this register a name? If so, please add a #define.
> >Are the bits in the register documented?
> 
> Unfortunately, no. This is one of those undocumented registers. I will
> make a note of it in the commit message.

Undocumented magic is typical for Marvell Erratas.

> 
> >> +     if (!err && up) {
> >> +             if (chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6390X ||
> >> +                 chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6190X)
> 
> >6191X? 6193X?
> 
> Errata I have available refers only to 6190x and 6390x. Not sure about other devices.

Please mention this in the commit message.

Thanks
	Andrew
