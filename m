Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC7478B8A9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjH1TqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbjH1TqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:46:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20ED7BE;
        Mon, 28 Aug 2023 12:46:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B36AB61230;
        Mon, 28 Aug 2023 19:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C5BC433C8;
        Mon, 28 Aug 2023 19:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693251959;
        bh=yhDfpHHMTwoKf6lQHxj/LI3JfvoIJGkL3VYzwzQSSPo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ntOoDqAO4HSTdUm/9O+IxWZMHgoAovKePv+l/8lN/W/C43VzX+fklx87Jnc/Ky7/f
         eVMNzplEf+Lo2ztDOvYdjJPp/pmyrbENd81do8XnQ6WK6VOPexIDW95Tccb317hl8q
         LGzwXdISp5hQIIg0+LEqFW44L9eOunA5oYo4Gq80VlpMHzHlDNME/HiVZbrAxgLMz9
         xsRgwJ9gmqq5Dfh+nvpCcYH0wbWl3L3py4QKE1o3c5TayOGg9s7B6MxTaSWFz5a0g/
         WcciuDb3toaDbjKQQfEtSWrv6E9/MCUgmnMn25Yao6O4AW87OdWTAmDNxdD9g9QNNC
         RxZUL8ri1U5vw==
Date:   Mon, 28 Aug 2023 12:45:57 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Zheao Li <me@manjusaka.me>
Cc:     edumazet@google.com, mhiramat@kernel.org, rostedt@goodmis.org,
        davem@davemloft.net, dsahern@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4] tracepoint: add new `tcp:tcp_ca_event` trace event
Message-ID: <20230828124557.0cc70e58@kernel.org>
In-Reply-To: <20230825133246.344364-1-me@manjusaka.me>
References: <20230825133246.344364-1-me@manjusaka.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023 13:32:47 +0000 Zheao Li wrote:
> This the 4th version of the patch, the previous discusstion is here
> 
> https://lore.kernel.org/linux-trace-kernel/20230807183308.9015-1-me@manjusaka.me/
> 
> In this version of the code, here's some different:
> 
> 1. The event name has been changed from `tcp_ca_event_set` to
> `tcp_ca_event`
> 
> 2. Output the current protocol family in TP_printk
> 
> 3. Show the ca_event symbol instead of the original number
> 
> But the `./scripts/checkpatch.pl` has been failed to check this patch,
> because we sill have some code error in ./scripts/checkpatch.pl(in
> another world, the test would be failed when we use the 
> scripts/checkpatch.pl to check the events/tcp.h
> 
> Feel free to ask me if you have have any issues and ideas.

## Form letter - net-next-closed

The merge window for v6.6 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Sept 11th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

