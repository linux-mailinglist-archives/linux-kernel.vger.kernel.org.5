Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C537DE138
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 14:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343716AbjKAMmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 08:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343681AbjKAMme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 08:42:34 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E964DB7;
        Wed,  1 Nov 2023 05:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=/rSzh2CBUdRpxCG4aPjW7h8lo8I4+wNi85x2FnwfJu0=; b=Yg8omY7OdOxly0zWXtqXNofPfu
        gSvV6lsiWyVKDGi23r6OPqadcW1KKOWDZGJH56gepezgQMGkPJqR8IYqhnyw/sfRXye5DuFkxKv2/
        hWHS6Eri/xBYRff3IdgQ9M8AguvvdPjaQspwk0+283Hw5IT/SlqeN9rZBKLVfRSn/uL4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qyAYC-000gX1-ME; Wed, 01 Nov 2023 13:42:24 +0100
Date:   Wed, 1 Nov 2023 13:42:24 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, horms@kernel.org,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: Re: [net PATCH] octeontx2: Fix klockwork and coverity issues
Message-ID: <335216cc-3412-4898-8b88-10405ff7c316@lunn.ch>
References: <20231101074919.2614608-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101074919.2614608-1-sumang@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 01:19:19PM +0530, Suman Ghosh wrote:
> Fix all klockwork and coverity issues reported on AF and PF/VF driver.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

The subject line is:
[net PATCH] octeontx2: Fix klockwork and coverity issues

So you want these fixes backported to net? If so, you need to provide
Fixes: tags.

This patch is way too big. A fix patch generally fixes one thing, and
it documents what it fixes. Or it could be one class of problems, like
uninitialised variables etc. Its good to include the message from the
static analyser in the commit message.

    Andrew

---
pw-bot: cr
