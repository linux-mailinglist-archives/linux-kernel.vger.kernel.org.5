Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527C476EEA4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237247AbjHCPuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbjHCPuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:50:02 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408922109;
        Thu,  3 Aug 2023 08:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=bajgnuKTGlG0RtP4bwkiUS04QrRESVaCChAJs0W23Eo=; b=y8JmzLyUCI5yi3iS8gD55qA0O5
        +zQPDSo4EhRJ+CnOBCpcogYWwXnw/l64T1Rzx71B4mDm4pqr4UujbztoVnNX7mFnhm4s5kypAsH8P
        9ncC4FpwjtlCb26X9870ENwSicYe4a1O3QOuAY9rkiUGnCvI0kWdGvm3SXim8Kd0v5dQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qRaa9-00305O-OZ; Thu, 03 Aug 2023 17:49:45 +0200
Date:   Thu, 3 Aug 2023 17:49:45 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     justinlai0215 <justinlai0215@realtek.com>, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net/ethernet/realtek: Add Realtek automotive PCIe driver
Message-ID: <87194ec9-476a-471b-a5b5-d70e8a2cbcd5@lunn.ch>
References: <20230803082513.6523-1-justinlai0215@realtek.com>
 <ZMtr+WbURFaynK15@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMtr+WbURFaynK15@nanopsycho>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 10:57:29AM +0200, Jiri Pirko wrote:
> Thu, Aug 03, 2023 at 10:25:13AM CEST, justinlai0215@realtek.com wrote:
> >This patch is to add the ethernet device driver for the PCIe interface of Realtek Automotive Ethernet Switch,
> >applicable to RTL9054, RTL9068, RTL9072, RTL9075, RTL9068, RTL9071.
> >
> >Signed-off-by: justinlai0215 <justinlai0215@realtek.com>
> 
> [...]
> 
> 
> >+
> >+static long rtase_swc_ioctl(struct file *p_file, unsigned int cmd, unsigned long arg)
> 
> There are *MANY* thing wrong in this patch spotted just during 5 minutes
> skimming over the code, but this definitelly tops all of them.
> I didn't see so obvious kernel bypass attempt for a long time. Ugh, you
> can't be serious :/
> 
> I suggest to you take couple of rounds of consulting the patch with
> some skilled upstream developer internaly before you make another
> submission in order not not to waste time of reviewers.

I have to agree with Jiri here. This 'vendor crap' driver has no
chance of being merged as is. You need to reach out to some
experienced mainline driver developers to help you rewrite it to
mainline quality.

    Andrew

---
pw-bot: cr
