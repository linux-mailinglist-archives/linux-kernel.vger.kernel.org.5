Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48247D79ED
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjJZBFk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Oct 2023 21:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJZBFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:05:39 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EF7A4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 18:05:37 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qvoo2-0005sH-1f;
        Wed, 25 Oct 2023 21:05:02 -0400
Message-ID: <9ee1efa31c9be3f5c162329d82d1deaa2837f682.camel@surriel.com>
Subject: Re: [PATCH] Fix: rseq uapi: Adapt header includes to follow glibc
 header changes
From:   Rik van Riel <riel@surriel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Date:   Wed, 25 Oct 2023 21:05:02 -0400
In-Reply-To: <20231025214811.2066376-1-mathieu.desnoyers@efficios.com>
References: <20231025214811.2066376-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-25 at 17:48 -0400, Mathieu Desnoyers wrote:
> With "recent" glibc headers, using <sys/types.h> with __GNU_SOURCE
> fails
> to have __u32 and others types needed by the rseq.h uapi header file.
> Include ctype.h and asm/types.h to fix this. Add a __KERNEL__ #ifdef
> to
> select the kernel vs userspace header includes.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Reported-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
Acked-by: Rik van Riel <riel@surriel.com>

-- 
All Rights Reversed.
