Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264737C6076
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376516AbjJKWmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbjJKWms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:42:48 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92389D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 15:42:46 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5333fb34be3so695862a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 15:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697064165; x=1697668965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/yrWMHnU++xrRqYHbtcx/jI9yDnw9HSAqWIYV1wwM4s=;
        b=fvGP5m6I5GUDE+yqS0XZnaI6tq4FdXF/rNbu6F5SPfatZPGZ8KUlzEaSv94bs0LAoR
         EyfOeWDB8RVQj4OfdlLJMqJtzoe+/VWiMwS5/gEixZi8ne0yoRiaphpRooDbfqwljxuq
         euObnl7lxJeZxU2eZptWieE9zLv24wmyzx2qOyqrSZyAsWGyyD3TPsIK5tFkJ/C/JBtr
         mRpCa7oLh4KQKXdvMd8sTfeoLD7asDzG9NUD/fK8zh31rsmo9g3NRl1JHry29Y+IzfzP
         xJ42YCRrIK9ksGoUSK++hu8pFrQVA6ZYaoBRS/a5fGVeGSuLV2VVmPgWHjUmuTG4LJIC
         Gt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697064165; x=1697668965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yrWMHnU++xrRqYHbtcx/jI9yDnw9HSAqWIYV1wwM4s=;
        b=FDb9rJgztv+SR8aOdKGylBi/F+tDLMaNQyz9OM+TsVcBSWWn7HGRxdNe8NtD7Q1/Lm
         qLhV6xhYJrinZiyYjQ93/8ezKIz6sNx3ipW+kczEfiDMRECpywU3YnAlPDlwY7DAmhSr
         oAzhxuPtRJ9mZf7B3XUb/Mpoja8OBTWho9bZuTNoTPX7oSWS0w8wenQ8PFywNKsDk1XA
         SeZuy3BTlr0K2sgj2S9cc2AWSpFJKtbq8zDumiztsVGJCf9Y82abPCovVWUkvsfo9WXn
         Q2HerJcN+8aIbcsUksR2CeVw/mAsZ8GtSm5V7jLcniyb9LQlQ8zYVaGib0yKWzblHrVk
         Akhw==
X-Gm-Message-State: AOJu0YyGZMZUvyMC1Zif2qsEtapS7tV9/oXyebZCN5BP6Uu2vpZGOt1j
        QvqsLjuUNYWzvLk8gCKUz38=
X-Google-Smtp-Source: AGHT+IE+wKu7paim2Fer5C0M2i7Oxkg46ZEcFshD9/tGoguQTUrempImFlqZeALERKQproe4B5Zw/A==
X-Received: by 2002:aa7:c549:0:b0:525:6e47:10f6 with SMTP id s9-20020aa7c549000000b005256e4710f6mr20151639edr.22.1697064165123;
        Wed, 11 Oct 2023 15:42:45 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id ba10-20020a0564021aca00b005346bebc2a5sm9336498edb.86.2023.10.11.15.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 15:42:44 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 12 Oct 2023 00:42:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        David Kaplan <david.kaplan@amd.com>, x86@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Revert "x86/retpoline: Remove
 .text..__x86.return_thunk section"
Message-ID: <ZSck4mcr6sKS/ob7@gmail.com>
References: <20231010171020.462211-1-david.kaplan@amd.com>
 <20231010171020.462211-2-david.kaplan@amd.com>
 <20231010174833.GG14330@noisy.programming.kicks-ass.net>
 <20231010195721.p5pb273kevg7ydxz@treble>
 <20231010200429.GIZSWuTWSUM9aId7a6@fat_crate.local>
 <20231010201912.7pjksbparssqu34k@treble>
 <20231010212254.ypk2wdogno55shit@treble>
 <20231011074142.GK14330@noisy.programming.kicks-ass.net>
 <20231011162843.grv6kixw4ides6uw@treble>
 <20231011223513.GH6307@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011223513.GH6307@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> I don't care too deeply, I can't make up my mind either way. But perhaps 
> keeping the section is easier on all the backports, it's easy to forget a 
> tiny objtool patch like this.

If the objtool fix has a Fixes tag that points to one of the major 
mitigation commits, then it won't be forgotten.

Arguably the new objtool is more robust against what could happen, so that 
patch is not going away - and with that patch mainline doesn't have to keep 
the (now ...) pointless section.

Maybe change the commit order around: first add the objtool fix, then 
remove the section, pointing back to the objtool SHA1 in the very next 
commit, explaining that the objtool fix enables this change. That makes it 
all backporting-proof as well.

Thanks,

	Ingo
