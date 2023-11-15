Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F2E7ED754
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 23:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344326AbjKOWeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 17:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbjKOWeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 17:34:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E01197
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:34:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C64AC433C7;
        Wed, 15 Nov 2023 22:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1700087651;
        bh=RPCr+mo1zODqFJlwyYvp8P0sgcWngl4DsJin7qkkwfA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZxcdXi/89TPqDqOX33gxismO3xXIZLPF0QaLfUYnx5uOf66VdC0NzXlyZMYC9DDQe
         7BVIzb5Dm5t3lfDNA8Yxn47isviP3R0geoxMcVbswDuOYO6kSRUrrKaLtYAGvd2Ftn
         BZ3T6S/9qBGkg3WKY9zwy8xN+G4xCqwgGzqMOB4Y=
Date:   Wed, 15 Nov 2023 14:34:10 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Paul =?ISO-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@tum.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kasan: default to inline instrumentation
Message-Id: <20231115143410.e2c1ea567221d591b58ada1f@linux-foundation.org>
In-Reply-To: <918c3ff64f352427731104c5275786c815b860d9.camel@perches.com>
References: <20231109155101.186028-1-paul.heidekrueger@tum.de>
        <CA+fCnZcMY_z6nOVBR73cgB6P9Kd3VHn8Xwi8m9W4dV-Y4UR-Yw@mail.gmail.com>
        <CANpmjNNQP5A0Yzv-pSCZyJ3cqEXGRc3x7uzFOxdsVREkHmRjWQ@mail.gmail.com>
        <20231114151128.929a688ad48cd06781beb6e5@linux-foundation.org>
        <918c3ff64f352427731104c5275786c815b860d9.camel@perches.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 21:38:50 -0800 Joe Perches <joe@perches.com> wrote:

> > +LIBRARY CODE
> > +M:	Andrew Morton <akpm@linux-foundation.org>
> > +L:	linux-kernel@vger.kernel.org
> > +S:	Supported
> 
> Dunno.
> 
> There are a lot of already specifically maintained or
> supported files in lib/

That's OK.  I'll get printed out along with the existing list of
maintainers, if any.

> Maybe be a reviewer?

Would that alter the get_maintainer output in any way?

I suppose I could list each file individually, but I'm not sure what
that would gain.

btw, I see MAINTAINERS lists non-existent file[s] (lib/fw_table.c). 
Maybe someone has a script to check...
