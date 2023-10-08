Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D707BCD85
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 11:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344537AbjJHJ3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 05:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjJHJ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 05:29:31 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D45AC
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 02:29:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-98377c5d53eso619342966b.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 02:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696757368; x=1697362168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OABQteG0diB/a10SIinmyQPt6vzd3GItMqWnEkzIryM=;
        b=U4LIEYCMMKjY++SQNPXedP3o7JkTaHlOxYBsaJ4/Ju5JKxtFB6er4heZGdg3IdmxgD
         vVUYcO2qRHFMtucjj/XCQhJVi+tAvUyscYJ6ULqldWeqHqdjh2SJuWLbN/40hSgHmHT6
         +6xoRwIncylL79mKLwix5pmCvo4Oe+/QKvuS9b6zLZsAzLxdk1ZaGZXdb6loSsiq86BG
         qadIhWemwa9ZyRi07s1ZY+WfFjQsZJS4OjgxQbC1X5NsNh1Jghn0N23QTz2J7ZHs7U0b
         +7b3xCNi0nLK9nvbif9EOBgkPzzhQhuSb7928VxdJWr3NsVizVOAs6yu99/7SknHIjRH
         H4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696757368; x=1697362168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OABQteG0diB/a10SIinmyQPt6vzd3GItMqWnEkzIryM=;
        b=HFJsEjNA1hnxXE1oAAfxDco/mdVcUMlmU7wSb8VOFVwyuAMKfswAc4FC9iNW5ESJ/5
         zdutm1Jk9xaZa7Psprgu/1mIt9gq1xBRVcVZhr/zvQvsm5hMUaQZ+CgDdLc6Lnz85gPM
         Smc38gqTHqs0PvLIfvpwuWW3V9fkuS03sTY/EYgwpmBSf0mOZzl0kmhhBHbBdQ5dEuwI
         WPtEL8kx0Rp3gand2JqV/y5OxzD4jQxcdHeIJbTvKSKjxKR1Xob1MpapBepHftWTi3RM
         onzsomHOC5ND2jod9bnhnrUSbL9nFGacLaHHz5yXhAsOzk5ugLj81GQDleUF3DZqEeoz
         EGeQ==
X-Gm-Message-State: AOJu0Yz5TSmXLFjDR5DY6PomLk+3aVkEMwTdNUMIiQq4lbk8Ynw1iA4n
        Orp8DlTqcxc+pG+CQQsMCKI=
X-Google-Smtp-Source: AGHT+IFjab5KAUzDmrJVlW/Zf1y4+OvtG1gWfL7/Z3KxRqpjAzfh4AHbu8X24buZkJ9ZmGlLvRvEGw==
X-Received: by 2002:a17:906:3f04:b0:9ae:5568:b6a8 with SMTP id c4-20020a1709063f0400b009ae5568b6a8mr12489378ejj.10.1696757367584;
        Sun, 08 Oct 2023 02:29:27 -0700 (PDT)
Received: from gmail.com (195-38-113-164.pool.digikabel.hu. [195.38.113.164])
        by smtp.gmail.com with ESMTPSA id sd23-20020a170906ce3700b009b2b9af0784sm5273282ejb.110.2023.10.08.02.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 02:29:26 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 8 Oct 2023 11:29:24 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Philip Li <philip.li@intel.com>
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, linux-mm@kvack.org
Subject: Re: [tip:x86/percpu] [x86/percpu] ca42563486:
 BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)
Message-ID: <ZSJ2dIRNvgfrOrpZ@gmail.com>
References: <202310071301.a5113890-oliver.sang@intel.com>
 <CAFULd4bUu=wVhH8AweOPycEw2QsbFWSjP8ytr7SM6Z5WLOdWsA@mail.gmail.com>
 <ZSEtmiUERKp1+KX7@rli9-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSEtmiUERKp1+KX7@rli9-mobl>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Philip Li <philip.li@intel.com> wrote:

> For this report, we have found a possible boot issue on the reported 
> kconfig as compared to the parent commit. You can kindly do a check.

Thank you for reporting this - I've excluded tip:x86/percpu from 
tip:master for the time being, until we manage to fix the bug.

This should address the boot crash starting with tomorrow's -next 
integration.

Thanks,

	Ingo
