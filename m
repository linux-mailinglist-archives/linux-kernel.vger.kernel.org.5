Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6356F7FBB58
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345111AbjK1NW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344875AbjK1NW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:22:28 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA25A0;
        Tue, 28 Nov 2023 05:22:34 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cfc34b6890so19769405ad.1;
        Tue, 28 Nov 2023 05:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701177754; x=1701782554; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30VypmY2CFZ8lvqagGC6jaet2OpETydP+u6D3TSu8fI=;
        b=gS+2sAKa2JBYPVICquPPt+xxjHgT5NonnAOR9Cqy8i7FTINvDQVAf/A0/FGQgetPCV
         AUN0lka06G7EFwylo9Mg/Nllkm9BmB6SB7coVFP/fXq1Mgmg3CyhFS3hDmx6BPgZkLTk
         Wto9aTndWnNpv9uAFjhsqvj6+p3PFabmTqwsaZkTAlx+66FRZal1lwVNZBqZJnEJPvsz
         64mnZpQYzEMsLcwwioi8z4o+IoY+VZr/lRwuOKmpBsL6fVoHVbLg5WJW8/3pDXVQoBNa
         1+6zjBO/TxGrtwoT9RYlhJA4a1C6rrzR9knhZ9JzkLIJ9mLHdife8X7V/c1Eabx2mky1
         lDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701177754; x=1701782554;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=30VypmY2CFZ8lvqagGC6jaet2OpETydP+u6D3TSu8fI=;
        b=esnAz3IWr4MPwVkAk2tfURXRFB/EDbvo4uNK7q0Lenk4NBNGE5nliOpf+glX9qCF3o
         TzwGlNFEdAOz5UMTwJJ54zsZBPWG7WVnfnW/vw9/SZgOMD6aYwKuhMltjsCXIUmXadER
         sURfYzffcaMPM4CVZOfcy+rXV93F7/JHXGYfuiOFv+6mcS0iYh/3H7SwZAHblDSkOCVh
         iStQbsuIIXmokrv+Xnqj0rwSCU281fEkRk6d8a3aQgni7eSVt3xwISFgJp8QopMY8bcP
         lEGfUgQv7iSiGPkbCTNX2rT8Aoaz+GJj4+7yhTQoBd4fFyD+8mQi+SkTt4T74BWIudnk
         6rNA==
X-Gm-Message-State: AOJu0YwK8iNoxLWw7wf00JspSo9K76MbgW4qrwmaIJW766yi0DQkAY/y
        mHBmivqMnXDNAVOPjHUYrNMJtcdIK6qIAA==
X-Google-Smtp-Source: AGHT+IH3JFeDBdC18l8j/Q+NB48Ja1KZVkzEIv229wi7jf8qWZFdPd/OFYbLqFjShGbgQBekqvZ+4w==
X-Received: by 2002:a17:902:ead2:b0:1cf:a53f:200f with SMTP id p18-20020a170902ead200b001cfa53f200fmr16674842pld.32.1701177753559;
        Tue, 28 Nov 2023 05:22:33 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e5cb00b001cfbd011ca9sm5767276plf.113.2023.11.28.05.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 05:22:33 -0800 (PST)
Message-ID: <01df8329-06d7-4fd1-9c7a-05296f33231e@gmail.com>
Date:   Tue, 28 Nov 2023 20:22:27 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Power Management <linux-pm@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ramses VdP <ramses@well-founded.dev>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Intel hybrid CPU scheduler always prefers E cores
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I come across an interesting bug report on Bugzilla [1]. The reporter
wrote:

> I am running an intel alder lake system (Core i7-1260P), with a mix of P and E cores.
> 
> Since Linux 6.6, and also on the current 6.7 RC, the scheduler seems to have a strong preference for the E cores, and single threaded workloads are consistently scheduled on one of the E cores.
> 
> With Linux 6.4 and before, when I ran a single threaded CPU-bound process, it was scheduled on a P core. With 6.5, it seems that the choice of P or E seemed rather random.
> 
> I tested these by running "stress" with different amounts of threads. With a single thread on Linux 6.6 and 6.7, I always have an E core at 100% and no load on the P cores. Starting from 3 threads I get some load on the P cores as well, but the E cores stay more heavily loaded.
> With "taskset" I can force a process to run on a P core, but clearly it's not very practical to have to do CPU scheduling manually.
> 
> This severely affects single-threaded performance of my CPU since the E cores are considerably slower. Several of my workflows are now a lot slower due to them being single-threaded and heavily CPU-bound and being scheduled on E cores whereas they would run on P cores before.
> 
> I am not sure what the exact desired behaviour is here, to balance power consumption and performance, but currently my P cores are barely used for single-threaded workloads.
> 
> Is this intended behaviour or is this indeed a regression? Or is there perhaps any configuration that I should have done from my side? Is there any further info that I can provide to help you figure out what's going on?

PM and scheduler people, is this a regression or works as intended?

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218195

-- 
An old man doll... just what I always wanted! - Clara
