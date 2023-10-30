Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56547DC282
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 23:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjJ3WgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 18:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjJ3WgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 18:36:01 -0400
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3A6DD
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 15:35:58 -0700 (PDT)
Date:   Mon, 30 Oct 2023 18:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698705357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aGKhGcA7hoykm4opZ2dFmPkeWp+rME4yNLwrlH1CA4Q=;
        b=PoUuMClXCdoxxX6TuVKOZMEUxAGomGwPfc5ZAGnDuZxutO+VlUkE9rrkzJqBpw8/dqSf0U
        0F55Lhak0PbjL2xa6QRzY8/dkkf6InOk/g5MBdAL2rMCaU3l47JaL4S9X1B1hJFaEWuinI
        uSqsA3NMo0LIflvFjOaNuSRjBAfMoZw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, keescook@chromium.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/39] lib/string_helpers: Add flags param to
 string_get_size()
Message-ID: <20231030223553.b246qs6qnibudhbv@moria.home.lan>
References: <20231024134637.3120277-1-surenb@google.com>
 <20231024134637.3120277-2-surenb@google.com>
 <ZTfUCiFP3hVJ+EXh@smile.fi.intel.com>
 <20231024194653.c24qbnk6bx3hep6y@moria.home.lan>
 <ZTpl1ELUMEmne21U@smile.fi.intel.com>
 <20231026184456.q6ocnmpq6jhqi7zi@moria.home.lan>
 <CAHp75Vch5U=F00i0yB82XRU2504pUUEUu1YvBPbiU=FRbJ9FJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vch5U=F00i0yB82XRU2504pUUEUu1YvBPbiU=FRbJ9FJw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 10:07:43PM +0200, Andy Shevchenko wrote:
> I don't think I bikeshed here too much. This is the regular asking the
> reviewers and/or maintainers usually do, so is it too hard to split?

Excuse me?

You were objecting to the new approach making it impossible to add
_octal_ support, and your proposed patch split was completely broken.

Are you trying to be more reasonable now...?
