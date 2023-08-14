Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600D977B2BD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbjHNHlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbjHNHlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:41:11 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DA110D5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 00:41:05 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bc7e65ea44so26875645ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 00:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691998865; x=1692603665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=osUjcaEHtBFUKHlMgydGCW0+LXDmW2BKWDOjMgrl0H4=;
        b=gYElgx4Y9XpD+x4CIpjkhq1bSiJGmw+awZyz2AmlDe9X4vT6PAI2iQUwqtPfe8zi83
         pvDVGp8ijRjc1l1skHpiyisdBKMoRdQe824oVY48DrMfzCTi8qguLt58prjnuWSNDJ0B
         ZDa3alWhOkSQjrQkoMm7k5Pajfa4/E5jhFikE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691998865; x=1692603665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osUjcaEHtBFUKHlMgydGCW0+LXDmW2BKWDOjMgrl0H4=;
        b=XZEZh+5YdJfWclJzGYBV16yeqf9uqiMXxfOWGMCBVOlZE4Ou147EfzGvQ1EXox7lPP
         HyD4mdQpdGv6ZILKt6DbIUVPGuIw3qvzO01imk5Ik2neNwKwIda9KJdJQASKzGkI1gWO
         vDe97kpB6yWqWmP54Pthkqd/JJIUEgRT6bMlq/dBAkvy7wpoVkTx+KoxII1V/OEVn0y9
         WCJcnT8CITdLgl2XyeBDE2P02qQir43+L101wqsBcHdpNPOda7NEHvR3xUNgS1oOJphC
         TI+VGDlJnlZNqpV57pBpaD7B/Fdel2RqkFerLvtCVLAsawSW1UY8x5V+OmSOQYS/t3hj
         36iA==
X-Gm-Message-State: AOJu0YxShoAqP1DWXbP8G5aGS2iAYmrY/KC7+mZ0SeG7I8AJBJqww30o
        lMw1tg5Ik6uZzvw+THb4+tggjA==
X-Google-Smtp-Source: AGHT+IGzAzUfBdp29beWjVa3J5Q0XpfJkc7H0CgGQ+XJNgLDognagfaqgl+ZzbOysdJfBVX6PH+nPQ==
X-Received: by 2002:a17:903:1cb:b0:1bc:40ce:e1ec with SMTP id e11-20020a17090301cb00b001bc40cee1ecmr10624727plh.30.1691998865050;
        Mon, 14 Aug 2023 00:41:05 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id jf7-20020a170903268700b001b9f032bb3dsm8732882plb.3.2023.08.14.00.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 00:41:04 -0700 (PDT)
Date:   Mon, 14 Aug 2023 16:40:59 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
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
Message-ID: <20230814074059.GA907749@google.com>
References: <20230811054528.never.165-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811054528.never.165-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/08/10 22:45), Kees Cook wrote:
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

Thanks a lot!

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
