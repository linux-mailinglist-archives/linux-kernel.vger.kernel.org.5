Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E42807D6C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441918AbjLGAyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjLGAyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:54:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE16FA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 16:54:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE5DC433C8;
        Thu,  7 Dec 2023 00:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701910494;
        bh=7NQaJczkVv5wrigtA1QaLdfOwqAzSDMCJYkOqBKS8no=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TOpGHcvP2acc+8l2aN2+Nrzd+A9ar1eqkWzpGllk3b4EM4LXWPb2W4PGAUL+lJwAM
         bKM14QyBxYo4nECo1dITZVL7fzf6hAnMQ8UqF+PcHOlFn73bvspEHH0625NOEmrzhW
         l0CD22MSCSgEhntr836Phts2sN4l0L8XqqwPA9IU=
Date:   Wed, 6 Dec 2023 16:54:53 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>,
        Guangwu Zhang <guazhang@redhat.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH V4 resend] lib/group_cpus.c: avoid to acquire cpu
 hotplug lock in group_cpus_evenly
Message-Id: <20231206165453.613dbe57555f41ab4b9b0acc@linux-foundation.org>
In-Reply-To: <ZXEUyH/38KeATuF4@yury-ThinkPad>
References: <20231120083559.285174-1-ming.lei@redhat.com>
        <ZXEUyH/38KeATuF4@yury-ThinkPad>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2023 16:41:44 -0800 Yury Norov <yury.norov@gmail.com> wrote:

> Although, it's not related to this patch directly. So, if you fix
> zalloc_cpumask_var(), the patch looks good to me.
> 
> Reviewed-by: Yury Norov <yury.norov@gmail.com>

Thanks.

I just moved this into mm.git's non-rebasing mm-hotfixes-stable branch,
so I'd prefer not to have to redo it at this stage.

Let's do these things (with which I agree) as a followup patch, please.
 
