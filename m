Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A1E784480
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbjHVOjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbjHVOjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:39:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E7E124;
        Tue, 22 Aug 2023 07:39:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54DAB659A7;
        Tue, 22 Aug 2023 14:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE79AC433C8;
        Tue, 22 Aug 2023 14:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692715139;
        bh=dF4eTB9fjoFe8tM897OnkRcDuHdGOZfJjqtM3RFKizw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B+5T54p/ouIO7ecN2PZN2saHhTN5D5d3cdHy8lR3vieibv1sLLFFH8S7ZFp2zWknn
         mDxru/WJXiJIPWgQzMP7/7uM4g4QH3exPMfM6NJ3Y3LVqFZQ8gpwzqr4Mign8IK4gv
         uIZuQbhmb/f5ULT1K11hSodEGrcRgr+jqwXMknSvSc5q0leTO2orYgJ+2XTye3ed6K
         /luMKpoH7C0GNc5ZQV9anN+nuOQ0WsV/aQPTcXW2RZrZK14VaWLTbpMcupa4OKs0eI
         /+QQ8dZ+gOXj2GzopWazokSfsMwNPAVA0cwHEwmSh0IQU5VubR4YpiyKwapftD8RXm
         7HJzI6c9hNDqg==
Date:   Tue, 22 Aug 2023 23:38:55 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v5 0/9] tracing: Improbe BTF support on probe events
Message-Id: <20230822233855.94b653a4bf37b2e93739daa6@kernel.org>
In-Reply-To: <20230822100716.2dd867e0@rorschach.local.home>
References: <169137686814.271367.11218568219311636206.stgit@devnote2>
        <20230822000939.81897c0c904934bfb9156a59@kernel.org>
        <20230822100716.2dd867e0@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023 10:07:16 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 22 Aug 2023 00:09:39 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Hi Steve,
> > 
> > Can you review this series?
> > I would like to push this to for-next.
> > 
> 
> I skimmed the patches and played a little with it, but as I've just
> started my vacation I will not be able to do a full review before the
> next merge window. But I don't want me to be the cause of you not
> getting it in.
> 
> Feel free to add:
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> to the entire series. I'm sure I'll be playing with it after it gets
> in, and we can fix any bugs that come up then.

Thanks! I'll fix a bit about anon_stack thing and push it to probes/for-next.


> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
