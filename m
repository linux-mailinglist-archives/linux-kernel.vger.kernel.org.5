Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F867D176F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 22:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjJTUtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 16:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjJTUtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 16:49:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2372B3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 13:49:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19220C433CA;
        Fri, 20 Oct 2023 20:49:20 +0000 (UTC)
Date:   Fri, 20 Oct 2023 16:49:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] seq_buf: fix a misleading comment
Message-ID: <20231020164917.6fb6f89b@gandalf.local.home>
In-Reply-To: <87pm19kp0m.fsf@meer.lwn.net>
References: <87pm19kp0m.fsf@meer.lwn.net>
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

On Fri, 20 Oct 2023 14:38:49 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> The comment for seq_buf_has_overflowed() says that an overflow condition is
> marked by len == size, but that's not what the code is testing.  Make the
> comment match reality.
> 

I guess we can add:

Fixes: 8cd709ae7658a ("tracing: Have seq_buf use full buffer")

Thanks!

-- Steve

> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  include/linux/seq_buf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
> index 515d7fcb9634..026302765494 100644
> --- a/include/linux/seq_buf.h
> +++ b/include/linux/seq_buf.h
> @@ -39,7 +39,7 @@ seq_buf_init(struct seq_buf *s, char *buf, unsigned int size)
>  
>  /*
>   * seq_buf have a buffer that might overflow. When this happens
> - * the len and size are set to be equal.
> + * len is set to be greater than size.
>   */
>  static inline bool
>  seq_buf_has_overflowed(struct seq_buf *s)

