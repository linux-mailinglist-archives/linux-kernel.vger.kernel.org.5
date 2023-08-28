Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF0578AE27
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjH1K5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjH1K4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:56:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E3A2D53;
        Mon, 28 Aug 2023 03:56:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B10E4643BA;
        Mon, 28 Aug 2023 10:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E05C43395;
        Mon, 28 Aug 2023 10:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693220139;
        bh=Bb5ceWlaWfPfAbTCvodCpwqGEOWqs3DzAgQJiJfYYLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qR1SoaeXARfJ5B+C7d1LrT8ZNFXqBqyjUjWCQB+bcrZ+F//B5r4j/u0xcjOjgNkYT
         4i9JwXyCuIBJQvQlEKkhPYGpxgfKdjeBFD0ZpGrcNWbfqqaI3ulRi3VCjloeGnH3jF
         BteU6FCE4IZropHtFlCbLyH0sG/W4J0IAo5Djh7Q=
Date:   Mon, 28 Aug 2023 12:51:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andras Sebok <sebokandris2009@gmail.com>
Cc:     linux-serial@vger.kernel.org, andriseseboke@gmail.com,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org
Subject: Re: [PATCH 1/2] Simplify sysrq help
Message-ID: <2023082831-undefined-hut-11fd@gregkh>
References: <20230828102753.4811-2-sebokandris2009@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828102753.4811-2-sebokandris2009@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 12:27:53PM +0200, Andras Sebok wrote:
> This patch simplyfies sysrq help menu by moving each command to a 
> separate line and by moving the key from brackets to after a semicolon.
> 
> before:
> sysrq: HELP : loglevel(0-9) reboot(b) crash(c) terminate-all-tasks(e) memory-full-oom-kill(f) kill-all-tasks(i) thaw-filesystems(j) sak(k) show-backtrace-all-active-cpus(l) show-memory-usage(m) nice-all-RT-tasks(n) poweroff(o) show-registers(p) show-all-timers(q) unraw(r) sync(s) show-task-states(t) unmount(u) force-fb(v) show-blocked-tasks(w) dump-ftrace-buffer(z)
> 
> after:
> sysrq: HELP :
> loglevel : 0-9
> reboot : b
> crash : c
> terminate-all-tasks : e
> memory-full-oom-kill : f
> kill-all-tasks : i
> thaw-filesystems : j
> sak : k
> show-backtrace-all-active-cpus : l
> show-memory-usage : m
> nice-all-RT-tasks : n
> poweroff : o
> show-registers : p
> show-all-timers : q
> unraw : r
> sync : s
> show-task-states : t
> unmount : u
> force-fb : v
> show-blocked-tasks : w
> dump-ftrace-buffer : z

So now the options all scroll off the screen?  Are you sure this is
wise?  What problem are you trying to solve here, it just looks like you
are changing one "help text format for another", and doesn't actually
change much of anything.

Note the:
	sysrq: HELP :

line format being different from all the others makes this not even look
correct?

So I really do not see the point of this change here, why is it needed?

thanks,

greg k-h
