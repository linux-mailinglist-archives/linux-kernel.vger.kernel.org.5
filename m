Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE43779D39
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 07:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjHLFU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 01:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjHLFUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 01:20:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C68E60;
        Fri, 11 Aug 2023 22:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D26FF63674;
        Sat, 12 Aug 2023 05:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB2CC433C9;
        Sat, 12 Aug 2023 05:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691817623;
        bh=LtbDtWiCrGT6LFZ79+Ps2lWPpTWtt9KGv4PGFkq84Vk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r/SCjsQTcdLBpF8FWcXY5tdUmdescA/anp4/gJDVPzqLGsGMJcFTBqfCjV3VDJ2l3
         aHLi29mXtRtt81nXFOAFle34fAXH1OnlAn6xb78HcDhsfKcfSV2ileHiTXYWoy1kq8
         o3BA56LuMGrno25HahQhigksOV/URdBv9QegDfzvyAcOuftMkyenLuVHdb5YchWldS
         5zbEwboKM4QdpHgA8hzq/6G2Q2eqUASHlh69DmzQWilcC6rUyJX4OrFZkMJdU69Ria
         2Vddu8CdYqVEJK/MI75Q5Mn2lq6xIdiKQ0byup57pMq/GBwyWj+HI4UkRgfHJDmGos
         vkoe3OmCi5mww==
Date:   Sat, 12 Aug 2023 14:20:19 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Chuang Wang <nashuiliang@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/eprobe: Iterate trace_eprobe directly
Message-Id: <20230812142019.06cb38b56287b0f068e8164f@kernel.org>
In-Reply-To: <20230811154523.61e67cc3@gandalf.local.home>
References: <20230811081239.246365-1-nashuiliang@gmail.com>
        <20230811154523.61e67cc3@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 15:45:23 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 11 Aug 2023 16:12:39 +0800
> Chuang Wang <nashuiliang@gmail.com> wrote:
> 
> > +
> > +#define for_each_trace_eprobe_on_trace_probe(ep, _tp) \
> > +	list_for_each_entry(ep, trace_probe_probe_list(_tp), tp.list)
> > +
> 
> As I replied to the other patch, but after this one was sent (sorry, I was
> hyperfocused on my work the last couple of days and was not reading email,
> so my INBOX is a bit full). I really hate the verbosity of that name.
> 
> At a minimum, let's call it:
> 
>   for_each_trace_point_eprobe()

OK, what about "for_each_trace_eprobe_on()"? I would like to clarify

- what type is returned
- not all trace_eprobes, but only on the trace_probe.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
