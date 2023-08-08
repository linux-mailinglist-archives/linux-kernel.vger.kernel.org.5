Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7793A7735C8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 03:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjHHBOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 21:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjHHBOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 21:14:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D6919B0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 18:14:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87D6062349
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 01:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4D8C433C8;
        Tue,  8 Aug 2023 01:14:11 +0000 (UTC)
Date:   Mon, 7 Aug 2023 21:14:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     thunder.leizhen@huaweicloud.com
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org, Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 2/2] hexdump: add a new dump prefix
 DUMP_PREFIX_ADDRESS_LOW16
Message-ID: <20230807211409.750c17a5@gandalf.local.home>
In-Reply-To: <20230805072116.1260-3-thunder.leizhen@huaweicloud.com>
References: <20230805072116.1260-1-thunder.leizhen@huaweicloud.com>
        <20230805072116.1260-3-thunder.leizhen@huaweicloud.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  5 Aug 2023 15:21:16 +0800
thunder.leizhen@huaweicloud.com wrote:

> For example:
> dump memory at sp=ffff800080883a90:
> ffff800080883a90: 80883ac0 ffff8000 3d8e936c ffffbd5b
> ffff800080883aa0: 5833f000 ffff3580 00000001 00000000
> ffff800080883ab0: 40299840 ffff3580 590dfa00 ffff3580
> ffff800080883ac0: 80883b30 ffff8000 3d938b28 ffffbd5b
> ffff800080883ad0: 40877180 ffff3580 590dfa00 ffff3580
> ffff800080883ae0: 4090f600 ffff3580 80883cb0 ffff8000
> ffff800080883af0: 00000010 00000000 00000000 00000000
> ffff800080883b00: 4090f700 ffff3580 00000001 00000000
> 
> Generally, we do not dump more than 64 KB memory. It is sufficient to
> print only the lower 16 bits of the address.
> 
> dump memory at sp=ffff800080883a90:
> 3a90: 80883ac0 ffff8000 3d8e936c ffffbd5b
> 3aa0: 5833f000 ffff3580 00000001 00000000
> 3ab0: 40299840 ffff3580 590dfa00 ffff3580
> 3ac0: 80883b30 ffff8000 3d938b28 ffffbd5b
> 3ad0: 40877180 ffff3580 590dfa00 ffff3580
> 3ae0: 4090f600 ffff3580 80883cb0 ffff8000
> 3af0: 00000010 00000000 00000000 00000000
> 3b00: 4090f700 ffff3580 00000001 00000000

I find the "before" much easier to read than the "after".


-- Steve
