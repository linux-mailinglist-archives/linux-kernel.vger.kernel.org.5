Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7954F7E072E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376601AbjKCRG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345483AbjKCRGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:06:25 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EA4D47;
        Fri,  3 Nov 2023 10:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=zceykpx/VhpqN1zRb1lvrV0ipA+xbJD7LJTS3nOqa80=; b=vm9C2bhQR1dTP96MoYHCSqw2HI
        9CyvuRDnDaHdB1dlqTbSrfS0Ma9rtBnj4J1g03waAew+KhWboI35fnY3asv7byH8Ed89ZIKBu3eC7
        9DxARIHREFWkcEEKe33qz83GQSAZfptSMwJnag+cRFpMMjBcvEqAyid38qIHNToC0JnE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qyxcW-000peM-Vr; Fri, 03 Nov 2023 18:06:08 +0100
Date:   Fri, 3 Nov 2023 18:06:08 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Jerin Jacob Kollanukkaran <jerinj@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "horms@kernel.org" <horms@kernel.org>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: Re: [EXT] Re: [net PATCH] octeontx2: Fix klockwork and coverity
 issues
Message-ID: <bafea4cc-9bf9-4485-a85b-206b82e0b21c@lunn.ch>
References: <20231101074919.2614608-1-sumang@marvell.com>
 <335216cc-3412-4898-8b88-10405ff7c316@lunn.ch>
 <SJ0PR18MB521648A973DF026521B57D39DBA5A@SJ0PR18MB5216.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR18MB521648A973DF026521B57D39DBA5A@SJ0PR18MB5216.namprd18.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> [Suman] Yes, backporting to net was the intention. Do we need to put all the fixes tags? Because the fixes are from different commits.

When you break it up into multiple patches, the fixes-tag will get
simpler.

> Are there any generic submission steps for klockwork fixes?

Take a look at

https://docs.kernel.org/process/stable-kernel-rules.html

In particular, the "It must fix a real bug that bothers people".

Some issues found by static code tools don't actually bother
people. So you might want some patches to net-next, not net.

     Andrew
