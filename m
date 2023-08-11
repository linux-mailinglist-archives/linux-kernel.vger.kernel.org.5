Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A88A77954C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjHKQxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjHKQxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:53:53 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D5130C1;
        Fri, 11 Aug 2023 09:53:52 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 5EDDE32001FF;
        Fri, 11 Aug 2023 12:53:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 11 Aug 2023 12:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691772830; x=1691859230; bh=W3
        QlfQPf/mhvsUrrEpuciPnw8YcCrut43G8ZIaPlOQ0=; b=rq1RlGScfenEom/BZ5
        mh5DqdQFANtcENVmz1ZAe1+woYnjJlXGpi4QGvKSHV0CdWGUTvpf2StJsjr4qQDy
        ZrA/NUhULu2Pr4fvOMPXieFrjfhN+wtCI3JvX7lPKvgT4Fyp7/Y8ijDSgiC9cY1W
        sIBituV1M9VDfjLYRPUasZS/WNnCgZaDQRaV3aoepfvkowsjAtlZDScm44hXjnwR
        XEtkzlQCH06mPWtAa3xo0QkzKS+H6DLZbDF6FjbF1oiJU+tIIfvZF29oZhIsLjzz
        NGjLfr5EVh5r4oprdx9iWm6R+09s6yrIqc8vI7Ao+v1aM2PDSj+9lo949lZYFA7m
        UUPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691772830; x=1691859230; bh=W3QlfQPf/mhvs
        UrrEpuciPnw8YcCrut43G8ZIaPlOQ0=; b=qmNm5DWVpIG9SgcAJYhVSgVOFi0gJ
        ShmFThzYAQY2nerhQPStN4DEK9Klef2gV7qOhe8pZIbMZmAEDKMFPp65BWW+TwqA
        lmay1DrejRorvFGPP1jnFpCPkfGdjfhc8H9ZpJS3YKpUOtW7FIwJpEjoPKrVudV8
        fwNizWihX07PcLVxEdFwOrzOzSfgpCXiBFdpNwhL6Hhq9A8EGgH+VH+DAauyM3gY
        jhqeiNzKqzzVqd0OpJ3yrDU+BbH66hZsywDIoJ++o35KJ8nVS5g+JIAK8fL+avVK
        tlm9IybVbnmo+y3mWvZc/VyPK8+kkDzyoZDv5Kv2gWbtd8EQESc70+4EA==
X-ME-Sender: <xms:nmfWZF8iK3vuXAKFmEQz36vdzOXVZsMlVT8JisQNk0bm7R51qb1T7g>
    <xme:nmfWZJsYyYvEZi8yH17GasH1EEzTsj9dCvbeDLI9W0FmFk7oHv58ZiByP1hpoDRFw
    f7vJ17kaH2w4Rh39BU>
X-ME-Received: <xmr:nmfWZDAU_0ABHVXasHGgFRF02xuqLC_UNpuQMCBP4rx27NZJsQxs9EAY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleekgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihlhgv
    rhcujfhitghkshcuoegtohguvgesthihhhhitghkshdrtghomheqnecuggftrfgrthhtvg
    hrnhepgfegkeeiffethefgteffudfhfeejhedvjefhjeekudelffdulefhfeekieeludej
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgesthihhhhitghkshdrtghomh
X-ME-Proxy: <xmx:nmfWZJck4ln2F7jxcVbJG6QURvQHknn9Xh1q7cej8zxPpb_SpgQOLw>
    <xmx:nmfWZKMCoVtSMG68BUOndwBvE0RGbScyva5GfT2aVzBLC9lVgvZ2sw>
    <xmx:nmfWZLktF_X2IYxq1MjH2dCti0xOO0x2reyhn08ONqHYHCPzovZUrQ>
    <xmx:nmfWZLGDKWjsrGWc1qfphg8p0zz2jOTc7ZfN7gpDXcIDsF79wiRTxw>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Aug 2023 12:53:48 -0400 (EDT)
Date:   Fri, 11 Aug 2023 11:53:37 -0500
From:   Tyler Hicks <code@tyhicks.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Vijay Balakrishna <vijayb@linux.microsoft.com>,
        stable@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] printk: ringbuffer: Fix truncating buffer size min_t cast
Message-ID: <ZNZcTQCDXfMA3v6O@sequoia>
References: <20230811054528.never.165-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811054528.never.165-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-10 22:45:32, Kees Cook wrote:
> If an output buffer size exceeded U16_MAX, the min_t(u16, ...) cast in
> copy_data() was causing writes to truncate. This manifested as output
> bytes being skipped, seen as %NUL bytes in pstore dumps when the available
> record size was larger than 65536. Fix the cast to no longer truncate
> the calculation.
> 
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: John Ogness <john.ogness@linutronix.de>
> Reported-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
> Closes: https://lore.kernel.org/lkml/d8bb1ec7-a4c5-43a2-9de0-9643a70b899f@linux.microsoft.com/
> Fixes: b6cf8b3f3312 ("printk: add lockless ringbuffer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Nice find!

Reviewed-by: Tyler Hicks (Microsoft) <code@tyhicks.com>
Tested-by: Tyler Hicks (Microsoft) <code@tyhicks.com>

Verified the fix by applying it to an instrumented v6.5-rc5 kernel that
allows userspace to execute kmsg_dump(), detects NULL bytes in data
copied from the ring buffer, and warns about invalid truncation due to
the min_t(u16, ...) casting bug. Everything looks good!

Tyler

> ---
>  kernel/printk/printk_ringbuffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index 2dc4d5a1f1ff..fde338606ce8 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -1735,7 +1735,7 @@ static bool copy_data(struct prb_data_ring *data_ring,
>  	if (!buf || !buf_size)
>  		return true;
>  
> -	data_size = min_t(u16, buf_size, len);
> +	data_size = min_t(unsigned int, buf_size, len);
>  
>  	memcpy(&buf[0], data, data_size); /* LMM(copy_data:A) */
>  	return true;
> -- 
> 2.34.1
> 
