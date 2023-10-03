Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1DE7B721E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjJCT5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjJCT5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:57:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB60A1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:57:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381E8C433C8;
        Tue,  3 Oct 2023 19:57:05 +0000 (UTC)
Date:   Tue, 3 Oct 2023 15:58:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     jim.cromie@gmail.com
Cc:     =?UTF-8?B?xYF1a2Fzeg==?= Bartosik <lb@semihalf.com>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH v1] dynamic_debug: add support for logs destination
Message-ID: <20231003155810.6df9de16@gandalf.local.home>
In-Reply-To: <CAJfuBxxmL-GtBgt=033F9UNeLCreFbJh3HrQQN2nYKwR_0uTbg@mail.gmail.com>
References: <20230915154856.1896062-1-lb@semihalf.com>
        <CAJfuBxyFYyGCtr5i=P7N=1oX3J=jmdp1VLGLt+z1fAnuvGK2aA@mail.gmail.com>
        <CAK8ByeJBrPEQSgUc91LQO9Krzjh2pauhMTjEC82M8ozayE76Yg@mail.gmail.com>
        <CAJfuBxxmL-GtBgt=033F9UNeLCreFbJh3HrQQN2nYKwR_0uTbg@mail.gmail.com>
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

On Mon, 2 Oct 2023 14:49:20 -0600
jim.cromie@gmail.com wrote:

> hi Lukasz,
> 
> sorry my kernel-time has been in my own trees.
> 
> What I dont understand is why +T is insufficient.
> 
> IIUC, tracefs is intended for production use.
> thats why each event can be enabled / disabled
> - to select and minimize whats traced, and not impact the system
> 
> and +T  can forward all pr_debugs to trace,
> (by 1-few trace events defined similarly to others)
> or very few, giving yet another selection mechanism
> to choose or eliminate specific pr-debugs and reduce traffic to
> interesting stuff.
> 
> Once your debug is in the trace-buf,
> shouldnt user-space be deciding what to do with it ?
> a smart daemon could leverage tracefs to good effect.
> 
> IMO the main value of +T is that it allows feeding existing pr_debugs
> into the place where other trace-data is already integrated and managed.
> 
> At this point, I dont see any extra destination handling as prudent.
> 


I'm fine with either approach. I kind of like the creation of the instance,
as that allows the user to keep this debug separate from other tracing
going on. We are starting to have multiple applications using the tracing
buffer (although most are using instances, which is why I'm trying to make
them lighter weight with the eventfs code).

-- Steve

