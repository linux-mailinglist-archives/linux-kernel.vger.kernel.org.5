Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA507D3B93
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjJWQAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJWQAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:00:10 -0400
Received: from janet.servers.dxld.at (mail.servers.dxld.at [IPv6:2001:678:4d8:200::1a57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47FDE9;
        Mon, 23 Oct 2023 09:00:06 -0700 (PDT)
Received: janet.servers.dxld.at; Mon, 23 Oct 2023 17:59:56 +0200
Date:   Mon, 23 Oct 2023 17:59:50 +0200
From:   Daniel =?utf-8?Q?Gr=C3=B6ber?= <dxld@darkboxed.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, wireguard@lists.zx2c4.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wireguard: Fix leaking sockets in wg_socket_init error
 paths
Message-ID: <20231023155950.oyl2olisob6dnvwo@House.clients.dxld.at>
References: <20231023130609.595122-1-dxld@darkboxed.org>
 <ZTZ9XfPOXD4JXdjk@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTZ9XfPOXD4JXdjk@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Mon, Oct 23, 2023 at 04:04:13PM +0200, Jason A. Donenfeld wrote:
> The signed-off-by is missing and the subject does not match the format
> of any other wireguard commits.

Ah, I don't usually send kernel patches. Forgot to do format.signOff=true.

> On Mon, Oct 23, 2023 at 03:06:09PM +0200, Daniel Gröber wrote:
> > This doesn't seem to be reachable normally, but while working on a patch
> 
> "Normally" as in what? At all? Or?

I committed this while working on my address/ifindex binding patch[1]
(which I will also resend shortly), at the time I thought this fix makes
sense in isolation but apparently not.

[1]: https://lists.zx2c4.com/pipermail/wireguard/2023-August/008148.html,

> > for the address binding code I ended up triggering this leak and had to
> > reboot to get rid of the leaking wg sockets.
> 
> This commit message doesn't describe any rationale for this patch. Can
> you describe the bug?

It's been a while since I wrote this patch. Unfortunately you didn't
respond to my initial mail in Aug, so some context has already been lost to
time.

I may have been under the mistaken impression that udp_sock_create can
return <0 while leaving *sockp!=NULL, but as I recall it I did re-test with
this patch and it fixed the bug, that I wish I remembered how to trigger
now. Unsatisfying.

--Daniel
