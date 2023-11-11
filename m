Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA487E8BBF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 17:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjKKQxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 11:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKKQxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 11:53:47 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E686A2590;
        Sat, 11 Nov 2023 08:53:43 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so3147780b3a.2;
        Sat, 11 Nov 2023 08:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699721623; x=1700326423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tKsYqeTKvyflOZt7aAZyQORAfJRtz6JfB29s29kRskY=;
        b=bnnzCAlWiBPucRE0kZISZgTociNSIXEadw5J6x71zifQY0B9XzW2cg8WVKzKonje/V
         d3LTmCeU9EK6ODQ4R0YP89tiV1M+Ze9OWDx0nnN5VSj7V4QIIhRfhuUXhm7Hk1ua0Zg2
         C3/Bi2HuzKl/r/O5yHtSZH/5jrxCfwYH9+F+LpJ12+JqD932PBCY6QlZdk/Kgj7O8gYq
         B4kT7j4JzEii55cbr7LE/OBUiNhc1PTNV7qPWD2BUJVRLRLAJVlLnM2Vm8IAKQLfhF1X
         Qw0c5VAYjsD4uRNrZ6qcsciHNUlQengrJ1X6CL8FOY+RN6esvLu7a6MUWndTJEnwsxys
         Tsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699721623; x=1700326423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKsYqeTKvyflOZt7aAZyQORAfJRtz6JfB29s29kRskY=;
        b=NIxrswwXQ9KxytHrBH2f5ljY45GDJrQTOz1WbjqqxWnXZ6/f9KjsfXFKBTvlMdAT6b
         tQ3AsvON8IvVnz0RkCG5MAh5wcSQHhwVLinyI+mQ82giH7KP/ki0yAlFk4g7BV5BfYyF
         hNg85Sp6wzfblvumMcgV48o7zkWz8Bxnnuxip8aigwhuD0Cik41SL9N/hZYAxHSLNfKK
         +nYOFNv7M7jbfvfFJV/0LC0QqogR17ldpKVH47Le9qGhe6YAui+14jJ3+riSfT+EX6ZS
         J8MC517NGNkfJYO5Yo2rno8aft9BMr9KA2n/yg0MA0dXj3YQrmN+0V50DJXdmK7rM1Zy
         vR3g==
X-Gm-Message-State: AOJu0YymOmo9Q5Xf5r8WGr+JNasl07Ffck9BqwBZdwnnm7Qro0GMElAn
        d5xYXrYnWXn45UvMwImo3iBHyR7RS/DjWA==
X-Google-Smtp-Source: AGHT+IEKdRyc74l4fdWmW2an++vXfXOSZMnlGaRR0E3c5U0wLIrJ7Q1G0iXYos1atXUoBDYgVhvGzQ==
X-Received: by 2002:aa7:85c4:0:b0:690:ce36:8b00 with SMTP id z4-20020aa785c4000000b00690ce368b00mr2405037pfn.2.1699721623279;
        Sat, 11 Nov 2023 08:53:43 -0800 (PST)
Received: from swarup-virtual-machine ([171.76.83.22])
        by smtp.gmail.com with ESMTPSA id e14-20020a62ee0e000000b00688435a9915sm1459536pfi.189.2023.11.11.08.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 08:53:42 -0800 (PST)
Date:   Sat, 11 Nov 2023 22:23:38 +0530
From:   swarup <swarupkotikalapudi@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests: capabilities: namespace create varies for
 root and normal user
Message-ID: <ZU+xkpH09xjzO5IS@swarup-virtual-machine>
References: <20230929125348.13302-1-swarupkotikalapudi@gmail.com>
 <0f3a63ff-cbf9-4e06-8f4f-fd22bafa26fe@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f3a63ff-cbf9-4e06-8f4f-fd22bafa26fe@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 02:23:34PM -0700, Shuah Khan wrote:
> On 9/29/23 06:53, Swarup Laxman Kotiaklapudi wrote:
> > Change namespace creation for root and non-root
> > user differently in create_and_enter_ns() function
> > 
> 
> Sorry for the delay on reviewing this.
> 
> Can you tell me more about why this change is needed and
> include it in the change log.
> 
> thanks,
> -- Shuah

Hi Shuah,

This patchset was raised to fix below TODO:

"If we're already root, we could skip creating the userns."

Without this patchset, function create_and_enter_ns(),
at this path --> tools/testing/selftests/capabilities/test_execve.c
was as mentioned below:

static bool create_and_enter_ns(uid_t inner_uid)
{
   ....
   if (unshare(CLONE_NEWNS) == 0) {
       ....   
    } else if (unshare(CLONE_NEWUSER | CLONE_NEWNS) == 0) {
       ....
     } else {
                ksft_exit_skip("must be root or be able to create a userns\n");
     }

     ...
}

To fix the TODO, above mentioned if block is executed if root user,
for normal user it enters inside 'else if' block.

Thanks,
Swarup
