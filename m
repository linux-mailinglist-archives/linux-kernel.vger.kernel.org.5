Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F8A78025D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 02:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356379AbjHRABp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 20:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356504AbjHRABO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 20:01:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556803C30;
        Thu, 17 Aug 2023 17:01:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AF8660E8A;
        Fri, 18 Aug 2023 00:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F3BC433C8;
        Fri, 18 Aug 2023 00:00:41 +0000 (UTC)
Date:   Thu, 17 Aug 2023 20:00:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sishuai Gong <sishuai.system@gmail.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracefs: avoid setting i_mode to a temp value
Message-ID: <20230817200044.373f9655@gandalf.local.home>
In-Reply-To: <A9B746AC-DF36-4ED3-BBA3-2EEC1BA166C8@gmail.com>
References: <10CFECF7-B9FC-4562-A445-4811F4C27655@gmail.com>
        <20230816155245.6ead4384@gandalf.local.home>
        <A9B746AC-DF36-4ED3-BBA3-2EEC1BA166C8@gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 19:47:34 -0400
Sishuai Gong <sishuai.system@gmail.com> wrote:

> > Can you produce this race?  
> This data race was detected when I was testing the kernel (e.g., fuzzing)
> but I did not make the attempt to reproduce it.

Now, I'm curious to what exactly is this fixing? The intermediate value is
the S_IALLUGO bits cleared. Doesn't that mean that nothing has permission?

It's not a big deal if that's the case, as it just means things are locked
down a bit more than normal.

My question is, do we really care, and why should we?

-- Steve
 
