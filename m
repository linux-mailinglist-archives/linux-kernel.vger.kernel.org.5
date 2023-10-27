Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD83D7D9ACD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346059AbjJ0OGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346009AbjJ0OGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:06:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CC0D6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:06:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926B9C433C8;
        Fri, 27 Oct 2023 14:06:44 +0000 (UTC)
Date:   Fri, 27 Oct 2023 10:06:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] Fix: rseq uapi: Adapt header includes to follow glibc
 header changes
Message-ID: <20231027100641.52fbee5d@gandalf.local.home>
In-Reply-To: <81d2fd04-572d-48cd-bb5c-9a77937a79a0@efficios.com>
References: <20231025214811.2066376-1-mathieu.desnoyers@efficios.com>
        <202310271556.LunB8KLv-lkp@intel.com>
        <81d2fd04-572d-48cd-bb5c-9a77937a79a0@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2023 09:37:26 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2023-10-27 03:53, kernel test robot wrote:
> > Hi Mathieu,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on linus/master]
> > [also build test WARNING on v6.6-rc7 next-20231026]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]  
> 
> The test robot complains about using <asm/types.h> in uapi headers for 
> !__KERNEL__ case.
> 
> Steven, was there something wrong with including linux/types.h in uapi 
> headers ?
> 

Actually, linux/types.h includes asm/types.h so I don't think that was the
issue. I think the issue was mostly with:

 #include <asm/byteorder.h>

Replacing linux/types.h with asm/types.h worked, but may have been
unnecessary.

-- Steve
