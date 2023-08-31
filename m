Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C4D78F41A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 22:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbjHaUdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 16:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237897AbjHaUdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:33:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9CEE79;
        Thu, 31 Aug 2023 13:33:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EE5D629BA;
        Thu, 31 Aug 2023 20:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58782C433C7;
        Thu, 31 Aug 2023 20:33:33 +0000 (UTC)
Date:   Thu, 31 Aug 2023 16:33:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     Brian Foster <bfoster@redhat.com>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: zero the pipe cpumask on alloc to avoid
 spurious -EBUSY
Message-ID: <20230831163331.6c90c963@rorschach.local.home>
In-Reply-To: <26f8fb43-6ea8-edc2-381d-3600fce261af@huawei.com>
References: <20230831125500.986862-1-bfoster@redhat.com>
        <26f8fb43-6ea8-edc2-381d-3600fce261af@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Thu, 31 Aug 2023 21:51:18 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> > Hi,
> > 
> > I ran into this problem just recently on one of my test VMs immediately
> > after updating to a v6.5 base. A revert of the aforementioned commit
> > addressed the problem. I'm not terribly familiar with the tracing code,
> > but on further inspection I noticed the cpumask doesn't appear to be
> > initialized anywhere. I suppose this could alternatively do a
> > cpumask_clear() or whatever after allocation, but either way this
> > addresses the problem for me.  
> 
> Yes, pipe_cpumask must be initialized.

Can I add a Reviewed-by tag from you?

> 
> > 
> > Please CC on replies as I'm not subscribed to the list. Thanks.

That's the default with Linux kernel lists.

-- Steve
