Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243337FFE78
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377162AbjK3WaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377137AbjK3WaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:30:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C995170D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:30:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854E0C433C8;
        Thu, 30 Nov 2023 22:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701383407;
        bh=7EffNkSDfDJr0a24w3PHrGPfiZWCrDtwUrPFGvGXQEs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QqbDzj32thF4H0vWCw1dq+wVh4q8p9WsIIeNDJgTnN2WEFH+9AilMu2EjRllapi49
         zKyyEN0R9IUSAhIBtOYuxwAI35XVhqV6z4ea3H4qlPCc4jt6c0ubmTaKb6+rxaH/Zz
         eWgX9dI1IpPu87728kMZmNDIR4YRNFJ7lIc4gFkc=
Date:   Thu, 30 Nov 2023 14:30:07 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, Kuan-Ying.Lee@mediatek.com,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] scripts/gdb: Fix lx-device-list-bus and
 lx-device-list-class
Message-Id: <20231130143007.0ca748b966e35426c2cfaa53@linux-foundation.org>
In-Reply-To: <ae225003-d7a8-41c3-b4f9-a66397512c21@broadcom.com>
References: <20231130043317.174188-1-florian.fainelli@broadcom.com>
        <20231130135133.1031e4b2ca96a288ce2c18d0@linux-foundation.org>
        <ae225003-d7a8-41c3-b4f9-a66397512c21@broadcom.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 14:00:32 -0800 Florian Fainelli <florian.fainelli@broadcom.com> wrote:

> >> Fixes: 83b9148df2c9 ("driver core: bus: bus iterator cleanups")
> >> Fixes: 7b884b7f24b4 ("driver core: class.c: convert to only use class_to_subsys")
> > 
> > I don't know how -stable maintainers handle more than one Fixes:.  One
> > of the above was released in 6.3, the other in 6.4.  What are they to
> > do?
> 
> Neither are stable kernels fortunately, so any kernel >= 6.4 where both 
> issues are present should be able to cleanly cherry-pick the change.

OK, I'll change it to just 6.4's 7b884b7f24b4 to simplify life.

> I suppose this should have called for me to issue two patches, one 
> fixing lx-device-list-bus and the other one fixing lx-device-list-class, 
> though it seems like this is such a niche usage that it may not matter 
> that much.

It is indeed nichey :)
