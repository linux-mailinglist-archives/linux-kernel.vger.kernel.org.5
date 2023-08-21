Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1062782D40
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbjHUP2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjHUP2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:28:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1796D9;
        Mon, 21 Aug 2023 08:28:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DCFF63067;
        Mon, 21 Aug 2023 15:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32520C433C8;
        Mon, 21 Aug 2023 15:28:12 +0000 (UTC)
Date:   Mon, 21 Aug 2023 11:28:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Song Liu <song@kernel.org>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for
 'perf_kprobe' PMU
Message-ID: <20230821112826.4ebd64a1@gandalf.local.home>
In-Reply-To: <20230822001955.d326dbfe7a5755c9684b26cb@kernel.org>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com>
        <20230818213705.b4f5e18b392c4837068cba6f@kernel.org>
        <20230818114141.2a3a75ee@gandalf.local.home>
        <4853240.31r3eYUQgx@pwmachine>
        <20230818142033.1d7685e9@gandalf.local.home>
        <20230819101519.568d658fbb6461cc60d348e5@kernel.org>
        <CAPhsuW7d4cMi_FAtvyTn4HJWzRdocJaEVq-uYVcW43=JDE_EnA@mail.gmail.com>
        <20230820183218.bf0b04be3c0ccac5e7b2a587@kernel.org>
        <CAPhsuW73yT+D9HhLhi8pafYZsgT=qsqk5foAwGRTvStnWCZwNA@mail.gmail.com>
        <20230821102943.758dca19@gandalf.local.home>
        <20230822001955.d326dbfe7a5755c9684b26cb@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023 00:19:55 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > I guess the question is, does CAP_PERFMON allow seeing where the kernel
> > mapped itself via some other means? If not, then no, I would nack this as
> > being a security hole.  
> 
> As Song said, CAP_PERFMON allows user to put a kprobe anywhere user specified,
> and it can run BPF program on it. This means it can access raw address
> information via registers. if so, CAP_PERFMON allows seeing the kernel map or
> equivalent information at this point.

I still don't like just giving it full kallsyms access.

I really do hate capabilities.

-- Steve
