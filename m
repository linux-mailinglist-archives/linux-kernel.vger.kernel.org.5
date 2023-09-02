Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A53790767
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 12:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352004AbjIBKqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 06:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjIBKqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 06:46:13 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20574F3;
        Sat,  2 Sep 2023 03:46:10 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-401b0d97850so28868995e9.2;
        Sat, 02 Sep 2023 03:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693651568; x=1694256368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Kh1VI1LcjsBnupdfTnq6KlXv8yLyvgvRnkwgnm5o6U=;
        b=sZsMF9f9fM3ZZxDYfqNZgBIUDZl2rBQ7jfaXEYG/LF04lX6Nw4K98qyFX1MVBpaG2R
         2Tbxy84+TVepePpo3labnL3rPhrbOYS88cDXQz/0/KABtD6J8g1HL/9yhuOBJQizwf/5
         DD2PeBlyHbXjlChhJ31uEAksnQKmjrDI0JTmZbA8bpROXGTFZ+m2Y+0PB8bY0kwqKvcQ
         LJJh81rP5tp22wzap9Y0pATpmFFALQWWWXY8nMjbfzsv4abbtz6/TBK+Kpb24wY/HbCC
         feTfwH6ogBx8n/k0wwDSwEd4Lb4EHOklWH44a347nJbPAjoRCniiu8lMoXKJkJlGQMPn
         Rg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693651568; x=1694256368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Kh1VI1LcjsBnupdfTnq6KlXv8yLyvgvRnkwgnm5o6U=;
        b=KrjhPaUhZBKVYA810e+YRw9S+s7rC2Ib0yaMGqOiEGPWhn7JTNRJRAuIl5+7a0pUz5
         QMOBkFzjwEHGWe90c7lmGr/UKEVhj4T8ZVoACaSBAP/YYh/6OycRfglw6rE0jwmbKEAe
         ou8EVda5U/Xu0zluytlrpRgvd4Z6NPrYW45uYX1YStEF0UbjE5Yjm4+e2NPQFwKYdUvW
         oBM2axJQG238ZNw4ywOHXHbsshtEwmK1ZmKLHuwDfo6yWtuuq7ZmixMujI6UnhTiRG3s
         h8lhBqGJ47tF5Xn4Ou47ttja6CAOdH4qJ7XlpvtsqaEc9Sj39Uk+yrUqzowK52TUArrS
         RRIw==
X-Gm-Message-State: AOJu0YzX7Q9p9kgpWnFwR2hMLVDoIblPA5AR4i+lJiLWOGV2r1WbnmNe
        oIrr/A+ufYqiW7UsiNC+4l8=
X-Google-Smtp-Source: AGHT+IGw3MfYy/uixXGIijRnylwpNaNUbgKvyqvZnK8GYnTifW1QIar7BFthAZ79YlDJ9ikGvECA5A==
X-Received: by 2002:a1c:4b08:0:b0:3fb:b3aa:1c8a with SMTP id y8-20020a1c4b08000000b003fbb3aa1c8amr3400357wma.16.1693651568188;
        Sat, 02 Sep 2023 03:46:08 -0700 (PDT)
Received: from gmail.com (1F2EF6A2.nat.pool.telekom.hu. [31.46.246.162])
        by smtp.gmail.com with ESMTPSA id y3-20020adfe6c3000000b00317909f9985sm8107077wrm.113.2023.09.02.03.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 03:46:07 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 2 Sep 2023 12:46:05 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-tip-commits@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/bugs] x86/srso: Fix vulnerability reporting for
 missing microcode
Message-ID: <ZPMSbabIw5ZtTqbo@gmail.com>
References: <65556eeb1bf7cb9bd7db8662ef115dd73191db84.1692919072.git.jpoimboe@kernel.org>
 <169295877252.27769.17888941552572030723.tip-bot2@tip-bot2>
 <20230901094053.GDZPGxpcG56GwE0LyG@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901094053.GDZPGxpcG56GwE0LyG@fat_crate.local>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Aug 25, 2023 at 10:19:32AM -0000, tip-bot2 for Josh Poimboeuf wrote:
> > The following commit has been merged into the x86/bugs branch of tip:
> > 
> > Commit-ID:     b3be1397be0340b2c30b2dcd7339dbfaa5563e2b
> > Gitweb:        https://git.kernel.org/tip/b3be1397be0340b2c30b2dcd7339dbfaa5563e2b
> > Author:        Josh Poimboeuf <jpoimboe@kernel.org>
> > AuthorDate:    Fri, 25 Aug 2023 00:01:41 -07:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Fri, 25 Aug 2023 11:21:59 +02:00
> > 
> > x86/srso: Fix vulnerability reporting for missing microcode
> > 
> > The SRSO default safe-ret mitigation is reported as "mitigated" even if
> > microcode hasn't been updated.  That's wrong because userspace may still
> > be vulnerable to SRSO attacks due to IBPB not flushing branch type
> > predictions.
> > 
> > Report the safe-ret + !microcode case as vulnerable.
> > 
> > Also report the microcode-only case as vulnerable as it leaves the
> > kernel open to attacks.
> > 
> > Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Link: https://lore.kernel.org/r/65556eeb1bf7cb9bd7db8662ef115dd73191db84.1692919072.git.jpoimboe@kernel.org
> > ---
> >  Documentation/admin-guide/hw-vuln/srso.rst | 22 ++++++++++----
> >  arch/x86/kernel/cpu/bugs.c                 | 34 ++++++++++++---------
> >  2 files changed, 37 insertions(+), 19 deletions(-)
> 
> This is still unfixed:
> 
> https://lore.kernel.org/r/20230825072542.GFZOhXdgXpUidW51lC@fat_crate.local
> 
> mingo, do you want fixes ontop or do you wanna rebase this branch?

Since these are fixes that are supposed to be fully correct,
I'd suggest we rebase it.

Josh, mind sending a v3 SRSO series, as a replacement for x86/bugs,
with Boris's review & testing feedback addressed?

[ Feel free to send it as a delta series against v2 in x86/bugs and I'll 
  backmerge it all. ]

Thanks,

	Ingo
