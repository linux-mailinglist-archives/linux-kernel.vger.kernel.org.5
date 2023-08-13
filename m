Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B6377A743
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjHMPJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjHMPJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:09:22 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16ACE6A;
        Sun, 13 Aug 2023 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=W2wqWQ3KB/fmDRV98QTDbhm4GDqKPYDoQbKjO7pgA2A=; b=sBRi+Csjtr6xBLC3I5dkaj/nPc
        pd49JvNMDPv6dCdCev/pwlJfth5VEqJKYm4uM2L0tUmD3MmypHo1S68O6LzSDDgMHtJyiKKWgxJxn
        G7aksQUy4fSMml9R7ijGqMdGRUXTr5ClXS1HR9b5awTC4qrKlvN/puBIGB1zWLNQxQxk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qVCiQ-003yOJ-CP; Sun, 13 Aug 2023 17:09:14 +0200
Date:   Sun, 13 Aug 2023 17:09:14 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Alfred Lee <l00g33k@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        sgarzare@redhat.com, AVKrasnov@sberdevices.ru
Subject: Re: [PATCH v2 net] net: dsa: mv88e6xxx: Wait for EEPROM done before
 HW reset
Message-ID: <dc56700c-8617-44de-8285-720e1514ebc9@lunn.ch>
References: <20230811232832.24321-1-l00g33k@gmail.com>
 <20230813105804.2r4zdr6dyqe5dsrf@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813105804.2r4zdr6dyqe5dsrf@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 01:58:04PM +0300, Vladimir Oltean wrote:
> Hi Alfred,
> 
> On Fri, Aug 11, 2023 at 04:28:32PM -0700, Alfred Lee wrote:
> > If the switch is reset during active EEPROM transactions, as in
> > just after an SoC reset after power up, the I2C bus transaction
> > may be cut short leaving the EEPROM internal I2C state machine
> > in the wrong state.  When the switch is reset again, the bad
> > state machine state may result in data being read from the wrong
> > memory location causing the switch to enter unexpect mode
> > rendering it inoperational.
> > 
> > Fixes: 8abbffd27ced ("net: dsa: mv88e6xxx: Wait for EEPROM done after HW reset")
> > Signed-off-by: Alfred Lee <l00g33k@gmail.com>
> > ---
> 
> I don't think you understand the meaning of the Fixes: tag.

The subject looks correct, but the hash is wrong. The correct hash is
a3dcb3e7e70c72a68a79b30fc3a3adad5612731c.

Fixes: a3dcb3e7e70c ("net: dsa: mv88e6xxx: Wait for EEPROM done after HW reset")

       Andrew
