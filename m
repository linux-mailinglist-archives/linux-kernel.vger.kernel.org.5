Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B767B564B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237873AbjJBPIj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Oct 2023 11:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbjJBPIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:08:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43583A7;
        Mon,  2 Oct 2023 08:08:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EC7C433C7;
        Mon,  2 Oct 2023 15:08:33 +0000 (UTC)
Date:   Mon, 2 Oct 2023 11:09:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christian Loehle <christian.loehle@arm.com>
Cc:     Zheng Yejian <zhengyejian1@huawei.com>, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] tracing: document buffer_size_kb more precisely
Message-ID: <20231002110935.2fde6637@gandalf.local.home>
In-Reply-To: <efe41cee-42dd-290f-9ec2-ac002e2ec34e@arm.com>
References: <cee6d5cd-e15b-3bb1-f867-de467d96d6b5@arm.com>
        <a1ae1bc0-0677-8284-9f18-1171e1dcb175@huawei.com>
        <efe41cee-42dd-290f-9ec2-ac002e2ec34e@arm.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2023 11:38:14 +0100
Christian Loehle <christian.loehle@arm.com> wrote:

> >> @@ -191,7 +191,7 @@ of ftrace. Here is a list of some of the key files:
> >>       A few extra pages may be allocated to accommodate buffer management
> >>       meta-data. If the last page allocated has room for more bytes
> >>       than requested, the rest of the page will be used,
> >> -    making the actual allocation bigger than requested or shown.
> >> +    making the actual allocation bigger than requested.  
> > 
> > Hi, the actual allocation should still be bigger than shown due to the
> > loss of accuracy when doing unit conversion from bytes to kilobytes (see
> > tracing_entries_read()).
> >   
> Right, the sysfs obviously only allows for KB aligned setting, but you're right.
> If set on the cmdline non-KB multiples are possible and accuracy is lost.
> Nevermind then.

I'm assuming this patch can be dropped?

-- Steve
