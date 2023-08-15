Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6861A77C4EF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbjHOBQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjHOBQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:16:14 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848D31715;
        Mon, 14 Aug 2023 18:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=vmDqYNYNVKX9nXI+lnVpwoCYe/6hDlYjcGo/oG9uNZw=; b=pU6w/PiTHnSopHqx4VBIZ9YE+K
        Peh6KOzMWxCwpjUPzVboVRk8HlCIt2ia5B6yapuSphNtOBHySbIuXH8+Ck36sg805kKE269OThiNM
        Ix5oCOPg0FWwvm2s1NyFG9V9jsvzdpjAEjlhLdteBO3EPw7tUlIqCX3eAAWld1wlTXrA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qVifD-0046d9-ES; Tue, 15 Aug 2023 03:16:03 +0200
Date:   Tue, 15 Aug 2023 03:16:03 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alfred Lee <l00g33k@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, sgarzare@redhat.com,
        AVKrasnov@sberdevices.ru
Subject: Re: [PATCH net v3] net: dsa: mv88e6xxx: Wait for EEPROM done before
 HW reset
Message-ID: <a7f0ffc1-eb12-4e76-8e0e-7adf40912d08@lunn.ch>
References: <20230815001323.24739-1-l00g33k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815001323.24739-1-l00g33k@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 05:13:23PM -0700, Alfred Lee wrote:
> If the switch is reset during active EEPROM transactions, as in
> just after an SoC reset after power up, the I2C bus transaction
> may be cut short leaving the EEPROM internal I2C state machine
> in the wrong state.  When the switch is reset again, the bad
> state machine state may result in data being read from the wrong
> memory location causing the switch to enter unexpected mode
> rendering it inoperational.

Hi Alfred

It is normal to place a history after the --- of what changed between
each version.

> Fixes: a3dcb3e7e70c ("net: dsa: mv88e6xxx: Wait for EEPROM done after HW reset")
> Signed-off-by: Alfred Lee <l00g33k@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
