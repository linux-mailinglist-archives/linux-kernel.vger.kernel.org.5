Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C654F7B778B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 07:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjJDFvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 01:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjJDFvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 01:51:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FF1A7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 22:51:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC103C433C7;
        Wed,  4 Oct 2023 05:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696398671;
        bh=iCuHgBPuubAVdQm7QbXMcIphSaPSVtN9vw7j0BuXv7Y=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=IQ62F9x+o5F1qpPjc+2LK5/Fg0/iJgbyPXCKKIl99oGB6E3h+13uStR+cNVVZnfXM
         KdEmOw2g6DSf+N+fDSoaaeneEi6YRUhXYSGrf1PwjCV6n8B7jVxSg0PxZvJioqluyH
         BYfAxdT2czzbOymGEzK7X7GVk4MVAMaDn+fiCAGqaXRKZUsZhG4SmtKYigFperCNZk
         oZuL6QEwFMi7MgGNAblLveIwaKbKTgV35pDd+IHV1YfGRKxywaXpA51QkYLPwe+UGm
         femEYGr4Q/Eek+3iHho1E00g0+7E4UOEeMWbevRE6AZ6lx2tbcEeJWYTlgOvZZ/tks
         kcJVAHD3D/Ctw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH -fixes] riscv: Fix ftrace syscall handling which are now
 prefixed with __riscv_
In-Reply-To: <CAHVXubgTkoWYEybsbXVbCMO4JaMAChaSq4BgqZZO9ih7OxwUyA@mail.gmail.com>
References: <20231003182407.32198-1-alexghiti@rivosinc.com>
 <CAHVXubgTkoWYEybsbXVbCMO4JaMAChaSq4BgqZZO9ih7OxwUyA@mail.gmail.com>
Date:   Wed, 04 Oct 2023 07:51:08 +0200
Message-ID: <87v8bn3pgz.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> @Conor Dooley This fails checkpatch but the documentation here states
> that this is how to do:
> https://elixir.bootlin.com/linux/latest/source/Documentation/trace/ftrace-design.rst#L246

FWIW, I'll relax the PW CI checkpatch test going forward. It's way too
strict...
