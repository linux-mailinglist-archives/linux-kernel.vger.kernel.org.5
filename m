Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8527B53DD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbjJBNR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237263AbjJBNRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:17:54 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC1FB4;
        Mon,  2 Oct 2023 06:17:51 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso2338149966b.1;
        Mon, 02 Oct 2023 06:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696252670; x=1696857470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPqnJsqsKHIApUXBARSxKv3rNfiUrOevvN0MUpOGTZU=;
        b=fFy5+PCv5+C6jf18KHrUKTj4I7sfOYLHv1pPKh3ebzEm8zOxq5xOpLIXhRm+f1Z9+x
         h4cuA7duOPCBWFFQXW3lO0j2jX7+HXMQAwTNRZ0U2HRSILkcQXcL614oiBGhBwt8Wi9v
         GiuwXGi5GUTgkv8drlLiBfbmXEHImlpUJ49KNbFqLfU1bUuZh5dj1eEGMPzoG/7FDCp3
         rULItel+gLVbYF0ZIXV7C13O7jehU5OlDuKiIm/bR3kZa4JxSq3DyIKjwZyESlRii9MI
         qQF6Z/ucC2ux2fIq++RTcJKGd1zayE7u+ntcocD9dVx1Oe3qJBLLQ083nmSjP/XYpNg2
         Iksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696252670; x=1696857470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPqnJsqsKHIApUXBARSxKv3rNfiUrOevvN0MUpOGTZU=;
        b=ZIViqMmR4EZOY6RNVFzcPWVY0R/ude8Hec+7nlI8UvoWMmnt+/MMfK2U27zODzjx9S
         uS9emzSgQQd4bIc4rNabXaLs3sLhwIP1BvfPyPNv62KWEJaHhArcfYi3BmIapW++GQvM
         65GQj9FgFpyGY7lzYZmIETjAhYs8Hd2cGG2LMUciCY6IX6tDDtjz5AECOOLubo+NTx1/
         73KnevyApclcr8D76n3mV4VFkNBUOvOc/tOD462X3YQ767+yuHXlUwFuWNBfd8vhOwl4
         H3iWSZ5XFchs/ZbiMztYvNSKGbbcZgARCJAbQ+NpkE3atXa/tiM95bBlnNBfSzC1cXLs
         z4Hg==
X-Gm-Message-State: AOJu0YxS7yPC+jt0YImvVqzCbQ6B471fSGTWpMnlKBsn6Su0gnvvu0NN
        3Nj7QaMuI/g4jVCU6OWHz9w=
X-Google-Smtp-Source: AGHT+IFhl411eyi7vPLUepzMCi+w9fjzkBCacaDfBy64uzt59M6kokx4CDuSnFWWTJcKYypgmf7iuw==
X-Received: by 2002:a17:907:77d9:b0:9ad:e669:ff30 with SMTP id kz25-20020a17090777d900b009ade669ff30mr10547957ejc.68.1696252669523;
        Mon, 02 Oct 2023 06:17:49 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id lw3-20020a170906bcc300b009ade1a4f795sm16919304ejb.168.2023.10.02.06.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 06:17:48 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 2 Oct 2023 15:17:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [PATCH v3 0/3] Fix sched-rt sysctl files & update docs
Message-ID: <ZRrC+huyOi5Ow9s5@gmail.com>
References: <20231002115553.3007-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002115553.3007-1-chrubis@suse.cz>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Cyril Hrubis <chrubis@suse.cz> wrote:

> New in v3:
>  - Spelling fixes as requested by Ingo
>  - added third patch that replaces all cases of realtime with real-time
>    in the docs
> 
> Cyril Hrubis (3):
>   sched/rt: Disallow writing invalid values to sched_rt_period_us
>   docs: scheduler-rt: Clarify & fix sched_rt_* sysctl docs
>   docs: scheduler-rt: Use real-time instead of realtime
> 
>  Documentation/scheduler/sched-rt-group.rst | 40 ++++++++++++----------
>  kernel/sched/rt.c                          |  9 ++---
>  2 files changed, 26 insertions(+), 23 deletions(-)

Applied to tip:sched/core for a v6.7 merge, thanks!

	Ingo
