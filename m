Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B047D85E6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345425AbjJZPXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjJZPXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:23:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB9ED7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:23:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868DAC433C8;
        Thu, 26 Oct 2023 15:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1698333796;
        bh=KJS2k1u4DDMw0/b0buiBWZM6zr1OPS6aOkhpGbQXye8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ceSji+GR/3DQAcdtE6H9wWp22qc4NvverisA9Ztwi69e9e4n25Ozw1cqokNGNXakU
         oNXIePJO4AI0jcLXVF67vxfZK6mZ9qGWNRxE09/3GneWky6VY7v+jU07Z63KZ9qz5c
         yVT6/ykSaiYJMKHpewmF5coyhy5FtJcG2tpiF4QY=
Date:   Thu, 26 Oct 2023 08:23:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] fs: Remove unneeded semicolon
Message-Id: <20231026082315.fd432f07d9db32642f78aeac@linux-foundation.org>
In-Reply-To: <20231026150334.GA13945@redhat.com>
References: <20231026005634.6581-1-yang.lee@linux.alibaba.com>
        <20231026150334.GA13945@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 17:03:35 +0200 Oleg Nesterov <oleg@redhat.com> wrote:

> On 10/26, Yang Li wrote:
> >
> > @@ -3826,7 +3826,7 @@ static struct task_struct *first_tid(struct pid *pid, int tid, loff_t f_pos,
> >  	for_each_thread(task, pos) {
> >  		if (!nr--)
> >  			goto found;
> > -	};
> > +	}
> 
> Ah, I forgot to remove this semicolon :/
> 
> This is on top of
> 
> 	document-while_each_thread-change-first_tid-to-use-for_each_thread.patch
> 
> perhaps this cleanup can be folded into the patch above along with Yang's sob ?

The above is in mainline, so no squashing.  I added your acked-by.
