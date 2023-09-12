Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B0D79D963
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbjILTN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjILTN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:13:56 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A234EE6;
        Tue, 12 Sep 2023 12:13:52 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401b393df02so70420975e9.1;
        Tue, 12 Sep 2023 12:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694546031; x=1695150831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TeoZs7xQmKdzpDag8SbCgUnRAmmiY/rfJsyiwqIz2wg=;
        b=amX+k6hxuuWY/0W0kWLMTgiY1rofP/kdN25Gl8u7G+buAgZwSHJo/T+rzzYGsdrUKn
         tZlrppuQzOjosdZ5zpyMyt02bhNSkIRnhvfukQ7hoBPbrMvGpcvhbLX18yJo/TSyukFj
         so3EOwkrqwNvegdMy/2Gch4iP4iQ+zwdLkBG0jkKATV0HW71uzH43r9apH1nEXtNi7ig
         VciGEGTo/XEM2pnxH75sqpVoloxKxjTyLwD11mDfFbINOVgKPkfarhgWv2hh9+oeF7eS
         DZMPAw50jGySl9/2Ajl2wUuu4qNU814sJBC3LfPRC8BV9ybsAHluiLN6UHnCrg2qbQRd
         osYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694546031; x=1695150831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TeoZs7xQmKdzpDag8SbCgUnRAmmiY/rfJsyiwqIz2wg=;
        b=N55bdneS94k7rNewsV2eyTrgJgOWVHiE+UfzSodO87EHUmDaVgGqcJgzYxtP6EuAV4
         y1C8JtEW2JXEIkjJPjl6YX17D0A76sRFuSxEICeG/eg2CZEbfH4hGIzT+CuiZPV2NwEx
         w19FX1Fu/et+iF01XIrwO58IukWTMfcgfqq4T2lu/fSEjDR/v5XFSogNWtlL+5ZDDINO
         YVE3hF+y7pVz4LWNML36falksH5ztnU/NzwZHIcBpjrYeau5y+vebYO5mOO3k71cBgZ7
         /IVIwI4IUjpBET0pXeGU8kPhVCZAn2n7FyVu9RFlEY0oPbLpXtMIUHR5Ys2CLsQtxz8B
         Q+xQ==
X-Gm-Message-State: AOJu0Yx+Jg3TXf/p32P2h8WgM6+DrjMx1HpkymWWibhmyXosjrr3riOx
        RYvaELeOhb8Nd0neC0z3BFg=
X-Google-Smtp-Source: AGHT+IEKiL11zfBDl8yaQlLJxvTC9Xw7ZSCVeIdBcoIFgGvnKVa07dBGn4wXuvlP08eImu0izECGPQ==
X-Received: by 2002:a05:600c:20c4:b0:3fe:e85b:425d with SMTP id y4-20020a05600c20c400b003fee85b425dmr300453wmm.9.1694546030978;
        Tue, 12 Sep 2023 12:13:50 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id y12-20020a1c4b0c000000b003fee9cdf55esm13409501wma.14.2023.09.12.12.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 12:13:50 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id B695BBE2DE0; Tue, 12 Sep 2023 21:13:49 +0200 (CEST)
Date:   Tue, 12 Sep 2023 21:13:49 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Timo Sigurdsson <public_timo.s@silentcreek.de>
Cc:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        regressions@lists.linux.dev, sashal@kernel.org,
        1051592@bugs.debian.org,
        Arturo Borrero Gonzalez <arturo@debian.org>
Subject: Re: Regression: Commit "netfilter: nf_tables: disallow rule addition
 to bound chain via NFTA_RULE_CHAIN_ID" breaks ruleset loading in
 linux-stable
Message-ID: <ZQC4bcVVK99Q8WrO@eldamar.lan>
References: <20230911213750.5B4B663206F5@dd20004.kasserver.com>
 <ZP+bUpxJiFcmTWhy@calendula>
 <20230912113959.8F8B26321005@dd20004.kasserver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912113959.8F8B26321005@dd20004.kasserver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Timo,

