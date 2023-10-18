Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324CC7CDAE9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjJRLqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjJRLpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:45:49 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2218FE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:45:44 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53f6ccea1eeso611318a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697629543; x=1698234343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VTINOs7IVK0NtmhaZm8Hxfp0zmQge6ZaL9u3C96Qtkk=;
        b=RrSLeh03Z/Q/dAMWzai1S/m+J0txdbn5j10o+rQS7UxhfywO8gQb9hFuUcnmnWvQ1q
         nrGatzVJl7/NZS4KwmmR5U2qc7kg34Cq1st3cCVLeO/xUKYXa5nqY6SSM2fdfuB3gl0r
         9DIK3WoHBDO3WcbkF7fKFoQq94vtoAT43uXQI8OEC3kktqbpioVnX3d2eqmTD3UWR93Z
         vOw12465Fe5SiSbwv6qRxmY7LujZcR1TACGrMNHByj+IQQCmr+XTVoJO+IwBTLZmBY77
         YSoJD4EWNkhloUsCnZIXokTmn/Zg5YblrxAwFX3h+S77ev5XBoWM0sN4PtfmN0fqZh2T
         nOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697629543; x=1698234343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTINOs7IVK0NtmhaZm8Hxfp0zmQge6ZaL9u3C96Qtkk=;
        b=M+/SLogiqbt701pbJxuLO213ndKelJ2oqfzvkLqJtVIKrCEECMz6VDzivs43gzKuW+
         C2Z07UJJcHSQJvw6lfQspHMUQU5dQOJvPkKcAx1M8OHVPnrzXlfhF5Ul/332viBLVMdn
         W+T/uM5jCUXNrvvJgJurT1aTX62EQnm6uA686n+XWR9tnquhEfVvR+c+F5cMM0JO5jyL
         UMBVoXx+lb2iOtZqbFqq2GG9N9jaVr255Kj/R1nLcha/2kU3wFq6QHnOt+l/ZT2FZMj6
         xivTvDCIYNWEj9o1wedNhq5pIIJ3wx0E+ZpSsXMxnQNaGyw3gROXvuiPjws4jnxsdPie
         5IUg==
X-Gm-Message-State: AOJu0YzwgNDtwrbv41XRgkOPsTZbVgVaJ7bvgyF5f5RgFbe2L28FC/fv
        b1Gh3U42fUsHM+y10auhGlM=
X-Google-Smtp-Source: AGHT+IGqXeNQawRBulQQP5v5T/ldgBTck2xmiz8UH0flZ10jQ2YZnQiB6VM/bXbO7Y22mMXA5ybPvg==
X-Received: by 2002:a05:6402:4410:b0:530:bd6b:7a94 with SMTP id y16-20020a056402441000b00530bd6b7a94mr4825384eda.24.1697629543307;
        Wed, 18 Oct 2023 04:45:43 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id t29-20020a50ab5d000000b0053ed70ebd7csm2720856edc.31.2023.10.18.04.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 04:45:42 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 18 Oct 2023 13:45:40 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     Hou Wenlong <houwenlong.hwl@antgroup.com>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH RFC 1/7] x86/head/64: Mark startup_gdt and
 startup_gdt_descr as __initdata
Message-ID: <ZS/FZAq6lbxXtBtB@gmail.com>
References: <cover.1689130310.git.houwenlong.hwl@antgroup.com>
 <c85903a7cfad37d14a7e5a4df9fc7119a3669fb3.1689130310.git.houwenlong.hwl@antgroup.com>
 <ZS0lEmEpQOz4iQ4Q@gmail.com>
 <20231017072311.GA46993@k08j02272.eu95sqa>
 <ZS6F46vJfca5f6f8@gmail.com>
 <77B66FD0-ED28-4D3F-8D28-467AC4FCD00D@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77B66FD0-ED28-4D3F-8D28-467AC4FCD00D@zytor.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* H. Peter Anvin <hpa@zytor.com> wrote:

> If the goal is better KASLR, then what we really should spend time on was 
> Kristen Accardi's fgKASLR patches, which not only exponentially(!) 
> increases the randomization entrophy but also *actually* avoids the "one 
> leak and it's over" problem.

Agreed. Going by this version of function-granularity KASLR from 3 years 
ago:

  https://lwn.net/Articles/824307/
  https://lwn.net/ml/linux-kernel/20200623172327.5701-1-kristen@linux.intel.com/

The fgKASLR feature looks entirely viable to me. Back then I presumed it 
would get iterated beyond v3, and then it fell off my radar. :-/

If Kristen or someone else would like to dust this off & submit a fresh 
version it would be much appreciated!

Thanks,

	Ingo
