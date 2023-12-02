Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A63801E26
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 20:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjLBTJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 14:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBTJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 14:09:14 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B0311D;
        Sat,  2 Dec 2023 11:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=hILZhULZeuU4D7CkSzLlqvX1D9imsudessJgvQHUhpk=; b=KdTHcpqKq2XjRLSkRGdDGlFGak
        0yjtouapM61SGNda1mGd1bdbqIc/Fj2AEZDjaIkm/05NQFwvAlDSKnlXJyy02dpZ+8/YR7hV0AFRK
        Wshw2dyDSPw5IkQTl/UGIKImneDPTnyuTS7eegj1VehSX0n9VaknHnVApcumt+iQN7BM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r9VMU-001rX6-6S; Sat, 02 Dec 2023 20:09:10 +0100
Date:   Sat, 2 Dec 2023 20:09:10 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Justin Lai <justinlai0215@realtek.com>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next v13 01/13] rtase: Add pci table supported in
 this module
Message-ID: <0a2b5646-9d24-4a22-b1e3-87517e7cadb1@lunn.ch>
References: <20231130114327.1530225-1-justinlai0215@realtek.com>
 <20231130114327.1530225-2-justinlai0215@realtek.com>
 <20231201203602.7e380716@kernel.org>
 <27b2b87a-929d-4b97-9265-303391982d27@lunn.ch>
 <20231202105845.12e27e31@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202105845.12e27e31@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm mainly asking to make sure we avoid "implicitly programming" the
> switch, like, IIUC, one of the TI drivers did. And we ended up with
> multiple versions / modes of operation :( Sounds like this driver
> doesn't touch switch registers yet, tho, so all good.

I asked questions about this earlier, should it be a pure switchdev
switch, or a DSA switch, etc. So i think we have that basic questions
covered.

	Andrew