On Tue, Sep 12, 2023 at 01:39:59PM +0200, Timo Sigurdsson wrote:
> Hi Pablo,
> 
> Pablo Neira Ayuso schrieb am 12.09.2023 00:57 (GMT +02:00):
> 
> > Hi Timo,
> > 
> > On Mon, Sep 11, 2023 at 11:37:50PM +0200, Timo Sigurdsson wrote:
> >> Hi,
> >> 
> >> recently, Debian updated their stable kernel from 6.1.38 to 6.1.52
> >> which broke nftables ruleset loading on one of my machines with lots
> >> of "Operation not supported" errors. I've reported this to the
> >> Debian project (see link below) and Salvatore Bonaccorso and I
> >> identified "netfilter: nf_tables: disallow rule addition to bound
> >> chain via NFTA_RULE_CHAIN_ID" (0ebc1064e487) as the offending commit
> >> that introduced the regression. Salvatore also found that this issue
> >> affects the 5.10 stable tree as well (observed in 5.10.191), but he
> >> cannot reproduce it on 6.4.13 and 6.5.2.
> >> 
> >> The issue only occurs with some rulesets. While I can't trigger it
> >> with simple/minimal rulesets that I use on some machines, it does
> >> occur with a more complex ruleset that has been in use for months
> >> (if not years, for large parts of it). I'm attaching a somewhat
> >> stripped down version of the ruleset from the machine I originally
> >> observed this issue on. It's still not a small or simple ruleset,
> >> but I'll try to reduce it further when I have more time.
> >> 
> >> The error messages shown when trying to load the ruleset don't seem
> >> to be helpful. Just two simple examples: Just to give two simple
> >> examples from the log when nftables fails to start:
> >> /etc/nftables.conf:99:4-44: Error: Could not process rule: Operation not
> >> supported
> >>                         tcp option maxseg size 1-500 counter drop
> >>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >> /etc/nftables.conf:308:4-27: Error: Could not process rule: Operation not
> >> supported
> >>                         tcp dport sip-tls accept
> >>                         ^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > I can reproduce this issue with 5.10.191 and 6.1.52 and nftables v1.0.6,
> > this is not reproducible with v1.0.7 and v1.0.8.
> > 
> >> Since the issue only affects some stable trees, Salvatore thought it
> >> might be an incomplete backport that causes this.
> >> 
> >> If you need further information, please let me know.
> > 
> > Userspace nftables v1.0.6 generates incorrect bytecode that hits a new
> > kernel check that rejects adding rules to bound chains. The incorrect
> > bytecode adds the chain binding, attach it to the rule and it adds the
> > rules to the chain binding. I have cherry-picked these three patches
> > for nftables v1.0.6 userspace and your ruleset restores fine.
> 
> hmm, that doesn't explain why Salvatore didn't observe this with
> more recent kernels.
> 
> Salvatore, did you use newer userspace components when you tested
> your 6.4.13 and 6.5.2 builds?

It does explain now because understanding the issue better. While one
while experinting should only change each one constraint for the
6.4.13 and 6.5.2 testing I indeed switched to a Debian unstable
system, which has newer userpace nftables and so not triggering the
issue. This was missleading for the report.

> As for the regression and how it be dealt with: Personally, I don't
> really care whether the regression is solved in the kernel or
> userspace. If everybody agrees that this is the best or only viable
> option and Debian decides to push a nftables update to fix this,
> that works for me. But I do feel the burden to justify this should
> be high. A kernel change that leaves users without a working packet
> filter after upgrading their machines is serious, if you ask me. And
> since it affects several stable/longterm trees, I would assume this
> will hit other stable (non-rolling) distributions as well, since
> they will also use older userspace components (unless this is
> behavior specific to nftables 1.0.6 but not older versions). They
> probably should get a heads up then.

So if it is generally believed on kernel side there should not happen
any further changes to work with older userland, I guess in Debian we
will need to patch nftables. I'm CC'ing Arturo Borrero Gonzalez
<arturo@debian.org>, maintainer for the package. The update should go
ideally in the next point releases from October (and maybe released
earlier as well trough the stable-updates mechanism).

FWIW: In Debian bullseye we have 0.9.8 based nftables, in bookworm
1.0.6, so both will need those fixes.

As 0ebc1064e487 is to address CVE-2023-4147 other distros picking the
fix will likely encounter the problem at some point. It looks Red Hat
has taken it (some RHSA's were released), I assume Ubuntu will shortly
as well release USN's containing a fix.

Regards,
Salvatore
