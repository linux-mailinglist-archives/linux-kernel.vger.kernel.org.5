Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1627CC404
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343644AbjJQNJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbjJQNJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:09:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B592EF0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:09:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172B6C433C7;
        Tue, 17 Oct 2023 13:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697548150;
        bh=7DESM29Y8/+UFNCA3cwlQd8/6LmZQ7M5c9R2HTefdds=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DzgsQe1rclKKnRfkeP8DR0NBK1m3BubRB5vhZKOVnYwgymDsvhK2v4MI/o3PdWzVo
         DswWax4fJf6FcpnFDWdCtjGih2yqD4YcoFGrpuDFpp5BzjZNzjKn9ynXBOAXg+prCE
         x9rUTro9x4Pc1hO2jLJjeNBf4S/GLihA34ZJm3zaDEjsq7k1e3l3LwoeW999WMRV6B
         9jaXIknKWq8NLNM4+WFyqurFN4JD79wLhuOQEwI8ObBISzy9OV7lfZ2whNsQJauhXR
         BH+oFlQXhGbfbpenb6sNu8b2gdKI97EpKwqLsmV05aN4/S8GXRapJSFNfm4eVegCM5
         3vg6RwYdbAa5g==
Date:   Tue, 17 Oct 2023 22:09:05 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] probes: Fixes for 6.6-rc6
Message-Id: <20231017220905.7b7da9975a2a873f5ca17ebf@kernel.org>
In-Reply-To: <CAHk-=wi3k8JA93pKh9VjuafNN9Qyrk6eH-tQbWePyRSgXi_3FA@mail.gmail.com>
References: <20231017103949.3e81d95ecf737e55bdbdf7f3@kernel.org>
        <CAHk-=wi3k8JA93pKh9VjuafNN9Qyrk6eH-tQbWePyRSgXi_3FA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 18:52:02 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 16 Oct 2023 at 18:39, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Masami Hiramatsu (Google) (2):
> >       Documentation: probes: Add a new ret_ip callback parameter
> >       fprobe: Fix to ensure the number of active retprobes is not zero
> 
> No diffstat? Tssk.
> 

Oops, sorry I missed to cut it out. Here is the diffstat.

----
 Documentation/trace/fprobe.rst | 8 ++++++--
 kernel/trace/fprobe.c          | 6 +++---
 2 files changed, 9 insertions(+), 5 deletions(-)


Thanks,

>            Linus


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
