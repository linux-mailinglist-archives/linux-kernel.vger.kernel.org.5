Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960CD7A511D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjIRRj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjIRRjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:39:55 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F871FB;
        Mon, 18 Sep 2023 10:39:49 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-403012f276dso51795025e9.0;
        Mon, 18 Sep 2023 10:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695058787; x=1695663587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1/lgZVflqyyt3jw5+T2bDLyWXYZmvdRzCSXLWVSuYA=;
        b=IHpu5u0eF6S17A6mQotrBp0DJ48IH9du+vf5GRu3S8foEQi0e0xkL5fFf+g3dm5AgT
         rdBaEkXTvGD9Hofhrc0l6tdKQ6xVe9M3jkTfHIq6VcUqXEzTXHgi8mbLD/3KpF+n1JX0
         TXh/AmM0aoBPOKrXXcECvq9zNEc/Si11xiBp0vmatAHVSxdW71zbkJUZVBv9YVWAMnS6
         PTwY1XhkHPJOq7KL2uDIzNGMBVKGVZQSSEMP1tzDXGgxZR6vWwA0+KRHrZIll34rpP5x
         C5QVYtRmtnm3DLdi/fnz5d7xv8ST2w5yYbGhTxvQ2Xe2ZH+uXUylH6IU8WW3JW3qIYnx
         B/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695058787; x=1695663587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1/lgZVflqyyt3jw5+T2bDLyWXYZmvdRzCSXLWVSuYA=;
        b=doeRMNkGPN+PVh5haatu1g90mH3+VTmhg9z+xHq6+cw/WT7k49marKg/Bf3ceswszM
         wG+6T1e5t4Nnv30xxEF7n+pdyAwxqJl2HJVa0CF2Zd+ZJNcUXLxu/FAdsvoZsi+UinZQ
         49+pH+cryayCDgxdNCjAGrgQSOXNuwUCYyKvJ0r2XcopawoMMEY1MVJeW6yvv0xFMOSC
         9PIgcPOdz1hla14vzmkUbT2TlGgPa21ZS7p38iGYjlGdEc2xvKW6A3XyND3+UXFWVRBm
         Zav2RRXs+rkWUZuVwsqEcQ4aeCLby8KX3q5WRdlCUhKDcn4ruCMNXhO8FaUHzXZ7P4hk
         mJaA==
X-Gm-Message-State: AOJu0YwSy1cTTRBAIZPcXkDaeIbB8oJVpl5128c2lkgeAxvhhQ4QUnVG
        UAXTDScupc5+nV1P+Z2+2lc=
X-Google-Smtp-Source: AGHT+IFrFTFR1xyoFqyL58si/yxpKchP5xcdqD8vMS6vIA5LBpyvQftnW10N0ehIERFDMNXGwC/i3w==
X-Received: by 2002:a05:600c:2209:b0:404:746e:c601 with SMTP id z9-20020a05600c220900b00404746ec601mr8928944wml.9.1695058787287;
        Mon, 18 Sep 2023 10:39:47 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bca46000000b003fefb94ccc9sm12968401wml.11.2023.09.18.10.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 10:39:46 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 18 Sep 2023 19:39:43 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Matteo Rizzo <matteorizzo@google.com>
Cc:     "Lameter, Christopher" <cl@os.amperecomputing.com>,
        Dave Hansen <dave.hansen@intel.com>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net, luto@kernel.org,
        peterz@infradead.org, jannh@google.com, evn@google.com,
        poprdi@google.com, jordyzomer@google.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 00/14] Prevent cross-cache attacks in the SLUB
 allocator
Message-ID: <ZQiLX0W2Tcr+wdJT@gmail.com>
References: <20230915105933.495735-1-matteorizzo@google.com>
 <7a4f5128-28fd-3c5f-34c2-1c34f4448174@intel.com>
 <1d7573c0-ebbc-6ed2-f152-1045eb0542f9@os.amperecomputing.com>
 <CAHKB1w+rVyww0UrHhzeGfPA7FM482Z-7ApzXvekVqLHvTDAV3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHKB1w+rVyww0UrHhzeGfPA7FM482Z-7ApzXvekVqLHvTDAV3Q@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Matteo Rizzo <matteorizzo@google.com> wrote:

> On Fri, 15 Sept 2023 at 18:30, Lameter, Christopher
> <cl@os.amperecomputing.com> wrote:
> >
> > On Fri, 15 Sep 2023, Dave Hansen wrote:
> >
> > > What's the cost?
> >
> > The only thing that I see is 1-2% on kernel compilations (and "more on
> > machines with lots of cores")?
> 
> I used kernel compilation time (wall clock time) as a benchmark while
> preparing the series. Lower is better.
> 
> Intel Skylake, 112 cores:
> 
>       LABEL    | COUNT |   MIN   |   MAX   |   MEAN  |  MEDIAN | STDDEV
> ---------------+-------+---------+---------+---------+---------+--------
> SLAB_VIRTUAL=n | 150   | 49.700s | 51.320s | 50.449s | 50.430s | 0.29959
> SLAB_VIRTUAL=y | 150   | 50.020s | 51.660s | 50.880s | 50.880s | 0.30495
>                |       | +0.64%  | +0.66%  | +0.85%  | +0.89%  | +1.79%
> 
> AMD Milan, 256 cores:
> 
>     LABEL      | COUNT |   MIN   |   MAX   |   MEAN  |  MEDIAN | STDDEV
> ---------------+-------+---------+---------+---------+---------+--------
> SLAB_VIRTUAL=n | 150   | 25.480s | 26.550s | 26.065s | 26.055s | 0.23495
> SLAB_VIRTUAL=y | 150   | 25.820s | 27.080s | 26.531s | 26.540s | 0.25974
>                |       | +1.33%  | +2.00%  | +1.79%  | +1.86%  | +10.55%

That's sadly a rather substantial overhead for a compiler/linker workload 
that is dominantly user-space: a kernel build is about 90% user-time and 
10% system-time:

   $ perf stat --null make -j64 vmlinux
   ...

   Performance counter stats for 'make -j64 vmlinux':

        59.840704481 seconds time elapsed

      2000.774537000 seconds user
       219.138280000 seconds sys

What's the split of the increase in overhead due to SLAB_VIRTUAL=y, between 
user-space execution and kernel-space execution?

Thanks,

	Ingo
